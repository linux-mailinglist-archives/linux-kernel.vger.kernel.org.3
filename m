Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFE53CDBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiFCRFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344212AbiFCRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:05:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3527522F8;
        Fri,  3 Jun 2022 10:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx/Vc79cnkipt64KdwIesYo9Z4aEXqpLzyQFcyvKUYB/iYDiIaclrF3i5TrV5aZWoURtfixaRlJEMLzjIcnbzt8x4aq2O6x4gTg2T8PhpP/JmN8SfSEDF6OW+89JG9yf51RTzdMJqn4JYXPTXM+T1OsTzroqkC2I89y/AVyWRQtVO1LftEQgj8gzexvKdU6c5GjPmVHmSXazPLJVRRTXWiK1FmlQnvdx9Cnqdm2yVMehXE2/WGvzWJeAB/Uaz4TNrnZHPlm0C6vjNI2v8ptNAlR5SJb/yTrH9sofnuamdtVueyc4VwiioMLACUrJER1qjeUUsnRryjhT2el0+qllog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6Oml0FJb5+VW0xLS2mmQzq4cSJEjCzGnMeV/azn9rM=;
 b=Mvds3oU55sJjVuePRJ/jrGTqnver8eURTG0kMiSlid6pQsJg55u0/W3ao99Ma+zRlr7UrxV1M3Ko4Wo3p9w11E9JhcX53Pt713YlhYKkloXUtK7qbbG5eVB44o/Bx9qoUxTG/GnYmVuUBsjtdt1YSyKzGBAtXw0Td0Vu0E1FiTge6mzOsBqCE4bkdSwsyzsx7p/5QRoEN64VemWblVNvcsRivC734AcBkKWAVW6jV3YDPIOxoGF3lVCYE2dccWI51jevixHVf5HJh9c2lPAKM8waJB1lwYR6OkHqxjUqsopoxzF2831kp7veN1svOIP2LQDg7xrX6+AkdLQyCtP0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6Oml0FJb5+VW0xLS2mmQzq4cSJEjCzGnMeV/azn9rM=;
 b=UHh7wz6Y96W8fZ94eWAHvwfX8OSBZksytqKNgxamFE/eV2vczQ5FMMLOV3zj5hwXXb8OSexsHOUeCCXayS+0526RHsO2F8dwox6rVIE+OWJ9E1uEdeZ6nnRi2foZAeoGQqI6iMXhcHLH+I1wLQZbfW2gfQbeXf6zJyUFTSWMMLs=
Received: from DM5PR13CA0037.namprd13.prod.outlook.com (2603:10b6:3:7b::23) by
 MWHPR02MB3342.namprd02.prod.outlook.com (2603:10b6:301:62::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 3 Jun 2022 17:05:13 +0000
Received: from DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::e0) by DM5PR13CA0037.outlook.office365.com
 (2603:10b6:3:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.5 via Frontend
 Transport; Fri, 3 Jun 2022 17:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT036.mail.protection.outlook.com (10.13.5.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 17:05:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Jun 2022 10:05:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Jun 2022 10:05:09 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Received: from [172.23.66.193] (port=44716 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nxAjV-000GsV-3m; Fri, 03 Jun 2022 10:05:09 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <git@xilinx.com>, Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V5 2/2] rtc: zynqmp: Add calibration set and get support
Date:   Fri, 3 Jun 2022 22:34:32 +0530
Message-ID: <20220603170432.26605-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603170432.26605-1-srinivas.neeli@xilinx.com>
References: <20220603170432.26605-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32253e09-c279-4782-6bc8-08da4583390d
X-MS-TrafficTypeDiagnostic: MWHPR02MB3342:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB334210FD1C249A93ABC12980AFA19@MWHPR02MB3342.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQihXam/Ggq13T96D4+2K38XaLr0OkyMoA5sTVY79+53reD0JLfXrl3ZGS+cvdqn4hcPfXfUW9Uu66GtRpL0By9Dr8fRdikaeUra0TMnGWdchKrl1Sky0UWn06LnU5i81nwBDbSvQyTx5AtXI2hOJXSLius60YvvqIsroNtZ70gEAfJlGs+nCcZ3ukIZJZ/bK1BhSQSey2ejOkWHDImWxxzj9nWzrDiOBwIl605Ar3xhL4B/Yf/njQfCuhYeBGosn8C8qVuFDqYTmudQijSCfD3eK97jCgAbZsHXb2/w3RZe2z/jMDZz37peNZUk8UXTktg28d1z8gZ0DvWapitIyg+4h09O9EPl9z62V9r/V+ICKrgcVm4YAKqMwjw5LkE7K35DXjcR6gTnHwrn06ZQfblFxmO2t82a8Hm8rU6+Q3wzuXHCgM0EgC375Zv2K2Fl7V0DtlZQBTZdITNbf53KCj0h0vO8+OGAMq5UnJommULR/f0gzxDu16eg1BmjTBv0Fih9Vcv0Rj1KZVDHEFXlMxtqBPb/zBLYQs8o71+N1vPwODtRri9Ak4BfQUdkFkYi6Fi2D/e2mEgZ846NrEOJCwd/B3bKweA3OxJqu9SYwVMTAQ3iE57Jh86B9xNbRiiSEuTOSoDjhnrU40n9DXs7zLj0yl1owQUdBrsrrVfOTpsTuTBG3ZioJ+EvPpCWcAyvriDj2kl4t00Fbr+zmgLOCJhbo7q1taPxyuQP0vh7tZM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(36756003)(70586007)(508600001)(110136005)(6666004)(316002)(8936002)(1076003)(336012)(186003)(426003)(5660300002)(6636002)(9786002)(2616005)(7696005)(107886003)(2906002)(40460700003)(8676002)(83380400001)(4326008)(36860700001)(54906003)(7636003)(47076005)(356005)(82310400005)(44832011)(26005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:05:12.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32253e09-c279-4782-6bc8-08da4583390d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3342
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
As per RTC spec default calibration value is 0x7FFF.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
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
 drivers/rtc/rtc-zynqmp.c | 115 ++++++++++++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index f440bb52be92..1dd389b891fe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -36,17 +37,23 @@
 #define RTC_OSC_EN		BIT(24)
 #define RTC_BATT_EN		BIT(31)
 
-#define RTC_CALIB_DEF		0x198233
+#define RTC_CALIB_DEF		0x7FFF
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
2.17.1

