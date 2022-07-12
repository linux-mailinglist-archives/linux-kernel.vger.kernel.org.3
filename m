Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B257296A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiGLWlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiGLWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53510C9102;
        Tue, 12 Jul 2022 15:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E267261703;
        Tue, 12 Jul 2022 22:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435A0C3411C;
        Tue, 12 Jul 2022 22:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657665667;
        bh=7OTxsiidUcUG+GGmeb2s3C1z19nIXcHCMhWXxtklkRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V/PRfSbtA6gw4BSNqnTIqp+kht6zI3yIsYRdrtYGaFFiXxxi0FuqGuilZEUF5TbMv
         UpsaN378KDaUuk8i1vGbe9EbbNwSSHbfZQxzg3ZSSVPhxQI5esNeB1yuuW4BzhMB1L
         ktwI8Kz1kAhdu/YEc9UfIIjvrc2tjTxjOJie+8rwm22PQRiqsBqKNoiQxOqwoeM+WC
         jwZzPSYaOh06g2RBR2FGdLaqAKsqXuvJADyIp6LxIZwywdnRAnvYNXt2UfUMpCYN//
         /2v4YszbXzw137f22loVrP31+mczuxlREbdFRb01NxCUPD5n0XgoaX3qpScOpZIjwo
         YHYnf7XvWBRDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E23E65C08C7; Tue, 12 Jul 2022 15:41:06 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:41:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <20220712224106.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
 <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsexpcG2iaplKPIs@google.com>
 <20220708230600.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS8hrT78JG_2uQX38oaF5TEGz-M3EgJ2PWjx8g+cfmhBw@mail.gmail.com>
 <20220712205854.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <dc5b3c63-7c95-79aa-75ec-1e8d1b3315f1@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5b3c63-7c95-79aa-75ec-1e8d1b3315f1@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 05:15:23PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/12/2022 4:58 PM, Paul E. McKenney wrote:
> > On Tue, Jul 12, 2022 at 04:27:05PM -0400, Joel Fernandes wrote:
> >> Ah, with all the threads, I missed this one :(. Sorry about that.
> > 
> > I know that feeling...
> > 
> >> On Fri, Jul 8, 2022 at 7:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>
> >>>> Currently I added a test like the following which adds a new torture type, my
> >>>> thought was to stress the new code to make sure nothing crashed or hung the
> >>>> kernel. That is working well except I don't exactly understand the total-gps
> >>>> print showing 0, which the other print shows 1188 GPs. I'll go dig into that
> >>>> tomorrow.. thanks!
> >>>>
> >>>> The print shows
> >>>> TREE11 ------- 1474 GPs (12.2833/s) [rcu_lazy: g0 f0x0 total-gps=0]
> >>>> TREE11 no success message, 7 successful version messages
> >>>
> >>> Nice!!!  It is very good to see you correctly using the rcu_torture_ops
> >>> facility correctly!
> >>>
> >>> And this could be good for your own testing, and I am happy to pull it
> >>> in for that purpose (given it being fixed, having a good commit log,
> >>> and so on).  After all, TREE10 is quite similar -- not part of CFLIST,
> >>> but useful for certain types of focused testing.
> >>>
> >>> However, it would be very good to get call_rcu_lazy() testing going
> >>> more generally, and in particular in TREE01 where offloading changes
> >>> dynamically.  A good way to do this is to add a .call_lazy() component
> >>> to the rcu_torture_ops structure, and check for it in a manner similar
> >>> to that done for the .deferred_free() component.  Including adding a
> >>> gp_normal_lazy module parameter.  This would allow habitual testing
> >>> on a few scenarios and focused lazy testing on all of them via the
> >>> --bootargs parameter.
> >>
> >> Ok, if you don't mind I will make this particular enhancement to the
> >> torture test in a future patchset, since I kind of decided on doing v3
> >> with just fixes to what I have and more testing. Certainly happy to
> >> enhance these tests in a future version.
> > 
> > No need to gate v3 on those tests.
> > 
> >>> On the total-gps=0, the usual suspicion would be that the lazy callbacks
> >>> never got invoked.  It looks like you were doing about a two-minute run,
> >>> so maybe a longer run?  Though weren't they supposed to kick in at 15
> >>> seconds or so?  Or did this value of zero come about because this run
> >>> used exactly 300 grace periods?
> >>
> >> It was zero because it required the RCU_FLAVOR torture type, where as
> >> my torture type was lazy. Adding RCU_LAZY_FLAVOR to the list fixed it
> >> :)
> > 
> > Heh!  Then it didn't actually do any testing.  Done that as well!
> 
> Sorry to not be clear, I meant the switch-case list below, not the
> torture list in rcutorture.c! It was in the rcutorture.c so was being
> tested, just reporting zero gp_seq as I pointed.
> 
> /*
>  * Send along grace-period-related data for rcutorture diagnostics.
>  */
> void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>                             unsigned long *gp_seq)
> {
>         switch (test_type) {
>         case RCU_FLAVOR:
>         case RCU_LAZY_FLAVOR:
>                 *flags = READ_ONCE(rcu_state.gp_flags);
>                 *gp_seq = rcu_seq_current(&rcu_state.gp_seq);
>                 break;
>         default:
>                 break;
>         }
> }
> EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);

Ah, that would do it!  Thank you for the clarification.

							Thanx, Paul
