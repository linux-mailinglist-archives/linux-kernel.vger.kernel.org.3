Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E24827EF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiAAQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:24:10 -0500
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:56481
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231774AbiAAQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTdhoJd0diVNPCF6mzwrtN2yVPP8CW96a8A6rgsBEuqi4fgf5iSC8qou8pCLSeRDgabjzNBdXK698TCSf0uUGVnfsQbZgpVSInmjIj79qrDTY1F3IsnLiLOji+T/xib+IL0r1eCsjoF9ftgwmSxCpMOHUxq/G9tL91vMc+HtUCeDoDghNs6zmTtF1E37iE3KU/FeUv0EPt4BLTuiPKm22fl948V9kgf7dHH6dofTGyK6vKlrEO88Ep4A+kcnk2x21743Zlc91fhnLiufPSgL5gHzHU1zUFDPT83+7NxvNGGGQ9AoN7Yx0egoRxE0ijvI5kH3QAaX8gf4K6G43OzAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj3bA4kXaP8U5wn/gbqAXZQ05bN8qWPz+fr0/ibxGZY=;
 b=MAR/yZ9cZKXfOYCuvhls6E8P0/0eFPqIf0GnEzXhEMESz+gu0COLRh96ItVH2N/3BKYo7jP+T8kdXjDJLl498MzjX/EqiXPHdoMy1uGfLik9T+0Xf8IpMxa61qbCzx5FfnZg3f5xiGEyxVobl5Jg944Ac06azS+8Y13zPa8Y5XZOZ2SfE3qP/oAM3ENJ89r9Vv9pYmIyJoWQ3r4K3lyVC220UWBVUK303vrOvomUPvrZijfqzeLJ7l1KcUAedfXUWazis/C+SbYvVfvg37NS1v5gO6323vxi2rEsb0ziGVQEoIk+cmjVasELW+OdjemIjgtLiFaurTDddQ7vhzIWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj3bA4kXaP8U5wn/gbqAXZQ05bN8qWPz+fr0/ibxGZY=;
 b=BdheNTF+p8LZkqm+x3zKkStiCKHEtbhu7xqOZWJ1RJ5oCrZ8MKgnngAo0p3SS0B9kUrBE5Snq8eMbaG4shz2i4rmXj6BfDBm47HNTFDPcZ4Tqf4P/0LFGAFY7jUXnbcg7vHKYoQNFIJlSSJTiIULGF/WhLY8F1i09Xmr7Y4TDVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5293.eurprd04.prod.outlook.com (2603:10a6:803:5f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 16:24:06 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 16:24:06 +0000
Date:   Sat, 1 Jan 2022 18:24:03 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] interconnect: imx8: Remove the imx_icc_node_adj_desc
Message-ID: <YdCAI6pxnS3fk+Jm@abelvesa>
References: <20220101155245.3139667-1-abel.vesa@nxp.com>
 <20220101155245.3139667-3-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101155245.3139667-3-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR09CA0146.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::30) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88835eaa-113c-4a2d-54c2-08d9cd43218e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5293:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB52939461E070C02EF26EF5D5F6479@VI1PR04MB5293.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGIbrlPdphak8xa952jg38RA4YNfptYjU2gruekrxMREcsIeW/gW0fY0A3g/o+i3AI019INvL7XL5HYheAsMK16X/t1k0pW7fzRnk6fSv4diOPmOmJap7uz0mGTI6a3Ka77F1jKQ/UnztIo1dyQBMtnqnCLGoAEd2e5gAklZWKc+eAkihyK6HBziyHrEgAlyB+CaQl+wyPbubI+wFzlveDrslqGZO+rMNopR+Qi7Wg58KI6B/g+EyeUMom8ef5TUCWICExSjDj+05HeqWEyH6QUoFQ6wW1M4CNDvUzaPdhoTmraGcrcTtTy+sYBqQ6ogyaA1OZ7bGSPCan+NbEIQRI4umED1ChXsMw98lfvwIP+03B+CqlOU7XJPb5qw/ywiT9tHtXGbqLMVQTkvHSqj6m3O/wbo9X5LVwXksgnXZqt2dp2/4ln6cgTHQUdgxVkPTKOz1thbVDBqy/yWViYW4M4PhMh1uPE07DZ2yVt5+FCLzobbgLbrUyUF3hiHujDCKaFzIwannS/j+L00Ya5Q+++Gb+29b68RxGRsAcyuKCsqANLe6OZWKUYbHpzG0pzdZkmPDxjDTnyel4ogQ4hBofkvJQTUWwZDC8zvN85C3a5jWfixumjSEAQ8BDD2qEVBifRIIWPBxYyAYH2igp6BazDb/XPas10Ozg17pn++Geo2mSimhVVkglErAVdW5B9M/Vqx5Shz9a8YNJUtBllULca4gB8Kt1akrNR+To6iJEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6512007)(6486002)(66946007)(8936002)(44832011)(66556008)(5660300002)(38350700002)(6506007)(9686003)(66476007)(186003)(4326008)(38100700002)(53546011)(110136005)(30864003)(316002)(52116002)(8676002)(508600001)(83380400001)(26005)(6666004)(2906002)(54906003)(86362001)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1YsXeXTE2Pvug3gHg1lRdn9ObBr7MbkjY7YF6wMjTJQJT4LAdC5L5SdbHgc?=
 =?us-ascii?Q?AlURyYnW/NHceAbt8Jbz0+8auWc0ChSteagWn6ZSMXuWkT4d23vIGPbbzB95?=
 =?us-ascii?Q?kBWvhM3LVTWAVMORnIupy/1OCAOLjgmPsNLfVuB4KCZaE13gbq8QirapIE9v?=
 =?us-ascii?Q?kigXSRghiY2REe5W7vM7C1LiP51e+AomiHF8a1bKlLKVCI6KcHC+bmOhe39M?=
 =?us-ascii?Q?P/yb/JUIGbpfDvGJVnA3w9JqIghHkbdo0xUXhtOJRTwFzFoq/Y5IZwZk8iO4?=
 =?us-ascii?Q?kM3ggGI2kuMm/TnHRiI/JF1VQO4cKEsQ/ckU6xfIQZ58m92YnCoWXewVLQUM?=
 =?us-ascii?Q?q7iMAB2Mh/5zdz8LPhGZhDi1P5HA62Z0dJkbrAP12uU+pdlhUHbHTJwnYdlz?=
 =?us-ascii?Q?lXUaCh3rLZAlggQYZib4AT8sAVSDqRlKfPxsO7Q4qswA6eIVyAroV22soYH3?=
 =?us-ascii?Q?xoxup3GlayRUwSxVorlpSs/jiWfG52clMUgJPab9wEgjGaL3VYw/AdNe2A75?=
 =?us-ascii?Q?NMdmMBpLYOkKB+J2TZuZmMB5ffuEfu3rs+q6sXDE3wwgJAGakrFDsPuBW8vq?=
 =?us-ascii?Q?rwKgKeLwO4ATge6lHao/se8Aei3ALO4wd79CUbhMNzbNdZTwnw+CNWGiNM6a?=
 =?us-ascii?Q?lQLw1823hd4zZVWYYEZtEmrlBsHOLDnClpcjWUdRgFoG8AuBZlAlS3D4cxRj?=
 =?us-ascii?Q?sqmyky+Noq7X/JdfZijzXhh6bpDlydjALcPO6nJuzQsqEekAkSJ+ABS6v0jj?=
 =?us-ascii?Q?GYqsd/3CzzCmJ+QDwHhNz0n37BwiOOCfyDcJseA9L3+MJYzcSrTHrZAIcZKj?=
 =?us-ascii?Q?bYKRrFFRlCxmHNC2ZVRZgcMMAsfFP2enbjZIG1DcTVXlecQacJAOe6KT2Pds?=
 =?us-ascii?Q?bjoSIDaBZ2J4Bg9rkE6FwX2CwSwrp0XNxP+UaLpphplt6+xqpAJyxJaDBZU7?=
 =?us-ascii?Q?u4DEx7YCrVpNc9HmOzy5/LHIP+lvxzcGQdHk8ysgotECnVzwMOl89lehLAns?=
 =?us-ascii?Q?6eYIjoPa0CISvhZO2v0GbMddafHr0YMscJDkrs/pWO3c/osr9uHaxtlxg0a7?=
 =?us-ascii?Q?JzbE/HRsfauTN0fkODKGw1jrtlmz/jxlV9Ew4P+Xik+BHSKNq9ixmkIoBrxI?=
 =?us-ascii?Q?Q/smHhascqGYdx/YVhc+50qh80sb+WNDTyRWyLq/VbeqpeGQivOt1dM9LVxc?=
 =?us-ascii?Q?i2fKMJFr07tf3gseGVksivKhgwxXhKz9/FrR2HTlKo9Wkb9CCT0y+HWEVTw5?=
 =?us-ascii?Q?AVGjLiquBOJrRwXH0xW/0AcMPmrlCgICRsH03j5Ck9/kTEtEqY4vIBBChakE?=
 =?us-ascii?Q?5qpAsvRVUOo4F0sMT6EbRrnRtKV581qrkvRBKu0f2rigcjoi9iSPqJfs4PGi?=
 =?us-ascii?Q?q6GuwWzZXfV3PDHkY81ZPJWmmkqWFIXI9Rs0h2tDtUGKEJtLu2ahWzclOc6O?=
 =?us-ascii?Q?N0UeFHVEwlTqMfdzXYxjBJzgwJFUELQElVxGRXXp+Ibt1hLvmcyUo42ZMeW9?=
 =?us-ascii?Q?Xlsyy9BiuIl5mXCD7fCaYy1Uf9V+1SyeBR0edP7kKpFDy1ymMUHNH3eWWt8B?=
 =?us-ascii?Q?+ntZH5RvKpn5YGenagZBA/TyOYTLde5l2nOk7kNF4m4rbK9W/cOgGXVr61OQ?=
 =?us-ascii?Q?MeXH31IypXlX9ivjuc8esrM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88835eaa-113c-4a2d-54c2-08d9cd43218e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 16:24:06.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeJqJTzaxEXAHWARgYobzPINOaXO+yzj83a0iP8gv7H+WwgmlRsv/iiJUDh+aHRFsIcbXo4yahJKK5LtJP4dvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-01 17:52:45, Abel Vesa wrote:
