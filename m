Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07D4FD3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391204AbiDLJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382358AbiDLIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:25:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140047.outbound.protection.outlook.com [40.107.14.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B45A16F;
        Tue, 12 Apr 2022 00:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Epi1Eu8E2vFELzsVjwOnN52giyuJgv3zCu+56IGva0UeYGpVgCGtWcnZZYaDfpsOAN4InnkZP+uRNd8mOgOwXVvRhfr2eDPdRP7OlaNsSkBKTM8MQRfIaEPlcfy+Ux8SLqaF3pHRqu+Y9vRfyf3KjnzpHeECdcH5z1AKT25ioRH9U+SPEIuobHQgK6T/yj8rUI28GzzdndfA9K/h3EfFuHaKi/A6mU43cen802TibMYpQaEli+77rRGCqwS6xy5CFPR5TQ/mTV6T3pkyd9YQ1gy0ia10yykvcGz3KQWfPk624UljA4ZAGognxwgWqeY+J9rCDrEngvFlyFoF8eBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN7SgkzzTm6W4WlfBQ1qpa8f7m7eVMAWARIJoyo8Ofk=;
 b=Q7RXFMK1eKBeJZFceZdsQXmJgklnwNxIUu+OXuoeY/u4kRwwQvGA7DeGAe3ENUEE9JF3G+MX9aDvl3mUPlxt+E/5gE3VhNy49qlqdRO9AmKijbQY1hKBFfeSOur9m2ld0ZHPvXGeA2LZZkqWT6ZbLdAipBaCKEiLKmETOcu11RPT+56kxTLK2LiDgsDUkzFkd86lm5pEsHoHCDWtHCjwUOcb2NRafDCVQe7lo5iDk8RBnxTRWSHqjhdqAId+Fs3g9ZLTQ5DHUccakk1YpqFL27dhrqQTGDysMepByrgk1uabpMI0XxXxVOEF8SXhcK0k711ggxstJwpuN56kbHOxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN7SgkzzTm6W4WlfBQ1qpa8f7m7eVMAWARIJoyo8Ofk=;
 b=YVCFgc8HgnWMDxQ8LaowHwa9YybcHU8o3ypCbxZkl0yQMiwS7pC9SsPVqkLEFsV+9aWqsa95PLsgTJayEY3JRghyo5YvOV+KVXwr+daPelYk3q0Yuwdkfk0Ye2YTDFIKU4piPlAWtXTxT/+lqIA9B8Z5+C9POMfWgdDqKrEPtfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB5395.eurprd04.prod.outlook.com (2603:10a6:208:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 07:58:52 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 07:58:52 +0000
Date:   Tue, 12 Apr 2022 10:58:50 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/2] clk: imx: add mcore_booted module paratemter
Message-ID: <YlUxOjpk3i0dSxGR@abelvesa>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR09CA0122.eurprd09.prod.outlook.com
 (2603:10a6:803:78::45) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c118664-91cb-4819-ccf2-08da1c5a48bb
X-MS-TrafficTypeDiagnostic: AM0PR04MB5395:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5395B67EAFF0A3200C06630BF6ED9@AM0PR04MB5395.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpBfgCe2g61et4UrVuiSiLvanueAz8MZ1XVspcTXJQl1CSnENylevw5GO066lalZ6kz9UUt6neXxPaXW1ydr1VyBsAb9P0nvBH09HH6Pr8M3A6l+9VAALKh1SrngIXK4S8Exo7aywDPkmdo8bpBashf/LZOj2afJCqj+VbXe6CrnzspAg+Lz6hx4yaxd7Al/67rytm/nZFgk115OqCVadp4Hg98QxnZXFlmx0ep6I+CgOjQSAAUsEoWGFtCSTTt9Ar/BaUUKqlHgdLF1pkygDCZuqDtFhhPsVjHqvn3O6aSkb+s+Olf44a1NW2CpLA/XRupZtkyktM8zQkp6LcI75Xl3NDsiopyc198148hIN+j4g7PqOwZ5vIBwIeMmp8AviY2TKiCWkEH5eVQHKLeW3bO4I9r5W1E1/yTeakM+x5Owp7WZLRo2CAYKw8LRbREvlQVV+/dPEO3066y3dW20lf5Wqo8VwP8axYGFfApDmcIN+vCD43cnmnBviy8jnYG3APb5LqjdHD/ezXM9mOH7rZkMK04Kd4wAXMYOupBjfP/Ell7flh6b8LcIf6DCJvwA7jFyKIUnttOn0AxK5IzIJ3FDU+j2jy/r0In6wewz9hU/4DJl00yjtNXGnBSuiwrVeVX8nilOemHe1sMk4u/ovOGm7PPA4OyEii0eKAvgQ7/0/v2EDcNon46RQIGMY7yZPma4YAhw9WTg4sh41YLasw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(508600001)(83380400001)(86362001)(38100700002)(6486002)(2906002)(38350700002)(66556008)(9686003)(52116002)(53546011)(66946007)(8676002)(6862004)(4326008)(66476007)(316002)(5660300002)(6506007)(6512007)(8936002)(44832011)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4icPPtv94x1qRfFh8yRTk2J02oz7e6wbvN+goTv56OvKUqOBpyMtnqJ3p0ru?=
 =?us-ascii?Q?jqUeTg1O2Ue4PD7mzfQ8OfTaqLktRAY0Nd+9Y5hsXkLzXI1Q+W+sHHhd0IUk?=
 =?us-ascii?Q?jX21qGeRmQ4/olwo7CdusqGlXaMjuIl29ajVph8TlD65A/5GIQ0i+DAyHZJv?=
 =?us-ascii?Q?RsRuIa0TsHpctYZGK20D6nEPoB+DEqqc6zxzBIIddd17KzbxyPVv4J9tHMPC?=
 =?us-ascii?Q?5b0hLUbAkpvsAjTgAR5W3zZgJdVcNwZUFb9OA0aWl+5ZOZiagoX0zsDGu3hu?=
 =?us-ascii?Q?LpEpxgsTtzb+YfQO2wUm7S6gvhPLkSalmUmmpizaqHoK9SK+sl2dCS2Ls4kS?=
 =?us-ascii?Q?zYI3veejCy0GlwnH/TRsASoAV8diItEABS/+xWjizG8vKXbKK0eGWGOgR755?=
 =?us-ascii?Q?42fRSup0TrB0IWnm9jdz2o7rpqBv+9x9TzM5ZvFJ8Hx2jxFc23EwzsYiC1cZ?=
 =?us-ascii?Q?P3gJLQoXqmcBL7HhB26nxpqCB+r5LKBQenl3hq/yMZanbWOKpUH4N8JbxZMi?=
 =?us-ascii?Q?RGIzW6etBV5yGUgezIPy25q9UA+XTKC1BHnnlW8iCs9J6wN7oPZwjMXsE+mD?=
 =?us-ascii?Q?T2aNe6WcyPhuTj2Y8ewHKVwYz3acfKm8lztCnErBP9bKPsqeiieSWD2y0SNp?=
 =?us-ascii?Q?hKMdidendwKtBaNsUNPMSn2FG1G02Vzna6zLokGzRbpBfnhto4/lszUJMAfV?=
 =?us-ascii?Q?l38SrAxXNKo9jO+Jvg674B6iCn+TbbTWlxHFeq5ezaVgKCjgJLzyQA7E3swk?=
 =?us-ascii?Q?Xuh6wL/RuAYQ74xyEeGz+mwzA2eOap1/LqEnGcrBz0faM0Rd1BkDbif8uqqO?=
 =?us-ascii?Q?zYBV1j4JnHEAcipEKn2/2biPghAYas/iZ7I63t1Wgg9imv4WTdx/ASFJxtNy?=
 =?us-ascii?Q?pntLxKIzGxdI1srXrUuXGK7zfst8OWrrFO+6yUqn/0aWwNVrIUi6lgW7/8ru?=
 =?us-ascii?Q?122m9dOsgE7JH4ppoWLUmc/jUPwfHlEV4ExcmPRFQQkk65S5AqFCuMnHGF23?=
 =?us-ascii?Q?mWQRDcCHAn+pDyxs3gKKbkXm+FQItlG+2iCZQffXePRgvm6LAy6J49GizjNw?=
 =?us-ascii?Q?Etjy4cue6ERVUbNmhlXiki5gn35ZNhsH0llsV5YW/HUd2dUFVU27AONzC4WC?=
 =?us-ascii?Q?38HOslOFHB7Q88RjFyOdRDtDIBbrsJn266KdTgXPlzjS+xyBNx6UWvT+luzw?=
 =?us-ascii?Q?ME7b8D0uucx5U67QxHHBAt1NCnX3CntHkH+jq8Jen0BeXeRKClf58fbz4zfK?=
 =?us-ascii?Q?njpAJHkw+2bxc6jizTriKSXz3UDZcNXKu4aRcOnC+zLZFYVG8slR2EvW1QUq?=
 =?us-ascii?Q?CFMXhhjBxmionCqddS1Zf6d0TA++Un0F7ZK+sDTrp9nXhV1NI+K7fSngB4Vl?=
 =?us-ascii?Q?3kBQAibhlvvULm7TyHq4Sb4QoYaRZixZuSCXZaf85+tRXlex4eGJAwAp9m3v?=
 =?us-ascii?Q?7SBWEYo44YeqJO0i74JmqQx614WIiJa+d/4B21J1ibsR1pwVaP9QFF+pdA47?=
 =?us-ascii?Q?sZ7s1o0ivcX3aI+6tFEQOXydwnMJ6fuHVNRwEBqMfsWJLUGyg4jo0tSDAqnq?=
 =?us-ascii?Q?0mu2sulaJyp4++MUk/JG02UOoB97Wu9QlMu66finRWglBLGygJrvdq8gvPDm?=
 =?us-ascii?Q?vkEEMUJZAz5bvQbXUljlkMqQE2y0RDPYaABrF4ULD6LLOd28tqEr0Y7OFOXz?=
 =?us-ascii?Q?+3/GE9AbgrADFDwNNaXY3BuaCzySyVy1Ss7xnzDCeeZymz5K8SiAhYrnRlvF?=
 =?us-ascii?Q?GH5Yghfv1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c118664-91cb-4819-ccf2-08da1c5a48bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:58:52.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoF3SW9ATaZmK5ryXGuS6lDbN4/6e8a5HEtRn8pgyHPSi29TVgkFZB4VOhJ49ufqLZUK5u9BRSkFyga3IGmh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 20:41:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add mcore_booted boot parameter which could simplify AMP clock
> management. To i.MX8M, there is CCM(clock control Module) to generate
> clock root clock, anatop(analog PLL module) to generate PLL, and CCGR
> (clock gating) to gate clocks to peripherals. As below:
>   anatop->ccm->ccgr->peripheral
>
> Linux handles the clock management and the auxiliary core is under
> control of Linux. Although there is per hardware domain control for CCGR
> and CCM, auxiliary core normally only use CCGR hardware domain control
> to avoid linux gate off the clk to peripherals and leave CCM ana anatop
> to Linux.
>
> Per NXP hardware design, because CCGR already support gate to
> peripherals, and clk root gate power leakage is negligible. So
> when in AMP case, we could not register the clk root gate.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I agree with this approach since every other option complicates things
more.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>
> V2:
>  Switch to use module parameter, tested on i.MX8MP-EVK
>
>  drivers/clk/imx/clk-imx8mm.c | 2 ++
>  drivers/clk/imx/clk-imx8mn.c | 2 ++
>  drivers/clk/imx/clk-imx8mp.c | 2 ++
>  drivers/clk/imx/clk-imx8mq.c | 2 ++
>  drivers/clk/imx/clk.c        | 3 +++
>  drivers/clk/imx/clk.h        | 1 +
>  6 files changed, 12 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index e8cbe181ec06..a452fd1bb891 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -639,6 +639,8 @@ static struct platform_driver imx8mm_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mm_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 92fcbab4f5be..dc69b7464b3d 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -594,6 +594,8 @@ static struct platform_driver imx8mn_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mn_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 18f5b7c3ca9d..250e45d9f844 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -721,6 +721,8 @@ static struct platform_driver imx8mp_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mp_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 83cc2b1c3294..33897b56130d 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -632,6 +632,8 @@ static struct platform_driver imx8mq_clk_driver = {
>  	},
>  };
>  module_platform_driver(imx8mq_clk_driver);
> +module_param(mcore_booted, bool, S_IRUGO);
> +MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>
>  MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 7cc669934253..4bd6ad060eea 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -17,6 +17,9 @@
>  DEFINE_SPINLOCK(imx_ccm_lock);
>  EXPORT_SYMBOL_GPL(imx_ccm_lock);
>
> +bool mcore_booted;
> +EXPORT_SYMBOL_GPL(mcore_booted);
> +
>  void imx_unregister_clocks(struct clk *clks[], unsigned int count)
>  {
>  	unsigned int i;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index a7cbbcd1a3f4..5061a06468df 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -7,6 +7,7 @@
>  #include <linux/clk-provider.h>
>
>  extern spinlock_t imx_ccm_lock;
> +extern bool mcore_booted;
>
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
> --
> 2.25.1
>
