Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D031B5119C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiD0M51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiD0M5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:57:25 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10071.outbound.protection.outlook.com [40.107.1.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3CBD97;
        Wed, 27 Apr 2022 05:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCn8HLWWTBXdBoUnwO+PELcg4OOOhNSH7Ly1AgUyhaNtOzz3uWlPsa30vASQtQGRFkuob/KiLilYClqB4OGqjvCZzefkcwosnNBAN9Cdml6MNqW85hrqg33JMSk9+K0zWN/qf4yOeCHRrUnesglXDiRy0JvchzqTQJSp6EpFWVADwlB2SOaUZAUslRA/hYK5cWYRiBmduWNGUm8kqCSMtVWAXRFhZ4omXrUJNpPubC6tLwEpwmJqWwoTzSFhozGbzgF4DIlG5RCS5Xt2NmmQ16w9RqvZtZDqu/Yl/LBNYKv7S81zSsdAsbPD/FTCT5VTCMfNR9FsFZDte8T70Hveag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBPMkyPdqIFAZA5AgZh9XO/wbIZb0VOhSB/qr1jxeR4=;
 b=RNX3PFE/P4oDX02YncA00tQVMM0Kg4Jo8iM0MEMN2gI54MfQCbfpeZ4GlbROmWGWdsXYmGsrGL5t6RU2gU3CGMTiinjgW9zuAsBW8+jJUy7rU3sK0nZ89YLZ/5b5T/OJBVI8ZJmhOqxDCsonJmdjfyVfmz7ghvWb2LA1og6FQq8k8zz2YfIKcR69EopdTlDxsk2CV6Hpozd4UTYVEV6mfuwJguyxJD6BPT/t+ZJsK6wAHwqVxZlkbugCncKtjvq3o9btOt+UOlTztMchnc08Mu9bqrCe6LOy6WXFoMmAYDB2Mt/TqUYlyAgSAcCKH6oW6QQLh8sNM36cxjW+kHbXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBPMkyPdqIFAZA5AgZh9XO/wbIZb0VOhSB/qr1jxeR4=;
 b=FNY8O8PFb4hq5w61rWUjznTlNQOHZnyIhWImJM739WsEnKQsc8oNo/YD17lYI4vp2MsB9Qh7nZfl3HPggVm6OMpUbIducrtoh0GBWF2wv5etG5GT07SPifkVLfm/DxPHxJKCAzLDTyhABpQjtq7WyK04UY3kx1RID7U/q7HcTms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM5PR0401MB2563.eurprd04.prod.outlook.com (2603:10a6:203:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 12:54:11 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::78d8:955a:7946:fd78%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 12:54:11 +0000
Date:   Wed, 27 Apr 2022 15:54:09 +0300
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
Subject: Re: [RESEND PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get
 to fix pm_runtime_get_sync() usage
Message-ID: <Ymk88RJ2v9cwJvU2@abelvesa>
References: <20220425011117.25093-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425011117.25093-1-linmq006@gmail.com>
X-ClientProxiedBy: VI1PR02CA0068.eurprd02.prod.outlook.com
 (2603:10a6:802:14::39) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4b7848b-84d5-4680-41f8-08da284d067f
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2563:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2563553C599A1A6FB915F27DF6FA9@AM5PR0401MB2563.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItZLjDfAOjqtlUmZkBWGn1xDQndqJ0uC9F01vTW9GJ0YJMT3J+OO8k/Uqmy55HMH4w24Fzo/f3R9E5bKlTf0uBNVsz40dwbUqK2tJ+FyDAF9/1BSDfGf6jwhDCfkJZ695VPcR+Nq6zToT622hvse361hG4pgvGFfJBIp3qpVtkyhG/PIK8qb2E9Y9qe/A8Z+Du+aiQkaZuiXeSoIOMtMg0b4zrECdhELuC7wDPb1Ei/4cHJnLmndoDma02SNlo3L1LwMQHUj1O4TTOatKFNv0r/TKfycbiWLxaoXUz3XMs75atRnSvqdM1aJfaFFoie5attZw9R0jQbIlRUGv+VMXg2XtsQYWGF31N+ughOBXYu36QPLdhWHsOeEozfm/0oXophkjS+siVo698TUcrgBxQu7n7XSI4WtdwMBcSGtIhywccazBAF+nmaePUPC1sLM0HSohulcXq6DruIPGcn3faLXy9l+MB4miLEbZhiA9Ml6a0/+1WycKzL0j4xfUnMciYKul6SlRPRwJQX8uUp+JUaC7Z69Kh9w5NlVmoiQ0BXaBwy3fc3RHiZAwVDUyRU5ptZY3QYx8zEtHcadVKRU3erZyzsAsUCKgEsBvEP2sTdT6nmdIU+653/1vIAUwLPF44tG0tdjH18iHDIwJSIMR31s1PkAbt81v/bSFLG34m86gPRrscyBM13e6vbjqs2qwuOWY4pFYO2pcTdLKRHsj/RxShK5j3jQlHLHxWT5eOnTnQMfVteEaPUhvWUDiMbjpYVv1hLw/4WpU7endWFFt71QnRNpJCsxrPzfc3fSWOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(966005)(6486002)(508600001)(83380400001)(86362001)(6512007)(9686003)(26005)(53546011)(6506007)(38350700002)(38100700002)(186003)(316002)(44832011)(2906002)(66946007)(66556008)(33716001)(5660300002)(7416002)(8936002)(54906003)(6916009)(66476007)(4326008)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLfayIgIwR2S1kCGVZZanFV5zghWzfsJUVqudpNNsECO4xiE3sav7coMAHGS?=
 =?us-ascii?Q?6y8DVra4yv9i5BQEysp+oSjsXxZrpq4sPhXla5LT1MMwiIZsztQr5pirX/5T?=
 =?us-ascii?Q?m8Y6p54K5xy6dutk4kpg2AP5sIe6B2uWv94rHqMtUxrLWs+KNFTlosu7rep1?=
 =?us-ascii?Q?UGINHr3LUdY/yKKPnac7UJbvpEGdoZeSKPZix1R9I+K1iJk9atrm7sJK5Pgd?=
 =?us-ascii?Q?73I0We5Jtv9W3Jg54I41fh2Hqbx7LSw9Afk0OXzltA3Gjwrj39KexlO5aGXd?=
 =?us-ascii?Q?k4v9J+pvxrXQuvj5/2Wder7jwdR+jUK2KxWkIAogkmJnywKc11/cDCspE0tP?=
 =?us-ascii?Q?kgeKio/YCFV2Bo4FJJFw45gwvYY7PIbeX9RJpBzkcuqgTIOUzxVsudrhtZFH?=
 =?us-ascii?Q?pMZ5etVPtyh7o4pcxZLWnhu4LIl2EDn56/U8FpuOT7o4JAj2K51/Aqfl7xfl?=
 =?us-ascii?Q?kfJrdZYyv3HC6ooQb6tdf3MWDAEXz03WAZq1tj2StJNFxFYS+dVr3lXL9FvA?=
 =?us-ascii?Q?phAjF2dHO24IK52qrhj+ffDq1AEPUD/Q/N3YTIhOmsrHrFYvX+BOs6gxjWmN?=
 =?us-ascii?Q?qqx7QM5RQM1j9N5ztFc0gLffYCUAmcxsHFkh3d/4al1PV4JgVpOr9Y7aC6WX?=
 =?us-ascii?Q?L67R0ZnfTZhs5Ni0x72yNfqhyR1Ufv93ouNC5zQsgq1IfUp9HOLJIIjuNSB1?=
 =?us-ascii?Q?mhqlCJL+z5lzLInnyBBCKM18V60ytP9NVHntbfA0PfyU4DGpJqj20c0PTDgy?=
 =?us-ascii?Q?2/RAavMn74vrVIFoU1JzHchqtCM7yrV5/s691m63W4Swxy3OAqnlHtOcihSB?=
 =?us-ascii?Q?UOTsqXmdB2EK5+/Gs0DGVX434e6NBo/H/nyQoYi3Sbju9mb/dEnFKn8MdEYI?=
 =?us-ascii?Q?cMMLgTsWVgMvGC28QczLsv+Ojvem68VLI+0p/XvCSM/ZCNdgqCDWutlbfkRx?=
 =?us-ascii?Q?LSW319H/8ZkQRdY7hcAEy46uc+YPyJTSv8qZILJIQSojOLJ7cNlTLx30+jeB?=
 =?us-ascii?Q?5m0x9bRz403rpHf3W9DNB7IiX9oGU3HW6X0XZnOyt4xOim8JOkMSvIGggpnN?=
 =?us-ascii?Q?dNw1qpblCEeapISusVV5k2IwD5CkmzA3EHUQmnOlpvVMQHJwMMZLRQIK1fhf?=
 =?us-ascii?Q?juQyPiYvseHrqqroZvOF4DUk4f5T9rYi/EtidkJSv3Y4RWrDk83X9IWNR9d2?=
 =?us-ascii?Q?1lH9jHQSEnqs8P+LT3O44xKHTb+0aW3DmWy1Hwt4yA3vj/GQ6hr+ADPuHwOx?=
 =?us-ascii?Q?Q/JSZ9ElNyrQUnTYu1M3U3PkI+qku+7XOVhXcPr/+XwzBmVZZbMBQhWtSpPp?=
 =?us-ascii?Q?jflKgH7o0BvXhDl2AMJFiiCqMIVQThbJvIIwiPbEeWEZcOKMLeR4IkYops72?=
 =?us-ascii?Q?lvrar8vh+vHZ7XbIxjOq8R92ACrp38tFYQ460qasbDPtbYAsATL1X7eKFq7b?=
 =?us-ascii?Q?7CAFuQs+o6QX1ohe3xv7K6vdAjo1TxTlYqNFJ6g/ah8TI3t+tDqRRJJOFWMj?=
 =?us-ascii?Q?N6Vba6uxea57CI6xCvBaiRRN/mTugeFGsMHZ9gaov84te3LJ2R/p6+vn4vv9?=
 =?us-ascii?Q?hADllgClP+xBe7MNiN0HDWI/w0POvtWe7+NzjEFqrvokux30lG/QaankAmRu?=
 =?us-ascii?Q?7Vzigiw2uYfnfbYGwnPvqS4c8Kk7fXgNP2xWRon/Kra2YuL8Kg++o2un5Ly/?=
 =?us-ascii?Q?MSU2BmFosxrXaRCMOYohlwclesP7zolKlIAWmvr1+FokZGJdy4s9LfzMfpB9?=
 =?us-ascii?Q?j3M2nh363g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b7848b-84d5-4680-41f8-08da284d067f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 12:54:11.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ0GC7y2xxeJaAiE8HqFfrCccLFLLWtz1zsR1C49X7ztk7FiTTX6IwHfYaLTh9o62NdBX56v+X+wJnHlm/931g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-25 09:11:17, Miaoqian Lin wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1.
>
> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
> fails, so use pm_runtime_resume_and_get() instead. this function
> will handle this.
>
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

I'm fine with this.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> changes in v2:
> - change pm_runtime_get_sync to pm_runtime_resume_and_get
> - current check works fine for pm_runtime_resume_and_get() so stay the
> same.
> Link: https://lore.kernel.org/all/20220412065719.17735-1-linmq006@gmail.com/
> ---
>  drivers/clk/imx/clk-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31dc3ea..2044e62980e3 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -528,7 +528,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
>  		pm_runtime_use_autosuspend(&pdev->dev);
>  		pm_runtime_enable(dev);
>
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  		if (ret) {
>  			pm_genpd_remove_device(dev);
>  			pm_runtime_disable(dev);
> --
> 2.17.1
>
