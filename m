Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47DE4B6E23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiBONzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiBONzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:55:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF206111089
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:54:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 57EDF1F44A2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644933296;
        bh=rhLKPavogy4229Ih++6dC1Fw+vvxjg8moyVEEB6fzwI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D2v2T3izIRsTe3TSERHpecE98t1Axt7AuUXaZGywAcYlR6yvxkP2KcmKP3ns5RqE7
         2UPxsE2hyNyulyUVHRjRUQr7N5naVk2doVlYjA8thMvpTaJIm3+dD5yVSsHo0HM7Bq
         oSqdxkCboiZx2TM97W2Ajh+VmI/hoUCmTwtxQdGRBR/vdVETtpQG5duo+ecANQp8uB
         Kw9VvHkb/REgQSgc9lmqV+E0x8By7ob9dEMnWvfvKFQshNUfv62beOPyN/A+VQeSEj
         m1R8aT1bmVyeSuQH+G3mwY9m8qMJIyZhI7ftLIjYGMcBjAfDQlU50tuz1SOXYQTqha
         rg8dGT46OqofA==
Message-ID: <da4b7285-1f2d-01a0-9a1d-1381b4772512@collabora.com>
Date:   Tue, 15 Feb 2022 14:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [1/2] soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver
 data
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, matthias.bgg@gmail.com
Cc:     chunkuang.hu@kernel.org, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
 <20220215131952.27861-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220215131952.27861-2-rex-bc.chen@mediatek.com>
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

Il 15/02/22 14:19, Rex-BC Chen ha scritto:
> There are different software reset registers for difference MTK SoCs.
> Therefore, we add a new variable "sw0_rst_offset" to control it.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
>   drivers/soc/mediatek/mtk-mmsys.c    | 6 ++++--
>   drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
> index 9dee485807c9..0c021f4b76d2 100644
> --- a/drivers/soc/mediatek/mt8183-mmsys.h
> +++ b/drivers/soc/mediatek/mt8183-mmsys.h
> @@ -25,6 +25,8 @@
>   #define MT8183_RDMA0_SOUT_COLOR0		0x1
>   #define MT8183_RDMA1_SOUT_DSI0			0x1
>   
> +#define MT8183_MMSYS_SW0_RST_B			0x140
> +
>   static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
>   	{
>   		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 0da25069ffb3..cab62c3eac05 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -49,12 +49,14 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8173-mm",
>   	.routes = mmsys_default_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_default_routing_table),
> +	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
>   };
>   
>   static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8183-mm",
>   	.routes = mmsys_mt8183_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
> +	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
>   };
>   
>   static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
> @@ -128,14 +130,14 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
>   
>   	spin_lock_irqsave(&mmsys->lock, flags);
>   
> -	reg = readl_relaxed(mmsys->regs + MMSYS_SW0_RST_B);
> +	reg = readl_relaxed(mmsys->regs + mmsys->data->sw0_rst_offset);
>   
>   	if (assert)
>   		reg &= ~BIT(id);
>   	else
>   		reg |= BIT(id);
>   
> -	writel_relaxed(reg, mmsys->regs + MMSYS_SW0_RST_B);
> +	writel_relaxed(reg, mmsys->regs + mmsys->data->sw0_rst_offset);
>   
>   	spin_unlock_irqrestore(&mmsys->lock, flags);
>   
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index 8b0ed05117ea..83320019b4cf 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -78,8 +78,6 @@
>   #define DSI_SEL_IN_RDMA				0x1
>   #define DSI_SEL_IN_MASK				0x1
>   
> -#define MMSYS_SW0_RST_B				0x140
> -
>   struct mtk_mmsys_routes {
>   	u32 from_comp;
>   	u32 to_comp;
> @@ -92,6 +90,7 @@ struct mtk_mmsys_driver_data {
>   	const char *clk_driver;
>   	const struct mtk_mmsys_routes *routes;
>   	const unsigned int num_routes;
> +	const unsigned int sw0_rst_offset;

I don't think that this offset will ever be larger than 0xffff.
Can we use u16 here instead?

>   };
>   
>   /*



