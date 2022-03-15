Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC74D9F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349870AbiCOP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiCOP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:58:36 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D55621E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:57:23 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 6831C36805
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:57:22 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id U9Y1nnMeNHnotU9Y1n1jNk; Tue, 15 Mar 2022 10:57:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4kVQ5GrJXG+XQBsvd7Sp5sVbbiDsI2CU7Suxb3igK0Y=; b=BgE5ldmEA5kL55GjjYn0qoCSBS
        uzkhZwoTd3UhUSPUXrcmg0M6e/tN27lE4hmgbyRSfBYIHwxwBMIAQg/0GVgHB6MhR68kxCChPqUNR
        H4c31oTWcAKkkLt+DJ6Fu851wJ/50Bb3pmq8UwU0Y4Zm+5zrLxrY8I2zt4mGWwJdrS4eGc5nyxl6h
        M1hS9JFJmWoOttURimuRiJaqliU0lHvsx+Mno5/ssLy41hCryDhlG1XPmmeaqHcCpvTpLOfiS3OrP
        q0c8FaCT9aN2VRle5vYhAjPgMdWC3Uu5Ksj9NriODyFedvgemG1dZOnfzBx13Z2+zyFJDeZFrRoHc
        hO03RsGQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54280)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nU9Y1-001qgu-Fy; Tue, 15 Mar 2022 15:57:21 +0000
Message-ID: <7e85a7fc-46d9-ae6a-25b1-5554e49a8f76@roeck-us.net>
Date:   Tue, 15 Mar 2022 08:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <51ea03f0-627b-2e9d-5972-2053fa12b9b5@nokia.com>
 <3dac349c-6470-1673-effb-354da2b52481@roeck-us.net>
 <292b2a9c-1f31-c3e3-753b-65a05d341574@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
In-Reply-To: <292b2a9c-1f31-c3e3-753b-65a05d341574@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nU9Y1-001qgu-Fy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54280
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Agathe,

On 3/15/22 06:03, Agathe Porte wrote:
> Hi Guenter,
> 
> Le 3/15/2022 à 2:22 AM, Guenter Roeck a écrit :
>> If of_property_read_string() returns an error, it will not set the pointer
>> to &data->channel[channel].label, which by default is NULL because the
>> data structure was allocated with devm_kzalloc(). That means tmp464_is_visible()
>> will disable the label attribute. I don't see a problem with the current
>> code.
> 
> Thanks for the explanation. I agree that there is no problem on this point.
> 
>> There are lots of examples in the kernel where the return value from
>> of_property_read_string() is silently ignored. Not a single one of
>> those uses a (void) typecast. I don't really want to start making
>> such changes just to make static analyzers happy.
> 
> I have to disagree here. Because something has always (not) be done in the past should not be a reason to (not) do it in the future out of pure habit. I did not suggest to add the (void) casts in existing code: I agree it would be a burden with no real added value.
> 
> But making static analyzers happy seems justified *for new code*. It also makes *other developers* more confident, because with the cast we are sure that not checking the return value is very intentional.
> 
> Please enlighten me if there are any downsides that I did not think of and that would block this one-line change.
> 

Changing the code now would require either a separate patch or
a rebase of the hwmon-next tree. Rebasing the hwmon-next tree
at this point of the release cycle (a few days before the commit
window opens) is something I really don't want to do, leaving the
option to add a separate patch for the change. That makes it
identical to changing existing code to add the (void).

In addition to that, I do not agree that adding (void) really
adds value here; it just says "this is done on purpose" because
the static analyzer doesn't know better. 0-day stopped reporting
this kind of perceived problem, presumably for good reason.
Since the result of the function call is implied in setting or not
setting the passed pointer, a return value check or adding (void)
is not warranted. This would be different if the property was mandatory,
but that is not the case here.

There are lots of other functions in the kernel where return values
are not checked, for a variety of reasons. Functions where checking
the return value is necessary/mandatory are tagged with __must_check.
For others it is left to the caller to decide if a return value
should be checked, and if it makes sense / adds value to add (void).

I'll give you another example: cancel_work_sync() and related functions.
I am sure your static analyzer will complain about the failure to check
its return value in almost all cases. A counter-example is, say,
platform_driver_register(), where the return value should really be
checked and a (void) typecast should be used if it is not checked on
purpose. The problem is that static analyzers can not determine if
the return value check is necessary, and should either leave it alone
or make reports conditional on some command line option.

Overall we'll have to agree to disagree.

Thanks,
Guenter
