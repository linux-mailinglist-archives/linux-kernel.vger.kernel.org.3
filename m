Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB14F94A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiDHL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiDHL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:57:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9772E05;
        Fri,  8 Apr 2022 04:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij+42JIeNzskrDtVJp6VeU8GsmZhKVC1/S9qqmLB4zZ4U6IBeqyQUYisxLK8CiVVhnlBtnhWMxV4R3HQEXwhf2utE3RaJd4f8wOAIFkrUIFxtnZ4duDHjPuXLYP/0D8sCGzyzLsePxWGDatslmtBXTvr7HTy/LO633dNCuKjl6+P9uSSPXMWF6wsDoIpcFdQyTtQBpTGKBSUWuiaoWXskRcZYVmCR/qm78HiB+015i+cT9hUfMRAxHkHjvYMRnYzxJMbhFtyQ2/zjBydH9faTrg3md/f8z1NOXthMY5HgeUXspvDrDUWX6J+qMtn6c7M1bE4eEwalQqExDR+zBF84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsZsmYFNT1Gph68gNqQ2T3vroeAABtjB+EzOi3TGcKY=;
 b=mWHtSrvafEe+vosDE2hUq5tHlusj+YGdyT20WwoNyelkPsbRM0kXLrchu0CmhBa8euCKGVTnFx7ngl6tZiZQ+Pgku9HXtFNmhJOCg+lRbvJqvyv5r78huS+5XL2IJJzFxO8n5iQJteNspqjFHwkrKhNGP8ZsKOy9jQaIJZBhaUR0dW3xlbzK7eRb+VLYHSwdBvbW3AMKZO34XWZEPuS9N4gLkPSFOP7ObCLi3OVUrqODY4U0wkUaL9vBEpWM8/YEQ43bILT15tuQjvrh42V+o1JTVVI/9JyqZ8JmApiO/SvswYOCRMkkdGCoKda7rClgCO30VdJoWfwLpbbCCxzztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsZsmYFNT1Gph68gNqQ2T3vroeAABtjB+EzOi3TGcKY=;
 b=PowzwEllosEqiqpbqiN7g27xdM/KBWFpajidWrc0v2tyBC6kdxzkADAiOs/6NlMJzNAtxtfmI1PPQQDcyweQII4hjztWY2Zg2dr9ElX4FZTxBBq2AwWQIYrkCAVznAlqm5KMKwuubWjUCjVrmQcNr2cszk2FyMksw2XvWQWgS2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 11:55:24 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a9d1:199:574b:502f%6]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 11:55:24 +0000
Date:   Fri, 8 Apr 2022 14:55:22 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     xkernel.wang@foxmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: scu: fix a potential memory leak in
 __imx_clk_gpr_scu()
Message-ID: <YlAiqhRf1p+svR1O@abelvesa>
References: <tencent_27FF59903EE6AB5C0D0E6D0A8E7059A59007@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_27FF59903EE6AB5C0D0E6D0A8E7059A59007@qq.com>
X-ClientProxiedBy: VI1PR07CA0238.eurprd07.prod.outlook.com
 (2603:10a6:802:58::41) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9136091b-79cc-46c2-915e-08da1956aa83
