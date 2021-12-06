Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE546A199
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhLFQp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:45:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52808 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLFQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:45:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EDB251F44A85
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638808916; bh=M3hSCHW0hydix9hLEzH0Vi8aDVF0BRckDz30x5C/otc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUmrqbTgbM7ViNCVOYPUNFgAwOKMfDYcV3caU+/NT+VSE0L94IjhC882xgvRXiSlh
         Xj8mjDujX0WAlz+LIeBN2a4XF36qKRXfZNJVtLAXb+2dsvcDbkDCjSMi5HZ8UMJaEI
         8oTagz5tVlppAgNaKsEQLJ7S1cvcmULer4Me8tRZTBHCvCByA/5f+vaQ/aKH9cBbBK
         Nx0Z1iz3EjOv51+yD+vvZAT/TgWvZVGZfCTqV4p/XhVVGGp+2cCQivtRib11vSACIX
         QAU4k+xNM+95FM9ec84q/WRGJFuZXsqDfhmmUvzZL977xn5GKmxgLUaDTR19SxFdEv
         QMDZuFp3X3M4w==
Date:   Mon, 6 Dec 2021 11:41:50 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 1/5] arm64: dts: mediatek: Correct system timer clock of
 MT8192
Message-ID: <20211206164150.wigqbwo6kdkwi35r@notapiano>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
 <20210825011120.30481-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825011120.30481-2-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

thanks for the patch! However, can you please improve the commit message? Here's
a possible suggestion:

    When the initial devicetree for mt8192 was added in 48489980e27e ("arm64:
    dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"), the
    clock driver for mt8192 was not yet upstream, so the clock property nodes
    were set to the clk26m clock as a placeholder.

    Given that the clock driver has since been added through 710573dee31b ("clk:
    mediatek: Add MT8192 basic clocks support"), as well as its dt-bindings
    through f35f1a23e0e1 ("clk: mediatek: Add dt-bindings of MT8192 clocks") and
    devicetree nodes through 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192
    clock controllers"), fix the systimer clock property to point to the actual
    clock.

Then you could use the same message for the other commits, just updating which
clock is being fixed in the last sentence there. With that improved commit
message:

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c7c7d4e017ae..2b63d2ea6cb6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -312,7 +312,7 @@
>  				     "mediatek,mt6765-timer";
>  			reg = <0 0x10017000 0 0x1000>;
>  			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_CSW_F26M_D2>;
>  			clock-names = "clk13m";
>  		};
>  
> -- 
> 2.18.0
> 
> 
