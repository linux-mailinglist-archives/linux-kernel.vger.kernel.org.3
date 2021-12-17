Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4480478F80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhLQPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:23:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37784
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231348AbhLQPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:23:55 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 210E63FFD8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639754634;
        bh=KoPA7XBSmB8os7xu1PQTPXCsP6kNd9wK5qL+vdd0vOE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eVxR6EiTsfJj4lzAU0ZFG8yfsMR7M0XSmKOpisbq6wwTCyILYbSVfQeA74q0m90By
         kksFwvS457zRJvs9OYouo/nBPn/lzlAgGMu+HSixRrEltkIDFo8oT2QyTbkDh+JjMN
         q9Bv1IFdENmZ/eTHPXCljsn6osVdp1sBqUEqCFx5PLwwLE52c3j5AGo2TyTluHe7Ut
         g1gR6+Grv4hVQJuUcsSlZ5TXH7zLJP/xfha5OwlWIDKPcFQtrWWzadls6d7/5l1Mbw
         VMZuZwEcEi5PQsOVjN4gGAuFBbWzP+qr2EYsAwBYQpVeWnHtFHS8OnJKTfwkXQpVw+
         vNen9h8rw+1XQ==
Received: by mail-lf1-f69.google.com with SMTP id w18-20020a194912000000b004254e83978cso579389lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KoPA7XBSmB8os7xu1PQTPXCsP6kNd9wK5qL+vdd0vOE=;
        b=Ftk7rNYaPkCxpxXyGfP8vid6gJyWYrNxT5R2CBfydPDqO7XRf1st+zyl1sf0d37lH+
         3ALIyNHzcdaIRZ9vFgNbeqKAGeWjJU8i1pdPH2Vd0hRz2OdXbGjxLwJKPPI0aLGSE3Ic
         7JlfaWO4ORt3Ykt4HVH5tgMLjylkHluV4CUmRde0edC9L9xUH9DdWr/Gm1IzfqBzPBFz
         is1xR5LrenTSdVSjMY63cL+1LVuH/S6Fos9qtf3k7kFEEzrf7ziW+zW+xI7Eu04KPxi5
         xZ+qxa610ED92NaC8bKy/KDlLmDq0Wa5GgG2fQXMgGLDjhqGriQRsDRxd17arTFFxNzC
         QRbA==
X-Gm-Message-State: AOAM531esPdBoMaMA/8kZhXECCIJ80XrMPZaLnZfWFuFdbG3yIpboiLr
        TSuScpdTuiSTU9WhbpGLH+t2JJsqPsucKg2b7oflYusah1enetToOTmjG+E0lvTQKhc1i29q5AJ
        6ybAQrYcyNcB1dBio6ncPaGiswlfgk+yk7fS6NhpIgw==
X-Received: by 2002:a2e:3505:: with SMTP id z5mr3081644ljz.466.1639754633470;
        Fri, 17 Dec 2021 07:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGnbf/r+o3+ydeP4IMLLDFYJCBZ2NpFU6fb0sgOrLd2TmZGpvF+9QbsAtIEqAVMqXFyKGwYA==
X-Received: by 2002:a2e:3505:: with SMTP id z5mr3081629ljz.466.1639754633264;
        Fri, 17 Dec 2021 07:23:53 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s25sm1765300ljd.39.2021.12.17.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:22:22 -0800 (PST)
Message-ID: <88ff0e3e-6709-68fc-88cb-f915dfddbe86@canonical.com>
Date:   Fri, 17 Dec 2021 16:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211217102945.17432-1-rogerq@kernel.org>
 <20211217102945.17432-4-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217102945.17432-4-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 11:29, Roger Quadros wrote:
> As more compatibles can be added to the GPMC NAND controller driver
> use a compatible match table.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c                   | 8 +++++++-
>  drivers/mtd/nand/raw/omap2.c                 | 2 +-
>  include/linux/platform_data/mtd-nand-omap2.h | 5 +++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 624153048182..814ddb45c13d 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  	u32 val;
>  	struct gpio_desc *waitpin_desc = NULL;
>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
> +	bool is_nand = false;
>  
>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> @@ -2183,7 +2184,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>  		}
>  	}
>  
> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
> +#if defined(CONFIG_MTD_NAND_OMAP2)

if (IS_ENABLED()) is preferred. If needed, you could make omap_nand_ids
symbol visible always (so without ifdef around it), because extern
structure should not have impact when not defined (if I recall
correctly...).

> +	if (of_match_node(omap_nand_ids, child))
> +		is_nand = true;
> +#endif
> +
> +	if (is_nand) {
>  		/* NAND specific setup */
>  		val = 8;
>  		of_property_read_u32(child, "nand-bus-width", &val);
> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
> index b26d4947af02..fff834ee726f 100644
> --- a/drivers/mtd/nand/raw/omap2.c
> +++ b/drivers/mtd/nand/raw/omap2.c
> @@ -2352,7 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static const struct of_device_id omap_nand_ids[] = {
> +const struct of_device_id omap_nand_ids[] = {
>  	{ .compatible = "ti,omap2-nand", },
>  	{},
>  };

I think OMAP2 NAND driver can be a module, so this should have
EXPORT_SYMBOL.

> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index de6ada739121..e1bb90a8db03 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -61,4 +61,9 @@ struct gpmc_nand_regs {
>  	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
>  	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
>  };
> +
> +#if defined(CONFIG_MTD_NAND_OMAP2)
> +extern const struct of_device_id omap_nand_ids[];
> +#endif
> +
>  #endif
> 


Best regards,
Krzysztof
