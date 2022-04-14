Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AD5003BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiDNBqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiDNBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 383DB26AD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd6dGinkDQ+ERZGbhh7LGheOUAL1/G4cOFfIvwcXv0w=;
        b=dTEzowO5OaqYgya+4W4JUKF/RuEc7+0BirzYCHGSe8ItI0amE1WYbfLRAORDXfJy/a+uP+
        ONxwbqpX0fQbl0QTQYhGZX8nN2BW11opd0YfE+DAu26Z+sJD1nfDn26mdHJ6vugswlLcQU
        ZKrzzdK0W35ziFtHbKx/ivV4t+uZhRs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-a2c9l02ZOBilK1SiZrzNSg-1; Wed, 13 Apr 2022 21:44:12 -0400
X-MC-Unique: a2c9l02ZOBilK1SiZrzNSg-1
Received: by mail-pj1-f70.google.com with SMTP id l10-20020a17090a72ca00b001cd46918af5so2234738pjk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd6dGinkDQ+ERZGbhh7LGheOUAL1/G4cOFfIvwcXv0w=;
        b=In1OEPsyeCXrcOfvz1H0Ahtta/Fud1TEwvUyO48OoGVh62LY4SrbmMXaZAJkhVh5ls
         Lhc5b/2Mn1xY/GbpcisMoIfi590jjpsINxPPjAcHWkbDyjCjzze9xXhbJBNNasUSof2M
         qNGyEuCsJH1ltNjKLoBnh1k3R5R09zjExc89uUFHLxVOuJESymZFeI4EBGi7tiZJNrDQ
         D9WEzv47INy3IUiX9NN+8RVi++deQzLFJAjCJRXUBjdN6ZwiFPDiK52cuCPxDWnk14VC
         +hwpQt8A8/Uj7r+rZtlzGakJVdMG9vOdDJkRTw1rt+a1T0tBoQ8YTvvh/lYBiGsIA+O8
         4idA==
X-Gm-Message-State: AOAM531pgbzgFMiZKrAPuBq0v3K0PX4997213wfK8oGAR4fLfl5yur5Y
        nQD8D63/I7H3n7SIIrE7uoq2m5JnT/ZNOo+Ks3riQ/Qke2uas+5dohEiEw+xEsC6dttyTDpMN1/
        F2EnsSo941sUG8ypeMX8Z8zbI
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr44981240plh.0.1649900651073;
        Wed, 13 Apr 2022 18:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSgcCqZWhETgn3SMmtU4LkqvxAQAdH4WIMasH4oGV8IV/wkQ4upyzvRDsL1mE0nxbO0jb+sg==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr44981222plh.0.1649900650830;
        Wed, 13 Apr 2022 18:44:10 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090aa58c00b001ca977b49d5sm295456pjq.31.2022.04.13.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:10 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Kairui Song <kasong@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v6 2/4] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Thu, 14 Apr 2022 09:43:42 +0800
Message-Id: <20220414014344.228523-3-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig makes use of system keyrings including
.buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
verify signed kernel image as PE file. Make it generic so both x86_64
and arm64 can use it.

Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f299b48f9c9f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
-{
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
-}
-#endif
-
 const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-	.verify_sig = bzImage64_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 413235c6c797..da83abfc628b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 /* Location of a reserved region to hold the crash kernel.
  */
@@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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

