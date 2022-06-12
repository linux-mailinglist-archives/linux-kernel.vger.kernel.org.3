Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103C547B73
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiFLSWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFLSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:22:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEE4550D;
        Sun, 12 Jun 2022 11:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A057B80D03;
        Sun, 12 Jun 2022 18:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C0C34115;
        Sun, 12 Jun 2022 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655058130;
        bh=/VmeNYdZ+2E/C8yC4Y4wGmIDxkM7EHBtXhhyeRTeDVM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TPMwT/npLzMaNSJJyqiSpa+MNyyL8c0IixelOABMbflNe7VuCsgrBpJXbFhah7zhV
         Whz7tULi2XeLVHJxAlsrIRS83V4Tvvpy/k2i9HUaPJ75nipd4ARIn4oQSYRnBXoNFy
         O4zEKsw4nxsbSLfMy3+AGn24ykwLVe+RrDRTQr7cV4LFJULdBqbqXFs5VFuAJBhyv1
         NZt1CxEXQjCIH4ZEvNLzChDAtOG8yvXQ5mcYvLlZMfTUm9sK3QkrfW2zahtOO8+QaQ
         LobUmvhuOn2Lsb/WZ0CJJTmrVIvAwTgq87pIM07F28X6pfTd8OzRFoLJ47wlmjfIRn
         JgwuWXUO1oEGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A4F9B5C0266; Sun, 12 Jun 2022 11:22:09 -0700 (PDT)
Date:   Sun, 12 Jun 2022 11:22:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     joel@joelfernandes.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refscale: Convert test_lock spinlock to raw_spinlock
Message-ID: <20220612182209.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220612020225.3098239-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612020225.3098239-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 10:02:25AM +0800, Zqiang wrote:
> In PREEMPT_RT kernel, the spinlock are replaced by sleepable rt_mutex.
> in a critical section where preemption is disabled this will trigger
> calltrace like the following:
> 
> BUG: scheduling while atomic: ref_scale_reade/76/0x00000002
> Preemption disabled at:
> ref_lock_section+0x16/0x80
> Call Trace:
> <TASK>
> dump_stack_lvl+0x5b/0x82
> dump_stack+0x10/0x12
> __schedule_bug.cold+0x9c/0xad
> __schedule+0x839/0xc00
> schedule_rtlock+0x22/0x40
> rtlock_slowlock_locked+0x460/0x1350
> rt_spin_lock+0x61/0xe0
> ref_lock_section+0x29/0x80
> rcu_scale_one_reader+0x52/0x60
> ref_scale_reader+0x28d/0x490
> kthread+0x128/0x150
> ret_from_fork+0x22/0x30
> </TASK>
> 
> Convert spinlock to raw_spinlock to fix it.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued for review and testing, thank you!

And as usual, wordsmithed, so could you please check for anything
that I might have messed up?

							Thanx, Paul

------------------------------------------------------------------------

commit 0c284371063996f09c0b5e3d0f4c7dff8e966d86
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Sun Jun 12 10:02:25 2022 +0800

    refscale: Convert test_lock spinlock to raw_spinlock
    
    In kernels built with CONFIG_PREEMPT_RT=y, spinlocks are replaced by
    rt_mutex, which can sleep.  This means that acquiring a non-raw spinlock
    in a critical section where preemption is disabled can trigger the
    following BUG:
    
    BUG: scheduling while atomic: ref_scale_reade/76/0x00000002
    Preemption disabled at:
    ref_lock_section+0x16/0x80
    Call Trace:
    <TASK>
    dump_stack_lvl+0x5b/0x82
    dump_stack+0x10/0x12
    __schedule_bug.cold+0x9c/0xad
    __schedule+0x839/0xc00
    schedule_rtlock+0x22/0x40
    rtlock_slowlock_locked+0x460/0x1350
    rt_spin_lock+0x61/0xe0
    ref_lock_section+0x29/0x80
    rcu_scale_one_reader+0x52/0x60
    ref_scale_reader+0x28d/0x490
    kthread+0x128/0x150
    ret_from_fork+0x22/0x30
    </TASK>
    
    This commit therefore converts spinlock to raw_spinlock.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 909644abee67f..435c884c02b5c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -385,7 +385,7 @@ static struct ref_scale_ops rwsem_ops = {
 };
 
 // Definitions for global spinlock
-static DEFINE_SPINLOCK(test_lock);
+static DEFINE_RAW_SPINLOCK(test_lock);
 
 static void ref_lock_section(const int nloops)
 {
@@ -393,8 +393,8 @@ static void ref_lock_section(const int nloops)
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock(&test_lock);
-		spin_unlock(&test_lock);
+		raw_spin_lock(&test_lock);
+		raw_spin_unlock(&test_lock);
 	}
 	preempt_enable();
 }
@@ -405,9 +405,9 @@ static void ref_lock_delay_section(const int nloops, const int udl, const int nd
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock(&test_lock);
+		raw_spin_lock(&test_lock);
 		un_delay(udl, ndl);
-		spin_unlock(&test_lock);
+		raw_spin_unlock(&test_lock);
 	}
 	preempt_enable();
 }
@@ -427,8 +427,8 @@ static void ref_lock_irq_section(const int nloops)
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock_irqsave(&test_lock, flags);
-		spin_unlock_irqrestore(&test_lock, flags);
+		raw_spin_lock_irqsave(&test_lock, flags);
+		raw_spin_unlock_irqrestore(&test_lock, flags);
 	}
 	preempt_enable();
 }
@@ -440,9 +440,9 @@ static void ref_lock_irq_delay_section(const int nloops, const int udl, const in
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock_irqsave(&test_lock, flags);
+		raw_spin_lock_irqsave(&test_lock, flags);
 		un_delay(udl, ndl);
-		spin_unlock_irqrestore(&test_lock, flags);
+		raw_spin_unlock_irqrestore(&test_lock, flags);
 	}
 	preempt_enable();
 }
