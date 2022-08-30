Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705F5A6252
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiH3Lo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiH3Ln6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64E7CAA2;
        Tue, 30 Aug 2022 04:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8C3615AF;
        Tue, 30 Aug 2022 11:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35207C433D6;
        Tue, 30 Aug 2022 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859824;
        bh=YNxOuIHy730JOT7NeJlPe+7ba0P+Vld16heKzFiPux4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XArcn/Q3thp7S3RHjlIGT/Hvk7YPxQJ44sZrYKJHq/y2KY1aVbnWrm5IEa1QNbVsj
         1cGQTYowuQLF1ryZAqzJEqwetz83myBbMCTcyz652XS2W2yNhmp1scx041WB+0zXOs
         EtqAz0ylLEBgd2hxefXeQ3Lx9ZfBQJBCGr4qWOG6/RHuyNgg4Bn1l3tBv2466CmmM3
         bRPFFUlmVt2gDk82Wd7Zw0Rl34R0LcRXoRauwCOuSfLeOkmqvbG8bldhPBMM7PDVto
         8l5z9wg7oTHK15NroENuxKR/pIhmvyzNB8X82IdleRxgoheSjd90ewjg11ogM7kypi
         8uKSNxjrZvXWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C23925C0531; Tue, 30 Aug 2022 04:43:43 -0700 (PDT)
Date:   Tue, 30 Aug 2022 04:43:43 -0700
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
Message-ID: <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830105324.GA71266@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:53:24PM +0200, Frederic Weisbecker wrote:
> On Mon, Aug 29, 2022 at 01:42:02PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> > > On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> > 
> > [ . .  . ]
> > 
> > > > > > 2) NOCB implies performance issues.
> > > > >
> > > > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > > > with the extra scheduling overhead of the extra threads which is usually not a
> > > > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> > > >
> > > > I never measured it myself but executing callbacks on another CPUs, with
> > > > context switches and locking can only involve significant performance issues if callbacks
> > > > are frequent. So it's a tradeoff between power and performance.
> > > 
> > > In my testing of benchmarks on real systems with 8-16 CPUs, the
> > > performance hit is down in the noise. It is possible though that maybe
> > > one can write a non-realistic synthetic test to force the performance
> > > issues, but I've not seen it in the real world. Maybe on
> > > networking-heavy servers with lots of cores, you'll see it but their
> > > batteries if any would be pretty big :-).
> > 
> > To Frederic's point, if you have enough servers, even a 1% decrease in
> > power consumption is a very big deal.  ;-)
> 
> The world has enough servers, for that matters ;-)

True enough!  Now you need only demonstrate that call_rcu_lazy() for
!rcu_nocbs servers would actually deliver that 1%.  ;-)

							Thanx, Paul
