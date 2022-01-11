Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2848B8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiAKUw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:52:59 -0500
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:3659
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233848AbiAKUwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:52:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpu/E16fEci5SHRxFq2m36+tXPayPnolXP6Sg5Y9bjiuxNWoRkQVaxW0x7mWkmqm2+9WlSf8zvVbhcHnW/APndXUmycEsmoa7IShQdSXskAIt9ky634MzSNw7EBUf50MgiFLF6kEcx+tzltCwmCIiVmJ0guIZ1xlL2i/xCsYJvad0gePurhKo7/pbI95zEXTpbSpdkrEcfDQur4JDVlS0I+ocNNyWAF0aEjoisur0U61WT+WGxj9HVvvFEtFR9IXXOqGawyX+VGECnqcelNGm2ODrkNO1H3ynIka8RqGZopkoYb3Hpf7WSJiAZwkT6dT6VvcPyTIoLRCmOVtEpz4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ilmMalg7qeO/FkMkpcTs40jVEoTK135MkmeOviZWU=;
 b=lzxGHGkSMEogaz0rVsML3mVO4hWJVgzoBI4eskC9TF5CY7nPhBue5HRPD28iiUfLdJkMimjDccKLhItlKlk1Cj3gq6gm3E/qHOPuVlCTIcDyqYlfdPqGLU0Zm9VZw1TN5xuxIXaWEtim55FDImAe6PMpz4bwiYCyRF2DOm7SdXYnanuFhkmgv/FrN8Z0/ndzgaXHNmBZBteopT6/ygej0GoUXxr1bh8Skwc64pTHT5QLSaMlDbw6XKU+43+DeElk5PqblOc46vH7izohlsltTuTB365aOi6s4XEZvhExWXr7/ouV+vNTVy4i5kEdncWDIgHYkMH0BiGdJiGPRd5Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ilmMalg7qeO/FkMkpcTs40jVEoTK135MkmeOviZWU=;
 b=npx9JhV5JUBsms3kdAmrcD4TGEIdjYahVFZI3ZuTlRn/bKgi0h51iZCzn8KK7d15mPPcMOyJSWCDsWWxK2voOrtRoj2yRGObwbbTkHLiOZueSEEK6zcBr/oFY90gPziPJITHZJbIUSvfeg49q+qqWBHu0k3i7754+v0aI4rpKvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB6014.eurprd04.prod.outlook.com (2603:10a6:803:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 20:52:32 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%5]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 20:52:32 +0000
Date:   Tue, 11 Jan 2022 22:52:29 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com,
        mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 5/7] clk: imx: Add initial support for i.MXRT1050
 clock driver
Message-ID: <Yd3uDSAwQMoNz8e3@abelvesa>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-6-Mr.Bossman075@gmail.com>
 <20220105235157.8ED80C36AEB@smtp.kernel.org>
 <89046151-e44e-6828-ad76-8574fba4fca8@gmail.com>
 <20220110201201.C1E37C36AE9@smtp.kernel.org>
 <Ydy3qvT5w6IWnR7s@abelvesa>
 <baa991a5-31d8-80fb-faf0-b443626030d4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa991a5-31d8-80fb-faf0-b443626030d4@gmail.com>
