Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5B52D643
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiESOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiESOh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:37:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B49E8B92
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF5E0CE24C1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD88C385B8;
        Thu, 19 May 2022 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652971061;
        bh=0464BZO3U+wjKojrSum++rOWCaIV9ebLIZTil/7y5HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvXuIwMe5aBC3wbPIZmbNJfIGpWzAORaB+iTRLrjZEXfQVUtT6AKkHswCDRG/u2lo
         Ik0Cqpkz/giCfnIZqWGGSomlLsG6oArjgWyYyk4mN0cN37fvHUYKCneXNfuaevQ9Nq
         PyCydXOFpbZg6YTIKbMA0ooKvInHW79JFZLO4vXKpXOMgte0rM0lK+JRZYRpQelrCX
         kGLrpOvp6amQEmClO0tqSZ4dcblHXmZRcKHeYI7DEQF4uUu+GwDylMDkP1EMuhGY8N
         XRSz8+H/EtMpxcrxNW8QH6Fk5F06sKJDkoRliSSGM9qMGChAiXD4uNCtGTl6P4wgyd
         ZOTbo9Avl25vQ==
Date:   Thu, 19 May 2022 16:37:38 +0200
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 20/21] context_tracking: Convert state to atomic_t
Message-ID: <20220519143738.GA612967@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-21-frederic@kernel.org>
 <372364b33b8d4b93908c3822e18f7d295de2ede9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372364b33b8d4b93908c3822e18f7d295de2ede9.camel@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 05:09:55PM +0200, nicolas saenz julienne wrote:
> On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:
> 
> [...]
> 
> > +/**
> > + * ct_state() - return the current context tracking state if known
> > + *
> > + * Returns the current cpu's context tracking state if context tracking
> > + * is enabled.  If context tracking is disabled, returns
> > + * CONTEXT_DISABLED.  This should be used primarily for debugging.
> > + */
> > +static __always_inline int ct_state(void)
> > +{
> > +	int ret;
> > +
> > +	if (!context_tracking_enabled())
> > +		return CONTEXT_DISABLED;
> > +
> > +	preempt_disable();
> > +	ret = __ct_state();
> > +	preempt_enable();
> > +
> > +	return ret;
> > +}
> > +
> 
> I can't see any use for this function with preemption enabled. You can't trust
> the data due to CPU migration and it could be a source of bugs in the future.
> Wouldn't it make more sense to move the burden into the callers? They all DTRT,
> plus, this_cpu_ptr() will spew warnings if someone shows up and doesn't comply.

I believe syscall_exit_to_user_mode_prepare() has preemption enabled.
Then it's ok if we are scheduled away right before the check, it still applies
on any CPU.
