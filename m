Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21387474E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhLNWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhLNWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:46:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2823C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YrdsNqyDgB0RTPzaYy+6NsMGBrEJQ8SFX1xoiSbqw+c=; b=hAIpW2jE+x2yUFWvYPh3vi1bQA
        0ZXHM6r0da9avi9VTud9HMlU2Gew3vhw+heCX8F9J7dkQM1n3vWkisVUWLVOQulqTkqF/Qu0+zO2c
        FwRsgOLYdVfjccLO/VjdP9Msw8Vx1sYYpS7MFVWhJywsyjm3GqQ8BVJE/58gEpsGQQSLT+ESsVWBL
        VWV7e/0FzLhuETsmKZZEgpDWoKpRQP+4+RZkBrq74U+bDKkLr+ABfX2UrDdsb2NdLerRFPFFP9oJb
        WQgz6jU6z7qrp5qlo7ujPZ9nfNKGQ8U37fl8KDmpeoW7y3Id19bdZiJ31++uN+8BEGAPFqQDt1TV2
        QeSQxr9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxGZ9-00E8gb-Rn; Tue, 14 Dec 2021 22:46:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F7B43001D0;
        Tue, 14 Dec 2021 23:46:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1C5E2058EE31; Tue, 14 Dec 2021 23:46:34 +0100 (CET)
Date:   Tue, 14 Dec 2021 23:46:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 16/23] x86,vmx: Provide asm-goto-output vmread
Message-ID: <Ybkeysfj85Ej9W03@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.840433319@infradead.org>
 <YbcbbGW2GcMx6KpD@hirez.programming.kicks-ass.net>
 <YbjmIPWtd6ke66CU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjmIPWtd6ke66CU@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:44:48PM +0000, Sean Christopherson wrote:

> This needs to route through a noinline vmread_error(), the intent is that KVM only
> does WARN once for all VMREAD failures, whereas having this inline will WARN once
> on each unique vmcs_read*().

Oh, fair enough.

> And at that point, we might as well hide the asm
> trampoline too.  The amount of ifdeffery gets a bit gross, but in for a penny in
> for a pound?
> 
> And like the other VMX instruction, I assume it's safe to annotate the failure
> path as instrumentation safe.
> 
> So this?

Yep, think so.

> ---
>  arch/x86/kvm/vmx/vmenter.S |  2 ++
>  arch/x86/kvm/vmx/vmx.c     |  7 +++++++
>  arch/x86/kvm/vmx/vmx_ops.h | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 3a6461694fc2..d8a7a0a69ec1 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -238,6 +238,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
> 
>  .section .text, "ax"
> 
> +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT

#ifndef ?

>  /**
>   * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
>   * @field:	VMCS field encoding that failed
