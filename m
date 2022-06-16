Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2354E1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbiFPN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377215AbiFPN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:28:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD708248E5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:28:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g4so1876444wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8h+FpcXrrgVVoUz/iXyZW+h/bqUW6xveKHdamK/cuQc=;
        b=a998jYD2CZKZZJVPrXyeBC/bJFux5MWHfso4bLTv11q7pyesMZCgv6WDOku9YPqUvN
         FDO7eR32YMlOe5kqaNv2yHLYNYJoiH6vO2OsGb8ebqOlPhV7cgdAwR1XqfKuhU6XIxMC
         PbYddJwmRfjU352RIVPwrjRL0TvqL9DkN3gq9ORZzp2kx06lrCfYe4G1JqzzvCf9MtJ2
         IIf+uhCuWz9ReVq4LmWp8OK/fNqP6QpLWUJtZKS4JxpCMjvqewjRX21/4VV938rWiKhr
         2IErU1R/CFnngTA39KwYkqVv+idN2Xl0GNfF2QS4Up29Yg8c753g4dUoRGvuNYzYhcgp
         qy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8h+FpcXrrgVVoUz/iXyZW+h/bqUW6xveKHdamK/cuQc=;
        b=WUDeJGFYGd9x5NmpU2UqJlPBXUCWUQcbxbNNVKUanRgy0+7dBYi3rrHr07df8j0Ank
         5dbol8R0sVr1lpZhZAW0t5b+oNi+cPB+4ydWCJIhngib5dtoxoUYlb+FcasZ/UEFQ1Qh
         wEehxURT7SPDr5SByGlNY5hJ5XLRc4et7sL3xT7La0wSgTThINExxcdVEoqYAFVDqcy3
         5yXvTQ9D2ImE58FLGNIu6fdRr2MduvGKCibWVR9lilYE8FNMff47/XmShz3ZnMNabWD4
         BdyZuvYrXF88tHvauZbFIZVpOx/BcRmfWyr08pbfm3RL8p4eFqZnc5Bckf17w+j2DObc
         hYog==
X-Gm-Message-State: AJIora/4q0FXP2RdN5wgByLMIhaqJJ9f3cAU7VWowdJFuWRtSh4D3/3i
        xjwsNgD3Va4wKbGKkl3NqO8=
X-Google-Smtp-Source: AGRyM1unnhtSqt7GBcBXkXPGLTuYxnFiOMYFOgsWaPoDEka0FPVYkml3TItU5PtGNRR2Jfz0hmT2dg==
X-Received: by 2002:adf:fe90:0:b0:210:7e22:186e with SMTP id l16-20020adffe90000000b002107e22186emr4837864wrr.321.1655386115274;
        Thu, 16 Jun 2022 06:28:35 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id bg27-20020a05600c3c9b00b003974d0d981dsm6360986wmb.35.2022.06.16.06.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:28:34 -0700 (PDT)
Message-ID: <085be77f-3833-628e-b76a-b2b888db3b78@gmail.com>
Date:   Thu, 16 Jun 2022 15:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/5] iommu/mediatek: Use dev_err_probe to mute
 probe_defer err log
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
 <20220616054203.11365-2-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616054203.11365-2-yong.wu@mediatek.com>
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



On 16/06/2022 07:41, Yong Wu wrote:
> Mute the probe defer log:
> 
> [    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
> [    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3b2489e8a6dd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1204,7 +1204,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>   		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
>   		if (ret) {
> -			dev_err(dev, "mm dts parse fail(%d).", ret);
> +			dev_err_probe(dev, ret, "mm dts parse fail.");
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
