Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26EB596D12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiHQK4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiHQK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:56:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39E69F59
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PxdB5u3XruAGLNJxHMGVmjg/UlyRoavqBo/jIEIV4wg=; b=IfVOxl60HRLVkn2UFQj5X3ak59
        x4w0CsPpP2FTm9/Y5rN7hC2V5kOAX7Id+qG2HcnMKe+S5z1kgDMMsYxZbnsih9r09PA6KDgBZihjW
        TinTm0xFBwyT87Nwrzu2lGaJMyVraeh47UlLZBcwj9CrZuLQZsphqKpDULPbim4hUiCan7FFQMN0E
        4dblHzcJfzaZ8oz3v5O20X8nAfdZZChCW86eSu+XyLN73LV0tQUjyASSll0Dg5Ypl1n0imYSV3Qs8
        q9/Vr2mhrhuwvoyooUtFVr1YhvbOcX1T7ic+KkX8hTs3sVNXIPsOvxlkthkBPWi3jNnpZS3e8kATG
        3lmrQ3tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOGif-008464-Ny; Wed, 17 Aug 2022 10:56:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8642980256; Wed, 17 Aug 2022 12:56:15 +0200 (CEST)
Date:   Wed, 17 Aug 2022 12:56:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>
Cc:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, pbonzini@redhat.com,
        x86@kernel.org
Subject: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 02:44:28AM +0000, Xu, Pengfei wrote:
> Hi Peter,
> 
> Greeting!

You again forgot to Cc LKML and relevant people...

> Platform: ADL-P (I tried that TGL-H could reproduce this issue also)
> Kernel: 5.19 mainline kernel with kernel IBT enabled.
> 
> Boot up ADL-P,  and then run syzkaller fuzzing tests, syzkaller will start up guests(Guest kernel is 5.19 mainline also but doesn't enable kernel IBT) to do fuzzing tests.
> After about 1 hour later,  there was "traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]" info generated.
> 
> [ 5048.057266] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
> [ 5048.057440] ------------[ cut here ]------------
> [ 5048.057457] kernel BUG at arch/x86/kernel/traps.c:253!
> [ 5048.057482] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 5048.057908]  <TASK>
> [ 5048.057919]  asm_exc_control_protection+0x2b/0x30
> [ 5048.057940] RIP: 0010:andw_ax_dx+0x0/0x10 [kvm]
> [ 5048.057999] Code: c3 cc cc cc cc 0f 1f 44 00 00 66 0f 1f 00 48 19 d0 c3 cc cc cc cc 0f 1f 40 00 f3 0f 1e fa 20 d0 c3 cc cc cc cc 0f 1f 44 00 00 <66> 0f 1f 00 66 21 d0 c3 cc cc cc cc 0f 1f 40 00 66 0f 1f 00 21 d0
> ...
> [ 5048.058209]  ? andb_al_dl+0x10/0x10 [kvm]
> [ 5048.058265]  ? fastop+0x5d/0xa0 [kvm]
> [ 5048.058320]  x86_emulate_insn+0x822/0x1060 [kvm]
> [ 5048.058376]  x86_emulate_instruction+0x46f/0x750 [kvm]
> [ 5048.058433]  complete_emulated_mmio+0x216/0x2c0 [kvm]
> [ 5048.058488]  kvm_arch_vcpu_ioctl_run+0x604/0x650 [kvm]
> [ 5048.058543]  kvm_vcpu_ioctl+0x2f4/0x6b0 [kvm]
> [ 5048.058590]  ? wake_up_q+0xa0/0xa0
> ...
> [ 6324.778942] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
> ...
> [ 8760.430810] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]

Urgh, fastops again :/

> Dmesg and all the ko files  in "/lib/modules/5.19.0-m2/kernel/arch/x86" are in attached.

From your kvm.ko:

00000000000376f0 <andw_ax_dx>:
   376f0:       f3 0f 1e fa             endbr64
   376f4:       66 21 d0                and    %dx,%ax
   376f7:       e9 00 00 00 00          jmp    376fc <andw_ax_dx+0xc>   376f8: R_X86_64_PLT32   __x86_return_thunk-0x4
   376fc:       0f 1f 40 00             nopl   0x0(%rax)

However, the Code: thing above gives:

  2a:*  66 0f 1f 00             nopw   (%rax)           <-- trapping instruction
  2e:   66 21 d0                and    %dx,%ax
  31:   c3                      ret
  32:   cc                      int3
  33:   cc                      int3
  34:   cc                      int3
  35:   cc                      int3
  36:   0f 1f 40 00             nopl   0x0(%rax)

