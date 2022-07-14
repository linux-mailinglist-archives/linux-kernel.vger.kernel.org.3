Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C9574F64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiGNNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiGNNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD595958D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiVvGqWued69KlQMltHUGXgLkEsQEsLtjAg7jnmKF7w=;
        b=bU6Wtbk0CnQsb1OtxiRKZOpOwE23WoCMB9m4Xug0bEPY0GWiSp0ZwQOP4BmsyvNDH599vl
        UA6fUkFoFg58VuEtAgD7Ej0zj4xtOdGRteLmt+3sgx12Wc7lgSAd1zfharMhNuy/OS7EYB
        QBVx6FWJohBBfhQ70sb4Qw44PANG8Kg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-ZiYJKnECOoepXIlC_2z90A-1; Thu, 14 Jul 2022 09:40:46 -0400
X-MC-Unique: ZiYJKnECOoepXIlC_2z90A-1
Received: by mail-pj1-f72.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so1487393pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiVvGqWued69KlQMltHUGXgLkEsQEsLtjAg7jnmKF7w=;
        b=EP8WoBvObm407RepdrzEzh2xnhTDDomZC36wOghrImzTLzQXi10knd2Ozro2SeMK/s
         qLBMP+vVtCAGvAcpIyCLe7Exnzod18joJ2gsEYrJOleX0nLEzMaHi/l3zXfCMM1i0yBL
         lPNI0kBmhGnaAqIHvqO1eXeO01DrGfgxL5l41xnJcs92dBVDqLG6WFXWdapGVvPh7W6B
         DHzr5ye3NZ4U6xEImYnyUxrFcqfgXb1uNYOe629HvuU8h0UavtSC5As1deiRyuMKgGLp
         ktMTu4lHZXW9gqRYbdgaHzSkn8mnSijZLpZGGYTSJxJCfsY3yHfbsnVEcUvptdio6npp
         TGgw==
X-Gm-Message-State: AJIora9vhXtfDVrtJfQlDCkipPPaVGe3tXDfOlZ91aynpipRXjGDJPDA
        r9Uo7XuYO1qdwPayj5KuKyVdVVOy5z+6EPOKOIu4GDhCuPdlBYrwUnCpa1+ZiQsFsGuLgJ9HUyw
        rw9bSONI/tlVg2L4yrki+IFAx
X-Received: by 2002:a17:903:2310:b0:16c:1546:19ba with SMTP id d16-20020a170903231000b0016c154619bamr8463329plh.57.1657806045384;
        Thu, 14 Jul 2022 06:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vR6P1tHGe2AUAKkpHoPoHZ3qPv099U+d+IUX/aj3wmn46jrsJ1Kfs8MRjpFEQ0YAvbKCgu6w==
X-Received: by 2002:a17:903:2310:b0:16c:1546:19ba with SMTP id d16-20020a170903231000b0016c154619bamr8463303plh.57.1657806045096;
        Thu, 14 Jul 2022 06:40:45 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o21-20020a170902779500b0016be24e3668sm1425461pll.291.2022.07.14.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:40:44 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Thu, 14 Jul 2022 21:40:24 +0800
Message-Id: <20220714134027.394370-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
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

Before commit 105e10e2cf1c ("kexec_file: drop weak attribute from
functions"), there was already no arch-specific implementation
of arch_kexec_kernel_verify_sig. With weak attribute dropped by that
commit, arch_kexec_kernel_verify_sig is completely useless. So clean it
up.

Note this patch is dependent by later patches so it should backported to
the stable tree as well.

Cc: stable@vger.kernel.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  5 -----
 kernel/kexec_file.c   | 33 +++++++++++++--------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6958c6b471f4..6e7510f39368 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -212,11 +212,6 @@ static inline void *arch_kexec_kernel_image_load(struct kimage *image)
 }
 #endif
 
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
-
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c27c81351ee..6dc1294c90fc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -81,24 +81,6 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
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
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf, unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -141,13 +123,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+				  unsigned long buf_len)
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
+				     image->kernel_buf_len);
 	if (ret) {
 
 		if (sig_enforce) {
-- 
2.35.3

