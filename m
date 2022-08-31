Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600C05A7912
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiHaIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:31:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302CA8A1E3;
        Wed, 31 Aug 2022 01:31:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BACD6601A13;
        Wed, 31 Aug 2022 09:31:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661934688;
        bh=7tmwsymc7qJDSQUSPLXblO4+6Q5hPnTwu9RWsnUwg6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S249Wi/5YyEj1EMvxVnzWOqNZyVMGPy+TSmY8b4L4QP79qmM7PTodfEYCBOX16X32
         xyVZ/2sSXTejvWtMlkBezKXPnE2ZmMLMaquISgk96/86g1j39uod9uGbLaexE+2uoh
         CJ+GVWHmaPDu6fP4OUpPnATB0PWIT0h54Z/5yKxAhzFLTH22GBsUmSROQjSXA4UtFb
         wtyqED6k7Jvaj+X25fEBY/hisXotCet+zqF0OvWIVcfBoKqUxLi0OXbttEEjBj3R3x
         HLYnAzzIs/2vxicvFuNjVM5s9jF2HRgSeiDTRDG+TqgX5nJ5B+3q3WwNBI6QVVW5DK
         4pf1c7OYtmFyw==
Message-ID: <9a7abae0-e31e-6beb-74ce-96462d847a88@collabora.com>
Date:   Wed, 31 Aug 2022 10:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 7/7] phy: phy-mtk-tphy: fix the phy type setting issue
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
 <20220829080830.5378-7-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220829080830.5378-7-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/08/22 10:08, Chunfeng Yun ha scritto:
> The PHY type is not set if the index is non zero, prepare type
> value according to the index, like as mask value.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

I agree with this change and I'd be happy to give you my R-b tag, but this
commit clearly needs to be backported, so you need a Fixes tag, or a Cc to stable.

Thanks,
Angelo

> ---
> v2: no changes
> ---
>   drivers/phy/mediatek/phy-mtk-tphy.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index e0f227a0d3cc..cc10298bc70d 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -915,7 +915,7 @@ static int phy_type_syscon_get(struct mtk_phy_instance *instance,
>   static int phy_type_set(struct mtk_phy_instance *instance)
>   {
>   	int type;
> -	u32 mask;
> +	u32 offset;
>   
>   	if (!instance->type_sw)
>   		return 0;
> @@ -938,8 +938,9 @@ static int phy_type_set(struct mtk_phy_instance *instance)
>   		return 0;
>   	}
>   
> -	mask = RG_PHY_SW_TYPE << (instance->type_sw_index * BITS_PER_BYTE);
> -	regmap_update_bits(instance->type_sw, instance->type_sw_reg, mask, type);
> +	offset = instance->type_sw_index * BITS_PER_BYTE;
> +	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
> +			   RG_PHY_SW_TYPE << offset, type << offset);
>   
>   	return 0;
>   }
> 

