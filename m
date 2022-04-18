Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC3504F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiDRL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiDRL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:57:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F176301;
        Mon, 18 Apr 2022 04:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9zmhEGTezNdhXPjYVwEhHZJ5cqflOF1WDOGGmArJT4rFJZctwwTKzd1II4BifM5hybpSa7oJ5SoBuX1VJOkgw2Op5wY8kA+kUFD+ovU4ndgCkI4bgOHdx6simPzTKE4Ps9+UgDd91c0gj9eLAyPMDSRAwdThEIpeCc1Knwz3B08f8yLS5kcPDPG9+PfX7Aomm7u6aY6yr3spX46hP198bIa1Ey6fvwTAGQ1/HsPjul2HIpJYkZ8AiuWf7tFFDR5ksI0QBHFrKBa2vtp0RWIGMJTcGeqw2Bzy8WE6R1mAwVWtu2JdtK2EXXiL6G3trAgy9tmOJmyJ+nrYJervxwP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaQ14GZone6JpFMyVvqJCb9nZcMp/GXcGnFd6Zda4hA=;
 b=mdj/2V3GX6sN8cC0FmPqwYjQW0s7Ydn5k8VSk9V6TsaN+88HTxJwRzQVy/I/uKBbEpTZiDgTIJJC/7bIEjAnzc/WZbsnvgVW7qru4zYC1kUPJQBry0oyv3Li2WFLQrDeJiM9PlJlJSLJ7dlDfC7CDgZ0oWTAGh6DaiWDjoBnltVNNT2z0DO/Ez5hSsqoeYp4cisA33oTnGwGSP5Erf8/jSETMv1VnrmoZThcf2wB543WBnZknO9YarDo6K5hbBwjGr8CIQmQ33hLQI3eMk2ATTJfa8Ky27QJWVXMWm2u2oqKYm/9BWJGRKzrqiSLmkTpaVLquKuxmzt/WbEBsYo8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaQ14GZone6JpFMyVvqJCb9nZcMp/GXcGnFd6Zda4hA=;
 b=BBWr4wxIgJ1vuwjYKCXfCtkRqljxiYZ3jezBS1Bkw3CTvDQ8ogQR+pc/ISW0+a0crkr8bqMC4xZgxDBZ1fSgo988lIXmz+SRtB1dfH1/ec5IvCjeuJ+viu0dmG+7dmSHKej0XvA3YgA8Rzo3xCESwd56s8byQSCnbp7QfCjwVLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 11:54:36 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 11:54:36 +0000
