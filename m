Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27324BF8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiBVNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiBVNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E63151D3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645535358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=VwZNFxR77lbkpEtRsxdCTAJUCuaaqy0k3cShwxrqhD573OMtzIlGLT4LJg6RU8YJhWpmyn
        QaEjfUr3nFYrf6YK1lWD6otozFDmSmL2+tvDnobUkvii49AMK6eFR9LrS67kSXlN3YHlS+
        eIMYga+uWl/CHqScEOCEQ6lmr7ShbxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-6JlWTrEVPBWcUn2KGw5y8A-1; Tue, 22 Feb 2022 08:09:16 -0500
X-MC-Unique: 6JlWTrEVPBWcUn2KGw5y8A-1
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso589153wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=vUV+Oexa9UGvCANCijAsozehwG5v29hUzRBQ1WRXEt/w+vQJaOVCb73c8Vpk3QSLUu
         hqkSmphaLfDdPCAVNdAqqsSIP+AUKJbHU8DsF01g0jwp4d0fi3ADdl7ShHNBzteY//AQ
         k0eeTbJW/o9fRU7Hinv1taxD3QkYjN7NKBOMpA+Gzwg4D+JEZrSDJeimReZiiKM1mnz1
         pVCa4FJc0Lb2xeJb2TGkSLXLPytmNu8p/aQvyv+ySfwzwuZROv2vtFj32St6XyLOXA6y
         RfVCBmXqPtM9Qjh1mhWoovoi4bqt9oN6gQFjSS0kXomfiuDKoGnmWAAUQTgiA4cE4mcH
         yPug==
X-Gm-Message-State: AOAM5309RYGY5aa9ZQVonlHl+iGaK8auc1mCuvC0vnBWoi5QG0DP6cmB
        wO6HdeeMrbpjn4hnVuShq9/sF5mvl7nkuE1Ct1gvUa52OO0uOOb2ieuGPcDiS3NsXvjrJuaL1od
        PXRORvKGPavhi+HKXKqBstnM=
X-Received: by 2002:a05:600c:354e:b0:37c:815f:8a3f with SMTP id i14-20020a05600c354e00b0037c815f8a3fmr3313199wmq.15.1645535355538;
        Tue, 22 Feb 2022 05:09:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQZUOcmka7nguaRPH6nM7p3MydniI3eCapUpOS2yqAzqCqv/uWaEJ/dUdgWIOzkVBk3J/Q6Q==
X-Received: by 2002:a05:600c:354e:b0:37c:815f:8a3f with SMTP id i14-20020a05600c354e00b0037c815f8a3fmr3313189wmq.15.1645535355348;
        Tue, 22 Feb 2022 05:09:15 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bk5sm39623223wrb.10.2022.02.22.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:09:14 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v7 02/13] module: Simple refactor in preparation for split
Date:   Tue, 22 Feb 2022 13:09:00 +0000
Message-Id: <20220222130911.1348513-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222130911.1348513-1-atomlin@redhat.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch makes it possible to move non-essential code
out of core module code.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/internal.h | 21 +++++++++++++++++++++
 kernel/module/main.c     | 22 ++--------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8c381c99062f..ea8c4c02614c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -7,6 +7,27 @@
 
 #include <linux/elf.h>
 #include <asm/module.h>
+#include <linux/mutex.h>
+
+#ifndef ARCH_SHF_SMALL
+#define ARCH_SHF_SMALL 0
+#endif
+
+/* If this is set, the section belongs in the init part of the module */
+#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG - 1))
+/* Maximum number of characters written by module_flags() */
+#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
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
index 34a2b0cf3c3e..5f5e21f972dd 100644
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
@@ -4542,9 +4527,6 @@ static void cfi_cleanup(struct module *mod)
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

