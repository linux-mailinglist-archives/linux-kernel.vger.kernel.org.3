Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152E54C954
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349461AbiFOM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352069AbiFOM6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:58:38 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130045.outbound.protection.outlook.com [40.107.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6142A3C;
        Wed, 15 Jun 2022 05:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je5PvaIrqo2ELARlSbWXGA9wGHylW6laQ1FOgaxTuOB5/LotSU7/D5Om4LhAke8GlKqx2nYfxkV8KCdYO8c1pl3G3v4aJyvZ0zFpiEls9ybjV2Z1AeKURCbAtpq3AbwG+PKT0Qi11lR8fl6xq72unMrXP0aBFoNdd1kqPmhK9I3P9jun8lP/gbn+3OgIHXufgA1W9yMH6R8aE0DYHPXzT2Pj5AmcgbBSi8BKxjne46eovvbH2n18nxmMN4NVJ5pdptMgp7MfMTCc8Hg+Ze+XAQOtzCA73LMX8Y3x0mjFxsYB2PQ1rbGqSFDjSys/Jaw70EGY69rxx5REldASUYZlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2258pDEOBc1J1Pfbty7dNPY3PvfuuY3Nz4aaDuJLFtU=;
 b=mQ4x7s3Uv/gbWzuzzSspjrs0Bg4puFJXUysBIexYhMIGy1pWTHFz2R+Js49rLMZKyzakliCoJVMec0MDioKZ3YfAFCPhElitha/Z1BNqBeWoSHlIjEXDj1Bj5PgvLsJEK7u0PrRaILDiAhmiRN5B8bf/NCF1Gq0LmdmDJK3Z0KspB2esbEjDe376kN40iJpA/jlJBnOPY/EUB1eCAXlQrjO8aMfUNNjRRER1ytE4kpU9Z77EaxkdxK0EmGansoysq7R/NYHKWpD8OZeGyv3tpQSjLscoRQQqLvUvOywAo1MxeNe9BuN7qaiNVbtcPTmk8enf7kFRSCvyXffhVfHnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2258pDEOBc1J1Pfbty7dNPY3PvfuuY3Nz4aaDuJLFtU=;
 b=fNjQSMgZ0F8YOnjzfTUvF5D4Twz+dRL0ffE8zYCrSniW3FXzzW4VMaJMjK8rXy6eT3+oYMZH/y0CzZ8IZZIBK47qbrSUYpXMzQLsQz475zJ+3f3mUfw1dtZC56CbixsigRosN4h1Zlw6BHU90S26f1pJbOP9Fz6vmEPHnPQD3V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 12:58:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 12:58:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/2] dt-bindings: mailbox: imx-mu: add RST channel
