Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F056BD83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiGHPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiGHPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:34:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60311A3A6;
        Fri,  8 Jul 2022 08:34:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so12598383wmn.4;
        Fri, 08 Jul 2022 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MAqLoi+55aml5N6fFSPK1rUqMXnOHduR/XoxC2k56IQ=;
        b=aBInTkdfKEbuCecWBfZTYBsX4pUvITVCPZg6LYSP+R7TTijdbEIlhjuLniqz7iqDLT
         N9lputlg96scgD8vmFch3VKZPdBFs/4Rtus1IKiZdq3vIYYqOuH+FgGK9SGDdxSHfaMx
         tVd+lRAUvCiR9C356gGavD38VLJr+ahNtI8b4EjlHmpeL4swe+YMSW03QZzPf/6kiNCz
         Z76F1yjmN02kgpKeQiRhk6CBIIldbqJJRfvkzyrmsamXW4Qdc2KyCsov3mK3lpg8pQ8G
         zN8jifKQG265+LEqfqGKruL1+PJ5STxAxnRHHeQ+PLfPJqFxaZHc+Wr5fQKPnID194vE
         +wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MAqLoi+55aml5N6fFSPK1rUqMXnOHduR/XoxC2k56IQ=;
        b=Mtk6V8vCSA2S0+y1yEm9WCa4JTcqqhBh5foLWBWnfdBon42jfBGrAcpG4Md7ECealk
         t+72KMGu8Ee/M0mToOABoGjkGAV2XH+mYfsWOgsCBTAXISLSFBIXIIUreWYzZ21+kDXQ
         h5vewHX5/udgf1/LXolFDJE4tPuUJXkCYuvSoz50EVZdr7Nb9GdoMj21+JcU08d/WMPz
         2lBAC4pXeRhh/6cKyepGrEQTHkUh8tr39ykYQuieIPon0r8ebvO90W8ytftcJg0J0L7e
         QejsjH9sqdsGfpCBjHPmv9ylcK0v4pigLbYVG+yjw+c79sB7R4EGtSQN5uS9VCRWrPIH
         b2gw==
X-Gm-Message-State: AJIora8VMHkhYXmqkZdKZfYWCr6QOFy6rFYXFF663z78D1fTj021qqDx
        HRGvFJMbWBlZ0vcII1uWKns=
X-Google-Smtp-Source: AGRyM1vJh5BBswMOyUfeUEhKlXJeDvX61sP0BSyfepc6oJN5VGNdZqaoBvRL8zEWyyEan5Yznxgl1A==
X-Received: by 2002:a7b:cd94:0:b0:3a1:7c5c:b11d with SMTP id y20-20020a7bcd94000000b003a17c5cb11dmr393698wmj.87.1657294453162;
        Fri, 08 Jul 2022 08:34:13 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c3-20020adfef43000000b0021bab0ba755sm42956689wrp.106.2022.07.08.08.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 08:34:11 -0700 (PDT)
Message-ID: <d1a93418-587b-a03d-ed9b-01646345deeb@gmail.com>
Date:   Fri, 8 Jul 2022 17:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v24 04/10] soc: mediatek: add mtk_mmsys_update_bits API
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220622130824.29143-1-nancy.lin@mediatek.com>
 <20220622130824.29143-5-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220622130824.29143-5-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/2022 15:08, Nancy.Lin wrote:
> Add mtk_mmsys_update_bits API. Simplify code for update  mmsys reg.
> It is a preparation for adding support for mmsys config API.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 37 +++++++++++++-------------------
>   1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index a74c86197d6a..ca5bf07114fa 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -192,22 +192,27 @@ static int mtk_mmsys_find_match_drvdata(struct mtk_mmsys *mmsys,
>   	return -EINVAL;
>   }
>   
> +static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(mmsys->regs + offset);
> +	tmp = (tmp & ~mask) | val;
> +	writel_relaxed(tmp, mmsys->regs + offset);
> +}
> +
>   void mtk_mmsys_ddp_connect(struct device *dev,
>   			   enum mtk_ddp_comp_id cur,
>   			   enum mtk_ddp_comp_id next)
>   {
>   	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>   	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
> -	u32 reg;
>   	int i;
>   
>   	for (i = 0; i < mmsys->data->num_routes; i++)
> -		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
> -			reg = readl_relaxed(mmsys->regs + routes[i].addr);
> -			reg &= ~routes[i].mask;
> -			reg |= routes[i].val;
> -			writel_relaxed(reg, mmsys->regs + routes[i].addr);
> -		}
> +		if (cur == routes[i].from_comp && next == routes[i].to_comp)
> +			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask,
> +					      routes[i].val);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
>   
> @@ -217,15 +222,11 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>   {
>   	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>   	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
> -	u32 reg;
>   	int i;
>   
>   	for (i = 0; i < mmsys->data->num_routes; i++)
> -		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
> -			reg = readl_relaxed(mmsys->regs + routes[i].addr);
> -			reg &= ~routes[i].mask;
> -			writel_relaxed(reg, mmsys->regs + routes[i].addr);
> -		}
> +		if (cur == routes[i].from_comp && next == routes[i].to_comp)
> +			mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].mask, 0);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>   
> @@ -234,18 +235,10 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
>   {
>   	struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
>   	unsigned long flags;
> -	u32 reg;
>   
>   	spin_lock_irqsave(&mmsys->lock, flags);
>   
> -	reg = readl_relaxed(mmsys->regs + mmsys->data->sw0_rst_offset);
> -
> -	if (assert)
> -		reg &= ~BIT(id);
> -	else
> -		reg |= BIT(id);
> -
> -	writel_relaxed(reg, mmsys->regs + mmsys->data->sw0_rst_offset);
> +	mtk_mmsys_update_bits(mmsys, mmsys->data->sw0_rst_offset, BIT(id), assert ? 0 : BIT(id));

Let's be this a normal if (assert) else but calling mtk_mmsys_update_bits().

Other then that patch looks good.

Matthias

>   
>   	spin_unlock_irqrestore(&mmsys->lock, flags);
>   
