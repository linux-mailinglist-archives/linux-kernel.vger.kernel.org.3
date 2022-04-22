Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD850C21F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiDVWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiDVWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F72E6636;
        Fri, 22 Apr 2022 13:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PunZdJPK98+TOeqHmIITFoQnoOAG3+ek03XCnjJHlQqFvoQv9V58wiXbAkwldS+xvrjg3iKCzJ6+Z22s3VVLPwF64G3JraOX2Z9DlLNHieKSs64w8yvkbKAOpJZiaxtV70NnMDdZQKXAloby8yPegoUQU7/5bGB7kgTiMdm4+aIP37hH2KYtFQc2jqy3zhBsxoPNGDmSPQmrE3pDHSDQKBDtKMx7EXm46Gj6r3y0IeRI5FH9SL0Mm9Fjmf/RhXxgMTg6CDG0f/ZcrQF2K/NLA44TaxZ5XbAJzWXHfwO2oTJJwYe9Vi9DD4tcNmLuyITnIJch11KYa+MJhHwkBt7s/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wgzS2azRR5c4w6lTEOeJ24VZ+yBzjALXy0YNkYTRvI=;
 b=h4W1vofAcUgVcuwFWSc3xN5riYux27Memb4b+Sqaq2APa1NdGmnn2+GvvZmU5750pw7W1r/0zoTqw37yPrgTNtTbb8gdqNurVnrfv7vGxgBP+nnDYtnyK6nw39/KPtH1dCCI7PWcIBlAvVOO9eYZpsDIv6qhkQ8y/1OsaMkupb4JdBx8j0cxk8Wfip11g+2O9ecPJICxgLxind8CwI42ke0vsQunR+Tlj/BDkvz/g0LACi0HrCLeOMKdXTFPvVzOH0q3d+cFH9Kmlm/WPtav/sP2OIxAyrhkqrMkPXKMRRATBGWP3g0X2uHaBF4LnTEj6ffhUpnM/xCPR5USTTiyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wgzS2azRR5c4w6lTEOeJ24VZ+yBzjALXy0YNkYTRvI=;
 b=Yv8zuNuYAB93Ffx1Ke5wd+0451BHXVqMRFsNoSZYJzZe8oUGdWW30INFAb6IzZ6wQAQy/0NMEkK5heyf0VBc1Pyfr4GXdX2T8XEnftvp9fHx63HzjVFMRELh9Kp7B38gJU/cDDpOwiwWvRpb8ntB8eAov5fBMScfsUdEsHleToSCQIvsHmOpVv9juFygUmg9Ylb/XuZIdfwYggRiUaDTq2O1TRcq5u0trH4xHr3gYBi7ozMVEbMN1Hjoj7Vlh/0IFWhNvTCf3vfXbFGhV2NIS8jDMBhwnygoFe/X/pEuXClGJPssQZhzrMLs2KfU8hrahM3//iK2988HfDBwiTIeZw==
Received: from BN9PR03CA0186.namprd03.prod.outlook.com (2603:10b6:408:f9::11)
 by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 20:53:07 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::d7) by BN9PR03CA0186.outlook.office365.com
 (2603:10b6:408:f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 20:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:53:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:26 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:25 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 07/10] gpiolib: cdev: Add hardware timestamp clock type
