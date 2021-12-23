Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6547E8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbhLWUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:36:53 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:37608 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245049AbhLWUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:36:52 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 818AB2090F74
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 2/4] ata: pata_platform: Merge pata_of_platform into
 pata_platform
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <dc6c931f-493e-cb94-b62c-cb9b87e393ec@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d5173a9a-2221-4209-7c34-afdbb7d7e7c5@omp.ru>
Date:   Thu, 23 Dec 2021 23:36:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dc6c931f-493e-cb94-b62c-cb9b87e393ec@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 11:30 PM, Sergey Shtylyov wrote:

[...]
>> Merge the OF pata_of_platform driver into pata_platform. While doing so
>> drop usage of platform_get_resource() and use platform_get_irq_optional().
> 
>    Sounds like you need a separate patch for doing that... 
> 
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]
>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>> index cb3134bf88eb..d1f7f4d65316 100644
>> --- a/drivers/ata/pata_platform.c
>> +++ b/drivers/ata/pata_platform.c
[...]
>> @@ -168,23 +178,81 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> [...]
>> -static int pata_platform_probe(struct platform_device *pdev)
>> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
>> +				      struct pata_platform_priv *priv)
>>  {
>> +	struct device_node *dn = ofdev->dev.of_node;
>>  	struct resource *io_res;
>>  	struct resource *ctl_res;
>>  	struct resource *irq_res;
>> +	int pio_mode = 0;
>> +	int irq;
>> +	int ret;
>> +
>> +	io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
>> +	ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
>> +	irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
>> +	if (!io_res || !ctl_res || !irq_res)
>> +		return -ENOMEM;
>> +
>> +	ret = of_address_to_resource(dn, 0, io_res);
> 
>    Why not switch to platform_mem_or_io() -- either before or after this patch?
> 
>> +	if (ret) {
>> +		dev_err(&ofdev->dev, "can't get IO address from device tree\n");
>> +		return -EINVAL;
>> +	}
>> +	priv->io_res = io_res;
>> +
>> +	ret = of_address_to_resource(dn, 1, ctl_res);
> 
>    Ditto.
> 
>> +	if (ret) {
>> +		dev_err(&ofdev->dev, "can't get CTL address from device tree\n");
>> +		return -EINVAL;
>> +	}
>> +	priv->ctl_res = ctl_res;
>> +
>> +	irq = platform_get_irq_optional(ofdev, 0);
> 
>    Contrariwise, either keep the old code and update it in pata_of_platform before

   s/either keep the old code and//. 

> this patch or do it after this patch. Otherwise it seems somewhat inconsistent WRT
> the of_address_to_resource() calls which you don't convert...

[...]

MBR, Sergey
