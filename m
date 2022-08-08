Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17558C855
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiHHM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiHHM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:27:02 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00130.outbound.protection.outlook.com [40.107.0.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2B7649;
        Mon,  8 Aug 2022 05:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXCvKkGNifDkx7ynjqhEBTJEErLKoVN9kAt3PYzRMZ37jBavW2wfU6c+QnLb9EITMWKEljLG1Wrmq3clzjPyNbpAbFeTiiixwbep71pfTJR49EFzHJSN3NcOjm+PfpgJLweHj+tVN58geqTO+W6EE4WckOrpLvaIcnMuMiLtLLSwcGDunCDCcMH3wPb2XSR8h8PYjGu9+incOyJoX64yrQ61pLxrZyF5/59n/1hh/jEMs9J/TGKbCRr9wJiTPOKgw3pRLI7kS95Tv052mxS4goXvMV+LkYkhotgfzxSKcS7T1QydUiLnkzy2A6rX4ok09cbI8aHXdDnfuTuGjpAdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FItosUqbmHv2KuqIKvPM5qqX/x0/tGzSxJy5J7tmQFg=;
 b=HdReHuVAdBLjBdn+sVVL/Omah49ukuIMbeXksbQlHjnJSV94jeEoDy0KKw02Sic2ER888Z4J6M7DxGDoOCrm31Mj4GFU1vSznp9IR+ldZJXoW8rMuMF67T6fVK1ZHqSqWbR208JTLpKjbzBmovXO1mdl2JGKCaRhzu4wJUEpgVZnRyCpTJTLV5+T6Zfvp61Y+c344HpDV3K4AIIeHB3NmpryhZ63GEbs7zD/bO2I6Vl/ZgH1ly4PfXm6N9pSUwczrQl2abJwIG32AZLv/XmWM72LB3Xbx4nt3wnMVgbQMGnB/RA0fyx0L3cQATgKK84+1lD9oJpdQ2UNKMCgbSPSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FItosUqbmHv2KuqIKvPM5qqX/x0/tGzSxJy5J7tmQFg=;
 b=UerExFvgVVtpwWBkQChNZWECDxHm791VSeJi33MOLLc1PBtDtL4vlHuTAFAQRq4EO1eVlgHtxrND+uXQSqDYH1gNnPTz3o5IlJBxwdbnqFhwOciu5lfsZ7J+CAuXMO4HG4wPC9WJzTnG+0NoTHtC8E1yv0Qhpn4aEhP2of/ZRIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3e::13) by
 DB6P190MB0229.EURP190.PROD.OUTLOOK.COM (2603:10a6:4:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Mon, 8 Aug 2022 12:26:57 +0000
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::80ef:cc92:119c:1a0d]) by DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::80ef:cc92:119c:1a0d%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 12:26:56 +0000
Date:   Mon, 8 Aug 2022 15:26:52 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220808122652.GA6599@plvision.eu>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu>
 <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: GV3P280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::25) To DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:3e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0261e022-d40c-4f83-c7d8-08da793948a1
