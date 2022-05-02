Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2124A516D34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384143AbiEBJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbiEBJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:22:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9F3AA65;
        Mon,  2 May 2022 02:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU7Akp6UL8LesKRkdwEjhXmD2GeC+gdjuYtCpFyVtTfYqjTgfqSAwLp8KUxS7r6cq2wPq/C3GzHweTabO1WyqGeJ8UVyenq8MaioN3FKHb0+2u0tWx+/ev7ZV53B+kaq0iAP3ZUIJ2zJ4v7QhwpJ6NvUGFzcYxcfF/mo0SrBywRthsFRr4Su5UmKZ7rljMjZjuhcgKmb3OmfmeYPAGGX1W38trPJ/cTXU05VnctcFLFMEObg4cJ0CKB6MPMrRETOraRf6VK6PgRWhEGrkkpUJ2BhcGe6E2sY78C5C6aA3yclGdchEJEpLK0V30aRkgQjbZZwvjikMmXUGiFEkw/+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7clrQBllLTvPJ1bClryM7xcuSlCle9qh5F0w+hSKRs=;
 b=LhJtO+4fpDkhJ51uiB84Iz6zPKzTsDcXTpGRlN/LPL5cFhtNoFbqJlYyaHo1VweFHqQ0moiSWRf/ZwpG4A2SZhgtuoJjfcuW8xUae16ChyAdROzv6mHIvB4gWZFT99Z9KDR3O1/S4wX0XH2ApzFdykObLZ8AzXipxrgKE8Gv+0wcPEzfjMFv0R/0GxvIBFvD+z/myt22rHfqYCu/GVRzNdH9Vmu69WjTKcav66vxBZA65CZ0GB9heHRai1i93FzP7hhhzltlWwlUAz2CnWS2BVTWMDS7pf6U9DkG8qhVIqlH9qc28+GUH5u2vycpYAxJZ74oG0oAoKTlY/riSDA2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7clrQBllLTvPJ1bClryM7xcuSlCle9qh5F0w+hSKRs=;
 b=lO9wadsUfXac3p3WYcIh/vm2ZYheNkuvw5obaApmzK1TIrco3X9u8j76D89jQ7sWrKWk9keiNlarwKgZDDs/oBITxTHDZUNukHFA49p4gWcewbHcXuUxUzOcepGeFNWG/0e1hUJkfCstnLv9Guj6vWJ8n3ZR9q6G8hRZEBhkpKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 2 May
 2022 09:19:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78%6]) with mapi id 15.20.5206.013; Mon, 2 May 2022
 09:19:12 +0000
Date:   Mon, 2 May 2022 12:19:10 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        dev@lynxeye.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 09/15] ARM: clk: imx: Update pllv3 to support
 i.MXRT1170
