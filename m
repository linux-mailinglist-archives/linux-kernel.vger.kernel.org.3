Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917BB4833DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiACPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:02:03 -0500
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:45633
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232481AbiACPCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:02:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwxdM+gd9yUJKV6WnfFN72uVpwsLxJpi5P+I+zyaeTS1w73GTCUSsXOdToaZSZ8uOe/KkSuGBwptf65YgHmKbQnVhD26z3tNJ+DRhVbu+WdSsEVBBpdcXisNlaG2YQcWMym+Rvyu4IKonFu0xfOAGbFOnNd2JQZ/f8JLE4OpHXE5OEGZrfr1lcovOJqzrpAZ3qY/OVSFgrvqetZ8mGgLuA9d/my9X4E2mtsnMzFu46QiUFzxxP34JVC0/p2SIaHN0Pzgg3j1QOYHpZIa+6b+urh6jOz05+wA6zBbvvTjH55cW8FYZi20f0NqZMAm/AfqNUNTnrwFlxk8tocsn83+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTM3XKBhsJCGG/+XrwMPLbAU3Wh57a5R69/2EZxYE/g=;
 b=DhKSYveF2Wl+YebZtqyoY9bE0Dd68JLrEtEfOu9myxnqkO7bIXoBdFkXossIZM97RiVxcqwX+WY+lygzad03lw+Pu/f+LrHtzdNnUCL0CaKXyUzwtCcWljZ9yOs7moWNjpZutFsOAhT48/dfzlB6qh/25gB9lEb62YXG1WUrnCO76cU6lvjNgzkdA6fzX/2AtUhpXtdftysC92EP+zI0x2FswXRVEf1gT4lx4SYmvlSW400Q/ZjRzPy3CiAjfxSzByKC4WzODOgaN5xZ4ImVPS+Ospwj9yKixQq2X1wBa4knrhU5WrPugb2P3/x87luW8k18DyEtefRTOEhkq4vFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTM3XKBhsJCGG/+XrwMPLbAU3Wh57a5R69/2EZxYE/g=;
 b=DXlioSb1eKUTj96ZM5+O3p00xa6KvvaBB9bVtvwaVGPUHhi/oArKGrpUC8LPygAEaSs4xwu6HYLTQUOc5LaGjR5SkXSnTnT1jPB6dInaAGDzweCej2y0xSuv7LOlTsicL9w0C3dYjcMPshplBVLBBp5L4ErWT/C4noABVzMBYCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5855.eurprd04.prod.outlook.com (2603:10a6:803:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 15:01:57 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 15:01:57 +0000
Date:   Mon, 3 Jan 2022 17:01:56 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] interconnect: imx: Add imx_icc_get_bw and
 imx_icc_aggregate functions
