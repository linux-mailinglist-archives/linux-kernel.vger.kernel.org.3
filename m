Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1515148E854
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiANK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:27:48 -0500
Received: from mail-mw2nam12on2097.outbound.protection.outlook.com ([40.107.244.97]:7689
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237771AbiANK1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:27:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MztEM3Ksb0RYsIOKg9gIofj1YX7viw+0DASo9mVbEVKsaFLobD5eXPsFoKrz716soZt967aDGJA8zfy/ZC9AkmbdtTxXdXLFxfRncoiT+oxZXRwBgiD4UpdtuCqsfX105Zx7s0k8d1cpobKTWdjEvsLVCzvNe2JxraKwSlvDNjoH9FGMoZXhKmmp1wFblIi986uuXjYp05a+vxHlPy+WMr2vWUx8wmWajQt1B5jwHQEBiBxAyTy9ukoW9syWT+w/VV9sSrnJdK2XPVIDUUMVosX2M1eRjitPX67KDuVeLZM+++70Vz6GVbsr/y/7aH/haRDCwi19cwUf3bz312FZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlX1HRp7HoCNrW3RTH57kofOhAzlqYeFwkmouvWYDwk=;
 b=HLdtaw8OGP+c+Oipm4HXkliUH9VLCiibIlp0Q+G4NVzMI0buHRvm+9PEN6aHOJyoBJsh6Xr/TNPsW6soj0kMfazCjkcZFUMMrqXcGE/hpuQa4D5KJrB8Pzrwbpdbgm2l/+HbhWn2UzdjI+9v6TNdSmV709Z6feKxJb5VFE0HRzipcS+uGdOKqDWiwPPqACwCjFNwBQPNw1OCSIkwrwWTh73Q9AmCSMA34/Z2NCTAUcpfvzJSxGSkX1LAQzh432zmC0K9WFSRXdjFUnGCr5ARiCSfYujecHTkeMwLqMWTlFEu/VSlwOU5lJ9WYhkiyrR5dOxcsnIb9/CZtC7FUtNiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlX1HRp7HoCNrW3RTH57kofOhAzlqYeFwkmouvWYDwk=;
 b=G5BPPmVq8wnv4Q2QSTk4JbDfJqeeTu8qqP8QnBdaegs+XkR+C4Imi2mjlccbxDx55v0ag7xS19dzS3vtdlIoaF+tiEbGjKFlG3cmLm3NUjEOYdiVCCYdEuoIEptCr4Bw2kRoiiztVSqCIHVjUoML3xv9IhBKcVa37Bt7Luiynfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:44 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:44 +0000
Date:   Fri, 14 Jan 2022 18:27:37 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, daniel@ffwll.ch, airlied@linux.ie,
        p.zabel@pengutronix.de
Cc:     jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v9,3/3] drm/bridge: anx7625: config hs packets end aligned to
 avoid screen shift
