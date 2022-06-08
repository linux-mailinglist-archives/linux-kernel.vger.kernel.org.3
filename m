Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF0543AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiFHRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiFHRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:43:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5843F7FBE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68FD1B82993
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA96C3411D;
        Wed,  8 Jun 2022 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654710195;
        bh=+2exFGLJw+UJqq4HfDC1N6L9YdBzC6hg4Y+JcmTqSkQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MZvDwbaPnD75j7B3VQtP168GOXuxA54br2I5C4CxfWYX/fjWlF/ghfZ0yKk2IkFDa
         YTB2IFu/119asLIfGvfoc1hOgDA5tNNyO1wkTGEy+cDiR6tp0l9rxJo67Yef3py81L
         HrOB9ZciwVgm0F8+LgL4C4O819vMv+bVkFtdfXrVFepkpwpw/vIHl+pxzGrCob5g/n
         SIFFRO+hS7gudhPq65RoPkd1dEH2eGfqRQ8M6iMRSY1WzAaOR2CMXUSAfe0kaN25Ks
         JZ41eZaUwBFHNhx558o+acP1IzjUNhzAO4pOZsg4NAP9wx95/sItBb2W6KgmDETMUt
         4Y2CuKbeVX7nA==
Message-ID: <3074f89b32c440749ae4adbe52ae968170bef7ff.camel@kernel.org>
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
Date:   Wed, 08 Jun 2022 19:43:07 +0200
In-Reply-To: <20220608142927.GA1735086@lothringen>
References: <20220519145823.618983-1-frederic@kernel.org>
         <20220519145823.618983-21-frederic@kernel.org>
         <315b0b80f7f541b99a49a9fecb743874f31d95ba.camel@kernel.org>
         <20220531142335.GA1272449@lothringen>
         <bcc4c9fa41ace6f9d98d88d24d1bd67a469cbfeb.camel@kernel.org>
         <20220608142927.GA1735086@lothringen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Wed, 2022-06-08 at 16:29 +0200, Frederic Weisbecker wrote:
> On Tue, May 31, 2022 at 06:15:36PM +0200, nicolas saenz julienne wrote:
> > On Tue, 2022-05-31 at 16:23 +0200, Frederic Weisbecker wrote:
> > > But idle at least is an exception and CONTEXT_IDLE will remain during=
 the
> > > interrupt handling. It's not that trivial to handle the idle case bec=
ause
> > > ct_irq_exit() needs to know that it is called between ct_idle_enter()=
 and
> > > ct_idle_exit().
> >
> > Just for the record, this behaviour was already here regardless of this=
 series,
> > so it's not something it needs to fix.
>
> Right.
>
> >
> > Something like this should work, right?
> >
> >      ct_idle_enter()
> >          //IRQ or NMI
> > 	 if (__ct_state() =3D=3D CONTEXT_IDLE)
> > 	     ct_idle_exit()
>
> Right but that's one more costly operation (atomic_add_return())
>
> >          ct_irq_enter()
>
> Ideally this should increment by RCU_DYNTICKS_IDX - CONTEXT_IDLE
>
> > 	    ...
> >          ct_irq_exit()
>
> And this should increment by RCU_DYNTICKS_IDX + CONTEXT_IDLE
>
> I guess the CONTEXT_IDLE state should be remembered on some per cpu
> variable somewhere.
>
> BTW one interesting optimization to do when an idle interrupt leads to
> setting need_resched() would be to have:
>
>     idle_loop() {
>         while (!need_resched) {
>             rcu_idle_enter();
> 	    mwait();
> 	    //IRQ {
> 	        rcu_irq_enter();
> 		do_irq()... //set need_resched()
> 		rcu_irq_exit() // but no need to do the atomic_add_return() here
> 		               // since we want to keep RCU watching as we'll
>                                // escape from idle
>             }
> 	    rcu_idle_exit() // and no need to do the atomic_add_return() here ei=
ther
>
>
> That's two expensive operations spared for a pretty common event.

>
>
>
> > 	 if (needs_update_state()) //using irqentry_state_t for ex.
> > 	     ct_idle_entry()
> >      ct_idle_exit()
> >
> > Note that it's not a big issue as we can work around this behaviour by =
checking
> > through dynticks whether a CPU is really idle.
> >
> > Do you think it's worth fixing nonetheless?
>
> Nothing urgent for sure.

Thanks for the feedback, I'll think about it.

BTW if you're patient I'll try to make a last test run on v4 of the series =
next
week.

Regards,
Nicolas
