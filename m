Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7590D48655E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiAFNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAFNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:40:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C3C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 05:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC4C61A5C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF45C36AED;
        Thu,  6 Jan 2022 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641476410;
        bh=q3ly8S7aPFPJldotITryq9m6fn3xnLYDfxH/laFyipk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTBRnxB6vmr+jRBvWvXXawGsiw9XHAr4e1ZIoy/WufoQAnloudhQO0v7561WI8ZUS
         adbtFoIPjzZJ0vt1HcH666JebTTJouu1VlNVbD3OOrO9L34BkW2PIkbjh2I+ly8ktW
         iTSG+wmZreJ44tkBt4zpJ25jMlL++UBs/kiJUzJfJ0bupGkhGt3FMmy5CLRaup8u7z
         zeiVcaRAJZsSea8NXim17GwT8u778vv/bLuZVELUFg8jFEfAsJ7kP8DRsIgiLbuYKB
         pVfSrM7nPiqTgsJ/DGiEPmvGR1rOPCfXfoWOtAjwZrNMm46OUAK7AEkOQbIqILRdHy
         yQkgBAM81wqNw==
Date:   Thu, 6 Jan 2022 14:40:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: tick/sched: iowait_sleeptime resides in tick_cpu_sched structure
 is a negative value
Message-ID: <20220106134007.GA1313863@lothringen>
References: <074a28e8-3794-5fee-f2ab-f08787149481@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <074a28e8-3794-5fee-f2ab-f08787149481@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:14:02PM +0800, luanshi wrote:
> Hi All,
> 
> We encounted a hardlockup problem on ARM server, after some debug found
> that:
> 
> PID: 0      TASK: ffff0400064de300  CPU: 126  COMMAND: "swapper/126"
>  #0 [ffff8000250f3c90] __crash_kexec at ffff80001013a064
>  #1 [ffff8000250f3e30] panic at ffff800010afd028
>  #2 [ffff8000250f3f10] nmi_panic at ffff80001004a9e0
>  #3 [ffff8000250f3f20] watchdog_hardlockup_check at ffff80001017b7f0
>  #4 [ffff8000250f3f40] sdei_watchdog_callback at ffff80001003c9a4
>  #5 [ffff8000250f3f50] sdei_event_handler at ffff8000108816b8
>  #6 [ffff8000250f3f80] _sdei_handler at ffff800010b1c2e4
>  #7 [ffff8000250f3fd0] __sdei_handler at ffff800010b139b0
>  #8 [ffff8000250f3ff0] __sdei_asm_handler at ffff800010014c18
> --- <IRQ stack> ---
>  #9 [ffff800013973f10] __cpu_do_idle at ffff800010b13764
> #10 [ffff800013973f20] arch_cpu_idle at ffff800010b137ec
> #11 [ffff800013973f30] default_idle_call at ffff800010b1b5cc
> #12 [ffff800013973f50] cpuidle_idle_call at ffff80001009648c
> #13 [ffff800013973f90] do_idle at ffff8000100965b0
> #14 [ffff800013973fc0] cpu_startup_entry at ffff8000100967d4
> #15 [ffff800013973fe0] secondary_start_kernel at ffff800010026bb0
> 
> 
> per_cpu(tick_cpu_sched, 126) = $1 = {
>   sched_timer = {
>     node = {
>       node = {
>         __rb_parent_color = 18446603337117384112,
>         rb_right = 0x0,
>         rb_left = 0x0
>       },
>       expires = 6108564000000
>     },
>     _softexpires = 6108564000000,
>     function = 0xffff800010122ec0 <tick_sched_timer>,
>     base = 0xffff04473bbcc780,
>     state = 1 '\001',
>     is_rel = 0 '\000',
>     is_soft = 0 '\000',
>     is_hard = 1 '\001'
>   },
>   check_clocks = 0,
>   nohz_mode = NOHZ_MODE_INACTIVE,
>   inidle = 1,
>   tick_stopped = 0,
>   idle_active = 1,
>   do_timer_last = 0,
>   got_idle_tick = 1,
>   last_tick = 0,
>   next_tick = 0,
>   idle_jiffies = 0,
>   idle_calls = 0,
>   idle_sleeps = 0,
>   idle_entrytime = 5012087709249,
>   idle_waketime = 0,
>   idle_exittime = 0,
>   idle_sleeptime = 4936136669951,
>   iowait_sleeptime = -1942739704,
>   last_jiffies = 0,
>   timer_expires = 0,
>   timer_expires_base = 0,
>   next_timer = 0,
>   idle_expires = 0,
>   tick_dep_mask = {
>     counter = 0
>   }
> }
> 
> iowait_sleeptime = -1942739704,
> ----------
> iowait_sleeptime is monotonically increasing, under what circumstances iowait_sleeptime
> can be a negative value?
> 
> For detailed information:
> https://bugzilla.kernel.org/show_bug.cgi?id=215458
> 
> 
> Can you give me some suggestions for debugging.

Some racy updates can happen if cpufreq or "cat /proc/stat" do concurrent
updates. But for that nohz needs to be running and I see your CPU clock has
NOHZ_MODE_INACTIVE. Perhaps it's only for that CPU though.

What is the value of tick_nohz_active in your dump?


> 
> 
> 
> Thanks,
> Liguang
> 
