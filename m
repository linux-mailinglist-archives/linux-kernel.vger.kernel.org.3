Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E004B1423
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbiBJRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:24:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiBJRYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:24:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7AE1C2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:24:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1F0D6E;
        Thu, 10 Feb 2022 09:24:37 -0800 (PST)
Received: from [10.1.30.148] (e127744.cambridge.arm.com [10.1.30.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 283923F718;
        Thu, 10 Feb 2022 09:24:35 -0800 (PST)
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
From:   German Gomez <german.gomez@arm.com>
Message-ID: <e68839bc-b4f0-1fe8-1748-484254ded37a@arm.com>
Date:   Thu, 10 Feb 2022 17:23:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220208130047.GA273989@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 08/02/2022 13:00, Leo Yan wrote:
> Hi German,
>
> On Mon, Feb 07, 2022 at 12:06:14PM +0000, German Gomez wrote:
>
> [...]
> Indeed!  I can reproduce the issue now.  And I can capture backtrace
> for arm_spe_pmu_start() with below commands:
>
> # cd /home/leoy/linux/tools/perf
> # ./perf probe --add "arm_spe_pmu_start" -s /home/leoy/linux/ -k /home/leoy/linux/vmlinux
> # echo 1 > /sys/kernel/debug/tracing/events/probe/arm_spe_pmu_start/enable
> # echo stacktrace > /sys/kernel/debug/tracing/events/probe/arm_spe_pmu_start/trigger
>
> ... run your commands with non-root user ...
>
> # cat /sys/kernel/debug/tracing/trace
>
>              dd-7697    [000] d.h2.   506.068700: arm_spe_pmu_start: (arm_spe_pmu_start+0x8/0xe0)
>              dd-7697    [000] d.h3.   506.068701: <stack trace>
> => kprobe_dispatcher
> => kprobe_breakpoint_handler
> => call_break_hook
> [...]
> => do_el0_svc
> => el0_svc
> => el0t_64_sync_handler
> => el0t_64_sync
>
> The backtrace clearly shows the function arm_spe_pmu_start() is
> invoked in the 'dd' process (dd-7697); the flow is:
> - perf program sends IPI to CPU0;
> - 'dd' process is running on CPU0 and it's interrupted to handle IPI;
> - 'dd' process has root capabilities, so it will enable context
>   tracing for non-root perf session.

Thanks for testing, and sharing the commands in your replies!

>
>>>> One way to fix this is by caching the value of the CX bit during the
>>>> initialization of the PMU event, so that it remains consistent for the
>>>> duration of the session.
>>>>
>>>> [...]
> So the patch makes sense to me.  Just a minor comment:
>
> Here we can define a u64 for recording pmscr value rather than a
> bool value.
>
> struct arm_spe_pmu {
>     ...
>     u64 pmscr;
> };

I agree with the comment from Will that it makes more sense to store the
value of the register in the perf_event somehow (due to misunderstanding
from my side, I thought arm_spe_pmu struct was local to the session).

What about perf_event's void *pmu_private?

Thanks,
German
