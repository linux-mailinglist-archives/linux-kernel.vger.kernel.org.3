Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57E4E400E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiCVOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiCVOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E3E32069
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apZpBB6s8ANx6PnqHZt1W7YrWPlcLByEn5Sm08WSqaI=;
        b=bjbkFsDR7bUD9GdLVFwnsHSQH59omASDTPgt3K2cx5gD7pW0AznkhAwlWMkvtlJad8/ekS
        kGCCk5u3qhX3tmM/SHGpA1GKf6HF7q7KokGhwCEC3TeJqlrbBMMGS7RKMZFaA5dSgzlQwC
        w/aNMdOtyAN1ckttHexPtrpF+QhAsBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-LWJWK6FZMO6DJ4lUNOqr-g-1; Tue, 22 Mar 2022 10:04:08 -0400
X-MC-Unique: LWJWK6FZMO6DJ4lUNOqr-g-1
Received: by mail-wm1-f70.google.com with SMTP id i65-20020a1c3b44000000b00385c3f3defaso5320489wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apZpBB6s8ANx6PnqHZt1W7YrWPlcLByEn5Sm08WSqaI=;
        b=Y7rQqUzT9NdQt4qlXyCr0C6Hw1xaprkPQKSvi6pG5MT0kMBXT+dA+0MyqO4nVULd53
         ybpGsLef0pJyvARYSNtA7wK8wAuANKngTjGb+mijyu0qHcLfRQgXD6UUVTtecDa9mOJl
         gqKzr7SpSxzoKC5BORwWHGX0a/Pz2GYdJ1TYdel48b+tu/GQtHK8JFuInTdjnkXQhEmP
         RDW+9lb/yKEehX3l3C1Y71OC54eS6DQp6ercntusu/dA4fVRbIf3utFQECnUfjH7+i5h
         R5d9BB+YQy4gHvlD01/LDq+YbpxmIAPGJtYedq3OdZ7VRSQPQx14zPrlT8diRHEGXnZS
         mW8w==
X-Gm-Message-State: AOAM532lJAU4IusI6HJMlGJ9ssELw9zn5y6MjM58KLNDIAhyJpFhafqD
        4L2iirIX/kDSuzEwauKk833OssLMoBbe1kKiiRhnhOn3E79SLlNHW51o50t0KCwnVvslgaf16nn
        SM4ga3X00SuBIjSEUGKR5Gd0=
X-Received: by 2002:a05:6000:2a4:b0:204:f41:13da with SMTP id l4-20020a05600002a400b002040f4113damr9252190wry.0.1647957847403;
        Tue, 22 Mar 2022 07:04:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxahke39ZUROCVLF/rzLvxu2Ear3P6xkA/JewZB4CYF+uda5as3TbSK2DO4keVTToymYmZ7tg==
X-Received: by 2002:a05:6000:2a4:b0:204:f41:13da with SMTP id l4-20020a05600002a400b002040f4113damr9252143wry.0.1647957847088;
        Tue, 22 Mar 2022 07:04:07 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm1373745wrt.115.2022.03.22.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:04:06 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 07/14] module: Move extra signature support out of core code
Date:   Tue, 22 Mar 2022 14:03:37 +0000
Message-Id: <20220322140344.556474-8-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates additional module signature check
code from core module code into kernel/module/signing.c.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h   | 12 +++---
 kernel/module/internal.h |  9 +++++
 kernel/module/main.c     | 87 ----------------------------------------
 kernel/module/signing.c  | 77 +++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 92 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ec9715de7dc..5e2059f3afc7 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -672,7 +672,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
 
 #else /* !CONFIG_MODULES... */
@@ -799,10 +798,6 @@ static inline bool module_requested_async_probing(struct module *module)
 	return false;
 }
 
-static inline bool is_module_sig_enforced(void)
-{
-	return false;
-}
 
 static inline void set_module_sig_enforced(void)
 {
@@ -854,11 +849,18 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #endif
 
 #ifdef CONFIG_MODULE_SIG
+bool is_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
 }
 #else	/* !CONFIG_MODULE_SIG */
+static inline bool is_module_sig_enforced(void)
+{
+	return false;
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index a6895bb5598a..d6f646a5da41 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -158,3 +158,12 @@ static inline int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	return 0;
 }
 #endif /* CONFIG_STRICT_MODULE_RWX */
+
+#ifdef CONFIG_MODULE_SIG
+int module_sig_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_SIG */
+static inline int module_sig_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5cd63f14b1ef..c63e10c61694 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -23,7 +23,6 @@
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
 #include <linux/proc_fs.h>
-#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -127,28 +126,6 @@ static void module_assert_mutex_or_preempt(void)
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
@@ -2569,70 +2546,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
-static int module_sig_check(struct load_info *info, int flags)
-{
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
-	const char *reason;
-	const void *mod = info->hdr;
-	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
-				       MODULE_INIT_IGNORE_VERMAGIC);
-	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
-	 */
-	if (!mangled_module &&
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
 #if defined(CONFIG_64BIT)
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 8aeb6d2ee94b..85c8999dfecf 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -11,9 +11,29 @@
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
+#include <linux/security.h>
 #include <crypto/public_key.h>
+#include <uapi/linux/module.h>
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
@@ -43,3 +63,60 @@ int mod_verify_sig(const void *mod, struct load_info *info)
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
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
+	/*
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
+	 */
+	if (!mangled_module &&
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
2.34.1

