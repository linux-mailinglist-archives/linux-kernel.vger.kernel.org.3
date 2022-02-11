Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B24B1B85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347093AbiBKBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbiBKBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:22 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300100.outbound.protection.outlook.com [40.107.130.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99215F99;
        Thu, 10 Feb 2022 17:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/zkF4UDN8u1E8At+/jqwF+ZQm9FmfRYbMuE79Q6YvUHe4H05aF7ZcPARZ5obw/BomDNA/u5BOL8CKMtT30jhcUqphT8764IIl239PW+mLSlqEIyg/3Q+9t/0EeSxZFzuHHgBQL/HHFGrXD548JQmwuXUGx3crpZJog0MoKlGzAtt7B55sS8pTDjOGxKJJm2R2QQAi+bDuXJaVh/5PaPg0gBnYOKWF6sg5oA71BbGBgp8BU7vRV7lub7L7HYHbj3d5pYZVdZFElXXQ9EXZqmrqEVwGAk/ttD0fKZa5eufApb8UvtYrfdcm3Nmt0AVLh5SdBGs9VZs+b6EGLS6Pl7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U+qZMiEYQuuwUYthaqKiZ4rPo5rYgpYTpz5r6aqttg=;
 b=WbNDRYqFcPzHasROy1h9KOED7TVBjMuG41asEfFTZd3QkQRLaSXz79jVnjCR7BGQyLRbsxjSMCH2w0sZ8uDDPfbyo5Ec2sGX/uyZPMBp0QiwXKuIsIjAwurKUbm9di2Ehn/4gX9BO/x9xB7gC+XLA4rpoDNjd8EgVsxqDwDEKvqvbdU62RnJ2JlfA6tKSa6bjVgKe6Mfe0O4UclSlYylKR77sU9uF4UJamzTgscXqdi7zflsbm+htJhmpBcYBZtiLerxI2ImijPXPG9lxyGQVoCmEJlkoYBIjQJ0RGazm/s6jp/uGVo3Hnn0or98dmxE7TIaC4qstC+ne3a6Xk2Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U+qZMiEYQuuwUYthaqKiZ4rPo5rYgpYTpz5r6aqttg=;
 b=GgXPEugeGX5aLEoZNL/KatVyQNEitHq4vZNJ8+kEkho9RKA1jhjhQzj1fyTj66pRbwbsfP7gFzEdo5gOJ78J9zlBKnyc9Wa1vmtuSVHbqpGFWLzVq22HaQN2ycsS1LBk/CLBGaFfYQptFGcMf9P7NMaUy5aTAnEOsdutlseiDrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:18 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:18 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 08/10] arch: arm: dts: bletchley: add INA230 sensor on each sled
