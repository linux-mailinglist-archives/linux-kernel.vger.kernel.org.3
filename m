Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2346C99E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhLHA5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLHA5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:57:47 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459AC061574;
        Tue,  7 Dec 2021 16:54:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso1025587otf.12;
        Tue, 07 Dec 2021 16:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0id8lr27Q06PU0ZpfksKqJP2WnkqgACe0AiGg4Xx0wI=;
        b=LRTZy3Usv/yxMGkkU3vVXe2xdTw6ZK7nWOuKzcOSJLa8scWUdO4JuZJCim9gzjWHkM
         r6HibFj+gmpgUm58EyadhTY8mZTYDHJ3NSqHRuLoQ9DUeeVrWA2Jb+KyvYNH4uaotS7w
         5PZ302DFUabLNjyJPIV11HG2Yec7Z28oRDF46dT9sXbuBF/TbhAL/YAic1vvsjFQYHJN
         rBcToVEU8DLIsFSyTHFScV8Z/P2lkzcPuGPjKyjfXlEv72zAAXtCbMjnoFdLg7Owb2mz
         vSiIfXnqSmhlpBBQsIbJrO/rxuJTx6gj03HBhbRIpjE2mU6M7+aPBzyIFne8AEyhsuC6
         2I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0id8lr27Q06PU0ZpfksKqJP2WnkqgACe0AiGg4Xx0wI=;
        b=g0GlggfhYHG8eV349TMNoxda6OGT7swfHgHEt3li7T+sAcUj/DJSeEqqZ+NB6b38dX
         zJDf7piQ5J94CYZj+fFvmKvWSZlVbpxfWfkfX7XVg4pAKGk/xILpXvsVJmHCfuUOpZ/Q
         8HgXF+YTg2QFKB5qGfbuxChjmnYJaZST9wxxOmu5DJhwVJDprpBDo/7bNlE7Czdg9T2T
         4hot8s2Lu3ytyiz9yETVglqWd77tAtHmItXqn3cf8OW+/E7JKKgOMTeZMinFMRv5/8dt
         Sj37wrqXu5fZTt4uX+kOeIhE1MZGO8QI5BYIRTMzbvZ7bluOq65O3/YHFCI7Z3IiUI4a
         B6RQ==
X-Gm-Message-State: AOAM532EFiKcQ/0SE7VvqZhDQblll0ewNvuYats6R40qz0cwP8H1HC+a
        ucgH58/Y2PfjdjV4qA8Q8Kq/z7UisV4=
X-Google-Smtp-Source: ABdhPJzIeHjwc+t1GCi60tbcjBm1n9013QVL3AFYpf9QR72HC2whDKz7VRbOnFINzEG6v2uZB2NN/A==
X-Received: by 2002:a9d:2243:: with SMTP id o61mr38065777ota.126.1638924854916;
        Tue, 07 Dec 2021 16:54:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9sm224968oti.32.2021.12.07.16.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 16:54:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add Delta AHE-50DC fan control
 module driver
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-2-zev@bewilderbeest.net>
 <20211207175015.GA772416@roeck-us.net>
 <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
 <f30241ad-f3c4-ee78-22f3-405401615b61@roeck-us.net>
 <Ya/X46owU78iVbSO@hatter.bewilderbeest.net>
 <abc2e3bc-3806-dbd3-840c-e19154bc0587@roeck-us.net>
 <Ya//HhC8a1DmQQAx@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5846df4d-3d93-8894-5c1c-bbb415908b27@roeck-us.net>
Date:   Tue, 7 Dec 2021 16:54:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya//HhC8a1DmQQAx@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 4:41 PM, Zev Weiss wrote:
> On Tue, Dec 07, 2021 at 03:15:18PM PST, Guenter Roeck wrote:
>> On 12/7/21 1:53 PM, Zev Weiss wrote:
>>> On Tue, Dec 07, 2021 at 11:44:01AM PST, Guenter Roeck wrote:
>>>> On 12/7/21 11:22 AM, Zev Weiss wrote:
>>>>> On Tue, Dec 07, 2021 at 09:50:15AM PST, Guenter Roeck wrote:
>>>>>> On Mon, Dec 06, 2021 at 11:15:20PM -0800, Zev Weiss wrote:
>>>>>>> This device is an integrated module of the Delta AHE-50DC Open19 power
>>>>>>> shelf.  For lack of proper documentation, this driver has been developed
>>>>>>> referencing an existing (GPL) driver that was included in a code release
>>>>>>> from LinkedIn [1].  It provides four fan speeds, four temperatures, and
>>>>>>> one voltage reading, as well as a handful of warning and fault
>>>>>>> indicators.
>>>>>>>
>>>>>>> [1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>>>>>>
>>>>>>
>>>>>> Hmm, that reference isn't really accurate anymore. I think it would be
>>>>>> better to just say that the device was found to be PMBus compliant.
>>>>>
>>>>> Sure, will do.
>>>>>
>>>>
>>>> Makes me wonder: How do you know that the referenced driver is for Delta AHE-50DC ?
>>>
>>> We'd been waiting for the source code for the software it ships with for a while, and were finally provided with that repo; everything I've observed from the factory software is consistent with the code in that driver.  A sampling:
>>>
>>
>> I assume you mean "Delta AHE-50DC" when you refer to "it".
>>
> 
> Yes.
> 
>> [ ... ]
>>>> Can you check this with real hardware, by any chance ?
>>>>
>>>
>>> If you mean running that code on it, yes -- here's the userspace utility that invokes that library routine:
>>>
>>>     root@bmc-oob:~# fan-util.sh
>>>     fan1 speed: 7860 RPM
>>>     fan2 speed: 7860 RPM
>>>     fan3 speed: 7620 RPM
>>>     fan4 speed: 7560 RPM
>>>     temperature1: 29.20 C
>>>     temperature2: 27.80 C
>>>     temperature3: 28.50 C
>>>     temperature4: 30.20 C
>>>     vin_undervolt_fault: no
>>>     overtemperature_warning: no
>>>     fan_fault: no
>>>     fan_warning: no
>>>     fan_status: ok
>>>
>>
>> That doesn't really tell me anything in the context of the driver you submitted.
>> Would it be possible to install your driver and provide the output from the
>> "sensors" command ? It should match the information from the proprietary
>> driver/tool.
>>
> 
> Thanks, in doing so I realized I'd neglected to prevent reads from unsupported registers in the read_word_data function, which was leading to the driver producing sysfs files for meaningless sensor limits that the device doesn't actually support.  With that fix (which I'll include in v4):
> 

What a surprise. See drivers/hwmon/pmbus/dps920ab.c; that seems to be
a common theme for devices from Delta. I would suggest to add a similar
comment.

Guenter
