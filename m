Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4356AF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiGHAbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiGHAbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:31:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864562AE09;
        Thu,  7 Jul 2022 17:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+MNe2QgO9leIgH5h/YF5uF2YzUTuQBe3hchZRQwO2Cusel2K6mKH79n4WVfwHponwcLBkOkFQx3T0wqCUr4t1AlvLjdYTPv0EF/QEz56PAraFe87jZvT3UPD0u3RcjAe7Ot8kVybYFNFqFPSE4v1AJlmrEPT2BSOBeCkbxVSwpgtkMGCUIYJkGncS4g5VIJ+q+57URSTwoj4/bJgzNcSLWxU9J30cOfnFZFcVQgduj+a6NRmiu15YT+JG+cG2iSy1IWDkC2oTcgDK5tsBLMBB0964LYCcEk+2p8Djc6+hFAasziPJgKXNSVeRaIas3xsbR5dCsRBGbnJqBIEMax2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp0GHg4QnMrI9yeBQDbF8KD3NSHsdhwDuCt+OCwdPdg=;
 b=DNP2ViwxsvNi3IX8EQ8Fwq1tCypZvRSLdcUvOrn5tJNGTGarkRLUgo3E38i5CMxGrGhGI53T/QvIbZdUsIhlNH2rKm6dtnIjAU/d+s+XkJBxSMSFW7Fhn1W0SvfxINq8y2SmRQp7Qjv4rte80z4adeVdFStUV/K67AwmH8G6MmYfCqDMgNU52/W6nFYSI50WzB2OHeHEvzKRq2WN5EBwxnAx0JKtdx7kRvbAPBoVYwmYYmoZ6+lUiVtGWkynDwq70l3NZAWOk184uMlmeK8Js7P/H0sMG2dtqPAXJSOFkFZnKrviswDZXXCmy7c2yxvqIb5izlY1sL2YPJnyj0ZpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp0GHg4QnMrI9yeBQDbF8KD3NSHsdhwDuCt+OCwdPdg=;
 b=R9EwP3hjUeBMZXTwYAs523buR4b5Xc4XdGWhmbMBOt91oaVnnu6FMyysYQu0lfleXtr8n1mpc7sOayn1aFfFVBtBMrmhq7ocumMP+e7YRRejoSIKBOb1zVcZXm2QjxGMzwH3cdJHLesZiKd04GN57HLilUkSHvr+tewBhfVZnXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SA2PR10MB4618.namprd10.prod.outlook.com
 (2603:10b6:806:11f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 00:31:36 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 00:31:36 +0000
Date:   Thu, 7 Jul 2022 17:31:28 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, kavyasree.kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <Ysd64LTu7CtBjV4R@COLIN-DESKTOP1.localdomain>
References: <20220707185342.2697569-1-horatiu.vultur@microchip.com>
 <20220707185342.2697569-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
X-ClientProxiedBy: MWHPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:300:115::25) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae04061-7243-45c4-5f73-08da607936e4
X-MS-TrafficTypeDiagnostic: SA2PR10MB4618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfd9DRTqTUpVhAEgULahA3/CnBFjLijsnYK0zyFHYmK7XqKoE8ZONbZY9k6Vslihb2TYmK5TiF5aEHBjhkLQWK3vwUu3jS5uOOQwWB1dVDYIGhigF2olxcKHk42fvb9JHVB70X4bXfnObZKgM4E2nW86ElAnyg91Jy+yAZ8M+0Ej4ctM5W/7Lg8CFFR1j0zy/fdolECzPDS6fv5foqMtq3gpmGU399FNgkBgx1o2qB7Rs7LpnVRHfQ5XbAMp/wYYh6J1d4MlAoY62jKl6zFvhh33z5oYGnmzFOlePw5Hxh9Da55GfsmlyKb4ttTrp8vj7ylm+FgjohsEEgJtk4XzUit340q1E8fRZBlUUZPaPXWiM7WHjRdVDgMmuYi5ewZU2ojRanlZJ5ZmyrE7baP9Bm6lA0FpPA1Bri3y790bYwzeKiWrf9VRORZ8O2CI5E+fnysk8/gzFzSWCs/Cltq66WFfJY3Y7klal6vsfMmtepBF+6geYkV0zEU67uTzBE7qUD97jNFycTA11KzCfGVKswt4fZPA35AcXm7Ui+MEG4kkg7mqWnlTLsq6Kt4jGFiFQsH7sV+bGJDFPDKigtZ0Cg2o51erAcwcjQxO5XKNd14XUXfCsWK9PFbMkjo73fuKqtZuXIwjZNF7YIlfj1N/OVTZRw1PO01e8PQ5cPOLNRl9rdyYff6uCBh/kLeCUArPSDT8XUMFoA3/kKAcfFxfQwCM46bqYlo+f8IfLbIfppOTXKf2BwTYQyB+EK4vlqNecehL1Dw0pvu3e+XHya3M0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39830400003)(366004)(396003)(136003)(376002)(38100700002)(83380400001)(186003)(66556008)(4326008)(66946007)(66476007)(8676002)(6512007)(6916009)(316002)(5660300002)(478600001)(6486002)(966005)(2906002)(86362001)(41300700001)(6666004)(6506007)(26005)(9686003)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om1qugLIiMEX/YF46FnqTtz8Q5HT+bNe+JyM2Gaa/Fp9oe4nkiP/z3XqIaNc?=
 =?us-ascii?Q?vVH+tdNelvKSH0M7+6xDLqPHTCrDJEHcIp2RyX9ED5oyUVtKharsGQd35/dc?=
 =?us-ascii?Q?sVMvGIuoJFj0Mzso+ns8D69jDXV35OystEg3zLpohzqvhXiD+du/G99nIW56?=
 =?us-ascii?Q?ADclRZtiEHHEFKGiQ2oJ3BSJR50tGol48SK8woG9V/C971vYp7bu0qbEVVLg?=
 =?us-ascii?Q?8zlMVX9+/7Gw5FuLAKoQr0YkcvjFUQ5ad6BgE4MqoX9wVP3zj6O91hbLtoVl?=
 =?us-ascii?Q?QK4LU2vk6Wjm9f7RrvuNXYgcinVh/+G50rOA+cYFYMALeq8Y/fx3zGDlt4aC?=
 =?us-ascii?Q?qHdYxjlQH3ebJLwds2jqPYmm7I6m1PoSPZvfGCILrEte0wymn700gJLqzdz4?=
 =?us-ascii?Q?ttzX1wAODnsyoVCe1h2D9H2tovn+4yDyN7CNFHaWtgzdR6k9TUCl5Y/zXP8Q?=
 =?us-ascii?Q?0wIrJCX0ZT4voMomE+iGJN7mSUSmcPUKIVb0+t8ibFcStnxUfVuhAa7rsqeu?=
 =?us-ascii?Q?kuf2HtOQEGBLAnPdTY9uTe8mL13mAs1hB9q010/sTO5stzl924n9KFrnOVBF?=
 =?us-ascii?Q?noottGcbcujJtOZ67MWGR+MLBt6Y3qWo3S9p19zS5bvg/FDM5dtIQ7iA64/B?=
 =?us-ascii?Q?+dJQSYzZwp0zD8THCMQ5SOpanUa4flZYOCnuRu8mp8HBI4NVIJgn85LIrr8d?=
 =?us-ascii?Q?cDxAWli1OFSms1LBQYeaqALHX2WUdCq6sXqRikwngIoxozu06Fjtm0UxTJcS?=
 =?us-ascii?Q?OpX9o07FfA2ZI7jvj6cfsyRDXznJnsAz91nlG+0Z1JgASiiVE20cvBHfmiq5?=
 =?us-ascii?Q?WvoKtuopDga+VycOoimDMh1GFbvz+Op0iNoSd1h/FgbR05kapY1KlZZB/mx/?=
 =?us-ascii?Q?ni2HUkjjKjqoeXFVbMB3Gll/+GpHKwm/PM13E6Dzj4xoAWIEWpibTWzwwDqJ?=
 =?us-ascii?Q?AX6LTPboAGWUSrgzHMBf5iXqYKC8MuiQTc/0+UTZzOe7MysUrjv4b2jrSzP3?=
 =?us-ascii?Q?1zVYAN2CnxjtpdZPalsqQCi+sNM5m6UiAZiv2jhF/g/yrnSQg9QkYkUlqt7m?=
 =?us-ascii?Q?jXBnIAcfYVLJkfsksfFw4TU4N4NmFt3RSODb4xfatDiL2I4ySNHHAg3YCcCw?=
 =?us-ascii?Q?HfjPo1IhSKfnGYTXfsOJy7DPfj5ecXNWTQo6Q5iVRlnkmWlU7hY8B+pMJiSl?=
 =?us-ascii?Q?wYn0xRQyL5eZ8H1t6JNo8dUC6iM02iP4G5zxN4B3zxhnKL0bjf8yIhWFlgLO?=
 =?us-ascii?Q?HpOSnFUd3mZzu3bCdzKwGk0d7wfC4Zy3J6EjDrYkGkzOefCwVk79cRFIUe/j?=
 =?us-ascii?Q?G0Oex2BxA7SW4NFRwasEpYC2vrJETwaYc02ixc20+W31DjugKkmLv6BTTpMh?=
 =?us-ascii?Q?CGvb0QwwoAQkKTNKAg3BFhUCAnf7s3y0Lx3Xj3tqkVx3Bg6QZA4TcYdPcyDC?=
 =?us-ascii?Q?+LlAqej8lUVksCIKhDhwANhWsGgeq2D7SQdymXPhHp0o0LOVXNXgzwbrNhfm?=
 =?us-ascii?Q?8gPadHaItroN7FdyJHTjhrYQBVNcbXqtmAURiUhsdnSRymJzoHO20mWkpglB?=
 =?us-ascii?Q?C14pcolcPjmkML+0VoFmIegD8bO6fYYBlh1uRcTeXQJD4dTOihUfW4rNpMR/?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae04061-7243-45c4-5f73-08da607936e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 00:31:35.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4cGKJH8hDwFAT1ialAxkyO/rO9keaU7jB5ce3tofffTSfor/lNfvVLmfkGLqTiYPRdI1f7uVeRn3wQ9Bp3LdST5Myma/EgSrfU0eq8sWoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Thu, Jul 07, 2022 at 08:53:42PM +0200, Horatiu Vultur wrote:
