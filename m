Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDF532A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiEXMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEXMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:21:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061F22B2C;
        Tue, 24 May 2022 05:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChA37k7fsPoBl331COnbhZZ5LU32eAZrreqNSliCUjJPhWhlRgSoIhXUbhf/qWzQZrLu7CipcuPYiyLRIbEaXTKyY8zVW7JqPsDuhvQ//WE7XvSyrDLotT+lnT7hILcwY99AIjWw+2mFcZUtA62dIlljDm/DUrQRCGa+sFZTOh4aj9YQ5+DvaEzms9G0Q0F9OQQKM8BKwUYxvhBRgBUL0CIegS07cjHX2Fl8x7DQo+CBvh3pzv36A8luF1W/eB0ijvN07+UCufo5sG8isaonlr7sP7+Rltl5cZiQor4QjR0vYTfwKjd9QHZ67W1NSdSRq5jqKq+4iZryajedh9pn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7zBHUlJRyr/5u5bxn/3CKGMEjXYJUFT28/l881yas4=;
 b=f6UpEL79GD/nXjDU45/sEey+FIavOutKWtqF74YCCRxjwOYMDyFNxjXl9N+r3ZIhsFWBGFtUS7iAPn+QX7JiAKhiWnBoHVO28rh9lN1iJ/NttNjs43gn5EsmrFtt1Q+j/LK41wIVLYooq33JXvP5t2TGjUpXRl6UI9l/Ua1lt+IJzZSMwqSUQESv/6nKFEutpHmmetQSBhgq557poUUuCEj2sdEun7g0zs710m87d8C9EBCN5dzOKPCEJAqTfF+JIXjmlXsatdcYjihDrec6rzH/LNgphB2xMWf1ZgK6myeVNHZXwRyDaZie6JoGNm5VTDnrJW8gcyWaBJOqi4plFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7zBHUlJRyr/5u5bxn/3CKGMEjXYJUFT28/l881yas4=;
 b=MlN4xeaOH9aXWl6ov3MWgiknXPBlZu4L87BI4fGyAl/5CJcFAPhkPbwaVsVaPJZfLdTPU0WTU0DfwI9vPJxTx/S9bzOjKEAJ9bNWtNY+e+a92LIQtDKB+vLZTmWtKsrQ/ArC1NjLpQpDUTKoagmMY24O81+YtuYIKMW49s39iao=
Received: from DM5PR11CA0006.namprd11.prod.outlook.com (2603:10b6:3:115::16)
 by SJ0PR02MB8369.namprd02.prod.outlook.com (2603:10b6:a03:3e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:21:07 +0000
Received: from DM3NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::e5) by DM5PR11CA0006.outlook.office365.com
 (2603:10b6:3:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20 via Frontend
 Transport; Tue, 24 May 2022 12:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT039.mail.protection.outlook.com (10.13.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 12:21:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 05:21:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 05:21:01 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.66.193] (port=41286 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1ntTX2-000DAp-5L; Tue, 24 May 2022 05:21:00 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <sgoud@xilinx.com>, <shubhraj@xilinx.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V4 2/2] rtc: zynqmp: Add calibration set and get support
Date:   Tue, 24 May 2022 17:50:50 +0530
Message-ID: <20220524122050.48553-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220524122050.48553-1-srinivas.neeli@xilinx.com>
References: <20220524122050.48553-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d700e678-d45f-43c6-e6bd-08da3d7fe0bb
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8369:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8369945EE1A582755A070B94AFD79@SJ0PR02MB8369.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkfWzqeVVcIQI9+aLRETfC7EqguxVXmASkPAUqh00fNBgqVrDs+HEI5qiRnnwlTxLGPE3Y2PvNmaQwZtaUtodqJzrvO9n89QjIOG8L4hxft6BMEkuorfxYZeo0hzfcjAXc6ryb+q5hPCz5KSnF/49GId5/uGdt4clneYhsvodZCC8LZhDZAy80eQ1Ip8wD1BS5vV2uFZKdMo4UrY0uz9Rso4o9WIqc9QNDRdm/TiNDGMncDcTVL2RlYhr4W4vs410NjJjDtwP1DvdXhZBKvTch984rzw20CvgT8gTA8jw3IZFOHxkB9obtG5PMOubXZcXaPAokzDnuDOACkq01tBDRnldqvU1hGKOVPYILOM5P7hAsYfXzNR0nO00kFhxZS8NB2SOHg00qmfwThWuH4eMDpJAfUkle9NfQbzJ7UBvxgbfkIoZavSRrPewJIAjppOrKhdXFEmP+LyyZUG5eLzw3fweujrRUMIlSsgKpJOPPUJDSwuKtaUoiOQI4mUXjt79EjEkY5x08ka4uncz90T+eAQiZKjd0kUgxD/SD91toKJvev7cUZPfkCS42h/NZfmLZW7P45C9UPjIlXnUOewClIkGRlY5/h2upnzyfHC+6Dccd0hO5zkxdvAGE7mMjhE+IID9K0XyV6Qlg5/s+MOCHto14UeNvmTomrGJhPHaAaWeE/giNmybWZQKt+8xcN9LUdzeBXUTXqi7I/A7EYcHUc1BtlNKfWmTYl/WC+1p7A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(4326008)(70586007)(8676002)(336012)(47076005)(426003)(82310400005)(26005)(36756003)(7636003)(40460700003)(316002)(508600001)(36860700001)(7696005)(5660300002)(1076003)(6666004)(8936002)(54906003)(9786002)(110136005)(2906002)(107886003)(186003)(6636002)(44832011)(2616005)(83380400001)(356005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:21:06.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d700e678-d45f-43c6-e6bd-08da3d7fe0bb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8369
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
Changes in V4:
-Updated MIN and MAX calibration values.
-Updated RTC default calibration value to 0x7FFF.
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
index f440bb52be92..ea9feca0299a 100644
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

