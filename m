Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1722C50BCB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378014AbiDVQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377448AbiDVQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:15:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2064.outbound.protection.outlook.com [40.92.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4F5E17D;
        Fri, 22 Apr 2022 09:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR1VQ9HarPAQGINKnH+JY+ZuXMg5uWENxmn8VH9YsHBniirmW8xgcCxET4YBDgQDc86ip8bzESDeuhBpo8SlkgVZl7d++0/2coNINMQs5qVA28dd8CpC2WgzBJ8XKTiOoJ6Y5rTdpBa7OHBahlvm+m0HOLW2mTUqbcbNIgEwFNWdtvjCrKMIERfF8iKhtMSlb7XIuvH5IOfd3AeI/86WKVE38sYjohvyWYF+H2nW+98WR8Xo6myNZYl1DGdogKvWQH0+E4xCvSnFAbxRq+VWNv8fcj0lD2w3sV4CM1wVKy+4WciBquhrj/77s13rg1Ov2GWQHclK2H8nKLaRx0tCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAF2HdcjwCdgr2Kjx5dH8Vy5izGEjjHNh8wXWPDzMX8=;
 b=bjnSbhjA8Ik5QVoEgMTghqKNEvEl7PM8ejRzOiQZ2FXsdDrig9w2LM9t9X0L3E7pu2Bra6GNAeiqkZdCASJJCZazPS/XaO6Q550LvidvLZ8MzFY/9UVVgRtQC+NAzQwchD36TZechXmjV1Rp/+XjLCRFcic6w5ZhnD0YcPZk89YyA5b2pbHHOhNKGZnP0o1G1tl/uVc5d/rTQAyQz0H0koUOFBTfFFpB/7bYEOI34RI9mplvdqXydb+Sccyw66ME4R7yP49TuJdKlfrqMMCG9qjdXrkHUbtRBYWgJ/5ogo8Odu/LWzFjC2cMOD7EHS4PbbN3o0T6dvw69qvq313TIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAF2HdcjwCdgr2Kjx5dH8Vy5izGEjjHNh8wXWPDzMX8=;
 b=sjo0urha1p/LmfTjCmyp1lwsPfyFYpse2gulcjalwPTzgAJbWxZJUsOK2dzswhocxDvo+fjqyMkU+GLd2XjkJ2S0SrJMzp9AHzy9PmnC/0IChW1Bt8kDJg7CA704BFrPXNn+leUijm5nKrPawwCfm8Jy9sBtxYyNH9efbMDldafO7Qlly88QwxNJpoIVDVImupawj0XVWVwnv9HPzxkl3ISOTtJibgZzKKzV/KUzjV07AHxMAB7s7/u6FB/ZgrlPa12uKPZ65XPDSap0TTbwKMAtobGgj99FVMsZm4MapMs/J0U3bfVZWEnSU4d+8NNiHOYZrLox9hovfeoWRAmJng==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CH0PR20MB3756.namprd20.prod.outlook.com (2603:10b6:610:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:12:20 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:12:20 +0000
From:   icenowy@outlook.com
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] thermal: sun8i: add R329 THS
Date:   Sat, 23 Apr 2022 00:11:56 +0800
Message-ID: <BYAPR20MB24720C488FD2BB42038D9825BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422161156.1075227-1-icenowy@outlook.com>
References: <20220422161156.1075227-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [WXW8Gh6Z9bVddR2G2K6RciEf6Wd9n7y7]
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422161156.1075227-2-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7522bf6c-8989-4284-9a98-08da247ae073
X-MS-TrafficTypeDiagnostic: CH0PR20MB3756:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAHSy0aOhD+05ROBRr7bAgh5UG65RCpjH6xECWk/ERIEfLL4GD5OvDtnv4flQTINTbBoLtQoog6qOc9E9nsTvZGdHq1D4A42WKcXUWwzBxU6eXFFJ1m8CEtMSADhN+Bqs/DxAfOhmmwr3XqYDLsF8hBP3IcK1d1y73/MRIfgW7zHrkrFNulN0XrFD8VAWMEsL1o9C72j/xhBGW8VQBfnMg9zSz2cNXnSgwis0WbXShCBbDnEigWMdBAMzZwazmP1xtVWWtiAOS8tBVnW1lgQhM+kQ7usYhJDiJqjwQRinOpUgTKGa5LjRYCz360tzGQLTBZUHL1BwEE+Q1y+i+PYryeCCufPmENz5nko9N/FADNy9BcpQ75qHvJkGnt7si7l1d/605AQ0MTWKhfRDi5z4Qwe4z0ZYzT1OyE8DbWuoAJF7vMKheNhUeQaMPo29nqoUiKliLcf4gqtFdeT/CZ9VaOEsFrTDMY6dNNIsRpwWwryye73R3GiSNWUzc77D29Q9FKoZzJKr0BZFJ6/1Zjl5XYzRLfmvBaJzMa1tLbj6ArPdtBdiQFCxP7i1D0eAqwq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Ca7uRx60amJK+RTEjSZkfHumnkaxpXfoa+JKDeV7n6+V+gwf6jts+lMCVHL?=
 =?us-ascii?Q?96IqS5WUtOQSm+/BzW0kDMXqBV2rdRBrO6jOtdeAyEjobOH3YWvkIc7o4OuX?=
 =?us-ascii?Q?m7rvYz9UBX1z2sekm3DmyJQfK9TrsSoLIWjhI7G8UFq+Qs7yE9388ROYWDGJ?=
 =?us-ascii?Q?JDSLCilGlTAISUrSBcZ2RUBhAyb28YgTDrLCQAzkuF+eyn3/0Hk3ENRgjaV/?=
 =?us-ascii?Q?ehCtSot0rzHoBXv0WlW3FFkdPJgsKA37V10AP6Jqa3UZnm32D0mQKJt4ibjw?=
 =?us-ascii?Q?qOM1TJR1IirXNNs9JcE4mict1T7M2MtidQLOSw7HWs/vbjHTpQVXjkHi8T5c?=
 =?us-ascii?Q?ipQk4B1b1yhf08yq0VMg3V6BxmKqsADQWiUUwCTljgdZh9izSdjIAsYbNkV7?=
 =?us-ascii?Q?02NAK6yiNme3VENbOrHQsg2x4ql2jEZwXu0KItqkeB3tJ8aEhIiL0x5i2QnV?=
 =?us-ascii?Q?B0TYRehnYuua97BU2tkqqL318iChPz3boYxoK+/5j2OShVvsDckNOur6Pf1k?=
 =?us-ascii?Q?KZntEwaaM0ZQ7MQs8EDI2Hoo+U62S9YCJk8bNr8Jx5otXvcDqCRDUdXTiTnO?=
 =?us-ascii?Q?vfXQP0vB/BML92HWoJuKRrZgp6aUjJu0cag683+wqRDCXSIlo2nV9Wp1NQa8?=
 =?us-ascii?Q?G4SCzYleQb3CD5OvFQRdudU5TBsUshxTdc5enUWLz4iBoa89sWZuZBK2TZCY?=
 =?us-ascii?Q?zQC6X7gYjd3mwiSk46HIRQX8cNpXIDr9nDyD8XS0nXISK2V01kVb2Krq8CQI?=
 =?us-ascii?Q?NrCLLjIsntY+NnZpPLYhIEjnejKCRN2vvkg2hY+87YMhCdFo+lx/B2nFt7Cs?=
 =?us-ascii?Q?sIHJtsOMAU/1ftvNYYIfXa5XHU22juyEOTwKGNmwMvhSOUe3BFIEP5wXdp0A?=
 =?us-ascii?Q?VAVJ+EoaNJHFBRq+5q/J9nUuScklK9XWbDGPGTknKUp6v/tWiK85vp0tKgu4?=
 =?us-ascii?Q?rEFqYuoqQFZlyb6DU6S/22/XVtPrIbfZOr7EVF303dyPAD7fMJVtDTzDdTQv?=
 =?us-ascii?Q?Hosa64FX8rLjT/6W3R8nppkPug92hPCDJeRQbCPLtm8J/0dOmjq1AIkOlpnt?=
 =?us-ascii?Q?x4Jcla8FIBQtrD7weq5wt1vVY/bd52EFxD/M8/XsShPHtyBJvikPntFmK7oj?=
 =?us-ascii?Q?SRMgCIstc2KObN1AXTJnlKl1NLPvcpSs56aQlBo02eNoRk/nAHbwvwOBrYcg?=
 =?us-ascii?Q?FFsXqhuSVJcmPypXHRCumm/xM9ohFWHLNCv/604Ab/kQ9aPHZbALAbwJpeOL?=
 =?us-ascii?Q?fiANvQk0rHOmgIHmG8e9mscBmSOjwIFp922jMbmUP9d1882dEARyxOr+HUoD?=
 =?us-ascii?Q?27h9IxAj6vMjc0US+WuQIa7URHFvbbU3bU7b1ZLYK5blEI+YEWtKRPmCzJcK?=
 =?us-ascii?Q?EuskXAOom5/35stLUsjinsMhKB5sJmAY4NVdt8dUEra64En49c4r8sIUVlJ7?=
 =?us-ascii?Q?HWeEAmlrYaw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7522bf6c-8989-4284-9a98-08da247ae073
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:12:19.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The thermal sensor controller on R329 is similar to the one on H6, but
with only one sensor. Calibration method is still unknown because no
calibration is implemented in BSP kernel, neither is it documented in
the user manual.

Add its support to sun8i-thermal driver. Calibrating it is now
prevented.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/thermal/sun8i_thermal.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..3a2f381005b4 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -312,7 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 		goto out;
 	}
 
-	tmdev->chip->calibrate(tmdev, caldata, callen);
+	if (tmdev->chip->calibrate)
+		tmdev->chip->calibrate(tmdev, caldata, callen);
 
 	kfree(caldata);
 out:
@@ -628,6 +629,17 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun50i_r329_ths = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.offset = 188744,
+	.scale = 672,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
+	{ .compatible = "allwinner,sun50i-r329-ths", .data = &sun50i_r329_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.35.1

