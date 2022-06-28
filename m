Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF3355DD00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiF1Dpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbiF1Dpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:45:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80422BCB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:45:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k14so9933464plh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFS37TBrSuv4gm4FPYmVxuLo1hjFrZ0Wm5eeFGteyXw=;
        b=JC9nSS5Tq4Gicto+oCAVO9AjdLFnqt1m2EMjxTe1JGxXt9oVMisCLdp+EGQ/OoV8NB
         VXvt80Rv800N3gLg3gx48oy9LVspCARgrr3Riq6Duet+rwlCy2VHOvkXqSoiX4RAhYcc
         KWOV+ZaorEDDbu04MRfLr2VPoE+GBySLxn+g9PkSukcgC5EZYJ4B3FesRyMD3ch1ZlmM
         JcmiLolycDnAvm6ZNat2erb9XJ4HZ4pq6mClfm+MF8AcarcCz9IWYPOzMStCCrigwpCc
         voyqqb9CAbD8tajMZAG4ubIX1tJ4Clbly99S88tS0tHTxYk5brSPAg7uGYXakau++w7c
         z8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFS37TBrSuv4gm4FPYmVxuLo1hjFrZ0Wm5eeFGteyXw=;
        b=sPP6qF8jWaXdWLJY1lDUO3J4gdOual2D4XqB6f0eSpBHzwwzWuj8BrdUSd9AkTBxCW
         bUDnMHBdO4V0GiZjvk8vuTLesQN0xQvDPoftN9f7pliSMPKc9oH71A7b49la3iKNZZfJ
         Vf88hojKvrV3dPDz4paWishxlN8PHQKdw4mm9f7IcYV9WwovIAOPBKhCOjf6QB13HIsu
         yrAEi0o35pLU/+3kAM+UiCNzJLH03YdaKApiCUj079AbblKPugCgnhMZT1lcdu5PItSy
         yZ7kh8vYz1f+1cEpI5h+m8w2/vt+pf4oBSdHEF1xhJ3Le0EJ1aRpoEzSa9uccxn8Ge8R
         Azxw==
X-Gm-Message-State: AJIora9Z5Orb8X+48VcBoXVoxyz2++7mzbaf0IgApA9I2FTMwk5Q760w
        DI1ssxgH9+waIKa0X9D+j/o=
X-Google-Smtp-Source: AGRyM1sO8dYuMdlGVja1BTXMaxZHbyElAyhc2WdhqkpoHmjePg9xedPrldC2JDeHOqzgnBAL98FP+g==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr2831998plg.14.1656387928697;
        Mon, 27 Jun 2022 20:45:28 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id bl21-20020a056a00281500b005251c6fbd0csm8068208pfb.29.2022.06.27.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:45:28 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: [PATCH 4/4] f2fs: add swap space for memory using
Date:   Tue, 28 Jun 2022 11:45:17 +0800
Message-Id: <20220628034517.24861-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: duguowei <duguowei@xiaomi.com>

If device enables swap file, enlarging the memory usage for each
monitored item. It can be adjusted by ram_thresh sysfs node.

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/f2fs/node.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 836c79a20afc..f1cf3d2bc7c2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -54,9 +54,12 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		return true;
 
 	si_meminfo(&val);
+	si_swapinfo(&val);
 
 	/* only uses low memory */
 	avail_ram = val.totalram - val.totalhigh;
+	/* if there is swap space, use it too.*/
+	avail_ram += val.totalswap;
 
 	/*
 	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
@@ -96,7 +99,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = mem_size < (avail_ram * nm_i->ram_thresh / 100);
 	} else if (type == COMPRESS_PAGE) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		unsigned long free_ram = val.freeram;
+		unsigned long free_ram = val.freeram + val.freeswap;
 
 		/*
 		 * free memory is lower than watermark or cached page count
-- 
2.36.1

