Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88084FD39C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbiDLJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359485AbiDLIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:45:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8D60CC0;
        Tue, 12 Apr 2022 01:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTkEC2zJlDTQc+HcEkJdIRowf+U1qYK39ltlfs3m6FcChKGGnejZSGOFLKB5KeuvZUXHiuUDNHfonDr7siSBd4usLLOSn2JTJ23LiSTLjC67VHnZ1uow2k10niNtv/X/lGRL1+cGeM9bXVobxsIVUOhRykkRFZKcLFkZtbzRcJXbkDxv35Sq75/S7DVfPdDx5iVfiwJ0+nEQHdJ7svvE3KiOjgp7pZHCh0Rfql7pU73T4Pv3EKEy9W0BVgCGL5pm669Ru421QltCeGJajpDoSBfEPPWCPG6rzVTTO9doOriaKr9F6LBHsPM0RoqBZHp2mV/ewR2QNArn2Y+BuVYI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wc1s12xJrtM2PYuyEeKkllwsn2/aBkJzXjMYbDu07c=;
 b=XR62j8t7C00pIcqnmdMJJoUh6SH10vPiEqRSekZ8ZxptzzD89yz+0O2BwAUz1WPVDVpWcEG434jOf8fqqwy7CNmaqgn8mX/zkyKelvsPfPMlXKwvWgx24fSGNZpKrbOLJt5w9I+8E/Iru5Xs8CPx+jaoV65ewQjnSVIt5SeHeQD/nJhCG0wE+6adh1Cia3NcgO6ZKesUArQOw895wIVSqbPeaVLhNzJLkbDwX/YG0ZCnYMVp+Z7FYS17+GhDSnAeQYCtWhR7DBQXokDiJ5TeGUeYz2xj41t/MlkSjf/dqqZZH5/0YQP9EksBTESR74Tzdx4le6nS9qZid/ljf1f3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wc1s12xJrtM2PYuyEeKkllwsn2/aBkJzXjMYbDu07c=;
 b=DZOTjuk5nuEw8Pd4BEh5jxxTDY8uYbiYtTov31bQqHnNAd+RCj+MCw1U+VU/XU7eBcljOuPYarziFanI9/N9+xplqu0+6tm8ImXy3JXfKntQJwEvyhD5iEJD/LwYylhGCiUxx+q8IH8/0fWn1brlnSrUSJVHnbnzXCVKhJCk0cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by HE1PR04MB3209.eurprd04.prod.outlook.com (2603:10a6:7:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 08:11:19 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 08:11:19 +0000
Date:   Tue, 12 Apr 2022 11:11:17 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/2] clk: imx8m: check mcore_booted before register clk
Message-ID: <YlU0JRrInWbCiylZ@abelvesa>
References: <20220228124112.3974242-1-peng.fan@oss.nxp.com>
 <20220228124112.3974242-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228124112.3974242-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1P194CA0059.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::48) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e10221b8-313b-4400-1aa4-08da1c5c0660
