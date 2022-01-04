Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388FA483BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiADG1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:07 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:59213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231815AbiADG1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:27:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKr2xnqq9bB4SX3tyKlMzXQrvwISrb7YgV8hdc0D9AgJ6LmH9ffWRQQEdspKiVUzL+UteVg6yUaBEGFMaoEcnyWUuVRNXG/eCHeaC5Et2bSQwy9H4ZVtnvhWtZqMJ44repZ9EdN3axiE+YLPQjAX1NUzC/GGiKlJmonP7GSCU9OVns/THdIzOzyYkdrOVYmRQ/jbU0MQOSuageNihKOqIQJ8FYLjh6uTl+5hFjB1Y4+ngIMOL0BoiKt0Si+kYOoMi+0Kq0biovQ57wVjAUmn7ehVxCap1sIyrSiu8YDFMPiMsdoiZ5OesK0PbgwP7rKwqFI1UAK53/OxyDolty1Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V7EP+v6Fu82aOSBAKZmi2HGRZMyye7PSL3xplF7qYU=;
 b=b01IxMDZ2VnBIXrAAJiog3o7OrjzggGEdCspFLk95miRd4ADCYmGI9qvdyAjswjI2tiXcGSqoYSd3e/ixw0MKfiozzd074l5yK1PKasn7/R/7fqTVrVdIKY+11/5q9RDvZ9tE4nejNlQnTTwS5xFSVb09zlvc5YQoEWSWb3IwX3kajor/EM1iHRichUxnxbmo46IALsuXqYbAmyLVcpEniYzC35x8GIgIuvQs2rXBGLcaIl/WyRJ/FfMp9RtsKzh7M3mI9Lb2PbyfWLg9Gi/cVo+IOUQs2H9txgpLTJlRAJfX/J4L0fJb44WYDVQ2rEA+lUG/EXXRKxGeTGWSZU7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V7EP+v6Fu82aOSBAKZmi2HGRZMyye7PSL3xplF7qYU=;
 b=DntKj4xroILaYQj2FPufz4CecvVzDBYaFe2dYN/1NVAIJT/SlrZuRlBIB1bHe2H4NO485srU8IZ6mGOWtXj6F5sLfyPey3azVbBwXyYHd+ON+b1xFFtxlKJrFmUicYWwGiSlkv92z5A9PjOU9kbGgOuJdjbSfoYVu/9ccyjSpAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:27:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:27:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/7] dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
