Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3094B72C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiBOQca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiBOQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A338AE62;
        Tue, 15 Feb 2022 08:32:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baQVzLOxVH4YHCal5vo0Isme+ehTgYg0ibIPBJqzI4W2ROYOBbZ5Pg0L/OEi4gZyj1TPa0xoAK7l2HrgN76asZOhO0PXm4Zkrz53vpk8/cY5pzPs+Lv+xX6Mw0jeYCA54Aofhps6W2SI/x1NToRTOep/rF9t3XjolTZjRFnKIGdf5MlnLMBMP7fGeT1X2yVANPrTGSKQLfQaQLTXptHDaYCuhHOv+2QcRnXTGvw+g36kO2/E1NdwzJEgD3kR1gJsuAXe1R7tRK5F3N2UF8bS3sBGNqhaZNO3jYU/+clPw5ckFGKnMDpVSENX4/qMv+JJMIonhjP0R+AEpnSJVK7oDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdUJBmwjU5W2iari+ueVI/TTp3sc1eWteK4je1O4ZtQ=;
 b=n0/GsvUvWnZADz2EkmXXBiVny0EoouN9DBnVBhBzpaKH9GorjLRa1PJfhGlhaLPBDTW45ywNd9iF3U/lzZgirtNZ1Hz7neU2djhs8aatLkbnhKLypH2s+Hx1GXVQyBbIqzEmSG1a6ZSIiPhlbKq4AOcbFib+8D1oZjbHSOYjSnevZvdGS1HRDlyw+Ql9To0ST09zQ0ZkcVUYecv4x02gVWS8300LHO02XFZ+DqdUCIzzYG2w+RXI7QHIiZTnA7iUZGv6cTevdi6IjgC6YoQNfo4U+7cldanMST/yPwma9XafelM/fQUr8vofZo96tgGH3i8LStYunzhPkcJ9MKGU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdUJBmwjU5W2iari+ueVI/TTp3sc1eWteK4je1O4ZtQ=;
 b=q2OlnbhSOjdeaMNto8/tk+a0ZI25J9LYhHMwOI9u3CqJ1GrhB6oIGRRqM8AcBsLiYsKrtIhlzxN/XovPjiiiwsv+6nU2Bqy+oopu9Sw5vpntdTsTNqYDuG1muHXgQx3Ep4VtKdXfgIlcnZUnQ3lILdKFDarlTO+stJTFFGhMWBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB4602.apcprd04.prod.outlook.com (2603:1096:4:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:32:06 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:06 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 03/10] ARM: dts: aspeed: bletchley: update gpio-line-names
