Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203F4DC905
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiCQOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiCQOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:40:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715E9F3BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:39:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647527949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwa5B4vbC87faqjFjpMX9eHkgYU0LzWzNDEusWEFXMA=;
        b=aXAczIdCT5b8wJP+mVoY4R7Jp71iJt3bhoK/69/KoIRyiBa/T/4Pj+y2huc4Woeq/Bvy9y
        K5KYUWYAeQpJ0dOqohhKdBqKo2y2ahxG0URwLLpgVusUw51sFfPLDe9lponrYBoGIbn+lv
        pMvGyKXnUIUyFM4urZX6sMOpUVdiRWMzAMeDFybIEOqGqQiHNRvOrapDE6/rji/LUgm+ti
        WugGYbkFVfPhbBWdzRvJg9zjN2zPjM/bkgpZjK6OLelo2K/FkZvRoDUuhudkmJAfdK9kIy
        9QVGp1leQkjhk4jxa3wHF2NT78+j3Y2CAYuvTubXD+LJfYgS7vonFLcZzvaanw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647527949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwa5B4vbC87faqjFjpMX9eHkgYU0LzWzNDEusWEFXMA=;
        b=Z1UtT6VeZQ8ZBxrky5MMlNxZgSh5g7/X0sLp/gp7EYSwLoJpG95TC8LaYJGS2w16xM1/1g
        a3u60SY+mRSeOUBg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 05/30] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
In-Reply-To: <20220317135820.frdppktft4flzhha@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-6-kirill.shutemov@linux.intel.com>
 <87czil303j.ffs@tglx> <20220317135820.frdppktft4flzhha@black.fi.intel.com>
Date:   Thu, 17 Mar 2022 15:39:08 +0100
Message-ID: <87r170d4oj.ffs@tglx>
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

On Thu, Mar 17 2022 at 16:58, Kirill A. Shutemov wrote:

> On Thu, Mar 17, 2022 at 01:16:00AM +0100, Thomas Gleixner wrote:
>> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
>> > @@ -82,6 +82,14 @@ void __init tdx_early_init(void)
>> >  
>> >  	cc_set_vendor(CC_VENDOR_INTEL);
>> >  
>> > +	/*
>> > +	 * All bits above GPA width are reserved and kernel treats shared bit
>> > +	 * as flag, not as part of physical address.
>> > +	 *
>> > +	 * Adjust physical mask to only cover valid GPA bits.
>> > +	 */
>> > +	physical_mask &= GENMASK_ULL(gpa_width - 2, 0);
>> > +
>> 
>> Hrm. I forgot about the second use case for gpa_width, but my comment
>> about ordering still stands. OTOH:
>> 
>>          GENMASK_ULL(gpa_width - 2, 0) == BIT_UL(gpa_width - 1) - 1
>> 
>> right? So you really can consolidate on the fact that cc_mask is a
>> single bit which is above the guests physical address space boundary.
>> 
>> I.e. make the code tell the story instead of adding lengthy comments
>> explaining the obfuscation.
>
> So it will looks something like this:
>
>
> 	cc_set_vendor(CC_VENDOR_INTEL);
> 	cc_mask = get_cc_mask();
> 	cc_set_mask(cc_mask);
>
> 	/*
> 	 * All bits above GPA width are reserved and kernel treats shared bit
> 	 * as flag, not as part of physical address.
> 	 *
> 	 * Adjust physical mask to only cover valid GPA bits.
> 	 */
> 	physical_mask &= cc_mask - 1;
>
> I still think these comments are useful. I hided comment for cc_mask
> calclulation inside get_cc_mask().
>
> Does it look fine to you?

Yes.
