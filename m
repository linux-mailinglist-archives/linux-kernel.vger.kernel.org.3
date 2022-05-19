Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3FB52D7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbiESPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiESPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:36:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6D66CA8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7953EB82291
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CCBC385AA;
        Thu, 19 May 2022 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974530;
        bh=FXXdmKJx9OG/3f612TLCNMeE8xaowuI6lWU8XkiHicE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewbtFM8ax3OCaWLC8z2u+/La7nmXFmE48clx59622saby+/0dI/bjlvOXOwf8z0eV
         enZRRJsLYwL1m8aPej6qKglGYkO6EEtLEn8E1snPxFrZFri9Ueow5FFXrNbbXpkms0
         DYnyjWHj8bni3of5Dtko6YkAG6A2CKveCzm+lhafUQ00mPZo12h0ujV8IcukjYZh0w
         nXCCIYtlkmvwb0Qf98fvAi2k/qlfhqB1wMYrVJ6qGiWtpbhRWi1bwjHCNebiCeNJ0L
         d12nBqZsFbkzavkPTyLbMw0xgTKAHke29SouPBWfJYOMBjW875f5rKRWhqT/29bu25
         cPwJ5vnnyIv/g==
Date:   Thu, 19 May 2022 17:35:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/21] rcu: Add a note about noinstr VS unsafe eqs
 functions
Message-ID: <20220519153527.GE618878@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
 <20220519145438.GJ2578@worktop.programming.kicks-ass.net>
 <20220519152611.GY1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519152611.GY1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:26:11AM -0700, Paul E. McKenney wrote:
> On Thu, May 19, 2022 at 04:54:38PM +0200, Peter Zijlstra wrote:
> > On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> > > Some RCU functions enter or exit into/from RCU idle mode while using
> > > trace-able and lockdep-aware IRQs (un-)masking. This could be easily
> > > solved with using raw versions of local_irq_*() but we would then
> > > lose some precious debugging informations.
> > > 
> > > Another possible way to solve this may consist in using rude RCU-tasks
> > > in lockdep and irqsoff tracing.
> > > 
> > > In any case and until this get solved, those RCU functions can't get
> > > tagged as noinstr even though they should.
> > 
> > FWIW, this also means RCU_NONIDLE() is broken. Luckily there aren't many
> > users left.
> 
> More to the point, rcu_irq_enter_irqson() and rcu_irq_exit_irqson() need
> the same help that rcu_idle_enter() and rcu_idle_exit() got earlier this
> week [1], independent of RCU_NONIDLE().
> 
> Unless Frederic beats me to it, I will queue something up.

It's in the patchset I just posted (02/21).

> 
> 							Thanx, Paul
> 
> [1] https://lore.kernel.org/all/20220518162118.GA2661055@paulmck-ThinkPad-P17-Gen-1/