Date:   Wed, 16 Feb 2022 00:31:44 +0800
Message-Id: <20220215163151.32252-4-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce76e88e-02ba-49e5-efa3-08d9f0a0b497
X-MS-TrafficTypeDiagnostic: SI2PR04MB4602:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB4602BFE43D2FB9200807543D8E349@SI2PR04MB4602.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ay68pfiQ6HVCz3xksXkWnJ+YgITGCBJYE97jxnoLHseglORMriSBGlmJDaipSeh6SWTxhP5hG+lwSUbRk80WvmyOen394x5QjojtwxPe/Qt74MaNonjErDCdiJSwiD1U1qr0DJyL7WRTsW/4oE7TmTJ/jlSw7T1rCt9NIjct/AOJ5xYwduiZIY/Kelemx2tb7MFjaUIq7HdQIHnyV1CPFzVjwJ7LPeYYjonnOzL3hhA7/8KjH5fhSwimd5yXIbHVXbtIbJ2rLmGpXdih+PdkZ9SBnV7OZShk+r2E0pDoXam0mh+vuT3eyjLfDi3/HSBfgPvmQ/HGbGSKMNKACL269fGuRJl0hjOqrJ4p4QvQ2K1AyFxq+Y48wlbHgu+9Stt8+BOmefElWnZ794FN6Wf/7Hn4ZRjFMquvzInXR2C/Ja309H1ZJmGJ1GXkIJ0qwzjIr43UU49mwWkH5zs1PjWoYFHcuxSIZGPOHdUJ0LSmvSsVbGFxZPQnMGZ2wKnf9sXNTAJ0ovVXgydQqiNqRU3PWxUYYENR8OsLnkIXFRZa6Lz2Kp9Dlz9YFQNSjnGGFLUMLRlubIH8w/7I8k3ckqzV5ohchKa4/v/MKXbQGxMCMMQutv0WoD2oNTMcKqDjpzs3NHXF5YjYZbub1ShIsjA/+GWIWNFot8r+FBY/z9waDEM3WsLMtCL9kQ7gf9YUA1gukcQo6SpxnIcoj6r3DIfPzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(26005)(186003)(2616005)(36756003)(107886003)(6666004)(6506007)(52116002)(6512007)(83380400001)(508600001)(5660300002)(54906003)(110136005)(8936002)(38100700002)(8676002)(44832011)(6486002)(86362001)(15650500001)(66946007)(4326008)(66476007)(66556008)(316002)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odWYwfBx8Am/AauT+WdawooSw2Uu2AwfGOeAJTi1iqUpLXP7WBtwIdOx0rxw?=
 =?us-ascii?Q?cXIPbthAe0FT4CkSl/lwatUFoqcfcCH1YnZnGUrlM+qFd8I/9V9xcqZHmyDN?=
 =?us-ascii?Q?Gb6PyQ03ShDdpux2Yr/EPuHEGscowKEsgM6M9FO9a+3M9ypnGgYO2MkSf62f?=
 =?us-ascii?Q?N5GvemhG7CYRKRfyCMwQNgjllqP9f/fxQv3+ajsbK5wROsM9L27QvZbKC8F+?=
 =?us-ascii?Q?cYKK4bEQ2sLgC+aQmxYhwB7xHLnjAiYJ3rwTAbc/4QGgGpykcwIga9iUcfix?=
 =?us-ascii?Q?nqiXWS4HAJJNn4AhRQt83JNGa0xPtcmViD9fH1Pgy92HP0Nl8JNdMwoqdBw5?=
 =?us-ascii?Q?nUFTnQn71zYrpuQ6IR6auGVwoBnBGGruhClaJktQnCCdi7NljbkPmEUKrjJ/?=
 =?us-ascii?Q?1YCqbYaR5ULIIuqNGaNeIhcMZ4ASY+f4h6yR8gKrzZPWew5cTgajMbu5beQU?=
 =?us-ascii?Q?TwJdow5jqCc5MHNH9rwCg/91ZVMcRx5D3Xk6Dsx0VQuqc5HTmTtkn5QNQsH5?=
 =?us-ascii?Q?nmXHVrIMMopTqytOzbAhof3CqrSihYBWq0Mt0TOV4t7eSPBi/TkJ8/1n1Nxu?=
 =?us-ascii?Q?drmsNsXPvqlgVUpLHmfMlesL62s5MUT9RzGC033oEqjnq1ZGst0rPoNZDW9z?=
 =?us-ascii?Q?4bHBlMBy6fe3kMGkDkdQ1IB09jbacpMNfdHxF4ajArereODVp6L3gD/anxHz?=
 =?us-ascii?Q?UvL6uPj7rp1KRvx7TpVOXQxC6cRwM4cz0dDp9FZKx7Q4RCrMjbpKQJk5d+L1?=
 =?us-ascii?Q?DSR/SWcoL2Woxg7jmOq9nD3S3Eo2njO7Aj1APIS36tGaT0tbjljqJG8guHJB?=
 =?us-ascii?Q?58HVtXxX3t8yXIDchodTU7WDJxq7u+rX1D227EH+znutyiULwF5Lu3X3kK/W?=
 =?us-ascii?Q?bv4xcapc2/zq2D8x08jhICF1B3pKYYAnYq5wQmJoWR3Oau5sTelRa38Brvtt?=
 =?us-ascii?Q?/YmNhV38fRJePU0sZugfrdhdo5YzzhzSmAJVyHPthIRTcx8FMBHYHMKS+kJ5?=
 =?us-ascii?Q?RdT4a8Ygs80zSEGE0dlAYUZy4Rfz51oFoBW2IMBd+ctHw57bmLGKig1BYMgN?=
 =?us-ascii?Q?CkprleiMotQY+Md3dfV+Yey92Oul2SAXGJGhxTCIIyyDs3xODvgjwmdkrXtG?=
 =?us-ascii?Q?ygJnc17SCpbHoLXtS576EXwh60BMJ7hJorf0UmCzvJFWC/6W2mgusJw7DeLt?=
 =?us-ascii?Q?+GWrjLcwwG7pAtvuhaVKrE0T8WRw3I8M+AFH3YabPI4A0MV+gknMLVGSqOWF?=
 =?us-ascii?Q?P3Pp+RvIesOyJ0cE4KPek69R7xsmY5HXaBoFAVUsY9pP/7E6A8DVJVcSQWgI?=
 =?us-ascii?Q?8GCNepr/Ya3/tigHe0Fal5n7J43N37z6mGOThhw7cPduoLps27OqOtdwCIxK?=
 =?us-ascii?Q?hhDocj/peDRTX+X9vEJt7Gx0+YgfjtgKZANIHsOjsornwtl9kQyWpmaySIpn?=
 =?us-ascii?Q?lw43lOroo90LcOC3jyq1Qv3yNRuk4Cs/PySuI35BALDoMtUoFdWFg7fb/SHj?=
 =?us-ascii?Q?812b08sNDBUdSbEiIIT7OxaIe1CTgr5O6sHQOliQKsE67VnOctNgX45rngi7?=
 =?us-ascii?Q?A6RZqV12UDzrzZZh4vF3RSCHg6iSeeFXUJxf4bPR2v7mXMfj7oww+4IIpPA/?=
 =?us-ascii?Q?85NGw7qY6m7RhtnyUoPCxBo=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76e88e-02ba-49e5-efa3-08d9f0a0b497
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:06.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH08aVSNb4x6T9SjqL9fCSXnu7x1uFEQ2g1TrB40WvtKV4BFLeaIjV5dHpxlFlTR1+hcAJbNPwNtG3Wn15cVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4602
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update gpio-line-names based on EVT HW schematic

