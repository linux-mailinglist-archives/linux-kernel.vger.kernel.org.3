Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6854B1D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiBKEyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:54:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiBKEyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:54:11 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9E2710;
        Thu, 10 Feb 2022 20:54:10 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21B4hkGL008200;
        Thu, 10 Feb 2022 20:54:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=raf8OY7AF1C4vCN/KkI9mH8XZsY++SYirqVC8dSjGe8=;
 b=TWubMh/vjNKVctIbgEs353kswwTWU3vEtJzMw9ngMbykCmK1DcX5TC0cmU/3wT6G8Vm/
 RWK+UErlkIy+gR5s5ZFd4hmMmIZ7Q/Fd/DUZKnLWpAJRIMakz+cIXfGOAWrxe9ItkPK8
 6TFcpx7FJFwpGwt6/Z0Vf5kpU4SVNwNIp4uY6b5BRubGUbw1c85iD5QVjCYgudAEmKe/
 TeVBObWR0bKrt7GCtj/tMtKaOKW7ENhaucgTXnrrxlpjLxiOYVH9O9Mpe5Y6Wwt/+XTo
 EWxWsnZ1aW+SLF5zGcMJ+lCxC38IeYY244hmmZAagqdr1vjbvDRva2sHjKhU6SBHEozj dg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3e50uccadg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 20:54:04 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 20:54:03 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 10 Feb 2022 20:54:00 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v8 3/4] perf/marvell: cn10k DDR perfmon event overflow handling
Date:   Fri, 11 Feb 2022 10:23:45 +0530
Message-ID: <20220211045346.17894-4-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211045346.17894-1-bbhushan2@marvell.com>
References: <20220211045346.17894-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: oDu3ntrkX79cok1Y1wXn0jXV_8lKvS6Y
X-Proofpoint-ORIG-GUID: oDu3ntrkX79cok1Y1wXn0jXV_8lKvS6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CN10k DSS h/w perfmon does not support event overflow interrupt, so
periodic timer is being used. Each event counter is 48bit, which in worst
case scenario can increment at maximum 5.6 GT/s. At this rate it may take
many hours to overflow these counters. Therefore polling period for
overflow is set to 100 sec, which can be changed using sysfs parameter.

Two fixed event counters starts counting from zero on overflow, so
overflow condition is when new count less than previous count. While
eight programmable event counters freezes at maximum value. Also individual
counter cannot be restarted, so need to restart all eight counters.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
v7->v8:
 - No change

 drivers/perf/marvell_cn10k_ddr_pmu.c | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index d93268943e23..19c8744e1a23 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/perf_event.h>
+#include <linux/hrtimer.h>
 
 /* Performance Counters Operating Mode Control Registers */
 #define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
@@ -127,6 +128,7 @@ struct cn10k_ddr_pmu {
 	struct	device *dev;
 	int active_events;
 	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
+	struct hrtimer hrtimer;
 };
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
@@ -251,6 +253,18 @@ static const struct attribute_group *cn10k_attr_groups[] = {
 	NULL,
 };
 
+/* Default poll timeout is 100 sec, which is very sufficient for
+ * 48 bit counter incremented max at 5.6 GT/s, which may take many
+ * hours to overflow.
+ */
+static unsigned long cn10k_ddr_pmu_poll_period_sec = 100;
+module_param_named(poll_period_sec, cn10k_ddr_pmu_poll_period_sec, ulong, 0644);
+
+static ktime_t cn10k_ddr_pmu_timer_period(void)
+{
+	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
+}
+
 static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
 {
 	switch (eventid) {
@@ -433,6 +447,10 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	pmu->active_events++;
 	hwc->idx = counter;
 
+	if (pmu->active_events == 1)
+		hrtimer_start(&pmu->hrtimer, cn10k_ddr_pmu_timer_period(),
+			      HRTIMER_MODE_REL_PINNED);
+
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
 		reg_offset = DDRC_PERF_CFG(counter);
@@ -484,6 +502,10 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 	cn10k_ddr_perf_free_counter(pmu, counter);
 	pmu->active_events--;
 	hwc->idx = -1;
+
+	/* Cancel timer when no events to capture */
+	if (pmu->active_events == 0)
+		hrtimer_cancel(&pmu->hrtimer);
 }
 
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
@@ -502,6 +524,92 @@ static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 		       DDRC_PERF_CNT_END_OP_CTRL);
 }
 
+static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
+{
+	struct hw_perf_event *hwc;
+	int i;
+
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		cn10k_ddr_perf_event_update(pmu->events[i]);
+	}
+
+	/* Reset previous count as h/w counter are reset */
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		hwc = &pmu->events[i]->hw;
+		local64_set(&hwc->prev_count, 0);
+	}
+}
+
+static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
+{
+	struct perf_event *event;
+	struct hw_perf_event *hwc;
+	u64 prev_count, new_count;
+	u64 value;
+	int i;
+
+	event = pmu->events[DDRC_PERF_READ_COUNTER_IDX];
+	if (event) {
+		hwc = &event->hw;
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
+
+		/* Overflow condition is when new count less than
+		 * previous count
+		 */
+		if (new_count < prev_count)
+			cn10k_ddr_perf_event_update(event);
+	}
+
+	event = pmu->events[DDRC_PERF_WRITE_COUNTER_IDX];
+	if (event) {
+		hwc = &event->hw;
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
+
+		/* Overflow condition is when new count less than
+		 * previous count
+		 */
+		if (new_count < prev_count)
+			cn10k_ddr_perf_event_update(event);
+	}
+
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL)
+			continue;
+
+		value = cn10k_ddr_perf_read_counter(pmu, i);
+		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+			pr_info("Counter-(%d) reached max value\n", i);
+			cn10k_ddr_perf_event_update_all(pmu);
+			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static enum hrtimer_restart cn10k_ddr_pmu_timer_handler(struct hrtimer *hrtimer)
+{
+	struct cn10k_ddr_pmu *pmu = container_of(hrtimer, struct cn10k_ddr_pmu,
+						 hrtimer);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cn10k_ddr_pmu_overflow_handler(pmu);
+	local_irq_restore(flags);
+
+	hrtimer_forward_now(hrtimer, cn10k_ddr_pmu_timer_period());
+	return HRTIMER_RESTART;
+}
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu;
@@ -550,6 +658,9 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
+	hrtimer_init(&ddr_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ddr_pmu->hrtimer.function = cn10k_ddr_pmu_timer_handler;
+
 	ret = perf_pmu_register(&ddr_pmu->pmu, name, -1);
 	if (ret)
 		return ret;
-- 
2.17.1