> Now that the imx generic interconnect doesn't use the
> imx_icc_node_adj_desc, we remove it from all the i.MX8M
> platform drivers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/interconnect/imx/imx.h    | 19 ++++-------------
>  drivers/interconnect/imx/imx8mm.c | 32 +++++++++-------------------
>  drivers/interconnect/imx/imx8mn.c | 28 +++++++------------------
>  drivers/interconnect/imx/imx8mq.c | 35 ++++++++++---------------------
>  4 files changed, 33 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
> index 75da51076c68..5c9f5138f6aa 100644
> --- a/drivers/interconnect/imx/imx.h
> +++ b/drivers/interconnect/imx/imx.h
> @@ -14,15 +14,6 @@
>  
>  #define IMX_ICC_MAX_LINKS	4
>  
> -/*
> - * struct imx_icc_node_adj - Describe a dynamic adjustable node
> - */
> -struct imx_icc_node_adj_desc {
> -	unsigned int bw_mul, bw_div;
> -	const char *phandle_name;
> -	bool main_noc;
> -};
> -
>  /*
>   * struct imx_icc_node - Describe an interconnect node
>   * @name: name of the node
> @@ -35,23 +26,21 @@ struct imx_icc_node_desc {
>  	u16 id;
>  	u16 links[IMX_ICC_MAX_LINKS];
>  	u16 num_links;
> -	const struct imx_icc_node_adj_desc *adj;
>  };
>  
> -#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
> +#define DEFINE_BUS_INTERCONNECT(_name, _id, ...)			\
>  	{								\
>  		.id = _id,						\
>  		.name = _name,						\
> -		.adj = _adj,						\
>  		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
>  		.links = { __VA_ARGS__ },				\
>  	}
>  
>  #define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
> -	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
> +	DEFINE_BUS_INTERCONNECT(_name, _id, _dest_id)
>  
> -#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
> -	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
> +#define DEFINE_BUS_SLAVE(_name, _id)					\
> +	DEFINE_BUS_INTERCONNECT(_name, _id)
>  
>  int imx_icc_register(struct platform_device *pdev,
>  		     struct imx_icc_node_desc *nodes,
> diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
> index 1083490bb391..0c16110bef9d 100644
> --- a/drivers/interconnect/imx/imx8mm.c
> +++ b/drivers/interconnect/imx/imx8mm.c
> @@ -14,18 +14,6 @@
>  
>  #include "imx.h"
>  
> -static const struct imx_icc_node_adj_desc imx8mm_dram_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 16,
> -	.phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 16,
> -	.main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -33,43 +21,43 @@ static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,
> +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC,
>  			IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),
>  
> -	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),
> -	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),
> +	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM),
> +	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM),
>  	DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),
>  
>  	/* VPUMIX */
>  	DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),
>  	DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),
>  	DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),
> -	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, IMX8MM_ICN_NOC),
>  
>  	/* GPUMIX */
>  	DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),
>  	DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),
> -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, IMX8MM_ICN_NOC),
>  
>  	/* DISPLAYMIX */
>  	DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),
>  	DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),
> -	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, IMX8MM_ICN_NOC),
>  
>  	/* HSIO */
>  	DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),
>  	DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),
>  	DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),
> -	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, IMX8MM_ICN_NOC),
>  
>  	/* Audio */
>  	DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),
>  	DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),
> -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, IMX8MM_ICN_MAIN),
>  
>  	/* Ethernet */
>  	DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),
> -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, IMX8MM_ICN_MAIN),
>  
>  	/* Other */
>  	DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),
> @@ -77,7 +65,7 @@ static struct imx_icc_node_desc nodes[] = {
>  	DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),
>  	DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),
>  	DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),
> -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,
> +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN,
>  			IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),
>  };
>  
> diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
> index ad97e55fd4e5..8d16bd5cf006 100644
> --- a/drivers/interconnect/imx/imx8mn.c
> +++ b/drivers/interconnect/imx/imx8mn.c
> @@ -11,18 +11,6 @@
>  
>  #include "imx.h"
>  
> -static const struct imx_icc_node_adj_desc imx8mn_dram_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 4,
> -	.phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 4,
> -	.main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -30,23 +18,23 @@ static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC, &imx8mn_noc_adj,
> +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC,
>  			IMX8MN_ICS_DRAM, IMX8MN_ICN_MAIN),
>  
> -	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM, &imx8mn_dram_adj),
> -	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM, NULL),
> +	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM),
> +	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM),
>  	DEFINE_BUS_MASTER("A53", IMX8MN_ICM_A53, IMX8MN_ICN_NOC),
>  
>  	/* GPUMIX */
>  	DEFINE_BUS_MASTER("GPU", IMX8MN_ICM_GPU, IMX8MN_ICN_GPU),
> -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, NULL, IMX8MN_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, IMX8MN_ICN_NOC),
>  
>  	/* DISPLAYMIX */
>  	DEFINE_BUS_MASTER("CSI1", IMX8MN_ICM_CSI1, IMX8MN_ICN_MIPI),
>  	DEFINE_BUS_MASTER("CSI2", IMX8MN_ICM_CSI2, IMX8MN_ICN_MIPI),
>  	DEFINE_BUS_MASTER("ISI", IMX8MN_ICM_ISI, IMX8MN_ICN_MIPI),
>  	DEFINE_BUS_MASTER("LCDIF", IMX8MN_ICM_LCDIF, IMX8MN_ICN_MIPI),
> -	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, NULL, IMX8MN_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, IMX8MN_ICN_NOC),
>  
>  	/* USB goes straight to NOC */
>  	DEFINE_BUS_MASTER("USB", IMX8MN_ICM_USB, IMX8MN_ICN_NOC),
> @@ -54,11 +42,11 @@ static struct imx_icc_node_desc nodes[] = {
>  	/* Audio */
>  	DEFINE_BUS_MASTER("SDMA2", IMX8MN_ICM_SDMA2, IMX8MN_ICN_AUDIO),
>  	DEFINE_BUS_MASTER("SDMA3", IMX8MN_ICM_SDMA3, IMX8MN_ICN_AUDIO),
> -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, NULL, IMX8MN_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, IMX8MN_ICN_MAIN),
>  
>  	/* Ethernet */
>  	DEFINE_BUS_MASTER("ENET", IMX8MN_ICM_ENET, IMX8MN_ICN_ENET),
> -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, NULL, IMX8MN_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, IMX8MN_ICN_MAIN),
>  
>  	/* Other */
>  	DEFINE_BUS_MASTER("SDMA1", IMX8MN_ICM_SDMA1, IMX8MN_ICN_MAIN),
> @@ -66,7 +54,7 @@ static struct imx_icc_node_desc nodes[] = {
>  	DEFINE_BUS_MASTER("USDHC1", IMX8MN_ICM_USDHC1, IMX8MN_ICN_MAIN),
>  	DEFINE_BUS_MASTER("USDHC2", IMX8MN_ICM_USDHC2, IMX8MN_ICN_MAIN),
>  	DEFINE_BUS_MASTER("USDHC3", IMX8MN_ICM_USDHC3, IMX8MN_ICN_MAIN),
> -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN, NULL,
> +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN

Please ignore this series. This patch will break the build due to the
period missing at the end of the line. I'll resend V2 right away.

>  			IMX8MN_ICN_NOC, IMX8MN_ICS_OCRAM),
>  };
>  
> diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
> index d7768d3c6d8a..b8c36d668946 100644
> --- a/drivers/interconnect/imx/imx8mq.c
> +++ b/drivers/interconnect/imx/imx8mq.c
> @@ -12,18 +12,6 @@
>  
>  #include "imx.h"
>  
> -static const struct imx_icc_node_adj_desc imx8mq_dram_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 4,
> -	.phandle_name = "fsl,ddrc",
> -};
> -
> -static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
> -	.bw_mul = 1,
> -	.bw_div = 4,
> -	.main_noc = true,
> -};
> -
>  /*
>   * Describe bus masters, slaves and connections between them
>   *
> @@ -31,43 +19,42 @@ static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
>   * PL301 nics which are skipped/merged into PL301_MAIN
>   */
>  static struct imx_icc_node_desc nodes[] = {
> -	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, &imx8mq_noc_adj,
> -			IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
>  
> -	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM, &imx8mq_dram_adj),
> -	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM, NULL),
> +	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM),
> +	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM),
>  	DEFINE_BUS_MASTER("A53", IMX8MQ_ICM_A53, IMX8MQ_ICN_NOC),
>  
>  	/* VPUMIX */
>  	DEFINE_BUS_MASTER("VPU", IMX8MQ_ICM_VPU, IMX8MQ_ICN_VIDEO),
> -	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, NULL, IMX8MQ_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, IMX8MQ_ICN_NOC),
>  
>  	/* GPUMIX */
>  	DEFINE_BUS_MASTER("GPU", IMX8MQ_ICM_GPU, IMX8MQ_ICN_GPU),
> -	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, NULL, IMX8MQ_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, IMX8MQ_ICN_NOC),
>  
>  	/* DISPMIX (only for DCSS) */
>  	DEFINE_BUS_MASTER("DC", IMX8MQ_ICM_DCSS, IMX8MQ_ICN_DCSS),
> -	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, NULL, IMX8MQ_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, IMX8MQ_ICN_NOC),
>  
>  	/* USBMIX */
>  	DEFINE_BUS_MASTER("USB1", IMX8MQ_ICM_USB1, IMX8MQ_ICN_USB),
>  	DEFINE_BUS_MASTER("USB2", IMX8MQ_ICM_USB2, IMX8MQ_ICN_USB),
> -	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, NULL, IMX8MQ_ICN_NOC),
> +	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, IMX8MQ_ICN_NOC),
>  
>  	/* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
>  	DEFINE_BUS_MASTER("CSI1", IMX8MQ_ICM_CSI1, IMX8MQ_ICN_DISPLAY),
>  	DEFINE_BUS_MASTER("CSI2", IMX8MQ_ICM_CSI2, IMX8MQ_ICN_DISPLAY),
>  	DEFINE_BUS_MASTER("LCDIF", IMX8MQ_ICM_LCDIF, IMX8MQ_ICN_DISPLAY),
> -	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, NULL, IMX8MQ_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, IMX8MQ_ICN_MAIN),
>  
>  	/* AUDIO */
>  	DEFINE_BUS_MASTER("SDMA2", IMX8MQ_ICM_SDMA2, IMX8MQ_ICN_AUDIO),
> -	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, NULL, IMX8MQ_ICN_DISPLAY),
> +	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, IMX8MQ_ICN_DISPLAY),
>  
>  	/* ENET */
>  	DEFINE_BUS_MASTER("ENET", IMX8MQ_ICM_ENET, IMX8MQ_ICN_ENET),
> -	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, NULL, IMX8MQ_ICN_MAIN),
> +	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
>  
>  	/* OTHER */
>  	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
> @@ -76,7 +63,7 @@ static struct imx_icc_node_desc nodes[] = {
>  	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
>  	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
>  	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
> -	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN, NULL,
> +	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
>  			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
>  };
>  
> -- 
> 2.31.1
>
