Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9025D567BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGFCGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiGFCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:06:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDD193D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:06:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso4107421pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUYx/nMpPRZZ7T3OJcp0ViMS4SfBN+r9mg60+It2koY=;
        b=d6XsyRYc5VWPdjScT++7C/ZlgNyGhk6CLnTXXvXdD4UwuZSxr8M+SWAxA+PZbjZhwY
         Dhm9jdYWXA6Q1lTGNEy4Sl+tdQM0Pq+Y2/GGSc7xmwDONTI35x1b3yLwhpxAgpytD21b
         12p0Yg4IXeFZPkXG+MqGz3mulGFMpzDohuIZzNZNtbhGnJtOK9hzhOKtbZB9wbDAxHcY
         htYJs/Fx1ugeJMWvc76YmzYHmYCzvo/hdxkr7wq7ZR72BaPnynnpoUtdnX+MRvveNWIk
         q3YefMRabt4oR+hqrRIrI+4+MekUXi+TwA0qFeJjgfEcKnqkTYmlC+tVPcuT1ucDCCZ+
         //SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUYx/nMpPRZZ7T3OJcp0ViMS4SfBN+r9mg60+It2koY=;
        b=QQi/ADOxi2RPl9YhfisPG3KNAO3fRm4f9HAD9lZbyreTnwrQnjtKO15LQhy5zR1RGA
         ifER4CX/CHpWM1y5dx8aNHNkZJTgqNbYUsFPC8tshS8X9gruEfLkmtuVj8mRgm3nagHx
         rY8qjCGYwUKGpV5YfXNjw0tN6+r4CvIsdq4kEWX/bLQU41x4JLyriKBixv7ND9Q3tWGh
         JJFM/CO84oPDDTi21XY2+T9eSGbRVAxUcV1MVAe5Zd057pvQsMf9HQJoCjTGNIUuLLjk
         3zXHgjEbhKfopnSwHuJyKF+eKOCF83jtf7WM2FN7KyfTWlmC++DGcWw6d66ubEreLfyb
         H6DA==
X-Gm-Message-State: AJIora88Gm5SPooCl5I6fz0CuNL6cSf3+K2wvSOwJEus22SPYnzCS8Ga
        QxhRV/g9nvFQNNHr4s7+B4Q=
X-Google-Smtp-Source: AGRyM1twbylijzBnLpfEZfmVSXG72ZKveb2t2MZtM2qOX+aHeHkHb+737e81WqT8tIdgRrY2KMJ0mw==
X-Received: by 2002:a17:902:e808:b0:16a:75be:2ba with SMTP id u8-20020a170902e80800b0016a75be02bamr44746280plg.85.1657073187042;
        Tue, 05 Jul 2022 19:06:27 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902a9c100b0016a1e2c2efcsm23998925plr.223.2022.07.05.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 19:06:26 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: [PATCH] f2fs: add some sysfs nodes for segment
Date:   Wed,  6 Jul 2022 10:06:15 +0800
Message-Id: <20220706020615.29938-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There are two ways to show meta segment information,
one is by dump.f2fs, another is by sysfs node. But,
sometimes dump needs root privilege,So adding a
few sysfs nodes.

The generic permission of node is 0444(S_IRUGO).

$ cd /sys/fs/f2fs/DEVICE/...
$ ls -l
...
-r--r--r-- 1 root root 4096 7月   5 23:21 reserved_segments
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ckpt
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_main
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_nat
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_sit
-r--r--r-- 1 root root 4096 7月   5 23:21 segment_count_ssa
...

$ sudo dump.f2fs -d 1 DEVICE
...
Super block
segment_count                           [0x      26 : 38]
segment_count_ckpt                      [0x       2 : 2]
segment_count_sit                       [0x       2 : 2]
segment_count_nat                       [0x       2 : 2]
segment_count_ssa                       [0x       1 : 1]
segment_count_main                      [0x      1f : 31]
...
Checkpoint
rsvd_segment_count                      [0x       e : 14]
...

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/f2fs/sysfs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 4c50aedd5144..05350bba2c83 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -697,6 +697,55 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 	return sprintf(buf, "unsupported\n");
 }
 
+static ssize_t segment_count_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count));
+}
+
+static ssize_t segment_count_ckpt_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ckpt));
+}
+
+static ssize_t segment_count_sit_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_sit));
+}
+
+static ssize_t segment_count_nat_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_nat));
+}
+
+static ssize_t segment_count_ssa_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_ssa));
+}
+
+static ssize_t segment_count_main_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(F2FS_RAW_SUPER(sbi)->segment_count_main));
+}
+
+static ssize_t reserved_segments_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n",
+			(unsigned long long)(reserved_segments(sbi)));
+}
+
 #define F2FS_SB_FEATURE_RO_ATTR(_name, _feat)			\
 static struct f2fs_attr f2fs_attr_sb_##_name = {		\
 	.attr = {.name = __stringify(_name), .mode = 0444 },	\
@@ -801,6 +850,13 @@ F2FS_GENERAL_RO_ATTR(moved_blocks_background);
 F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
 F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #endif
+F2FS_GENERAL_RO_ATTR(segment_count);
+F2FS_GENERAL_RO_ATTR(segment_count_ckpt);
+F2FS_GENERAL_RO_ATTR(segment_count_sit);
+F2FS_GENERAL_RO_ATTR(segment_count_nat);
+F2FS_GENERAL_RO_ATTR(segment_count_ssa);
+F2FS_GENERAL_RO_ATTR(segment_count_main);
+F2FS_GENERAL_RO_ATTR(reserved_segments);
 
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption);
@@ -934,6 +990,13 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_reclaimed_segments),
 	ATTR_LIST(max_fragment_chunk),
 	ATTR_LIST(max_fragment_hole),
+	ATTR_LIST(segment_count),
+	ATTR_LIST(segment_count_ckpt),
+	ATTR_LIST(segment_count_sit),
+	ATTR_LIST(segment_count_nat),
+	ATTR_LIST(segment_count_ssa),
+	ATTR_LIST(segment_count_main),
+	ATTR_LIST(reserved_segments),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.36.1

