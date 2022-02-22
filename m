Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218E4BF924
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiBVNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBVNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:21:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B2154D19;
        Tue, 22 Feb 2022 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645536072; x=1677072072;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LlDTmjwS1WHEhK9J84iLZY/ntYEVzCRnQKxmqUeWpr8=;
  b=YdtDwRHFcszOmnX4VnOOQUO8XWYR5gaO0Lf4oeuuCvh/TMklaMvYnUWV
   wdhJjgxMjG65z1YN5QFP4COQo7XIk6LCfJUrgaRqmVSe7E+MegeyJ8ao7
   Qf8WFi3mCQzwLhi85eAr7nQg0cCAk+GYtmi66+lXy/8N27bd22tRx+l06
   ZNq6N1eUwlMp48Re1uZxSt3XS1wE8aGdNl+UWPWY4ZvywlDT4hWjvUmQQ
   +HcEIBoS2/Eh+eeAObu1QBEsPFQhdy0PIKFJqyC4ja1OSizxmzTM2P/TD
   fumIudtBzZ9u0oRGz8LA4FPoOsLvSzItOT33M9ejkRlW3wfgjlzRj2MuK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276300640"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276300640"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:21:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="507983334"
Received: from vchandol-mobl.gar.corp.intel.com (HELO [10.252.64.244]) ([10.252.64.244])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:21:09 -0800
Message-ID: <4dec1984-b406-7b54-7f8e-7ac93d4eb6f0@linux.intel.com>
Date:   Tue, 22 Feb 2022 18:50:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, iwona.winiarska@intel.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
 <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
 <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
 <91104ef8-de89-aeb3-91ef-8925260e8782@roeck-us.net>
 <56283791-4b82-ad66-174b-49f717d224eb@linux.intel.com>
 <ea859778-92ba-ce22-7c17-4a891d5466e8@roeck-us.net>
 <cfc47708-26a3-8836-2eef-5b5bfb809e71@roeck-us.net>
From:   Vikash Chandola <vikash.chandola@linux.intel.com>
In-Reply-To: <cfc47708-26a3-8836-2eef-5b5bfb809e71@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2022 1:27 AM, Guenter Roeck wrote:
> On 2/10/22 11:55, Guenter Roeck wrote:
>> On 2/10/22 10:29, Vikash Chandola wrote:
>>>
>>>
>>> On 2/10/2022 10:55 PM, Guenter Roeck wrote:
>>>> On 2/10/22 07:57, Vikash Chandola wrote:
>>>>>
>>>>>
>>>>> On 2/10/2022 8:14 PM, Guenter Roeck wrote:
>>>>>> On 2/10/22 04:41, Vikash Chandola wrote:
>>>>>>> pmbus fault and warning bits are not cleared by itself once 
>>>>>>> fault/warning
>>>>>>> condition is not valid anymore. As per pmbus datasheet faults 
>>>>>>> must be
>>>>>>> cleared by user.
>>>>>>> Modify hwmon behavior to clear latched status bytes if any bit in 
>>>>>>> status
>>>>>>> register is high prior to returning fresh data to userspace. If
>>>>>>> fault/warning conditions are still applicable fault/warning bits 
>>>>>>> will be
>>>>>>> set and we will get updated data in second read.
>>>>>>>
>>>>>>> Hwmon behavior is changed here. Now sysfs reads will reflect latest
>>>>>>> values from pmbus slave, not latched values.
>>>>>>> In case a transient warning/fault has happened in the past, it 
>>>>>>> will no
>>>>>>> longer be reported to userspace.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> NACK.
>>>>>>
>>>>>> Reporting that information is exactly the point of the current code.
>>>>>> We _do_ want to report at least once that a problem occurred in 
>>>>>> the past,
>>>>>> and only clear the warning flag(s) afterwards.
>>>>>>
>>>>>> Guenter
>>>>>>
>>>>> But as per current implementation we will continue to report fault 
>>>>> even after fault condition is cleared. I could not find sysfs entry 
>>>>> or any other means by which user/kernel can clear the 
>>>>> faults/warnings after it is reported. Please point if I am missing 
>>>>> anything.
>>>>>
>>>>
>>>> Normally a chip should clear the status after the fault condition 
>>>> cleared
>>>> and the register was read. At least that was my experience so far.
>>>> What chip (or chips) don't do that ?
>>>>
>>>> Guenter
>>>
>>> I see that pmbus spec says that once fault/warning bits are set
>>> they won't be cleared by itself. Section 10.2.3 of
>>> "PMBus Specification Rev. 1.3.1 Part II 2015-03-13" from
>>> https://pmbus.org/specification-archives/   says
>>>
>>> "
>>> Almost all of the warning or fault bits set in the status registers 
>>> remain set, even if the fault or warning condition is removed
>>> or corrected, until one of the following occur:
>>> * The bit is individually cleared (Section 10.2.4),
>>> * The device receives a CLEAR_FAULTS command (Section 15.1),
>>> * A RESET signal (if one exists) is asserted,
>>> * The output is commanded through the CONTROL pin, the OPERATION 
>>> command, or the combined action of the CONTROL pin and OPERATION
>>> command, to turn off and then to turn back on, or
>>> * Bias power is removed from the PMBus device...
>>> "
>>>
>>>  From this I concluded that slave(PSU) following pmbus spec will not
>>> clear the fault/warning in status registers.
>>> I don't have exact chip details handy but I can get it by tomorrow.
>>> However this looks to be issue not related to specific chip ?
>>>
>>
>> Good point. Interesting that I have not seen this before.
>>
>>> If this is a problem, how should I approach this ? Shall I create a new
>>> sysfs entry that user space application can invoke and clear all faults
>>> or provide sysfs entry to clear individual fault/warning bits or
>>> something else ?
>>>
>>
>> No. What we need to do is to add code to pmbus_get_boolean() and 
>> selectively
>> write the reported status bit back into the status register. Something 
>> like
>>      ...
>>      regval = status & mask;
>>      if (regval) {
>>          ret = pmbus_write_status(client, page, reg, regval);
>>                        ^^^^^^^^^^^^^^^^^^ new function
>>          if (ret)
>>              goto unlock;
>>      }
>>
>> and that will need to be tested on a variety of real hardware.
Hi Guenter,
I see that there is already a method pmbus_write_byte_data that does
same thing. I will post patch using that method to update one bit.
>>
> 
> Plus, of course, we need to confirm that there is at least one chip which
> does follow the specification and does not auto-clear alarms.
We observed above behavior SOLUM G36234-015 PSU.
Apologies for delay. It took some time to get information from our PSU
experts that PSU firmware itself is not broken here.
> 
> Guenter

-- 
Vikash
