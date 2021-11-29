Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB821461F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377457AbhK2Sxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379038AbhK2Svq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:51:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440AFC043CEE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:06:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so12634873wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAfhB6MBX86Cpk3aps4aSC1NpzI4h2JBf099mJFR3iY=;
        b=ff7yo7Z6plI2VVM/yuXEpxPtdVHyWcsO0xD9vwwi5wZBU4nu4ph+Vmw0t4P1UwwCmU
         AcXUep0IjDyIASZczpUy7NrMXBoLBumGFk+ZphWIRkFR4jJAQU+RA3jCc1WIIEpQBYU/
         FL4lfnbXDLhoq0f0j7m8Nh2bj8nI7tvCdgPVPMxuyaUIgjlfvOapW13Q+dZIYjzDk1JD
         TkNsQJCLy3D4T0jiomhIhWIJvahl0Dkp105gCCdhgl6DKDco1Kooc5Ft7qeQjQItemKg
         OAMuXAro7xg/FLUhSFDmCzhRRfXZ8gDEhIy2RUO2oPxlDkwq+X685yJqWxGdKPr3jglT
         XkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAfhB6MBX86Cpk3aps4aSC1NpzI4h2JBf099mJFR3iY=;
        b=sD2d/7Oe+C8gJJycmJiOp+HlqYRmogntrTIcgn+FSeV5Hgcif2nD1gOeUEW5/ADz15
         qxoBrUIxx/zN50o0wJsyDuUxCttyNCEQ7ATiANkUfWZHBmObdEsioqt4RDyMzItxweWw
         kxV9y4T7Ue9KalVH9bvHGFFUTFkxxEffbr/iKNhlkX7F/JRfSw5KM2W9w8hvRFfJhSwz
         whNbUQBIlco/o1EHOrNaRTXucX0Oy4ndmUKDrn2O+GSDPNg0UsM7+Weg26Sqlc7TmlXe
         9HJazuNwEFh4JC789/OUJ4f52pNMhQvkYC8HFmP+UnqSeGi4LPePfGGrFVY3oHTnQGjK
         Y8pA==
X-Gm-Message-State: AOAM53008odj+apoGVH6HVmaCjEVzY2qz1o1E4m1QOP3TWkB8L3wxTlS
        6pnvkV5t2Yt3L3xQdgb1oLCJ+y0K1rN25qaW
X-Google-Smtp-Source: ABdhPJzOjnUSTySm9comO+MxzbXHC52ZzDv1piY1NLM4WFs87zqKAyAVCsylYZ67RNdEMaGKcm9cpQ==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr36894658wmq.119.1638198417746;
        Mon, 29 Nov 2021 07:06:57 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:387:571:2fd1:1eb])
        by smtp.gmail.com with ESMTPSA id y6sm19427197wma.37.2021.11.29.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:06:57 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
        bp@alien8.de, tglx@linutronix.de
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v2] x86/purgatory: provide config to disable purgatory
Date:   Mon, 29 Nov 2021 15:06:55 +0000
Message-Id: <20211129150655.2272568-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling purgatory reduces the boot time if it is not needed
as the sha256 digest of kexec segments is no longer calculated
or verified. This helps reduce the downtime of servers when
the host kernel managing multiple VMs needs to be updated via kexec.

The time taken from reboot to running init process was measured
with both purgatory enabled and disabled over 20 runs and the
averages are:
Purgatory disabled:
- TSC = 3908766161 cycles
- ktime = 606.8 ms
Purgatory enabled:
- TSC = 5005811885 cycles (28.1% worse)
- ktime = 843.1 ms (38.9% worse)

Hence disabling purgatory has a significant improvement in kexec
time.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Fam Zheng <fam.zheng@bytedance.com>

---
v2 changes:
 - Updated commit message to include timing and usecase.
 - Fixed bug in v1 in which bootparam_load_addr was not passed when
   purgatory was disabled.
