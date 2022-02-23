Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6B4C184B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbiBWQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbiBWQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:15:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81DC4E0B;
        Wed, 23 Feb 2022 08:15:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 4B6071F448A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645632927;
        bh=uLwakwP+7QKWR8eipFTI5+MziZSsq1n0V6y5bky0dvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6zrFVPJcIENISvUjbXHuF7gKBP62jAgL+effeVsGwYOpsdezSb7QRZjZ797ouJP/
         6HI9BYeoiHlyaQ671tzSITXcM47cStd2R7vwp7sOIbBAM8IYyY6QiqYVa539q0FAez
         V7w9irMFCiolbqvs1p4s7LEz/hUV5EA8sSTBjM8Gy2BAIZA5n2FrlqFDQd6ilRqZgD
         LQfNAi81d6QEofNqYsRAnvkLXBNZGbXgiKiCkTtLQVXL4eUVUwhKU+YV0ULIc5Siy/
         CUpgnjYOKT//3K0EfX/ZC1eulWw+WvksKLaCXnRfBFZRyECXQVeHyfaa/5WUnEK+Am
         LFPZEhN8AIsdQ==
Date:   Wed, 23 Feb 2022 11:15:22 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: mt8183: jacuzzi: Fix bus properties in
 anx's DSI endpoint
Message-ID: <20220223161522.522ps5jmwizpgqij@notapiano>
References: <20220214200507.2500693-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214200507.2500693-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping for this patch :). It's an important fix to get the display working
again on mt8183-kukui-jacuzzi, and also one of the requirements for us to get
IGT running on that platform in KernelCI :).

Thanks,
Nícolas

On Mon, Feb 14, 2022 at 03:05:07PM -0500, Nícolas F. R. A. Prado wrote:
> mt8183-kukui-jacuzzi has an anx7625 bridge connected to the output of
> its DSI host. However, after commit fd0310b6fe7d ("drm/bridge: anx7625:
> add MIPI DPI input feature"), a bus-type property started being required
> in the endpoint node by the driver to indicate whether it is DSI or DPI.
> 
> Add the missing bus-type property and set it to 5
> (V4L2_FWNODE_BUS_TYPE_PARALLEL) so that the driver has its input
> configured to DSI and the display pipeline can probe correctly.
> 
> While at it, also set the data-lanes property that was also introduced
> in that same commit, so that we don't rely on the default value.
> 
> Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> v2: https://lore.kernel.org/all/20220201174643.843102-1-nfraprado@collabora.com
> v1: https://lore.kernel.org/all/20220120224204.773117-1-nfraprado@collabora.com
> 
> Changes in v3:
> - Added missing Reviewed-by
> 
> Changes in v2:
> - (thanks Rob) Use proper format when refering to commit in commit
>   message as pointed out by checkpatch
> 
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 8f7bf33f607d..e8f133dc96b9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,6 +171,8 @@ port@0 {
>  
>  			anx7625_in: endpoint {
>  				remote-endpoint = <&dsi_out>;
> +				bus-type = <5>;
> +				data-lanes = <0 1 2 3>;
>  			};
>  		};
>  
> -- 
> 2.35.1
> 
> 
> -- 
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.
