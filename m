Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7657C3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGUErM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUErK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517F78DE2;
        Wed, 20 Jul 2022 21:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD8761805;
        Thu, 21 Jul 2022 04:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE697C3411E;
        Thu, 21 Jul 2022 04:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658378828;
        bh=1b6KFnzt/XRO3H9QzuEte6FrE/uR0jOfEb/7nMgJjuw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dn+B/nOHUX/baSwA/l4KE/nRknv1cMibO62yJHy47tfTCkzHdv+mqcMy1Dk0Pt4Ap
         5CLSYbKJv1AXH92XWRlSutGgRlnpWCtKR2zfWeueNIHURsUKL5OngFUJpjmACgf40N
         PMwxP7nB0XJtzmij3R1MaG6QqVDE1FYMyMwCue8hP3BkibqDCj+uoPB+vmdFNbz9Ds
         9x35Ugk0CAYYw9GYtgip/bX4ZBCTl8GRFCWwkwREISNyJHV6YFEYHWoozdcmPHIu91
         d8nE/zzaaf2SCF4i6aFysiY7D4Rkt7A1isCY50SNUjz8TtDyWQ8OObp5gv/ywbLscU
         zYr0iLWOnOyaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F3585C054C; Wed, 20 Jul 2022 21:47:08 -0700 (PDT)
Date:   Wed, 20 Jul 2022 21:47:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to
 ->gp_seq_polled
Message-ID: <20220721044708.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
 <20220620225128.3842050-4-paulmck@kernel.org>
 <Ytijki0fkkyKaD9u@boqun-archlinux>
 <20220721010455.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YtixMeMCcqAyeTiH@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtixMeMCcqAyeTiH@boqun-archlinux>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:51:45PM -0700, Boqun Feng wrote:
> On Wed, Jul 20, 2022 at 06:04:55PM -0700, Paul E. McKenney wrote:
> [...]
> > > > @@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
> > > >  	 * before the load from ->gp_seq.
> > > >  	 */
> > > >  	smp_mb();  /* ^^^ */
> > > > -	return rcu_seq_snap(&rcu_state.gp_seq);
> > > > +	return rcu_seq_snap(&rcu_state.gp_seq_polled);
> > > 
> > > I happened to run into this. There is one usage of
> > > get_state_synchronize_rcu() in start_poll_synchronize_rcu(), in which
> > > the return value of get_state_synchronize_rcu() ("gp_seq") will be used
> > > for rcu_start_this_gp(). I don't think this is quite right, because
> > > after this change, rcu_state.gp_seq and rcu_state.gp_seq_polled are
> > > different values, in fact ->gp_seq_polled is greater than ->gp_seq
> > > by how many synchronize_rcu() is called in early boot.
> > > 
> > > Am I missing something here?
> > 
> > It does not appear that your are missing anything, sad to say!
> > 
> > Does the following make it work better?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 2122359f0c862..cf2fd58a93a41 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3571,7 +3571,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
> >  unsigned long start_poll_synchronize_rcu(void)
> >  {
> >  	unsigned long flags;
> > -	unsigned long gp_seq = get_state_synchronize_rcu();
> > +	unsigned long gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
> 
> get_state_synchronize_rcu() is still needed, because we need to return
> a cookie for polling for this function. Something like below maybe? Hope
> I didn't mess up the ordering ;-)

My thought is to combine your comment with my functionally equivalent
code that avoids the extra variable.  If that works for you (and if it
works, for that matter), does Co-developed-by work for you?

							Thanx, Paul

> Regards,
> Boqun
> 
> ---------------
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 84d281776688..0f9134871289 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3571,11 +3583,39 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
>  unsigned long start_poll_synchronize_rcu(void)
>  {
>         unsigned long flags;
> -       unsigned long gp_seq = get_state_synchronize_rcu();
> +       unsigned long gp_seq_poll = get_state_synchronize_rcu();
> +       unsigned long gp_seq;
>         bool needwake;
>         struct rcu_data *rdp;
>         struct rcu_node *rnp;
> 
> +       /*
> +        * Need to start a gp if no gp has been started yet.
> +        *
> +        * Note that we need to snapshot gp_seq after gp_seq_poll, otherwise
> +        * consider the follow case:
> +        *
> +        *      <no gp in progress>     // gp# is 0
> +        *      snapshot gp_seq         // gp #2 will be set as needed
> +        *      <a gp passed>
> +        *                              // gp# is 1
> +        *      snapshot gp_seq_poll    // polling gets ready until gp #3
> +        *
> +        * then the following rcu_start_this_gp() won't mark gp #3 as needed,
> +        * and polling won't become ready if others don't start a gp.
> +        *
> +        * And the following case is fine:
> +        *
> +        *      <no gp in progress>     // gp# is 0
> +        *      snapshot gp_seq_poll    // polling gets ready until gp #2
> +        *      <a gp passed>
> +        *                              // gp# is 1
> +        *      snapshot gp_seq         // gp #3 will be set as needed
> +        *
> +        * Also note, we rely on the smp_mb() in get_state_synchronize_rcu()
> +        * to order the two snapshots.
> +        */
> +       gp_seq = rcu_seq_snap(&rcu_state.gp_seq);
>         lockdep_assert_irqs_enabled();
>         local_irq_save(flags);
>         rdp = this_cpu_ptr(&rcu_data);
> @@ -3585,7 +3625,7 @@ unsigned long start_poll_synchronize_rcu(void)
>         raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>         if (needwake)
>                 rcu_gp_kthread_wake();
> -       return gp_seq;
> +       return gp_seq_poll;
>  }
>  EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
