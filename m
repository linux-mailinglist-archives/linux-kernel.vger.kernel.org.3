Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BEB4BD7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiBUIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:25:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiBUIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:25:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039F219B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:24:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so3172723pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=tq75CxPMCVsoBqoIBKmpG9Xq9izNFXwI9AAm6hA/CT4=;
        b=g1ox4N0q3/fyf0qYN2sLLiquD2FI9oNIUkA61gPCc0TBPDWM2d4YlEvtpxZivUGyJX
         Tk+YfgfQWnGh0eZDR2i6adtW8UPiVKl/nvSWNMXGSM7PKN3YHQ35sQSueijw62jNynxx
         D98b5OFx4GQqGTjcj1wttKuSJLQpmB1K91HJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=tq75CxPMCVsoBqoIBKmpG9Xq9izNFXwI9AAm6hA/CT4=;
        b=htYuioxTHnxvz6wLAbKLmpEmkNpZSPJXdwJQpqS7/MkFqYM+mzVSbHiv3LCC8qy3+q
         q8rvvxoGDl/TyhrrumPFHb94CdKQ/CHxPMPO4Q31mSYLy44u0+k/8ynUVitb/pmRXZuM
         +n6ly1kAbspw6EO04nwSur+91u8XCMCwVqZZDytp7wHXJZmPoV3dhw+Iwxc7xmEp05vm
         Wf2x/0LLeRCeYV5Hc73ekcQxOZd9H9uy8r0n3C1jeaePxlHD8S0B5arSj40g4+E3JK1n
         ZCle6nAuJAC2DyJmXqpkONd55Yqa/4YJvjz300X+qxqXeRVdGCeVWRYp9CdeE5rBvB/b
         td+g==
X-Gm-Message-State: AOAM531YMeJCOTsX2dRo/oK9GhmA2uVS/ytQ8KK/kDhHhAIOqZU/6EfP
        1Gyiil+g9mD6v6mk2uvqjUuVbw==
X-Google-Smtp-Source: ABdhPJwv467EEXn83ohP6YsVPY3XLtA8IZfP5D2sF605P/pUBMkLYG+3vJTVZezi7/u0f/h6G/0G0w==
X-Received: by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id s16-20020a17090302d000b0014d8a8d0cb1mr17667986plk.50.1645431889105;
        Mon, 21 Feb 2022 00:24:49 -0800 (PST)
Received: from ?IPv6:::1? ([2600:6c55:6300:7238:34b8:edf8:24ec:9845])
        by smtp.gmail.com with ESMTPSA id ft9sm3370576pjb.4.2022.02.21.00.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 00:24:48 -0800 (PST)
