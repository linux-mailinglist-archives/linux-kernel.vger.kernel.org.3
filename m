Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE48550AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiFSNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiFSNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:12:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98362DE4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:12:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655644360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iup7jqj4HKk8NAHRLdcZUmwZbJJqOWQTBSlxI3PY8FI=;
        b=4FfJnHRwtVDPty0CHnz3OKRTR2RUIzzvNM/Nw3nkN10fIu7PO312AFS0EHl9MkS9PfCRrz
        g7Cc9q4QXueqWmhgLCTSsdGE5LOwe7ZW5AgIGRR8Y4pPsiPNAoJj49nUyvzBcXR+ri113b
        bZWnaSl3jpC7zIpHnKpwcgxGb9ASw8cXUHIe0B0cox0J2VgKuFw2zPHDph6+QkNx8j8Cf+
        /uHiqN74hVokdmrryGQRRG3/kdCjPHsEuNoClFqlo/4/tn5bR6gIyqjSLW6XNIrdPa2Tq8
        8zdiT/XkFtlET1KVDaE3iYMoGbhSqiFdGFCQ1y9QrInem+V4/16eCpjM+IuOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655644360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=iup7jqj4HKk8NAHRLdcZUmwZbJJqOWQTBSlxI3PY8FI=;
        b=zflDCboh1geZFfgzjyngIdw8CLPlit4FNnqt3XE/BZZLiaO/2f5BED9UAv9jPfX0Z2twvd
        BrfcPEfGsJHh/7DA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.19-rc3
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
Message-ID: <165564430323.1413209.8199754494182196241.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Jun 2022 15:12:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
06-19

up to:  1e7769653b06: x86/tdx: Handle load_unaligned_zeropad() page-cross to =
a shared page


X86 updates:

 - Make RESERVE_BRK() work again with older binutils. The recent
   'simplification' broke that.

 - Make early #VE handling increment RIP when successful.

 - Make the #VE code consistent vs. the RIP adjustments and add comments.

 - Handle load_unaligned_zeropad() across page boundaries correctly in #VE
   when the second page is shared.



Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      x86/mm: Fix RESERVE_BRK() for older binutils

Kirill A. Shutemov (3):
      x86/tdx: Fix early #VE handling
      x86/tdx: Clarify RIP adjustments in #VE handler
      x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page


 arch/x86/coco/tdx/tdx.c       | 187 ++++++++++++++++++++++++++++++----------=
--
 arch/x86/include/asm/setup.h  |  38 +++++----
 arch/x86/kernel/setup.c       |   5 --
 arch/x86/kernel/vmlinux.lds.S |   4 +-
 4 files changed, 159 insertions(+), 75 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..928dcf7a20d9 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -124,6 +124,51 @@ static u64 get_cc_mask(void)
 	return BIT_ULL(gpa_width - 1);
 }
