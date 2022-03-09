Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463144D3B69
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiCIUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiCIUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:54:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25394D049D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92DC61A69
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9966BC340E8;
        Wed,  9 Mar 2022 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646859192;
        bh=PP2xh1vGoujSuJeCpjQG3H8UeMvu6Kpl1mVn08zxKdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSwuwHAc+s+D2OankmMjDhFhntRl7uYIKbLPKmwZ0inm3J3sd5nmW/6zN6wSCsuM2
         /4+fvRjKe8QbfDhbqZd+JWiCED8C4Zt65bEOCfPi6Am0EFGltBmvdcB0wByWe0v0jK
         2HR4/OGlbAFIqdMCazHD+WUKjpO3mK4Bnw3chRNRp80D/ruMCIKjS1Yr5+WnVmhiXw
         jUceZKcEZGx2k154/QLPgRhrZtChkgIaLnWjMxpLOvNRv9VdyH92grkkAbDFXkIJ/l
         qDqbkzccVNS2JxFkJKY1QAXOQUD8aBI8LM+MsWJOXQtI1ZweRBQ1O7FNhaNFnVa0O4
         qCbl068CLkOPw==
Date:   Wed, 9 Mar 2022 21:53:09 +0100
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
Subject: Re: [PATCH 02/19] context_tracking: Rename
 context_tracking_user_enter/exit() to user_enter/exit_callable()
Message-ID: <20220309205309.GA68269@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-3-frederic@kernel.org>
 <20220305135940.GU11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305135940.GU11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:59:40PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:47:53PM +0100, Frederic Weisbecker wrote:
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index ad2a973393a6..83e050675b23 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -125,11 +125,16 @@ void context_tracking_enter(enum ctx_state state)
> >  NOKPROBE_SYMBOL(context_tracking_enter);
> >  EXPORT_SYMBOL_GPL(context_tracking_enter);
> >  
> > -void context_tracking_user_enter(void)
> > +/**
> > + * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
> > + * 			   archs that didn't manage to check the context tracking
> > + * 			   static key from low level code.
> > + */
> > +void user_enter_callable(void)
> >  {
> >  	user_enter();
> >  }
> > -NOKPROBE_SYMBOL(context_tracking_user_enter);
> > +NOKPROBE_SYMBOL(user_enter_callable);
> >  
> >  /**
> >   * __ct_user_exit - Inform the context tracking that the CPU is
> > @@ -182,11 +187,16 @@ void context_tracking_exit(enum ctx_state state)
> >  NOKPROBE_SYMBOL(context_tracking_exit);
> >  EXPORT_SYMBOL_GPL(context_tracking_exit);
> >  
> > -void context_tracking_user_exit(void)
> > +/**
> > + * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
> > + * 			  archs that didn't manage to check the context tracking
> > + * 			  static key from low level code.
> > + */
> > +void user_exit_callable(void)
> >  {
> >  	user_exit();
> >  }
> > -NOKPROBE_SYMBOL(context_tracking_user_exit);
> > +NOKPROBE_SYMBOL(user_exit_callable);
> 
> I'm thinking all this wants to be noinstr instead of NOKPROBE_SYMBOL..

Good point, I'll fix that ahead.