Date:   Mon, 21 Feb 2022 00:24:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
User-Agent: K-9 Mail for Android
In-Reply-To: <20220218171409.395399333@infradead.org>
References: <20220218164902.008644515@infradead.org> <20220218171409.395399333@infradead.org>
Message-ID: <0429C271-3C3F-4A1A-8B4E-73A940AB96E9@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 18, 2022 8:49:16 AM PST, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>The bits required to make the hardware go=2E=2E Of note is that, provided
>the syscall entry points are covered with ENDBR, #CP doesn't need to
>be an IST because we'll never hit the syscall gap=2E
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>---
> arch/x86/include/asm/cpufeatures=2Eh          |    1=20
> arch/x86/include/asm/idtentry=2Eh             |    5 ++
> arch/x86/include/asm/msr-index=2Eh            |   20 ++++++++
> arch/x86/include/asm/traps=2Eh                |    2=20
> arch/x86/include/uapi/asm/processor-flags=2Eh |    2=20
> arch/x86/kernel/cpu/common=2Ec                |   23 +++++++++
> arch/x86/kernel/idt=2Ec                       |    4 +
> arch/x86/kernel/traps=2Ec                     |   65 +++++++++++++++++++=
+++++++++
> 8 files changed, 121 insertions(+), 1 deletion(-)
>
>--- a/arch/x86/include/asm/cpufeatures=2Eh
>+++ b/arch/x86/include/asm/cpufeatures=2Eh
>@@ -387,6 +387,7 @@
> #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tra=
cking */
> #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
> #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
>+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
> #define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
> #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
> #define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
>--- a/arch/x86/include/asm/idtentry=2Eh
>+++ b/arch/x86/include/asm/idtentry=2Eh
>@@ -622,6 +622,11 @@ DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_dou
> DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
> #endif
>=20
>+/* #CP */
>+#ifdef CONFIG_X86_IBT
>+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
>+#endif
>+
> /* #VC */
> #ifdef CONFIG_AMD_MEM_ENCRYPT
> DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
>--- a/arch/x86/include/asm/msr-index=2Eh
>+++ b/arch/x86/include/asm/msr-index=2Eh
>@@ -360,11 +360,29 @@
> #define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
> #define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
>=20
>-
> #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
> #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
> #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
>=20
>+/* Control-flow Enforcement Technology MSRs */
>+#define MSR_IA32_U_CET			0x000006a0 /* user mode cet */
>+#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet */
>+#define CET_SHSTK_EN			BIT_ULL(0)
>+#define CET_WRSS_EN			BIT_ULL(1)
>+#define CET_ENDBR_EN			BIT_ULL(2)
>+#define CET_LEG_IW_EN			BIT_ULL(3)
>+#define CET_NO_TRACK_EN			BIT_ULL(4)
>+#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
>+#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9=
))
>+#define CET_SUPPRESS			BIT_ULL(10)
>+#define CET_WAIT_ENDBR			BIT_ULL(11)
>+
>+#define MSR_IA32_PL0_SSP		0x000006a4 /* ring-0 shadow stack pointer */
>+#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
>+#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */
>+#define MSR_IA32_PL3_SSP		0x000006a7 /* ring-3 shadow stack pointer */
>+#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table=
 */
