Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC154E279
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377113AbiFPNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFPNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:49:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A283EF1A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:49:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n1so1718014wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vMYX8vVEMVSTBnRO4T8a2iTEzySbI9JJmfib14Jv9h0=;
        b=oHZ/WlVy8bLQzX5XPSluY6fi8t4wrJHCh2DNNHWAK5yiyH5xZ9COwCQrs9ZfP+6ptJ
         93ySFOJe9wfCGwWXgHnar7m/6aGDnD0S1O+HxPC6xSk+cexyKjWkbP7CtFeceQJSn23R
         v1G63z1Dcox5wBclBjv9DRSavVbCjhO7hmFUmwX86Rnry/7oE4lazYOsHA8QrlPHgztj
         uR4PVch1A9250cKszi6i7e8YGVJtaKtiXz8JGxthLI1rLdfhbPsSKvbHGV5eoaEnr6rT
         Du4Tomd7n70SIuNSI7H8BbB7wi5Tzqpa8naYoVpfCcP1QttROIseu+D9zm/KshxSL+jU
         h+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vMYX8vVEMVSTBnRO4T8a2iTEzySbI9JJmfib14Jv9h0=;
        b=lcOxl/b9o4uI9fKaCnOPRgH2PmBSjWRPJELhuKmUzpFDdok9k0EOH6ONcLZr4RVh4z
         UZEaiTrK3cEE3DmD6jgFLP0We6I/fub5NpM2kO1O2k9tN+QX7RmOgqpRh1HKsaBSvZsJ
         miT4CXvV/hDCI+h98Y00TkAUACqQpctMkcQLzKR3nPB7iqkDeWfnCw50po10vpFli97n
         zMBRb4hkQe0AS9Hzyo4ElsqtAJWGjUoUIQpM1Xo2FfeEJZO23xqurDUNSXZVprMwvw5v
         QoaYKEvUWPaAeNcR9PxtkaVC9tZuWpgv1lJjyQrpnIu/pGnvQkJZ+IxuMKqhRtoE+DpV
         N8rg==
X-Gm-Message-State: AJIora8k/v+aGr0Y5bTnc5KvtmTTnpxra+ILxz1K7VJyKnJyW0bLeQBM
        HqNMjM8aqDZjjDqVX+mveY8=
X-Google-Smtp-Source: AGRyM1s9twy4XfOTRNf07Dn5/dC+PXKASOKIAn/okFRK8bJikDResr8hjVSbZIf2IlwH1J8fURxW2Q==
X-Received: by 2002:a05:6000:170e:b0:218:3fe0:7c72 with SMTP id n14-20020a056000170e00b002183fe07c72mr4971478wrc.572.1655387386601;
        Thu, 16 Jun 2022 06:49:46 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0039c5497deccsm13646132wmq.1.2022.06.16.06.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:49:45 -0700 (PDT)
Message-ID: <22c40a7f-d759-5b4a-f554-cf679102d91f@gmail.com>
Date:   Thu, 16 Jun 2022 15:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616054203.11365-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 07:42, Yong Wu wrote:
> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
> larb is parsed fail(return -EINVAL), we should of_node_put for the 0..i
> larbs. In the fail path, one of_node_put matches with of_parse_phandle in
> it.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3b2489e8a6dd..ab24078938bf 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1071,12 +1071,12 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   

Don't we need to call the goto also on error case of:

larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);


Regards,
Matthias


>   		plarbdev = of_find_device_by_node(larbnode);
>   		if (!plarbdev) {
> -			of_node_put(larbnode);
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			goto err_larbnode_put;
>   		}
>   		if (!plarbdev->dev.driver) {
> -			of_node_put(larbnode);
> -			return -EPROBE_DEFER;
> +			ret = -EPROBE_DEFER;
> +			goto err_larbnode_put;
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
> @@ -1107,9 +1107,20 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>   	if (!link) {
>   		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_larbnode_put;
>   	}
>   	return 0;
> +
> +err_larbnode_put:
> +	while (i--) {
> +		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> +		if (larbnode && of_device_is_available(larbnode)) {
> +			of_node_put(larbnode);
> +			of_node_put(larbnode);
> +		}
> +	}
> +	return ret;
>   }
>   
>   static int mtk_iommu_probe(struct platform_device *pdev)
