Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9C5453EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbiFISRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiFISRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:17:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D274222355;
        Thu,  9 Jun 2022 11:17:06 -0700 (PDT)
Received: from notapiano (unknown [169.150.201.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE44766017A8;
        Thu,  9 Jun 2022 19:17:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654798624;
        bh=73Y/v8InPphxMIIyYusgiQmgRfQZkIA8g+2zCfS9xd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goJymFXpI7vGo2vU57POZtqsHzw1PpoQkonRZaV/x1GeP1CRRfbfwSYD+zZOU0MS4
         vxqVooUWCc68dlgojJTXXYPSnzjfFkPX8yoUufLCtUoMPPSB/Ff2q4fUIHNdDVpPm4
         Ei07wTVddxPDxLOvirTqGGp7vix41HO3QUX28RDQ9vslO65rIPNmxzUsAtyFx7lpBn
         dwZB1AYpPVvh4GTmHx9495CssUjaGqp66NDM7APpD1zZZeuib+Tb2SosDJl5PLgU2T
         9x4y62bQWke4bSN/3lLtUzXybMVRPfwKuaKWX/XI88PC2XVg1eoQ51BdjbnV672hMP
         ULDU+5NWSvi5g==
Date:   Thu, 9 Jun 2022 14:16:58 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 1/4] pinctrl: add generic driving setup property on
 mt8192
Message-ID: <20220609181658.s5qdm32f5vhwkkao@notapiano>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
 <20220608053909.1252-2-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608053909.1252-2-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

thank you for the patch.

On Wed, Jun 08, 2022 at 01:39:06PM +0800, Guodong Liu wrote:
> This patch provides generic driving setup, which support
> 2/4/6/8/10/12/14/16mA driving, original driver just set
> raw data setup setting when use drive-strength property

You should mention in the commit message that the dt-binding expects that
drive-strength arguments be passed in mA, but the driver was expecting raw
values. And that this commit changes the driver so that it is aligned with the
binding.

Thanks,
Nícolas

> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index acccde9262ba..9faf7001369d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> @@ -1372,8 +1372,8 @@ static const struct mtk_pin_soc mt8192_data = {
>  	.gpio_m = 0,
>  	.bias_set_combo = mtk_pinconf_bias_set_combo,
>  	.bias_get_combo = mtk_pinconf_bias_get_combo,
> -	.drive_set = mtk_pinconf_drive_set_raw,
> -	.drive_get = mtk_pinconf_drive_get_raw,
> +	.drive_set	= mtk_pinconf_drive_set_rev1,
> +	.drive_get	= mtk_pinconf_drive_get_rev1,
>  	.adv_pull_get = mtk_pinconf_adv_pull_get,
>  	.adv_pull_set = mtk_pinconf_adv_pull_set,
>  	.adv_drive_get = mtk_pinconf_adv_drive_get,
> -- 
> 2.25.5
> 