> The blamed commit changed to use regmaps instead of __iomem. But it
> didn't update the register offsets to be at word offset, so it uses byte
> offset.
> 
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Sorry about this one. It sounded familiar though:
https://patchwork.ozlabs.org/project/linux-gpio/patch/20220125161245.418882-1-horatiu.vultur@microchip.com/

The only takeaway from that was the use of regmap_get_reg_stride, which
was done in
commit baf927a833ca ("microchip-sgpio: Fix support for regmap")

And I see it is only for pincfg - which I don't have any hardware to
test that. Apologies again!

> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 6212abe2b66f..e84f2f82901f 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -303,6 +303,13 @@ static const char *const ocelot_function_names[] = {
>  	[FUNC_RCVRD_CLK]	= "rcvrd_clk",
>  };
>  
> +const struct regmap_config regmap_pincfg = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.name = "pincfg",
> +};
> +
>  struct ocelot_pmx_func {
>  	const char **groups;
>  	unsigned int ngroups;
> @@ -1334,7 +1341,8 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>  	if (info->pincfg) {
>  		u32 regcfg;
>  
> -		ret = regmap_read(info->pincfg, pin, &regcfg);
> +		ret = regmap_read(info->pincfg, pin * regmap_pincfg.reg_stride,
> +				  &regcfg);
>  		if (ret)
>  			return ret;
>  
> @@ -1368,14 +1376,16 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
>  	u32 val;
>  	int ret;
>  
> -	ret = regmap_read(info->pincfg, regaddr, &val);
> +	ret = regmap_read(info->pincfg, regaddr * regmap_pincfg.reg_stride,
> +			  &val);
>  	if (ret)
>  		return ret;
>  
>  	val &= ~clrbits;
>  	val |= setbits;
>  
> -	ret = regmap_write(info->pincfg, regaddr, val);
> +	ret = regmap_write(info->pincfg, regaddr * regmap_pincfg.reg_stride,
> +			   val);
>  
>  	return ret;
>  }
> @@ -1940,21 +1950,13 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>  {
>  	void __iomem *base;
>  
> -	const struct regmap_config regmap_config = {
> -		.reg_bits = 32,
> -		.val_bits = 32,
> -		.reg_stride = 4,
> -		.max_register = 32,
> -		.name = "pincfg",
> -	};
> -
> -	base = devm_platform_ioremap_resource(pdev, 1);
> +		base = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(base)) {
>  		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
>  		return NULL;
>  	}
>  
> -	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> +	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_pincfg);
>  }
>  
>  static int ocelot_pinctrl_probe(struct platform_device *pdev)
> -- 
> 2.33.0
> 
