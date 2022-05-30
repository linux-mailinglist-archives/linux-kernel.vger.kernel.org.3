Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB86537A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiE3MAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiE3MAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:00:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F487CB35
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxj0J/YhMMhKAH1EkbuiQrbuk0Qda0v5TTbkiBkZN3M=; b=i3KE6kOP6FM7xKwMx8F4naRfR/
        Tv2rcCqj9mMDhTVAe2VjSVPqM036ElOQQ3r56b/GoRMeLiAFnmLsBJZxUwHZHz8sAi8en/Ugl+qdG
        /pvEl2QOCqBsrpo5V/WWHOBy60Bs36rp1h5qSoOBwN//+dDyXJy2sIzMJWc/RezAXVRRMXUmTazAz
        Bx4DX3V0L9sEykDMBFDBy0/BhlV80fhlSooeJ4rM4QiOmg2colZ8E98Ri+RKZDGalMNy76AkzzHb4
        XxjBXR36La1hPUlmq36nL3ovFeOtuBFuY/FcLCPICgShJOYYxu7GJj0Hv/swT8JB/m75gCjevmXUu
        pgPhryJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nve4c-0032El-4c; Mon, 30 May 2022 12:00:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E2213001EA;
        Mon, 30 May 2022 14:00:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A97B207688E7; Mon, 30 May 2022 14:00:36 +0200 (CEST)
Date:   Mon, 30 May 2022 14:00:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     paulmck@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 3/9] cpuidle: Move IRQ state validation
Message-ID: <YpSx47DA05npvtzQ@hirez.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213421.748352112@infradead.org>
 <20220530113640.GC1257179@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530113640.GC1257179@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 01:36:40PM +0200, Frederic Weisbecker wrote:
> On Thu, May 19, 2022 at 11:27:53PM +0200, Peter Zijlstra wrote:
> > Make cpuidle_enter_state() consistent with the s2idle variant and
> > verify ->enter() always returns with interrupts disabled.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  drivers/cpuidle/cpuidle.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -234,7 +234,11 @@ int cpuidle_enter_state(struct cpuidle_d
> >  	stop_critical_timings();
> >  	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> >  		rcu_idle_enter();
> > +
> >  	entered_state = target_state->enter(dev, drv, index);
> > +	if (WARN_ON_ONCE(!irqs_disabled()))
> > +		raw_local_irq_disable();
> 
> So it means that idle functions are supposed to return with IRQs disabled
> without tracing, right? I can see that at least acpi_safe_halt() is using
> the non-raw local_irq_disable().

Yeah, I might need to re-order this. 0day also complained about that.
I'll need to find a moment to re-audit this and put it in the right
place.
