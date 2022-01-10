Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD14895FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiAJKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiAJKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:09:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68269C06173F;
        Mon, 10 Jan 2022 02:09:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A8B501F43744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641809347;
        bh=9r/SDK6nozUu5OWdjoYPAUhp3hjBUTHjNcy/d6M0jgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WcHo25d+Tywel71wR0c+GwyX5XpRG3rJEHviTasqUvqh+sDhc4FFxKMvnt4pGKimK
         yvGVBlFqmW05dJ3aO3QJDNQmXTC5a31mMtQ9qDT20emZnvV/xq1W9ljkN93kJhOTiJ
         ioi/SP1A92tc46RyIyCXLvX03qRD3qp4Jy4tChtYHnk5tk+Mp5PrHE4Hbu7J77oMa5
         72ipZ9sWmccyF8JBcGy5ORq+zYYDkuIliHES6/ZXF3dezsULqlmullRP7xlahWog4+
         kL6PT4n3P2vpCm1QxacbyNPtEemg26ixY0UIIeMDDAkmYqYhZk5b2/PbfwWeCTI7kC
         LUZx1lJA5Yj+w==
Subject: Re: [PATCH v1 2/2] pinctrl: add pinctrl driver on mt8186
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110073111.31306-1-guodong.liu@mediatek.com>
 <20220110073111.31306-2-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c7d7fbe3-1fe2-8765-5577-b4b06cebe9b6@collabora.com>
Date:   Mon, 10 Jan 2022 11:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110073111.31306-2-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 08:31, Guodong Liu ha scritto:
> This commit includes pinctrl driver for mt8186.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>   drivers/pinctrl/mediatek/Kconfig              |    6 +
>   drivers/pinctrl/mediatek/Makefile             |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 1313 ++++++++++
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h | 2186 +++++++++++++++++
>   4 files changed, 3506 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 66db4ac5d169..2cb5963cef4c 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -147,6 +147,12 @@ config PINCTRL_MT8183
>   	default ARM64 && ARCH_MEDIATEK
>   	select PINCTRL_MTK_PARIS
>   
> +config PINCTRL_MT8186
> +	bool "Mediatek MT8186 pin control"
> +	depends on OF
> +	depends on ARM64 || COMPILE_TEST

Like the other MTK pinctrl drivers, please add:
	default ARM64 && ARCH_MEDIATEK


With that fixed,

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +	select PINCTRL_MTK_PARIS
> +
>   config PINCTRL_MT8192
>   	bool "Mediatek MT8192 pin control"
>   	depends on OF
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index 1e3931d924e7..29018d6ad0de 100644
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

