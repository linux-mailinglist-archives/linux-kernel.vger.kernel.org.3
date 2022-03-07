Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8214D058F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiCGRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbiCGRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D261E939AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=SQtwZ7R9494XU/RfnykcmXiNrKQ+e+wR0XxLaNtl70c4NMsp8PkoBIwDkDr3xv/8+ltDh6
        yKsvSCr3FIa5L63hlTJIs9+s9pTBgjgmKJPW8PvKKq8K1smNJpRjY6OhCYEn1BEIsQVVzW
        F0s64sGtSNOf/IxlMc7G91FXTX4dRbw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-FUnWVB2fMryNGzFnYRokwQ-1; Mon, 07 Mar 2022 12:45:29 -0500
X-MC-Unique: FUnWVB2fMryNGzFnYRokwQ-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so4875727wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EwM5m/UKCLcQUodhjTTwfqA0OAG1WbMnIR0FKcI9qsQ=;
        b=ZW3oGoKXZzR3TjaKDbKM9lz7iAsiN5D/gETFIrs2JiXxWjYFbyjE4r8OKZwyhbCYgQ
         Qwvx87tEO1lx5F9KDkmgUJF6qLxoJAQPLNlepYPo+gekUZWwhdIqZ9cRypYmi5u7ZY5U
         GAnTVZtk+GzYy4gFt8/AiVqzglEZnulRlL+kBNXPFGdSSmCA66ahH8/5MmksvrkaDbiW
         CecWQKi/+IMCeCdtHu/vkefkQqZjym1NP6AjkMRCNq6QsSab5OeWqp5LT4OfKoreOhHl
         paPrFTkq1l6lgItSHpy2tm/U6sfngwFmoDJ2DumZpYsOtxtHzmFcc8CjORyLl8jcMmSQ
         TN7A==
X-Gm-Message-State: AOAM530JUiO5JwdzrVFdGR/RYFR6wDXQ2tNsMZabse8iLkX4Qx5qxQul
        PK8G1fWeBwg9+9Ro+Gm9UY8ZvSIFEbwKf6S2Ty3Q9xOl7PSIbbjtRqKRkiwy3v/xbAl55YkMnmM
        ZLkSgPPEb4Qxt+FhwvC5XrAA=
X-Received: by 2002:a5d:6da5:0:b0:1f1:f958:46fa with SMTP id u5-20020a5d6da5000000b001f1f95846famr3779335wrs.622.1646675127768;
        Mon, 07 Mar 2022 09:45:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyurCUYY5LH3jUmskIlDdoG/6dvqHZRp3se93Jg9nMuP2WZ6gFN7P0Tmj3tMmD4UkWNrBoMDg==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f958:46fa with SMTP id u5-20020a5d6da5000000b001f1f95846famr3779309wrs.622.1646675127527;
        Mon, 07 Mar 2022 09:45:27 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b00387369f380bsm14921267wmq.41.2022.03.07.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:45:26 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 08/14] module: Move kmemleak support to a separate file
Date:   Mon,  7 Mar 2022 17:45:03 +0000
Message-Id: <20220307174509.2887714-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kmemleak code out of core module
code into kernel/module/debug_kmemleak.c

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile         |  1 +
 kernel/module/debug_kmemleak.c | 30 ++++++++++++++++++++++++++++++
 kernel/module/internal.h       |  7 +++++++
 kernel/module/main.c           | 27 ---------------------------
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 kernel/module/debug_kmemleak.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index d313c8472cb3..12388627725c 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
+obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
new file mode 100644
index 000000000000..12a569d361e8
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
+			  const struct load_info *info)
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
index d6f646a5da41..b0c360839f63 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -167,3 +167,10 @@ static inline int module_sig_check(struct load_info *info, int flags)
 	return 0;
 }
 #endif /* !CONFIG_MODULE_SIG */
+
+#ifdef CONFIG_DEBUG_KMEMLEAK
+void kmemleak_load_module(const struct module *mod, const struct load_info *info);
+#else /* !CONFIG_DEBUG_KMEMLEAK */
+static inline void kmemleak_load_module(const struct module *mod,
+					const struct load_info *info) { }
+#endif /* CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c63e10c61694..7dd283959c5c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2519,33 +2519,6 @@ bool __weak module_exit_section(const char *name)
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

