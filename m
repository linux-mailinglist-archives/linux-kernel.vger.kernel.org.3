Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9A4B1B89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347015AbiBKBof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbiBKBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:21 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633005F99;
        Thu, 10 Feb 2022 17:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLGCuIyJ68wWXc49jif6v95V0s6wSjN9ILRlMUdeM7se86rctUczD67i/kBWqdy2sLa6jjZyiryX7n8uS2Pp6rTqSZy/qj03awgmGxHgSY35jG30zygqLlzyOK8KW4xlsry8gbTv+yY9jU7+7PYHVlFP7Ef0O6bCJqm8WJuqZ7k7t4yXoePJsyNvFtlfGOj5Wp9+uAEDXYUQ+xsveGOVhEzXh8yxiBlLmzIuPGonD3fHtn5o06LNWLWwOIfte3RVb4YGCCkukpIHqfBaMirQoFpa2v12hxIfDEsJM6dVvIiwh5glaE7aghmQCFWY39Xgk+u5TaF6qSkaijf0OorWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP5HXQWNQDu0kPu93Qi/cyxG6HflqgTsAz3rl/SoNIU=;
 b=nPamJw3go1a8IFBLK2c3vUdS48yCNOViUPODO8kvP4gbrmwFEAr4ix49ms3s+3a1kmC2w9or0ajA1xqLSKptunvA9ek486m5gNW/RX8C/A5Omytg3T47jahm3sZjMkRCh0G5R2bZzKgQEm6mjGZtF0LCMyXyHMGP0mrB/QXyjZjSZ9muwA4OfH1COttQgQqr/B9SSZNQWmJ1R6RZqfR1JXDnDqam+RzBRMNlHRKYTRNMjm0HyU/2ynCkSMXHPbY+pfxAUaTMfS9+OPsYnKS0rI2aUBYuUpjGLgHpWT5JI8y7TFWXypFAfulVxjqIo3CPSQMquIIvOHpyUzPFyqzxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP5HXQWNQDu0kPu93Qi/cyxG6HflqgTsAz3rl/SoNIU=;
 b=mmYZFYHjQtgsovaVmHnsdZAhOEQMk55+Yk28BmPMJ/TY4PpUpyWk1rkHLASo7vSiABVcWoNyAabYpCN2C8GVxrTUoDcqEzyf/iE1qVAVrm3Sg7mru8/XTpWr3o+tSFGZzEhP59YrMAMNAplpFKi1jToRtMsp5P+rAPWhHDe56cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:16 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:16 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 05/10] arch: arm: dts: bletchley: switch to spi-gpio for spi2
