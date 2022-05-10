Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2522522219
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347838AbiEJRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiEJRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E22BF30A;
        Tue, 10 May 2022 10:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015986188C;
        Tue, 10 May 2022 17:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5892DC385C2;
        Tue, 10 May 2022 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652202897;
        bh=5y/vAVwde0HqnA5nQ1KPT5/RVLZLMkTULnrLQbWw3H8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LqcoBJ7jxEphDO07qYlcF5eiAkCtgKjTr8+CUbt9u7l15bQdiDnJ2CaUyafm/JI3r
         rGErienokqkFDULf7MjxZiTvEHDf1qNADw+/gxtlwkfyU/Q0EzEcV6UwbpBgCLK4Hf
         Kt/pC8LQa/Y+yYMbgl2O+d/lRZCrFEOxonwq/+qb/boHViC371H+v/swLHeJ+fPss9
         6hGgKuqAAzz8NS0SQW+8wuDTtAc4jnfw7aRDjEKkFt6CK8ULXmyzpPymeqQrCesX22
         rrFnwSGp8tzix7WU5Ggord8X81BsXHkuIG+N0LguyssLMAvhE3oHGGFZl1awD5RUua
         x9hgKSvwq+YnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E76D55C0602; Tue, 10 May 2022 10:14:56 -0700 (PDT)
Date:   Tue, 10 May 2022 10:14:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220510171456.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505101641.28472-1-urezki@gmail.com>
 <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <Ynpxm46hEg0+G82g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynpxm46hEg0+G82g@linutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 04:07:23PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-05-05 12:09:15 [-0700], Paul E. McKenney wrote:
> > All good points!
> > 
> > Some questions and comments below.
> > 
> > Adding Sebastian on CC for his perspective.
> 
> Thank you.
> I may missing things, I tried to digest the thread…
> 
> In my understanding: The boosting option is used to allow a SCHED_OTHER
> task within a RCU section to allow to leave the RCU section while tasks
> with higher priority occupy the CPU.
> As far as the RCU callbacks are concerned, I'm not aware that it would
> be beneficial to run them with an elevated priority. On SMP systems,
> there is the suggestion to have a housekeeping CPU and to offload the
> RCU callbacks to this CPU and no to bother the CPU with the RT workload.

Agreed, even within RT, there are multiple ways to get this job done.

							Thanx, Paul
