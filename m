Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA14D4DC5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiCQM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCQM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140C1A94A5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:25:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647519913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gb79sWi4m4dbNXtJsnSEmI57RBmlXzY8WCvcSqnzS1E=;
        b=gIaYZfMbTeIiC91pw08dBS1Rb4TzR6MC3rRrBlTBcBjfDfUoAk8GPPrCDmpWVDq6fE9lms
        i/rMd38P8hIIjkoiVbu/GX8SsnVTA0SoxqiBiCvCScFO9i0f+pmU0co4Ar8WqXPRJ1iCRc
        3SiZNYfBu/kBhOrYzkdLRa12i8sUmBpysUfKqvlDU1WVoB8jgn7rLfvrxMob5qwUeWWEti
        q0e720Nmq0INFNrhKtopIQRwcGgt4vjRaMU2CWEv2y2yo0D+EK8XhgWGbAZw56Edn4/ESf
        /z46TMnY8IOjcyTX+4dsAREhx0CPnNvOHtWDASrNxELc1cCsna5PGSg1NgGCPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647519913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gb79sWi4m4dbNXtJsnSEmI57RBmlXzY8WCvcSqnzS1E=;
        b=9ohosx+HfP+VpvFJFXUtIlU5IMJop5iV5lidOJR3mMZBjrNMXydwC3hSDf2SAfgtotUvTy
        X7UeQtKVIYXKdyCg==
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
Subject: Re: [PATCHv6 17/30] x86/tdx: Port I/O: add runtime hypercalls
In-Reply-To: <20220316020856.24435-18-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-18-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:25:13 +0100
Message-ID: <877d8s22c6.ffs@tglx>
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
> +static bool handle_in(struct pt_regs *regs, int size, int port)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
> +		.r12 = size,
> +		.r13 = PORT_READ,
> +		.r14 = port,
> +	};
> +	bool success;
> +	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

Reverse fir tree ordering please:

	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
	bool success;

> +/*
> + * Emulate I/O using hypercall.
> + *
> + * Assumes the IO instruction was using ax, which is enforced
> + * by the standard io.h macros.
> + *
> + * Return True on success or False on failure.
> + */
> +static bool handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	bool in;
> +	int size, port;

Ditto.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
