Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1A4DBB49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350541AbiCPXon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350051AbiCPXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:44:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CE6324
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:43:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647474204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZw0o0A4wRb2qEwrMVhNIrLoqsDfPePK9xt/pyVjrAQ=;
        b=AU7pkwzrq7DJ8i89Uj8mtUuyF30EHQeHavZNNrdjXtGWh/R1Lh4T55fSsk3mQYz1e8SogC
        9UonoXlsiSYi/14nq2JJkib8PJsHFqZmBqyv5eN84AxLfpRCqcp1yIGBFv4cpwYbxpDneq
        Y4m3FRukny05JE8YNDtK2+SN8FEqM8/nGr0MMyYGyK68bHXgzTa0L8HWMd7unhpFtMeCyF
        bwBR8u8MOZofWAEJnCELU8Iuh6SFiUsVHwwEtWrY0oy261UVwjeUBt5/hivcmIBJkX+BHK
        mhGTPW/L7GU2BLgq6XuNgUdbWCahtEYUmMkxAfyYeXq3M82KAWh+B1mpSlmS5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647474204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZw0o0A4wRb2qEwrMVhNIrLoqsDfPePK9xt/pyVjrAQ=;
        b=kRwJIYwOEPlIMYqkWbloe/H5BYBwA/LOhKfuF3SKqOjaWQmyF8PspBBna2uW1N6QFMfgEd
        RHoxUaHjESk1f4CQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20220316020856.24435-4-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-4-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 00:43:23 +0100
Message-ID: <87ilsd31lw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> +/*
> + * Wrapper for standard use of __tdx_hypercall with no output aside from
> + * return code.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = fn,
> +		.r12 = r12,
> +		.r13 = r13,
> +		.r14 = r14,
> +		.r15 = r15,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}
> +
> +/* Called from __tdx_hypercall() for unrecoverable failure */
> +void __tdx_hypercall_failed(void)
> +{
> +	panic("TDVMCALL failed. TDX module bug?");
> +}
>  void __init tdx_early_init(void)

Lacks a new line before tdx_early_init().

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
