Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE955635EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGAOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiGAOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0567C18E;
        Fri,  1 Jul 2022 07:37:10 -0700 (PDT)
Date:   Fri, 01 Jul 2022 14:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656686228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FpOqjtoVS3/RdF3uoniN+HTRp7MUhUkImJN39hH6yc=;
        b=3Mi4TmzizPBbRHPZ+uKSWxfrneqa/6iDUCd6NxBlXK9c3XwaSsv5r1e/Hlez4xEkqM271a
        m3Z6fn1r/bUNK6q99AGq6GivNEitJi345o6Gkj8FyToTM5dQ1jTgJuudQT9arhN4t3ABme
        fCL+hOY2VyRJEo6XslthVO8ZuUVEr4vwFspNRmmyPqbyB2hbBNS1c4aLvbhAk4Q0EJp+z2
        ECWBBBdAY5QPhvkUT3f+uS1wbDhi3bDiYZj6Ki2plranCe9X48wGnFhjjNUTddczDiiHdx
        aGVGPB8yQCH3dV2Y9+pVFcij41bA675W5n28c+YrOMUAR8h2RqL3dGV+m+corg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656686228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FpOqjtoVS3/RdF3uoniN+HTRp7MUhUkImJN39hH6yc=;
        b=83rf7iW+OsrQTYQ/xtwb9GC/7LREf86xq9mF3OcE4qVRgEpCS3UJ89yKQY74XCYxz5kkUn
        FhEWaxMGH5dHuKAg==
From:   "tip-bot2 for Jonathan McDowell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/kexec: Carry forward IMA measurement log on kexec
Cc:     Jonathan McDowell <noodles@fb.com>, Borislav Petkov <bp@suse.de>,
        Mimi Zohar <zohar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
MIME-Version: 1.0
Message-ID: <165668622733.15455.18381501422331434452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     b69a2afd5afce9bf6d56e349d6ab592c916e20f2
Gitweb:        https://git.kernel.org/tip/b69a2afd5afce9bf6d56e349d6ab592c916e20f2
Author:        Jonathan McDowell <noodles@fb.com>
AuthorDate:    Thu, 30 Jun 2022 08:36:12 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 01 Jul 2022 15:22:16 +02:00

x86/kexec: Carry forward IMA measurement log on kexec

On kexec file load, the Integrity Measurement Architecture (IMA)
subsystem may verify the IMA signature of the kernel and initramfs, and
measure it. The command line parameters passed to the kernel in the
kexec call may also be measured by IMA.

A remote attestation service can verify a TPM quote based on the TPM
event log, the IMA measurement list and the TPM PCR data. This can
be achieved only if the IMA measurement log is carried over from the
current kernel to the next kernel across the kexec call.

PowerPC and ARM64 both achieve this using device tree with a
"linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
device tree, so use the setup_data mechanism to pass the IMA buffer to
the new kernel.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> # IMA function definitions
Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG
---
 arch/x86/Kconfig                      |  1 +-
 arch/x86/include/uapi/asm/bootparam.h |  9 ++++-
 arch/x86/kernel/e820.c                |  6 +-
 arch/x86/kernel/kexec-bzimage64.c     | 42 ++++++++++++++++-
 arch/x86/kernel/setup.c               | 63 ++++++++++++++++++++++++++-
 drivers/of/kexec.c                    | 13 +----
 include/linux/ima.h                   |  5 ++-
 include/linux/of.h                    |  2 +-
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e..670e0ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2033,6 +2033,7 @@ config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
 	select BUILD_BIN2C
+	select HAVE_IMA_KEXEC if IMA
 	depends on X86_64
 	depends on CRYPTO=y
 	depends on CRYPTO_SHA256=y
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdc..ca0796a 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -11,6 +11,7 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 #define SETUP_CC_BLOB			7
+#define SETUP_IMA			8
 
 #define SETUP_INDIRECT			(1<<31)
 
@@ -172,6 +173,14 @@ struct jailhouse_setup_data {
 	} __attribute__((packed)) v2;
 } __attribute__((packed));
 
+/*
+ * IMA buffer setup data information from the previous kernel during kexec
+ */
+struct ima_setup_data {
+	__u64 addr;
+	__u64 size;
+} __attribute__((packed));
+
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205..9dac246 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
-		 * SETUP_EFI is supplied by kexec and does not need to be
-		 * reserved.
+		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
+		 * to be reserved.
 		 */
-		if (data->type != SETUP_EFI)
+		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
 			e820__range_update_kexec(pa_data,
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd..c63974e 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -186,11 +186,38 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 }
 #endif /* CONFIG_EFI */
 