X-MS-TrafficTypeDiagnostic: DB6P190MB0229:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIpC7op0Mk+elhMUYlzmgmIO30pXUZFjK3ALa7j9+EYbQjCGWnGXC44Mf/tcVncxe7kaWXwsy1llqJFwgENOvKaQTC1PYa6M032km8e3LZqfcjEnrROvq+E8KDsbE4pUTCuX2cqZTZwlVOEbmqdMCZg0j1mw4RXDfW0MRU0ihFC0I7v7NajZ6dCdMhvG3MJRlxoDLzXb/+tIiO5rOehOyMk1Ys9QdJPYKRWc/OKelhHOUb9KoRy3l+SLr+Zs2PGRLZkNvv3lIc1/qBejZ0SSG+OoI2Ma/+3HnjeVTZwE90i7HWUf2VbWY0nc7Sv6j0PR/VCAPPsjYbk1rTt+w2ActTNK6fucNbbvWZQJ/drVm2299xOFVqluJf4P8HRpCy6LQtoQZqDWsrQV11beEUu7cgqGrVumZooJdfWuVUHXjxmkhaGGeo8fURRfYdedtRtrOQX/qIP+9RyJJhsJUlhEr77h+73muYUSLRhDOhywq8VfSYrwFr1agL9GibYjWA32OpRw2PM6HzNDnSzDnKFohrtzS8pqzgNFEvcKIKYsLojSRy46WJS8Z2+HWBumU8yEOCgDIFPU+HOab2RX43J7N9Q2BSYzqdjYz89JIHiEZ+LGMoj7MRFLB+YsRW2sn8U4Y2FBHRBzgGZ7SKy3vUyVD0hXdNNi7sdLlVwWGe2l6dbXcCbOicW0HUPQdEO04JplUu8qJrA+Os/caJ+pYGz7zVwy3Ntchsgid1Sgd53yjwAbYcyUW4m4lwmbMorAeZ5f86qeHACxdoybOpR17v+UMpPP4QDHuya31pbsWqdV8Pbs64js88Us5AyaPmn5AUjgKj7h6JlBhZM5V1yMATzrLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0310.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(34036004)(376002)(39830400003)(6666004)(52116002)(1076003)(83380400001)(186003)(44832011)(2906002)(33656002)(41320700001)(6486002)(41300700001)(508600001)(36756003)(30864003)(8936002)(6916009)(54906003)(5660300002)(86362001)(38100700002)(38350700002)(316002)(45080400002)(2616005)(6506007)(6512007)(26005)(53546011)(4326008)(8676002)(66946007)(66556008)(66476007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWhQ+Tu/A1I7vnJad0WDKrsz58700mfxtaCvMcXLoJXUHiz758uETSW93Iis?=
 =?us-ascii?Q?Xui12hrrbxmUvF/C1+ju04M1C29bEEuEq9j1gKMjtD4F/FVUcS6CrtzLP8q9?=
 =?us-ascii?Q?uYwMOLG40eHsopULIraOalVmZMfvPYJB3s5LuAYw0sEI4SXP8ycUzAhRDoXz?=
 =?us-ascii?Q?OjZk/0jOzey1thZHIbDYv1botlF+fWl8fLKwazvorhnFt7JJRQwYsRcGKATA?=
 =?us-ascii?Q?LNaQrdsUxoOCIhqlqNAQ+Ddg1HZ3sgAAQS7tdA3u1falKnb1N4SydvmiESxR?=
 =?us-ascii?Q?D6NUE58mkjhYXBuwqzUCJyyjCG+Fr71ASbVbbnVPQKweBb2oSfKk8zAcKyx6?=
 =?us-ascii?Q?p0uC6pXfwNMG66VTB0c736tsfppEaulf/uS1kRyqoLdqGUnzy6Z08VJ8UGIV?=
 =?us-ascii?Q?UBQekHYH1d/t1pwAT86vs8nLXatNjDgTirT8oTHKVxUsyHTCfzqo+sEi2TQ3?=
 =?us-ascii?Q?RwlLbvavg8NFcvzQIA2K89pkiuhPLfrwSMG8Vcz26hCkvOVFMk4NKUpd6Su6?=
 =?us-ascii?Q?zYl4cftyVKVDJ7Bcyae9oc35dC0mFd9oRlttXG0ipm5yVCsw/4BJmOGxgPmI?=
 =?us-ascii?Q?pjRuvJ9ivotMx8l+4qppCP3jKJeS34iR5BvY/H7ewUHkUlCnkBJQMm6211pk?=
 =?us-ascii?Q?NxDweaG66ZcJSGi+3Y5mkooUxqerHCKx7V7rQ9rZEAz84tmjUY5hZ99X7JiS?=
 =?us-ascii?Q?a9LqqeSMH5+J6uGrH1K67jbZGCq3X7eCbsYVBJHAfK048BMYmElztxMyBCTR?=
 =?us-ascii?Q?tC7uFGWzSL1897A+LYqHpO2g8nojAv9ORfF2LimywXFphYGiwTDgxIm7PeaR?=
 =?us-ascii?Q?5AEX870w2Q8Mtne1ftNkmOFmka5/fGQKJE9aanIXoa1D1ijfBfKYBNF4JpcR?=
 =?us-ascii?Q?N2TrAasKMMfumYpEiKZjWhvRrDfjXzvG/YZTwT5RrcgsWLB8/1pku0dSnw6k?=
 =?us-ascii?Q?8VmNA9k6utuaiQdAu08TTQyQrCs1xDNA7gejXj5UwfpkN7rC6KauZVeYAZQ+?=
 =?us-ascii?Q?qmuIQrU7mih1uFbQYwbthsw5J0Ir161l7//y31BDv84wxqIepxrO2IxNM7mf?=
 =?us-ascii?Q?sJieAmXWbk233vyo3CRtvF/D7Bd/Gx6DCYXUmvc+SeLa70BH1y8oand/y6eA?=
 =?us-ascii?Q?mivSG2LYd7B9Z06n1wXwM4yK3L1mrXQFmtj6hcptfAgbijCmyah/EplRkPcQ?=
 =?us-ascii?Q?Vv8qcF2zC3xzKLV0xIKdyGmjKiz+OVFnZMoYX2tONvtU+EnW8/VKWtE3f3dc?=
 =?us-ascii?Q?b8Q5GVUVAkthceIvoCV8oE+MGJGI9q7aIK+8JT7NhYgMzNBICzSFiapU8S4S?=
 =?us-ascii?Q?lwhM3FSo3Han+Cnx3R3D5sqsrttih/rkEZ8wUWjImUymZICe3mzLApN8/JAc?=
 =?us-ascii?Q?myaChBrA/TOkIdT5us5P3LR4jx+TCPof9kzcyt/mfhpIwqvLiaX5TogwQkUA?=
 =?us-ascii?Q?GjKgIHeksQEUX+31krRRvto8tNp1ZXzE1tNylxQBdOMq686EE6kg+LD5eFQM?=
 =?us-ascii?Q?2GHqLWo24TCSkNVxUJJU+j2ITM7ow7+TpUS9zkbniof4pzxpeweIBl3xeoQG?=
 =?us-ascii?Q?aXe1J/GrC1sCjgfaKvyfU++tcbO/MeTFL77DmCjn6bCJCEOcqYJplgv4HyWT?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0261e022-d40c-4f83-c7d8-08da793948a1
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 12:26:56.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DunXpW0tuuAZMm6mMWqLkTdrkD4A1igDK8qCr60DeOUe6/SvxAqCxFmeB4t4caUeqAtWtSv6ElRsxC9LtjF1u3dJjNUYsLfN+GhXklQOSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0229
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 02:40:07PM +0300, Adrian Hunter wrote:
> On 8/08/22 12:52, Vadym Kochan wrote:
> > Hi Adrian,
> > 
> > On Mon, Aug 08, 2022 at 12:19:10PM +0300, Adrian Hunter wrote:
> >> On 1/08/22 12:30, Vadym Kochan wrote:
> >>> Hi Florian,
> >>>
> >>> On Wed, Jul 27, 2022 at 07:45:32PM +0300, Vadym Kochan wrote:
> >>>> Hi Florian,
> >>>>
> >>>> On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
> >>>>> On 7/26/22 10:07, Vadym Kochan wrote:
> >>>>>> From: Elad Nachman <enachman@marvell.com>
> >>>>>>
> >>>>>> There is a limitation on AC5 SoC that mmc controller
> >>>>>> can't have DMA access over 2G memory.
> >>>>>>
> >>>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
> >>>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>>>> ---
> >>>>>>  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
> >>>>>>  1 file changed, 13 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >>>>>> index 08e838400b52..666d06b58564 100644
> >>>>>> --- a/drivers/mmc/host/sdhci-xenon.c
> >>>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
> >>>>>> @@ -18,6 +18,7 @@
> >>>>>>  #include <linux/of.h>
> >>>>>>  #include <linux/pm.h>
> >>>>>>  #include <linux/pm_runtime.h>
> >>>>>> +#include <linux/mm.h>
> >>>>>>  
> >>>>>>  #include "sdhci-pltfm.h"
> >>>>>>  #include "sdhci-xenon.h"
> >>>>>> @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
> >>>>>>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>>>>>  	u32 sdhc_id, nr_sdhc;
> >>>>>>  	u32 tuning_count;
> >>>>>> +	struct device_node *np = pdev->dev.of_node;
> >>>>>> +	struct sysinfo si;
> >>>>>>  
> >>>>>>  	/* Disable HS200 on Armada AP806 */
> >>>>>>  	if (priv->hw_version == XENON_AP806)
> >>>>>> @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
> >>>>>>  	}
> >>>>>>  	priv->tuning_count = tuning_count;
> >>>>>>  
> >>>>>> +	si_meminfo(&si);
> >>>>>> +
> >>>>>> +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> >>>>>> +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
> >>>>>
> >>>>> Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
> >>>>>
> >>>>> Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
> >>>>>
> >>>>>
> >>>>
> >>>
> >>> I could use DMA only in 2 ways:
> >>>
> >>> #1 Use sdhci bounce buffer with SDMA mode
> >>>
> >>>     But there was the issue that SDMA requires that SDHCI v4 mode should
> >>>     be enabled, and when I enable it via sdhci_enable_v4_mode(host)
> >>>     then I got error that EXT_CSD can't be recognized.
> >>>
> >>>     But if I comment this line in sdhci.c:
> >>>     
> >>>     int sdhci_setup_host(struct sdhci_host *host)
> >>>     {
> >>>         ...
> >>>
> >>> 	/* SDMA does not support 64-bit DMA if v4 mode not set */
> >>> 	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
> >>> 		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
> >>> 		host->flags &= ~SDHCI_USE_SDMA;
> >>> 	}
> >>>
> >>>        ...
> >>>     }
> >>>
> >>>     then everything is OK.
> >>>
> >>> #2 Use restricted-dma-pool in device-tree
> >>>
> >>>    But I am not sure if it is good solution compared to #1.
> >>>
> >>> Setting only DMA mask did not help because after some time I got
> >>> "DMA overflow address" error stack-traces.
> >>
> >> AFAICT using a DMA mask is the correct way to solve this.  If that
> >> reveals another issue then that must be resolved also. Can you show
> >> the stack traces and what kernel they are from?
> >>
> > 
> > The Linux version is next-20220808
> > 
> > Here is a stacktrace:
> > 
> > [   40.537028] ------------[ cut here ]------------
> > [   40.541698] xenon-sdhci 805c0000.sdhci: DMA addr
> > 0x00000002ff700000+40960 overflow (mask 27fffffff, bus limit 0).
> > [   40.551968] WARNING: CPU: 0 PID: 7 at kernel/dma/direct.h:103
> > dma_direct_map_sg+0x28c/0x2b0
> 
> Do you have CONFIG_SWIOTLB=y?
> 