Date:   Fri, 22 Apr 2022 13:52:18 -0700
Message-ID: <20220422205221.952-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50af1760-eb5f-47a4-6f18-08da24a21a6e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3682005065744FAACF2634EBAEF79@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XFODUzKAgnk+uZtCJ8sk+FR3agiLnmow+Eb63fs805+zBGTgiNtnKiX+dppG2dTqSuX8Wxdsy0MSRcb9D2OF5hO8ACOtJ5yjtXIHHgSMVSrJnlMLTTPALyR/zRBSILQcFh6svX+6XzKvgl5n5xraRgnw4u2w7RabrM41EtsnTet6SQVEFZV+aU4mmtbwziK6L52Ox9XbzIai6/WBDo25iy7bIkIguZF2CE87eWK1aj4VjWcSjcEeoNKaUfZCYmJzBs8cJLiuh7kx+gYiiaR/lGrxcNyVaLU79ZxbbuIr2WrKibPVm/JfFxDlz7mECGIjr1c1bX3SuRhu8Pe1z0oGKCrBpuhtjkrAHsOcoEE19qffCoTamzLKB1mMibDYT5Vy5G2462LLNPxePTdYaDAm4dM/YGNP+kPo7+qzdvmXT/eyk5fajXareVlJLj1bJ82scZgY9twyqS/VzkQDrcBQ+1+pg58OwbiK6sFChmS1pAs3VLaCHBTa9Epmj5PXzYkRdPAZEZ9Q1eJFbwUfKMSzpw63nttE9ESvRZiSI75uMhoEe8b4T4/bMeEGS3lwyIcz5ZSOa0MSTrxGNcFIkrDzSAw8BT+KOJg7HRXDL8IpAb0QFJSIhIRwjAcbMHu0lXLm/UOQvWbJQDMUg9zHQ7Jfuk1Eu3MUNNWlDjhusHNPzw5izBHGyJAkXnudWUpRSzjhaC+DTLJhlE6TOfDLP+I/ipJI+jdArU8cFPw6HY5WXGSVeF98LJufU9ZRw15aA5z50oNndI53tkTZg3x/mDYNlPk/2OioFv9eHZBrhSaYS1Kkpne7snPhft7Xu5iDvt6
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(7696005)(508600001)(7416002)(107886003)(186003)(6666004)(86362001)(36756003)(81166007)(8936002)(2906002)(83380400001)(40460700003)(5660300002)(2616005)(70206006)(26005)(110136005)(426003)(47076005)(336012)(30864003)(8676002)(4326008)(356005)(36860700001)(82310400005)(70586007)(316002)(921005)(83996005)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:53:07.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50af1760-eb5f-47a4-6f18-08da24a21a6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new clock type for the GPIO controller which can
timestamp gpio lines in using hardware means. To expose such
functionalities to the userspace, code has been added where
during line create or set config API calls, it checks for new
clock type and if requested, calls HTE API. During line change
event, the HTE subsystem pushes timestamp data to userspace
through gpiolib-cdev.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Changes in v2:
- Added hte_dir and static structure hte_ts_desc.
- Added callbacks which get invoked by HTE when new data is available.
- Better use of hte_dir and seq from hte_ts_desc.
- Modified sw debounce function to accommodate hardware timestamping.

Changes in v4:
- Correced line level and event sequence counter handling.
- Added hte edge setup functionality.

Changes in v6:
- Added code to line init and get hte descriptor before making hte request.

 drivers/gpio/gpiolib-cdev.c | 252 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/gpio.h   |   3 +
 2 files changed, 222 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ffa0256cad5a..2f224394e9e7 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -24,6 +24,7 @@
 #include <linux/timekeeping.h>
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
+#include <linux/hte.h>
 #include <uapi/linux/gpio.h>
 
 #include "gpiolib.h"
