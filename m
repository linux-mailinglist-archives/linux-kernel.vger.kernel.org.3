Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81035531B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350349AbiFUMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiFUMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:11:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC672B266;
        Tue, 21 Jun 2022 05:11:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C68D96601795;
        Tue, 21 Jun 2022 13:11:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655813500;
        bh=DKwtRGko3s5x/gAEoSQN2wLREgvcMu85ngMm3S7JYTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RU8k6ptkWXi/VlsfNEeonqcHZ+3DSgxSgiDRQ67KyoHDfrOWVfRB77VoeXy0YqlA2
         Mandvf5OUdDTtzOGPfvBSjD9pj0KNxEnA3flVT7hfINGK44mnlcozfLAbl8AOuGeLR
         Yfkahl2xmpLifqJrbwMUFptUspYq79F+ffMQcR3a0UBkZj1xwcS8JEEk5PpcctE1UC
         Pc78W8mcAmAwhw4IczNjEBJsyZAyBtQmmiRYM+1ktwnkevNVusS6LpOp9/EOmKxx/+
         QnT6ycnQo2XkQRWrWg3q6NtdABnJh0gvD2wlMAdzUOkL6gksxEnl/33+kA+kJ1VbBK
         BrTtygaCgqV5w==
Message-ID: <55c98626-9b95-7721-94cf-8c471580a53b@collabora.com>
Date:   Tue, 21 Jun 2022 14:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 12/14] drm/mediatek: dpi: add config to control
 setting of direct connection to pins
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
 <20220621113732.11595-13-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220621113732.11595-13-rex-bc.chen@mediatek.com>
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
> MediaTek dpi supports direct connection to pins while dp_intf does not
> support. Therefore, add a config "support_direct_pin" to control this.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 438bf3bc5e4a..ef7f828a4b1e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -129,6 +129,8 @@ struct mtk_dpi_yc_limit {
>    * @is_ck_de_pol: Support CK/DE polarity.
>    * @swap_input_support: Support input swap function.
>    * @color_fmt_trans_support: Enable color format transfer.
> + * @support_direct_pin: Dpi can directly connect pins, and enable this config
> + *			to do this.

@support_direct_pin: IP supports direct connection to pins

or

@support_direct_pin: IP has direct connection to DP pins

or

@support_direct_pin: IP connects directly to DP pins

pick one, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


