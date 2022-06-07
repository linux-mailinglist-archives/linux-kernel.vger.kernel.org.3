Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974A753F4B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiFGDrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiFGDrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:47:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2EB45;
        Mon,  6 Jun 2022 20:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF431B81C9C;
        Tue,  7 Jun 2022 03:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D1EC385A5;
        Tue,  7 Jun 2022 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573630;
        bh=MVpr40KTbILxZwA1w6h0iiwkJlj3LKyq0Znk4sfngig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LrRM8vysDihuh8gOBCTHPWQrGlN6AFMqU3tcFP7/45J42nW8gs+SKqUOlxvq5xTd7
         KM95af5i9tZAb2UvqgUlJ8TZLvLF3PIBeTrTsoBZDpWjWa8Hc8UGttNU/qnp5G+mSr
         sVab3KCD+k/mT4BgIiBFuPTVFfs/64ugqGeGv7ANQiDj+bJK4teH8VT09/8bKSH967
         0SKW0UqA5DSVX8ZovxAWQogOSeTzMEnjWbOIv3B7biXrjSRAgIaC2QKffswU4lbOeJ
         +aLwD60qZg0sPGiwF4w0Z3z7Aby20SU3d6/g7asbD8I18N1NU0qF3fk3EX9R39+uug
         cKhIHY1PR3MHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B8E55C05C5; Mon,  6 Jun 2022 20:47:10 -0700 (PDT)
Date:   Mon, 6 Jun 2022 20:47:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <20220607034710.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpxzB3/HRN/EEHa8@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpxzB3/HRN/EEHa8@pc638.lan>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 11:10:31AM +0200, Uladzislau Rezki wrote:
> > On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > > Currently the monitor work is scheduled with a fixed interval that
> > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > a low utilization of page slot in some scenarios. The page can store
> > > up to 512 records. For example on Android system it can look like:
> > > 
> > > <snip>
> > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > <snip>
> > > 
> > > where a page only carries few records to reclaim a memory. In order to
> > > improve batching and make utilization more efficient the patch introduces
> > > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > > case a memory reclaim occurs more often whereas in mostly idle cases the
> > > interval is set to its maximum timeout that improves the utilization of
> > > page slots.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > That does look like a problem well worth solving!
> >
> Agree, better ideas make better final solution :)
> 
> > 
> > But I am missing one thing. If we are having a callback flood, why do we
> > need a shorter timeout?
> >
> To offload faster, because otherwise we run into classical issue, it is a low
> memory condition state resulting in OOM.

But doesn't each callback queued during the flood give us an opportunity
to react to the flood?  That will be way more fine-grained than any
reasonable timer, right?  Or am I missing something?

I do agree that the action would often need to be indirect to avoid the
memory-allocation-state hassles, but we already can do that, either via
an extremely short-term hrtimer or something like irq-work.

> > Wouldn't a check on the number of blocks queued be simpler, more direct,
> > and provide faster response to the start of a callback flood?
> >
> I rely on krcp->count because not always we can store the pointer in the page
> slots. We can not allocate a page in the caller context thus we use page-cache
> worker that fills the cache in normal context. While it populates the cache, 
> pointers temporary are queued to the linked-list.
> 
> Any thoughts?

There are a great many ways to approach this.  One of them is to maintain
a per-CPU free-running counter of kvfree_rcu() calls, and to reset this
counter each jiffy.

Or am I missing a trick here?

							Thanx, Paul
