Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467CF564B50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiGDBwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiGDBwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 734092AC1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTUj8DskjrdqH+782mh4voi0bsQ4nV3nMCPn/39C26o=;
        b=SYFFNlMJ+4FVnIf6CHit9KPxA9Nh8YOfGTaR61/CivRuanH0pMosWU/Bme0cuqGFVHHHnw
        zEJaUrkVrmiGcSsd72qMJ0XfoYCJmhLMuO4qgYEGyZPbsJxXOCmO+S43VyxhkZbwz4r6y7
        DGAFwD31XXuzz79O8lw5TTbw6hRM5dI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-tA3Edq3JPJ69rXE8rysDyA-1; Sun, 03 Jul 2022 21:52:38 -0400
X-MC-Unique: tA3Edq3JPJ69rXE8rysDyA-1
Received: by mail-pj1-f72.google.com with SMTP id lt7-20020a17090b354700b001ec8364bed0so4542116pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTUj8DskjrdqH+782mh4voi0bsQ4nV3nMCPn/39C26o=;
        b=IoYWHy1mZWLKy3gJnSd1RZKqGEHYgTYC4nKg5DQcXIUrhkgGHVIqMdPpBf/wJ9ocNb
         hktVYF8eL5S1kPJEQQTyoe4l78wDKru8FpybtZuyAHVBTxkrtLtbXIn/oM6+fhDdzGc+
         6KHTPCwC55dcRi/bttk/e7RmpafKq90F/1DUEI6cpwZ85uDZMBuLGMukjpNUd7iVVjIE
         /37r0LQ+EVW4bMnkP0Moe+bx3zbl/Cxo/NVeQv+mlGaYZ+nriIegqTWkTkVLfYxPvPn/
         dY3Yum2XUS1NL1lq6hTFpVjyZ+Ey1D5D4TJhHaoHslgDKiwAmOPLo+4MLAsKEs/uW6rO
         kL0w==
X-Gm-Message-State: AJIora9Ppy2cN5KY5NilG8f/og2O3pi/03qDQ+494faISS9UMj83XJQp
        jcWls9Ikgd8ymz5Js/2aH6n76aQeNoadTV8RFihXtjDP5JjuA1XCBjldT+yh5jj9Z/0gBdcUSTu
        WMPJjRgeGqdEeUnG9eZhM6w0L
X-Received: by 2002:a05:6a00:14d3:b0:528:486d:d576 with SMTP id w19-20020a056a0014d300b00528486dd576mr10568893pfu.24.1656899556863;
        Sun, 03 Jul 2022 18:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPC0DInjaucHaeeAE1l8WghG5rlTMFBew3zvn/xHz/06n1jLEOyrEMAmRej9+XCnhiWSv1dg==
X-Received: by 2002:a05:6a00:14d3:b0:528:486d:d576 with SMTP id w19-20020a056a0014d300b00528486dd576mr10568874pfu.24.1656899556610;
        Sun, 03 Jul 2022 18:52:36 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090332cd00b0016b7c557e08sm11927704plr.56.2022.07.03.18.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:36 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v9 2/4] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Mon,  4 Jul 2022 09:51:59 +0800
Message-Id: <20220704015201.59744-3-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig uses the keys on the
.builtin_trusted_keys, .machine, if configured and enabled,
.secondary_trusted_keys, also if configured, and .platform keyrings
to verify the signed kernel image as PE file.

Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
 include/linux/kexec.h             |  6 ++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 24 insertions(+), 19 deletions(-)

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
index e3125fae1599..620018bbc419 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 /* Location of a reserved region to hold the crash kernel.
  */
@@ -194,6 +195,11 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
 void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
+#endif
+#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c7cbadc754a1..db6e89128b98 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -131,6 +131,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
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
2.35.3

