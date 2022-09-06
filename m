Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4945AEF41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIFPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiIFPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:46:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED7A6C36;
        Tue,  6 Sep 2022 07:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq8vewKkgtdvGzYH/D6xd+ke4eVteGvrKwqzVEhw060suYDWAy5MKaLlWBUIyecE4+PZcN/MEYPyLxJSMIx9BF0BM7KOaGhs0mwus5g7suw1Mvqm4Ffm4qFRD3crvkxOVzLlGnFL+MXVnw4Cx+BuYtsWERCh6Sb1pByDQZrzDcYv1gmGBWZ1vBXkrDcimVEPExzwoVPmOYd7uTP4cuZ2fu2EvTRQCqv23Ua5NHvYX6rCLCNqhB4CZEJrWrkPlui7N2dXrQVqlR+wBZxb2VSu42h8dPT9cLkImsH8ARDWAZRXpNxf1+CVRVmdTmZxWfbpTJ53UvWmoflC2mSNVn5zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=EIxHVw+kPro5Tcbh4p+Ij+PEre8QGVa2cEbDqEbT4NBAJK72/8RX6g5xaTYrqf7mleJRNLHipFEyfvsnFxLzbwK89o/rTwDM3VsMdW+MNElDqXVewN6Du+w5tcfOhxWJWbCzue2bsxjpFD/fgk8V6Cm6CgaaIuDhwfOSYpIk1GS2ZSsln4Qy49jSjoF19/D737ZdNbyG6CX/rfSrqVXVvETnojYduEzSK79+CQZRCHQwnx47aEcGl8c/lhr4ZCIs5ijhfjbnNShfRx0l/t4CaEASsEPUQ9JdXdW3Cf4hw8tFF9zBeuv7pfTWEXH5mUraFV6uDffXXiHHBXJ9BFhQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=I8QjtoEYWmcB0Ha7BXUu/4UIFSDHYvjbODSJh6Ysekb8ZQ23rDnnHNANpA8ywpQaFnSc+EOe0lH6SUW+Gtto/kLYG9WS1O+cPmM6OzdycmFrkPDzvUEEn2g2nthC1ETJZC1I0gkqoQgmiOU8xdDbyA6/neKob46P5od5pEBSX+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM0PR04MB6098.eurprd04.prod.outlook.com (2603:10a6:208:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 14:56:59 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 14:56:59 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v7 2/5] dt-bindings: arm: imx: update fsl.yaml for imx8dxl