- gpio0:
  - BSM_FRU_WP (G0, out)
  - PWRGD_P1V05_VDDCORE (G4, in)
  - PWRGD_P1V5_VDD (G5, in)
  - BSM_FLASH_WP_STATUS (I5, in)
  - BMC_TPM_PRES (I6, in)
  - BMC_RTC_INT (L5, in)
  - BMC_HEARTBEAT (P7, out)
  - PWRGD_CNS_PSU (V0, in)
  - PSU_PRSNT (V3, in)
  - BMC_SELF_HW_RST (Y0, out)
  - BSM_PRSNT (Y1, in)

- sled1_led pca9522:
  - SLED1_MD_REF_PWM (3, out)

- sled2_led pca9522:
  - SLED2_MD_REF_PWM (3, out)

- sled3_led pca9522:
  - SLED3_MD_REF_PWM (3, out)

- sled4_led pca9522:
  - SLED4_MD_REF_PWM (3, out)

- sled5_led pca9522:
  - SLED5_MD_REF_PWM (3, out)

- sled6_led pca9522:
  - SLED6_MD_REF_PWM (3, out)

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index ebd2430a3bdd..fc0690ccdb0a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -270,7 +270,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -333,7 +333,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -400,7 +400,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -463,7 +463,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -526,7 +526,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -589,7 +589,7 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
 		"","","","",
 		"","","","",
 		"","","","";
@@ -727,16 +727,17 @@
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
-	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
+	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
+			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
 			"presence-sled1","presence-sled2",
 			"presence-sled3","presence-sled4",
 			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
-			"","","","",
+			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
 	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
 			"ALERT_SLED3","ALERT_SLED4",
 			"ALERT_SLED5","ALERT_SLED6",
@@ -744,19 +745,20 @@
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","BAT_DETECT",
 			"BMC_BT_WP0","BMC_BT_WP1","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","RST_BMC_MVL","","",
+	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
 			"USB2_SEL0_A","USB2_SEL1_A",
 			"USB2_SEL0_B","USB2_SEL1_B",
 	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"","","BSM_FLASH_LATCH","","","","","",
+	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
+			"","","","",
 	/*Z0-Z7*/	"","","","","","","","";
 };
 
-- 
2.17.1

