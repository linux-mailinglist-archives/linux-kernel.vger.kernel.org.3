Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E039456464A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGCJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiGCJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B4271A;
        Sun,  3 Jul 2022 02:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muS95gZ0I29WCZY5uXlDzuIBm8AmqRMaMBEJrmTL4T/nbeNe4KTn4rJoxR8X/+VKB/xr74jCAtmnFlFluUNNAsTNca+FBAPdJ96h6l1TNA6NMtm11J2yZZ3D2xsjURltTTBpt5ri2AcWiKzdKssxS3tlyHtqKX7wS4KiTkvJvRwAJA092AEkFnObd7OIS3EQCsbgCRnLJk3A1af+vTs/mxUbxovJWQSGD7XlRpe9frLl7iP1J/Gbqnok3r/jQv4AAi8p+xRPUWmGqFra5j6OMEuVQ9qQWhgMOk7cuWV/vNWp4g2J6gxSt5Aq8GSVEx5q82OCioQDvseuIced6/szjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=NarkzyvJi/8vpC4V4jZZAReP5tkg8ELQAJOP1Su2DVIJ6pGSL0j6dmQl2EmeASQv+ZoygXQHGcrgKlM6GtFlsmiCaV9A+vMyNejpTlNzsThD+tjQmKwet/rXfEE4OvQdKyrHcritFGWkoA0xnldj4klWU8NyDhxVCvBkyNFsbF+/4ck6qISibMFSEZbG7ZZ0PTmR2EMvu8Hx0FCKRmH1Wp369QsRFzZFQs4zKdSiTSeDFQZbWtwktXbz4ctOmJsFl+MTqhjg52tEn2tcUbqgSUvXk8NXmZ2l+KQ+FtsORmrI5QpndnugWBJapQek2aDTPTE2eZYQUGn8hSeBF+OvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=e9Qdb3JsYHRjsTZpGKvaBmVMJ8qAULuFuiP85odrcOAG1eA/Q3FTbKNE3P+bHA+w/+df+3qeaWwN1zM+gauRjlxdUNUzhv5nmFs4Ejl8glXDPiaVTMNnKJetj0TFUB+Bv6LiDX0rkZNbIj8b9IQnOrHLMQBUx6JTYjTmW40UbZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 3/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk ctrl
