Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6E58C5EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbiHHJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiHHJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:52:46 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50108.outbound.protection.outlook.com [40.107.5.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9EBF42;
        Mon,  8 Aug 2022 02:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYDFSz8oTnxqGrj7J8/Dh1+gkxxiQh2B1UW4S4mu3vJsBU1FD8GHBAXjCC7FgAbSrO/3JeMFUWT1f5QPQc5EM+1sSkoizqDiJUXqR0Nz18PgkE4e6tVFhV5PjKjepm5AdXqSpD4EYqsnDykETNf6RBJ7C2lavEMkJ9XsNj0PUQ5PsL/s47GtrLfSdd0w64HkNLAJW5Oc+exzSCVwCPppiQ9r3GRbQYLriIkehb4cybUrmQT5IXib5Gm3TjXeEZiT1pG3K42YmLSvOUJFI5PXQ2UvTaE+fOGq+DxYVdQanxFW/dtBssCZ7v7g2wJPmIhwhFg1UYrZMTeZdFNvpYGnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyp0dqAprTqvpDx4cxkC5ZKn5px+CoCH0C/gyQrk8RI=;
 b=naWJeiqbFAebrX3BZzhBEwJceRqI328ORlUGA7ozpbOHniWrjvzkIP+fwN8zhuwp5v37n30HsheIxd3D8LHl/z4Q/ErUUSfRdK63YvaWztR3TLoF4UUB4y0PvKphQYUTdZ/4l7r3IOIoB2vrII/lbDfK4iJ6zCR7IhikbCPv7pC0qsdxTxTtqg+c7xah2wSMBfOXuNiPuBEgQNZN4GdgL8oi1+9XDliCNxuXwABjKsfKgXAW7AHnVi93W64fgVSC9t2QDyRExKMPbRqu/hdqeWiV9eg8nop7enu1VqrwSpFOKryuIwMDXI3vr6TTZV7Ib4E65yHUqiKBAY07mHVSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyp0dqAprTqvpDx4cxkC5ZKn5px+CoCH0C/gyQrk8RI=;
 b=rY44aEakpbp4JkaKgvCM66i5R+ySciucpga7sQpvRjmVkbR46nANSxh79AVqcTihmThPdF32+yEXvZrsVXoSahLBdw/d8jdz0tDKYp4EkqDj+sFtmvaWNr8WN98FlXZKTSYZJ7gE6j7VKZa3TnE+VK1MaQA3eeeFs+G4QEu1gEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3e::13) by
 VI1P190MB0781.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:128::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Mon, 8 Aug 2022 09:52:41 +0000
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::80ef:cc92:119c:1a0d]) by DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::80ef:cc92:119c:1a0d%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 09:52:40 +0000
Date:   Mon, 8 Aug 2022 12:52:37 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220808095237.GA15939@plvision.eu>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu>
 <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BE1P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::17) To DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:3e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22bd66ff-6812-4eac-ddb3-08da7923bb9b
