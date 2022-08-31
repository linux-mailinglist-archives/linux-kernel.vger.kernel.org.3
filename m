Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCF5A8130
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiHaP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:27:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E32D7D0B;
        Wed, 31 Aug 2022 08:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B48F1CE21A4;
        Wed, 31 Aug 2022 15:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46F1C433D6;
        Wed, 31 Aug 2022 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661959621;
        bh=GZQd7XoZdv6HICFQy/4MFm0/zBVJf4WZ/VLKVKq+/2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuNJWYLDbOUG7abPFFgptLbrjJvCWAjrsNjzCQGZysBOep+lrX/bbfskGPirtpop9
         +hW1hagcmu0eVyF5/zM1D0svhBckBMX7WVgY4g1BN+GKuiHtaxo9FJkTrLHRMmTEVH
         ZJY/R8trl1aBS4rcm3SpdyqJdeh327rrE3sbZotUUa3BQjlOD7j+U/9pgSKEpFrtO/
         RZR4pZ/qWmFNBRxK6ReQ7hr7dJPMcTnUWugk1ufcy9f2qd9aodB8u79IiVreItyDZJ
         YAFke+pMPy4CzCbwWcQoj1Ga/nS6le2ZJdb5+ta5zoW4vV87pnZY9fLi6DIdlGKOYs
         6ZqXNIiE7cg4A==
Date:   Wed, 31 Aug 2022 17:26:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220831152658.GA89704@lothringen>
References: <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:46:34AM -0700, Paul E. McKenney wrote:
> > Although who knows, may be some periodic file operation while idle are specific
> > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > periods associated.
> 
> Sounds like a good start.
> 
> And yes, we don't need to show that the whole !NOCB world needs this,
> just some significant portion of it.  But we do need some decent evidence.
> After all, it is all too easy to do a whole lot of work and find that
> the expected benefits fail to materialize.

So here is some quick test. I made a patch that replaces Joel's 1st patch
with an implementation of call_rcu_lazy() that queues lazy callbacks
through the regular call_rcu() way but it counts them in a lazy_count.

Upon idle entry it reports whether the tick is retained solely by lazy
callbacks or not.

I get periodic and frequent results on my idle test box, something must be
opening/closing some file periodically perhaps.

Anyway the thing can be tested with this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/lazy-trace

Excerpt:

          <idle>-0       [007] d..1.   414.226966: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.228271: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.232269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.236269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.468048: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.468268: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.472268: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   414.476269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.500577: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.504253: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.508250: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.512249: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.566881: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.568252: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.572249: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   419.576255: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.666873: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.668233: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.672230: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.676232: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.737283: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.740233: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.744230: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   424.748231: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.767922: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.768209: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.772212: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.776212: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.972931: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.976214: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.980211: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [007] d..1.   429.984212: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.402139: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.404211: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.404290: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.408235: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.408304: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
          <idle>-0       [003] d..1.   430.412215: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle

Thanks.
