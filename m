Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5052E5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiETHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbiETHG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:06:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0C3FBCE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6FAmHGYr5lfoBH3BRNeJlM4krPnia1Yy1bleN0MZmg=; b=IoqzbE3IUrPi/gt7tUUdrWVJBI
        rLIBL25zehMVeBHSuMw7qBBvuRJgmGeZrYr+0S8F1GXyB5nVsFvoEaij/D30ThX/9yNqrJ3ES9l8s
        r1YOlxtL8azf2SD04R+YrurE0KW8IK2J4NT5VShTpJRC/WiAAlJUpaJaHJDcqlBDhaGGNapPWroCC
        WiJ8Xvz82/jZOu6ORrvpEO9c8ofKaSYT0kGm53uPiYUWHTkRpUdjSlIH8USJp1LDzJBfc/zUw8Vcr
        FlxjjcgQyXQF8FCTQZ0JYcpNla/4NFHUFK2Zl5gKXMTZBd2k3AJlnUtF9V4ACYK2+rK+5hTZ8tKaQ
        6Lfa3uWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrwiF-002Fmm-Hf; Fri, 20 May 2022 07:06:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13E93981005; Fri, 20 May 2022 09:06:15 +0200 (CEST)
Date:   Fri, 20 May 2022 09:06:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220520070614.GP2578@worktop.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
 <20220519220349.GM2578@worktop.programming.kicks-ass.net>
 <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:20:52AM +0300, Kirill A. Shutemov wrote:
> On Fri, May 20, 2022 at 12:03:49AM +0200, Peter Zijlstra wrote:
> > 
> > On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> > > --- a/arch/x86/coco/tdx/tdx.c
> > > +++ b/arch/x86/coco/tdx/tdx.c
> > > @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
> > >  	 */
> > >  	if (__halt(irq_disabled, do_sti))
> > >  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> > > +
> > > +	/* XXX I can't make sense of what @do_sti actually does */
> > > +	raw_local_irq_disable();
> > >  }
> > >  
> > 
> > Kirill, Dave says I should prod you :-)
> 
> It calls STI just before doing TDCALL that requests HLT.
> See comment above $TDX_HCALL_ISSUE_STI usage in __tdx_hypercall()[1].

Yes, it says that, but it's useless information since it doesn't
actually tell me the behaviour.

What I'm interested in is the behavour of the hypercall when:
.irq_disabled=false, .do_sti=false

From what I can tell, irq_disabled=false should have the hypercall wake
on interrupt, do_sti=false should have it not enable interrupts.

But what does it actually do ? Because HLT without STI is a dead
machine, but this hypercall looks more like mwait with the irq_disabled
argument...

> 
> __halt(do_sti == true) matches native_safe_halt() semantics (or suppose
> to) and __halt(do_sti == false) corresponds to native_halt().
> 
> For context, see Section 3.8 in GHCI[2]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/arch/x86/coco/tdx/tdcall.S?h=x86/tdx#n151
> [2] https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface-1.0-344426-002.pdf

Yeah, that stuff is unreadable garbage. Not going to waste time trying
to make sense of it again.
