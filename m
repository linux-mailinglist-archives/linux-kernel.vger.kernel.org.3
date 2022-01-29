Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA64A301F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbiA2OxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:53:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345959AbiA2OxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:53:18 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 825541EC0501;
        Sat, 29 Jan 2022 15:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643467992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cHshVngJq2rwO4BYW6u5wwy9aor2jnSk3mNnGZCFeQ4=;
        b=I9w2BGpRd7Du3Z3a4oG7NtQvP1rlBG04XPwu/LamcY4sJa5Xi60LaYv5KA1u26ADvegk0o
        qSXQLASvqEpFoF17sFSEYLME4WcCcO/64tuHgCee+wPrqmOoc7o/UhImLabJ0f+FARCiyE
        ocaVnw9hFNgb1sx7ZIFVR7NgWlyhTXA=
Date:   Sat, 29 Jan 2022 15:53:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 05/29] x86/tdx: Add HLT support for TDX guests
Message-ID: <YfVU01dBD36H0EIv@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124150215.36893-6-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:01:51PM +0300, Kirill A. Shutemov wrote:
> @@ -870,6 +871,10 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
>  	} else if (prefer_mwait_c1_over_halt(c)) {
>  		pr_info("using mwait in idle threads\n");
>  		x86_idle = mwait_idle;
> +	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> +		pr_info("using TDX aware idle routine\n");
> +		x86_idle = tdx_safe_halt;
> +		return;

Forgot to remove that "return".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
