Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52A4BDF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiBUImz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiBUImw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:42:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DB12A9F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:42:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g1so8188581pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=jLGHn0A8QA9ZVTYR76VN7KaceCr6ZRTgtUrs93sqi2o=;
        b=GiLwPrKRHTUdxumr+0Ozaq1ncsrTZdFjrMT/Q5bmeMx5IBRkw4b3Vk8B7g/vcTdxfm
         FnJAuit2w64u/aN0bMCM/XXwJrtsY3nF55zyLzb9wmVp7vicoMrOVHk3mlP3NLqyaLOp
         WFVTkzfgclwhWWs3GkbYOxwe8lo5XOpTi7JSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=jLGHn0A8QA9ZVTYR76VN7KaceCr6ZRTgtUrs93sqi2o=;
        b=kW40CHexHRbEyu7BsOBIoa6UW897ciHqjLAbiogc8eyViJ2vLK2veQJS0hIA98FT48
         tEGDgwmt5H/1nhHDR/nulzRV1lN+gEHXx2MIY7/4yaBOE5V+PkT0+IhECSs3EVOKALTH
         iV0bynWJ6fcrMJHfYqu0/+fr4g9vUvDJzZtmSc9F1Xu3B5IWdjnxlKkPakQqfilbhFxH
         VYj2VE8gcczV6Pj8MQH5qVf86qyULAnoLqD9Kw01EN83K/6J0GrShCeqgLmL0GxIxKzg
         RaBH26uoZDJQY9QsD18N/ebjSa+yf7Dsdmkv1krATSSrUYnIF9OMG6lpHrYeTeFjkPgy
         MIvw==
X-Gm-Message-State: AOAM530aYXTikRh4noqbE65gwKNsmQU9QHle/XV3h1XYmzkKJkWbbdc2
        8X2//Y8J25tqmaP9YVOlBJgg9Q==
X-Google-Smtp-Source: ABdhPJwYX4hMuu13kCp5YZzyJJXzjfN+1tQYwEDNnLKraHcf/03z3gUqXHzynQgvK9mQWumPw/vFCw==
X-Received: by 2002:a63:6441:0:b0:372:c9d1:ea90 with SMTP id y62-20020a636441000000b00372c9d1ea90mr15575583pgb.249.1645432949776;
        Mon, 21 Feb 2022 00:42:29 -0800 (PST)
Received: from ?IPv6:::1? ([2600:6c55:6300:7238:34b8:edf8:24ec:9845])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a1fcb00b001bc58804974sm663127pjz.27.2022.02.21.00.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 00:42:29 -0800 (PST)
Date:   Mon, 21 Feb 2022 00:42:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
User-Agent: K-9 Mail for Android
In-Reply-To: <20220219095827.GI23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org> <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com> <20220219095827.GI23216@worktop.programming.kicks-ass.net>
Message-ID: <1C202B85-FCB1-4282-9CA6-ED9115F203BB@chromium.org>
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



On February 19, 2022 1:58:27 AM PST, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>On Sat, Feb 19, 2022 at 01:29:45AM +0000, Edgecombe, Rick P wrote:
>> On Fri, 2022-02-18 at 17:49 +0100, Peter Zijlstra wrote:
>> > This is an (almost!) complete Kernel IBT implementation=2E It's been
>> > self-hosting
>> > for a few days now=2E That is, it runs on IBT enabled hardware
>> > (Tigerlake) and is
>> > capable of building the next kernel=2E
>> >=20
>> > It is also almost clean on allmodconfig using GCC-11=2E2=2E
>> >=20
>> > The biggest TODO item at this point is Clang, I've not yet looked at
>> > that=2E
>>=20
>> Do you need to turn this off before kexec?
>
>Probably=2E=2E=2E :-) I've never looked at that code though; so I'm not
>exactly sure where to put things=2E
>
>I'm assuming kexec does a hot-unplug of all but the boot-cpu which then
>leaves only a single CPU with state in machine_kexec() ? Does the below
>look reasonable?
>
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -638,6 +638,12 @@ static __always_inline void setup_cet(st
> 	}
> }
>=20
>+void cet_disable(void)
>+{
>+	cr4_clear_bits(X86_CR4_CET);

I'd rather keep the pinning=2E=2E=2E

>+	wrmsrl(MSR_IA32_S_CET, 0);
>+}

Eh, why not just require kexec to be IBT safe? That seems a reasonable exe=
rcise if we ever expect UEFI to enforce IBT when starting the kernel on a n=
ormal boot=2E=2E=2E

-Kees

>+
> /*
>  * Some CPU features depend on higher CPUID levels, which may not always
>  * be available due to CPUID level capping or broken virtualization
>diff --git a/arch/x86/include/asm/cpu=2Eh b/arch/x86/include/asm/cpu=2Eh
>index 33d41e350c79=2E=2Ecf26356db53e 100644
>--- a/arch/x86/include/asm/cpu=2Eh
>+++ b/arch/x86/include/asm/cpu=2Eh
>@@ -72,4 +72,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
> #else
> static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
> #endif
>+
>+extern void cet_disable(void);
>+
> #endif /* _ASM_X86_CPU_H */
>diff --git a/arch/x86/kernel/machine_kexec_64=2Ec b/arch/x86/kernel/machi=
ne_kexec_64=2Ec
>index f5da4a18070a=2E=2E29a2a1732605 100644
>--- a/arch/x86/kernel/machine_kexec_64=2Ec
>+++ b/arch/x86/kernel/machine_kexec_64=2Ec
>@@ -310,6 +310,7 @@ void machine_kexec(struct kimage *image)
> 	/* Interrupts aren't acceptable while we reboot */
> 	local_irq_disable();
> 	hw_breakpoint_disable();
>+	cet_disable();
>=20
> 	if (image->preserve_context) {
> #ifdef CONFIG_X86_IO_APIC

--=20
Kees Cook
