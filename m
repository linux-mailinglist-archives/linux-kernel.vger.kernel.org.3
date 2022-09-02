Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6125AAD31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiIBLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiIBLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3E5D103;
        Fri,  2 Sep 2022 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POJ4zICj5OkZC/SvPoXJsx3pCJETk/ynfTjLI7qTJ3NjSbjjQ+bZCx0+eXRw1bl07f3an3JdAdKf42xkVScPmITaY0fCmHGCwxWPVoRP7rtLysgkKcoqr+oDvWMKvsZzUyzC30KmOygLaT0f/Mv6Kl8Q/Uky+eiaaP2lGHBvosgec+nGcqrpAnp4R3/X7f7D64a/3wM2Y2jNpIuM6R+wSA7pT4tuKTlAZ1gilVmaQuNso4G3cpDhfhR3jjSaE5cxRIGnlSpnHf2swVBZpkS/nC1vbNatbpdZTMu5RXDFM/9yhwZJo83SqhZ3VCLa986EfN0/B7OvIcJni7k05k159Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26bTvPIXamFH4/QRlFp+HgLg+pgOmJYp7TWjSnqJ27Q=;
 b=gJ27yTZuORZMmfEyrYkO59KVb2FRhp1MZKlTMrcY6XEiL506piPPW8mlAS6Qko0iVEsowjbXvPQTTuxBMssveF5jeZP5FC/axporaoHwxpsuic2StdouX0cBv+4HqtrEyEFiDNs2Pr2BCUhRW6kx/VgkFAUnPIlVvBTLs3Z/JvBrloHItjy9Dz6L0GKDdgXu12/e6y/j+v3S34fiNpBpFqbgkrNIzASMIoHOVRqgjKfmg21gzbxIDdOT2SvBGX67OrAxqEnPMM4IbF9w0s87btUgiszxc2VZEgWF3ryNf04pbA9J7mE1CIdDa34/Rg2JA6MdmMCTSb3d59xRybpBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26bTvPIXamFH4/QRlFp+HgLg+pgOmJYp7TWjSnqJ27Q=;
 b=JhytQgBr1vU+1Nf2QtzyZi15dZqxGse49z7JJppnhkiLqcPJKJZf7HSLIM4dmJtzxIIZlViSL1QIY+JqCnIeAB3GuiJAkCaWaUs/zGXtstjnqEe065k8m+nZN/Jd7JWXvJMeLx1rAwUzf/ir5lw+vYPSAVFXmzAQGrvodtkugmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5447.eurprd04.prod.outlook.com (2603:10a6:20b:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 11:10:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 11:10:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] clocksource: sysctr: add nxp,no-divider property
