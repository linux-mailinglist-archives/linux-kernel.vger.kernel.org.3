Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E016A5982EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiHRMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiHRMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:07:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2093.outbound.protection.outlook.com [40.107.20.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E2B14ED;
        Thu, 18 Aug 2022 05:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fub6nNFApwEXhwcwnxIDI+lRsChnhjCuAYnVER35R5YP8WyJ2Fn9HEfc9J4STDFxfyhtAVBZ5e5VTSfuq71SNrLJR1rJbTPQWb+tvV7CehTS35azc+Po0U0gVobobfwgwBSeaqxSPAAjhrV3T0/aiaKDq8//6KtuEqpGhU9wWlS4TN0KPIs3tVKl798m5Aj11cNfBwCIlCqt7sc83SVGngjwPSjEnHxBY65ZuBijXo9Zmm1RhyMn0QyvkE5y7/ShnQAt68KQh97+YaHJ5iyUYVK2mtdxy/qVo4voenJOC9qPmn5mrmHAl20DhkIehlw0uADkLPNK35MRJJck0+YpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzi7QnIxwk0mhcCnQ0IJEFiEnmEWVqiZaBkvqR8aico=;
 b=PAy4ASvu4r/9Lj/bgZMQfiHNMn+w/DNVvbjneoPYSPmNrzdZpHsmC1pTni7x0H7lMAXSkYZQC7caAHv5EFSSR/hwqJqNn9iobXD8d5iLwPx+5GSXOsD3v4JtnSM116CWjEpEqW8qdJm1VQL7Bir0bSbJwaglwitteKCrBulPKWOJkgHRSB87i8951AlpUsUp12MG1gfXU8pHLsZXCCv8u8JUg1W/w4Xoz+QntKaXtsQ37suVW1EG/dYTtxYa08qlfGzdsJqiSipkcekbWserJRNdnLPP6gHvgta8PqbOakvIM72PkcH1TUvtQqdDhuPOFR1hP6RHgnvnHBEIvplqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzi7QnIxwk0mhcCnQ0IJEFiEnmEWVqiZaBkvqR8aico=;
 b=Ac42u50u7q5pXNBsbBlwpIO+kmoTZSTnYSTamnDlJkPmEqwhL0w0gM3mUjwBOAT+6rRfh8fmr4Q+2T9ja/sg3nYsJWmGkqdiAi6y0P33UK3CEzVwxpQP23Jn18XJ+kGfKMi9qsb/bKxJQWh68JbEpZ1A1ojqJcMBVv40sVdArIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS8P190MB1592.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 12:07:43 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc%5]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 12:07:43 +0000
