Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5773D47EE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352401AbhLXKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 05:10:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbhLXKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 05:10:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1ABC71F45CC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640340657;
        bh=K0vduRr/PSyXSZURCDSAe+4sfJYS7J60lk/6WQDlpcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Saf556NNDqc6qq6vvuZBsNYtzw57NQTrKeXFn4aAec/8HBh4iAWReD8sZs9xgU8Nu
         xLRC1NCzZVVeonuR9yQrkIyt6WVRl/S5c4SOoP8Zdt9J+livMZeYY68KMmikJRXrHz
         9ywxUk7maA0wLDh5MYrB/Gy4BqbLvodZC1r+07qicypwrN+EIj7fDZTkBmOgvxf8CO
         Mmb7WZ9qujweXRcsmP4NhbHHOuUXV+YJeRX9rC+tuIMmsfgwJd+kaSO0G//BmwXATl
         9f2E06nsVksHSw0Db0SZDDDUgmeztKBTjzFOjScFAeFJ1lVJSLNZ8afUQSScBzqBbv
         UqnEvHjWD54fg==
Subject: Re: [PATCH v2 3/5] phy: mediatek: add helpers to update bits of
 registers
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
 <20211218082802.5256-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <047803b9-d09f-d4f8-a674-317cc19dd055@collabora.com>
Date:   Fri, 24 Dec 2021 11:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211218082802.5256-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/12/21 09:28, Chunfeng Yun ha scritto:
> Add three helpers mtk_phy_clear/set/update_bits() for registers operation
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: new patch, add register access helpers,
>      Add updatel() macro suggested by Vinod, here add more ones instead.
> ---
>   drivers/phy/mediatek/phy-mtk-io.h | 38 +++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 drivers/phy/mediatek/phy-mtk-io.h
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
> new file mode 100644
> index 000000000000..500fcdab165d
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-io.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + *
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + */
> +
> +#ifndef __PHY_MTK_H__
> +#define __PHY_MTK_H__
> +
> +#include <linux/io.h>
> +
> +static inline void mtk_phy_clear_bits(void __iomem *reg, u32 bits)
> +{
> +	u32 tmp = readl(reg);
> +
> +	tmp &= ~bits;
> +	writel(tmp, reg);
> +}
> +
> +static inline void mtk_phy_set_bits(void __iomem *reg, u32 bits)
> +{
> +	u32 tmp = readl(reg);
> +
> +	tmp |= bits;
> +	writel(tmp, reg);
> +}
> +
> +static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
> +{
> +	u32 tmp = readl(reg);
> +
> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +	writel(tmp, reg);
> +}
> +
> +#endif
> 

These helpers are almost exactly duplicating what regmap_update_bits() is doing.
I appreciate the effort to stop open-coding the same sequences over and over by
adding such helper functions, but I think that the proper way of doing what you
are proposing is not to add custom functions but rather reuse what the Linux APIs
give you.

What about doing a conversion to use regmap on this driver?
