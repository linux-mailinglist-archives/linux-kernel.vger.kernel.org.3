Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161204827FA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiAAQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:41:16 -0500
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:35681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229714AbiAAQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:41:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORT+a3mGHgKgJZuseIFGrV5NEVNnd5BMbjmsXC7vi/hZ+DJcUvnYn7o/xASsvBPKIe9l4KgDT7kmSApLOrIV1GhWpm1HAI3QBOcQ58hHQZAPaZC0VZ3pupWPvaqlOKrhQBta7H1MKepZktozi1pPvFce42YPUYp09VcWHbmXVFYvUz9ClVm62VyejSVrbkxFUD1CAArvkEjD2p6+jMJdqA472YSOxEYmBl51tXkgxc8ZpKhGwVMUbMJhsen8Dfa9XeELGCJmLA6z/0hKsLfzheHIzlf9MdcA7mBbjVjh0VvpNdx96FgXK129E463DJHN2JRfrRM4BZ34THj8UIt8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC/wzkJuabM/N5v5Om3uuctVpq8FIeDMHyki7QfUXbM=;
 b=Ldo7Y0OLbJj6V7/I5DGD65A26sm/59wny8xbI1LhBNY6Ju2KN+NJuT5h2AZPvplLpOiOVq/DxbwLBhLLztfHFPgEVOOrhPzUYrMa8XvREEyMj320uu0RsFEWswlIQw6RdEoTNE6vPiQd67vhPF7CZLoBFX4N8ngcBjD7nYp41/FS+XbYxzjx9YuofV2OObJi67vGRP7Ng2myXeU34L5vzzA21HdEUlpNuJFcVd2YwW8oihLTCS6V44HURKtBK9iSYdC+LA+DQ4hZRfwIfqtMd5AsdcRP4766mOMI4McOFNwLH7OriZ8a7MsHukTARwYZk0iJaHy9ZYE0bE9XuMV2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC/wzkJuabM/N5v5Om3uuctVpq8FIeDMHyki7QfUXbM=;
 b=GJfAMPraQII9q+8O4rdLvla/PYlAZXUIlN97Lo3TZdWFRC2VGLa3Z8PSZTP7ONlqZ2m+DFjDZdFPjP6CdGx0cl0qQaD/0KKyn/42uQvvUbSZ/KFSbw4o4hCtAWb1r8nroVW7RFEZgaGgyfKTOQ2DCl15zPXj0H4dyNC5uWETHaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2797.eurprd04.prod.outlook.com (2603:10a6:800:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 16:41:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 16:41:12 +0000
Date:   Sat, 1 Jan 2022 18:41:10 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] interconnect: imx8: Remove the imx_icc_node_adj_desc
Message-ID: <YdCEJr0bijT+eJBj@abelvesa>
References: <20220101155245.3139667-1-abel.vesa@nxp.com>
 <20220101155245.3139667-3-abel.vesa@nxp.com>
 <YdCAI6pxnS3fk+Jm@abelvesa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdCAI6pxnS3fk+Jm@abelvesa>
