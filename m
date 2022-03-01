Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB344C93AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiCAS7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCAS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:59:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70196FC4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:58:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C96A61548
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE3C340EE;
        Tue,  1 Mar 2022 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646161103;
        bh=2/nZgk/9IpyftnMuUy57Y4SE+vy+TOgblD9YKfS1pT4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qlJOMjJVIpRICBycDW/tW+DNUiiSoODQHiAgAAxn+dOnml97PlXpm62oH12MSw7lL
         qj2FiUrL/zFk3YbUwNEOMx1/lyIBGU1DbqhNnvHli2QSoCPTpjY/JgyIuUgnOqDTnX
         QpqJcLdOXq5ijeGPFynnBOiOp2AWPxXTjdwpomYTJHMRGJQLj+NyKcBYatjBUE4bCX
         D42G7iuaax8UqaT0g3tNWx65MHmW8qsKdiSh+QxaSwbd+XmPJL2Mxx7QRWqZGPlUL2
         TYODUx+qgPPOhRwIIC3xZg7Yd5/KSjz5yLnf2QRgeQ66u8JGENPj8JnzocEaSyLjfa
         1+DCrtx+Rc9Kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 09CE25C0440; Tue,  1 Mar 2022 10:58:23 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:58:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220301185823.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220228141423.259691-1-nsaenzju@redhat.com>
 <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
 <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
 <69e92bc6-0917-17e9-1b61-d884d30ba42c@kernel.org>
 <20220301180509.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <c3cf7c0c-27fe-4dfa-4249-a7e1747237a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cf7c0c-27fe-4dfa-4249-a7e1747237a5@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 07:44:38PM +0100, Daniel Bristot de Oliveira wrote:
> On 3/1/22 19:05, Paul E. McKenney wrote:
> >> I see, as long as it costs < 1 us, I am ok. If it gets > 1us in a reasonably
> >> fast machine, we start see HW noise where it does not exist, and that would
> >> reduce the resolution of osnoise. AFAICS, it is not causing that problem, but we
> >> need to make it as lightweight as possible.
> > In the common case, it is atomically incrementing a local per-CPU counter
> > and doing a store.  This should be quite cheap.
> > 
> > The uncommon case is when the osnoise process was preempted or otherwise
> > interfered with during a recent RCU read-side critical section and
> > preemption was disabled around that critical section's outermost
> > rcu_read_unlock().  This can be quite expensive.  But I would expect
> > you to just not do this.  ;-)
> 
> Getting the expensive call after a preemption is not a problem, it is a side
> effect of the most costly preemption.
> 
> It this case, we should "ping rcu" before reading the time to account the
> overhead for the previous preemption which caused it.
> 
> like (using the current code as example):
> 
> ------------------------- %< -------------------------------
> static u64
> set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
> {
>         u64 int_counter;
> 
>         do {
>                 int_counter = local_read(&osn_var->int_counter);
> 
> 		------------> HERE <-------------------------------------
> 
>                 /* synchronize with interrupts */
>                 barrier();
> 
>                 *time = time_get();
> 
>                 /* synchronize with interrupts */
>                 barrier();
>         } while (int_counter != local_read(&osn_var->int_counter));
> 
>         return int_counter;
> }
> ------------------------- >% -------------------------------
> 
> In this way anything that happens before this *time is accounted before it is
> get. If anything happens while this loop is running, it will run again, so it is
> safe to point to the previous case.
> 
> We would have to make a copy of this function, and only use the copy for the
> run_osnoise() case. A good name would be something in the lines of
> set_int_safe_time_rcu().
> 
> (Unless the expensive is < than 1us.)

The outermost rcu_read_unlock() could involve a call into the scheduler
to do an RCU priority deboost, which I would imagine could be a bit
expensive.  But I would expect you to configure the test in such a way
that there was no need for RCU priority boosting.  For example, by making
sure that the osnoise process's RCU readers were never preempted.

Just out of curiosity, why is this running in the kernel rather than in
userspace?  To focus only on kernel-centric noise sources?  Or are there
people implementing real-time applications within the kernel?

							Thanx, Paul
