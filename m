Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F4480D79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhL1VbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237500AbhL1Vax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=DMJE9waWCIjZlvFWNlhuZn2N6kyGfdgiULqhoE6de+omDvUnsmykFxiS/5lzLwkjm+vIxy
        gPRj/LvHOyUBKPCRBcVePFcUZJQgdvC3adiG+PI8sEyY0QZTl/sAsdKNcf1cxFUR6TR3q7
        IaK4XAwxeiL97Qe1kT8COwz/pZxNtEQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-K-hH1ZR5ObK8yeBbfLegIg-1; Tue, 28 Dec 2021 16:30:51 -0500
X-MC-Unique: K-hH1ZR5ObK8yeBbfLegIg-1
Received: by mail-wr1-f69.google.com with SMTP id h7-20020adfaa87000000b001885269a937so4330511wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdvMqON2+g29uF5MGNt8FJ0hyaTFBqbggeNzWwGO7Ms=;
        b=XUmkRZSP0FaAMddnEFaG2JAScQCn8ZCJ8G7uML6QJ8iXLcmETqVVgLUYqYmwtDN53U
         k6JzZXz1b4jt87oUtVF2A2neMTt0XGge3wpp8uTvVPoXhznfAUWnZNoZBMatO7I7MEFv
         khm2Gs+k1aTWeK19J9DpVBt97Qg3NFrJZ/TiC3XBjwJHjTy87QyC7TlGI0mtSL6hxHGM
         e6pV38G0TEcz65RDV/slCWbgYL7KTCbw795reUrEQ9M1p/+pK8ih2TAoVfF8WKVsDFgP
         mbFxWrJyuFS0k+eWncNtmE7h/HRrgjsxASNsOp5U82Qd1+wZn+e+frSwiNde9uNuFUfV
         EYAg==
X-Gm-Message-State: AOAM5310FzYVKusU0vRGtQSbMjd9ORk7DkQZ8ht3BZGOzhoAqV6TC7R0
        Ar9sQRAqjjh1OVEkx80yjkR7wAwGGjAu3K/21g6aDJYxyASnJA4p6i+PoWd76jC6/PYSZ6xYTE0
        1PONk8nPSLWU5UQUgx3kxHR0=
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr17330566wrc.274.1640727050412;
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa/mdwd5RP9WlrJlprOyPdltkjlK5AWEEYB/GP6aDuIFA61L/iYsiVp0nPYfPfNVYFImXi+Q==
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr17330554wrc.274.1640727050268;
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r7sm18530335wrt.77.2021.12.28.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 08/12] module: Move kmemleak support to a separate file
Date:   Tue, 28 Dec 2021 21:30:37 +0000
Message-Id: <20211228213041.1356334-9-atomlin@redhat.com>
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

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile         |  1 +
 kernel/module/debug_kmemleak.c | 30 ++++++++++++++++++++++++++++++
 kernel/module/internal.h       |  7 +++++++
 kernel/module/main.c           | 27 ---------------------------
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 kernel/module/debug_kmemleak.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 795fe10ac530..2e03da799833 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..818c9d168aed
--- /dev/null
+++ b/kernel/module/debug_kmemleak.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/debug_kmemleak.c - module kmemleak support
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
index b4db57bafcd3..31d767416f0c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -6,6 +6,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/compiler.h>
 #include <asm/module.h>
 #include <linux/mutex.h>
 
@@ -72,3 +73,9 @@ static int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+extern void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void __maybe_unused kmemleak_load_module(const struct module *mod, const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 8f8a904d5ba7..672a977b1320 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2467,33 +2467,6 @@ bool __weak module_exit_section(const char *name)
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
 	unsigned long secend;
-- 
2.31.1

