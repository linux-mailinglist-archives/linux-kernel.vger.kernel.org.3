Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654264B6ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiBOOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:30:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiBOOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:30:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C06EEA7C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:30:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EACD1396;
        Tue, 15 Feb 2022 06:30:14 -0800 (PST)
Received: from [10.1.28.155] (e127744.cambridge.arm.com [10.1.28.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0153F718;
        Tue, 15 Feb 2022 06:30:13 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220205153940.GB391033@leoy-ThinkPad-X240s>
 <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
 <20220208130047.GA273989@leoy-ThinkPad-X240s>
 <e68839bc-b4f0-1fe8-1748-484254ded37a@arm.com>
 <20220211104528.GA475776@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <d59e99ad-dfc6-27ee-d952-7455d8e9fda6@arm.com>
Date:   Tue, 15 Feb 2022 14:29:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220211104528.GA475776@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/02/2022 10:45, Leo Yan wrote:
> Hi German,
>
> On Thu, Feb 10, 2022 at 05:23:50PM +0000, German Gomez wrote:
>
> [...]
>
>>>>>> One way to fix this is by caching the value of the CX bit during the
>>>>>> initialization of the PMU event, so that it remains consistent for the
>>>>>> duration of the session.
>>>>>>
>>>>>> [...]
>>> So the patch makes sense to me.  Just a minor comment:
>>>
>>> Here we can define a u64 for recording pmscr value rather than a
>>> bool value.
>>>
>>> struct arm_spe_pmu {
>>>     ...
>>>     u64 pmscr;
>>> };
>> I agree with the comment from Will that it makes more sense to store the
>> value of the register in the perf_event somehow (due to misunderstanding
>> from my side, I thought arm_spe_pmu struct was local to the session).
> It's shame that I miss this point :) As you said, struct arm_spe_pmu is
> a data structure for Arm SPE device driver instance and it's not
> allocated for perf session.
>
>> What about perf_event's void *pmu_private?
> Before we use perf_event::pmu_private, could you check the data
> structure arm_spe_pmu_buf firstly?  This data structure is allocated
> when setup AUX ring buffer (so it's allocated for perf session).
> IIUC, the function arm_spe_pmu_setup_aux() will be invoked in the perf
> process, so it's good for us to initialize pmscr in this function.
Thanks for the suggestion. I recorded the following stacktrace:

 perf-323841 [052] d.... 3996.528812: arm_spe_pmu_setup_aux: (arm_spe_pmu_setup_aux+0x60/0x1c0 [arm_spe_pmu])
 perf-323841 [052] d.... 3996.528813: <stack trace>
 => kprobe_dispatcher
 => kprobe_breakpoint_handler
 => call_break_hook
 => brk_handler
 => do_debug_exception
 => el1_dbg
 => el1h_64_sync_handler
 => el1h_64_sync
 => arm_spe_pmu_setup_aux
 => perf_mmap
 => mmap_region
 => do_mmap
 => vm_mmap_pgoff
 => ksys_mmap_pgoff
 => __arm64_sys_mmap
 => invoke_syscall
 => el0_svc_common.constprop.0
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

So for a v2 I may include something like this:

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d..aadec5a0e 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -45,6 +45,7 @@ struct arm_spe_pmu_buf {
     int                    nr_pages;
     bool                    snapshot;
     void                    *base;
+    u64                    pmscr;
 };
 
 struct arm_spe_pmu {
@@ -748,7 +749,7 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
         write_sysreg_s(reg, SYS_PMSICR_EL1);
     }
 
-    reg = arm_spe_event_to_pmscr(event);
+    reg = ((struct arm_spe_pmu_buf *) perf_get_aux(handle))->pmscr;
     isb();
     write_sysreg_s(reg, SYS_PMSCR_EL1);
 }
@@ -855,6 +856,8 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
     if (!pglist)
         goto out_free_buf;
 
+    buf->pmscr = arm_spe_event_to_pmscr(event);
+
     for (i = 0; i < nr_pages; ++i)
         pglist[i] = virt_to_page(pages[i]);

>
> Thanks,
> Leo
