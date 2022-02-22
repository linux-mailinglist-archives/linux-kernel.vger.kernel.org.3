Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B54C006F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiBVRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiBVRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:50:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648B15FCBF;
        Tue, 22 Feb 2022 09:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+hFlI0Eg70iJW8T8vMziIz9ZFDNZgDl3rAAUpIybltoHqkckNf48vWUcr3hHpl1HDv6fnjvrmlTBHt5I3KxI8M/u+u7oSyyunKSceQTNntvk7GtY+xCb1Uz7j1hAzvnYPb7WFB9pw39T0oGGigiv52L/UOe669XS+Q0YG4GeF2coeun39Q7DDhMOfVVrt2u0Pnc98qH5Ew7i9rgDTBYozxz3PMgSNjlIp71R3vnB706srVvEttJ3WTe7aA40v2PftDqR2kiQTZQQ2EOoAlKXz8S+wnzxKvdbRp43uk3mr9NpLdHbooAefQ1E9QJuz+ZUOH1WfjXmEiW3+yLmE/YKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnJWxjD6QlsPRLzUzk/FWJSgCWgArQNDv9ALFcw/Dzc=;
 b=jMUXJcDs1SppMUg/yWz8LxkqKHBIaFzMWzcJKT+JuCk3gWSCIAD22xJ2NahTJbM3UEAxFyHUPyi+Ov44lUXpkw68nJtL6TqZqzFuxeKPMq9JfAMUAndeAu4Tl7JLK8UZocS+mwKMYL5duNGvlFKWd67hQRHWC9siCji/y97lh57wIfjLi4S9420pPGeYq+MogvMEvIp4X4xucYkhXkBZsD0uwmMHpL4PKsMkUjC5GckVS1AXxfV1AZBo0oPb2xzyP3tb58G2PZxQU+63Thq9BeEfKHAn07KQ6bIBmQG98gUaFWxI8cDlxgfHdddL5hbADdyIPGc6NvNFnPL2ma0BUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnJWxjD6QlsPRLzUzk/FWJSgCWgArQNDv9ALFcw/Dzc=;
 b=S/wB3gD/9WntG3oPp5MAucqWa5GmhmL2TOBjB2xvrYxuaETmpfhcGKyM4FFfcRimc/FdDQgNxC+9lMx4q8CvfcFGnOgj/wxHFuwCvw4cMuD6+4hnK+fE1vGL+jlhGoexCe67fbe22XxE6MkQOm0W5rdSTqdr1SKFq3hMQdJMiOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DU0PR08MB7485.eurprd08.prod.outlook.com (2603:10a6:10:355::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 17:50:15 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:50:14 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, frank-w@public-files.de
Subject: [PATCH 1/2] arm64: dts: rockchip: enable work led on rk3568-evb1
Date:   Tue, 22 Feb 2022 18:50:03 +0100
Message-Id: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d87d415-1fb5-4f01-25ef-08d9f62bc7b3
X-MS-TrafficTypeDiagnostic: DU0PR08MB7485:EE_
X-Microsoft-Antispam-PRVS: <DU0PR08MB748525993F4DF76FD88FD76AF23B9@DU0PR08MB7485.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7blQFLvLxTwQOZthcMVbBK8nNj/vINr9uRsDxUR7hNQgJOgSlwB1x4X8/edD0MkvvLXi6s8j+eyUAR31s2I4DOmPd5xmOQpmj55PFakuvqO3neUh2TDvMFthAWqV/N20klezz9f600QKkMI0U+i5oecmTj5agt7cZlautsU8nzJ2g8qMxrI6dajb6qVrP8NFI9H1SgY+DHOVFXJylsORJXysCYXb9TVs2TO7BO9n5RCjJqX8OzvH0HTfwFia7ypjn1XQS+2QAiFe0BRvPqd5cMs600yWQvDm4o5mIV+Pnbru0Bfg0Ua00fryYsSYJQv+94suXbaSL3Dy5tpu97OPDKcWxcjyct3AghQQsTdW0TZDTNATlphYeMOQswFoXiIW0OOsuDXtgvDxsmDsSWlexJJ8Ry2O181cbXsYgBSbQRUXP5keQCIzScnkAcA+I/FW/yUlV4I9U/B+bhDCmX31G8TJQffhn/LwL/IGGYuhXpdfcT5kWJvQ2fpyLJn3uPKL0T91FmRVoZM74ZA+sqMaig5HCuYPjMQSzFViewKCcXGRbHpWNsLhmkZ+kweEA9ssh1SugCAJoYYO0JFw/8dAwISjGUi8ORZq4Fsgt65djdqzALojRgOWSkNB+95wSOHNApZVsSCMrXaEa+WpMN0Khg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(39830400003)(376002)(396003)(366004)(136003)(186003)(8676002)(4326008)(54906003)(6506007)(2906002)(2616005)(316002)(38100700002)(5660300002)(6512007)(66476007)(1076003)(66556008)(66946007)(44832011)(6486002)(6666004)(8936002)(36756003)(508600001)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlFlFoZqABBrBmvhMdZpQS9ykdrV2/jRjFszQcWjTStLxb4NSCh5vUOUYZwQ?=
 =?us-ascii?Q?dGhqxjqO6g6zH4MYXkqx1T98U++YKPA8UUM4seA2xOwoOi+RU/eJlxEDi/Rp?=
 =?us-ascii?Q?dYKog5HVYNr8OkqBOQKohRMjzXEjKMU4+PfyI9xKqWRIJ5khg9nZQp0vUZqa?=
 =?us-ascii?Q?z1RWccssvBobdd8ksNH6CrIzRgLBMIZ6Q21ZfnjSm9o1zMJF81S1+ZN+JsNc?=
 =?us-ascii?Q?lGSkR9wXL2KuHk6pv8iOXUb2Rm/ou3Tmefz+qP5aoaVmGw3bWnlpRoUMCkX6?=
 =?us-ascii?Q?YtNSWlNvhmp0FfarMZTm5qCxntujuQif7whX6tYaCA0hadc0hk/WrS7YRskv?=
 =?us-ascii?Q?Dj1QlG++Db3PEvkUyl8pF/ZZdpELLn4r3HaLJaMZFGf1dgMQ6V65P6zgU6LF?=
 =?us-ascii?Q?EQA/oJWPPXajy/gXDCi5pHX7ECxeCvYuKMN9CJ0FBPdkS3iDMOwvVrLroDvS?=
 =?us-ascii?Q?D8BgLzKAIvzzskCIFPFu57DMrM1fMTSE6Lzd1JJ5ZgcbDMMa0wi16pdksmJS?=
 =?us-ascii?Q?PUbtJAB4JHI/v+whbJ99iem1sBoEBO/GoO37dryou0iDnEvRY7Ox7DbVf/4Y?=
 =?us-ascii?Q?rBC2zqX7IC8s2gKuzX/GpmdGphf3R7W7cA6XPvTb6m7qXuV42Ni4ZFN1NGrH?=
 =?us-ascii?Q?mDQvF+1La5jU3OfB2dtUIY/WziK9fyhjxDve4FIiq8FhV4IwnzeR0yQaclGt?=
 =?us-ascii?Q?1BlmB6q4y/dosC74eniG0IZ1em0IeiGFYpQnpaehLY51LuKBq2uIDGK8AcwI?=
 =?us-ascii?Q?cuXKaRPWLy0oUExrS4Ov9rhVmrxecwiHvFCMSDZeRWDMffZ02KyFx5MjxPek?=
 =?us-ascii?Q?YW/MqbxS7tCpccFHdHkTHBFRkL/mZ4cgtRuV3bLn54hDC9zqx04IhemsPX2j?=
 =?us-ascii?Q?AuZOE/TgNLKSqN21FbFwyvpg/KADSWvhnOqbO2yhpYHgY2nOfEEVoV+AmscZ?=
 =?us-ascii?Q?mMNoEUtRh6DkqC4LtSqwIAV8d1BKaSqBULXa8XvKrp4rJE0GRASkzJpB76Bg?=
 =?us-ascii?Q?mb2dRZaJXd0CIea1B6HvLf+uOcbGmaV130Mc8Tb4li9dWHt7L8ccBp4BgG1l?=
 =?us-ascii?Q?SLT6oxlxumqo07kuTI0IrpQCNbOboQf4E+bgMNNuWVA7FE2bZq/XC21fWy3k?=
 =?us-ascii?Q?6OY3o3vvUWwsZ7arxd5QWwFBYX2DdB+nZBvcas4Ik4zN6MitFsWdOClZmxh2?=
 =?us-ascii?Q?amshE1vzMVe6GqqPy65xJmo/EhsPddexRfxoia9iooB1gP0yRktqPmz1/RER?=
 =?us-ascii?Q?JRSJ9DSlJESnGXkWvtcmEvbMA+bSr5ejT3jHHc9KOUayA1x9ZxM1yMCYcb5J?=
 =?us-ascii?Q?JURPBBl22Y/L505tiZxh6u6O4USE3EzIUStS6hmer04qi9ljr+DRLxGMNKKh?=
 =?us-ascii?Q?fLqLHZNb9CWjRXP8zIem6cPADFvV2w1wRR91OIUhjnlBTuSbcIUDOtCHuMs8?=
 =?us-ascii?Q?ogZa9fl3HTq7BClAJXTV+bKQiyu0AtYAonAyp3IQyA+lDClAMkFQN6VQavc8?=
 =?us-ascii?Q?S97aHO4agfMHz+0vxo3sql2UsI0BFNro3Io2bAGUTi4VI2nBFS0f5gQ62zb8?=
 =?us-ascii?Q?dgJpr/Ly65rmFV2yk/VPsiSBLJPjKnxk3AKhf2oiaOQD78hpLzZnEdjW5BUo?=
 =?us-ascii?Q?NJv9vvsZJvH0y6SpZQHhLXkirRPW1tLC/DPARiT0zFnV1h7wPSi82ULwGvGj?=
 =?us-ascii?Q?2e8iK/kd+U5UfYVvNWHfzcigAEcdACEmXoGhIVC5KdIebQHb88wRfX79uxIP?=
 =?us-ascii?Q?9FXpk23ttQ=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d87d415-1fb5-4f01-25ef-08d9f62bc7b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:50:14.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIWU3aPRduKqEtFwcT///rcavWFu0KmLoA1x6xe8R/5lwUhQ0h0+XBg/g9olHirOIkTkj1yK31u/NPNi8wMJ4atwEjIqZcrh7DR6xpFKQUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7485
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the blue work LED on the Rockchip RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 39c495ff0157..aaf7b4bed24b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -33,6 +33,18 @@ dc_12v: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led_work: led-work {
+			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
+			label = "led_work";
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&led_work_en>;
+		};
+	};
+
 	vcc3v3_sys: vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
@@ -404,6 +416,12 @@ vcc3v3_lcd1_n_en: vcc3v3_lcd1_n_en {
 		};
 	};
 
+	leds {
+		led_work_en: led_work_en {
+			rockchip,pins = <0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int: pmic_int {
 			rockchip,pins =
-- 
2.30.2

