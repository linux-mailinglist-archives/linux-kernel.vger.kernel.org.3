Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F357E9E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiGVWk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiGVWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:40:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B3921E17;
        Fri, 22 Jul 2022 15:38:19 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MMCLPR006590;
        Fri, 22 Jul 2022 22:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=sfEmqvMJt+XLWEnIf3sTot+8D/lb4qevkhTB16BGR0A=;
 b=fhfoRiphPO6OJKJ4m4DVAPYZBtM1e7Wpb1Jf9WHwarqbFcBydli5jgEBP68CAJw3TUfB
 itmNwsPd+bXCHEEuPLkTIhuxZZWHOi3QGo1+XxWPF+A3Zx3zOVapohEsR8y0hWN2eN0d
 +vMovVGxssPKncQyUcJKP5fXR1cyYfRTps1X2+PCt91P8TdL2LqF9QRgrisHw/1KqPzx
 ItP2QbNGeGGB6KBxy6KoXlIFB3/Pvlrqi2v3iJvjGTPjw2v7CaLzC7bxa2/J+kmxm60g
 HHpGZ92K4674WPtWEcBCKvuz9HVVRrgKLEPHHEU1SKGjWh936xCZ0XBZ8JSGUCed6WwG sg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hf8a9mdy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 22:37:27 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26MMbRX0023926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 22:37:27 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 15:37:26 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper functions
Date:   Fri, 22 Jul 2022 15:37:17 -0700
Message-ID: <1658529438-9234-5-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wyy3dzfzv12m1CYyMs0dkrXsA1a72GHZ
X-Proofpoint-ORIG-GUID: wyy3dzfzv12m1CYyMs0dkrXsA1a72GHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the firmware (FW) supports multiple requests per VM, and the VM
also supports it via the `allow-multi-call` device tree flag, the
floodgates are thrown open for them to all reach the firmware at the
same time.

Since the firmware currently being used has limited resources, it guards
them with a resource lock and puts requests on a wait-queue internally
and signals to HLOS that it is doing so. It does this by returning two
new return values in addition to success or error: SCM_WAITQ_SLEEP and
SCM_WAITQ_WAKE.

  1) SCM_WAITQ_SLEEP:

  	When an SCM call receives this return value instead of success
  	or error, FW has placed this call on a wait-queue and
  	has signalled HLOS to put it to non-interruptible sleep. (The
	mechanism to wake it back up will be described in detail in the
	next patch for the sake of simplicity.)

	Along with this return value, FW also passes to HLOS `wq_ctx` -
	a unique number (UID) identifying the wait-queue that it has put
	the call on, internally. This is to help HLOS with its own
	bookkeeping to wake this sleeping call later.

	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
	identifying the SCM call thus being put to sleep. This is also
	for HLOS' bookkeeping to wake this call up later.

	These two additional values are passed via the a1 and a2
	registers.

	N.B.: The "ctx" in the above UID names = "context".

  2) SCM_WAITQ_WAKE:

  	When an SCM call receives this return value instead of success
  	or error, FW wishes to signal HLOS to wake up a (different)
  	previously sleeping call.

  	FW tells HLOS which call to wake up via the additional return
  	values `wq_ctx`, `smc_call_ctx` and `flags`. The first two have
  	already been explained above.

  	`flags` can be either WAKE_ONE or WAKE_ALL. Meaning, wake either
  	one, or all, of the SCM calls that HLOS is associating with the
  	given `wq_ctx`.

A sleeping SCM call can be woken up by either an interrupt that FW
raises, or via a SCM_WAITQ_WAKE return value for a new SCM call.

The handshake mechanism that HLOS uses to talk to FW about wait-queue
operations involves three new SMC calls. These are:

  1) get_wq_ctx():

    	Arguments: 	None
    	Returns:	wq_ctx, flags, more_pending

    	Get the wait-queue context, and wake up either one or all of the
    	sleeping SCM calls associated with that wait-queue.

    	Additionally, repeat this if there are more wait-queues that are
    	ready to have their requests woken up (`more_pending`).

  2) wq_resume(smc_call_ctx):

  	Arguments:	smc_call_ctx

  	HLOS needs to issue this in response to receiving an
  	IRQ, passing to FW the same smc_call_ctx that FW
  	receives from HLOS via the get_wq_ctx() call.

  3) wq_wake_ack(smc_call_ctx):

  	Arguments:	smc_call_ctx

  	HLOS needs to issue this in response to receiving an
  	SCM_WAITQ_WAKE, passing to FW the same smc_call_ctx that FW
  	passed to HLOS via the SMC_WAITQ_WAKE call.

(Reminder that the full handshake mechanism will be detailed in the
subsequent patch.)

