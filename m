Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE434A62FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiBARwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiBARwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:52:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81EC061714;
        Tue,  1 Feb 2022 09:52:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6E13A1F42650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643737922;
        bh=vjUzehLvDCyX+ZuEqZcFwP2Vc1ndAwr7dPV8FPY5mOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QObNmog3dVAUNgUeT+YmFBheaj1ZgBvbYmTanGwngouXuYFnTF4WHlX6+73fY8G4n
         y3rBcPrlPZphgsd6tQyHXVw2XMvhp4w6aqzIO5gTmlB859DSMP7LjF1iE+DyLFCOlL
         aSmKNRUrNmywsY956sn74tS5vAmR0SlMZzDys4Rugy+4VGd8deIPjEYT5tV6bblUcY
         S1T1/Z8O4kom9w0mFj6i2Vl3nc6ZyAA2lMRuJ926rD19e4acK9K+8ZIl7bDbcrGTgx
         FeMvu2DYLCQdwGbDW4pYA3vzxs9bHABp0IyqtV1Q4RDM6mDfuTCfU5mh9b6Ti9TaCb
         Aap954XKr3V7A==
Date:   Tue, 1 Feb 2022 12:51:57 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: mt8183: jacuzzi: Fix bus properties in
 anx's DSI endpoint
Message-ID: <20220201175157.nhjbspw7kfz7gwyy@notapiano>
References: <20220201174643.843102-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201174643.843102-1-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to add the reviewed-by from v1. Added below.

On Tue, Feb 01, 2022 at 12:46:43PM -0500, Nícolas F. R. A. Prado wrote:
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
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> ---
> v1: https://lore.kernel.org/all/20220120224204.773117-1-nfraprado@collabora.com
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
