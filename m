Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976844DCE91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiCQTPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiCQTPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:15:49 -0400
X-Greylist: delayed 1416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 12:14:32 PDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.196.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85E182DB9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:14:32 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 1CB9B49B2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:50:56 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id UvD5ncm5Mb6UBUvD5nzVXr; Thu, 17 Mar 2022 13:50:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bliZfqMjbtUe+Z7mtVzrTV+GXBLNQtnwAl5kZnYyJB4=; b=CL8exiWLR7XrnVE+ojkZHH+O6l
        sOJmq8EkwYGUH2xuXE7Do8lfaqhGpiYv17psO8UtbBo5EsUHhLLEndTzltEUsR7oRVjDdsZCazuYT
        mAI3KeuvD+lmeudaYPnpweZI53bLhfFKV434sex3m+Ur4ojLymm6PwqBEZ8iqK8QX3KHhHG8PHwoF
        3SoUKAsw73BFIw6ctbZNTgdYUIUX4mjS81rgW7adhEPjkr1UWeD2voY3iZVskHbFJPUhfbYTNTka4
        3O+vNDBvsF4PA9WVyt1W1f2RkbVXnPqyTlv0O+xQiKmX2vRcqcb6gMdZkRiHVaZ0N0OV/zm2TjJG9
        fO90E1aQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54314)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nUvD5-0038xc-Gk; Thu, 17 Mar 2022 18:50:55 +0000
Message-ID: <b284838a-6987-273c-ce00-592aa9ab51b2@roeck-us.net>
Date:   Thu, 17 Mar 2022 11:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220311181014.3448936-1-bjwyman@gmail.com>
 <fa8b2d9f-e5c9-73f4-3916-84e370748687@roeck-us.net>
 <CAK_vbW2S07+S8+PrQnBLjvXYnLBXU06FHBvfM2zaT6RYx9HO+g@mail.gmail.com>
 <582086fe-1cc3-d161-a866-f4726d04a254@roeck-us.net>
 <CAK_vbW1Lfroo91cMxsLpuf-uuDwcsssG1=fjp3an_O5-FUHjMQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs
 entry
In-Reply-To: <CAK_vbW1Lfroo91cMxsLpuf-uuDwcsssG1=fjp3an_O5-FUHjMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nUvD5-0038xc-Gk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54314
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 09:12, Brandon Wyman wrote:
> On Wed, Mar 16, 2022 at 3:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/16/22 13:03, Brandon Wyman wrote:
>>> On Sun, Mar 13, 2022 at 11:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 3/11/22 10:10, Brandon Wyman wrote:
>>>>> Add a clear_faults write-only debugfs entry for the ibm-cffps device
>>>>> driver.
>>>>>
>>>>> Certain IBM power supplies require clearing some latched faults in order
>>>>> to indicate that the fault has indeed been observed/noticed.
>>>>>
>>>>
>>>> That is insufficient, sorry. Please provide the affected power supplies as
>>>> well as the affected faults, and confirm that the problem still exists
>>>> in v5.17-rc6 or later kernels - or, more specifically, in any kernel which
>>>> includes commit 35f165f08950 ("hwmon: (pmbus) Clear pmbus fault/warning
>>>> bits after read").
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> Sorry for the delay in responding. I did some testing with commit
>>> 35f165f08950. I could not get that code to send the CLEAR_FAULTS
>>> command to the power supplies.
>>>
>>> I can update the commit message to be more specific about which power
>>> supplies need this CLEAR_FAULTS sent, and which faults. It is observed
>>> with the 1600W power supplies (2B1E model). The faults that latch are
>>> the VIN_UV and INPUT faults in the STATUS_WORD. The corresponding
>>> STATUS_INPUT fault bits are VIN_UV_FAULT and Unit is Off.
>>>
>>
>> The point is that the respective fault bits should be reset when the
>> corresponding alarm attributes are read. This isn't about executing
>> a CLEAR_FAULTS command, but about selectively resetting fault bits
>> while ensuring that faults are reported at least once. Executing
>> CLEAR_FAULTS is a big hammer.
>>
>> With the patch I pointed to in place, input (and other) faults should
>> be reset after the corresponding alarm attributes are read, assuming
>> that the condition no longer exists. If that does not happen, we should
>> fix the problem instead of deploying the big hammer.
>>
>> Thanks,
>> Guenter
> 
> Okay, I see what you are pointing out there. I had been mostly looking
> at the "files" in the debugfs paths. Those do not end up running
> through that pmbus_get_boolean() function, so the individual fault
> clearing was not being attempted. The fault I was interested in
> appears to be associated with in1_lcrti_alarm. Reading that will give
> me a 1 if there is a VIN_UV fault, and then it sends 0x10 to
> STATUS_INPUT. That clears out VIN_UV, but the STATUS_INPUT command was
> returning 0x18. Nothing appears to handle clearing BIT(3), that 0x08
> mask.
> 
> Should there be some kind of define for BIT(3) over in pmbus.h?
> Something like PB_VOLTAGE_OFF? Somehow we need something using that in
> sbit of the attributes. I had a quick hack that just OR'ed BIT(3) with
> BIT(4) for that PB_VOLTAGE_UV_FAULT. That resulted in a clear of both
> bits in STATUS_INPUT, and the faults clearing in STATUS_WORD.
> 
> It is not clear if there should be a separate alarm for that "Unit Off
> For Insufficient Input Voltage", or if the one for in1_lcrit_alarm
> could just be the two bits OR'ed into one mask. I can send a patch
> with a proposal on how to fix this one bit not getting cleared.
> 

We don't have a separate standard attribute. I think the best approach
would be to add a mask for bit 3 and or that mask for lcrit in
vin_limit_attrs with PB_VOLTAGE_UV_FAULT. I'd suggest to name the
define something like PB_VOLTAGE_VIN_OFF or PB_VOLTAGE_VIN_FAULT
to clarify that the bit applies to the input.

Thanks,
Guenter
