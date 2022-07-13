Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C379C572C28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiGMEGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiGMEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:06:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C35DA0E2;
        Tue, 12 Jul 2022 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657685164; x=1689221164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h21pW3u7dmAn7T6DdhtskCVqgHq2DRMMlW5PszHq9Uo=;
  b=QHCX8PVpBCaWVvUPgVJ2dURo3wxmTU7eRpfsGY8TOmsuXUCTYNH4eKD1
   UgaiD3F2nXbtEIhS96A2Q2J1dRQIbtp35MVIQDDYroz8/+LkuYNtzOAST
   sNF3j/Emvo5fyQwHSd1iwsrT1ilhRRwVDrYDNxyfZ1OiaDITpARDu2RsZ
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jul 2022 21:06:03 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:06:03 -0700
Received: from [10.242.59.11] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 21:05:59 -0700
Message-ID: <ac0ef25b-b9a9-b4d5-381c-4e970a258cc9@quicinc.com>
Date:   Wed, 13 Jul 2022 09:35:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V6] arm64: perf: Make exporting of pmu events configurable
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654779589-19937-1-git-send-email-quic_c_spathi@quicinc.com>
 <20220624121825.GB18561@willie-the-truck>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <20220624121825.GB18561@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/2022 5:48 PM, Will Deacon wrote:
> On Thu, Jun 09, 2022 at 06:29:49PM +0530, Srinivasarao Pathipati wrote:
>> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
>> Make it configurable using sysctls to enable/disable at runtime.
>>
>> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
>> ---
>> Changes since V5:
>> 	- removed configuring with kernel parameters.
>> Changes since V4:
>> 	- Registering sysctls dynamically for only arm64 as suggested by Will
>> 	- Not removed the code to configure with kernel parameters
>> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
>> 	  is not working at early bootup. pmu_reset() getting called before
>> 	  sysctl's kernel parameter is set.
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
>>
>> ---
>>   Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
>>   arch/arm64/kernel/perf_event.c              | 13 +++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index ddccd10..c2ecd84 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -267,6 +267,17 @@ domain names are in general different. For a detailed discussion
>>   see the ``hostname(1)`` man page.
>>   
>>   
>> +export_pmu_events (arm64 only)
>> +==============================
>> +
>> +Controls the PMU export bit (PMCR_EL0.X), which enables the exporting of
>> +events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
>> +
>> +0: disables exporting of events (default).
>> +
>> +1: enables exporting of events.
>> +
>> +
>>   firmware_config
>>   ===============
>>   
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index cb69ff1..a8c32a0 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
>>   PMU_FORMAT_ATTR(rdpmc, "config1:1");
>>   
>>   static int sysctl_perf_user_access __read_mostly;
>> +static int sysctl_export_pmu_events __read_mostly;
>>   
>>   static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>>   {
>> @@ -1047,6 +1048,9 @@ static void armv8pmu_reset(void *info)
>>   	if (armv8pmu_has_long_event(cpu_pmu))
>>   		pmcr |= ARMV8_PMU_PMCR_LP;
>>   
>> +	if (sysctl_export_pmu_events)
>> +		pmcr |= ARMV8_PMU_PMCR_X;
> I think we need to do this in armv8pmu_start() rather than armv8pmu_reset(),
> otherwise any changes to the sysctl at runtime won't take effect unless you
> do something like re-online the CPU.
>
> Will

Hi Will ,

We think it may not work.   Say for example pmu->reset is called which 
disables the exporting of events,
and pmu->start not called. This would lead to missing of events.

How about enabling it in both reset and start functions? do you see any 
issue?

--Srinivas

