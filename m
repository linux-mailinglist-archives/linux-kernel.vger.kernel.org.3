Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62FB4BE840
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379966AbiBUQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiBUQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:13:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15242BF40;
        Mon, 21 Feb 2022 08:13:05 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f37so19520010lfv.8;
        Mon, 21 Feb 2022 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9svlVloIRFTm0V9CmprJDnoHOsTYF2+BAhlCr5Fme5A=;
        b=FfE3wxk/bEL8UTmlDO/hRc28DE6CbLUk0akjgMW+NOVFnCAL3skLaYD4L4OknYwUn6
         qpffpoihf89dfHeln61E5gIpe5CA5UERdHev6OrUqkGTVjy8z7Ypaj0cxGDV6DvFqel0
         5BSHV6mrl+fcJ1cbgEMTYdjgjBY5LM4uKYg0luNZiKRqEaB1U0/9Z7UgQeX33JsGFmlV
         w0Cb4ZLsYICEM0OuQwNbHxiLwBhGbI1Ym5QbdLe5wm/QZugosE5SGU3rcU3yjHNVD1WU
         7CMDUdUMld4hOcxsXBPhJhcpQBNU7IMfPUt04MUj6+ewMDsOMiC8vg4NnuGotnDVIOlA
         LksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9svlVloIRFTm0V9CmprJDnoHOsTYF2+BAhlCr5Fme5A=;
        b=vnOPxkwEtE8dST6BPkwrnk0+dQ1MM0HcGIoJd0r5Y7Efyg/Szwgsh5dv+nPj7+YrVl
         lQh+2wqcgQFzX33XRdABYcil+IiklFqxvLkwqGgifKxCQmOjOj8fGG555FS/97tOnh4R
         OnEQmb1rtk+YEh+iEzKFnshAGy4nQwJ7YWNoH3GHbAucOh9E0J8taeyZYC7zzgDpun0W
         kdp8MAy+KUzkTtL4oMEylcNcQ9mbNA1eiF16ONoIbzhBnd7m5LNQwpf7a61YiMcLjnyp
         4BLFel8qovHaZHiCrMXVVI8aHlL6wxoHl7MqQ+wLPfey/zGtZTXo56GzFbOFwzhQyqkA
         FMFA==
X-Gm-Message-State: AOAM531PugxsBWBg+tzVmjS7IC0cGjhB8PmRb6tlMNzAZNIXMczHjgYA
        IeyeyAP12CVkam1W7lNlmcQ=
X-Google-Smtp-Source: ABdhPJwNZJrEg1y0eTIOwei9jZ+BJ3p5jeQ6ORrtvrmOUkahCLjrtgLftda6GwQtMMvTU/J9imqkyQ==
X-Received: by 2002:a05:6512:b91:b0:443:922a:c93b with SMTP id b17-20020a0565120b9100b00443922ac93bmr14640778lfv.121.1645459983314;
        Mon, 21 Feb 2022 08:13:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id s17sm1389500ljc.20.2022.02.21.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:13:02 -0800 (PST)
Message-ID: <c55b15c8-df49-6458-56ea-a753ae578d18@gmail.com>
Date:   Mon, 21 Feb 2022 19:13:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.02.2022 19:02, Guenter Roeck пишет:
> On 2/21/22 07:49, Jon Hunter wrote:
>>
>> On 21/02/2022 15:43, Guenter Roeck wrote:
>>
>> ...
>>
>>>> We observed a random null pointer deference crash somewhere in the
>>>> thermal core (crash log below is not very helpful) when calling
>>>> mutex_lock(). It looks like we get an interrupt when this crash
>>>> happens.
>>>>
>>>> Looking at the lm90 driver, per the above, I now see we are calling
>>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>>> hwmon_notify_event() I see that ...
>>>>
>>>> hwmon_notify_event()
>>>>    --> hwmon_thermal_notify()
>>>>      --> thermal_zone_device_update()
>>>>        --> update_temperature()
>>>>          --> mutex_lock()
>>>>
>>>> So although I don't completely understand the crash, it does seem
>>>> that we should not be calling hwmon_notify_event() from the
>>>> interrupt handler.
>>>>
>>> As mentioned separately, this is not the problem.
>>
>> Yes I can see that now.
>>
>>> I think the problem may be that this is not a devicetree system
>>> (or the lm90 devide does not have a devicetree node), but thermal
>>> notification currently only works in such systems because the hwmon
>>> subsystem uses the devicetree registration method. At the same time,
>>> CONFIG_THERMAL_OF is obviously enabled. Unfortunately, the hwmon code
>>> does not bail out in that situation due to another bug.
>>
>> The platform I see this on does use device-tree and it does have a
>> node for the ti,tmp451 device which uses the lm90 device. This
>> platform uses the device-tree source
>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node
>> is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>
> 
> Interesting. It appears that the call to
> devm_thermal_zone_of_sensor_register()
> in the hwmon core nevertheless returns -ENODEV which is not handled
> properly
> in the hwmon core. I can see a number of reasons for this to happen:
> - there is no devicetree node for the lm90 device
> - there is no thermal-zones devicetree node
> - there is no thermal zone entry in the thermal-zones node which matches
>   the sensor
> 
> We'll have to revert the lm90 changes until this is sorted out.

Oh, yeah. Seems there is a problem there and tzd pointer could be
-ENODEV. But it's a hwmon core problem, which apparently existed for a
long time, not the lm90 problem.