Date:   Tue,  6 Sep 2022 09:55:25 -0500
Message-Id: <20220906145528.40079-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906145528.40079-1-shenwei.wang@nxp.com>
References: <20220906145528.40079-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0c9b9e-c87a-4e8b-2342-08da90180c63
X-MS-TrafficTypeDiagnostic: AM0PR04MB6098:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiapEIRGQGt1JkbIR+lOVr6A4/dJyVBNavfMpBfdWibXZF5J7ZoAgv2xMZY7/abRKCfF03xWetqxteicAbY9RKJHtSW7iJG2lGvw8IGmDKPuSsAbmMsN36pvDwAHBrGGe5WHwyc7DCO9LvUcBVr4dvE7egJUQJvb1KxkqArxEBxY8m+MZU2MfOBUH1wvWGn7UkJvoGxIfRdEEW1qHhzdT5LuVjAxxQjICLbFZPx0N9MmEEGGW6fgMBrhD8KAUl8xfaeKecBEwEc/2CzH/uahA6P87beo0I6G7xBpW/8CgkG4Cgyb1HASRfkIFlccLlNvYCxZGkbLpagNe0KRR/79xMncWCDnjLH9j3vOhqxvcZ640PUz0xzEd82tHAUwfm9iZ6zdliZqHNaJJ8HrDX7voXPaKXDO/fsA+9tJBshTXkfvrbzJkDb8azggH2SZrNPdsOfbYAwLgsJGSXv3gqsVvluaSS2ftkhiVpy5DLe5TdwaLTsjRGUI21p5N9kyvU20Vd9Jylk4BKRNB7rVLJWwIrdyXrRrKJnyq7NMc/xyDyaUCcJChVRwWT67pm7afG7yn55KDv+0G8UwQS+rQaVwg06bm4JYZcRP8M1yPv1qROt0qjijU1DTRCyqjcQ/mvic766xR9oeMNCH5Ji/E05Au3PyeLcpfgc8pmVEzY8AauxTMIzdAWhvrIsef5MFeDa+oo07CogDByz70ejZ7wp1rQUfVXkd43FDmn9Ja7lmI4yjXa6iRHvwwjb7SMLuvBMyRSnQBxcXHXJSVoUjnU5H7yO+7PoP/iNbOM3bH3n53yE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(6486002)(38100700002)(86362001)(6512007)(26005)(6506007)(55236004)(41300700001)(6666004)(478600001)(52116002)(2616005)(38350700002)(66556008)(1076003)(186003)(44832011)(316002)(110136005)(2906002)(66476007)(4326008)(8676002)(36756003)(66946007)(7416002)(54906003)(5660300002)(4744005)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qTc1B9lkYl3XbMtB0YfGAjANtdUMtt9rSu+TsNX9G//c0aNX4eU9XnQ+82s?=
 =?us-ascii?Q?D8r3gazhFk1j/UChxyYlvYgUyMI77zNLULc93zqofkaXoIRVpNy3i2rUoAf6?=
 =?us-ascii?Q?amYuzykoQJZRBvN2ZxUD1zmU3nrmUNH/HN88QrTdrfrfxz2nYHfIjAZwVrxM?=
 =?us-ascii?Q?dD9Mct1iyqFRSjPG1nT5FTSHl2tKIY9h2D1a9yir4ZaEYS/l8amR8prTN2xX?=
 =?us-ascii?Q?DyhK3PN3ycJn+TNLwbXOfrXL+T1nKZUbZ35OAkUaQVlKf0oK+zSkwssYXJ5w?=
 =?us-ascii?Q?tngn/MCFTsgDBPHuZUU04zIAgAujULh2OzWbLtDNPpfXrEb2m5xmKAudAmxd?=
 =?us-ascii?Q?wC7uwzfCdO1ycRzrKFfd6+6gZMay6aNXBArhken0iTr/vnCkWC1Oz/yRqKdk?=
 =?us-ascii?Q?4sqSc6dZ6mmtyrSkTrSl0PaAbcg+TwpFmazJJo+8qvJJeF3kp3OKnJImE1lW?=
 =?us-ascii?Q?1vSd+E8x6rsqyXmlqH4OONf3W7hbiNsH9tgWDWHr4GhLCmHncx82E689rAO6?=
 =?us-ascii?Q?zyY6HKSMH5NF332xOCtr3L0cNLNKk6eNvrGDcS1DhseobxT/syOpCodColci?=
 =?us-ascii?Q?qwfpNmE2lWNsH5dSomuIZtTEU9KDqIzA9lVDjm5XZ9pfcCKk/H5uWo6ofKiw?=
 =?us-ascii?Q?yGMYMf57rvAKCpttWDkPnE8ppQG1nTMsMKxE2J/FpepJOJGcL8rTcY76daE3?=
 =?us-ascii?Q?i/HIFugK/etKPH1zlCRHFJoB00cSZx8CQnnghUs2g2QNAfa8fjjvmKP/6tMK?=
 =?us-ascii?Q?yIDxXN3KpXa/ttqUyeTe/siFvdLw6hQkAIYzlCEOd3UYxvW2QHxYzWNR66hP?=
 =?us-ascii?Q?2wfVDyS3KQxrlOanKyJdrL7m5JOVdJFLcF+isKz7yO/UB+w7qt7JauO3rWSA?=
 =?us-ascii?Q?VbnN61Vh11Y8WJbTRI9jphSMiURKZ5qEJHfsrBR4aj9ga2P7+Tr8Bhuwpg6P?=
 =?us-ascii?Q?6eiMR9KlvrdWpbWvUG75C1at9IBHEadIwnvYvnBZFzTJyUIHHflWeHHGjhrL?=
 =?us-ascii?Q?rO7TQ2Vvu4O9IuN31T4akzVKFZx7lh6t0k3NGUkPRkB545OtWdPHiYPs5HTi?=
 =?us-ascii?Q?dP4cVHXxHpgh8Mz9YOOiOr33+6n+LzcoqkSjMFNvheyTiPEK/w5qK8+X7kX4?=
 =?us-ascii?Q?2VNfbucQChPGFMStyMi2x2gsn+XXJLgbUhazHlNCBiHbhxvJUPn4x9CpnCHZ?=
 =?us-ascii?Q?HQdaBnBZcJ2QR6ZYqDeOboZrgXMsJdqXw37NRoXKNTDx7b543reHFsty0LbC?=
 =?us-ascii?Q?WhjLrDiqXk4kvgn1cXwS7ZcwVwg4p5DCR+r5Mk+YMuRUk3jUoFihgnm2iG0d?=
 =?us-ascii?Q?5G5ql+WBfI5oR6hLxrtlrse9WSrP2JRSNofGd9wxXIzDDoXxgzmKQd6KnbuG?=
 =?us-ascii?Q?INIMWVPxBLEs6P760pk+ZDY9P/aYgikKH2ENJEpKn6SFUejZ4WYH90l3gI7y?=
 =?us-ascii?Q?UzmtR/gs0PX8P38DeVh8cXo1PxXbDThRg6qWyjABbn2lGXYC5S3fV7GVPq5E?=
 =?us-ascii?Q?iiNZZ6YQtvMv5kX/iWQ6ax+Kee4Gg4BfqywtOC5DUAT6IvlK9y0yFsxRyqhs?=
 =?us-ascii?Q?RebDn/LlGU1C0E7EMhY/VMM5FhqSBNjCacSTPtz/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0c9b9e-c87a-4e8b-2342-08da90180c63
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:56:59.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNaP3X9v4nd5hM9eNndEY/1jtJ1OT9nu/DlKFH7NVLoYkEEf1317kPaAvZb7e+qOS0AdwARNNQJkldnCxHVKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8DXL is a device targeting the automotive and industrial market
segments. The chip is designed to achieve both high performance and
low power consumption. It has a dual (2x) Cortex-A35 processor.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..4f4c9c0a1315 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1034,6 +1034,12 @@ properties:
               - toradex,colibri-imx8x     # Colibri iMX8X Modules
           - const: fsl,imx8qxp
 
+      - description: i.MX8DXL based Boards
+        items:
+          - enum:
+              - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
+          - const: fsl,imx8dxl
+
       - description: i.MX8QXP Boards with Toradex Coilbri iMX8X Modules
         items:
           - enum:
-- 
2.25.1

