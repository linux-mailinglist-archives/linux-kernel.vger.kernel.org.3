Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEE4923B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiARKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:23:49 -0500
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:38592
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbiARKXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:23:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCY/A1GcZ4+wp1Ly1uhwBTaWqlgbD/kECsxELKb9B0CkjqftSuHmC7k5VhSCY0EjcrbM0D5NX2qqIIJJ1+KXL1daWQVX2mGWled45f50pIIUVZvMmbAhLUD832IawWKnX9QQA/w3llLb5y1+MRHXX4iV9O85+0fA18LHqbZ/tNj1x5GslE1DmWcPxLte7jjwC5oLje3cjMG9FdBQ5ySMch8H1gU3pM1y4iPFVb8ofHaISguDAc83OapNw17hRYVOtttqjYnO5zrlcPYVanlFWDg8ufN7GPOZV9uUlYWVoM1uolmcE3nyOdwDJQBfxpozhMiqeQ4NnXD9GAxCXpYK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb9qK8cBGaYx+CET8OX2POF/rg7nWoB5vWegZYDJoGg=;
 b=NpGZV9MYcfAOMAgTkl4zIMRNdexuGZWoZEVb7CVmsrfLgNy3XDFh0uWJJRvHCm1yWtAJixkcp5Ls8/JvKuJ828YnJvxl0QLSgkadMamTwbzY7a4iwWWtm+8YQULETLsO7QFBh5rZ1xeeCCQV1FSGFuIFBU/zKW25Ku1A2SY8hpRNlsmlCN2882snrjaV/3t9d7YTyik+PGF/mjPur9rP7SP6BAZELEPgs+W0FlyjtqRNIdud1s2OI+fk+qzawctxIO9Soy2yy8pFSCdRRaP13yu+zgXnlOJW6mNO6Zi6V2B1OmQnD7WGUVqMF1XJvCD3nLzJZRGah6tX2llJKJQVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb9qK8cBGaYx+CET8OX2POF/rg7nWoB5vWegZYDJoGg=;
 b=gvwhM7wtZ0qmhgFJMwaJiFXHL/4ACLOX2Z78iqmb7WARSkCSZAXkdI5iDSk7VqPS247nHQ0itYG4N90eLueLRihfoaVfbkiS4RhthiOByYoyLXSXcQix7ttp1uFCqT+AFN8r6ks9sVM4/J3V/kBaHtE3ogz1bpeh7aRBM0yHkKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 10:23:45 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:23:45 +0000
