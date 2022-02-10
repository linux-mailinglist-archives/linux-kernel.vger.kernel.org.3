Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6154B169A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiBJTzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:55:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiBJTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:55:19 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2F2FE4;
        Thu, 10 Feb 2022 11:55:19 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so7710570ooi.2;
        Thu, 10 Feb 2022 11:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=He0CkM3K84rAZ1/3JojcQid/MBuHRjAjsDa582tYvNM=;
        b=cL4NVbQNQ4lle47SSQLcJEZFcyUNlx95izWqE0vAyR6RC1pj6Yc4QWIbDKPSzjwl+V
         GPEuOu4KAEcYySDJW65qp6fJ4hDIln/bU/CSJAeT0Uvu8zf2pwBSgnoyMtR27ynSt6R7
         Ptds/U363Kqbh4kaBPgcv96hXIkEcKhgAXbPZkLof3dSqsqD7Ipyer2Xs3Xw9Mwj6Iw7
         6h5+eOtJ9HAuBGASVqHtGdvpFaeXxiLB7roWQd6K64ALESJSMy68GmFXnTnKo1QyAA8q
         3J+Srwa/P5BF4LhxheZK3yZHKz7mrmwssMZ5VogxqMwMbbi8wRyd4gsZsHUqYpb6VfXP
         ybCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=He0CkM3K84rAZ1/3JojcQid/MBuHRjAjsDa582tYvNM=;
        b=tIU771u5UjN27+A/RUCm22NLkxu9iln9jBbRsiXvw4nKBK2uMSLnmAUh7Jc5yybuey
         OpMmhCLgMMDmyZOahTbFZylz8gsySe6GobiJES3Z/esC8uc6wzYbpYsF1mVOqe2Ht7ft
         oEkP+UpwV61liS5wBq0FMSeZCXsrYr3u25mVTERDEp+BF9uSDtZZ4Bnj4YvgiBQe3ocK
         DMfkqsc43+4qBsyT7QL1vO2OSti9GFAodmyZ8htipkYjErJzcCNnZH1d/1GCjgOG8Svz
         ac5N3cMktDBAXW9DwvLJcoY1g0+HYg6cSfB1SfInyogy1PJ11JLLd9b6d8mJZjdqL5Ty
         vmhw==
X-Gm-Message-State: AOAM533qpSji5BbQUkUea0JBlKqpDMAjxAVJka/kXOPRRe0tw22OR6po
        RHYoPw2h0F9wZSmMQFmZugc=
X-Google-Smtp-Source: ABdhPJwF33MBfV9If1DfZl8KvA7Gv9nChP3u0Lkw1T8skPm2tS18Et6gdD3UDYSkvyQDparKh5WRfg==
X-Received: by 2002:a05:6871:400d:: with SMTP id kx13mr1325458oab.263.1644522918977;
        Thu, 10 Feb 2022 11:55:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm8356318otl.41.2022.02.10.11.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 11:55:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea859778-92ba-ce22-7c17-4a891d5466e8@roeck-us.net>
Date:   Thu, 10 Feb 2022 11:55:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Vikash Chandola <vikash.chandola@linux.intel.com>,
        iwona.winiarska@intel.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
 <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
 <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
 <91104ef8-de89-aeb3-91ef-8925260e8782@roeck-us.net>
 <56283791-4b82-ad66-174b-49f717d224eb@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
In-Reply-To: <56283791-4b82-ad66-174b-49f717d224eb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 10:29, Vikash Chandola wrote:
> 
> 
> On 2/10/2022 10:55 PM, Guenter Roeck wrote:
>> On 2/10/22 07:57, Vikash Chandola wrote:
>>>
>>>
>>> On 2/10/2022 8:14 PM, Guenter Roeck wrote:
>>>> On 2/10/22 04:41, Vikash Chandola wrote:
>>>>> pmbus fault and warning bits are not cleared by itself once fault/warning
>>>>> condition is not valid anymore. As per pmbus datasheet faults must be
>>>>> cleared by user.
>>>>> Modify hwmon behavior to clear latched status bytes if any bit in status
>>>>> register is high prior to returning fresh data to userspace. If
>>>>> fault/warning conditions are still applicable fault/warning bits will be
>>>>> set and we will get updated data in second read.
>>>>>
>>>>> Hwmon behavior is changed here. Now sysfs reads will reflect latest
>>>>> values from pmbus slave, not latched values.
>>>>> In case a transient warning/fault has happened in the past, it will no
>>>>> longer be reported to userspace.
>>>>>
>>>>
>>>>
>>>> NACK.
>>>>
>>>> Reporting that information is exactly the point of the current code.
>>>> We _do_ want to report at least once that a problem occurred in the past,
>>>> and only clear the warning flag(s) afterwards.
>>>>
>>>> Guenter
>>>>
>>> But as per current implementation we will continue to report fault even after fault condition is cleared. I could not find sysfs entry or any other means by which user/kernel can clear the faults/warnings after it is reported. Please point if I am missing anything.
>>>
>>
>> Normally a chip should clear the status after the fault condition cleared
>> and the register was read. At least that was my experience so far.
>> What chip (or chips) don't do that ?
>>
>> Guenter
> 
> I see that pmbus spec says that once fault/warning bits are set
> they won't be cleared by itself. Section 10.2.3 of
> "PMBus Specification Rev. 1.3.1 Part II 2015-03-13" from
> https://pmbus.org/specification-archives/   says
> 
> "
> Almost all of the warning or fault bits set in the status registers remain set, even if the fault or warning condition is removed
> or corrected, until one of the following occur:
> * The bit is individually cleared (Section 10.2.4),
> * The device receives a CLEAR_FAULTS command (Section 15.1),
> * A RESET signal (if one exists) is asserted,
> * The output is commanded through the CONTROL pin, the OPERATION command, or the combined action of the CONTROL pin and OPERATION
> command, to turn off and then to turn back on, or
> * Bias power is removed from the PMBus device...
> "
> 
>  From this I concluded that slave(PSU) following pmbus spec will not
> clear the fault/warning in status registers.
> I don't have exact chip details handy but I can get it by tomorrow.
> However this looks to be issue not related to specific chip ?
> 

Good point. Interesting that I have not seen this before.

> If this is a problem, how should I approach this ? Shall I create a new
> sysfs entry that user space application can invoke and clear all faults
> or provide sysfs entry to clear individual fault/warning bits or
> something else ?
> 

No. What we need to do is to add code to pmbus_get_boolean() and selectively
write the reported status bit back into the status register. Something like
	...
	regval = status & mask;
	if (regval) {
		ret = pmbus_write_status(client, page, reg, regval);
                       ^^^^^^^^^^^^^^^^^^ new function
		if (ret)
			goto unlock;
	}

and that will need to be tested on a variety of real hardware.

Guenter
