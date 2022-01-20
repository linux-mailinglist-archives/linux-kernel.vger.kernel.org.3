Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19AD494D18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiATLhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:37:33 -0500
Received: from foss.arm.com ([217.140.110.172]:34568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbiATLhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2692113E;
        Thu, 20 Jan 2022 03:37:31 -0800 (PST)
Received: from [10.57.37.233] (unknown [10.57.37.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0933F774;
        Thu, 20 Jan 2022 03:37:30 -0800 (PST)
Subject: Re: [PATCH 1/1] coresight: Fix TRCCONFIGR.QE sysfs interface
To:     Mike Leach <mike.leach@linaro.org>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220114173254.1876151-1-james.clark@arm.com>
 <20220114173254.1876151-2-james.clark@arm.com>
 <CAJ9a7VhedrLMKfXBqzD_9fFxzKTg63-9wUM38Tw6ukhmSR9aoA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <139e5fb6-b917-163e-751c-1ef745852529@arm.com>
Date:   Thu, 20 Jan 2022 11:37:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VhedrLMKfXBqzD_9fFxzKTg63-9wUM38Tw6ukhmSR9aoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2022 15:22, Mike Leach wrote:
> Hi James
> 
> On Fri, 14 Jan 2022 at 17:33, James Clark <james.clark@arm.com> wrote:
>>
>> It's impossible to program a valid value for TRCCONFIGR.QE
>> when TRCIDR0.QSUPP==0b10. In that case the following is true:
>>
>>   Q element support is implemented, and only supports Q elements without
>>   instruction counts. TRCCONFIGR.QE can only take the values 0b00 or 0b11.
>>
>> Currently the low bit of QSUPP is checked to see if the low bit of QE can
>> be written to, but as you can see when QSUPP==0b10 the low bit is cleared
>> making it impossible to ever write the only valid value of 0b11 to QE.
>> 0b10 would be written instead, which is a reserved QE value even for all
>> values of QSUPP.
>>
>> The fix is to allow writing the low bit of QE for any non zero value of
>> QSUPP.
>>
>> This change doesn't go any further to validate if the user supplied value
>> is valid, because none of the other parts this function do, but it does fix
>> the case where it was impossible to ever set a valid value.
>>
> 
> I concur that the input is not checked as valid, However all the other
> fields are single bit - with no invalid values - other than the cond
> field, which controls tracing of non-branch conditionals -
> architecturally unsupported for A profile in ETMv4/.
> 
> 
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> index a0640fa5c55b..a99bb537ea23 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> @@ -368,7 +368,7 @@ static ssize_t mode_store(struct device *dev,
>>         /* start by clearing QE bits */
>>         config->cfg &= ~(BIT(13) | BIT(14));
>>         /* if supported, Q elements with instruction counts are enabled */
>> -       if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
>> +       if ((mode & BIT(0)) && drvdata->q_support)
>>                 config->cfg |= BIT(13);
> 
> This can be trivially changed to
> 
> if ((mode)  && drvdata->q_support)
>          config->cfg |= BIT(13);
> 
> to ensure that any input mode 2'b01, 2'b10, 2'b11 results in output
> settings of 2'b01, 2'b11, 2'b11 respectively
> 
> With that
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 

Thanks for the review. Can I also get your opinion about this one? At the very least
I think the comment is not detailed enough, but I also think that case 0 should set
BIT(0) rather than BIT(1). Or is there some edge case and it's correct?


	/* start by clearing all instruction event enable bits */
	config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
	switch (drvdata->nr_event) {
	case 0x0:
		/* generate Event element for event 1 */
		config->eventctrl1 |= val & BIT(1);
		break;
	case 0x1:
		/* generate Event element for event 1 and 2 */
		config->eventctrl1 |= val & (BIT(0) | BIT(1));
		break;
	case 0x2:
		/* generate Event element for event 1, 2 and 3 */
		config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
		break;
	case 0x3:
		/* generate Event element for all 4 events */
		config->eventctrl1 |= val & 0xF;
		break;
	default:
		break;
	}


>>         /*
>>          * if supported, Q elements with and without instruction
>> --
>> 2.17.1
>>
> 
> 