Date:   Fri, 11 Feb 2022 09:43:42 +0800
Message-Id: <20220211014347.24841-6-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce45ce1-0110-4868-f807-08d9ed0002bc
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB3577E7C92CF75907E584B7C68E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhR4IiNnBy7WXDsek94M1J1LVCvsC7D++Tt2oTpZBKQXUF9hx1BkwFXS1CYHiDAWi4yPfofkXJCNwP6WX8RLCbH3Zsa81XUas/olXgjpjanlQKdbNtgoS4uefPJqDaHr3IlZ2McL7R46wzaxk42+mp+2sf67GGuWOJ+atWuu5J44ISwm+WBAXc6lWb3np6WKikvLdVwvQGYWlejjoMjhp66JR6GvS23rypzBGNvI1RtHDQlVzTZ5S6x2OVRuHiL15biZkAnIfwoEywUlWGVMP0OolukU6TCie+K91NW4HXfErUgn4zFBR8YqnCASAaX8EZBe5jHg30j0Z1iSsUe6jvWVdpI2aeSFH/PXNDFKDtuZMNIKFpHmycgLRScgLIeOv6nnwBY43TQEcRTlxo0fsJesDY5gPfALbDYWAa+GLvM8Rsq/re8lV0KBWZ+0d716b+uDKVM0GQ8+JEgQNoTK7epJTtlHwYREE5lOg8cXi/JTrS1CywvnOmG/TzYoRulr6zvXImQfULmiBhRxY26i40d+qmBlug02cURivKc+rMpzzVMDST0nOzfwtYZjBMvnSU8IRH2EuAAZLFUzhlay6p6cWDPtPa7ePzhiyh85vQE86OuwPqXfaPv05euk40TzOSe0qI+P9imN4ICUvlSnjieQ1NNvZvo2dmN6oDmYzv0WGxH5+L7DU8HVqTDZ20eq+dOwbzYW7qEnZojNfypOjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(4744005)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/7ff0wYUn7ldU4siuZ79EMEA396nx/X1oSrFj1BZYIQIIWnLYwQIUJCBhVT?=
 =?us-ascii?Q?Eg5lo+zWrjL1W/cOS7v3TVBNZfUBLusAzznlAplZ+LyLzcUcQVnBnYE+4rtH?=
 =?us-ascii?Q?ed9Wc8F2brywrEPIGt5V36EOhKUUL6kCtN71OKO9cLNOGXF9zwOHO08KHih+?=
 =?us-ascii?Q?KXgcJPgjnQlLmu6PP7t7OejmhbRizncgXH7Kw0rsoxtG0Dh3lx9smHUOPtIg?=
 =?us-ascii?Q?8H5tzoub0Q5dRgtI9ZmLW5VAPcuRscp2i5pmQ/r2Qo1EIJZDlQABRKSFhecU?=
 =?us-ascii?Q?RRxNCYBYuEhZ17yNQi5j7XxpDxQPMvnICiE0syrdM4VelaNA1EOQXMmn/zJd?=
 =?us-ascii?Q?7G0Po65ZlLrj6GBkC4jWgiHhGwxIjVl7/DSsH7ZmWC063xgnCLx2FfmsQ17s?=
 =?us-ascii?Q?GD0wdr3D2aI5QNxlwVxGrE3b2rlc1JmNfvOkxPYlXgez/9/17MlqcvDqh3uy?=
 =?us-ascii?Q?65w9Bn7/aYMNPhJQLABmsT4FGdQdKGrKCAFebVsUUnXUFp+LfGO14igYZgtn?=
 =?us-ascii?Q?W8isXzBg6UYj58YG9n1xli12MnUPwy3Ht/q+/3vI7OpCNijuVgulOpsOjVTv?=
 =?us-ascii?Q?jXKyBcsTq7oBtBc5sZlXwp9Ru5mT5z7ZASjzBJiiHf0BzuwUbCsleGyotmTL?=
 =?us-ascii?Q?k4jCRK8UPP4skYDqNKiK1UkfucRwz5D7w0YiAMy8WpI7/EMe1YDkkPVHrg7J?=
 =?us-ascii?Q?8pZhm1Ov3PC8UhCBQnZy0Pf+3kFIFPmHfgs6ABvc+2emJ/HcUWwGllFIMYiV?=
 =?us-ascii?Q?OOl12sfGBa+XnY6kgL7wonPIZdL0l/wkh9fDbRtwTilpiuNqmSuzkDgnP7dc?=
 =?us-ascii?Q?r/dUIE+gnsnJ4at5IkTLiN4hNlqAkqQ09T8Z5pweP8hEI6mlXouC68nzPSXG?=
 =?us-ascii?Q?Hbqe5ovhLKh/UsR8QEpRLxpp+x7rTWw4aMDk/aMdEC3xWQiGhwV67NKWLwLn?=
 =?us-ascii?Q?iuefig7/HvY8Hvf6xRPlFfs1/0+rK+kkyaOlzUwEnu7GX8PoW78JWKkfN4kr?=
 =?us-ascii?Q?WdyvCHBpyiq8Mm19Vmo2+m96KhxrLORhBBHyXJ/IyavlpT09fMaQjrOqfWat?=
 =?us-ascii?Q?MmLW0EZvASdc8sDXEuiGuAr0jNlkaa1bqZ8kx5PaE7OSwtZCqmr8qsuDqHrB?=
 =?us-ascii?Q?LuQC7Ds6cTocqb2T/Cypc6DDU8PimjPvkZ+6vzoJsVyrS736K1o/OpNouLV4?=
 =?us-ascii?Q?dfhxOjrw6kyslFZ5g0i3eYrjN+gdT75idjy6JCd9MbEtkkNa6gSTTzzg9NsP?=
 =?us-ascii?Q?LQE177hwO3tL2fHi+AlQacjfWJyXZqJvqhEokSK9TQ6dO1x0dEkURtgM692I?=
 =?us-ascii?Q?6eEXziMAzcBWfZFQJe8VbmhDJh4PToubCvYyWk+MSx5QA26XQ9UFaMbnFTlB?=
 =?us-ascii?Q?rDriDVaUGhUjl3k5IJ/O1FKn1omtvuhKvut/zXlmkHDPEyR+Wolx3+Dy+iom?=
 =?us-ascii?Q?wSBpGRpI0pGYWUceyEkLLHiGG6lrCPcLtueShfuuqOzCO2t7TDhtmSD37qZ1?=
 =?us-ascii?Q?kXaqv9gmNGx0Dq+GEXDYYuNXUrqwi85CRt8y/IOXw4rHvjiaQ74PndXPstwQ?=
 =?us-ascii?Q?p6s2ab+XEqYkfi/E1RMvti5sjkWj8UAwpzr3AOWzRqmOlIKdjdKj0XsHeVS4?=
 =?us-ascii?Q?HisoD5j3elyrErQL2jHTbic=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce45ce1-0110-4868-f807-08d9ed0002bc
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:15.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Esi7m2+qbfz53OzVpY7pwaB/wq+axuggfvAcmiiYBkdlbCRVerEOvqzORdZgXjocCgTtV7gfWX7WMCe69dm6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to spi-gpio driver to avoid unstable signal issue with EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index b01f1e7adb81..3c54e4a892c9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -227,8 +227,16 @@
 
 &spi2 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	compatible = "spi-gpio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+	gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+	gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+	num-chipselects = <1>;
+	cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 
 	flash@0 {
 		status = "okay";
-- 
2.17.1

