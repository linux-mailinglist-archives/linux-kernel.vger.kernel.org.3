Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34BA4912B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbiARATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:19:03 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:44309
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243881AbiARASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBgw12IcA2s5GQB+5wkkaFaKRs1M3bQcLVbbEv2VmJUbI5djSUKd6dddVLmKPjXiZX4LuBZ3TOz2BIEqlnjBGb4EIfanYMThxuucgM+BxOZ7lLIzj9r8IvVRs2ZfBB8ZWKU3r3TeUpQGWP+YzS0YsbY8N0Jo0mCPrUZBMVGeec+AWce7SZ0Ib0+jqbry8sxAbsore/WacpwBzdZScun7YrjM0m8IYWQ3Q9PacKgeByvEIEWQALyv+Oe2Xs9D1NshyYU+1KsqIEnx/BF2nV7aGdGD1Gk6YDjzTdNOH0lmeIn1c9jVZl9lRpgPQPuh6u0lZL0n3GM4TATOoibJu6AVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3R2i4wriZq45cwcl1HhTgnbevEaFjfJ3BdvABtlWSw=;
 b=AYxWTkbe4ITU+/bp6ZIQW3yGOjtGrnPQE7jZzUJGSBR1hzVCHcDrnDy40fA8rLmPpTtUbFWdrxNp0xhhJDpnI04QUZBMKTK+qZv1cZqvfOanmMWsHhHeF4rXTt1a2WbJIWKstnl3AtP8SqNnguqwhI2feKPCL1kt0aWDIv/cAEknBcGJzYLgPn3IK/9l1bSacsh2cKk5D0aXpXEpQdO/vakRYKFq9uuXmRuD8bp4K7b35UyDD5DabwrJadFBYAyQ5iuNX9NXU7lPXwNcGNBffB+CPX6twJ+PI2OujiYz/L0zC8rCl3+JhUADncd3qfIS2oXwWAgduy8uE61O9w1TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3R2i4wriZq45cwcl1HhTgnbevEaFjfJ3BdvABtlWSw=;
 b=nHQjJQGYfIHgFmXhsk2MD3xKY3MCph+ATu8nO+Gy3KAnpx1WJ2RkkgE7bQVJZsaDITDyw6chzYszxzsWU0xI3xcFFNlahoir/S0j0OJR9RqTy5SUcfyf6YDigeJFAwtz5BVFFYFBQzZPZK28a8nMWdGe+5KZAa6GMcSvUzrw4IeIiZ7F3Vi3tmDG8GDx0/AY97y79hotip01voSp6cyQSjBLl4iWzy5tcZzk5q1uOGeEHnfoVvVrdtQ85fMBUKGmp3PDxGUJ9gJ0rAe6y4MzUOI04riJ++eQmlO+doQIQPky35f6YcvPKxrOQwhyA3IjSFF3S+TgS66VemZRiXGElg==
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 00:18:46 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::c5) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:46 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:45 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:45 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:45 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 08/11] gpiolib: cdev: Add hardware timestamp clock type
Date:   Mon, 17 Jan 2022 16:22:11 -0800
Message-ID: <20220118002214.18271-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97905a27-2199-4258-54af-08d9da1817fd
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0151:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0151B8CCC034C348C3BB0121AE589@CY4PR1201MB0151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGGASSkZxhDuCqOxWwTjx9NvxP2ALfWmH1sYFh7+DEawsaTBBxeRASbNDIDOOH/vyCM4xLHHGhrau/PnT87u0R8A6lGlPhF+w1levyXix1XgqVIQ1Jz/ep/u1rLOE+GIOLhOXrw1fnQNDyhZVEZ1U1/gYqAXhcgoTQzuzJFdj4dAW4tHQdjHZoWpkwD6XSci+SXvltOY5+WejgsWhmKZfs7Nl/ETUH6gC2CBjs6vW0tFL1xGPIUwOFkNHIyrCjX0qui6zKlUy2vm0PyagfchzwI1IwG80oSfDQUK3tUNc5d7U3qkXYLNOeMEbr7/TjLLpx0zCP+9KWSJAQfscW+F75+YfYT1vlfYvFWidAofk14x53spSTFXWBNPKj3xKPsQSy6WKA2UDeahJ/JYUsV5/sp9nKNd4C8OVM4EpcBDGAwHIOuOP0xmG4i2SprReO3dGfSLFgxSe+sDU4D2nhuT72ytKHPTwOuNXOAmp2ta+/EGOxZlK9Pzj+qYKjYB6Ylt1OclNGrHuv8v2WGFo414DKEIQIa12P6U02OfIFfOMzNwHK7Yg6kSpERyhj7C2h6xJcivcyzYwqRcqtdaAYq5G3jK8721W/U4slKwDlOwUmF59twh2wYZBpmWcU2wO+imNMakaSsry4W6knpIUkVxQq9ON0E8ZhphZv8At9V6/vd6PH6hd38ZjHNeB6qG6oAmlaodPwshls8Ltk/KNZvKygjKe94H8zX+//qA06WuOSzywRoEWh/L84fzGTfOXyLC8itVBL4MNmBfUw321WbT5OX/vLQHCK0OUeVwOXFrB4JnYL4gLpU4Fj0MfPMmq1IJmclLxZVChS8n1ksZp1TlFn2LJD8oxwj4MjKCXPzTCnftdKGF+8mjFpX/isRSqenZ/JXG5GwhndF+k9h1hWbo7w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(110136005)(2906002)(316002)(8936002)(70586007)(7416002)(70206006)(426003)(921005)(36860700001)(26005)(47076005)(36756003)(186003)(508600001)(86362001)(1076003)(82310400004)(4326008)(40460700001)(356005)(8676002)(83380400001)(30864003)(2616005)(5660300002)(336012)(6666004)(7696005)(107886003)(81166007)(83996005)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:46.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97905a27-2199-4258-54af-08d9da1817fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
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
Changes in v2:
- Added hte_dir and static structure hte_ts_desc.
- Added callbacks which get invoked by HTE when new data is available.
- Better use of hte_dir and seq from hte_ts_desc.
- Modified sw debounce function to accommodate hardware timestamping.

Changes in v4:
- Correced line level and event sequence counter handling.
- Added hte edge setup functionality.

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