Yes. Additionally I pass "swiotlb=force", because as I understand it is
not enabled by default at least on arm64.

> Is DMA mask correct? 2G mask would be 7fffffff not 27fffffff right?
> 

The RAM starts at 0x2_00000000 so thats why I use this mask.

Event if to use forced swiotlb via command-line then swiotlb complains
about the mask (from what I checked is that because swiotlb will be
allocated at the top of the DMA memory, which is actually the end of
RAM. Ofcourse if to manually hard-code arm64_dma_phys_limit in
arch/arm64/mm/init.c then everything works ok and I see that swiotlb
does the job if to check via debugfs):

[    1.129987] ------------[ cut here ]------------
[    1.134595] xenon-sdhci 805c0000.sdhci: swiotlb addr 0x00000002f7000000+512 overflow (mask 27fffffff, bus limit 0).
[    1.142086] usb 1-1: new high-speed USB device number 2 using orion-ehci
[    1.145025] WARNING: CPU: 0 PID: 24 at kernel/dma/swiotlb.c:880 swiotlb_map+0x1b4/0x1f0
[    1.159679] Modules linked in:
[    1.162733] CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted
5.19.0-next-20220808 #46
[    1.170202] Hardware name: Marvell A0-AC5X Board (DT)
[    1.175243] Workqueue: events_freezable mmc_rescan
[    1.180033] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[    1.186982] pc : swiotlb_map+0x1b4/0x1f0
[    1.190898] lr : swiotlb_map+0x1b4/0x1f0
[    1.194813] sp : ffff80000a8eb840
[    1.198119] x29: ffff80000a8eb840 x28: ffff80000a8ebb38 x27:
0000000000000000
[    1.205245] x26: 0000000000000000 x25: ffff0000004de810 x24:
0000000000000000
[    1.212369] x23: 0000000000000002 x22: 0000000000000002 x21:
0000000000000000
[    1.219494] x20: 0000000000000200 x19: ffff0000004de810 x18:
ffffffffffffffff
[    1.226619] x17: 203231352b303030 x16: 3030303766323030 x15:
3030303030783020
[    1.233744] x14: 7264646120626c74 x13: 2e29302074696d69 x12:
6c20737562202c66
[    1.240869] x11: 6666666666663732 x10: 206b73616d282077 x9 :
6f697773203a6963
[    1.247994] x8 : 6864732e30303030 x7 : 205d353935343331 x6 :
ffff80000a665000
[    1.255118] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
00000000ffffffff
[    1.262243] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff0000005a0000
[    1.269369] Call trace:
[    1.271810]  swiotlb_map+0x1b4/0x1f0
[    1.275380]  dma_direct_map_sg+0x94/0x2b0
[    1.279382]  __dma_map_sg_attrs+0x28/0xa0
[    1.283388]  dma_map_sg_attrs+0x10/0x30
[    1.287219]  sdhci_pre_dma_transfer+0xcc/0x150
[    1.291658]  sdhci_send_command+0x644/0xea0
[    1.295834]  sdhci_send_command_retry+0x40/0x140
[    1.300443]  sdhci_request+0x70/0xd0
[    1.304012]  __mmc_start_request+0x68/0x140
[    1.308188]  mmc_start_request+0x78/0xa0
[    1.312103]  mmc_wait_for_req+0x70/0x100
[    1.316020]  mmc_send_adtc_data+0xd8/0x130
[    1.320109]  mmc_get_ext_csd+0x70/0xe0
[    1.323850]  mmc_init_card+0x7e8/0x1ad0
[    1.327680]  mmc_attach_mmc+0xdc/0x180
[    1.331422]  mmc_rescan+0x280/0x2f0
[    1.334905]  process_one_work+0x1d0/0x320
[    1.338912]  worker_thread+0x14c/0x450
[    1.342655]  kthread+0x10c/0x110
[    1.345879]  ret_from_fork+0x10/0x20
[    1.349450] ---[ end trace 0000000000000000 ]---
[    1.354091] ------------[ cut here ]------------


