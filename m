Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242804B153E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbiBJS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:29:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBJS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:29:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF1CED;
        Thu, 10 Feb 2022 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644517782; x=1676053782;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PPeLzYV91B+6Mxqp0GoY4YF9X1EhbWjWryKYK6RFh+A=;
  b=iDk56/caHl9f5ae8zyb/TKJnfdlsNH/8uGbWLUl6VNmGknapmF1puOx3
   UwsIJ6wDyW+X2NRHmhKbOSkWSSVILJXMbKscwtkUTkC3fGJ7OMzn+oTQj
   BD7Q+WM6efghANifGz6uGhkMBESzoFgEvewMPOX57A7UuuR59nCow8+4F
   xiZtRciXCgofWYIWLWKVHsVoqWd0crIVIdCYYbZeL3YfipG6OTi3Vj25h
   9O0imOu35wSJfoYl96K3yGhN1ylGGYxzW+mqm8jjsrEVoCuyYdLuYOQd+
   T7k3kPVskCXMxsZra1sNYwQOyUkvOowA7XnLVUVfwEVz3zuP8FO6hVUbk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="310298028"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="310298028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:29:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="541736917"
Received: from vchandol-mobl.gar.corp.intel.com (HELO [10.215.123.92]) ([10.215.123.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:29:34 -0800
Message-ID: <56283791-4b82-ad66-174b-49f717d224eb@linux.intel.com>
Date:   Thu, 10 Feb 2022 23:59:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, iwona.winiarska@intel.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
 <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
 <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
 <91104ef8-de89-aeb3-91ef-8925260e8782@roeck-us.net>
From:   Vikash Chandola <vikash.chandola@linux.intel.com>
In-Reply-To: <91104ef8-de89-aeb3-91ef-8925260e8782@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2022 10:55 PM, Guenter Roeck wrote:
> On 2/10/22 07:57, Vikash Chandola wrote:
>>
>>
>> On 2/10/2022 8:14 PM, Guenter Roeck wrote:
>>> On 2/10/22 04:41, Vikash Chandola wrote:
>>>> pmbus fault and warning bits are not cleared by itself once 
>>>> fault/warning
>>>> condition is not valid anymore. As per pmbus datasheet faults must be
>>>> cleared by user.
>>>> Modify hwmon behavior to clear latched status bytes if any bit in 
>>>> status
>>>> register is high prior to returning fresh data to userspace. If
>>>> fault/warning conditions are still applicable fault/warning bits 
>>>> will be
>>>> set and we will get updated data in second read.
>>>>
>>>> Hwmon behavior is changed here. Now sysfs reads will reflect latest
>>>> values from pmbus slave, not latched values.
>>>> In case a transient warning/fault has happened in the past, it will no
>>>> longer be reported to userspace.
>>>>
>>>
>>>
>>> NACK.
>>>
>>> Reporting that information is exactly the point of the current code.
>>> We _do_ want to report at least once that a problem occurred in the 
>>> past,
>>> and only clear the warning flag(s) afterwards.
>>>
>>> Guenter
>>>
>> But as per current implementation we will continue to report fault 
>> even after fault condition is cleared. I could not find sysfs entry or 
>> any other means by which user/kernel can clear the faults/warnings 
>> after it is reported. Please point if I am missing anything.
>>
> 
> Normally a chip should clear the status after the fault condition cleared
> and the register was read. At least that was my experience so far.
> What chip (or chips) don't do that ?
> 
> Guenter

I see that pmbus spec says that once fault/warning bits are set
they won't be cleared by itself. Section 10.2.3 of
"PMBus Specification Rev. 1.3.1 Part II 2015-03-13" from
https://pmbus.org/specification-archives/   says

"
Almost all of the warning or fault bits set in the status registers 
remain set, even if the fault or warning condition is removed
or corrected, until one of the following occur:
* The bit is individually cleared (Section 10.2.4),
* The device receives a CLEAR_FAULTS command (Section 15.1),
* A RESET signal (if one exists) is asserted,
* The output is commanded through the CONTROL pin, the OPERATION 
command, or the combined action of the CONTROL pin and OPERATION
command, to turn off and then to turn back on, or
* Bias power is removed from the PMBus device...
"

 From this I concluded that slave(PSU) following pmbus spec will not
clear the fault/warning in status registers.
I don't have exact chip details handy but I can get it by tomorrow.
However this looks to be issue not related to specific chip ?

If this is a problem, how should I approach this ? Shall I create a new
sysfs entry that user space application can invoke and clear all faults
or provide sysfs entry to clear individual fault/warning bits or
something else ?

> 
>>>> Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>
>>>> ---
>>>>   drivers/hwmon/pmbus/pmbus_core.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c 
>>>> b/drivers/hwmon/pmbus/pmbus_core.c
>>>> index 776ee2237be2..1cc82d644079 100644
>>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>>> @@ -577,6 +577,15 @@ static int pmbus_get_status(struct i2c_client 
>>>> *client, int page, int reg)
>>>>           break;
>>>>       default:
>>>>           status = _pmbus_read_byte_data(client, page, reg);
>>>> +        if (status > 0) {
>>>> +            /*
>>>> +             * Status greater than 0 could mean that there was a 
>>>> fault/warning.
>>>> +             * Clear faults and do a second read to make sure we 
>>>> are not getting
>>>> +             * stale values.
>>>> +             */
>>>> +            pmbus_clear_fault_page(client, page);
>>>> +            status = _pmbus_read_byte_data(client, page, reg);
>>>> +        }
>>>>           break;
>>>>       }
>>>>       if (status < 0)
>>>
> 

-- 
Vikash
