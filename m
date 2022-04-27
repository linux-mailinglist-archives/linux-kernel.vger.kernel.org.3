Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B09510F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357555AbiD0Dm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiD0Dm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:42:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C774DD0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZC08xt3KzhLnL61bymzPGMhKW1cNYQWjacd6UyskUvjcEwm7ZF9w4QmBWbcgYDeqdglXUXCkQA+FFuKmpxcNOCxIizvYy6zc4lTIAX3jga+17YHBaiV+UkEal7yCLAaCQxNM4il54ujxgHfQK3zmsl5/kEHV4hMGyBuu6GZU02aGJWHeh7to+S42Go4ZSVb20Nrz1iNkUC1DyOz6yjuJ3+9CeiI0d4xi1W/OOwL3ZJ6km5oDuPeqptxCrOB1azXAmPLSkIBpLBg1DlUgWMETE+dIe0LocTm6HUjzXmPuDGR3y+fnTcbJitQW78qfIyCEmDzcnQCmtmyEglsqd1YcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSsinbvTtvQf8HZvZIKPVWD1ZbypylbIVlJUJ+bianU=;
 b=eU52U/fe746RVoXgvUpSNWX7u93ejnCK+gHOkWdhM+6ZGyBFAR/kTfLiYG6/n3RblgR6vwOJvG2Ly/AwvrgqW5M5/q6VPTxivr+CCtDY+yjPXWcE8egEQkmY2Cn9sdiSrb3cq7CCyHkz4xAY8nSfDGj8167stHLX94oW0WqC4iIdmq6RhkyblPV6ghJDO979TPsqXtJa4rlJJKIVWhgHA24n0r0ntjGjBzMdsmkzj1vtL2gbD82u3t7PnzM8zn07jsC5OE+JuESlcC2K+fm3TKMa5WJ00MsMUIJSQ+zIJJO+5u3OKfuYhA7PTJZkuezIVRpMzhkGM58mZi0YJc9zjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSsinbvTtvQf8HZvZIKPVWD1ZbypylbIVlJUJ+bianU=;
 b=lEN+EZosubUTJVZc7u1e5b4VS7NgklUN2QpPUCyvLnXogMZbvEFK08rdnZdaEEpLom3HRiEdB9A6nDxoimvXHE2WGN7QvcvSS7aa8vUbx8u67SsyPB6q2GQ2y6jSEYz5cNGKBKAl2m1yP9xCeuz5ZfyXR6/cgBWRofwC0qeEkV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (20.177.94.19) by
 HK0PR06MB3185.apcprd06.prod.outlook.com (20.177.160.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Wed, 27 Apr 2022 03:39:11 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 03:39:11 +0000
Date:   Wed, 27 Apr 2022 11:39:08 +0800
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kael_w@qq.com" <kael_w@qq.com>
Subject: Re: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
Message-ID: <Ymi63CIzGLOCniVo@myhostname>
References: <20220316014128.89315-1-wanjiabing@vivo.com>
 <DU0PR04MB9417A00C2F5BA3F8D6F2C7E088119@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417A00C2F5BA3F8D6F2C7E088119@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8fadc03-87cc-4821-4b4a-08da27ff7e04
X-MS-TrafficTypeDiagnostic: HK0PR06MB3185:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3185312F6612F48F74495239ABFA9@HK0PR06MB3185.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK1aFYctDkZ7SXcOggxISDVgeCAhyYukcZYYwU/0PrVzrdnzN4KFKS+O2eKQDw7I0BxhmnwLKipKrg82UF2K8MC6Ke3ejGiuQFCWYNVrKqXy3FFovIbIQh0dWnVnRAH8tIMv3987fho5ymU014ZjOXTihGKkETdggcnrUqZSJKrGjxv9HfXiraQR7w3+HwFGGDQ7U//no1tsDO0pop+hVnHWpiqIObzguBMbYy+X3Md/4EGPkUJW9OdtzoDjiEhxWX3hAwRvoB42cmJp9kOOKFlBxw8ivAfYsEWi6Bv5wthD5PYY/mJSbtAHsE6qErPMR2CvvFMG3pCL1P8HgncwrmAW7XwWot2r+X242sFVj8OWV3bx6ZV8hLAphxsyWBOznF5/undpzYYGXLabzqFHqYdsLEBIpnCcyqP3GFps8/X/rCduVEmMsDFNK6fUX+ps9Fd1utO/0RrSthLEOBWAoSZsNi0DuPyhxebSHYWcOI6+XgSwRclJsgyN6PcfSGXVQ678uoDVtIfjE6UxewYrbOzGf+HsNRfFoA0utw78cTSCAZxJPBfTqLE+KFTShZpOp11oAxMa4WDHQ3hgS38a8B9e2auR2uSYFQ4e32qhDq6531nzyzlNprxvqeZgBjwbcUtuH34RFEcLmophjg7E53uKUk89bCmcnaRjbys2QvRmAK6KJupyXoPB7rzuStXjVUeEPn80kfvFEzWdp1XQO4HT55m5qlpaIfc1rfrfxRIgWpIRiDZSUlSO1zpkZQRISAt7aLMAehsI0SMjmWlF1ukKx3TJDZcPQmIJXMOslW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(15650500001)(508600001)(6512007)(8936002)(9686003)(26005)(6666004)(38350700002)(38100700002)(86362001)(2906002)(5660300002)(66946007)(52116002)(66556008)(6506007)(7416002)(66476007)(33716001)(186003)(83380400001)(8676002)(4326008)(6486002)(966005)(316002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2V5CIZWI9smH3J4ex1fX0+kZXCYEvD8NSXh/ZvPK+5xeB9HQYLjw+SU2NEX?=
 =?us-ascii?Q?iKYPC2U4xnpEki13R8ejSg1bJrq9X4RLr9p3KCuLm73pyKklfUITUzBheESQ?=
 =?us-ascii?Q?tBOVlbbDC5EvCGoYawd/h3amgbLfOHWCpyoOCmfGqMBCgP0QcPXSH+4gtvmq?=
 =?us-ascii?Q?8AHbcVQRIoQ6kE7jif2ky1BblsFEWKzpwEQYeXUiecRv44G+34sLUzbDR680?=
 =?us-ascii?Q?AURtMiHss6S2Xe299PAkfPPlOAt6pfJVWLXevTfma2BuwXQAx3iz8fxvwmV1?=
 =?us-ascii?Q?d1V09JlMt/r5tETt1YpVI1TCSAGLQ3/dXqFuaEqquzGa2Tch+bPHbAiQEcXG?=
 =?us-ascii?Q?QKFpBrWff+hMHHtQObCdVAbvi3TgRlnICpFXG6zh5XFcnQw9zqvk1yxndphU?=
 =?us-ascii?Q?dkoTlyN190dMMkChMWHlahH+kbNSh3cv546G5QZsu5JkSr0mUFsl6V+DFoAD?=
 =?us-ascii?Q?vSHH3OSsFDRyodcJpWnHYbiFQAm3J/kzo0dxw7FrDNMUmGAp+YSl0Di59xBB?=
 =?us-ascii?Q?OP5ycKQj/xIkn0seu/CSYDEOTNfHOeUvUGwyX2jBttCPEsbeSX4eCc1QMTR4?=
 =?us-ascii?Q?pyJ+p8Odj3EGA71fAg+L0iMayMK1Jpjp0NhSPuxkFoYSyOrEhOxG/NQtSP0I?=
 =?us-ascii?Q?bKa3G/c/N/W2IFx4ks1SB6VPbYsZ9lGETDSh8wi2p4EGUMeLzu0z2jjggMik?=
 =?us-ascii?Q?FDXASmh1XvkEX4ASiX4cG2DKDXFhqdoxi6lzYmGH1CrI+6NZRjTub65+W7t0?=
 =?us-ascii?Q?KlypUDjk5vwlgo7jVh9ikeIooys7THhb/6atQNVJzKtRu3xB6IflU7oQcXNS?=
 =?us-ascii?Q?T/1z/9Ehn+3VwBw+kUPj4FkmkqJNdtIX0clRXTdtGwoKqsdW1ZwmeoOtS0Xh?=
 =?us-ascii?Q?yDWB1OIbEqDPwYOstEbmEs3UafDK8lgUUiAVmSaSLibSkjs9tMreUxiP5Xic?=
 =?us-ascii?Q?uOwgWliGoqMnTuKyDzqRCJ1/vjnEd7drtjbmYyDbW6zLwkavKphMYAKcjU6r?=
 =?us-ascii?Q?eAskDjVCGy2X5bvrYCRIN/CESw5IkXVagjRYcTMx36QUtKBOR3dp/e3XO8yW?=
 =?us-ascii?Q?ig63+66WkRoIXLJrDSWfDE7xzQsWi8icfHiqD99ax1sDuUFCZFu1pMB4Qjvw?=
 =?us-ascii?Q?aMZf724ZeP4oBfWSpcJfsOYRQahaMV4ZRB5WDTfSAYCkpLFcknY8oBDaAXCP?=
 =?us-ascii?Q?2nEz0WL6XULTpgrbWfVWTqvvEod4lqUMEzvXk7xeaCQBu0aIls8LkX2ZIkoQ?=
 =?us-ascii?Q?m6Fsafwdisy2tjMubq2CM6s8eGKSutEkdUozBVytBHYAG0ZkIIz/ImbTTtUN?=
 =?us-ascii?Q?MWpUoX7JAaAeQBZfWk7e7Wk2SH8bPYjoeELYjnw1CGqa6897Y+9rkza7m+z/?=
 =?us-ascii?Q?K8QB4I9DgzSrwiByOqZ2ym6UCeYu2/vnD3tDfVZoKU7ZPO+wIC8Au6ZPTu9h?=
 =?us-ascii?Q?x/MZwBNVqIBe5w3tzUvqu55h3Mh0Iaf2lq7Nj6Jl0jjyl8lSQkK/5InlI1FB?=
 =?us-ascii?Q?Df4xY5bvrULhow4ctJgisJwg0QuGrupgpMgS/hIlxKzAnrxw31N19m/Izddi?=
 =?us-ascii?Q?oax4s3Q3gXMMfaA4dR7McOV5VTkrXR2SFKCDnE77WsRXj28MDk1TWRlgSUEp?=
 =?us-ascii?Q?3xmxwmwVK57StJ7u5IaLqkZLnMuKUDIPTU+3ZA1JwD4ntZfc58mi5NcvrN/c?=
 =?us-ascii?Q?QxX13niwzArU5sR4mScTVjJkCffEC1x7nTD9wMb1dsp2e3OR5LhNvMrZ2J3+?=
 =?us-ascii?Q?7Msa8crtWQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fadc03-87cc-4821-4b4a-08da27ff7e04
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:39:11.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzjXhj2O6K/+ZbiMNgNdidwT6uk6FSn1TaC4tKrar4giFp3T+o0fVTR9IWrz6lyd9eYXZisHpaBS6oZcEpfJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3185
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:03:49AM +0000, Peng Fan wrote:
> > Subject: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
> > 
> > Fix the following coccicheck warning:
> > ./drivers/mailbox/imx-mailbox.c:884:51-52: rxdb: first occurrence line 887,
> > second occurrence line 889
> > 
> > Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> 
> > ---
> >  drivers/mailbox/imx-mailbox.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> > index e88f544a1548..df8a785be324 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp
> > = {
> >  	.rx	= imx_mu_generic_rx,
> >  	.rxdb	= imx_mu_generic_rxdb,
> >  	.init	= imx_mu_init_generic,
> > -	.rxdb	= imx_mu_generic_rxdb,
> >  	.type	= IMX_MU_V2,
> >  	.xTR	= 0x200,
> >  	.xRR	= 0x280,
> > --
> > 2.35.1
> 

Hi, all

I notice the status of this patch hasn't been updated for
a long time.

Could someone pick it up to avoid warning again?

[0] https://lore.kernel.org/all/20220403145304.685443-1-trix@redhat.com/

Thanks,
Wan Jiabing 
