Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85EC4DDFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiCRR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiCRR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:27:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C631D7607
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:26:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t14so5495202pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyzdGcC7z2CaLIxh7mq81OL5m9NRMojME9w8lSxLMjM=;
        b=30sApx0Og4EZwM+m1YS/xRdshE5OwNyV8TQ6seWUNxBNskSxn5h4RxMuoDgmCnHbkX
         V8QLgNNZF+VcOnYJcmq9M3A09TfoWaypBI79oTels1ka2rzWG9O+rmfQ/tORvd9vpyYQ
         1AsqrwbapEn/jFgiN6eSJC7nMuLLUH/g9fprgSIeBk6a9fbEWKGdWhqjkVBwbwLAldt8
         Hy+X138N2Yc1I25eZwDjhEUPHC1fMA6/Uiw6NExQxqghnQIceW/8mFfmELZ7cIq8gyfh
         NhBWoUfB6etAWfVe9o9HW/mmN71T6+3qUUUVZLSsoW0566N1XnGLmLKdhwfz9RXUnLrL
         JxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MyzdGcC7z2CaLIxh7mq81OL5m9NRMojME9w8lSxLMjM=;
        b=5tu/uapMmvaDGYo/2uwXt3H+d/SlU4ASrKqTsg6fgfx5IlDUJ4BW1TVSGvRaggKW3J
         GEX8emC9SWybrAPlfaIXm9OFNTODbJwBOFPP5Wc6dtqO+kqf6Wlq5GuiiNU2uo5BOIQR
         xIpMqzzS8BfEkuAs/zuJnPlK6PFbHuFNIc/G14EoiURCe2reKfnrsRnZEa/lbD7B19jS
         EDd2wx0NLNNUOULf5H93FbtDMq3cFxXu4q13ASY2mfI2n0c+ZvU1HhOFyW2fQaDEGheD
         MVWlf/VBR+WJoE/TzNlGwVrrwvPc8E88D4eHNZxU+xdmDVug6Ftf/jxqsjgnlEc+zqML
         VrgQ==
X-Gm-Message-State: AOAM531PZb6RulQUeJpwwrz+6pjlqyFww+PhrOJoz4iDlU+pbAoIws3B
        KRiVy3zEhmL4srAmN0jfRMzWBHcQxGsl7JtRqdg=
X-Google-Smtp-Source: ABdhPJz7wfBBo4CoW9VBKHtWvsoTalOpgpEg4X63l0tzURvmOqUXoNTUSGh882/+LQ2yZ2IhUNCUaw==
X-Received: by 2002:a63:6a41:0:b0:37c:7a6e:e7a3 with SMTP id f62-20020a636a41000000b0037c7a6ee7a3mr8490924pgc.528.1647624366169;
        Fri, 18 Mar 2022 10:26:06 -0700 (PDT)
Received: from banyan.flat.jof.io ([181.214.206.226])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a001a5600b004f7c17b291asm10215305pfv.87.2022.03.18.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:26:05 -0700 (PDT)
From:   Jonathan Lassoff <jof@thejof.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Lassoff <jof@thejof.com>
Subject: [PATCH v2] Add FAT messages to printk index
Date:   Fri, 18 Mar 2022 10:23:51 -0700
Message-Id: <c11c5c259d5e53afe5b20fa761002e7edd48277f.1647624190.git.jof@thejof.com>
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
production, it is proving useful to leverage the printk indexing system. This
printk index enables kernel developers to use calls to printk() with changable
ad-hoc format strings, while still enabling end users to detect changes and
develop a semi-stable interface for detecting and parsing these messages.

So that detailed FAT messages are captured by this printk index, this patch
wraps fat_msg with a macro.

PATCH v1 -- Fix indentation with tabs in fat_msg macro
PATCH v2 -- Define FAT_PRINTK_PREFIX

Signed-off-by: Jonathan Lassoff <jof@thejof.com>
---
 fs/fat/fat.h  | 9 ++++++++-
 fs/fat/misc.c | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index 91ca3c304211..a3f1e4f8bed3 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(__fat_fs_error);
  * fat_msg() - print preformated FAT specific messages. Every thing what is
  * not fat_fs_error() should be fat_msg().
  */
-void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
+void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -53,7 +53,7 @@ void fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk("%sFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.35.1

