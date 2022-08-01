Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FA5866DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiHAJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:30:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC102B1A0;
        Mon,  1 Aug 2022 02:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlcM3swerXB+dIFNn3TX9vgF7gDVTcGr2BvuB5G1tOXznterEfL8Y/QU3dmBL7QHUxmtI/GJ1kIugsMokQ6s1CppeKlamflyvaNHK1XZ33Zx9Bt2joPeCGL3c4gP+M78SiiH2Gw7SofMqFH6BeJlqfmDX/ngx2YM8ehub+xHczju55JrPpxoi7yxKNPSFsqhp0BBOFAxjLeq8RJCWZpi/L/toZ1GJcM7G1NkpAazBvYL/dh5YKvGhzroIweOOnDCl56m2PFLJAdnZWxhOY+K8j60inmKwx95+cf1ubBUx4NP5gUaKrmADinHGDVMce+izCaSZ62NXu6abmXGaudURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B3oOAEtVjCkXEyejXQlHd/FM7zivLD0FzUZOfnBxdE=;
 b=Rq3oqeaJWkqHa5CPpnH6Uuwpe9/NBlpOx6Aq0Vs6lKaMGoiRs08PfgtjzfpIqnHw0CNVs/mxLaqfv82/ThPJxtvX+t+gZM7XraHqADowJa59TPK5nKNnzhHWv3sBnVVse6K2Uj+3rvbU2ydGuYQ6c/fWJbEIkR2GmSxGSEs5uLf4HrwZo0adigmIEr6oUfoCc1luLvauYO+kL5ujvTA1snvsKB90ay3lsEH//VwkN399LcMnEHvrm2z27PQmj53+ajjMZzT9uS8XLsF9Lw0LvWGLETPNK81SV629K2Ugidkhn+2A+VVt30xw5AwlWmqawM/Kf2Y05ARtxCUqslVDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B3oOAEtVjCkXEyejXQlHd/FM7zivLD0FzUZOfnBxdE=;
 b=jvsiJE+GR5WWxa0X/ITvEmtUADzUf4wHwBDmE4CScOLjUOEjmzoPRm4aLIfjLXCAR57qYVfiQ+tu528nDzRARnkgQ69zi1zISXj/cxrmzmjubetugBQehWyQjQ2NTUbDhyLXv7Ym/uEBPJqEzGtZVkOlkwZFyBQ+iNwQhUkkGDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PR3P190MB0988.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:82::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Mon, 1 Aug
 2022 09:30:47 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.026; Mon, 1 Aug 2022
 09:30:47 +0000
Date:   Mon, 1 Aug 2022 12:30:44 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hu Ziji <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220801093044.GA22721@plvision.eu>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
 <20220727164532.GA19351@plvision.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164532.GA19351@plvision.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR3P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::17) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7053eefc-7ca5-43ce-f315-08da73a083be
