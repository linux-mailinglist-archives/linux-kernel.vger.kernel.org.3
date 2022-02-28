Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD14C6614
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiB1Jt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiB1Jty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:49:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51420F7A;
        Mon, 28 Feb 2022 01:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA/+lwAndZt42PJfmxt7akP6rJ+UOTui33AJF4ePKp0fGMKRj8T81S0/EEfO4G0kI9kVX/tT3gOeqGsaXBxc3LJre+b8Z53v/DS5YmLNQlYk6WBF4BSThZkRhk00eMtZdxU7G5+n0AYqUbECcPacSrro2LcYzfR1ngW1mNDfVQHs49zHRGr64upqXyqj7dCqInaEBQJyx9FYvuPxFQwi4DO0zSCIRlHxB4U87a7XfIFE/2n/ZE5h0zS/Ugnp8W8MbSR+QJDlMjUy5lG0QyHmjI1AD/ZsACODw22VNbEDzFY8TFm4t1Gxvb6l3LTiDMRa66O4iCrFhni8MeYecM8uxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ1QOjYa79p3eOFsqS+aDOxQXYZHRMetwVr5fmkxWeg=;
 b=OhUAyRSs++Nk9MuSeyMoPdCFE8/4Mj7ywwrVuJ5snQSaGL6Yxwr4gj39GeymvXbpFPpc1w436eh9gAcQ+IEz0h67tuKCycAgFk8CYTMuuX6VjtW9F5J2DL7jY/b8RTNfZu0VAVS+Q3gU5Xz3Os3wB6gEWusAGl8/GBZcLqA8pTvWhq3fkRFG673EOBKQS15TgrmzVc9vkYzFFe6W7g6Gf6xfyMbTR5NMRLB/yO2fIxJ3+A5jMpqcFNUZq84F2qlLyJSqwA5EcBy+54jUNfC0H7Tmyy5FQ7S/4TtcGxVxjz72MzLlSEAgjXjVfiLukHcsnICg2t9eBo4uOMKzwsZ78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ1QOjYa79p3eOFsqS+aDOxQXYZHRMetwVr5fmkxWeg=;
 b=sYwLyi4nS0bbchceTfE6wbAzdp2aeNpeEtGhUimrWhG8VUcQims3OICq4bJ3LrLxitA+L8mPCTs/H0ABwtC1GRm8a5jnwGrjaqYz3EfQdAg4clFlPZYfjh2Y1wEaFpWur98d6cqUytbBt3lOqwGxZVFH6tAs8bfULgF2/J07YTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 09:49:14 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:49:14 +0000
