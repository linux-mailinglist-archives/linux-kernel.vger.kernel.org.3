Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D455AFCA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiFZHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZHI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:08:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CE12AFD;
        Sun, 26 Jun 2022 00:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvwgAT12VIxEC6yXy0HUVqOst6Ef3FDiUNnM0y7cy1uLSgSGKlSBNw/kZRA1RzgXQhv0yX8qabMKyG5DlG/41/tp0paoS5xWf3I5OgqIDG7jZfgp1avYNa+zqKGkHDibUOeUfYOn63bZbFVi2NRUprXcf5FAgp8MfJJhnLeJXgO7hsyrsQnMOhdXg3DGbEltExiW3x6cUfFXPen1mijJ1Wbv2JbplcnU3cRoi/n612eHoS+BvtLSh/FAuvJdBzYsdmVaOgi7o0bigMJSw94yKP4a6kGLq8boZFCCfbIIiKFnd6UA15wrsNwkEar3nn/JYRR3bV13XVHb6zBZAcyutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoDfnd+22aIUj7ycGxpVSruq43gsFV8+98RJ/0uK10g=;
 b=FmgJbeN5SYWvci3Y0Y0AbcrhSv1qs66yk70ztZK8tQP/In02Owsniu8rp9loznqSpXtH879JGNGj7plsfZanprANh2bDcSsJhY6NBc0DxZ1VRvskC6adaYqM1mcpvJN7G6pMkORV9+K69P3CYca+uysUaG4zDvkGmlHf2tpRL9pk5LZ83AvufnIQcjPh4miTsB302WkhUFcRvIyapsV2UC1ve3BjHBE018AjtquDsyhAGlZ1OdLUIoI4+QR8nobUQqyxRrkHMLC1xM/Tfl9ZR6v2RFASfqnUXO97sGkRpLxSXTsfRVfIrOGtCg50u+lfkcOp4nUcQG1BwDBq49Zttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoDfnd+22aIUj7ycGxpVSruq43gsFV8+98RJ/0uK10g=;
 b=aiuyCrHVaj/YWP8ta3WcqvqhbnCwDAgM49GKE0ePpJXWTFluRIJXFXhbyqxInGi0nZIgDwEmRgM312nlzyzIwzMyUXBa+i+oB/SXj5yU6cRZYRHaMGz+fo9B9M9t3lyutIg/cnxWt2x6MDUOBaRApVvx0t5xeF+VppzvPlvJEvI=
