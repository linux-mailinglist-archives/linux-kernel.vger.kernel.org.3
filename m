Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C462A4CCB85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiCDCEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiCDCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:04:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4413DE0F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:04:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b8so6177324pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CR9vVQihO0qFKWqSweZPx72Hjt/E+k2ox1hfnK+ogp0=;
        b=cgLPjke7bu5oyIi7lbn+OjmutdOS1VUnCwZ5gwH7XEBiQ0GdlEzLV8/QrxzQj8CEbe
         nZg5qbsJwb2glpdX6QV6/E1IGrvM+y1Z+vr64WVuTPsFeqGTa+pl5h7qlbfoj1k3vKGN
         GuvbiHfBEAhpA/1MaTEzg22PCVY3QQKZfFCWpcqa1azcMOCT38ovDEEuVeUk6/bqZ2nP
         fDJaBcjReCZ3j4mGpN0ksN2++V9Vcx1XYWBJ65CCTgxJCEV3uKHnFBcfNY3cigqXYg/K
         qUFouNu/+XbAxygUYsUPdq4eBbs8zMO+5VjXfZILsweupRMJGZsq4Klw7j8Rwng7IkK4
         Egxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CR9vVQihO0qFKWqSweZPx72Hjt/E+k2ox1hfnK+ogp0=;
        b=Ph2RyZ8CG7rnFYVc6tPx8IOJN7tYgA8Dezep2HciU/mS8ERQuERp81mtzXZG3Crfsk
         tpzbvKFAL+zgwdiGbvz00hg2O3ooCfLr/dzVOpXGCvPIDy8+jh4LXTzttAYhZlPwa2J9
         eh7tkEUvG7uFBDMe4SaztXMXbYnp5b/rrnq+dLLMkis4FLMDRLEWgRzH7o7pZ7KI+txZ
         OezUpcfH8aToobtxVWFCqLUCa6oooQCf4rh3MV7YcTmJKZzM+6aqDmi5cY0aBF2uGgAC
         9Tzyb5zqWFtcF1WYxcfODEH8qHN+7hzAFOZXktKDz03vQkcY/9HFFXc+ckc+fOG7cfFZ
         Ydnw==
X-Gm-Message-State: AOAM5326+YHPG7jiCcgo9O2J/lZDlTdo5iFQeLBYEhzTKO0sucQH8NIa
        TNUPL6xOv7GwXkraO+/mfgY=
X-Google-Smtp-Source: ABdhPJxgfLEyWYjWENib2qUy9Pi2Gp1sRCl5X5eLYmJEdlFUtiREskTMqGyie1xArvk1epTlPb1uYA==
X-Received: by 2002:a17:903:2285:b0:151:ae75:21c6 with SMTP id b5-20020a170903228500b00151ae7521c6mr4400927plh.32.1646359445426;
        Thu, 03 Mar 2022 18:04:05 -0800 (PST)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id 67-20020a630846000000b00372782a65d0sm3337201pgi.60.2022.03.03.18.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 18:04:04 -0800 (PST)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Coiby Xu <coxu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RESEND PATCH v3 2/3] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Fri,  4 Mar 2022 10:03:40 +0800
Message-Id: <20220304020341.85583-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304020341.85583-1-coiby.xu@gmail.com>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coiby Xu <coxu@redhat.com>

The code in bzImage64_verify_sig could make use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
signed kernel image as PE file. Make it generic so both x86_64 and arm64 can
use it.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 13 +------------
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f73aab3fde33 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
+	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 755fed183224..2fe39e946988 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
@@ -196,6 +197,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel,
+				    unsigned long kernel_len);
+#endif
+#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3720435807eb..754885b96aab 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -165,6 +165,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
+#endif
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 		unsigned long buf_len)
 {
-- 
2.34.1

