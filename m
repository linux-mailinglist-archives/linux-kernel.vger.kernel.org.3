Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF5578126
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiGRLov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:44:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BE1C913
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:44:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so16599924wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6bkiYoT/Yv84bMuEQ4pZ1YWScyWUqhJvhev5bFy+Jbk=;
        b=ko8OV/YQXGUYtFhicux4+g/mXQW/tMaHdItobwhP1F1I37TAxNvsPMWaMQV3wcmC4r
         Qcufk8fs/r/zFP92LJGCcKik5qryAVWIpuyG1tpFDPdIDslT7aXdViZUbBQqbwBN/8NK
         /GujDslbUkd7xzcWcFYWz8sUr8LNsgjIL1Vu1GGoMlqjSBXlnIbymlZUcQKp1qYTSBro
         4+ON5z0IbwFqz9MTR+9r1jURRGx/2GJpqfwJ4wG47EXibzT1ECgsY0ZI9kl7F3uMXzrf
         fJ46Wnjbs189zZlRkp/K+xnTMnJ8OGR9naLmBSK2CoRMo192vE9lkOPkKhMTLOVdNHaV
         XPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6bkiYoT/Yv84bMuEQ4pZ1YWScyWUqhJvhev5bFy+Jbk=;
        b=shSQt7UKJOGrmOs9E5UBI4lzn/nVfS1jhjG4Mo1EZGNbDRC53agaQ0gbiVXqcxNelq
         bRGisskhL85zppL6FAzp8BbIdAd3+G8EuvgI38PpJE2isEGrXBwo69DM5dZ2h5UEKUYe
         LN3upcXiuzKe+5ePhqfcL5AsLVle9U5aOpkkD62ZXXXfhlng+xlhTbl3+8ci0vDaPTv0
         wYoinW1X4skrXBctkJHFO4b8Tefgtft5gWkKeUJb/H/47FgHvUwf7O6Q8s8Mla3CkMPd
         wN2yWUHrjoXii7EcL5YDj63K5aPrXUJ484XpoeN6RNxMDj3F8A0HNXMEQ+drtzqATrJR
         jrqg==
X-Gm-Message-State: AJIora84eD95txur9LlceSGj4bTQ4BixixURUL6sxALn8EU8KTqf/0DJ
        z8j2My2zTDdm6OgjB9aBsVNsHQ==
X-Google-Smtp-Source: AGRyM1sPOmp/WbRqFKx96NSUYYWSBje3lFrsVD23g55qROu2yx5Ujf8W2fad2+E3Ctsfy+h+f6NpDA==
X-Received: by 2002:a5d:6502:0:b0:21d:f19e:602b with SMTP id x2-20020a5d6502000000b0021df19e602bmr8583035wru.714.1658144686308;
        Mon, 18 Jul 2022 04:44:46 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id i10-20020a05600c354a00b003a31d4f6a1bsm2144173wmq.44.2022.07.18.04.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 04:44:45 -0700 (PDT)
Message-ID: <9029caa7-beea-34f6-7f9b-b2b230c3baeb@linaro.org>
Date:   Mon, 18 Jul 2022 12:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next,v2] nvmem: core: Fix memleak in nvmem_register()
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        wangweiyang2@huawei.com
References: <20220716095257.2752110-1-cuigaosheng1@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220716095257.2752110-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2022 10:52, Gaosheng Cui wrote:
> dev_set_name will alloc memory for nvmem->dev.kobj.name in
> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
> memory will be freed and return, but nobody will free memory
> for nvmem->dev.kobj.name, there will be memleak, so moving
> dev_set_name after nvmem_validate_keepouts to fix it.
> 
> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   drivers/nvmem/core.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1e3c754efd0d..a5d75edf509d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -808,20 +808,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	else if (!config->no_of_node)
>   		nvmem->dev.of_node = config->dev->of_node;
>   
> -	switch (config->id) {
> -	case NVMEM_DEVID_NONE:
> -		dev_set_name(&nvmem->dev, "%s", config->name);
> -		break;
> -	case NVMEM_DEVID_AUTO:
> -		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
> -		break;
> -	default:
> -		dev_set_name(&nvmem->dev, "%s%d",
> -			     config->name ? : "nvmem",
> -			     config->name ? config->id : nvmem->id);
> -		break;
> -	}
> -
>   	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>   			   config->read_only || !nvmem->reg_write;
>   
> @@ -838,6 +824,20 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   		}
>   	}
>   
> +	switch (config->id) {
> +	case NVMEM_DEVID_NONE:
> +		dev_set_name(&nvmem->dev, "%s", config->name);
> +		break;
> +	case NVMEM_DEVID_AUTO:
> +		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
> +		break;
> +	default:
> +		dev_set_name(&nvmem->dev, "%s%d",
> +			     config->name ? : "nvmem",
> +			     config->name ? config->id : nvmem->id);
> +		break;
> +	}
> +
The issue with this approach is that dev_err messages in 
nvmem_validate_keepouts() will show up without device name setup.

I think better option is to move nvmem_validate_keepouts() after 
device_register() and let the device core deal with cleaning name in 
error cases.

--srini

>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_register(&nvmem->dev);
