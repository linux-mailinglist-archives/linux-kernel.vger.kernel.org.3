Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC43A4BD7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbiBUI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:27:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245406AbiBUI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:27:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE512A98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:27:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso15920820pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Mr2BoYtb31MdV+XPz+c55LRfQ5ShVB+NJKIE9aF3JDA=;
        b=FIk7NA8r6IbSKOuUc5aajgjTq3bjgZp0huvOtWOl/DKJdhQTt7N4srPkTQSrHl6gab
         ePWgzrd465v8/X68Ol4h0UhYqBtQdOctA5G5qD5SS4UAQRgWT2G1XiFGOvtuSHRzuYz/
         qe8AS12nF1xw3ESJd2QYfHOgz/yxbTLqMEiCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Mr2BoYtb31MdV+XPz+c55LRfQ5ShVB+NJKIE9aF3JDA=;
        b=43qGwPm1bfYyZdSrXFzVyJ+MhC+vdB7rmL+vS/Kbk8Z4Qtq/IVF0YPqhcVtASaiMRQ
         sf3pJeUJMtIOq+u2cQoQCKhLmSoKmMiKuMU9URJ2TP91pNf/rQ2pNkqrIIngWow0L2I7
         JaicJUN0U2dey5J718ciBz5Krkp8Guu8CBq81tz4OeWCosC55scuASWioHSuYs10ThMi
         MEFK56D6g1+wmff9rur4u+QeBXvMs9560rasLz5tRDvNu/3eLUgJ8zFJUKsyCYMPkSYI
         4m5W1jczVXJKxFonlCjfVOxhQ59tJnm2l2cTzz3/8VcsR8+mXpWJK6yEASvzr6sijSN2
         7Qrw==
X-Gm-Message-State: AOAM530Dv2AVkMyxJeFnXsW1zTmkMyxB1eeofSVrUAPldShKz8Hem9/j
        4MfNva+C778s70xBAzDLX6uRcQ==
X-Google-Smtp-Source: ABdhPJzNwLbo0XeGJA0ueKqD968h+lgXGAPUsw1+JuUkPszC8hcTuOpeIxyLNOzgkidgJaVhBRd1oQ==
X-Received: by 2002:a17:903:1d0:b0:14d:a620:5828 with SMTP id e16-20020a17090301d000b0014da6205828mr17501446plh.64.1645432044153;
        Mon, 21 Feb 2022 00:27:24 -0800 (PST)
Received: from ?IPv6:::1? ([2600:6c55:6300:7238:34b8:edf8:24ec:9845])
        by smtp.gmail.com with ESMTPSA id f67sm17849518pgc.38.2022.02.21.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 00:27:23 -0800 (PST)
Date:   Mon, 21 Feb 2022 00:27:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com
Subject: Re: [PATCH 15/29] x86: Disable IBT around firmware
User-Agent: K-9 Mail for Android
In-Reply-To: <20220218171409.456054276@infradead.org>
References: <20220218164902.008644515@infradead.org> <20220218171409.456054276@infradead.org>
Message-ID: <831051EB-FF09-4B75-98EE-A7C8D0054CFE@chromium.org>
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