> > [   40.560321] Modules linked in: uio_pdrv_genirq
> > [   40.564766] CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted
> > 5.19.0-next-20220808 #20
> > [   40.572236] Hardware name: Marvell A0-AC5X Board (DT)
> > [   40.577278] Workqueue: kblockd blk_mq_run_work_fn
> > [   40.581980] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   40.588929] pc : dma_direct_map_sg+0x28c/0x2b0
> > [   40.593366] lr : dma_direct_map_sg+0x28c/0x2b0
> > [   40.597801] sp : ffff80000a6eba20
> > [   40.601107] x29: ffff80000a6eba20 x28: ffff000006d66080 x27:
> > 0000000000000004
> > [   40.608233] x26: 0000000000000000 x25: ffff0000004de810 x24:
> > 0000000000000000
> > [   40.615358] x23: 0000000000000002 x22: fffffc0000000000 x21:
> > ffff800009153360
> > [   40.622484] x20: 0000000000000005 x19: 00000002ff700000 x18:
> > ffffffffffffffff
> > [   40.629609] x17: 766f203036393034 x16: 2b30303030303766 x15:
> > 6632303030303030
> > [   40.636735] x14: 3078302072646461 x13: ffff80000a433d58 x12:
> > 00000000000002dc
> > [   40.643860] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
> > ffff80000a48bd58
> > [   40.650985] x8 : ffff80000a433d58 x7 : ffff80000a48bd58 x6 :
> > 0000000000000000
> > [   40.658110] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
> > 0000000000000000
> > [   40.665234] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > ffff0000004add00
> > [   40.672360] Call trace:
> > [   40.674800]  dma_direct_map_sg+0x28c/0x2b0
> > [   40.678890]  __dma_map_sg_attrs+0x28/0xa0
> > [   40.682895]  dma_map_sg_attrs+0x10/0x30
> > [   40.686725]  sdhci_pre_dma_transfer+0xcc/0x150
> > [   40.691165]  sdhci_pre_req+0x3c/0x50
> > [   40.694734]  mmc_blk_mq_issue_rq+0x25c/0x9d0
> > [   40.698997]  mmc_mq_queue_rq+0x118/0x2b0
> > [   40.702912]  blk_mq_dispatch_rq_list+0x19c/0x800
> > [   40.707521]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > [   40.712218]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > [   40.717608]  blk_mq_sched_dispatch_requests+0x40/0x80
> > [   40.722651]  __blk_mq_run_hw_queue+0x80/0xc0
> > [   40.726911]  blk_mq_run_work_fn+0x24/0x30
> > [   40.730913]  process_one_work+0x1d0/0x320
> > [   40.734919]  worker_thread+0x14c/0x450
> > [   40.738662]  kthread+0x10c/0x110
> > [   40.741885]  ret_from_fork+0x10/0x20
> > [   40.745457] ---[ end trace 0000000000000000 ]---
> > [   40.750160] ------------[ cut here ]------------
> > [   40.754770] WARNING: CPU: 0 PID: 7 at drivers/mmc/host/sdhci.c:1152
> > sdhci_send_command+0x7fc/0xea0
> > [   40.763719] Modules linked in: uio_pdrv_genirq
> > [   40.768149] CPU: 0 PID: 7 Comm: kworker/0:0H Tainted: G        W
> > 5.19.0-next-20220808 #20
> > [   40.777090] Hardware name: Marvell A0-AC5X Board (DT)
> > [   40.782129] Workqueue: kblockd blk_mq_run_work_fn
> > [   40.786827] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   40.793775] pc : sdhci_send_command+0x7fc/0xea0
> > [   40.798297] lr : sdhci_send_command+0x644/0xea0
> > [   40.802821] sp : ffff80000a6eb980
> > [   40.806127] x29: ffff80000a6eb980 x28: ffff80000a6ebcf8 x27:
> > 0000000000000002
> > [   40.813253] x26: 0000000000000000 x25: 0000000000000000 x24:
> > ffff0000004237c0
> > [   40.820378] x23: 000000000000000b x22: ffff000006d825b8 x21:
> > ffff000006d82628
> > [   40.827502] x20: ffff000006d825b8 x19: ffff000000423580 x18:
> > ffffffffffffffff
> > [   40.834627] x17: 766f203036393034 x16: 2b30303030303766 x15:
> > 6632303030303030
> > [   40.841751] x14: 3078302072646461 x13: ffff80000a433d58 x12:
> > 00000000000002dc
> > [   40.848876] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
> > ffff80000a48bd58
> > [   40.856001] x8 : ffff80000a433d58 x7 : 0000000000000000 x6 :
> > ffff0000004deaf8
> > [   40.863125] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > 0000000000000000
> > [   40.870250] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > 00000000ffffffe4
> > [   40.877374] Call trace:
> > [   40.879813]  sdhci_send_command+0x7fc/0xea0
> > [   40.883989]  sdhci_send_command_retry+0x40/0x140
> > [   40.888597]  sdhci_request+0x70/0xd0
> > [   40.892167]  __mmc_start_request+0x68/0x140
> > [   40.896345]  mmc_start_request+0x78/0xa0
> > [   40.900260]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > [   40.904521]  mmc_mq_queue_rq+0x118/0x2b0
> > [   40.908436]  blk_mq_dispatch_rq_list+0x19c/0x800
> > [   40.913045]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > [   40.917741]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > [   40.923131]  blk_mq_sched_dispatch_requests+0x40/0x80
> > [   40.928173]  __blk_mq_run_hw_queue+0x80/0xc0
> > [   40.932435]  blk_mq_run_work_fn+0x24/0x30
> > [   40.936437]  process_one_work+0x1d0/0x320
> > [   40.940442]  worker_thread+0x14c/0x450
> > [   40.944184]  kthread+0x10c/0x110
> > [   40.947407]  ret_from_fork+0x10/0x20
> > [   40.950977] ---[ end trace 0000000000000000 ]---
> > [   40.960738] ------------[ cut here ]------------
> > [   40.965361] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > sdhci_send_command+0x7fc/0xea0
> > [   40.974403] Modules linked in: uio_pdrv_genirq
> > [   40.978843] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > 5.19.0-next-20220808 #20
> > [   40.987873] Hardware name: Marvell A0-AC5X Board (DT)
> > [   40.992913] Workqueue: kblockd blk_mq_run_work_fn
> > [   40.997613] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   41.004562] pc : sdhci_send_command+0x7fc/0xea0
> > [   41.009086] lr : sdhci_send_command+0x644/0xea0
> > [   41.013610] sp : ffff80000a9db980
> > [   41.016915] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > 0000000000000002
> > [   41.024041] x26: 0000000000000000 x25: 0000000000000000 x24:
> > ffff0000004237c0
> > [   41.031166] x23: 000000000000000b x22: ffff000006d05eb8 x21:
> > ffff000006d05f28
> > [   41.038291] x20: ffff000006d05eb8 x19: ffff000000423580 x18:
> > fffffc0003fde640
> > [   41.045416] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > [   41.052540] x14: 0000000000000002 x13: 0000000000100000 x12:
> > 0000000000000000
> > [   41.059664] x11: 0000000000000000 x10: 0000000000000b10 x9 :
> > ffff80000a9db9e0
> > [   41.066789] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > ffff0000004deaf8
> > [   41.073914] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > 0000000000000000
> > [   41.081039] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > 00000000ffffffe4
> > [   41.088164] Call trace:
> > [   41.090603]  sdhci_send_command+0x7fc/0xea0
> > [   41.094779]  sdhci_send_command_retry+0x40/0x140
> > [   41.099379]  sdhci_request+0x70/0xd0
> > [   41.102949]  __mmc_start_request+0x68/0x140
> > [   41.107127]  mmc_start_request+0x78/0xa0
> > [   41.111042]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > [   41.115305]  mmc_mq_queue_rq+0x118/0x2b0
> > [   41.119221]  blk_mq_dispatch_rq_list+0x19c/0x800
> > [   41.123831]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > [   41.128528]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > [   41.133917]  blk_mq_sched_dispatch_requests+0x40/0x80
> > [   41.138959]  __blk_mq_run_hw_queue+0x80/0xc0
> > [   41.143222]  blk_mq_run_work_fn+0x24/0x30
> > [   41.147223]  process_one_work+0x1d0/0x320
> > [   41.151230]  worker_thread+0x14c/0x450
> > [   41.154973]  kthread+0x10c/0x110
> > [   41.158195]  ret_from_fork+0x10/0x20
> > [   41.161766] ---[ end trace 0000000000000000 ]---
> > [   41.171543] ------------[ cut here ]------------
> > [   41.176169] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > sdhci_send_command+0x7fc/0xea0
> > [   41.185210] Modules linked in: uio_pdrv_genirq
> > [   41.189650] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > 5.19.0-next-20220808 #20
> > [   41.198679] Hardware name: Marvell A0-AC5X Board (DT)
> > [   41.203720] Workqueue: kblockd blk_mq_run_work_fn
> > [   41.208420] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   41.215369] pc : sdhci_send_command+0x7fc/0xea0
> > [   41.219892] lr : sdhci_send_command+0x644/0xea0
> > [   41.224414] sp : ffff80000a9db980
> > [   41.227721] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > 0000000000000002
> > [   41.234846] x26: 0000000000000000 x25: 0000000000000000 x24:
> > ffff0000004237c0
> > [   41.241972] x23: 000000000000000b x22: ffff000006d001b8 x21:
> > ffff000006d00228
> > [   41.249097] x20: ffff000006d001b8 x19: ffff000000423580 x18:
> > 0000000000000000
> > [   41.256223] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > [   41.263348] x14: 0000000000000002 x13: 0000000000100000 x12:
> > 0000000000000000
> > [   41.270473] x11: 0000000000000001 x10: 0000000000000b10 x9 :
> > ffff80000a9db9e0
> > [   41.277598] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > ffff0000004deaf8
> > [   41.284722] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > 0000000000000000
> > [   41.291846] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > 00000000ffffffe4
> > [   41.298971] Call trace:
> > [   41.301410]  sdhci_send_command+0x7fc/0xea0
> > [   41.305588]  sdhci_send_command_retry+0x40/0x140
> > [   41.310198]  sdhci_request+0x70/0xd0
> > [   41.313769]  __mmc_start_request+0x68/0x140
> > [   41.317946]  mmc_start_request+0x78/0xa0
> > [   41.321862]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > [   41.326125]  mmc_mq_queue_rq+0x118/0x2b0
> > [   41.330040]  blk_mq_dispatch_rq_list+0x19c/0x800
> > [   41.334649]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > [   41.339346]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > [   41.344735]  blk_mq_sched_dispatch_requests+0x40/0x80
> > [   41.349779]  __blk_mq_run_hw_queue+0x80/0xc0
> > [   41.354040]  blk_mq_run_work_fn+0x24/0x30
> > [   41.358041]  process_one_work+0x1d0/0x320
> > [   41.362048]  worker_thread+0x14c/0x450
> > [   41.365791]  kthread+0x10c/0x110
> > [   41.369014]  ret_from_fork+0x10/0x20
> > [   41.372584] ---[ end trace 0000000000000000 ]---
> > [   41.382383] ------------[ cut here ]------------
> > [   41.387009] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
> > sdhci_send_command+0x7fc/0xea0
> > [   41.396051] Modules linked in: uio_pdrv_genirq
> > [   41.400491] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
> > 5.19.0-next-20220808 #20
> > [   41.409520] Hardware name: Marvell A0-AC5X Board (DT)
> > [   41.414561] Workqueue: kblockd blk_mq_run_work_fn
> > [   41.419261] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   41.426210] pc : sdhci_send_command+0x7fc/0xea0
> > [   41.430734] lr : sdhci_send_command+0x644/0xea0
> > [   41.435256] sp : ffff80000a9db980
> > [   41.438562] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
> > 0000000000000002
> > [   41.445687] x26: 0000000000000000 x25: 0000000000000000 x24:
> > ffff0000004237c0
> > [   41.452812] x23: 000000000000000b x22: ffff000006d004b8 x21:
> > ffff000006d00528
> > [   41.459937] x20: ffff000006d004b8 x19: ffff000000423580 x18:
> > 0000000000000000
> > [   41.467062] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > [   41.474187] x14: 0000000000000002 x13: 00000000000ff000 x12:
> > 0000000000000000
> > [   41.481311] x11: 0000000000000001 x10: 0000000000000b10 x9 :
> > ffff80000a9db9e0
> > [   41.488436] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
> > ffff0000004deaf8
> > [   41.495561] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
> > 0000000000000000
> > [   41.502685] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
> > 00000000ffffffe4
> > [   41.509811] Call trace:
> > [   41.512250]  sdhci_send_command+0x7fc/0xea0
> > [   41.516427]  sdhci_send_command_retry+0x40/0x140
> > [   41.521035]  sdhci_request+0x70/0xd0
> > [   41.524607]  __mmc_start_request+0x68/0x140
> > [   41.528784]  mmc_start_request+0x78/0xa0
> > [   41.532699]  mmc_blk_mq_issue_rq+0x284/0x9d0
> > [   41.536961]  mmc_mq_queue_rq+0x118/0x2b0
> > [   41.540876]  blk_mq_dispatch_rq_list+0x19c/0x800
> > [   41.545485]  blk_mq_do_dispatch_sched+0x2bc/0x350
> > [   41.550182]  __blk_mq_sched_dispatch_requests+0x10c/0x160
> > [   41.555570]  blk_mq_sched_dispatch_requests+0x40/0x80
> > [   41.560613]  __blk_mq_run_hw_queue+0x80/0xc0
> > [   41.564874]  blk_mq_run_work_fn+0x24/0x30
> > [   41.568875]  process_one_work+0x1d0/0x320
> > [   41.572881]  worker_thread+0x14c/0x450
> > [   41.576624]  kthread+0x10c/0x110
> > [   41.579847]  ret_from_fork+0x10/0x20
> > [   41.583428] ---[ end trace 0000000000000000 ]---
> > 
> > 
> >>>
> >>>> Do I understand correctly that the swiotlb will be used in case DMA
> >>>> engine could not map the page in the specified range (limited by dma-ranges or
> >>>> dma-mask) ?
> >>>>
> >>>>>
> >>>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> >>>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> >>>>>> +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> >>>>>> +	}
> >>>>>> +
> >>>>>>  	return xenon_phy_parse_params(dev, host);
> >>>>>>  }
> >>>>>>  
> >>>>>> @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >>>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >>>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >>>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> >>>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
> >>>>>>  	{}
> >>>>>>  };
> >>>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >>>>>
> >>>>>
> >>>>> -- 
> >>>>> Florian
> >>>>
> >>>> Thanks,
> >>>>
> >>>
> >>> Regards,
> >>
> > 
> > Thanks,
> > Vadym Kochan
> 
