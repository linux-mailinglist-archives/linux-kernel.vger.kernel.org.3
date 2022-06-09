Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C25442D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiFIFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFIFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:02:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6B219128;
        Wed,  8 Jun 2022 22:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654750968; x=1686286968;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zXw+Mis03bohBkfK+hDhw/wFr5Kd1lzp07uRvIK3edI=;
  b=OV3VHIG5K49NaV0qNx7NjDZr6HKMHAdn5j+6f5+C70S75fPuVBllSk+z
   ulXWcbNLlRXD29eqsO703NqAslJFLdKKsoqDEJA4hHoygepfequB29tUG
   ZtAbRvlUqJ43cWEV8iGcDEprYzA8UyO9OA6o/R1zzDfVhICvGuGi1tCPT
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 22:02:48 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 22:02:47 -0700
Received: from [10.242.59.11] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 22:02:44 -0700
Message-ID: <6820a04b-16d2-3310-6491-835d8727edec@quicinc.com>
Date:   Thu, 9 Jun 2022 10:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V5] arm64: perf: Make exporting of pmu events configurable
Content-Language: en-US
To:     <will@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <1653306574-20946-1-git-send-email-quic_c_spathi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Will / Robin ,

Could you please review this change.

On 5/23/2022 5:19 PM, Srinivasarao Pathipati wrote:
> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
> Make is configurable using sysctls to enable/disable at runtime.
> It can also be enabled at early bootup with kernel arguments.
>
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V4:
> 	- Registering sysctls dynamically for only arm64 as suggested by Will
> 	- Not removed the code to configure with kernel parameters
> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
> 	  is not working at early bootup. pmu_reset() getting called before
> 	  sysctl's kernel parameter is set.
> Changes since V3:
> 	- export bit is now configurable with sysctl
> 	- enabling export bit on reset instead of retaining
>
> Changes since V2:
> 	Done below changes as per Will's comments
> 	- enabling pmcr_x now configurable with kernel parameters and
> 	  by default it is disabled.
> 	
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment.
>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>   Documentation/admin-guide/sysctl/kernel.rst     |  9 +++++++++
>   arch/arm64/kernel/perf_event.c                  | 24 ++++++++++++++++++++++++
>   3 files changed, 38 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index de3da15..2bf1187 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5150,6 +5150,11 @@
>   			Useful for devices that are detected asynchronously
>   			(e.g. USB and MMC devices).
>   
> +	export_pmu_events
> +			[KNL,ARM64] Sets the PMU export bit (PMCR_EL0.X), which enables
> +			the exporting of events over an IMPLEMENTATION DEFINED PMU event
> +			export bus to another device.
> +
>   	retain_initrd	[RAM] Keep initrd memory after extraction
>   
>   	rfkill.default_state=
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd10..db42d4c 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -892,6 +892,15 @@ The default value is 0 (access disabled).
>   
>   See Documentation/arm64/perf.rst for more information.
>   
> +export_pmu_events (arm64 only)
> +==============================
> +Controls the PMU export bit (PMCR_EL0.X), which enables the exporting of
> +events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
> +
> +0: disables exporting of events (default).
> +
> +1: enables exporting of events.
> +
>   
>   pid_max
>   =======
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1..d93e7c4 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
>   PMU_FORMAT_ATTR(rdpmc, "config1:1");
>   
>   static int sysctl_perf_user_access __read_mostly;
> +static int sysctl_export_pmu_events __read_mostly;
>   
>   static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>   {
> @@ -1025,6 +1026,17 @@ static int armv8pmu_filter_match(struct perf_event *event)
>   	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
>   }
>   
> +static int __init export_pmu_events(char *str)
> +{
> +	/* Enable exporting of pmu events at early bootup with kernel
> +	 * arguments.
> +	 */
> +	sysctl_export_pmu_events = 1;
> +	return 0;
> +}
> +
> +early_param("export_pmu_events", export_pmu_events);
> +
>   static void armv8pmu_reset(void *info)
>   {
>   	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1047,6 +1059,9 @@ static void armv8pmu_reset(void *info)
>   	if (armv8pmu_has_long_event(cpu_pmu))
>   		pmcr |= ARMV8_PMU_PMCR_LP;
>   
> +	if (sysctl_export_pmu_events)
> +		pmcr |= ARMV8_PMU_PMCR_X;
> +
>   	armv8pmu_pmcr_write(pmcr);
>   }
>   
> @@ -1221,6 +1236,15 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
>   		.extra1		= SYSCTL_ZERO,
>   		.extra2		= SYSCTL_ONE,
>   	},
> +	{
> +		.procname       = "export_pmu_events",
> +		.data           = &sysctl_export_pmu_events,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ZERO,
> +		.extra2         = SYSCTL_ONE,
> +	},
>   	{ }
>   };
>   
