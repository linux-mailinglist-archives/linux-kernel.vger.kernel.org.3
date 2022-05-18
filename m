Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC552BD80
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbiERORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiERORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:17:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC322019C;
        Wed, 18 May 2022 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652883434; x=1684419434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RFGAGelgq/QkQ2F/v3PyHI0+fFIxwAPIU2tigz7ul+g=;
  b=egyrfij24dBHlSGps3Sr0pX+zU660u1uuQw9GqFT7wKMGmM+jdMlJtS5
   e7ewtbqGzY2jC4Py6OIK30rUCnQBHI3g2En/UAoeZNbHF8g2nDJ0tEWqE
   OLsT/Ewp+Ns4/0iEKc1TLcuBFGTWIEX0BjQFZ6jQluXStTHSFKxUxBiz7
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 07:17:13 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:17:12 -0700
Received: from [10.242.59.11] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 07:17:08 -0700
Message-ID: <7c9074ef-46c2-08b8-ab1d-410953145570@quicinc.com>
Date:   Wed, 18 May 2022 19:47:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4] arm64: perf: Set PMCR.X of PMCR_EL0 during pmu reset
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1652705738-1628-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220517130822.GA3369@willie-the-truck>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <20220517130822.GA3369@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2022 6:38 PM, Will Deacon wrote:
> On Mon, May 16, 2022 at 06:25:38PM +0530, Srinivasarao Pathipati wrote:
>> Enable exporting of events over PMU event export bus by setting
>> PMCR.X of PMCR_EL0 during pmu reset.
>>
>> As it impacts power consumption make it configurable at bootup
>> with kernel arguments and at runtime with sysctl.
>>
>> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
>> ---
>> Changes since V3:
>> 	- export bit is now configurable with sysctl
>> 	- enabling export bit on reset instead of retaining
>>
>> Changes since V2:
>> 	Done below changes as per Will's comments
>> 	- enabling pmcr_x now configurable with kernel parameters and
>> 	  by default it is disabled.
>> 	
>> Changes since V1:
>> 	- Preserving only PMCR_X bit as per Robin Murphy's comment.
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>   Documentation/admin-guide/sysctl/kernel.rst     |  8 ++++++++
>>   arch/arm64/kernel/perf_event.c                  | 15 +++++++++++++++
>>   include/linux/perf_event.h                      |  1 +
>>   kernel/sysctl.c                                 | 12 ++++++++++++
>>   5 files changed, 40 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index de3da15..2139b81 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5150,6 +5150,10 @@
>>   			Useful for devices that are detected asynchronously
>>   			(e.g. USB and MMC devices).
>>   
>> +	export_pmu_events
>> +			[KNL] Sets export bit of PMCR_EL0 to enable the exporting of
>> +			events over PMU event export bus.
> Sorry, I should've been clearer ahbout this before: if you add a sysctl,
> then you get the kernel cmdline option for free via something like
> "sysctl.kernel.export_pmu_events=foo", so I think you can drop this and
> the early_param().

Thanks for your suggestion , I tried this method and observed that 
pmu_reset is getting called even

before kernel argument updated the sysctl variable.   So exporting is 
not happening at early boot.

>> +
>>   	retain_initrd	[RAM] Keep initrd memory after extraction
>>   
>>   	rfkill.default_state=
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index ddccd10..8fbc3a0 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -892,6 +892,14 @@ The default value is 0 (access disabled).
>>   
>>   See Documentation/arm64/perf.rst for more information.
>>   
>> +export_pmu_events
>> +=================
> You should add something like "(arm64 only)" to the title.
>
>> +Controls the export bit(4th bit) of PMCR_EL0 which enables the exporting of
> Just say "Controls the PMU export bit (PMCR_EL0.X), which enables ...".
>
>> +events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
>> +
>> +0: disables exporting of events
>> +
>> +1: enables exporting of events
> Please state that the default value is 0.
>
>>   pid_max
>>   =======
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index cb69ff1..271a8c6 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -34,6 +34,7 @@
>>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
>>   #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
>>   
>> +int sysctl_export_pmu_events __read_mostly;
>>   /*
>>    * ARMv8 Architectural defined events, not all of these may
>>    * be supported on any given implementation. Unsupported events will
>> @@ -1025,6 +1026,17 @@ static int armv8pmu_filter_match(struct perf_event *event)
>>   	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
>>   }
>>   
>> +static int __init export_pmu_events(char *str)
>> +{
>> +	/* Exporting of events can be enabled at runtime with sysctl or
>> +	 * statically at bootup with kernel parameters.
>> +	 */
>> +	sysctl_export_pmu_events = 1;
>> +	return 0;
>> +}
>> +
>> +early_param("export_pmu_events", export_pmu_events);
>> +
>>   static void armv8pmu_reset(void *info)
>>   {
>>   	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
>> @@ -1047,6 +1059,9 @@ static void armv8pmu_reset(void *info)
>>   	if (armv8pmu_has_long_event(cpu_pmu))
>>   		pmcr |= ARMV8_PMU_PMCR_LP;
>>   
>> +	if (sysctl_export_pmu_events)
>> +		pmcr |= ARMV8_PMU_PMCR_X;
>> +
>>   	armv8pmu_pmcr_write(pmcr);
>
> Hmm, I think this reset path only runs when initialising/onlining a CPU,
> so it's not a great user interface where the sysctl is concerned. It's
> probably better to hook armv8pmu_start() for this.
>
>>   }
>>   
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index da75956..7790328 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1311,6 +1311,7 @@ extern void put_callchain_entry(int rctx);
>>   
>>   extern int sysctl_perf_event_max_stack;
>>   extern int sysctl_perf_event_max_contexts_per_stack;
>> +extern int sysctl_export_pmu_events;
>>   
>>   static inline int perf_callchain_store_context(struct perf_callchain_entry_ctx *ctx, u64 ip)
>>   {
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index e52b6e3..3b751a2e 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2008,6 +2008,18 @@ static struct ctl_table kern_table[] = {
>>   		.extra2		= SYSCTL_ONE_THOUSAND,
>>   	},
>>   #endif
>> +#ifdef CONFIG_HW_PERF_EVENTS
>> +	{
>> +		.procname       = "export_pmu_events",
>> +		.data           = &sysctl_export_pmu_events,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0644,
>> +		.proc_handler   = proc_dointvec_minmax,
>> +		.extra1         = SYSCTL_ZERO,
>> +		.extra2         = SYSCTL_ONE,
>> +
>> +	},
>> +#endif
> Since this is arm64-specific, it should live in the arm64 code and not
> here. See how we already register 'armv8_pmu_sysctl_table' for the ARMv8
> PMU.
>
> Will
