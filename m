Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6245003BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiDNBqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiDNBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70CE420F78
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUo4znEOkRrWRs1sMxG9XXTvdlj/WDC4ky0CeyyLoSA=;
        b=U1XWFI22c0P7MXu7LDxVvtBwEAHilUr6vSYRqsG2+1jTyav5OUbne0h15ROkgu6Uc396Ts
        hMzdjY0EaQNxE12oQM0+75liUqBiEIUhBz0FbkKtI5t2e+av9t7+CNbFaqTqVQBQkWGLE3
        w2PcpDxk1niKjdk81oId4Y+DvazpQ90=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-RM-rfOzbOkqYhnnCwFcizQ-1; Wed, 13 Apr 2022 21:44:03 -0400
X-MC-Unique: RM-rfOzbOkqYhnnCwFcizQ-1
Received: by mail-pg1-f200.google.com with SMTP id l6-20020a637006000000b003811a27370aso1980020pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUo4znEOkRrWRs1sMxG9XXTvdlj/WDC4ky0CeyyLoSA=;
        b=0zMprhfkK0RSYd/Hn8v6AIfStMaw4ja9XVLWiXtesaWvSN843PmVyHb5w3qkMsDkQc
         z31ffXfCJn1DxPoM4IJ+D5lbRIsVk6m+9+veuJBszEFARPNIYbuDA2/ZxumI/jkMB7QE
         Ms2+U2gCtd2nO1dloVkzaS58jyM3MGMoPSc6zLSMXYXFuZdQepV1hhZ9MSVGS6lMFv/9
         mLAcbSC9mep1HSpgdkzJaDd9lee5WQsXvVobDaOOzudnda34h832QK/dYMiDu5Z8oHfX
         7JXZ+4AkDW90WyxnD8QoNh7em6WboQ6ZDzwxjX8E0PJPffgMHxq/DFoFKAE6DFcmDdDF
         ygHA==
X-Gm-Message-State: AOAM533ALHm0L01Fm24N6Z2Wxuuo82qk6J9lnC9XhZQzVLauX5puZ02j
        skIO3z0/4rWzpNXcFW6ORzEw9XACPs9afpE+53eTHGW1BFHjPfXR5bTgtpx2GSM9QvmVLubu6jP
        0TGeW/2QIyiTLhq/UcoGFXk4I
X-Received: by 2002:a05:6a00:4211:b0:506:5061:3e38 with SMTP id cd17-20020a056a00421100b0050650613e38mr1591784pfb.74.1649900642604;
        Wed, 13 Apr 2022 18:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPUPsdDaV0SaXNU950qh/kHth5bPSWxu8nmDnhrsKNKGWJouIJSJ3+yN9qcKr5KVKvb/41OA==
X-Received: by 2002:a05:6a00:4211:b0:506:5061:3e38 with SMTP id cd17-20020a056a00421100b0050650613e38mr1591763pfb.74.1649900642367;
        Wed, 13 Apr 2022 18:44:02 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id ml1-20020a17090b360100b001cd40539cd9sm311141pjb.1.2022.04.13.18.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:44:01 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Thu, 14 Apr 2022 09:43:41 +0800
Message-Id: <20220414014344.228523-2-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414014344.228523-1-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: stable@kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
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
2.34.1