Date:   Fri, 11 Feb 2022 09:43:45 +0800
Message-Id: <20220211014347.24841-9-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc5af48-f3fe-46ca-3850-08d9ed0003a4
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB3577DAF3F41623B433CDEBCD8E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHgA20m6b0W7sJBKsFoHlVMf4V+TrPTZblEd9Ct4zAKIPcvFHrnDX2alUu2ovwPe1lQsjiS/e83Gj1ZLzw9ZMw2VuYmjvLdAmpR7KTaY26F20DG1lLXwpZYt1bwn4CLOnz9x4fNAF53dVvXvwYc1RBe07/XgTUMwaHQGzBgA/XpiwRL9zHg7u6O0hejnfaAuthbXGcfzGlEpwFK7jyfcdNezgqT92VDNv68v0IbFH/oXI4RbBBBL83UWE2zNJ6S2uXtSVIqrE5koucokTPbYxcRX1wXVz7uC0kF14bqBni+P2peZsw9X7Uvl4/my9lwzVLlQqQ//gbvtSxJT8XvhsdWeU6BjXRr6lljyJG6oeU8MYMfFPBQwySeCOV0nneIGstCVfk6B16vMYl/J3VFpLfk6Ekv5h/h4gV6zUcVCyDLfFsjT6xZ4C2j5j+fgMpfGCP43rATePPxn7n7DQJFAYcjaOKxLt1yRDkwNENpJA4twj95ZTYv1ZZl11GsctZQXTLwXh0E9sRCk/CTQEbr8bRx9rkUUr7ea05TMT6kAUlOd/BbAHRcfw+B19Soem3VKM9gxysRkBjuJpJFtzra0F77WPmLgiFMc6dyGMFhdbpMp7o2r8wBPY24UQVQBSqazHrfXFPO+YdeOuONLVbNVFKDnag0hQ4162tgZwx5QpEstfUnr6hb2MQiKODpxV9QjbpcDllEMQlFn7h8iIbE++Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qqZkFLxIjBYPLChcZ902hM1Fuurdl6X1JYjQjjQ74VnQE0sCTnYkePtPhuH?=
 =?us-ascii?Q?+JamO+9kpP7yprF7jjh2DSswc7ec1V/FipEf8rsOerR63nibpkv1Gce9ogfR?=
 =?us-ascii?Q?Cl4hCYyZU2F02q6qvpwg9mVr4saSyu2HsYmdaMtO2ovXpjPojipSvYMo34v7?=
 =?us-ascii?Q?/rCypv+fh2Hiv2oScpmGwbPhiQcw9x77aibXlidDecWHCdCSPG1X9gYZ06h7?=
 =?us-ascii?Q?/fWfRTAJSKwAjYx6AzLqI6FgZqJEPkc1iv6v6F1nMYOm3EvenvNleXD8sNZW?=
 =?us-ascii?Q?3KjaVUDwR/VRwBRTxyPEDOSfJi0OaOGQGWQ5aO8CMcttLRFW4VhLHw+Ddw6d?=
 =?us-ascii?Q?nhQeN4n4MrEq0OH39yP5Edu3PGwfjv/n+HLd5EsulKDVICmsuDmadG97fS/3?=
 =?us-ascii?Q?1aeJBbR0DRIEP/Bw9kwm/paW2w84Q9sPICvaExwZBgZiY1FXE6L1Um/7G2DH?=
 =?us-ascii?Q?SJDpXTDDZrMaIoEw1iqO5LHMXFZSkhaYdLv4OQ567QHH6RE4S8RIOkG0IulX?=
 =?us-ascii?Q?dFh0d4WcrjtSVCl3uoJCdaXB1jrjOyjLnyXv5m526aFOuBv8ypJJBLIM965l?=
 =?us-ascii?Q?M8clDO/jTpIOpHTdK45XRGMzd20Q7N3/9RRXiBfS8/2sZpv3VN+YfK7/HOpd?=
 =?us-ascii?Q?dIGkXB5YHM6hOey7WbV33NrU+ePHFXJ/Iq0LpIVjEc/U4HPOa9BiQKP+jiBi?=
 =?us-ascii?Q?pcDp05OkUmpFDnOwLp4t6Y5W3+Lc7/RJOZEB/Bq325P5BXs41zpYb92IDzWd?=
 =?us-ascii?Q?hxk3PbmAc59HkCw0DoIY1GQMKYSTbWqSCXWOxy+2KaaALsaAHWMiwQPFPX8v?=
 =?us-ascii?Q?/S6lyrDcRoK8NtWZNU+Nqh//53G0DNRe0ioKBD74mY8C4LL3//rXOoIHgW41?=
 =?us-ascii?Q?+EsgV9IBteqK6kBiug/xCIk1JjaUyQbjismhwHtkDyi499fUmTEV4AvaPhjE?=
 =?us-ascii?Q?NIeH5sRIs6Lsq4F6QIglPidoE18LUw1uE5G8n+IwIyvrmUzffVZypYZgXu1+?=
 =?us-ascii?Q?cyEWlkHyHiTp99Q5/RjY6HKkeJ23w3rzcTWuLoccTEOy414FLyWbxDoEATfW?=
 =?us-ascii?Q?Zj/dDaVpMirbygQNSX59B1dO7hSEF5f3Jtaime9KgoCOXzW6UOvjTGBzDFr9?=
 =?us-ascii?Q?/E39mhxPVJY73gnL+KP63vPlRCnmKDYsQAAmVUQ5VApdAyt+sPeqbQXx3C3H?=
 =?us-ascii?Q?fAyK2LfTCCDDMftJPdNOhCpAQ9c/gzKBA3R2rHNJeEBkAEK0ibxDokDJplkW?=
 =?us-ascii?Q?FLHAq8Ewc7kXPo9qxl1+jN7H2f5HzArbYd6vq/RAgHO3yyaZBge1QAS9KFc2?=
 =?us-ascii?Q?hWdlzAV+hJDA3Uljg9pFLBDAMwNX3x/tRoeyUo/wMiiRk3ODQeaZO1VbdyOX?=
 =?us-ascii?Q?5PH+D2GT4FcmuOSwuD6UoG1qpc5b71DAwMGg9UwUkT/vmDaBIlc4vJc9XWFy?=
 =?us-ascii?Q?gy3mHMbpudmmHvFNLO4wnhAHGJw18oOHedQoxZ8POkKjpdrI1p7O+/zoMtbb?=
 =?us-ascii?Q?2UHUcu1Uis1KqwBA0GZ1kB5otKPVsMMdtFj60dVzTINgxgiNJvPXNlqA9ypV?=
 =?us-ascii?Q?WSgyalNihUNfmvCF5op+0mvnzsmeuWm9DMhUKhHDPfH8rBmI9LZ041Is0Odf?=
 =?us-ascii?Q?Ry0q1/H9b7Ee7jvjgfgglZo=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc5af48-f3fe-46ca-3850-08d9ed0003a4
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:16.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntbwzX3+Vrxw2mf8q3HmLOSUfc7WVUh1zpNvJ5J4b/FH3PcAf38ow2zkrCAOU7FvZ4Nc+Hs4MBfxrtmXwqpt5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add INA230 node on each sled base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 76c086ea7b71..8c8fbfcbb257 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -249,7 +249,11 @@
 
 &i2c0 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -315,7 +319,11 @@
 
 &i2c1 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -385,7 +393,11 @@
 
 &i2c2 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -451,7 +463,11 @@
 
 &i2c3 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -517,7 +533,11 @@
 
 &i2c4 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
@@ -583,7 +603,11 @@
 
 &i2c5 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230@45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023@40 {
 		compatible = "mps,mp5023";
-- 
2.17.1

