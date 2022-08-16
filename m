Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079D596404
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiHPUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiHPUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:51:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2094.outbound.protection.outlook.com [40.107.104.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264E8993B;
        Tue, 16 Aug 2022 13:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrDHMRthnlrMYY/htyc97SS23nc8gDGPlGoGWEs8RWb1qzH7kRE1zwNVyoxixnHBNbpFGKyu3w36eC61A1xA3aGvw2oEjEsAlpFLuMvTHA4iYxZxeUUV1B9xcPScew0NfdkkmEo5C2lB0xYnaQmkenP2aN0NTFowBsyzdqhObF9Fj7Oaval1fcf8scwZeFyRRqVwE6ogDKneFgdC5WlvhfKiPS7AfuSE2259Ti4xCpDyy3GL0nhyFwQYhpZYW1Vq+Zuvt5yHYgKG6DmZtVcGgQOVw3QNhru6WXjrSOekj8VmvrWZc7GmSRtbS6b5sWVWSqhGB3ewOV/2wd7lT37AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM504g9AjuHfHzKcUoxkQt21SLzU+EpIyKdmYhl1p/o=;
 b=LHD018Sh2OFzarfIm2kkO7Ho5Mf8Eu/ClR5y8nO9oCw+J4fRQMtYcWs7W180Ah1KXMRM0ZvLr/bCogoflXwRAjd7Z/DMF3opEgmtvmzTIt8Z3CrjC8po6iZ7ho5Gjhof4+fRSmxJuB8gQpY+DXqgbsLeuLb7aHqbkq3zGHaufPuySCJVYhia6bkRiZcYNYMyYBn16Wt3BT/odUubEJQsrbkSd1aZqRk8+TmK5B8BVcGEDK4946viSdbqhh9Ib3MYNz/092/naBCKFk1tBEWIvidM9ZUd/ghH4O9uS4ink48ewP3MJ02j8JrPVBfwqwwxiw/OwPvo9XyRDNZ46YeDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM504g9AjuHfHzKcUoxkQt21SLzU+EpIyKdmYhl1p/o=;
 b=kcwUYdiWvJTQpFUrt2F3pTFROQZm+2mvBfCTpGQKwGqQoVDgCPvyyhpdB2jRle+jozFsE/nUKGEU+1ENzhA2qtjvMRzb2VIBGBd64dt4dxkxpqrcpqJZmXJLCpjl188jDb89apG1D49yvjYaVv4UJbQqgb/yVsqTgiF07WDisdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM5P190MB0241.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 20:51:33 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 20:51:33 +0000
Date:   Tue, 16 Aug 2022 23:51:29 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220816205129.GA6438@plvision.eu>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu>
 <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f15f88-fd18-44b3-ddc7-08da7fc919f0
X-MS-TrafficTypeDiagnostic: AM5P190MB0241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcICG6up89m7QAH916rWxv2WUmlg7b+iOt7MMZlBPFm+agNKBC89igmtuycl4qg+umLNso9ZlCxVEdhrF4ZOgRq36HxinOAyugXrEQKyZQ0Dex0mBMX5WZ0Gfohc7h0AYkmwB+yB8m794lBHlv1S5B1nxHI1ilWGnY3nBpx9ZD7yqLXcn53kD9cex6Ki3oKFJQ8U90UD50Xt8hpNJLd6+Xq88Fnm66C7M+D2naVEYGM7WOcD0OQCQ0kFUh9bnPiU/8isW4/98sU1XUM4muv0tYyJtBncwrIm0iT62nMHBb3ZLg5pz/Z6WszSBF5CFLCCQ47at9IlEw/FnpotChrVADJAi+wUR7+a5EPSM4vFUCLe3HZh5wXaH3VntqB9tFO4d07p/4VBOR3pGXlg/Nq5qwJmnAJSjeAh54J0t+8ofDSXrr7uFKxmUHlkuFj7Qcw7utHhBJbVzkgSEGllyB8Q44/J6ve1SUhrGetmbS78US3Co8ruhLc76tIwkV48+OpbTpIs1hHvbMStvw2bRbUoIbZumArz8/aJAlAuMzTxip/XttkcQ6TMrzIw+BSm6XeaORxbYeFky22uO4pwEp5x0JgWNfgOeP4ztxwW2DNQ6ehS6lWTnMjzXtINLnGg8P7uefMvSqVoY95ro6xKknHwuCWfCma2sQl+01X8irgO0fadLEJ51nkkRJG9rkeYjbQfnmom7YPQ/rt0BkuBWICAud4AzTUqKZ1uJM2k0DQ8sWz6i0+xv145ssvVUIS8zQ8xNMgGLY7Iz25LpEbwP5Y1LtJY2faK3aogj7gGz7maLtHlVXmAeTHhvQgCL+e3OId9cDbydAAQs3TF1RTIdKOyVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(34036004)(376002)(396003)(39830400003)(136003)(366004)(346002)(26005)(53546011)(33656002)(52116002)(6512007)(66476007)(66946007)(66556008)(4326008)(6506007)(6486002)(8676002)(6916009)(508600001)(45080400002)(38100700002)(38350700002)(316002)(54906003)(6666004)(30864003)(41320700001)(1076003)(83380400001)(8936002)(186003)(5660300002)(86362001)(7416002)(41300700001)(44832011)(36756003)(2616005)(2906002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iXRfSx0tMzDvvVa3ODvSO6Q2tv670qea4Y2zHxOQLDiHX4kcQfyfaTbgvtz1?=
 =?us-ascii?Q?Oc9mvPgMdnraLgfdnLR0GdrESj88TZzQ6XzJpZ4kHPKur7CoLSijAEVUFMmz?=
 =?us-ascii?Q?cVUWMkD2SpM0KRvJkCNDTdmZ54v3fDXMUGgnLRGskb4e2WnLdbmYBwT6p9ZK?=
 =?us-ascii?Q?c6n53mIbK3IBYiAwyN22lWLmk1pw20oP1mm4pxRqNbeNuf8WRwNXD3XG4s72?=
 =?us-ascii?Q?47C7HT9izaFBmqi/QYJOh0XDBz5twgxVGmTSdsOTTvP/KRI2AcBWA1O/Qigm?=
 =?us-ascii?Q?hEzQdDzCPFbqM3u/oCXCo6/iPCFo0GzDrNBR/tvq3HGWLLaXnFRJpEuD/nu8?=
 =?us-ascii?Q?aC+tNHunQ20IdYvKP8bKhrzFMsVVuM6dVuINNS6gFeO+dpUpLkixSvsXmtJZ?=
 =?us-ascii?Q?5JVfLUGXh+qUzaxKFvd2a0BdifnQbmfqa7J8bIx/GxmKBP/UnYbl0WY6U2Zw?=
 =?us-ascii?Q?tFHo617SRexGLyme5sG0BAF/PAxHyuNZzoLNjE83Wvs+be+yM+SorS+TJWTz?=
 =?us-ascii?Q?9ATlAfHUGLPBFn2DMfA3+4xlEPzZq1zz627rDBqCUW+tO4kZf3ergIeOvqZ+?=
 =?us-ascii?Q?ss4Umtrsk54wQvtD7ocvbGsYnwKR9C/Z4ruJ4cNRvOPvCHR9nKaLDpQzro6r?=
 =?us-ascii?Q?zWVripVtgvBz7N/cfCshtZ0UOB/VQqQ88GTbZ29B9dNBPrroHvxvh13qSIC/?=
 =?us-ascii?Q?IWD0Q9m07tJ68eYk/TBmuQIWkUFv6O3NAom2FItHEtqWH51RYixmpYrUi3/U?=
 =?us-ascii?Q?8FIR1T5kn6l8n3uyHsEfdbi6KpLXL9IoqeHN/LpCZCEzTzvReV0GZbYoEUqZ?=
 =?us-ascii?Q?4oU100KAZ8AsmvAzhjDQIiC7N6EgVZzd/mUravESGoljIX0hWIBHGADHA0JW?=
 =?us-ascii?Q?UeFPc6oou0Bt/d8W/3rQsC9eQLJvfJDG4PD897KcrJw8gygkHh0Hejyz7Tpb?=
 =?us-ascii?Q?bHG2hK3/g64A8yjjyf5bztazrHv1RyVKWZOQDet4rOFWnIjjUEq2hXFypLxz?=
 =?us-ascii?Q?L1P53BxtY0w+2ncfBBLTpihoqpU+AWmKS5POSwziHJMThCCMtOZw/fLz3p2a?=
 =?us-ascii?Q?VdEzkzxXTA7a0i75clwYIKr1YIhFHXvNNc1Sx7Em/6mY+ni0OMTMsclrdp4d?=
 =?us-ascii?Q?K5qeYVJ40iji8p42PyUNWszA5hpYPDtP/0UvaEX/QK2hJnvdUJG/FaikZ3v1?=
 =?us-ascii?Q?N/xExFDj8GsFQhbaRhn3lpN9aXl638IuqO2/NzS9QFk+nFb/M7YkwX1a5nat?=
 =?us-ascii?Q?v5CeSx+Oor5EYUS+hkxaloyY76Q+4sKQ89SEsEnFXPvWULe2Pxs8L3qdzrxO?=
 =?us-ascii?Q?eww7iBxhWgifRM0Lw23f9lYGeAfWxiA0tBpkM5163cJvoiuStaGAbxMcwlDg?=
 =?us-ascii?Q?OVqKwZKnj1dD53V65TDt0K1BuVFQAKih4teMVLoNBr0nd0XPntAlCpF3D9am?=
 =?us-ascii?Q?fM86Wj4npUhI6lPWD1mJ8SjwySP9pRrFB3diICF0Mdbl093/JlMP8MEHkQfI?=
 =?us-ascii?Q?CivAfy62EMc5HY4BlnQRXtg8DTmdl3pr75lIcJIO/45ghZhgyrI4pIqX7/B7?=
 =?us-ascii?Q?W/gefDb8ZggNAxpwcJlmG2YjXbY8/y6qbsgctIsP2U/obElVjd32Yuh1yFfj?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f15f88-fd18-44b3-ddc7-08da7fc919f0
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 20:51:32.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AxBEoaI3veLFW5ek2oJlBma+HMYZrxz4SPVy9EFnmQCVcs8GyPFkvZ6VJIXVycb4swRRrZkwwwwO+Dy1++MuOoWzWpswrPgczWKBoQ2z7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Aug 08, 2022 at 03:06:51PM +0100, Robin Murphy wrote:
> On 2022-08-08 13:58, Adrian Hunter wrote:
> > On 8/08/22 15:26, Vadym Kochan wrote:
> > > On Mon, Aug 08, 2022 at 02:40:07PM +0300, Adrian Hunter wrote:
> > > > On 8/08/22 12:52, Vadym Kochan wrote:
> > > > > Hi Adrian,
> > > > > 
> > > > > On Mon, Aug 08, 2022 at 12:19:10PM +0300, Adrian Hunter wrote:
> > > > > > On 1/08/22 12:30, Vadym Kochan wrote:
> > > > > > > Hi Florian,
> > > > > > > 
> > > > > > > On Wed, Jul 27, 2022 at 07:45:32PM +0300, Vadym Kochan wrote:
> > > > > > > > Hi Florian,
> > > > > > > > 
> > > > > > > > On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
> > > > > > > > > On 7/26/22 10:07, Vadym Kochan wrote:
> > > > > > > > > > From: Elad Nachman <enachman@marvell.com>
> > > > > > > > > > 
> > > > > > > > > > There is a limitation on AC5 SoC that mmc controller
> > > > > > > > > > can't have DMA access over 2G memory.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > > > > > > > > > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > > > > > > > > > ---
> > > > > > > > > >   drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
> > > > > > > > > >   1 file changed, 13 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > > > > > > > > > index 08e838400b52..666d06b58564 100644
> > > > > > > > > > --- a/drivers/mmc/host/sdhci-xenon.c
> > > > > > > > > > +++ b/drivers/mmc/host/sdhci-xenon.c
> > > > > > > > > > @@ -18,6 +18,7 @@
> > > > > > > > > >   #include <linux/of.h>
> > > > > > > > > >   #include <linux/pm.h>
> > > > > > > > > >   #include <linux/pm_runtime.h>
> > > > > > > > > > +#include <linux/mm.h>
> > > > > > > > > >   #include "sdhci-pltfm.h"
> > > > > > > > > >   #include "sdhci-xenon.h"
> > > > > > > > > > @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
> > > > > > > > > >   	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > > > > > > > > >   	u32 sdhc_id, nr_sdhc;
> > > > > > > > > >   	u32 tuning_count;
> > > > > > > > > > +	struct device_node *np = pdev->dev.of_node;
> > > > > > > > > > +	struct sysinfo si;
> > > > > > > > > >   	/* Disable HS200 on Armada AP806 */
> > > > > > > > > >   	if (priv->hw_version == XENON_AP806)
> > > > > > > > > > @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
> > > > > > > > > >   	}
> > > > > > > > > >   	priv->tuning_count = tuning_count;
> > > > > > > > > > +	si_meminfo(&si);
> > > > > > > > > > +
> > > > > > > > > > +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> > > > > > > > > > +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
> > > > > > > > > 
> > > > > > > > > Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
> > > > > > > > > 
> > > > > > > > > Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > I could use DMA only in 2 ways:
> > > > > > > 
> > > > > > > #1 Use sdhci bounce buffer with SDMA mode
> > > > > > > 
> > > > > > >      But there was the issue that SDMA requires that SDHCI v4 mode should
> > > > > > >      be enabled, and when I enable it via sdhci_enable_v4_mode(host)
> > > > > > >      then I got error that EXT_CSD can't be recognized.
> > > > > > > 
> > > > > > >      But if I comment this line in sdhci.c:
> > > > > > >      int sdhci_setup_host(struct sdhci_host *host)
> > > > > > >      {
> > > > > > >          ...
> > > > > > > 
> > > > > > > 	/* SDMA does not support 64-bit DMA if v4 mode not set */
> > > > > > > 	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
> > > > > > > 		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
> > > > > > > 		host->flags &= ~SDHCI_USE_SDMA;
> > > > > > > 	}
> > > > > > > 
> > > > > > >         ...
> > > > > > >      }
> > > > > > > 
> > > > > > >      then everything is OK.
> > > > > > > 
> > > > > > > #2 Use restricted-dma-pool in device-tree
> > > > > > > 
> > > > > > >     But I am not sure if it is good solution compared to #1.
> > > > > > > 
> > > > > > > Setting only DMA mask did not help because after some time I got
> > > > > > > "DMA overflow address" error stack-traces.
> > > > > > 
> > > > > > AFAICT using a DMA mask is the correct way to solve this.  If that
> > > > > > reveals another issue then that must be resolved also. Can you show
> > > > > > the stack traces and what kernel they are from?
> > > > > > 
> > > > > 
> > > > > The Linux version is next-20220808
> > > > > 
> > > > > Here is a stacktrace:
> > > > > 
> > > > > [   40.537028] ------------[ cut here ]------------
> > > > > [   40.541698] xenon-sdhci 805c0000.sdhci: DMA addr
> > > > > 0x00000002ff700000+40960 overflow (mask 27fffffff, bus limit 0).
> > > > > [   40.551968] WARNING: CPU: 0 PID: 7 at kernel/dma/direct.h:103
> > > > > dma_direct_map_sg+0x28c/0x2b0
> > > > 
> > > > Do you have CONFIG_SWIOTLB=y?
> > > > 
> > > 
> > > Yes. Additionally I pass "swiotlb=force", because as I understand it is
> > > not enabled by default at least on arm64.
> 
> If you think you need "swiotlb=force" then something's definitely wrong.
> SWIOTLB should be invoked automatically based on device DMA masks being set
> correctly. If you need to support devices with masks smaller than 32 bits
> you should have CONFIG_ZONE_DMA enabled as well.
> 
> > > > Is DMA mask correct? 2G mask would be 7fffffff not 27fffffff right?
> > > > 
> > > 
> > > The RAM starts at 0x2_00000000 so thats why I use this mask.
> 
> You can't have holes in DMA masks, they don't work that way. Presumably
> either the device interface itself drives DMA_BIT_MASK(34) or wider but the
> interconnect address map doesn't decode the full range, or the device drives
> DMA_BIT_MASK(31) and the interconnect adds a fixed offset of 0x200000000.
> Either way such a configuration should be described by devicetree dma-ranges
> property (or ACPI _DMA object) on the parent bus.
> 
> The one thing to watch out for is that SWIOTLB doesn't necessarily interact
> very well with DMA offsets. Given the intent of
> of_dma_get_max_cpu_address(), I think it ought to work out OK now for
> current kernels on DT systems if everything is described correctly, but
> otherwise it's likely that you end up with ZONE_DMA either being empty or
> containing all memory, so the SWIOTLB buffer ends up being allocated
> anywhere such that it might not actually work as expected.
> 
> Robin.

