Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552B4DBB89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiCQARX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiCQARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:17:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832749FE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:16:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647476161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nI5tk69toWBHDjM9IY8bnHeeLWwvrrPpLjQKaTRNB8k=;
        b=InQd31HP5F7Z1m5Qv700fFdOQVB9V+TjiQqI8VpaJ1f0n6nZv/S1Fvz77quCROsGudciqH
        uaSRV056YL54Yb+FXKlL2DlGr58JTVczGU5h9evnYSS10YYho0SNTCoQncFQilQ069HuQU
        UwXQ1VPcqilpWNTV6yzbNAxougbzKfHzCnaFYNKdbmScAZabse/neB0N4YsPUEirx+K6/u
        0hu8XNfjhyzgH+uuKORq4A6mMdV7JCAzJB/9nJeV2iG7X8QTrA/LrEHp7PLtFKNfB8W+S9
        vAS1BLL+BgeLo4P/ho+SoAlCRWJ3TGUV4cwzPxxbpzQi11evllzRrPTdM25xVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647476161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nI5tk69toWBHDjM9IY8bnHeeLWwvrrPpLjQKaTRNB8k=;
        b=FIxxOhwJERFPf+4UGlnHzFe5SgStJ7qjABM0C8Rfkk8kpYIOy2O9gGj73NB1NzOfbA2pxt
        6BFKWQdR7Cj7bLDQ==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
In-Reply-To: <20220316020856.24435-6-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-6-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 01:16:00 +0100
Message-ID: <87czil303j.ffs@tglx>
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
> @@ -82,6 +82,14 @@ void __init tdx_early_init(void)
>  
>  	cc_set_vendor(CC_VENDOR_INTEL);
>  
> +	/*
> +	 * All bits above GPA width are reserved and kernel treats shared bit
> +	 * as flag, not as part of physical address.
> +	 *
> +	 * Adjust physical mask to only cover valid GPA bits.
> +	 */
> +	physical_mask &= GENMASK_ULL(gpa_width - 2, 0);
> +

Hrm. I forgot about the second use case for gpa_width, but my comment
about ordering still stands. OTOH:

         GENMASK_ULL(gpa_width - 2, 0) == BIT_UL(gpa_width - 1) - 1

right? So you really can consolidate on the fact that cc_mask is a
single bit which is above the guests physical address space boundary.

I.e. make the code tell the story instead of adding lengthy comments
explaining the obfuscation.

Thanks,

        tglx

