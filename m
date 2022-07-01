Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39D562ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiGAFHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGAFHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:07:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36A4061D4D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:07:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE7F1042;
        Thu, 30 Jun 2022 22:07:43 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03393F5A1;
        Thu, 30 Jun 2022 22:07:40 -0700 (PDT)
Message-ID: <9be223fb-5803-b676-902a-28e1c168cd8a@arm.com>
Date:   Fri, 1 Jul 2022 10:37:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Regarding perfmon_capable()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In perf event subsystem and related platform drivers registering a PMU,
should perfmon_capable() be used directly ? OR just wondering if instead
perf_allow_[cpu|kernel|tracepoint]() helpers should be used which also
checks for 'sysctl_perf_event_paranoid' ? Should not both capabilities
and 'sysctl_perf_event_paranoid' decide whether kernel/cpu/tracepoint
events will be captured for unprivileged users.

arch/parisc/kernel/perf.c:      if (!perfmon_capable())
arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
drivers/gpu/drm/i915/i915_perf.c:           i915_perf_stream_paranoid && !perfmon_capable()) {
drivers/gpu/drm/i915/i915_perf.c:                       if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
drivers/media/rc/bpf-lirc.c:            if (perfmon_capable())
drivers/perf/arm_spe_pmu.c:     if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
drivers/perf/arm_spe_pmu.c:     if (!perfmon_capable() &&

Although BPF might use perfmon_capabale() alone, because it was never
dependent on 'sysctl_perf_event_paranoid' ?

- Anshuman