Hi Robin,

Thank you for the reply.

My understanding is that swiotlb is allocated (in case of arm64)
in the following cases:

   #1 when it is forced from the kernel cmdline

   #2 when max_pfn is greater than arm64_dma_phys_limit (and this is used
      as the end from which to allocate the swiotlb pool in the
      top-botom direction via memblock API).

   #3 using restricted dma-pool

Of course option #3 works fine because swiotlb is kind of forced to use
particulary this range of memory.

Both options #1 & #2 causes to use full memory mask even if to specify
dma-ranges in the DT:

    dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;

or if to specify the opposite:

    dma-ranges = <0x2 0x0 0x0 0x0 0x0 0x80000000>;

    just to make it lower than U32 to pass

        zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits)

    condition, but then it will be re-set in max_zone_phys() by:

     
	if (phys_start > U32_MAX)
		zone_mask = PHYS_ADDR_MAX;
	else if (phys_start > zone_mask)
		zone_mask = U32_MAX;

So, currently I dont see how to pin swiotlb (I see it as a main problem) to some specific range of physical
memory (particulary to the first 2G of RAM).

Thanks,
Vadym

> 
> > > 
> > > Event if to use forced swiotlb via command-line then swiotlb complains
> > > about the mask (from what I checked is that because swiotlb will be
> > > allocated at the top of the DMA memory, which is actually the end of
> > > RAM. Ofcourse if to manually hard-code arm64_dma_phys_limit in
> > > arch/arm64/mm/init.c then everything works ok and I see that swiotlb
> > > does the job if to check via debugfs):
> > 
> > It sounds like maybe SWIOTLB does not support your memory model?
> > Adding SWIOTLB people.
> > 
> > > 
> > > [    1.129987] ------------[ cut here ]------------
> > > [    1.134595] xenon-sdhci 805c0000.sdhci: swiotlb addr 0x00000002f7000000+512 overflow (mask 27fffffff, bus limit 0).
> > > [    1.142086] usb 1-1: new high-speed USB device number 2 using orion-ehci
> > > [    1.145025] WARNING: CPU: 0 PID: 24 at kernel/dma/swiotlb.c:880 swiotlb_map+0x1b4/0x1f0
> > > [    1.159679] Modules linked in:
> > > [    1.162733] CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted
> > > 5.19.0-next-20220808 #46
> > > [    1.170202] Hardware name: Marvell A0-AC5X Board (DT)
> > > [    1.175243] Workqueue: events_freezable mmc_rescan
> > > [    1.180033] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
> > > BTYPE=--)
> > > [    1.186982] pc : swiotlb_map+0x1b4/0x1f0
> > > [    1.190898] lr : swiotlb_map+0x1b4/0x1f0
> > > [    1.194813] sp : ffff80000a8eb840
> > > [    1.198119] x29: ffff80000a8eb840 x28: ffff80000a8ebb38 x27:
> > > 0000000000000000
> > > [    1.205245] x26: 0000000000000000 x25: ffff0000004de810 x24:
> > > 0000000000000000
> > > [    1.212369] x23: 0000000000000002 x22: 0000000000000002 x21:
> > > 0000000000000000
> > > [    1.219494] x20: 0000000000000200 x19: ffff0000004de810 x18:
> > > ffffffffffffffff
> > > [    1.226619] x17: 203231352b303030 x16: 3030303766323030 x15:
> > > 3030303030783020
> > > [    1.233744] x14: 7264646120626c74 x13: 2e29302074696d69 x12:
> > > 6c20737562202c66
> > > [    1.240869] x11: 6666666666663732 x10: 206b73616d282077 x9 :
> > > 6f697773203a6963
> > > [    1.247994] x8 : 6864732e30303030 x7 : 205d353935343331 x6 :
> > > ffff80000a665000
> > > [    1.255118] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> > > 00000000ffffffff
> > > [    1.262243] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > > ffff0000005a0000
> > > [    1.269369] Call trace:
> > > [    1.271810]  swiotlb_map+0x1b4/0x1f0
> > > [    1.275380]  dma_direct_map_sg+0x94/0x2b0
> > > [    1.279382]  __dma_map_sg_attrs+0x28/0xa0
> > > [    1.283388]  dma_map_sg_attrs+0x10/0x30
> > > [    1.287219]  sdhci_pre_dma_transfer+0xcc/0x150
> > > [    1.291658]  sdhci_send_command+0x644/0xea0
> > > [    1.295834]  sdhci_send_command_retry+0x40/0x140
> > > [    1.300443]  sdhci_request+0x70/0xd0
> > > [    1.304012]  __mmc_start_request+0x68/0x140
> > > [    1.308188]  mmc_start_request+0x78/0xa0
> > > [    1.312103]  mmc_wait_for_req+0x70/0x100
> > > [    1.316020]  mmc_send_adtc_data+0xd8/0x130
> > > [    1.320109]  mmc_get_ext_csd+0x70/0xe0
> > > [    1.323850]  mmc_init_card+0x7e8/0x1ad0
> > > [    1.327680]  mmc_attach_mmc+0xdc/0x180
> > > [    1.331422]  mmc_rescan+0x280/0x2f0
> > > [    1.334905]  process_one_work+0x1d0/0x320
> > > [    1.338912]  worker_thread+0x14c/0x450
> > > [    1.342655]  kthread+0x10c/0x110
> > > [    1.345879]  ret_from_fork+0x10/0x20
> > > [    1.349450] ---[ end trace 0000000000000000 ]---
> > > [    1.354091] ------------[ cut here ]------------
> > > 
> > > 
> > > > > [   40.560321] Modules linked in: uio_pdrv_genirq
> > > > > [   40.564766] CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted
> > > > > 5.19.0-next-20220808 #20
> > > > > [   40.572236] Hardware name: Marvell A0-AC5X Board (DT)
> > > > > [   40.577278] Workqueue: kblockd blk_mq_run_work_fn
> > > > > [   40.581980] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [   40.588929] pc : dma_direct_map_sg+0x28c/0x2b0
> > > > > [   40.593366] lr : dma_direct_map_sg+0x28c/0x2b0
> > > > > [   40.597801] sp : ffff80000a6eba20
> > > > > [   40.601107] x29: ffff80000a6eba20 x28: ffff000006d66080 x27:
> > > > > 0000000000000004
> > > > > [   40.608233] x26: 0000000000000000 x25: ffff0000004de810 x24:
> > > > > 0000000000000000
> > > > > [   40.615358] x23: 0000000000000002 x22: fffffc0000000000 x21:
> > > > > ffff800009153360
> > > > > [   40.622484] x20: 0000000000000005 x19: 00000002ff700000 x18:
> > > > > ffffffffffffffff
> > > > > [   40.629609] x17: 766f203036393034 x16: 2b30303030303766 x15:
> > > > > 6632303030303030
> > > > > [   40.636735] x14: 3078302072646461 x13: ffff80000a433d58 x12:
> > > > > 00000000000002dc
> > > > > [   40.643860] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
> > > > > ffff80000a48bd58
> > > > > [   40.650985] x8 : ffff80000a433d58 x7 : ffff80000a48bd58 x6 :
> > > > > 0000000000000000
> > > > > [   40.658110] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
> > > > > 0000000000000000
> > > > > [   40.665234] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > > > > ffff0000004add00
> > > > > [   40.672360] Call trace:
> > > > > [   40.674800]  dma_direct_map_sg+0x28c/0x2b0
> > > > > [   40.678890]  __dma_map_sg_attrs+0x28/0xa0
> > > > > [   40.682895]  dma_map_sg_attrs+0x10/0x30
> > > > > [   40.686725]  sdhci_pre_dma_transfer+0xcc/0x150
> > > > > [   40.691165]  sdhci_pre_req+0x3c/0x50
> > > > > [   40.694734]  mmc_blk_mq_issue_rq+0x25c/0x9d0
> > > > > [   40.698997]  mmc_mq_queue_rq+0x118/0x2b0
> > > > > [   40.702912]  blk_mq_dispatch_rq_list+0x19c/0x800
> > > > > [   40.707521]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > > > > [   40.712218]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > > > > [   40.717608]  blk_mq_sched_dispatch_requests+0x40/0x80
> > > > > [   40.722651]  __blk_mq_run_hw_queue+0x80/0xc0
> > > > > [   40.726911]  blk_mq_run_work_fn+0x24/0x30
> > > > > [   40.730913]  process_one_work+0x1d0/0x320
> > > > > [   40.734919]  worker_thread+0x14c/0x450
> > > > > [   40.738662]  kthread+0x10c/0x110
> > > > > [   40.741885]  ret_from_fork+0x10/0x20
> > > > > [   40.745457] ---[ end trace 0000000000000000 ]---
> > > > > [   40.750160] ------------[ cut here ]------------
> > > > > [   40.754770] WARNING: CPU: 0 PID: 7 at drivers/mmc/host/sdhci.c:1152
> > > > > sdhci_send_command+0x7fc/0xea0
> > > > > [   40.763719] Modules linked in: uio_pdrv_genirq
> > > > > [   40.768149] CPU: 0 PID: 7 Comm: kworker/0:0H Tainted: G        W
> > > > > 5.19.0-next-20220808 #20
> > > > > [   40.777090] Hardware name: Marvell A0-AC5X Board (DT)
> > > > > [   40.782129] Workqueue: kblockd blk_mq_run_work_fn
> > > > > [   40.786827] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [   40.793775] pc : sdhci_send_command+0x7fc/0xea0
> > > > > [   40.798297] lr : sdhci_send_command+0x644/0xea0
> > > > > [   40.802821] sp : ffff80000a6eb980
> > > > > [   40.806127] x29: ffff80000a6eb980 x28: ffff80000a6ebcf8 x27:
> > > > > 0000000000000002
> > > > > [   40.813253] x26: 0000000000000000 x25: 0000000000000000 x24:
> > > > > ffff0000004237c0
> > > > > [   40.820378] x23: 000000000000000b x22: ffff000006d825b8 x21:
> > > > > ffff000006d82628
> > > > > [   40.827502] x20: ffff000006d825b8 x19: ffff000000423580 x18:
> > > > > ffffffffffffffff
> > > > > [   40.834627] x17: 766f203036393034 x16: 2b30303030303766 x15:
> > > > > 6632303030303030
> > > > > [   40.841751] x14: 3078302072646461 x13: ffff80000a433d58 x12:
> > > > > 00000000000002dc
> > > > > [   40.848876] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
> > > > > ffff80000a48bd58
> > > > > [   40.856001] x8 : ffff80000a433d58 x7 : 0000000000000000 x6 :
> > > > > ffff0000004deaf8
> > > > > [   40.863125] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > > > > 0000000000000000
> > > > > [   40.870250] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > > > > 00000000ffffffe4
> > > > > [   40.877374] Call trace:
> > > > > [   40.879813]  sdhci_send_command+0x7fc/0xea0
> > > > > [   40.883989]  sdhci_send_command_retry+0x40/0x140
> > > > > [   40.888597]  sdhci_request+0x70/0xd0
> > > > > [   40.892167]  __mmc_start_request+0x68/0x140
> > > > > [   40.896345]  mmc_start_request+0x78/0xa0
> > > > > [   40.900260]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > > > > [   40.904521]  mmc_mq_queue_rq+0x118/0x2b0
> > > > > [   40.908436]  blk_mq_dispatch_rq_list+0x19c/0x800
> > > > > [   40.913045]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > > > > [   40.917741]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > > > > [   40.923131]  blk_mq_sched_dispatch_requests+0x40/0x80
> > > > > [   40.928173]  __blk_mq_run_hw_queue+0x80/0xc0
> > > > > [   40.932435]  blk_mq_run_work_fn+0x24/0x30
> > > > > [   40.936437]  process_one_work+0x1d0/0x320
> > > > > [   40.940442]  worker_thread+0x14c/0x450
> > > > > [   40.944184]  kthread+0x10c/0x110
> > > > > [   40.947407]  ret_from_fork+0x10/0x20
> > > > > [   40.950977] ---[ end trace 0000000000000000 ]---
> > > > > [   40.960738] ------------[ cut here ]------------
> > > > > [   40.965361] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > > > > sdhci_send_command+0x7fc/0xea0
> > > > > [   40.974403] Modules linked in: uio_pdrv_genirq
> > > > > [   40.978843] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > > > > 5.19.0-next-20220808 #20
> > > > > [   40.987873] Hardware name: Marvell A0-AC5X Board (DT)
> > > > > [   40.992913] Workqueue: kblockd blk_mq_run_work_fn
> > > > > [   40.997613] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [   41.004562] pc : sdhci_send_command+0x7fc/0xea0
> > > > > [   41.009086] lr : sdhci_send_command+0x644/0xea0
> > > > > [   41.013610] sp : ffff80000a9db980
> > > > > [   41.016915] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > > > > 0000000000000002
> > > > > [   41.024041] x26: 0000000000000000 x25: 0000000000000000 x24:
> > > > > ffff0000004237c0
> > > > > [   41.031166] x23: 000000000000000b x22: ffff000006d05eb8 x21:
> > > > > ffff000006d05f28
> > > > > [   41.038291] x20: ffff000006d05eb8 x19: ffff000000423580 x18:
> > > > > fffffc0003fde640
> > > > > [   41.045416] x17: 0000000000000000 x16: 0000000000000000 x15:
> > > > > 0000000000000000
> > > > > [   41.052540] x14: 0000000000000002 x13: 0000000000100000 x12:
> > > > > 0000000000000000
> > > > > [   41.059664] x11: 0000000000000000 x10: 0000000000000b10 x9 :
> > > > > ffff80000a9db9e0
> > > > > [   41.066789] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > > > > ffff0000004deaf8
> > > > > [   41.073914] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > > > > 0000000000000000
> > > > > [   41.081039] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > > > > 00000000ffffffe4
> > > > > [   41.088164] Call trace:
> > > > > [   41.090603]  sdhci_send_command+0x7fc/0xea0
> > > > > [   41.094779]  sdhci_send_command_retry+0x40/0x140
> > > > > [   41.099379]  sdhci_request+0x70/0xd0
> > > > > [   41.102949]  __mmc_start_request+0x68/0x140
> > > > > [   41.107127]  mmc_start_request+0x78/0xa0
> > > > > [   41.111042]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > > > > [   41.115305]  mmc_mq_queue_rq+0x118/0x2b0
> > > > > [   41.119221]  blk_mq_dispatch_rq_list+0x19c/0x800
> > > > > [   41.123831]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > > > > [   41.128528]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > > > > [   41.133917]  blk_mq_sched_dispatch_requests+0x40/0x80
> > > > > [   41.138959]  __blk_mq_run_hw_queue+0x80/0xc0
> > > > > [   41.143222]  blk_mq_run_work_fn+0x24/0x30
> > > > > [   41.147223]  process_one_work+0x1d0/0x320
> > > > > [   41.151230]  worker_thread+0x14c/0x450
> > > > > [   41.154973]  kthread+0x10c/0x110
> > > > > [   41.158195]  ret_from_fork+0x10/0x20
> > > > > [   41.161766] ---[ end trace 0000000000000000 ]---
> > > > > [   41.171543] ------------[ cut here ]------------
> > > > > [   41.176169] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > > > > sdhci_send_command+0x7fc/0xea0
> > > > > [   41.185210] Modules linked in: uio_pdrv_genirq
> > > > > [   41.189650] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > > > > 5.19.0-next-20220808 #20
> > > > > [   41.198679] Hardware name: Marvell A0-AC5X Board (DT)
> > > > > [   41.203720] Workqueue: kblockd blk_mq_run_work_fn
> > > > > [   41.208420] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [   41.215369] pc : sdhci_send_command+0x7fc/0xea0
> > > > > [   41.219892] lr : sdhci_send_command+0x644/0xea0
> > > > > [   41.224414] sp : ffff80000a9db980
> > > > > [   41.227721] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > > > > 0000000000000002
> > > > > [   41.234846] x26: 0000000000000000 x25: 0000000000000000 x24:
> > > > > ffff0000004237c0
> > > > > [   41.241972] x23: 000000000000000b x22: ffff000006d001b8 x21:
> > > > > ffff000006d00228
> > > > > [   41.249097] x20: ffff000006d001b8 x19: ffff000000423580 x18:
> > > > > 0000000000000000
> > > > > [   41.256223] x17: 0000000000000000 x16: 0000000000000000 x15:
> > > > > 0000000000000000
> > > > > [   41.263348] x14: 0000000000000002 x13: 0000000000100000 x12:
> > > > > 0000000000000000
> > > > > [   41.270473] x11: 0000000000000001 x10: 0000000000000b10 x9 :
> > > > > ffff80000a9db9e0
> > > > > [   41.277598] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > > > > ffff0000004deaf8
> > > > > [   41.284722] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > > > > 0000000000000000
> > > > > [   41.291846] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > > > > 00000000ffffffe4
> > > > > [   41.298971] Call trace:
> > > > > [   41.301410]  sdhci_send_command+0x7fc/0xea0
> > > > > [   41.305588]  sdhci_send_command_retry+0x40/0x140
> > > > > [   41.310198]  sdhci_request+0x70/0xd0
> > > > > [   41.313769]  __mmc_start_request+0x68/0x140
> > > > > [   41.317946]  mmc_start_request+0x78/0xa0
> > > > > [   41.321862]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > > > > [   41.326125]  mmc_mq_queue_rq+0x118/0x2b0
> > > > > [   41.330040]  blk_mq_dispatch_rq_list+0x19c/0x800
> > > > > [   41.334649]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > > > > [   41.339346]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > > > > [   41.344735]  blk_mq_sched_dispatch_requests+0x40/0x80
> > > > > [   41.349779]  __blk_mq_run_hw_queue+0x80/0xc0
> > > > > [   41.354040]  blk_mq_run_work_fn+0x24/0x30
> > > > > [   41.358041]  process_one_work+0x1d0/0x320
> > > > > [   41.362048]  worker_thread+0x14c/0x450
> > > > > [   41.365791]  kthread+0x10c/0x110
> > > > > [   41.369014]  ret_from_fork+0x10/0x20
> > > > > [   41.372584] ---[ end trace 0000000000000000 ]---
> > > > > [   41.382383] ------------[ cut here ]------------
> > > > > [   41.387009] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > > > > sdhci_send_command+0x7fc/0xea0
> > > > > [   41.396051] Modules linked in: uio_pdrv_genirq
> > > > > [   41.400491] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > > > > 5.19.0-next-20220808 #20
> > > > > [   41.409520] Hardware name: Marvell A0-AC5X Board (DT)
> > > > > [   41.414561] Workqueue: kblockd blk_mq_run_work_fn
> > > > > [   41.419261] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [   41.426210] pc : sdhci_send_command+0x7fc/0xea0
> > > > > [   41.430734] lr : sdhci_send_command+0x644/0xea0
> > > > > [   41.435256] sp : ffff80000a9db980
> > > > > [   41.438562] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > > > > 0000000000000002
> > > > > [   41.445687] x26: 0000000000000000 x25: 0000000000000000 x24:
> > > > > ffff0000004237c0
> > > > > [   41.452812] x23: 000000000000000b x22: ffff000006d004b8 x21:
> > > > > ffff000006d00528
> > > > > [   41.459937] x20: ffff000006d004b8 x19: ffff000000423580 x18:
> > > > > 0000000000000000
> > > > > [   41.467062] x17: 0000000000000000 x16: 0000000000000000 x15:
> > > > > 0000000000000000
> > > > > [   41.474187] x14: 0000000000000002 x13: 00000000000ff000 x12:
> > > > > 0000000000000000
> > > > > [   41.481311] x11: 0000000000000001 x10: 0000000000000b10 x9 :
> > > > > ffff80000a9db9e0
> > > > > [   41.488436] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > > > > ffff0000004deaf8
> > > > > [   41.495561] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > > > > 0000000000000000
> > > > > [   41.502685] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > > > > 00000000ffffffe4
> > > > > [   41.509811] Call trace:
> > > > > [   41.512250]  sdhci_send_command+0x7fc/0xea0
> > > > > [   41.516427]  sdhci_send_command_retry+0x40/0x140
> > > > > [   41.521035]  sdhci_request+0x70/0xd0
> > > > > [   41.524607]  __mmc_start_request+0x68/0x140
> > > > > [   41.528784]  mmc_start_request+0x78/0xa0
> > > > > [   41.532699]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > > > > [   41.536961]  mmc_mq_queue_rq+0x118/0x2b0
> > > > > [   41.540876]  blk_mq_dispatch_rq_list+0x19c/0x800
> > > > > [   41.545485]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > > > > [   41.550182]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > > > > [   41.555570]  blk_mq_sched_dispatch_requests+0x40/0x80
> > > > > [   41.560613]  __blk_mq_run_hw_queue+0x80/0xc0
> > > > > [   41.564874]  blk_mq_run_work_fn+0x24/0x30
> > > > > [   41.568875]  process_one_work+0x1d0/0x320
> > > > > [   41.572881]  worker_thread+0x14c/0x450
> > > > > [   41.576624]  kthread+0x10c/0x110
> > > > > [   41.579847]  ret_from_fork+0x10/0x20
> > > > > [   41.583428] ---[ end trace 0000000000000000 ]---
> > > > > 
> > > > > 
> > > > > > > 
> > > > > > > > Do I understand correctly that the swiotlb will be used in case DMA
> > > > > > > > engine could not map the page in the specified range (limited by dma-ranges or
> > > > > > > > dma-mask) ?
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > > > > > > > > +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > > > > > > > > > +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > >   	return xenon_phy_parse_params(dev, host);
> > > > > > > > > >   }
> > > > > > > > > > @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> > > > > > > > > >   	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> > > > > > > > > >   	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> > > > > > > > > >   	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> > > > > > > > > > +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
> > > > > > > > > >   	{}
> > > > > > > > > >   };
> > > > > > > > > >   MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > -- 
> > > > > > > > > Florian
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > 
> > > > > > > Regards,
> > > > > > 
> > > > > 
> > > > > Thanks,
> > > > > Vadym Kochan
> > > > 
> > 
