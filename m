Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7856755F2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiF2Bn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Bn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:43:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D044275CA;
        Tue, 28 Jun 2022 18:43:55 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXkjk295WzkWx3;
        Wed, 29 Jun 2022 09:42:34 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 09:43:53 +0800
Subject: Re: [PATCH -next] soc/tegra: fuse: Add missing DMADEVICES dependency
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220628121039.21640-1-yuehaibing@huawei.com>
 <53794ec1-c9b9-67df-ccd2-5ce46f264b5a@collabora.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <83392db3-e8d1-e839-3cb6-e90e14044a56@huawei.com>
Date:   Wed, 29 Jun 2022 09:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <53794ec1-c9b9-67df-ccd2-5ce46f264b5a@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/29 7:02, Dmitry Osipenko wrote:
> On 6/28/22 15:10, YueHaibing wrote:
>> WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
>>   Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n])
>>   Selected by [y]:
>>   - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]
>>
>> TEGRA20_APB_DMA depends on DMADEVICES, so SOC_TEGRA_FUSE also should depends on it
>> before select it.
>>
>> Fixes: 19d41e5e9c68 ("soc/tegra: fuse: Add APB DMA dependency for Tegra20")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/soc/tegra/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
>> index 5725c8ef0406..2b6ba0f798fa 100644
>> --- a/drivers/soc/tegra/Kconfig
>> +++ b/drivers/soc/tegra/Kconfig
>> @@ -135,6 +135,7 @@ endif
>>  config SOC_TEGRA_FUSE
>>  	def_bool y
>>  	depends on ARCH_TEGRA
>> +	depends on DMADEVICES
>>  	select SOC_BUS
>>  	select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
>>  
> 
> Since it's a problem only for the Tegra20 config, shouldn't it be:
> 
> -  select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
> +  select TEGRA20_APB_DMA if (ARCH_TEGRA_2x_SOC && DMADEVICES)

Indeed, will do this in v2.

> 
> ?
> 
