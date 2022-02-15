Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D74B7660
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiBORcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:32:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiBORc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:32:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D251D33A;
        Tue, 15 Feb 2022 09:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A29615EF;
        Tue, 15 Feb 2022 17:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396CC340EB;
        Tue, 15 Feb 2022 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644946337;
        bh=dWJuGin0yny3G/JlamcHgjYAM9ls/bo33ms1my3RK4M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k2dValidg8ClDnhpDiX2/p01wd0zpBMbzPs5Txa4eWOEqT7fOJKth1KTMJtKLx9yE
         dIOmIpAlWrqTShTrFMi6s69hQUumFCjwxIA8gaaUZSpVeZO8O4R3FTMwoHLRb3T/AQ
         fdz/faCQ0N9ozaaKfTnjRyt7hMY8V7paVlHnN5jhdz1fn9P7Ihroa388jyElLdPDY5
         foECbklDNLNqI8CMjfcofeHZP4DE2Xlc+CME/3oMbT3CgY+zn+9WvHsSedzmtiJ1jt
         WdHBa6g8ztDC2Q3DoDOuEsYRdHqKfB7vPa7cUTId9hPoL942V6kfCRjB55Jk/sPYdd
         NFWk9NQ+GI/LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B55C25C0641; Tue, 15 Feb 2022 09:32:16 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:32:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        willy@infradead.org
Subject: Re: [PATCH 2/2] mm/page_alloc: Add remote draining support to
 per-cpu lists
Message-ID: <20220215173216.GG4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <20220208100750.1189808-3-nsaenzju@redhat.com>
 <YgKQfsznPUDN34un@fuller.cnet>
 <2374bbca7651b671ec934fa5c630cbe3eed3b496.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2374bbca7651b671ec934fa5c630cbe3eed3b496.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:47:35AM +0100, Nicolas Saenz Julienne wrote:
> On Tue, 2022-02-08 at 12:47 -0300, Marcelo Tosatti wrote:
> > > Changes since RFC:
> > >  - Avoid unnecessary spin_lock_irqsave/restore() in free_pcppages_bulk()
> > >  - Add more detail to commit and code comments.
> > >  - Use synchronize_rcu() instead of synchronize_rcu_expedited(), the RCU
> > >    documentation says to avoid it unless really justified. I don't think
> > >    it's justified here, if we can schedule and join works, waiting for
> > >    an RCU grace period is OK.
> > 
> > https://patchwork.ozlabs.org/project/netdev/patch/1306228052.3026.16.camel@edumazet-laptop/
> > 
> > Adding 100ms to direct reclaim path might be problematic. It will also
> > slowdown kcompactd (note it'll call drain_all_pages for each zone).
> 
> I did some measurements on an idle machine, worst case was ~30ms. I agree that
> might too much for direct reclaim, so I'll switch back to expedited and add a
> comment.

Given your measurements, it looks to me like this is a case where use
of expedited grace periods really is justified.

For one thing, expedited grace periods are much less disruptive than
they were in the old days, for example, back when they used stop-machine.
For another thing, systems that cannot tolerate the disturbance (an IPI
per non-idle non-nohz_full CPU per grace period, less than a wakeup)
can always be booted with rcupdate.rcu_normal=1, which will make
synchronize_rcu_expedited() act like synchronize_rcu(), at least once
RCU has spawned its kthreads.  And CONFIG_PREEMPT_RT=y kernels forcibly
set this mode.  ;-)

Nevertheless, expedited grace periods should not be used lightly because
they do increase overhead.

							Thanx, Paul

> > >  - Avoid sparse warnings by using rcu_access_pointer() and
> > >    rcu_dereference_protected().
> > > 
> > >  include/linux/mmzone.h |  22 +++++-
> > >  mm/page_alloc.c        | 155 ++++++++++++++++++++++++++---------------
> > >  mm/vmstat.c            |   6 +-
> > >  3 files changed, 120 insertions(+), 63 deletions(-)
> > > 
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index b4cb85d9c6e8..b0b593fd8e48 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -388,13 +388,31 @@ struct per_cpu_pages {
> > >  	short expire;		/* When 0, remote pagesets are drained */
> > >  #endif
> > >  
> > > -	struct pcplists *lp;
> > > +	/*
> > > +	 * As a rule of thumb, any access to struct per_cpu_pages's 'lp' has
> > > +	 * happen with the pagesets local_lock held and using
> > > +	 * rcu_dereference_check(). If there is a need to modify both
> > > +	 * 'lp->count' and 'lp->lists' in the same critical section 'pcp->lp'
> > > +	 * can only be derefrenced once. See for example:
> > 
> > Typo.
> 
> Noted.
> 
> Thanks!
> 
> -- 
> Nicolás Sáenz
> 
