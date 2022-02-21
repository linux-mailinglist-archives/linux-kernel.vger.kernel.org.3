Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD884BE2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377878AbiBUOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:32:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377864AbiBUObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:31:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCF22513;
        Mon, 21 Feb 2022 06:31:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9BD311F437D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645453868;
        bh=N4Q5wrYBCEyiwQyMO1QGIB213vHWLXUeGyE8Au/Swq8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=JRVIx99hM8g0lJMG67zLddemt5gjDyjZUbDkYQbSqtrBmsi82foU/EAk4UNAufyLe
         Y00fiAtDkBFmyCX+li9ig3sc1ZE8ftZNVDIvh1bVV58hAQvnEIpOry6qvo/xLRIcrD
         LI0EKe4zonX5xyEZRPM4ypRqrTc3pS5Q5KgL2cxbedw6jLN/5G4k+lM7TOdHvkl/BP
         8UJU+RI26fI1cbrO4eWVN6ieNyqYWhk02U8pOMpbrJUKWEoqZ3yjLD9YvKFfIXHsZg
         y/oc6efDT4+LFvLxarPxYeEDexrDj7Tki1D2wlLI7SbWAjBm/5Yiuk8H6rM38Jc6xc
         Q2P67OHDdcqOA==
Message-ID: <ac28d599-3fe3-96d2-a8a9-b32fff2e7a89@collabora.com>
Date:   Mon, 21 Feb 2022 15:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 09/19] drm/mediatek: dpi: move dimension_mask to board
 config
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-10-granquet@baylibre.com>
Content-Language: en-US
In-Reply-To: <20220218145437.18563-10-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> Add flexibility by moving the dimension mask to board config
> 

You should really fix both title and description for this commit,
as this is moving hvsize_mask, not dimension_mask.
Also, s/board/SoC/g.

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 8ca3455ed64ee..0d3acd08ea358 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -129,6 +129,8 @@ struct mtk_dpi_conf {
>   	bool swap_input_support;
>   	// Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift)
>   	u32 dimension_mask;
> +	// Mask used for HSIZE and VSIZE (no shift)

C-style comments please

> +	u32 hvsize_mask;
>   	const struct mtk_dpi_yc_limit *limit;
>   };
>   

