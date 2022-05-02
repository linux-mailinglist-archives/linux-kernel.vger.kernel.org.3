Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4851740D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386283AbiEBQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386271AbiEBQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:19:56 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5FE0E4;
        Mon,  2 May 2022 09:16:26 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so14697875fac.7;
        Mon, 02 May 2022 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CsoWEFYA6oWSiqhk0itUr0DgVsHArvM3fYs9hP+JNhQ=;
        b=MGay0hqvR9zLVVhYvGtNNM+6DsAoscTtWads5Z9SsEZFDbN2OdCz7k2IxB8J5sC+MW
         ioPITDPaH4vNVAWuLHXit712aDuG0Ld2SKtjgcoB6avXkZBg4QI3SgQ20I/iqVe/7HIN
         El0cdCR5jy4AfodPZ3OrWO6/hdXKM97oc/IQFKqCmj6ddmZhG9Sgyc0e8Fn98bOdR3hN
         FgHThMjcp144VxF6N3L4OA1hgcp1VEEOGko5hJ9jjQBL/X4ENl/0GiNgOnPC0WB5JahU
         XTDyecExEBfHNGtcePcP0YuoyjJJdcuxNMbLnj/kpS/XgzmiI2j/rQUZvbgyWvtlHRGY
         WcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CsoWEFYA6oWSiqhk0itUr0DgVsHArvM3fYs9hP+JNhQ=;
        b=v/jBXetN00Eh739IwtUf4uDAVcoR5jDBL8ba/1S1CHGXczxpMVycwhu2aZ6wphrE5f
         DtdNIWjoJ4zIw/GCbjaCsoWddQ8a3/vw3uXVnYIO5ZVinWvggfnaBw8BP1b0BGvRnHOo
         eIa6QmH11Pjfv7b5oZPQ+Ig4YRlkX8sFFLmPhj9K3UxbGxxWeIfR5SNdTyKl0dQ0C/EE
         mhg1NJw+JHy2gx+C7GkRX5EHMWu4kWDFsd/X6OKEMB8Q46q6cyoVUOLV3uuMIlc6GzMm
         GGFMDZP9tGXvJ1TsjHHvMb4uLP9xbauq/CENdLiaHjMzLFzx8XmRNnyaOMhgk/xnx0g3
         /d4g==
X-Gm-Message-State: AOAM532l1OvX6SITWXypyVYHixaEErONd73qowXbK9rPBC2mxVTJTywQ
        HRAVbEffQI2Dad4Jn8bRjxu4yayVUGDu4A==
X-Google-Smtp-Source: ABdhPJz+SmowUxKGKeiGA3cKrv5xDgWPsQV7GkBX4C+ZZ+xdqowSKMw0vofdkoCzzmfXnnFT8qO9cA==
X-Received: by 2002:a05:6870:3047:b0:ec:44c2:1718 with SMTP id u7-20020a056870304700b000ec44c21718mr6015845oau.214.1651508185628;
        Mon, 02 May 2022 09:16:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f11-20020a4ae60b000000b0035eb4e5a6bdsm3723135oot.19.2022.05.02.09.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 09:16:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <25e2dc90-ab01-ab19-ffde-1b709dbebad4@roeck-us.net>
Date:   Mon, 2 May 2022 09:16:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] hwmon: (tmp401) Add of_match_table
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Camel Guo <Camel.Guo@axis.com>, Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502091942.1083067-1-camel.guo@axis.com>
 <a2e81680-e62c-dddd-ee58-6f5aa3664d2f@roeck-us.net>
 <20220502145800.GA21695@axis.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220502145800.GA21695@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 07:58, Vincent Whitchurch wrote:
