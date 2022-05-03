Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD051809E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiECJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiECJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:10:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7822BF0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eqK1xi56ux6pqK7FTWNtDH04KbxWFX0qsAS2KOydu0M=; b=ksS6OnqMEgvJfZzNYtO6y901OY
        SL5iu1tTQ6bgjR9FH6jk5EnJwsqr6b6Y6pq3WBahFp48E2iQ3j4XjNacsXPkFD+Inc6Gw0SUvkdyd
        /IJ3K+H2xJJ1nCV7zoBTNvKHmP8ncWRLX5uPhoWwNJkKpUpFGJaY24zXSG2pEynXa4KbEqnL9QImR
        /kk1AaC+8g81prxdylyNxE7NmrH2T2WOHfwsYRFEdoxujzHcktbNKdJrXIuV5Jka2VGoLWKeAHQeT
        npva4nepUROXwUlnixBu5pIbDTb1Pi7BU1EdE3RS70YLhFwAqL/Zv8wwNItIahZ4jGLq01tFk5ku1
        nNsd5qeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nloUC-00AjV7-9V; Tue, 03 May 2022 09:06:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2693F30047E;
        Tue,  3 May 2022 11:06:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1344820288CED; Tue,  3 May 2022 11:06:22 +0200 (CEST)
Date:   Tue, 3 May 2022 11:06:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
 <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0b4lydr.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 05:58:40PM +0200, Thomas Gleixner wrote:

> >> +void fpregs_lock(void)
> >> +{
> >> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >> +		local_bh_disable();
> >> +	else
> >> +		preempt_disable();
> >
> > So I'm wondering: can we get rid of this distinction and simply do
> > preempt_disable()?
> > 
> > Or can FPU be used in softirq processing too so we want to block that
> > there?
> 
> Yes, FPU can be used legitimately in softirq processing context.
> 
> > But even if, fpu_in_use will already state that fact...
> 
> Right, though currently it's guaranteed that softirq processing context
> can use the FPU. Quite some of the network crypto work runs in softirq
> context, so this might cause a regression. If so, then this needs to be
> an explicit commit on top which is easy to revert. Let me stare at it
> some more.

Right, so with the:

	preempt_disable();
	this_cpu_write(fpu_in_use, true);
	barrier();

sequence it is safe against both softirq and hardirq fpu usage. The only
concern is performance not correctness when dropping that
local_bh_disable() thing.

So what Thomas proposes makes sense to me.