+static void
+setup_ima_state(const struct kimage *image, struct boot_params *params,
+		unsigned long params_load_addr,
+		unsigned int ima_setup_data_offset)
+{
+#ifdef CONFIG_IMA_KEXEC
+	struct setup_data *sd = (void *)params + ima_setup_data_offset;
+	unsigned long setup_data_phys;
+	struct ima_setup_data *ima;
+
+	if (!image->ima_buffer_size)
+		return;
+
+	sd->type = SETUP_IMA;
+	sd->len = sizeof(*ima);
+
+	ima = (void *)sd + sizeof(struct setup_data);
+	ima->addr = image->ima_buffer_addr;
+	ima->size = image->ima_buffer_size;
+
+	/* Add setup data */
+	setup_data_phys = params_load_addr + ima_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+#endif /* CONFIG_IMA_KEXEC */
+}
+
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
 		      unsigned int efi_map_offset, unsigned int efi_map_sz,
-		      unsigned int efi_setup_data_offset)
+		      unsigned int setup_data_offset)
 {
 	unsigned int nr_e820_entries;
 	unsigned long long mem_k, start, end;
@@ -245,8 +272,15 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 #ifdef CONFIG_EFI
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
-			efi_setup_data_offset);
+			setup_data_offset);
+	setup_data_offset += sizeof(struct setup_data) +
+			sizeof(struct efi_setup_data);
 #endif
+
+	/* Setup IMA log buffer state */
+	setup_ima_state(image, params, params_load_addr,
+			setup_data_offset);
+
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
 				EDDMAXNR * sizeof(struct edd_info));
@@ -403,6 +437,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 				sizeof(struct setup_data) +
 				sizeof(struct efi_setup_data);
 
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		kbuf.bufsz += sizeof(struct setup_data) +
+			      sizeof(struct ima_setup_data);
+
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bd6c6fd..53f863f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -11,6 +11,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
+#include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
 #include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
@@ -140,6 +141,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
 __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
 #endif
 
+#ifdef CONFIG_IMA
+static phys_addr_t ima_kexec_buffer_phys;
+static size_t ima_kexec_buffer_size;
+#endif
+
 /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
 int bootloader_type, bootloader_version;
 
@@ -330,6 +336,60 @@ static void __init reserve_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+static void __init add_early_ima_buffer(u64 phys_addr)
+{
+#ifdef CONFIG_IMA
+	struct ima_setup_data *data;
+
+	data = early_memremap(phys_addr + sizeof(struct setup_data), sizeof(*data));
+	if (!data) {
+		pr_warn("setup: failed to memremap ima_setup_data entry\n");
+		return;
+	}
+
+	if (data->size) {
+		memblock_reserve(data->addr, data->size);
+		ima_kexec_buffer_phys = data->addr;
+		ima_kexec_buffer_size = data->size;
+	}
+
+	early_memunmap(data, sizeof(*data));
+#else
+	pr_warn("Passed IMA kexec data, but CONFIG_IMA not set. Ignoring.\n");
+#endif
+}
+
+#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
+int __init ima_free_kexec_buffer(void)
+{
+	int rc;
+
+	if (!ima_kexec_buffer_size)
+		return -ENOENT;
+
+	rc = memblock_phys_free(ima_kexec_buffer_phys,
+				ima_kexec_buffer_size);
+	if (rc)
+		return rc;
+
+	ima_kexec_buffer_phys = 0;
+	ima_kexec_buffer_size = 0;
+
+	return 0;
+}
+
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	if (!ima_kexec_buffer_size)
+		return -ENOENT;
+
+	*addr = __va(ima_kexec_buffer_phys);
+	*size = ima_kexec_buffer_size;
+
+	return 0;
+}
+#endif
+
 static void __init parse_setup_data(void)
 {
 	struct setup_data *data;
@@ -355,6 +415,9 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_IMA:
+			add_early_ima_buffer(pa_data);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 8d374cc..f2e58dd 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -9,6 +9,7 @@
  *  Copyright (C) 2016  IBM Corporation
  */
 
+#include <linux/ima.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/memblock.h>
@@ -115,6 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -122,16 +124,13 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  *
  * Return: 0 on success, negative errno on error.
  */
-int ima_get_kexec_buffer(void **addr, size_t *size)
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
 	size_t tmp_size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
 	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
 	if (!prop)
 		return -ENOENT;
@@ -149,16 +148,13 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __init ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
 	size_t size;
 	struct property *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
 	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
 	if (!prop)
 		return -ENOENT;
@@ -173,6 +169,7 @@ int ima_free_kexec_buffer(void)
 
 	return memblock_phys_free(addr, size);
 }
+#endif
 
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 426b174..81708ca 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -140,6 +140,11 @@ static inline int ima_measure_critical_data(const char *event_label,
 
 #endif /* CONFIG_IMA */
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
+int __init ima_free_kexec_buffer(void);
+int __init ima_get_kexec_buffer(void **addr, size_t *size);
+#endif
+
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
diff --git a/include/linux/of.h b/include/linux/of.h
index f0a5d6b..20a4e7c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -441,8 +441,6 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_load_addr,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 1375313..419dc40 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