Also add the interrupt handler that wakes up a sleeping SCM call.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
[v2]
- Corrected device tree property to "enable-multi-call" in commit message.
- Added idr_destroy() in the probe function.

 drivers/firmware/qcom_scm-smc.c |  56 +++++++++++++++++++
 drivers/firmware/qcom_scm.c     | 119 +++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/qcom_scm.h     |  12 ++++
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index 66193c2..4150da1 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -53,6 +53,62 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
 	} while (res->a0 == QCOM_SCM_INTERRUPTED);
 }
 
+static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
+{
+	memset(resume->args, 0, ARRAY_SIZE(resume->args));
+
+	resume->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
+			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_RESUME));
+
+	resume->args[1] = QCOM_SCM_ARGS(1);
+
+	resume->args[2] = smc_call_ctx;
+}
+
+static void fill_wq_wake_ack_args(struct arm_smccc_args *wake_ack, u32 smc_call_ctx)
+{
+	memset(wake_ack->args, 0, ARRAY_SIZE(wake_ack->args));
+
+	wake_ack->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
+			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_ACK));
+
+	wake_ack->args[1] = QCOM_SCM_ARGS(1);
+
+	wake_ack->args[2] = smc_call_ctx;
+}
+
+static void fill_get_wq_ctx_args(struct arm_smccc_args *get_wq_ctx)
+{
+	memset(get_wq_ctx->args, 0, ARRAY_SIZE(get_wq_ctx->args));
+
+	get_wq_ctx->args[0] = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
+			 ARM_SMCCC_SMC_64, ARM_SMCCC_OWNER_SIP,
+			 SCM_SMC_FNID(QCOM_SCM_SVC_WAITQ, QCOM_SCM_WAITQ_GET_WQ_CTX));
+}
+
+int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
+{
+	int ret;
+	struct arm_smccc_args get_wq_ctx = {0};
+	struct arm_smccc_res get_wq_res;
+
+	fill_get_wq_ctx_args(&get_wq_ctx);
+
+	__scm_smc_do_quirk(&get_wq_ctx, &get_wq_res);
+	/* Guaranteed to return only success or error, no WAITQ_* */
+	ret = get_wq_res.a0;
+	if (ret)
+		return ret;
+
+	*wq_ctx = get_wq_res.a1;
+	*flags  = get_wq_res.a2;
+	*more_pending = get_wq_res.a3;
+
+	return 0;
+}
+
 static void __scm_smc_do(const struct arm_smccc_args *smc,
 			 struct arm_smccc_res *res, bool atomic)
 {
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 4046073..73bbd62 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -3,8 +3,12 @@
  * Copyright (C) 2015 Linaro Ltd.
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
+#define pr_fmt(fmt)     "qcom-scm: %s: " fmt, __func__
+
 #include <linux/platform_device.h>
+#include <linux/idr.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/dma-mapping.h>
@@ -12,10 +16,13 @@
 #include <linux/types.h>
 #include <linux/qcom_scm.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/ktime.h>
 #include <linux/arm-smccc.h>
 
 #include "qcom_scm.h"
@@ -29,12 +36,19 @@ bool qcom_scm_allow_multicall = false;
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
 
+struct qcom_scm_waitq {
+	struct idr idr;
+	spinlock_t idr_lock;
+	struct work_struct scm_irq_work;
+};
+
 struct qcom_scm {
 	struct device *dev;
 	struct clk *core_clk;
 	struct clk *iface_clk;
 	struct clk *bus_clk;
 	struct reset_controller_dev reset;
+	struct qcom_scm_waitq waitq;
 
 	u64 dload_mode_addr;
 };
@@ -56,10 +70,14 @@ struct qcom_scm_mem_map_info {
 static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	0, BIT(0), BIT(3), BIT(5)
 };
+
 static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 	BIT(2), BIT(1), BIT(4), BIT(6)
 };
 
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
+#define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
+
 static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_UNKNOWN] = "unknown",
 	[SMC_CONVENTION_ARM_32] = "smc arm 32",
@@ -1266,11 +1284,92 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL(qcom_scm_is_available);
 
+struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx)
+{
+	struct completion *wq = NULL;
+	u32 wq_ctx_idr = wq_ctx;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&scm->waitq.idr_lock, flags);
+	wq = idr_find(&scm->waitq.idr, wq_ctx);
+	if (wq)
+		goto out;
+
+	wq = devm_kzalloc(scm->dev, sizeof(*wq), GFP_ATOMIC);
+	if (!wq) {
+		wq = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	init_completion(wq);
+
+	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
+			    U32_MAX, GFP_ATOMIC);
+	if (err < 0) {
+		devm_kfree(scm->dev, wq);
+		wq = ERR_PTR(err);
+	}
+
+out:
+	spin_unlock_irqrestore(&scm->waitq.idr_lock, flags);
+	return wq;
+}
+
+void scm_waitq_flag_handler(struct completion *wq, u32 flags)
+{
+	switch (flags) {
+	case QCOM_SMC_WAITQ_FLAG_WAKE_ONE:
+		complete(wq);
+		break;
+	case QCOM_SMC_WAITQ_FLAG_WAKE_ALL:
+		complete_all(wq);
+		break;
+	default:
+		pr_err("invalid flags: %u\n", flags);
+	}
+}
+
+static void scm_irq_work(struct work_struct *work)
+{
+	int ret;
+	u32 wq_ctx, flags, more_pending = 0;
+	struct completion *wq_to_wake;
+	struct qcom_scm_waitq *w = container_of(work, struct qcom_scm_waitq, scm_irq_work);
+	struct qcom_scm *scm = container_of(w, struct qcom_scm, waitq);
+
+	do {
+		ret = scm_get_wq_ctx(&wq_ctx, &flags, &more_pending);
+		if (ret) {
+			pr_err("GET_WQ_CTX SMC call failed: %d\n", ret);
+			return;
+		}
+
+		wq_to_wake = qcom_scm_lookup_wq(scm, wq_ctx);
+		if (IS_ERR_OR_NULL(wq_to_wake)) {
+			pr_err("No waitqueue found for wq_ctx %d: %ld\n",
+					wq_ctx, PTR_ERR(wq_to_wake));
+			return;
+		}
+
+		scm_waitq_flag_handler(wq_to_wake, flags);
+	} while (more_pending);
+}
+
+static irqreturn_t qcom_scm_irq_handler(int irq, void *p)
+{
+	struct qcom_scm *scm = p;
+
+	schedule_work(&scm->waitq.scm_irq_work);
+
+	return IRQ_HANDLED;
+}
+
 static int qcom_scm_probe(struct platform_device *pdev)
 {
 	struct qcom_scm *scm;
 	unsigned long clks;
-	int ret;
+	int irq, ret;
 
 	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
 	if (!scm)
@@ -1333,12 +1432,29 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, scm);
+
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	spin_lock_init(&__scm->waitq.idr_lock);
+	idr_init(&__scm->waitq.idr);
 	qcom_scm_allow_multicall = of_property_read_bool(__scm->dev->of_node,
 							"allow-multi-call");
 
+	INIT_WORK(&__scm->waitq.scm_irq_work, scm_irq_work);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq) {
+		ret = devm_request_threaded_irq(__scm->dev, irq, NULL,
+			qcom_scm_irq_handler, IRQF_ONESHOT, "qcom-scm", __scm);
+		if (ret < 0) {
+			pr_err("Failed to request qcom-scm irq: %d\n", ret);
+			idr_destroy(&__scm->waitq.idr);
+			return ret;
+		}
+	}
+
 	__get_convention();
 
 	/*
@@ -1354,6 +1470,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
+	idr_destroy(&__scm->waitq.idr);
 	/* Clean shutdown, disable download mode to allow normal restart */
 	if (download_mode)
 		qcom_scm_set_download_mode(false);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index c0a4d6b..ae3a331 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -62,6 +62,11 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
+struct qcom_scm;
+extern struct completion *qcom_scm_lookup_wq(struct qcom_scm *scm, u32 wq_ctx);
+extern void scm_waitq_flag_handler(struct completion *wq, u32 flags);
+extern int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
+
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
 extern int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 			  enum qcom_scm_convention qcom_convention,
@@ -131,6 +136,11 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1		0x03
 #define QCOM_SCM_SMMU_CONFIG_ERRATA1_CLIENT_ALL	0x02
 
+#define QCOM_SCM_SVC_WAITQ			0x24
+#define QCOM_SCM_WAITQ_ACK			0x01
+#define QCOM_SCM_WAITQ_RESUME			0x02
+#define QCOM_SCM_WAITQ_GET_WQ_CTX		0x03
+
 extern void __qcom_scm_init(void);
 
 /* common error codes */
@@ -141,6 +151,8 @@ extern void __qcom_scm_init(void);
 #define QCOM_SCM_EINVAL_ARG	-2
 #define QCOM_SCM_ERROR		-1
 #define QCOM_SCM_INTERRUPTED	1
+#define QCOM_SCM_WAITQ_SLEEP	2
+#define QCOM_SCM_WAITQ_WAKE	3
 
 static inline int qcom_scm_remap_error(int err)
 {
-- 
2.7.4

