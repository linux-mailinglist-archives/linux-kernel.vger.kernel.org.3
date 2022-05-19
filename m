Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03452D778
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiESP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiESP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3D38DB2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1663B82291
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9DC385AA;
        Thu, 19 May 2022 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652973971;
        bh=fiU4NSF4TvUqiWY49Pnepo8xHAf+TC9fyzWCuoONWSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fT05jFy9zsasv/0XEbUaeRGAwVYHZ+iVYn4tGImCV1g/82vc5UJgb6KgespOE/oyU
         PTR6Krj8fmuBwUbAno9Jtcz/Ov+IDSkkFAcEG6P9yg91vstIyeL9Y3niQxd6xZVnwD
         GyUnn+1i+PJIf6AtDuJYjLavPVTIbKiRcxgMtbufy+VIi6+On4/WDFzRqaHX+jRwcT
         KMkvaftyMewxexNsxXUXJt7z95ozYa7su9z5tGNH/JJXnalCEKmI7gLVFjWPkML8k/
         B6DB1uBBH8faCh81l38lASDRNg9I7Zkr3fv5JiyFBSEvPlJ9wushSDRP/x0yIwZB4o
         h03xGTukmPXIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38FD75C04E0; Thu, 19 May 2022 08:26:11 -0700 (PDT)
Date:   Thu, 19 May 2022 08:26:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <20220519152611.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
 <20220519145438.GJ2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519145438.GJ2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:54:38PM +0200, Peter Zijlstra wrote:
> On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> > Some RCU functions enter or exit into/from RCU idle mode while using
> > trace-able and lockdep-aware IRQs (un-)masking. This could be easily
> > solved with using raw versions of local_irq_*() but we would then
> > lose some precious debugging informations.
> > 
> > Another possible way to solve this may consist in using rude RCU-tasks
> > in lockdep and irqsoff tracing.
> > 
> > In any case and until this get solved, those RCU functions can't get
> > tagged as noinstr even though they should.
> 
> FWIW, this also means RCU_NONIDLE() is broken. Luckily there aren't many
> users left.

More to the point, rcu_irq_enter_irqson() and rcu_irq_exit_irqson() need
the same help that rcu_idle_enter() and rcu_idle_exit() got earlier this
week [1], independent of RCU_NONIDLE().

Unless Frederic beats me to it, I will queue something up.

							Thanx, Paul

[1] https://lore.kernel.org/all/20220518162118.GA2661055@paulmck-ThinkPad-P17-Gen-1/
