Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB84B40D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 05:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiBNE0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 23:26:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiBNE0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 23:26:15 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0C4F9CA;
        Sun, 13 Feb 2022 20:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfUJWg6tYOnUZWeTtjO9mM5nCoOcsnZpC+7YHgJJhw5TsKc02sx8u0qx6gYNsv1f5LkJe8a223YzJAZ6ImP/FtZE4aLRdavdEeNRKHT/WGySjEwe61ZRp2Au2iWSYb/QQm63aRfrmSCCGzibnmEk2TB2l2z4UB5pHXHlOyZvEI9/cKjMEik9h11y7rdqJZUhC97kZBTSvHchXausbparesii6auFPJuzoGKO8QinywDpOXozQWmWQFnL0hDXDD1DSySUOchg33UIIXrN3QFWzqnMyQiIR6KVWdB8drPIbHbyIhRpZLRZLKyRKXTVNRM2jX5BqpHjYehchm70wKUA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPOUxLPkgIHvneNPO+vh1qiWCiUwAAPBBO5un89I9W4=;
 b=Tti4wMMF+U4XynzENLGUzc0/up6XeArMOIVa43a8Ru64WoMLB7RL+7JvaV6yhf3xQGzK3HmLVvWYlrmaG0Z07YGGtaRn/WvVa0phDOy2dxCso3KhFLzsUe7ux5kVkkY+XsNAuaixQoWG8Vb3QQ637WBUoBIhvTCQqE8XtpC7baAMtq+LNMu9e07GMYgPzA1X6S1kFTo5oJMPh1LJaRF5qk6cJbqm4Loiy9ZFWzSnWJFA5kCcCNKDOtoi3I7/WAmUSCV3uWEEYw4wY15qKMhRT3+iVo4TJi2lIJN4XRF66pCO+RcW2kIRznBPPjdDksTg/gpaTpBAIJoQC74zxXLQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPOUxLPkgIHvneNPO+vh1qiWCiUwAAPBBO5un89I9W4=;
 b=12mIa43NRANrnkrzbxxadl7tCFDP1JERbTJ6CmJ83gZIrnVn3KintfXr6Ukf6r6QpxQw0ApHCnYvb+sBo0+vfDd+tGGiuDw9eyNTWO4qQVUOzDY5TszPD1gWGgIqJsBD1w1ITe23yn1hvMSswNcllmG70bmyAJECAtwzFG69HFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2451.apcprd04.prod.outlook.com (2603:1096:203:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 04:26:03 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:26:02 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 10/10] arch: arm: dts: bletchley: cleanup redundant nodes
