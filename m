Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A7544E72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiFIOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbiFIOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:10:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56D4D610;
        Thu,  9 Jun 2022 07:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5+TlGgsawH0H+1ZWPHx1w6178Lf8dhRrJO2e0qH83g0hDfh5TLtQKJe1a+D68DpZClKHLY40Iu4I0BuGwcBn8irCiBw+kfstgT5Vd2mKz1ZXhOs2RwXcbLhcesPvnAwiQKN2ogs1ijKuGtChnSTxUXQ0zIHqAPtZVIrFyopL2nrj2t7xy9V75NfZX18KjAV+y/YdpyzYjQ8fTwxaujOLTFd95zETlH3SyNTG5KbErNYE8WpaCatUkv7YUH0uSs1A+95PCVT13j6+0IQ2QIS63uigj3n69BpGLk5vnHiaiVq281VaPadkOmfSSZD8D+brIO082yfTA8jLj35mezl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys5JX/GT0QAG6rP/33DMBuT0Ca0wc+h3kCmOF8P9v8g=;
 b=Z8DJFHf31OTFOCimbkOtQ7RS8fC2g4EMmYLqiHoSFJC3nimGO7V2nx+r0fioA6nL7VCsAoFOREbI9N+d4GZbmqWdgighXWRIirNJU1U9e1K2nRRvasAeaSqWYD3EHlNjH0psvx02zsCpULFv55c8qAovcpOkNcBPIi79mqVledtcJUeH/6PoDJ8wRZE+Y/F72/tKAu6/ckdKKN+OYgJieKzZcAkIGBlOvb8s2ZyHJl1z0s+D9J0jjjVK67Qf3BswouGl9WpfKtLdqCtdcoC/ow00iUChH4XdblJZexYLlsmsTXAmhCikBh+6SQl4zTnc5Iq7RiXAfDPdLEbU03OsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys5JX/GT0QAG6rP/33DMBuT0Ca0wc+h3kCmOF8P9v8g=;
 b=KfCb8+hkbQ13OdwuD2pWl5OT3LnJ/YkKZxrePsZA1DKcZkA0z5He88v6Jz6O7JDeWS/MrT5WqtaJX2kohYED10GbdK/JsfuT2NBItI89L1Fpi6ZA6Z864WsizjC+IS20xNG2dUZqJlDP+vGEETQrMRzXu0Z52kdkuC9TzYee8ow=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by CH0PR02MB8075.namprd02.prod.outlook.com (2603:10b6:610:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 14:10:48 +0000
Received: from SN1NAM02FT0027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:21:cafe::3c) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Thu, 9 Jun 2022 14:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0027.mail.protection.outlook.com (10.97.4.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 14:10:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 9 Jun 2022 07:08:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 9 Jun 2022 07:08:50 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=38176 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nzIq9-0001FS-Nx; Thu, 09 Jun 2022 07:08:50 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
Date:   Thu, 9 Jun 2022 19:38:33 +0530
Message-ID: <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c04a4ab-d349-4030-8be2-08da4a21da4b
X-MS-TrafficTypeDiagnostic: CH0PR02MB8075:EE_
X-Microsoft-Antispam-PRVS: <CH0PR02MB80755FBACDD9088761A87815AFA79@CH0PR02MB8075.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWXgZ0gYz3gyQKGkhrOgxn/3Uubi93YUizoRGBo3WQixy8VRS35Up2Fwe5O3eZUJFuPIvY9FDTvUD9aP0dqyMFBrQG5Zu+wq62vTzUWCKfkS9zT9Vdfq3DEsA/34VemISW1g6lx2EnDPXak7Nnxx8ffNfjaHkYYFss/ECvmQJG12+sGZy3oZvPRA22iF8bVowOH1BCqvPCXacQxNqiv6ui0es4FmU0H5p8GXzK3aETbnnx9tUI+w9Rg7K2sDCFVQENgEJhjJ+YMiVAi0Fg68qzeQNMfKwxT+3guiD3NY/LVnDDUe+08BHK4L6PflVi7I+uCxRb0xlp4aHeMrK1qTjER43eT4QQfGWkK/fdmE5Q6TWph17yw6D9hGz63kmS8lMrUUVNI4CFj7M9cZM2ionwGmw1JgrxMbaNN5c+hVgPQ4FM+jcaA7d7j9LUpHZnBKzTuimP3f8phZrEgGwz7AcGsuMq7MZmlsBsvC/4axnKDS5UCn+Ag5UZ88JcSkallu+0MirG88K49mIwLP04PTZpOzXhF3UZxHRgOK6CdJApB6RmOn3k3jyDLIqaOYJ4ZXVOKtUm5tEkqDG9otpJEte5FIp4gb4v6yHzFijyuOt6jnmCPBBEYgnpmNPCpd9+FlUFeJ1ZOVpiT6TMjzMR57uYRrDEDFYi1g62nztHjnvToWkJ7cTdz9Ey1PInmub31k8Y8i9yalW6FtILYL0gZRyF0rzUrKJS1DeosL6gr9v7g=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(82310400005)(186003)(9786002)(107886003)(2616005)(426003)(336012)(47076005)(508600001)(54906003)(8936002)(36860700001)(110136005)(8676002)(4326008)(5660300002)(7416002)(70586007)(2906002)(70206006)(316002)(83380400001)(26005)(6666004)(7696005)(356005)(44832011)(36756003)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:10:48.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c04a4ab-d349-4030-8be2-08da4a21da4b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8075
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
2.25.1