From that we can tell gen_endbr_poison() has been used to scribble the
endbr -- so clearly objtool didn't manage to find code references here.

And indeed, kvm.ko's .rela.ibt_endbr_seal section includes:

00000000000002c0  0000000100000002 R_X86_64_PC32          0000000000000000 .text + 376f0

---
Subject: x86/kvm, objtool: Avoid fastop ENDBR from being sealed

Xu reported a number of "Missing ENDBR" triggers for the KVM fastop
emulation code. It turns out that because of how the fastops are set up,
only the first of a series -- the 8 byte variants that overlap with the
em_ symbols -- is found referenced.

Specifically:

        .pushsection .text, "ax"
        .global em_and
        .align 16
        em_and:
        .align 16
        .type andb_al_dl, @function
        andb_al_dl:
        endbr64
        andb %dl, %al
        11: jmp __x86_return_thunk
        .size andb_al_dl, .-andb_al_dl
        .align 16
        .type andw_ax_dx, @function
        andw_ax_dx:
        endbr64
        andw %dx, %ax
        11: jmp __x86_return_thunk
        .size andw_ax_dx, .-andw_ax_dx
        .align 16
        .type andl_eax_edx, @function
        andl_eax_edx:
        endbr64
        andl %edx, %eax
        11: jmp __x86_return_thunk
        .size andl_eax_edx, .-andl_eax_edx
        .align 16
        .type andq_rax_rdx, @function
        andq_rax_rdx:
        endbr64
        andq %rdx, %rax
        11: jmp __x86_return_thunk
        .size andq_rax_rdx, .-andq_rax_rdx
        .popsection

Only has the em_and symbol referenced, resulting in and{w,l,q}_* getting
sealed.

Add (yet another) annotation to inhibit objtool from sealing a specific
ENDBR instance.

Fixes: 6649fa876da4 ("x86/ibt,kvm: Add ENDBR to fastops")
Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ibt.h |  5 +++++
 arch/x86/kvm/emulate.c     |  4 ++--
 include/linux/objtool.h    |  6 ++++++
 tools/objtool/check.c      | 44 ++++++++++++++++++++++++++++++++++++++------
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880eca9ba..f32ba1c4e619 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -29,6 +29,10 @@
 #define ASM_ENDBR	"endbr32\n\t"
 #endif
 
+#define ASM_ENDBR_NOSEAL	\
+	ANNOTATE_NOSEAL		\
+	ASM_ENDBR
+
 #define __noendbr	__attribute__((nocf_check))
 
 static inline __attribute_const__ u32 gen_endbr(void)
@@ -84,6 +88,7 @@ extern __noendbr void ibt_restore(u64 save);
 #ifndef __ASSEMBLY__
 
 #define ASM_ENDBR
+#define ASM_ENDBR_NOSEAL
 
 #define __noendbr
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b4eeb7c75dfa..d51ee8a3bcae 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -326,7 +326,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t" \
-	ASM_ENDBR
+	ASM_ENDBR_NOSEAL
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
@@ -461,7 +461,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(SETCC_ALIGN) " \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
-	ASM_ENDBR \
+	ASM_ENDBR_NOSEAL \
 	#op " %al \n\t" \
 	__FOP_RET(#op) \
 	".skip " __stringify(SETCC_ALIGN) " - (.-" #op "), 0xcc \n\t"
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ffbeeaa..ad752f8b3b36 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -90,6 +90,12 @@ struct unwind_hint {
 	_ASM_PTR " 986b\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_NOSEAL						\
+	"986: \n\t"						\
+	".pushsection .discard.noseal\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74da7ffe..0d04d0a707f4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2111,6 +2111,40 @@ static int read_noendbr_hints(struct objtool_file *file)
 	return 0;
 }
 
+static void mark_endbr_used(struct instruction *insn)
+{
+	if (!list_empty(&insn->call_node))
+		list_del_init(&insn->call_node);
+}
+
+static int read_noseal_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.noseal");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
+		if (!insn) {
+			WARN("bad .discard.noseal entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_ENDBR) {
+			WARN_FUNC("ANNOTATE_NOSEAL not on ENDBR", insn->sec, insn->offset);
+			continue;
+		}
+
+		mark_endbr_used(insn);
+	}
+
+	return 0;
+}
+
 static int read_retpoline_hints(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2356,6 +2390,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noseal_hints(file);
+	if (ret)
+		return ret;
+
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
@@ -3952,12 +3990,6 @@ static int validate_functions(struct objtool_file *file)
 	return warnings;
 }
 
-static void mark_endbr_used(struct instruction *insn)
-{
-	if (!list_empty(&insn->call_node))
-		list_del_init(&insn->call_node);
-}
-
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
