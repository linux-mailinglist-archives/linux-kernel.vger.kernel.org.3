Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C559ED61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiHWUft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiHWUfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:35:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757EBE7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:16:33 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C0DF6601DBC;
        Tue, 23 Aug 2022 21:16:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661285791;
        bh=JzsxxNzouivL3LyaaYX6SnjsVTmMyaN7Zhs2/j5WlOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnMaI8bqbVUHlua3CqX6Vwg6KiYF1aJ13rYtZ523ug1LHTLuFd/zVLXFhqg578FRt
         2vU/2IujnRXHlNWAJeTv4hIEObDZdoHsukdOKCXcHZ2A4+Baspwkf+nzWmwH9xu2oV
         J7+NXvPg62ewlJX+ki1OpWDesCQU8QmFjnFTzHxDDj3b8cKXzX9fmfyDeck8braTFD
         KNjpYIzjJRNXruVDPSu8nLiNkFnIHYPMffGRVRmeU8LbRSF/j2JGmxhewPxxNKsCs4
         kn1Nm4ttPomESf87rOw4JImZDDG88sKTFAcC/QN3Q9k5DMOrNaZFegAzwq0KMpvHN9
         mJxu5m0xKz/SA==
Date:   Tue, 23 Aug 2022 16:16:22 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     xinlei.lee@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3,2/2] drm: mediatek: Adjust the dpi output format to
 MT8186
Message-ID: <20220823201622.meedlqvmixf5ukdf@notapiano>
References: <1661235517-23699-1-git-send-email-xinlei.lee@mediatek.com>
 <1661235517-23699-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661235517-23699-3-git-send-email-xinlei.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 02:18:37PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dpi output needs to adjust the output format to dual edge for MT8186.
> Because MT8186 HW has been modified at that time, SW needs to cooperate.
> And the register (MMSYS) reserved for dpi will be used for output
> format control (dual_edge/single_edge).
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> ---
[..]
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
[..]
>   * @yuv422_en_bit: Enable bit of yuv422.
>   * @csc_enable_bit: Enable bit of CSC.
>   * @pixels_per_iter: Quantity of transferred pixels per iteration.
> + * @rgb888_dual_enable: Control output format for mt8186.

Let's not mention mt8186 in the description to keep the property generic. Also,
this description should say what having 'rgb888_dual_enable = true' indicates
about the hardware (in this case mt8186) and it currently doesn't.

Let's take a step back. What does 'dual enable' mean in this context and how
does it relate to 'dual edge' and the dpi output format? By answering those
questions we can find a description (and maybe variable name) that makes more
sense.

>   */
[..]
> @@ -449,6 +454,9 @@ static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
>  			     dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE ?
>  			     EDGE_SEL : 0, EDGE_SEL);
> +	if (dpi->conf->rgb888_dual_enable)
> +		mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, DPI_RGB888_DDR_CON,
> +					     DPI_FORMAT_MASK, NULL);

This if block should be further indented.

>  	} else {
>  		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, 0);
>  	}
[..]
> --- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
> @@ -235,4 +235,8 @@
>  #define MATRIX_SEL_RGB_TO_JPEG		0
>  #define MATRIX_SEL_RGB_TO_BT601		2
>  
> +#define DPI_FORMAT_MASK			0x1
> +#define DPI_RGB888_DDR_CON		BIT(0)
> +#define DPI_RGB565_SDR_CON		BIT(1)

I'm not sure if it would make more sense to have these definitions in the mmsys
header since they're configurations of a register in mmsys' iospace... I think
we can keep them here but at least add a comment above:

/* Values for DPI configuration in MMSYS address space */

Thanks,
Nícolas
