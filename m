Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAF58EC32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiHJMl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiHJMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:41:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07D75FD5;
        Wed, 10 Aug 2022 05:41:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso1981143pjl.4;
        Wed, 10 Aug 2022 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=paIljyHrUvej+/v+fGWG6Ry2j3rdU6vBvSRVU4+Ng94=;
        b=CNXtsRPrb/GrYK/cLLTUVSxVh2X5WYkC3jRbKLtfBZ2x6Su/TzrAztaLxy2clwDaqC
         bVlb/4nrQ+h8TKXpnnFmrj/ksn7HWP+fYvQmj8fuvmf7ucuJoFdnVf6Ab9Zk21Fn0Vzu
         nhhyqdX/qyyWYK2qPvLz2JiuuHBgl7UH9MG65Ap6gyCAXVns2NKLSiU3FiYh5ycsazru
         Zs4qG0S2L152zYMTtciGSD19q1KPYmb0bYYQVMNd5J0WL2cFAcVLB5y/11ugPghc/elg
         Obt9bcqzGslBJ6gB8Z/QB5nS3rsZEdyI1Gmq9MmiCOCr0fFmW/KF79be491zY5Vw8o1l
         NGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=paIljyHrUvej+/v+fGWG6Ry2j3rdU6vBvSRVU4+Ng94=;
        b=CnE5UugXJsOMi9IocR/DuA+BNND6XbmSGZpO9qd2utOpMlhCIe+Gv4EyJak88KWj9t
         kLr3Zg5F4im7fGuB0lA1NqngBbfdfBalfq6raCjjPkp3Qll3VGDjMWTfd2Qp4vzC9Hb8
         Zcm8aeIENtUiA7owrkT9oGegZcFOZtBTGxOJdJAFCupAWtheQM5pWRydaQRH5vERvZoK
         vb2wfIez7jeN65JnNvH1pUOjF2OBNshW/YpKOYaR7OmMasELycBb+VeJctURYfG5hpw0
         pg8+7oO1ITkmTU5xyNWy5H0tYLyH6dlSpPe/cxy5ek0HP3MuVqF44S8aznLXrb9Jbcy/
         OksQ==
X-Gm-Message-State: ACgBeo3qWP6Izwa0jwV0RylLwtXC0DaFDWmgLkG1dRYO2putOj1zYLJ+
        L7b8b3KeTOyCVz9MLhgTw2s=
X-Google-Smtp-Source: AA6agR7XAtjBC8yH4qNC8ojRXQc2+OqICsXEy04ur7rcG7rKpV2LpLk4MuLwWRTziU5gsZlCfR8tXA==
X-Received: by 2002:a17:90b:100b:b0:1f7:68e8:dcb1 with SMTP id gm11-20020a17090b100b00b001f768e8dcb1mr3575262pjb.198.1660135282341;
        Wed, 10 Aug 2022 05:41:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b0016dd6929af5sm12601477plr.206.2022.08.10.05.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:41:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <684fa47a-d8a8-3b4c-7749-438128e8efec@roeck-us.net>
Date:   Wed, 10 Aug 2022 05:41:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 26/33] hwmon/drivers/pm_bus: Switch to new of thermal
 API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Jean Delvare <jdelvare@suse.com>,
        "open list:PMBUS HARDWARE MONITORING DRIVERS" 
        <linux-hwmon@vger.kernel.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-27-daniel.lezcano@linexp.org>
 <20220808102949.GC1969424@roeck-us.net>
 <61109578-8136-d544-0bdc-d65c0736c566@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <61109578-8136-d544-0bdc-d65c0736c566@linaro.org>
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

On 8/10/22 03:23, Daniel Lezcano wrote:
> On 08/08/2022 12:29, Guenter Roeck wrote:
>> On Fri, Aug 05, 2022 at 12:43:42AM +0200, Daniel Lezcano wrote:
>>> The thermal OF code has a new API allowing to migrate the OF
>>> initialization to a simpler approach. The ops are no longer device
>>> tree specific and are the generic ones provided by the core code.
>>>
>>> Convert the ops to the thermal_zone_device_ops format and use the new
>>> API to register the thermal zone with these generic ops.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>>
>> Subject tag should be something like "hwmon: (pmbus) ...".
>>
>> Also, from other patches it appears that this would or might result
>> in a registration failure if a thermal zone for the sensor does not
>> exist. This will need to be resolved before the patch is can be applied.
> 
> With the subject fixed, shall I add your Acked-by ?
> 

Yes. With subject fixed:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
