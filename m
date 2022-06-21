Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70D5531B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348730AbiFUML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiFUMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:11:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AF2B26A;
        Tue, 21 Jun 2022 05:11:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5399D6601795;
        Tue, 21 Jun 2022 13:11:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655813505;
        bh=HlUSN22NItfpRsSQU5D6uXf4MKq/qtRGbjiKMjx6BEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xh/O0r+4jW6DD8KtuCLF/cB7PbLmuWQCFSb/Rk6xfXWG44FeHJgH9DAz5i8yICzd6
         ypNFC8ekgND9bQe6etipNxNOvJaCfgmHfNX9Ke7MNkaxhzooYZ6dRJEieFXBbt/0Ja
         3M+AAFvgDdA5VF9pDwj2XMEciiFlE6jNnLHhHt0m4MKu8ooWzei9+bzmtDHbfrGuG2
         cbl5tYRQLoQu9De0aDhvJW5bwifRUvXZo0KA/MjTc1hhDCj+nk/h8+QbQPQspeehT5
         Ik4VdEbVoReCWNF3FZ+ljhSDkVyXrbZl5mhoa2+itJTOu4gnYv+Us5tsqNed+dGfKy
         aoHAZ0PpjDSCQ==
Message-ID: <98679256-5903-3923-dcaf-5a965174e049@collabora.com>
Date:   Tue, 21 Jun 2022 14:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 11/14] drm/mediatek: dpi: Add YUV422 output support
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220621113732.11595-1-rex-bc.chen@mediatek.com>
 <20220621113732.11595-12-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220621113732.11595-12-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/06/22 13:37, Bo-Chen Chen ha scritto:
> Dp_intf supports YUV422 as output format. In MT8195 Chrome project,
> YUV422 output format is used for 4K resolution.
> 
> To support this, it is also needed to support color format transfer.
> Color format transfer is a new feature for both dpi and dpintf of MT8195.
> 
> The input format could be RGB888 and output format for dp_intf should be
> YUV422. Therefore, we add a mtk_dpi_matrix_sel() helper to update the
> DPI_MATRIX_SET register depending on the color format.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c      | 34 ++++++++++++++++++++++++-
>   drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  3 +++
>   2 files changed, 36 insertions(+), 1 deletion(-)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> index 3a02fabe1662..65fce11316b7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -217,4 +217,7 @@
>   
>   #define EDGE_SEL_EN			BIT(5)
>   #define H_FRE_2N			BIT(25)
> +
> +#define DPI_MATRIX_SET		0xB4
> +#define INT_MATRIX_SEL_MASK	(0x1F << 0)

Please, change INT_MATRIX_SEL_MASK: that's GENMASK(4, 0).

After that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   #endif /* __MTK_DPI_REGS_H */


