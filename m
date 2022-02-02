Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA44A69E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbiBBCT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:19:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51226 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiBBCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:19:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63DFEB82FE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1182C340E9;
        Wed,  2 Feb 2022 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643768394;
        bh=F0LcKh1ac0TKi7p99iEDqymE4wflW6f24zs7rFcvM3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGLU0tRWk5bPGUadK3YKiVCQWioXMlqcRobneLMDZCkrltVjEMysnFoGRquVZCojV
         kF7O+V/GLUjB7naAVg1Hj4a/oStrOE+Su+RNYpU5SRz1YnpAc5+vZ4OQyA/AK8hcjm
         C7qhWErwzko2ErRgVYlHua6PgqCgk1KAH2cBb+H2Z7ivsWymvf+DGL/AGft/1ylQmn
         a5sRXeb2F+cZpMqx3PMRv0HUySYC/BYXZ93dJoF3XhwFqf6A8sUas9kl86eW4e6BFS
         lrZKJOQ9AIWYRLpG/bKaGo9DNgPf6ygqB7NVYi4KZdmoBWpeT61yw8qASEBVa3JHuD
         Icz4fbryy/YgA==
Date:   Wed, 2 Feb 2022 03:19:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tick: Detect and fix jiffies update stall
Message-ID: <20220202021951.GA415483@lothringen>
References: <20220202000107.416695-1-frederic@kernel.org>
 <20220202014934.GI4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202014934.GI4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:49:34PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 02, 2022 at 01:01:07AM +0100, Frederic Weisbecker wrote:
> > On some rare cases, the timekeeper CPU may be delaying its jiffies
> > update duty for a while. Known causes include:
> > 
> > * The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
> >   or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
> >   updates while waiting for the target CPU to complete its
> >   stop_machine() callback.
> > 
> > * The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
> >   on the host.
> > 
> > Detect and fix these situations with emergency timekeeping catchups.
> > 
> > Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Nice, thank you!
> 
> So I should revert your earlier patch, apply this one, and then test
> the result?

No need to revert the nohz_full fix, this new one deals with non-dynticks
issues. This way we cover every timekeeper stall situations:

_ dynticks-idle is handled on IRQ entry

_ full dynticks is handled on IRQ entry in case of CPU 0 (traditional nohz_full
  timekeeper) timekeeping stall. Let's hope we won't need to handle syscalls and
  faults as well but we'll see...
  
_ periodic ticks are now handled on the tick.

So you just need to apply this patch on your dev branch for testing.

Thanks!
