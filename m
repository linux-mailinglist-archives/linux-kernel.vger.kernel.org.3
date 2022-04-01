Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767234EE5B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiDABdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiDABdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711881EC63B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648776691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVmPCPO0oF3pRYu+F7qpHdcQzaq88pJ0kcN8pmyvV4M=;
        b=D+LSA6SEubz6jrEXxyxhlxgA0vSOLveHLHyYHkJjaMb2VX6I/wOaIEixfS9NUNfBYOB+IZ
        FnAE9Q9HwzcKN3aOc3+5aKc42X8WHnKsiuID4gxJXVaDV3+xxi0zVkaViJmx+W8WM5lVTx
        gN8FQun4vVPIBYDv1/c0qKGFkgDspXM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-DNJHqsv9OAmkOx7bStQSYg-1; Thu, 31 Mar 2022 21:31:29 -0400
X-MC-Unique: DNJHqsv9OAmkOx7bStQSYg-1
Received: by mail-pj1-f70.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so2815587pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVmPCPO0oF3pRYu+F7qpHdcQzaq88pJ0kcN8pmyvV4M=;
        b=KXGaOH5zHvllRU/82zrhYHInKAXtOv+nPAzaZYt4e4Bg1/aUWV+GMcZ6MtnPJYHqE/
         Nxk+3yIDgv+Wj2c3O5QjqO8WBPDdY06qNdwDL3CKSCZ4M+UMsiiDzJBgtzzAg8tn87L3
         f8f+sBvZ5FzuS18uaWSXewHWHFPiHLN9qoG52yWNCbaglUeAIEODoKaFmRd820yqW5g7
         VmXIYx9XeRd3xVn4f3kvlzL6rhQsC8zOJuJhJOk/W1vs7HXghmlAnJqlBLeZEjtqmv4b
         roBgUurVvf9lPo6W/5AIreKwLBDpvp/NAFRdkQSkoQ98QZ8vvpEDWdYrkizrTV3MzzXr
         sGog==
X-Gm-Message-State: AOAM533yPMZFqVb45a/XNNKd4eIk1kYBudqqEU0fhZfiIMqz2waXockz
        cKTjtCazWE5HTo25Dn9wP/A+7oAuEtzPTC/ZI+0dbqmKVIeD4MZkvkDDjOUbn3bo/wiylSXhGWX
        Ms27y3gLQ+dXRglZ7b5tCFJ92
X-Received: by 2002:a17:903:20cc:b0:154:8c7f:1ed3 with SMTP id i12-20020a17090320cc00b001548c7f1ed3mr7854398plb.131.1648776688284;
        Thu, 31 Mar 2022 18:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk8pGREHFgs4EKOdX9WUE7Kapxs8ssHrqs3uFxMkIE8BiXg/yu0dkJv+gF0OWTAflQuu0kcg==
X-Received: by 2002:a17:903:20cc:b0:154:8c7f:1ed3 with SMTP id i12-20020a17090320cc00b001548c7f1ed3mr7854375plb.131.1648776688014;
        Thu, 31 Mar 2022 18:31:28 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm759358pfh.59.2022.03.31.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 18:31:27 -0700 (PDT)
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
Subject: [PATCH v5 2/3] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Fri,  1 Apr 2022 09:31:17 +0800
Message-Id: <20220401013118.348084-3-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401013118.348084-1-coxu@redhat.com>
References: <20220401013118.348084-1-coxu@redhat.com>
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

