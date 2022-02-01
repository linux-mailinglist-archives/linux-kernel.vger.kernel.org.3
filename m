Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C34A6726
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiBAVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:39:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiBAVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:39:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643751576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcHaf3e/6oiN1KcirjfqMmosPqy3ruXHMgDwkzeKAZQ=;
        b=H7zLdTKdeI1edCC5U0hN+tUz+JROOtfgspgeUL+peO4efjz2oiXaeLskyQUgYG5RRlf8g6
        EVyknW6ICLVSJ2oh03rRN0gLY04eNrUSCqUOpPUlj8d6HG3TS90SHziEvVyLw1uthgmG9m
        O+AswFbh0Y9PK/TGkPc3wg/+YZHqudNRskbHoy1Nu29MVdz6H4MnLR8NJaYlKt2vfcbS5k
        07LDf+T2YQjaopJqYCS8XxsO85WKyrQmwK9XtBbrf4SiTVcbHu3328pnxz1baaHSeWmjpB
        irV3SMAoC3G+IjEUuYYc+8lRp+SlQXApRIcemITVRNq3blZGjyPiIif94pgZKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643751576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcHaf3e/6oiN1KcirjfqMmosPqy3ruXHMgDwkzeKAZQ=;
        b=Uf9hijGOx+1w8I62Exu2JJy88jsMMaGH5MOfbgHwPSIhVDrd4JtRrX1GtS0e7zP42Uw1dO
        9VgsXNun7OBhtgCA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 07/29] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220124150215.36893-8-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-8-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 22:39:35 +0100
Message-ID: <87y22uxo4o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> +static bool tdx_handle_cpuid(struct pt_regs *regs)
> +{
> +	struct tdx_hypercall_output out;
> +
> +	/*
> +	 * Emulate the CPUID instruction via a hypercall. More info about
> +	 * ABI can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
> +	 */
> +	if (_tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out))
> +		return false;
> +
> +	/*
> +	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
> +	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
> +	 * So copy the register contents back to pt_regs.
> +	 */
> +	regs->ax = out.r12;
> +	regs->bx = out.r13;
> +	regs->cx = out.r14;
> +	regs->dx = out.r15;
> +
> +	return true;
> +}

Ack.

>  bool tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -157,8 +182,18 @@ bool tdx_get_ve_info(struct ve_info *ve)
>   */
>  static bool tdx_virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  {
> -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> -	return false;
> +	bool ret = false;
> +
> +	switch (ve->exit_reason) {
> +	case EXIT_REASON_CPUID:
> +		ret = tdx_handle_cpuid(regs);
> +		break;

Comment about ret and break applies accordingly.

Thanks,

        tglx
