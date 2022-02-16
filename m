Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945D4B9220
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiBPUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:13:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBPUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:13:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8451131101
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:13:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1890BB81FFE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8A4C004E1;
        Wed, 16 Feb 2022 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645042392;
        bh=OqVzJczwrQtqanb6wDQA2guNoUrRRzDNhq79/DBeIgc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ity1oWy27aKHzyc/PV2YZg3eHIUbH+2CZ2D0NA4ZrcQqM7QU2LlBl09cLzzpD6lQN
         aNUDsLpZdp304wopAi1Mmwbq+RVh6s1i824+Pv8SOozs7ENs+z0NXhaTwL1sKtThrI
         NOh7RKV/Hg9/686w2vxoj5UOhfCWcoKMIXNsfONZLTjvFBQzTsnA2xZi8uqct/cgXw
         cTgIT6rClBEctaxWcGsal0tdMEUUjO/bgD0hgUpI9ghDL6Gt4hNLZKMIAJ0IdN9Ydo
         33e33GabnzhE0Tu4GSxVWHMA+csKdbJsK7+XksJhHIlgnmCNeDGnLpnVj9HaFNWWWl
         qidJyNFRQWcCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A8915C064D; Wed, 16 Feb 2022 12:13:12 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:13:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/5] rcu: Bunch of cleanups
Message-ID: <20220216201312.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220216154208.696069-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216154208.696069-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:42:03PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> Just a bit of housekeeping.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/dev
> 
> HEAD: be4d4c3ba8c4ceeba9dc9df4de5451c7261161f3

Queued and pushed, thank you!  I reworked 3/5 to make it clear that the
preceding (existing) block comment still applieds to that whole section
of code and did the usual wordsmithing.

Nice to get rid of those unused functions and to avoid the unnecessary
for_each_online_cpu() loops!

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (5):
>       rcu: Remove rcu_is_nocb_cpu()
>       rcu/nocb: Move rcu_nocb_is_setup to rcu_state
>       rcu: Assume rcu_init() is called before smp
>       rcu: Initialize boost kthread only for boot node prior SMP initialization
>       rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization
> 
> 
>  kernel/rcu/rcu.h         |  2 --
>  kernel/rcu/tree.c        | 25 +++++++++++++++++--------
>  kernel/rcu/tree.h        |  3 +--
>  kernel/rcu/tree_nocb.h   | 41 +++++------------------------------------
>  kernel/rcu/tree_plugin.h | 16 ----------------
>  5 files changed, 23 insertions(+), 64 deletions(-)
