Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A459BF11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiHVL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiHVL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:59:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18EB193F7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:59:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g129so6771700pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=P31UUUIF82MqgGzzRYTcT2xG9ydrixuRjNOqAsz74Qs=;
        b=sQ2pt6h/5gOgoBl+bIMy/RKAZ3gr/k3Q58E9oQs0ghosDwBo7Y4bm4Yb+dpfa1Pzv/
         6z8Me/NRn1BH0SjOfCNqi3GB06sl8ATi+pp26k9RY51dXIr9OmapDRg/xqS/RtMY54f7
         Eglye4uibbOKKHBunhWbBCvMaz9wRtBvWqzH5o1zAJAmnQa5Zr0oPoTHV+wq21Tp3sZ5
         Nc7NaHLHvlaj9pcIZiDv+S9NGBXFEC2ZpDocgaOhbeUW9tcy/8xofLyU/EsKLitvdrHe
         tr4rp97Qmwb8rrxLFcA+frlz199bfHWToswm0eADP77hdLPp694UDAdvjNVSv/SBpIDy
         MvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=P31UUUIF82MqgGzzRYTcT2xG9ydrixuRjNOqAsz74Qs=;
        b=pt0lVEBPUNhUgEDxRdNtboXcGiKc/GlmcGJrLeZdy27TIwnO9UMHp71/KvvARFAuNb
         q8U67ZSfn/w/bOnKG3IkhKZzReDYGnjoyaom1Jfu9LTXQYlfBt4xcqdm1qdfiHab3i44
         QwtFcJaU116YZhU+Nr2wltD5BTD38j4jgswC3Wqbhlb4abX5FxLGMNsf4MWNV5B4tbza
         Dllgo8AfrpqQEtimYOaIU8mYP3lYbvnnGRxikojgvJApc+wNeCreeF/9s1xFrNez3tNT
         UNvfFfpI1LyfkSObu6TIBvLwWdMLK/otTnEHcW0eA72/haJ59lbNBICGl2665RkM/9Zw
         RfOQ==
X-Gm-Message-State: ACgBeo0jlOuBTjmGu3It8D4bWWVWnTCYCrGhLc0VW5lSAGc5UgD0opw6
        XVH7QX54ytdoHo0tMi+Kpb9WIQ==
X-Google-Smtp-Source: AA6agR5m/vYllIKVHdKuQU1vFTHy0Hc9KojXLZoDOv7lM+9yahOy/1hS2CCrMYfRjBHstaT2Btum1g==
X-Received: by 2002:a05:6a00:198f:b0:536:c49f:898a with SMTP id d15-20020a056a00198f00b00536c49f898amr2448105pfl.47.1661169572038;
        Mon, 22 Aug 2022 04:59:32 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a2a4900b001f326ead012sm9830875pjg.37.2022.08.22.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 04:59:30 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] ext4: do io submit when next to write page not continuous
Date:   Mon, 22 Aug 2022 19:59:15 +0800
Message-Id: <20220822115915.88205-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

In ext4_writepages, sometimes we leave the bio to next-to-write page for
physic block merge. But if next page no longer continuous, we'd better
submit it immediately.

For extent inode, the chance of physic continuous while logic block not
continuous is very small. If next to write page not continuous and
unmapped, we may gather enough pages for extent and then do block
allocation and mapping for it's extent. Then we try to merge to prev
bio and get failed. For the prev bio, the waiting time is unnecessary.

In that case, we have to flush the prev bio with holding all page locks
of the extent. The submit_bio may be blocked by wbt or getting request
which may take a while. Users also may be waiting for these page locks.

In fast do_map=0 writing mode, we should also end this hopeless waiting
soonner and submit it without any page lock.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
Changes in v2:
-fix some spelling errors

 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..ad7139a835a2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2608,6 +2608,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
 				goto out;
 
+			/* Submit bio when page no longer continus and
+			 * do it before taking other page's lock.
+			 */
+			if (mpd->next_page != page->index && mpd->io_submit.io_bio)
+				ext4_io_submit(&mpd->io_submit);
+
 			lock_page(page);
 			/*
 			 * If the page is no longer dirty, or its mapping no
-- 
2.20.1