Message-ID: <Ym+iDvAsrDUlfbXK@abelvesa>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-10-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-10-Mr.Bossman075@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::33) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4378d383-739e-4718-678c-08da2c1cd238
X-MS-TrafficTypeDiagnostic: AM8PR04MB7202:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM8PR04MB7202A3157C4E36960E0D7A7AF6C19@AM8PR04MB7202.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzRakLoE4oo12ZWEsB1jupAUcdvUkFNBrtULKXEPbbXwaBEh09DVNajFYg4vU2MKIHWFoxSQenyRctYBVYWkRPnn6MuiaMrsppV3qOVk1TneB38UM0lZq1b6TtYI53s6+3u8J00dvLFqkUrOKEbGduS/2u3E+8NfPIgbbRzM8rN4EbNPfo6LLNrnkomGwjmJCFS4QkC32M1qOmm0uKcgTVXI/oJ1Tm9yEmqcmDndhGopuJun74z9WPPL3dLCPuyWILJdnXef/AU8oKK7QEvI65z3LDYp9F+f0yQ7uwXIVJFOpdNDo2w2puImQQE0tg9EEn0Lrz85kwnk9I+O4Yde6avrnTpHBhoiOeBdCI0r4kj3O11cbIkPSM5HfwHBmM0lHpeFp8cl5dGnAc3gv3fiX5YL/Rm99PTrkyXietlfVHjBusyRli7RXcw0ujX8fiwX1z0EVYBxpUtFL6PIIrj7IiL8W1F96z+xOJJKu9FHVxqmohQesSvVKxkAYGjjxVktd2XvoYUFiZLt3a6pKUpGsepu3dVLLnJCGWdIlBpMDTpFj0dVDQcPsbQSxE8VjRFPYxEANilouLShqiZcp/NRKclfe3avGuvSnVLG64P8d0cHWGd0IMCNGrqsKRyAtWDetlhaJM0oi08NOksZCtICzBqi83V6BBTtFPnzJtMYsx1Zi+qAJAEhRbpBdYHzEMxK786ibIl0bpeG0gONKSCLmSQSlZFq48ad3vEOrWk9W7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(44832011)(316002)(33716001)(26005)(9686003)(5660300002)(6486002)(6916009)(7416002)(38100700002)(38350700002)(508600001)(6512007)(8936002)(52116002)(53546011)(4326008)(6506007)(86362001)(186003)(83380400001)(8676002)(66476007)(66946007)(66556008)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hm4aF9loGKY05jmd/T+0Ljm0IK/v9f0II2Sxa/FUo9yaHL7hV4RcbanXnkzc?=
 =?us-ascii?Q?MUU4iYD1s9SGn8sAX5rlZkzrMzRZGatvjcvaCAvryLJoTyUMxK+LXYpbQKHU?=
 =?us-ascii?Q?1B9RNynijh7IOkUFv1kpV/FaMoPCf93gm9vmRssp9kQ3ZgljvzmLbxWrC2RV?=
 =?us-ascii?Q?1+cjTIcuDxlEuRu6D3YjcvP/myHFrw6U09utuUrk7UCRD5dQoad0Tp3rA3ZR?=
 =?us-ascii?Q?LSZU+KYv4AqJEI7ELGgYHiJ86Re6SM4EqLXbiA1NyFoUTfT4FkqGoukBqNgs?=
 =?us-ascii?Q?4D6DJ86sP/pODbZa3IfykwzEYDftBUM2oPtc8jeem3X6qdYX8R+4KqrXgTve?=
 =?us-ascii?Q?YMWa2lmcmvo0TqmYQ4WoU+ps2fyVVkI4nH7ztF5724XiDt4YKFRB1PFsdeKB?=
 =?us-ascii?Q?fYDDLUVpou8wf7/45g2h2dO5nN5FvEoZR2zyVzUXXl26+wccsiG5WBxEIgJF?=
 =?us-ascii?Q?UgnJi3P0DWRVNTZenVGdd+p8W8VQFra3NajvcmiH4lx8DouMpv6/mMK9j9wn?=
 =?us-ascii?Q?Tdn8WAounkYeFVT8nu/A4Dlu/vDocoZr3n8+h0NDdqgGUzmbpGiLwln+mk45?=
 =?us-ascii?Q?p5SwGkpBdNfu9vaXG1Phqm8dvBLrrofqivR/AZRUUz6Y2DYDIodXhGkVX6+z?=
 =?us-ascii?Q?H+KIcGTM7zL/o8NWrtIynazjH5Mg4DK+1HEn0ICn5kv214JvMkRNO+q+ZbEh?=
 =?us-ascii?Q?AeNybbLoZX/PB4TocCLpdDEUMYUQiuPQbIxVRQYcvx0GET2Iq2zBUFjp7kyr?=
 =?us-ascii?Q?jUay3VcCYx3uBXphNggM1RrZx7AR60SzSx00X7oAduywoUtu0ntOMvuQcA8N?=
 =?us-ascii?Q?w7zLczRy/Uz2GGG5l/LDSdcgBZDgi9skuOyNcXAOWNRF6o4M6d1/PCRyl9A2?=
 =?us-ascii?Q?ffM6bnMez/HKlxxaLMDbKGAfFhfqVL3DI6yQMjKm2P3I8yMwYWp9TX8eQjPc?=
 =?us-ascii?Q?VCbtM48HjTHHvAFy+5epvIcfaE+c69NRVfla7OByAdKvyjYbgo0S54vWgtXD?=
 =?us-ascii?Q?XTwP8VuHxxwZNtANL/59xFceWx0Qm1eFUTxs6z1nblp4Dl+oWqCMGs+1xssh?=
 =?us-ascii?Q?18QwOAZhDnp821q/xGTCWgdLqdftbX4U29BokUr6zojpS5LEYadi5HhxqZUK?=
 =?us-ascii?Q?Tadc/CTyCXxpjGDJEqgJVZ2esMhefr4dRkdTdVGcFZhpy8W/DbTvToNa/Ht0?=
 =?us-ascii?Q?l5KqUbrfkLatDZfFu5sEtxRD3dj/BkwtES7/ZQ3FG3hrbDfrAVSLEqtzC0Q6?=
 =?us-ascii?Q?KrdOHBK2N92aek9YCqvTkHfuUcsQvQquC2A1ux9Wdzmol0RGJr0l9ADeoXLx?=
 =?us-ascii?Q?4Rws0s4w6j3bZMGHAWmb6PNKIav7PMOo4a9GtxgrZQdX/JJqEjlsmpiTzV87?=
 =?us-ascii?Q?H4Xxvl98LKrEMpRkRRFvFtUQpNIIgXIpWeS/fBbmahj8Q/qSFvtOIl7oniv4?=
 =?us-ascii?Q?VLAhQL56maqygeP9+ZKsT/JWqm1uXvfE9swRt4epEgmjQla0WGgbMntfXHHu?=
 =?us-ascii?Q?wG7SOUWrY+OHlgE4WyOh85uFORXjpgfa21xNNWEHUtWETujxlR+Tzjqm1vLp?=
 =?us-ascii?Q?rbOLg7NaSPlTfcTDetOMDXAu7ZfB4cLJGMuYcz2X0VR3C7RP40kB9gDcvb65?=
 =?us-ascii?Q?iu+LhPSWY6h8Ubux2NLOkLSmChsQVnfOvdwa1FgwHStaqQB+ikmZ2CFM+ZfQ?=
 =?us-ascii?Q?EsY91qhey8oQbiPAKL4v5/q0iA52CzO27d5kSwvnAM3kc+eVVYXZZdDuZUx4?=
 =?us-ascii?Q?3oGEOFoetQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4378d383-739e-4718-678c-08da2c1cd238
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 09:19:12.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpaChXTi/gER5xx4ui3ROOW9TI7/46HwUJFZsCXdJIZ1DgDhh+ItUOIKN1446UFU2/QM3RVKIdRTJYGulul7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-28 17:48:32, Jesse Taube wrote:
> The i.MXRT1170 has a pll that has the multiplier bits inverted and
> cannot be changed add IMX_PLLV3_GENERICV2.
>