Message-ID: <YdMP5P7Lwwkf6uRn@abelvesa>
References: <20220101163956.3344467-1-abel.vesa@nxp.com>
 <20220101163956.3344467-2-abel.vesa@nxp.com>
 <048650ad-e015-3733-bdf2-72b7a0ed61e4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048650ad-e015-3733-bdf2-72b7a0ed61e4@kernel.org>
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb8e34d-097e-406b-b83f-08d9cec9fcea
X-MS-TrafficTypeDiagnostic: VI1PR04MB5855:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB58555CA76B365537DE1F1BA2F6499@VI1PR04MB5855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7RYOufj7AryCULHsxMRmzChjG/R40vCOxwp5qGv03Oo7+N1fynI2s+SlMUD9u2Fe/A1tNh9eSja2pFf5uE/lce2amxTHJQ2F9UIo5dTi7oCy2Tv0lUlhgiwuBo+R4kuj0N5yDxzEgxdSgWBMQVXCYEDK/OUMutQqUoz0mrsE2MG9gaY2GWQk1s1lm4QQrvk7SyRzVGsok8GAYXUSJUz2iMNsCmaSf6Nv6NaRAL1jD3lxCkbxC1Fgz70ZAxqlhKu/R2dKoYN0ZJROZbsdiX9cy/E5XUtCJut8M3ImA/z86BMYyj2K7/2YvrSHvRd8HqIS41SGAcM+Tl6v0jwsNW9CMgeygsd8QCj0hNudyF2DDheVQ8MlpV9UH8ryKj+8BkHXW2ioMqbM2/DNWHHyQRFGTSwHnI548FyhaT9FBWvatA1i9DshAMG/JI5DrDjDlpmW9qR8IDgTX2492oeH66fvG+qfRdI9Nmufj93fK8pMcARWbEGR5EJi6aZgyWR/z9Hfy1cCAhHwNCc+XxQBeE0u5HAoz0uIr8dFelhQP7P0Xd7/l0ajZf2T87shmr1MfPJDN16LFzXl2aY+5JLo09DoO13u8a1r8vW9PtULfdEJewBa6f/EVur0ciNUm/QrQhS6l89rz2t3K+K1QsQTBcSq1AYGMe4OXlFevg4WhEbNKFhuKQ6s5CTBk4AhthyyfVNAtYXwJeoMtu4NzxVuvLMmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(86362001)(66556008)(38350700002)(186003)(5660300002)(8936002)(38100700002)(83380400001)(54906003)(66476007)(44832011)(2906002)(4326008)(66946007)(316002)(8676002)(6486002)(9686003)(6512007)(53546011)(6506007)(52116002)(33716001)(26005)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOkxFwCuLt6sYBdpRyU/zsP82EgUSHHQwM5eGjrPfe6Zmn7S5LCKv5y2hIUU?=
 =?us-ascii?Q?yASFH9cc3VuOYnx+saDTT+V9fazMY3InKEXQuOYZmNsPRf++CkIT2ikAG6qk?=
 =?us-ascii?Q?YJjLEAR+VKHBe87IIhXpqBlaSh4+uOrVOs0+oolmqlIKVrf42WggGjDzukjT?=
 =?us-ascii?Q?djd1iKd9ejEOcyq00xXVtSxHheE2pnN0SOtZKgxNP+0kH9Igm4P8eKKAoQqY?=
 =?us-ascii?Q?xXSeXR/WjTWDSRc3ZMgXD3BZyjiHMEQyEMb2DBtj3v4vJZtOFIJ1TV1x7GVF?=
 =?us-ascii?Q?46FEi19SJVEo2MkEk0Ojs4eoWr/Ik9FPpHM3ZQGrMYveDV4bgoofF+XE7PB1?=
 =?us-ascii?Q?pxsG8dbYDDRa7mEln31+fD5ArJzb9/pUV0u3vKBKpo5X+BwjPaiISbnOY7i3?=
 =?us-ascii?Q?xCsBdJafvbya9TYCx+muKszcpDd6Ta0Kow5icIOGN3r0CvG+D8aNv9VPhiM0?=
 =?us-ascii?Q?Ct+aqyW/RwwingL0Z9tSHEGwEoN4h75YaLe2U7p6Qs81z3lFdSgaJHn3cb6v?=
 =?us-ascii?Q?1lBdJzVyfqdx75aRInnni5nAiA1MP8+a/rKHjKwLKlNnXA7PVFYhZlQrQqz3?=
 =?us-ascii?Q?CSicQz8AXvvt/HGFogLyqat0CiOE/C3vxQQdm5g+qfndxZWe7HQW8qJ048so?=
 =?us-ascii?Q?8Plyq5SuRJ2V4dp8edkxgyRf7BTZE1DlwMiYuqQ5CspAXe8nUTBU2PXxxq20?=
 =?us-ascii?Q?enEbPogvM+09vy9wlHnz3zOmKoCq6Ft62r7qGLdMNL2KPVnKanTkihkFz3aE?=
 =?us-ascii?Q?rSSbEq+T03MnKzvIpLPpGgvbdG6O+qOnNzh4H7llxnlqMi2ZQCCuggC/PtTa?=
 =?us-ascii?Q?1CL6Thb1yqPhiESbi/JhwTwZi6MEvSkUkDzWAhMQi7mk7DtCXH5JwI6wcK/d?=
 =?us-ascii?Q?Svr777KuDTFgdeE/NhmtUEw7YHM3TaGxkJcAKhEnUlRZaGxrSwANnB42e6/h?=
 =?us-ascii?Q?RzaS1YADND/xb+0iIHwRAuD0PA0mrl/fgg+ORMyuqKsk99C1hEgAnFXZkx2z?=
 =?us-ascii?Q?kRndKP49g7qR2oIghhYCpcDGoljyuHVkFy7gHHT+0/Fc9tMknwfwwKgbmaSy?=
 =?us-ascii?Q?QLf8+BGn254aDhbTTDV3BizAcCqeyHrrHfmdd75i5/A0jSYGmD3fcG0km5qQ?=
 =?us-ascii?Q?j+rG27Z37OySmrWDB4p6BxWYw6M9bqyLIF77AIaZ2n9NOjMrjRVJPKp9iW+e?=
 =?us-ascii?Q?cqwRHppH/qAb8yh6TS0JiESWD7VPazzRZTe9kWD+7T/T4EbWbzGcM9wj7VD+?=
 =?us-ascii?Q?884o7DiblB7P/+cknkv6mhIhT0+k7Y1z+ng55p3f7T1n2ttvZLFHuCqTvD/i?=
 =?us-ascii?Q?R70xuTLjgayq4/Q1DS+h+ORg94Uon6Eu430bRTjRwZLZXefL5UxNpmelEilO?=
 =?us-ascii?Q?Z489XGAjf9MJ/A7OlMOdtWgh5jVRiGZl+ZiS9NCXPqMTESwoJ+irK6DvUGOn?=
 =?us-ascii?Q?R+UJy/3gK0vfccsf4N2Ko2z1wdJUF0E9Sf7ezaS54QAI7v9NM4pdNm+AeyG1?=
 =?us-ascii?Q?GZLSmHbHkA3W5R+qcZmNszpHAVAY/jz+g9inkKtdak8fkcXKswvhqzTMFfJz?=
 =?us-ascii?Q?XEtBNGVeBn4Lrd2IftudxBaBokjTa1p7nNNqz/slj9owY7/Mt464HZJ4WQRv?=
 =?us-ascii?Q?IcAu7Fd812jKKqRq2QlA6VM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb8e34d-097e-406b-b83f-08d9cec9fcea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 15:01:57.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tR1SUdHO1eH0KntyPOQBlXKdqZRA87+Zo6rMNDAtEoNHtTdAur+AylHj5PABnwIEDkDF1E94hHEiGFXzFXZW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5855
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-01 20:26:05, Georgi Djakov wrote:
> Hi Abel,
> 
> On 1.01.22 18:39, Abel Vesa wrote:
> > The aggregate function will return whatever is the highest
> > rate for that specific node. The imx_icc_get_bw sets the
> 
> Adding some more details about why we switch from
> icc_std_aggregate to imx_icc_aggregate would be nice.
> 