=20
+/*
+ * The TDX module spec states that #VE may be injected for a limited set of
+ * reasons:
+ *
+ *  - Emulation of the architectural #VE injection on EPT violation;
+ *
+ *  - As a result of guest TD execution of a disallowed instruction,
+ *    a disallowed MSR access, or CPUID virtualization;
+ *
+ *  - A notification to the guest TD about anomalous behavior;
+ *
+ * The last one is opt-in and is not used by the kernel.
+ *
+ * The Intel Software Developer's Manual describes cases when instruction
+ * length field can be used in section "Information for VM Exits Due to
+ * Instruction Execution".
+ *
+ * For TDX, it ultimately means GET_VEINFO provides reliable instruction len=
gth
+ * information if #VE occurred due to instruction execution, but not for EPT
+ * violations.
+ */
+static int ve_instr_len(struct ve_info *ve)
+{
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+	case EXIT_REASON_MSR_READ:
+	case EXIT_REASON_MSR_WRITE:
+	case EXIT_REASON_CPUID:
+	case EXIT_REASON_IO_INSTRUCTION:
+		/* It is safe to use ve->instr_len for #VE due instructions */
+		return ve->instr_len;
+	case EXIT_REASON_EPT_VIOLATION:
+		/*
+		 * For EPT violations, ve->insn_len is not defined. For those,
+		 * the kernel must decode instructions manually and should not
+		 * be using this function.
+		 */
+		WARN_ONCE(1, "ve->instr_len is not defined for EPT violations");
+		return 0;
+	default:
+		WARN_ONCE(1, "Unexpected #VE-type: %lld\n", ve->exit_reason);
+		return ve->instr_len;
+	}
+}
+
 static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
 {
 	struct tdx_hypercall_args args =3D {
@@ -147,7 +192,7 @@ static u64 __cpuidle __halt(const bool irq_disabled, cons=
t bool do_sti)
 	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
 }
=20
-static bool handle_halt(void)
+static int handle_halt(struct ve_info *ve)
 {
 	/*
 	 * Since non safe halt is mainly used in CPU offlining
@@ -158,9 +203,9 @@ static bool handle_halt(void)
 	const bool do_sti =3D false;
=20
 	if (__halt(irq_disabled, do_sti))
-		return false;
+		return -EIO;
=20
-	return true;
+	return ve_instr_len(ve);
 }
=20
 void __cpuidle tdx_safe_halt(void)
@@ -180,7 +225,7 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
=20
-static bool read_msr(struct pt_regs *regs)
+static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args =3D {
 		.r10 =3D TDX_HYPERCALL_STANDARD,
@@ -194,14 +239,14 @@ static bool read_msr(struct pt_regs *regs)
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
=20
 	regs->ax =3D lower_32_bits(args.r11);
 	regs->dx =3D upper_32_bits(args.r11);
-	return true;
+	return ve_instr_len(ve);
 }
=20
-static bool write_msr(struct pt_regs *regs)
+static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args =3D {
 		.r10 =3D TDX_HYPERCALL_STANDARD,
@@ -215,10 +260,13 @@ static bool write_msr(struct pt_regs *regs)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	return !__tdx_hypercall(&args, 0);
+	if (__tdx_hypercall(&args, 0))
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
=20
-static bool handle_cpuid(struct pt_regs *regs)
+static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args =3D {
 		.r10 =3D TDX_HYPERCALL_STANDARD,
@@ -236,7 +284,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 */
 	if (regs->ax < 0x40000000 || regs->ax > 0x4FFFFFFF) {
 		regs->ax =3D regs->bx =3D regs->cx =3D regs->dx =3D 0;
-		return true;
+		return ve_instr_len(ve);
 	}
=20
 	/*
@@ -245,7 +293,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
-		return false;
+		return -EIO;
=20
 	/*
 	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
@@ -257,7 +305,7 @@ static bool handle_cpuid(struct pt_regs *regs)
 	regs->cx =3D args.r14;
 	regs->dx =3D args.r15;
=20
-	return true;
+	return ve_instr_len(ve);
 }
=20
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
@@ -283,10 +331,10 @@ static bool mmio_write(int size, unsigned long addr, un=
signed long val)
 			       EPT_WRITE, addr, val);
 }
=20
-static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
+	unsigned long *reg, val, vaddr;
 	char buffer[MAX_INSN_SIZE];
-	unsigned long *reg, val;
 	struct insn insn =3D {};
 	enum mmio_type mmio;
 	int size, extend_size;
@@ -294,34 +342,49 @@ static bool handle_mmio(struct pt_regs *regs, struct ve=
_info *ve)
=20
 	/* Only in-kernel MMIO is supported */
 	if (WARN_ON_ONCE(user_mode(regs)))
-		return false;
+		return -EFAULT;
=20
 	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
-		return false;
+		return -EFAULT;
=20
 	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
-		return false;
+		return -EINVAL;
=20
 	mmio =3D insn_decode_mmio(&insn, &size);
 	if (WARN_ON_ONCE(mmio =3D=3D MMIO_DECODE_FAILED))
-		return false;
+		return -EINVAL;
=20
 	if (mmio !=3D MMIO_WRITE_IMM && mmio !=3D MMIO_MOVS) {
 		reg =3D insn_get_modrm_reg_ptr(&insn, regs);
 		if (!reg)
-			return false;
+			return -EINVAL;
 	}
=20
-	ve->instr_len =3D insn.length;
+	/*
+	 * Reject EPT violation #VEs that split pages.
+	 *
+	 * MMIO accesses are supposed to be naturally aligned and therefore
+	 * never cross page boundaries. Seeing split page accesses indicates
+	 * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
+	 *
+	 * load_unaligned_zeropad() will recover using exception fixups.
+	 */
+	vaddr =3D (unsigned long)insn_get_addr_ref(&insn, regs);
+	if (vaddr / PAGE_SIZE !=3D (vaddr + size - 1) / PAGE_SIZE)
+		return -EFAULT;
=20
 	/* Handle writes first */
 	switch (mmio) {
 	case MMIO_WRITE:
 		memcpy(&val, reg, size);
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_WRITE_IMM:
 		val =3D insn.immediate.value;
-		return mmio_write(size, ve->gpa, val);
+		if (!mmio_write(size, ve->gpa, val))
+			return -EIO;
+		return insn.length;
 	case MMIO_READ:
 	case MMIO_READ_ZERO_EXTEND:
 	case MMIO_READ_SIGN_EXTEND:
@@ -334,15 +397,15 @@ static bool handle_mmio(struct pt_regs *regs, struct ve=
_info *ve)
 		 * decoded or handled properly. It was likely not using io.h
 		 * helpers or accessed MMIO accidentally.
 		 */
-		return false;
+		return -EINVAL;
 	default:
 		WARN_ONCE(1, "Unknown insn_decode_mmio() decode value?");
-		return false;
+		return -EINVAL;
 	}
=20
 	/* Handle reads */
 	if (!mmio_read(size, ve->gpa, &val))
-		return false;
+		return -EIO;
=20
 	switch (mmio) {
 	case MMIO_READ:
@@ -364,13 +427,13 @@ static bool handle_mmio(struct pt_regs *regs, struct ve=
_info *ve)
 	default:
 		/* All other cases has to be covered with the first switch() */
 		WARN_ON_ONCE(1);
-		return false;
+		return -EINVAL;
 	}
=20
 	if (extend_size)
 		memset(reg, extend_val, extend_size);
 	memcpy(reg, &val, size);
-	return true;
+	return insn.length;
 }
=20
 static bool handle_in(struct pt_regs *regs, int size, int port)
@@ -421,13 +484,14 @@ static bool handle_out(struct pt_regs *regs, int size, =
int port)
  *
  * Return True on success or False on failure.
  */
-static bool handle_io(struct pt_regs *regs, u32 exit_qual)
+static int handle_io(struct pt_regs *regs, struct ve_info *ve)
 {
+	u32 exit_qual =3D ve->exit_qual;
 	int size, port;
-	bool in;
+	bool in, ret;
=20
 	if (VE_IS_IO_STRING(exit_qual))
-		return false;
+		return -EIO;
=20
 	in   =3D VE_IS_IO_IN(exit_qual);
 	size =3D VE_GET_IO_SIZE(exit_qual);
@@ -435,9 +499,13 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qua=
l)
=20
=20
 	if (in)
-		return handle_in(regs, size, port);
+		ret =3D handle_in(regs, size, port);
 	else
-		return handle_out(regs, size, port);
+		ret =3D handle_out(regs, size, port);
+	if (!ret)
+		return -EIO;
+
+	return ve_instr_len(ve);
 }