X-MS-TrafficTypeDiagnostic: HE1PR04MB3209:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB3209A1856407DF6FA51B6C5BF6ED9@HE1PR04MB3209.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtfSWFvRvVaJqpsxeiZubIN+AoNysbS6IkVHzIvqNTwGoVteaYHW0KWjHjojwwVwQ4mj9WInJcU0zRfKV+i4BSHRwkUqrVJBVJTzSFKRFj9RTX2UDt04/BIsNiGLs2UPvLGTT3wY73Miy78iQBndxKSyEPZ0fVwXj+7gW9+e/t5SJ+gZvKTzEWiYvR6QVFjyz6IeWCiD24yiRkiPmVWQpD0H0hEYOLNnBHrV26B+b1BAzy4le+CgHeM9gBPUf7SfKlVoNzDfoN8u88QVIEzx7vGsBbzycH555j8Vdi6+nt6t5zxYL1W+QTizFJVVIqbe9HJwJm7ZU8kY1Q7VJqgooXeWK4xiAEQlG9lSAZmDaHZde5el6mZe0R264xcYPZVI3bknHmPOgBCzOZOlCvGJw8XGO5brztplNBOr8rHnO/jmbcS45dCHY5XlIdV41J4jM0FSiNNmSc6Gov03S+gws22SC1pMqlT/yt8+LsF+qJHAm9vnFkwcFEL/7socnUl57V+OlWwEL0cyQX924uWK/R7qsiOtyx0lAei0FrAtmvSWc74QPyfAvab6pWPC91ozkfZbppD9a2MVjB156VDnBtO0VZ3RnQMB0YSCSQMsYtTfpGwOS1CU45dVph9+ga7ZELvtSAhedqmjvjP9+ddGpZX4k2i0aFNIuE1as1Em02gg7sXm5RPoBiBkHtpcCkj8jTYc8HofyIMn8v6lGkjnchOFvouBsJGYtC+SXpF1UZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(33716001)(53546011)(38100700002)(38350700002)(6486002)(8676002)(66476007)(4326008)(66556008)(66946007)(6862004)(9686003)(316002)(44832011)(6506007)(508600001)(5660300002)(8936002)(52116002)(186003)(6512007)(83380400001)(26005)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPC1Tbswn3oLE/s48Wpvlfsm+q/71lkfOtj40AtWhvBiNNW5rcT7IZY84KQj?=
 =?us-ascii?Q?fcHaQ6l319QTPzShj1Cwq7ttXVh6/rIVYf0d+4gzCq0HJM6B3IZrl0mVRaRq?=
 =?us-ascii?Q?RkH0XYwCjH5eujM2lKFXT/WoTGWzDlKtBjS6Yew9a8PnNlEEXJ2tDd0Hi2zV?=
 =?us-ascii?Q?8lnv8742y53/q5T/2w6lqfL9Lerd/fFX8nFuEj1VfH8bkv0JPyftoOt4Atyp?=
 =?us-ascii?Q?8l5udWdZVmWDNXe9lGqPnrj8y8JZ0HDCiITyZ8jdadrh0dycchgnOnjaEe4h?=
 =?us-ascii?Q?DN20KTbYAQzMClRVMIGDdldBg/NeKsGiBPAfbC0WH9RitnHRmfnsV1MY/HW6?=
 =?us-ascii?Q?ZnerEJm6aRjt6TJS4xED6eKhZsNnIaczzuFxwg1ze0SA7hcRWu6R/7XDxNy8?=
 =?us-ascii?Q?q350WM+W84zQxvGNir2XPpNw//rb7ab61PxnR03Y4Gy3+ZIlhEc+DzUFdOU5?=
 =?us-ascii?Q?EItAP+jEr5C2AlHMRhgkyvwGfiAlYRBiyjryzoZo9bv6YzjsjseW29a89Kd8?=
 =?us-ascii?Q?YLWhoTQGKhOzdi2h7Lda9ak1vjhNcsjmIg1tUQXXwPALiCX9HeksN7LY/XUD?=
 =?us-ascii?Q?NwN1sjaBURt9YAP6G+WespCXME9SMILCA6UZD/bypGJ73Wq0boJ98ENH9Y9V?=
 =?us-ascii?Q?sTIU2yRcLgOzTQJOoxpt95qRxuaVj6fAZ06Nwi7ZSuTNeD4n5PUZCCiGk+ta?=
 =?us-ascii?Q?7IBpiUu2C24SNNNzjujnTYIP/RgmmSNteGffjWJ+9BvAdckn3eoYfMkKRDcz?=
 =?us-ascii?Q?X/yl+MtCgR1fEGu+578OMajwHeX1D1y8H82tQeHk9mjJxm684pOWevSZT7xh?=
 =?us-ascii?Q?mm74GUNHaAAouqOtonVTfEX/WEF6hztOk0c2nSqzdmSC1KKgBibzD1b9mkf5?=
 =?us-ascii?Q?D4l/2ewtetshwOpbWia95XgINZ/T89haKaenhNpr9lI2kC8MCQQJj05NO39g?=
 =?us-ascii?Q?TI5JdNMQ7rKxHr8mos7HUlVGJtJfI5DBm/efKQ/13SFfYHoExlK+/2gRyK8J?=
 =?us-ascii?Q?9GFwizYXITxsBptzB7sSFdcqqD7tT1gFKBCQ+Hi4SsJmz5ivrTfJKqr69TH4?=
 =?us-ascii?Q?EttgVQwnQctzhjP5VZaRua5wgGHDjVSkymjz12/9cfHmgtyMPGbrtQvfCDbL?=
 =?us-ascii?Q?CX4XmGblDjnEBLDDjFvQgceBqOhI9+/QhP4PEtJ12TUyrFFJd3zBF3vWkUnc?=
 =?us-ascii?Q?/Iuo7RTUZQPZ3nGUjdzW6OdxJ3ATVLkFKRA7H+Eock2Kvt2SrTSHkOZIIqsR?=
 =?us-ascii?Q?274/guou+1uPe8dKX27pkj40nctU3nmaJcUaMUefvd7Nu0NtkX8NThp5XiIF?=
 =?us-ascii?Q?KcMs94F67/q/A/kbs7ydB7J8OW9tfSngjqYgFyuXgGT99J9B7xlw4dN0fqZL?=
 =?us-ascii?Q?OgdagRu8T+2HPm1LKOKTgUVwiW0JZXuvqviXNcivAQAjftzFc89DxtwQ4P/1?=
 =?us-ascii?Q?afCdR4m07aTFETfcQ/a+TW9FEBc/vAzlE+cTingb7y2S/bz8iHWwVQKDAzro?=
 =?us-ascii?Q?hMOjsRvWoNArWY4PTI1r+0yl78+vs13yeuKkCvngxdOwMUVc8z/3N0GaOuLQ?=
 =?us-ascii?Q?58py4jPFJfpcyIqq4GYpCQDHpkkOl9PpCrVB2+BtE9pcPpUJePN9zNEm6Egg?=
 =?us-ascii?Q?LZWNFmyol3pFtH4IZlEk0ZvMqrRzZruGtF8RkeXaI8T6dRuKgsZqrVF75bsg?=
 =?us-ascii?Q?gjznfd7G77BJM2g12FTTErxOwfFdjLd3fl+oYNvRapAv5Yob5Kz4HFSjig8m?=
 =?us-ascii?Q?2zikiirxnw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10221b8-313b-4400-1aa4-08da1c5c0660
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 08:11:19.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFtHjOLu3nIsMjW1UgnOzkgXgSlE6kSpwwg1roSEkaDu3QsfD27VlxbxGUoKDFzA53x7/a/4FdJOTFDJpKFCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-28 20:41:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> If mcore_booted is true, ignore the clk root gate registration and
> this will simplify AMP clock management and avoid system hang unexpectly
> especially Linux shutdown clk used by mcore.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V2:
>  None
>
>  drivers/clk/imx/clk-composite-8m.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index 2dfd6149e528..b16c2c0ea9f6 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -223,14 +223,19 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  	div->lock = &imx_ccm_lock;
>  	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
>
> -	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> -	if (!gate)
> -		goto fail;
> -
> -	gate_hw = &gate->hw;
> -	gate->reg = reg;
> -	gate->bit_idx = PCG_CGC_SHIFT;
> -	gate->lock = &imx_ccm_lock;
> +	/* skip registering the gate ops if M4 is enabled */
> +	if (mcore_booted) {
> +		gate_hw = NULL;

Lets have the gate_hw set to NULL when declared and get rid of this if
case.

> +	} else {

And then lets do here:

	if (!mcore_booted) {
> +		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +		if (!gate)
> +			goto fail;
> +
> +		gate_hw = &gate->hw;
> +		gate->reg = reg;
> +		gate->bit_idx = PCG_CGC_SHIFT;
> +		gate->lock = &imx_ccm_lock;
> +	}
>

Would look a bit cleaner this way.

With that done:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

>  	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
>  			mux_hw, mux_ops, div_hw,
> --
> 2.25.1
>