On a second look, I think I can drop the imx_icc_aggregate and use the
icc_std_aggregate instead, as long as I use the peak_bw and forget about
the agg_bw.

> > initial avg and peak to 0 in order to avoid setting them to
> > INT_MAX by the interconnect core.
> 
> Do we need a Fixes tag for this?
> 

Neah, the imx interconnect is not used by any platform yet.

> I would recommend to split imx_icc_get_bw and imx_icc_aggregate
> changes into separate patches. These also seem to be unrelated to
> the imx_icc_node_adj_desc patchset.
> 

Since I can use icc_std_aggregate, the imx_icc_aggregate change will be
dropped.

> Thanks,
> Georgi
> 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > 
> > No changes since v1.
> > 
> >   drivers/interconnect/imx/imx.c | 20 +++++++++++++++++++-
> >   1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> > index 34bfc7936387..4d8a2a2d2608 100644
> > --- a/drivers/interconnect/imx/imx.c
> > +++ b/drivers/interconnect/imx/imx.c
> > @@ -25,6 +25,23 @@ struct imx_icc_node {
> >   	struct dev_pm_qos_request qos_req;
> >   };
> > +static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> > +{
> > +	*avg = 0;
> > +	*peak = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> > +		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> > +{
> > +	*agg_avg = max(*agg_avg, avg_bw);
> > +	*agg_peak = max(*agg_peak, peak_bw);
> > +
> > +	return 0;
> > +}
> > +
> >   static int imx_icc_node_set(struct icc_node *node)
> >   {
> >   	struct device *dev = node->provider->dev;
> > @@ -233,7 +250,8 @@ int imx_icc_register(struct platform_device *pdev,
> >   	if (!provider)
> >   		return -ENOMEM;
> >   	provider->set = imx_icc_set;
> > -	provider->aggregate = icc_std_aggregate;
> > +	provider->get_bw = imx_icc_get_bw;
> > +	provider->aggregate = imx_icc_aggregate;
> >   	provider->xlate = of_icc_xlate_onecell;
> >   	provider->data = data;
> >   	provider->dev = dev;
>
