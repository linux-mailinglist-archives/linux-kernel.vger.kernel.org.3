Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A14AD18B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbiBHGcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiBHGcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:32:03 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD65C0401F6;
        Mon,  7 Feb 2022 22:31:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLR8m2DzfE3d+I/1eiIGfFGbGll6lraJ4Wc7SmZdApNARADNoj4tEYxh738kDbXZGOrEzsgGxPLz7J1KCYx+BgFvj8qQEPqstQbGY0OosC/sqS/T4MTWMGZ0Vi2YnN6VtF35Vq51t5tAkKnVPmM5MQ4JaPVvslv1yVZZHAg3hpmSaqaRhP0U3wYDtwVG0eDZCC52hnVGVaTcLfuSJ5XvfI9/yBTNKYy7+eRoyujhsj6A22+L5FFfnKycbn3ilBnZ/jPObF/s9wLb/oE3z8qYf2lZvV55lalmJtD51zmhX9fA/xYlX4/91so+HMTYDbF9HuEqjBfWYkoSy4M45Rh0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehSQ8WTYbA18ZsxnCAcv+txkqt5hOqI+QtXMrtWb50Q=;
 b=IDO8Ept8Z2VuMmJebK8aiTYVlEcrogtyVErWGhTrE/Ut8UdFDxKE/nfZgPf2yOHT7aNAtsT9R8C/EOAjt0MANVN4Sh/GrJ0haZTeslOkuPegie3/rLHcmjPLEqFyvr6yGpSXrrB5/d2R1D0wWQj3z5cupM4jpss/iJluMcI/dxq8WbTj4tD2vmnaC17T06TWqpVuGt1Dxb8FCYoWppKA78ubMgQlZwXk1wVBaarNVf+VCR0g2PXZgBJDYLowr2cgIJFfXmUrHiW6lgHfvY9qnJ1rqygB+VHIlDJC4G2vblCB24FWLDjNN6hy/zxk+ZK6aJJaxDJReZ4wCtQzxZJbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehSQ8WTYbA18ZsxnCAcv+txkqt5hOqI+QtXMrtWb50Q=;
 b=bhlCTGPr66vRn2AKXIY+DD1HBw9T+pZOHimox+7CFBTlQ3cm2EiYVURs/FO3etuK9B6zrpzAIq/Vs0NIqold0aio3T/KMMKuwJV06U/qLAY91pTiQfdcVFLNNQm4ILVzgueis0I33YOZwhVEPLwHpeQE3h55qlyn160+yZdzfzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 06:31:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:31:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Tue,  8 Feb 2022 14:30:44 +0800