Received: from BN6PR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:405:4c::12) by MWHPR02MB3261.namprd02.prod.outlook.com
 (2603:10b6:301:63::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sun, 26 Jun
 2022 07:08:53 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::1f) by BN6PR1201CA0002.outlook.office365.com
 (2603:10b6:405:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Sun, 26 Jun 2022 07:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 07:08:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 00:08:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 00:08:49 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 git@amd.com
Received: from [10.140.6.39] (port=59232 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o5MO1-00061W-1m; Sun, 26 Jun 2022 00:08:49 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V10 3/3] rtc: zynqmp: Add calibration set and get support
Date:   Sun, 26 Jun 2022 12:38:17 +0530
Message-ID: <20220626070817.3780977-3-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
References: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d0238b-2404-44ca-bfa5-08da5742ba17
X-MS-TrafficTypeDiagnostic: MWHPR02MB3261:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWhQoCcmO7OBv62R6ndeZtDjJW7PraZoZPAQpSNqNJnPzdjaupm4739WpXAX1pchWK1YkqMpmsbXAQIu/oRs1YYdAkY+3iWlYsDJn0z2kvA6eAGizM9m/1w/1tzm+HrSffc5GebDM5FODyd5WibLhS/DULaZYD5Vrt3QGVUDtTxVe3LiU6XKx9tg2kBgnJHcgVaIhHnEZucWrJ6Y10l7L0NxRhlPVV1pKM+S2CXmcdhTJVut9XSDconTw6Z4135/9yBKqvr9DnBsI8WIv9hibEzOxpvfrzeFD6+KHhjVokbwUAXzk4/CjRAvocYIxtP7TBr7nqJvgLU+oWBHHTUv7z1VDhjqZUtR/jYn+k9mACflRtNq1szidWsUo9Bixd8C/TwA+aLghQvR7S8eB03lReSsGLXkBoANRSVCzRH4xmYA2wFpLoy1gkNiOlVFK76VnosmiNGO71VR01Hf28LDn5Cq2Od8wk6+LIEkfvscf0JTYvXd1DlCUsi3DPQf6h2oHHGeVd5xt0xLckf/1XVTZ4i6kTu66tQso1SjqvYxGLAF5pcuSUo1QbmBv3AnYwSKACSZhr8wNk4VeK9zTKqcpcXU/s57nXfn66XJ7KWD5H+E10gnWIp8oGIk4Wu9QdyHOUYgHP6dWQFQSOCpabbqTNIn8m+AQ2CcCkmQPG++HXg2nFW83/d5oCeZbY6uNSkbPBf/i0vmR54Id1PxHDi5DGRcUaM55FF0buk17hpyhj4Ilp12BG/qeoz2W27DmDmnbbSADooKi6gjvrKxgdEvqo8vql2RqphG3Z8PMv9zAE0Vlqqi/xfZT16M00BvWQ8XZO62atcYYSPykcyADIq2Gpd88z+9faosGZpgIVMXaPo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(186003)(47076005)(70206006)(4326008)(40460700003)(70586007)(6666004)(107886003)(41300700001)(36860700001)(8676002)(83380400001)(356005)(336012)(1076003)(426003)(26005)(36756003)(2616005)(7636003)(478600001)(8936002)(9786002)(82310400005)(7696005)(7416002)(5660300002)(6636002)(110136005)(54906003)(316002)(2906002)(40480700001)(44832011)(82740400003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 07:08:52.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d0238b-2404-44ca-bfa5-08da5742ba17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zynqmp RTC controller has a calibration feature to compensate
time deviation due to input clock inaccuracy.
Set and get calibration API's are used for setting and getting
calibration value from the controller calibration register.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
Chanes in V10:
-None
Changes in V9:
-None
Changes in V8:
-None
Changes in V7:
-Removed calibration default value update from this patch.
Changes in V6:
-None
Changes in V5:
-None
Changes in V4:
-Updated MIN and MAX calibration values.
Changes in V3:
-Calculated tick_mult using crystal frequency.
-Calibration register updating based on crystal frequency in probe.
-Supressed MIN an MAX calibration values,Will send separate patch in future.
Changes in V2:
-Removed unused macro.
-Updated code with review comments.
---
 drivers/rtc/rtc-zynqmp.c | 113 ++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 5da33d760419..1dd389b891fe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -40,13 +41,19 @@
 #define RTC_CALIB_MASK		0x1FFFFF
 #define RTC_ALRM_MASK          BIT(1)
 #define RTC_MSEC               1000
+#define RTC_FR_MASK		0xF0000
+#define RTC_FR_MAX_TICKS	16
+#define RTC_PPB			1000000000LL
+#define RTC_MIN_OFFSET		-32768000
+#define RTC_MAX_OFFSET		32767000
 
 struct xlnx_rtc_dev {
 	struct rtc_device	*rtc;
 	void __iomem		*reg_base;
 	int			alarm_irq;
 	int			sec_irq;
-	unsigned int		calibval;
+	struct clk		*rtc_clk;
+	unsigned int		freq;
 };
 
 static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -61,13 +68,6 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	 */
 	new_time = rtc_tm_to_time64(tm) + 1;
 
-	/*
-	 * Writing into calibration register will clear the Tick Counter and
-	 * force the next second to be signaled exactly in 1 second period
-	 */
-	xrtcdev->calibval &= RTC_CALIB_MASK;
-	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
-
 	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
 
 	/*
@@ -173,15 +173,76 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
 	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
 	rtc_ctrl |= RTC_BATT_EN;
 	writel(rtc_ctrl, xrtcdev->reg_base + RTC_CTRL);
+}
 
-	/*
-	 * Based on crystal freq of 33.330 KHz
-	 * set the seconds counter and enable, set fractions counter
-	 * to default value suggested as per design spec
-	 * to correct RTC delay in frequency over period of time.
+static int xlnx_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
+	unsigned long long rtc_ppb = RTC_PPB;
+	unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
+	unsigned int calibval;
+	long offset_val;
+
+	calibval = readl(xrtcdev->reg_base + RTC_CALIB_RD);
+	/* Offset with seconds ticks */
+	offset_val = calibval & RTC_TICK_MASK;
+	offset_val = offset_val - RTC_CALIB_DEF;
+	offset_val = offset_val * tick_mult;
+
+	/* Offset with fractional ticks */
+	if (calibval & RTC_FR_EN)
+		offset_val += ((calibval & RTC_FR_MASK) >> RTC_FR_DATSHIFT)
+			* (tick_mult / RTC_FR_MAX_TICKS);
+	*offset = offset_val;
+
+	return 0;
+}
+
+static int xlnx_rtc_set_offset(struct device *dev, long offset)
+{
+	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
+	unsigned long long rtc_ppb = RTC_PPB;
+	unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
+	unsigned char fract_tick;
+	unsigned int calibval;
+	short int  max_tick;
+	int fract_offset;
+
+	if (offset < RTC_MIN_OFFSET || offset > RTC_MAX_OFFSET)
+		return -ERANGE;
+
+	/* Number ticks for given offset */
+	max_tick = div_s64_rem(offset, tick_mult, &fract_offset);
+
+	/* Number fractional ticks for given offset */
+	if (fract_offset) {
+		if (fract_offset < 0) {
+			fract_offset = fract_offset + tick_mult;
+			max_tick--;
+		}
+		if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
+			for (fract_tick = 1; fract_tick < 16; fract_tick++) {
+				if (fract_offset <=
+				    (fract_tick *
+				     (tick_mult / RTC_FR_MAX_TICKS)))
+					break;
+			}
+		}
+	}
+
+	/* Zynqmp RTC uses second and fractional tick
+	 * counters for compensation
 	 */
-	xrtcdev->calibval &= RTC_CALIB_MASK;
-	writel(xrtcdev->calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+	calibval = max_tick + RTC_CALIB_DEF;
+
+	if (fract_tick)
+		calibval |= RTC_FR_EN;
+
+	calibval |= (fract_tick << RTC_FR_DATSHIFT);
+
+	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
+
+	return 0;
 }
 
 static const struct rtc_class_ops xlnx_rtc_ops = {
@@ -190,6 +251,8 @@ static const struct rtc_class_ops xlnx_rtc_ops = {
 	.read_alarm	  = xlnx_rtc_read_alarm,
 	.set_alarm	  = xlnx_rtc_set_alarm,
 	.alarm_irq_enable = xlnx_rtc_alarm_irq_enable,
+	.read_offset	  = xlnx_rtc_read_offset,
+	.set_offset	  = xlnx_rtc_set_offset,
 };
 
 static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
@@ -255,10 +318,22 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "calibration",
-				   &xrtcdev->calibval);
-	if (ret)
-		xrtcdev->calibval = RTC_CALIB_DEF;
+	/* Getting the rtc_clk info */
+	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc_clk");
+	if (IS_ERR(xrtcdev->rtc_clk)) {
+		if (PTR_ERR(xrtcdev->rtc_clk) != -EPROBE_DEFER)
+			dev_warn(&pdev->dev, "Device clock not found.\n");
+	}
+	xrtcdev->freq = clk_get_rate(xrtcdev->rtc_clk);
+	if (!xrtcdev->freq) {
+		ret = of_property_read_u32(pdev->dev.of_node, "calibration",
+					   &xrtcdev->freq);
+		if (ret)
+			xrtcdev->freq = RTC_CALIB_DEF;
+	}
+	ret = readl(xrtcdev->reg_base + RTC_CALIB_RD);
+	if (!ret)
+		writel(xrtcdev->freq, (xrtcdev->reg_base + RTC_CALIB_WR));
 
 	xlnx_init_rtc(xrtcdev);
 
-- 
2.25.1

