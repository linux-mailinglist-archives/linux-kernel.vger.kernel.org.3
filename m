Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB044A67E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiBAWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:23:44 -0500
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:11331
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239569AbiBAWWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMVpsEvt5blHxBg8yKD/bm95mfHz7mF1P3+jNOeDy1+bF979WWxb/wEVHyq18ad60nlHUcrBoEy/rwZaj61F0nrKwCfE94J0hSEtcqfO8IH6XYDkcN6PRTWXrTGSN4S40REprwC7icXTWMMbqYtGHgD1OKIeE2kND92hnNXtRPLxo3b8+bLHU8Pi9t+YL3OtYDCl4yJjNoit9MrzjcBM5cdZlOW3a6Cc7HNf64KP5OZYFjes5pbOFPB3ODWowmMmeoGe7CdqztFrm2NLZxxoua4X/LDAhzpf4pKrg54jo6R3pgY8P9Z4MIFrGILhWm1OrkeffEyUZuIcCJYg7MTV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChhrXHrg2ywOVfTrkIg/R0h1yTCR21MBvCUKIE5Y4DU=;
 b=OFwAy6OlSTaKYPbmrObUy3EfmPxXOlP+6aQUhfHoDCLNB7X3LoxuP6avOR5e8ahjRFk3Zz69Dls6cWYSRanb7kViK0vurG+FWg/kmKVfS7u2mGyePIUJO1XqP9B/c7iOTajSP8cG8TTNWSMIvRdv3HgvrdqqgJFYUAh3b3ah3ZSB19yOscwClOT+4yPq69/HlWyLMhZLXiCaN4sbDNsSGni3nn3zg13yF6c26IxChxHOxEZXqJociOMmvF90dZdUnqmIQ07qfDOsMcPBnK47TifA/Tve9Bg2gLHXbjRCM86WnJljIAvyLhXlB2iBqpUDZ8/YsZV33yeiiwlSCH1qXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChhrXHrg2ywOVfTrkIg/R0h1yTCR21MBvCUKIE5Y4DU=;
 b=Gus+seCRXngMiw0wFFPkMpFLASziP4S8EQ1eJkF9tlV55pktWoqccGYnRO9zqH5ugRlqOSj0f/4+z0Pt1cI8crbJN24C2DSSagPu1NYoJXtMvIcNKPqSAGlbvJtfnFHBUJNpK325/W7dr4yoOu4ZM/TwJFN/pyJnRj9zz6vGzoTS44xo19fstHBV79hr2iHrbqNahImNuvBwpibR26H9Y8LBo95sRXi0Uptp5SoMP0xjlUBwrg6ipURruffUOPs3otHU9Mdz8zzg5uccmQC2oN9g2khtP6jDZv6aNnZ2vFPGRCL45pYqJAnImn2t2IOBiTC9cKo6gmiBFXJFLMlXTQ==
Received: from MWHPR13CA0039.namprd13.prod.outlook.com (2603:10b6:300:95::25)
 by BN8PR12MB3379.namprd12.prod.outlook.com (2603:10b6:408:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 22:22:34 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::fe) by MWHPR13CA0039.outlook.office365.com
 (2603:10b6:300:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:32 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:32 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 08/11] gpiolib: cdev: Add hardware timestamp clock type
Date:   Tue, 1 Feb 2022 14:26:27 -0800
Message-ID: <20220201222630.21246-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b28034-95ed-45cd-daa9-08d9e5d15851
X-MS-TrafficTypeDiagnostic: BN8PR12MB3379:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3379713FFC4C6E54481B8E57AE269@BN8PR12MB3379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhtafSQ+VznD1Qds33SBQZHQs+BzyoiSwQyU/MLAUlTRgqje+f0LBaQoB6x7XTxi4HFUUDYk7J8D250F3waYm3lE3FYQojH/VEXWV15d16MsG0M9ucQWG/OXi/+IYxgi06llrIRQY9mq/g9i3quijeUzuqZJWcNGr4rVTzdxvSZMAG6K8zs7AdTze4HDQWtbL/9IVCLgkTETsJVmUJl4UNybEAI0+mpCnXM/8SLP3c+UvC6/S8Pb811QcsH5KYjwerwz6Athy2RUC991bQ5GW/eU5TVRk5ekHqoM/CgAQhh/sDj0YUR4iO+kcaYZtT40KrURw3r8PjQcvGXqlZNBGm61Vdquh44+qAORfnL3LxoybwksPXhJM+FZaIRmuUQcjEMEHphjcShoALgTmYPKEi4ID2m0iJQV9uGLV8Cr5NYYG6lPQ0xgVKp9R3WELXIzVcGEj9KiX3+e9kqATiZzII3m0ilPvMhm/N98G+aPYWI2ypCyjhySG2X3vNgDG31gkwH8WZ2qmFkBu67b525GfMauyeVrJU82D4Px3U2c5wJEZmd9KHMWXGG+wBUiVTORSY8RfPb5I8Z6e60ZBuDcDVhOKr+6P2Ez9+EAZbqUDEZht6jr4nP6m+nFKyPe5++TLareaOpKZ9eZrMauDEemjmQaMQTH307QMvbc823znxE4k2rx0dp5N7r9MsDOwvPt20OXBdjvRjT5PtdW7IHaBJWr1EPlgRtR/Dv1R0FIBlXShUUQkAdDUJC2WiHoDbOUV80fSHhO7wvvHuubrYThkpmS8YW/LzxYdaNREEkPIOXtS5yDcXquc9Vt+T9FT8BC
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(921005)(356005)(83380400001)(26005)(316002)(36756003)(110136005)(81166007)(186003)(1076003)(30864003)(7416002)(107886003)(6666004)(82310400004)(2906002)(5660300002)(2616005)(8676002)(8936002)(70206006)(70586007)(4326008)(47076005)(40460700003)(508600001)(336012)(426003)(7696005)(36860700001)(86362001)(36900700001)(83996005)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:34.1227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b28034-95ed-45cd-daa9-08d9e5d15851
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3379
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
---
 drivers/gpio/gpiolib-cdev.c | 247 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/gpio.h   |   3 +
 2 files changed, 217 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c7b5446d01fd..a4f2de229e6c 100644
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
+		return HTE_RUN_THREADED_CB;
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
@@ -700,8 +826,29 @@ static void debounce_work_func(struct work_struct *work)
 	linereq_put_event(lr, &le);
 }
 
