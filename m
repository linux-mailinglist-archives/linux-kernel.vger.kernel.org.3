Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BF562CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiGAHfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiGAHfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:35:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2D6D55A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:35:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2617STH8018546;
        Fri, 1 Jul 2022 07:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AuotTv//2vpnaKk0+ERgaBUpY14yc+MaS21uWhbY1cU=;
 b=m39auTEYyT6c1O0tp4Em4Kbczoti7d6YnLIN3Tz/I2OKok/DWC1HI8tfaSCeU6jDoG4h
 h1hK7k3D7aheCFQGlfiMfDutqaryRTD54wrR/JE1lxd6WO87lkbChVnP65fxLUJ2Ld3y
 A5bkMsrJjdqus1DCoplPX+1tc06ji0Urz/VcUVgffz8qQPQRgXGnVWqwTWc+SFl1n17i
 N5PlUYdXLXKLnWd7lAvDmDiqEKoXolmuxwN/u+A1E+iV0LTJT7r9D93cOW2yZPcL34n2
 M2YWxqgQCaEfDMdc7MDxqJt+t58rTaWOm0hUFUuVGFgoi4TjVzAdXCM6bf0mK98pkgbV IQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1vjpg78u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 07:35:45 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2617SJ3H018417;
        Fri, 1 Jul 2022 07:35:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3gwt0970c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 07:35:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2617ZfD823396658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 07:35:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E5CB4C040;
        Fri,  1 Jul 2022 07:35:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 128C74C044;
        Fri,  1 Jul 2022 07:35:40 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.100.5])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 07:35:39 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 1/2] kexec_file: Drop weak attribute from functions
Date:   Fri,  1 Jul 2022 13:04:04 +0530
Message-Id: <2cd7ca1fe4d6bb6ca38e3283c717878388ed6788.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QlQ5uHlqaShLgs9bUvvmlRGb2h4E5Qn3
X-Proofpoint-GUID: QlQ5uHlqaShLgs9bUvvmlRGb2h4E5Qn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop __weak attribute from functions in kexec_file.c:
- arch_kexec_kernel_image_probe()
- arch_kimage_file_post_load_cleanup()
- arch_kexec_kernel_image_load()
- arch_kexec_locate_mem_hole()
- arch_kexec_kernel_verify_sig()

arch_kexec_kernel_image_load() calls into kexec_image_load_default(), so
drop the static attribute for the latter.

arch_kexec_kernel_verify_sig() is not overridden by any architecture, so
drop the __weak attribute.

Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/arm64/include/asm/kexec.h   |  4 ++-
 arch/powerpc/include/asm/kexec.h |  9 +++++++
 arch/s390/include/asm/kexec.h    |  3 +++
 arch/x86/include/asm/kexec.h     |  6 +++++
 include/linux/kexec.h            | 44 +++++++++++++++++++++++++++-----
 kernel/kexec_file.c              | 35 ++-----------------------
 6 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9839bfc163d714..78d272b26ebd11 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -115,7 +115,9 @@ extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
 
-extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
+
 extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr, unsigned long kernel_size,
 		char *initrd, unsigned long initrd_len,
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 2aefe14e144229..1e5e9b6ec78d9d 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -120,6 +120,15 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 #ifdef CONFIG_PPC64
 struct kexec_buf;
 
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len);
+#define arch_kexec_kernel_image_probe arch_kexec_kernel_image_probe
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
+
+int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
+#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
+
 int load_crashdump_segments_ppc64(struct kimage *image,
 				  struct kexec_buf *kbuf);
 int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 649ecdcc873453..8886aadc11a3a6 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -92,5 +92,8 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *relsec,
 				     const Elf_Shdr *symtab);
 #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
 #endif /*_S390_KEXEC_H */
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6ad8d946cd3ebf..5ec359c1b50cb3 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -193,6 +193,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *relsec,
 				     const Elf_Shdr *symtab);
 #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
+
+void *arch_kexec_kernel_image_load(struct kimage *image);
+#define arch_kexec_kernel_image_load arch_kexec_kernel_image_load
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
 #endif
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d26997..5e0bc3f9eac3e9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -188,21 +188,53 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
+void *kexec_image_load_default(struct kimage *image);
+
+#ifndef arch_kexec_kernel_image_probe
+static inline int
+arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len)
+{
+	return kexec_image_probe_default(image, buf, buf_len);
+}
+#endif
+
+#ifndef arch_kimage_file_post_load_cleanup
+static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	return kexec_image_post_load_cleanup_default(image);
+}
+#endif
+
+#ifndef arch_kexec_kernel_image_load
+static inline void *arch_kexec_kernel_image_load(struct kimage *image)
+{
+	return kexec_image_load_default(image);
+}
+#endif
 
-/* Architectures may override the below functions */
-int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-				  unsigned long buf_len);
-void *arch_kexec_kernel_image_load(struct kimage *image);
-int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #ifdef CONFIG_KEXEC_SIG
 int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 				 unsigned long buf_len);
 #endif
-int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
+#ifndef arch_kexec_locate_mem_hole
+/**
+ * arch_kexec_locate_mem_hole - Find free memory to place the segments.
+ * @kbuf:                       Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	return kexec_locate_mem_hole(kbuf);
+}
+#endif
+
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9b2839775c837b..66e4ce29fc6961 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -56,14 +56,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-/* Architectures can provide this probe function */
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len)
-{
-	return kexec_image_probe_default(image, buf, buf_len);
-}
-
-static void *kexec_image_load_default(struct kimage *image)
+void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -74,11 +67,6 @@ static void *kexec_image_load_default(struct kimage *image)
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
@@ -87,11 +75,6 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
-int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
-{
-	return kexec_image_post_load_cleanup_default(image);
-}
-
 #ifdef CONFIG_KEXEC_SIG
 static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
 					  unsigned long buf_len)
@@ -104,8 +87,7 @@ static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
 	return image->fops->verify_sig(buf, buf_len);
 }
 
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
+int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf, unsigned long buf_len)
 {
 	return kexec_image_verify_sig_default(image, buf, buf_len);
 }
@@ -616,19 +598,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
 
-/**
- * arch_kexec_locate_mem_hole - Find free memory to place the segments.
- * @kbuf:                       Parameters for the memory search.
- *
- * On success, kbuf->mem will have the start address of the memory region found.
- *
- * Return: 0 on success, negative errno on error.
- */
-int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
-{
-	return kexec_locate_mem_hole(kbuf);
-}
-
 /**
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
-- 
2.36.1

