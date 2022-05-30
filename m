Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516253889B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiE3VgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiE3VgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:36:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3090999825;
        Mon, 30 May 2022 14:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCD5BB80EFB;
        Mon, 30 May 2022 21:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB8EC385B8;
        Mon, 30 May 2022 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653946560;
        bh=7YNcmkRLolF/kp8AznAQ6pw37uC1DOd0oAfeaiw3X8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD8A1irvFLWQWd0Xei8uTuSGLDsSYQpPYzOVw2207sej/d/+q9qG2XUdVZskucLjw
         OD0DvHktTSm+HoCicUQAlubMVp6uAPtFdcEkI2JknWEnVwggVJ6V45/1SE8NKUhrbv
         4aQ8NqFzXWptLb3/Q8SgsAUYLO//8NcMycXcO9ZdpFD9KH8Zwtm98VSyYrM/MVMD1d
         sb4Am06ug9S+OA4GWiPCna/HKjT5M9fFn5WWWhvK4zXkWOGMfhF3mNQBEsZzPeEtzG
         EcWdEkRs/sRp+OJAGLzTgcP/J2f5J2QA5NRrtdWLjexPBWzr183j6oCGhrFE1HGqa6
         R6o7JSf0K4TXw==
Date:   Mon, 30 May 2022 23:35:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220530213556.GD1257179@lothringen>
References: <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
 <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 03:16:27PM +0200, Peter Zijlstra wrote:
> On Mon, May 30, 2022 at 12:56:50PM +0200, Frederic Weisbecker wrote:
> 
> > > This is ABI, you can't walk back on it. I would suggest starting with an
> > > 'all feature' isolation. Only if there's real demand for something more
> > > fine-grained add that on top. Simple first etc.
> > 
> > That's actually my worry. If we start with an all in one ABI, how do we later
> > mix that up with more finegrained features? Like what will be the behaviour of:
> > 
> > cpuset.isolation.rcu_nocb = 0
> > cpuset.isolation.all = 1
> 
> Well clearly that doesn't make sense. I was more thinking along the
> lines of cgroup.subtree_control, where instead all features are enabled
> by default.
> 
> But only if there's a real usecase, otherwise there's no point in
> providing such knobs.

That makes sense. So there would be a simple cpuset.isolation that can
be either 1 or 0 where 1 has all possible isolation stuff on. Then
if the need arises we can provide more tuning through a new specific
cgroup controller, right?

If so that sounds good to me.
