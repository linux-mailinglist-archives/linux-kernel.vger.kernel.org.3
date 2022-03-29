Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5574EB6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiC2Xkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2Xks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:40:48 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.47.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B862F6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:39:04 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 01201400C36C4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:39:04 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZLOZnU9FBRnrrZLOZnf35L; Tue, 29 Mar 2022 18:37:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s6j/BhgIkwBUzXe+DvwFH/oKdI/HQ5L9CcN/nCwmPoo=; b=yv2b13u2GyeOm/0Fnctklxkctt
        6bDiqvkeSvt2XVQM8bzPttH9oL8xUVHKY1gm1IIVOMmOCgKaWDxGmwW2pSU96FvfSUrHMaA0sf7RQ
        k1ZSkkpGmJJuWFfXxsE+fU9G2D/8PVmlmjsdTppTH8ExU0pohnyeEdtZm4bYcsBrBw3KuMaW9gOhs
        NWW02Ld+b4jHWiaXSJ3Z/+lj/VmGDiBR0on1GzuYlQcitjNz8yHBKrEfJYnPpdWwe3WcBdIGTTRAZ
        1FTcfvZNaJRM0V38zmDfgMke//xpnUnPVkHlk/DfZ1lJk8qEfPGDuI+RQYX8pCDEFYreoBzWvYlDZ
        XWmpjF2g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54548)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZLOZ-0010Uk-Dv; Tue, 29 Mar 2022 23:37:03 +0000
Message-ID: <fef5c154-2b1b-0a2b-52c3-c3fe0b4c2abf@roeck-us.net>
Date:   Tue, 29 Mar 2022 16:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com>
 <df43bce6-b1bc-1abc-307b-878ee7acb261@roeck-us.net>
 <CAB95QASgzUSaLjZuxWauiSvNK7Or=1Kz8htJcjWqU+HrRutvJg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QASgzUSaLjZuxWauiSvNK7Or=1Kz8htJcjWqU+HrRutvJg@mail.gmail.com>
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
X-Exim-ID: 1nZLOZ-0010Uk-Dv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54548
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

On 3/29/22 15:11, Eugene Shalygin wrote:
> On Tue, 29 Mar 2022 at 23:23, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> +/* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
>>> +#define ACPI_GLOBAL_LOCK_PSEUDO_PATH ":GLOBAL_LOCK"
>>> +
>>
>> That needs to be documented.
> 
> Do you mean a note in the /Documentation/..../...rst or adding details
> here? There is an additional bit of information on this identifier
> below, in the ec_board_info struct declaration.
> 
My understanding was that the user would/could request its use via
the module parameter, so it needs to be documented in the rst file.

>> There is some type confusion in the above lock functions. Some return
>> ACPI error codes, some return Linux error codes. Please make return
>> values consistent.
>>
>> Also, why use mutex_trylock() instead of mutex_lock() ? This is
>> unusual since it will result in errors if more than one user
>> tries to access the data (eg multiple processes reading sysfs
>> attributes at the same time), and thus warrants a detailed
>> explanation.
> OK.
> 
>>> +     struct lock_data lock_data;
>>> +     /* number of board EC sensors */
>>> +     u8 nr_sensors;
>>
>> Ok, I must admit I am more than a bit lost. In patch 1/4
>> you removed this variable (and argued that removing it was
>> for "deduplication"), only to re-introduce it here.
>> Sorry, I don't follow the logic.
> 
> Sorry for that. This is my mistake which I tried to warn you about in
> my first reply to the email with this patch.
> 
>>> +     if (!mutex_path || !strlen(mutex_path)) {
>>
>> When would mutex_path be NULL ?
> When it is set to NULL in the board definition struct ec_board_info.
> 

Are there any such board definitions ? I don't recall seeing any.

Thanks,
Guenter

>>> +             if (ACPI_FAILURE(status)) {
>>> +                     dev_err(dev,
>>> +                             "Failed to get hardware access guard AML mutex"
>>> +                             "'%s': error %d",
>>
>> Please no string splits. And the negative impact can be seen here:
>> No space between "mutex" and "'%s'".
> 
> Yes, of course.
> 
>>>                dev_warn(dev,
>>> -                     "Concurrent access to the ACPI EC detected.\nRace condition possible.");
>>> +                     "Concurrent access to the ACPI EC detected.\n"
>>> +                     "Race condition possible.");
>>
>> Why this change, and how is it related to this patch ?
> Same as above, will be corrected.
> 
> Thank you,
> Eugene

