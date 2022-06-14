Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44D754AF82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiFNLuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiFNLuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:50:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E0344C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:50:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so8368685pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7USdEj51HE+B1W75ZrU25EJ9oEbMG9WGuwAFaI6L8WI=;
        b=SHDYoBfQEbpxLJf9QLOz5WYVuhOqKagBsWr2lKNJC5ivL+lqvNOb5rhAaCrOMyQie9
         kzJJercKHSZodWdYSA3z1AmTaPCjl935BN8b9HeN3XvZ9pCTi8UnF+5mq1wlzS+6S/b0
         tnEbqlJjK8YPELkWyofXdseg7vYRSL3y+/PPErFJ2eIOl4A+sYIuqp/MSOB53IoMC73N
         iHUeSEA+gxgWixbbPOvivMy8r920+AhT83Ps2WUdikycbYR6J+jlB81CBTep4auVyyyn
         5fwWBsK10wJPlWpoRlN6YtKRylNBWsWYG34P9gj56q3pVdRYg8lzH93zR79NydS3jjdi
         FTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7USdEj51HE+B1W75ZrU25EJ9oEbMG9WGuwAFaI6L8WI=;
        b=k/blprSERNQ69q3SQXH418SVqK6ixoaCU3K+rLcjzowL58fHi6vSkerpV5gj32hgiM
         oIpKN6/NJZxnbEPlFDtu3Lr64YcWYMBIzzwoD/HS9TkAzEx3aWkgOiL8v13nluzeNmHJ
         lyuz8F99dIYRgmSpYSv3UsxmOzpniojy8qwue1NjquSPlfv6Vcw3Pnebfs0REBownVgS
         bRh6/2v1ov2x5P9Ak2TuZsZS6ahAzYB7Wedd6f+EwwlfAlaqmKI9BVU4Iwr2omUIeDvD
         dTkGIfD+TMBzR8Su+3fvKid1va4iFIC49axqAyof4df6VtSH/lk8Y5zyr4V16/dheQRu
         KutQ==
X-Gm-Message-State: AOAM530m6UgvPAQULJtQPRp1CgpKqCphIYjgPsaXdNPoIkNbpskzrAhR
        5mc/ZA1zje12r7mP/pYiEMk=
X-Google-Smtp-Source: ABdhPJz2uVsUMAAG8G/cswub01WoridQVs3LbPbqALCem8eTfK5OBpikxbeU18hETFsqc+A7X5jnPA==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr4419369pfm.41.1655207409855;
        Tue, 14 Jun 2022 04:50:09 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id ay21-20020a056a00301500b0051bc3a2355csm7291268pfb.64.2022.06.14.04.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2022 04:50:08 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12 <liuchao12@xiaomi.com>
Subject: [PATCH 1/2] resize.f2fs: add option to manually specify new overprovision
Date:   Tue, 14 Jun 2022 19:49:28 +0800
Message-Id: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
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

This change add a new '-o' option to manually specify overprovision.

Signed-off-by: liuchao12 <liuchao12@xiaomi.com>
---
 fsck/main.c   |  8 ++++++--
 fsck/resize.c | 12 ++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

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
index f1b7701..d19c6fa 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -146,12 +146,15 @@ safe_resize:
 						get_sb(segs_per_sec));
 
 	/* Let's determine the best reserved and overprovisioned space */
-	c.new_overprovision = get_best_overprovision(sb);
+	if (c.new_overprovision == 0)
+		c.new_overprovision = get_best_overprovision(sb);
+
 	c.new_reserved_segments =
 		(2 * (100 / c.new_overprovision + 1) + 6) *
 						get_sb(segs_per_sec);
 
-	if ((get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
+	if (c.new_overprovision == 0 ||
+		(get_sb(segment_count_main) - 2) < c.new_reserved_segments ||
 		get_sb(segment_count_main) * blks_per_seg >
 						get_sb(block_count)) {
 		MSG(0, "\tError: Device size is not sufficient for F2FS volume, "
@@ -476,6 +479,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
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
-- 
2.36.1

