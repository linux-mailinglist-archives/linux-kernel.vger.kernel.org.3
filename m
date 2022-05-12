Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039EB5246D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbiELHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350934AbiELHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:22:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3F27B3A;
        Thu, 12 May 2022 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652340125; x=1683876125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TcvqFRo7tE7F2CGVY7lJqLdptfPjmpv6H/Lv9po1svo=;
  b=KBWi2NK9ffH3L6RU8stGP8/c3cs8oUyY9oTK2tblBLAp6yRAMlHvds3E
   dUKocG/603dE6zRqHRhkV0fRJddf9/cs8716RuLnpxlCXWtOB89hwlSp/
   qJRvx2OKa8jrIdkBKGgLrhf18tjjk6jrW5q2cCYVARt2uJAQsDfyVk9Y7
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 May 2022 00:22:05 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 00:22:04 -0700
Received: from [10.50.47.121] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 00:22:00 -0700
Message-ID: <e740f0f7-8010-a390-98e0-d549d981f5e3@quicinc.com>
Date:   Thu, 12 May 2022 12:51:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs
Content-Language: en-US
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Andre Przywara <andre.przywara@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
References: <20220511080247.1530-1-quic_shrekk@quicinc.com>
 <7a7b4657-ec75-7984-1a6e-50ff928ab09c@quicinc.com>
From:   Shreyas K K <quic_shrekk@quicinc.com>
In-Reply-To: <7a7b4657-ec75-7984-1a6e-50ff928ab09c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 5/11/2022 4:43 PM, Sai Prakash Ranjan wrote:
> Hi Shreyas,
>
> On 5/11/2022 1:32 PM, Shreyas K K wrote:
>> Add KRYO4XX gold/big cores to the list of CPUs that need the
>> repeat TLBI workaround. Apply this to the affected
>> KRYO4XX cores (rcpe to rdpe).
>>
>> The variant and revision bits are implementation defined and are
>> different from the their Cortex CPU counterparts on which they are
>> based on, i.e., (r0p0 to r1p0) is equivalent to (rcpe to rdpe).
>>
>> Signed-off-by: Shreyas K K <quic_shrekk@quicinc.com>
>> ---
>>   Documentation/arm64/silicon-errata.rst | 3 +++
>>   arch/arm64/kernel/cpu_errata.c         | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/arm64/silicon-errata.rst 
>> b/Documentation/arm64/silicon-errata.rst
>> index 466cb9e89047..d27db84d585e 100644
>> --- a/Documentation/arm64/silicon-errata.rst
>> +++ b/Documentation/arm64/silicon-errata.rst
>> @@ -189,6 +189,9 @@ stable kernels.
>> +----------------+-----------------+-----------------+-----------------------------+
>>   | Qualcomm Tech. | Kryo4xx Silver  | N/A             | 
>> ARM64_ERRATUM_1024718       |
>> +----------------+-----------------+-----------------+-----------------------------+
>> +| Qualcomm Tech. | Kryo4xx Gold    | N/A             | 
>> ARM64_ERRATUM_1286807       |
>> ++----------------+-----------------+-----------------+-----------------------------+ 
>>
>> +
>> +----------------+-----------------+-----------------+-----------------------------+
>>   | Fujitsu        | A64FX           | E#010001        | 
>> FUJITSU_ERRATUM_010001      |
>> +----------------+-----------------+-----------------+-----------------------------+
>> diff --git a/arch/arm64/kernel/cpu_errata.c 
>> b/arch/arm64/kernel/cpu_errata.c
>> index 4c9b5b4b7a0b..2518657e6de1 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -208,6 +208,8 @@ static const struct arm64_cpu_capabilities 
>> arm64_repeat_tlbi_list[] = {
>>   #ifdef CONFIG_ARM64_ERRATUM_1286807
>>       {
>>           ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 0),
>> +        /* Kryo4xx Gold (rcpe to rdpe) => (r0p0 to r1p0) */
>> +        ERRATA_MIDR_RANGE(QCOM_CPU_PART_KRYO_4XX_GOLD, 0xc, 0xe, 
>> 0xd, 0xe),
>>       },
>>   #endif
>>       {},
>
> Why not include r2p0 and r3p0 which are affected by this erratum? I 
> see these revisions are present
> in our SoCs as per the document.
>
> Thanks,
> Sai

Acknowledged. Changing in the next version.

Thanks,
Shreyas