X-MS-TrafficTypeDiagnostic: PR3P190MB0988:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozz/bVyBPqdt51SSY8nhrqw2MQ4bhVa1o/mSTKQ3nf9WzfGkv+cgDu9j3Tzy4Wqen9Qza+cFY1ZDjVoN/gw/zF+aGnaj2Nf1uSztCrV9tHrGAcmd4dSWqhMe36aIroWYZSlv17mMLRvXIQYFSAV7fAwbH7mjOePMi9fnGviFY1dqULC/wg7uEkiVp2Ym9eYoXFADur6mqU/piwxep4aWL/SrKrhrpRs2HyeSj9MI3obIyXPm57cIk5iYeZ5xbqVYxLr+zkaUifa3S9jhEdghoAs1KQzRTebvJyx1PHKL0cNKCk0Rm8rZkwF5VA4XcJM2ZDGbdVYOYOYo++DhdkWMPjeWzqJ3GfRvlDy9b/14l9AZ0imk5GShv5pOMgObxckzyG7XiRlLpFHZynWls8CAEYVxeVmsHc4Kl0C/ZwDdBU0/4/aQZ3KK15rqgscrEww8Vmjkfft/KFxUQWje36cmnhD/4cDP7Kd3K58hPVcUedfwuvDqh2QSHDgx0L/0E+GjugaeQwyVcWBdmGTSy+A/lTzX7F9iyxsmuSX6vdH47k+mW+2exsGCAVpmBKimpkgnREHVtdJh8XBOGQnF+G4PYJlrJgeMo/rIDoHuS3ItC+HL6Ip3sWZGzWh0Ja3s3m+tfdzTWynngHJprhIXuGlYaiPBgWiQWJOnkO4rh2gfnOO5xIfwBlXZKc1szpzebC4eNkz9APuSt66wELvmrWuwjfdx+SbYtpwiJw86RlguCikUlj5UjE6OFePm4bum1DqBSuIOgVBtVvV3v++GXG9p3gKl0XV+s2E/81sTAKD0ehUdukTsKiKeJIS4ptGzSPNE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39830400003)(396003)(346002)(36756003)(2906002)(8936002)(8676002)(4326008)(66556008)(33656002)(66476007)(66946007)(316002)(54906003)(6916009)(478600001)(6486002)(86362001)(38350700002)(53546011)(1076003)(6666004)(83380400001)(6506007)(52116002)(6512007)(186003)(2616005)(41300700001)(26005)(5660300002)(44832011)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EVz4E7TT5ezagSiOgxpqgG782ustKP8qEZj6pNFKkE3RZJV6ittlhH19jIo?=
 =?us-ascii?Q?12NIR0HZWqsyP5AETv78Hw421kyFWcdbQmRO2hZyC5uhMmT56Z5l6G3vhEFd?=
 =?us-ascii?Q?vjlg+JA0mODRPrQa8EUKPu+cJL7ZqcGc82xKXr5VUhPOdSUcMMkc5+0xK4rz?=
 =?us-ascii?Q?xBM0lL48EuhM13A8YP+vNCs8rzI3rYQ4NjnpkcHGatxwzpQBFYx0rP1Ju8Xg?=
 =?us-ascii?Q?h3QQ/PTBsPgCO4AFr5J62cQMxrhttK2VWsIPuB+hfVzf+FItJEvWKS7844X+?=
 =?us-ascii?Q?DWvNk4a3T3QU2qHwLSt4kSvbi55Ey+jYjYgOG4LR23eAyfiIkmqFCO++AV7X?=
 =?us-ascii?Q?s4LxUJ+37sh1FHdB0f5YPv85DAxx92PQVsdWuXSGVSq/zuJcCZR/SdAjjSb1?=
 =?us-ascii?Q?weg2AR7kd6bZFLuFkfzjYjcZBDVUjx4FPIVw1k3AgmdRpojpV0Sr8jh8jQGG?=
 =?us-ascii?Q?uJN7m+ZiZB1mpNLzmFrpWxuXldFx8ct6GD4EBVAOpUIuUollhPIDq/fXePjt?=
 =?us-ascii?Q?Co3/PQTNCeliAMknLc0iCcLgE1bhtIlbYSex5BCBRKrToCmSFCRwNvuhhl+W?=
 =?us-ascii?Q?cq8hiGzpyZauE3P7lL7mMIhX2nUlgfkTOn1BcPD6uCTVCPJALLtuVgSxz023?=
 =?us-ascii?Q?SPcNht6XXUTicqOa//3NgzAFR95Wh383NIccYEX/T4rIckxjupZ7wlRhycmz?=
 =?us-ascii?Q?KKFPY9kQxkMt5o2IIfuvZQgdoG7cfp7+gc8f2TgYgTHQmdJ4Bb1wMsmtwe64?=
 =?us-ascii?Q?K4sie+V0EnK7hhk+A1qMKXHT4eah/3s2j6kOyPR+g5Ymz8gLBBuuhKZf9n8+?=
 =?us-ascii?Q?0skrh24fYxUzDzjdLv9nm/4FKbxbhx5Xe6nkran8TzZHlI17U/yqwXffQ03w?=
 =?us-ascii?Q?43WYE0FpPpc6R4Ess/zQBsOLHs+x2uGReow26MXBSW2no2E5btwvdNF2iatj?=
 =?us-ascii?Q?1VjJId4yCBKQo7g1o4VvTWXAJYBiDCK/SjM/lyjf9ojMMKNl7yAbBNMWJAUc?=
 =?us-ascii?Q?DKbMgrOvbDzUqZNhWeCPAwe52NmHbrFu0/bziBmNpcvLaVgJ6pxfEXywUlnp?=
 =?us-ascii?Q?+aGL8jD7eZ+WZTDJxRLqYX1SAdq+vkZQLLGQPtPXBRkAbAp0anA5N3vY4whc?=
 =?us-ascii?Q?l7Ay7PJY9EiwprDZcMSlDpaUkcEJHoIU91nw1gejUNDnEDG4NhEYSXeMgI//?=
 =?us-ascii?Q?3/QEDNxYFhSE85dPT5WLvmp5V2RCNP2d1XWTzzh3C7k2hHNcx29azv0+QMA4?=
 =?us-ascii?Q?Rj8j8zyTxbJHsQ00RrfSKw2aOJVerwWEqBjiymN8AWjABvSDjYoW/2Xmu8dL?=
 =?us-ascii?Q?R1cAM8Xsgn8zJ7ppdbyOX+sedps0xwMZMJgFcWQ+TMQtyHjQEzjEhU7tyuwh?=
 =?us-ascii?Q?G3C44MP0loN6aCQKvF9wPvyCaQ1C7KwW8i7UKeFdYlkDLqT0eXESrfQeW03/?=
 =?us-ascii?Q?uahnet/AnTawFZuTj37nTyrVDLdtFzUrykXtMQCX5LMS3EiW/jvM7orugPL8?=
 =?us-ascii?Q?b2JKiYZB3HDhVlSReAcEbFqP6QU3ZPq2TvBtpmof5JE7cUw0ThALstDjnN5B?=
 =?us-ascii?Q?WquZSQtn+8UPbdjnc2kQAUwN2hZafE8HMkI+kEh/+0WfZZD5uahzqBM3kzm9?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7053eefc-7ca5-43ce-f315-08da73a083be
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 09:30:47.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00lfxHDU4nYAXq7mzmLE+BzCqLv1Q4qS9jMpT/wN32DiaDk/8zZhs67+JOXUbKxZS5T8xTxxT5zAZ4wv5s5vuT2CnLi8uorWTtq82afkA9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jul 27, 2022 at 07:45:32PM +0300, Vadym Kochan wrote:
> Hi Florian,
> 
> On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
> > On 7/26/22 10:07, Vadym Kochan wrote:
> > > From: Elad Nachman <enachman@marvell.com>
> > > 
> > > There is a limitation on AC5 SoC that mmc controller
> > > can't have DMA access over 2G memory.
> > > 
> > > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > > ---
> > >  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > > index 08e838400b52..666d06b58564 100644
> > > --- a/drivers/mmc/host/sdhci-xenon.c
> > > +++ b/drivers/mmc/host/sdhci-xenon.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/pm.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/mm.h>
> > >  
> > >  #include "sdhci-pltfm.h"
> > >  #include "sdhci-xenon.h"
> > > @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
> > >  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > >  	u32 sdhc_id, nr_sdhc;
> > >  	u32 tuning_count;
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct sysinfo si;
> > >  
> > >  	/* Disable HS200 on Armada AP806 */
> > >  	if (priv->hw_version == XENON_AP806)
> > > @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
> > >  	}
> > >  	priv->tuning_count = tuning_count;
> > >  
> > > +	si_meminfo(&si);
> > > +
> > > +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> > > +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
> > 
> > Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
> > 
> > Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
> > 
> > 
> 

