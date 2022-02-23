Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F604C1154
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiBWLdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbiBWLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C2D23E0CB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645615978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwQLMtEcBC3XALlAa6IT7v4zUNwzhN/4Kn6SmvYX9qs=;
        b=c5NLgQmPNdRGQucKYTADgMqoih27W97h46vAkSqsQX1kl1N9X/AmzgQlN95qvIw3kASaiE
        32j72abbB12XaZ7QNSruyXEU+HngnV+fVwR8fztGA7ejO6LwYLkp9u+dif8AcHk6RLloF/
        esEvsk9BAC/rHptNsyFA3A0eCUbvFFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-fFlfqDnAPRC_m8p-UZVHVQ-1; Wed, 23 Feb 2022 06:32:55 -0500
X-MC-Unique: fFlfqDnAPRC_m8p-UZVHVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CFC41091DA0;
        Wed, 23 Feb 2022 11:32:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.smartont.net (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00FA76C2B;
        Wed, 23 Feb 2022 11:32:51 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com, x86@kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
Date:   Wed, 23 Feb 2022 19:32:25 +0800
Message-Id: <20220223113225.63106-3-bhe@redhat.com>
In-Reply-To: <20220223113225.63106-1-bhe@redhat.com>
References: <20220223113225.63106-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function arch_kexec_kernel_image_load() has a common weak version which
is a wrapper of kexec_image_load_default() , and has only one arch
dependent version in x86_64. Now the x86_64 dependent function is not
needed any more. So clean it up.

And also rename kexec_image_load_default() to kexec_kernel_image_load() for
better reflecting its functionality.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  1 -
 kernel/kexec_file.c                |  9 ++-------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f0eb0eed546..6b14d9274def 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -372,17 +372,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	if (!image->fops || !image->fops->load)
-		return ERR_PTR(-ENOEXEC);
-
-	return image->fops->load(image, image->kernel_buf,
-				 image->kernel_buf_len, image->initrd_buf,
-				 image->initrd_buf_len, image->cmdline_buf,
-				 image->cmdline_buf_len);
-}
-
 /*
  * Apply purgatory relocations.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..47b70402c0a4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -186,7 +186,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 /* Architectures may override the below functions */
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
-void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..b6a1347f546e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -60,7 +60,7 @@ int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 	return kexec_image_probe_default(image, buf, buf_len);
 }
 
-static void *kexec_image_load_default(struct kimage *image)
+static void *kexec_kernel_image_load(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -71,11 +71,6 @@ static void *kexec_image_load_default(struct kimage *image)
 				 image->cmdline_buf_len);
 }
 
-void * __weak arch_kexec_kernel_image_load(struct kimage *image)
-{
-	return kexec_image_load_default(image);
-}
-
 int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
@@ -279,7 +274,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	ima_add_kexec_buffer(image);
 
 	/* Call arch image load handlers */
-	ldata = arch_kexec_kernel_image_load(image);
+	ldata = kexec_kernel_image_load(image);
 
 	if (IS_ERR(ldata)) {
 		ret = PTR_ERR(ldata);
-- 
2.31.1

