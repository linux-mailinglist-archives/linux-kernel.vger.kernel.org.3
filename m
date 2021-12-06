Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD646A1BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhLFQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhLFQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:51:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CFC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:47:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10888336wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GpiAk0DSMvAlgtKzbQ5d7fVfV7JAeUwlfTvh4M7YeQ=;
        b=H0ACRpOrlkuZ+2oLswQD6lI8QLcF2zmvJ4iy/w3gD1eP/5FszSllu5VXK5M+wbrrqR
         /NeWy4fT52wH4AarMNyhulXGd+DFQsbIZn/XLLPqrDaVC8iN2ZkcbtXrhLYumV/XFVXM
         7jyP3Yg6NZhuE+MyNZnENES5zpmthXHQ0AekesOlZu0b3eBNKtZsfK8sM3V54I18ci/d
         NJToq1J0YvNm6pjtJaapJ36VU2Dd3gPFNLeqn/708b5YyMA7HipVTIijeons4S0R8za5
         HwqGDTzy7RjTHezEUtbjTLoGG/3FQOOX+hYjC2Fw8oCsAR/S9PvL4kZYTUXDBf4TsH76
         0x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GpiAk0DSMvAlgtKzbQ5d7fVfV7JAeUwlfTvh4M7YeQ=;
        b=gv2GWkOFYfNBx1t91E05ddhNfH1XEHPVkkmMCG4kMBBtEpVMjLfwjSsJBvGQBpBSqD
         dKltAfFCIhYcW78Wl9jR3b3IoErBPUCr3BtW+QihZoj/EKNyvylMyN4JxowCtpDyn4wB
         NSGlMm0nevg51LOvm44QJD5cNlbLUcQ+7fPuoGn77VYQWeB3Nfxyki0o9g8oB0TElvgR
         Q6BiU/UR1DGpuvwhrpzlrhK08fYKqRzztb6vZnaEi3TW4tbN9Hg8CVZNuO/g0889CXPr
         11zkheg36LQf/y4xWZ1Rog+uSb7nQMVHrtalEbsl4iUSfYJAVW6coVE9HohCwojIaTcy
         1RRw==
X-Gm-Message-State: AOAM530elP6sQ/F/0r4GN9KQRl+hbt2NV+AyEItbsi7NT0imHFM7kTm9
        FpJ2LHXRJjTBO7PtihTGOvFk7w==
X-Google-Smtp-Source: ABdhPJyIL2P2DSvvGCJP6XYyJwddeSDbqzBTDK6nC0qtNsaKGiuym4M8/hV1+CKs8MBCKmKkDhf4Vw==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr41511242wmz.19.1638809266329;
        Mon, 06 Dec 2021 08:47:46 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:f209:703c:1a57:7e])
        by smtp.gmail.com with ESMTPSA id z8sm12394538wrh.54.2021.12.06.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:47:46 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
        bp@alien8.de, tglx@linutronix.de, ebiederm@xmission.com,
        bhe@redhat.com, dyoung@redhat.com
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v3] x86/purgatory: convert CONFIG_ARCH_HAS_KEXEC_PURGATORY to be user selectable
Date:   Mon,  6 Dec 2021 16:47:24 +0000
Message-Id: <20211206164724.2125489-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the existing config option that only enabled
purgatory for specific architectures in which it has been currently
implemented (x86, powerpc and s390) to an option that allows purgatory
to be disabled (with default enabled) and only provides code to disable
purgatory for x86 only. This would give the option to make kexec operation
on x86 similar to arm64 or riscv, i.e. skipping purgatory.

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
v3 changes:
 - Updated commit mesage to make the patch clearer.

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

