Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA34D647E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiCKPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiCKPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:25:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E181B30BA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:24:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E568D61530
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7921C340E9;
        Fri, 11 Mar 2022 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647012269;
        bh=g4Te640jhsFX03myFh35bEx8907G0PHqW4RzxS5KFHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwXmmgAgHWk2WE72ZiDqiXEhpiv2kUeTzKx7xWaLwHT58FW/irdSuONjfDR7Ovcu2
         wmGbY1+5emkNOvn5139VkIjTu1EMSjbFVMzHq8OM6GqmU14otz5mndAqOvtbBvI41E
         TCazz/mtoohL0HIIlQz69ZSIz3aeH8u6i8qx19raxM8zTPfhyTSByYTmwmWHLU8U5S
         8rTAD3TVvP/VsWET4YJTbmZI2qX/NsfQaTwfaRXrXoy7GOe0YZFm/K6pXbxBd4HX2d
         JqyjEpNWkCrkRkEOukAdYkScjQ6SB9zyb73We6lPtVXuc6t9OfRKi4ISn6GBJqKhJj
         A9tL8sQyiOV2w==
Date:   Fri, 11 Mar 2022 16:24:26 +0100
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
Subject: Re: [PATCH 16/19] context_tracking: Convert state to atomic_t
Message-ID: <20220311152426.GB227945@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-17-frederic@kernel.org>
 <23cbcd6a467c211f792ff54d50635cd6536c9dcc.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cbcd6a467c211f792ff54d50635cd6536c9dcc.camel@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 06:17:02PM +0100, nicolas saenz julienne wrote:
> On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> > Context tracking's state and dynticks counter are going to be merged
> > in a single field so that both updates can happen atomically and at the
> > same time. Prepare for that with converting the state into an atomic_t.
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
> >  static __always_inline bool context_tracking_in_user(void)
> >  {
> > -	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
> > +	return __ct_state() == CONTEXT_USER;
> >  }
> 
> I was wondering whether it'd make more sense to use ct_state() for extra safety
> vs preemption, but it turns out the function isn't being used at all.
> 
> I figure it'd be better to remove it altogether and leave ct_state() as the
> goto function for this sort of checks.

Ah even better!

> 
> >  #else
> >  static inline bool context_tracking_in_user(void) { return false; }
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index de247e758767..69db43548768 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -337,6 +337,7 @@ static __always_inline void context_tracking_recursion_exit(void)
> >   */
> >  void noinstr __ct_user_enter(enum ctx_state state)
> >  {
> > +	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
> 
> I wonder if there is any value to having __ct_state() take 'struct
> context_tracking *ct' as an argument to avoid a redundant this_cpu_ptr()...
> 
> >  	lockdep_assert_irqs_disabled();
> >  
> >  	/* Kernel threads aren't supposed to go to userspace */
> > @@ -345,8 +346,8 @@ void noinstr __ct_user_enter(enum ctx_state state)
> >  	if (!context_tracking_recursion_enter())
> >  		return;
> >  
> > -	if ( __this_cpu_read(context_tracking.state) != state) {
> > -		if (__this_cpu_read(context_tracking.active)) {
> > +	if (__ct_state() != state) {
> 
> ...here (and in __ct_user_exit()).

Hmm, I'll check that.

Thanks!