@@ -464,6 +465,25 @@ struct line {
 	 * stale value.
 	 */
 	unsigned int level;
+	/*
+	 * -- hte specific fields --
+	 */
+	struct hte_ts_desc hdesc;
+	/*
+	 * HTE provider sets line level at the time of event. The valid
+	 * value is 0 or 1 and negative value for an error.
+	 */
+	int raw_level;
+	/*
+	 * when sw_debounce is set on HTE enabled line, this is running
+	 * counter of the discarded events.
+	 */
+	u32 total_discard_seq;
+	/*
+	 * when sw_debounce is set on HTE enabled line, this variable records
+	 * last sequence number before debounce period expires.
+	 */
+	u32 last_seqno;
 };
 
 /**
@@ -518,6 +538,7 @@ struct linereq {
 	 GPIO_V2_LINE_DRIVE_FLAGS | \
 	 GPIO_V2_LINE_EDGE_FLAGS | \
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME | \
+	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_BIAS_FLAGS)
 
 static void linereq_put_event(struct linereq *lr,
@@ -542,10 +563,98 @@ static u64 line_event_timestamp(struct line *line)
 {
 	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &line->desc->flags))
 		return ktime_get_real_ns();
+	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags))
+		return line->timestamp_ns;
 
 	return ktime_get_ns();
 }
 
+static hte_return_t process_hw_ts_thread(void *p)
+{
+	struct line *line;
+	struct linereq *lr;
+	struct gpio_v2_line_event le;
+	int level;
+	u64 eflags;
+
+	if (!p)
+		return HTE_CB_HANDLED;
+
+	line = p;
+	lr = line->req;
+
+	memset(&le, 0, sizeof(le));
+
+	le.timestamp_ns = line->timestamp_ns;
+	eflags = READ_ONCE(line->eflags);
+
+	if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
+		if (line->raw_level >= 0) {
+			if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
+				level = !line->raw_level;
+			else
+				level = line->raw_level;
+		} else {
+			level = gpiod_get_value_cansleep(line->desc);
+		}
+
+		if (level)
+			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
+		else
+			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
+	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
+		/* Emit low-to-high event */
+		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
+	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
+		/* Emit high-to-low event */
+		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
+	} else {
+		return HTE_CB_HANDLED;
+	}
+	le.line_seqno = line->line_seqno;
+	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
+	le.offset = gpio_chip_hwgpio(line->desc);
+
+	linereq_put_event(lr, &le);
+
+	return HTE_CB_HANDLED;
+}
+
+static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
+{
+	struct line *line;
+	struct linereq *lr;
+	int diff_seqno = 0;
+
+	if (!ts || !p)
+		return HTE_CB_HANDLED;
+
+	line = p;
+	line->timestamp_ns = ts->tsc;
+	line->raw_level = ts->raw_level;
+	lr = line->req;
+
+	if (READ_ONCE(line->sw_debounced)) {
+		line->total_discard_seq++;
+		line->last_seqno = ts->seq;
+		mod_delayed_work(system_wq, &line->work,
+		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+	} else {
+		if (unlikely(ts->seq < line->line_seqno))
+			return HTE_CB_HANDLED;
+
+		diff_seqno = ts->seq - line->line_seqno;
+		line->line_seqno = ts->seq;
+		if (lr->num_lines != 1)
+			line->req_seqno = atomic_add_return(diff_seqno,
+							    &lr->seqno);
+
+		return HTE_RUN_SECOND_CB;
+	}
+
+	return HTE_CB_HANDLED;
+}
+
 static irqreturn_t edge_irq_thread(int irq, void *p)
 {
 	struct line *line = p;
@@ -651,10 +760,16 @@ static void debounce_work_func(struct work_struct *work)
 	struct gpio_v2_line_event le;
 	struct line *line = container_of(work, struct line, work.work);
 	struct linereq *lr;
-	int level;
+	int level, diff_seqno;
 	u64 eflags;
 
-	level = gpiod_get_raw_value_cansleep(line->desc);
+	if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+		level = line->raw_level;
+		if (level < 0)
+			level = gpiod_get_raw_value_cansleep(line->desc);
+	} else {
+		level = gpiod_get_raw_value_cansleep(line->desc);
+	}
 	if (level < 0) {
 		pr_debug_ratelimited("debouncer failed to read line value\n");
 		return;
@@ -685,10 +800,21 @@ static void debounce_work_func(struct work_struct *work)
 	lr = line->req;
 	le.timestamp_ns = line_event_timestamp(line);
 	le.offset = gpio_chip_hwgpio(line->desc);
-	line->line_seqno++;
-	le.line_seqno = line->line_seqno;
-	le.seqno = (lr->num_lines == 1) ?
-		le.line_seqno : atomic_inc_return(&lr->seqno);
+	if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+		/* discard events except the last one */
+		line->total_discard_seq -= 1;
+		diff_seqno = line->last_seqno - line->total_discard_seq -
+				line->line_seqno;
+		line->line_seqno = line->last_seqno - line->total_discard_seq;
+		le.line_seqno = line->line_seqno;
+		le.seqno = (lr->num_lines == 1) ?
+			le.line_seqno : atomic_add_return(diff_seqno, &lr->seqno);
+	} else {
+		line->line_seqno++;
+		le.line_seqno = line->line_seqno;
+		le.seqno = (lr->num_lines == 1) ?
+			le.line_seqno : atomic_inc_return(&lr->seqno);
+	}
 
 	if (level)
 		/* Emit low-to-high event */
@@ -700,8 +826,34 @@ static void debounce_work_func(struct work_struct *work)
 	linereq_put_event(lr, &le);
 }
 