---
 arch/powerpc/Kbuild                  |  2 +-
 arch/powerpc/Kconfig                 |  2 +-
 arch/s390/Kbuild                     |  2 +-
 arch/s390/Kconfig                    |  2 +-
 arch/s390/purgatory/Makefile         |  2 +-
 arch/x86/Kbuild                      |  2 +-
 arch/x86/Kconfig                     |  6 ++-
 arch/x86/include/asm/kexec.h         |  3 +-
 arch/x86/kernel/kexec-bzimage64.c    | 70 ++++++++++++++++------------
 arch/x86/kernel/machine_kexec_64.c   |  3 +-
 arch/x86/kernel/relocate_kernel_64.S |  8 ++++
 arch/x86/purgatory/Makefile          |  2 +-
 include/linux/kexec.h                |  5 ++
 kernel/kexec_file.c                  |  9 ++--
 14 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
index 22cd0d55a892..072e62d7898e 100644
--- a/arch/powerpc/Kbuild
+++ b/arch/powerpc/Kbuild
@@ -15,7 +15,7 @@ obj-$(CONFIG_KVM)  += kvm/
 
 obj-$(CONFIG_PERF_EVENTS) += perf/
 obj-$(CONFIG_KEXEC_CORE)  += kexec/
-obj-$(CONFIG_KEXEC_FILE)  += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY)  += purgatory/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..58bdfd1abb44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -557,7 +557,7 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to a list of segments as is the
 	  case for the older kexec call.
 
-config ARCH_HAS_KEXEC_PURGATORY
+config KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
 config RELOCATABLE
diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
index 76e362277179..2ed4ee5cdf59 100644
--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS_FS)	+= hypfs/
 obj-$(CONFIG_APPLDATA_BASE)	+= appldata/
 obj-y				+= net/
 obj-$(CONFIG_PCI)		+= pci/
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2a5bb4f29cfe..d15bdaa0e198 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -538,7 +538,7 @@ config KEXEC_FILE
 	  kexec system call this system call takes file descriptors for the
 	  kernel and initramfs as arguments.
 
-config ARCH_HAS_KEXEC_PURGATORY
+config KEXEC_PURGATORY
 	def_bool y
 	depends on KEXEC_FILE
 
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 360ada80d20c..03cac6d7310a 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
 $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
 	$(call if_changed_rule,as_o_S)
 
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
+obj-$(CONFIG_KEXEC_PURGATORY) += kexec-purgatory.o
diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1a4f7a..9089438ed6d8 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -24,7 +24,7 @@ obj-$(CONFIG_IA32_EMULATION) += ia32/
 obj-y += platform/
 obj-y += net/
 
-obj-$(CONFIG_KEXEC_FILE) += purgatory/
+obj-$(CONFIG_KEXEC_PURGATORY) += purgatory/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327d1eff..7efe6dbfdc67 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2000,8 +2000,10 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
-config ARCH_HAS_KEXEC_PURGATORY
-	def_bool KEXEC_FILE
+config KEXEC_PURGATORY
+	bool "A standalone relocatable object run between the 2 kernels during kexec"
+	depends on KEXEC_FILE
+	default y
 
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 11b7c06e2828..8c33bb32b593 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -129,7 +129,8 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int host_mem_enc_active);
+		unsigned int host_mem_enc_active,
+		unsigned long bootparam_load_addr);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..dbaa0e8c7634 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -374,18 +374,19 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 			return ERR_PTR(ret);
 	}
 
-	/*
-	 * Load purgatory. For 64bit entry point, purgatory  code can be
-	 * anywhere.
-	 */
-	ret = kexec_load_purgatory(image, &pbuf);
-	if (ret) {
-		pr_err("Loading purgatory failed\n");
-		return ERR_PTR(ret);
-	}
-
-	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
+		/*
+		 * Load purgatory. For 64bit entry point, purgatory  code can be
+		 * anywhere.
+		 */
+		ret = kexec_load_purgatory(image, &pbuf);
+		if (ret) {
+			pr_err("Loading purgatory failed\n");
+			return ERR_PTR(ret);
+		}
 
