Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F88483364
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiACOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:36:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33898 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiACOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:34:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F35B80EF2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1975C36AEB;
        Mon,  3 Jan 2022 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641220482;
        bh=kxzLuP0W5HNS5y4JPh4ATpkpErb4oP7rLxAFa+gmsy4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u4gJ8Yd5UfOl2AYDjVwu/nSvn9dhd9SwIu3bBzMCl8ONS/1thlwGuQXXq4zHnyl4L
         R8YBmkTzsFUEDrya9lnfw0JkzUYpxZmgO/qGTwVPdsf75nG/SfRUQy50Hw1GPfc024
         rIa9suGthVJddIsafBxlPsJ9wF5TKD2CdNU33lpsHKijZFzlAy/rYzJiPlo8IFzh8V
         iozEu/C3loTEzIAqYhELi0369oTHpa2hRwetkUHyuLdnHbxO80bLkzSr3BhPSmx/td
         5yepxpk9o+VaFVbh8ygefkWwhz70LKYGuDadpIpPllkcslB+Gqp26FhylDWrgvs9C2
         6c0izP3O4/XDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C7105C19BD; Mon,  3 Jan 2022 06:34:42 -0800 (PST)
Date:   Mon, 3 Jan 2022 06:34:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: per-cpu rcuc kthread are created only when
 rcutree.use_softirq=0
Message-ID: <20220103143442.GG2408833@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211228160510.2893362-1-qiang1.zhang@intel.com>
 <20220101164426.GA2408833@paulmck-ThinkPad-P17-Gen-1>
 <YdL3Vx6pq6YCL1kx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL3Vx6pq6YCL1kx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 02:17:11PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-01-01 08:44:26 [-0800], Paul E. McKenney wrote:
> > On Wed, Dec 29, 2021 at 12:05:10AM +0800, Zqiang wrote:
> > > In non-RT kernel, if the RCU_BOOST is enabled, the per-cpu rcuc
> > > kthread will be created, however under the rcutree.use_softirq=1,
> > > the RCU core processing only in softirq context, the rcuc kthread
> > > doesn't do anything, so remove RCU_BOOST interference.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > Looks sane to me, but adding Sebastian on CC for his thoughts.
> 
> Yes, it makes sense. invoke_rcu_core_kthread() is only invoked for
> !use_softirq so it makes to create the threads based on this condition.
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you both!  As usual, I could not resist a bit of wordsmithing,
please see below.

							Thanx, Paul

------------------------------------------------------------------------

commit 6e68b781388cfaca95a07493a060c4a6e4ee5d0f
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Dec 29 00:05:10 2021 +0800

    rcu: Create per-cpu rcuc kthreads only when rcutree.use_softirq=0
    
    The per-CPU "rcuc" kthreads are used only by kernels booted with
    rcutree.use_softirq=0, but they are nevertheless unconditionally created
    by kernels built with CONFIG_RCU_BOOST=y.  This results in "rcuc"
    kthreads being created that are never actually used.  This commit
    therefore refrains from creating these kthreads unless the kernel
    is actually booted with rcutree.use_softirq=0.
    
    Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aeea5487632f7..5c0ffee7a43a0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2903,7 +2903,7 @@ static int __init rcu_spawn_core_kthreads(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
-	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
+	if (use_softirq)
 		return 0;
 	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
 		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
