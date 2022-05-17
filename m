Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB85299C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiEQGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiEQGr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:47:56 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54245062;
        Mon, 16 May 2022 23:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrRMcYCa/Bc7M4l6QCG9nydpMtL3txGxdjTvaKaOAKGUM0hnk85klBxkkV2WF4cJQRetKXtwm8bMiHagDjAWkCRWPs6cTbEvG312E11DOSrCtJ/JhgfzhxLpwoSFMbQDSlpqdsQTRtBOFfCw8QSC15IpQjspzIrs3wETAkALDa+qTVCX4kjRD/BZQDAX0jgZgOQ9wvq2O6j7wdwp4x15wZIwlnD7YeSmj4WmTTjg0k7gIovRf144tvFCcMwWeIaBEeqoTvCSSVkF++Rs+i6ewXVzXuQSAvVcLZjjSFjAQvGt477b9rVXs4Y5LVqY3SvPK7gX9K2tAKB74Q712AcHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEcY26fu/75EW7aEJaPNpF2scIeoz5wCWxDOPRGLUAM=;
 b=PU4KFTGa5WeBNtgbvnK5O1KtZsV/8RfKIwrkU8uuUgA4udx8QPolDvDgOhjbJMuOvAp1tzEiXXrRoiMz2+W9VDcwyPyqgrPcACxe8rbYfGqKKVLgBvGq1kM06VDekeIucKZKcyMtJoWto5xJFUYxnbFf5nNvj3li7r/KmigfowvZcNSSgjOmfTmJTKqnG/J/Id1eXHw0svS50a4sA0/lvWi+7b5ymaA4d7TIxmOIzA1MN7YYB6vtKKY3qfCw5e76jHIz3WQSgHqjrVK8G/OsDWOtUSQ2in03huZtHUk4q0Q3IqLxsQOsFVH9PzfG2xz4uvtiPhLK9/2qS69orvv2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEcY26fu/75EW7aEJaPNpF2scIeoz5wCWxDOPRGLUAM=;
 b=HFOUPWhcFInf6TjRjk2nHXDcLw34CprvT+5i6p+4nZvgDrJ+iu8mUq9GMLY/DVhXMXqwFCipNix5gPmPgS3thZbq2yoqC5rEbYL2vm9FYTi7UJ1vKkvzWJAehvs1IOdVl4TmoMVVztAyudu+mJ85c1f+OSkPITupTQzlSLIBtZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2697.eurprd04.prod.outlook.com (2603:10a6:3:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 06:47:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:47:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Tue, 17 May 2022 14:49:31 +0800
Message-Id: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb4c37d4-3626-4684-8393-08da37d128f8
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2697:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB26973A35725618BF9A505D48C9CE9@HE1PR0402MB2697.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XfvefiuuRHKrew5K83EBjZ2mOXbtUJafu9X8AFfZU0XqnGpwSaHqajDc9MJ3sIb/v7G2glGtshAfRSI+TUl16EohaZXHuLtvmb4LOESvraySE12jglqIZvZ8xQWPmb8g2vvIunwFNZDVuMNl1Aje49d/NQhMK86gw65I08I/Fflu9t5NNwY+5RbeYwsbGSMMFkaIjDLf2MiBHjzk/BAmcFaZUsUmCzE8u1wosuuwENImwCx4qJ5Xh6D4+Lempx6TfaUdaeBzyOVWPknIla5+yqmh6Q1jYSQywWKyVgYEwrXTHZQljbwmCP/HIOqMmrY9en2C5yvZpxBUpF3SaI8NKEUeu+ClBjyw35XNglDospVCVQIEZaJAjLWs08nJOEetTKokduBGCOWRzPMmVOnQKh3VkJJEF5JqcoO7NtguSM0zkNUfR2RKA49HYU3xkuhYvO+icYlDq363nfT/Hg9IuRq0wHrRKv6AiGwI6t0P12kyOexlUu7Z6d3LoHslGpE+ZjjQAqA2uD+11jhFBvFw2pPe30slnNbu5j+hh8bt6RGixHZy8b4kx4cGvX1OX+zT9RYW5z6oz0Di72bio8H4jP2C3VBAZfEeHbNgkhpB7G3aPV1Cq5143Pp0rAIY4byct5f8U60k2FPXOAYyvoTT6hX1aaHIu3Zox6MGlbRDsGk2JUUR2EmgP/Zqx0cpAfhgeLI4rrxGfvwoGBI8ktpWljpSPnDSyfrhp867/fxny/Yy3NVZ6u1wobmtGNAWHnaWJ9kzSSD12/E7h+rnKigjBtKTmODceWtUjvL4SQFui/TTCvEUfxNofsCsu9sbnLbl/pu1UaVPTt2l1zfyUqerrR2VDMLHsqrzExGS4ySop8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(966005)(6506007)(2906002)(6512007)(38100700002)(6666004)(38350700002)(52116002)(316002)(8676002)(4326008)(508600001)(6486002)(26005)(66946007)(921005)(66476007)(1076003)(83380400001)(66556008)(8936002)(2616005)(186003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DOwsiZErE6PNHhNWePkwMQ45jox/AhV6u06ieKDAg7ERwiT/phq1816D1aD?=
 =?us-ascii?Q?1OocPldVsHtHgRY4dFXcMyv9T795FINzp19gnpKInqloZPWH3pa7YhNPulHY?=
 =?us-ascii?Q?RzquEZ93OdqgaaHQRuUAwGbcid7dadQSrVOgz7aysyZ77E6vrnS9g2yfKg1n?=
 =?us-ascii?Q?sp/CvGUkya5RMSpdf6y17WmwlieumLP/MHSQPb+yepOjG8Hsi7AQKUV/E5sM?=
 =?us-ascii?Q?c19Navi3NURA+WxLi5HRoqfCdgeDOblchbDudBdiOuxjZDhGmR335IrOqkvO?=
 =?us-ascii?Q?J2dDP7iuzBk3q7IZmAilsxmLDEStwXoJggtA/bknk3S0mSMZbhTJGdP17kkB?=
 =?us-ascii?Q?+C2IxIhQR4+fmJZhEPim35lAqHW0+V1orymvKP8E4SBeGFdsYW2hHJTH+S3T?=
 =?us-ascii?Q?kqSt0Ma9XbPRFrbasAFCHyEXwqj0DmxMy710SutuqmDx9ajlbvLwWrzwG1c5?=
 =?us-ascii?Q?ntkbUtE0sd1MwszqIsOB7YAxyn2GRdl0lh58gYwEPVU+qjzXkpg/fCaXVjur?=
 =?us-ascii?Q?kBdIepMhN1eHod6NKZrUcATrWEIwh/QkWAfooQ4UBjdOyceJtf3OYn7OaPxr?=
 =?us-ascii?Q?S5pTjsLsXJThSiArp3Po2SfkmCW+SkZf5UR9L0Hb8pWCe5stQKMGctM5oi1y?=
 =?us-ascii?Q?6uUlYJQZ/p1CVXvUfWklGEKg8i/1eiYSuIFnkO5K40az3xIRmVwKyhiTwOIb?=
 =?us-ascii?Q?mYJ0uYjFRd4+g4swMMl/GEPzVdV2o6OaQSWUmL4+75mjGjpPNZPP8abt0Aaz?=
 =?us-ascii?Q?tS3leR+YcMlO7ednwtdMhKXb7A1LSo2tTWwZVmDz8wnJ2vUZa13XbBLAHI76?=
 =?us-ascii?Q?LHBUv88wWXsj0FwYZQJdKz289VhI9+9mztceUQV21IyLJYTNvKbqs0ESh8nJ?=
 =?us-ascii?Q?LBWQel3b4E4HkD5ZZhBxT1gcRdri3fAozI8KrpK9cGa50GhxnkMnes2tufMN?=
 =?us-ascii?Q?lXuwdRxXvJv7V5Dl3HTB0dd8Uedc2wHDfUiB25ElZI3KoPDXtNJf2TU7uuQV?=
 =?us-ascii?Q?v8neVMzsgXK7hM/gpYlQ6CII/eMMCLebXKFudoZPGPphIcXjcxpt7YzQQTHt?=
 =?us-ascii?Q?TIDDLue4QS4CCQpiKlaDyHPNyy4MExFRNjLA1bLmplhlGLTpt4KgsOT07eRx?=
 =?us-ascii?Q?QbjsVKaKcsxrjU1ClugFgjBGILeNvt/yUnC7Chhfz9NOsByq7FhlvsLGqZFe?=
 =?us-ascii?Q?d9R8mqOIMkf5tdR7zE2WlQXKtjV6QZ0HQMtPBotcOJ7MAjJKHjOMptva64Bl?=
 =?us-ascii?Q?7P8s0za8FkrdvmJJAV4pqrMmcIA28XMtFsFKVjsuUGoUHOtMUJ/5wazLqTjV?=
 =?us-ascii?Q?Xi42q53XUZWcwEVyvfaRMsnQef1tTsZFUq+LqurCcoVjIXAtj4I2jQM/T8li?=
 =?us-ascii?Q?Uh2PnWuuQWoqhffMIndJWz1ElwCaYUdnFFP86wf2Wp7EpYwJkUsPaKAazvMJ?=
 =?us-ascii?Q?dntCiZvuVeCMrxj+3W51j/VQvQg7C97Ke2XWo7/1thapJZsRYwl7x1d7GfcI?=
 =?us-ascii?Q?cezn3yqJnoKT9QG92YKs+sjZXRKWN6uaZ/3+zJWxlL4u7mP1Xk6SXbGw2HTe?=
 =?us-ascii?Q?W5JuIKhvhfjUIQ1WBmjge6JpPvN8caiAwNKK3RgCiqwQkhEUS8sujMmiHeDI?=
 =?us-ascii?Q?rD18ozgZeHE/x3rfZBTze57iX2Zhsl0JLOC6OOueysRAjCswk1W7nu23PM6M?=
 =?us-ascii?Q?Jwyg5R8sS/ZPhNiMMc2PxKGDNYyZPXZ+AxBRZ4be+W6SLc+qzQeh8jP9sl6G?=
 =?us-ascii?Q?roW5C5skfg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4c37d4-3626-4684-8393-08da37d128f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:47:50.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smSRgmiBlFDJ2zCDfFTE0uzh/0CNn8mcdSXOQLM151BVwXi/y4C87ydHOIit9O1p+OOh4X7GvwdT068Xcaj46g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2697
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Drop the dependency in V2.
 Tested on i.MX8QM/8MM
 Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer
 Drop 'reg' property Per remoteproc maintainer
 Drop mcore self recovery, until we land in common framework support.

V2:
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
 Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Tested on i.MX8QXP/QM/8MP
 Addressed Mathieu's comments
 Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
 Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
 Update commit log
 Drop magic number to get entry address from device tree in patch 4/6

The V1 patchset:
https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/

Peng Fan (6):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
 drivers/remoteproc/imx_rproc.c                | 222 +++++++++++++++++-
 2 files changed, 231 insertions(+), 7 deletions(-)

-- 
2.25.1

