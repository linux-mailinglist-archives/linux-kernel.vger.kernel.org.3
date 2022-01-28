Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47534A022C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiA1UkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344515AbiA1Ujt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NsAIYrsaMFdioppTbSAD/oCtDYtbz/3oa7wgYDL+PvU=;
        b=E9PdFAS0784h9hRA7hPuz/6I46MhCRU+c47zoOrJGNiSI1VOiuVCgO8HrxKeNVwZhFIj1w
        rKbhqQtLQocQXSTfsx9OJRDiPUGj1gDlAFSQR313gaOjWPNDzkRs0YjdL1de5an4ijBmmk
        Vfxxs4l2rkVn3CD8/acot+X6mQYv18E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-XjLINWNtOlS8bfw1UhoZ0g-1; Fri, 28 Jan 2022 15:39:46 -0500
X-MC-Unique: XjLINWNtOlS8bfw1UhoZ0g-1
Received: by mail-wm1-f72.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so5663601wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsAIYrsaMFdioppTbSAD/oCtDYtbz/3oa7wgYDL+PvU=;
        b=uqdVu2WckGWM3UzOdaXUsLMoV5SxDGg706xyHiL4qvZ66GL4XKLaSR6nRxBVnMeEKK
         xLZ1SgnjEqsp0bPcG1fli3ti/MFpMIDWXPME/RZ+AKa1ERleoIKp4g0OPIgbEfoXANyv
         GQNiLhV7AtHeN+q5zis+E6Drfa3QsX9QQDwPoakMXwzG7UB4kUeRDJSbfZ3nE1AK3pA5
         JODWIErLjH4a0T+pwO9IA/lj9WeJ/DZ72v/Z/ORs7reIGhSFwuOdgfDjDBu78zKiBhqC
         Ru3R29iJd81BqXK/GDf9NtaGod8dsovelFlCV31p8FIaNWbmvkGNQXOoFg4NlT4jcwTh
         KD2g==
X-Gm-Message-State: AOAM533wS7TquktN5dvTJNYs4jCk0sWoNTGNKRydDGYNItdnVEHL2bX7
        JcJSD7n3Ni4S/xyQmQIkiOvmUb+Y4GewlRO2auEE6dbCGyK8SWEOydV+NzN0aWoMsPyYPC5G3dt
        VIbQVliaZ9cwryLKAwbxFMmo=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr8394474wrt.219.1643402385773;
        Fri, 28 Jan 2022 12:39:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylzjcgZDoD96Qm8ciNhcI7xY4BI+En+zUfdeeoKuCa44n6yGgIy3KnBjrReliOeKPRyvJFcw==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr8394460wrt.219.1643402385645;
        Fri, 28 Jan 2022 12:39:45 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 1sm2702409wmo.37.2022.01.28.12.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:45 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 08/13] module: Move kmemleak support to a separate file
Date:   Fri, 28 Jan 2022 20:39:29 +0000
Message-Id: <20220128203934.600247-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile         |  1 +
 kernel/module/debug_kmemleak.c | 30 ++++++++++++++++++++++++++++++
 kernel/module/internal.h       |  8 ++++++++
 kernel/module/main.c           | 27 ---------------------------
 4 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 kernel/module/debug_kmemleak.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index c4198fcf4772..3901f0713f22 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..e896c2268011
--- /dev/null
+++ b/kernel/module/debug_kmemleak.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kmemleak support
+ *
+ * Copyright (C) 2009 Catalin Marinas
+ */
+
+#include <linux/module.h>
+#include <linux/kmemleak.h>
+#include "internal.h"
+
+void kmemleak_load_module(const struct module *mod,
+				 const struct load_info *info)
+{
+	unsigned int i;
+
+	/* only scan the sections containing data */
+	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		/* Scan all writable sections that's not executable */
+		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
+		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
+		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
+			continue;
+
+		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
+				   info->sechdrs[i].sh_size, GFP_KERNEL);
+	}
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 5aab87716d9f..ef9513070b88 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/compiler.h>
 #include <asm/module.h>
 #include <linux/mutex.h>
 
@@ -89,3 +90,10 @@ static int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+extern void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void __maybe_unused kmemleak_load_module(const struct module *mod,
+						       const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 36ed4dd64cac..6fb1c885d9c2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2466,33 +2466,6 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-#ifdef CONFIG_DEBUG_KMEMLEAK
-static void kmemleak_load_module(const struct module *mod,
-				 const struct load_info *info)
-{
-	unsigned int i;
-
-	/* only scan the sections containing data */
-	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
-
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		/* Scan all writable sections that's not executable */
-		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
-		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
-		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
-				   info->sechdrs[i].sh_size, GFP_KERNEL);
-	}
-}
-#else
-static inline void kmemleak_load_module(const struct module *mod,
-					const struct load_info *info)
-{
-}
-#endif
-
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
-- 
2.34.1

