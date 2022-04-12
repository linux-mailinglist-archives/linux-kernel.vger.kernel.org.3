Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3761C4FDFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353426AbiDLMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353719AbiDLMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:04:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BA8222AF;
        Tue, 12 Apr 2022 04:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9XHev++efoewEi8Ywk8cUpvTxim4fRx8gxUTS3d3m+Z4/8I9zOsTaQrkpPQcq8ottVWfTnWlM2R3NAkqL4ilt9UIAuTdI/PgqWeuUpIzIT19o7n/If5FSMSMg1WyzmDF1aB44XGygi94wtOSKitxF8XwrQ71QU9OwFxgBCoFMCmiqszbr90xJJCDZbPkCLAamhPivch+ThXnZtw0l4ZdLc6lbXgmIzMwti0KqD2PjiqEhJ15Dgdr1NLu4+U51//9FttY2LqQVA+eDWWkx5jiccVRrshO4dnK2pCxMAyuJ++bDL23YD7Z7qjlCqhIcalBJSClur6rY2wjt5q+5w/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob5IfYTtOeUXYzjBHpJzDWd7gd5oqu4U6wOH4wTmjuQ=;
 b=BLz+041LdF6CYYKSfFDiWAYAxgUhGUmKdFHoraMC73i+YgZRqrgFryZtTL9J8QYtjQZxAfUdbApjOdZKHa7RmkNtxjztb13qlPOdxRSOeP9umltWCPuSnlFk78FdQji22dHdQnDZn05jrP9mlcV7hsN1fWZgHLszgCrjdm/G4v3sul+C3eLW+JtBw8XBs2dtXcmotsNZhXE6PsBa4tGH6CS2aE4eImQbeG6CtnKRkpBAXg7+a0P7mIg94K4tkUxH15ZXdJgkUDyBga95qidk3oKQ5nr8Sl1OlSik2ShVK+oJ2hjaW22Z32c01HpGSOqHsIAo5X+nrcYioSF6CTdpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob5IfYTtOeUXYzjBHpJzDWd7gd5oqu4U6wOH4wTmjuQ=;
 b=n7VMOvvpb+GOv52lAHjs5Hqcz7gXCj13CUp/Hq0l+Z9I0yJmcIN92cLw3xSa9xLMwQiTIlhlkw8KV3jRLvyXKId/SvNnrhYD2sLwLOIxEDUF9gTrykwvs54nNq2Silkt9rkldgkBiM4k1HVt/wzqXfKFQlPSOodayrsPx6iWtms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Tue, 12 Apr
 2022 11:05:17 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 11:05:17 +0000
Date:   Tue, 12 Apr 2022 14:05:16 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     xkernel.wang@foxmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: scu: fix a potential memory leak in
 __imx_clk_gpr_scu()
