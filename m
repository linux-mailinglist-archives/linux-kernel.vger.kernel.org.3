Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B4486DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiAFXnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245716AbiAFXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCGQaji14i2F94mV0DWpkRKJAs6KEBhnNJRRFLq3kec=;
        b=OUIPloov7DBXVoL0wecHN3PdmhFI1qvwVakZ/Q3B3JDwqHElxMHbwUmMZaOkjHRT7bfWGO
        EEHAAQ4FxaYbk1GTmzBZb46vVbs+bo9ZXAI/rXTC3+jSPKJTHyn+KqSWHQT2VH1zGVxv9a
        KhBHSSp9Wtv3cjTG0EKP94sS4exejOc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-eSTsUjGXNQanrNe7bUOy5w-1; Thu, 06 Jan 2022 18:43:29 -0500
X-MC-Unique: eSTsUjGXNQanrNe7bUOy5w-1
Received: by mail-wm1-f72.google.com with SMTP id n14-20020a05600c3b8e00b0034693893555so624740wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCGQaji14i2F94mV0DWpkRKJAs6KEBhnNJRRFLq3kec=;
        b=5PdlCpBpV5vJonNVYvp+H78N2g7sPsKevz0SkzdjCqzrhec/TjUh07Kausvt0FT0WX
         W8K1/7jDuPbOnByJo3VblPZ1z99sKXukp0/DvOU+cKjBN9ubEmQKPs2rP4ajPFNqS3b1
         DABrwEiSfKKkmQ9wzPaXfXQcWf/whfYQ0bONkrJW0HLXMcT8Ww4LWuoW0ZU4hy/d9Dn6
         N+pnq9EdcrCsAteZ9Aa9FEmKpeby2w9af4yc78TeQ4rgCKwdpPDA95emdVMKqfb4Arx5
         tbXRzbiy+g9tY2IWqp1oXLV3NDF4tu3APtb4FPPrOAp1hcutfKiGetc3l2wEhTgIitJu
         eH8A==
X-Gm-Message-State: AOAM5309diVTVtGYZygzq5PdFhe5EHEsI35xVjfsehZHDLYLveh741rW
        quWxTL2KqLtPnbY6DjqCLO5azL4eLiBCOWcjEykG+ZS85Tu4IGf0WVanwx752wkrCIh+u/AY3bl
        p5lTaG2HR+6cm1zaY+rAaHpA=
X-Received: by 2002:a5d:6f11:: with SMTP id ay17mr14858179wrb.662.1641512608275;
        Thu, 06 Jan 2022 15:43:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA4y/2KQTMM+c6WywYryhpbnWsxkIUVDdI6DSoEVL948RrCr73yqG7vfM3NoMTgwDbY/bJ5w==
X-Received: by 2002:a5d:6f11:: with SMTP id ay17mr14858171wrb.662.1641512608103;
        Thu, 06 Jan 2022 15:43:28 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g5sm3761050wrd.100.2022.01.06.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:27 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 07/13] module: Move extra signature support out of core code
Date:   Thu,  6 Jan 2022 23:43:13 +0000
Message-Id: <20220106234319.2067842-8-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates additional module signature check
code from core module code into kernel/module/signing.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h   |  5 ++-
 kernel/module/internal.h |  9 +++++
 kernel/module/main.c     | 86 ----------------------------------------
 kernel/module/signing.c  | 75 +++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 88 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 218ac6768433..3383912268af 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -736,8 +736,8 @@ static inline bool is_livepatch_module(struct module *mod)
 }
 #endif /* CONFIG_LIVEPATCH */
 
-bool is_module_sig_enforced(void);
-void set_module_sig_enforced(void);
+extern bool is_module_sig_enforced(void);
+extern void set_module_sig_enforced(void);
 
 #else /* !CONFIG_MODULES... */
 
@@ -927,6 +927,7 @@ static inline bool module_sig_ok(struct module *module)
 {
 	return true;
 }
+#define sig_enforce false
 #endif	/* CONFIG_MODULE_SIG */
 
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 91ef152aeffb..b4db57bafcd3 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -63,3 +63,12 @@ static inline int copy_module_elf(struct module *mod, struct load_info *info)
 }
 static inline void free_module_elf(struct module *mod) { }
 #endif /* CONFIG_LIVEPATCH */
