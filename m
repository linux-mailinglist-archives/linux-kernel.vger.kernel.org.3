Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E44CCB84
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiCDCEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiCDCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:04:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493A13D90D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:03:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bd1so6432201plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 18:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR7366Di99yTyHJIbovR9LHqPQL69gNs/+RxpOoEfdQ=;
        b=VJLlau3KSmcs7NGnpO9zSiLmHToeEVv2U1Y3zyv87tdjdXEwmoBehutpwwHFEQImR3
         KYdPhwq3nbwlqbVynWP+9T00kskMgoKgW37M1jva2kQnpkqD6ZX54qve/Ajfn6fKxh1g
         3Xh8w305m+aD5E8ZLQvcs7El6f0EhomMrBhVWjSfIIeBl5ONM97vaQKWYn0U/BSk4fae
         lmTUiI2L5kJOUsjW8xaZEX+Be2LEGARI8C0wgCBvqnwfLo9ee5m+SJ9crFJf7OfyHgXg
         CtO9uYYTKorZC3Dhbhn6nsxDNf4Zw/BB3m+EUcy2Jx32lKx2JgDIYD59sr/G7CnqN8KH
         hxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR7366Di99yTyHJIbovR9LHqPQL69gNs/+RxpOoEfdQ=;
        b=DqbFykJpXbTYKM0XYESOirDBmvQJ+lThpLU1hrjXdLb7PfoUryUmbwn1BTALI807yH
         RuwZ1HL3lIg4ULtO4hz2s1RtKroVIbUxMqss/vvFR2q96z5ohN9t5xOBupz64OCJDZXW
         d+G71PK14HnI/Yj90JzZPFIWiVRxsNM+hcPhZ8p3gQaQjc0RIJL8O3lFEp8DwiCTu6TK
         OMhI0n5HSZdiE261EmPg4432zpb1pzt5ZnAaxECaCOwzCV+9gry9BFKTuVZ0ZAq7fu4t
         h1qI0K7lG1ZSketuFgAr89t11HR0TUE2wXCquXJp5JHBu6YWSYivIVHsBovjGFcrRUJi
         W4Ww==
X-Gm-Message-State: AOAM530A8F0bA7KkX21lzLM9DuOCXyULJs8TiWAQoZC766R/yzJWCxSR
        qk1KcsQH2JTamB3ULJMg098=
X-Google-Smtp-Source: ABdhPJxB1g/JhYbgFUWmoGCqe3SF0cDhpB9lBeq/c6KeGJIUqMZpsqvOww4gzLEBClJulGZxFOU/rA==
X-Received: by 2002:a17:90a:eb07:b0:1be:f354:940a with SMTP id j7-20020a17090aeb0700b001bef354940amr8283349pjz.43.1646359437290;
        Thu, 03 Mar 2022 18:03:57 -0800 (PST)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id bh6-20020a056a00308600b004f6aa0367f6sm1162719pfb.118.2022.03.03.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 18:03:56 -0800 (PST)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Coiby Xu <coxu@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Fri,  4 Mar 2022 10:03:39 +0800
Message-Id: <20220304020341.85583-2-coiby.xu@gmail.com>
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

commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
powerpc: factor out kexec_file_ops functions" allows implementing
the arch-specific implementation of kernel image verification
in kexec_file_ops->verify_sig. Currently, there is no arch-specific
implementation of arch_kexec_kernel_verify_sig. So clean it up.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..755fed183224 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
 				 const Elf_Shdr *relsec,
 				 const Elf_Shdr *symtab);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..3720435807eb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_SIG
-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
-					  unsigned long buf_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.\n");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(buf, buf_len);
-}
-
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
  * @pi:		Purgatory to be relocated.
@@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+		unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 static int
 kimage_validate_signature(struct kimage *image)
 {
 	int ret;
 
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+	ret = kexec_image_verify_sig(image, image->kernel_buf,
+			image->kernel_buf_len);
 	if (ret) {
 
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-- 
2.34.1

