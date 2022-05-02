Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE55173F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385906AbiEBQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386196AbiEBQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:15:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD2DFFC;
        Mon,  2 May 2022 09:12:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 34F4B1F42BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651507928;
        bh=yFJOMKwuIhisyg/HTjYUfFFgojnjn1gaRe4MzlvPbJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WugItvxTkOGGNHaEeKBTDncAM3wUeRs3oShgHGf4GWeVrX/mMiT1QygpMU4x5j065
         Gt6pyaBHFSuQyXEAYYa28BgHWT2AFjZ8qhjXyFtxtQaQAgj1scf++bvYnN0LPsRNLi
         Nce9SmSI9VJi9VrUeXPTLEafQp1+wPzugsIy3ByqPyONYVqhh07PyqnzfKsbe/QdCG
         M96xm5UA5kIIdPqVzlfRRSV4yCAJ8jrFmk0njylohNyipmPCk2/FWxZxrQV8qDr8Iy
         LL96d6HWQYUl894lIIUIdjaj/+4WOzRgEiBtOgz52UELJWKVB3NbSFCGf44AUVzO6H
         Ua1OkdPiuO7ug==
Date:   Mon, 2 May 2022 12:12:03 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: Add fallback compatible for
 mt8192's flash
Message-ID: <20220502161203.pfmjyep4escqwjix@notapiano>
References: <20220429195745.2203461-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429195745.2203461-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:57:45PM -0400, Nícolas F. R. A. Prado wrote:
> The dt-binding for Mediatek's SPI NOR flash controller expects a mt8173
> fallback compatible for mt8192, so add it in mt8192.dtsi.
> 
> The driver already sets custom data based on the mt8192 compatible, so
> this fallback compatible won't be used and is added purely to suppress
> the dt-binding warning.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

By the way, I wonder if this patch should be accompanied by a patch adding the 
mediatek,mt8192-nor standalone compatible as deprecated in the dt-binding. I
feel like the answer is in theory yes, but in practice no.

The fact that the mediatek,mt8192-nor standalone compatible was accepted in the
devicetree means that it should show in the dt-binding, since it's an acceptable
binding. But since the binding already shows up there with a fallback binding,
then this standalone binding should be considered deprecated.

But in practice, the mediatek,mt8192-nor is the more specific binding so
documenting its standalone use as deprecated wouldn't accomplish much.

What do you think?

Thanks,
Nícolas

> 
> ---
> 
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 26dbe9ecc528..32a836105ea7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -896,7 +896,7 @@ pcie_intc0: interrupt-controller {
>  		};
>  
>  		nor_flash: spi@11234000 {
> -			compatible = "mediatek,mt8192-nor";
> +			compatible = "mediatek,mt8192-nor", "mediatek,mt8173-nor";
>  			reg = <0 0x11234000 0 0xe0>;
>  			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
>  			clocks = <&topckgen CLK_TOP_SFLASH_SEL>,
> -- 
> 2.36.0
> 
