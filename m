Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221C52C244
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiERSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiERSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:14:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AAB16A277;
        Wed, 18 May 2022 11:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89D1EB82019;
        Wed, 18 May 2022 18:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43327C385A5;
        Wed, 18 May 2022 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652897663;
        bh=HXcgqQoC2j8uMdZbslQ5dj2wJLQUBcNJqdHvlFwHJ/A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QkXS9DmFT0x0MJgHh4vg9bjRKA0Sfa5QT1m+UQTOO2/1gK5AETm0+/zlg2jZYLfYl
         NVsFvdgKFtQIGvicTy8Sn/gdo4OV0Z9+kRoUmHecC4xLkNGiFBAEIH1CnNjpDTsK1Y
         FlQDAzrjNFI/mlVILP4bz+fSon6upBDIlLQdmwRscts8CnH8n7L1MAfickowlJqKMl
         uuv4frt8pK84aJAGfnT5yjfWYvgrzOKJUw88j6WU4tho3MRal5w0MnV02zvOJdq7lQ
         TPCjT/QBT4/bMh7tuPkavYf91FEBTGFCuwbfmifsS1dvLCrLicchZAgmPB6UQQlqPE
         R60gBY1XZWt4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D06605C042D; Wed, 18 May 2022 11:14:22 -0700 (PDT)
Date:   Wed, 18 May 2022 11:14:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add cpu-exp indicator to expedited RCU CPU stall
 warnings
Message-ID: <20220518181422.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220518114310.1478091-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518114310.1478091-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 07:43:10PM +0800, Zqiang wrote:
> This commit adds a "D" indicator to expedited RCU CPU stall warnings.
> when an expedited grace period begins, due to CPU disable interrupt
> time too long, cause the IPI(rcu_exp_handler()) unable to respond in
> time, this debugging id will be showed.
> 
> runqemu kvm slirp nographic qemuparams="-m 4096 -smp 4"  bootparams=
> "isolcpus=2,3 nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1
> rcutorture.stall_cpu_holdoff=30 rcutorture.stall_cpu=40
> rcutorture.stall_cpu_irqsoff=1 rcutorture.stall_cpu_block=0
> rcutorture.stall_no_softlockup=1" -d
> 
> rcu_torture_stall start on CPU 1.
> ............
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:
> { 1-...D } 26467 jiffies s: 13317 root: 0x1/.
> rcu: blocking rcu_node structures (internal RCU debug): l=1:0-1:0x2/.
> Task dump for CPU 1:
> task:rcu_torture_sta state:R  running task     stack:    0 pid:   76
> ppid:     2 flags:0x00004008
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Nice!!!  I have queued this for v5.20 and for further testing and
review, thank you!

As usual, I could not resist the temptation to wordsmith the commit log,
so could you please check it in case I messed something up?

							Thanx, Paul

------------------------------------------------------------------------

commit 178b9d47f3049e8122738c3166ee4975b75cba55
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed May 18 19:43:10 2022 +0800

    rcu: Add irqs-disabled indicator to expedited RCU CPU stall warnings
    
    If a CPU has interrupts disabled continuously starting before the
    beginning of a given expedited RCU grace period, that CPU will not
    execute that grace period's IPI handler.  This will in turn mean
    that the ->cpu_no_qs.b.exp field in that CPU's rcu_data structure
    will continue to contain the boolean value false.
    
    Knowing whether or not a CPU has had interrupts disabled can be helpful
    when debugging an expedited RCU CPU stall warning, so this commit
    adds a "D" indicator expedited RCU CPU stall warnings that signifies
    that the corresponding CPU has had interrupts disabled throughout.
    
    This capability was tested as follows:
    
    runqemu kvm slirp nographic qemuparams="-m 4096 -smp 4"  bootparams=
    "isolcpus=2,3 nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1
    rcutorture.stall_cpu_holdoff=30 rcutorture.stall_cpu=40
    rcutorture.stall_cpu_irqsoff=1 rcutorture.stall_cpu_block=0
    rcutorture.stall_no_softlockup=1" -d
    
    The rcu_torture_stall() function ran on CPU 1, which displays the "D"
    as expected given the rcutorture.stall_cpu_irqsoff=1 module parameter:
    
    ............
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks:
    { 1-...D } 26467 jiffies s: 13317 root: 0x1/.
    rcu: blocking rcu_node structures (internal RCU debug): l=1:0-1:0x2/.
    Task dump for CPU 1:
    task:rcu_torture_sta state:R  running task     stack:    0 pid:   76  ppid:     2 flags:0x00004008
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4c7037b507032..f092c7f18a5f3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -637,10 +637,11 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
-				pr_cont(" %d-%c%c%c", cpu,
+				pr_cont(" %d-%c%c%c%c", cpu,
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
-					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)]);
+					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
+					"D."[!!(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
