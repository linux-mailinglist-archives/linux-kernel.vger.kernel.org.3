Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282494DD73C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiCRJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiCRJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 958BB2C3DEE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwB9ZURkcH7/Y+etuUEb9xxXjVVCmMsQlrMh7LXVjOY=;
        b=KfuZMq7nv0Ng0/omNkftCpxUyKI85aarzqlSlZt5hbULj/y+QCZ4Q5vikegE+0/gsbL7Cy
        IM2bkGB+OSKpi8o5EX7epZpXh8ewqMVhlNw/LHr3FqBHA3nwuB+8FUQLQX/gxHfmRWY/IS
        UGyc9ebmbjxOem/rRC1Fwk7xR2igUJw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-s2x06zI1OG2rYxjG7CRyEQ-1; Fri, 18 Mar 2022 05:41:09 -0400
X-MC-Unique: s2x06zI1OG2rYxjG7CRyEQ-1
Received: by mail-pf1-f197.google.com with SMTP id y27-20020aa79afb000000b004fa7883f756so26408pfp.18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwB9ZURkcH7/Y+etuUEb9xxXjVVCmMsQlrMh7LXVjOY=;
        b=dNRG7Qjkp76Txgt2e/Bbvky+Otf12lbsoc1dHHXUZZSxdpl2VW5diflQY2eqDeOmc1
         biSv0D5lDsYAtjYGK2n34gEAlfQe96jSascp90mnKO5xSM7sdQZBrmFIyTGe0Hka2771
         kW71w8V+QqImSxq3DmpGQDOBCctC0xo+oNuhIV9BTFwCsvj8s7Ao1MVvcghRa26oHSAW
         14UUxogtwI9eRh/DtNOoSZEUGTgdEl0yv5gRkYTbRwUSuF7jPnl9PPB6afldXGA2okrH
         iuDEfyrn4HjZ5DjtneQhNtdutO3JpAuZ6LfzFxONn4FLMzk1qjoIzj5JCZ/6Z/8k5U/I
         rgfw==
X-Gm-Message-State: AOAM532EJHOrsmrK6zEyeLbm83SW7z9BzaDiI4df6LYFzwE7mrR1ZBts
        8wLbhrWPHRXYKo36tVQeUF4Pb+heAoCA2tevzRBME6fDKJCmEv1fG76NXIuDmIMI3tuZfwIluqi
        oNaJ/fLYtNusVza+/hDEWc/po
X-Received: by 2002:a17:90a:ca96:b0:1c6:b478:788e with SMTP id y22-20020a17090aca9600b001c6b478788emr1699047pjt.162.1647596468357;
        Fri, 18 Mar 2022 02:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgBkcXsK1rGQ1Ahb6434nwbtdmmC/q90wdZ/LIeinBZlv3tTPqVTddL5TmOxAl7jnaZ1Gryw==
X-Received: by 2002:a17:90a:ca96:b0:1c6:b478:788e with SMTP id y22-20020a17090aca9600b001c6b478788emr1699023pjt.162.1647596468092;
        Fri, 18 Mar 2022 02:41:08 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id m18-20020a639412000000b003820bd9f2f2sm3599952pge.53.2022.03.18.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:41:07 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Fri, 18 Mar 2022 17:40:59 +0800
Message-Id: <20220318094101.274950-2-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318094101.274950-1-coxu@redhat.com>
References: <20220318094101.274950-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
functions") allows implementing the arch-specific implementation of kernel
image verification in kexec_file_ops->verify_sig. Currently, there is no
arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
up.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
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

