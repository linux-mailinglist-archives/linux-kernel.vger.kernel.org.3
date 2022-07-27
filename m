Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF1582F54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiG0RYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiG0RXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:23:24 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20131.outbound.protection.outlook.com [40.107.2.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817256A9CB;
        Wed, 27 Jul 2022 09:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeIQin7PR2CFJ3N1gjHNzDgLk0i2i4t8qu+ZcSUIigYM1Xz6FW7o3NOkipDZKumhEIgdnFdeXvQmHPsCXqvqbECJptlpZpCPheEMIe/XoWZHPSPnil/uQpH1WUD+NzTX/iOw2bMlMvicj017xF8BsArck/KM1hbbawRqZp1+R4x+hCBB3rSEfbdx/TAhVcYb0IN/1H4AUHoTnM/VP5TLozy78RA4BnSso0F16dLpQ3Rj8vKgdYz42cvGmFyUIsqLoS/OGN9DR54QWvs8CHB5t2FPIn7DzCQK8ills9RXcwb9DAQKAiNSCzAgzWF4kWgHlSUu/4La90wpd17gQVcWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0H/ppPxVW09NBbfKRoyDnTf8GiiUxi2szClwnwyQ1A=;
 b=BoIEMxj4AHpD32esQy8X+0ihGcgNDdLvMVAMfnqN2T2Ti28XjZKWv83/3QFp0LkRKuf8jWT7kKIIfLRtwp+y5BA+glIvTYJDfL9wo8zCGyOVu62eFAtiEBiK2Xkx/AjbSsfadf3l4cCKTQJcehgODyEcOD49/LkUMHCEdUW0LdLU3ImLOjFBPTc3VFHDMj/dgSahBkHZ4fFNCKjchjjveB8x/pLYxzWPcx7LxR1P18QiBhyyAlNIqDlb6fQFaQTu8vsfMRlvVGTU545E3U7eh9gM5bbEOm+KZzq9ctEiuq3nR+N/FgwfDk4D/hGF+PvJTK750HmCFpmeGfAFN+fcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0H/ppPxVW09NBbfKRoyDnTf8GiiUxi2szClwnwyQ1A=;
 b=r+5cIWjsK6ppR0gij2Wk29yMyA2rrSp4JcGNldBjrFqLiHdlx0BHkNUEl+IVdfsXDDqRLH3TjRFKrQSGiGlE2e3Tgl1emzE1nqeNtxgYxOIHedfErWAkvuxWgyZAHNjN319egx3sfpH66Tfvd6XZmK9hEW8niLTXtI+6/uN/sTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1611.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 16:45:36 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 16:45:36 +0000
Date:   Wed, 27 Jul 2022 19:45:32 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Hu Ziji <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220727164532.GA19351@plvision.eu>
References: <20220726170711.30324-1-vadym.kochan@plvision.eu>
 <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139317dc-15e2-ac63-0e04-295e715a7747@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e128807-55e9-4386-ec21-08da6fef6de4
X-MS-TrafficTypeDiagnostic: DB9P190MB1611:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nKaXQxsjSHLsmOmEEV3lon/oX2CHKiYeGXDsr5MlXIB+0sKx9w0kn8fyzYBHdM9ZMGP9dYOGl7AMpY4llurRNOwmforWu3phCe3GWnVK59lMQ1pd3WckwGsbsa0KSegAE8Wl2bJPGzJPhPD/eHMgbeJoxyzi4jOZOuHQydIetb0+pxnJ8nBmnPbkbOBOs/iqaf7ht9i9a3no5tsiz4o46IxbYFcUH74nHxDjZPzZgVTOldzdnThfcpyJgt0dTr5x1a2L/T1id3NDnmyMP8aZvLtBlCCsT51E9aFrLi1cB722biICwPle8IMTTgL6cRw8yvc3Mn24yCKVCu3VH5Z1K0SpIEoi2scZIFHFUuBK6jPtSsF1YEG3GpLgjxGTb5Cs9vlRz4Na/8+Sb5nfc4AQqyC1L1dzhP06bN5LED3KJalQAhgdJnLOvMPm1852jT4G94sCutf0aTcah/yA5t8vJMbpHi8jh8Gy7d9R50TZxxgRYMfNLb8paGnAQergsAt8D2AjpgzAF5KB+qgcu0OsjcgBLsURhX+9FFMQdzUhjshnYQPqXoPmfhhe+6lf/e5tgqlTimNIdidLh0CgSjrR/z6kTEtQk7rvQVMp/LVciO1DELLom9WHGsxN1SKnzkXmZuqe5T2fQ3gxjz201pPoDffULyH4jqevMCy607BQCJjhpZp++3CfGbuqBAlEfvfzCVHir8KpAZy6N54BSVDxW3cJJ6CBbBc7hT98I8nTtCf4GRvazAmKdxuPW1EeFz06cSo3IRS2levU5TaoVNCM+zgfe450VpNYTeMkmP+m3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39830400003)(66476007)(6506007)(83380400001)(4326008)(8676002)(26005)(6512007)(66946007)(53546011)(41300700001)(478600001)(52116002)(66556008)(6666004)(86362001)(6916009)(33656002)(36756003)(54906003)(186003)(6486002)(1076003)(316002)(2616005)(2906002)(38100700002)(5660300002)(44832011)(8936002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5y+7gaP6h+0Dx9E6mqRt77P4Y83HCw1ssubGg+JX+xmy/IIwJzNp1F/48Vb?=
 =?us-ascii?Q?9vD1AtscFZrfxErkZJqdPcmOtflmR5lvPGifCqQe1laxbAh25sT27eZcPy5x?=
 =?us-ascii?Q?uVfHfs6p6262ad3U6qsbV6HYKFPOITAW4D85aKcspHmFLlmGjXUlgFbj8FKI?=
 =?us-ascii?Q?NDAi4z8MND8C20zfJ8aE06pjxGIT7CVL49/a2H4/Av1Tk2GOWtf5wm51vsaU?=
 =?us-ascii?Q?KzFAWWXJ9BApTnsk3emQvbqM0VoTi1wHZeJVh0FhMoGhY2yzcryM8nM0xSCC?=
 =?us-ascii?Q?9K3NIRGKCggLYTaHmSKZtddtEKtL+gYYr+hyf97/9EaC3ZfFkXe63TDpo/AH?=
 =?us-ascii?Q?E57MlFHNSdBYdW/0pD0dIWHpde+rq6jt4LDXyNNWNvXdqf7kP2Vsv5xgHBKe?=
 =?us-ascii?Q?fk33SONO9r5GXKPUsqx0Vl/X+M9siIYfDBZnYtHgVnY4VnGN3VQ8NwfH7/zY?=
 =?us-ascii?Q?N8ftZ6tD8tLvb32nKq2csHnmq56oYj7De3syTecc4D1K1b2EYVWQue9j11El?=
 =?us-ascii?Q?s5j9aKn0FSPnXR0knjO7h/KplyAyDZGd8N2byroS+5nivBSUMvkq4bw0lU4w?=
 =?us-ascii?Q?WsYEeyRFB5TqT4pg3aN9J2OA7u5eeMvX7Nhdc+zyjvNhsAOtnJxP4wNbRSbo?=
 =?us-ascii?Q?POyVHM81aDAALhs/OuKKd9NQXRmcl+iJF6uGZZ7p2MrbhxbO2VNuCJGIf6UB?=
 =?us-ascii?Q?LtUTihfrrOT85gWRdvd7NbWXO1NIShWrOhY6QYpsiF7fmYV1NRqJp/F6NYms?=
 =?us-ascii?Q?HbmFTNu8jG2zvJp4qORgqE+LJgDGo2cSaBTnlvLkOsDjdtSzaH2BTzJi5VJM?=
 =?us-ascii?Q?ZDiL1/Nc3BxGD6BgXl2EV3tDpd1nFFCPMsmGVl2wfkZ5dh9JpQNrFV2xzTfb?=
 =?us-ascii?Q?hJkq6I0PDoKdtBe+KlybPMxokCWtF7jcpUNpFREvrdZgrVjQEIvUFswqk+/H?=
 =?us-ascii?Q?ZzFjuw6wdWezBHk0AwMdqGvmXFxeuGCgU8koHez250gR/tl56b/d4z3ObNyj?=
 =?us-ascii?Q?dpTuB60pI3S/tL1LBCsr9ixjdBjnF5Fm1hZ/2l431vFyOybHVQRg/ZYeIEZA?=
 =?us-ascii?Q?INfzo+fXsAEx0nDfdVO2u+zM9B9OiWD8X2ZmlmEWIfp2ZmIDDMo2yBmynJQF?=
 =?us-ascii?Q?FGzzr/6RIT1ikp1p/U9m8wsq4ZCVy3easPeKf4KlnnLJPLO8ejjoOdc1KSBX?=
 =?us-ascii?Q?EnNzrJ1RkFxNYwQev2yPEd/wr4SzghKuKEqL0FcIMtRTN+P3GD+S0fbjetH1?=
 =?us-ascii?Q?nJr+FanC1AN70YKq9CD9gikbUmQwv9DW4u2lqmrhf/I5yMOBDzm20lkJgoLm?=
 =?us-ascii?Q?Z5dZIKnCIC6OMPnF8NkY6F70CnZmbgCD+Q+oioyx9PQWYizF0XdgUQgzZKpG?=
 =?us-ascii?Q?FFmLkteWiA5l8IU4N/TNmjZ5rFPJXvq1Cw5irWJEog76nq+bKa1UC9Rg+IEB?=
 =?us-ascii?Q?VYcg0Tfo8AFGR1ZH+ZHJdVg+Drcp/TjtBFDgzgjTR8nfpNPWf7OOJz1qnKuu?=
 =?us-ascii?Q?96nqrqoqfRYdSVykToU8tLX+8yojz8kfL+pEsapOfWDshNy5zHFV2uFmkWI7?=
 =?us-ascii?Q?2UCFQO71rq9QTJOKLIVhP4/LDmFWZYMDmfvMf3v/bkP661kBCucxwU/swHHc?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e128807-55e9-4386-ec21-08da6fef6de4
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 16:45:35.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgBH3ZwONaZrHq3t6YYcG2wU2OzAcXEfDm5fG2MeAzyDwS3hKuu8JrFChBxMc9fu1BqaijuyLDajgmwWb+2PypyFTT4a1s48ql7nRpRdUlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1611
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

On Tue, Jul 26, 2022 at 10:37:46AM -0700, Florian Fainelli wrote:
> On 7/26/22 10:07, Vadym Kochan wrote:
> > From: Elad Nachman <enachman@marvell.com>
> > 
> > There is a limitation on AC5 SoC that mmc controller
> > can't have DMA access over 2G memory.
> > 
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> > index 08e838400b52..666d06b58564 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/mm.h>
> >  
> >  #include "sdhci-pltfm.h"
> >  #include "sdhci-xenon.h"
> > @@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
> >  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >  	u32 sdhc_id, nr_sdhc;
> >  	u32 tuning_count;
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct sysinfo si;
> >  
> >  	/* Disable HS200 on Armada AP806 */
> >  	if (priv->hw_version == XENON_AP806)
> > @@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
> >  	}
> >  	priv->tuning_count = tuning_count;
> >  
> > +	si_meminfo(&si);
> > +
> > +	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
> > +	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
> 
> Why not limit the DMA mask of the device and ensure, that bounce buffers get used so you can still do DMA?
> 
> Also, you ought to be able to describe that limitation using Device Tree (assuming this is an option) and declaring a dedicated bus node for the SDHCI controller and providing a suitable dma-ranges property, see: arch/arm/boot/dts/bcm2711.dtsi and the 'soc' node for such examples.
> 
> 

Do I understand correctly that the swiotlb will be used in case DMA
engine could not map the page in the specified range (limited by dma-ranges or
dma-mask) ?

> 
> > +		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > +		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
> > +	}
> > +
> >  	return xenon_phy_parse_params(dev, host);
> >  }
> >  
> > @@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
> >  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
> >  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
> >  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> > +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> 
> 
> -- 
> Florian

Thanks,