I could use DMA only in 2 ways:

#1 Use sdhci bounce buffer with SDMA mode

    But there was the issue that SDMA requires that SDHCI v4 mode should
    be enabled, and when I enable it via sdhci_enable_v4_mode(host)
    then I got error that EXT_CSD can't be recognized.

    But if I comment this line in sdhci.c:
    
    int sdhci_setup_host(struct sdhci_host *host)
    {
        ...

	/* SDMA does not support 64-bit DMA if v4 mode not set */
	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode) {
		pr_info("XXX SDMA does not support 64-bit DMA if v4 mode not set\n");
		host->flags &= ~SDHCI_USE_SDMA;
	}

       ...
    }

    then everything is OK.

#2 Use restricted-dma-pool in device-tree

   But I am not sure if it is good solution compared to #1.

Setting only DMA mask did not help because after some time I got
"DMA overflow address" error stack-traces.

> Do I understand correctly that the swiotlb will be used in case DMA
> engine could not map the page in the specified range (limited by dma-ranges or
> dma-mask) ?
> 
> > 
> > > +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > > +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > > +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> > > +	}
> > > +
> > >  	return xenon_phy_parse_params(dev, host);
> > >  }
> > >  
> > > @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> > >  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> > >  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> > >  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> > > +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> > 
> > 
> > -- 
> > Florian
> 
> Thanks,
> 

Regards,
