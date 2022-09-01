Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A335A9B04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiIAO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiIAO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468C75CE3;
        Thu,  1 Sep 2022 07:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FAEA61DF3;
        Thu,  1 Sep 2022 14:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50988C433C1;
        Thu,  1 Sep 2022 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662044302;
        bh=En7apUiUy36ywZsUgJ3gviiKGdFpGXtXpQxMMA0VXF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX9tR1swI2COSnSV5z/gdyF496mf2T4tk9tBw3Lc9WjSgDeNA1THG+NthmE8IDNmq
         SCMiJOEYCvpfZG/F2XiLNgDIJyNBfKMj0f1KXV+ohkMdYaNatuUdw/9pHSEXtl+9X6
         +8AnmTmJEd+gN4s0KGHGN/4J2nnrIEL9s5kYC18ZMEblyT87ohSnEutsxQ+43lHzSZ
         HbVdwRokcsNDUq39MKTyu52ibu0O9ezEFOw+acdTwpLUE1O9JsJhwe2RKnAFYLEypz
         bdKhhYftgTH7Nw6QiJWc1rG5O8Utz4uSCIZ2tCee3o5rdH7I+LRYf6ihWa1G9MQU+1
         UnsikXDEyMD/g==
Date:   Thu, 1 Sep 2022 16:58:19 +0200
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
Message-ID: <20220901145819.GB105556@lothringen>
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <20220831152658.GA89704@lothringen>
 <20220901143907.GU6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901143907.GU6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:39:07AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 31, 2022 at 05:26:58PM +0200, Frederic Weisbecker wrote:
> > On Tue, Aug 30, 2022 at 09:46:34AM -0700, Paul E. McKenney wrote:
> > > > Although who knows, may be some periodic file operation while idle are specific
> > > > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > > > periods associated.
> > > 
> > > Sounds like a good start.
> > > 
> > > And yes, we don't need to show that the whole !NOCB world needs this,
> > > just some significant portion of it.  But we do need some decent evidence.
> > > After all, it is all too easy to do a whole lot of work and find that
> > > the expected benefits fail to materialize.
> > 
> > So here is some quick test. I made a patch that replaces Joel's 1st patch
> > with an implementation of call_rcu_lazy() that queues lazy callbacks
> > through the regular call_rcu() way but it counts them in a lazy_count.
> > 
> > Upon idle entry it reports whether the tick is retained solely by lazy
> > callbacks or not.
> > 
> > I get periodic and frequent results on my idle test box, something must be
> > opening/closing some file periodically perhaps.
> > 
> > Anyway the thing can be tested with this branch:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/lazy-trace
> > 
> > Excerpt:
> > 
> >           <idle>-0       [007] d..1.   414.226966: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> >           <idle>-0       [007] d..1.   414.228271: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> >           <idle>-0       [007] d..1.   414.232269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> >           <idle>-0       [007] d..1.   414.236269: rcu_needs_cpu: BAD: 1 lazy callbacks retaining dynticks-idle
> 
> Just to make sure that I understand, at this point, there is only the
> one lazy callback (and no non-lazy callbacks) on this CPU, and that
> CPU is therefore keeping the tick on only for the benefit of that one
> lazy callback.  And for the above four traces, this is likely the same
> lazy callback.
> 
> Did I get it right, or is there something else going on?

Exactly that!

Thanks.
