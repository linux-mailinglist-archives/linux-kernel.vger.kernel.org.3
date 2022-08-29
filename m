Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA35A55B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiH2UmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2UmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:42:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743181B00;
        Mon, 29 Aug 2022 13:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE603B8119B;
        Mon, 29 Aug 2022 20:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9FAC433D6;
        Mon, 29 Aug 2022 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661805722;
        bh=OBcGiRNFwXCZG7Ywe6tMUzBA7pJx2biK6lrBMOUvG3U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iZ4I7yXctAwuSWtOO41cAIY+O8fMhJOOj8NVEwkEHiq/aC5wMNTQjDKY4kxTJVl79
         9BOXuojHyCB2Mdrr0HD/OuR19UHlOXzvT+GxDI39omqEgMnLRA2Kwnf20WMnn4Q692
         qHKNhEOgvQ/qynwf0BztOA2mwuA76YW/5/RuDoMVn/4c8wUNVkTXZtuedX7UOXgUjD
         0VRmBFucxJDRceWzUrmBDvkN72BjlOV0DHCChDe8bKMY5O5FeD+CP4Gjh3yEmEVzvm
         5Fr9/A3Zp8bFRmgd2zyxY5oyvgvqK1fR+v1PjPsQlAAsIEDZ12qs1LM8v9xvJkVTct
         BDuQiuY6axNZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 289465C055D; Mon, 29 Aug 2022 13:42:02 -0700 (PDT)
Date:   Mon, 29 Aug 2022 13:42:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
> On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
> > > On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:

[ . .  . ]

> > > > 2) NOCB implies performance issues.
> > >
> > > Which kinds of? There is slightly worse boot times, but I'm guessing that's do
> > > with the extra scheduling overhead of the extra threads which is usually not a
> > > problem except that RCU is used in the critical path of boot up (on ChromeOS).
> >
> > I never measured it myself but executing callbacks on another CPUs, with
> > context switches and locking can only involve significant performance issues if callbacks
> > are frequent. So it's a tradeoff between power and performance.
> 
> In my testing of benchmarks on real systems with 8-16 CPUs, the
> performance hit is down in the noise. It is possible though that maybe
> one can write a non-realistic synthetic test to force the performance
> issues, but I've not seen it in the real world. Maybe on
> networking-heavy servers with lots of cores, you'll see it but their
> batteries if any would be pretty big :-).

To Frederic's point, if you have enough servers, even a 1% decrease in
power consumption is a very big deal.  ;-)

							Thanx, Paul
