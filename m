Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3924C4B03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiBYQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiBYQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:40:15 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F249218CCD;
        Fri, 25 Feb 2022 08:39:43 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso3973592otf.8;
        Fri, 25 Feb 2022 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=11tzMfBXZWTEFu0SmCPnVL2TtZRM1lacEuBs47JGN18=;
        b=Q6lPdNvWOYVkVMB+Ob8pAsRnWU/khUVxcYPwQX0huyQVohoS8PLdmrTbEv09/SZGgp
         mWKO0aCv7XXrbhBVIeeoZTYYJjj1/kEp54eyn8sMmXVVFCPhmgisKe1i8788iMwVtPRb
         niJMPyHXbrsUwvHlnHH9vUAJv1zzsm+2G/HNwIgyDQbb4hsPhwPElKPf1jDW5U6Xsrru
         JkHvzTlu9ah+fW8nREllsscdRyXJoxmOhTudcQ/1DYOcG+Co+uQVAMwq1mXhb8EMOdtl
         gtNv6Gf4J5LD8x5Dt/RVCPiljOwBOVdCIdliwKvnSrPfV5VDHwMuoYjbN1xgzUbWonOx
         OW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=11tzMfBXZWTEFu0SmCPnVL2TtZRM1lacEuBs47JGN18=;
        b=hR+kyNvH2Vx8ysJeuTEC7Ql8hW5tClxxOPEVLh+TAMY+eFfnrg4hXjTu3qbUrM86AT
         lIzm4KTrZXR4wRPtuoZ1EsC2SuO2JEuDDT6fBx5RoEgRWvIsAP9tGhoPnPY/h4Norr63
         kk2qr7eL5L0CP9rjCL74ocQv5Q1EXUCN2M3X68E4zRhCAWLak5AauT9AOr8TtQPuY+wR
         iDsfXA+p2JWpMWEvs5h7tHwG9KZkYOWY7t1Jq1BHWIUlCjydnK8VCEfeL8LKAgtag9N7
         V9TTO/Kvw55pvGga6CWiH6+zWeirhr0HJkgmrgFCmqCbUchYkXQKMrTH02zdGyIvFkQN
         hteA==
X-Gm-Message-State: AOAM532TBiriF18NfyAWvntPGa0Blahc/jQRmg3f62cFbL9ZsS8Yc9N4
        onO5fEXdmvg+r9BlqnzvV6g=
X-Google-Smtp-Source: ABdhPJxMkjgJv2VmxqbfWtbBsi6ys5WBHUI32OD7DBNlP/O58zz+KZ7xJlkp3YvZhuqxzoMRUH1vXQ==
X-Received: by 2002:a05:6830:4126:b0:5af:b9dd:14be with SMTP id w38-20020a056830412600b005afb9dd14bemr2864627ott.366.1645807182651;
        Fri, 25 Feb 2022 08:39:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808208400b002d54070f170sm1416054oiw.37.2022.02.25.08.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:39:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8656b67c-e093-0a18-9c5f-02f5b4264bb2@roeck-us.net>
Date:   Fri, 25 Feb 2022 08:39:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
Content-Language: en-US
To:     sylv <sylv@sylv.io>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
References: <cover.1645108566.git.sylv@sylv.io>
 <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
 <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
 <246de83631dd5e165f95904d7f1628502f030e02.camel@sylv.io>
 <66d4ea0b-0377-c9ae-68eb-7303c32cf87e@roeck-us.net>
 <7a567823d62b6ed00cbdc2ce239dc4a69e48b411.camel@sylv.io>
 <aa82f347-1b1a-8c40-b5cb-9efe292ae0ec@roeck-us.net>
 <337fe0598837b35ee96773339e9cdc8345a7c16e.camel@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <337fe0598837b35ee96773339e9cdc8345a7c16e.camel@sylv.io>
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

On 2/21/22 04:13, sylv wrote:
> On Thu, 2022-02-17 at 11:25 -0800, Guenter Roeck wrote:
>> On 2/17/22 10:38, sylv wrote:
>> [ ... ]
>>
>>>>
>>>> That makes me wonder if the chip needs to be added to this driver
>>>> in
>>>> the first
>>>> place, or if it could be added to pmbus.c instead. Any idea ?
>>>
>>> Oh, we did wrote a standalone driver too, and it works fine.
>>> Maybe it's better to upsteam it instead. :)
>>
>> No, I meant if it would make sense to just add something like
>>
>>          {"xdpe11280", (kernel_ulong_t)&pmbus_info_one },
>>
>> to drivers/hwmon/pmbus/pmbus.c.
>>
>> You only really need a standalone driver if it does something
>> special, such as a workaround for some register access (like
>> the xdpe12284 driver), or if support for manufacturer specific
>> registers is desired or needed. That would, for example, be useful
>> if the xdpe11280 supports per-phase sensors.
>>
>> Thanks,
>> Guenter
> 
> Hi,
> 
> I tested if the xdpe11280 can use the generic pmbus driver. Everything
> works fine except it does only detect READ_TEMPERATURE_1 on page 0.
> Looking at the pmbus_find_sensor_groups function it looks like only
> some commands are probed on each page (READ_VOUT, READ_IOUT, and
> READ_POUT) but not READ_TEMPERATURE_1.
> The PMBus spec 1.3.1 tells us: "Each page may offer the full range of
> PMBus commands available for each output or non-PMBus device." How
> could we adapt the generic driver so that it is possible to probe
> commands for each page?
> 

The problem is the "may". Some chips don't implement multi-page
support especially for temperature sensors. So we'll have to go
with adding support to the existing driver.

Guenter

> Furthermore, It would be great to add regulator and DT support. I
> created a WIP branch on GitHub with a possible way to implement this:
> https://github.com/9elements/linux/tree/upstreaming_pmbus_regulator_wip
> 
> What do you think?
> 
> Thanks,
> Marcello
> 

