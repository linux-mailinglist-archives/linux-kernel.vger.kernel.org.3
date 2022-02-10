Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91914B0901
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiBJI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:57:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiBJI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:57:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CFE7A;
        Thu, 10 Feb 2022 00:57:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 90F0E1F46047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644483426;
        bh=beBoCF9E69P2Dr/kHu3IApUCGiTodhpacSRBbcpe5+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EV+ukFNj/sNvscWcfMeIJt1T7Raaz6uH+ysq9a1OUQIiRCuB1jYVWM1gs3SiW6fXq
         +W1qHEqA/kQIRoslgeuLHIjelBJh449OZFjzF9ndNBnEsndLL/Uhq6Dci5EDTPMFJ3
         2b3BTKTNcx7cfRYfFKEc2a1cQdlUehVkFOH9A40Zav4cF91ThhuTeWch3NMyfoawzk
         lfMBATjnkgXx2TiW/OGjnseyh2aInMPuEMX/LTuwk6iU9yxCyFRtYlxEhAbn+kwb0G
         MzsY4tKK6hHqu9o44fgNdRAw76Onntol5rlR80qiT+WxDo0kmJmr+j0JeUWkBdWuqC
         HkP9EKXc4Pj6w==
Message-ID: <332434dc-2c94-5488-e7d0-7db00139d814@collabora.com>
Date:   Thu, 10 Feb 2022 09:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 2/3] pinctrl: add pinctrl driver on mt8186
Content-Language: en-US
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
 <20220210062122.23974-3-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210062122.23974-3-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/22 07:21, Guodong Liu ha scritto:
> This commit includes pinctrl driver for mt8186.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>   drivers/pinctrl/mediatek/Kconfig              |    7 +
>   drivers/pinctrl/mediatek/Makefile             |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 1313 ++++++++++
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h | 2186 +++++++++++++++++
>   4 files changed, 3507 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 66db4ac5d169..8dca1ef04965 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -147,6 +147,13 @@ config PINCTRL_MT8183
>   	default ARM64 && ARCH_MEDIATEK
>   	select PINCTRL_MTK_PARIS
>   
> +config PINCTRL_MT8186
> +	bool "Mediatek MT8186 pin control"
> +	depends on OF
> +	depends on ARM64 || COMPILE_TEST
> +	default ARM64 && ARCH_MEDIATEK
> +	select PINCTRL_MTK_PARIS
> +
>   config PINCTRL_MT8192
>   	bool "Mediatek MT8192 pin control"
>   	depends on OF
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index 90f43bb9d9a7..31c3784c6089 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_PINCTRL_MT7986)	+= pinctrl-mt7986.o
>   obj-$(CONFIG_PINCTRL_MT8167)	+= pinctrl-mt8167.o
>   obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
>   obj-$(CONFIG_PINCTRL_MT8183)	+= pinctrl-mt8183.o
> +obj-$(CONFIG_PINCTRL_MT8186)	+= pinctrl-mt8186.o
>   obj-$(CONFIG_PINCTRL_MT8192)	+= pinctrl-mt8192.o
>   obj-$(CONFIG_PINCTRL_MT8195)    += pinctrl-mt8195.o
>   obj-$(CONFIG_PINCTRL_MT8365)	+= pinctrl-mt8365.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
> new file mode 100644
> index 000000000000..1e550b15b9d4
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
> @@ -0,0 +1,1313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + *
> + * Author: Guodong Liu <guodong.liu@mediatek.com>
> + *
> + */
> +
> +#include "pinctrl-mtk-mt8186.h"
> +#include "pinctrl-paris.h"
> +
> +/* MT8186 have multiple bases to program pin configuration listed as the below:
> + * iocfg[0]:0x10005000, iocfg[1]:0x10002000, iocfg[2]:0x10002200,
> + * iocfg[3]:0x10002400, iocfg[4]:0x10002600, iocfg[5]:0x10002800,
> + * iocfg[6]:0x10002C00.
> + * _i_based could be used to indicate what base the pin should be mapped into.
> + */
> +
> +#define PIN_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits) \
> +	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits, \
> +		       32, 0)

Please don't break this line: 84 columns is fine.

> +
> +#define PINS_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits) \
> +	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits,  \
> +		       32, 1)

Same here.

And with that fixed,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
