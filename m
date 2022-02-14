Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172104B40D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiBNE05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiBNE0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2324F47F;
        Sun, 13 Feb 2022 20:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVB6k9oEXLdf4FSrNLPcuScy68taZmLbXYAWhFsOYj/DlZn7fkYLKFB/Kv5r5x+3btkcEa5Wvlbvz05NT0kGef6n2S2eHb8mX2p+WmteBy1P+gAr/zEU0DBoG2I7EILCypCQgcJ5cWYcMx0tt+DclvENG/yKHGu7AT2fGClbm9cnk4BOOhiZRwZMJyzmRfR06+6y6zKoklH6K2hhP/KUBekGEJzQZL9c/qBC+/BZZr5CkZMXNFxkA3gtCqRQLl3HQrgQmY2T8fVdq5dmUHsIHulO0I7vj+pujuiU0OdBuFuOTTWfjhK+t/MnNSqh2hqZFXBd3VicNUmiBSChGm2ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP5HXQWNQDu0kPu93Qi/cyxG6HflqgTsAz3rl/SoNIU=;
 b=ZGg31bqNYmlcYN/EcsJ5GDeDJQhP97gpik61/eT4TMhcR+9ogOhrkwDiGgTSL7A0Ygo4ef4UGt8ZAWDbb2yp1iH7F2MKDqWIsNTEKpZphYH7In+or8KJcVl5SAEf8DuJUWfzI+DdN4PZg0s1OtxCCiXm5pfAB6jw82eieS2QCYlr66bxhxlrdYJHU8e+GN0KmZngxEhaTCHqT1wUbwWN1lcvo5HkIpnWFsjM7BOUu6KsDoGnAW8mbluF3Ql5RwmbQrVujdywJxRJ1nZ3rihRANNRcAHFGHfPt+j7yWkNzOa833tYzbr6LBOAxAYjKNXMRFEhpMog3/Qk4nskTfx2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP5HXQWNQDu0kPu93Qi/cyxG6HflqgTsAz3rl/SoNIU=;
 b=tS/BD0eIzL9R8R5gkt53ympOhA3FAPRkpz6dYNYGLYsD4pG6ttN1OKOeNz40sPxQeikwCHTDLkDxDR5qsO38RyDajy3pqny2A9X3TGgjRS9C+DQmDiJMD6MC2IWc0xhwyHMSdjfoqQAsnSkoVC5eneax7Z4hs6vU2LqZOGePbEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:01 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:00 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 05/10] arch: arm: dts: bletchley: switch to spi-gpio for spi2
