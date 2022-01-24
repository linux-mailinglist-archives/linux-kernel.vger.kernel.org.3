Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF41498804
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiAXSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:15:36 -0500
Received: from foss.arm.com ([217.140.110.172]:43484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235811AbiAXSPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:15:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD38A101E;
        Mon, 24 Jan 2022 10:15:32 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 216393F766;
        Mon, 24 Jan 2022 10:15:31 -0800 (PST)
Subject: Re: [RFC V1 07/11] arm64/perf: Add BRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        German Gomez <german.gomez@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-8-git-send-email-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <774cac19-5907-0b35-92a4-ccfef3cc095d@arm.com>
Date:   Mon, 24 Jan 2022 18:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642998653-21377-8-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2022 04:30, Anshuman Khandual wrote:
> This adds a BRBE driver which implements all the required helper functions
> for struct arm_pmu. Following functions are defined by this driver which
> will configure, enable, capture, reset and disable BRBE buffer HW as and
> when requested via perf branch stack sampling framework.
> 
> - arm64_pmu_brbe_filter()
> - arm64_pmu_brbe_enable()
> - arm64_pmu_brbe_disable()
> - arm64_pmu_brbe_read()
> - arm64_pmu_brbe_probe()
> - arm64_pmu_brbe_reset()
> - arm64_pmu_brbe_supported()
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
[...]
> +bool arm64_pmu_brbe_supported(struct perf_event *event)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
> +	struct pmu_hw_events *hw_events = per_cpu_ptr(armpmu->hw_events, event->cpu);
> +
> +	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL) {
> +		if (!perfmon_capable()) {
> +			pr_warn_once("does not have permission for kernel branch filter\n");
> +			return false;

Why not check perf_event_paranoid too? I would expect kernel sampling to be allowed for non
root users with paranoid <= 0.

