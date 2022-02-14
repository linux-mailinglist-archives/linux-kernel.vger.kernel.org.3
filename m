Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBE64B562B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356353AbiBNQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:29:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356348AbiBNQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:29:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215035FF0B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEBF614D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D07CC340E9;
        Mon, 14 Feb 2022 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856161;
        bh=R1d02V76htJZBVQORex0kXIw/s8UK5VVtOKdpThhKyA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VwJvm0KYfGpykWMe6Y2SpHAd7Oburhir3zl9WAp1TgHbEnDrjZY4dLyZ+PqXO/PhA
         rCKMaqdUqVlFw0iwALrogvrt7mjZWP6+OmCAfhtdEo5Tj3cM6DQWH+HL75vse8cVZG
         HrqWs8j0jGL3s4zFm+ILrHTn9T6nru8ulryKM+Voggj2c6gK3Xoil4kFtyU14tfuLa
         zo2S5PPdJfJVZkTKd79BlaMswMKX753lfE1iAH2coxmVqLuIElO8C0JVdiyrYelx1D
         oFp5XfxDh5TTzy7R1f4Kb09R9BXXyuFyFCVumiT/XDkocU+r3PloLPt+Qmfz+G4Jjb
         BAc2WF44MZodw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D62795C0388; Mon, 14 Feb 2022 08:29:20 -0800 (PST)
Date:   Mon, 14 Feb 2022 08:29:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu
Subject: Re: [PATCH 0/3] tick: Fix softirq related warnings
Message-ID: <20220214162920.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208161635.544701-1-frederic@kernel.org>
 <bd2a0eb7-2b0b-bb45-3c58-bfce3049bb94@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2a0eb7-2b0b-bb45-3c58-bfce3049bb94@molgen.mpg.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:46:59AM +0100, Paul Menzel wrote:
> Dear Frederic,
> 
> 
> Am 08.02.22 um 17:16 schrieb Frederic Weisbecker:
> > Some cleanups and debug rework.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	timers/core
> > 
> > HEAD: 18b00369d58da4c73946d5f8ebed8e8c7ade89e2
> > 
> > Thanks,
> > 	Frederic
> > ---
> > 
> > Frederic Weisbecker (3):
> >        tick/rcu: Remove obsolete rcu_needs_cpu() parameters
> >        tick/rcu: Stop allowing RCU_SOFTIRQ in idle
> >        lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe
> > 
> > 
> >   include/linux/interrupt.h | 11 ++++++++-
> >   include/linux/rcutiny.h   |  3 +--
> >   include/linux/rcutree.h   |  2 +-
> >   kernel/rcu/tree.c         |  3 +--
> >   kernel/time/tick-sched.c  | 60 ++++++++++++++++++++++++++++++++++-------------
> >   5 files changed, 57 insertions(+), 22 deletions(-)
> 
> I tested this series on the IBM S822LC with Ubuntu 20.10 and rcu/dev (commit
> 0ba8896d2fd7 (lib/irq_poll: Declare IRQ_POLL softirq vector as
> ksoftirqd-parking safe)). Running `sudo ppc64_cpu --smt=off` the warnings
> are gone.
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

I will apply on my next rebase, thank you!

And thanks to Peter and Christophe for chasing this down!

							Thanx, Paul
