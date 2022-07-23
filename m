Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AC57ED26
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiGWJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiGWJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAE2FFF2;
        Sat, 23 Jul 2022 02:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy/pnwB2HImIFuoydNpCzSERIxkGbRLUuVXb6Jsf2sPdAFx2/hkWG7FxBxPnuUoAsOU91mJI0SNyzvIQu+h2XeZKymHqudBIuum8Z37N2O6hzK/B0QQZBgqz/nT3nM6jR9Wpd+tIDUFAlq47koGDA8XiMIF9MK0qR1N22DfjBByY+vYoEdR4N25Fz0quZhW48cfSUwHPsENock+c23GKVSBTU6th4bUlMKXoAK/Bz/WtLXYq35PSvqeyocK3Jfx3Jj1MeLA+kdHwksBbosqNS3NegIr08/h1Lupb8+d47QKevctXwai8jDw6z3sISMPFkdfFN90wQsLoi3vWrCEtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r0w9935HeRIElZkIY9eDoa10GWpc5EGFiFR9YvTjg4=;
 b=Sl2PBkdzrtN7k2NsvTJ29BbAHSJ44Ms4YtWIBrjcVLyLJgNhyzB9P4r4qSfl97TB/MO+cUaClh+vYWaA3h8CVYRR3r45+ZKUkwEv46MLAnkpJBUd7fL7/G8pbdTsoWG3xCxGxnvbOEqKsZv86azkqp5uRl0XXH8JO7UExAZBasGUbv6x9CkVda3Hey0cehOPchRC3BByeBifaXmo9CD+2tqKzBKnJjOnuw7NI91Qh3h4Hk6NzlFH2aoxumARLlFotoFvPKxqoscl154n2rsOp85va7HF/6A8Ri41AfsO37oVJghP8BXqzYnn8FQw6c9wwSaST18FVjQVR3gnAdXs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r0w9935HeRIElZkIY9eDoa10GWpc5EGFiFR9YvTjg4=;
 b=VBO+dR3GtNilPvwrE26p47DaXDGl5vZ7FP5ogKKe2kHbyhBS5h5/q3EJJ64gOYUHrjjbejPIRC7D6ykhH2TpiTZkdoHN1MwiEac50SzgZErPxDTmftYHYo3CSigQMau0VDSNZGJqALkNslvu5fqFu9QtpGTQn+sQJRMYHpfQGn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:41:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:41:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/9] dt-bindings: pinctrl: imx8mm: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:27 +0800
