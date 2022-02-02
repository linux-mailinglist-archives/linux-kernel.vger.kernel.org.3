Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B354A6D73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbiBBJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:03:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiBBJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:03:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C0FAC1F44279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643792617;
        bh=ViQMSZyem2MB0mucYiFAcZf2AlB+Sx22LpjdHO5YXF0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b1RRKral5pgotlT6/jsPB+u1VgcTZt1FRG7f2Er6wgkECZsykAIVxS2Nun0z4mTeo
         q/7Kkirv9qIpyJBbD/SOYgFQifaE/65xIkE09at9DlJO/IoM6q+S59z6BrWr7JhhgF
         EiuW2pLioSCLXtKvwlYFbQbohL8u5aa58DrXHDoBacOP0c6ipDEKOTYd+L1KUi10OA
         xRkwKskoXoTGTe1YmhFRaarO1tH/wPe3DeLIT4KEwx7RP2FU0wNGyHHROw7Phf3erO
         buErqVINDQhsx9hyD8w9sJrRd7WnkDUZQKtHJrhWNwLr9NO+3VxKGzxm4qq1tvJr4n
         0w9chva8H2eLw==
Message-ID: <91fff43a-c85d-2934-b54b-67ffe6fc2f29@collabora.com>
Date:   Wed, 2 Feb 2022 10:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/3] remoteproc: mtk_scp: Use dev_err_probe() where
 possible
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220124120915.41292-1-angelogioacchino.delregno@collabora.com>
 <20220124120915.41292-3-angelogioacchino.delregno@collabora.com>
 <20220201183612.GC2490199@p14s>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220201183612.GC2490199@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/22 19:36, Mathieu Poirier ha scritto:
> Hi Angelo,
> 
> On Mon, Jan 24, 2022 at 01:09:15PM +0100, AngeloGioacchino Del Regno wrote:
>> Simplify the probe function, where possible, by using dev_err_probe().
>> While at it, as to increase human readability, also remove some
>> unnecessary forced void pointer casts that were previously used in
>> error checking.
> 
> I am in favour of all 3 patches (please add a cover letter next time) but weary
> about testing - do you have access to a Mediatek platform to try this on or
> is it purely theoretical?
> 
> I would definitely feel better to see a "Tested-by" tag by someone out there
> with access to the HW.
> 
> Thanks,
> Mathieu
> 

Hello Mathieu,

I have multiple MediaTek platforms and I always test on all of them before
pushing such commits upstream, so, even though this kind of patch is trivial,
this is *not* purely theoretical and I confirm that this was successfully tested.

Regards,
Angelo

>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/remoteproc/mtk_scp.c | 28 ++++++++++++----------------
>>   1 file changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
>> index e40706b0e015..dcddb33e9997 100644
>> --- a/drivers/remoteproc/mtk_scp.c
>> +++ b/drivers/remoteproc/mtk_scp.c
>> @@ -757,10 +757,8 @@ static int scp_probe(struct platform_device *pdev)
>>   	int ret, i;
>>   
>>   	rproc = devm_rproc_alloc(dev, np->name, &scp_ops, fw_name, sizeof(*scp));
>> -	if (!rproc) {
>> -		dev_err(dev, "unable to allocate remoteproc\n");
>> -		return -ENOMEM;
>> -	}
>> +	if (!rproc)
>> +		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
>>   
>>   	scp = (struct mtk_scp *)rproc->priv;
>>   	scp->rproc = rproc;
>> @@ -770,21 +768,20 @@ static int scp_probe(struct platform_device *pdev)
>>   
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
>>   	scp->sram_base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR((__force void *)scp->sram_base)) {
>> -		dev_err(dev, "Failed to parse and map sram memory\n");
>> -		return PTR_ERR((__force void *)scp->sram_base);
>> -	}
>> +	if (IS_ERR(scp->sram_base))
>> +		return dev_err_probe(dev, PTR_ERR(scp->sram_base),
>> +				     "Failed to parse and map sram memory\n");
>> +
>>   	scp->sram_size = resource_size(res);
>>   	scp->sram_phys = res->start;
>>   
>>   	/* l1tcm is an optional memory region */
>>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
>>   	scp->l1tcm_base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR((__force void *)scp->l1tcm_base)) {
>> -		ret = PTR_ERR((__force void *)scp->l1tcm_base);
>> +	if (IS_ERR(scp->l1tcm_base)) {
>> +		ret = PTR_ERR(scp->l1tcm_base);
>>   		if (ret != -EINVAL) {
>> -			dev_err(dev, "Failed to map l1tcm memory\n");
>> -			return ret;
>> +			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
>>   		}
>>   	} else {
>>   		scp->l1tcm_size = resource_size(res);
>> @@ -792,10 +789,9 @@ static int scp_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	scp->reg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>> -	if (IS_ERR((__force void *)scp->reg_base)) {
>> -		dev_err(dev, "Failed to parse and map cfg memory\n");
>> -		return PTR_ERR((__force void *)scp->reg_base);
>> -	}
>> +	if (IS_ERR(scp->reg_base))
>> +		return dev_err_probe(dev, PTR_ERR(scp->reg_base),
>> +				     "Failed to parse and map cfg memory\n");
>>   
>>   	ret = scp->data->scp_clk_get(scp);
>>   	if (ret)
>> -- 
>> 2.33.1
>>


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
