Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B692F563C6C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiGAWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:36:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A138795;
        Fri,  1 Jul 2022 15:36:58 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 070F266017F5;
        Fri,  1 Jul 2022 23:36:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656715017;
        bh=vZ3irZ1TSm2BYJfU1kDyXnE/zMCI6E+fE9pW9wuk8Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSR5xImLUn316LrjljZ1ZE2vpJUZM4TVRpGvnWzfv4NErflfdKirKLu8UPCVzqron
         l4YGAOJWdXyKYK6D2OrVmU07Xj0/Wp+90Ey1FT9698Nd5TWi4qJsOKQTIY9ABVbCMN
         73NxzIc/WJqP1kt5p7h2izMmWdnFOy5ZA4odTghE7lkPbjsABsydmEZO4ZmDIsu2P0
         /SJkm9X2cTQ12UVvM/HQm4peSCLCUgGBID/YFa8egtT/YuL0NskPQ/6Jzx/Y01WWsm
         w5IUGXT1fRjR8AILu/a22mSqxIsQb+bVOnQ2gE95eNxUzjd1ezd55oFIdvr5gGXm92
         I3XECuFDuJE8g==
Date:   Fri, 1 Jul 2022 18:36:48 -0400
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
Subject: Re: [PATCH 05/11] arm64: dts: mediatek: cherry: Add support for
 internal eMMC storage
Message-ID: <20220701223648.ps76hfjdnfoj3bf2@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:10PM +0200, AngeloGioacchino Del Regno wrote:
> Add mtk-sd controller and pin configuration to enable the internal
> eMMC storage: now it is possible to mount a rootfs located at the
> internal storage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 091338f7d5ff..8c4b492f774f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -9,6 +9,7 @@
>  
>  / {
>  	aliases {
> +		mmc0 = &mmc0;

There was this discussion about adding aliases on dtsi's or not [1]. The
case in favor of adding them in the dtsi seemed stronger, but it wasn't
conclusive... Anyway, I guess it's fine.

[1] https://lore.kernel.org/all/CAD=FV=Wi9xTnWTPbakSnf9rKkiT+4AT=3db-uwhww1bdLKjv9g@mail.gmail.com/

>  		serial0 = &uart0;
>  	};
[..]
> +&pio {
> +	mmc0_pins_default: mmc0-default-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;

These MTK_DRIVE_*mA macros map directly to the values, and the drive-strength
property is already standard and defined to take values in mA, so it's better to
use the value directly:

	drive-strength = <6>;

(Likewise below and in some other patches)

Otherwise,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