Drop the "ARM:" from the subject line. It is confusing reviewers.
This is a clocks patch. Has nothing to do with arch/arm subsystem.

> The i.MXRT1170 also has the lock bit moved as well as the
> power bit inverted the power bit also is in different locations on each
> pll control register.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Nothing done
> ---
>  drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++++--
>  drivers/clk/imx/clk.h       |  4 +++
>  2 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 20ee9611ba6e..a1dbc3a2e280 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -23,6 +23,7 @@
>
>  #define BM_PLL_POWER		(0x1 << 12)
>  #define BM_PLL_LOCK		(0x1 << 31)
> +#define BM_PLL_LOCK_V2		(0x1 << 29)
>  #define IMX7_ENET_PLL_POWER	(0x1 << 5)
>  #define IMX7_DDR_PLL_POWER	(0x1 << 20)
>
> @@ -34,6 +35,7 @@
>   * @base:	 base address of PLL registers
>   * @power_bit:	 pll power bit mask
>   * @powerup_set: set power_bit to power up the PLL
> + * @lock_bit:	 pll lock bit mask
>   * @div_mask:	 mask of divider bits
>   * @div_shift:	 shift of divider bits
>   * @ref_clock:	reference clock rate
> @@ -48,6 +50,7 @@ struct clk_pllv3 {
>  	void __iomem	*base;
>  	u32		power_bit;
>  	bool		powerup_set;
> +	u32		lock_bit;
>  	u32		div_mask;
>  	u32		div_shift;
>  	unsigned long	ref_clock;
> @@ -65,7 +68,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>  	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
>  		return 0;
>
> -	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
> +	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
>  					  500, PLL_LOCK_TIMEOUT);
>  }
>
> @@ -101,7 +104,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>
> -	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> +	if (readl_relaxed(pll->base) & pll->lock_bit)
>  		return 1;
>
>  	return 0;
> @@ -155,6 +158,39 @@ static const struct clk_ops clk_pllv3_ops = {
>  	.set_rate	= clk_pllv3_set_rate,
>  };
>
> +static int clk_pllv3_genericv2_set_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long parent_rate)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +	u32 val, div;
> +
> +	div = (readl_relaxed(pll->base) >> pll->div_shift) & pll->div_mask;
> +	val = (div == 0) ? parent_rate * 22 : parent_rate * 20;
> +
> +	if (rate == val)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static unsigned long clk_pllv3_genericv2_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +	u32 div = (readl_relaxed(pll->base) >> pll->div_shift)  & pll->div_mask;
> +
> +	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
> +}
> +
> +static const struct clk_ops clk_pllv3_genericv2_ops = {
> +	.prepare	= clk_pllv3_prepare,
> +	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
> +	.recalc_rate	= clk_pllv3_genericv2_recalc_rate,
> +	.round_rate	= clk_pllv3_round_rate,
> +	.set_rate	= clk_pllv3_genericv2_set_rate,
> +};
> +
>  static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
>  					       unsigned long parent_rate)
>  {
> @@ -407,6 +443,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
>  	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>  };
>
> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +
> +	pll->power_bit = shift;
> +}
> +
>  struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  			  const char *parent_name, void __iomem *base,
>  			  u32 div_mask)
> @@ -422,10 +465,20 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  		return ERR_PTR(-ENOMEM);
>
>  	pll->power_bit = BM_PLL_POWER;
> +	pll->lock_bit = BM_PLL_LOCK;
>  	pll->num_offset = PLL_NUM_OFFSET;
>  	pll->denom_offset = PLL_DENOM_OFFSET;
>
>  	switch (type) {
> +	case IMX_PLLV3_GENERICV2:
> +		pll->lock_bit = BM_PLL_LOCK_V2;
> +		pll->powerup_set = true;
> +		ops = &clk_pllv3_genericv2_ops;
> +		break;
> +	case IMX_PLLV3_SYSV2:
> +		pll->lock_bit = BM_PLL_LOCK_V2;
> +		pll->powerup_set = true;
> +		fallthrough;
>  	case IMX_PLLV3_SYS:
>  		ops = &clk_pllv3_sys_ops;
>  		break;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 7d220a01de1f..e70e985840a4 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -220,6 +220,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
>
>  enum imx_pllv3_type {
>  	IMX_PLLV3_GENERIC,
> +	IMX_PLLV3_GENERICV2,
> +	IMX_PLLV3_SYSV2,
>  	IMX_PLLV3_SYS,
>  	IMX_PLLV3_USB,
>  	IMX_PLLV3_USB_VF610,
> @@ -231,6 +233,8 @@ enum imx_pllv3_type {
>  	IMX_PLLV3_AV_IMX7,
>  };
>
> +void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift);
> +
>  struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  		const char *parent_name, void __iomem *base, u32 div_mask);
>
> --
> 2.35.1
>