+static int hte_edge_setup(struct line *line, u64 eflags)
+{
+	int ret;
+	unsigned long flags = 0;
+	struct hte_ts_desc *hdesc = &line->hdesc;
+
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_RISING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				  HTE_FALLING_EDGE_TS : HTE_RISING_EDGE_TS;
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_FALLING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				  HTE_RISING_EDGE_TS : HTE_FALLING_EDGE_TS;
+
+	line->total_discard_seq = 0;
+
+	hte_init_line_attr(hdesc, desc_to_gpio(line->desc), flags,
+			   NULL, line->desc);
+
+	ret = hte_ts_get(NULL, hdesc, 0);
+	if (ret)
+		return ret;
+
+	return hte_request_ts_ns(hdesc, process_hw_ts,
+				 process_hw_ts_thread, line);
+}
+
 static int debounce_setup(struct line *line,
-			  unsigned int debounce_period_us)
+			  unsigned int debounce_period_us, bool hte_req)
 {
 	unsigned long irqflags;
 	int ret, level, irq;
@@ -721,19 +873,27 @@ static int debounce_setup(struct line *line,
 		if (level < 0)
 			return level;
 
-		irq = gpiod_to_irq(line->desc);
-		if (irq < 0)
-			return -ENXIO;
+		if (!hte_req) {
+			irq = gpiod_to_irq(line->desc);
+			if (irq < 0)
+				return -ENXIO;
 
-		WRITE_ONCE(line->level, level);
-		irqflags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
-		ret = request_irq(irq, debounce_irq_handler, irqflags,
-				  line->req->label, line);
-		if (ret)
-			return ret;
+			irqflags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
+			ret = request_irq(irq, debounce_irq_handler, irqflags,
+					  line->req->label, line);
+			if (ret)
+				return ret;
+			line->irq = irq;
+		} else {
+			ret = hte_edge_setup(line,
+					     GPIO_V2_LINE_FLAG_EDGE_RISING |
+					     GPIO_V2_LINE_FLAG_EDGE_FALLING);
+			if (ret)
+				return ret;
+		}
 
+		WRITE_ONCE(line->level, level);
 		WRITE_ONCE(line->sw_debounced, 1);
-		line->irq = irq;
 	}
 	return 0;
 }
@@ -766,13 +926,16 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
-static void edge_detector_stop(struct line *line)
+static void edge_detector_stop(struct line *line, bool hte_en)
 {
-	if (line->irq) {
+	if (line->irq && !hte_en) {
 		free_irq(line->irq, line);
 		line->irq = 0;
 	}
 
+	if (hte_en)
+		hte_ts_put(&line->hdesc);
+
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->eflags, 0);
@@ -784,7 +947,7 @@ static void edge_detector_stop(struct line *line)
 static int edge_detector_setup(struct line *line,
 			       struct gpio_v2_line_config *lc,
 			       unsigned int line_idx,
-			       u64 eflags)
+			       u64 eflags, bool hte_req)
 {
 	u32 debounce_period_us;
 	unsigned long irqflags = 0;
@@ -799,7 +962,7 @@ static int edge_detector_setup(struct line *line,
 	WRITE_ONCE(line->eflags, eflags);
 	if (gpio_v2_line_config_debounced(lc, line_idx)) {
 		debounce_period_us = gpio_v2_line_config_debounce_period(lc, line_idx);
-		ret = debounce_setup(line, debounce_period_us);
+		ret = debounce_setup(line, debounce_period_us, hte_req);
 		if (ret)
 			return ret;
 		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
@@ -809,6 +972,9 @@ static int edge_detector_setup(struct line *line,
 	if (!eflags || READ_ONCE(line->sw_debounced))
 		return 0;
 
+	if (hte_req)
+		return hte_edge_setup(line, eflags);
+
 	irq = gpiod_to_irq(line->desc);
 	if (irq < 0)
 		return -ENXIO;
@@ -834,13 +1000,18 @@ static int edge_detector_setup(struct line *line,
 static int edge_detector_update(struct line *line,
 				struct gpio_v2_line_config *lc,
 				unsigned int line_idx,
-				u64 eflags, bool polarity_change)
+				u64 flags, bool polarity_change,
+				bool prev_hte_flag)
 {
+	u64 eflags = flags & GPIO_V2_LINE_EDGE_FLAGS;
 	unsigned int debounce_period_us =
-		gpio_v2_line_config_debounce_period(lc, line_idx);
+			gpio_v2_line_config_debounce_period(lc, line_idx);
+	bool hte_change = (prev_hte_flag !=
+		      ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) != 0));
 
 	if ((READ_ONCE(line->eflags) == eflags) && !polarity_change &&
-	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us))
+	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us)
+	    && !hte_change)
 		return 0;
 
 	/* sw debounced and still will be...*/
@@ -851,11 +1022,12 @@ static int edge_detector_update(struct line *line,
 	}
 
 	/* reconfiguring edge detection or sw debounce being disabled */
