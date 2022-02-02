Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626774A76C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbiBBRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbiBBRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:24:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70901C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:24:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B8F617EF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 17:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51CEC004E1;
        Wed,  2 Feb 2022 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643822681;
        bh=m3b6JLektjB/7M4PIprzOo7AlaYiSiEHs+yMP8snFiU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eo4mBGWIad0gxzp9g1bHzL2AaaRhi0FYjUJHaBpqPUeMk/EXC7eIJPYeWgiAWNdeQ
         RGnfjNClQotQRoCuQKnsSkIY5l0MhOcGOoRIuPOVd9NvxqQHP+GW6ZwwWv8sn/5QB/
         IWZe4U68nbH5irFHVe31vgPXYEsZzGhSlBYcb1dfhNKd6t6F1SFaWaauPGoDR/gjb4
         DDx8mAjYpFA08n2Xt8qce4hKcX1+LDCFsAjALidEV0IMe8rwiRh5EAAdUNzCyCEjhS
         uaW0Y7sY/h9+eJ2f9JbIThZROKBS1qfB+OnBttbqfx/SxJKxiZv4rueW7+J+Ijd23Z
         F5wU8gz3uZSCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BEA35C0418; Wed,  2 Feb 2022 09:24:41 -0800 (PST)
Date:   Wed, 2 Feb 2022 09:24:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tick: Detect and fix jiffies update stall
Message-ID: <20220202172441.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220202000107.416695-1-frederic@kernel.org>
 <20220202014934.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <20220202021951.GA415483@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202021951.GA415483@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:19:51AM +0100, Frederic Weisbecker wrote:
> On Tue, Feb 01, 2022 at 05:49:34PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 02, 2022 at 01:01:07AM +0100, Frederic Weisbecker wrote:
> > > On some rare cases, the timekeeper CPU may be delaying its jiffies
> > > update duty for a while. Known causes include:
> > > 
> > > * The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
> > >   or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
> > >   updates while waiting for the target CPU to complete its
> > >   stop_machine() callback.
> > > 
> > > * The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
> > >   on the host.
> > > 
> > > Detect and fix these situations with emergency timekeeping catchups.
> > > 
> > > Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Nice, thank you!
> > 
> > So I should revert your earlier patch, apply this one, and then test
> > the result?
> 
> No need to revert the nohz_full fix, this new one deals with non-dynticks
> issues. This way we cover every timekeeper stall situations:
> 
> _ dynticks-idle is handled on IRQ entry
> 
> _ full dynticks is handled on IRQ entry in case of CPU 0 (traditional nohz_full
>   timekeeper) timekeeping stall. Let's hope we won't need to handle syscalls and
>   faults as well but we'll see...
>   
> _ periodic ticks are now handled on the tick.
> 
> So you just need to apply this patch on your dev branch for testing.

I have pulled it in, thank you!  I will beat on it.

I am guessing that this goes up some other path to mainline, so I have
marked it "EXP".

							Thanx, Paul