Message-Id: <20220723094335.3577048-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6de4575-1072-49ff-a0a7-08da6c8f96ac
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzSTBP4EugCypXjAMlODq/+iFuS/9yUkMH6xKwNc+AOkcwKa14AzJ3+4zQWS3dwIfDfOS0zPO1rVfY1VPUd+vbg3zP/0w8nVMGU6EIbfTeqFdFjq+QzNbjMvIqnWNtT1vUgruf55QUQ57ap0X6nfv7PC2vTr2iO/oHFEgfuCfPAv8pzhFbktM6kdqCA6jifQ1mGeiZK2ygx3+k5TZijF0PjribZIrfXu2bXs7Zwx8OajiGfY0TjyFrGw3+RceNWB7BC41yfUfYqaZnijsN/STqV4g4YCLpjs+bHI7H6Mr6hN3CiC4KqDTCb2nQIA7yaciDWEIo0AEKLTmoeAzoBoyCnYSVCNz25bGqs/drFeIob4l9ngPP8tNnc9mvar7M1ixxinWzzkBtfz36RHCukyuMSAQakRfElbmY//zd2UxAN7KgLbkiOLeihgLDIPiuSsFbLsgVqGYIfyBRh1kY1taIy1JHTvrVpRO937RnhWz0XvBFsGYSJN3WuBYmRNSFqwCcp1bNPMKID1duh7pFr7EA5Z72vcDED/Szsgq3fovy49NqK7aNa0KV88uR90/6dcSBBeNQ/sQ3yK2fxIlGBqiTHTpiTZPDTZYYeR3zt9qM9Szay6kdzczpyzFa3zJ+zgKANtdzzTXzyxkXm8qvUdJs5NEbpWfHWPUI6mng58+vIO7Fru09iuRHbFmH6RFTY/TikOVrnQw8BFrgq4eETYcy2RZ8O33mTF+9sA8ALsVccwLnLDAfGpQVyMR/3A3i7AVjHLceaxJs4jilkORJc4S5YeEbAhScsuTqu3IVYafWcWKKwRQjaWfCg4eNRaN2Usz0co/0YRZQumpC0HXeY0fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk/EBKeVd/9KVRK6DXuSfAtTia99NVbYClUFROvwbz64TSv0ReeV8TstnBsF?=
 =?us-ascii?Q?9JNM3X4U1N3qhP+ARnIPfxtQJaSXtBt8YLdMxt86GkDu5wlHgGp3LdgljvN2?=
 =?us-ascii?Q?Y9h/L6eiSdN1loHg6pk1DaWQg8oJAQ/BTm6sdIM6m8vudRQzejtmJxwKQsiW?=
 =?us-ascii?Q?SoWQY+awBtv66EuNizk421CrtRNYZjZpcnj2GV6z9oHo84l7mhLBOe4qXVPW?=
 =?us-ascii?Q?2t1HlnnXndwKuSn1thQdmbBBq5nSGdxoxATDkodDksWhHkz1VXONgoExhGQT?=
 =?us-ascii?Q?kdhRhQK7CYmfQrvnv1JkI0JLtRaJCxs3Eqw/NM24uyOuJb//X/NasJszWPZU?=
 =?us-ascii?Q?omURb3Fsr641ivIDb2TeR6TQaKKZu7royj/TL719E9MHHpZsKyKY4VUzj8Lj?=
 =?us-ascii?Q?klJNpq2LokMHWP7ld7ars2UGPRbivvgEF00LuSSIvahOOuGJQHKwiUW3YZg9?=
 =?us-ascii?Q?1i+5owO16+YB5PA/qRS171dn+DyQkpePp+nNb3dFJUbPT06rkdukUApMobMc?=
 =?us-ascii?Q?MBsl47m7Zgj8S3XVs1auwrNvzrOzNZ3rmKHGXFX10aS92TTzATEpidFIzCOW?=
 =?us-ascii?Q?J8696gCdbVYuXFAjsrbTeVxutz8zSPBPV+QXCml5+z3bNvmqpLCPlEUPLhs9?=
 =?us-ascii?Q?Ba7QBnMVnomUv2SL1nGis3uMDjYPs7+bVkl0Q88JmHoGZboD4ze5ClsMSLo4?=
 =?us-ascii?Q?jVlJCx06On0hy7TmS0qj+tntPquzEutEXhj+jI480Ro4BOaucssrQCbSbyRx?=
 =?us-ascii?Q?QuBF2y1zh3eJwN+BgONp8BNcQNlOIzwCCFNWJ+yKQfuLuYYkMb5o5ip98NRW?=
 =?us-ascii?Q?FZT2EIJdq9V8cCurM0/ctBlvpCKhepcMLvRvguE3YRoyVBVAASqKrbCh3ToJ?=
 =?us-ascii?Q?1C4aA8q9dP34cJpz6PgklE1E9lpMuIX1DhHJKHTd7BWD3IKuLAbeEG4HSxjo?=
 =?us-ascii?Q?Klnj+qAt3Jvc+qSXEDxKCIltIOfhN2pw4n4AmLWXcLsZ3zkhP0jyLRMCZHrs?=
 =?us-ascii?Q?q7AXXMTLe1KU23XlbXSBLshgap90ZAHoFQC1PMFm8XfUOnBKUIiIGS5x4upP?=
 =?us-ascii?Q?AeMoTAdldmPLKA2pf6KO8uPqjms/l0YaMAmCyj5VOgxdQd4o29E6615UOC5Z?=
 =?us-ascii?Q?HoLB1fa8LbKc48rtLeuaMSkvKPQ+ZdUcg1tv2O+Wt8J4GcfApgy0c0DCxnFu?=
 =?us-ascii?Q?4C+MZSDj4MfBqq9keLV1LLkASeAIO7fIzYkyLaTTgKZyZrOVZxVVfot7zrKB?=
 =?us-ascii?Q?oWXT36U505WxxZxpezW06RBfEGhHA71bn18bJeGBWwqgZHjnAukJLRxQLT7Y?=
 =?us-ascii?Q?DeCx2XP0un3AhQvoJMXkxbCF6VK9GyrrLBmNl6UwwpuU5695fnrRTSXFKWlj?=
 =?us-ascii?Q?t0DEpMWFvYD8ogAkfJOth7gUfJ9SH1o41fuxd1HFwp7uwyF0JMXsIteMdVov?=
 =?us-ascii?Q?Ywkcadg3hmJIgLKNjoOa/lYZtlPSJTXs/6JFh92aYgY4zrGTE/cnhv57Yft2?=
 =?us-ascii?Q?U2/4CND+xXKwMfivcZIeceVO8BYMCNREdge+Y4B30W942kUMR0pbW+Y351he?=
 =?us-ascii?Q?hbwWcXBwSjF87BsSs41/9xD5QpfkXVYuenkFT5fQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6de4575-1072-49ff-a0a7-08da6c8f96ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:41:59.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANC6i/dfhFq/0qqxI0eeV836QBoE4EyApzi+2Gs9nPxVu7ZNFuPX9tKFHgyvUXsmE+wdvpp66geIr7RE8I1wAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: 03b4154183a2 ("dt-bindings: pinctrl: Convert i.MX8MM to json-schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
index 6717f163390b..b72d257cfd9b 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
@@ -52,6 +52,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