X-MS-TrafficTypeDiagnostic: VI1P190MB0781:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrEv7tN+P7PHAdCgwtbHunc7lZFnCrtqDk2GFxZp2k4oR4RLyrAyY7fnS1mn8xB5ulbW/OBiYo5z/rHEYWK+UkcV4Ifhjkv8XQHFfYNIqaTzFgFla/18Sl0qKQ8t39JxCsgA8LjqM3FMN8rKnVwEUYs8+Oz4Ku7bCxiJ7jmXTkuSCPIpSI0IX3yP8hQTt78UJrUSvwknAYxkSkD0xk1ES5hod+qL6np/KLpFPDDEckd4sMI3WtZJR1CIVw9inD12aQQoYpHPgsmhVs2fbFlJXeDbAkTbnpFId4py60jX2xAab1ON0yQdFoEy/TgZNGcDUIdrq5MNKmcBdB1+JDpPFsBpJI0A37pq/KbhERGAqrts+Q/WCGMTe5HQ4ZEfa5VUSOL/CubFpEHfP0RDnZyNP+QmP4PMKliaVnBIwxLS1IvJoi6iN3MtpDuJeGYadhok0WVWkUwFSyUWzxDGOpBpnU44czOfzAq7a0Gc2/H0KTWJZLzGFcNk9zlEav0pFo5y+2rWZkNsA3eIAgcr4BHfaskq3nnX9LZe4W68gVAUMoLMp6GHSoeOfrITDJGJ5k9CSove9imxg46NvP8BgHZbsiSsGjzgmZJH3MFVtk3m7H7Cbxf9VdTE3ywRkR3OQYcz5IcPZ5AxjGlZ89pFjbc/EnMQwikH9sY2D36siQ25M5Y1C/e33jIIzGPxJRRWwBN7NACYP+Ec7j3Po/73tY4AyT8CpwqH0+KaYQrxpZOwU2kczwIs/XpmHlhXMLxPKMGE2YjNsUGNc3ATFvqFaRNF2kjo7hLAhhjMOKYqF+Dhj7AEpczhaYJConldefFd0r9d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0310.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(34036004)(376002)(39830400003)(346002)(396003)(366004)(6666004)(2906002)(41320700001)(6512007)(26005)(41300700001)(52116002)(53546011)(6506007)(83380400001)(38100700002)(38350700002)(2616005)(186003)(1076003)(44832011)(508600001)(33656002)(45080400002)(4326008)(36756003)(8676002)(66476007)(66556008)(8936002)(66946007)(6486002)(30864003)(6916009)(316002)(54906003)(5660300002)(86362001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLB/wSiV2kp3LgL62hzLQhK4itT0hDU+ASHkDCwbuuxoIxCgjQsE9h1Q55qH?=
 =?us-ascii?Q?6+9SxeS7Wg2h+HBdoNkGG+2a3y3ovOMSLsw7XSPmsLIU30wxJOqzSSo3Hfj5?=
 =?us-ascii?Q?ZMrmoFX+RMkSPQcYpTbX3SD2q/pTucpD40nDJLjcWU27IqDmedNXQDSpp4gx?=
 =?us-ascii?Q?GFKWU1vJUDv22kCbVr8B4du9hCGOQdOOweYuWsuErG1yA7MIcWB5oPDSDOaj?=
 =?us-ascii?Q?aUAC09RIRY+Fogr9D6BJgadGjstKyEH2EZxg332gwEEGQcDqXJ95nHyoEUMM?=
 =?us-ascii?Q?P+8qdnHzQDe/n4ivgYP87aSfXzkvvgLEev6OdE1MImTCsvsLCPEezZO+luy4?=
 =?us-ascii?Q?JvVQ3o2WeieQTWS+sjwDggv27qXIvGN/KyadFpwgsvJsD0hItUTjmJ5sXhKf?=
 =?us-ascii?Q?qJLEc5Pt7S5i2lc/mBuhWl0lF+M0C7Fv8Qqol5gced2mDUSCWjIpMzLjDfS4?=
 =?us-ascii?Q?EBvIMIrFAzBkuuhaRC64A2ePAoR5A1kk9s12z+SJBH7qeoiZ7psNzowSQaAZ?=
 =?us-ascii?Q?Lzt5KFQ45md+LhS/opeqWqOS1lGQdHrKTAzfZznTcFlzRLX31AIZQ5ZKqny4?=
 =?us-ascii?Q?dV+cgHaSTQbuJU2Ys9pDwj8Oh2C7OwP+CLRNWymmKbqZzevOyGHwziXn+ZDU?=
 =?us-ascii?Q?VCn+OaK3HF3IHD9rMZzGKwdl7aX3K80cICLlGg/FXZBfviUeYxxOa08cC7Dk?=
 =?us-ascii?Q?687Faq+G+9SxbQGLPHpoamMLGP69+BfE2IAYLimUbuLu+4EhrzMPzBHCC/NR?=
 =?us-ascii?Q?0oFiD0FYZke1Juc3h6rDM81Vkj2y5rPSWb9OrdBLfC+dcdSr08q6o3GWMa8S?=
 =?us-ascii?Q?JuI15Ga7jUQuQdwcHjZ2uLcWPD283IrRiw5AsUIXkeLHnrlgSFvSAC/iXph1?=
 =?us-ascii?Q?UkbioNQOl1IpqB/igUlkhC6yuf7VGylupVG4hv1yXlYJTQU+0BcT2aEuuzTC?=
 =?us-ascii?Q?GlD6HBWz8iv8tJKT36X/fGG7Y5cGIpZzJnzbQzgN4VWSU2HQaoZFpQubjSgp?=
 =?us-ascii?Q?SRkuutmF+vABQ2BBK2cL5HyBS+2UoHJwRty/Wxq/mPgnTAXI8sXEiULp8p/D?=
 =?us-ascii?Q?Mawsj0TBbjtdYl0cnyYrRyf5rR3Z2l6jHYM2pOOfpogi6XV7z2ztkVzpJpEw?=
 =?us-ascii?Q?e8UDURgkriUkH42rRtd+jF3bcavnttd90sSfKgHOBUB2z/lkIcj7F0qgmMxn?=
 =?us-ascii?Q?KL1EwqSMuPU7Vcq/O74hNneh4f0kznKBuuJfnvwHVGJyEfYJb7YYc37Jkygo?=
 =?us-ascii?Q?UDmACr36t/g6nRLFWv/C6UA9BmcLxCCM7L0a+W33gHlOnliGDzP+dmhcGR9H?=
 =?us-ascii?Q?bGluIU/BstIvU+qkJabaOOSnOEDGjhkwh8YTtsUaNqQcn6i3w91N3V71c04h?=
 =?us-ascii?Q?qEO0bBquvPswVv2Bb1KZLsFYpZR8XQpuQDpQqdDv0GvM3miHRCYFwCk2b7Cy?=
 =?us-ascii?Q?Ku4yyIE/cATWmK3v1m2bQL089X7hYYWAb6gvAmkrJy8HZPHbHemV9O5pZR+u?=
 =?us-ascii?Q?GjZWj2JVNmpJvPAWjyvKilI7wi2hlcqja83XT3G9LZ9oNWzuy3gY9JKuCbvl?=
 =?us-ascii?Q?6eDogWLZ5vlBRQxArKyYiwWhJ9QyGd0Q/fpUnFL9Kj6KOtij+ZWNHm+YOwrD?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bd66ff-6812-4eac-ddb3-08da7923bb9b
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 09:52:40.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d/0tghbVZmu9PZJOD+SUWy+zl4vOF2g0GRS/sYMODXN6GFeVQAaJJIx3h5bnvsssCS1Djyz64oMXnHm9/ftRKGGzPZW9lcEwYGQT9VcarQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Aug 08, 2022 at 12:19:10PM +0300, Adrian Hunter wrote:
> On 1/08/22 12:30, Vadym Kochan wrote:
> > Hi Florian,
> > 
> > On Wed, Jul 27, 2022 at 07:45:32PM +0300, Vadym Kochan wrote:
> >> Hi Florian,
> >>
> >> On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
> >>> On 7/26/22 10:07, Vadym Kochan wrote:
> >>>> From: Elad Nachman <enachman@marvell.com>
> >>>>
> >>>> There is a limitation on AC5 SoC that mmc controller
> >>>> can't have DMA access over 2G memory.
> >>>>
> >>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
> >>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >>>> index 08e838400b52..666d06b58564 100644
> >>>> --- a/drivers/mmc/host/sdhci-xenon.c
> >>>> +++ b/drivers/mmc/host/sdhci-xenon.c
> >>>> @@ -18,6 +18,7 @@
> >>>>  #include <linux/of.h>
> >>>>  #include <linux/pm.h>
> >>>>  #include <linux/pm_runtime.h>
> >>>> +#include <linux/mm.h>
> >>>>  
> >>>>  #include "sdhci-pltfm.h"
> >>>>  #include "sdhci-xenon.h"
> >>>> @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
> >>>>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>>>  	u32 sdhc_id, nr_sdhc;
> >>>>  	u32 tuning_count;
> >>>> +	struct device_node *np = pdev->dev.of_node;
> >>>> +	struct sysinfo si;
> >>>>  
> >>>>  	/* Disable HS200 on Armada AP806 */
> >>>>  	if (priv->hw_version == XENON_AP806)
> >>>> @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
> >>>>  	}
> >>>>  	priv->tuning_count = tuning_count;
> >>>>  
> >>>> +	si_meminfo(&si);
> >>>> +
> >>>> +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> >>>> +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
> >>>
> >>> Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
> >>>
> >>> Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
> >>>
> >>>
> >>
> > 
> > I could use DMA only in 2 ways:
> > 
> > #1 Use sdhci bounce buffer with SDMA mode
> > 
> >     But there was the issue that SDMA requires that SDHCI v4 mode should
> >     be enabled, and when I enable it via sdhci_enable_v4_mode(host)
> >     then I got error that EXT_CSD can't be recognized.
> > 
> >     But if I comment this line in sdhci.c:
> >     
> >     int sdhci_setup_host(struct sdhci_host *host)
> >     {
> >         ...
> > 
> > 	/* SDMA does not support 64-bit DMA if v4 mode not set */
> > 	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
> > 		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
> > 		host->flags &= ~SDHCI_USE_SDMA;
> > 	}
> > 
> >        ...
> >     }
> > 
> >     then everything is OK.
> > 
> > #2 Use restricted-dma-pool in device-tree
> > 
> >    But I am not sure if it is good solution compared to #1.
> > 
> > Setting only DMA mask did not help because after some time I got
> > "DMA overflow address" error stack-traces.
> 
> AFAICT using a DMA mask is the correct way to solve this.  If that
> reveals another issue then that must be resolved also. Can you show
> the stack traces and what kernel they are from?
> 

