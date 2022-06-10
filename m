Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C445465E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiFJLie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349123AbiFJLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:38:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141A7B9C8;
        Fri, 10 Jun 2022 04:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxZiuLc5kcEOF+aDTKWsbE8H5WFd2qUr3p+yWCK3XpvCs5unq/S4P6qXovgnbwhmsjMCGvkxKoYBtMp8WM8zIPw+ESwLSuv7dHITQwBHF2w3wyQjNDzFCPsl5dqAZUBfAN2YJsg1orGErybsKJLvYc97eLUfD7OLlN5gzbYwdYSVzVuwH2uhRytBipxIgBc6TV/i6HDhPniqSt7VJp9ji/LiRIMrobAv3ooA9qJjB+9/Y++1ryH4joFeqYbi8vRZzJRuxs0mSYisAzezSTFr5hFWzbPe8EwVM95F5sSlZ+KxTmcgTk/Va0cpHnoS5EIJtad4AYHG5t7uQQeZ5ULjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi6W89wILb2rFFcoXkD3plmfkD0PZBhNyAyNqw8vseU=;
 b=WS3hI/Z30PEg412eW0T1gF2H5lO9gxkfZhItZMK5OIrdAu0yV7GeE5AN8xEzsRFmMClmRzHyWzJtuUWejiBcczhCjeYb/w048N/f9y9LDwdT/AJ6tSTEUgrSqM+bvfl7+GiiA4CEWNv4EH50JRRdEnBgeUxBQfOgxT6lhF+otjPDHKPK1ZGDtvH201/4XCZsyNG1qJOI3PD8vLh1QKZ7HIYDQBF3gTyvSJw3Khp7XiulUC3UaMJtL5VQOuBUbZG0v17v1Zod8FH/B/XcvGyqTEfZ68Z+t4MX1tw1EG14YeN1M632YLLpxeTXjd29KOAU0OnghLvmiDsXUMyzuMjg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vi6W89wILb2rFFcoXkD3plmfkD0PZBhNyAyNqw8vseU=;
 b=M9+qIr31MZVS7s7fI9wrRtgCWyGE0prIUYya74Lb4Uy+/+j/rMcT8FmgUBmOJCzVOFZ3RbAZQ8GXEZm+C8zur6VoyuizXmdnvFCfQLUlxbYht4WoPb3SV18ke7UkG8/+fKXqDlkU6phfM54/CBlbI/I2uyoL7ZCvaEL6gwUsTJc=
Received: from SN4PR0601CA0017.namprd06.prod.outlook.com
 (2603:10b6:803:2f::27) by BN8PR02MB5748.namprd02.prod.outlook.com
 (2603:10b6:408:b0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 11:37:27 +0000
Received: from SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::98) by SN4PR0601CA0017.outlook.office365.com
 (2603:10b6:803:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 11:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0025.mail.protection.outlook.com (10.97.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 11:37:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Jun 2022 04:37:25 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 10 Jun 2022 04:37:24 -0700
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
Received: from [10.140.6.39] (port=39538 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nzcxA-0002aq-9t; Fri, 10 Jun 2022 04:37:24 -0700
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
Subject: [PATCH V7 2/3] rtc: zynqmp: Add calibration set and get support
Date:   Fri, 10 Jun 2022 17:07:08 +0530
Message-ID: <20220610113709.2646118-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
References: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f094d7-2880-4b96-2565-08da4ad598a3
X-MS-TrafficTypeDiagnostic: BN8PR02MB5748:EE_
X-Microsoft-Antispam-PRVS: <BN8PR02MB574891CFADC135A472ED1743AFA69@BN8PR02MB5748.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQSKw12100Kyl4t1fhjZc/nvfVragYTqCNQdE/IntS92uJTRCr5RWC9C/a/LPKIYoh0XzLdXmE+6l/UaNiabTSBr/8/OswD4Sd4FZi3AHmEqdLyBD+Qw3LzySM9WDk1SReGtSkipppz11ZoHwfaUZrvHWHRJNwNgQ4nU9Dcg/TIlqx2pzP0kaNtidYO3eIWg0tPTtutgmK3atwxUGkL49hk4+FILHETrrt06NK9kezEfAlogONNrCMRSuvPY55p6t95zyRZuQb1Pb8UrMWbI8j48OcZ+FsvLWBZe5Pk001ulmv7sDN3qEI+v3I7T8klR5DdasLW5N8WCrH9SUG/zL4ZpbaYZCwlFywQ96D6ECgOA5NlzPMPdEm5lWRakTPLyMJdXXkDwXvd98LxbfHiEjKuM/3sXLvpcw353FigW3PAUoVj+aVCViBQVQMZGn3/JSiClpoiJsMKfPiS7Orxg8/bjil6yV7Y32N0sgZKpBOGbkkEO/c3P75Gq1VSphsAjSGcmZPkT29GvmTnxnGbIokpzuC9mnL3Ed7xItF6ty/6yuAifyjXMXdOLC4nn0o4xf0ogAPIB2lF+Kl8nEUGO2S1oj0AQ8H7jntRHWF1cLkZHe6tq77NDNl8T0YYJYk8IUrL0D/HFlnM6g0JY8yYbW8XwnmHb8FT0iJU3sCLo6vVElTVw9C+TdTJn3JbyHEwCNfAPXPaO2o2W0NQ1adDwJvyj9tDgSiFM1vgSAFiF5BQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(82310400005)(36860700001)(40460700003)(508600001)(316002)(2906002)(110136005)(54906003)(6666004)(7696005)(356005)(336012)(7636003)(47076005)(26005)(186003)(1076003)(107886003)(70586007)(2616005)(70206006)(36756003)(8676002)(4326008)(5660300002)(44832011)(9786002)(8936002)(7416002)(426003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 11:37:27.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f094d7-2880-4b96-2565-08da4ad598a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5748
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
index f440bb52be92..39b23f88ee26 100644
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