X-ClientProxiedBy: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d18511-0394-43e2-aad3-08d9d5444978
X-MS-TrafficTypeDiagnostic: VI1PR04MB6014:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6014947C2FDAECB370D69EACF6519@VI1PR04MB6014.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2btoxZG/BcgvCWcrH13NI1/tQi93jodcfwlrKU31mNuSPMHQu0deROeAOVkomwWOwP7ZhRCkoPfv9dfIi7PLYHPGPFp6lkQNGIPOwNDV4PvjVXbHl2+pd8WeqFgxnPEzj45yGugc/T87h1hIAkJqHLGA62EJBJvA3m7VLHcUJRikPGPt/Y5vfxMTd5YM1yzwU24q/umeqFLc2tzOSLV20hahSFP5blRsDegIy0jUMA1H0GmcF1IUQbSr/Lb9lQ07Vmq9P0CuxGVMca+0LwO5wF62l3OOJy8XIUnisdUZdWKmXzXoV6BtKg2wKDzIaFRuzGPEz8qNNYL5xMxUZunEN6H7k7/W/+2UTDw85F5WIUPSEHgTHxnOP92bidCzzsIxT9M4dWUyJ2neS+9+FHjyqEb2U8EHPhI4MAz58xjRaNJvIlSZQMR3oaS+WW0DXQ59QvMLc69cg8FgGmaKe7zz99zoJEStIEXQmpz+kuOF+6YlLFHxSGuH1g4sZ/ioKvcH1zwidJvOpIWeHLXzKUySlgjBngqV5/aYKUpWvIK+YvXtTZ+yMcoibZDlaktXaCe642JsY2UXz8KC39i/gcg7+fq54llD1qZl6WVz9UFtTeHvD1uCVcJfyc0SAco3igsoPF5L04Zswr8ZDgTvwy6zEfZEy2TFWk3LI2sLFsfnXAxM49bj2J0qYBOL2HZbAOebnP2m6NE4ZjD1ix6xOwh/4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(33716001)(6506007)(53546011)(8676002)(6512007)(38100700002)(316002)(5660300002)(4326008)(6666004)(2906002)(38350700002)(508600001)(6916009)(9686003)(26005)(7416002)(66946007)(186003)(83380400001)(86362001)(66476007)(66556008)(6486002)(52116002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dc72J8SdP8XBRyPAD+H/7Rk+l2Q3qzK4bAEBtEnh2pQIcb+m0ARy+A0nLSlp?=
 =?us-ascii?Q?D6hC5SvQzG9k6Iv50tjkdnC4BCXQYwZl++ruARRQxDD/18FSEfjZA/iyvtdC?=
 =?us-ascii?Q?PX6HDNiDlLOQ3jCXAdYM2qSRbAQ0rascawSZkhGRqK7J9FpFbsm41HDcw4+l?=
 =?us-ascii?Q?GHtUMnb7OxU9grbOEV/aJedkfoG4HPqAMpJpLkSrHeUFMid8fPxTGNGE0Xmg?=
 =?us-ascii?Q?R7MV3RYrv7nIEoexeGPq18v5OgDsUquJmz1WHnrlozoMGfh+kA2hichLcxwO?=
 =?us-ascii?Q?XCiEis/YCxajQc9j5i1aNb+ZjMqC2yX5KhuHEkTTDLeo7U7zzCmBFRxKnTOE?=
 =?us-ascii?Q?vEKlcA+fSFmoG/+lD83uHj+ojf+UZ7UkRE+Cwk1pHtE9q0ivlv2Nk2vKgPyE?=
 =?us-ascii?Q?kyJgKnE8OgnwLPAy/Yq03Z0sOREB/egJ707s8yDu3U6jkqokFfMcsOwoqBGC?=
 =?us-ascii?Q?OGYOGRcRaMSnrekDADMTWJ1UVgmBNV3rk+77ZMCBSjIteJhwNXOKbqIoOJt+?=
 =?us-ascii?Q?/HSJJUzHPZqjK181Ht1xTHFwOOk35fN15pmI67b4u48TWwR8daYodeEmzuSn?=
 =?us-ascii?Q?xe19LWaO+m49KwN9CL6QsClaJQPH9d+zbw2o7gF9n7awriBwzP8yKtMI5w4N?=
 =?us-ascii?Q?u7bbhsLrW7SjAnPP7D8iGWE2owy4bjDKJl6qnWpBECy3XQyjhasXk311PM5x?=
 =?us-ascii?Q?oCJzgoWlofeZFN5ATHnGAspaXtoCq9AecqEhSWeHvh7wOTtNek5irBMaLN5u?=
 =?us-ascii?Q?Byou7Mbk5ip5tnQWM5QHtG4EF45+U/hZlc1yTPzD3M26ck9BLqsNhhi7t37a?=
 =?us-ascii?Q?G7kJMILHvg6lGgT0/2Mcj11p2oNdqfGTFExs/0mM8AR2Sisr5OciAF6nOwKW?=
 =?us-ascii?Q?OdtXOahx0i0QgQRfMXFtHK2es9PWRVftFhwQwiHH/mPk7mAUQAJ452J+r2A5?=
 =?us-ascii?Q?kumVBoIZOcJhK92+5R0F43YTozzoadvh8nBkGAoX/GjqteP6q/50/lyRXlpE?=
 =?us-ascii?Q?lnifAUZOArBdXQQfT313k9g8A3EvhbeM8Y7fMm6I9u83t3AsDxvlyVAfSLoQ?=
 =?us-ascii?Q?MancBO4RHcasL308JIdIPO7jOGcH6bSY8Ru1MYclkz5xZMG9Umgc3GuQmVv+?=
 =?us-ascii?Q?5OaaADgx9j3mCXmD7WZ+4fvsWEoYC6XgqCjwq7mDfJv0zdwC1c6G1Gpjkp41?=
 =?us-ascii?Q?HlJBZYrAyFhDKm5Ydifv9uLsPvdvREEuFj0bpFHZ4yLEzGCMSCzbaQy0PIcX?=
 =?us-ascii?Q?eqzAVmEmyvuxJyyLM34h4DblrTMAta83+Kmc8f/RcWHuJtHdQLVxWpXZs1o2?=
 =?us-ascii?Q?HGbbKwuSIhd38xUp8md4ULWRJALSbsoXt8tdV6B7qHcNbcaIdUO4ruxRnel8?=
 =?us-ascii?Q?LgesVA/McrJjopUpsnlBqAdZ9gSl6WgFMVnaD+h45zrbk6wzji1G9+KeNfp+?=
 =?us-ascii?Q?sLCnOkNc4795y0yXbIolKog67/crf+hmMbT9ExSSoqadGzq36pPZXmNE9xp5?=
 =?us-ascii?Q?nua8OhL4Btna5dTWh5oIfVJ1GcYyKCrgz3aITQfMljqkNTMikbyj0CSv94un?=
 =?us-ascii?Q?foKm69GcfAfxNQDtjLUzdgX5fHmFwvljFDfpSg3QtyE4fjMG+q2Lj5JAvrDt?=
 =?us-ascii?Q?szRftQEA+KN4I7oPd7eBl3c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d18511-0394-43e2-aad3-08d9d5444978
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 20:52:31.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwChWVc8O5/QyF/Fa9sCJNAa5SMfBd4qEAKX8RL51W5a3qEVRKLh2RKQopgq0sNxZ3cnmSlTUDVG7aGHIMyKEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-10 19:18:58, Jesse Taube wrote:
> 
> 
> On 1/10/22 17:48, Abel Vesa wrote:
> > On 22-01-10 12:12:00, Stephen Boyd wrote:
> > > Quoting Jesse Taube (2022-01-09 11:07:42)
> > > > > > +
> > > > > > +       clk_hw_data->num = IMXRT1050_CLK_END;
> > > > > > +       hws = clk_hw_data->hws;
> > > > > > +
> > > > > > +       hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
> > > > > 
> > > > > Use clk_parent_data instead and reference the binding name with .fw_name
> > > > 
> > > > Hi Stephen, sorry to bother you again.
> > > > I'm wondering if adding `clk_parent_data` is necessary as it seems like
> > > > it wold be a big change and the other IMX boards haven't implemented
> > > > this yet would it be okay if I don't do this, or if it is necessary
> > > > could you link to a patch set to change it.
> > > > 
> > > 
> > > Is it a big change because the imx_clk_hw*() APIs aren't prepared for
> > > non-string parents? Can you make some clk_parent_data based APIs and
> > > migrate things over gradually? This is really a question for i.MX folks
> > > to see if anyone is working on moving away from the string names.
> > 
> > I'm currently looking into it. I would suggest we take this patch as is
> > and I'll switch it later on to clk_parent_data.
> Thanks so much that would be great!
> 
> Should I sent the other changes requested I have them ready? Or should i
> wait.

Sure, send it. If Stephen is OK with my suggestion, I will pick it.

> 
> Best regards
> 	Jesse Taube
