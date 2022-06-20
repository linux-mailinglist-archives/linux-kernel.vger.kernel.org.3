Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064955137B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiFTIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiFTIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:55:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627302AD8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:55:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a17so7184752pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtLr/oIle+ftNWxzyiFCCWbJ/ItjPPT10HheHqkPajk=;
        b=fE/s/b+ZcvraL3GiWx5cEAwt5ZdVqVnARphsKCN6OHLs6yO4PMg/tHMBSIjAqCJHRf
         H7G4RzDkSBY/ZDVAN0lQL6P5WVbaWOFXJ0qO2tV2mg/JxzwddCFLmAKjluBqfW7dudlh
         iy3cD4R2Z9KWfk/cnQXConPubztYE0TR9gyc8oWNQsAf0TMo1k8t9KUpTI8qW1NfL1NM
         nWONh3lMFyK0mi8kDl8i7nm/JqGIFN2qZNWxwOwum2oFOFchpe1NNbYH0Ew5uCD/W5ov
         b9U+LPPdS1FOG/1iXvbGHhd/NGpuv8wDcod/6TZgwUqPojDjVbdMcH5NBt/H5ciBB0rm
         YrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtLr/oIle+ftNWxzyiFCCWbJ/ItjPPT10HheHqkPajk=;
        b=TFE0HFkMT2dyh1qrpwP07OyNfyoxIHH/AtZJTYL6FNcvrvca0PSBo9NQanq9FQ/wH2
         f/VZrXoFHBnHWXheakPK3TH+sDRPwV/BiiitFevvJjUlj/rk8VMnLL/AD5Wsrd1rGrSH
         MuM7XE5q2HDsdQSoZxSkm6fiyBgmeJfwje2N9pK/XbZHsLUPLf7LX6k6vz3/Tr8d3//1
         DFbOC4RcUCxDvgIX08xvr0sfORrATpPVO1kiEHxFbkmD4cgvnju0nxE+EbsOuFjk1POF
         Aha7IvIYzz2pnFYmVGhNoUkiazmLzOECEkfY4em+rdRrL9nguv/7Ig7ClY8lhD5q58W+
         GHmw==
X-Gm-Message-State: AJIora/1u79B6Ebtk7HorWeudACYxR+L2Wk/iJpYLY3GhVaGDdbS6OuD
        lp5o9AwIKXdXih64r2rqff8=
X-Google-Smtp-Source: AGRyM1tVSn9nQC6aoE5n05n9SL9OJZev2NyQ1B4n2oaWJETYreDggz36HY2MsiXeII/DZAcUUukG+w==
X-Received: by 2002:a17:902:ba86:b0:167:7ee0:7ab9 with SMTP id k6-20020a170902ba8600b001677ee07ab9mr22992897pls.24.1655715299757;
        Mon, 20 Jun 2022 01:54:59 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79605000000b0051c6613b5basm8450801pfg.134.2022.06.20.01.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:54:59 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12@xiaomi.com,
        qxy65535@gmail.com, qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: Re: [PATCH v2] resize.f2fs: add option to manually specify new overprovision
Date:   Mon, 20 Jun 2022 16:48:10 +0800
Message-Id: <20220620084810.24885-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
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

From: liuchao12 <liuchao12@xiaomi.com>

Make.f2fs supports manually specifying overprovision, and we expect
resize.f2fs to support it as well.

This change add a new '-o' option to manually specify overprovision,
and fix to check free space before grow. Otherwise, after grow,
kernel may report below error message when we mount the image if -o
parameter is specified during resize:

F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
mount(2) system call failed: Structure needs cleaning.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---

  Change log form v1:
    - merged fix to check free space before grow
    - delete unessassary check of "c.new_overprovision == 0"
    - update man page

 fsck/main.c       |  8 ++++++--
 fsck/resize.c     | 45 ++++++++++++++++++++++++++++++++-------------
 man/resize.f2fs.8 |  9 +++++++++
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index aef797e..3b4da0f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -121,7 +121,8 @@ void resize_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
-	MSG(0, "  -s safe resize (Does not resize metadata)");
+	MSG(0, "  -o overprovision percentage [default:auto]\n");
+	MSG(0, "  -s safe resize (Does not resize metadata)\n");
 	MSG(0, "  -t target sectors [default: device size]\n");
 	MSG(0, "  -V print the version number and exit\n");
 	exit(1);
@@ -527,7 +528,7 @@ void f2fs_parse_options(int argc, char *argv[])
 #endif
 	} else if (!strcmp("resize.f2fs", prog)) {
 #ifdef WITH_RESIZE
-		const char *option_string = "d:fst:iV";
+		const char *option_string = "d:fst:io:V";
 
 		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -561,6 +562,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 'i':
 				c.large_nat_bitmap = 1;
 				break;
+			case 'o':
+				c.new_overprovision = atof(optarg);
+				break;
 			case 'V':
 				show_version(prog);
 				exit(0);
diff --git a/fsck/resize.c b/fsck/resize.c
index f1b7701..3d8ea46 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -146,7 +146,9 @@ safe_resize:
 						get_sb(segs_per_sec));
 
 	/* Let's determine the best reserved and overprovisioned space */
-	c.new_overprovision = get_best_overprovision(sb);
+	if (c.new_overprovision == 0)
+		c.new_overprovision = get_best_overprovision(sb);
+
 	c.new_reserved_segments =
 		(2 * (100 / c.new_overprovision + 1) + 6) *
 						get_sb(segs_per_sec);
@@ -476,6 +478,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 						get_cp(rsvd_segment_count));
 
+	DBG(0, "Info: Overprovision ratio = %.3lf%%\n", c.new_overprovision);
+	DBG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
+					get_cp(overprov_segment_count),
+					c.new_reserved_segments);
+
 	free_segment_count = get_free_segments(sbi);
 	new_segment_count = get_newsb(segment_count_main) -
 					get_sb(segment_count_main);
@@ -591,6 +598,26 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
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
@@ -608,6 +635,9 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 	if (get_new_sb(new_sb))
 		return -1;
 
+	if (f2fs_resize_check(sbi, new_sb) < 0)
+		return -1;
+
 	/* check nat availability */
 	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
 		err = shrink_nats(sbi, new_sb);
@@ -651,11 +681,8 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
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
 
@@ -666,15 +693,7 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
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
diff --git a/man/resize.f2fs.8 b/man/resize.f2fs.8
index 463eca5..a4b6cd7 100644
--- a/man/resize.f2fs.8
+++ b/man/resize.f2fs.8
@@ -13,6 +13,10 @@ resize.f2fs \- resize filesystem size
 .B \-d
 .I debugging-level
 ]
+[
+.B \-o
+.I overprovision-ratio-percentage
+]
 .I device
 .SH DESCRIPTION
 .B resize.f2fs
@@ -35,6 +39,11 @@ Specify the size in sectors.
 Specify the level of debugging options.
 The default number is 0, which shows basic debugging messages.
 .TP
+.BI \-o " overprovision-ratio-percentage"
+Specify the percentage of the volume that will be used as overprovision area.
+This area is hidden to users, and utilized by F2FS cleaner. If not specified, the
+best number will be assigned automatically according to the partition size.
+.TP
 .SH AUTHOR
 This version of
 .B resize.f2fs
-- 
2.36.1