Message-Id: <20220208063046.2265537-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c8a454-30ea-4076-63ee-08d9eaccb20c
X-MS-TrafficTypeDiagnostic: DB9PR04MB8156:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8156FF3BEDB8DB5C6B10D54AC92D9@DB9PR04MB8156.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOH8ka0SwofRdE/6TooDIfIkU0wrTl8w3SqhtX8dw+K3HYRq6D72pGPeCzCj+UNyndlUu+sn0CLQRGiZZDbXEPGr4xUH9FsLa6iHg59mMBm5ZTeXuN0S5aLGyyb07CqzTJt7ej+GirIIOSSJk/C1t/Hl8Gm7S9mfRfoMDrkSYFz0NIFyef5WmvQexvvdxwrEASCJ8xwrLs+z8cCahA7Dfr2P9LgZxR2m85+Lm4KJANoxMigsTCWgVewUxYHwnt6VuqfMG2/VR4/WC+iV7RiC2uMJhfr76hdNTxVjxAw/5aWebK7t6uFOSHMbZvOrBBdMvqC6S36Ll/KN73p/RYyI8HxhN5hRTpBTj55nrE8ZZFsF7OrLrJoaRJZQMoTaPnvJIFLLOdhH7cNQ9AFbWgMNsXuCN+idS3acYW+j4XebxRWVsPlovmzThHSWp4FhCJqcGXL5RA4DnM2I2jNrsRWLTk6bpXioO85vZg8fT71KGCdFb15EFQXlUdUhQRT8f6tihgjPt7RHUpka+1+aaKpcHXB8UkQmRWCzoaammb/SJycAZgK3fxPAHVSG0qv5Rn2QBlVHhJqqxzio08gLZwww/T4OoMOrHNWEsUEfP4Gstc3NbBZaYFNGUp10LMEgEqNFXqHM3ObAOLxbCWGffp9brNaYc96HRo4xyAecPEPudF/K3C/3f/a+CY5ejE+kzV4lqYfEomXAdC0B4HQVQ/QoSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(83380400001)(15650500001)(1076003)(5660300002)(6506007)(2616005)(52116002)(4326008)(6512007)(8936002)(2906002)(186003)(8676002)(26005)(7416002)(6486002)(66556008)(66946007)(508600001)(38350700002)(38100700002)(316002)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9gONfjimv8Y+K+OXVRJok9mLICrsbkVu0TF0xa4YwaToTbkfcGvi+fvRH4B?=
 =?us-ascii?Q?TegAtYIRg3Hc6M+QktTJPPlDOr6mmwX3JsWuFCFRtQtnEXkX24x1NgzdcLEw?=
 =?us-ascii?Q?pjs8HhyjPMa5KijEAkf7/pbWxSEANgyHAka7cW0oZcg540EQ/eeParvYs9pw?=
 =?us-ascii?Q?hhkNt+Llp8TnFwfFtXC3rwQjDqbvwcgetvUgRSPy81SJp97QUMBAKhSakqrK?=
 =?us-ascii?Q?1nVCTiRegO+0oBxOn0DHTgDlm8Cn86UzVpaJwAPRdA2mTCRlQ63nhtItA6CE?=
 =?us-ascii?Q?llU+FAwX6wwERd3l54V1qihviW09/PnuuOSs1Q4CpjO7FVkyD7jzOBYqJL2C?=
 =?us-ascii?Q?ftqax3fKKa6aJkWoObhZHC3bMfT7Xnb77BdQzUFstoWFOS0e/gcgkZla3W+Z?=
 =?us-ascii?Q?8QwXiltAXtGnV+ciHRjxlMcVjuU9cKEg8ww8l3ezLIdBQFHySgdkTieHb3Q3?=
 =?us-ascii?Q?5ZVm3TSqNxVJNGP4lx8jdXLdKLrKHOWW3+SRhImZWOF/w6sRCflKiZjNdj/Y?=
 =?us-ascii?Q?M7jd/aoXmgDadOK+SDPxJfmoptsexqI/K9mpCCa14SBtegmE8GIGjpHth5U7?=
 =?us-ascii?Q?cCZLAJYHGNuRvCJ99RqGWA37kDhvWWeT2CyyCvnoeyDjRwgw4bHYeN7rLMw1?=
 =?us-ascii?Q?tATn3gvw/JdwEE9zwcb+JNrgpk6HOdTKP/jZO94HklnfoRkEVEq54bq2t2HT?=
 =?us-ascii?Q?qWiRn9hBGo7UzsXfFuHHpHrNTdakdSm7eiouDLlWr52/V0E6cj06Q7tQxEoY?=
 =?us-ascii?Q?XkFvln2uUOjxngGgjE3WfSNNgV2G5ewt6Qlu5xfhs0yvt8CgXtI0LjrNi1yy?=
 =?us-ascii?Q?COi7kS1jrohTorZBAsxzBY0c+qyZBXWj0JHnfQ/y5hLBbxf0lxbdez27uQ4K?=
 =?us-ascii?Q?JqtaOxpxH6I0HDD8dUBBCCDUtMpiqY5DnJgFTCOsyK/zAMRWDVXokwwHZ++M?=
 =?us-ascii?Q?5q8HhcBv4ykSIjAii1CQC1w53UMiEY26JKwSJsd6rObsru7wG+t/amaz8Ryr?=
 =?us-ascii?Q?7BM24izcjJqXCMgV+pMXvgodIHP/t3aivz3jPAgLeOdN72s1a293WohlH0f/?=
 =?us-ascii?Q?zqO5nzmIbQA/cEC6ms981rwlk/ztc65oJD1diM8M1i1Y0FGuyQmWzDMxeiWw?=
 =?us-ascii?Q?UkJrLUiav+CBY6/a0GqBG3dMcScQMHeDuCaVK+aL0+XpOiNudQDL7WzZ2iz8?=
 =?us-ascii?Q?jV9ov7IGBe+FCUZ0GwFninNQVenTqxXx2fh+EBQn2U+B0YmaItAYKfgOowRR?=
 =?us-ascii?Q?gQ7xLh+6MgroknZG7kwxggfq5KifVUOXM6geYBhl21zSgimMUAj548fHP+X6?=
 =?us-ascii?Q?SkKvydf4hdljMBNDy9gIAgIhQu1nbH8HidBNEHGhwtmMngVRZWr5E796ekyH?=
 =?us-ascii?Q?L5tx5HCnmm2F8ytSTdAjQQo0/rfuONCDF99JAkh3S28yd4/kt3KU1/41Jbt1?=
 =?us-ascii?Q?70Sz3gf7b+GWIpfz9v7w6/Z8Hj3XnbPO3MCJJmvG6pIYy6IWIQFs2PQlsNtj?=
 =?us-ascii?Q?+6xkzJ8HsQD0Y8YsgQSlqhXqBETZLtiTPYyDNn2BfgZTpQc5K89jqxlpYQ7r?=
 =?us-ascii?Q?VQObOVGVw8WK2zcoiDldFjndhjAt8IEHof1mKUYt3suu4FC42C4FyJdQ0mR8?=
 =?us-ascii?Q?IbdKbRKiWWf13iggOqLKlZ0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8a454-30ea-4076-63ee-08d9eaccb20c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:31:53.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1QSNbm8lWzOkUBtaXMC8NsO/04R/EwXESTub6W+8RNoFZOFq99iDZEAqlmympuieQ1wire8jYxnAsdcpfeWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
between Sentinel and Cortex-A cores from hardware design, it could not be
reused for other purpose.

However i.MX93 S4 MU use separate tx/rx interrupt, so update
interrupts and add interrupt-names property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..f0a7e693ebf8 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,6 +29,7 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
+      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
       - items:
           - const: fsl,imx93-mu
@@ -57,6 +58,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: txirq
+      - const: rxirq
+
   "#mbox-cells":
     description: |
       <&phandle type channel>
@@ -90,6 +97,20 @@ required:
   - interrupts
   - "#mbox-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx93-mu-s4
+    then:
+      properties:
+        interrupt-names:
+          minItems: 2
+          maxItems: 2
+        interrupts:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

