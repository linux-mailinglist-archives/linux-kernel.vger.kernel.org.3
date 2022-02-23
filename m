Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBE4C0670
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiBWAxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiBWAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:52:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8C3AA73;
        Tue, 22 Feb 2022 16:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CA461341;
        Wed, 23 Feb 2022 00:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB7C340E8;
        Wed, 23 Feb 2022 00:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645577544;
        bh=wtszXTGLCE0YIbPMI7+Az+4DkUro2sZGjhHJa80rl0Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q1G+S73/vN/oCIsi+w40OW6gDaZM8xjyBH+6XbFLG2HSCA9DbPCuHBeL1l/RwN4SV
         vqRo2ENyvQUl+uedPgsQTpvK9zuLWKLax21eJOiuidw6eau0BO7+oxNTet1wnPIJxS
         jMo9PUqMmUJpiP122fMR/4waS/pkhAuXnFEJcEiiz7sdhPx26FxWXB+iUhe2Rmjb2A
         kyOrdN4NFBB8mkqA6GHKVPBcYb119lmD/CJc+VaSRhR3hZNAtnJeiJkQ5bHCiCEjee
         8XFV7+28+H3jHkeuZJd2MSi5XAe2w5tvqX2H98qYIpC6SXvlts26+jX4q7LscJXmH0
         fgtPPqja5nYqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF80B5C0521; Tue, 22 Feb 2022 16:52:23 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:52:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rcu-tasks: Fix race in schedule and flush work
Message-ID: <20220223005223.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220217152520.18972-1-treasure4paddy@gmail.com>
 <20220217174330.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <20220220183517.GA3164@pswork>
 <20220220200425.GB4285@paulmck-ThinkPad-P17-Gen-1>
 <20220222220629.GA2334@pswork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222220629.GA2334@pswork>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:06:29PM +0100, Padmanabha Srinivasaiah wrote:
> On Sun, Feb 20, 2022 at 12:04:25PM -0800, Paul E. McKenney wrote:
> > On Sun, Feb 20, 2022 at 07:35:17PM +0100, Padmanabha Srinivasaiah wrote:
> > > On Thu, Feb 17, 2022 at 09:43:30AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Feb 17, 2022 at 04:25:19PM +0100, Padmanabha Srinivasaiah wrote:
> > > > > While booting secondary CPUs, cpus_read_[lock/unlock] not keeping online
> > > > > cpumask stable. The transient online mask results in below calltrace.
> > > > > 
> > > > > [    0.324121] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
> > > > > [    0.346652] Detected PIPT I-cache on CPU2
> > > > > [    0.347212] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
> > > > > [    0.377255] Detected PIPT I-cache on CPU3
> > > > > [    0.377823] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
> > > > > [    0.379040] ------------[ cut here ]------------
> > > > > [    0.383662] WARNING: CPU: 0 PID: 10 at kernel/workqueue.c:3084 __flush_work+0x12c/0x138
> > > > > [    0.384850] Modules linked in:
> > > > > [    0.385403] CPU: 0 PID: 10 Comm: rcu_tasks_rude_ Not tainted 5.17.0-rc3-v8+ #13
> > > > > [    0.386473] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> > > > > [    0.387289] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > [    0.388308] pc : __flush_work+0x12c/0x138
> > > > > [    0.388970] lr : __flush_work+0x80/0x138
> > > > > [    0.389620] sp : ffffffc00aaf3c60
> > > > > [    0.390139] x29: ffffffc00aaf3d20 x28: ffffffc009c16af0 x27: ffffff80f761df48
> > > > > [    0.391316] x26: 0000000000000004 x25: 0000000000000003 x24: 0000000000000100
> > > > > [    0.392493] x23: ffffffffffffffff x22: ffffffc009c16b10 x21: ffffffc009c16b28
> > > > > [    0.393668] x20: ffffffc009e53861 x19: ffffff80f77fbf40 x18: 00000000d744fcc9
> > > > > [    0.394842] x17: 000000000000000b x16: 00000000000001c2 x15: ffffffc009e57550
> > > > > [    0.396016] x14: 0000000000000000 x13: ffffffffffffffff x12: 0000000100000000
> > > > > [    0.397190] x11: 0000000000000462 x10: ffffff8040258008 x9 : 0000000100000000
> > > > > [    0.398364] x8 : 0000000000000000 x7 : ffffffc0093c8bf4 x6 : 0000000000000000
> > > > > [    0.399538] x5 : 0000000000000000 x4 : ffffffc00a976e40 x3 : ffffffc00810444c
> > > > > [    0.400711] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
> > > > > [    0.401886] Call trace:
> > > > > [    0.402309]  __flush_work+0x12c/0x138
> > > > > [    0.402941]  schedule_on_each_cpu+0x228/0x278
> > > > > [    0.403693]  rcu_tasks_rude_wait_gp+0x130/0x144
> > > > > [    0.404502]  rcu_tasks_kthread+0x220/0x254
> > > > > [    0.405264]  kthread+0x174/0x1ac
> > > > > [    0.405837]  ret_from_fork+0x10/0x20
> > > > > [    0.406456] irq event stamp: 102
> > > > > [    0.406966] hardirqs last  enabled at (101): [<ffffffc0093c8468>] _raw_spin_unlock_irq+0x78/0xb4
> > > > > [    0.408304] hardirqs last disabled at (102): [<ffffffc0093b8270>] el1_dbg+0x24/0x5c
> > > > > [    0.409410] softirqs last  enabled at (54): [<ffffffc0081b80c8>] local_bh_enable+0xc/0x2c
> > > > > [    0.410645] softirqs last disabled at (50): [<ffffffc0081b809c>] local_bh_disable+0xc/0x2c
> > > > > [    0.411890] ---[ end trace 0000000000000000 ]---
> > > > > [    0.413000] smp: Brought up 1 node, 4 CPUs
> > > > > [    0.413762] SMP: Total of 4 processors activated.
> > > > > [    0.414566] CPU features: detected: 32-bit EL0 Support
> > > > > [    0.415414] CPU features: detected: 32-bit EL1 Support
> > > > > [    0.416278] CPU features: detected: CRC32 instructions
> > > > > [    0.447021] Callback from call_rcu_tasks_rude() invoked.
> > > > > [    0.506693] Callback from call_rcu_tasks() invoked.
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/20220210184319.25009-1-treasure4paddy@gmail.com/T/
> > > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > > > 
> > > > Thank you, Padmanabha!  I have queued this with additional explanation
> > > > in the commit log as shown below.
> > > 
> > > Thanks paul.
> > > > 
> > > > If you have not already tested this by repeatedly rebooting, for
> > > > example continuously in an overnight test, could you please do so?
> > > > (I am assuming that your system can do an automated reboot loop, so no,
> > > > I am not asking you to stay up all night!)
> > > > 
> > > Yes, tested and issue doesn't appear.
> > 
> > Very good, thank you!
> > 
> > May I add your Tested-by?
> > 
> > 							Thanx, Paul
> >
> Sure paul. Once again thanks for the suggestion.
> 
> Tested-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>

Thank you!  I will apply this on the next rebase.

							Thanx, Paul
