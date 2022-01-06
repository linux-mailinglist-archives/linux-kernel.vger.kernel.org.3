Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF5486DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245696AbiAFXn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245664AbiAFXn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=eSPuA029nkI2EpemBayf5/nQbBnIsGwAVZlbp3jNdbZWEjjQfdOBUz4xwQ2R1GclIacsHA
        VP59JuicMKuZfyKGpMux4aK52KQv6sdvmFXryp41jS66x6IpQhjlU6sfywfD4W3x+XHFlw
        7uauXOjszGAgQMs5wieBpoGeVNwJ9Vc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-PfDQ330TMz26ed8c4i1FRA-1; Thu, 06 Jan 2022 18:43:24 -0500
X-MC-Unique: PfDQ330TMz26ed8c4i1FRA-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so3716279wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=JgEfpZmRjq3+rdDz9TV/UkH+4hM03bNorc7JH2w7cnV2JeWKEj5bocX3MNPj3PKcmV
         Yq6o1ZYX2jhTqyktlEgYRUZBdVl1XscYqb8aaAxubSMD0nx1iL3avHeP7HLVfXpJjuip
         qiHH6EvQenGlu1ToaVGwzzpb5tQoz+I6VW1T5CljQwlyyvFHdRg9ZGf59PN3zisvh1tf
         /mFKP4FfDPSLPGlL2N1FRG9XPI/VGGWocC9TgpbrSaL2mfQSwEoTkEh/2oi1Qj1/mXKU
         TZL/+bytCjQoAISIzkmTAo9NyPgyPPhj5FQ8oJd8G5PNgQFySXR9Revs0XdwH87W8L0E
         V6pA==
X-Gm-Message-State: AOAM533Tb3B3NzpvuD/xIiKeRYe686RblFONULgLxH7v9uKwJOUrrF+n
        HBPhaxJh4/1jBWjnsk6ySiGclK095w0CC1XTwYWVWWHziI/z4/3T9g0aog2NvPgD+kANBmUEcY3
        5konmyfjUB+dTwbirCcqZSnA=
X-Received: by 2002:a7b:c118:: with SMTP id w24mr8854763wmi.22.1641512602932;
        Thu, 06 Jan 2022 15:43:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuWOVlKzbntgAR3rk5Pck95yKMKdiYzb9eqkYQL4b7cFRgzC6t8B5lsX7KIeE20CgK6R/AuA==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr8854744wmi.22.1641512602724;
        Thu, 06 Jan 2022 15:43:22 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w8sm470021wrs.41.2022.01.06.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:22 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 02/13] module: Simple refactor in preparation for split
Date:   Thu,  6 Jan 2022 23:43:08 +0000
Message-Id: <20220106234319.2067842-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
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
index 33783abc377b..ffc50df010a7 100644
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
index bc997c3e2c95..2a6b859716c0 100644
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
@@ -1491,7 +1476,6 @@ struct module_sect_attrs {
 	struct module_sect_attr attrs[];
 };
 
-#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
 static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
 				struct bin_attribute *battr,
 				char *buf, loff_t pos, size_t count)
@@ -4498,9 +4482,6 @@ static void cfi_cleanup(struct module *mod)
 #endif
 }
 
-/* Maximum number of characters written by module_flags() */
-#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
-
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
 static char *module_flags(struct module *mod, char *buf)
 {
-- 
2.31.1

