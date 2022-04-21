Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811965096E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384485AbiDUFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:39:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1EE12093;
        Wed, 20 Apr 2022 22:36:20 -0700 (PDT)
X-UUID: a9312b898733484fa1ac93e97664829f-20220421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5e5ef666-9c2a-421e-9c78-5042f2324c18,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:6cb79aef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a9312b898733484fa1ac93e97664829f-20220421
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 562152983; Thu, 21 Apr 2022 13:36:16 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Apr 2022 13:36:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 21 Apr
 2022 13:36:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Apr 2022 13:36:14 +0800
Message-ID: <8c42fd4345063a9a538b0c28342171616c9d0b02.camel@mediatek.com>
Subject: Re: [PATCH V2 09/12] clk: mediatek: reset: Add support for input
 offset and bit from DT
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 21 Apr 2022 13:36:14 +0800
In-Reply-To: <20220420130527.23200-10-rex-bc.chen@mediatek.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-10-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 21:05 +0800, Rex-BC Chen wrote:
> To use the clock reset function easier, we implement the of_xlate.
> This function is only adopted in version MTK_SET_CLR because of
> the method of id calculation.
> 
> There is no impact for original use. If the argument number is not
> larger than 1, it will return original id.
> 
> With this implementation if we want to set offset 0x120 and bit 16,
> we can just write something like "resets = <&infra_rst 0x120 16>;".
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/reset.c | 24 ++++++++++++++++++++++++
>  drivers/clk/mediatek/reset.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/reset.c
> b/drivers/clk/mediatek/reset.c
> index 1173111af3ab..dbe812062bf5 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -59,6 +59,20 @@ static const struct reset_control_ops
> mtk_reset_ops_set_clr = {
>  	.reset = mtk_reset_set_clr,
>  };
>  
> +static int reset_xlate(struct reset_controller_dev *rcdev,
> +		       const struct of_phandle_args *reset_spec)
> +{
> +	unsigned int offset, bit;
> +
> +	if (reset_spec->args_count <= 1)
> +		return reset_spec->args[0];
> +
> +	offset = reset_spec->args[0];
> +	bit = reset_spec->args[1];
> +
> +	return (offset >> 4) * 32 + bit;
> +}
> +
>  static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
>  	[MTK_RST_SIMPLE] = &reset_simple_ops,
>  	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
> @@ -98,6 +112,11 @@ int mtk_clk_register_rst_ctrl(struct device_node
> *np,
>  	data->rcdev.ops = rst_op[desc->version];
>  	data->rcdev.of_node = np;
>  
> +	if (desc->version == MTK_RST_SET_CLR) {
> +		data->rcdev.of_reset_n_cells = max(desc->reset_n_cells, 
> 1);
> +		data->rcdev.of_xlate = reset_xlate;
> +	}
> +
>  	ret = reset_controller_register(&data->rcdev);
>  	if (ret) {
>  		pr_err("could not register reset controller: %d\n",
> ret);
> @@ -143,6 +162,11 @@ int mtk_clk_register_rst_ctrl_with_dev(struct
> device *dev,
>  	data->rcdev.of_node = np;
>  	data->rcdev.dev = dev;
>  
> +	if (desc->version == MTK_RST_SET_CLR) {
> +		data->rcdev.of_reset_n_cells = max(desc->reset_n_cells, 
> 1);
> +		data->rcdev.of_xlate = reset_xlate;
> +	}
> +
>  	ret = devm_reset_controller_register(dev, &data->rcdev);
>  	if (ret)
>  		dev_err(dev, "could not register reset controller:
> %d\n", ret);
> diff --git a/drivers/clk/mediatek/reset.h
> b/drivers/clk/mediatek/reset.h
> index 30559bf45f7e..4cfc281fc50d 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -19,6 +19,7 @@ struct mtk_clk_rst_desc {
>  	u8 version;
>  	u32 reg_num;
>  	u16 reg_ofs;
> +	int reset_n_cells;
>  };
>  
>  struct mtk_clk_rst_data {

Hello all,

I think reset_xlate can also support for MTK_RST_SIMPLE.
If this patch is acceptable, I will modify for MTK_RST_SIMPLE in next
version.

BRs,
Rex

