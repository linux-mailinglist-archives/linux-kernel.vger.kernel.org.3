Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9C4EA757
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiC2Fry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiC2Frp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832A24A75F;
        Mon, 28 Mar 2022 22:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFeRA+BeTOW/9kU2GNpwAWhNNXc41ik0DqaqMLC+leALG8RbXdg0eKCekR5Tune4yJmGU795++EQSBoEDKMxLCuDmHBXl7ykdhRNu6YJcfL4FqanTt2RW9Kc8hDi7hVhx0+0YJ6Kt6prZhu8/LJFQYYRvMkWZNQwvlGN5HCpwtaF3CT68XXFf+TxTjHZ4OOneR93LmBCTyJfnfKQRBoKa/shBbcUDrvV8OAJ79/gwnwn3X0dlP8EnFJ1mAh98FYVfBR7zR66K+lPcbYAEwZYuuzAXdOES6vKPZOQbfLwVR4zuiNxiSycyf+8lAZVdVGb3DR2d1fkA2DdGQ7qKZ+Usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+hJUKYhEuANt/Cc0/VeBi94+QVgrEai7k9drx3irSs=;
 b=D7/1tfHFXdKDiWNHowjf4jAg777VS1n4C/figln3mYulla8TbXIyU5yW5RJCCARxkox2iORx2z9I4Xy1nrPy+DjeRLi2T5hReQcPQx/thsBj3PHpOwwMccWKlkLjzJOgxA/WNRDxX9zhkNInDvzScsZGiEusQMkd1itWaGKQPuHyhZ0+1FBMGmMQpOQYfL4BrPIWr/C2+FvAsTdaJWCMdyT+gAzwbniK/YjNd0VxUNvpJnTDkLNPMgjb/8wkMBdGuyTD3IcHK0EEnsLlDZxOpKA+wVr9zbe7weZJbH88/cKIaxKjwJy2+di0I2xh34DvDvWGpVQdBYfPHMNmSUzxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+hJUKYhEuANt/Cc0/VeBi94+QVgrEai7k9drx3irSs=;
 b=P4NqAJEyHXlkyj+OfkTQxb9KzA/7wC3YQjBqjXmDrJz2pd4ZWxKcyFcnty1Z2c4vYeqzvqH9ux3dVywxBWgMkN+wyCS8XgE8jQp3+U7cxEKSEiIQfgn1Ovf5xR/f1N3nFiZ4F1CAdUH8FL+9tfce1r8jeg0SWLsTDxbH8k0KeGcubAqoXb6vTWDtrZfYTz28mLJe+R0vUHyg0n7a1tU1n9imNETOs2zIStb/RpnWyThIHpOMWN6zs1Pku+s0l1rxpQuGSqOHXdDdJwDnGTWOA8SIIMNWeKWJlouvwSf8Ihrv7ORoUtEe1cd26g7Vp+s5vNgygeVE4z8vg69hKA1Vjg==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by BN6PR12MB1282.namprd12.prod.outlook.com (2603:10b6:404:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 05:45:37 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ab) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:35 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 08/11] gpiolib: cdev: Add hardware timestamp clock type
Date:   Mon, 28 Mar 2022 22:45:18 -0700
Message-ID: <20220329054521.14420-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71a9a942-8806-4a32-5f36-08da11475974
X-MS-TrafficTypeDiagnostic: BN6PR12MB1282:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12820AE27C416740BD5639B1AE1E9@BN6PR12MB1282.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi4AUwozhc30w7QE8RsQJobJy3S6a+yU19h09smX9+iym6X3UUNhbQ4mTgXww+/BfZ6lVhlnUY+hQOt3YgOlUc8OA0ijQwTft6T2VeM/ORatLLb0x5L+bJvHuQvRaOKXv1bTdarBxo0DRBP63a/iAw5qaR4zoCpgW5rja99GF/BCW+2OiwgDk4Hy0BK1TDhEXWjk3I5GEb5jqzzbY4L6KGHtV1deRECd2578ezWDC8fow7iFksJLnxBuUUuj/htDwqGVCirEOq9CRjf441UEMPHKgykSgeorjQu1NLBicQXDtf5KXKtro1MjBO2ODDDBKgi2295k6HLfbNUpNCBLwzofQO78SliWFcLZd3D3SoMEqWj03xG6VW2u9cj8p9CI3sCUMmgD3ZFcq+NJq6XDLTcdn6IKgUMJElBn6cUmGQ0gwCAdM7vPk7ZjVAVf7sr4exXU+Mb9/RwvUX72LBlhXY7nbdrlA4TudGrKubT4rBphH5waBxWo5xz7dHybsNf1ZQ8SGe4mtRkUefCfbLLaVwFRIvA2A0ftZKFUWtcpbHpUh725Ak64ZkBtYjqK3JRhIqNHdsaFCBMiPAVY3KdzO3YwNh0NfIkE+MV5b6JwxE9VvvMvxkWDpB2axmNA5ZU0mIrcZMVyBbwe9hh+Xdrw1R7ya2H4RG6mLwNfTHNK5jxx9dd6hKn5gQLRaER18leLEeEIFQPTmkb3eCjqlEsBrNNqq1TMvsL3VzlX0wNvE1NVZvyLyEmXX9k20F9xRODxTdO5AcRuPGkdFBUA6y2lYZ/CgGMgYJc15A3R3xiTHSmleMArBmakvo0qLfxe+r7y
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(70586007)(70206006)(8676002)(40460700003)(30864003)(5660300002)(316002)(2616005)(86362001)(110136005)(81166007)(7416002)(8936002)(2906002)(356005)(921005)(6666004)(508600001)(336012)(107886003)(1076003)(82310400004)(426003)(26005)(186003)(7696005)(83380400001)(36860700001)(47076005)(36756003)(2101003)(36900700001)(83996005)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:36.5933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a9a942-8806-4a32-5f36-08da11475974
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1282
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

 drivers/gpio/gpiolib-cdev.c | 247 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/gpio.h   |   3 +
 2 files changed, 217 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ffa0256cad5a..62f914bbf14d 100644
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
@@ -700,8 +826,29 @@ static void debounce_work_func(struct work_struct *work)
 	linereq_put_event(lr, &le);
 }
 
+static int hte_edge_setup(struct line *line, u64 eflags)
+{
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