Date:   Mon, 14 Feb 2022 12:25:38 +0800
Message-Id: <20220214042538.12132-11-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef025740-7972-4aeb-b547-08d9ef721c1b
X-MS-TrafficTypeDiagnostic: HK0PR04MB2451:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB24512A1F6C11D52B5B216A448E339@HK0PR04MB2451.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ngTYyZ/eZaTT3IyntEJ2clPLykFizd6nnJXPn8HTUVQbEPqVo655R1e2ZXYJuUt1Q0SJMcTP6Od7EyoXM/imjYKxICv7jSuH3pr0+z3HGn3aeXqC0GtSjh+hV3cuXnmqIc6Nu7+6qVIVoTFAc3NU4dXW4uofMeL+647smADdhzyWl8a95g6pmWcNNyjReEs+yQ6PiFsE0J4nddArLCxRBgO8q8DEhuxMYeGqekklqxKNgLcokGIk0A6Rfh4eNb56Vgr1vYEbR02/92HeyKl4T2TNrLjOlf8vsSBB10Nu8HvQV1MRpPWuyT07kHxSXEk8WnkBsdrQOV2KuzE4d23ksHk9B/SfugLVu4oPF+8f5fdlRffIrXJeAiyYvSeZmsKfVHV4I+Q9xVP7z3kkgNw7BL+KKMPEzDs5yKvwCBhz48UREQSgg9qCaJe+KYm0EZ9XHx0uxpwuWlMklTlb9I4mT0iXUGWOBoepeccUDKN36FXECuvr4gQaImgYBHwNXZVq2fiQVQf4dSMe9DHhMs7HB0yeL/o4KYMms8FqPlx581Is6ONipXWJg3/bIe65eullvrbCTMbbV7VkGnO2SCKvsNGxmteilH9j6G/+9Fk8hVbqoCfVeLvGHE/Yox9c8b3QCgt2xRZz637GePhf+FHsLjZ7E8A8jSWlXyt+P/MwH14cLpcARZRWQW20kJdNsDJY+YseYweprp5DqV3gL0ImA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(52116002)(6506007)(36756003)(5660300002)(4744005)(38100700002)(38350700002)(6486002)(4326008)(8676002)(83380400001)(6666004)(66556008)(66476007)(86362001)(66946007)(186003)(26005)(107886003)(54906003)(2616005)(110136005)(1076003)(508600001)(8936002)(6512007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNMNtKy297hY22UhFROzzmXn83kDs6qt8S3yMBc1mBHw5eGT51Urv3oRdaDe?=
 =?us-ascii?Q?aDkQUyYt9G5ouRVMVCpRlRuo47ktRgk9G28k504ZImGmx3+Uj3AZUK0ge75t?=
 =?us-ascii?Q?5mmhOAcLPZ8qT+Z9GuHiNoHLxE+P78dSR5Crd81zGw4+00wsA7vy4NJ0IbOy?=
 =?us-ascii?Q?08GPoGJ3QNz8WEhVkexWGkQ2Kv/G1YJoZS0bJERWoJPD33SV4Yg/gOrb/4FM?=
 =?us-ascii?Q?XanpYBriWXElEdE2hRSDkemCxVg5hPsS0ui/uu54PW0SDzFEgUHYTmN3EbkV?=
 =?us-ascii?Q?ahjnTj9UjZpJnMNlnRs9Vr8MpVdPkiCvVOuomMy41HuXQgPcs9yZceGFyaXb?=
 =?us-ascii?Q?teBqeQuNMzbozHfuoHko/68c8g1IcIY2UWIk2/VcikCf3xkVDGVXwp1V7AGr?=
 =?us-ascii?Q?BJNzPtaoFYO9CvKtA6rgwv8eZ75JfVSJe90WBPiafJ2qoLJ134Wj8Wv62g8f?=
 =?us-ascii?Q?CQZMTtlIL8ExEnPGCUQenNVO9yHQItardZrHDLcdy1XbsbuNmSjCz7151vXz?=
 =?us-ascii?Q?zgs7FTE/sJ60ajZXs82dm6vcLuYttnA2PCDmKUGiRgUh97Yi/cFc7gUp5dWv?=
 =?us-ascii?Q?rECGSUjMWHegTFa/rYHVkHKKDAJglgzLHDgbcIs048+WSbvRX7eXo4YBD+fJ?=
 =?us-ascii?Q?x9eEzqW3N+CfdiRAOhWFSgH0hmU48ZjEk7V89sIGhqazWD/DODGYdo99C8Qw?=
 =?us-ascii?Q?ReIwljSAAtNPExK1LGpFwc0CYWin5t6BPluq5jSugKago0lSUzF/EhfksTqM?=
 =?us-ascii?Q?vnsb2ZAw6bASjoeyUh5Ao1AWuTEZO4T81SEeaFUX+e90x3+qTtVRPshRENOX?=
 =?us-ascii?Q?YmcCbv5q0fIHNhrFaAHXqMwmzQ9iHjVVwFn/vlmA2ZYp3zOgDh19YRLCN7CR?=
 =?us-ascii?Q?ew5pE4NzZcFRHTmUgikYXV0y5kOahxi+x/kYWxlUFw4V88RAMqruaXbolfB2?=
 =?us-ascii?Q?/aL8PX0vx2kr39Ii1dhDWBCmHrYEysI8i6mOjoRa1a6WQBrVAupC+Rix98ZI?=
 =?us-ascii?Q?RgZEdA5doHJQQmkBZpQmZmUxG+oTt5mZThxZtZNtz37Ufh1927D4nUzFrRBx?=
 =?us-ascii?Q?hxFxydTeTgbMGj34HGSKrvoVnSTlj/wSqsVm3bZpJQ9orzg44WeOnXLz/e+/?=
 =?us-ascii?Q?uRT39vy1/ypa35ZghKm4gZAE/px2zSeGWTcW4p0JkeskjqhntX+r5Cj3Xqhb?=
 =?us-ascii?Q?JFit8+qpf/j7Hap4kASUbTDB+UHFRBBRt6mYwuHCQUp+iZw1j0YnsSgNSvIc?=
 =?us-ascii?Q?OquUOlQu71AHFrkjKbFH9xxX9t04aS0eHgVEHTMwMQwQk59loRspYdX7uShn?=
 =?us-ascii?Q?ye4GOx4AumIpXRzX2Y8Em4t0w2z0uVGCbY5J9RznB+dz2lRLKOs76gFvIbQU?=
 =?us-ascii?Q?hSzDmpcsc4R2tv7RuKYy+tY5o1VSL5Nsx/kB+IjKIEwispcVgoo9lAdeo0s0?=
 =?us-ascii?Q?VZ2sv1OFHXaemJF4tlUbsnTFCjf1xRDF3BU7nu6YSz8rY7T5HoflGqBKh6RR?=
 =?us-ascii?Q?DNtZoBe08BWzE1jHYuUtrxDHs4h59k7frrYhDhHX0RuL7bArQlgGXgmCZ6kk?=
 =?us-ascii?Q?PeHluz0V56q1DMXNUdhPOlzU8W+CbK86yx1LeG+0ehNjeSZbnIGM7YqbRa24?=
 =?us-ascii?Q?zePFB6bqmZQNWwWP7VQVDow=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef025740-7972-4aeb-b547-08d9ef721c1b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 04:26:02.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i949kmg1hdX89zlHW3mNSxLjB1pnZ8urrW4MJmpLTjAfwkSe6mUyfNHmMRGXs10Ki90KcGMkeuxhnHcqsUBWGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup following nodes

1. Remove redundant i2c1 node.
2. Disable in-chip rtc, use battery-backed external rtc (pcf85263)
   instead.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 946107bd8bc7..52201c6a69bc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -205,10 +205,6 @@
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &fmc {
 	status = "okay";
 	flash@0 {
@@ -387,10 +383,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-};
-
 &i2c2 {
 	status = "okay";
 	ina230@45 {
@@ -680,6 +672,7 @@
 	};
 
 	rtc@51 {
+		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
 		reg = <0x51>;
 	};
-- 
2.17.1