Message-ID: <YlVc7J2UMhTc5Rkn@abelvesa>
References: <tencent_27FF59903EE6AB5C0D0E6D0A8E7059A59007@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_27FF59903EE6AB5C0D0E6D0A8E7059A59007@qq.com>
X-ClientProxiedBy: VE1PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:803:104::36) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c89ddda3-f567-4e4c-653d-08da1c7453d7
X-MS-TrafficTypeDiagnostic: PR3PR04MB7386:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB73864696FACF5719E358D01EF6ED9@PR3PR04MB7386.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0USZKvv04prb78sUE2FUs4GYBXLpJqOaTR2pDq8/zAp5N2EADIrUzcUGY1EVU9tZ0YnfPyZmSZyO8JdIqRWoafbOkXdmxN5u40AVx43zbPUws3m+zeyQ/R7+DQ4mpAYgKDZTTQxhmgkAXVXWlUdjPZzTjorJ8jHsR22aMzSedYb4xoZSHywuDcj7YUp3tnOJdhCFVlXUmRhT2+R/Lcrd1Roci+/7YQr/A2G4F8q5h0MLgF4PBa63ni+bB3WZFypHGU1UoF18G3pmljOoonl6kL5EgFCB3LrjOe47p/bqU8D5OQQw9lsGR3veSM7A/WNLwLjtYRjCIV+PkrucTPcDGLTICg7PhSY+yLX11ukt3yqIFl9glu0oqGXSixKbf1rLnt79jEcU/bIDDAv3mD+dQZ/lki/WtvFQHs16iyOscOzG/Tse9oqx/tLJEy0bAgoRHocrOPpAVtQXUfborJj1OEDsPsmVTpIadB4t1yLEnnnkaIesmx5xuNwEipoBhRReHGpOwuZ/iKIsSh7WCpTwq7wCENhBKnOMOxZ3DVA07Uh1QZAFFEXcrtoteWpWVDPL+WVdF2L1zuyxrLQAPLHEl/5g0QGQ68kVlK5LdLCh/BlN0NAp3rMTyXMTPsEYXCFb/fKDULPcf0AzSKkTdO1gAjqhcXH3WvhJftFO3blep+GoQwTAq55Oja7mO/T1heFgC82L0tTM7pkCFoFRyClLRaf+zIYRXB/uAqbBvmfMeJAs+3guvTk1V++1JTJwpEet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38350700002)(5660300002)(86362001)(83380400001)(186003)(316002)(38100700002)(66556008)(66476007)(8676002)(66946007)(4326008)(2906002)(7416002)(8936002)(44832011)(26005)(6512007)(9686003)(6916009)(53546011)(6506007)(508600001)(6486002)(33716001)(52116002)(48020200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sPzwV5Olp7OYke0TlHVGmTIZNpKSYNt/hXXSiXX17JL0KsDkRCxZvEb5Zo+b?=
 =?us-ascii?Q?HkejevgVG5L/A4YHR7hRm+p8NhnrNKPFiltGCHPdhrh+sS2jQ+fEoPw7+y+y?=
 =?us-ascii?Q?SUeQ4PerXYHZy9qZPAuJchQVk7Hxhkiu7yUQMsgcQoiUniAuqeL0ydOde0MB?=
 =?us-ascii?Q?53JnskaZMzez4/WTsuYlS8UJS+x6DURqfo2u1FEjJ2MLRompmKs1D04/9Dcg?=
 =?us-ascii?Q?qkTQO/AGuItTaSJKI7p0saA8X03ExdUxfKRkd89HclyxFLdP56zHKXsFPAMC?=
 =?us-ascii?Q?jekI/MfCXC4i3/0BLD0EYmm7i3H2+1qO0SzP18iAyU+Qpcx2ZZnpkrOjMRNx?=
 =?us-ascii?Q?0DFgD2D6nJ13/G3D1srrVp1ejwKXbtl2GXhc4PnZhGNoM5pELozTgf7yWi3/?=
 =?us-ascii?Q?nbywcANQuSX+++MTIlk0eTHtxuqS8LL+KIdoJ3CPPvGBc+frIE5Ayd/iyHln?=
 =?us-ascii?Q?/rg0WU64l15g1ieZn57xADd0cWV4sb/fxoyc700lhnNtuyJTktRzAH/dQ9DI?=
 =?us-ascii?Q?Q1WRHYkLP/UpEzaYf/OxeKMgqVqDV5xBeSiCf5ohrd3Sg9mIcRoXRo2RtaiN?=
 =?us-ascii?Q?O44WrYA3qG174O65N5a1fMpb5kKT/THLqTDRo+jydkGwt4uP3CCifnYI/lfp?=
 =?us-ascii?Q?tYy8ev6L+VlBkCWsRV7DNygFrzNJDzJsM6H2UUC4FfPHdnOEwV123IHW0ZZl?=
 =?us-ascii?Q?K57QsvRZsjbdsPqhdHPxRngsTdQcUn6kwdpKUCSJnQLjtxVQnw5giL1dGanz?=
 =?us-ascii?Q?ZaJ36sRLqt8U6dZVsicdihAYq3aEKbNHZKt1pS7TCqG4mWxcNBQKsSJ1e7ab?=
 =?us-ascii?Q?D3XSiKBmAbMeYiBFKKKwafEDzZseLNmYvB1QtDF5a+YgD1b921nL3O7LJyEJ?=
 =?us-ascii?Q?AXUB7JvspUZx/iZhV3+Z1PMERrp7yvRD9BaOhMj2sPnD/Zf7QFPJkFj9/i3U?=
 =?us-ascii?Q?W1LREl3KpgQJ+vJEEnpybuue5b93thP2AaMTlmbC24/KxAkuzYmMNCASMTPQ?=
 =?us-ascii?Q?20fVfKB3auBhAhtlZW1qw3OJnilRvLroh0X6xB2G6XC9j7WsrPnYVefbnwId?=
 =?us-ascii?Q?SNPWT+Wat3YYyuWvirka7h0mTnSGUBMPQUHkUYgq+W2BRWDdm+K6i4HbhLJq?=
 =?us-ascii?Q?b0/H1/MOwjbHNgj5EQ98U5TEGj1waXWs4ycFvXd8Swhwgum/tqHNuEV24rci?=
 =?us-ascii?Q?+6ZpJpUZDimySDr5PyMxffUS63WhO7PDYi65LFa5CYXTtckBDZOBaPlrFn6q?=
 =?us-ascii?Q?U6PVkQMVjCO1M/5mAcN/hphU8N+SzPyw4dY9xUQSLps0HqqljRIptcFC2dWr?=
 =?us-ascii?Q?vBBc+PWw9mhoC9c/O/48mg7m+a9+BTs6TfiL8BQZf+5n1Gf7M98drJ7ForiO?=
 =?us-ascii?Q?vHrx1Qzo7FqLewgMOCU9WFvxQdfWZwgf5FCreQ/NOm0sEVNXSLGVyhdQHBDI?=
 =?us-ascii?Q?U9VawsJ46/C0n8qgOr+SoZoyjlCPRJO7MAZcWJTmjC8bOJtHG8ddpXeWytwM?=
 =?us-ascii?Q?UL53fbvogm/GdA2ZxOAf7P8JuwWMjOplWKWyZLX+nkP9TY0A9jOWb/Caf7vF?=
 =?us-ascii?Q?RW6829KJTyfkOTYH9PRLywnx4Jn67nHGr1r94BHukuZ9yl2Uwn6wxuhi9U9j?=
 =?us-ascii?Q?Lg8DgUkfHGM25S8QZP8cyESXiy+33xyLu4WEuqYbSMq/ohs+yG48b7JOFVnN?=
 =?us-ascii?Q?d3VqX43vKMJDtbtT13YdiK3Mcxz/A80kSfx+lftl1slupv6j08rg0YXKsuSs?=
 =?us-ascii?Q?98X0EKYJ/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ddda3-f567-4e4c-653d-08da1c7453d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 11:05:17.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHybVlB0ZvcNpLE9ucCaaUPPT4Q+9qeGnwms6kFw745J1vLLcOLLTVQzmMWbNxZrPXg0GceZ77G8kcFB60vRTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-07 15:37:22, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> In __imx_clk_gpr_scu(), if imx_scu_clk_is_valid(rsrc_id) fails, then
> `clk_node` which is allocated by kzalloc() is not properly released,
> which may lead to memory leak.
> So this patch added kfree(clk_node) on the above error path before
> return ERR_PTR(-EINVAL).
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Applied, thanks!

> ---
>  drivers/clk/imx/clk-scu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31..ed3c01d 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -837,8 +837,10 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
>  	if (!clk_node)
>  		return ERR_PTR(-ENOMEM);
>
> -	if (!imx_scu_clk_is_valid(rsrc_id))
> +	if (!imx_scu_clk_is_valid(rsrc_id)) {
> +		kfree(clk_node);
>  		return ERR_PTR(-EINVAL);
> +	}
>
>  	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
>  	if (!clk) {
> --
