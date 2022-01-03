Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56759482F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiACI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiACI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:59:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A1C061761;
        Mon,  3 Jan 2022 00:59:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8A5071F41EBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641200347;
        bh=Lg7ar1sN11ciL2DcpoXXF8T+6ylIewLjLgr41Thyq3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YKOtWIbxd0k61NxswnNEpxj+h1HzxuK9la2Q+nvHl2NikBMjv+8ZCdlxSr5bepYGH
         rmO7GB93XpTKJiOc55M2foj8gXDaQ9oLaCGMHJ7ncNMF2FlIc7jeBq7UBm8BTt7acd
         5qWncBGtpDuiHtuAD6oBA/yWfyfjX9EEh+FOBJ7Fz3OwzZUTRH1JbmsEGFHLq+E7W9
         sgvyn/PymuRs79ZAzKf53YXkO23qjQY8uDi6RMxXjm04gNySExylW9iq7XNDpdZd0M
         ULOLdg3gHfjACKvWBNOKtxIDJ/XA6Qs0CsfVpidOYylnH89u/S+rJqJWYrF6B3tzbq
         tUPGLHYuglTLA==
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
 <047803b9-d09f-d4f8-a674-317cc19dd055@collabora.com>
 <75b2773d1d170f42bae0774dbc58d1458cb25502.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <821f9e8b-cf35-2e53-e64f-c19e7bde957b@collabora.com>
Date:   Mon, 3 Jan 2022 09:59:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <75b2773d1d170f42bae0774dbc58d1458cb25502.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/12/21 03:06, Chunfeng Yun ha scritto:
> On Fri, 2021-12-24 at 11:10 +0100, AngeloGioacchino Del Regno wrote:
>> Il 18/12/21 09:28, Chunfeng Yun ha scritto:
>>> Add three helpers mtk_phy_clear/set/update_bits() for registers
>>> operation
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>> v2: new patch, add register access helpers,
>>>       Add updatel() macro suggested by Vinod, here add more ones
>>> instead.
>>> ---
>>>    drivers/phy/mediatek/phy-mtk-io.h | 38
>>> +++++++++++++++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>>    create mode 100644 drivers/phy/mediatek/phy-mtk-io.h
>>>
>>> diff --git a/drivers/phy/mediatek/phy-mtk-io.h
>>> b/drivers/phy/mediatek/phy-mtk-io.h
>>> new file mode 100644
>>> index 000000000000..500fcdab165d
>>> --- /dev/null
>>> +++ b/drivers/phy/mediatek/phy-mtk-io.h
>>> @@ -0,0 +1,38 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2021 MediaTek Inc.
>>> + *
>>> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> + */
>>> +
>>> +#ifndef __PHY_MTK_H__
>>> +#define __PHY_MTK_H__
>>> +
>>> +#include <linux/io.h>
>>> +
>>> +static inline void mtk_phy_clear_bits(void __iomem *reg, u32 bits)
>>> +{
>>> +	u32 tmp = readl(reg);
>>> +
>>> +	tmp &= ~bits;
>>> +	writel(tmp, reg);
>>> +}
>>> +
>>> +static inline void mtk_phy_set_bits(void __iomem *reg, u32 bits)
>>> +{
>>> +	u32 tmp = readl(reg);
>>> +
>>> +	tmp |= bits;
>>> +	writel(tmp, reg);
>>> +}
>>> +
>>> +static inline void mtk_phy_update_bits(void __iomem *reg, u32
>>> mask, u32 val)
>>> +{
>>> +	u32 tmp = readl(reg);
>>> +
>>> +	tmp &= ~mask;
>>> +	tmp |= val & mask;
>>> +	writel(tmp, reg);
>>> +}
>>> +
>>> +#endif
>>>
>>
>> These helpers are almost exactly duplicating what
>> regmap_update_bits() is doing.
>> I appreciate the effort to stop open-coding the same sequences over
>> and over by
>> adding such helper functions,
> I agree with you.
>> but I think that the proper way of doing what you
>> are proposing is not to add custom functions but rather reuse what
>> the Linux APIs
>> give you.
> I also like to use common APIs ASAP, but not found suitable ones.
> This may be a problem, I found that some similar custom helps already
> added under phy fold.
> 
>>
>> What about doing a conversion to use regmap on this driver?
> No, we don't use regmap here, these registers are monopolized by t-phy,
> it's not syscon.
> 
> 

Hello,

The regmap API allows this kind of usage, registers don't necessarily have
to be part of a syscon.

Regards,
- Angelo