+static int hte_edge_setup(struct line *line, u64 eflags)
+{
+	unsigned long flags;
+	struct hte_ts_desc *hdesc = &line->hdesc;
+
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_RISING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				  HTE_FALLING_EDGE_TS : HTE_RISING_EDGE_TS;
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_FALLING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				  HTE_RISING_EDGE_TS : HTE_FALLING_EDGE_TS;
+
+	hdesc->attr.edge_flags = flags;
+	hdesc->attr.line_data = line->desc;
+	hdesc->attr.line_id = desc_to_gpio(line->desc);
+	line->total_discard_seq = 0;
+
+	return hte_req_ts_by_linedata_ns(hdesc, process_hw_ts,
+					 process_hw_ts_thread, line);
+}
+
 static int debounce_setup(struct line *line,
-			  unsigned int debounce_period_us)
+			  unsigned int debounce_period_us, bool hte_req)
 {
 	unsigned long irqflags;
 	int ret, level, irq;
@@ -721,19 +868,27 @@ static int debounce_setup(struct line *line,
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
@@ -766,13 +921,16 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
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
+		hte_release_ts(&line->hdesc);
+
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->eflags, 0);
@@ -784,7 +942,7 @@ static void edge_detector_stop(struct line *line)
 static int edge_detector_setup(struct line *line,
 			       struct gpio_v2_line_config *lc,
 			       unsigned int line_idx,
-			       u64 eflags)
+			       u64 eflags, bool hte_req)
 {
 	u32 debounce_period_us;
 	unsigned long irqflags = 0;
@@ -799,7 +957,7 @@ static int edge_detector_setup(struct line *line,
 	WRITE_ONCE(line->eflags, eflags);
 	if (gpio_v2_line_config_debounced(lc, line_idx)) {
 		debounce_period_us = gpio_v2_line_config_debounce_period(lc, line_idx);
-		ret = debounce_setup(line, debounce_period_us);
+		ret = debounce_setup(line, debounce_period_us, hte_req);
 		if (ret)
 			return ret;
 		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
@@ -809,6 +967,9 @@ static int edge_detector_setup(struct line *line,
 	if (!eflags || READ_ONCE(line->sw_debounced))
 		return 0;
 
+	if (hte_req)
+		return hte_edge_setup(line, eflags);
+
 	irq = gpiod_to_irq(line->desc);
 	if (irq < 0)
 		return -ENXIO;
@@ -834,13 +995,18 @@ static int edge_detector_setup(struct line *line,
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
@@ -851,11 +1017,12 @@ static int edge_detector_update(struct line *line,
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
@@ -891,7 +1058,6 @@ static int gpio_v2_line_flags_validate(u64 flags)
 	/* Return an error if an unknown flag is set */
 	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
 		return -EINVAL;
-
 	/*
 	 * Do not allow both INPUT and OUTPUT flags to be set as they are
 	 * contradictory.
@@ -900,6 +1066,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
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
@@ -992,6 +1163,8 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
 
 	assign_bit(FLAG_EVENT_CLOCK_REALTIME, flagsp,
 		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
+	assign_bit(FLAG_EVENT_CLOCK_HTE, flagsp,
+		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
 }
 
 static long linereq_get_values(struct linereq *lr, void __user *ip)
@@ -1121,6 +1294,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 	unsigned int i;
 	u64 flags;
 	bool polarity_change;
+	bool prev_hte_flag;
 	int ret;
 
 	for (i = 0; i < lr->num_lines; i++) {
@@ -1130,6 +1304,8 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 			(!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) !=
 			 ((flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW) != 0));
 
+		prev_hte_flag = !!test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags);
+
 		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
 		/*
 		 * Lines have to be requested explicitly for input
@@ -1138,7 +1314,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(lc, i);
 
-			edge_detector_stop(&lr->lines[i]);
+			edge_detector_stop(&lr->lines[i], prev_hte_flag);
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
@@ -1148,8 +1324,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 				return ret;
 
 			ret = edge_detector_update(&lr->lines[i], lc, i,
-					flags & GPIO_V2_LINE_EDGE_FLAGS,
-					polarity_change);
+					flags, polarity_change, prev_hte_flag);
 			if (ret)
 				return ret;
 		}
@@ -1278,9 +1453,12 @@ static ssize_t linereq_read(struct file *file,
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
@@ -1406,7 +1584,8 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 				goto out_free_linereq;
 
 			ret = edge_detector_setup(&lr->lines[i], lc, i,
-					flags & GPIO_V2_LINE_EDGE_FLAGS);
+				flags & GPIO_V2_LINE_EDGE_FLAGS,
+				flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
 			if (ret)
 				goto out_free_linereq;
 		}
@@ -1959,6 +2138,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 
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

