Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AA5394D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbiEaQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiEaQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:15:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AA95DDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE26FB810EE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A5DC3411E;
        Tue, 31 May 2022 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654013742;
        bh=TVgs8pObD4Gy+he4AStVAaVMXRyS4YbTqQVgEsrHYlE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LRXPn6WJNIA0LBbi2jQrWj4NXRV9q6HxvsbQ3dyix5uv7hSEIFxEFFnwbNpVJdV2U
         vuUu5wZkZlE6Q4snUrWCwROlgFkxlBvCW1en+8UIZUSyzXG8ReJ1A8ue28PnSisL1m
         Eeijd0+CwRSahgle+DavRFuQoYJOW+5qlWqZKeh/Ts0GYujiLxN9Hh99Btv3U7zfcO
         Z+2Jou9kDP+onyRyWl/MMxydQy4c/Q0STeuod1N/FRZAw7K20Obt+y88kERe+j+hpr
         B57yUGgDKgEc5qeIom5F/NpdjcrHBNyX+aRxTuHlsvPcPe5fGs6f9MBw/WkkoRt3Hi
         9xaEUgYpHR52A==
Message-ID: <bcc4c9fa41ace6f9d98d88d24d1bd67a469cbfeb.camel@kernel.org>
Subject: Re: [PATCH 20/21] rcu/context_tracking: Merge dynticks counter and
 context tracking states
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Date:   Tue, 31 May 2022 18:15:36 +0200
In-Reply-To: <20220531142335.GA1272449@lothringen>
References: <20220519145823.618983-1-frederic@kernel.org>
         <20220519145823.618983-21-frederic@kernel.org>
         <315b0b80f7f541b99a49a9fecb743874f31d95ba.camel@kernel.org>
         <20220531142335.GA1272449@lothringen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-31 at 16:23 +0200, Frederic Weisbecker wrote:
> On Mon, May 30, 2022 at 08:02:57PM +0200, nicolas saenz julienne wrote:
> > Hi Frederic,
> >=20
> > On Thu, 2022-05-19 at 16:58 +0200, Frederic Weisbecker wrote:
> > > Updating the context tracking state and the RCU dynticks counter
> > > atomically in a single operation is a first step towards improving CP=
U
> > > isolation. This makes the context tracking state updates fully ordere=
d
> > > and therefore allow for later enhancements such as postponing some wo=
rk
> > > while a task is running isolated in userspace until it ever comes bac=
k
> > > to the kernel.
> > >=20
> > > The state field becomes divided in two parts:
> > >=20
> > > 1) Two Lower bits for context tracking state:
> > >=20
> > > 	CONTEXT_KERNEL =3D 0
> > >    	CONTEXT_IDLE =3D 1,
> > > 	CONTEXT_USER =3D 2,
> > > 	CONTEXT_GUEST =3D 3,
> > >=20
> > > 2) Higher bits for RCU eqs dynticks counting:
> > >=20
> > >     RCU_DYNTICKS_IDX =3D 4
> > >=20
> > >    The dynticks counting is always incremented by this value.
> > >    (state & RCU_DYNTICKS_IDX) means we are NOT in an extended quiesce=
nt
> > >    state. This makes the chance for a collision more likely between t=
wo
> > >    RCU dynticks snapshots but wrapping up 28 bits of eqs dynticks
> > >    increments still takes some bad luck (also rdp.dynticks_snap could=
 be
> > >    converted from int to long?)
> > >=20
> > > Some RCU eqs functions have been renamed to better reflect their broa=
der
> > > scope that now include context tracking state.
> > >=20
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > > Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > > Cc: Yu Liao<liaoyu15@huawei.com>
> > > Cc: Phil Auld <pauld@redhat.com>
> > > Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> > > Cc: Alex Belits <abelits@marvell.com>
> > > ---
> >=20
> > While working on a feature on top of this series (IPI deferral stuff) I=
 believe
> > I've found a discrepancy on how context state is being updated:
> >=20
> >  - When servicing an IRQ from user-space, we increment dynticks, and cl=
ear the
> >    ct state to show we're in-kernel.
> >=20
> >  - When servicing an IRQ from idle/guest or an NMI from any context we =
only
> >    increment the dynticks counter. The ct state remains unchanged.
>=20
> Hmm, an IRQ from userspace does:
>=20
>     ct_user_enter()
>     //run in user
>         //-----IRQ
>         ct_user_exit()
>         ct_irq_enter()
>         ct_irq_exit()
>         ct_user_enter()
>     //run in user
>=20
> An IRQ from guest does:
>=20
>     for (;;) {
>          context_tracking_guest_enter()
>         //vmrun
> 	//IRQ pending
>         #VMEXIT
>         context_tracking_guest_exit()
> 	local_irq_enable()
>         ct_irq_enter()
>         ct_irq_exit()
> 	local_irq_disable()
>     }
>=20
>=20
>     (although I see there is an "sti" right before "vmrun" so it looks
>     possible to have ct_irq_enter() after context_tracking_guest_enter()
>     if a host IRQ fires between the sti and the vmrun though I might be
>     missing some kvm subtelty).
>=20
> An IRQ from idle does just:
>=20
>     ct_idle_enter()
>         //IRQ
>         ct_irq_enter()
>         ct_irq_exit()
>     ct_idle_exit()
>=20
> So guest looks mostly ok to me (except for the little sti before vmrun fo=
r
> which I have a doubt).

Yes, shouldn't have mentioned guests. I got carried away.

> But idle at least is an exception and CONTEXT_IDLE will remain during the
> interrupt handling. It's not that trivial to handle the idle case because
> ct_irq_exit() needs to know that it is called between ct_idle_enter() and
> ct_idle_exit().

Just for the record, this behaviour was already here regardless of this ser=
ies,
so it's not something it needs to fix.

Something like this should work, right?

     ct_idle_enter()
         //IRQ or NMI
	 if (__ct_state() =3D=3D CONTEXT_IDLE)
	     ct_idle_exit()
         ct_irq_enter()
	    ...
         ct_irq_exit()
	 if (needs_update_state()) //using irqentry_state_t for ex.
	     ct_idle_entry()
     ct_idle_exit()

Note that it's not a big issue as we can work around this behaviour by chec=
king
through dynticks whether a CPU is really idle.

Do you think it's worth fixing nonetheless?

Regards,
Nicolas