Message-ID: <20220114102737.GA2606309@anxtwsw-Precision-3640-Tower>
References: <20220114092110.12137-1-rex-bc.chen@mediatek.com>
 <20220114092110.12137-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114092110.12137-4-rex-bc.chen@mediatek.com>
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8359c436-6dec-4405-c79e-08d9d748800a
X-MS-TrafficTypeDiagnostic: SN6PR04MB3983:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB39831B71F2C0F233AF902312C7549@SN6PR04MB3983.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsZqnvgE2hs+3S3sasFfUwrHgVBDRwkTwujRrhPg2nstVKdI1bwCK9yEyxqZ8hCUp65Bd7se08LHug+skAzqBjE1Ql9nNcwpYyoPBBsadgQz5SLP9IAluFvj5JCszxLi5TCBH4271wPgD3yG3gC2DxZRN+lenNIVnBf4Y7nATG97R9t3gOf3W6wlhXFNn9Jx0HFaU1zbd875ATrYXiN9XRk5PvgFgtmVPQQOcHecDRVnDOH/QeyLzJeMNrB5AAT10hc4nQIKe9BtgkrzWB3NDawmmG92QKQl3aTH6uxeV4R2TY+jUWJ/o73kHYMK7Jfyl/AKGGhpvfST4WAa07mc87OJ9RJFYXFW7fAfxnMWy6YD1NmMkdR6ef4GnQIUByGgbVRqwMIMhybk/x4aXMi+BqgkPG2XqSJjC6EJeUQhjG1n+Q5FXkSny+N4wovVhNWyNrWKV5Yo4ph2mdxG3mxkfib7OTwMCSxjWiGglB+MRyeYoOHXH0otIeAdtrgUJO1gAnAv2LtyyZkMZB/ngfAzW/Kg9iOD5Jadi35FZeAYmSo8bp7n0VEcX4/h9ddGTqFDGAEbhviXXeJQDzu/CFsRdTLsKQkgfKkGOiF1uWhK0Iojncf3ZwWFM0k/6itxyPpAuTtvl+p7ie6mmNHEfHiCEg2HE9GoqsFNGXVVe7IkP6Zs4zz7fPf5/Vp0VItzkvyab1qhBxwktH4/L2A6a6bHng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(316002)(4326008)(38100700002)(33656002)(52116002)(7416002)(38350700002)(6666004)(8936002)(8676002)(33716001)(5660300002)(6512007)(66946007)(66476007)(55236004)(66556008)(9686003)(83380400001)(1076003)(508600001)(6506007)(2906002)(26005)(186003)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r35j+CeLSusYAPkz6fUiW+0Io5F5+E5vpa+6dDJFRFUZ8m1mYP9+uyJK2gE/?=
 =?us-ascii?Q?fNYBE0BZNJxoDOq7i0NToYxzi/xyGV4oYAZhxOjRh8XNeG23nyitur/6IxKj?=
 =?us-ascii?Q?ZVO7deWTa2Dtl3W4AW8WN1mIpCpaemT8Swu9LvrjxrghGaAq4qimhsY8k2WA?=
 =?us-ascii?Q?m8kEbhIcIv6WBZNN2NDul9UY3qRLgk9aIG0NOLfenfdb9WJQpOdymlv+JWEY?=
 =?us-ascii?Q?vUO5m+GQ9SYUoRSfoaMxFt6zHH++LV8OR7frX15FW6l/on/4HSaI36XBSsqf?=
 =?us-ascii?Q?fvWPdY4tLRS31Xw1D+HKz+nCyiHdmSlTkFt9HGs3XMirmGRlFhNSFgu0kr8u?=
 =?us-ascii?Q?aZiUcpkaiNDBQ5dxUnlLi5Oj/kZVO0RxiihWJi+XEJvl58Yzz01Z+FC8039T?=
 =?us-ascii?Q?Ib/3sFwLSxq2ammd/kFSPc83os/mqXxEOCBnkdlUJBORl+k5FsmtexJDinkH?=
 =?us-ascii?Q?UiKVboWs64NnkAs5pdvXpVbOq+WHq5cBvVuEC5K5NdoWeKLgCdSX6QN6RY4A?=
 =?us-ascii?Q?vd9rsw7dMNKBOmvpEA7Gizi2wgI/zp/OSkm72TaQy/W3pv2cv1egxv72LdTB?=
 =?us-ascii?Q?1oTUDg/tcvq8l9DXkO7RoH/eY0CkEHn8T63N+/RuL0H6aXn09q7aC3mTLhjM?=
 =?us-ascii?Q?A3VnOT7mscZzP6fXkqlOn3ZtErJtzSpw1RDhU8w5W1LjIYIXkoOpTIVTeImf?=
 =?us-ascii?Q?AvCLLEVwmioQULZb09GWD5yhXObmmceknAw/3sPyC11iQF0TDoZ2UBowLSKq?=
 =?us-ascii?Q?coHCMnlMO4NwUSueLYFCMCEQ2tkyOxUXsQOqQOlsRbCXdQxX+WQ9QYShUQV+?=
 =?us-ascii?Q?qh51H/C/on2woeHsfygbQ8V4nyzmlY6N5msoQbyVLaHhmbj5wC/tIdmDK0lt?=
 =?us-ascii?Q?J8+5Iz00AE3r4jbyqxkyKaRCIo4ymWEUeqR7Rsb1wyb4Bfzmtibhhu5xSEMm?=
 =?us-ascii?Q?ltvOzlvBynCZSCoUjhD3FRZHXJpw0Sb1YwJBqnFdgQyrBLzC36N2o8HnfjSO?=
 =?us-ascii?Q?/bBrMfTZiqdy5btua0aGLcGA2N1aJ0xyM4Vvvqb4jzxJkz6Wv90KIYEjnmMC?=
 =?us-ascii?Q?fMrTtwMIsNnh8E54rFdOa9v0Xt8Y3m6x4n/bMdd80nAAk7OYzrynpc3WMlN+?=
 =?us-ascii?Q?0Zk6NJqVADcS8f+3M2nhdSMAcYvBdou931u7HE2E6FY3yfZJ/binahveQhGU?=
 =?us-ascii?Q?q7OSD8IckLxFcc2LoCtZfZRXFcyvxIYnZa0i5Lq849uTuvCt1jU0f52mtKGh?=
 =?us-ascii?Q?P2WmKNMFJYiNlbDDeFO1jxCukPcpqB2M8212wEEASW9KMv4vpHRT7HOeuJs2?=
 =?us-ascii?Q?KsJ+8YM7kpFsIG7YzpOi53EaNhf+Q2aoukvXFuVzykRvIhxdj+o1+w0Vs8Qf?=
 =?us-ascii?Q?WFQJOwQGyu6v9OTE+YN6UEGLahHHGhxd+t7rI3YB6LGnaxY/+8mZUrJ2iDRm?=
 =?us-ascii?Q?kqiq5Kl7ttuUkxlsZhzgK0C8J4m6gEf2Fj3GsnCjqlEmqmI2mRUyZiidTwyY?=
 =?us-ascii?Q?JLrtvfaKCJzqYqPSkkfMr5aH8wQiW+Y9ta1boKDyYYu1tuO+pGzd9gJhU6g7?=
 =?us-ascii?Q?LCVNTnYX5Z5BZFwV0blwo6X9zyseC8s1lrh4pvFvTkQ+yCvsX1gKnpcP2xnk?=
 =?us-ascii?Q?t+G12hsncUDtAhyI+Qef7q8=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8359c436-6dec-4405-c79e-08d9d748800a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:43.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRlsgD3YScJTyPfnVOVFnOWNStw6gInkjaMbwQMxy7sAjMKnji/HVAilQ7RiCTLEByRU8Sz2p3HEVqb25JqtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3983
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex-BC Chen, thanks for your patch, it is OK for me.

Reviewed-by: Xin Ji <xji@analogixsemi.com>

Thanks,
Xin

On Fri, Jan 14, 2022 at 05:21:10PM +0800, Rex-BC Chen wrote:
> This device requires the packets on lanes aligned at the end to fix
> screen shift or scroll.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 2346dbcc505f..fe32ab0878ae 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1673,7 +1673,8 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>  	dsi->format = MIPI_DSI_FMT_RGB888;
>  	dsi->mode_flags = MIPI_DSI_MODE_VIDEO	|
>  		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
> -		MIPI_DSI_MODE_VIDEO_HSE;
> +		MIPI_DSI_MODE_VIDEO_HSE	|
> +		MIPI_DSI_HS_PKT_END_ALIGNED;
>  
>  	ret = devm_mipi_dsi_attach(dev, dsi);
>  	if (ret) {
> -- 
> 2.18.0
