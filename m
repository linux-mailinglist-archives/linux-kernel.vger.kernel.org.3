Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406E49E09C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiA0LV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiA0LV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:21:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98989C061714;
        Thu, 27 Jan 2022 03:21:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C85F1F450BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643282485;
        bh=3BQWjA3nBp0sP7zgUSrad36ylixDnLmcqKRaTEEAMiM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TqymkiTkmc8ouV09E5rSvKQgI1FdJ0efS27pK79aps2Jzy7Z8w/Cy0sDkt8Yn9gFO
         KGMCLUBeNBWSc5d+ZeCKWEwex3xbBOCP4CNz28lYh1Fi7qKWXjkkQusXvM2/mUT8LE
         Wa2H+R+DwBAgfDM6IOoGwx9cOkPsIgj7mGW3g/pFQskGpDN3uaaEJyglRNEh9Rb2mK
         XBmZeF9jONOMblSQQygM6bv8s/ecqlK1rrkjNVkqNffmePAeiOMJUkylg17LZCVPuK
         e6tEGjEP6a9LpBl4OFu6G3DSTcKyWWfs4QJsLckJsJhdTG07bQOJoz8zABH0/KTkil
         g9B6Tw63fHj6A==
Subject: Re: [PATCH v4 32/35] iommu/mediatek: Get the proper bankid for multi
 banks
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-33-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <0dce6a25-6e45-efcc-3235-b8b7be81ea4f@collabora.com>
Date:   Thu, 27 Jan 2022 12:21:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-33-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> We preassign some ports in a special bank via the new defined
> banks_portmsk. Put it in the plat_data means it is not expected to be
> adjusted dynamically.
> 
> If the iommu id in the iommu consumer's dtsi node is inside this
> banks_portmsk, then we switch it to this special iommu bank, and
> initialise the IOMMU bank HW.
> 
> Each a bank has the independent pgtable(4GB iova range). Each a bank
> is a independent iommu domain/group. Currently we don't separate different
> iova ranges inside a bank.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 22586d1aed72..c6de9304bbc6 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -191,6 +191,7 @@ struct mtk_iommu_plat_data {
>   
>   	u8                  banks_num;
>   	bool                banks_enable[MTK_IOMMU_BANK_MAX];
> +	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];

I would prefer to see u32 here instead... but maybe that's just a
personal preference, it doesn't really matter.

In any case:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