Date:   Wed, 15 Jun 2022 21:00:08 +0800
Message-Id: <20220615130009.1457986-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
References: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04567955-096c-459b-fe12-08da4ecec1b8
X-MS-TrafficTypeDiagnostic: DB8PR04MB7004:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7004A9B1BB9655D2D68CE1B3C9AD9@DB8PR04MB7004.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJU6YpZuZn9DsDOawKWbrgQS3XG9xHade+eftbMbVyruH2xWiychZ7r2i3TGug7DLXCPUR4oD7CunuaHubuS7bGomFbWmCNXNn+6ttcgjaIBRHQ5gu+9X+BW4neoXxEy1IsKUrai8kdiQxjpBqhQrWwV5O/kXtIjrQCRnkb8GQcdPRmsN+yMh8+84jaYtrzFNN5/1a0oA0E1bSmu8rYxsF4/xBYEjSQjAHndedZFFCSvkRMXxvDqXFiQ/kRM+tlYm6uDM7soBO5fWAd0ZhAiUUu7rAJ1GYXGSaAP6huRCQzTmlhf6a79RipXocaITJLLOwRpQAUh57tKhY4ehtE7RHSFN1G0wcOltEGftuy1VUbpz+nyAergU2/9gj6Psik5HmUfLyp+MFviAwS5R8/IXxNynjVWM8oBx+1QfzMzkoUt6CNPXstifDkRz1cEiSBp8MCBbhqe7CMCqSt09UM8TucmT/PMScKyFFY4szZWBWxczzPtOASDDmtstm7pmIUMW2ERSIAEW/FmVTpQci17f9HkiRgI8Ata+4/RWvUTn42Ahkrx505ibLD9fS/m8gd41P7xlHf0cabqbFaIkngKSUsPOxIb4DV+Z5nAeqfAUL2IdMc1OlaDQaGFtyVxZrNk+bKe/vNXmv8g8ki5SsyO5AQwlOWBP3WoGbjFMLJ+x7SksJiutSuaMYOsYxFmRV0lzkx6InvPFOYBDyh6WXm7AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(15650500001)(2906002)(186003)(83380400001)(316002)(508600001)(6666004)(6486002)(54906003)(1076003)(2616005)(66946007)(8676002)(66476007)(6506007)(4326008)(52116002)(6512007)(26005)(5660300002)(86362001)(66556008)(38100700002)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tO1wnK9hc83G3vmwdshIVhjSjhclL81ajz8kfQcZM0wLjKdmGeGuX0ZJ3YaT?=
 =?us-ascii?Q?ie/QwRhX/jW6vcC6CBGx+MHKoBZhpDyOverayTEg7s7iOkDtocMvuRVY8eow?=
 =?us-ascii?Q?aSErgZ9d6zU6BqJmSz9O9TFJpP8Ov/VnSTNUSX7ZEEsEfravQfnuNgLoWYIg?=
 =?us-ascii?Q?NHCUp/fkatCMGRVH+FvB4P1ePirpGR1PS2zxeLXj53zQXfYlIYSVkfMuKEjo?=
 =?us-ascii?Q?PpW+i6yeHMCwsQhhPeTPQ3WUPLzGMjfuhJVq8ihvqIqRe905JPcYkLdyRO7u?=
 =?us-ascii?Q?22u13/6K6GPPy+BltcFzEIIzGYgPvzH4NwP+DQTaLZkTNEYSZqy3caFO3Dzb?=
 =?us-ascii?Q?T4a9CKZP3qRO/WPkEJcW6Mmp2qD5gLgu9E4GJiptsvhhTdnhXHXKYqKz5Fd1?=
 =?us-ascii?Q?YNvURJlkjunahNyWvkL5z5dIrDoUYuSJPp/RKzHkwapOhaheb3j9NQTbglJl?=
 =?us-ascii?Q?lqIME+wlFL+j+AsXG4w3/wpggFMg0tfO9X9ZhEDIprWuJQr5z0tTHfCiNPl8?=
 =?us-ascii?Q?33pBJnCY5IRj5Xnm4AaiSBv5JIjwBdVhRUz3ViWq4wpFEHA955iq/AY7s2FK?=
 =?us-ascii?Q?XrornH0DxFKZjzGkCjQd7LjVaPQHStM19avmLCggQlQAHI4jy6Q0eBRbLvPk?=
 =?us-ascii?Q?mPNa88o6HgBbJhG/Amt2ta19SCSXPhH+dThiQ3+qJLdL641kkM2879iTNtXW?=
 =?us-ascii?Q?ad3CngVXxTXNx81iO291gy3vUpQBRr5hAW8TDWDZI+8ph61gnye2TGPMbSHU?=
 =?us-ascii?Q?Fs5DIVmddaDNC3NZnHIMNm/HGatb0rSjKQ4Ab1mgWcECCKi55F5JdnJDtbKi?=
 =?us-ascii?Q?VJIzmdDNpF7t7Jl+se7TOVnVWnD+ozPznmr0ZgDnvk0GeSZ0NFbltIoK7+o4?=
 =?us-ascii?Q?LSDtg/UfUMuhw6VwgJiAT6RWzPSi2Xi8fAWVzi3yJ2tvvkAVfZ59poJLFvAL?=
 =?us-ascii?Q?/v7v5TViCjkOREy2SRRT7sORsLNFjhb2gTrohR79FzoA2s5f24eIUNzEomd+?=
 =?us-ascii?Q?hw6feBy/PYH29ceUE3aKg2QP0892boNyJcZEzkw28UY79W6wx/A/G+mKFiaX?=
 =?us-ascii?Q?kUQR25qNLXrGaGCa2z4KuFxPJlJfKLzhJ6rULPOUUmrVjYYGkHK1MdF2UgAq?=
 =?us-ascii?Q?ceQZdy20cOWYYUOK42aNxN7+RtAVMuIiurMqMiHu/yUyzCUS3OeHvvWOLppN?=
 =?us-ascii?Q?Q5jb1FK8XN/WiFfKxGFp9HQKSRmHVO2j9eWSHjNlV9oePLj2ZsUxFYOKYYbj?=
 =?us-ascii?Q?sHA90o6jBm+CsjVox6C+SwjaK8GfKavL5xYFebNn0nkcKRXF2ycy1L4TNSZW?=
 =?us-ascii?Q?/o8BtW0t1OekbI81nJ3sAb99VYQG69VD/BmVFptFUtky8gq6C4AU2B+BmE48?=
 =?us-ascii?Q?icNMf4TSHiHipDUnLribWRCI0s6cgXEAg2bV21Q04UztMleEXTNCBaiG2fyZ?=
 =?us-ascii?Q?gQMwwQST7CsT8G/RR/UJ/9+YnReKdu3F4yp+Jmzya6ZJ6n2F5QdFl+NvIKDJ?=
 =?us-ascii?Q?Zb4GOZm6wrHDQkVG66Y3o9jh6HsZlviH73wDKDP1DpfwwZFXtlBYEgFl+rGI?=
 =?us-ascii?Q?gecx21LJW9LkHFGYJub06lj7KtNspJqSSh7q+OZQaR4cAywNx9lbIzKNmj4x?=
 =?us-ascii?Q?BR3L+Ui4vHc9Txuy/6VPcvPr8KODG2euUvNKVUfF5xXsxLDTgIVGxOa6tBw3?=
 =?us-ascii?Q?3lFvEd5/pGd8UjrD+V0mxhCLfD67yE7097gqorABfWqZHUN453rTl6dA9xc/?=
 =?us-ascii?Q?2W1iPeUVTQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04567955-096c-459b-fe12-08da4ecec1b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 12:58:34.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBQJuaD5fUYa3KyP94VT4GL/E+/YoTEo/vu6rSHATLICWoab6qFmI3bTVKltFo2cuB256rI7IEzY5UpoOhkGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX MU has a MUR bit which is to reset both the Processor B and the
Processor A sides of the MU module, forcing all control and status
registers to return to their default values (except the BHR bit in the ACR
register and BHRM bit in BCR register), and all internal states to be
cleared.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 7a86e7926dd2..191c1ce15009 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -72,14 +72,16 @@ properties:
       type      : Channel type
       channel   : Channel number
 
-      This MU support 4 type of unidirectional channels, each type
-      has 4 channels. A total of 16 channels. Following types are
+      This MU support 5 type of unidirectional channels, each type
+      has 4 channels except RST channel which only has 1 channel.
+      A total of 17 channels.  Following types are
       supported:
       0 - TX channel with 32bit transmit register and IRQ transmit
           acknowledgment support.
       1 - RX channel with 32bit receive register and IRQ support
       2 - TX doorbell channel. Without own register and no ACK support.
       3 - RX doorbell channel.
+      4 - RST channel
     const: 2
 
   clocks:
-- 
2.25.1

