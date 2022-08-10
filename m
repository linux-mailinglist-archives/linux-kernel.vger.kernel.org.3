Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E3558F23C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiHJSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:21:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DA79A66;
        Wed, 10 Aug 2022 11:21:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gj1so15605667pjb.0;
        Wed, 10 Aug 2022 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=BdGTPiXk6CTaW5FzVUwAa4QoLiC6hNTwBQkDXRoMqck=;
        b=eREwCFIGqwJDyWSaCwO/sHCEBk4IR646/rSrVtloa55NAy9PnO5O6lbp3MQSVprAFq
         JCVY4c+v9nFzSECvIljqYpHv7lKm5PYzitrCvk9WfR3Xt1Df/4pNvOBtwDPBHhfJ30vQ
         wSVwlE2xBcu0vrqSGJlp2lFoxtR9wXrwRrCPxe9SD3nNfRNEgEFanwgwIpUpmz1OzHIp
         /j+xUN4XbUwUF4HaPctD84fI2byfO/wPFV8WQJvVTVVDutaO4jzhiKCatNdQfdimpO4Y
         X6pBZ13FAsEkie6DxOZZhp+vKxfAjVhPCZU1CMZfUI0mdgXsHCDHtcKsN54dhngA33NC
         Frfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=BdGTPiXk6CTaW5FzVUwAa4QoLiC6hNTwBQkDXRoMqck=;
        b=BHWv4nIrRrTixRAooL1WmkRvs5G7JnOCZ02wHPBOcXb7iyjtQKo7iDtUquFUoQgY7B
         /wvvReZYjOeA5q53hPQqEf28eL5hCwgTVPCi2G/d7JfpeGROHZz7vHpsUpspHEGhhNws
         CYZ9IQ23Y+FcX54BUEj+KWQWVaixgvus/zg8DlvN4XUSI6XWYgH8/ga7/+ei/9MZh3Fa
         xfL9MmL9P9PbfXdgN7jDY2+dBFxi+0rh+oinWC6P336njWp8dt/2uHve0OaAFxbELG2F
         h+8Yo1XmfyvPvVMPHGgUI/bXX6daaKoqQw+/t4inLO+MAGAkzcHgDGZwKye1UcYp2CQq
         yHMg==
X-Gm-Message-State: ACgBeo2AbRMpri9NSZo5+IvfqemW+NRHDCaVyupJfiSc3ZVWC+u2wDbT
        AwsCPbNa921K4RUVvfE+RWWgsKuVmqM=
X-Google-Smtp-Source: AA6agR4+Gap920jMlVC1TQg34bq9ieJThFhzCTs8IuNAkqW7fWVZLPnWbijugn25nRKaTxd90c/LXg==
X-Received: by 2002:a17:90b:3947:b0:1f5:104:f8cd with SMTP id oe7-20020a17090b394700b001f50104f8cdmr4845428pjb.26.1660155698818;
        Wed, 10 Aug 2022 11:21:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020aa796a4000000b0052e67e9402dsm2302937pfk.106.2022.08.10.11.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 11:21:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8beb8ae2-04cd-fa37-5dbe-8d18e6a53f4d@roeck-us.net>
Date:   Wed, 10 Aug 2022 11:21:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
 <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
 <20220810185658.6e27d9bd@posteo.net>
 <bc1d22d1-45b4-7d49-bedd-f0eafdc035cd@roeck-us.net>
 <20220810194852.78536153@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220810194852.78536153@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/10/22 10:48, Wilken Gottwalt wrote:
> On Wed, 10 Aug 2022 10:29:08 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 8/10/22 09:56, Wilken Gottwalt wrote:
>>> On Wed, 10 Aug 2022 09:31:21 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> On 8/10/22 06:53, Wilken Gottwalt wrote:
>>>>> Add reporting if the PSU is running in single or multi rail mode via
>>>>> ocpmode debugfs entry. Also update the documentation accordingly.
>>>>>
>>>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>>>> ---
>>>>> Changes in v2:
>>>>>      - fixed spelling issues in commit message
>>>>
>>>> You did not address or even provide feedback on my second comment.
>>>
>>> Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
>>> answer the earlier mail and think about it.
>>>
>>> Though, maybe you can help me with that what keeps me so busy. Would it be okay
>>> to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
>>> with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
>>> used to set a sample/update rate in a sensor (-register), but this USB-HID
>>> approach is a pure polling thing. It seems to work quite and enables the driver
>>> to collect data quite early in the boot process.
>>>
>>
>> It really depends. Is it _necessary_ ? The pwm-fan driver uses a timer for
>> periodic polling, but that is because it has to. We should not do it purely
>> for convenience, and from the code I don't immediately see why it would
>> be necessary.
> 
> Together with the polling I would add encountered lowest and highest values and
> the average of basically all available sensors (kind of session statistics). I
> know it is a bit odd, but currently these power supplies are sold again in a
> newer version and people really like to use them in their servers/workstations
> because of the "realtime" data and this driver. No joke, but I really got
> several requests to add this and I must admit I have quite some fun implementing
> it.
> 

That is out of scope for a kernel driver. If desired, a user space application
should do the polling and calculate statistics such as lowest/highest or averages.

Guenter

> Maybe I can provide a patch after I'm done and you can decide if this is okay
> or not. After all I provide an external more enhanced driver via github where
> some features are added, which are a clear no-go. It would be nice to have that
> in mainline, but I'm absolutely fine with a "no".
> 
> greetings,
> Wilken

