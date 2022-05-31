Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9543539318
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiEaOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiEaOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8F7C174
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CEB9612FB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622ADC3411D;
        Tue, 31 May 2022 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654007018;
        bh=3uDJRMnzzkW1jtjk1n7EQ8ObZJ85Vi7lUATGso0uNF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP8RRYZ3y30ALTNdCEkm+3VDVsur8xxSUZ/6Pn5NadYKSgyZD98jwvQeU3yHdCikI
         eBuTt1Fr5FwqoWMuS2d0Ib+dT382cv3Xzuc9LC61T2isr3EKlsQOwKRXEIznLQyLDo
         UK6l3E+79kAQ5J6TWeWKQ4nVvVxkR6tzRJKw4n/NXDa6f0Pq6S5xJVRtqhGHgT0WMD
         742UOnfk8s0rR0vPcepuHXvS+BUoXmwJm1rvYoQSKRhvkJRNjTLDMSXGTofGZ30gu8
         sGVzxgkZxYYKrNywTr5zhzZfHuxKVCNGJpEXhOze9/SoJeJn2aq+sPM6Rp8xhfatUm
         QZrMPs+a8OAdg==
Date:   Tue, 31 May 2022 16:23:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 20/21] rcu/context_tracking: Merge dynticks counter and
 context tracking states
Message-ID: <20220531142335.GA1272449@lothringen>
References: <20220519145823.618983-1-frederic@kernel.org>
 <20220519145823.618983-21-frederic@kernel.org>
 <315b0b80f7f541b99a49a9fecb743874f31d95ba.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315b0b80f7f541b99a49a9fecb743874f31d95ba.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 08:02:57PM +0200, nicolas saenz julienne wrote:
> Hi Frederic,
> 
> On Thu, 2022-05-19 at 16:58 +0200, Frederic Weisbecker wrote:
> > Updating the context tracking state and the RCU dynticks counter
> > atomically in a single operation is a first step towards improving CPU
> > isolation. This makes the context tracking state updates fully ordered
> > and therefore allow for later enhancements such as postponing some work
> > while a task is running isolated in userspace until it ever comes back
> > to the kernel.
> > 
> > The state field becomes divided in two parts:
> > 
> > 1) Two Lower bits for context tracking state:
> > 
> > 	CONTEXT_KERNEL = 0
> >    	CONTEXT_IDLE = 1,
> > 	CONTEXT_USER = 2,
> > 	CONTEXT_GUEST = 3,
> > 
> > 2) Higher bits for RCU eqs dynticks counting:
> > 
> >     RCU_DYNTICKS_IDX = 4
> > 
> >    The dynticks counting is always incremented by this value.
> >    (state & RCU_DYNTICKS_IDX) means we are NOT in an extended quiescent
> >    state. This makes the chance for a collision more likely between two
> >    RCU dynticks snapshots but wrapping up 28 bits of eqs dynticks
> >    increments still takes some bad luck (also rdp.dynticks_snap could be
> >    converted from int to long?)
> > 
> > Some RCU eqs functions have been renamed to better reflect their broader
> > scope that now include context tracking state.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Cc: Yu Liao<liaoyu15@huawei.com>
> > Cc: Phil Auld <pauld@redhat.com>
> > Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> > Cc: Alex Belits <abelits@marvell.com>
> > ---
> 
> While working on a feature on top of this series (IPI deferral stuff) I believe
> I've found a discrepancy on how context state is being updated:
> 
>  - When servicing an IRQ from user-space, we increment dynticks, and clear the
>    ct state to show we're in-kernel.
> 
>  - When servicing an IRQ from idle/guest or an NMI from any context we only
>    increment the dynticks counter. The ct state remains unchanged.

Hmm, an IRQ from userspace does:

    ct_user_enter()
    //run in user
        //-----IRQ
        ct_user_exit()
        ct_irq_enter()
        ct_irq_exit()
        ct_user_enter()
    //run in user

An IRQ from guest does:

    for (;;) {
         context_tracking_guest_enter()
        //vmrun
	//IRQ pending
        #VMEXIT
        context_tracking_guest_exit()
	local_irq_enable()
        ct_irq_enter()
        ct_irq_exit()
	local_irq_disable()
    }


    (although I see there is an "sti" right before "vmrun" so it looks
    possible to have ct_irq_enter() after context_tracking_guest_enter()
    if a host IRQ fires between the sti and the vmrun though I might be
    missing some kvm subtelty).

An IRQ from idle does just:

    ct_idle_enter()
        //IRQ
        ct_irq_enter()
        ct_irq_exit()
    ct_idle_exit()

So guest looks mostly ok to me (except for the little sti before vmrun for
which I have a doubt). But idle at least is an exception and CONTEXT_IDLE will
remain during the interrupt handling. It's not that trivial to handle the idle
case because ct_irq_exit() needs to know that it is called between
ct_idle_enter() and ct_idle_exit().

Thanks.
