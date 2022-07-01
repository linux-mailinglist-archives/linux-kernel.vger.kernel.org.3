Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5799563C72
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiGAWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiGAWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:42:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48970E7C;
        Fri,  1 Jul 2022 15:42:50 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82EE666017F5;
        Fri,  1 Jul 2022 23:42:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656715369;
        bh=4vl93FTFjxxc3xIXFjEIYVlIvv8NLDkDY4yTRtBdznM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAtv26Rs0ziY74EhKPnnIdlH1f0MYN7fSA5TB5hms81a1JjkAIyTQaPs44n9t4GMX
         U62FjY/6hEvISXnyYC8Y0QaxCaHkJt2kcp2QnwqRX0VfxyUa3gG5klo68Pr9GUi41b
         Qw4AMtWKmOljBrZE7T4/WG5MFGZcTjX7Xi0gxZB2jqOAv8NSoTcaVVB4msWzrRuAwW
         +v9y9zPAMorexekg5Id3SVJ1cezUN49M1o4HzPDVxg7EvivaJp3aHnGpe9w5eCv5V7
         bKPIcLLm+wFUqnk+ObYcCuKm0fk3yJs825G757bEjGNBUuN6d16QbiY9E1cuuLWTxs
         PfuOu+J8eCySQ==
Date:   Fri, 1 Jul 2022 18:42:39 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 07/11] arm64: dts: mediatek: cherry: Enable I2C and SPI
 controllers
Message-ID: <20220701224239.n3o4ofzsnvpbdytg@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-8-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:12PM +0200, AngeloGioacchino Del Regno wrote:
> This platform uses eight I2C controllers and one SPI controller:
> in preparation for enabling devices attached to these controllers,
> add basic configuration to enable the busses.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 2f70341bba91..23a86d07274c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -9,6 +9,13 @@
>  
>  / {
>  	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c7 = &i2c7;
>  		mmc0 = &mmc0;
>  		serial0 = &uart0;
>  	};
> @@ -88,6 +95,65 @@ ppvar_sys: regulator-ppvar-sys {
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pin>;

Very nitpicky: you could name it "i2c0_pins" to be consistent with the others
(including SPI on this patch).

> +};
[..]
> +&i2c7 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

These *-cells are already defined in the parent dtsi, so drop.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
