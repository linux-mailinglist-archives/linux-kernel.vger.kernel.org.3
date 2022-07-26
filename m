Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EFF58159F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiGZOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGZOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:44:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AA9E26AD9;
        Tue, 26 Jul 2022 07:44:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A83551FB;
        Tue, 26 Jul 2022 07:44:54 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.87.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32CA43F70D;
        Tue, 26 Jul 2022 07:44:53 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:44:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [-next] Lockdep warnings
Message-ID: <Yt/9z1+X3hDfXkbL@FVFF77S0Q05N>
References: <20220726104134.3b3awfphvafljdgp@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726104134.3b3awfphvafljdgp@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:41:34AM +0100, Sudeep Holla wrote:
> I was seeing the below lockdep warnings on my arm64 Juno development
> platform almost 2 weeks back with -next. I wanted to check for similar
> reports before post and forgot.

[...]

> However I don't see the above warning with the latest -next. When I tried
> yesterday's -next now, I see a different warning. Not sure if they are
> related. I haven't tried to bisect.
> 
> --->8
> =============================
> [ BUG: Invalid wait context ]
> 5.19.0-rc8-next-20220725 #38 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> (&drvdata->spinlock){....}-{3:3}, at: cti_cpu_pm_notify+0x54/0x114

Hmmm... do you have CONFIG_PROVE_RAW_LOCK_NESTING enabled?

IIUC that should be {2:2} otherwise...

> other info that might help us debug this:
> context-{5:5}
> 1 lock held by swapper/0/0:
>  #0: (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x2c/0x80

... and this is telling us that we're trying to take a regular spinlock under a
raw spinlock, which is not as intended.

The Kconfig text notes:

         NOTE: There are known nesting problems. So if you enable this 
         option expect lockdep splats until these problems have been fully
         addressed which is work in progress. This config switch allows to
         identify and analyze these problems. It will be removed and the
         check permanently enabled once the main issues have been fixed.

... and I suspect this is one of those latent issues.

Mark.

> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-next-20220725-00004-g599e6691ed8c #38
> Call trace:
>  dump_backtrace+0xe8/0x108
>  show_stack+0x18/0x4c
>  dump_stack_lvl+0x90/0xc8
>  dump_stack+0x18/0x54
>  __lock_acquire+0xa70/0x32d0
>  lock_acquire+0x160/0x308
>  _raw_spin_lock+0x60/0xa0
>  cti_cpu_pm_notify+0x54/0x114
>  raw_notifier_call_chain_robust+0x50/0xd4
>  cpu_pm_enter+0x48/0x80
>  psci_enter_idle_state+0x34/0x74
>  cpuidle_enter_state+0x120/0x2a8
>  cpuidle_enter+0x38/0x50
>  do_idle+0x1e8/0x2b8
>  cpu_startup_entry+0x24/0x28
>  kernel_init+0x0/0x1a0
>  start_kernel+0x0/0x470
>  start_kernel+0x34c/0x470
>  __primary_switched+0xbc/0xc4
> 
> ----
> 
> --
> Regards,
> Sudeep