Date:   Tue, 18 Jan 2022 12:23:43 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] clk: imx: Add imx8dxl clk driver
Message-ID: <YeaVL33SMFHc8pZ3@abelvesa>
References: <1636567000-24145-1-git-send-email-abel.vesa@nxp.com>
 <20211216185024.7DE53C36AE2@smtp.kernel.org>
 <YeaT6pGCo2wUGEFf@abelvesa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeaT6pGCo2wUGEFf@abelvesa>
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c221b02-cfcb-4914-53ca-08d9da6c9be7
X-MS-TrafficTypeDiagnostic: AS8PR04MB8657:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8657CF9DDE6ACC37F019EF5AF6589@AS8PR04MB8657.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76vNF910/n+BrZc7pomJj999RTtLd8tvM6u8xVcvwO4fVyjyYvAAp5PUyY9i0QHY9RAmuPWgYk1+FXtWaqvXFnUzHys2mA0uX1kLpU+vIn6FSn3QRvH8jWhUDasb6WPSt2zSpCyIu1m3sncIVtrZr97r99mNzUQCcRGhea87g8VRb6m9CQ2raaGVDoA2T+EJDPcoYRwsLa3epxHwsdbz6Qk1MuFwLmxOh8pgTqEx8JZHLwl/b51u5Rsx6ASltM+IUdjtLtQsr8qCHPBA9XpLksDzKb1URDXd2A89Wry1ZPt9mAMF9QrL5GnbV5gkbW/yfPg50Iv1uj8x4gzEwaX5c4R6OJbjRzr17kHjEEWMh2+zZoXmDFNbhKiECz9bf/8LXrlZ1c9kgrgWFL1wuH0jQDC7MbYBswY9MFD7w1X8IrN/W23hjaNX5ygvHXpDeARttf+ffedbyu0u+X28VcwmYxsDanaoVLdyCTNmi1E4gPxJl2+CE7ew9VpRpQCcEV6Dk937CG9t0uEvbPmtwhLjJQftr0g5rAjWOmFDhMVov+4AYXEHrmn+RBXHi4WugsERHdZ4sBXwvhp1QuseMt3VYlqqcY2P/8YVw9UD/KUs5umZVtijDbpYdh8CYyEX0mdrrkSnk2qn8WT461iEOKsioZ6XO4WUJMh5n59N9haXS6BZpFewr63GNoO1IujswX/d5xDO0BjNYqICOvETrm0173exMJ8u8AE7yFMBfobHAmcIOpWErwjTW3I0bBiObaj6CgPyOEZzy5CNavns2P7NeLzG32gVAr3MozwuMyAcFbLx0jlLdXQYjjzTGkr0zFIF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(4326008)(54906003)(6512007)(9686003)(38350700002)(4001150100001)(2906002)(186003)(86362001)(33716001)(5660300002)(38100700002)(66556008)(8936002)(44832011)(26005)(66476007)(8676002)(66946007)(53546011)(508600001)(966005)(52116002)(6486002)(6916009)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRJUethp/+7CDkT9owpV2Dw9wWBsPIBBfCvVFMRAYUbdvgXgrkt6DtM7RWNp?=
 =?us-ascii?Q?XLzPmmahagFOvjUN7O3KZdgmQsuehBfuoApJGi2FNFoRgANKenGoRSmkWhmw?=
 =?us-ascii?Q?byby29mL3WMC80pAoSd9bZfMZOuEPPZ3O0SqPGfpQBR7aseMCaPH3NYqMu91?=
 =?us-ascii?Q?DFTRyDM21xPOiIeNlomFf+QHp7XarVQ8702iNHx+oDGULrrDeXhWf6Hj7Bhu?=
 =?us-ascii?Q?pBMnW39vIqqpjSTdGZtamuBvkTB50aAbOtnR9PhAIGDvgHfzo36jVOFmbn5g?=
 =?us-ascii?Q?zTBstiWM0AxnshA3K31NdqaYOU6Bgp1sMigBAvtMKUvC28uPgYAdfQKNkmDp?=
 =?us-ascii?Q?QG1IHNiKaagoN7be3Rp26yiqZlNioJBgMIct7OLEy4sCLA0uuSXkEpIqBGHx?=
 =?us-ascii?Q?LgeV1djQOQ8T1VEUgioVMLiBzpZ0DE8z1RpHT78PS7c8nkwg8iKUha2xundF?=
 =?us-ascii?Q?gQ00Lt5rQn2EpzO3Yp+bkjrhOhS94Fzmco3UOfNdmBnqrWjY9x3UFTZaDstq?=
 =?us-ascii?Q?rHJ3iJI75NyB4wmvkm4WdWQuit/D3epUeH9sOxH+Q3wWmJjOdU16HrV+A+V3?=
 =?us-ascii?Q?myD8nrexrlLjBxCJpuvk5EUL5In2kaXqgBSencT2axLsHNdy6TLyLAc+lJ66?=
 =?us-ascii?Q?TnlQBHJRwhFGoSLfh2K89tQSTwZtRkYKEAUbi0VyJf5ztpTB+RcHeLU60Nhc?=
 =?us-ascii?Q?FlLmC/WPPZYXl4Fn9BVmKrRDpGoLWvyq3kjzbqWGquRwNyGti3St9JqziULN?=
 =?us-ascii?Q?eXFypZVcfG11cJeSGHjrW/JwfaXI0HtdpxfJLwjJKNOV9KNvpJZ2CEPZ3+J6?=
 =?us-ascii?Q?rAP8Uwxn6ByqjO0ACbNPqR/v29fZBT9/x5edWVrUdKE9hpEziGFFi03DzQNb?=
 =?us-ascii?Q?mE2R+Un4dWgE8aZczYj0mkQDiqLf23b9+ZAr3wunK9gEntrJ3Hpdxzifi5ij?=
 =?us-ascii?Q?LGmyyguSZna5CaC7lO3ipGUD3REPH+wE9FMBPwwTmOz5wAMyo6MdMPiN/67B?=
 =?us-ascii?Q?WrTp2v1jIojjb3Vvj3pkCq4QWz2jazGJ+z8Z6QkFaCOpOdF7Vz/7kC9DON3k?=
 =?us-ascii?Q?nHkR6JFANDwL3pNA1zCp2Cxc9mzhRqFRYaYLQ/GIeP4YOAqCGcDfM3VD53Nl?=
 =?us-ascii?Q?RsNkPqdl8m7+6Ntl0oYnhn1ZRYubRFbhOj7tlcNgbI1PAHDCeDyjrDGVwecI?=
 =?us-ascii?Q?C8yy36zlcEmEwd02FOA/XbEuudQ6jtbhGbeshk6pqnrkefmxwgpQomZThrpc?=
 =?us-ascii?Q?q2ItMZLiC8VNrCMz+L29QuklPN4FuH1J5DWaEl3MSWiH5p856sY+qjuoEPQd?=
 =?us-ascii?Q?p4kwI2XmS3oYtHDYCbKxLkLMeGu64ScM3v3HtHhilGw7hzB559CMcr+u4uwi?=
 =?us-ascii?Q?Y+zwDrXdngS+SB/zE6gSe/FAWEAt53zWVN4dJABRRan3IQGnBfM2Nq+/UAqe?=
 =?us-ascii?Q?+RL02a37dyrQLWBjA/ZONletl69JCfYrpPtx+P45pNLF5wGwT7L7ptxjZniu?=
 =?us-ascii?Q?C+KiZN8tbdPy5lcdjJj2M0GVNS3+2dWtJ94SKzMGnke7H0DCpu/VDzQThJg6?=
 =?us-ascii?Q?R9x4oduNnXoWE8Whl/hN1t57lpnwsg00d03VCEuI0XvSTcqDBdTx9u0DxUmT?=
 =?us-ascii?Q?BHgSgVnNK3o80emCR34Af5A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c221b02-cfcb-4914-53ca-08d9da6c9be7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:23:45.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHjzcnP1h2gkh9r5dxp5IdY7QX+wndKfX4S6ajsXu/6qHZpaw0Df7S0OnH6jlQJ3dF+c7Y5IYriX3sruAuJyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-18 12:18:18, Abel Vesa wrote:
> On 21-12-16 10:50:23, Stephen Boyd wrote:
> > Quoting Abel Vesa (2021-11-10 09:56:40)
> > > diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
> > > index c53a688d8ccc..7f4893706cc2 100644
> > > --- a/drivers/clk/imx/clk-imx8qxp.c
> > > +++ b/drivers/clk/imx/clk-imx8qxp.c
> > > @@ -297,6 +297,7 @@ static const struct of_device_id imx8qxp_match[] = {
> > >         { .compatible = "fsl,scu-clk", },
> > >         { .compatible = "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
> > >         { .compatible = "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
> > > +       { .compatible = "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },
> > 
> > Can you keep this sorted on compatible string? Then we don't have to
> > worry about conflicts as much.
> > 
> 
> Yep. Will resend.

Actually, v2 is right here:

https://lore.kernel.org/linux-arm-kernel/1639747533-9778-1-git-send-email-abel.vesa@nxp.com/

You ACK'ed it already. And it adds the dxl compatible in the right spot.

> 
> > >         { /* sentinel */ }
> > >  };
> > >
