Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1A55681D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiGFIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGFIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:36:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE5248DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:36:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bf13so421154pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3rzfxOGSqbmsMXygj1P/cqh2Us2vss/rVotjH7eOiew=;
        b=dk2nJfeFYSbNNmJ7tfrqvCIB0euid3h5zOgKmeIekOTSjhv32mCcyofMLQzJOxVoHK
         aRq8F2c7iJUjCTd7Y/R57xcY2bQaG6ioi6kv+TLcL+BJXAejshlsS8xum/OPiXvWATUT
         vdpXbQt44L+uRaYXT/JYB1kPPRa5y4RCwgzLVcx6cO8cxsxhXpGhmN3kN09lXKVIZ1EV
         2RM/eb4YmuKY00crYGVaIq/BcRRUuz6NJ06G7GmqQXyCv3np8UGtERkM6G7D8uEfqBjH
         kNj56D5Yll5Oi4SUi1xuGmI0nMVIO/WeFD/kdtiHRvSGSaLJFJ39dLB9U3M7/SenAMsI
         7e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3rzfxOGSqbmsMXygj1P/cqh2Us2vss/rVotjH7eOiew=;
        b=qA8P1WImQrgkr3EP2YbE3SEeSEmr41W9XjpUhQy8U8Z9LrFrLNBl6USxNOQhpRKoXh
         Y0/cI+y+4ehNfm3TXcZGnXeaMfKacQ13M5siu60ACzFljv1n2UqA7q51H9EEt4NJLMUS
         EMNIFWwowgl0/V/gmEuVujM29pUbMaIxIX1vUmQcYy4c7bm4fDIpxNukNgL5k969NLtP
         GPiytVOK2YM7dGSIVJkxcwymJDe/HrmNlsI61uV5XxD+KEch0QUlj2ushJMGxiUkMP9K
         BtJqo7g6J5gWASYMtKoqqg/gHTf3QWIChEakdd+FpJCDZ4ixabp1NMp8Re0ufhSIVDw/
         5Mkg==
X-Gm-Message-State: AJIora/RvupaIO5llVzwiTPBgVaGzjRDqhAowzK+Qed/0uOEg+v+9hXy
        E1w8KrRWN+vOqyubXJGRW4mB8g==
X-Google-Smtp-Source: AGRyM1tFhqz+nKiml8dYdUjMlqXU6Xc6JmbRL/P4emD0Q/E95wuRF7UkZpzP0rKmsb8rD5oZaq+n2Q==
X-Received: by 2002:a05:6a00:17a7:b0:525:4306:72ad with SMTP id s39-20020a056a0017a700b00525430672admr45748510pfg.42.1657096575284;
        Wed, 06 Jul 2022 01:36:15 -0700 (PDT)
Received: from [192.168.10.153] (203-7-124-83.dyn.iinet.net.au. [203.7.124.83])
        by smtp.gmail.com with ESMTPSA id m14-20020a056a00080e00b00525b61f4792sm19405754pfk.109.2022.07.06.01.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:36:14 -0700 (PDT)
Message-ID: <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
Date:   Wed, 6 Jul 2022 18:38:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 09/14] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com
References: <cover.1650890638.git.robin.murphy@arm.com>
 <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2022 23:18, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary. This also
> leaves the custom initcall effectively doing nothing but register
> the driver, which no longer needs to happen early either, so convert
> it to builtin_platform_driver().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 35 +----------------------------------
>   1 file changed, 1 insertion(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 8fdb84b3642b..2549d32f0ddd 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1090,11 +1090,6 @@ static int ipmmu_probe(struct platform_device *pdev)
>   		ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
>   		if (ret)
>   			return ret;
> -
> -#if defined(CONFIG_IOMMU_DMA)
> -		if (!iommu_present(&platform_bus_type))
> -			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> -#endif
>   	}
>   
>   	/*

The comment which starts here did not make it to the patch but it should 
have as it mentions bus_set_iommu() which is gone by the end of the series.


More general question/request - could you please include the exact sha1 
the patchset is based on? It did not apply to any current trees and 
while it was trivial, it was slightly annoying to resolve the conflicts 
:)  Thanks,


> @@ -1168,32 +1163,4 @@ static struct platform_driver ipmmu_driver = {
>   	.probe = ipmmu_probe,
>   	.remove	= ipmmu_remove,
>   };
> -
> -static int __init ipmmu_init(void)
> -{
> -	struct device_node *np;
> -	static bool setup_done;
> -	int ret;
> -
> -	if (setup_done)
> -		return 0;
> -
> -	np = of_find_matching_node(NULL, ipmmu_of_ids);
> -	if (!np)
> -		return 0;
> -
> -	of_node_put(np);
> -
> -	ret = platform_driver_register(&ipmmu_driver);
> -	if (ret < 0)
> -		return ret;
> -
> -#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> -	if (!iommu_present(&platform_bus_type))
> -		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> -#endif
> -
> -	setup_done = true;
> -	return 0;
> -}
> -subsys_initcall(ipmmu_init);
> +builtin_platform_driver(ipmmu_driver);

-- 
Alexey
