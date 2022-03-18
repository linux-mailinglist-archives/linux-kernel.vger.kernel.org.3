Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C24DD73D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiCRJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiCRJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F00A32C3DF4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVmPCPO0oF3pRYu+F7qpHdcQzaq88pJ0kcN8pmyvV4M=;
        b=DoLhZS2U4BOaZ4skAFkMZSLh3lsR0hZOL7YxI/tMY1fiS/KJq3XmkuWkgUt/4yCtBK9o3Q
        SWN/Ki6oCsqOjpiT0A9wZ9cwss10TS3X14RcWkdC5aOf0CT2rMQEOz9tW+u18FjKHsT8Ct
        8l7FEkCPAim/WZjZyE0UGu7OAjhmei0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-2T_SQsKMOzCIgvePib-fBQ-1; Fri, 18 Mar 2022 05:41:12 -0400
X-MC-Unique: 2T_SQsKMOzCIgvePib-fBQ-1
Received: by mail-pj1-f70.google.com with SMTP id j10-20020a17090a7e8a00b001bbef243093so8099364pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVmPCPO0oF3pRYu+F7qpHdcQzaq88pJ0kcN8pmyvV4M=;
        b=5fR9x9Jr8Jz8/ovRsYW8aFgb7zY7K5YFLjgUTb02VTCkdggRn7KOvwELWxlev0Ff40
         lW5B6trtlFi12qCeE8JRBTk7/V8mbOGVqUC/bpqaRPEN3gDQf+se6Wm9FBK4YqWcLlmk
         5o4PUjWWYAvkIT3TivFRi3F4BcjWrr7ObH4b12W7YtJm0HXPxfzqtFJxjvbnUn9J8Dje
         GefDeGJRnm7Ocew71QKC5OAWwu15lnVBTQy0RqVuPSba5fJ7BrcaqXaxNfOLjXeaVyao
         vOzzSk/jPiiEI4srBRcGom2Rc3IwtXOUDebxQcF0WtDbYFOs/WDeJhcWWW6/oXt5K6Wk
         /f2w==
X-Gm-Message-State: AOAM530Qo6VCvOfcZI3qRfWUDOfyqVFdn3O+F1VfBvX8WiwWCy3E+t5e
        lh/7X6yR+KSaar/rqSnzs/YbbnIwz1Zfe0ajbvAjKWv8AeV8lG0Y39GH2aQX7ndLEi6s3wlI5p2
        XLky1mTU4MDkqmyM+34AjwKQl
X-Received: by 2002:a63:ab47:0:b0:375:5d05:9f79 with SMTP id k7-20020a63ab47000000b003755d059f79mr7232000pgp.192.1647596471696;
        Fri, 18 Mar 2022 02:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC67EGQnlUHMa8v+f0Jvrco6hTVeignBbFV846ZQZwUN1ugwR1tKrHp9uyTiLPMVPVkFvsXA==
X-Received: by 2002:a63:ab47:0:b0:375:5d05:9f79 with SMTP id k7-20020a63ab47000000b003755d059f79mr7231986pgp.192.1647596471470;
        Fri, 18 Mar 2022 02:41:11 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id q16-20020a056a00151000b004f7cdeddfffsm9107299pfu.115.2022.03.18.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:41:10 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v4 2/3] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Fri, 18 Mar 2022 17:41:00 +0800
Message-Id: <20220318094101.274950-3-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318094101.274950-1-coxu@redhat.com>
References: <20220318094101.274950-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in bzImage64_verify_sig could make use of system keyrings
including .buitin_trusted_keys, .secondary_trusted_keys and .platform
keyring to verify signed kernel image as PE file. Make it generic so
both x86_64 and arm64 can use it.

Signed-off-by: Coiby Xu <coxu@redhat.com>
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

