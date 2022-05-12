Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113525242CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiELCeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiELCeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B198134E3A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652322852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1RM6J3uuTVxgrBSDhjonzu3khLVyy7UfT2z18Xr7/8=;
        b=EamDmkCCVkC4Te1apaPfnUZPKBG8ITOWe7HVnB7m7ZPIakUpHiJWeOsRik025M1xcAZb1E
        n9BHxnZjwM6ULSWfz9iu7AAr9r9hdcSx6k9qDZ2Z09OkCuiUTqRjGjJpNeo1TDuFOdJJid
        4ZA3OHf2/TnDJAUAsVPclLaz1pJ+w6I=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-gnRzkf_zP3aXVSQFYSzb7A-1; Wed, 11 May 2022 22:34:10 -0400
X-MC-Unique: gnRzkf_zP3aXVSQFYSzb7A-1
Received: by mail-pf1-f197.google.com with SMTP id z19-20020a62d113000000b0050d183adf6fso1928009pfg.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1RM6J3uuTVxgrBSDhjonzu3khLVyy7UfT2z18Xr7/8=;
        b=U0WA8WlhlANnZsTpJytKJfQPFMKXr4T3WJnGXUWPQkzajPzemwCJ1ZPuqgrd0iC+CH
         WIh+YvnFDG9db6ktSOisHTnVmAYhPIoDc3b10Czsq2AKRUGi7t6BDurWUan0X6CiYUuW
         +pwWQaBLFzp+28uFZ3kKQf+R9DeC9zUU9OxM6BDHn8y7bgwrfUAqNToaIWg+/jdm1vyN
         E1cl3DYDIQozkVloporQueN8n3mQ112Xh//+1A7yET69GDC0g9jUoukcI1PL5R8G+a0H
         dIUXj11X0dzmY8XHOzKlFCay50PcE6kOFa9tSwHouiXsqpCnRK1RcHVvc4nqzUQV7XtI
         dqJg==
X-Gm-Message-State: AOAM530dJ/lgijeXp6y70EGy+Bpwq+/9qKrJDOHhE+EA7FoPCnL7fhsG
        k8tpVuJnEVw5iASkDWrUtbK0jy9fXCtufsgM1IoDX3zA+ojpEJrdp/SaozH88t8GNb48YBEyHPL
        /9gHeCUPJ1e8n6pTJ8GL3tXp+
X-Received: by 2002:a17:903:230b:b0:15e:bc9c:18c7 with SMTP id d11-20020a170903230b00b0015ebc9c18c7mr28317284plh.29.1652322849331;
        Wed, 11 May 2022 19:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBLwmAnT3YjOM0+q7aOBCPUuYBD9cDVb22vSPfF5bLWDIiVaY+O2ApMQ8Fxd/8OpkQUf8EAA==
X-Received: by 2002:a17:903:230b:b0:15e:bc9c:18c7 with SMTP id d11-20020a170903230b00b0015ebc9c18c7mr28317266plh.29.1652322849104;
        Wed, 11 May 2022 19:34:09 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 7-20020a621507000000b0050dc762812asm2475053pfv.4.2022.05.11.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:34:08 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date:   Thu, 12 May 2022 10:33:59 +0800
Message-Id: <20220512023402.9913-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512023402.9913-1-coxu@redhat.com>
References: <20220512023402.9913-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Note this patch is needed by later patches so Cc it to the stable tree
as well.

Cc: stable@vger.kernel.org
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

