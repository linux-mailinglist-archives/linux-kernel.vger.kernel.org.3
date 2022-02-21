Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233764BE1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357521AbiBUMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:12:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357517AbiBUMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:11:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11720F78;
        Mon, 21 Feb 2022 04:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdL0YMZjMUDZ2ZdB+yDvG5/aX1/87aWCPBonqt6+2AMoC5JcvUpo0eTsce+fC0Tvl7i/VmLD3i2BEUZtSdSIcn6iS38sbNoGubdyLev8YT008E4NE8X/tX9dpDroQpO7lry3GxIQGONoZecalFTJICMfFmDyVD7OWT2bEJyL2ryq3gPQGvJbCa+CAXQekiZkjHAKK5ePDlTu2zbILEXkmqo937ZhPxNrcYwWH9APr7RDXXHRj5t6Ny8rIPJhiCzRtcGYvtNNxQuQQnIRg6aGdwrojOllxhtzr1u+OhE1F6p0cNIVgI+jNZoTXjW5nPdunOA1Oh7ZcAiLq+lj5FCzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAVjcRqd9m1BXESvAYqgk5wW+7qWPXaCdEWwUgdnK3Y=;
 b=HWvpixmN0BWge6brdjhik2mHUZmNzEgFB0JssoqlNbJvMq0ondDVKhvXjgO3UoeVn0X4PG9+OkKJadrtRexYstxFkO++HUKtNfItctE/UXkEfyGjISvxqxAa0FeSMP2kZr4Sa82+iOVPU8ZyFqdLCjb0BugRZjTVQRAR2/Mo9uupnC2N6lnOGkhy+ofZ3dZ3YM3sYX1tFDHzsNOtv8FayXo5yGVIZGNWlt0HHmF20Ygrbb4bj1HTyAVxT5/Kl9iiHjGV3rmv+J0yMdxhwzbEknIlbig6BCpmhoEthWKS2PYc8CVqtxSM3m6SP0fPXBvrbm6XKIs1nZlojM8ZXxQ9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAVjcRqd9m1BXESvAYqgk5wW+7qWPXaCdEWwUgdnK3Y=;
 b=mTFPTVbr5j5M58nO/VGK4lKzBKqlrs6b71lxZJypv7Ci0YIa36cczyhCOkbCF4x92QknNLUxHxpdPEVM7ku+e7sJu/48ATmSD5FRe4uB/hFrbjfK+1mMOPu6DsEi5RGaQmYmX5aVsL0KbTA7l9LYbEH4nhb0za2bWLqpxCqhsLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3423.eurprd04.prod.outlook.com (2603:10a6:803:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 12:09:52 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::2936:6a6f:6e6f:161f%6]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 12:09:52 +0000
