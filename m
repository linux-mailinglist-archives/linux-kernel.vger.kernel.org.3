Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF3759A5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiHSS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbiHSS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B4FC741E;
        Fri, 19 Aug 2022 11:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8332460B92;
        Fri, 19 Aug 2022 18:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A5CC433C1;
        Fri, 19 Aug 2022 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660933605;
        bh=QGIx0uM/G/2giC5AwzHmtZuCIltms+An/DdTszHehEc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iAIg127PzjLBBUm8S1tO5vEcoEL5CEPWJfupHgqR8Hn54dsqx/PAEGW13KNOypwef
         Xtd4p54Dwy4ReB/i2BQcth/owSH76/r3wgKaKNs6/puKrW5iWLkGYm7ho9UWG2YY0F
         eYnqpPiLLLqzMjM+8lyvVVTzz5cfYh7lDQLlQny/38qgB5Jt5qAp56EFlQlMC0DzSZ
         jMDOT58fOxZaI7t5Dc8srf3vhl4j+tqzjTeQ2RtYjodhay+I6OtJ+ikZZEg1YBV2Km
         LieEdoZjeTEvpGoUM4pUs6xaLXqlukBBbc4M4I+ePSV9eSUESHILf9zSdn0d8/iE2M
         M5brxJT+VLLig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6BDF85C0164; Fri, 19 Aug 2022 11:26:45 -0700 (PDT)
Date:   Fri, 19 Aug 2022 11:26:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
Message-ID: <20220819182645.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220809034517.3867176-5-joel@joelfernandes.org>
 <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1>
 <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org>
 <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
 <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
 <CAEXW_YTxtfbbQ_rOiSbu62GpDPBDFpfWrNBef06MAkYPybNJ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTxtfbbQ_rOiSbu62GpDPBDFpfWrNBef06MAkYPybNJ2A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:17:32PM -0400, Joel Fernandes wrote:
> On Fri, Aug 19, 2022 at 2:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> [..]
> > >> Things are much better with the following change. However, this brings
> > >> me to a question about lock-contention based or any deferring and boot time.
> > >>
> > >> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> > >> skip the jiffie waiting for the bypass timer? Otherwise things
> > >> synchronously waiting will slow down more than usual. Maybe bypassing
> > >> should not be done for any case until boot up is done. I'm curious to
> > >> see if that improves boot time.
> > >
> > > Why not simply disable laziness at boot time and enable it only after
> > > booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
> > > boot parameter uses a similar scheme.
> >
> > That sounds like the right thing to good, but unfortunately it wont help
> > this problem. The boot time issue happens after init has started. So the
> > OS is still "booting" even though the kernel has.
> >
> > Also the problem can happen after boot as well, like if RCU
> > lazy/non-lazy callbacks come back to back quickly, or so.
> >
> > But yes nonetheless, I can see the value of disabling it till the
> > in-kernel boot completets.
> 
> My mail client is acting weird. I meant to add to this, I wonder if
> there is a way other subsystems detect when userspace boots using some
> heuristic?

I don't know of one, but I bet that ChromeOS has ways.  If nothing else,
might you add a sysfs write to one of the boot-up phases?

							Thanx, Paul
