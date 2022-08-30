Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6A5A68A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiH3Qqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH3Qqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F18B2CF2;
        Tue, 30 Aug 2022 09:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 753B6B81C35;
        Tue, 30 Aug 2022 16:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B51AC433C1;
        Tue, 30 Aug 2022 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661877995;
        bh=AR8ycBXfaOCATMPDffJV6k+LpBnMDGH/P5BC77bn7rk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DhJNH6a6reToiPh/T+FS/mZQUF+qaOZAk2XtdC3omOuoy2VSkRU8UVHSTlAb9FJlm
         1GfW87TueIgO4VnqYO1YGxmIOXC/qOvT1e1FzF5NmNATZtNfpe5yz7lnzYJlqs1xDu
         HP/HppLMk5YnUz8Jy2t04yRe3Gx5bA5PICZQ4Bdrv3s76tCekJFSUUT4tnBQnli+kX
         lWuiQKwdQQSJI6sxqVSbiiqdtqc56KaTGj8Y85qe6nSaGzTlkvpw3GkPAeJETppL7L
         aUltoS4WcFu8N6LVAcMSMB8o8wKGmPPlv/PEA5Zy8D5R9aUd4j2EpBOB5nrOTVV7/G
         sJWMhMvTyHslg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7B6C5C0981; Tue, 30 Aug 2022 09:46:34 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:46:34 -0700
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
Message-ID: <20220830164634.GC6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830162244.GA73392@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:22:44PM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 30, 2022 at 06:03:16PM +0200, Frederic Weisbecker wrote:
> > On Tue, Aug 30, 2022 at 04:43:43AM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 30, 2022 at 12:53:24PM +0200, Frederic Weisbecker wrote:
> > > > On Mon, Aug 29, 2022 at 01:42:02PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> > > > > > On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > > > > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > > > > > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > > > > 
> > > > > [ . .  . ]
> > > > > 
> > > > > > > > > 2) NOCB implies performance issues.
> > > > > > > >
> > > > > > > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > > > > > > with the extra scheduling overhead of the extra threads which is usually not a
> > > > > > > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> > > > > > >
> > > > > > > I never measured it myself but executing callbacks on another CPUs, with
> > > > > > > context switches and locking can only involve significant performance issues if callbacks
> > > > > > > are frequent. So it's a tradeoff between power and performance.
> > > > > > 
> > > > > > In my testing of benchmarks on real systems with 8-16 CPUs, the
> > > > > > performance hit is down in the noise. It is possible though that maybe
> > > > > > one can write a non-realistic synthetic test to force the performance
> > > > > > issues, but I've not seen it in the real world. Maybe on
> > > > > > networking-heavy servers with lots of cores, you'll see it but their
> > > > > > batteries if any would be pretty big :-).
> > > > > 
> > > > > To Frederic's point, if you have enough servers, even a 1% decrease in
> > > > > power consumption is a very big deal.  ;-)
> > > > 
> > > > The world has enough servers, for that matters ;-)
> > > 
> > > True enough!  Now you need only demonstrate that call_rcu_lazy() for
> > > !rcu_nocbs servers would actually deliver that 1%.  ;-)
> > 
> > Well, !rcu_nocbs is not only used by server but also by pretty much
> > everything else, except android IIUC.

And soon, ChromeOS.

> >                                       I can't really measure the whole
> > world but I don't see how the idleness of a server/router/desktop/embedded/rt/hpc
> > device differs from the idleness of an android device.
> > 
> > But ok I'll try to measure that.
> 
> Although who knows, may be some periodic file operation while idle are specific
> to Android. I'll try to trace lazy callbacks while idle and the number of grace
> periods associated.

Sounds like a good start.

And yes, we don't need to show that the whole !NOCB world needs this,
just some significant portion of it.  But we do need some decent evidence.
After all, it is all too easy to do a whole lot of work and find that
the expected benefits fail to materialize.

							Thanx, Paul