=20
 /*
@@ -447,13 +515,19 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qu=
al)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
+	int insn_len;
=20
 	tdx_get_ve_info(&ve);
=20
 	if (ve.exit_reason !=3D EXIT_REASON_IO_INSTRUCTION)
 		return false;
=20
-	return handle_io(regs, ve.exit_qual);
+	insn_len =3D handle_io(regs, &ve);
+	if (insn_len < 0)
+		return false;
+
+	regs->ip +=3D insn_len;
+	return true;
 }
=20
 void tdx_get_ve_info(struct ve_info *ve)
@@ -486,54 +560,65 @@ void tdx_get_ve_info(struct ve_info *ve)
 	ve->instr_info  =3D upper_32_bits(out.r10);
 }
=20
-/* Handle the user initiated #VE */
-static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the user initiated #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=3D0)
+ * or -errno on error.
+ */
+static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
=20
-/* Handle the kernel #VE */
-static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
+/*
+ * Handle the kernel #VE.
+ *
+ * On success, returns the number of bytes RIP should be incremented (>=3D0)
+ * or -errno on error.
+ */
+static int virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 {
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
-		return handle_halt();
+		return handle_halt(ve);
 	case EXIT_REASON_MSR_READ:
-		return read_msr(regs);
+		return read_msr(regs, ve);
 	case EXIT_REASON_MSR_WRITE:
-		return write_msr(regs);
+		return write_msr(regs, ve);
 	case EXIT_REASON_CPUID:
-		return handle_cpuid(regs);
+		return handle_cpuid(regs, ve);
 	case EXIT_REASON_EPT_VIOLATION:
 		return handle_mmio(regs, ve);
 	case EXIT_REASON_IO_INSTRUCTION:
-		return handle_io(regs, ve->exit_qual);
+		return handle_io(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-		return false;
+		return -EIO;
 	}
 }
