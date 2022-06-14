Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9EB54AF85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiFNLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiFNLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:50:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94F344E3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:50:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso5948553pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=;
        b=F3dA6Eu5MXASMIfexqV07GCk3QkS5c8VuNH6YdrBBkCX8OS6cYMYpuxBWYZpQy9GY2
         Hyj5aQZelm82gUh3a5iqvyGqHzz31LvMjiN58PiDsfnZOpUD0Y4uIfbYSU/Oj6HS+dz/
         3+ynscwaddW/3z8crG2VjTLFSMxpcSAP4FzPMkEkg5kXrrsGPXiFBHgpJl22bc6Pe23U
         XmI9aWoR+VWXIxye8yexVTe4UKFLSDeLoXMQ2imYdb+gLyf3rUaZUxW84rlNww2HfU2T
         2tiTaGpRRXzflSECub9VdAzHXVRpWm7oCAtb6IFOYB/CTPsF/sDL5KTCdY6hrSRQLCME
         rEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=;
        b=hKaCNJeaVT/MXuYqmUGfVE6J3MruHzqcnC0u8hruL5elPzMrvJRqTlzpfGjCdapYP9
         TRGWMJ6VHOR9uVZGF8Z22Q8aDyxk87kBp1pBjqy1mn5BbXifY71gNyNhaUnH9g2Gt3Wt
         nUFjS+x27SrbR+GYWoktVebAjsKECpKACX8nS3r/d3ElMX6Lyq7L8WVK0JIM1aQJiglJ
         ujYJUp8UUETipnB1id/ghE9oKfFYEPHrZ6DhA2wqqJKW96pa7vUChhwn+JkHnxUfMHqK
         0AxaHY0Lu+1h2xtKI+//AWcmIA4jw2bkXwKMMP6S75JWORPP5e/v8A/gOejOCoXFbdR/
         Ga1g==
X-Gm-Message-State: AJIora/mP+uT+Nq46M78u5eL41EILK+eagEGfi9Q7Qwzvn/Ivad2MOND
        /D/EpdaQtGPSfsa2Tz2i7Do=
X-Google-Smtp-Source: AGRyM1uvH8uvscKQstVODrvJnevEYuArUZv/5c6h2w0iTRtaH4LPDFGbyxXjDueXCmhu0Sjxlm5uig==
X-Received: by 2002:a17:902:a704:b0:168:f037:98cd with SMTP id w4-20020a170902a70400b00168f03798cdmr1623074plq.87.1655207418352;
        Tue, 14 Jun 2022 04:50:18 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id ay21-20020a056a00301500b0051bc3a2355csm7291268pfb.64.2022.06.14.04.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2022 04:50:17 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH 2/2] f2fs-tools: fix to check free space before grow
Date:   Tue, 14 Jun 2022 19:49:29 +0800
Message-Id: <20220614114929.6897-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
References: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, after grow, kernel may report below error message
when we mount the image if -o parameter is specified during resize:

F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
mount(2) system call failed: Structure needs cleaning.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fsck/resize.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index d19c6fa..e135b66 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -599,6 +599,26 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
 }
 
+static int f2fs_resize_check(struct f2fs_sb_info *sbi, struct f2fs_super_block *new_sb)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	block_t user_block_count;
+	unsigned int overprov_segment_count;
+
+	overprov_segment_count = (get_newsb(segment_count_main) -
+			c.new_reserved_segments) *
+			c.new_overprovision / 100;
+	overprov_segment_count += c.new_reserved_segments;
+
+	user_block_count = (get_newsb(segment_count_main) -
+			overprov_segment_count) * c.blks_per_seg;
+
+	if (get_cp(valid_block_count) > user_block_count)
+		return -1;
+
+	return 0;
+}
+
 static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -616,6 +636,9 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 	if (get_new_sb(new_sb))
 		return -1;
 
+	if (f2fs_resize_check(sbi, new_sb) < 0)
+		return -1;
+
 	/* check nat availability */
 	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
 		err = shrink_nats(sbi, new_sb);
@@ -659,11 +682,8 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_super_block new_sb_raw;
 	struct f2fs_super_block *new_sb = &new_sb_raw;
-	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	block_t old_end_blkaddr, old_main_blkaddr;
 	block_t new_end_blkaddr, new_main_blkaddr, tmp_end_blkaddr;
-	block_t user_block_count;
-	unsigned int overprov_segment_count;
 	unsigned int offset;
 	int err = -1;
 
@@ -674,15 +694,7 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
 	if (get_new_sb(new_sb))
 		return -1;
 
-	overprov_segment_count = (get_newsb(segment_count_main) -
-			c.new_reserved_segments) *
-			c.new_overprovision / 100;
-	overprov_segment_count += c.new_reserved_segments;
-
-	user_block_count = (get_newsb(segment_count_main) -
-			overprov_segment_count) * c.blks_per_seg;
-
-	if (get_cp(valid_block_count) > user_block_count)
+	if (f2fs_resize_check(sbi, new_sb) < 0)
 		return -1;
 
 	/* check nat availability */
-- 
2.36.1

