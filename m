Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13D4E74E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359334AbiCYORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348556AbiCYORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:17:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A327EA3B;
        Fri, 25 Mar 2022 07:15:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A84E41F462FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648217728;
        bh=sja1g3dzc8qDBvEHxzgzRqMutttR4lk7hJeFs3aFMrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FQJJSC26ejBDB4/+Qj6Xw8KwJ0hryubPf5gx4jsPamDol9B2J5wI+bWShxKmiLm79
         z243gfsBJhWYvPmw6BJZhraJN8GqsGwSfeJ9bUGxOlGPe/U8kilRm5kCr3mesojUnm
         mAGy8A+4ZgyAm0Ak+KSKY05/GEKw6A9xbf+4noxC+jUnhXhHlJwnnfLVCT7b2zZRL9
         LToadUNgDwsrkuj0qbupuK286RoKE8GjDMwlT6pg1bPPDdqZmLv1uNthCHIXnt7QOf
         c64ANQiFUXoTIk1cDEODx9OGNgZmH/Y0X6fK1VtQBIFNvNTLt/cMwnc8s8rybg1BR5
         vAAQsFgoAdKJQ==
Message-ID: <be06e57d-302e-e641-a134-c45ea89a6a6b@collabora.com>
Date:   Fri, 25 Mar 2022 15:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/2] phy: mediatek: Add PCIe PHY driver
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220323065608.27426-1-jianjun.wang@mediatek.com>
 <20220323065608.27426-3-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220323065608.27426-3-jianjun.wang@mediatek.com>
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

Il 23/03/22 07:56, Jianjun Wang ha scritto:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   drivers/phy/mediatek/Kconfig        |  11 ++
>   drivers/phy/mediatek/Makefile       |   1 +
>   drivers/phy/mediatek/phy-mtk-pcie.c | 272 ++++++++++++++++++++++++++++
>   3 files changed, 284 insertions(+)
>   create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> 

..snip..

> diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c b/drivers/phy/mediatek/phy-mtk-pcie.c
> new file mode 100644
> index 000000000000..44a2ad8d324e
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-pcie.c
> @@ -0,0 +1,272 @@

..snip..

> +/**
> + * struct mtk_pcie_phy - PCIe phy driver main structure
> + * @dev: pointer to device
> + * @phy: pointer to generic phy
> + * @sif_base: IO mapped register base address of system interface
> + * @data: pointer to SoC dependent data
> + * @sw_efuse_en: software eFuse enable status
> + * @efuse_glb_intr: internal resistor selection of TX bias current data
> + * @efuse: pointer to eFues data for each lane

Oops! There's a typo! "eFues" => "eFuse"

After fixing this typo,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: Many thanks for the kerneldoc documentation!!!!

> + */
> +struct mtk_pcie_phy {
> +	struct device *dev;
> +	struct phy *phy;
> +	void __iomem *sif_base;
> +	const struct mtk_pcie_phy_data *data;
> +
> +	bool sw_efuse_en;
> +	u32 efuse_glb_intr;
> +	struct mtk_pcie_lane_efuse *efuse;
> +};

