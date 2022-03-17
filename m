Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51EA4DCD70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiCQSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiCQSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:19:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46F5D181
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:18:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647541096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1cMRioNx9dyBHJVz2CH0cxjLaOPntib9co0rfHgwgU=;
        b=Qwnh3wirWfWrTNOaSMoLiRggVDoBJWJqwgsac8TwO2aXHM/Csr4Ev8uzz/p9rXDUctImmG
        dHBeGfNHLypxIDjPbxuOyaLAwhX4p9u8suz7kHja7f7zJYjSY6pTWCePgU8OSTEHShw36E
        YJ6OcRxOCEggZawGP+Um3yi4d3pQjGvvvR3DOcfn6G0FbjSePDvwf0QFBuXYlrSG5fFnZM
        AhjYv6i+uicoy3Uf3Rn3t8gLmHqKa90SYli+pTRW96YuWdy0IHHzF4DoCkD3FQZqhlhHen
        9JUbAO8wusF9B641iIeSLJQGOfCSPCiVtJXrMQtJb53ZC8zaQSJHJqdN7XHbeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647541096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1cMRioNx9dyBHJVz2CH0cxjLaOPntib9co0rfHgwgU=;
        b=SabTM6h+J39HEs/HdKKtPDESeI6Qyc5crpV+6SBE2jLSTqW7Ok/JWoGjxwPhlru3PeujNl
        CuIvw7zWGOq/hwCw==
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
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx> <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
Date:   Thu, 17 Mar 2022 19:18:15 +0100
Message-ID: <87czikcujc.ffs@tglx>
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

On Thu, Mar 17 2022 at 20:33, Kirill A. Shutemov wrote:
> On Thu, Mar 17, 2022 at 01:48:54AM +0100, Thomas Gleixner wrote:
>> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
>> Hmm?
>
> Does the changed version below address your concerns?
>
> 	void tdx_get_ve_info(struct ve_info *ve)
> 	{
> 		struct tdx_module_output out;
>
> 		/*
> 		 * Called during #VE handling to retrieve the #VE info from the
> 		 * TDX module.
> 		 *
> 		 * This has to be called early in #VE handling.  A "nested" #VE which
> 		 * occurs before this will raise a #DF and is not recoverable.
> 		 *
> 		 * The call retrieves the #VE info from the TDX module, which also
> 		 * clears the "#VE valid" flag. This must be done before anything else
> 		 * because any #VE that occurs while the valid flag is set will lead to
> 		 * #DF.
> 		 *
> 		 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
> 		 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
> 		 */
> 		tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
>
> 		/* Transfer the output parameters */
> 		ve->exit_reason = out.rcx;
> 		ve->exit_qual   = out.rdx;
> 		ve->gla         = out.r8;
> 		ve->gpa         = out.r9;
> 		ve->instr_len   = lower_32_bits(out.r10);
> 		ve->instr_info  = upper_32_bits(out.r10);
> 	}

Nice.

>> The point is that any #VE in such a code path is fatal and you better
>> come up with some reasonable explanation why this is not the case in
>> those code pathes and how a potential violation of that assumption might
>> be detected especially in rarely used corner cases. If such a violation
>> is not detectable by audit, CI, static code analysis or whatever then
>> document the consequences instead of pretending that the problem does
>> not exist and the kernel is perfect today and forever.
>
> It is detectable by audit. The critical windows very limited and located
> in the highly scrutinized entry code. But, yes, I cannot guarantee that
> this code will be perfect forever.

Fair enough.

> Consequences of #VE in these critical windows are mentioned in the
> comment:
>
> 	Any exception in this window leads to hard to debug issues and can
> 	be exploited for privilege escalation. 
>
> I have hard time understanding what I has to change here. Do you want
> details of audit to be documented? Make consequences of #VE at the wrong
> point to be more prominent in the comment? 

So having something like this in the comment would be helpful:

        *
	* The entry code has been audited carefuly for following these
        * expectations. Changes in the entry code have to be audited for
        * correctness vs. this aspect.  #VE in these places will cause
        * [an instant kernel panic | whatever | fill the blanks ]
        *

Thanks,

        tglx