X-MS-TrafficTypeDiagnostic: AM0PR04MB6978:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB6978E62DFEE5014C097CEF46F6E99@AM0PR04MB6978.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3H9UXRDunl7e+r+5C0BAuVkwuX8/x3FeMVcfLLJc22NdNVZc68ubummyAEdDuzh91ss2vBqGdTubO4ls+k4M2Vpz2SsCirjfsQa/3MLs4SDkprD13OBFNfudS6VYDj5Q4m4qLPNJEI1bOA4/0kqD8UoK8wIiLedtUZ3jykkjNCAoO5rRZ6XqFX3SmOkrts9o3VNjsWauzt9DJTadCQkPRXfVYht4SXETLvNfncd7So5ypQgk81Bkb5TOU4d/Tzc/zA1tWXz2AI1isXvFtmuI5E1YBz4xjD5akjm9uA95FNG4XI1tHkM/86CGsACBRaFFcGDPAkgXU4kx1j3pR/PMHjnM9x8rqEF8I6+QtW2nhZtBY205/sRuoW56Pk8cF7LmRI+tKopTOC7c7G3IFkkAPXlpCE0tiPei7FgpaI1r2ZHq2IPjy+xEVXTm/PWDo4ovb8eUMQu8ajco3KnKVxt2lVOLf1moXLXXan6y0SkvU0yP8Wpd08x/rWwMerRnERqG+9jnKfC9usRq7uAPXRehrQm6QLq4tV8G7MrzLiikoPdNT82bYJ6/HmqHAoWH5QMf3jS1RgvVVNMdOu4sviokA3ykCxHEag1TqXPOJHAO9go0hDF6VMFYbiuU+cR4PTFojja2Xj5U4ZOb0yJPGVKmZWopKGlw5AsO0cAHocKM2Nw2I90DJT+LUBntV/s9vG36ETG4Qjn1hBTeMbRa9e1FNRu1YiJmCEmyHKory59m/KtDhxPeLlrbNq0y1oxB6Kx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38350700002)(8676002)(4326008)(66946007)(52116002)(2906002)(9686003)(38100700002)(66556008)(66476007)(508600001)(316002)(6486002)(6512007)(6916009)(186003)(26005)(83380400001)(6506007)(86362001)(53546011)(7416002)(5660300002)(8936002)(44832011)(33716001)(48020200002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7S0TR5d7Xj3Y77eo6tclzF29XZlb5iP7kQUjAV3O4Yz7LaLNFTvotf8qTmj5?=
 =?us-ascii?Q?y2FL7o6L8s0tMWSMVSVhAlF65vaH2ZnBy6yJ0K5uFX9rK1KssWuYQdGGcVoL?=
 =?us-ascii?Q?PIBuNV6oo2pm0Oo3jU5jUBD5Trfm5j4qTitdU52c5DBOZAuFPYPISxBK/9Ue?=
 =?us-ascii?Q?4d5LV+/GOFbac2SED/0tk36gHT6OzUxyRqoZcuylJJ4pJfQe7QF28HfvXumf?=
 =?us-ascii?Q?LndNz21EpudWH/nes8upZOCko4DHWt6F4LPm6tj3orX8TDYAORueb9+vq28E?=
 =?us-ascii?Q?JWnNwrHzNZgm6a6mEflqJAsh4XfHMNBsdLh4UPWb0c/im3lGge2vYdCWS2QA?=
 =?us-ascii?Q?lvYsf1603HodFkpjMJjxBIdS9a44SIur4dbq7grej8qS9cPCd5KIQIcXt+j6?=
 =?us-ascii?Q?0aHITs0FcRklC0+QuNjWbIUahiPp+aKZ3FlxiswhIEMARHcgFv5CHAjF+tyT?=
 =?us-ascii?Q?mbDoZIncEyDwASgD6zTDQK7FejM/a1YExaL97hJ8urc74P9NZ1+6V45osq0c?=
 =?us-ascii?Q?2DlYUCFqNSEVj3ZH6nx1diHw4RKs2UQtwN71wrWdfL70Fwx2pLk97J5GhQHb?=
 =?us-ascii?Q?PCVrk3tlHt+/8bzcAlV4LzFcGLCkM2Kd2LbO8zzv6tLBIjwr3xnB5q0o9rHD?=
 =?us-ascii?Q?CqjJ71dLizuJn+9e+d8VvmYqrPke5UTl7eWPKdwTmHmKYKKku0vgmRr/fe9l?=
 =?us-ascii?Q?T0qtLJ2pCDeqZKYBLS6xcqLuwrHRRXaiwVxLI1qonoDQM4CdcR0JA3o3GuMP?=
 =?us-ascii?Q?fhbsxwRaM2rXxbwsQZmRRNEIJFYLyFkAzaFSSPM3SofMkMJ4YVOrDxh/7RYz?=
 =?us-ascii?Q?HB8H1dX8x7icZw+QuICplVdKsv9VqZEXOxuZMy/iq83sUF1aCs2OFtAmBzOe?=
 =?us-ascii?Q?qRevAWk8/poOTO3wnhRSfWBBH/hMikgzfxiyhG27mGQCg5Fj8XvKS6DANQsf?=
 =?us-ascii?Q?wopLlWe+HF3S1TIZ8EElpq9DKSHwoIbzw2YKkj4Hh/RZG9DCUJnozdxWc+9l?=
 =?us-ascii?Q?GkwCVIrQeRsKfBrf5AkgxZ5C8mP/tuXGYAUpkjHbOjabW6XB4ciZQ0wLz4dA?=
 =?us-ascii?Q?shl13r0c4yzsR7pglXpSAr3KuItaa8IUiUuo1dEIJZWXWTKf05ryOtXO8T3G?=
 =?us-ascii?Q?oCiCfOClTUf9Jeve13WK9Lm6eROTnCihPMMTuhjFKnJhqX1FmqtXsb/9Mkzd?=
 =?us-ascii?Q?mIrz2IUkRPzSXV5WUK3ZEL5k3HoZGQpfmgmLIKCpSJHBQ7WKUhAPT2fVoxOh?=
 =?us-ascii?Q?YoGGz7di5rmtmfyRBL+sBNVe3cWKMgq5nLpCSmyCKeS58EoZ9kD6qU3Zz0mZ?=
 =?us-ascii?Q?ujmKXkkDhXbVlYLHsPc6p+ThoQD+zfDiZtYt8FgAJPkT77ufFFddUzCODwQJ?=
 =?us-ascii?Q?hLJQOJfvoWwBEXDBUSRJHKdZXIS+CMPsbnzSf8jRGprsdNKTLpcCqc6dBEyK?=
 =?us-ascii?Q?rKa9x/NKUzyte526I0n8Xb9nObDoB9MWy5FfGN29+3bhe8p2wha+WGiqtv88?=
 =?us-ascii?Q?X31MXyGX+rAJ3i3VDJ6j6uI+dqT9yRl27iTjdViRLgB8x+RyU0vbfQ06K+f+?=
 =?us-ascii?Q?q8p1BqM7WEMhKn6R+sfz0SXxVGAJx1p03oh68f1/yqAypsrPT1Fk1F6qbpci?=
 =?us-ascii?Q?GrAYuAptSmzrMtbF1f5hMUJ56D6F1dYJuS/NXW1MEpAICK7yoP6z3OHzNkHG?=
 =?us-ascii?Q?Vow1VC2xnjK3mR3vw0wNOaLcDzuveeH4FEyfsHvqV+SsQCMN51Q4P+Qt/dV+?=
 =?us-ascii?Q?6b7Yw9W3MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9136091b-79cc-46c2-915e-08da1956aa83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 11:55:24.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSKirM5zzgjQsUjXx3w13JqnwLaixciXOMfckd/4/EFn5I6+yl+beZ2TO6UQh1k2dnR/yJEFUTCpRJrhcijGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