Date:   Sun,  3 Jul 2022 17:14:47 +0800
Message-Id: <20220703091451.1416264-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce832251-97d9-4eed-2974-08da5cd44a47
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds2HO1BxIaoi5hURp9VgQs4CpH/vouWwOQk6iGYbNv03qegWp9oYdiHoRJYJSayP6MIlGflFZoQnneRx5SheT1v/ceO3IkrnFzrkzz0YkqY08vbl4nl3fjrtt27HBB7tvgql/lFPxUa8lTIFqUQf5uW8HLHeXtq9z0n7D6VZ3s4E4MB6BYteNZ3O5LNT1A+KczubaXaPFSwWnWt+lJ86JOxxja6xtMDVdVD5yWQ7f6eRIH5qO7sSahBkehlH93kjEr8onrGpdEn71hA86ss0nytT9ietHA0kfz8qRor96OxYjuXGDkmYNnkjWHX5698nHcCuTO/FEnBpgnuZjhZUmykpEAOmDdJCYjO7O7tJnGW5rqXhzdJcwGd3282xwdjCEeZCr7NW+EMkO7+ncKgrLTc8/CRzqG8QNJkiYVl8HWtKzEhXTy6VOU1gtzJLWGpxqbTdUOZrBiNFQLB5O5rMN9YkjFCfGBXqU1ysA0xjQPikPvm2lYPPLMS88U9MswU8UJ08QZv0+TyrTZqftliya3GvUJbaOZc0t4BhM3QZI0kWXaIIQpFf0MtaRubtqiUDXio/3WYHdRwcHw2UJ7rExi9HF7yhitTrAgD5khXINr+48fuwr+5GMUgdFCaMZxinhfIIRZt8K/07bRU+FiBhb9GCNC8tHrI9nCkxCu8OHsxRJfFrYWDPwGdKjY/xsCYeDjEXvNAljAfN0X5vroiAd7ZE4WQMnyrYrPnVhHjQXidard/9ZSBxiVBiU1lexqrhrWNUWyvVV/TaiHhhsnxbSMGj/oaaxpQlZMVqpcewf662Y7Kuu4BVcIc0CwJyz0vcmPR/UiB6RSETf6wEXOwYRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(4744005)(5660300002)(8936002)(7416002)(921005)(54906003)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRAx/KZquCdd1Q5E+xfzJjmwABntvLLr9AMKO4q1eNTcUszZz5emZ3jssv8M?=
 =?us-ascii?Q?iXtyWXorMwF+DJGgIaDsaB659SVU81/J7DToIroYO56pASbLXV3s7nIkYamE?=
 =?us-ascii?Q?crGSIhq3btexd7k5PzVKZE15/7iMXLxo7PPYje+dLQabxJKCj6PeaThSKKkB?=
 =?us-ascii?Q?h8PR0lfxFVpTeKQRpgJQNoahCFw2kDQDeVTmnzMX0wcN+s0UOHxmOMdbgzS2?=
 =?us-ascii?Q?ezhrsTz/GrXPiqkz1ZHhQinpdznfGuvYuU7hY87hWUzuW7ug1ks07nQ8KMuH?=
 =?us-ascii?Q?olSe+d/R42lDQ0Tr2Ac1XgAhP1qo8I14zc68fqRKa4iV5NqrsfZZ/fJJPa3s?=
 =?us-ascii?Q?OmbseLBRyzTg943zqxOiRe6y2PXyiiMq+ViJffBvEm+7PuV97UJU5N9AMWEe?=
 =?us-ascii?Q?JLKjz7ZVlHXgEtxQoffsb6+6aXz64N8C6q53+kmJfGlXI0TF80kIKUM3nfk7?=
 =?us-ascii?Q?e9Jm2HSO/ckNwydnaRb4BaKPQCKW5rySW7MhpQNGcYXgALT2ZH5YQhocufz2?=
 =?us-ascii?Q?GBjIwhfEOYkvJzFcWhdkZyarj5s5LoxgcVdi6aNBaiE10eMSR5q7EgKfrSBB?=
 =?us-ascii?Q?0cReau7RCWzOqwJc/qasn4bwqwU8Y8vk3zHFv6oGJBjkhNJNPOyqw6QOOO/A?=
 =?us-ascii?Q?1gg0rwcVKB6WQtIFBKMuwJ2+OAPGrqGujsoZUtQLvm88xIxjRC7lOZyl73le?=
 =?us-ascii?Q?wgVBZ/dCI/SjmSfZIQtQa07SHw2dRxxbMop5BlPZcCGexw6dhc2nU+QlTsiC?=
 =?us-ascii?Q?c2wsiWqtK6jeKkvCIV28K5HvkxnzrZkNDiWrCZAKbB0iZyXHyFsrpkfEdDg7?=
 =?us-ascii?Q?RRj0C0bLuFUO6KqjXWrI90EHFkzooKaQmo8fHRA566sXsK7TjvR/DH+SLfWY?=
 =?us-ascii?Q?eXM0qDq+8lM1xBixRe/y3e+YZtQ9I5u5MCnxFULrTxgSs9y2KujysIZzSv+T?=
 =?us-ascii?Q?Qt63SedOMfQsXCKjx9i/P9n+O5F+XBKpT53N8RF/TpOsK6pwdxKJ4r++UznS?=
 =?us-ascii?Q?7mbb9nmCb5Sr4WfA+VXV3q2zg62jndYZqFxnSc7eq+BwffYWw2M6AxcptXEM?=
 =?us-ascii?Q?DuGLUEbN2zuBnVJyzpFhrmaezLN+UgQDjpSXdCrT/xcan8Ee0FQZSeZ/R2lQ?=
 =?us-ascii?Q?vcXCXVjItEKVq1YZPWUCZL+SEoVj37wrnACi5fzQhYy+C+Rn6VNdLMHYXE+1?=
 =?us-ascii?Q?3o3fYaCrqzgtwTnwA+yk/hcCRKnY2Pn6fE9yiz3z23EawpWkKsczJrsVZHW7?=
 =?us-ascii?Q?Od/2AQ6hSrTxnXeCckEhUakFI8uoNOxO8En1NUDJW+fMEwVv4QySikD2mV1V?=
 =?us-ascii?Q?mQ5zScYfKkX2hH7dkBoNazKokvh4J/0/dT0YFvi8yhBitlbxLMHsad+9qr/y?=
 =?us-ascii?Q?Mx741mQZRHZCRl+HYlq99ZNyWbP4D5BS4E3ZBfZaUtBYz951PqqQ3TyvAbLv?=
 =?us-ascii?Q?aqRuSuYcsmcgg7fAGMEaTOUkANYgTim4HpafIzbWqrauj0MtXoGTTzoPFzu1?=
 =?us-ascii?Q?iCwxuZ8EDlzCrQN/tzDGrOwPnoL3aC9ocWY1UrRruz0d9hp3gMalmJJlylwk?=
 =?us-ascii?Q?Tx7qcylBzH1UlyLoFeeFTmaEkgGsGF7QJFlamTYE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce832251-97d9-4eed-2974-08da5cd44a47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:27.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih/DtAkDgTmw4ql0lHz8TfRsAlzJbpIySu4z0QfKv6DWajuKCLXsr2dHO2YMP1H8KqHTou5rmmgkrOWpLrbK6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
index c1e29d94f40e..c29181a9745b 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
@@ -48,6 +48,16 @@ properties:
       - const: usb
       - const: pcie
 
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: noc-pcie
+      - const: usb1
+      - const: usb2
+      - const: pcie
+
 required:
   - compatible
   - reg
-- 
2.25.1

