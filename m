Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425704A3A74
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356741AbiA3Vcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356487AbiA3VcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643578342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKFHu1mwRyMCd3tE6xfYJyy3RgbH1D0nAbWrHT5RWOU=;
        b=DCR9t5yrgdZX6WNYuCqMcBXxRvad9/or/d8ffkAF6kvly83Sr0fJEdiPq6B8xM9vonhxc5
        JbQ6D53K2+b3s3l8miFl3+Kc+FbToDwVCtq6BL1BofFpl0uBFBrjjkDDnRpzeZSh9+Fisn
        CwGam0xeAB78xp+RURLUrfV1hpJDH9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-4WIY67vkMqqu0IXJPNUKSQ-1; Sun, 30 Jan 2022 16:32:21 -0500
X-MC-Unique: 4WIY67vkMqqu0IXJPNUKSQ-1
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a1c7207000000b0034ec3d8ce0aso5135245wmc.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKFHu1mwRyMCd3tE6xfYJyy3RgbH1D0nAbWrHT5RWOU=;
        b=AnVkjqDu6ZgJG9+X6CRe8cGH5J1J4iCVkD1rdo3WT9sGDHi+Xo5L/h3+0t8NzBhPO2
         yzxbc3UHCdHsvFFKR20ysZVXXXbkorfa4unklU4R9atAlfLZ85SpobY/JtFmYg4eqxF7
         JqVHO4CMCpme6DzpdDfATi2S8GoSbVCJ5CWKompJupuh3ramQZLZPX3uNrQsYxQk8e45
         ROYAbKafanQiprsdhfhemvhOWemf3rx4iPQ5L3+Z6YzXLRToh9PMm7+92wxbhnl8KT81
         zd4W7LBO494zlc3IrE3fEnxNqSGUKe4sYZxk33KVk+JUphLn+14ZIDfZ61eye0Vmpdpy
         VshQ==
X-Gm-Message-State: AOAM532wctJxMyK4xw9sSIW3Lye2GLOEBS21UN6QlVxeoRpB73/szaW8
        cdolaKTbDF3I64SFyO98v7jrda5kTzs6KimqO9AxiSwj421oIYb96woSKpOdSJkJJi4GO8suBgz
        YHPv+8jybLkFyl9HEYqIVPII=
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr15316702wry.523.1643578339933;
        Sun, 30 Jan 2022 13:32:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw17nLhSQySLDHIo8E6y8aoNvy6mIUxMDuspgSa/9hzx9TeehLqEPnw5LpcjcmIpptujoZxyA==
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr15316693wry.523.1643578339742;
        Sun, 30 Jan 2022 13:32:19 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l11sm7075887wry.50.2022.01.30.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:32:19 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: [RFC PATCH v4 02/13] module: Simple refactor in preparation for split
Date:   Sun, 30 Jan 2022 21:32:03 +0000
Message-Id: <20220130213214.1042497-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130213214.1042497-1-atomlin@redhat.com>
References: <20220130213214.1042497-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch makes it possible to move non-essential code
out of core module code.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h | 22 ++++++++++++++++++++++
 kernel/module/main.c     | 23 ++---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8c381c99062f..e3c593f8767f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -7,6 +7,28 @@
 
 #include <linux/elf.h>
 #include <asm/module.h>
+#include <linux/mutex.h>
+
+#ifndef ARCH_SHF_SMALL
+#define ARCH_SHF_SMALL 0
+#endif
+
+/* If this is set, the section belongs in the init part of the module */
+#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
+/* Maximum number of characters written by module_flags() */
+#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
+#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
+
+extern struct mutex module_mutex;
+extern struct list_head modules;
+
+/* Provided by the linker */
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___ksymtab_gpl[];
+extern const struct kernel_symbol __stop___ksymtab_gpl[];
+extern const s32 __start___kcrctab[];
+extern const s32 __start___kcrctab_gpl[];
 
 struct load_info {
 	const char *name;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d8c6269af6cf..fee64c4957f3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -63,10 +63,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
-#ifndef ARCH_SHF_SMALL
-#define ARCH_SHF_SMALL 0
-#endif
-
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
@@ -78,9 +74,6 @@
 # define debug_align(X) (X)
 #endif
 
-/* If this is set, the section belongs in the init part of the module */
-#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
-
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -88,8 +81,8 @@
  * 3) module_addr_min/module_addr_max.
  * (delete and add uses RCU list operations).
  */
-static DEFINE_MUTEX(module_mutex);
-static LIST_HEAD(modules);
+DEFINE_MUTEX(module_mutex);
+LIST_HEAD(modules);
 
 /* Work queue for freeing init sections in success case */
 static void do_free_init(struct work_struct *w);
@@ -408,14 +401,6 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 	return (void *)info->sechdrs[sec].sh_addr;
 }
 
-/* Provided by the linker */
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___ksymtab_gpl[];
-extern const struct kernel_symbol __stop___ksymtab_gpl[];
-extern const s32 __start___kcrctab[];
-extern const s32 __start___kcrctab_gpl[];
-
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
 #else
@@ -1490,7 +1475,6 @@ struct module_sect_attrs {
 	struct module_sect_attr attrs[];
 };
 
-#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
@@ -4555,9 +4539,6 @@ static void cfi_cleanup(struct module *mod)
 #endif
 }
 
-/* Maximum number of characters written by module_flags() */
-#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
-
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
 static char *module_flags(struct module *mod, char *buf)
 {
-- 
2.34.1