-	if ((line->irq && !READ_ONCE(line->sw_debounced)) ||
+	if ((line->irq && !READ_ONCE(line->sw_debounced)) || prev_hte_flag ||
 	    (!debounce_period_us && READ_ONCE(line->sw_debounced)))
-		edge_detector_stop(line);
+		edge_detector_stop(line, prev_hte_flag);
 
-	return edge_detector_setup(line, lc, line_idx, eflags);
+	return edge_detector_setup(line, lc, line_idx, eflags,
+				   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
 }
 
 static u64 gpio_v2_line_config_flags(struct gpio_v2_line_config *lc,
@@ -891,7 +1063,6 @@ static int gpio_v2_line_flags_validate(u64 flags)
 	/* Return an error if an unknown flag is set */
 	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
 		return -EINVAL;
-
 	/*
 	 * Do not allow both INPUT and OUTPUT flags to be set as they are
 	 * contradictory.
@@ -900,6 +1071,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
 	    (flags & GPIO_V2_LINE_FLAG_OUTPUT))
 		return -EINVAL;
 
+	/* Only allow one event clock source */
+	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
+	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
+		return -EINVAL;
+
 	/* Edge detection requires explicit input. */
 	if ((flags & GPIO_V2_LINE_EDGE_FLAGS) &&
 	    !(flags & GPIO_V2_LINE_FLAG_INPUT))
@@ -992,6 +1168,8 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
 
 	assign_bit(FLAG_EVENT_CLOCK_REALTIME, flagsp,
 		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
+	assign_bit(FLAG_EVENT_CLOCK_HTE, flagsp,
+		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
 }
 
 static long linereq_get_values(struct linereq *lr, void __user *ip)
@@ -1121,6 +1299,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 	unsigned int i;
 	u64 flags;
 	bool polarity_change;
+	bool prev_hte_flag;
 	int ret;
 
 	for (i = 0; i < lr->num_lines; i++) {
@@ -1130,6 +1309,8 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 			(!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) !=
 			 ((flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW) != 0));
 
+		prev_hte_flag = !!test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags);
+
 		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
 		/*
 		 * Lines have to be requested explicitly for input
@@ -1138,7 +1319,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(lc, i);
 
-			edge_detector_stop(&lr->lines[i]);
+			edge_detector_stop(&lr->lines[i], prev_hte_flag);
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
@@ -1148,8 +1329,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 				return ret;
 
 			ret = edge_detector_update(&lr->lines[i], lc, i,
-					flags & GPIO_V2_LINE_EDGE_FLAGS,
-					polarity_change);
+					flags, polarity_change, prev_hte_flag);
 			if (ret)
 				return ret;
 		}
@@ -1278,9 +1458,12 @@ static ssize_t linereq_read(struct file *file,
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
+	bool hte;
 
 	for (i = 0; i < lr->num_lines; i++) {
-		edge_detector_stop(&lr->lines[i]);
+		hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
+				 &lr->lines[i].desc->flags);
+		edge_detector_stop(&lr->lines[i], hte);
 		if (lr->lines[i].desc)
 			gpiod_free(lr->lines[i].desc);
 	}
@@ -1406,7 +1589,8 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 				goto out_free_linereq;
 
 			ret = edge_detector_setup(&lr->lines[i], lc, i,
-					flags & GPIO_V2_LINE_EDGE_FLAGS);
+				flags & GPIO_V2_LINE_EDGE_FLAGS,
+				flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
 			if (ret)
 				goto out_free_linereq;
 		}
@@ -1959,6 +2143,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 
 	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
+	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
+		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
 
 	debounce_period_us = READ_ONCE(desc->debounce_period_us);
 	if (debounce_period_us) {
diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index eaaea3d8e6b4..cb9966d49a16 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -66,6 +66,8 @@ struct gpiochip_info {
  * @GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN: line has pull-down bias enabled
  * @GPIO_V2_LINE_FLAG_BIAS_DISABLED: line has bias disabled
  * @GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME: line events contain REALTIME timestamps
+ * @GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE: line events contain timestamps from
+ * hardware timestamp engine
  */
 enum gpio_v2_line_flag {
 	GPIO_V2_LINE_FLAG_USED			= _BITULL(0),
@@ -80,6 +82,7 @@ enum gpio_v2_line_flag {
 	GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN	= _BITULL(9),
 	GPIO_V2_LINE_FLAG_BIAS_DISABLED		= _BITULL(10),
 	GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME	= _BITULL(11),
+	GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE	= _BITULL(12),
 };
 
 /**
-- 
2.17.1

