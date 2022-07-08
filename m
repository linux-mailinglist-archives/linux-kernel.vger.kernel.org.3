Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2356256C228
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiGHUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiGHUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:16:10 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2121.outbound.protection.outlook.com [40.107.101.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC0564F7;
        Fri,  8 Jul 2022 13:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF+L5tprRcMABBkMPlVgFbdxK67Zg0/ONzh+yDYLtZbf1nwXKS0BDs2iobtjqCv8VZtK/DfsQzi929xL8EBPqALgvVDTIJilwE+Y8C4qDzM9gvu01Cp4tDlEmO3YG/8x6IoIJiA/YE+v+ipum6fuw2sJmtsntn1pNPfxXJJ+D0pE0IAxMHT3W/fUSZgzXoJd6EONcQHwrBJwvWn1v4lqJU/ZQq/GdWBqv3L+8rKYLd+utq23fiqyBkiLYa6VgA/wswDFwNf2OnVOo3QkFRWthkrbDrxjlYUGl5HVuzMvL3L3s8yXlzZa9wMjMZXAfFBf1usWixOnDwmIQlQDnBXYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdllqpinDh1AD7F5tKtJ1afL2aB0IK86dSCjfcPHGBE=;
 b=c0CYQp8DSu/0VYzad33UyfUA2pn5v8Vc8DqiiE/6irScsbGByDSk0lFseszWb4bVIXBZgtEodA3Up+CjxfsXi/Yd7tNQivgd2O5Vs+2yMrk8k3hshSAD+atoHUzBs8Du27aNFELPEbxsTLjL8v0Jdt+0yA45HUpitkrQbxmHH+hKriebyGgRu0bSmaYr9aStR9dhFjC617GcoGHEI81vXO1TvdWceueOOxe0jftZUjnHW5dtXScj5u1U3s0spVwDNwqKUE4DWwqJlemTJ2s/Kon3JpTUsikG7tWHfVZEliGIdO+7KCxyB4CzimE8YAsR/ejHt/81OwNHxwxUgkON8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdllqpinDh1AD7F5tKtJ1afL2aB0IK86dSCjfcPHGBE=;
 b=zAWg2l0WLyZJNJ0cH31kpmVpn/ofyl2woZfygwPpifc86AEqZafet5qLLjdWWdCWMfzmKuKOW01qzZEhDTjt3vbmsTyaJAYwU4SByGyHXHDkQgjjcev57NLVSC32bBwK8N+67SR2yHQzWfCLJ6YWs4iiWeOB+gwmuFCsaov2ZJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BN0PR10MB5048.namprd10.prod.outlook.com
 (2603:10b6:408:117::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 20:16:08 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 20:16:07 +0000
Date:   Fri, 8 Jul 2022 13:16:04 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, kavyasree.kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com, michael@walle.cc
Subject: Re: [PATCH v2 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <YsiQhA9pHaX4s3R8@colin-ia-desktop>
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708195510.2951661-3-horatiu.vultur@microchip.com>
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac5476d0-9981-45d5-76a2-08da611eb141
X-MS-TrafficTypeDiagnostic: BN0PR10MB5048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVg8MIXyrBzP/3KCqHkvbHMC+KrOXEYMrHRn6I0QQQoQVf9x8sdpjhTk+j+VdSyHhO4WNE2c5t0+rs2Z2vAkJ5eVL3i7cL49wGi2J2jsNSETkp7AbZKxXUfquk9AEtUV6nVYouMF9FKNCDK358oaebgngWRuO0nIrD49GPRLO4G+wMJtJbsisaZ73OLNF/gG7ExJxmNlw1xuCef3db9+US55+Mqiz0mrsWY11cZBjAduGV512lTFLpfCCjgq9WRw4Lhf+4SYY4O/WfbpodqhbGPwMGVy3K676K+kkVwMVVWxpVd+6jmah/IxQnz3GBwOPJnSw4/ab8T0vFhaFrnIZ2l3HFM+i7URwuLTeZk3R0THLqH4Yl9KqxmOPyhP0ZEDWzrU6lhHcdM1B2RBG/6q6MSrx13oKMMe0Bea5PHSwZnZIkJDAQ//awNLDgkbcxntG9TkBlcBtSyfZ2sh/DCmHunHgo2KvoDFUZLTUX3ZLjGL/XkBa3/Vai7X8bI1tfE0HFNdhMF1k6P9O9umoVoZrTk+/r2PEsuNvSvxIEnnuXuTZfAP9pKzZ1yPD9R/FO3/YM+3AnqqmS4qqHF6oQy6WvDXQ5/goHBs4ecSucN5am0ko6LCg1P8j5QlLfz6NabC7rnQ8ywyXtWS1jpIJvHGkhr6Hyat8x3VvQugo3dZrZBjUVnTEUriq7b++sQ1pc5uhaPmlbMwPjmaV2bIPkvrfMMD4TrsqY/AHInFzf5HPhIrHpMBIGumzKAbtvHa1072
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39830400003)(136003)(396003)(376002)(366004)(66476007)(66556008)(316002)(66946007)(83380400001)(6916009)(6512007)(478600001)(26005)(8936002)(5660300002)(8676002)(6486002)(4326008)(86362001)(6506007)(44832011)(6666004)(41300700001)(186003)(9686003)(2906002)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTOSs/ix5Cv1U0CqP5HVMssiAeDR7U0AYJ7BTbFYHFO5PQgOr2uT/QbS2NbN?=
 =?us-ascii?Q?CDcTy9hylzNeYDk2b+Bn24gbUh3w1P8doApAD4I32/hOahySmCiZW/KTq/pD?=
 =?us-ascii?Q?V/iX92k9a93aCYNq/7y1cUppiFXsUH/ctwza4DLfaR22zYOfpvvw7VSzJBVm?=
 =?us-ascii?Q?z8RVpyd5DkEWjtBWVhCHXvqx68hZCdgzXZiON9JGbGKL+VWqE56ud58179Jg?=
 =?us-ascii?Q?85cZkY1MzoqI6Ib/p52nJkgnMC5Xm86UylRLeOhDEFPXd2hF13BHnBEkqz3V?=
 =?us-ascii?Q?im9KsPSFOdf3EhSHzR3HbKgt77ZtKsCj7Fcugpk/9z4VZmYgVk4BvxHRNJZa?=
 =?us-ascii?Q?vuzBVw1jwSUyAVri1lJuaLZA7MJVbP6M0aQFMbXHP4A1tYAOMTcaknkqkBS/?=
 =?us-ascii?Q?+AAKRW3jDmLV+g+VCmElNZglKtV5PTeJ0GZDcvEG5I2nyPihmnflrZus/rv0?=
 =?us-ascii?Q?v74e84Dvc9tqUPucc368hzf6mf5G4l8nbkzyJ3MoQ1em4ViCXwZH2XF3H5f+?=
 =?us-ascii?Q?7a7b2/5PJ+Wjv2AT/ilMvnLVpbc0sgeUCGjqk8X257u+WrbL+UUicjoeVNLD?=
 =?us-ascii?Q?pGMjwdmvWLMVs43z3BxujDXeZT3aWP9IHuEUglw439vQpN6E/OhFqFFgZREc?=
 =?us-ascii?Q?c1wFLbIYI2aWUr+cxgysNrz7sFSk/KwQdhdA4HKg/bcjsOL/If33/s6x2W1w?=
 =?us-ascii?Q?n30aaWJZYbzC3f3f730PSfF6Wj09riNj60vDJs1dc7Bw6CP4Jv9xii8nG0J3?=
 =?us-ascii?Q?ZHoR6jsLXofoj9lyyTtX501tFyHzsIuyWTBCGrQDUFYaNuNEW5SMNQ3mV1Dn?=
 =?us-ascii?Q?2Cr92DNeOHy9/oeKf1xU81K1KjarWcWcmG/GMX0wA5pSbeaJLwIViqMZh0VF?=
 =?us-ascii?Q?t3djEM7Kqja5IX07ZF5DmCDQ3cGVPY9EtB4J5spDFkyt8nzII+YLOOR33bv7?=
 =?us-ascii?Q?hxCgpDNi9hzjmfekBxhRQXSawV3Pzu9QWWl0gJuTrQ7ojogIR3ixyUGnOQn3?=
 =?us-ascii?Q?dpCUqdKaZyJAIZB7oLUpmSagu0cE2zwcw6mERRcf+o7giG70awIuy6wV17Mz?=
 =?us-ascii?Q?SWoLtTDehSqAYfu58sEx/MCWtWLeJZqfihj89MCBh/beQhqtvOS2291v68qM?=
 =?us-ascii?Q?09w6WZDQOHVfdChUdvXKsCVpi25K293E3Xf0zynmcd33qtRFv96g5r3jLtR0?=
 =?us-ascii?Q?uVRYwr+EwxP//VLtRNK9HSAn5k2keTWdVGmyyeV0clJR3AX4Rz/aWOghAtGV?=
 =?us-ascii?Q?cvu8oF1ecSCYbhPlmssdULTgRNmYB5VX2a9B5dPoczmOg5awBPA1pv8Gz9sL?=
 =?us-ascii?Q?DSALYQDTwzmzRX0yRUUsx7cXg8OyxoO/q2i/KUTgpIdzpclaZuSjftPQETBf?=
 =?us-ascii?Q?nTUfxAFwcVPw4Y4HUo6LApdq69nP0j6S6BuykgzMaauDijIdqD5bxQQOKETt?=
 =?us-ascii?Q?27GZAA1tBCYSjc39Ksmkoj8RfUOg2prDOPWUA2WB2t49IZxNGmTjqRIIGTVk?=
 =?us-ascii?Q?5jaESV6uFw4KF/eyQL6/6GzHuY6BrANHUhgIjqJK5EdcBiNzR24Gx8e1vkVq?=
 =?us-ascii?Q?YON81h1bk39wtue5hNmXVA4q/KTe8zgdBESLoETGEjx55jUlithdxbqou77M?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5476d0-9981-45d5-76a2-08da611eb141
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 20:16:07.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTdd/A06jV51q7WtDxh3EF7CxbMxEk5IgGLAy5FxX98ZhkyuxHoU4CIjw1H9DCGeVEPCsubfBw9ndfEOSTEehMZqDCW6SlQ3s60LZa/otb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:55:10PM +0200, Horatiu Vultur wrote:
> The blamed commit changed to use regmaps instead of __iomem. But it
> didn't update the register offsets to be at word offset, so it uses byte
> offset.
> Another issue with the same commit is that it a limit of 32 registers
> which is incorrect. The sparx5 has 64 while lan966x has 77.
> 
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 10787056c5c7..d88d6af71e46 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1334,7 +1334,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>  	if (info->pincfg) {
>  		u32 regcfg;
>  
> -		ret = regmap_read(info->pincfg, pin, &regcfg);
> +		ret = regmap_read(info->pincfg,
> +				  pin * regmap_get_reg_stride(info->pincfg),
> +				  &regcfg);
>  		if (ret)
>  			return ret;
>  
> @@ -1368,14 +1370,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
>  	u32 val;
>  	int ret;
>  
> -	ret = regmap_read(info->pincfg, regaddr, &val);
> +	ret = regmap_read(info->pincfg,
> +			  regaddr * regmap_get_reg_stride(info->pincfg),
> +			  &val);
>  	if (ret)
>  		return ret;
>  
>  	val &= ~clrbits;
>  	val |= setbits;
>  
> -	ret = regmap_write(info->pincfg, regaddr, val);
> +	ret = regmap_write(info->pincfg,
> +			   regaddr * regmap_get_reg_stride(info->pincfg),
> +			   val);
>  
>  	return ret;
>  }
> @@ -1944,7 +1950,6 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>  		.reg_bits = 32,
>  		.val_bits = 32,
>  		.reg_stride = 4,
> -		.max_register = 32,

What happens in /sys/kernel/debug/regmap/*-pincfg/{range,registers} when
there's no max register?


Should it be this?

struct regmap_config regmap_config = {
    ...
};
regmap_config.max_register = info->desc->npins * regmap_config.reg_stride;

>  		.name = "pincfg",
>  	};
>  
> -- 
> 2.33.0
> 
