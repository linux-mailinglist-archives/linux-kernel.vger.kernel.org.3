Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A334E5CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbiCXBMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347103AbiCXBMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:12:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027B92304
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648084274; x=1679620274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K/sJ8bKhUciZIRzZUdPxmJL072OHBKzj5AY5uZaH5KY=;
  b=VdPGkiK2e5nHUCOZe1KkDXwnQE3O2VqMq3750TlNgOveNx2WFov487md
   JtRALPgTo799FKYexA0l+62PEd+NlENir/FWTZoq8yGxBRdTxovGDPZQt
   Q2Z697JH2BBbufQEydvYMbZ7tLdAiV616wlDUjCg4XE/hkb6cTh5+zyUS
   /c0yK7jbIlKod5zUKZAVBpGjwheYJgIRWLPxlR05ZcZfCR7ckZvippMEd
   6TSWynGu+V8okVVxV5nQYTvn7mW6WrNbuXvMqetDknDUng8go+g+Y0o89
   xSeqG8UYImkF0bYU43RSKPuYli4LZVNgO3Sx+9TBjKDiYMuEAMykM675M
   g==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="196121335"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:11:12 +0800
IronPort-SDR: 2Ack7JwVycFk2dD7u1UQv5LF3tx2Rojimz4nMMJ5yxtDnoka768PRTwsCpPg5z51VNCK6LpSqy
 B7ycedw9hZX3P1QWBmY20w8NA3hAwf/VYrSWXZoogw/3hV8yxSTTKKsIZdrSKl+EZqVjqwEJaz
 yHQkBOWAbBGY/mNO5dIgienyRi5vGR3d+k0Gow5WBJcqUgdc9JcNOtQjBvqkzjIGkG57mbmfOI
 65phDXD/2tW3D1yi+8Fw/dgNkvgEK0MhW3ea8W4TCKSgAJB1QFXqBpT3CcG9/RXRhvUJxvTzmt
 G+1KKLhrSdT8USw9I6WYpYl3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:43:05 -0700
IronPort-SDR: uxb24KKfKzZR8wiegOCh8CQx5bx4vm/CzOK6g5Y7Dw1j9pnr6tPhM2BY5dq+F1jH1Ga2EfYBKF
 4OmlvppCo0Rl3xUjtZ6+sH8SE+S3b+0qnB1IwY3VD7sa/SC3YxNbLpOHINvYb9oj3WxEG+bFw/
 ElNsDY/ZVGqTZ6OcplTWG3ZQMQqMteVhxY8vqhp2lnW+n4PfioefOUDrrwhgiiAjRVZHcVUOH4
 K5trHlxonv24hA9+Nw5GmuULIXCBcejIgECQfKE2Bm5HbZtMd7IaWQBB4o8nhPlriUlL1lppnN
 nTs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:11:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP6cJ4rzcz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:11:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648084271; x=1650676272; bh=K/sJ8bKhUciZIRzZUdPxmJL072OHBKzj5AY
        5uZaH5KY=; b=hsGGWUJ0a5Vaz/7o4Nq+f774W1IerSJsvSoveT/AZB9F/670ZKf
        +Jsu/5IPj5Cvq7qs5tP2YsWJPg0yAIHr/XW+xNORShkiSMN8UTKXsoObW7LD42uE
        Gy2+KL3B6dUXNX3ZFNXKkhlaLWtOh0y3gDqV4GNHyQI8W8bdRSQjqJnF03pneiR9
        3si9L/7jdXscINTi0Po1BPXbalFX6qPrcBbM3iHzjiZmtaCgvZc5jUTFQ+pj2Jn8
        T7ZsHxk4w/4bImJihAOeAXM2ZlXI2flAfHtSVHupcC4PbFQ0CQgaLeFG/MOfhAUX
        tQHEA6Fu1MHzwJhgEIy0EUcbzQadp4kIZrA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DsdWUNn_FK9g for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 18:11:11 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP6cG20Ghz1Rvlx;
        Wed, 23 Mar 2022 18:11:10 -0700 (PDT)
Message-ID: <ff109d7a-e308-3ce0-b7aa-0905e101e5fd@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:11:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 04/21] ata: libahci_platform: Convert to using handy
 devm-ioremap methods
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-5-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-5-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Currently the IOMEM AHCI registers space is mapped by means of the
> two functions invocation: platform_get_resource() is used to get the very
> first memory resource and devm_ioremap_resource() is called to remap that
> resource. Device-managed kernel API provides a handy wrapper to perform
> the same in single function call: devm_platform_ioremap_resource().

> 
> While at it seeing many AHCI platform drivers rely on having the AHCI CSR
> space marked with "ahci" name let's first try to find and remap the CSR
> IO-mem with that name and only if it fails fallback to getting the very
> first registers space platform resource.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 1bd2f1686239..8eabbb5f208c 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -404,11 +404,13 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  	devres_add(dev, hpriv);
>  
> -	hpriv->mmio = devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");

See __devm_ioremap_resource(): if there is no resource named "ahci" found,
then this will print an error message ("invalid resource\n"). That may
confuse users as this error message was not present before. So you may
want to change this code to something like this:

/*
 * If the DT provided an "ahci" named resource, use it. Otherwise,
 * fallback to using the default first resource for the device node.
 */
if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
	hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
else
	hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
if (IS_ERR(hpriv->mmio)) {
	rc = PTR_ERR(hpriv->mmio);
	goto err_out;
}

>  	if (IS_ERR(hpriv->mmio)) {
> -		rc = PTR_ERR(hpriv->mmio);
> -		goto err_out;
> +		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(hpriv->mmio)) {
> +			rc = PTR_ERR(hpriv->mmio);
> +			goto err_out;
> +		}
>  	}
>  
>  	for (i = 0; i < AHCI_MAX_CLKS; i++) {


-- 
Damien Le Moal
Western Digital Research
