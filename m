Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C134D28F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiCIGZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiCIGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:25:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B71617C4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646807089; x=1678343089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=402p/cC9Q8pxSjYD8AYMP1zGXs05qRwp767H72pcxjQ=;
  b=l/xpOozDnXY/7RbFFbYh6uqFpT2F3cUFbnRhTCb+SWDTc9/nUvzVGES7
   VenN8MucP2z35i41j4Tc5V46H3F3B0Sl9qbw2UdlQPCQXli6Klv8xBUHk
   TTr1z+62gADCCfiYMslesC2cxSqdh0c+5cg8oH5/+66CuRH5wKDepehHD
   xqK+2gJsjcld8VstHeWIf6cfJ4LIYOjRg4LxR/EJQ3y5BYSE4j6FkcuK7
   R3O7o9mWsHM6jpu0HgMP5gToYgJvKfL4LYFZEdCvtyVQbDxjXawTJ9HvK
   tyDMevlx9229oVFLL9QqtLlTBymLBq2IRaxKanKb43WtS34zZwwOovk48
   g==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="194835490"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 14:24:47 +0800
IronPort-SDR: hi1wrQg37QUKnzkRtFzjsD9ac9yU5vMn5NMsXexGGKUCCCWDOesNxnehqrUDu/iFJ+tSNBlBWr
 dIMY5+62z3DfWdA5+lqK8tgzx8CQxO2TMi4d71FLxLtwaUKR5YCM4oCVgpzZD2cmpykHVY9wA6
 uHu48QkBaCrP+Dc1yIrBRto/7WxBIJZAVM1OwAQIQ1n05R2ZKR92uG8EcLS9SULIuAZOtk7Ccb
 wmMqO56jC3jhHXC2V1wfIdsdckuPo8oQvXRUeGXrZD+I/2RV4cQe4tm4CeZmnNFEYrS+8N8qMr
 /0W7825IwD/2d3cdhgujdIZL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:56:02 -0800
IronPort-SDR: z4UmIkQZG0GHxC+4UCK3+MgcwyLeS0REdWwsxrEj9ItGXHtGtmZasSjqwsh31amQo+g8/Z8yKI
 TTHJX9gZLGqBXWL9Sq9T4px5+PeTHrYsxzLqCDv8qt27kmd/MUUUc9cm8H5Bc/jctXpEJ26HAb
 ounatoab1V2qgxJ09IiRRdeq5RfGbSphHC2sZqQ/fUlTgNfc+0aEkWlDkElMidKdWYARj2qusQ
 Rjcxk2PZCJ3a3y/2758cnkjU4DtfuhGveBF66/81us05OnqBNZIXe8FZVytylH0kv/fwYwQqRH
 Ogw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:24:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KD2H21wx8z1SVp1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:24:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646807085; x=1649399086; bh=402p/cC9Q8pxSjYD8AYMP1zGXs05qRwp767
        H72pcxjQ=; b=GIbZe5xGcclBgP/H4XXqchA/E/u8VrKvMhqFi2IPrY+aHQDCxgF
        C5DSl7EAttB/zyYmCGWUgRAfwzt6hyAht4Qyub4jWTLgGPryGlS526bSOk14Zu9m
        2zrLN7w3g6/1IsO3cZv4lAWqkidlc7ljK9+0fA7iu56/JQELqdm0Qqa+P0t0Xt+/
        BJ6sUnT5Hqhu35E+RJIArqZ7eKBThbZgh48qDk966Bq+z1GUevOcKLUvcg90KkPY
        0NLYbuIKxhxtYR61uf1LW0Nf9D7c7BSsf9YiG/nlMqyoP0ldXgnEGvz2rNBsZ6p+
        2uYKRGaJ9K9sa6PL8D+lvV9GFB8qULjCr4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IXlk4QAGHfzh for <linux-kernel@vger.kernel.org>;
        Tue,  8 Mar 2022 22:24:45 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KD2H056grz1Rvlx;
        Tue,  8 Mar 2022 22:24:44 -0800 (PST)
Message-ID: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 15:24:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220309055038.2081317-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309055038.2081317-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 14:50, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
> 	- Use more specific in the subject: ata: pata_pxa:
> 	- Switch to returning 'irq'
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..340b274d0cad 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	struct resource *cmd_res;
>  	struct resource *ctl_res;
>  	struct resource *dma_res;
> -	struct resource *irq_res;
>  	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct dma_slave_config	config;
>  	int ret = 0;
> +	int irq;
>  
>  	/*
>  	 * Resource validation, three resources are needed:
> @@ -205,9 +205,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> -		return -EINVAL;
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))

Please drop the unlikely() here. Not needed. This is not the hot path.

> +		return irq;
>  
>  	/*
>  	 * Allocate the host
> @@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * Activate the ATA host
>  	 */
> -	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
> +	ret = ata_host_activate(host, irq, ata_sff_interrupt,
>  				pdata->irq_flags, &pxa_ata_sht);
>  	if (ret)
>  		dma_release_channel(data->dma_chan);


-- 
Damien Le Moal
Western Digital Research