Date:   Thu, 18 Aug 2022 15:07:40 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220818120740.GA21548@plvision.eu>
References: <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 555fbf34-957c-4a1e-d201-08da8112416b
X-MS-TrafficTypeDiagnostic: AS8P190MB1592:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOQPWUaU+x6ts82J0P07rEHFK6MHlBGeECgWsWs3cb7U035l8hhlJw2d7jACSmivTEEf78MZg7UKxWZid4GRSHfM5fH15BAbs3gmgCdN6ge6rbNPVOaPQZpB3b5pepZFkbjuZec14gitHNu2lHXnPXZL0bDdWrsSW7LD1JtsqOhfi3xfuzw79xJsTXQ0054GQHGF2LS/WWHCEirqrsjfzKIVXmW1LD3esB+qkGHqWJedusZANx7eOlKhPNOcYpMV6rICYASp14kol+7kQUCsVgi9Z/0JGlbzoepDbeKdeoUOmzj29T2JZIFI3DsPJ7fbpJaXA1FDHmGGpLuYtcDQAaDds+CuJdzgb39i1sIfx1+qv5hOPZwAVqjLCEwzD1kMSMzIWiRTFsQ8K66T/CvL8NJ+Zna2iP86whSi2vNx8X3UWlmfcaAX0F4XWiovgyIiTp7HENqzgQTNJI0nTEt3VdgOV3mtfH4f5nQMhpeYOaZwyGqmq8Wq1SGIcQD/55GssWdVPVnZtNyBNJnVSEZaCfN7YodJ8sX9qbWQwCfKO4izVZ87jFdB91WdsY03Ox8Zcx6bfUp8+jo1TY9CJFmd9xMsUmh6rYaZ4AY4CYYVshcCGtmi+nxHtCq2FVJQ1U3C/p/pPe0kjp5qSzzzsDoL7CqCzWmifIse1vFAKubYpZHkzSmPtdXPS8xXRuNsJALcyA6jhIoynGLzj3Btv+27VeIk8ZWiYpZLjd/JDDWyAxNZZZf5eZ4yrhk39gcyKKsO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(34036004)(376002)(366004)(396003)(39830400003)(41320700001)(38350700002)(38100700002)(316002)(66476007)(66946007)(36756003)(66556008)(4326008)(8676002)(33656002)(52116002)(53546011)(2906002)(186003)(26005)(44832011)(7416002)(6506007)(83380400001)(6512007)(41300700001)(86362001)(508600001)(54906003)(6916009)(2616005)(6486002)(5660300002)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zP49Vvmy7cdn1rEvLSgWLHp76jb3woOzWQC6fGusa97iC3rWK6EERi3g8+h?=
 =?us-ascii?Q?9yXzRMu+KEAEcsr/QVICaaFVJQGd4pEazytN6kg1pkXdzDVeJ3tJn9Y/3D14?=
 =?us-ascii?Q?+mOOHL7qZoIo8lYSvGZohF6E/4U+7shoZrZsBB9AB6CqIQljU9tdTuV3ROH7?=
 =?us-ascii?Q?+QbQ9v5qJ7WcKWIqhdr4o8IbdlM2FgKoHz01op9HMH0Ut5UqIzpffoHQ2AF8?=
 =?us-ascii?Q?4/0JNl4EQhZfpzFRtjTExZsbw/+nLo+Fq/RLvFVqnu9Ly3WAwvqjIMpO7ggg?=
 =?us-ascii?Q?P3aarJQEM7tLm8nlOS87ZZYV4St3kXG3qsmI0k6bcF0VqE0l6dUma27nikfC?=
 =?us-ascii?Q?KmawX2IssDZwCmsNpyhhrX5ZvjXEWqqBByEsqKDI0jnt6HiIuA3fd6QEiLrD?=
 =?us-ascii?Q?YPmBd/+AGPXO7MYBvf2TUSrmBlb1DE+Url70rPj0yu0Q5evVhSLZ0Z8XW3zu?=
 =?us-ascii?Q?w7JkcDUCp+880bhJnmrWDeM47d9c6nDkilYK+iUa9shxWmqarHTc1/V0vLRx?=
 =?us-ascii?Q?wktOZm1OOoRfgJ26cVOSCyrbuv4uxdB+PqlT8te8sSRnAQFooC2cZFg2mzdo?=
 =?us-ascii?Q?9mVhYYxG4ISNOkUZks14g0X+ZiqpBUifzp8mwRG5jqUXXh85xqeOnCdVlwnU?=
 =?us-ascii?Q?u00t918VjQRGFwJMpvPwCnQlOGO2y6KJPCsPkvcPf+rbYICk6dfcDJxe5JUC?=
 =?us-ascii?Q?8q/I617FO4yQXO83nJbbV0MEkfuluJOMz1MRH9x/r2WPHjLUXjh75OLcsOKo?=
 =?us-ascii?Q?/keWB6QdGR8SD0PUWcSow4UJjzRcuHoGgVJnrTm0Dc8xNWVJrT8eilxNa8nE?=
 =?us-ascii?Q?WF2HIRaNHGBJAFZ9XXpVUUnKcSdrnP3PPq6FhXm6G4lCNoYTarLuihOAx2Ik?=
 =?us-ascii?Q?InvSIrjwDa1CDsqcpelh7cswHWTN0UGCvTQypI8NTzZeNjspd1b5WatbVy3P?=
 =?us-ascii?Q?V2rdMKYGc26mtzifAOxXymyopwWQJhRfC4b3pHhihiH3OT3wH2I9w5ogqOe3?=
 =?us-ascii?Q?bSOPfLA7HWIEEZvtgX0FS4nqrkORRArGTXt4zJ53riEE7Y0ekewv495a7E3E?=
 =?us-ascii?Q?ZXGoZyfN18FOLVWGLMPzLeLguzZEkfC9qShuPxQU9ppNT0MzhS7TeKSXPYnE?=
 =?us-ascii?Q?q9wSSE71oyBAP1Ie/WbAd4tQMmjz6vWyL+yeBa+XlQ7++xkdldqEhm+vgWdf?=
 =?us-ascii?Q?/ulfh7lAb6gLAy9JYj9utMcubYl6pDWkPgwJcfhy9n5MkEJALTvcijxFZIUk?=
 =?us-ascii?Q?jI05LvOvhruwPeLfqYZQC7fc1irKQeySXy1GdDA5xOE0mp9azhMCQ8xHM1lm?=
 =?us-ascii?Q?Amfmu2btnUonpjIN2dA7Cv7sXm1Kx7Oboj5boERnLIKquk0Gk5W4lIAsnFAc?=
 =?us-ascii?Q?//e3QHp9bK7tM/kcNrEGV/7cQc6FuanH71oEAx8NXrVTQaFvhFgZb4hcwjNI?=
 =?us-ascii?Q?UMwD5+qO/UBVl89f5LnyMMKklRLRCPbDmGvRkpAb2cVDm4VilSC9oCAlzIff?=
 =?us-ascii?Q?YZVut8JzYDkIxtwDFpP/v/GgsRfnvD3gAnl7i/wICK+4D9PTu35dSjs698rF?=
 =?us-ascii?Q?NZ3G1zBSQKxPIo0dtsdxgVL9C3WOlOx5zelsk2UAqe+cgBHhyYh9ha79Guuy?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 555fbf34-957c-4a1e-d201-08da8112416b
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 12:07:43.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIWsZV3jjXiwyUTXAHiX2b/GQhMXpQDb/bFJ6qooUMl6X6U4LsbppqCv4TyZ921Iaa5WeQQHDSIAndiAl3RelwKuZOOQ7Dmp8lPkqGRjgVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Aug 17, 2022 at 06:23:02PM +0100, Robin Murphy wrote:
> On 2022-08-17 17:07, Vadym Kochan wrote:
> > Hi Robin, Adrian,
> > 
> > On Wed, Aug 17, 2022 at 02:43:46PM +0100, Robin Murphy wrote:
> > > On 2022-08-16 21:51, Vadym Kochan wrote:
> > > [...]
> > > > > The one thing to watch out for is that SWIOTLB doesn't necessarily interact
> > > > > very well with DMA offsets. Given the intent of
> > > > > of_dma_get_max_cpu_address(), I think it ought to work out OK now for
> > > > > current kernels on DT systems if everything is described correctly, but
> > > > > otherwise it's likely that you end up with ZONE_DMA either being empty or
> > > > > containing all memory, so the SWIOTLB buffer ends up being allocated
> > > > > anywhere such that it might not actually work as expected.
> > > > > 
> > > > > Robin.
> > > > 
> > > > Hi Robin,
> > > > 
> > > > Thank you for the reply.
> > > > 
> > > > My understanding is that swiotlb is allocated (in case of arm64)
> > > > in the following cases:
> > > > 
> > > >      #1 when it is forced from the kernel cmdline
> > > > 
> > > >      #2 when max_pfn is greater than arm64_dma_phys_limit (and this is used
> > > >         as the end from which to allocate the swiotlb pool in the
> > > >         top-botom direction via memblock API).
> > > > 
> > > >      #3 using restricted dma-pool
> > > > 
> > > > Of course option #3 works fine because swiotlb is kind of forced to use
> > > > particulary this range of memory.
> > > > 
> > > > Both options #1 & #2 causes to use full memory mask even if to specify
> > > > dma-ranges in the DT:
> > > > 
> > > >       dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> > > > 
> > > > or if to specify the opposite:
> > > > 
> > > >       dma-ranges = <0x2 0x0 0x0 0x0 0x0 0x80000000>;
> > > > 
> > > >       just to make it lower than U32 to pass
> > > > 
> > > >           zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits)
> > > > 
> > > >       condition, but then it will be re-set in max_zone_phys() by:
> > > > 
> > > > 	if (phys_start > U32_MAX)
> > > > 		zone_mask = PHYS_ADDR_MAX;
> > > > 	else if (phys_start > zone_mask)
> > > > 		zone_mask = U32_MAX;
> > > 
> > > Ah, indeed I missed that, sorry. It seems that that change to stop assuming
> > > an offset kind of crossed over with the introduction of
> > > *_dma_get_max_cpu_address(), but now that that firmware property parsing
> > > *is* implemented, in principle it should be equally possible to evaluate the
> > > actual offsets as well, and decide whether an offset ZONE_DMA is appropriate
> > > or not. Either way, this is definitely the area which needs work if we want
> > > to to able to support topologies like this properly.
> > > 
> > > > So, currently I dont see how to pin swiotlb (I see it as a main problem) to some specific range of physical
> > > > memory (particulary to the first 2G of RAM).
> > > 
> > > Indeed, if ZONE_DMA and/or ZONE_DMA32 can't be set appropriately, then
> > > there's no way to guarantee correct allocation of any DMA buffers, short of
> > > hacking it with explicitly placed reserved-memory carveouts.
> > > 
> > 
> > I have sent some time ago a solution which binds restricted-dma pool to
> > the eMMC device, so Adrian, Robin do you think this can be acceptable as
> > a temporary solution (at least conceptually) ?
> > 
> > I was also thinking would it be OK to introduce something like
> > bounced-dma pool (similar to the restricted one) which will reserve
> > memory for the bounced buffers only ? It should not be hard as looks
> > like it will re-use existing interface between dma and swiotlb ? In that
> > case it would allow to map first 2G of memory to eMMC controller.
> 
> TBH I'd prefer to fix it (or at least work around it) more generally.
> Putting made-up things in devicetree to work around shortcomings in
> kernel code tends to be a hole that's hard to dig yourself back out of.
> As a bodge that would be just about justifiable in its own terms, does
> the diff below help at all?
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b9af30be813e..88f7b26f49db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -451,7 +451,14 @@ void __init bootmem_init(void)
>   */
>  void __init mem_init(void)
>  {
> +	/*
> +	 * Some platforms still manage to elude our attempt to calculate
> +	 * ZONE_DMA appropriately, so encourage the SWIOTLB allocation to go
> +	 * as low as it can anyway for the best chance of being usable.
> +	 */
> +	memblock_set_bottom_up(true);
>  	swiotlb_init(max_pfn > PFN_DOWN(arm64_dma_phys_limit), SWIOTLB_VERBOSE);
> +	memblock_set_bottom_up(false);
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();

It works with the following changes:

    #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;

    #3 swiotlb="force"

Is it OK to force the memory allocation from the start for the swiotlb ?
Or may be do it by new CONFIG which will be enforced by the new
CONFIG for the device on that particular SoC ?

Thanks,
Vadym