>+
> /* Hardware P state interface */
> #define MSR_PPERF			0x0000064e
> #define MSR_PERF_LIMIT_REASONS		0x0000064f
>--- a/arch/x86/include/asm/traps=2Eh
>+++ b/arch/x86/include/asm/traps=2Eh
>@@ -18,6 +18,8 @@ void __init trap_init(void);
> asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt=
_regs *eregs);
> #endif
>=20
>+extern bool ibt_selftest(void);
>+
> #ifdef CONFIG_X86_F00F_BUG
> /* For handling the FOOF bug */
> void handle_invalid_op(struct pt_regs *regs);
>--- a/arch/x86/include/uapi/asm/processor-flags=2Eh
>+++ b/arch/x86/include/uapi/asm/processor-flags=2Eh
>@@ -130,6 +130,8 @@
> #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
> #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
> #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
>+#define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technolog=
y */
>+#define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
>=20
> /*
>  * x86-64 Task Priority Register, CR8
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -59,6 +59,7 @@
> #include <asm/cpu_device_id=2Eh>
> #include <asm/uv/uv=2Eh>
> #include <asm/sigframe=2Eh>
>+#include <asm/traps=2Eh>
>=20
> #include "cpu=2Eh"
>=20
>@@ -592,6 +593,27 @@ static __init int setup_disable_pku(char
> __setup("nopku", setup_disable_pku);
> #endif /* CONFIG_X86_64 */
>=20
>+static __always_inline void setup_cet(struct cpuinfo_x86 *c)
>+{
>+	u64 msr;
>+
>+	if (!IS_ENABLED(CONFIG_X86_IBT) ||
>+	    !cpu_feature_enabled(X86_FEATURE_IBT))
>+		return;
>+
>+	cr4_set_bits(X86_CR4_CET);

Please add X86_CR4_CET to cr4_pinned_mask too=2E

>+
>+	rdmsrl(MSR_IA32_S_CET, msr);
>+	if (cpu_feature_enabled(X86_FEATURE_IBT))
>+		msr |=3D CET_ENDBR_EN;
>+	wrmsrl(MSR_IA32_S_CET, msr);
>+
>+	if (!ibt_selftest()) {
>+		pr_err("IBT selftest: Failed!\n");
>+		setup_clear_cpu_cap(X86_FEATURE_IBT);
>+	}
>+}
>+
> /*
>  * Some CPU features depend on higher CPUID levels, which may not always
>  * be available due to CPUID level capping or broken virtualization
>@@ -1709,6 +1731,7 @@ static void identify_cpu(struct cpuinfo_
>=20
> 	x86_init_rdrand(c);
> 	setup_pku(c);
>+	setup_cet(c);
>=20
> 	/*
> 	 * Clear/Set all flags overridden by options, need do it
>--- a/arch/x86/kernel/idt=2Ec
>+++ b/arch/x86/kernel/idt=2Ec
>@@ -104,6 +104,10 @@ static const __initconst struct idt_data
> 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
> #endif
>=20
>+#ifdef CONFIG_X86_IBT
>+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
>+#endif
>+
> #ifdef CONFIG_AMD_MEM_ENCRYPT
> 	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
> #endif
>--- a/arch/x86/kernel/traps=2Ec
>+++ b/arch/x86/kernel/traps=2Ec
>@@ -210,6 +210,71 @@ DEFINE_IDTENTRY(exc_overflow)
> 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
> }
>=20
>+#ifdef CONFIG_X86_IBT
>+
>+static bool ibt_fatal =3D true;

__ro_after_init please=2E :)

>+
>+extern unsigned long ibt_selftest_ip; /* defined in asm beow */
>+static volatile bool ibt_selftest_ok =3D false;
>+
>+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
>+{
>+	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
>+		pr_err("Whaaa?!?!\n");
>+		return;

Seems like this case should fail closed and not return?

>+	}
>+
>+	if (WARN_ON_ONCE(user_mode(regs) || error_code !=3D 3))
>+		return;
>+
>+	if (unlikely(regs->ip =3D=3D ibt_selftest_ip)) {
>+		ibt_selftest_ok =3D true;
>+		return;
>+	}
>+
>+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
>+	BUG_ON(ibt_fatal);
>+}
>+
>+bool ibt_selftest(void)
>+{
>+	ibt_selftest_ok =3D false;
>+
>+	asm (ANNOTATE_NOENDBR
>+	     "1: lea 2f(%%rip), %%rax\n\t"
>+	     ANNOTATE_RETPOLINE_SAFE
>+	     "   jmp *%%rax\n\t"
>+	     "2: nop\n\t"
>+
>+	     /* unsigned ibt_selftest_ip =3D 2b */
>+	     "=2Epushsection =2Edata,\"aw\"\n\t"
>+	     "=2Ealign 8\n\t"
>+	     "=2Etype ibt_selftest_ip, @object\n\t"
>+	     "=2Esize ibt_selftest_ip, 8\n\t"
>+	     "ibt_selftest_ip:\n\t"
>+	     "=2Equad 2b\n\t"
>+	     "=2Epopsection\n\t"
>+
>+	     : : : "rax", "memory");
>+
>+	return ibt_selftest_ok;
>+}
>+
>+static int __init ibt_setup(char *str)
>+{
>+	if (!strcmp(str, "off"))
>+		setup_clear_cpu_cap(X86_FEATURE_IBT);
>+
>+	if (!strcmp(str, "warn"))
>+		ibt_fatal =3D false;
>+
>+	return 1;
>+}
>+
>+__setup("ibt=3D", ibt_setup);
>+
>+#endif /* CONFIG_X86_IBT */
>+
> #ifdef CONFIG_X86_F00F_BUG
> void handle_invalid_op(struct pt_regs *regs)
> #else
>
>

--=20
Kees Cook