+		pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	}
 
 	/*
 	 * Load Bootparams and cmdline and space for efi stuff.
@@ -466,28 +467,37 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params->hdr.type_of_loader = 0x0D << 4;
 	params->hdr.loadflags = 0;
 
-	/* Setup purgatory regs for entry */
-	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
-					     sizeof(regs64), 1);
-	if (ret)
-		goto out_free_params;
+	if (IS_ENABLED(CONFIG_KEXEC_PURGATORY)) {
+		/* Setup purgatory regs for entry */
+		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+						     sizeof(regs64), 1);
+		if (ret)
+			goto out_free_params;
 
-	regs64.rbx = 0; /* Bootstrap Processor */
-	regs64.rsi = bootparam_load_addr;
-	regs64.rip = kernel_load_addr + 0x200;
-	stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
-	if (IS_ERR(stack)) {
-		pr_err("Could not find address of symbol stack_end\n");
-		ret = -EINVAL;
-		goto out_free_params;
-	}
+		regs64.rbx = 0; /* Bootstrap Processor */
+		regs64.rsi = bootparam_load_addr;
+		regs64.rip = kernel_load_addr + 0x200;
 
-	regs64.rsp = (unsigned long)stack;
-	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
-					     sizeof(regs64), 0);
-	if (ret)
-		goto out_free_params;
+		stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
+		if (IS_ERR(stack)) {
+			pr_err("Could not find address of symbol stack_end\n");
+			ret = -EINVAL;
+			goto out_free_params;
+		}
 
+		regs64.rsp = (unsigned long)stack;
+		ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+						     sizeof(regs64), 0);
+		if (ret)
+			goto out_free_params;
+	} else {
+		/*
+		 * Pass kernel and bootparam load address to relocate_kernel
+		 * if purgatory is disabled.
+		 */
+		image->start = kernel_load_addr + 0x200;
+		image->bootparam_load_addr = bootparam_load_addr;
+	}
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
 				    efi_map_offset, efi_map_sz,
 				    efi_setup_data_offset);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index f5da4a18070a..f7b009768652 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -359,7 +359,8 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT),
+				       image->bootparam_load_addr);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c8fe74a28143..12789c8eabe6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -48,6 +48,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rdx start address
 	 * %rcx preserve_context
 	 * %r8  host_mem_enc_active
+	 * %r9  bootparam_load_addr
 	 */
 
 	/* Save the CPU context, used for jumping back */
@@ -59,6 +60,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
+	/* Save bootparam_load_addr in %r14  */
+	movq	%r9, %r14
+
 	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
 	movq	%rsp, RSP(%r11)
 	movq	%cr0, %rax
@@ -179,7 +183,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
 	xorl    %edx, %edx
+#ifdef CONFIG_KEXEC_PURGATORY
 	xorl    %esi, %esi
+#else
+	movq    %r14, %rsi
+#endif
 	xorl    %edi, %edi
 	xorl    %ebp, %ebp
 	xorl	%r8d, %r8d
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..688b3f21be8f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
+obj-$(CONFIG_KEXEC_PURGATORY)	+= kexec-purgatory.o
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..818c3770158f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -313,6 +313,11 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+#ifndef CONFIG_PURGATORY
+	unsigned long bootparam_load_addr;
+#endif
+
 };
 
 /* kexec interface functions */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..ad3131880a37 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -108,6 +108,7 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
 }
 #endif
 
+#ifdef CONFIG_KEXEC_PURGATORY
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
  * @pi:		Purgatory to be relocated.
@@ -141,7 +142,7 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 	pr_err("REL relocation unsupported.\n");
 	return -ENOEXEC;
 }
-
+#endif /* CONFIG_KEXEC_PURGATORY */
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -724,7 +725,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	struct kexec_sha_region *sha_regions;
 	struct purgatory_info *pi = &image->purgatory_info;
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))
+	if (!IS_ENABLED(CONFIG_KEXEC_PURGATORY))
 		return 0;
 
 	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
@@ -829,7 +830,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
-#ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
+#ifdef CONFIG_KEXEC_PURGATORY
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
  * @pi:		Purgatory to be loaded.
@@ -1176,7 +1177,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
-#endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
+#endif /* CONFIG_KEXEC_PURGATORY */
 
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
-- 
2.25.1

