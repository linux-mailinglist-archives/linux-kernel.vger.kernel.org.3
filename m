Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D016C59B59B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiHURVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:21:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D6193D3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:21:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z187so8326114pfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fl7PKJi3GOgL1+x5RqT6oZMi+wDpO4AP2SfnrI4ILyQ=;
        b=yQ4GbyKKSjHfOuvO2bR4vUex8MAm55DE2+85ejBTB97eXYCHWI7XHz+55B9Hd9au5H
         QSI52NaqISjSn7ho2gFjMXTiDIxjXun++0AKUCoK0269W48Y6FL/vhAjX3R0/2L3tfkQ
         BX4BxYALmMQer6lHetooq+B47FBxMbIhoiNtPKgteR70TMVwEGGrdPbD3WZgz0+swnTq
         xPahMi1r6jArK2FyT2Gfrwlv2pQH1Jo5Fka43rlNe3UAbzXMGO/igWtu4tfknKMKr1SM
         pOhA56Xo+DZgYwZwFyGTl9w8Hl4ua+w3wdN6ecsSfWAElXExScEy4jooD07hHKhQUyid
         Lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fl7PKJi3GOgL1+x5RqT6oZMi+wDpO4AP2SfnrI4ILyQ=;
        b=twIF0PMw8uC/1pFPjPoSCXTPjnOE0xQ4lfYxplmXULoM9iGsfnYo4iOqtp+VrE+V/2
         E5WX4vlm2/n39x3aCBhcSPeBM4lveAHKUjcnIu4pKPrYZFETIJij1cxTPT3ZA0x8HfbC
         RiannZEx7ReG1P7kHnrXEPMmlS0bHT/IU9c9gl2yL9tQh56gVu7ECrEZqxPddcizAbG3
         Nbpzpav8hCaNhof87Dh3YaX0KgOpygiA7+KDTMl11hUEK/gwX5lqPL3D555PhQBfPHZ7
         buAvVNyE3Le9pBT3Mj/pgtC8WwU92XfDdKAbhGckxn9SM49/twZdUAjmIvPnXLfTOWmz
         iaTw==
X-Gm-Message-State: ACgBeo3GiRONXTygEN+D9Ub/rUueg0bb37eeyyzXizGABJJdK2gZdBm9
        l/unnyNL2PIfOmsHQUgGwsEcGw==
X-Google-Smtp-Source: AA6agR5GzyO0+yNf5fLNxJVUJTILIHIeMxhGrN4VBxDi17I9IdrsYy6C0Z/9QHrpPauxAeOveW3K3A==
X-Received: by 2002:a63:2b4d:0:b0:41d:6d37:365 with SMTP id r74-20020a632b4d000000b0041d6d370365mr13952601pgr.325.1661102503842;
        Sun, 21 Aug 2022 10:21:43 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id h3-20020a62de03000000b0053639773ad8sm3665673pfg.119.2022.08.21.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:21:43 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: do io submit when next to write page not continues
Date:   Mon, 22 Aug 2022 01:21:26 +0800
Message-Id: <20220821172126.45113-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

In ext4_writepages, sometimes we leave the bio to next-to-write page for
physic block merge. But if next page no longer continus, we'd better
submit it immediately，

For extent inode, the chance of physic continue while logic block not
continus is very small. If next to write page not coninus and unmapped,
we may gather enough pages for extent and then do block allocation and
mapping for it's extent. Then we try to merge to prev bio and get failed.
For the prev bio, the waiting time is unnecessary.

In that case, we have to flush the prev bio with holding all page locks
of the extent. The submit_bio may be blocked by wbt or getting request
which may take a while. Users also may be waiting for these page locks.

In fast do_map=0 mode, we also end this not much hope waiting soon and
submit it without any page lock.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..2f7786c459c9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2608,6 +2608,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
 				goto out;
 
+			/* Submit bio when page no longer continus and
+			 * do it before taking other page's lock
+			 */
+			if (mpd->next_page != page->index && mpd->io_submit.io_bio)
+				ext4_io_submit(&mpd->io_submit);
+
 			lock_page(page);
 			/*
 			 * If the page is no longer dirty, or its mapping no
-- 
2.20.1

