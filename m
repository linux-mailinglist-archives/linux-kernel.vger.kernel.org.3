Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA533524650
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350647AbiELHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350645AbiELHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879FC3F88D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652338891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCJO+RNZFCWFbvical/P2gICaKsGaW3kZmBlIuAflVw=;
        b=SeR0hJXi6/HRpRnxSyCPhPO3hWZIuEDS5EvbEsvkCuHIHslfLmVGvAXw6EVk+3ltkh45qp
        98Ky/LfNWqTOSciCR8AXzhb4aw+jKNyq941xubSGiCgmWCIw54ZPH/pGNNlzJhV1nDsNYg
        PcTujLnQO+JAppb/HS8hfqM6kgLzpbU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-uCkBrL_UNP2Xjr0xyI8gRw-1; Thu, 12 May 2022 03:01:30 -0400
X-MC-Unique: uCkBrL_UNP2Xjr0xyI8gRw-1
Received: by mail-pj1-f72.google.com with SMTP id v10-20020a17090a0c8a00b001c7a548e4f7so4211584pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCJO+RNZFCWFbvical/P2gICaKsGaW3kZmBlIuAflVw=;
        b=0gsuKHHpwDS9FvR58dcRxa14FLdydHvYxYdc76kGOmUMgWxIQamjExkRwYfGJn3S2K
         n2j+0FuEZuJMjMmc2URtihMBVJsI89E/UdiDBUcLHhrC+/NtjW+CidTAa9ctfYJneYEt
         SPcRy9QrMerWGc3y/WlyVJnHfg0wniVR3joE+JujOzorQdNg/MxHCHIkbDaoPynThISq
         F2PEO1+85/5h7GgijX9CvmkDAY33g+1ua+nepLCvsWLfjBN6xRtXEs1Pq7Cdh5GEAUUV
         aBYnu8x7NBHVxxZsmQ94sZ4cve2vapYUdp3fiSBNFKpWdOpaSo4si9K3FC6Vw8cwvXN5
         uIlQ==
X-Gm-Message-State: AOAM5302bl+eJDsEGqAyUyfrfbgJdc7Wzrb8TcKSmNGe5CKqxihhDcmd
        2jvA5/xy2nd6uyCbp71tTbOe+z21u1nGLi4JfxyKMFw9L0BIb+UzwrtCuWbkdpr7cnX9l3JQ+GN
        epdXvAL7xvR3Ao2jijHh7Aju4
X-Received: by 2002:aa7:9109:0:b0:50a:78c8:8603 with SMTP id 9-20020aa79109000000b0050a78c88603mr28527893pfh.77.1652338889158;
        Thu, 12 May 2022 00:01:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI4KLqu3XPMmJRgrRI1AQSmd2vuUO9Ery3UYOJ2pMkClSuI93JjOxZe+aoInV9a9hDdY685A==
X-Received: by 2002:aa7:9109:0:b0:50a:78c8:8603 with SMTP id 9-20020aa79109000000b0050a78c88603mr28527872pfh.77.1652338888845;
        Thu, 12 May 2022 00:01:28 -0700 (PDT)
Received: from localhost ([240e:3a1:2e9:efa0:e73c:e550:ac9e:58fd])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b0015e8d4eb2aesm3061225plo.248.2022.05.12.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:01:28 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Thu, 12 May 2022 15:01:20 +0800
Message-Id: <20220512070123.29486-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512070123.29486-1-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no arch-specific implementation of
arch_kexec_kernel_verify_sig. Even if we want to add an implementation
for an architecture in the future, we can simply use "(struct
kexec_file_ops*)->verify_sig". So clean it up.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..413235c6c797 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -202,10 +202,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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
2.35.3