The Linux version is next-20220808

Here is a stacktrace:

[   40.537028] ------------[ cut here ]------------
[   40.541698] xenon-sdhci 805c0000.sdhci: DMA addr
0x00000002ff700000+40960 overflow (mask 27fffffff, bus limit 0).
[   40.551968] WARNING: CPU: 0 PID: 7 at kernel/dma/direct.h:103
dma_direct_map_sg+0x28c/0x2b0
[   40.560321] Modules linked in: uio_pdrv_genirq
[   40.564766] CPU: 0 PID: 7 Comm: kworker/0:0H Not tainted
5.19.0-next-20220808 #20
[   40.572236] Hardware name: Marvell A0-AC5X Board (DT)
[   40.577278] Workqueue: kblockd blk_mq_run_work_fn
[   40.581980] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   40.588929] pc : dma_direct_map_sg+0x28c/0x2b0
[   40.593366] lr : dma_direct_map_sg+0x28c/0x2b0
[   40.597801] sp : ffff80000a6eba20
[   40.601107] x29: ffff80000a6eba20 x28: ffff000006d66080 x27:
0000000000000004
[   40.608233] x26: 0000000000000000 x25: ffff0000004de810 x24:
0000000000000000
[   40.615358] x23: 0000000000000002 x22: fffffc0000000000 x21:
ffff800009153360
[   40.622484] x20: 0000000000000005 x19: 00000002ff700000 x18:
ffffffffffffffff
[   40.629609] x17: 766f203036393034 x16: 2b30303030303766 x15:
6632303030303030
[   40.636735] x14: 3078302072646461 x13: ffff80000a433d58 x12:
00000000000002dc
[   40.643860] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
ffff80000a48bd58
[   40.650985] x8 : ffff80000a433d58 x7 : ffff80000a48bd58 x6 :
0000000000000000
[   40.658110] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
0000000000000000
[   40.665234] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff0000004add00
[   40.672360] Call trace:
[   40.674800]  dma_direct_map_sg+0x28c/0x2b0
[   40.678890]  __dma_map_sg_attrs+0x28/0xa0
[   40.682895]  dma_map_sg_attrs+0x10/0x30
[   40.686725]  sdhci_pre_dma_transfer+0xcc/0x150
[   40.691165]  sdhci_pre_req+0x3c/0x50
[   40.694734]  mmc_blk_mq_issue_rq+0x25c/0x9d0
[   40.698997]  mmc_mq_queue_rq+0x118/0x2b0
[   40.702912]  blk_mq_dispatch_rq_list+0x19c/0x800
[   40.707521]  blk_mq_do_dispatch_sched+0x2bc/0x350
[   40.712218]  __blk_mq_sched_dispatch_requests+0x10c/0x160
[   40.717608]  blk_mq_sched_dispatch_requests+0x40/0x80
[   40.722651]  __blk_mq_run_hw_queue+0x80/0xc0
[   40.726911]  blk_mq_run_work_fn+0x24/0x30
[   40.730913]  process_one_work+0x1d0/0x320
[   40.734919]  worker_thread+0x14c/0x450
[   40.738662]  kthread+0x10c/0x110
[   40.741885]  ret_from_fork+0x10/0x20
[   40.745457] ---[ end trace 0000000000000000 ]---
[   40.750160] ------------[ cut here ]------------
[   40.754770] WARNING: CPU: 0 PID: 7 at drivers/mmc/host/sdhci.c:1152
sdhci_send_command+0x7fc/0xea0
[   40.763719] Modules linked in: uio_pdrv_genirq
[   40.768149] CPU: 0 PID: 7 Comm: kworker/0:0H Tainted: G        W
5.19.0-next-20220808 #20
[   40.777090] Hardware name: Marvell A0-AC5X Board (DT)
[   40.782129] Workqueue: kblockd blk_mq_run_work_fn
[   40.786827] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   40.793775] pc : sdhci_send_command+0x7fc/0xea0
[   40.798297] lr : sdhci_send_command+0x644/0xea0
[   40.802821] sp : ffff80000a6eb980
[   40.806127] x29: ffff80000a6eb980 x28: ffff80000a6ebcf8 x27:
0000000000000002
[   40.813253] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff0000004237c0
[   40.820378] x23: 000000000000000b x22: ffff000006d825b8 x21:
ffff000006d82628
[   40.827502] x20: ffff000006d825b8 x19: ffff000000423580 x18:
ffffffffffffffff
[   40.834627] x17: 766f203036393034 x16: 2b30303030303766 x15:
6632303030303030
[   40.841751] x14: 3078302072646461 x13: ffff80000a433d58 x12:
00000000000002dc
[   40.848876] x11: 00000000000000f4 x10: ffff80000a48bd58 x9 :
ffff80000a48bd58
[   40.856001] x8 : ffff80000a433d58 x7 : 0000000000000000 x6 :
ffff0000004deaf8
[   40.863125] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
0000000000000000
[   40.870250] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
00000000ffffffe4
[   40.877374] Call trace:
[   40.879813]  sdhci_send_command+0x7fc/0xea0
[   40.883989]  sdhci_send_command_retry+0x40/0x140
[   40.888597]  sdhci_request+0x70/0xd0
[   40.892167]  __mmc_start_request+0x68/0x140
[   40.896345]  mmc_start_request+0x78/0xa0
[   40.900260]  mmc_blk_mq_issue_rq+0x284/0x9d0
[   40.904521]  mmc_mq_queue_rq+0x118/0x2b0
[   40.908436]  blk_mq_dispatch_rq_list+0x19c/0x800
[   40.913045]  blk_mq_do_dispatch_sched+0x2bc/0x350
[   40.917741]  __blk_mq_sched_dispatch_requests+0x10c/0x160
[   40.923131]  blk_mq_sched_dispatch_requests+0x40/0x80
[   40.928173]  __blk_mq_run_hw_queue+0x80/0xc0
[   40.932435]  blk_mq_run_work_fn+0x24/0x30
[   40.936437]  process_one_work+0x1d0/0x320
[   40.940442]  worker_thread+0x14c/0x450
[   40.944184]  kthread+0x10c/0x110
[   40.947407]  ret_from_fork+0x10/0x20
[   40.950977] ---[ end trace 0000000000000000 ]---
[   40.960738] ------------[ cut here ]------------
[   40.965361] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
sdhci_send_command+0x7fc/0xea0
[   40.974403] Modules linked in: uio_pdrv_genirq
[   40.978843] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
5.19.0-next-20220808 #20
[   40.987873] Hardware name: Marvell A0-AC5X Board (DT)
[   40.992913] Workqueue: kblockd blk_mq_run_work_fn
[   40.997613] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   41.004562] pc : sdhci_send_command+0x7fc/0xea0
[   41.009086] lr : sdhci_send_command+0x644/0xea0
[   41.013610] sp : ffff80000a9db980
[   41.016915] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
0000000000000002
[   41.024041] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff0000004237c0
[   41.031166] x23: 000000000000000b x22: ffff000006d05eb8 x21:
ffff000006d05f28
[   41.038291] x20: ffff000006d05eb8 x19: ffff000000423580 x18:
fffffc0003fde640
[   41.045416] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
[   41.052540] x14: 0000000000000002 x13: 0000000000100000 x12:
0000000000000000
[   41.059664] x11: 0000000000000000 x10: 0000000000000b10 x9 :
ffff80000a9db9e0
[   41.066789] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
ffff0000004deaf8
[   41.073914] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
0000000000000000
[   41.081039] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
00000000ffffffe4
[   41.088164] Call trace:
[   41.090603]  sdhci_send_command+0x7fc/0xea0
[   41.094779]  sdhci_send_command_retry+0x40/0x140
[   41.099379]  sdhci_request+0x70/0xd0
[   41.102949]  __mmc_start_request+0x68/0x140
[   41.107127]  mmc_start_request+0x78/0xa0
[   41.111042]  mmc_blk_mq_issue_rq+0x284/0x9d0
[   41.115305]  mmc_mq_queue_rq+0x118/0x2b0
[   41.119221]  blk_mq_dispatch_rq_list+0x19c/0x800
[   41.123831]  blk_mq_do_dispatch_sched+0x2bc/0x350
[   41.128528]  __blk_mq_sched_dispatch_requests+0x10c/0x160
[   41.133917]  blk_mq_sched_dispatch_requests+0x40/0x80
[   41.138959]  __blk_mq_run_hw_queue+0x80/0xc0
[   41.143222]  blk_mq_run_work_fn+0x24/0x30
[   41.147223]  process_one_work+0x1d0/0x320
[   41.151230]  worker_thread+0x14c/0x450
[   41.154973]  kthread+0x10c/0x110
[   41.158195]  ret_from_fork+0x10/0x20
[   41.161766] ---[ end trace 0000000000000000 ]---
[   41.171543] ------------[ cut here ]------------
[   41.176169] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
sdhci_send_command+0x7fc/0xea0
[   41.185210] Modules linked in: uio_pdrv_genirq
[   41.189650] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
5.19.0-next-20220808 #20
[   41.198679] Hardware name: Marvell A0-AC5X Board (DT)
[   41.203720] Workqueue: kblockd blk_mq_run_work_fn
[   41.208420] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   41.215369] pc : sdhci_send_command+0x7fc/0xea0
[   41.219892] lr : sdhci_send_command+0x644/0xea0
[   41.224414] sp : ffff80000a9db980
[   41.227721] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
0000000000000002
[   41.234846] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff0000004237c0
[   41.241972] x23: 000000000000000b x22: ffff000006d001b8 x21:
ffff000006d00228
[   41.249097] x20: ffff000006d001b8 x19: ffff000000423580 x18:
0000000000000000
[   41.256223] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
[   41.263348] x14: 0000000000000002 x13: 0000000000100000 x12:
0000000000000000
[   41.270473] x11: 0000000000000001 x10: 0000000000000b10 x9 :
ffff80000a9db9e0
[   41.277598] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
ffff0000004deaf8
[   41.284722] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
0000000000000000
[   41.291846] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
00000000ffffffe4
[   41.298971] Call trace:
[   41.301410]  sdhci_send_command+0x7fc/0xea0
[   41.305588]  sdhci_send_command_retry+0x40/0x140
[   41.310198]  sdhci_request+0x70/0xd0
[   41.313769]  __mmc_start_request+0x68/0x140
[   41.317946]  mmc_start_request+0x78/0xa0
[   41.321862]  mmc_blk_mq_issue_rq+0x284/0x9d0
[   41.326125]  mmc_mq_queue_rq+0x118/0x2b0
[   41.330040]  blk_mq_dispatch_rq_list+0x19c/0x800
[   41.334649]  blk_mq_do_dispatch_sched+0x2bc/0x350
[   41.339346]  __blk_mq_sched_dispatch_requests+0x10c/0x160
[   41.344735]  blk_mq_sched_dispatch_requests+0x40/0x80
[   41.349779]  __blk_mq_run_hw_queue+0x80/0xc0
[   41.354040]  blk_mq_run_work_fn+0x24/0x30
[   41.358041]  process_one_work+0x1d0/0x320
[   41.362048]  worker_thread+0x14c/0x450
[   41.365791]  kthread+0x10c/0x110
[   41.369014]  ret_from_fork+0x10/0x20
[   41.372584] ---[ end trace 0000000000000000 ]---
[   41.382383] ------------[ cut here ]------------
[   41.387009] WARNING: CPU: 1 PID: 49 at drivers/mmc/host/sdhci.c:1152
sdhci_send_command+0x7fc/0xea0
[   41.396051] Modules linked in: uio_pdrv_genirq
[   41.400491] CPU: 1 PID: 49 Comm: kworker/1:1H Tainted: G        W
5.19.0-next-20220808 #20
[   41.409520] Hardware name: Marvell A0-AC5X Board (DT)
[   41.414561] Workqueue: kblockd blk_mq_run_work_fn
[   41.419261] pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[   41.426210] pc : sdhci_send_command+0x7fc/0xea0
[   41.430734] lr : sdhci_send_command+0x644/0xea0
[   41.435256] sp : ffff80000a9db980
[   41.438562] x29: ffff80000a9db980 x28: ffff80000a9dbcf8 x27:
0000000000000002
[   41.445687] x26: 0000000000000000 x25: 0000000000000000 x24:
ffff0000004237c0
[   41.452812] x23: 000000000000000b x22: ffff000006d004b8 x21:
ffff000006d00528
[   41.459937] x20: ffff000006d004b8 x19: ffff000000423580 x18:
0000000000000000
[   41.467062] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
[   41.474187] x14: 0000000000000002 x13: 00000000000ff000 x12:
0000000000000000
[   41.481311] x11: 0000000000000001 x10: 0000000000000b10 x9 :
ffff80000a9db9e0
[   41.488436] x8 : ffff000000649af0 x7 : 0000000000000000 x6 :
ffff0000004deaf8
[   41.495561] x5 : 0000000000000000 x4 : 0000000000000020 x3 :
0000000000000000
[   41.502685] x2 : 0000000000020401 x1 : 0000000000000001 x0 :
00000000ffffffe4
[   41.509811] Call trace:
[   41.512250]  sdhci_send_command+0x7fc/0xea0
[   41.516427]  sdhci_send_command_retry+0x40/0x140
[   41.521035]  sdhci_request+0x70/0xd0
[   41.524607]  __mmc_start_request+0x68/0x140
[   41.528784]  mmc_start_request+0x78/0xa0
[   41.532699]  mmc_blk_mq_issue_rq+0x284/0x9d0
[   41.536961]  mmc_mq_queue_rq+0x118/0x2b0
[   41.540876]  blk_mq_dispatch_rq_list+0x19c/0x800
[   41.545485]  blk_mq_do_dispatch_sched+0x2bc/0x350
[   41.550182]  __blk_mq_sched_dispatch_requests+0x10c/0x160
[   41.555570]  blk_mq_sched_dispatch_requests+0x40/0x80
[   41.560613]  __blk_mq_run_hw_queue+0x80/0xc0
[   41.564874]  blk_mq_run_work_fn+0x24/0x30
[   41.568875]  process_one_work+0x1d0/0x320
[   41.572881]  worker_thread+0x14c/0x450
[   41.576624]  kthread+0x10c/0x110
[   41.579847]  ret_from_fork+0x10/0x20
[   41.583428] ---[ end trace 0000000000000000 ]---


> > 
> >> Do I understand correctly that the swiotlb will be used in case DMA
> >> engine could not map the page in the specified range (limited by dma-ranges or
> >> dma-mask) ?
> >>
> >>>
> >>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> >>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> >>>> +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> >>>> +	}
> >>>> +
> >>>>  	return xenon_phy_parse_params(dev, host);
> >>>>  }
> >>>>  
> >>>> @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> >>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
> >>>>  	{}
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >>>
> >>>
> >>> -- 
> >>> Florian
> >>
> >> Thanks,
> >>
> > 
> > Regards,
> 

Thanks,
Vadym Kochan