X-ClientProxiedBy: VI1PR0901CA0104.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::30) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e00943-49e6-4261-de5f-08d9cd458536
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2797:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB27977A9ADF68B4153956B5ADF6479@VI1PR0402MB2797.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cB4UNize/v3V+iB7FTi2Ym1Fnpnny9Fb06cukeym5B0IhB8J8id6/ByW8NoE4pPImW8S8TTTpnsXMDO7dF+5hgpdfpfq/oA7LjkYgzk0G/FLw1Df15nZlpgSL6J7k/MpBmEsrt2L4snHbxkZtsyCovqTfaaojdHQALI0UdII9wIKEyroDRER+q+k20dDtEIJV1L8ZtibPahB7GvY5Y1jZsDoPFzTxwjDUjRtdJSJ5Guf9N7XcZLy+V3RlIEB39gkQ56iuC5D1V0rXfaXv2OlbriS3GLt4uxUusEVbL5GrLp/Sd0YfKhXYwaWwQeFt6XztEVI1UGhxMicFuiAVB6MvZjODqnDUat0iMfkxd7i9C6DOxN6fUji8QOxBdRkMd1JIqLN4uU+6VxcRtUoI5FPDietVL84yrg0Te/BJ+G+okQI3srN2UbTEKeLRgLlXxVIkS4ifrKls4lBN4OV25pp4voSsrBd6dA6zNjcvMnzjgUpMS3jMAzIFzZ4CFTSSifNALSfKNhd5IWjeUGwgGtlQ+atoNnhhxksLdZW7abX4XjM5GgNXpkDFm42/GzZtewjP53ZNEOC5sSEGI9lCX9/VCv1JgtrHPrb93hGOxBMyqVdn5IB2ie7ZSYzHy81LTlRVA7KymTwODCsGn/E1jyRGeFSnfpQ+aUBIUm3av2K89sVxT/WOIaB+doVxzjRUw+8V3eRzZWIxkSgkU262Ru+lN/Wuf1BZkoOKRHxgHgl/+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(4326008)(6512007)(9686003)(5660300002)(6486002)(38350700002)(33716001)(38100700002)(66476007)(53546011)(316002)(2906002)(44832011)(86362001)(8936002)(110136005)(52116002)(186003)(30864003)(508600001)(8676002)(66556008)(83380400001)(26005)(6506007)(66946007)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYWn2Qgf2NW7f48wpPsnCiG1EfOO6gvKtJqPdo9Qe5f9Vdr4Eje5gJgOhgf5?=
 =?us-ascii?Q?vasysRQzWO84EnsyXRzZx8VZJtyjJo3aQiHplew940GLs71YND/+/3D6qQqr?=
 =?us-ascii?Q?biuNZBC1XLQH2cXBmWd9ihdd/jboXQTzfsg3J1e0uojMhOTbSN+WoEQ5pKfy?=
 =?us-ascii?Q?DAXrQ99m3DWhq0Yc77I4g28ZDIgBmOWJaXnNDwTzoiDNMohbbhSUc8Bf/E9L?=
 =?us-ascii?Q?p0szHyFeN+eM5Ew61PaT5DRfR+NdjSX7P6AVStTRkWpr7HctMbqN6riMouvv?=
 =?us-ascii?Q?/yAV4705khntLM8oMQzcqtQ7jPZqprOj1RuHNZYdWGN9Kv3O9XtLf8qqjKGQ?=
 =?us-ascii?Q?RBgw5f+5LsgLWWocssyh8OTcd8kqQJ4KUlicXrkKJkYNLq+FUrUU0EU5253b?=
 =?us-ascii?Q?+2g5nSmp6dHT2f8k5OQCFW/LN9c6DaQMc+6Bdc+EJx8CA7NIf8vBPj8e0SCM?=
 =?us-ascii?Q?8pBMP3yb8LCVbUDt5s6NGoqmLcpV+Ek+mI+ZSNK4v8AAxHWisiO1tBzioP55?=
 =?us-ascii?Q?Y/71rirmr0fwtg9az0kNBtqpo3qBd0CS0jZ7py8AAvJYQ2S63T6NB027VC8L?=
 =?us-ascii?Q?2RaDfcfAqbzz8Q26cHTLEgi67EBdzLp5rXIM8fpblmA/g0//j3N1XZZZrpqz?=
 =?us-ascii?Q?vU34S5CgdG3ZW9qpwuLrGSgqmmKBG5QuombCXChNHFFgLrZkTiKqT+0JfqNz?=
 =?us-ascii?Q?RNVsBarSSKmbvzp/iL6ZQoz38JDBD4qS2oiAMhuSQmsCDXHA6LLla8ZnwYTb?=
 =?us-ascii?Q?YjE586+pzXjr1trfCVEzqeg0/rzBWEwTMWAoyIbsUdes5W9vwFoazzC4eHFi?=
 =?us-ascii?Q?Q305637zX68fWpCRXNoTIyzrnascuZBLEETNbdspwX1Te/phqEedeSntpHzy?=
 =?us-ascii?Q?nWrc/tr3XR5XdaOeT1TBEA/UuHbd7bI4ct23MmmiiwmVvZXry3S+KEzU6QLy?=
 =?us-ascii?Q?Y2ziGNaVtHqifsGLqX1EoIXoksB+5pgN53x3Ty+NzxbDESHzN9IfG/xECumN?=
 =?us-ascii?Q?USmc6wTrh0BqlhP8SIe5gIhPKElQo0m6Kr0JS5aK+rFecTvSUCrNX5jRjwuX?=
 =?us-ascii?Q?XwJnRuJJBxhp0D3STdVopoV0ElE3z09dbAie6MH8/HWp4eurcHIQSBgmiOb7?=
 =?us-ascii?Q?JW+5CXpxSt/NdLCRrA6s6Oth48YOCHJ93Xh65ZeVh5gEYvz48zzXcCxeng5w?=
 =?us-ascii?Q?1v4FH5x4CWPmk1xf6bFH3ec01Mdoh8Z3M8a95+6CgNt1oftTc5qZcFrZjatt?=
 =?us-ascii?Q?b+BwsMYbdgQPCtNExplzxezP/9Vy3AXVY1yLwTX9dw9JwRjXfY+MBqxl7wAL?=
 =?us-ascii?Q?zGzq0fAmv2bUjsFID9nEvtwGyFhsLwxuKvpC8E+tu8jLiWdcnyiqmQoqntUZ?=
 =?us-ascii?Q?QgEIoiOVO0yJwscZhJMDQSJ9Ub75bYgde4dnnKPQMtjYQqeDwJk2poi3ulzG?=
 =?us-ascii?Q?tFoShYoAzFwDQoEQ9HgfqjY+EgP8NpZEsAL0/Tzc5MYiG1tUQkBJ6kUzseEX?=
 =?us-ascii?Q?Z2r3IuFuySBNimILhYEXw3zNqaSyIyrs5n6TS/kxTRQia+Wur6/zrp0WXRMk?=
 =?us-ascii?Q?NLKiVWOfwX7hYLGStzheh3phnvLFWeaK6eOfDW30eiOZjlYfPubCIzH+aRQs?=
 =?us-ascii?Q?+P+mqJ+OkATF2XlH0tiZpHg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e00943-49e6-4261-de5f-08d9cd458536
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 16:41:12.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwMC91t5PgiDG//YH3Cpa5v/wI6+SyaOBjX9bEdGuMGPUPabiGyzm1OPYqBH7w1e2037GdfYhppnSPPhP4asxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-01 18:24:03, Abel Vesa wrote:
> On 22-01-01 17:52:45, Abel Vesa wrote:
> > Now that the imx generic interconnect doesn't use the
> > imx_icc_node_adj_desc, we remove it from all the i.MX8M
> > platform drivers.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/interconnect/imx/imx.h    | 19 ++++-------------
> >  drivers/interconnect/imx/imx8mm.c | 32 +++++++++-------------------
> >  drivers/interconnect/imx/imx8mn.c | 28 +++++++------------------
> >  drivers/interconnect/imx/imx8mq.c | 35 ++++++++++---------------------
> >  4 files changed, 33 insertions(+), 81 deletions(-)
> > 
> > diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
> > index 75da51076c68..5c9f5138f6aa 100644
> > --- a/drivers/interconnect/imx/imx.h
> > +++ b/drivers/interconnect/imx/imx.h
> > @@ -14,15 +14,6 @@
> >  
> >  #define IMX_ICC_MAX_LINKS	4
> >  
> > -/*
> > - * struct imx_icc_node_adj - Describe a dynamic adjustable node
> > - */
> > -struct imx_icc_node_adj_desc {
> > -	unsigned int bw_mul, bw_div;
> > -	const char *phandle_name;
> > -	bool main_noc;
> > -};
> > -
> >  /*
> >   * struct imx_icc_node - Describe an interconnect node
> >   * @name: name of the node
> > @@ -35,23 +26,21 @@ struct imx_icc_node_desc {
> >  	u16 id;
> >  	u16 links[IMX_ICC_MAX_LINKS];
> >  	u16 num_links;
> > -	const struct imx_icc_node_adj_desc *adj;
> >  };
> >  
> > -#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
> > +#define DEFINE_BUS_INTERCONNECT(_name, _id, ...)			\
> >  	{								\
> >  		.id = _id,						\
> >  		.name = _name,						\
> > -		.adj = _adj,						\
> >  		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
> >  		.links = { __VA_ARGS__ },				\
> >  	}
> >  
> >  #define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
> > -	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
> > +	DEFINE_BUS_INTERCONNECT(_name, _id, _dest_id)
> >  
> > -#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
> > -	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
> > +#define DEFINE_BUS_SLAVE(_name, _id)					\
> > +	DEFINE_BUS_INTERCONNECT(_name, _id)
> >  
> >  int imx_icc_register(struct platform_device *pdev,
> >  		     struct imx_icc_node_desc *nodes,
> > diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
> > index 1083490bb391..0c16110bef9d 100644
> > --- a/drivers/interconnect/imx/imx8mm.c
> > +++ b/drivers/interconnect/imx/imx8mm.c
> > @@ -14,18 +14,6 @@
> >  
> >  #include "imx.h"
> >  
> > -static const struct imx_icc_node_adj_desc imx8mm_dram_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 16,
> > -	.phandle_name = "fsl,ddrc",
> > -};
> > -
> > -static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 16,
> > -	.main_noc = true,
> > -};
> > -
> >  /*
> >   * Describe bus masters, slaves and connections between them
> >   *
> > @@ -33,43 +21,43 @@ static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
> >   * PL301 nics which are skipped/merged into PL301_MAIN
> >   */
> >  static struct imx_icc_node_desc nodes[] = {
> > -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,
> > +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC,
> >  			IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),
> >  
> > -	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),
> > -	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),
> > +	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM),
> > +	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM),
> >  	DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),
> >  
> >  	/* VPUMIX */
> >  	DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),
> >  	DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),
> >  	DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, IMX8MM_ICN_NOC),
> >  
> >  	/* GPUMIX */
> >  	DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),
> >  	DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),
> > -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, IMX8MM_ICN_NOC),
> >  
> >  	/* DISPLAYMIX */
> >  	DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),
> >  	DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),
> > -	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, IMX8MM_ICN_NOC),
> >  
> >  	/* HSIO */
> >  	DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),
> >  	DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),
> >  	DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, IMX8MM_ICN_NOC),
> >  
> >  	/* Audio */
> >  	DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),
> >  	DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, IMX8MM_ICN_MAIN),
> >  
> >  	/* Ethernet */
> >  	DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),
> > -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, IMX8MM_ICN_MAIN),
> >  
> >  	/* Other */
> >  	DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),
> > @@ -77,7 +65,7 @@ static struct imx_icc_node_desc nodes[] = {
> >  	DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),
> > -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,
> > +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN,
> >  			IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),
> >  };
> >  
> > diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
> > index ad97e55fd4e5..8d16bd5cf006 100644
> > --- a/drivers/interconnect/imx/imx8mn.c
> > +++ b/drivers/interconnect/imx/imx8mn.c
> > @@ -11,18 +11,6 @@
> >  
> >  #include "imx.h"
> >  
> > -static const struct imx_icc_node_adj_desc imx8mn_dram_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 4,
> > -	.phandle_name = "fsl,ddrc",
> > -};
> > -
> > -static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 4,
> > -	.main_noc = true,
> > -};
> > -
> >  /*
> >   * Describe bus masters, slaves and connections between them
> >   *
> > @@ -30,23 +18,23 @@ static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
> >   * PL301 nics which are skipped/merged into PL301_MAIN
> >   */
> >  static struct imx_icc_node_desc nodes[] = {
> > -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC, &imx8mn_noc_adj,
> > +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC,
> >  			IMX8MN_ICS_DRAM, IMX8MN_ICN_MAIN),
> >  
> > -	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM, &imx8mn_dram_adj),
> > -	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM, NULL),
> > +	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM),
> > +	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM),
> >  	DEFINE_BUS_MASTER("A53", IMX8MN_ICM_A53, IMX8MN_ICN_NOC),
> >  
> >  	/* GPUMIX */
> >  	DEFINE_BUS_MASTER("GPU", IMX8MN_ICM_GPU, IMX8MN_ICN_GPU),
> > -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, NULL, IMX8MN_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, IMX8MN_ICN_NOC),
> >  
> >  	/* DISPLAYMIX */
> >  	DEFINE_BUS_MASTER("CSI1", IMX8MN_ICM_CSI1, IMX8MN_ICN_MIPI),
> >  	DEFINE_BUS_MASTER("CSI2", IMX8MN_ICM_CSI2, IMX8MN_ICN_MIPI),
> >  	DEFINE_BUS_MASTER("ISI", IMX8MN_ICM_ISI, IMX8MN_ICN_MIPI),
> >  	DEFINE_BUS_MASTER("LCDIF", IMX8MN_ICM_LCDIF, IMX8MN_ICN_MIPI),
> > -	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, NULL, IMX8MN_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, IMX8MN_ICN_NOC),
> >  
> >  	/* USB goes straight to NOC */
> >  	DEFINE_BUS_MASTER("USB", IMX8MN_ICM_USB, IMX8MN_ICN_NOC),
> > @@ -54,11 +42,11 @@ static struct imx_icc_node_desc nodes[] = {
> >  	/* Audio */
> >  	DEFINE_BUS_MASTER("SDMA2", IMX8MN_ICM_SDMA2, IMX8MN_ICN_AUDIO),
> >  	DEFINE_BUS_MASTER("SDMA3", IMX8MN_ICM_SDMA3, IMX8MN_ICN_AUDIO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, NULL, IMX8MN_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, IMX8MN_ICN_MAIN),
> >  
> >  	/* Ethernet */
> >  	DEFINE_BUS_MASTER("ENET", IMX8MN_ICM_ENET, IMX8MN_ICN_ENET),
> > -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, NULL, IMX8MN_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, IMX8MN_ICN_MAIN),
> >  
> >  	/* Other */
> >  	DEFINE_BUS_MASTER("SDMA1", IMX8MN_ICM_SDMA1, IMX8MN_ICN_MAIN),
> > @@ -66,7 +54,7 @@ static struct imx_icc_node_desc nodes[] = {
> >  	DEFINE_BUS_MASTER("USDHC1", IMX8MN_ICM_USDHC1, IMX8MN_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("USDHC2", IMX8MN_ICM_USDHC2, IMX8MN_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("USDHC3", IMX8MN_ICM_USDHC3, IMX8MN_ICN_MAIN),
> > -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN, NULL,
> > +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN
> 
> Please ignore this series. This patch will break the build due to the
> period missing at the end of the line. I'll resend V2 right away.

Sorry, I meant comma.

> 
> >  			IMX8MN_ICN_NOC, IMX8MN_ICS_OCRAM),
> >  };
> >  
> > diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
> > index d7768d3c6d8a..b8c36d668946 100644
> > --- a/drivers/interconnect/imx/imx8mq.c
> > +++ b/drivers/interconnect/imx/imx8mq.c
> > @@ -12,18 +12,6 @@
> >  
> >  #include "imx.h"
> >  
> > -static const struct imx_icc_node_adj_desc imx8mq_dram_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 4,
> > -	.phandle_name = "fsl,ddrc",
> > -};
> > -
> > -static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
> > -	.bw_mul = 1,
> > -	.bw_div = 4,
> > -	.main_noc = true,
> > -};
> > -
> >  /*
> >   * Describe bus masters, slaves and connections between them
> >   *
> > @@ -31,43 +19,42 @@ static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
> >   * PL301 nics which are skipped/merged into PL301_MAIN
> >   */
> >  static struct imx_icc_node_desc nodes[] = {
> > -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, &imx8mq_noc_adj,
> > -			IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
> >  
> > -	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM, &imx8mq_dram_adj),
> > -	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM, NULL),
> > +	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM),
> > +	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM),
> >  	DEFINE_BUS_MASTER("A53", IMX8MQ_ICM_A53, IMX8MQ_ICN_NOC),
> >  
> >  	/* VPUMIX */
> >  	DEFINE_BUS_MASTER("VPU", IMX8MQ_ICM_VPU, IMX8MQ_ICN_VIDEO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, NULL, IMX8MQ_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, IMX8MQ_ICN_NOC),
> >  
> >  	/* GPUMIX */
> >  	DEFINE_BUS_MASTER("GPU", IMX8MQ_ICM_GPU, IMX8MQ_ICN_GPU),
> > -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, NULL, IMX8MQ_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, IMX8MQ_ICN_NOC),
> >  
> >  	/* DISPMIX (only for DCSS) */
> >  	DEFINE_BUS_MASTER("DC", IMX8MQ_ICM_DCSS, IMX8MQ_ICN_DCSS),
> > -	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, NULL, IMX8MQ_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, IMX8MQ_ICN_NOC),
> >  
> >  	/* USBMIX */
> >  	DEFINE_BUS_MASTER("USB1", IMX8MQ_ICM_USB1, IMX8MQ_ICN_USB),
> >  	DEFINE_BUS_MASTER("USB2", IMX8MQ_ICM_USB2, IMX8MQ_ICN_USB),
> > -	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, NULL, IMX8MQ_ICN_NOC),
> > +	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, IMX8MQ_ICN_NOC),
> >  
> >  	/* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
> >  	DEFINE_BUS_MASTER("CSI1", IMX8MQ_ICM_CSI1, IMX8MQ_ICN_DISPLAY),
> >  	DEFINE_BUS_MASTER("CSI2", IMX8MQ_ICM_CSI2, IMX8MQ_ICN_DISPLAY),
> >  	DEFINE_BUS_MASTER("LCDIF", IMX8MQ_ICM_LCDIF, IMX8MQ_ICN_DISPLAY),
> > -	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, NULL, IMX8MQ_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, IMX8MQ_ICN_MAIN),
> >  
> >  	/* AUDIO */
> >  	DEFINE_BUS_MASTER("SDMA2", IMX8MQ_ICM_SDMA2, IMX8MQ_ICN_AUDIO),
> > -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, NULL, IMX8MQ_ICN_DISPLAY),
> > +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, IMX8MQ_ICN_DISPLAY),
> >  
> >  	/* ENET */
> >  	DEFINE_BUS_MASTER("ENET", IMX8MQ_ICM_ENET, IMX8MQ_ICN_ENET),
> > -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, NULL, IMX8MQ_ICN_MAIN),
> > +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
> >  
> >  	/* OTHER */
> >  	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
> > @@ -76,7 +63,7 @@ static struct imx_icc_node_desc nodes[] = {
> >  	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
> >  	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
> > -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN, NULL,
> > +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
> >  			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
> >  };
> >  
> > -- 
> > 2.31.1
> >
