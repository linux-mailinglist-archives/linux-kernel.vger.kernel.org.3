Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE6483E60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiADInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiADIna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:43:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C54C061761;
        Tue,  4 Jan 2022 00:43:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1857F1F42495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641285807;
        bh=xG0sghhv24/za4oOpx452HZr3+LccnGXwhDhlPka2U8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HDvT9Z4iB9znD1ig1CQNGVpDIUTu3g+gD8gAt8x+lBLIcWV14QkXUns8Cj0SOzdfj
         +uXR2Mc/lZS/mw+DapadZOO0wdOaPxsQSXuAPKG3p+TDn+osD+PAYccMidqwi5JWIV
         txUfAd7Bnn3+NN4bPJtnwLSG3/KZPyrZ71IVI1ZCRkusF/QPdsIhfUtVXAUA+mLbdt
         u1O2ZLPtgOeZbLOLy4+NjESlmAoEACkWZlhC0se6LnOm/Q67Mps5yiGX8li+r17x1z
         YkpYNfu29YIUFKqCVy/3U+/6CAN3Y84BEhqp0jS9swnm2y4oT+AmVpnogAf1t76ogR
         jC44KM6IPIenQ==
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Support mt8186 scp
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-remoteproc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220103075854.10438-1-allen-kh.cheng@mediatek.com>
 <20220103075854.10438-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <39f95db9-9d52-e64c-7444-ccd8d88cc522@collabora.com>
Date:   Tue, 4 Jan 2022 09:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220103075854.10438-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/01/22 08:58, allen-kh.cheng ha scritto:
> Add SCP support for mt8186
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Hello! Thanks for the patch!
However, there's something to improve...

> ---
>   drivers/remoteproc/mtk_scp.c | 39 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 36e48cf58ed6..38eab6b86fd7 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -365,6 +365,31 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
>   	return 0;
>   }
>   
> +static int mt8186_scp_before_load(struct mtk_scp *scp)
> +{
> +	int i;
> +
> +	/* Clear SCP to host interrupt */
> +	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
> +
> +	/* Reset clocks before loading FW */
> +	writel(0x0, scp->reg_base + MT8183_SCP_CLK_SW_SEL);
> +	writel(0x0, scp->reg_base + MT8183_SCP_CLK_DIV_SEL);
> +

.............

> +	/* Turn on the power of SCP's SRAM before using it. Enable 1 block per time*/
> +	for (i = 31; i >= 0; i--)
> +		writel(GENMASK(i, 0), scp->reg_base + MT8183_SCP_SRAM_PDN);
> +	writel(0, scp->reg_base + MT8183_SCP_SRAM_PDN);
> +

.............

This snippet corresponds exactly to the mt8192_power_on_sram() helper:
please avoid code duplication by simply calling that function instead.

Thanks,
- Angelo