Date:   Tue,  4 Jan 2022 14:25:45 +0800
Message-Id: <20220104062547.2103016-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9fb5d3-435e-4348-276d-08d9cf4b3844
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB929868E9AE8C70654E34C3CFC94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q3x7A0tq+6wyGeoEiSVrtz3d/a9YL3/ZWhqjUNXPjGbHC9aSIhJmSQRzGYvS0uW4whuHMweiRKQOuglUDp7aRDfmeQg6BT39gpwgDd6VfIHKEnQAYMZHwV6WZAv0ECbPsYbfcJilvGaS8ciX9l2yMHTBliAx6Pmh7K/vXagA5jBlMZ4kgENZGuaSedYyX5K0d5K76zRdHZ5rj1197azg/gLmsdiDDIGyV9tLfD3BeDiCENPhj9EsRcHKX0587YvIpS7/eNCO7j8x9nKl36rTU9iHNL8wuAVYk7zOC4brToR333DiYttoaRLNNxRQnI7dXpfVD4Ec4OfB1REc/h7UDgRdIGlCPegpJpSyQi5Ot6CRNsdkFsTHxppwoLxkj4x/u5TiRkubV2bRnRs65eVNDssQgeFZzovq3e8ioWHd7H35WdXWtkS2hK8kY03llBQxfeqffnwkKb1ke87yw+LWNWQjOJH85f/OiOnaTzNVxDR+C0xrPMYEGtFbi6QOiUr+hm6HVVKdgtAi07xXjhv7mDcIQ6hOaGPcAFc7OyFaVsUVJeZs8HzpPxHK6wH2RTTR8y5ZzYu4rrVfsdPJEvUzK8NVIxzypXpJzetWfNNXW/WUxUx5fHmNKZQyswtCyufz5t3cqToohyojWcAEsdfCc2XGWOV8EWRiRkFouXsyu8b6c3ZH1XiQc/x/GISdAe+8WYM70+cpS+ZxS2Z1zRhqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(4744005)(2906002)(52116002)(316002)(2616005)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfLTVPB6fzto1vbomw50AusOs7iYGyNvumr3bXdqgjFqP5cUF9OZauWMfjiL?=
 =?us-ascii?Q?oB1sDNodaF1IBPWjkZ322SUWPEPstU6oCU1e3/ANVyNl0nB+LNH7Imq5ibks?=
 =?us-ascii?Q?xaopPwwXZtirYcKEQ1OwV4Pn4SbKj99xqgjRA0iI63cta1r5mcLBBcAoW+zm?=
 =?us-ascii?Q?eUdpXDuMNC+kfDL1HqDVi6JaYudRUYCLR/Rzrl0n+tHqVEEqTsl/1Mq1BZ+r?=
 =?us-ascii?Q?lylRQHS4Tfnx5fLNADtsMFPka4W2Cois/idwLbvcs29S7CLZy/MLtxuhGusK?=
 =?us-ascii?Q?QGdR+pIndSjlzuH6TvzKfd/H6+X1texm5aN/7+AcN2fdmRs4V7+PG0WftCga?=
 =?us-ascii?Q?5y9VTsv/vg/Onbv/+HX9DVfulw0ymLic+YtF3GWrkehhWGdn+KeNqWxVoobt?=
 =?us-ascii?Q?ZaHrhEG8h68lS7OCUFDnl2igkUbIdMuOzAOyjJhq1uhFNaRGih7VEFrlX/ei?=
 =?us-ascii?Q?DtbAHVWfID/ZAcaMVC9GR5r7hOfIGUhhUFOEsQAEyqJRR71vsi1cdqx4X97X?=
 =?us-ascii?Q?i00eP22zL5o1c8TD+o9oVOLzz/ihu/Wr/jQGa9uU9pMp1O0R3Tl/YfO1mopK?=
 =?us-ascii?Q?UuNDAOZ7Xn+01vQNZjvcvGud+Fja/kSme4z26SeywVWKj/yXRBNmEfcSh8sS?=
 =?us-ascii?Q?vxQs2AeQ54r7CJufseoVhlsOwWGZgfeQUFAiahBzlIPMs8vZPLcbPgTciOm0?=
 =?us-ascii?Q?aIvXOLbe2ScOeY+StLsETSKC64klEwkHceoDVUs1142aWueNJL1fkRoM15DX?=
 =?us-ascii?Q?CpTzNYCI3F779WnwGFc3PguR+B4PaUfizhix8QRe69r9HNT/EN3IW0nXFU6q?=
 =?us-ascii?Q?Lka6g3j2FcA2NI6SlLdm1RCP628LXQ0LPi7HtZqU+Eok7vQIbO1NUFexWwnR?=
 =?us-ascii?Q?vH4hQUhFY8wCNr6nHhWtQz0XKOlbE+2RiUznaXg/YLDY3qWrKrttGgzNNmKb?=
 =?us-ascii?Q?1SMui21OaQamhdY97UxA4G2KR98gm0d8c9pz79jIiwLyr1qYaoBdoCmzmIzS?=
 =?us-ascii?Q?wWBoKBYRjpDPi5+SgxJXmqao5oaGDJZBEKJsf/7QV9HyPm1hd6aHzU/N4TCs?=
 =?us-ascii?Q?OEdV5qyRPjg29VngWC6B0GAznU2g2R2287ch1b/ifEppLXtl0Y8U29RHrHs4?=
 =?us-ascii?Q?hEP+P/J81to/6uahQzkwnygyIiF4jxSyu2QmJHWXpeiO4yJq1bZqAH7QqxY8?=
 =?us-ascii?Q?fUKdKoSDbOWIrpzzbsuG9HmD6NYb6vERUW8m3XP3nwJrtVWFRw8skVS3EF2i?=
 =?us-ascii?Q?Y1SR6dXdrixiPfK7XNyOtwIIv6tk+mhFOA/2p3Hl7wTTTWZSC3ANV40wqS6y?=
 =?us-ascii?Q?3h8X84ur5A/4JRXTugwaVLkibGujCWFvhVO8QCeI5UNHa2Pux1+Abqiosdcu?=
 =?us-ascii?Q?gqehdnMaeqqGb1N1+aos8jXTeUmK0X5rHtO1hMdtS4NsO9PZ+lJkYF+E2Pto?=
 =?us-ascii?Q?KEIni9/EdX/TmEMtu40nNAr+A8nid8t9wQ6e3K0xFlsW0oSiovDEcKHeeHFl?=
 =?us-ascii?Q?KrbIp5EFOfQwMfQBubV44o5ZCyzzRUYK/SY97sqLXyvPgbspvkxbiwwP/ex6?=
 =?us-ascii?Q?y3i6l8W7jKxlEuqPjAiX09QwM20xRvS3ZQNrDjtT6UAImU4su5tiJ4t2MPBk?=
 =?us-ascii?Q?BTlm/lLK8xZEHqqjgDjgybw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9fb5d3-435e-4348-276d-08d9cf4b3844
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:27:02.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOHIeR2mwrA4O4SQMv4dz4Aek1T/7GO93x2W7iptqxYXD5oJEPG8020i/088ZwhPGhgjIwyW5kT6RVz5e5aSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8QM/QXP SCU, i.MX8 SECO MU is dedicated for
communication between SECO and Cortex-A cores from hardware design,
it could not be reused for other purpose. To use SECO MU more
effectivly, add "fsl,imx8-mu-seco" compatile to support fast IPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index a337bcd80c4a..f865b806ae6a 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -28,6 +28,7 @@ properties:
       - const: fsl,imx7ulp-mu
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
+      - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
       - items:
           - enum:
-- 
2.25.1

