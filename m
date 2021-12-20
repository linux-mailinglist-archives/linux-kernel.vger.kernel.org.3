Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BF47A7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhLTKsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLTKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:48:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB3C061574;
        Mon, 20 Dec 2021 02:48:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBE31B80E33;
        Mon, 20 Dec 2021 10:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8C0C36AE8;
        Mon, 20 Dec 2021 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639997311;
        bh=/NSsQes1J6WO5yIuZj0nTzaqt1pu+ZA3HTbUn4zWOmc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sECi3Batpy9APxumOzMNhpwUC4WcmGcMd+MZnM/nJ3LD60GznYoRjC0TV+RfiOqJ3
         Muo7dzIrk6/5LF+Tf1FDdDSEuF2NAkrcAFi0JK0VtQXNuFcT2oI2UkU409i2wd5kSN
         CK//zbHAIcIx1BsBodFeHaqheW8PHQs+2deks7huyz8e2yXs0O90f/zOa4E2IHSWSV
         aE+foku0FGpTxDNddSUS/xATFeg5e52ZFs5v08RyScZc8l4WH2wxpHw8Yv68UnccC/
         kRQ/xl6BbMeU7BVbCShPu3dTBUY4GeAKOAN7Rs1BibrgAUpnyGX+pXEizihxS1qHrD
         UUf2AogLs0Tpg==
Subject: Re: [PATCH 5/6] usb: cdns3: Use platform_get_irq_byname() to get the
 interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220010411.12075-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <95e016e9-4259-c1d6-f73c-ad79b7cef413@kernel.org>
Date:   Mon, 20 Dec 2021 12:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220010411.12075-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2021 03:04, Lad Prabhakar wrote:
> platform_get_resource_byname(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_byname().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/usb/cdns3/cdns3-plat.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 4d0f027e5bd3..dc068e940ed5 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -65,13 +66,14 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, cdns);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
> -	if (!res) {
> -		dev_err(dev, "missing host IRQ\n");
> -		return -ENODEV;
> -	}
> +	ret = platform_get_irq_byname(pdev, "host");
> +	if (ret < 0)
> +		return ret;
>  
> -	cdns->xhci_res[0] = *res;
> +	cdns->xhci_res[0].start = ret;
> +	cdns->xhci_res[0].end = ret;
> +	cdns->xhci_res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(ret);
> +	cdns->xhci_res[0].name = "host";
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
>  	if (!res) {
> 

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger
