Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4A48625B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiAFJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:49:56 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58237 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237370AbiAFJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:49:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V15ZUv-_1641462571;
Received: from 30.225.24.17(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0V15ZUv-_1641462571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 17:49:32 +0800
Message-ID: <bfdb3ed9-7c68-f7c5-63e6-40d18d9e8fd6@linux.alibaba.com>
Date:   Thu, 6 Jan 2022 17:49:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
From:   luanshi <zhangliguang@linux.alibaba.com>
Subject: tick/sched: iowait_sleeptime resides in tick_cpu_sched structure is a
 negative value
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We encounted a hardlockup problem on ARM server, after some debug found 
that:

PID: 0      TASK: ffff0400064de300  CPU: 126  COMMAND: "swapper/126"
  #0 [ffff8000250f3c90] __crash_kexec at ffff80001013a064
  #1 [ffff8000250f3e30] panic at ffff800010afd028
  #2 [ffff8000250f3f10] nmi_panic at ffff80001004a9e0
  #3 [ffff8000250f3f20] watchdog_hardlockup_check at ffff80001017b7f0
  #4 [ffff8000250f3f40] sdei_watchdog_callback at ffff80001003c9a4
  #5 [ffff8000250f3f50] sdei_event_handler at ffff8000108816b8
  #6 [ffff8000250f3f80] _sdei_handler at ffff800010b1c2e4
  #7 [ffff8000250f3fd0] __sdei_handler at ffff800010b139b0
  #8 [ffff8000250f3ff0] __sdei_asm_handler at ffff800010014c18
--- <IRQ stack> ---
  #9 [ffff800013973f10] __cpu_do_idle at ffff800010b13764
#10 [ffff800013973f20] arch_cpu_idle at ffff800010b137ec
#11 [ffff800013973f30] default_idle_call at ffff800010b1b5cc
#12 [ffff800013973f50] cpuidle_idle_call at ffff80001009648c
#13 [ffff800013973f90] do_idle at ffff8000100965b0
#14 [ffff800013973fc0] cpu_startup_entry at ffff8000100967d4
#15 [ffff800013973fe0] secondary_start_kernel at ffff800010026bb0


per_cpu(tick_cpu_sched, 126) = $1 = {
   sched_timer = {
     node = {
       node = {
         __rb_parent_color = 18446603337117384112,
         rb_right = 0x0,
         rb_left = 0x0
       },
       expires = 6108564000000
     },
     _softexpires = 6108564000000,
     function = 0xffff800010122ec0 <tick_sched_timer>,
     base = 0xffff04473bbcc780,
     state = 1 '\001',
     is_rel = 0 '\000',
     is_soft = 0 '\000',
     is_hard = 1 '\001'
   },
   check_clocks = 0,
   nohz_mode = NOHZ_MODE_INACTIVE,
   inidle = 1,
   tick_stopped = 0,
   idle_active = 1,
   do_timer_last = 0,
   got_idle_tick = 1,
   last_tick = 0,
   next_tick = 0,
   idle_jiffies = 0,
   idle_calls = 0,
   idle_sleeps = 0,
   idle_entrytime = 5012087709249,
   idle_waketime = 0,
   idle_exittime = 0,
   idle_sleeptime = 4936136669951,
   iowait_sleeptime = -1942739704,
   last_jiffies = 0,
   timer_expires = 0,
   timer_expires_base = 0,
   next_timer = 0,
   idle_expires = 0,
   tick_dep_mask = {
     counter = 0
   }
}

iowait_sleeptime = -1942739704,
----------
iowait_sleeptime is monotonically increasing, under what circumstances 
iowait_sleeptime
can be a negative value?

For detailed information:
https://bugzilla.kernel.org/show_bug.cgi?id=215458


Can you give me some suggestions for debugging.



Thanks,
Liguang

