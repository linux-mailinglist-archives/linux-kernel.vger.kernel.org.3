Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DEF5A613D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiH3K5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH3K5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FFE42C4;
        Tue, 30 Aug 2022 03:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D2860CF2;
        Tue, 30 Aug 2022 10:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB691C433C1;
        Tue, 30 Aug 2022 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661857062;
        bh=zrx2tzoy3uB2UpVoq4nUpuLps2c4xn/uqwRVCuI/+Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Phz3gGL+fi7mVlBxRw+EQEzn+o9yDbF1P23Mfwh5gTwSFGHKsbQDLTbR45b4/H+85
         MKj4SChO3GHB454ouTQmaSnVmiW5Om0IiCfcfkFkiOlpVrk87Mj5xWyMhaF3upX6qC
         9S27YhPPf9r7PP75/J2S7w8PYt4bHctm1QU67cT5OXM6aq2bmQEzhhwZMVlpdH7Ha1
         YjHwq+W1HeuRBLrzKQEBTHbTApBDEVBwzF3odUnl45tflf4Brz34XimnSVkYcHS5oM
         YVn9y08gBU8YHV3Oz09klv4Fp8sQ9R/hU+5gajUEJYEaEGiRCjjIFBO7i1/WztrmrB
         XeHZrM9TeTmvA==
Date:   Tue, 30 Aug 2022 12:57:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20220830105739.GB71266@lothringen>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSwkSi0UfBUrK=4gyMPC-R7pvQbreWOC3DcQqmLgp3aFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSwkSi0UfBUrK=4gyMPC-R7pvQbreWOC3DcQqmLgp3aFQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:48:25PM -0400, Joel Fernandes wrote:
> On Mon, Aug 29, 2022 at 4:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
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
> Ah I see Frederick's point now, so basically the claim is that using
> lazy-RCU on servers might make sense to save power because
> CONFIG_RCU_NO_CB_CPU may not be an option there (networking throughput
> and so forth).
> 
> That's a good point indeed...

You got it! And it's not just servers but pretty much everything that may
be idle sometimes. Distros (except android then) don't use rcu_nocbs= by
default. Routers enjoy night bandwith, etc...

Thanks!
