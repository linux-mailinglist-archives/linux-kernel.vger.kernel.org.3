Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438F537B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiE3NQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiE3NQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:16:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB364ED;
        Mon, 30 May 2022 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=obYBR28FbpSJAp30gAezgU5OKkXGsA5r4rJru5EBzPo=; b=Jg0O7ZkawyIbRQYiQh/fe1DLO5
        pOHRuud+4bXV4vL70xI5fSEpFwKXx0k5p4uGlhacsWYGmIHWHSsVGbRyuXlR3uffdhblS/7bbXNKi
        wFgq5v6bZdIQTW8lSpbYaBomCcTk41s8jINRbPxdE4s4Z5HP0k2UJAAhioDN9Bj4fRvk324HcvURl
        Qk5VRSvmcYMXz1ORFPtzMgA/OtlL7xWpuu/TcLqh7cvKTFCHVCClBOSJFTmCfDAT8CY8PPs4AzG8T
        3Nnct7Q0l8e+WE/0fLFV7vgC8CiW8FRkiGpRXWR9rMLz6kxKhh527AUvtIxDXX7zzjuga2UOZifWq
        U9dDap5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvfG2-004Umx-3z; Mon, 30 May 2022 13:16:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB035980DE7; Mon, 30 May 2022 15:16:27 +0200 (CEST)
Date:   Mon, 30 May 2022 15:16:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
References: <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530105650.GA1257179@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 12:56:50PM +0200, Frederic Weisbecker wrote:

> > This is ABI, you can't walk back on it. I would suggest starting with an
> > 'all feature' isolation. Only if there's real demand for something more
> > fine-grained add that on top. Simple first etc.
> 
> That's actually my worry. If we start with an all in one ABI, how do we later
> mix that up with more finegrained features? Like what will be the behaviour of:
> 
> cpuset.isolation.rcu_nocb = 0
> cpuset.isolation.all = 1

Well clearly that doesn't make sense. I was more thinking along the
lines of cgroup.subtree_control, where instead all features are enabled
by default.

But only if there's a real usecase, otherwise there's no point in
providing such knobs.
