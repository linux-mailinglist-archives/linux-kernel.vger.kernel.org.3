Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F784D3BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiCIVXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiCIVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D809A4E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F314161AEF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07130C340E8;
        Wed,  9 Mar 2022 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646860920;
        bh=W/yJ31yvINnCkFPJ/WGugTbL/AIM/a5yU8NIPqHVdRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzzbN3WQ/eHy7TvRMTESk9kdTBhqwF8NDHxan2+8yfJsxUELeQLn3SoTPooFQWO7S
         9M/LZGEDxu9w3JQN7QbzfE+idZoWVsTSOB0hZeafpkOGSTkOFquc7SEUdvAmnxvTki
         RzbP1qJ8CmiOFm87/iaSIlj7qGncpazig41NpCTMGfM3Q2ql8ZDwEv7N/ksJhcKXfi
         hFkKNN7yvuQAp+xOGhasTH53g0wpuYhp21AiHy8KC+ommwlgZEyEnbJIe3tJizrFpC
         ZgwCrdQuPYO+Lzpb3MCr+WQqwkbY73xYbFvXAOIi3PPGllaWZIjNxoQ/fe2AGW2yhh
         ymFTJD/gW+qCw==
Date:   Wed, 9 Mar 2022 22:21:57 +0100
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
Subject: Re: [PATCH 03/19] context_tracking: Rename
 context_tracking_enter/exit() to ct_user_enter/exit()
Message-ID: <20220309212157.GD68899@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-4-frederic@kernel.org>
 <20220305140233.GV11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305140233.GV11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 03:02:33PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:47:54PM +0100, Frederic Weisbecker wrote:
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index 83e050675b23..e8e58c10f135 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -103,7 +103,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
> >  }
> >  EXPORT_SYMBOL_GPL(__ct_user_enter);
> >  
> > -void context_tracking_enter(enum ctx_state state)
> > +void ct_user_enter(enum ctx_state state)
> >  {
> >  	unsigned long flags;
> >  
> > @@ -122,8 +122,8 @@ void context_tracking_enter(enum ctx_state state)
> >  	__ct_user_enter(state);
> >  	local_irq_restore(flags);
> >  }
> > -NOKPROBE_SYMBOL(context_tracking_enter);
> > -EXPORT_SYMBOL_GPL(context_tracking_enter);
> > +NOKPROBE_SYMBOL(ct_user_enter);
> > +EXPORT_SYMBOL_GPL(ct_user_enter);
> >  
> >  /**
> >   * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
> > @@ -173,7 +173,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
> >  }
> >  EXPORT_SYMBOL_GPL(__ct_user_exit);
> >  
> > -void context_tracking_exit(enum ctx_state state)
> > +void ct_user_exit(enum ctx_state state)
> >  {
> >  	unsigned long flags;
> >  
> > @@ -184,8 +184,8 @@ void context_tracking_exit(enum ctx_state state)
> >  	__ct_user_exit(state);
> >  	local_irq_restore(flags);
> >  }
> > -NOKPROBE_SYMBOL(context_tracking_exit);
> > -EXPORT_SYMBOL_GPL(context_tracking_exit);
> > +NOKPROBE_SYMBOL(ct_user_exit);
> > +EXPORT_SYMBOL_GPL(ct_user_exit);
> >  
> >  /**
> >   * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
> 
> Why is it NOKPROBE but not notrace, also local_irq_*() include explicit
> tracepoints.

Again stuff I need to fix ahead. Thanks for catching that.

Thanks!