Date:   Mon, 28 Feb 2022 11:49:12 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx: add mcore_booted boot paratemter
Message-ID: <YhyamBQWfY+2LOWF@abelvesa>
References: <20220228061150.3006113-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228061150.3006113-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5090dc-ad16-4357-ab38-08d9fa9f93ff
X-MS-TrafficTypeDiagnostic: AS8PR04MB8166:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8166934ECEA56B8339F61F6EF6019@AS8PR04MB8166.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPdgv23/Tgv+M3Stcy9odSL+qtH5MK2jR5il7LxkJgbpPEePvMX2/gvuwxm2DZI6QK+TouOAuPKYi0EOKT8UCfWFoxbgomH6IxJeHyHFJweIhH269K0MtmNAsCoaJC6l23jK+Uaw+5wHZLeaHlcOXRNw/xSCqrLWuYoX51wWisiRQPO2SRjjOyPVlM1xV6jPi3+w7fMm1nXePRl0xqZsdemBRgKJ2hT5jbV8jPspRh7mZ2MzYJHjFrQU2q7PDecuQW01HLB5axtLiLHa6MFyTOGoW84fYwOQ1d0fJoiPj6uQTxsqPpXmsIhKTkaoPSOiWvo5iYsc1oCSIrgyxg8pqStJ9bcRjy4qmkHSVgFZ4Yl961NLiOglhrzhnjdsPqgLmnZ2fXFcKXhXBNEhYdssCAxOD7KWVAjxrpqpo6/z2MD5Q3LZ9o474zxkWbmyvvKsy7ubKu6d8upidhaYNTeRUfCUijaLanVl16y7aHP0CS9a17fqqi9rp4pthDQgB0zW1yWvxJWJMXVdVlWFicNmPhZHI7SEVoZVhrnTPh2+rNLiM/84a3OrCLuUNwKhqMK7ONSDSUNBUt1SgIAljn/G0efDB9dFcvw7tlqWglaUi/wgg5cUkNCBPse+UOHZJUwVflVdIATVvUypbxCFgiOXTKKcCsOjB3HxxBUD9Xx+o/XRSDYYCHCANrVcycuw9OZJzKpLiF3D+gIwRz9pHmO3ia2Exlspx3N9XIUn2kQOwCA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(508600001)(33716001)(83380400001)(38350700002)(6506007)(44832011)(52116002)(9686003)(2906002)(6512007)(5660300002)(86362001)(53546011)(8936002)(66476007)(66946007)(66556008)(6862004)(4326008)(316002)(186003)(26005)(8676002)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZD4gGROUXeIOfOVMC3a6DqGKxhYT/hET6Le49erRUph6uAZyi5q0AI5Jd6f?=
 =?us-ascii?Q?O9tPNkylZn4FFbYBw0wW9fgiDIRBti1c3xH9ZkfiF8v65nCOMtr6Qup/c5Mr?=
 =?us-ascii?Q?54jjP8xyk/t6RaYS8Mki1leb3S0nDGphXJFuSXu76bvVy0Vp8GWKiudHr9cF?=
 =?us-ascii?Q?WmD2iGjrh9nkfUWDTpsoQgRQm3MlcdiInORR3PyL84JCwnnZC4vBkIQuWAuE?=
 =?us-ascii?Q?UKRYSYD8dafYO03lqvowo/FRR1G0XY07kad9vd1VpuSj0D0xkIDrdLP7oGeV?=
 =?us-ascii?Q?VauyyjXWfLFPYQW7mBuPFdq92R1eM6RUTqow/h9WWFweMtlXfZ8hZtksNb7P?=
 =?us-ascii?Q?FQZrGiRBttjdDg+drEv0efdDlvszrfJScjJzu4UgDdEI65TKfi80waJIirtg?=
 =?us-ascii?Q?viCbVPjarS9htmLkqesa+n7HRP2Moft+r+YQKXQ9y21g97NsBi0wXh98fK7F?=
 =?us-ascii?Q?+qKx97Adkj7izdIYk9DLeBvMycf4xcS7u66IGw/ENzJT6sQ4pEJlF3v96VVo?=
 =?us-ascii?Q?/emKOjo1dauLjSAwS8Up+i+h9IJby6Cacc9iOn3hIS5rGZ8a8uikG2yeVa3U?=
 =?us-ascii?Q?XoyflUXP+7oXsy0QD5P396dwoSIEl4eXNIMJLwkWM9igOAH/C3wRY9sqjCwB?=
 =?us-ascii?Q?6nBhMXtKShYFkdA69UrzN70KQv9P5VnEmWKi1v5ioC+NhCc+r7Xpom1qrn71?=
 =?us-ascii?Q?OuzzRWD0yKKoP/4rTlVmcS7SeEBym5PNs6if4KJc4cw6MBtMHw7g7u3myRSO?=
 =?us-ascii?Q?/GX3D+Tk8+15FSYPLxiaRlH+NkYPySODmi9SDUN4DxtbcIjx42zwVhdee1yf?=
 =?us-ascii?Q?/5zHzBNxe7W4FSCmhaH5/GkDy0eyRchNONcBptdqHEcazHlukST5yvJKIJAP?=
 =?us-ascii?Q?wdTKtEZ9+jy7Dt5CMPN2/bRU/3xaupUHf4KOl9UwqAEOo2Uk0iHwlC+DN0B5?=
 =?us-ascii?Q?BTskti2gAgYcp3T/Goy/5MP9rm63GO1cTHrW/kYdw1mqwlaV898/yKlajDt/?=
 =?us-ascii?Q?+jT4g9BE3PmUuaTAwPFKerYsyM9ZhW2Y+pwa/NToHhwmKgfdCef8QN8Yc+v5?=
 =?us-ascii?Q?mBNf0tTBY2tA8JmfYMq97iq/4M2psHUOosclHDcrqZ+FTR3qcVMHGurLFTUD?=
 =?us-ascii?Q?JqSuHt3rKIfPD2Eyf7z/jXvYb3x64sJqXfsR8ijQUR9Hu0DDugUqvdBLUa26?=
 =?us-ascii?Q?j16c0SjT6CZke0ZskkPXKCiC3jI60XrrOYmy6EXFXs+7eAJvrmbWJuUQUE0i?=
 =?us-ascii?Q?+KY3yp7AB+koydNuptWycFZPGRngVbW+SAhiz5t0YFx6toISgdEl1BKp0Dux?=
 =?us-ascii?Q?MbW1rBfCjCtytcXBOBwYrILbdhiVRZQaniDIVoINVInOx1iWyMufy/kH3dPj?=
 =?us-ascii?Q?g+QLZvJBnq2QhZUCi8APel4i9iwUAHp4AG2u3wG52cOIcveFtte1J6HLsFa4?=
 =?us-ascii?Q?x+sqlVT61VVbFhQ50UyjdDx4mG5ij+Tv8xWTitGS8G9TLmDhoOUS8FJBVdKT?=
 =?us-ascii?Q?uY4TB6jImx9dDgzN2Y0FY+3ASD/Erlxu49IqsKV3wc7h1q7RAI/+4za5SzqF?=
 =?us-ascii?Q?bYVmKxiGGFJ7fsLlAZ3WcXbm/vlbMO3sBbk/l1cF4twD/3zdiztas7WmsMdL?=
 =?us-ascii?Q?3lqoatkwwC5+0rRoO0tzCmw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5090dc-ad16-4357-ab38-08d9fa9f93ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:49:14.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxealOvRLPJp5wQSr+e0gfA4/DpAASZqI5h7N8TGY/+b/dttKuh/zjIv4ywUr4De2ie8V4PSaWIW+v4aUiZdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 14:11:49, Peng Fan (OSS) wrote:
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
> ---
>  drivers/clk/imx/clk.c | 9 +++++++++
>  drivers/clk/imx/clk.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 7cc669934253..5d3ac59b382b 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -146,6 +146,15 @@ void imx_cscmr1_fixup(u32 *val)
>  	return;
>  }
>  
> +bool mcore_booted;
> +
> +static int __init setup_mcore_booted(char *booted)
> +{
> +	mcore_booted = true;
> +	return 1;
> +}
> +__setup("mcore_booted", setup_mcore_booted);

Lets give module_param a try first, as discussed.

Thanks.

> +
>  #ifndef MODULE
>  
>  static bool imx_keep_uart_clocks;
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