> On Mon, May 02, 2022 at 03:57:50PM +0200, Guenter Roeck wrote:
>> On 5/2/22 02:19, Camel Guo wrote:
>>> When tmp401 is built as kernel module, it won't be automatically loaded
>>> even through there is a device node in the devicetree. e.g:
>>>       i2c {
>>>         #address-cells = <1>;
>>>         #size-cells = <0>;
>>>
>>>         sensor@4c {
>>>           compatible = "ti,tmp401";
>>>           reg = <0x4c>;
>>>         };
>>>       };
>>> In order to make sure it is loaded automatically, this commit adds
>>> of_match_table for tmp401.
>>>
>>
>> As mentioned before, historically i2c devices would instantiate based
>> on the i2c match table. You are claiming that this is no longer the case.
> 
> Note that while the commit message in the first version of the patch did
> wrongly claim that probe would not work without the of_match_table, this
> corrected description in v2 does mention the actual problem: that the
> module will not be automatically loaded without the of_match_table.  (If
> the module is loaded manually or the driver is built-in to the kernel,
> there is no problem.)
> 

No, it doesn't. None of the information you provided below is mentioned
in the description, but is essential to understand your patch and the
reason for it.

> See commit 72fc64c68decf119466 ("hwmon: (tmp103) Add OF device ID
> table") or commit 98b16a09861aa85d6 ("hwmon: (max31785) Add OF device ID
> table") for similar changes to other hwmon drivers.
> 

Those commits provide a valid and acceptable explanation.

> The potential future change mentioned in the commit messages of
> 72fc64c68decf119466 and 98b16a09861aa85d6 happened in commit
> af503716ac1444db61d80 ("i2c: core: report OF style module alias for
> devices registered via OF").  The commit message of
> af503716ac1444db61d80 has a lot of details about the change being made,
> and while it says that all in-tree drivers had been converted, it looks
> like some of them, like tmp401, were missed.
> 

And this is the missing link. If you provide that information
in the commit log I have no problems. Please also provide a Fixes:
tag.

Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")

Thanks,
Guenter

>> The above is no evidence; that would require a log output on an affected
>> system showing that the sensors are not or no longer longer instantiated.
> 
> A log would simply show nothing happening so that's probably not going
> to be that useful, but here is what the modaliases look like.  As you
> can see, the modalias of the device in sysfs does not match any of the
> alias patterns of the module without this patch:
> 
> $ cat /sys/bus/i2c/devices/4-004c/modalias
> of:Ntemperature-sensorT<NULL>Cti,tmp431
> 
> modinfo without this patch:
> 
> $ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
> filename:       /storage2/femfyra/linux-2.6/.roadtest/./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
> license:        GPL
> description:    Texas Instruments TMP401 temperature sensor driver
> author:         Hans de Goede <hdegoede@redhat.com>
> alias:          i2c:tmp435
> alias:          i2c:tmp432
> alias:          i2c:tmp431
> alias:          i2c:tmp411
> alias:          i2c:tmp401
> depends:
> intree:         Y
> name:           tmp401
> vermagic:       5.18.0-rc1 mod_unload
> 
> modinfo after this patch:
> 
> $ modinfo ./modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
> filename:       /storage2/femfyra/linux-2.6/./.roadtest/modules/lib/modules/5.18.0-rc1/kernel/drivers/hwmon/tmp401.ko
> license:        GPL
> description:    Texas Instruments TMP401 temperature sensor driver
> author:         Hans de Goede <hdegoede@redhat.com>
> alias:          i2c:tmp435
> alias:          i2c:tmp432
> alias:          i2c:tmp431
> alias:          i2c:tmp411
> alias:          i2c:tmp401
> alias:          of:N*T*Cti,tmp435C*
> alias:          of:N*T*Cti,tmp435
> alias:          of:N*T*Cti,tmp432C*
> alias:          of:N*T*Cti,tmp432
> alias:          of:N*T*Cti,tmp431C*
> alias:          of:N*T*Cti,tmp431
> alias:          of:N*T*Cti,tmp411C*
> alias:          of:N*T*Cti,tmp411
> alias:          of:N*T*Cti,tmp401C*
> alias:          of:N*T*Cti,tmp401
> depends:
> intree:         Y
> name:           tmp401
> vermagic:       5.18.0-rc1 mod_unload

