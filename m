Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859045A78A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiHaIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiHaIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:14:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F83BD153;
        Wed, 31 Aug 2022 01:14:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6F8F6601A13;
        Wed, 31 Aug 2022 09:14:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661933668;
        bh=MxOD5M65W1GJcNc0Z8B2s/tYrrWG9J/LN9h5lRW6bSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iaGCilpQKPcvOdreLUtUnyAO/H8KlaMdDQY5OwiupI4t3Ruht7gtwqhUgexUB9SPV
         p4okatpOHehg5tuz60UsjxuUuTKp07/aH9d94kH53QPMA/Bkeg0z8oxof/I1XPKUgw
         J/P5qqUYbelSw0cQUg2qqwljDtPkXqieT86jRDFdBkFhCycZOXOaTKBebwT8PpF6h5
         AxxrV3K60UmDTdA9mzSlWdXHYBCBmFS6MOSp2IkWcskFS6tinz73Y1ioLbE8Ic3edB
         oqooAJiBqGuoYJww0T4/ga0JmNHLFLVEJNhReQmRIMCpVvuhpRff8IDuIbN6o6LyiR
         X8CTpZsWeNlnw==
Message-ID: <219aef5a-af2a-6873-f682-cb6aef862425@collabora.com>
Date:   Wed, 31 Aug 2022 10:14:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/7] phy: phy-mtk-tphy: add property to set
 pre-emphasis
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
 <20220829080830.5378-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220829080830.5378-3-chunfeng.yun@mediatek.com>
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
> Add a property to set usb2 phy's pre-emphasis, it's disabled by default
> on some SoCs.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>   drivers/phy/mediatek/phy-mtk-tphy.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 8ee7682b8e93..986fde0f63a0 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -72,6 +72,8 @@
>   #define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
>   
>   #define U3P_USBPHYACR6		0x018
> +#define PA6_RG_U2_PRE_EMP		GENMASK(31, 30)
> +#define PA6_RG_U2_PRE_EMP_VAL(x)	((0x3 & (x)) << 30)

Hello Chunfeng,

can you please clarify which SoC is this change referred to?

If I'm not missing anything, there may be a register layout conflict between
one version and the other for T-PHYs, for which, it may be a good idea to add
a PHY version check before allowing to write settings that are supported only
on a specific IP...

Regards,
Angelo

