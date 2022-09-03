Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59055ABDB7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiICHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiICHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:43:26 -0400
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 00:43:24 PDT
Received: from mail-m118112.qiye.163.com (mail-m118112.qiye.163.com [115.236.118.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624898376;
        Sat,  3 Sep 2022 00:43:24 -0700 (PDT)
Received: from [172.16.12.102] (unknown [58.22.7.114])
        by mail-m118112.qiye.163.com (Hmail) with ESMTPA id 8D36D360184;
        Sat,  3 Sep 2022 15:34:16 +0800 (CST)
Subject: Re: [PATCH] usb: dwc3: core: leave default DMA if the controller does
 not support 64-bit DMA
To:     Sven Peter <sven@svenpeter.dev>,
        William Wu <william.wu@rock-chips.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com
References: <20220901083446.3799754-1-william.wu@rock-chips.com>
 <8fc4eb4b-25c4-4d4c-8203-1e5c314436b3@www.fastmail.com>
From:   wuliangfeng <wulf@rock-chips.com>
Message-ID: <5d1c1338-b820-e10b-76eb-daee9abda7c2@rock-chips.com>
Date:   Sat, 3 Sep 2022 23:33:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8fc4eb4b-25c4-4d4c-8203-1e5c314436b3@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGB5LVkNOGR9JQx5CSUIfSFUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktMSkhVSktLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6LRw*SD0pGDk0LiEVNgIw
        HRlPCzpVSlVKTU1JSkJLT05MSUhNVTMWGhIXVQwOFx07CRQYEFYYExILCFUYFBZFWVdZEgtZQVlO
        Q1VJSVVMVUpKT1lXWQgBWUFPSEhJNwY+
X-HM-Tid: 0a830245901a2ec0kusn8d36d360184
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        NICE_REPLY_A,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/2 上午1:38, Sven Peter wrote:
> 
> 
> On Thu, Sep 1, 2022, at 10:34, William Wu wrote:
>> On some DWC3 controllers (e.g. Rockchip SoCs), the DWC3 core
>> doesn't support 64-bit DMA address width. In this case, this
>> driver should use the default 32-bit mask. Otherwise, the DWC3
>> controller will break if it runs on above 4GB physical memory
>> environment.
>>
>> This patch reads the DWC_USB3_AWIDTH bits of GHWPARAMS0 which
>> used for the DMA address width, and only configure 64-bit DMA
>> mask if the DWC_USB3_AWIDTH is 64.
>>
>> Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
> 
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> 
>> ---
>>   drivers/usb/dwc3/core.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index c5c238ab3083..2fcbd05b2af1 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1751,12 +1751,6 @@ static int dwc3_probe(struct platform_device *pdev)
>>
>>   	dwc3_get_properties(dwc);
>>
>> -	if (!dwc->sysdev_is_parent) {
>> -		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
>>   	if (IS_ERR(dwc->reset))
>>   		return PTR_ERR(dwc->reset);
>> @@ -1823,6 +1817,13 @@ static int dwc3_probe(struct platform_device
>> *pdev)
>>   	dwc3_cache_hwparams(dwc);
>>   	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node,
>> "wakeup-source"));
>>
>> +	if (!dwc->sysdev_is_parent &&
>> +	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
>> +		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
>> +		if (ret)
>> +			goto disable_clks;
>> +	}
> 
> I guess you could also create the mask from DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0)
> directly instead of hardcoding it to 64bit here. Probably doesn't matter though unless
> there are some weird systems where dwc3 can only do 48bit DMA but there's actually memory
> above that.
> 
> 
Refer to the DWC3 databook "Table 4-1 Basic Config Parameters", it 
describe that "If your system address bus width for example is 40bits, 
select 64 and tie the address bits[63:40] of the DWC3_usb3 to 0", so it 
seems that "DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64" can 
cover 40-bit DMA or 48-bit DMA.