On February 18, 2022 8:49:17 AM PST, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>Assume firmware isn't IBT clean and disable it across calls=2E
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>---
> arch/x86/include/asm/efi=2Eh   |    9 +++++++--
> arch/x86/include/asm/ibt=2Eh   |   10 ++++++++++
> arch/x86/kernel/apm_32=2Ec     |    7 +++++++
> arch/x86/kernel/cpu/common=2Ec |   28 ++++++++++++++++++++++++++++
> 4 files changed, 52 insertions(+), 2 deletions(-)
>
>--- a/arch/x86/include/asm/efi=2Eh
>+++ b/arch/x86/include/asm/efi=2Eh
>@@ -7,6 +7,7 @@
> #include <asm/tlb=2Eh>
> #include <asm/nospec-branch=2Eh>
> #include <asm/mmu_context=2Eh>
>+#include <asm/ibt=2Eh>
> #include <linux/build_bug=2Eh>
> #include <linux/kernel=2Eh>
> #include <linux/pgtable=2Eh>
>@@ -120,8 +121,12 @@ extern asmlinkage u64 __efi_call(void *f
> 	efi_enter_mm();							\
> })
>=20
>-#define arch_efi_call_virt(p, f, args=2E=2E=2E)				\
>-	efi_call((void *)p->f, args)					\
>+#define arch_efi_call_virt(p, f, args=2E=2E=2E) ({				\
>+	u64 ret, ibt =3D ibt_save();					\
>+	ret =3D efi_call((void *)p->f, args);				\
>+	ibt_restore(ibt);						\
>+	ret;								\
>+})
>=20
> #define arch_efi_call_virt_teardown()					\
> ({									\
>--- a/arch/x86/include/asm/ibt=2Eh
>+++ b/arch/x86/include/asm/ibt=2Eh
>@@ -6,6 +6,8 @@
>=20
> #ifndef __ASSEMBLY__
>=20
>+#include <linux/types=2Eh>
>+
> #ifdef CONFIG_X86_64
> #define ASM_ENDBR	"endbr64\n\t"
> #else
>@@ -25,6 +27,9 @@ static inline bool is_endbr(const void *
> 	return val =3D=3D ~0xfa1e0ff3;
> }
>=20
>+extern u64 ibt_save(void);
>+extern void ibt_restore(u64 save);
>+
> #else /* __ASSEMBLY__ */
>=20
> #ifdef CONFIG_X86_64
>@@ -39,10 +44,15 @@ static inline bool is_endbr(const void *
>=20
> #ifndef __ASSEMBLY__
>=20
>+#include <linux/types=2Eh>
>+
> #define ASM_ENDBR
>=20
> #define __noendbr
>=20
>+static inline u64 ibt_save(void) { return 0; }
>+static inline void ibt_restore(u64 save) { }
>+
> #else /* __ASSEMBLY__ */
>=20
> #define ENDBR
>--- a/arch/x86/kernel/apm_32=2Ec
>+++ b/arch/x86/kernel/apm_32=2Ec
>@@ -232,6 +232,7 @@
> #include <asm/paravirt=2Eh>
> #include <asm/reboot=2Eh>
> #include <asm/nospec-branch=2Eh>
>+#include <asm/ibt=2Eh>
>=20
> #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
> extern int (*console_blank_hook)(int);
>@@ -598,6 +599,7 @@ static long __apm_bios_call(void *_call)
> 	struct desc_struct	save_desc_40;
> 	struct desc_struct	*gdt;
> 	struct apm_bios_call	*call =3D _call;
>+	u64			ibt;
>=20
> 	cpu =3D get_cpu();
> 	BUG_ON(cpu !=3D 0);
>@@ -607,11 +609,13 @@ static long __apm_bios_call(void *_call)
>=20
> 	apm_irq_save(flags);
> 	firmware_restrict_branch_speculation_start();
>+	ibt =3D ibt_save();
> 	APM_DO_SAVE_SEGS;
> 	apm_bios_call_asm(call->func, call->ebx, call->ecx,
> 			  &call->eax, &call->ebx, &call->ecx, &call->edx,
> 			  &call->esi);
> 	APM_DO_RESTORE_SEGS;
>+	ibt_restore(ibt);
> 	firmware_restrict_branch_speculation_end();
> 	apm_irq_restore(flags);
> 	gdt[0x40 / 8] =3D save_desc_40;
>@@ -676,6 +680,7 @@ static long __apm_bios_call_simple(void
> 	struct desc_struct	save_desc_40;
> 	struct desc_struct	*gdt;
> 	struct apm_bios_call	*call =3D _call;
>+	u64			ibt;
>=20
> 	cpu =3D get_cpu();
> 	BUG_ON(cpu !=3D 0);
>@@ -685,10 +690,12 @@ static long __apm_bios_call_simple(void
>=20
> 	apm_irq_save(flags);
> 	firmware_restrict_branch_speculation_start();
>+	ibt =3D ibt_save();
> 	APM_DO_SAVE_SEGS;
> 	error =3D apm_bios_call_simple_asm(call->func, call->ebx, call->ecx,
> 					 &call->eax);
> 	APM_DO_RESTORE_SEGS;
>+	ibt_restore(ibt);
> 	firmware_restrict_branch_speculation_end();
> 	apm_irq_restore(flags);
> 	gdt[0x40 / 8] =3D save_desc_40;
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -592,6 +592,34 @@ static __init int setup_disable_pku(char
> __setup("nopku", setup_disable_pku);
> #endif /* CONFIG_X86_64 */
>=20
>+#ifdef CONFIG_X86_IBT
>+
>+u64 ibt_save(void)
>+{
>+	u64 msr =3D 0;
>+
>+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
>+		rdmsrl(MSR_IA32_S_CET, msr);
>+		wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
>+	}
>+
>+	return msr;
>+}
>+
>+void ibt_restore(u64 save)

Please make these both __always_inline so there no risk of them ever gaini=
ng ENDBRs and being used by ROP to disable IBT=2E=2E=2E

>+{
>+	u64 msr;
>+
>+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
>+		rdmsrl(MSR_IA32_S_CET, msr);
>+		msr &=3D ~CET_ENDBR_EN;
>+		msr |=3D (save & CET_ENDBR_EN);
>+		wrmsrl(MSR_IA32_S_CET, msr);
>+	}
>+}
>+
>+#endif
>+
> static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> {
> 	u64 msr;
>
>

--=20
Kees Cook