Date:   Mon, 21 Feb 2022 14:09:48 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/4] clk: imx: add i.MX93 composite clk
Message-ID: <YhOBDJDdL0Z2tk/j@abelvesa>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
 <20220215081835.790311-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215081835.790311-3-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:803:1::15) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b45c8c4-c7a9-4fec-f371-08d9f5331089
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3423:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB34238F55DE0662A39194F633F63A9@VI1PR0402MB3423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZVmFCYVS7Bv7TFUaLDLlb8FAa/j7sGh58UVfW31Y6HzShrLwClZ8c5na81U3kV5q0SKBUYG1pXnqLJ29Cr02JS4o95hvvd6T/4bdVbX7WqDZE5hSvn9E5rd1d0mdnVOFWndAd9SlhinefdIWFYx5pZVKI2BM4WCHX/ai6GMe8DaEYlAjPJ5V+IyeaLfTLEUhheo/6mnlK+ht616wxY5Xu2AQ5PVXh3FA9879MeyzNaeZgiQct8jkZ/7mLZJyurO+ppNxQjpera4xN5R83seEn4td0pEsED5OUyAwpOa0eqEoMADrjTUPVRFXJK/6lXx6589Uv+JEVOiowu4mU0k1NmOY6GdTNSdU4ze04VN9jscN4R6WpBHQr+H6adNeWpA04JhT1Vm82gZ3yCLsiPymUpL6CVbvkhD7tEfzh7UoC571F8z0dn2+ShZOgExRvyfruKoN0MQu+UzJWkoMuG+3KLZCE9/tM1845kA3WsQxBLitK+RIVZwprbnX0yaSWD1tMF08GCma9iOSNtT3wr9wqkveDVYHTWxea0feoh+3nuWeVIJR99hREKK5sW7By8ZAX+n7I038YiLOVfaSVozSmYTfh5isCyLrvDVLTPkVzveBAZBlMj9hp1B4xCQh8XReNLSwuYHh2XZK2eXU0WD6iWysgryTFLyS2hCfplF2jlzGS0g1dBcMh5QkHjQRG9yi2dB8xPfqG8lnsbHiB4RlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(44832011)(8936002)(26005)(7416002)(66476007)(186003)(6506007)(6512007)(6486002)(9686003)(6666004)(38350700002)(38100700002)(316002)(508600001)(66946007)(66556008)(4326008)(6862004)(83380400001)(86362001)(53546011)(8676002)(33716001)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2spoNgtq3LpmwheoxAz3MoQf3EI80AAgGpRQJLNHET4uNPwsDHsX4BzSsAw?=
 =?us-ascii?Q?tTpSE9eRkniAYW+GREmc04dXTO3Ice3FkSqu97hCjJ6cKMh3A3wAf2ahQ4nM?=
 =?us-ascii?Q?gQpOrGxRa3ov1gzYill8E3JZqB7BE0vymDDMM8VP0M9g6YF0R6wUH8XcjUFD?=
 =?us-ascii?Q?zSx4MLAd9+Ll7YBMLT1w4e+SDL8IxYM75+jQWJ3DOcP1VTH/NE11izAXMQjP?=
 =?us-ascii?Q?HHxqdN0CeT1ljAluzLUurNI3r2vxctQENAVBTKsiTIRhyqZydIAiJBJvEgkT?=
 =?us-ascii?Q?5jx38a8w0ih6SAOkMnbYNiaxlOxOraFAW3mCOPAxRfI6Tb283MvFrX3WMUIV?=
 =?us-ascii?Q?rx5I8e3wyOaqGmSoyiMGkDd3509aJsL32grqN7Cr5rJYtIueyKITh/cYmDUz?=
 =?us-ascii?Q?f4vX/0YiaYuvkhJVs7dmlKIzSVObuqknxLOUAENiDl4ZD9866US2fKibGHA9?=
 =?us-ascii?Q?/AjU/AzEesRErpKoigVzULfDBXaqciFI+D8ZJge+dFqBt+WDOGOoe787zUq5?=
 =?us-ascii?Q?OJrvQzBRJ2uPu9DWRtHgCPHDzjWL2sXu9hX+O5REo8YsxzJOQh3AL2ir2Wq7?=
 =?us-ascii?Q?FbnXaI2zf6UkUehRhoSoMVRoIPvE1Pgky4BzGp7xwhHIz52fKiCq/LZrep6J?=
 =?us-ascii?Q?axRQEhS92j/ZoH59gdfYYZ2/I/Tr2ErlA1rj2iXoNLyT601MHRJS69OmuEFf?=
 =?us-ascii?Q?R5js1Hv6+MK3IDgtph3ANb7Bw/1CFGQMXU0056hZZF+lXd8kuYIXTW986G1q?=
 =?us-ascii?Q?1PwUMVJN3Ihn53c7sTjtK6ztblK1b7njk9213YVouyNxkjWkJhwkf8IWOfGf?=
 =?us-ascii?Q?fQkxLJNkG+WQRZtFqNzhotbiRaifvRdw4JOa2A1dF5T5HCYHtGHIlSbp1vZB?=
 =?us-ascii?Q?hY31oTNtR3Cu0dgOo8X7AAZg30z+221xkLTV7Tj/mOPFTFrNZa21/qEb1arY?=
 =?us-ascii?Q?32DYFze8t6TtL35j+ggW5hq9RzRuCF1pyzglVueJmdxZWNfK8kfSIMjirDaw?=
 =?us-ascii?Q?zQa7OEYuXdofY6uRUOzk5Nsc4SWkJPszpkRF5tJszD9hS4c1UEzMTgm4ZY2n?=
 =?us-ascii?Q?dU6SWdDRSwzkWSJda4X0hHhMWel5PP/0fXdj+fhqL6fqPb35RY+yvBdZmgtw?=
 =?us-ascii?Q?qTltyZKV9cGlHe0y9Jin65J2+WJeotlMSi+s6c3FXFzAFXgdiBl+a62YDmyD?=
 =?us-ascii?Q?dzaXnXND8ETrUEht1klZ26Ohn8H02/gf7Q72UwoxqnFUqJHpjuS7+dnog7ju?=
 =?us-ascii?Q?OvbrOslpvG8iAzdLIuVbVwcxyEeR8yFBN9gkWfvLl+RFcUN1xSGhZg/ZxcNx?=
 =?us-ascii?Q?Kl78KwaRaqbhhOlCYGq1zMSEkW1UblXA06BrFWtXEv58XaPQaSJ7SnP4xOTD?=
 =?us-ascii?Q?d6T+/xBn+7o2BjqjzVJideeGjdgu3lIVVco1239a1UsO5VgaQPou3NLi27ir?=
 =?us-ascii?Q?rzJSpuj4m166LV56r/qX1HSnjJ1lMGXevAonm/ylUOnx0eHzjGbhhsIYVoOI?=
 =?us-ascii?Q?hybD+csA6b5dCuY5x7lu7OH+V/4sEOxTzpRAi1jGipKLMU+Ejt82WiiHvS3T?=
 =?us-ascii?Q?dE02i9kkNf78qL7t4r4mHYHpOWK27yr3ukGus2mqDuB08kamU5jcBg9lsuk8?=
 =?us-ascii?Q?jx5a4HwkcqjG8P74Grhrlpk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b45c8c4-c7a9-4fec-f371-08d9f5331089
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:09:52.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5ghqAuj/0/5SUyWK0btWY26jC55RMBIB8OGCxJh3YfKONKkV1/ymsU1hd3vx7n6dH1C5H82lUA+oBp2wdIVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-15 16:18:33, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 CCM ROOT clock has a mux, gate and divider in one register, here
> is to combine all these into one composite clk and simplify clk tree.
> i.MX93 CCM is a new IP compared with i.MX8M, so introduce a new file.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/Makefile           |  1 +
>  drivers/clk/imx/clk-composite-93.c | 93 ++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h              |  9 +++
>  3 files changed, 103 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite-93.c
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b5e040026dfb..15549a1c332f 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -4,6 +4,7 @@ mxc-clk-objs += clk.o
>  mxc-clk-objs += clk-busy.o
>  mxc-clk-objs += clk-composite-7ulp.o
>  mxc-clk-objs += clk-composite-8m.o
> +mxc-clk-objs += clk-composite-93.o
>  mxc-clk-objs += clk-cpu.o
>  mxc-clk-objs += clk-divider-gate.o
>  mxc-clk-objs += clk-fixup-div.o
> diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
> new file mode 100644
> index 000000000000..b44619aa5ca5
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite-93.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 NXP
> + *
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define CCM_DIV_SHIFT	0
> +#define CCM_DIV_WIDTH	8
> +#define CCM_MUX_SHIFT	8
> +#define CCM_MUX_MASK	3
> +#define CCM_OFF_SHIFT	24
> +
> +#define AUTHEN_OFFSET	0x30
> +#define TZ_NS_SHIFT	9
> +#define TZ_NS_MASK	BIT(9)
> +
> +struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *parent_names,
> +					 int num_parents, void __iomem *reg,
> +					 unsigned long flags)
> +{
> +	struct clk_hw *hw = ERR_PTR(-ENOMEM), *mux_hw;
> +	struct clk_hw *div_hw, *gate_hw;
> +	struct clk_divider *div = NULL;
> +	struct clk_gate *gate = NULL;
> +	struct clk_mux *mux = NULL;
> +	bool clk_ro = false;
> +
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		goto fail;
> +
> +	mux_hw = &mux->hw;
> +	mux->reg = reg;
> +	mux->shift = CCM_MUX_SHIFT;
> +	mux->mask = CCM_MUX_MASK;
> +	mux->lock = &imx_ccm_lock;
> +
> +	div = kzalloc(sizeof(*div), GFP_KERNEL);
> +	if (!div)
> +		goto fail;
> +
> +	div_hw = &div->hw;
> +	div->reg = reg;
> +	div->shift = CCM_DIV_SHIFT;
> +	div->width = CCM_DIV_WIDTH;
> +	div->lock = &imx_ccm_lock;
> +	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
> +
> +	if (!(readl(reg + AUTHEN_OFFSET) & TZ_NS_MASK))
> +		clk_ro = true;
> +
> +	if (clk_ro) {
> +		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +					       mux_hw, &clk_mux_ro_ops, div_hw,
> +					       &clk_divider_ro_ops, NULL, NULL, flags);
> +	} else {
> +		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +		if (!gate)
> +			goto fail;
> +
> +		gate_hw = &gate->hw;
> +		gate->reg = reg;
> +		gate->bit_idx = CCM_OFF_SHIFT;
> +		gate->lock = &imx_ccm_lock;
> +		gate->flags = CLK_GATE_SET_TO_DISABLE;
> +
> +		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +					       mux_hw, &clk_mux_ops, div_hw,
> +					       &clk_divider_ops, gate_hw,
> +					       &clk_gate_ops, flags | CLK_SET_RATE_NO_REPARENT);

Just a thought. Could we just extend the imx8m_composite to do this, instead
of adding this new one? I mean, just because it is a new SoC, doesn't
mean we can't reuse the imx8m composite. 

> +	}
> +
> +	if (IS_ERR(hw))
> +		goto fail;
> +
> +	return hw;
> +
> +fail:
> +	kfree(gate);
> +	kfree(div);
> +	kfree(mux);
> +	return ERR_CAST(hw);
> +}
> +EXPORT_SYMBOL_GPL(imx93_clk_composite_flags);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 7d220a01de1f..63eb7c53b123 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -419,6 +419,15 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  			IMX_COMPOSITE_FW_MANAGED, \
>  			IMX_COMPOSITE_CLK_FLAGS_CRITICAL_GET_RATE_NO_CACHE)
>  
> +struct clk_hw *imx93_clk_composite_flags(const char *name,
> +					 const char * const *parent_names,
> +					 int num_parents,
> +					 void __iomem *reg,
> +					 unsigned long flags);
> +#define imx93_clk_composite(name, parent_names, num_parents, reg) \
> +	imx93_clk_composite_flags(name, parent_names, num_parents, reg, \
> +				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
>  struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
>  		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
> -- 
> 2.25.1
>