+
+#ifdef CONFIG_MODULE_SIG
+extern int module_sig_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_SIG */
+static int module_sig_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c404d00f7958..8f8a904d5ba7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -22,7 +22,6 @@
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
 #include <linux/proc_fs.h>
-#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -114,28 +113,6 @@ static void module_assert_mutex_or_preempt(void)
 #endif
 }
 
-#ifdef CONFIG_MODULE_SIG
-static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-module_param(sig_enforce, bool_enable_only, 0644);
-
-void set_module_sig_enforced(void)
-{
-	sig_enforce = true;
-}
-#else
-#define sig_enforce false
-#endif
-
-/*
- * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
- * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
- */
-bool is_module_sig_enforced(void)
-{
-	return sig_enforce;
-}
-EXPORT_SYMBOL(is_module_sig_enforced);
-
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
@@ -2517,69 +2494,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
-{
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
-	const char *reason;
-	const void *mod = info->hdr;
-
-	/*
-	 * Require flags == 0, as a module with version information
-	 * removed is no longer the module that was signed
-	 */
-	if (flags == 0 &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
-		err = mod_verify_sig(mod, info);
-		if (!err) {
-			info->sig_ok = true;
-			return 0;
-		}
-	}
-
-	/*
-	 * We don't permit modules to be loaded into the trusted kernels
-	 * without a valid signature on them, but if we're not enforcing,
-	 * certain errors are non-fatal.
-	 */
-	switch (err) {
-	case -ENODATA:
-		reason = "unsigned module";
-		break;
-	case -ENOPKG:
-		reason = "module with unsupported crypto";
-		break;
-	case -ENOKEY:
-		reason = "module with unavailable key";
-		break;
-
-	default:
-		/*
-		 * All other errors are fatal, including lack of memory,
-		 * unparseable signatures, and signature check failures --
-		 * even if signatures aren't required.
-		 */
-		return err;
-	}
-
-	if (is_module_sig_enforced()) {
-		pr_notice("Loading of %s is rejected\n", reason);
-		return -EKEYREJECTED;
-	}
-
-	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
-}
-#else /* !CONFIG_MODULE_SIG */
-static int module_sig_check(struct load_info *info, int flags)
-{
-	return 0;
-}
-#endif /* !CONFIG_MODULE_SIG */
-
 static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
 {
 	unsigned long secend;
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 8aeb6d2ee94b..ff41541e982a 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -11,9 +11,28 @@
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
+#include <linux/security.h>
 #include <crypto/public_key.h>
 #include "internal.h"
 
+static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
+module_param(sig_enforce, bool_enable_only, 0644);
+
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
+void set_module_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+
 /*
  * Verify the signature on a module.
  */
@@ -43,3 +62,59 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
+
+int module_sig_check(struct load_info *info, int flags)
+{
+	int err = -ENODATA;
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
+	const void *mod = info->hdr;
+
+	/*
+	 * Require flags == 0, as a module with version information
+	 * removed is no longer the module that was signed
+	 */
+	if (flags == 0 &&
+	    info->len > markerlen &&
+	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+		/* We truncate the module to discard the signature */
+		info->len -= markerlen;
+		err = mod_verify_sig(mod, info);
+		if (!err) {
+			info->sig_ok = true;
+			return 0;
+		}
+	}
+
+	/*
+	 * We don't permit modules to be loaded into the trusted kernels
+	 * without a valid signature on them, but if we're not enforcing,
+	 * certain errors are non-fatal.
+	 */
+	switch (err) {
+	case -ENODATA:
+		reason = "unsigned module";
+		break;
+	case -ENOPKG:
+		reason = "module with unsupported crypto";
+		break;
+	case -ENOKEY:
+		reason = "module with unavailable key";
+		break;
+
+	default:
+		/*
+		 * All other errors are fatal, including lack of memory,
+		 * unparseable signatures, and signature check failures --
+		 * even if signatures aren't required.
+		 */
+		return err;
+	}
+
+	if (is_module_sig_enforced()) {
+		pr_notice("Loading of %s is rejected\n", reason);
+		return -EKEYREJECTED;
+	}
+
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+}
-- 
2.31.1

