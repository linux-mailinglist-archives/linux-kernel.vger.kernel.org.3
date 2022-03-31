Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0674ED120
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352199AbiCaBAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbiCaBAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:00:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDF1AF02
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:58:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cm17so2507754pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZdhDjjK9OsK+m9vgDKiwjIPfyFYD6KvJkWr9Zxy8aM=;
        b=yTriMesdpvmDPaYBHrhfejORlMkN7fEYb94pCLNWrg0Ifd4Z5TtRdC2C9UwR4uf7rA
         qA23HdXAnrtS1k1ljCpTxqV5TTXy4tRTE2/GWnNMT7W3QAHDwsD/UUmUayhdoZ8fC5E2
         p1+PT1ae0OyzjwzceAJAMKyclP7HqDWkvY3pAAIscTPeP+UDndmshw+q7EU/mlEYoBxH
         d5n4XO47lGMpqECSfLS00GEiAP55IRRyFzcsDYoWchxWWFBca5yGoDlIbmYQDzQjWpEL
         hCeeB/qPLZhgHJAxFDDhO8jzq3h5LD72hI1Aok4RcNTuBXT7vTyLmBEQ1FQneT/RY4xm
         yQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZdhDjjK9OsK+m9vgDKiwjIPfyFYD6KvJkWr9Zxy8aM=;
        b=aG6NUrF3eydjQUPtkdbUB8KNp0XzUig9sEpExAN/O2ie+3u/4WEYAz7SxQwX1dVfWM
         0E6HSEKXwxb2WRGqLjrop+IdJiHy+tTxvBZEthY+Zh5RBNH3jVwEE7T/r7/Ea+h7sGVl
         VXD7Ph5eFtLnxfE+44UTE1ShphEGPVdX7Tu1SAGDXe0MzKuXwNoEoVSfUgvP6XH6vSwP
         GjhQxka+rPGF9mPVB8RJlPcpZQfR5LwVoP1W4lNQ3mBMHhRZdnJbLPFhMe/2Inxr+5NB
         guH5IZwRKTr59goSvzQ15UTSELW0uB1EoB/yyxhZvhTUHWAVPfcDiJ0ZQRYiB6s/I+Db
         mvQg==
X-Gm-Message-State: AOAM533lUeZ/UQAIMyWsDwT1+S53zTyMG9fbp3FM0o/Q9+wHDLZJ5+cO
        T07z6jYRJgjfS/pV/kKXcIv2qg==
X-Google-Smtp-Source: ABdhPJzXeFQ99hNqi7T1CtmItH1DQOAncEJrNYnDICW2fBckqPiOD1m0d+Mt0as7iK45oA1ibWvyWQ==
X-Received: by 2002:a17:90a:2e08:b0:1bd:59c2:3df5 with SMTP id q8-20020a17090a2e0800b001bd59c23df5mr2846511pjd.235.1648688311150;
        Wed, 30 Mar 2022 17:58:31 -0700 (PDT)
Received: from banyan.flat.jof.io (192-184-176-137.fiber.dynamic.sonic.net. [192.184.176.137])
        by smtp.gmail.com with ESMTPSA id h12-20020a056a00230c00b004faf2563bcasm24550030pfh.114.2022.03.30.17.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:58:30 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v4] Add FAT messages to printk index
Date:   Wed, 30 Mar 2022 17:58:00 -0700
Message-Id: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648688136.git.jof@thejof.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648687832.git.jof@thejof.com>
References: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648687832.git.jof@thejof.com>
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
production, it is proving useful to leverage the printk indexing system.
This printk index enables kernel developers to use calls to printk()
with changable ad-hoc format strings (as they always have; no change
of expectations), while enabling end users to examine format strings to
detect changes.
Since end users are using regular expressions to match messages printed
through printk(), being able to detect changes in chosen format strings
from release to release provides a useful signal to review
printk()-matching regular expressions for any necessary updates.

So that detailed FAT messages are captured by this printk index, this patch
wraps fat_msg with a macro.

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

PATCH v1 -- Fix indentation with tabs in fat_msg macro
PATCH v2 -- Define FAT_PRINTK_PREFIX
PATCH v3 -- Fix kernel-doc comment for _fat_msg()
PATCH v4 -- Reword commit message


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
 

base-commit: 787af64d05cd528aac9ad16752d11bb1c6061bb9
-- 
2.35.1

