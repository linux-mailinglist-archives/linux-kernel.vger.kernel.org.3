Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0E57944F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiGSHfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiGSHe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:34:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682F357D5;
        Tue, 19 Jul 2022 00:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0psezzdbIoVHaeGTApH8hZEILxxFtsrlcXwJOPL0lb7Qe9hujGg6AbtObGj/PyAic6Mh6BpfCHpbHpRx85bIs7eu3Q/KAre2ps90eoFKssE6vuEgGZVPuVcWRj06lfcE5OC4D+cQ/09kvEOyZ+3zDyv/cBXBMuegWUppYKhB4QZpCrEQIAKmcolRCy1RH+pFE/4OLCwaSs9bdVTgFgtFDWLifo1PF95d539t3v6U8g35u2xigdReOK8JWx38gjB2sqXvm3NKlWK88R4F/igYqZGFa/EnB3uz4RFC33K93DB5TVmCYPWdlqMUuI8X4jkBQK4NmLrB7ucC+5DSvLijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a7TK8rBMLJKw7jOIDDWzg0ZGU4t78s+Obr03vE1wDk=;
 b=CFH2K121HJ3R41I4ddgkUAvME46P+GDb0ed88OjTgiLp6slhqy9K7UGOFrTKf/frPKm9bklbzhI0LCAxBzCAdrRBgHsWcDd4jn9uHWF65vwa77FKtFA0If/aWxTJ8Tgrwpy6QJD22g5P5057xzWoH2Jyir3MLRXI9Yjc+RoLAGv+YKpEktIX8ZHFxojKj13FWOsDP9UUJl9TdJk0ik+BW+nX9RjkpV0fikM6ZRVUOFKye8WW+7Jzd/1PKoillBCwz6PLYbGqBPH4pM7Nan+24ikMifbTnk+7pkky7Mu/5AmqCfipgKcot9T6QHGF8PpQEyb1RsImYOckaZGQqUAyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a7TK8rBMLJKw7jOIDDWzg0ZGU4t78s+Obr03vE1wDk=;
 b=cuBIuJoQqbkOYfbRSTFQHKtNyqVGbeEDNNG4BB6EuZuqUn0MZmQTsMeQynyBjnliuxS19619oV9owJFgQv5f1tgJRoBEwXv6/A4OzQCIgnewywy54K7URM8qxTXfoidijgf1DGC4ssxq8QM4FBxA2vdL+yKjraS1ca80h1HbNm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 07:34:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:34:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 5/6] arm64: dts: imx93: add src node
