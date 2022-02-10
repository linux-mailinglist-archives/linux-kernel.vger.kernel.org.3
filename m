Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A64B1427
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiBJRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:25:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiBJRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:25:49 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB66F35;
        Thu, 10 Feb 2022 09:25:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t199so6630946oie.10;
        Thu, 10 Feb 2022 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ZzQLRA529c8v0/ktUR9ubxLZZnMsnudAGSkCkWSNYU=;
        b=Zgy0FwO4r/yRkObrgRwp+/k58uO+g11tCJPTeIdvQ5nWwT6s97jZzvV1KwzBdOSb9O
         83Aig/9QvlUq7vVUGf+CDQf+5S2GrUgFlN1oHPe/320tXnSLqZfOb6KLIKhtnJ9UABpp
         vlbwXN/sNG58fyk2d7msZ1WYpKfQzopPGwWVhCvzNBCjppTzAp70B5Ro0sn/IheYkpgW
         tfs+PH1UjeLMVB7pozyZzvpXf1YQIx65utJCvCCMeIAa2TqsqI0VkRdOc5LF6+QUhNoK
         VFns9YeOzGqlhDPDhOn6+zEapbtTnZdrbwIWy52PEIkWovYsbK9YpEQQMqYiKIBivpkq
         E+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7ZzQLRA529c8v0/ktUR9ubxLZZnMsnudAGSkCkWSNYU=;
        b=mVnhTDRYEjK9hVqdodOpbdWB5ih0Qw/EAzoXhHEPFXtWw+Jt0/Qq0G6yUQC26IRcCF
         K3/zSs5oXFzPhWxjDlf/vXfc1spBSpSlWAHu5AZN2B0PDvYSCIPs+5bi8pPXgLeu13B3
         JZVwCb03NO1zhEvmHhMrjVoasObbAY1z/9rAYKmcvr4kDpW0aAtMhv67weikh5gStwuf
         +cLSWPxnlKXTw9pIQ51j6WejSdzhKW+BXU0ucVBiG/wm/PIHyatePMpQaPy6M3nyXTHF
         rEbVQVDeEa8ikHr8qw8SUbgMbuYUz4vqlsc6j4bKaRQUBuuG8GQtxATV/jLiEkoUYqfa
         1MvA==
X-Gm-Message-State: AOAM533fDgWxnlWfjijhAm1hdFQZuIPVedIttgYwt8y6tNcZoGwwxmJq
        mS17ig7OS01mWSho2t22Y4Qwfqj4VJoCQw==
X-Google-Smtp-Source: ABdhPJyeiX14MvY0TtdflYuvC3qLlg92KhzCDQnEsq/fpzmnUIXZ8eBKkZNp17tTZd+IpbWxXTqp6A==
X-Received: by 2002:a05:6808:3085:: with SMTP id bl5mr1425884oib.300.1644513949739;
        Thu, 10 Feb 2022 09:25:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4sm7982257otk.39.2022.02.10.09.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:25:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91104ef8-de89-aeb3-91ef-8925260e8782@roeck-us.net>
Date:   Thu, 10 Feb 2022 09:25:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: (pmbus) Clear pmbus fault/warning bits before read
Content-Language: en-US
To:     Vikash Chandola <vikash.chandola@linux.intel.com>,
        iwona.winiarska@intel.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210124154.1304852-1-vikash.chandola@linux.intel.com>
 <46684682-a718-ca9a-b502-2031afd3a756@roeck-us.net>
 <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <6b5b3d5b-68c9-3f04-d9b7-b58951f5557a@linux.intel.com>
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

On 2/10/22 07:57, Vikash Chandola wrote:
> 
> 
> On 2/10/2022 8:14 PM, Guenter Roeck wrote:
>> On 2/10/22 04:41, Vikash Chandola wrote:
>>> pmbus fault and warning bits are not cleared by itself once fault/warning
>>> condition is not valid anymore. As per pmbus datasheet faults must be
>>> cleared by user.
>>> Modify hwmon behavior to clear latched status bytes if any bit in status
>>> register is high prior to returning fresh data to userspace. If
>>> fault/warning conditions are still applicable fault/warning bits will be
>>> set and we will get updated data in second read.
>>>
>>> Hwmon behavior is changed here. Now sysfs reads will reflect latest
>>> values from pmbus slave, not latched values.
>>> In case a transient warning/fault has happened in the past, it will no
>>> longer be reported to userspace.
>>>
>>
>>
>> NACK.
>>
>> Reporting that information is exactly the point of the current code.
>> We _do_ want to report at least once that a problem occurred in the past,
>> and only clear the warning flag(s) afterwards.
>>
>> Guenter
>>
> But as per current implementation we will continue to report fault even after fault condition is cleared. I could not find sysfs entry or any other means by which user/kernel can clear the faults/warnings after it is reported. Please point if I am missing anything.
> 

Normally a chip should clear the status after the fault condition cleared
and the register was read. At least that was my experience so far.
What chip (or chips) don't do that ?

Guenter

>>> Signed-off-by: Vikash Chandola <vikash.chandola@linux.intel.com>
>>> ---
>>>   drivers/hwmon/pmbus/pmbus_core.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>> index 776ee2237be2..1cc82d644079 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -577,6 +577,15 @@ static int pmbus_get_status(struct i2c_client *client, int page, int reg)
>>>           break;
>>>       default:
>>>           status = _pmbus_read_byte_data(client, page, reg);
>>> +        if (status > 0) {
>>> +            /*
>>> +             * Status greater than 0 could mean that there was a fault/warning.
>>> +             * Clear faults and do a second read to make sure we are not getting
>>> +             * stale values.
>>> +             */
>>> +            pmbus_clear_fault_page(client, page);
>>> +            status = _pmbus_read_byte_data(client, page, reg);
>>> +        }
>>>           break;
>>>       }
>>>       if (status < 0)
>>

