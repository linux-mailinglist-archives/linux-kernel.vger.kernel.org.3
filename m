Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4C4DDB71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiCROVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiCROU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:20:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472CC1CAB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:19:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647613174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/L0jdjbHK9avcbWxeB0aN6EZcZvySQA8oCMsEbJtdE=;
        b=OxC1QdUwSTRZWLeixHh2c47FDwVfqxThKWECCOKsIEz6fS+d8X4lc0Raqske4zHO4o6rIs
        ENAvaqxHNMQT8pA6k8ELyrqxxGZ9NhvgvVIW5mjgdbdE4ZV/5ewRkl3YhXyZ0RyzvPEC5P
        4lKksFPO+rIYuTYLZt04X04AXl+jo3z694RY5hIXWLyPot8iXSJANI90prWyx4HN/7y0Gp
        OHVgZZH6EQ0E29K0+SZq1By4K//uRmqE8O2K4JzljxY4qHM0Q8VnWwIu0xv8szDJtUb4Qp
        wyj3SDTFbb/kdOIxIJz8yAW6iilgeE6ZX6zGZet+YJrl3Jdxa/0t431RWnkSIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647613174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/L0jdjbHK9avcbWxeB0aN6EZcZvySQA8oCMsEbJtdE=;
        b=3S1MEAAYsBxJ/e7wtHMxaGmOobog8e62ehgRBXx/b8G9sPREHSksF0ydrERTNlevG9J8dw
        CCQ2OGfiHxd9v+Cw==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220317202141.GO8939@worktop.programming.kicks-ass.net>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx> <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
 <20220317202141.GO8939@worktop.programming.kicks-ass.net>
Date:   Fri, 18 Mar 2022 15:19:34 +0100
Message-ID: <87a6dncphl.ffs@tglx>
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

On Thu, Mar 17 2022 at 21:21, Peter Zijlstra wrote:
> On Thu, Mar 17, 2022 at 08:33:54PM +0300, Kirill A. Shutemov wrote:
>>  - in NMI entry code (asm_exc_nmi()) before NMI nesting is safe:
>>    + for NMI from user mode, before switched to thread stack
>>    + for NMI from kernel, up to end_repead_nmi
>> 
>> After that points #VE is safe.
>
> In what way is it guaranteed that #VE isn't raised in those places? What
> does an auditor / future coder looking to changes things, need to
> consider to keep this so.
>
> From vague memories #VE can be raised on any memop, loading the stack
> address in the syscall-gap is a memop. What makes that special? Can we
> get a comment _there_ to explain how this is safe such that we can keep
> it so?
>
> Same for the NMI path I suppose.

#VE is raised by HLT, CPUID, I/O-Port access, MSR read/write, EPT violations

So in the hairy places:

 - HLT:       No business
 - I/O Ports: That would be outright stupid to use

 - CPUID:     Should never be used - Emphasis on should :)
 - MSRs:      Same as CPUID

 - EPT:       Well....

Thanks,

        Thomas
