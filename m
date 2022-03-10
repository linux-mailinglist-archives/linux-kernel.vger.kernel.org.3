Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594D44D4E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiCJQIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiCJQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:08:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4D186466;
        Thu, 10 Mar 2022 08:06:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A441E1F40649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646928417;
        bh=ZiS/SPnwQg61kBgd93FXFvniwS51SClGVI0Qf1ZMNxk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VFAI6Al10tnepVyxeGIIzzYWTeLv5ZQBIqdkRLEtxjcGAt2khOqoqObnB7LoK6+yz
         N9YEyXhenA8DXI0VTQcbby7Si5uZpdZJNJJC8jBhV3V7bwSeNVGn5f0y95yQvmTn/G
         CRhaEbydHUGeJVNZpo60qJ0OhDFG+4YCJBKECSdSmXUo2+v7Q/lO8xJSzZplnDgDnI
         RCBXTLzrqMcVqq16Rltr1qS2Dnqov9qLLCllIRVSzzqVqRjPbDeBbA+ODnkFvScLOe
         xSAr3zv6md0Zz9+YKjkBPgl7vaudM1LuTWqF4lDvDbJlPncEkvCI5S2zfSwHEIA+sK
         T45amm6QPgw5A==
Message-ID: <f6e2a491-d701-d05c-eb3b-2f8f5c080a16@collabora.com>
Date:   Thu, 10 Mar 2022 17:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] pinctrl: mediatek: Fix missing of_node_put() in
 mtk_pctrl_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308071155.21114-1-linmq006@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308071155.21114-1-linmq006@gmail.com>
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

Il 08/03/22 08:11, Miaoqian Lin ha scritto:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: a6df410d420a ("pinctrl: mediatek: Add Pinctrl/GPIO driver for mt8135.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 5f7c421ab6e7..334cb85855a9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1038,6 +1038,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
>   	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
>   	if (node) {
>   		pctl->regmap1 = syscon_node_to_regmap(node);
> +		of_node_put(node);
>   		if (IS_ERR(pctl->regmap1))
>   			return PTR_ERR(pctl->regmap1);
>   	} else if (regmap) {
> @@ -1051,6 +1052,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
>   	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
>   	if (node) {
>   		pctl->regmap2 = syscon_node_to_regmap(node);
> +		of_node_put(node);
>   		if (IS_ERR(pctl->regmap2))
>   			return PTR_ERR(pctl->regmap2);
>   	}
> 

