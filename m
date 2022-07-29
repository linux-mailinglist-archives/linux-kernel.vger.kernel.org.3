Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E415585624
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiG2Uaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2Uai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:30:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033618E12;
        Fri, 29 Jul 2022 13:30:38 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 003A16601B8B;
        Fri, 29 Jul 2022 21:30:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659126636;
        bh=k1k8s7Za97TaDukHb1io/Pph036btg+/OCzVr3A+DLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5qxbh8llQDpysSkuzEFTSd//A+YhN8kKGDj8/zg7fh6Nixht1vZ3Wj4Yai8aPCAW
         vXdULCcrjsoFSDnuqvXNrRGEYcvl6r8A7WifuB7//iLYZDBVT4xmc3QlUCRu8v6Prb
         xtaMl8oo5e+9BL5FtEucFu5VfWT1dcXvnIf2OKHSVen4rKrYJMRZ8NVANfJyM2kHwA
         XO0fOpyA2NYcYWmBhx3w7PEMki61C2LQE034mNgpJid2SjZwP44aUljIb/lLaeHB9Z
         SUZigHRbser2iQUSFR7gn6KeUVuK9FqVLNM2Nf39R+za5Nwu+AzM3coMs1CFe4q8in
         SSqWJYX0B4x1w==
Date:   Fri, 29 Jul 2022 16:30:30 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8 3/6] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones for mt8192
Message-ID: <20220729203030.p645ccnpa4bd6sdn@notapiano>
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-4-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726135506.485108-4-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:55:03PM +0200, Balsam CHIHI wrote:
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC mt8192 and register the maximum temperature
> of sensors and each sensor as a thermal zone.
> 
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  drivers/thermal/mediatek/Kconfig         |  27 +
>  drivers/thermal/mediatek/Makefile        |   2 +
>  drivers/thermal/mediatek/lvts_mt8192.c   | 241 ++++++
>  drivers/thermal/mediatek/soc_temp.c      |   2 +-
>  drivers/thermal/mediatek/soc_temp_lvts.c | 928 +++++++++++++++++++++++
>  drivers/thermal/mediatek/soc_temp_lvts.h | 365 +++++++++
>  6 files changed, 1564 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/mediatek/lvts_mt8192.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
> 
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> index 9c41e9079fc3..7fc04237dd50 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -20,4 +20,31 @@ config MTK_SOC_THERMAL
>  		configures thermal controllers to collect temperature
>  		via AUXADC interface.
>  
> +config MTK_SOC_THERMAL_LVTS
> +	tristate "LVTS (Low voltage thermal sensor) driver for Mediatek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_TI_SYSCON

Both mt8192 and mt8195 use the reset controller provided by infracfg [1], so
there's no need to depend on RESET_TI_SYSCON. (Same thing below)

[1] https://lore.kernel.org/all/20220523093346.28493-1-rex-bc.chen@mediatek.com/

Thanks,
Nícolas

> +	help
> +		Enable this option if you want to get SoC temperature
> +		information for MediaTek platforms. This driver
> +		configures LVTS thermal controllers to collect temperatures
> +		via Analog Serial Interface(ASIF).
> +
> +endif
> +
> +if MTK_SOC_THERMAL_LVTS
> +
> +config LVTS_MT8192
> +	tristate "LVTS driver for MediaTek MT8192 SoC"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_TI_SYSCON
> +	depends on MTK_SOC_THERMAL_LVTS
> +	help
> +		Enable this option if you want to get SoC temperature
> +		information for MT8192. This driver
> +		configures LVTS thermal controllers to collect temperatures
> +		via ASIF.
> +
>  endif
[..]