Date:   Fri,  2 Sep 2022 19:12:05 +0800
Message-Id: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc88996-7b64-49a6-c3dc-08da8cd3c240
X-MS-TrafficTypeDiagnostic: AM6PR04MB5447:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jty4rxh/tM5AvQ5bS53R5ZmShd799gQvB6wNU9QlabZYmerp7Rr0aPS7bOxwJsKdfks5WE+R3ELx1/ov4vVswbpZ2jcRA3NBqSgYG0Tra9x60CP+Ty2knqiUKYr+NxiUkokVQ//NVKLMA6wsbQmsNWD230n0PM/Ns+Ep9bd5Zlv8Y5wMiIZgIUGrFnPreeIMeIf0Cjvc0MdgvqnOjKigPvYp/TCzt1UXCVGnq3U43Fvo610vmQbxzUFQA4FoYAKk/3sj27VIjyS7v5Vq7ZwViIensRVcUfWkRU+eTFl1JYjDxXymHHTETQ+r/mQsI2srqEDGD5dOGk9EW9NZgDKdSlvi16zJiuLXE1JPcAYcK7DQnnhkw/S8j23utaLzVGllPpJJBerD/TjTZp60PP+ITShW+dbyr7Jotqh9/8rS3cfH6yI6kzPV74T52yko1jk4gflpqkbqmFmg5+r81ZCA/loH+NbFpGpYrodwm1oi5rrpAKniWbBo4ZS6Hn5DH+0EKow+iJOpzBMnof/edR6PVoybMOoonvlwykzJ+NaaIcImg3A/uX9SvmkIEA+1wnCnSvnmf0wP4aFdAnqyVTVyMQz2lSIE5h3OzWHEjhVT/Rbo00AwjeMhUba9PPUkrzyu9LjcT8qVnkRPqrocpT67hZ3fjVAttvMR8m1rbtstYkiSQNinK85k2Q+P6OAHm5CKcAgQLMUFR56t1HxpVonPd+LuUZRXKBu2WNTlJaqjrjXKPo4N1HytXCJxJZid9TTvM+u1TSCxRoGd2jNi8XAU4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(83380400001)(38100700002)(38350700002)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(2906002)(8936002)(5660300002)(4744005)(6512007)(26005)(52116002)(6506007)(1076003)(186003)(2616005)(6486002)(6666004)(41300700001)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znwkWw/RcFd9IaqWqVUeW+rynrVORYNFqqrXw2SB1W36OrJEfpn2LAn1idRG?=
 =?us-ascii?Q?A8kmZRvnW6wwKdOQs/u7aqHwncZJaEsgbfVx6xpSdz/ByEfKaA8nuv2d0mjz?=
 =?us-ascii?Q?IGl6dgSfPY7Dwo26dGkcWnkZeQLl8eL9X9emxSdXfriFw1vLb8KyJBmdG04r?=
 =?us-ascii?Q?+oZxc2L/o7e4swMw524j4O74vZEi2feLzb9iLOw50FUG72gaifZxlv2raRLv?=
 =?us-ascii?Q?dHYIi4VlMxNXpLNiAaDrCLs/aCQvE0pv5pqOMipol0lzSmh8kdmweRB9F8hw?=
 =?us-ascii?Q?2OMH3tyqQRGWUN7zaPPo/kCW26MZAc69Kqh+QJ0F7AyTyxhrpKP4C4qllwaU?=
 =?us-ascii?Q?r1H9kl8PSOX9cM21oET9daFhbQPnFF+vL2N0iG6gvvDZRS/PJ9PQoZi+aa3E?=
 =?us-ascii?Q?iwedktaQfhdL4a87vvc/ZnIyVoinKDSqXVxF0yRFdiwNnMe2Rq16lhkKz2NC?=
 =?us-ascii?Q?eFUVdBdmH71e8hWnXen/w/g79Tj2OYGMIoTcdOMByCie+v9vcLJ88tlHF67f?=
 =?us-ascii?Q?Hh5LZckGAAOse4qz2F7uvXdyKH7Bzn0NkWPRrT4LxxS19/YOFprJ7EhAc0Ku?=
 =?us-ascii?Q?vyeuHgOP9PtP7ABARx3H6fvQtDsNIKLSibqojZsl4+8WzkkTJuAWWyA4DTl4?=
 =?us-ascii?Q?4m6i/iDJM4SahRjs+su+iuvUhzsxGXUxIr3nZFOKVpSEDE26kKMG10Kl0cwT?=
 =?us-ascii?Q?HorO+bEqmsRg3SZtY39DRRVZ+6F1WzRaG5GaFfpC/fj9cODqCowzIlrJ4nir?=
 =?us-ascii?Q?MlNFWHYGEw9z6AR2kVi6aQLV675MCTW6vG1eBjTYYB1/zX8GIGmWA+2Sg3To?=
 =?us-ascii?Q?5wjBmCaPs8IdGOJ8RUGldL7oebbmi8rvB2LRDVGUBWwoY6TApndEegAHzH6H?=
 =?us-ascii?Q?XoRyAsMjW5sr2ULgJhj9ryC+1rC4kFAABAVqNfbDwsvXZFS82jOnmF3VzXQw?=
 =?us-ascii?Q?krVf71rXxHSDhiXTxAqYJGLhL9ECOoGq22x5P12fUoFMQ1BG3rEOUASi+A/W?=
 =?us-ascii?Q?l2fZodkYeJPDxAEGcVvMtAvFRfAqB6OozEkBe5Gm9zmscdpNb5c6k+IVQTWn?=
 =?us-ascii?Q?HvWBTXE7m+GGODPtRrr4E8bp9cWid6LjoUHI+eZcnnUHEawGq8QJ6WCjASZi?=
 =?us-ascii?Q?7DmU+SX7cWAzwVsh+vW7eb5ANx4WrcSfVrg9KiM5yyCkTwNWHifdmfG+DRpf?=
 =?us-ascii?Q?xe1aSgBQWXr6c2/76378BvtIB184Ky2o31l19GkAqKiNgGPOS4f28zShpxmK?=
 =?us-ascii?Q?9OmX3QHk1LfA+Ge9W7NrSvP3d8ts/eE/OhUlwiblwo98O531EwPLPO1I5p5p?=
 =?us-ascii?Q?hfdveUR+wp5g/WgcRHPGtH+8u+qtcUUsBHDhEjDH68z2Ej8TbHzkb1INTUAo?=
 =?us-ascii?Q?k6+yCzjYObWsfhFWV/fDgeNl8eR2GtlRtIrvcYm9Obf0oKxVPlUreMfIQgcs?=
 =?us-ascii?Q?UH62A5Ih1qW9Ht323g6aYG2ZSmjhhOOjH9hOPfQiX3tPe5+v0NbAHscfopf9?=
 =?us-ascii?Q?d3fAV5Jmy0sK0ks5/XIaf2Fh36bl6aBJOIBLY6roBIoUIYyYLinv8dHleNWs?=
 =?us-ascii?Q?wIbs43Qjdyee2GNBAWEpxarlWPk+7lU9xOmGfnLr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc88996-7b64-49a6-c3dc-08da8cd3c240
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 11:10:35.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mG/GbsTaBaRs2wOXSTl9f/qK2lYS39hnVFdRdQ+tmv6e+l81FVCrGFMl2m0eSrCilzn5Kx1lq8oZHgb4UOYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5447
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Legacy design used in i.MX8M* has a internal divider, but new design
used in i.MX9* not has that divider. So add a property to indicate
the divider exists or not.

I thought to extend the binding such as nxp,imx93-sysctr-timer, and
update driver to support i.MX93, then no need to add nxp,no-divider.
But this means we need to extend the binding again when add new SoC,
saying imx9[x].

Not very sure which is better, so just post the NXP downstream way.

Peng Fan (2):
  dt-bindings: timer: nxp,sysctr-timer: add nxp,no-divider property
  clocksource/drivers/imx-sysctr: handle nxp,no-divider property

 .../devicetree/bindings/timer/nxp,sysctr-timer.yaml         | 4 ++++
 drivers/clocksource/timer-imx-sysctr.c                      | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.37.1