Date:   Mon, 18 Apr 2022 14:54:34 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: scu: Fix pm_runtime_get_sync() error checking
Message-ID: <Yl1Rege1GhPwwU6n@abelvesa>
References: <20220412065719.17735-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412065719.17735-1-linmq006@gmail.com>
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac1aa0aa-f560-40c9-76e0-08da2132360a
X-MS-TrafficTypeDiagnostic: DU0PR04MB9273:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9273D8C3CC790E3407D88E39F6F39@DU0PR04MB9273.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/xCcXQNUC1cJo1y9CnfLOL3Z0lwG8p0EazTD63MkGw/pgLn8s3ihCCOqKPQYAEJPjJAzykvx8pR5pO78VGPzUxM8zdzo4DZDsp9FaURseWDMzanJ0ehDNNvMj+fSCeKcqK4Jr4hy6YRbwO8xkuhNAmN4zflenLDUAEextqgBCw3I45GemtiTrfTfWjwfJo3kMWE0ZSqWd9jrUFCxrXmYpEQcIb1SN2QrsUA1k4jWhS9x2gG8YNh2QGXgN0g5qgOpZ/A/8kwrVXIcJpeEwsvZULdgg7Xr9/sjWvZ9IZKynzDk2Cwobx7wH1YcT/+3RvDYlzOrIW2awQcu/OAXRsomQK2bmfo0IrLpUxVJE3girO1tf6eCtwdxFkKR5NqDqiip6TH6STC7Vkk8AqU9Hwviwcdstabym4Tcsj5jPIlq0Og7efwsz5yLBmjaQ/Rzx7eMMlj2TkYdP3xfncu3mnoMLEbOyWgcXifqu4szS45y9WTYu9o4PiD3k09zm3g1rGfk/9va/YLdcHpDZ6+F/d+V+Gfpz7ZDvwxxHYQLK3vEbd6h2rwHchL4FftEC27I61qut3VpirnBPJEDbLD2KvMcD/nYHesd/KRhFrpsovTnwIlrwPu/bQ512x8rkXuyurgXGqvKWrfiUqEhVFEm8BMfvtyfdOEdj/EWEPORW5ujIcdy2xafsLDNeR41d9uAp0wPPFcc1B51MnPReZqzGo6FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(52116002)(66946007)(66476007)(54906003)(66556008)(4326008)(8676002)(6916009)(6512007)(8936002)(4744005)(6506007)(9686003)(2906002)(33716001)(86362001)(53546011)(38350700002)(316002)(38100700002)(83380400001)(26005)(5660300002)(7416002)(508600001)(186003)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VX5H0kd9fLAti0HjGNwOr23JctCz/8/MUT1N0R0db6c7WT6jzOBCFL0Xfiqx?=
 =?us-ascii?Q?UHtz0tYWYIcAM1uBt8ZS3DKiADzt0mPbcJa4m4Iy2LeNFMCYxw3ncfAWfPX8?=
 =?us-ascii?Q?tKZCeNsWh6Rsu5a5qQ6QrXQibtB+Zy2YjmoKVHltcZNV5gxAqFFA/bYT1xfK?=
 =?us-ascii?Q?tnR/EtmKl16P4LxKDwC7oscaDmf+0QvyVkO3aqVbUsM0o8gM2Ri9boRREsEu?=
 =?us-ascii?Q?1A5sBGy7ndJQOUWWvmnZCDAtNNuqRuQ60ZvNVOQ3CdfrgzrzMdhYjwRykZpe?=
 =?us-ascii?Q?R6V1HTe9yuHSYx5X0ZMc24bXoFDrjvUNT2+Vt2JQckFprndJGYb38/n8TxNh?=
 =?us-ascii?Q?4bqSN0xDDrwhnvkcSI+VRSevoXxRLW6dnkEFrqqdaXNY+zRl6qM9uWq2dzwq?=
 =?us-ascii?Q?P0LnZEWJFGI06y6VGigE6nDwdJsAoV2wFiszZvimUCtX/iyzzzhTF7rjHXxq?=
 =?us-ascii?Q?BxmS/A4qCx1/yRSAGFDvKADigdHmWgWJHSADqkRTi9cxsV85WZJ6aWEkqDhW?=
 =?us-ascii?Q?S65U3MuGRS8njG3VtfTdqhnQsrGjruLjmrPkOs0//I2SjVOTSEjIU3XK6TRg?=
 =?us-ascii?Q?e5D+/bAc4ow4nsqYdnQanLVbVaZyw5vlCTnQw+qV7D+PqupewQOSAG+QU50W?=
 =?us-ascii?Q?EC4sGjRldrifHKLy0/45JALMzore1tkdq5jVW+EgLJHk2bZXF1Pe323KiCmH?=
 =?us-ascii?Q?8+KheyfsfsEFFtZVBs96lecAuSXyVnbtf4LFQmIJmk8CUV/IeefC9XZk2sWc?=
 =?us-ascii?Q?lc7iK+kb9wBTv8u6B7Ws0AR/Jl38tp+nO8iBQHRS9DvkR7Hb32svnymiegEV?=
 =?us-ascii?Q?YWdiYgCxL9Qwo5m1ObYMWgVVQx+i1tITeJE3yG6sRDmY0gMFtEM4RpJmqipc?=
 =?us-ascii?Q?ez0kuZJcUoysMhtW68WouuDuQpCkJ3GrdvIQqOk6qO0XgRRa1FIfVT5fxoyu?=
 =?us-ascii?Q?3pIpb7jJYSEM2JTCQIBMwIZG/7dk8zFJIaI6IUFdtrCuVIplAqZBiZF7mZKM?=
 =?us-ascii?Q?jViGHHGr0AOaLZg02GTy0SnJicOsSnLzySGtjmfn1t3pAm4rajRT52nl7n65?=
 =?us-ascii?Q?oZJ9qc0Tl9eee6GdxoxfRF2OZ8cnLDD+KJARL6ahgdVMVCSWkJ+TCAWp9KR6?=
 =?us-ascii?Q?CoNbIJl7GSN70VfLKYASNMzjt4HCJEXPu+xWvxLoxieiino9onGBEGhSG3i7?=
 =?us-ascii?Q?l1AR63xXp5lh5RlatW3vZG75gv3dB9M7bgter6oX88IoWH1wcaONeOC0ETj3?=
 =?us-ascii?Q?gk3RQF+MogytFR/lfY5FtHZmBnZwan5+Sclrh6VP1rkfqigc+A3tCzxgTIE7?=
 =?us-ascii?Q?2BLOGC61ILNNF0r9yW3LkoXzg5LkFxAEs306iGmMJkIralQfZlwT5nE3Gbgw?=
 =?us-ascii?Q?zc6XW3j8nf2Cl+eVe8uJAC4WpqYLmJKTbPvenATabS+zrUJT+GcMyz1ZmHWU?=
 =?us-ascii?Q?Mg5fPW+lm1GJsVKuXP1SrlgJu25mjlH4eaKuLlLrx9+zMDyApJ9O/ElUL54+?=
 =?us-ascii?Q?wHwRGK7l/JUWqSiFzuOBHP81MR5tECkMLmVYyl99T53hnjywqkuM7IMUHV3X?=
 =?us-ascii?Q?6uvFiabXFG+TQNz8rM+ftRJHrp0lvfi1P0zi7irn9NZso5jqiVWEd/OWhj+b?=
 =?us-ascii?Q?yevMvTbaggd+Gr/yqphH6AlyniJeCSuwgmIrsxHd4S7TrD6xrWb9+k61eEL0?=
 =?us-ascii?Q?U59soDVzKzQxpYgeldN2YVvrBeEvXztxcfalN9/FX61Izd8Y4fgU9NmOCjSF?=
 =?us-ascii?Q?QQJT+1o3yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1aa0aa-f560-40c9-76e0-08da2132360a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 11:54:36.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLoCrNXLCI1k0t7WUbrGvwuixcglM7OKJDMxGHrZWG794ozxK1gzLHVzLshwfeiMw+QgFUfC5Eh5pOjDjtuB0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-12 06:57:18, Miaoqian Lin wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.
>
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31dc3ea..18c6190eeffd 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -529,7 +529,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
>  		pm_runtime_enable(dev);
>
>  		ret = pm_runtime_get_sync(dev);
> -		if (ret) {
> +		if (ret < 0) {
>  			pm_genpd_remove_device(dev);
>  			pm_runtime_disable(dev);
>  			return ret;
> --
> 2.17.1
>
