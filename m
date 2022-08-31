Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2405A73FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiHaCjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:39:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373569C8E0;
        Tue, 30 Aug 2022 19:39:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f24so10145067plr.1;
        Tue, 30 Aug 2022 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=6I3GeMx+uqUZdiXdBJPpFrxttsFF0ltwfrX0yfx92NI=;
        b=Vz+/yOjBgNxRcW4AcECQXhDA5IlCUp1rVQgNZVJBrJyxjMqmeLcDNSVdjxE+0FdUVy
         dz1MAzEjlNyCls+cqmM/keBJoot9JQ8tV/oY2IXmSV0paIeQeGyGmQdcP9rAiDfIj9vy
         qssA+ZTlwd+JDHTNJiuEhqQJdHdgYoe0errSOhaWKsJiVuXXlzugiVNPTnYb1KifcnF0
         BNc4i0ndkgPyouYM4xqT7M69yWGxgHVM6fW0e87vgEJbuUA7014qlOhtnuMIRPIvLbB1
         NF2weJ4LkqJCjCsCXeJfmswr2rKuj60SQsFY+gq2uXhG6nVl6OKIAyQwjr6pXnc94tqw
         J9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=6I3GeMx+uqUZdiXdBJPpFrxttsFF0ltwfrX0yfx92NI=;
        b=HajuRhkTzMIxqj/DaXMlwUAh2BA6UhEaEerme9WwzSilHZUbywfnm61Fv53DzBpKci
         bW2dgHZiC492mu0shsfHleIbxvmwYb3yfYLM9qTg3mnGBbPQniP0OFP0EQsNPh0SPt4R
         j5YpVKL8cFEXUog/Y8B5fszxXgyudcu3cBv/4sOaSeE2GkTF6IEqQSb5rOb7J9UhfpYX
         Xso0xolb/y50bm5IButrjP7l/F7u7STTi4pyuafaCFZV7KVmXJ47wqdgwZbMzeZr/a4k
         ewasVIl68Yv002B1BOjewWzGA0v6+bzWxKQSa9T78fQDuMBga2z20kyO1Dq880pKBMi2
         s1jQ==
X-Gm-Message-State: ACgBeo1I83jCu5mQa6w/+CfGbtkMIRFOjQeHZWHajYDG9C3LdIk28pD9
        gZf+YQ4APEOuwYUvq7KcxnzWyJAaIE8hFw==
X-Google-Smtp-Source: AA6agR7oAnrknYawTKOErK7WVEqTplrYWxE/svDSxMh/43DD0IjkCv/5ep1bPjBzTsAiszeScSfCsw==
X-Received: by 2002:a17:90a:9f96:b0:1fa:b4fb:6297 with SMTP id o22-20020a17090a9f9600b001fab4fb6297mr1050215pjp.80.1661913545641;
        Tue, 30 Aug 2022 19:39:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020a630605000000b0042988a04bfdsm2278466pgg.9.2022.08.30.19.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 19:39:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bd510d56-b161-ff17-8a09-ed4a8a66ca57@roeck-us.net>
Date:   Tue, 30 Aug 2022 19:39:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel,vm-map" not defined
In-Reply-To: <20220830192212.28570-3-farbere@amazon.com>
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

On 8/30/22 12:21, Eliav Farber wrote:
> Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
> to 0, and no voltage channel infos are allocated.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 046523d47c29..0e29877a1a9c 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device *pdev)
>   	}
>   
>   	if (vm_num) {
> -		u32 num = vm_num;
> -
>   		ret = pvt_get_regmap(pdev, "vm", pvt);
>   		if (ret)
>   			return ret;
> @@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device *pdev)
>   		ret = device_property_read_u8_array(dev, "intel,vm-map",
>   						    pvt->vm_idx, vm_num);
>   		if (ret) {
> -			num = 0;
> +			/*
> +			 * Incase intel,vm-map property is not defined, we
> +			 * assume incremental channel numbers.
> +			 */
> +			for (i = 0; i < vm_num; i++)
> +				pvt->vm_idx[i] = i;
>   		} else {
>   			for (i = 0; i < vm_num; i++)
>   				if (pvt->vm_idx[i] >= vm_num ||
> -				    pvt->vm_idx[i] == 0xff) {
> -					num = i;
> +				    pvt->vm_idx[i] == 0xff)
>   					break;
> -				}
> -		}
>   
> -		/*
> -		 * Incase intel,vm-map property is not defined, we assume
> -		 * incremental channel numbers.
> -		 */
> -		for (i = num; i < vm_num; i++)
> -			pvt->vm_idx[i] = i;
> +			vm_num = i;
> +		}
>   

So this is actually a functional change: In the old code, unspecified channel
numbers (num ... vm_num) were filled with incremental channel numbers.
This is no longer the case.

> -		in_config = devm_kcalloc(dev, num + 1,
> +		in_config = devm_kcalloc(dev, vm_num + 1,
>   					 sizeof(*in_config), GFP_KERNEL);

The relevant difference (and maybe bug in the existing code ?) seems to be
this change. Have you considered leaving everything else in place and only
changing this code as well as the num -> vm_num changes below ?

Thanks,
Guenter

>   		if (!in_config)
>   			return -ENOMEM;
>   
> -		memset32(in_config, HWMON_I_INPUT, num);
> -		in_config[num] = 0;
> +		memset32(in_config, HWMON_I_INPUT, vm_num);
> +		in_config[vm_num] = 0;
>   		pvt_in.config = in_config;
>   
>   		pvt_info[index++] = &pvt_in;

