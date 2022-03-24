Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DA4E5D24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiCXCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347716AbiCXCVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:21:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178B939A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:20:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b8so3485496pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGe+Phk4nmERQs5EeRHhU0F6cWbglg0pi3/f7lkHCA4=;
        b=BYTrPHlW4gh2Il2Vk2sEp/JQDJfszagtrtx/e5dj6a480ijz0kaF4NLfXyWzVgSrai
         K4W9P7YZAFfZTAmMZILPnNKR/POeMFRqHz8ZPPt/GGRtJlJYt4Ds/DadSopgyiGtkDw+
         gGdgXw6zb53bCS3Tt5y3y1pU6uAZHDcV7jAZyTyd8ufm1D2bUru4uce20Jm1ef3gzggY
         Q3fkBoodjNqPobDVJOiqHYuYGYb+J3w2nn3q/DmNnLrRJbPVlvxar82iP6kkrsHq7zSH
         wqKCSYYADYu1I1+wTOwM2ql5uJhCls3sogc37JglQ+jfEu7wDF3eDmCG8BCs4UOU8Lbp
         yyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGe+Phk4nmERQs5EeRHhU0F6cWbglg0pi3/f7lkHCA4=;
        b=KrV311JLZ1uPUVrq9S3iPAL3XgEisVfLNnb6pX0X8iyv0gB/z+GPwdb7p9Kj/hriuv
         V3C3gIQqQ5bBrx8rFp9u3lsJpP/QGC/r0D3t/G71RILFlIj660t1th8v+Ij6d6b8eRT2
         yiZdJDDfiVio1vaLoH3+iozrnI8GUF7WwL0dgkAEy0CPOkQJWmbqblsxzZDvb3ZYJAKo
         MRtfpWmB7862Lyiee7e/pazNLGAkzzq/9ESpBu7OB8DaOCMHR6372sGijG1Gac6EByVb
         Ybat4TOF+Eqp5212gQKwSVtbIYRuSHEaAnFvNgFy56dPJHYhV2Ce+PiZ1qafxmELfNa3
         2YiA==
X-Gm-Message-State: AOAM5325BYsI2F8J/yq2frebX/PHb9GKmjtEIGbEfPar1n7G44JU1Ba1
        YejWXdeC/+FXuBVhs4d12PoIoQ==
X-Google-Smtp-Source: ABdhPJzKgPTF1A4Uy6qtOMNO75KO3QbLVKYUp/4g+KiHeGKuk+QcuwtusvBjuePLUMPleMhnlhS3Xw==
X-Received: by 2002:a17:902:ecc6:b0:154:2a81:c810 with SMTP id a6-20020a170902ecc600b001542a81c810mr3255168plh.7.1648088416288;
        Wed, 23 Mar 2022 19:20:16 -0700 (PDT)
Received: from oak.jof.github.beta.tailscale.net ([2601:645:8780:7d20::3bfd])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm889507pgb.73.2022.03.23.19.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 19:20:15 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Lassoff <jof@thejof.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] Add FAT messages to printk index
Date:   Thu, 24 Mar 2022 02:19:58 +0000
Message-Id: <20220324021957.20173-1-jof@thejof.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for end users to quickly react to new issues that come up in
production, it is proving useful to leverage the printk indexing system. This
printk index enables kernel developers to use calls to printk() with changable
ad-hoc format strings, while still enabling end users to detect changes and
develop a semi-stable interface for detecting and parsing these messages.

So that detailed FAT messages are captured by this printk index, this patch
wraps fat_msg with a macro.

PATCH v1 -- Fix indentation with tabs in fat_msg macro
PATCH v2 -- Define FAT_PRINTK_PREFIX
PATCH v3 -- Fix kernel-doc comment for _fat_msg()

Reported-by: kernel test robot <lkp@intel.com>
---
 fs/fat/fat.h  |  9 ++++++++-
 fs/fat/misc.c | 14 ++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 02d4d4234956..2a20a21f2fb9 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -433,8 +433,15 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...);
 	__fat_fs_error(sb, 1, fmt , ## args)
 #define fat_fs_error_ratelimit(sb, fmt, args...) \
 	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ## args)
+
+#define FAT_PRINTK_PREFIX "%sFAT-fs (%s): "
+#define fat_msg(sb, level, fmt, args...)				\
+do {									\
+	printk_index_subsys_emit(FAT_PRINTK_PREFIX, level, fmt, ##args);\
+	_fat_msg(sb, level, fmt, ##args);				\
+} while(0)
 __printf(3, 4) __cold
-void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
+void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 #define fat_msg_ratelimit(sb, level, fmt, args...)	\
 	do {	\
 			if (__ratelimit(&MSDOS_SB(sb)->ratelimit))	\
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 91ca3c304211..855477d89f41 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -42,10 +42,16 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(__fat_fs_error);
 
 /**
- * fat_msg() - print preformated FAT specific messages. Every thing what is
- * not fat_fs_error() should be fat_msg().
+ * _fat_msg() - Print a preformatted FAT message based on a superblock.
+ * @sb: A pointer to a &struct super_block
+ * @level: A Kernel printk level constant
+ * @fmt: The printf-style format string to print.
+ *
+ * Everything that is not fat_fs_error() should be fat_msg().
+ *
+ * fat_msg() wraps _fat_msg() for printk indexing.
  */
-void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
+void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -53,7 +59,7 @@ void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk("%sFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.30.2

