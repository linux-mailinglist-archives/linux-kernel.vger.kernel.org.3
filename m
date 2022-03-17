Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86284DCF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiCQUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCQUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:23:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E61427F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ynJ63fuZlq/Q/DDYvx8FSGQPk2RfeTabFUx6AZiQ6A=; b=mouiyjq2GiFti606CpaZKdD/0+
        amvlNWrtul5jE5roZSSspQgi8ps/wFB7OWZH1ZGFnIpe1l9LHIZ9dccSoCU9d15wrN+0OQY85PQQd
        nfZTpXjSAZhlIdI/LNINaj6EJ5594cMP5K3xWtN7mTCv4HnEGsolNOxeXanSi5xYdPeQCj70SzPXr
        TJJsMmSXvJ0xR4pGuh7stiwxiYKvSyjLasTPNGfz3KW47KLVlu4dTsiNeoO142dIlpWMzxSG4XxQH
        QIHhB3cG64FBCt4qkIv7Du2kLwkYdXi0AaAXqahgxASeuqNoWNrWS9/grH4h3+wD8xkqtQCMoRrBo
        bT0gBf0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUwcw-001zQw-1N; Thu, 17 Mar 2022 20:21:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E04D9882B3; Thu, 17 Mar 2022 21:21:41 +0100 (CET)
Date:   Thu, 17 Mar 2022 21:21:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
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
Message-ID: <20220317202141.GO8939@worktop.programming.kicks-ass.net>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-8-kirill.shutemov@linux.intel.com>
 <877d8t2ykp.ffs@tglx>
 <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317173354.rqymufl37lcrtmjh@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 08:33:54PM +0300, Kirill A. Shutemov wrote:

> [ Disclaimer: I have limited understanding of the entry code complexity
>   and may miss some crucial details. But I try my best. ]
> 
> Yes, it is the same comment, but it is based on code audit, not only on
> testing.
> 
> I claim that kernel does not do anything that can possibly trigger #VE
> where kernel cannot deal with it:
> 
>  - on syscall entry code before kernel stack is set up (few instructions
>    in the beginning of entry_SYSCALL_64())
> 
>  - in NMI entry code (asm_exc_nmi()) before NMI nesting is safe:
>    + for NMI from user mode, before switched to thread stack
>    + for NMI from kernel, up to end_repead_nmi
> 
> After that points #VE is safe.

In what way is it guaranteed that #VE isn't raised in those places? What
does an auditor / future coder looking to changes things, need to
consider to keep this so.

From vague memories #VE can be raised on any memop, loading the stack
address in the syscall-gap is a memop. What makes that special? Can we
get a comment _there_ to explain how this is safe such that we can keep
it so?

Same for the NMI path I suppose.
