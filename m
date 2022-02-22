Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C54BFA94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiBVOOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiBVONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDBF4BB091
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cGhl6nHTPV8hs9/Da1/aRnlyvdgWqihboGstnvGLgA=;
        b=DfGqaj8NB5ZGSKKiIznv7BlRUHHev+BNbBl93flJs4zDchmTsHI4vsmmBS92BDk1OhrC+M
        8bqxWR3q2CRafQ4uDj1am11KrMWlIHCZtA3XppL2m38SxPDx9PzIcpJeZ1zo9pAM0Jh7Sy
        cUMJL2cTvNnMZxBaCAFGs3SLouI6SsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-0p2npxfkN16UVKKTjCoyIQ-1; Tue, 22 Feb 2022 09:13:14 -0500
X-MC-Unique: 0p2npxfkN16UVKKTjCoyIQ-1
Received: by mail-wm1-f70.google.com with SMTP id k30-20020a05600c1c9e00b0037d1bee4847so896812wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cGhl6nHTPV8hs9/Da1/aRnlyvdgWqihboGstnvGLgA=;
        b=ckMgwFGMEcmc93cgzLyYCZPoI8KZKyhFeu+QHCvPOgS6g7tyNKuqJogoi/mXQmbTXQ
         JeqcBwiNxXjgwPKlzueiOr2QmqQOmHZwstroBU9/h63vR/PkQsM8hyd73rhzydVxveRC
         mn8gLAsj/UwsxhEz6gbmCw/RyhfQ6KCPNFO8KmUKS+mKGgTJ4WpO27R3CxwCsZp47sBE
         ewT+nURqbucLUnLJJS9AWTEgRaILyhh6cW//j51LzGfYwXf04vpeago1AYIOsjfiHKYZ
         sJYT2uND8rOfKfdmc4A6pENK//Z0QodXckQEOR9oricCAZJ+bJ23bV/VASR2JmsXx/wj
         /j5w==
X-Gm-Message-State: AOAM533HXPGPieRnJKlkedTnDXZtaeMGE1e4ok5nIwMYF7n/0kqpS5yY
        5UONzh4WdJsbNNY2eMfHiQAZWUp7uR9Eef7dcW3felqazhTgtMVBW2iv2/5KiElIX4rwWVdEVq8
        Gii1T3dOiM16V2zVdVlfnGbE=
X-Received: by 2002:a5d:5902:0:b0:1ea:9aa1:6ad9 with SMTP id v2-20020a5d5902000000b001ea9aa16ad9mr1796035wrd.465.1645539193573;
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2BohY/gOv3fFwa+dKYMHi6Y6pPHAFj7n60L1VBjpT1/4K/yK8ZWfOwkYYQx3owW4Ajn69Gg==
X-Received: by 2002:a5d:5902:0:b0:1ea:9aa1:6ad9 with SMTP id v2-20020a5d5902000000b001ea9aa16ad9mr1796024wrd.465.1645539193364;
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o8sm2416515wmc.46.2022.02.22.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:13 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 08/13] module: Move kmemleak support to a separate file
Date:   Tue, 22 Feb 2022 14:12:58 +0000
Message-Id: <20220222141303.1392190-9-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
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