=20
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 {
-	bool ret;
+	int insn_len;
=20
 	if (user_mode(regs))
-		ret =3D virt_exception_user(regs, ve);
+		insn_len =3D virt_exception_user(regs, ve);
 	else
-		ret =3D virt_exception_kernel(regs, ve);
+		insn_len =3D virt_exception_kernel(regs, ve);
+	if (insn_len < 0)
+		return false;
=20
 	/* After successful #VE handling, move the IP */
-	if (ret)
-		regs->ip +=3D ve->instr_len;
+	regs->ip +=3D insn_len;
=20
-	return ret;
+	return true;
 }
=20
 static bool tdx_tlb_flush_required(bool private)
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 7590ac2570b9..f8b9ee97a891 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,19 +108,16 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
=20
 /*
- * Reserve space in the brk section.  The name must be unique within the fil=
e,
- * and somewhat descriptive.  The size is in bytes.
+ * Reserve space in the .brk section, which is a block of memory from which =
the
+ * caller is allowed to allocate very early (before even memblock is availab=
le)
+ * by calling extend_brk().  All allocated memory will be eventually convert=
ed
+ * to memblock.  Any leftover unallocated memory will be freed.
  *
- * The allocation is done using inline asm (rather than using a section
- * attribute on a normal variable) in order to allow the use of @nobits, so
- * that it doesn't take up any space in the vmlinux file.
+ * The size is in bytes.
  */
-#define RESERVE_BRK(name, size)						\
-	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
-	    ".brk." #name ":\n\t"					\
-	    ".skip " __stringify(size) "\n\t"				\
-	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
-	    ".popsection\n\t")
+#define RESERVE_BRK(name, size)					\
+	__section(".bss..brk") __aligned(1) __used	\
+	static char __brk_##name[size]
=20
 extern void probe_roms(void);
 #ifdef __i386__
@@ -133,12 +130,19 @@ asmlinkage void __init x86_64_start_reservations(char *=
real_mode_data);
=20
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .bss..brk, "aw"
+SYM_DATA_START(__brk_\name)
+	.skip \size
+SYM_DATA_END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3ebb85327edb..bd6c6fd373ae 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -67,11 +67,6 @@ RESERVE_BRK(dmi_alloc, 65536);
 #endif
=20
=20
-/*
- * Range of the BSS area. The size of the BSS area is determined
- * at link time, with RESERVE_BRK() facility reserving additional
- * chunks.
- */
 unsigned long _brk_start =3D (unsigned long)__brk_base;
 unsigned long _brk_end   =3D (unsigned long)__brk_base;
=20
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f5f6dc2e8007..81aba718ecd5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -385,10 +385,10 @@ SECTIONS
 	__end_of_kernel_reserve =3D .;
=20
 	. =3D ALIGN(PAGE_SIZE);
-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base =3D .;
 		. +=3D 64 * 1024;		/* 64k alignment slop space */
-		*(.brk_reservation)	/* areas brk users have reserved */
+		*(.bss..brk)		/* areas brk users have reserved */
 		__brk_limit =3D .;
 	}
=20

