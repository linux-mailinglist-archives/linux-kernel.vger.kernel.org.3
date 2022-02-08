Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A894ADBF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbiBHPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379219AbiBHPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:04:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48F7C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:04:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF96E2B;
        Tue,  8 Feb 2022 07:04:52 -0800 (PST)
Received: from [10.57.88.245] (unknown [10.57.88.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45DC93F73B;
        Tue,  8 Feb 2022 07:04:51 -0800 (PST)
Message-ID: <7ba34443-d76a-253d-d112-4100d5a57e21@arm.com>
Date:   Tue, 8 Feb 2022 15:04:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 01/15] coresight: Make ETM4x TRCIDR0 register accesses
 consistent with sysreg.h
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203120604.128396-1-james.clark@arm.com>
 <20220203120604.128396-2-james.clark@arm.com>
 <1b649955-cb45-1283-68cd-c82582cef60c@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1b649955-cb45-1283-68cd-c82582cef60c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 05:44, Anshuman Khandual wrote:
> Hi James,
> 
> These are all ETM4X specific changes. Something like this might be cleaner
> and also more compact. Also would suggest to follow the same for subsequent
> patches as well.
> 
> coresight: etm4x: Cleanup TRCIDR0 register accesses
> 
> Consistency with sysreg.h could be mentioned in the commit message itself.
> 
> On 2/3/22 5:35 PM, James Clark wrote:
>> This is a no-op change for style and consistency and has no effect on the
>> binary produced by gcc-11.
> 
> This patch adds register definitions, helper macros as well. Please expand
> the commit message to add more details. This is too short, for the change
> it creates. BTW why is it necessary to mention GCC version number here.
> 
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
>>   drivers/hwtracing/coresight/coresight-priv.h  |  5 +++
>>   3 files changed, 30 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index e2eebd865241..107e81948f76 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -1091,41 +1091,21 @@ static void etm4_init_arch_data(void *info)
>>   	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>>   
>>   	/* INSTP0, bits[2:1] P0 tracing support field */
>> -	if (BMVAL(etmidr0, 1, 2) == 0b11)
>> -		drvdata->instrp0 = true;
>> -	else
>> -		drvdata->instrp0 = false;
>> -
>> +	drvdata->instrp0 = !!(REG_VAL(etmidr0, TRCIDR0_INSTP0) == 0b11);
>>   	/* TRCBB, bit[5] Branch broadcast tracing support bit */
>> -	if (BMVAL(etmidr0, 5, 5))
>> -		drvdata->trcbb = true;
>> -	else
>> -		drvdata->trcbb = false;
>> -
>> +	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
>>   	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
>> -	if (BMVAL(etmidr0, 6, 6))
>> -		drvdata->trccond = true;
>> -	else
>> -		drvdata->trccond = false;
>> -
>> +	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
>>   	/* TRCCCI, bit[7] Cycle counting instruction bit */
>> -	if (BMVAL(etmidr0, 7, 7))
>> -		drvdata->trccci = true;
>> -	else
>> -		drvdata->trccci = false;
>> -
>> +	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
>>   	/* RETSTACK, bit[9] Return stack bit */
>> -	if (BMVAL(etmidr0, 9, 9))
>> -		drvdata->retstack = true;
>> -	else
>> -		drvdata->retstack = false;
>> -
>> +	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
>>   	/* NUMEVENT, bits[11:10] Number of events field */
>> -	drvdata->nr_event = BMVAL(etmidr0, 10, 11);
>> +	drvdata->nr_event = REG_VAL(etmidr0, TRCIDR0_NUMEVENT);
>>   	/* QSUPP, bits[16:15] Q element support field */
>> -	drvdata->q_support = BMVAL(etmidr0, 15, 16);
>> +	drvdata->q_support = REG_VAL(etmidr0, TRCIDR0_QSUPP);
>>   	/* TSSIZE, bits[28:24] Global timestamp size field */
>> -	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
>> +	drvdata->ts_size = REG_VAL(etmidr0, TRCIDR0_TSSIZE);
>>   
>>   	/* maximum size of resources */
>>   	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 3c4d69b096ca..2bd8ad953b8e 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -130,6 +130,23 @@
>>   
>>   #define TRCRSR_TA			BIT(12)
>>   
>> +/*
>> + * Bit positions of registers that are defined above, in the sysreg.h style
>> + * of _MASK, _SHIFT and BIT().
>> + */
> 
> ^^^ not really necessary. Instead the format requirement for below mentioned
> CORESIGHT_REG_VAL() macro might be relevant and should be mentioned.
> 
>> +#define TRCIDR0_INSTP0_SHIFT			1
>> +#define TRCIDR0_INSTP0_MASK			GENMASK(1, 0)
>> +#define TRCIDR0_TRCBB				BIT(5)
>> +#define TRCIDR0_TRCCOND				BIT(6)
>> +#define TRCIDR0_TRCCCI				BIT(7)
>> +#define TRCIDR0_RETSTACK			BIT(9)
>> +#define TRCIDR0_NUMEVENT_SHIFT			10
>> +#define TRCIDR0_NUMEVENT_MASK			GENMASK(1, 0)
>> +#define TRCIDR0_QSUPP_SHIFT			15
>> +#define TRCIDR0_QSUPP_MASK			GENMASK(1, 0)
>> +#define TRCIDR0_TSSIZE_SHIFT			24
>> +#define TRCIDR0_TSSIZE_MASK			GENMASK(4, 0)
>> +
>>   /*
>>    * System instructions to access ETM registers.
>>    * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> index ff1dd2092ac5..1452c6038421 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -36,6 +36,11 @@
>>   
>>   #define TIMEOUT_US		100
>>   #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>> +/*
>> + * Extract a field from a register where field is #defined in the form
>> + * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
>> + */
> 
> Looking at the usage, <register_name> is already embedded in <filed_name>. So
> it requires <field_name>_SHIFT and <field_name>_MASK instead. Unless register
> name should be passed as separate argument (which actually might be better).
> 
> REG_VAL(etmidr0, TRCIDR0_TSSIZE) ----> REG_VAL(etmidr0, TRCIDR0, TSSIZE)

I don't see much difference here. So I am fine either way.

> 
> with some restructuring in the comment ..
> 
> /*
>   * Extract a field from a coresight register
>   *
>   * Required fields are defined as macros like the following
>   *
>   * <register_name>_<field_name>_MASK and <register_name>_<field_name>_SHIFT
>   */
> 
>> +#define REG_VAL(val, field)	((val & (field##_MASK << field##_SHIFT)) >> field##_SHIFT)
> 
> This is too generic to be in a coresight header or it should just be
> named CORESIGHT_REG_VAL() instead, making it more specific for here.
> 
> The build should fail in case any required macro definition is absent.
> I guess no more fortification is required in case macros are missing.
> 
> However CORESIGHT_REG_VAL() is better placed in <coresight-etm4x.h>
> just before all the dependent SHIFT/MASK register field definition
> starts.

Not necessarily. CORESIGHT_REG_VAL() is a generic function and doesn't
have anything specific to do with etm4x. We could reuse that for
cleaning up other drivers in CoreSight.

Cheers
Suzuki
