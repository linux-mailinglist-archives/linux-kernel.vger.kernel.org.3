Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971924D2CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiCIKDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiCIKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:00 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7E16F970;
        Wed,  9 Mar 2022 02:02:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSviU33rE5J9yCaL+M36lmW8r87UxscKiXlnVlbiFbbtfP4KsVdzbjAxVzrZwVT3+tCrikWhjSrA79X+wuWr35M7orSsqlGOlG0Z0F3n9WIApABWv8+iOhwurD6xxrClcAfbQuA59n1tup6QLfrGUEFf53xcwHdznZFEWt+WTq6KUakAW+r1AhXzrEER7IRrFRC82EpyHt07vIDFzA8iPUH2RAfBjioOYL1djPNbziJzIwUzkdpc6z+hbEVyZX5EAtqUmcl5BLFjHCd8WdY12UlBCxhehbknhPodWakJPFLFTExbHB7j4aA6J6FmW4NEG794FXfxEvSCdYvqaxGXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=ShUIWLADDROCgOa6GwyRfwaR3fLA4nznWzcxnjYAfJElPR2TZdEGOAa+nrNVvuTYDk6+QuZliuiP/JXkVC4pKAxSoWY8RXWxWpCCGmEeFPy0+veSwUTMcTjdczlu1mnRziPqfJnPnRefW0ftPSdU8QUVBL9sJjqyzynafKdIMBgPtRSY/PUJSVJc6XJnejwzx/SVDUYFjG6rDm5vcVHBgRPlANrzQwQWpmD1xlEMRxQwGLuI4w0ucuRXNAxCGidRJGBxYwUi3yXLjvu1oUtJlvYcuP/Q1nGaIul+a5Q4qin444BbDawb/xIFJFM0JCUjvAamYvG9OL4sgd7CkB4tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=cnwI0OMl91gfXmvIg8yO0+ZF3eAFSFtbvTWdAoGNdjrfWcMsKBCQKyUDUGx9uvQkpHwLJJOjYf7sMqcXJCrvidMphcDUyNR+APsj0ULu2FgiDOadsoyATWOT89GxSz1zZYMF7stcz9Go2OOC0e6OgSAxiehuYPOxbH7mj+Fq0hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6724.eurprd04.prod.outlook.com (2603:10a6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 10:01:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:01:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V7 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Wed,  9 Mar 2022 18:03:41 +0800
Message-Id: <20220309100345.2633862-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
References: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd4a303-101f-460c-ea1b-08da01b3d989
X-MS-TrafficTypeDiagnostic: AM0PR04MB6724:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB67247A579986DC9D8283AB9CC90A9@AM0PR04MB6724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2ESYQBcnSaTNkWryU/G37ZxtTXDKKqnHeBae1EZmFPrvmxIXvDgD7NlDcsC9ZTnzSl5luw94P+rcn7q+L7ItlehvwyMZEypXb6PDF+afwVUoEdS/cVxKlnbFwSO3qhNq8QTLrog/bn0VBKvRWjD+apfi1nzkqfWhnwoSzAQzJ6f0Q8IMHegsSATueHJvmA2ReVDQ3qnp2aC6H9zwRlsFABqE7ix15WKvhGuLI2QtRPMVbWP5khIj5HBu/hTn1qM8TWCXSUX9W30YrpDhLyNJ7KkSV6U6ZKtQeNrC6FTDb1uwYTsm5024fVabo4RCesbbM1+SYc0A2wEMQ6itn2bQCRQ5YB1KF/hNmW+JjhQ51/w6bw99R4zSQv3kGUQQVczYQ2v6digPi/vjX8YEbeOFq/+2jZNZzeQo7VymtHCDSzwe8R8mFfF8B8atkrW9pdrTAcXDsye/X+zk8Cbtblbh9RFOrKaHLvk6y4hD8j4/+utHAolNL83bzuIqA+jcr8AFCXwMtG0O+gzK0vY8LF5r2IVxrU84oSR9ZumsmAJKonhfHOJZcy2ceB4lqAdkRlQOVItS1oINENO6sAboo8Zsn6DGS7gu+vLkf9hDELNLoH32+vbi2CbzgFJ2dLqG8d9yt+Hlwn0rvsji0k3f8wkkDSHBe1PdOFZk+0sMdyG5+A52kyoLgLB9bEHbo4SgG4cxt7wleDSkJ3lZ1CqdeaJvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(54906003)(316002)(66556008)(4326008)(6666004)(8676002)(66476007)(38350700002)(86362001)(66946007)(6512007)(8936002)(52116002)(6506007)(2906002)(508600001)(26005)(15650500001)(186003)(4744005)(1076003)(5660300002)(83380400001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WN5HB1GuJoxBlTOE7nFL5M3SGXCnKQ7OCzXXuamZaHWekMpAgfEOKScoOkEw?=
 =?us-ascii?Q?Cfa+y4SjFROhlzCMjua12d7uk1mCNIts085h2BdSlWhQKb31PfQJPciAcED+?=
 =?us-ascii?Q?gsWrmslILX+TFDecWgZ8UKXkjrE9PCAYQcfmujetJsUcJLgHyvyvrzt34geS?=
 =?us-ascii?Q?Q9dJK8IcHTUKD1bGCf1XFojkYY5U5MA3s/HiJXw6Pq8CnYkbomdpx88hLFNE?=
 =?us-ascii?Q?dcOHa/X/BtzA9q7Bu+yf1Ap83Ap2Im2hu2yBqUwqrRdMroWwBV0ML4pJ6leB?=
 =?us-ascii?Q?/ms05Ge8PfXxGp0G+Nj9FscAaJI2aS5KIeYFx2jm0I//JpPFrP64nhrMK7MJ?=
 =?us-ascii?Q?R9SkYbENysnmbvdUAN1fHoOr8CuF6gsP6xFIUBAR45Ca/TYdEp69pDkcyP/G?=
 =?us-ascii?Q?DEICHUMK5Xl6LTQ+13/z6BXd647avvmJw0zbO75rpS5GXn3AJcivZThpUpRt?=
 =?us-ascii?Q?LvZqL2yb3+APot/Flrrhlnss1PNz37G6F6a3t6AfRtV+15N02LXqdUfEmg9S?=
 =?us-ascii?Q?uKZA19sUr4YueCPVAXkSSVkmVV+2DTd/jZTZTen88cgxp3T1ByxsS+LLcsCV?=
 =?us-ascii?Q?0PZJkyw8sL/lJ3S95aZFbzp6LHtXTqQ838iGSRMZHmPPosJdCZbdv8L+uXG1?=
 =?us-ascii?Q?WTrPK5uVqAFqD6H0Gz88pLNtuS8dySC9lsp2bR/+Mqmi6QOxcQf5UjoAyX7y?=
 =?us-ascii?Q?TGLtkffAXKch/E3sth0xdnsZoE5mPMJWGiZursywb2iF3dOEKLEB/vRdjcZf?=
 =?us-ascii?Q?uMfqiGcpzbyk+u28f1ZlraakLfTq4drjYlxMiFbrYg0gR2FDoSm0fsx9l89s?=
 =?us-ascii?Q?j2DrUfSN4VP5Tun4KHGe7MTZImQEg6BTKVhHjYNsoKhjqThy5Q6JcDXbPYhE?=
 =?us-ascii?Q?sMxqbe8k309aabdqnwaLK/recyECrrYNLorMQCqcdGsn0079KEtmhsew8Kys?=
 =?us-ascii?Q?WUfnz33ghPj50A4RHn+QyTTPS86a05zX75kGDaT0c+Ws/EXbQZKx8/cQmH2J?=
 =?us-ascii?Q?AZpxquMKnTMdCf/av0cdv2NQzJGidCsCNHVmpEhpTLN1GzRq2kZmj4FHtHZ4?=
 =?us-ascii?Q?ZIojQXv6oRtTj2/iHU3Mjw0H5LQkzccIKMIUh9HrBnDMM5UCR+Yk9BAuMoS8?=
 =?us-ascii?Q?ybYU9zKEj3+AaniyJwKpOyr6mPHlrTnbwXRy96/r2rq+z07y49FXogGqqJU/?=
 =?us-ascii?Q?uEIkbZdNR9yv842CXZT0u2TGANaSkfuoM1rXTi4IfiaQMvclDYODxd7D+Gx7?=
 =?us-ascii?Q?jH3iMioAi92qkBWWIkGR0SoQwPGeS9jv3j1us/K1GNsbBr7F/auI+yKQ4WOW?=
 =?us-ascii?Q?Rex5sDBmhnqkivmEfdM4kzFWw6lizgf5Sbiwetsyv6SmZvsj5ScjC1S+PH87?=
 =?us-ascii?Q?Ey2gczcXobo3ZoYObjFtIC0GXtVtq6CZnH73zl0lPgOloHi1f7pMebwOYu6i?=
 =?us-ascii?Q?hJr7i20aN498QYSsgeTcPzm9umZTKRE7aBtp8LlizgPSI4YwvP1c7kLpAEqD?=
 =?us-ascii?Q?DwC9jKcxcXzZAePSRUeMFp5myCZT0d7bZ5bXhD3bX/oS/lwRO68ScthW7COK?=
 =?us-ascii?Q?lUY5JdFlygAqfF+ZYdm9i9s37WZ3OBtL1Ry6zT0B4Hr6tAIB5xnvPC9NcHIX?=
 =?us-ascii?Q?UBoezDL+Dufkr8nFfQlATEY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd4a303-101f-460c-ea1b-08da01b3d989
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:01:59.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im0ol8JtOIGl5SVpFF+/BapWF7D3DkeLTzACjq8Q0KZuDNDngBcxjnPIzKCeDKWf0QZyh6g5PVJRh+MbataIlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 MU which derived from i.MX8ULP

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index f865b806ae6a..6d056d5e16bf 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -30,6 +30,9 @@ properties:
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
+      - items:
+          - const: fsl,imx93-mu
+          - const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.25.1

