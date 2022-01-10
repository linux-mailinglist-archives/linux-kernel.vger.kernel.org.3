Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7248A32D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiAJWsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:48:18 -0500
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:25824
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241522AbiAJWsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:48:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLYUDYhpNOKH5GButKY8IVNNKx4EPIdJZaCWUUqd0BVXPBeiFTeYtvq+HFGrxEEiNHu9iawH7Y5U/pFYWu8n41GTGbYJtOn23Gme368BFuzIEG8PcOurfDRKNS+LgfoB7Xsv9P0Dd+SuVnLa6yiJ3HLUABErHhaKsSpjMf+w66xGjVnIL1AUKZ+otwVA4eEwBo8bgCWAxh7B/Y54Nc2jaSTy7UfF1+riVcs7k/VgaegZKoYWrjCUjlqYOULuKywi73Zn5SnfqTaLVFjaBiQ/f5PHaflFsv5KUcIz2+fBohAqf7LbpZ4SR6xBbKcJdg82/wPE/3kcVFLjD2sR4U0e2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3ponFCNRdU0SDu/J/m7J0IFzU80eckDtMzq4qtCIrA=;
 b=FlyE3lwUIP/1azSYKw2n3sghYFP0znxkmV7mYzqqDqJp3Pe/g+2BlK5Ra50clrT3ESaWlODqUQmNRbVSc9YCMoNwWBEYlWQyJv3LKxDQgfrQXLUyt5BHQJIyL2JircSB2qpBHK7+XsR1hv6cSOUWuBTI+u0SYdvbEofw2jmLplqn2zDpRkpWUVEHZWeQ7RGLa4ivbBsll0++jNbfLSlIY3Hwbhe8FUu/oOLDjr+H7IAC+T9mRZY3Hc62p7NGjnAGjsFrYl8VuYAc7RdiqZWkY0A7zbYvbO0rznoEotXcNF4PUujILNdwag3nGhaPsZsPUUmX+KDV0vJFlq9c3T3yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3ponFCNRdU0SDu/J/m7J0IFzU80eckDtMzq4qtCIrA=;
 b=Vxdm/bkrmvLDpBEvSLqOMBJDkfmgTxui16dp1AoapX3C5B5Ps2izWNGQv7m8xvLBo00SxGuQZPgdfN8zEevghm+OD5RFG+1/J5u7B3JKGlPNtQEjoixcqM4qbZvpvH5cwnObqyWaelBk7/pKqQGaSHXA52LpYte2OLRORQhYzZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2862.eurprd04.prod.outlook.com (2603:10a6:800:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 22:48:13 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 22:48:13 +0000
Date:   Tue, 11 Jan 2022 00:48:10 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com,
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
Message-ID: <Ydy3qvT5w6IWnR7s@abelvesa>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-6-Mr.Bossman075@gmail.com>
 <20220105235157.8ED80C36AEB@smtp.kernel.org>
 <89046151-e44e-6828-ad76-8574fba4fca8@gmail.com>
 <20220110201201.C1E37C36AE9@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110201201.C1E37C36AE9@smtp.kernel.org>
X-ClientProxiedBy: VI1PR0501CA0039.eurprd05.prod.outlook.com
 (2603:10a6:800:60::25) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33278c3-0d7f-4262-5f7b-08d9d48b4823
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2862:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB28620597F2F85A80DDAC673FF6509@VI1PR0402MB2862.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFU2RB9QwB4748q/0Z/SyHxZIbpAsGPnf+wpU/SguKe3K5mOIiZXQMv73mzDQRbiiOCmhKDTM+kI2uTyrCUExUj0qs0Qniy6hySaKcfQJ68S2FZLQV5Qrej2l7DNB9WtKHCPWYWIYZNN9N/TwT/P0PxoMgr8VKmsUmR7xLiCJz+Q1wkLKnbd1DVDTwQ5cmc1PUwcPyTmI7Lmp1F5wHu0UO/taCTOnmR7qL7eNaOxJXYck1q4bNQcALfRx0kCi348rqBYmUptRy/oVUkzxg/gzbDVDuwToKORlUqufzNMo/GrQ4Z1VErd36OiFm3wpw5of8gnKdEaqOwVcOuXPFPPFwSRvLg67oVA7j+jvZw9T/gcdiEPBisvRltMw6D60YyVg9cmsMUymgzrWC21tH+DaAdm+mCwylLWxw0LIzvKkJrgRke+2uS9vk2jwRcO7ZbZ731/6JDCxEerF9EMHt+P6xB3E6SsMRD/APXCqUjD7NQJsBpKft0m+JToduoe6jhy9dH/qD9FWtZUyEq+7CXhkZHmMcwCkQ+FiLXaHzkUSpsUUgL2axZlLN8nCVj18dSw3e6SnW7mlNXv6T3xLzC6OJHxKVinaguhxhrVAF13R7/td+dtkpg6REp/F9uUE3gnEKiyvrVsUKh7r8jsJE0+67lvxLx/UvhYc4uaXAfcIvTyrbUZxigDWgm+sqU3ao7tpGLA4Bfo18WShJUw2XxGGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(33716001)(9686003)(4326008)(7416002)(6512007)(86362001)(26005)(38350700002)(38100700002)(6486002)(5660300002)(66476007)(8676002)(52116002)(66946007)(66556008)(186003)(316002)(44832011)(508600001)(2906002)(6916009)(8936002)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IZzw5J84yaG3gkonz8I+PV/Sgd0wWSUBLQmityPj93Ha1kaTmNF4/rtE9UY?=
 =?us-ascii?Q?e5zqAqHBR1r4aUbrk8xGPxsqcD+PnUU3qMxae/MYIQMf0ontdToQjbO/LS//?=
 =?us-ascii?Q?y3Q1UYlQgHxKMP+Jo3l+TNJ310HaDcdRl+7GAzz8Is+Ci6FzzOOTwGKlAqBm?=
 =?us-ascii?Q?Jzw+4gzGEcRr3gkPx/4ItkFSCcaIvVE8M42HiqLQC8/RXVcrT9sfJ9BKPESk?=
 =?us-ascii?Q?IaOQpTd8KOtTIotUlQSbgnvLKfcdYpDDUg3FtNocWQG96ZJaxTFaOeXOAhYU?=
 =?us-ascii?Q?g712fNkClkxJtS5X7q6cB4XiOL18h3ykVyBkqGTCYNpCRlPjgbi6okH0Wqd5?=
 =?us-ascii?Q?3ZSAVCeQ77IaWqS/A5SA0eVgE3IaVNogCLOOv+xaVEbXiYC6DlpW0v9oCJ+m?=
 =?us-ascii?Q?y7KZCsBn5CH/GiOHOPKG4r0Eg6msYb1MtU3TzrOKx6ZoZVg75PHnj0mKctb2?=
 =?us-ascii?Q?I/7JJ+nbJ79raF+f7+mnIgRp/0ZmXfOc+2Rm5gPO38HSEr7Va7XJqywm1ihl?=
 =?us-ascii?Q?XyKDCewco4boGkAMcUQukl+FUksOedOPSQfSscVsDVIny1X8r6xj908xQhr7?=
 =?us-ascii?Q?c3M+OdJenuJzFxkO7Irg6ZfrncAr7SbqxjDLj0K6RRY6BEdhBcCzKALFcyJg?=
 =?us-ascii?Q?Np6lZseTFqAMLd5yO0TpTap4B0Un4IEyBdyyEy9Z+9s2ijEnTq+mIdLPAobL?=
 =?us-ascii?Q?4xlp06St+Y1Lf+QbbphlrA7FmM9wp4VMqXTRlpRGwrC/BHdIZ3ukL+5kWm0N?=
 =?us-ascii?Q?ei0+ulH/OMwbz96Yy5PfZRouGoUN19W6zRz50HpUkS4+zmkSF32Odbx5TZkY?=
 =?us-ascii?Q?jHLgFfHxEzQEdvo4yCd2GMMS8tSuPlmxMB/P94fy2cBypNv0P7WFH+yvhI4X?=
 =?us-ascii?Q?gTd8/i2jfF1+ssmHLThpB7adbOSUrbRdqh8NCq3w2lp6wY835T2EGqXGObZp?=
 =?us-ascii?Q?8WgalCjawPTiGdNhGIsgWhGF7UhKGIoVW/LRMGAQQnErhVybD4sdauCVJWS8?=
 =?us-ascii?Q?NTt3Vt2g78VGwq5+Bu7mlf3IaNP+l3UXtokoBBF9XxtLgKEKiDjmA+1Ga/mQ?=
 =?us-ascii?Q?Wm5nlI63By/y4uywMgKNvjonyPjA5WoJm9cc++XYH2wKFadWxIuVKBwV/Ndr?=
 =?us-ascii?Q?FzsrCyt8IeTp8jFANfZf+sd4C7AnqQZTch3o1Gj8rUTQSYVAfcQfHTDvRvsk?=
 =?us-ascii?Q?0j8dDr6NKfZiptrSLTOPQyxoy25cMbxS3oWh/1fQyZMG3sIXwj5xw4+te1PU?=
 =?us-ascii?Q?HddbWQjk86TC4kN8V3v8U/BOySfIIcyZdCE1JumSZZvMuJ2KzGQcTweDUUBA?=
 =?us-ascii?Q?76wQ6GklaDwTcVsMrKigvJiogJ57q8qVfa2B3z5aE93GwH95hwDhcEWLWEGy?=
 =?us-ascii?Q?jV2GxpaB/KPXRJJbhSBwtZSIgh3R8AR55/LL/Zx5tFIAaajEGyKtWvy4J9Cm?=
 =?us-ascii?Q?5c5KbyCzHRiLs7t7sJKxjwtOOH3OeEiAoxPoDll9jbnqh+ddbReZrjgoIIGP?=
 =?us-ascii?Q?Dhhxxi2o4Nmm5GslAGusxW3vf7OA6vkT7uKnbNNvgUIMvvd+Y5Ez60uZgsYH?=
 =?us-ascii?Q?c/ywcpH/6S/Zvfo7rM0mGprU6yviPS45iL2Ie16aOsWb/6L4LM0M9nv9xQWa?=
 =?us-ascii?Q?OBxNAU6F9x+eTDTd6F1cHno=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33278c3-0d7f-4262-5f7b-08d9d48b4823
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 22:48:12.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNMAYIaNOmQBdgcPS3Eiepx8uJxwrLR/BQxzySEQ4SArrjLI3WNKMA2dySOFYbGHth15iIZ/R1ffIfE3vxZl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-10 12:12:00, Stephen Boyd wrote:
> Quoting Jesse Taube (2022-01-09 11:07:42)
> > >> +
> > >> +       clk_hw_data->num = IMXRT1050_CLK_END;
> > >> +       hws = clk_hw_data->hws;
> > >> +
> > >> +       hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
> > > 
> > > Use clk_parent_data instead and reference the binding name with .fw_name
> > 
> > Hi Stephen, sorry to bother you again.
> > I'm wondering if adding `clk_parent_data` is necessary as it seems like 
> > it wold be a big change and the other IMX boards haven't implemented 
> > this yet would it be okay if I don't do this, or if it is necessary 
> > could you link to a patch set to change it.
> > 
> 
> Is it a big change because the imx_clk_hw*() APIs aren't prepared for
> non-string parents? Can you make some clk_parent_data based APIs and
> migrate things over gradually? This is really a question for i.MX folks
> to see if anyone is working on moving away from the string names.

I'm currently looking into it. I would suggest we take this patch as is
and I'll switch it later on to clk_parent_data.