Date:   Tue, 19 Jul 2022 15:35:40 +0800
Message-Id: <20220719073541.197788-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719073541.197788-1-peng.fan@oss.nxp.com>
References: <20220719073541.197788-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02a34f29-9f7a-4579-db17-08da695918b0
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6144dz3mzbKil4eoPaJrPnbPuKpW2j86/9jr9z/HZ4WSbrsWFdp3h/ihPUL4wc9b1CNK9T2GkfqJ3YAcJSXxWCS0bp4fg5iRElk0P9r+QNlnIrm8crrmFapmKQoeeugC8H0u0CQnVLQU2SU8dh71ooSrYE12/+ud5E4jafzVCxTLZYCQddCtUWGFQTAiWySRkf5atQEEdRcg/LXuUskSzuPrcUXs7GfIL5oSmP3j1cATc+4aAFBoPDWe7mlT3WQJvHJckpHGj+PyX4WvYcuz4Xy12XsAS4fLbUbVLUT990xoNZ1rRLQQKE5m2yVEphvnEOoJOk3t39uD9ka65rDOjSxvAh1WdcUUN4lIjYU7u5Yv62oPcTYvMbhMQ6JlZbMXLTyLuVbHVn766KVMrVM0W/qZimaOUWDweSevQcn1rU8DnUCF5crm+9Lj0FrBaO2b9NQfZis4eGSbDNWPFmZITiehDbjbh9yX4cIlUzfw0KlIg+5XWDJnlNuMh/8RTCGMAJLbwZtdZLEuRo9pq9qYM8CdwzDnohkImOQfPh2Bt8JG0anBwl261rndlTNIka6C2jUVtfo4UsBra2AiUNgGMQn0fmKMZshSNjmyYR9Q4unm5aP4I6jxMgKIygI6J1Trax7b5TSSlMeEx68Y+55YtJaiUvpyC4lIkucwuYTjUSWtznvB08fOCigGRoPAjQHHLQucIj+M5xXN1pBudt0/4Q5SMJAK3kXc+nMGHxMHt/XwHbFQ8TDlNZdGvgyNAzyc4v2OPB2GxnOFQ24el5DdKkVxunh31+/rGsMDaKKeVTrlfCInSs32XMAUepugpu/R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38350700002)(38100700002)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(4744005)(2906002)(41300700001)(26005)(6666004)(83380400001)(186003)(6512007)(478600001)(2616005)(7416002)(5660300002)(6486002)(8936002)(86362001)(1076003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnP80p1/RClmz2AP5Hsp3Hg26Un0/Jye6OWt1w2PcLVphkZZgX/Os1400kMR?=
 =?us-ascii?Q?8IgjO0bJGq2aWRiGYSIXbPpUkNLWqZMQqVUcpqq55NxeEU8OK2HDvn6jBzJl?=
 =?us-ascii?Q?AoEnKCg0zjbRUujheQouIjrXKNFOOXoeXFsfU8SmYEqm+/VEOSOKbDPkUnWV?=
 =?us-ascii?Q?/+eBV0dVbqo5NbjOLYGnLZnpokYP57Rj8eQzAhLUrO9km5dZLYFmO6P9/ePu?=
 =?us-ascii?Q?FCe0GFfY7ADaJKLKX8Wl72dmk0f1ca6Du6gNpD6yOxbOPlEM7bZtw/VfUYYT?=
 =?us-ascii?Q?jIqoBWTH+2wMv99mJsuOR0i7IAbgfI5YiN5Yg5OPiY4nEzu1zS8z6ij4lBgM?=
 =?us-ascii?Q?keXPtEvEwH3wz7sKzBRpWfQWcVxy7iJYAfa1Z1tZHGLTaNxCB+xMVxrEBq9P?=
 =?us-ascii?Q?RJViJUwvp61cm3mx351F0nFbIM7j0m+iwsTJH6dUuiIDp84fheB48HdWRYHV?=
 =?us-ascii?Q?Na66mAtiwV0r6hKFn4vmL/Eq9BPTMTWijLfaybCbc4emmIk8fY9BiuaNGGWA?=
 =?us-ascii?Q?2Qx2gbqjgjOTLKaq1fH/rj4jxQVyzWB9CzyGrOc+eANP38shFl4rx42gdnda?=
 =?us-ascii?Q?UtbJ5M6ujCJNcY8QO9oJY+08ugWr0+lMASqNqC2wwZw+LWfnCJE1vGXm0dhG?=
 =?us-ascii?Q?UcUudxbdmx+IMHrPCDJP4TMn6uzHj6JEPRPwi6ZEheycoYjHfBjxhamudfEE?=
 =?us-ascii?Q?DFQcroguiHT2+48JLE1tybA+RKV1DVrklosYQfa6AYV9SXEQBJ5kFUpCZbs+?=
 =?us-ascii?Q?wndVkSWnZpgYnhXXUR8+puXybzLGTuek3G7w5D1/o0izojq8g6fccBI50jON?=
 =?us-ascii?Q?cnU4874NXAxVCxVWy8ORwTwDKEnB99qLnSLPGgr4vJ2UCzQlD8u0PHhd5S0G?=
 =?us-ascii?Q?MWmuZUxUwqOZJuIZ/JrV9N1e/FJzkBYe1PV0vy2c5VLcA/BCoQzgJYGjK5F1?=
 =?us-ascii?Q?hmWzUQCg7TFU1o/c0Bkb29bMjJrbyMqdG6T+mkIwnUcCzyHL6FlTWOzahDHw?=
 =?us-ascii?Q?b3nPXK2/k+T/fvOyHrVN5HeV4wkN9OCuIjOKWJ3VQH1uQezJzqdwvaGmBISE?=
 =?us-ascii?Q?V/mZwC2gqnkVY8TCIqQvQaKP1l/4Xkyk+ShuYeDsM3JXiurKqex8XBToasC3?=
 =?us-ascii?Q?hivJnkA5Ze4Iidl02bJ+fOy9ZayKjtzed1a6N2mFlf7JROCQXVXY78fLF4ys?=
 =?us-ascii?Q?zfKmNcyvw7SkyPm2BU9noRpCxd5urv+KHp3FGoii5Cf1wMrHBCKMOpBDFyPT?=
 =?us-ascii?Q?Hy2bhFSl8wle4H36TNTKeEHs21DjvCO6F+4PAKyS8RgKmsXECPnt12J0WCgl?=
 =?us-ascii?Q?8ncPxKqqMD4yVhn3wp4EETHsCwdWk6gbcJfNcbyG7sPcX4k/exCOZbMzYBjW?=
 =?us-ascii?Q?OwTs2mmDnG6aHMQWRlCWYwvsC9yfcfBD6Jv/zJjBSBFI2rsrzlnhFz+6FrmO?=
 =?us-ascii?Q?uurzEQTktG5quQPPc9v4CP9moUKR7NfLMpFS0P79YGpYDB9cwQDVw63O2Ua+?=
 =?us-ascii?Q?ZZTJEmIqsxXi/a1WFOmqnvz51YIG1XZKTSE5VqfqrGwUyH2+rbcxWqDDx0P+?=
 =?us-ascii?Q?8K2gkM3n01woptYEtsdGnioqSXXJHWBvyzcpnk4G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a34f29-9f7a-4579-db17-08da695918b0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 07:34:21.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SApBlobaHD0PmwImyfMNClg0bAPPG6UrLDUpdtEyCAl4utwRBYrNzrUNC0WqDb5lX+gLhmIAN1QXJWhZdqINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 SRC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..883d38920db4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -161,6 +161,22 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				mediamix: power-domain@8 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44462400 0x400>, <0x44465800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+						 <&clk IMX93_CLK_MEDIA_APB>;
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.25.1

