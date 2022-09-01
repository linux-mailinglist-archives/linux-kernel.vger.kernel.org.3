Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD75AA0FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiIAUhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiIAUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:37:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9196872FD5;
        Thu,  1 Sep 2022 13:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32E41B82912;
        Thu,  1 Sep 2022 20:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC5C433C1;
        Thu,  1 Sep 2022 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662064617;
        bh=JC0714I7zcgWbR4C7LOGypNdnj+zqGE0EvXs8bWhVAE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KbDv6bPQNJTQcX6y0rIoB4uJmTJmRvkIxsKcYpgFsSRd/mm08WQ8FuTnCXWsjtB31
         6eGcvBp2aoXz81nP908gRmpYqkOT3a5SLiUsAsfz3MinjtPWxJWWG2Ee04JkZOOqjZ
         7sVUimqz5JLadq0c/UFksoeli9hSKR93o9R5QPw0QSe9Ey1vUrhxuV2bu1mfmwMPwb
         zN2aCidVDWnRbpU4I2wY9YiZ3XPL0B3JUJNRqj1CWPW73dJUnpMO6sCSIz73nlynM5
         nPFg2O6XLutT4j8+Up4ZPGTaT5dYMZsOe/hzcRgI/fGYPu8jtWwSDTdYFFzjXh4cgv
         VG71khvAXpEXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D5615C0691; Thu,  1 Sep 2022 13:36:56 -0700 (PDT)
Date:   Thu, 1 Sep 2022 13:36:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20220901203656.GD6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220831152658.GA89704@lothringen>
 <20220901143907.GU6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901145819.GB105556@lothringen>
 <0e8687de-bf45-5de6-c2f1-be6084991921@joelfernandes.org>
 <20220901164928.GZ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901182804.GA108007@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901182804.GA108007@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 08:28:04PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 09:49:28AM -0700, Paul E. McKenney wrote:
> > > On 9/1/2022 10:58 AM, Frederic Weisbecker wrote:
> > > > On Thu, Sep 01, 2022 at 07:39:07AM -0700, Paul E. McKenney wrote:
> > > >> On Wed, Aug 31, 2022 at 05:26:58PM +0200, Frederic Weisbecker wrote:
> > > >>> On Tue, Aug 30, 2022 at 09:46:34AM -0700, Paul E. McKenney wrote:
> > > >>>>> Although who knows, may be some periodic file operation while idle are specific
> > > >>>>> to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > >>>>> periods associated.
> > > >>>>
> > > >>>> Sounds like a good start.
> > > >>>>
> > > >>>> And yes, we don't need to show that the whole !NOCB world needs this,
> > > >>>> just some significant portion of it.  But we do need some decent evidence.
> > > >>>> After all, it is all too easy to do a whole lot of work and find that
> > > >>>> the expected benefits fail to materialize.
> > > >>>
> > > >>> So here is some quick test. I made a patch that replaces Joel's 1st patch
> > > >>> with an implementation of call_rcu_lazy() that queues lazy callbacks
> > > >>> through the regular call_rcu() way but it counts them in a lazy_count.
> > > >>>
> > > >>> Upon idle entry it reports whether the tick is retained solely by lazy
> > > >>> callbacks or not.
> > > >>>
> > > >>> I get periodic and frequent results on my idle test box, something must be
> > > >>> opening/closing some file periodically perhaps.
> > > >>>
> > > >>> Anyway the thing can be tested with this branch:
> > > >>>
> > > >>> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > >>> 	rcu/lazy-trace
> > > >>>
> > > >>> Excerpt:
> > > >>>
> > > >>>           <idle>-0       [007] d..1.   414.226966: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> > > >>>           <idle>-0       [007] d..1.   414.228271: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> > > >>>           <idle>-0       [007] d..1.   414.232269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> > > >>>           <idle>-0       [007] d..1.   414.236269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> > > >>
> > > >> Just to make sure that I understand, at this point, there is only the
> > > >> one lazy callback (and no non-lazy callbacks) on this CPU, and that
> > > >> CPU is therefore keeping the tick on only for the benefit of that one
> > > >> lazy callback.  And for the above four traces, this is likely the same
> > > >> lazy callback.
> > > >>
> > > >> Did I get it right, or is there something else going on?
> > > > 
> > > > Exactly that!
> > 
> > Are these callbacks confined to the RCU_NEXT_READY_TAIL and RCU_NEXT_TAIL
> > segments, which are the ones that could (in theory) buffer callbacks
> > without having started a grace period?  Or is it all the callbacks
> > regardless of segment?
> 
> Ah good point!
> 
> So I just excluded when those segments have callbacks and I now only get
> two tick retains every two seconds:
> 
>           <idle>-0       [007] d..1.  1111.893649: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1111.967575: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle

But reducing ticks is not the only way energy is saved.  The other way
is a reduction in the number of grace periods.  One way to estimate this
is to take the per-second grace period rate and subtract one grace period
per two seconds.  If the system is idle, this effect might be significant.

							Thanx, Paul

>           <idle>-0       [007] d..1.  1113.895470: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1115.669446: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1115.898144: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1117.202833: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1117.900521: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1119.903327: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1120.766864: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1121.909182: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1122.441927: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1123.908911: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1125.868505: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1125.910898: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1127.682837: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1127.913719: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1129.916740: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1130.967052: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1131.919256: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1132.957163: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [000] d..1.  1133.630082: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1133.923053: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1135.927054: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1136.067679: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1137.652294: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1137.932546: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1138.200768: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1139.932573: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1141.167489: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1141.935232: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1143.440538: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
>           <idle>-0       [007] d..1.  1143.938560: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
