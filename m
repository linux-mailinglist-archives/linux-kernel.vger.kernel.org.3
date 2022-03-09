Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEECE4D3CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiCIW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:26:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C916A072
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D53F361B43
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD1CC340E8;
        Wed,  9 Mar 2022 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646864723;
        bh=7VwSKftfAHbW2UAnTQ46IwVsEYq0prOKAeLb+si6kNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V81NdOoJzpDUxoNjDJ7+Op10BjeNeHox6pNkrHv/BPn2itKlKTtJfAzfGudAl8Xeo
         RPOt+vO7MmzD3M1f/+LnAwHvJUqbNmfnve5GpQpYdoyO/A+N3JKeLzYpYHkX8OUSkP
         927nd8SVTdQDk6yy/TF4bNH9eAzdb/4L7rlXZ1y1keLWA29WMy34D10Q5OEMI9OLW0
         O0XlbZ/FwE4TpyX/576N0x2yNjoLcK3b03ayjjnmRMW9d0IqaD10Ylr1PslMQmCDNW
         9rAtYKlU5ujrc7+r3JPXGPtmVw4g52q9SsQDjLiBeTvuid92PhYpJ3ZJY25F/KNhmz
         4GgusRZrSDEmg==
Date:   Wed, 9 Mar 2022 23:25:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 09/19] rcu/context-tracking: Remove rcu_irq_enter/exit()
Message-ID: <20220309222520.GF68899@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-10-frederic@kernel.org>
 <20220305141603.GY11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305141603.GY11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 03:16:03PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:48:00PM +0100, Frederic Weisbecker wrote:
> >  void ct_irq_enter_irqson(void)
> >  {
> > -	rcu_irq_enter_irqson();
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	ct_irq_enter();
> > +	local_irq_restore(flags);
> >  }
> >  
> >  void ct_irq_exit_irqson(void)
> >  {
> > -	rcu_irq_exit_irqson();
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	ct_irq_exit();
> > +	local_irq_restore(flags);
> >  }
> 
> I know you're just copying code around, but this is broken per
> construction :/
> 
> On the irq_enter site, local_irq_save() will hit a tracepoint, which
> requires RCU, which will only be made available by the ct_irq_enter().
> Same in reverse for the exit case.

Ouch. And playing a game similar to that in default_idle_call() is going to
be trickier because rcu_irq_enter() may or may not exit an RCU-off mode. But it's
feasible. Again I'll fix it ahead.

Thanks!
