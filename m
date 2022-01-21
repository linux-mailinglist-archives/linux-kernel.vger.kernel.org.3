Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40D9495E89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiAULqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:46:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiAULqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:46:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E4FBD1F45D2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642765581;
        bh=BaeBPWQQLy8TR0zWndGX80fxT+ee71mjcJucVO2+uYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fQxyUyYCryV+CGfTGU3W68Ul5GIQKr6bHvhHFOeFLcsg9vNn/6pOzSE2uRN0P47eV
         YgnXTN94rEfrWlUzpR9WrHA9afTXl7VvbTqF+xWtVA7bl3W9Zd9tVuWnI7v6S0FNJV
         waDZzay12MA1d6KoD6CKeZbcHl3A4n1V30Z187YQ0seGtLaBRaTFSo34JlXptlMXgR
         K4ki/3NDpwcta9IL/MBY9nt35zJPb+Ez+8ZbF7wbZopU2AXvO0HT9dzGXqzeBpGCcq
         CstVgUC0Zxgj2UgOhfnzLByHzude5vxdNzYPbc96r8WxtuZjcLidunmeUnddLMjSDr
         gBdtgO+gsmQzQ==
Subject: Re: [PATCH] arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's
 DSI endpoint
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220120224204.773117-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <29069a98-a839-4fb6-5b83-7877402aaf30@collabora.com>
Date:   Fri, 21 Jan 2022 12:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220120224204.773117-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/01/22 23:42, Nícolas F. R. A. Prado ha scritto:
> mt8183-kukui-jacuzzi has an anx7625 bridge connected to the output of
> its DSI host. However, after fd0310b6fe7d ("drm/bridge: anx7625: add
> MIPI DPI input feature"), a bus-type property started being required in
> the endpoint node by the driver to indicate whether it is DSI or DPI.
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

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 8f7bf33f607d..e8f133dc96b9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,6 +171,8 @@ port@0 {
>   
>   			anx7625_in: endpoint {
>   				remote-endpoint = <&dsi_out>;
> +				bus-type = <5>;
> +				data-lanes = <0 1 2 3>;
>   			};
>   		};
>   
> 
