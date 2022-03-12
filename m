Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1404D6E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiCLKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiCLKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:42:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A7270F28
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:41:15 -0800 (PST)
Received: from zn.tnic (p2e55d88d.dip0.t-ipconnect.de [46.85.216.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 315DE1EC04E0;
        Sat, 12 Mar 2022 11:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647081670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fhs5XY3spAN6QB7tl75uZvkIWWmeatMk5yrkrf6abqg=;
        b=H3sfFlO6fUNqs/yrw6c9I9Sbfa6KdXi/wIoO63qTRfqhKg9BwbqsfqXijxYymJ/Nzo4Ynd
        xvlmWQAbNeo2z1Tlco6zKEcLarpR2vg3aOkJe5hHX5t4of+J6bLauLSQf8jh+w/zGCiFhQ
        F8BbiOaz8TgLduaNm1vQSApIljqas1I=
Date:   Sat, 12 Mar 2022 11:41:16 +0100
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
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <Yix4zDfZD8ZusAdO@zn.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
 <YioZnTYahkoy2Mxz@zn.tnic>
 <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > > A guest uses TDCALL to communicate with both the TDX module and VMM.
> > > The value of the RAX register when executing the TDCALL instruction is
> > > used to determine the TDCALL type. A variant of TDCALL used to communicate
> > > with the VMM is called TDVMCALL.
> > > 
> > > Add generic interfaces to communicate with the TDX module and VMM
> > > (using the TDCALL instruction).
> > > 
> > > __tdx_hypercall()    - Used by the guest to request services from the
> > > 		       VMM (via TDVMCALL).
> > > __tdx_module_call()  - Used to communicate with the TDX module (via
> > > 		       TDCALL).
> > 
> > Ok, you need to fix this: this sounds to me like there are two insns:
> > TDCALL and TDVMCALL. But there's only TDCALL.
> > 
> > And I'm not even clear on how the differentiation is done - I guess
> > with %r11 which contains the VMCALL subfunction number in the
> > __tdx_hypercall() case but I'm not sure.
> 
> TDVMCALL is a leaf of TDCALL. The leaf number is encoded in RAX: RAX==0 is
> TDVMCALL.
> 
> I'm not completely sure what has to be fixed. Make it clear that TDVMCALL
> is leaf of TDCALL? Something like this:
> 
> 	__tdx_module_call()  - Used to communicate with the TDX module (via
> 			       TDCALL instruction).
> 	__tdx_hypercall()    - Used by the guest to request services from the
> 			       VMM (via TDVMCALL leaf of TDCALL).

Yes, it says above "via TDVMCALL" and "A variant of TDCALL used to
communicate with the VMM is called TDVMCALL." and that is ambiguous as
to whether this is about two instructions or one and a modification of
the same.

We write insn mnemonics with all caps so I see "TDCALL" and go, ah ok,
that's the insn but then when I see "TDVMCALL" I don't know what that
is. Another insn? Maybe, it is in all caps too...

> > And when explaining this, pls put it in the comment over the function so
> > that it is clear how the distinction is made.
> 
> But it's already there:

No not that - the explantion you wrote above that TDVMCALL is a leaf of
TDCALL. That needs to be there explicitly so that there's no confusion.

> Okay, will change. But it is not what we agreed about before:
> 
> https://lore.kernel.org/all/Yg5q742GsjCRHXZL@zn.tnic

I must've been confused from doing so many things at the same time,
sorry about that. :-\

> To me "invalid opcode" at "RIP: 0010:__tdx_hypercall+0x6d/0x70" is pretty
> clear where it comes from, no?

Probably to you and a couple more people who know how to read oops
messages. You have to think about our common users too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
