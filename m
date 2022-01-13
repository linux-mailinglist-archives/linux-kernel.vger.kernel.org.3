Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36E248D655
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiAMLJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:09:53 -0500
Received: from mail-dm6nam10on2133.outbound.protection.outlook.com ([40.107.93.133]:13543
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230045AbiAMLJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:09:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1iLPUIyd1jzGHuKBENxNFKSR72+tlrtrqWejTWpV22rSvZSr9vTCCl+TUlvVWybyGzf3IvYAusupTMvrk7ijIMzclXuNeuv1UgZxGnS5iLOZlfqOP5RJpqfMjGfvDTZU7CO7sTjcD7qdGoatNmNFZs2cddhvFEfyLe3SqmCmtZbTEGymXTZQB49iuxQDqgd+2/cGNm5Zh8zR0ujtQ/RMOkHktVruE893GFdhC9GNtyQZkkqb3DxCSg3Q7ci3mf2vbeuvU1Bcihufzh2baQ/4FSZHZweJ4GjaBpvBjbgCGgx4p7yNkQPHCYv5J9mf4bv18c0M9Hu5/MJMnJRM+6Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PaQYlNOv43X1+3BPIn9V/3jqu6v7Z4NB5vDWwMukI4=;
 b=VpfBu+rNcbF928gLqJdky5NT5tum7ULUMfyQ0IDKwKBH7eSTnNog5skI9pl+B6pNklQsqRK+bbapeHp5F7vXIChWzQ+1OGEEs1Knajbv/upk8dyUgpf/XKj1Lj8wG3Fz2Id1XkZqig6eoqaOyih5z4hUUxtoqQyMb9tM8aDGN8cixw0rY8xmZAS7N0oCVod7xtzwIXZZHCeScG3rEA9973cKnQaXpp+b6KRSbDaHenK6xXnRJs8jYZGa90DFPhewG3VbmiQpAcbEy3ar/PCUVfBkCHmUKfxNN4QCZqBeN2NUWHFfxBSYwaOEX5B+3lrKgbQpvaXcnxrmL8vWOt6/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PaQYlNOv43X1+3BPIn9V/3jqu6v7Z4NB5vDWwMukI4=;
 b=PosGQM/D5B4+OSAIe7qLC9nv3NPA4GBH8sCRb55BAYyNf79DGxG45PHJtIhm6hpihsV7KCJ3ppZVtTQBcurX56LCH8LSIjv6g3eOCFNAOG2x1q1kfioEGwbj672D2w8/yjIj34cSVMR5cOz4rD2gQ1W2ma2Sj86BEB3XFFNZF9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN0PR04MB7934.namprd04.prod.outlook.com (2603:10b6:408:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 11:09:48 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 11:09:48 +0000
Date:   Thu, 13 Jan 2022 19:09:41 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        chunkuang.hu@kernel.org, matthias.bgg@gmail.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de
Cc:     jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v8, PATCH 1/3] drm/dsi: transfer DSI HS packets ending at the
 same time
Message-ID: <20220113110941.GA2480843@anxtwsw-Precision-3640-Tower>
References: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
 <20220112153639.12343-2-rex-bc.chen@mediatek.com>
 <2f0fd4a9-4d24-a6b7-12ae-51763f304761@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0fd4a9-4d24-a6b7-12ae-51763f304761@intel.com>
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b6869c7-1625-4697-5e8f-08d9d6853651
X-MS-TrafficTypeDiagnostic: BN0PR04MB7934:EE_
X-Microsoft-Antispam-PRVS: <BN0PR04MB79349927338C469F4BFB70ADC7539@BN0PR04MB7934.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCjVDB2T8iiugSAcKm7fvxBxopnwVu5yGnHiqPE73T3PKGP5mlO/oK0NURjFLaOaGUoBfxWTdWAaoQdXvOl+5Mi733iif/ZKJz5VXBHfyC5W1FYxErtUbYQvGn3LJNTid+CHE9o3aUrLyPxfuzB58/C3nT/oNX5HQCVojP4W0NIAvtRIpauYUJDevyVBYF5fUPfSvFqHd334zIq0Nxn1BoD8KOX+MutLzrbS30oqZpA+coRYHykUNEZa+ZaLTs6yrZguOQLSKYFmrA1o5hUBt5mFIEVfEFpvzv9Wd4MaQB7aLScjDUYrKs8QVe6/fS9GhTMlTjqQcvbNO4BTWJ+5W2X0OFsfsHu4Wh6FN0TlNcfSf38WxA+sBXd6jWTglgxJuNt2ArKdhoHHbTZdaXrN7TtnqdVJ8DIJZJUozOBaZxzvGSBQWXEUg0O+rfsZp8A4KSkhT8K0uY0y8qXN08odONNRZnALSfOxMJtS+bcTuTYkisjJj+yOM6fwkUwXPrPXQeziQaPX2HL1LHNY7ZwQKdnAybrrp0Q4rNgsHUt5T46F2A2BC1FpWAUgx2BOrYSnt2VN2kvKtOuFyC1SeJMwOuoY0tR+uqATpxac8MEyhU5KPGIHt23Pojw3YYBfoREph2fGi2Xxq3pIL2z9ptjjc5Ckf3Hf60CD+LMtZm3uqHcrrSjhoyX/CVTkBvts+noqX6iDSnlCTWmtPoirTDysTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33656002)(4326008)(186003)(6666004)(55236004)(26005)(110136005)(7416002)(52116002)(508600001)(83380400001)(66476007)(66946007)(5660300002)(8676002)(9686003)(6512007)(2906002)(33716001)(8936002)(86362001)(66556008)(6486002)(6506007)(1076003)(53546011)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZKBKNnJ+rZ96N9F2QxS7ecwmvJD2qENePFVKV3eF5FoQgymqie1A2sF0lfoF?=
 =?us-ascii?Q?IuWknPjisqvABGvug46soLIziKothESZanqkBWzZN5H9ceWFx99TG2FTys66?=
 =?us-ascii?Q?FBSlNNeg4rHGYSbjChL2EPIF+AWN7z9CyyFSS1eGxm/SspjDIOHBt2B4piv+?=
 =?us-ascii?Q?qy3vF5GKt8KsQCyuOE78wimCrD9PSw6hWppSqQAQoGWTjGFDtIk0khHFQ63b?=
 =?us-ascii?Q?sr+eZWkYJxyoK6a+QZXTDEgqnZz8hyXk+O1NlsOEBUgyFh54/ixNgbHH4Q8i?=
 =?us-ascii?Q?QrE9NeeHhFxJ5PnqdLCamPpBytkXPfGvI0ZiesEi2u7LtJ/mIbTtajaz7oEk?=
 =?us-ascii?Q?Ad4Jdsb9LsThAqvYbLd1Yqcy3ecRY1JeoC0doEvOFGTfdrnwgVX7DkHFQCyG?=
 =?us-ascii?Q?9RVfZcS92NBWhFFz0RlxXRS+0nTRmf5+gd91sfd1XvMsLswDYxKAfOBqLYqS?=
 =?us-ascii?Q?JW9iiZ+/9KXXhw3IbFvrz7v7X0innaBfFniPAAcTxAD3W82bqjjPLXNqb/DJ?=
 =?us-ascii?Q?+fuuBR4gWoAl7enqsj6kyqNO7VE/nYG4sO8d2nLsQ7+yM0NPSGHGpoI03n4l?=
 =?us-ascii?Q?AtRwH5pIt9TdEwd1JistmuLEq/ZuhYeATIR64Hy6dMm6D9vFFXKaealiFeaK?=
 =?us-ascii?Q?uQuBsX6tigIe2+9XQp00g8tHl3O1sMPzbNb5r5zGYZrkCl40cvL9QdRDuTla?=
 =?us-ascii?Q?69G0qn6A+n7c14yGW7B+enwzpZLChcPBvP2Z9k2aHKWUd64nEygMzIBvaK+N?=
 =?us-ascii?Q?DTND0KKNH87x9ds7o7Hd74vibud1kquCkawunQJ0ZAtTtEfEMCCvM1dzR2Ex?=
 =?us-ascii?Q?t21TDhmNb2SLrXYh6aGhN6VysGTBYFoxZKZ1eB55gi5MtmW+cJlgAsRLnt7a?=
 =?us-ascii?Q?DAO9eBGfUyLfkzQ0ZFT24aGezzrhA02hyhuw+FkPV29/G62scn5OjBqRnHrr?=
 =?us-ascii?Q?Ai/w4tZ3L9PPyEE0yq8BApgSYMCYj5TWOdougmlh19lK2pYcWkHuW7YX2lbg?=
 =?us-ascii?Q?RqtetSgKbkTtwSrERyosyD0D12SliDy19tTXOR0QhNdxAguXpfTtY8dA2rMr?=
 =?us-ascii?Q?DW9QdPXTmukQbQhmK9+vx+KiN5DwHbYcjLdVyYrX11GfOI8z8jznnv53RebJ?=
 =?us-ascii?Q?j222mx8yyJb5xhjggc9lwqbcrJ4oca8MHR4TuUCcii2tYKrv+p46UNoRI5ML?=
 =?us-ascii?Q?91jSw1ESWE4PgrOcgFZ00wXzp7YrlDcReJTivKc5gGRRyU47mP/q9J9ApFby?=
 =?us-ascii?Q?Un1D/EilhYQy1oZ0qkognCf9boC/pSTEUnTz5nq9DZDinzHP5E1RgRtnMaK3?=
 =?us-ascii?Q?X5mz93qnqyRvC/J/C8+uJc7mFFmPpTJN9Ib1LujbE8mtMLZVBQ/drdZYF5sh?=
 =?us-ascii?Q?MFBcaAHJ7G7oYGTeGUYeQr4ohiTS0fLgy+N1gkiGt/FN11XEeeDLdBx4hlhs?=
 =?us-ascii?Q?xkBO0J8JjgkFkK6y3eva9OGdSxVuqCMuVlDF/EhgH0PSryj2N+FdiHh+uSK0?=
 =?us-ascii?Q?R5PLjH6kozLnYYrZJ6guxNDNQNm1SFxRD1hHZkLs6/K5p6ym10jhsosdg199?=
 =?us-ascii?Q?b11aDls+3BlvAD7S7L2b0qmD3w71o+umOXQhwWqVsONIjFwhg53GHBDGoHb3?=
 =?us-ascii?Q?XKSjW9sepYBsF+FJZK6L5Hs=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6869c7-1625-4697-5e8f-08d9d6853651
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 11:09:48.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTML3jCppFanrSPEez2+mv8aPUHDFAMTa8/1JZE9RSUBgEk0jxJ54yUGlSbh8pP0v/v5AGvHQYaNLtUz3iYbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej Hajda,

