Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656CD4AE6DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiBICk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbiBIAwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:52:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D4C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 867916184D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7537C004E1;
        Wed,  9 Feb 2022 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644367951;
        bh=86D5WV13YhdEOmavdvFHUeROq/zSqXd3iNHx2jJQIv0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fFcHtG3wP7lWwBBeHEaU2Q8dnzUtCE9vXaTQI9Dq7zxKutCCe+H6gIVO6FZkJyE8R
         wn4qlaScfksnWwl2YJ3XFsMAbEI7o0U2I//Rn8h/1dT9AOHp3Wzt04cy2oLPTJTYB6
         o3OcS7LlglcV+XzwCmxFh1HCivOBYG9cInmriK1BQ7KOnP2f+/ENkAeDb1ovpaWyga
         oUIv3aCZL4aVZl+oyjeYzQdB9x0nPpekxu7iSXAmcV3tGRct7cGwksL1veBaCcjNPw
         a2+is164UpkMNMvz0Vg6LjqtA9qhjIFxTTYWHFLdnzuVAiv1YSd57GQr18k/j+TMex
         vvFPBAxFuhhvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9C20E5C0825; Tue,  8 Feb 2022 16:52:31 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:52:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 0/3] tick: Fix softirq related warnings
Message-ID: <20220209005231.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220208161635.544701-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208161635.544701-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:16:32PM +0100, Frederic Weisbecker wrote:
> Some cleanups and debug rework.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/core
> 
> HEAD: 18b00369d58da4c73946d5f8ebed8e8c7ade89e2
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (3):
>       tick/rcu: Remove obsolete rcu_needs_cpu() parameters
>       tick/rcu: Stop allowing RCU_SOFTIRQ in idle
>       lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe

I have queued these for local testing, but I am guessing that you would
like them to go up some other path.

							Thanx, Paul

>  include/linux/interrupt.h | 11 ++++++++-
>  include/linux/rcutiny.h   |  3 +--
>  include/linux/rcutree.h   |  2 +-
>  kernel/rcu/tree.c         |  3 +--
>  kernel/time/tick-sched.c  | 60 ++++++++++++++++++++++++++++++++++-------------
>  5 files changed, 57 insertions(+), 22 deletions(-)
