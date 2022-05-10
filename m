Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED525210D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiEJJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiEJJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:30:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2FD4269EDD;
        Tue, 10 May 2022 02:27:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86A8112FC;
        Tue, 10 May 2022 02:27:00 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FB2F3F66F;
        Tue, 10 May 2022 02:26:58 -0700 (PDT)
Message-ID: <3b07bd45-42e7-0298-70d5-60d950e27304@arm.com>
Date:   Tue, 10 May 2022 10:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V3] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Content-Language: en-GB
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>,
        will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1652117330-21976-1-git-send-email-quic_c_spathi@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1652117330-21976-1-git-send-email-quic_c_spathi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-09 18:28, Srinivasarao Pathipati wrote:
> Preserve the bit PMCR.X of PMCR_EL0 during PMU reset to export
> PMU events. as it could be set before PMU initialization.

Reiterating my previous comment, if there are use-cases for enabling the 
event export bus under Linux, then it makes most sense to have an option 
to enable the event export bus. It shouldn't have to depend on whatever 
the bootloader may or may not have done.

What would it even mean to preserve a value of 0 instead of resetting it 
to 0?

Thanks,
Robin.

> Exporting events could result in additional power consumption
> so making it configurable.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V2:
> 	Done below changes as per Will's comments
> 	- enabling pmcr_x now configurable with kernel parameters and
> 	  by default it is disabled.
> 	
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment.
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>   arch/arm64/kernel/perf_event.c                  | 13 +++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index de3da15..cf3410e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5150,6 +5150,10 @@
>   			Useful for devices that are detected asynchronously
>   			(e.g. USB and MMC devices).
>   
> +	retain_pmcr_x
> +			[KNL] Retain export bit of PMCR_EL0 that is getting reset
> +			during pmu reset.
> +
>   	retain_initrd	[RAM] Keep initrd memory after extraction
>   
>   	rfkill.default_state=
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1..1ac251f 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -34,6 +34,7 @@
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
>   
> +static int export_pmu_events  __read_mostly;
>   /*
>    * ARMv8 Architectural defined events, not all of these may
>    * be supported on any given implementation. Unsupported events will
> @@ -1025,6 +1026,14 @@ static int armv8pmu_filter_match(struct perf_event *event)
>   	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
>   }
>   
> +static int __init retain_pmcr_x(char *str)
> +{
> +	export_pmu_events = 1;
> +	return 0;
> +}
> +
> +early_param("retain_pmcr_x", retain_pmcr_x);
> +
>   static void armv8pmu_reset(void *info)
>   {
>   	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1047,6 +1056,10 @@ static void armv8pmu_reset(void *info)
>   	if (armv8pmu_has_long_event(cpu_pmu))
>   		pmcr |= ARMV8_PMU_PMCR_LP;
>   
> +	/* Preserve PMCR_X to export PMU events */
> +	if (export_pmu_events)
> +		pmcr |= (armv8pmu_pmcr_read() & ARMV8_PMU_PMCR_X);
> +
>   	armv8pmu_pmcr_write(pmcr);
>   }
>   
