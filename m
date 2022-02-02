Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B94A78A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbiBBTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:20:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41010 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBBTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:20:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212JK4ND120200;
        Wed, 2 Feb 2022 13:20:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643829604;
        bh=Rz47yo2CsOvSbBUqTAu/MeC9oxThZqNB7BiBBAeBZfE=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Jvsv4wGbs+1GgJLy+NpYwrQ/IYEXLFSOPYPkeyDB+J7J0MjUYxlevRtwlCv5QRAAc
         zRdL3Rt2Ec1QaTAnv1QA17X9Yk/slfIjkHxoYFOYYTNrS+1X/Sr4ISnLR4A3BZkbF8
         tWOWEYzO94ll3CgtsK0JUTyE5F6Cry7WPyeYUD3Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212JK4Le130248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 13:20:04 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 13:20:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 13:20:03 -0600
Received: from [128.247.81.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212JK33r043456;
        Wed, 2 Feb 2022 13:20:03 -0600
Message-ID: <9848466d-6307-8f74-87b6-e3f050651c8d@ti.com>
Date:   Wed, 2 Feb 2022 13:20:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220114062840.16620-1-linmq006@gmail.com>
From:   Dave Gerlach <d-gerlach@ti.com>
In-Reply-To: <20220114062840.16620-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 1/14/22 00:28, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
> 
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
> 
> Fix the check of return value to catch errors correctly.
> 

Looks good to me.

Acked-by: Dave Gerlach <d-gerlach@ti.com>

> Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/soc/ti/wkup_m3_ipc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 72386bd393fe..2f03ced0f411 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -450,9 +450,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>  		return PTR_ERR(m3_ipc->ipc_mem_base);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (!irq) {
> +	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq resource\n");
> -		return -ENXIO;
> +		return irq;
>  	}
>  
>  	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
