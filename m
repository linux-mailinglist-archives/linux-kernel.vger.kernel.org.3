Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BD480D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhL1Vau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237471AbhL1Var (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=hbop5jSnE+BTiFCVm2J6DwAT81q49tG8+2dEA+nW2m5/lBeCqdGSoQ1jb9eXmeSR/AaY84
        zbhX6gv6Olp2wt1jKCwS7jyZWJmRuYCSs87rkz1a7PTCGVCbAvWPrYPNhm1r5Iw7C7VtnB
        EGOx7Qxb2bvI4017Xy4eXDewu+HIE8Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-RC0eyZifPoO0S_EjMd7g7A-1; Tue, 28 Dec 2021 16:30:45 -0500
X-MC-Unique: RC0eyZifPoO0S_EjMd7g7A-1
Received: by mail-wr1-f70.google.com with SMTP id t30-20020adfa2de000000b001a24004e1fbso4297446wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kJi6QbhQe0UKqaYog/4fs8E9UhX+TpYHbtJQ2kzdak=;
        b=Ks3I+eFEaCxAhGTgltNs6q0O3Gdhsh5RMPGwkgzkaknTwQxhbj7ELGmTG0N5FLC5CX
         86ppyOSIw1tPgK0AvglXJX5ykYy8rTh3iRZvtAS0h0L90RwRLxUEzxXpmkg0c2ozwjr1
         AlsNYTi4cSyiHlqDUPF17cBBtLGuH3xju5x2XihRmcyba40qw85pb5ixFRY0hP1j/xfn
         M+h/vQXtPUVB6Ljr/UZN1+DJh54h/bUVfutZPKxHMLvtdjZwf1B9aTU5vnfkZby7ATAy
         Z/AoJOIMTIn0cnSWzr5etDvolNi67SXXFqxQDfSHOYvhEEst2aYqKfR8DNtq+fnnKh/N
         0Caw==
X-Gm-Message-State: AOAM5333Ua+E+sZdPE8kEY6fYjXBlHgDOIhj6lsjWsHWvBcvvBCIixG7
        ehUymDRnj+6aJMTa6sVcX5Rs5ZTopaKi+g4JV1UtPYBfjp15GweF5nhqTuPUSDZWy/RBfr8nvL0
        oZ2aHQwWJLBU+Im/6eUK6cAI=
X-Received: by 2002:adf:f40b:: with SMTP id g11mr17714784wro.645.1640727044320;
        Tue, 28 Dec 2021 13:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbqBZEjYGOyh2QSHDIyFzBjjvk3ujK70INOECBs15JXNRoREc+6f2quKphIDOOu8dbecImnQ==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr17714769wro.645.1640727044176;
        Tue, 28 Dec 2021 13:30:44 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h3sm19232220wrt.94.2021.12.28.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:43 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 02/12] module: Simple refactor in preparation for split
Date:   Tue, 28 Dec 2021 21:30:31 +0000
Message-Id: <20211228213041.1356334-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
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