On Thu, Jan 13, 2022 at 01:14:14AM +0100, Andrzej Hajda wrote:
> Hi,
> 
> On 12.01.2022 16:36, Rex-BC Chen wrote:
> > Since a HS transmission is composed of an arbitrary number
> > of bytes that may not be an integer multiple of lanes, some
> > lanes may run out of data before others.
> > (Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)
> > 
> > However, for some DSI RX devices (for example, anx7625),
> > there is a limitation that packet number should be the same
> > on all DSI lanes. In other words, they need to end a HS at
> > the same time.
> 
> 
> Is it documented in anx7625 manual? Is it confirmed with hw team?
We have application note, and it is confirmed by designer, hw team.
> 
> If not, how it was detected? Have you tried to find workaround for it by
> inspecting registers, maybe it is just matter of clock gating deferral,
> timings or sth similar ???.
> 
> > 
> > Because this limitation is for some specific DSI RX devices,
> > it is more reasonable to put the enable control in these
> > DSI RX drivers. If DSI TX driver knows the information,
> > they can adjust the setting for this situation.
> > 
> > Therefore, add a flag to control this situation beacuse the
> > mipi DSI specification is not forbidden this situation.
> 
> 
> I am not sure what you mean here.
> 
> I have an impression (according t 6.1.3 of spec) that devices should allow
> transmission of arbitrary number of bytes, so this is bug in hw/fw.
This is anx7625 bridge chip design limitation.

> 
> The question if it can be fixed. If not patches are welcome.
> 
> 
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >   include/drm/drm_mipi_dsi.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index 147e51b6d241..df4d15345326 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -177,6 +177,8 @@ struct mipi_dsi_device_info {
> >    * @lp_rate: maximum lane frequency for low power mode in hertz, this should
> >    * be set to the real limits of the hardware, zero is only accepted for
> >    * legacy drivers
> > + * @hs_packet_end_aligned: transfer DSI HS packets ending at the same time
> > + * for all DSI lanes
> >    */
> >   struct mipi_dsi_device {
> >   	struct mipi_dsi_host *host;
> > @@ -189,6 +191,7 @@ struct mipi_dsi_device {
> >   	unsigned long mode_flags;
> >   	unsigned long hs_rate;
> >   	unsigned long lp_rate;
> > +	bool hs_packet_end_aligned;
> 
> 
> Maybe it would be better to add another mode_flag.
mode_flag should be OK.

Thanks,
Xin
> 
> 
> Regards
> 
> Andrzej
> 
> 
> 
> >   };
> >   #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
