Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F252562C81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiGAHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:22:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA3C68A08
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:22:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D481042;
        Fri,  1 Jul 2022 00:22:41 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67A143F792;
        Fri,  1 Jul 2022 00:22:39 -0700 (PDT)
Message-ID: <54ea5d8c-74ad-c89a-929f-5d570ca351df@arm.com>
Date:   Fri, 1 Jul 2022 12:52:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Regarding perfmon_capable()
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <9be223fb-5803-b676-902a-28e1c168cd8a@arm.com>
 <20220701064732.GA659023@leoy-ThinkPad-X240s>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220701064732.GA659023@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/22 12:17, Leo Yan wrote:
> Hi Anshuman,
> 
> On Fri, Jul 01, 2022 at 10:37:37AM +0530, Anshuman Khandual wrote:
>> Hello,
>>
>> In perf event subsystem and related platform drivers registering a PMU,
>> should perfmon_capable() be used directly ? OR just wondering if instead
>> perf_allow_[cpu|kernel|tracepoint]() helpers should be used which also
>> checks for 'sysctl_perf_event_paranoid' ? Should not both capabilities
>> and 'sysctl_perf_event_paranoid' decide whether kernel/cpu/tracepoint
>> events will be captured for unprivileged users.
> 
> This is an interesting but important topic, let me join the discussion.
> 
> Simply to say, sysctl_perf_event_paranoid is a control knob,
> perfmon_capable() is for capabilities.  perfmon_capable() only allows
> privileged Perf users to access Perf events; on the other hand,
> sysctl_perf_event_paranoid can grant green light for non-privileged
> users to access perf events.

Could not unprivileged users have capabilities too ? I thought that was
the whole point for capabilities.

> 
> Therefore, if we use function perf_allow_[cpu|kernel|tracepoint]() as
> checking condition which is interfered by sysctl_perf_event_paranoid,
> it's superset of perfmon_capable().

Right. IIUC sysctl_perf_event_paranoid was the original method for perf
event to restrict access, where as capabilities is the new method. Hence
both needs to be checked for compatibility purpose for the original one.

> 
> On the other hand, even a Perf event can be opened by a non-privileged
> process, the low level driver still doesn't want to leak any sensitive
> info in the trace data or sampling.  This is why Arm SPE driver checks

Can/should low level PMU drivers enforce yet another layer of privilege
check even after the core perf allowed the event to be created in the
first place ?

> the condition perfmon_capable() and disables CONTEXTIDR tracing for
> non-privileged users (no matter what's the value of
> sysctl_perf_event_paranoid).
> 
> Just bear in mind for a corner case, some perf callback functions are
> invoked from the kernel threads context rather than user process
> context, this is why we might obeserve some strange cases that
> non-privileged users might be wrongly granted some tracing
> capabilities even we check with perfmon_capable() (Checking
> perfmon_capable() is not wrong, but it's wrong to do the checking in
> the kernel kthread context rather than user process context).

Is not pmu->event_init() called in user process context itself. Why can
not all privillege checking be done there and stored (if required) some
where more platform specific e.g event->hw.config or any other platform
data structure. Why should privilege gets checked in callbacks which
might run in privilege contexts to create such corner cases ?

> 
> This is my understanding, just correct me if any thing mentioned
> is not reliable.
> 
> Thanks,
> Leo
> 
>> arch/parisc/kernel/perf.c:      if (!perfmon_capable())
>> arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
>> arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
>> drivers/gpu/drm/i915/i915_perf.c:           i915_perf_stream_paranoid && !perfmon_capable()) {
>> drivers/gpu/drm/i915/i915_perf.c:                       if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
>> drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
>> drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
>> drivers/media/rc/bpf-lirc.c:            if (perfmon_capable())
>> drivers/perf/arm_spe_pmu.c:     if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>> drivers/perf/arm_spe_pmu.c:     if (!perfmon_capable() &&
>>
>> Although BPF might use perfmon_capabale() alone, because it was never
>> dependent on 'sysctl_perf_event_paranoid' ?
>>
>> - Anshuman