Date:   Mon, 14 Feb 2022 12:25:33 +0800
Message-Id: <20220214042538.12132-6-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd8fc8a7-fac1-4ed6-2202-08d9ef721a1b
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB2451BA09179FABD52885564F8E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bcDsmTRj0PdRzjH9pDb9MqapxF1iob0c67XhiKhFUOmQAGVwq14Jfoj5sLr2CtxWgy5aBL7EKrfEGfnCNkGkK1zWvL1Aw/w1Sg0rJUbWEZfGEkpPxSEOZ6l6eLUZtSH/XRf0xGBzWMM53Tt8Ue+dCeFz7Wl6Bydz6+lLjkh1kZZQBACZMtZjGMXPNb5UhdZ39h98zKIfh9yqiz6OXdJiWpexSjFL7V0rtakPZG1VipobVmnn3KjHOvzq7HtnPnAo9CDd1nZF/8IlKPWoNL8VXvAZbLdPVa9rhoRjIZiUbS1NWAlEXLbsJKr5P7GgZeYxqO7N7U/E3ZhD09j9FybM5ACbIQuueCToz9pa0GgSZI0d7xxtxlWsVbzoJobhuyBkdf1ciHiyjiomZQjQPFyhVUUKNI/M7EfbU+Ul1RNE8zDSs5w4p5EwZlgFjbomdietY+lbSC1XuEdPKb1aPxt+MyO7ilsvOBajpYJB8bD6/cbg9jJb1VYVFfgsUvCNpA/dQqlaZfLRCIAx1KMBU9kIUwMzSqbKK32ZgzT9hRMRxmy3lMdx4uAp9as/aQM6IFj2u/a+m+tmxmhq17TR22H8JVKP5V3ZP4YDiTjqKGClxsy10056/Qw9+x0KTaLSangwgnijboOAeCQbls6kpjqKb6TOOaxPQoXB5brnPJsHzX346+cUOCt+ls//Q7En7/F/SRP9qxiVKyX9h8A94eEOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(4744005)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVdNhYKyizG3ek5qArXhnx7QcJx8TDzZ4INF6xMje3LtqPPGil+0Jg/aROv1?=
 =?us-ascii?Q?GpvgOdYyXZ94ex/1YFJyH+aIugY18IlkF8j3yU4RinqRH3SoF4tkWBa5E2Gg?=
 =?us-ascii?Q?PHlqjhuVQmZpoCEJnWSjLnKZXmECQiUTS+QQzqEXWzoxYYQj/0D9OvC59dbX?=
 =?us-ascii?Q?TvzVT0yTOG66QRno60+gN8wEKzkUVTPcBJyle2Ik4tXTFGG90EoeTO6xo5vN?=
 =?us-ascii?Q?xPnITYQKbOBQhz7nBZmUanWEQhSaRgWwmIJtoDaePEHfcO1Ty4UUJICCHXnF?=
 =?us-ascii?Q?31fu24RfC9u11MZ0YGEMDMWeBG+YlY/2WTKRz25vacOIm6/w8ZqWuwlEotgb?=
 =?us-ascii?Q?ht29ymSjxU+VruXzGbgL62qO68NEqU3DHZTFfYM53Kb1IL/+M6K/vYn8TwgP?=
 =?us-ascii?Q?4kqzOfyfcgh51Pn7FxWglN6REOp+UUKkgWF98NhgcGaPKB67wxDVriS+5xTu?=
 =?us-ascii?Q?85m3PyIA16MHY4TIquZcR8PPL3gQ9pFNtwWX2Bm65e1oW/mGuiTF+eA+aWnV?=
 =?us-ascii?Q?N5t5uIhgRcotImNgy8RpXqyRICbMdZs+hV+muaELr9anUwMR+WgGX4dfYoXl?=
 =?us-ascii?Q?eTT6Pkzgn0R201lD5YDd8bM4649c8zGGEDQ7IN9AFRvF8lWeE9/9Wy5oyrQp?=
 =?us-ascii?Q?xCOAFDjbEAnm0zgCSQkyKW8BbTKwwJ89oEK7YsygQOdgodpXdGrfL4GJQkvq?=
 =?us-ascii?Q?5eYGQvEvu9qeWIJZXG3fbY5iNTi/90f4/jfKjgbHn1wuJ+lIzFxxYt+qLxLl?=
 =?us-ascii?Q?YJVx1KrPJq7tumWijFxKltf8rCFNirg3JX/S66ikFi5aITxkcIhMpXG/gLTZ?=
 =?us-ascii?Q?LgrAucZ4OJPCyG3TmW22ogghkXelKYbuR09HhaWZmblfxqBN4EaRb2NNfIKQ?=
 =?us-ascii?Q?eWZ7uG9Oxcr5kfu3nWUL7l9N8058EqEQhGP7z4aCR3nS4eJ8+vdoRHhYV0Af?=
 =?us-ascii?Q?3sPJxZ4YVz6iYVUxYTN+aNJbpNN3OiSrximYP+AWsDrh3znr5A/JN1ymP7dE?=
 =?us-ascii?Q?RBgaGP/lrjWyXNdygn1xHh17Rrf1ADVzecRJJWv9h5LO1La3q2Eq3PE+KOe/?=
 =?us-ascii?Q?43LTUNfZFWBfk+01fnnWGhMD3Q0H+69SAyAM9ZYB4cxfIZoJUutmz4xC2CuH?=
 =?us-ascii?Q?g3CrcWbIvPgjlNysHH1Bk2dCRIzOWJZV6rMwn0u9wrm9pEftIZpw2br736v4?=
 =?us-ascii?Q?wExN4ieD48T1bekoudBWx3r4xzeTxsVVJ9i/09ZivyA8hblsX6/8yiVSzY4E?=
 =?us-ascii?Q?+8m8MN3mwMJQ3RzS9VL1lBijdw+UOTQy5jwmJjMDu4ysjRg1Qo60KQBBQcMT?=
 =?us-ascii?Q?S9gwz+n86py+U9sgtWNQHJzONhDXfO8ySLcWdk3kZ5B3gi6FL9FdsRlNUXgm?=
 =?us-ascii?Q?YUxfg4X+cB9OaRzaZgDie0UgoD5tGI5B/Z63b6PS28JpemthqIz1+xAnHaT/?=
 =?us-ascii?Q?Ary8YdXPUUZIGxhFNK+bcEjKrgmWm3d/a/B+Sf8SmTewQWtuvJA4JAQUEM0E?=
 =?us-ascii?Q?BNTILLgfqqkbXZ3ozU6G5NGTeWVGGbq6lGhAxNI17cmBqtKHyg2BNzNOeOlm?=
 =?us-ascii?Q?OIW+bDXqdxAQSPRjWSGyGW1Nz+GJ9pBz6cWUChXGkgQbIk6fRhf0uB7mUMI1?=
 =?us-ascii?Q?sdKm8eddXrJH6emrhVhxGLQ=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8fc8a7-fac1-4ed6-2202-08d9ef721a1b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:25:59.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIjKmkvQMP38P4W0orm6X3RugN+BgSl55a3oZAypUueT/rmzDaSjxk0jPdXDSnUo4Sakl1mDjjlM8QlKTureDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
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

