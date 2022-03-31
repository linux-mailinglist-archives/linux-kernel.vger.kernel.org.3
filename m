Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FA4ED113
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbiCaAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352161AbiCaAx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:53:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011055AA4C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:52:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so1215371pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXwltjMYyBKj1ElPMEQWrCVee8Nth/CJBd+bdiNgZpg=;
        b=EZG1O9SHiQEYxpTyRkxqMxdn83bRz445In5mlZ20lv/ovtmKicm8MXT/9Yp4SHcY0Y
         /3RFQC4ksqbatyLW5MnHMqc4t7EAy7LnJtPh8r9psMiAmxh1vTyukKn8ox+k5MWgzsgr
         Q66akPQmebNnSl/8lZ+E4XJV8xhwicHFC3yYKq7MHTknu/gezlLel/inNFgfFWzOLZAS
         VW6ANkvqrB3uzFYwdedj2Z3BsI9fOaJKf5E2rA9dN22a3wOLWf1SsRBJpeVGQIez6swk
         BPkBS4CiHjXQxDMFh52yCGIjslYVRaHwhRsZWO+au+UGGWDAyvJmEgzWMTJg49jJie/o
         xHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXwltjMYyBKj1ElPMEQWrCVee8Nth/CJBd+bdiNgZpg=;
        b=0HLm9j0VFsNN7dxMltRsOYkoi5GkygBooorr67HUJpEJ/Zx7WO7OvWBxHOSzoz7+Bt
         H4uDi3I9SjiETY3tckxAQEFfXX5+PMFf++5fpekXahEjxPeCmCY/lQWf/PeY4NkVFAzQ
         2LL7aGlsynVMoZxKTwwm2gHwwjwJ3/EWTZ0bnmdXyGInly2Uh8HFL6WbTyMZW5FCvFdg
         Jx8hQwiGRY+CKGFDQsCV1fnbOhKcFCNouE01KlSbxtyzDQ7izu1EvonVioLMbUgZq9EN
         +dnz4zx5+KJu1lF28irjzEIJ0Ku+kakyoIqptt5MMy5B8mJxkdbaZSxYUxTTjv+7YBKs
         e9XQ==
X-Gm-Message-State: AOAM530iWHFS4jCArPCn1mOWaF7IOT7rLDuEGzCf4SgdWSVUTMO7rZ53
        TE+6IPEY+mML8jOANMpsbgK/u7FSDaY6Oc8toY8=
X-Google-Smtp-Source: ABdhPJx6j0e2aOLLiRAnMqaGMebobmN26fcIXF13gVi7FLXh0l82SPSsYA3B2EWOJV66QqzEOrxqeQ==
X-Received: by 2002:a17:90a:bc02:b0:1c9:e722:918f with SMTP id w2-20020a17090abc0200b001c9e722918fmr2848783pjr.127.1648687930295;
        Wed, 30 Mar 2022 17:52:10 -0700 (PDT)
Received: from banyan.flat.jof.io (192-184-176-137.fiber.dynamic.sonic.net. [192.184.176.137])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f66d50f054sm24816303pfi.158.2022.03.30.17.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:52:09 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v4] Add FAT messages to printk index
Date:   Wed, 30 Mar 2022 17:51:57 -0700
Message-Id: <8aaa2dd7995e820292bb40d2120ab69756662c65.1648687832.git.jof@thejof.com>
X-Mailer: git-send-email 2.35.1
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

PATCH v1 -- Fix indentation with tabs in fat_msg macro
PATCH v2 -- Define FAT_PRINTK_PREFIX
PATCH v3 -- Fix kernel-doc comment for _fat_msg()
PATCH v4 -- Reword commit message

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
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
 

base-commit: 787af64d05cd528aac9ad16752d11bb1c6061bb9
-- 
2.35.1

