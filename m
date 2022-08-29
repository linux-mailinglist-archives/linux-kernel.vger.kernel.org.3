Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD75A4685
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiH2JxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiH2JxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:53:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5A5E33C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:53:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96ED166016BE;
        Mon, 29 Aug 2022 10:53:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661766782;
        bh=tyHVP8TVsJx7dsp4RoCLCe9+RAOLMn7P+Kx5RBRj4vk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LGbv0gfi1N/Vte34r6F56RHV1wAfbo207qYXVmTbX0COv5wDShGObyvRyS94XCdqE
         PjGPoUn/p0qNc+yorYkQm/3xgtr7RIhqpRVnQ+jZz3kwh6lOju6z4JcXqPVj5sKHsb
         DYXoqtrTnge7+/082g90s3IqH24Q8aAkXlu38qo/2FnlY1+b2t3L7KcnK6Bqr5nSwJ
         QZTTmT5u79TdvTzgg46MbUalFaSv3pP06uM0nueQcSCaMzrBQKzoX4PfjTHn/P5eI5
         nh7tNeBRkO28ab7+G/26wFFze5w3UBIDsCnvFsopmmUyGKGOqqQrAenijG9VBxX3Kn
         tPghf7FU/eSYw==
Message-ID: <8ccf007b-e411-3a56-e5aa-629264cdafee@collabora.com>
Date:   Mon, 29 Aug 2022 11:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4,2/2] drm: mediatek: Adjust the dpi output format to
 MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, matthias.bgg@gmail.com,
        rex-bc.chen@mediatek.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1661743308-29120-1-git-send-email-xinlei.lee@mediatek.com>
 <1661743308-29120-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1661743308-29120-3-git-send-email-xinlei.lee@mediatek.com>
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

Il 29/08/22 05:21, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dpi output needs to adjust the output format to dual edge for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c      | 32 +++++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  5 ++++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
>   3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index fb0b79704636..c23ef7deef26 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -14,6 +14,7 @@
>   #include <linux/of_graph.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>   #include <linux/types.h>
>   
>   #include <video/videomode.h>
> @@ -28,6 +29,7 @@
>   #include "mtk_disp_drv.h"
>   #include "mtk_dpi_regs.h"
>   #include "mtk_drm_ddp_comp.h"
> +#include "mtk_drm_drv.h"
>   
>   enum mtk_dpi_out_bit_num {
>   	MTK_DPI_OUT_BIT_NUM_8BITS,
> @@ -80,6 +82,7 @@ struct mtk_dpi {
>   	struct pinctrl_state *pins_dpi;
>   	u32 output_fmt;
>   	int refcount;
> +	struct device *mmsys_dev;
>   };
>   
>   static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
> @@ -133,6 +136,8 @@ struct mtk_dpi_yc_limit {
>    * @yuv422_en_bit: Enable bit of yuv422.
>    * @csc_enable_bit: Enable bit of CSC.
>    * @pixels_per_iter: Quantity of transferred pixels per iteration.
> + * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be
> + *		       set in MMSYS.

  * @edge_cfg_in_mmsys: Edge configuration for DPI output has to be set in MMSYS.

fits in one line and it's more immediate to read.

After which...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

