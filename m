Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB93E4BFA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiBVONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiBVONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 382DEB16E6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=SSE9Opl6W/7FDHYn5IhjVh+bTY/FO9aAa/LuWDfdF1ojmp9CXf3utP0ekR577p21MdsOSL
        TQqRbW2wwAoIbyOx6CX9HH+ueLxBTCcWQEjeC4PKjGFbx71ovFU3pzpTSLfl4PRB0PAOnP
        Vyf+woKgCPKa/cmO2ovHiopCpnRUZGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-NOjmhQSPMI-asEy5N-eH_w-1; Tue, 22 Feb 2022 09:13:08 -0500
X-MC-Unique: NOjmhQSPMI-asEy5N-eH_w-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b00380e3425ba7so411412wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zVpwYHDHIaBW4/Qu1I++XmAGaqsqPN3XBi8gcs7g9U=;
        b=z1fiY4WPdnXj5a9wU3aNz1wFDT0jli/1zjx1RbDSR4Vg6lorrF+Ql9TxnLspoWbVGY
         7R5NBZ66tBwTTfGYmPHkem/1InEsIJNQWqGtUJaKvCKIq6eohY1woFE9OOxRq14YX/a/
         7sYPXAq9mwHZpbSroqVUNHg83YHuu7VPNp1EkURBo3KrRZXfWHf3BYALruBIIeA2ayjo
         wqocFSlJZDyeY+kVctFiE44eq7GnJ+o+FyocZ32TjaAHOOMthjd1Pw/WL73hzZeT7tFO
         TLzypuesg2KtQlNWpTr8Ug4A3lrmPF+DUBecpL1srT9O+8g1IkBubiL1odN61JIX2TIa
         NwkQ==
X-Gm-Message-State: AOAM530EksJI8KN2by9LI+e1SRsWBrFj6vsQCtCadbj0oy+5hLxezPw1
        JKuR3hltfJoI5RDr5l9KjlAasDEC9ym1VQ9yecR+mR0tYIJ/rEgC6qTB4MO6Dvp5mwl046WBN7W
        xdw00Xo1TsrqNxkfRGj5Im+A=
X-Received: by 2002:a5d:68ce:0:b0:1e6:34cf:f7a with SMTP id p14-20020a5d68ce000000b001e634cf0f7amr20396801wrw.438.1645539186826;
        Tue, 22 Feb 2022 06:13:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjzmtxxnsQJ/Cc/G2/s8zBACl29beg0oaMrjFoneeJsStHeWFgYJDCBu78Mvo95ahCns/gpA==
X-Received: by 2002:a5d:68ce:0:b0:1e6:34cf:f7a with SMTP id p14-20020a5d68ce000000b001e634cf0f7amr20396775wrw.438.1645539186640;
        Tue, 22 Feb 2022 06:13:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b0037bdd0430c9sm2565650wmb.16.2022.02.22.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:06 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 02/13] module: Simple refactor in preparation for split
Date:   Tue, 22 Feb 2022 14:12:52 +0000
Message-Id: <20220222141303.1392190-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

