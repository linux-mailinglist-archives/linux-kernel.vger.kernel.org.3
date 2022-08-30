Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195E5A70D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiH3W1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiH3W07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:26:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C48520A7;
        Tue, 30 Aug 2022 15:25:33 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UK1XGn009466;
        Tue, 30 Aug 2022 22:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=N5jo3cXf1pHUAhz7MPG4SablCWfdRBY03Ry80OidHIY=;
 b=N5ZjmgYKefwqW2/riNv89ROnFmGbpnhyzX17l8jP6nxiUj9Ru5D0pgOXMCVbkzceNkmy
 R0qm60c/3nY35kVHUYoT+4giyCoVakdx4K5+nKLIGV6UXFXVkMnr6NT7xgP/fYNnfAbu
 ouoGxIbkXaAONwVo762ufb1EjoP/KWx/gDrHlp2lR3bfcJIUHhDdZrIvmKlz/hj1orcj
 6aBF8Bq7jSQ0UOl5SVXxrEXQ99vYJbBsNFA/Ta0LZjbYdYgMqUjrcwAoMQCR8x0G8r34
 f9w8oEsTJ7RieXOOX5fKBpYdJs0uAF+XyQfPOlPlvUrcYgC5ONZDW/CfrI7oGK/YVWSe Rg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9qdm0u1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:20 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27UMPJae008290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:19 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 30 Aug 2022 15:25:19 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [RESEND PATCH v2 5/5] firmware: qcom: scm: Add wait-queue handling logic
Date:   Tue, 30 Aug 2022 15:25:11 -0700
Message-ID: <1661898311-30126-6-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p_NwbDbAG9I0Gb77UnXm6PVAC1CZDANf
X-Proofpoint-GUID: p_NwbDbAG9I0Gb77UnXm6PVAC1CZDANf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add logic to handle QCOM_SCM_WAITQ_SLEEP or QCOM_SCM_WAITQ_WAKE return
codes.

Scenario 1: Requests made by 2 different VMs:

  VM_1                     VM_2                            Firmware
    │                        │                                 │
    │                        │                                 │
    │                        │                                 │
    │                        │                                 │
    │      REQUEST_1         │                                 │
    ├────────────────────────┼─────────────────────────────────┤
    │                        │                                 │
    │                        │                              ┌──┼──┐
    │                        │                              │  │  │
    │                        │     REQUEST_2                │  │  │
    │                        ├──────────────────────────────┼──┤  │
    │                        │                              │  │  │Resource
    │                        │                              │  │  │is busy
    │                        │       {WQ_SLEEP}             │  │  │
    │                        │◄─────────────────────────────┼──┤  │
    │                        │  wq_ctx, smc_call_ctx        │  │  │
    │                        │                              └──┼──┘
    │   REQUEST_1 COMPLETE   │                                 │
    │◄───────────────────────┼─────────────────────────────────┤
    │                        │                                 │
    │                        │         IRQ                     │
    │                        │◄─-------------------------------│
    │                        │                                 │
    │                        │      get_wq_ctx()               │
    │                        ├────────────────────────────────►│
    │                        │                                 │
    │                        │                                 │
    │                        │◄────────────────────────────────┤
    │                        │   wq_ctx, flags, and            │
    │                        │        more_pending             │
    │                        │                                 │
    │                        │                                 │
    │                        │ wq_resume(smc_call_ctx)         │
    │                        ├────────────────────────────────►│
    │                        │                                 │
    │                        │                                 │
    │                        │      REQUEST_2 COMPLETE         │
    │                        │◄────────────────────────────────┤
    │                        │                                 │
    │                        │                                 │

Scenario 2: Two Requests coming in from same VM:

  VM_1                                                     Firmware
    │                                                          │
    │                                                          │
    │                                                          │
    │                                                          │
    │      REQUEST_1                                           │
    ├──────────────────────────────────────────────────────────┤
    │                                                          │
    │                                                     ┌────┼───┐
    │                                                     │    │   │
    │                                                     │    │   │
    │                                                     │    │   │
    │      REQUEST_2                                      │    │   │
    ├─────────────────────────────────────────────────────┼───►│   │
    │                                                     │    │   │Resource
    │                                                     │    │   │is busy
    │      {WQ_SLEEP}                                     │    │   │
    │◄────────────────────────────────────────────────────┼────┤   │
    │      wq_ctx, req2_smc_call_ctx                      │    │   │
    │                                                     │    │   │
    │                                                     └────┼───┘
    │                                                          │
    │      {WQ_WAKE}                                           │
    │◄─────────────────────────────────────────────────────────┤
    │      wq_ctx, req1_smc_call_ctx, flags                    │
    │                                                          │
    │                                                          │
    │      wq_wake_ack(req1_smc_call_ctx)                      │
    ├─────────────────────────────────────────────────────────►│
    │                                                          │
    │      REQUEST_1 COMPLETE                                  │
    │◄─────────────────────────────────────────────────────────┤
    │                                                          │
    │                                                          │
    │      wq_resume(req_2_smc_call_ctx)                       │
    ├─────────────────────────────────────────────────────────►│
    │                                                          │
    │      REQUEST_2 COMPLETE                                  │
    │◄─────────────────────────────────────────────────────────┤
    │                                                          │

With the exception of get_wq_ctx(), the other two newly-introduced SMC
calls, wq_ack() and wq_resume() can themselves return WQ_SLEEP (these
nested rounds of WQ_SLEEP are not shown in the above diagram for the
sake of simplicity). Therefore, introduce a new do-while loop to handle
multiple WQ_SLEEP return values for the same parent SCM call.

Request Completion in the above diagram refers to either a success
return value (zero) or error (and not SMC_WAITQ_SLEEP or
SMC_WAITQ_WAKE).

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 drivers/firmware/qcom_scm-smc.c | 76 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index 4150da1..09cca48 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -53,6 +53,9 @@ static void __scm_smc_do_quirk(const struct arm_smccc_args *smc,
 	} while (res->a0 == QCOM_SCM_INTERRUPTED);
 }
 
+#define IS_WAITQ_SLEEP_OR_WAKE(res) \
+	(res->a0 == QCOM_SCM_WAITQ_SLEEP || res->a0 == QCOM_SCM_WAITQ_WAKE)
+
 static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
 {
 	memset(resume->args, 0, ARRAY_SIZE(resume->args));
@@ -109,25 +112,77 @@ int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending)
 	return 0;
 }
 
-static void __scm_smc_do(const struct arm_smccc_args *smc,
+static int scm_smc_do_quirk(struct device *dev, struct arm_smccc_args *smc,
+			    struct arm_smccc_res *res)
+{
+	struct completion *wq = NULL;
+	struct qcom_scm *qscm;
+	u32 wq_ctx, smc_call_ctx, flags;
+
+	do {
+		__scm_smc_do_quirk(smc, res);
+
+		if (IS_WAITQ_SLEEP_OR_WAKE(res)) {
+			wq_ctx = res->a1;
+			smc_call_ctx = res->a2;
+			flags = res->a3;
+
+			if (!dev)
+				return -EPROBE_DEFER;
+
+			qscm = dev_get_drvdata(dev);
+			wq = qcom_scm_lookup_wq(qscm, wq_ctx);
+			if (IS_ERR_OR_NULL(wq)) {
+				pr_err("No waitqueue found for wq_ctx %d: %ld\n",
+						wq_ctx, PTR_ERR(wq));
+				return PTR_ERR(wq);
+			}
+
+			if (res->a0 == QCOM_SCM_WAITQ_SLEEP) {
+				wait_for_completion(wq);
+				fill_wq_resume_args(smc, smc_call_ctx);
+				wq = NULL;
+				continue;
+			} else {
+				fill_wq_wake_ack_args(smc, smc_call_ctx);
+				continue;
+			}
+		} else if (!res->a0 || (long)res->a0 < 0) {
+			/*
+			 * Success, or error.
+			 * wq will be set only if a prior WAKE happened.
+			 * Its value will be the one from the prior WAKE.
+			 */
+			if (wq)
+				scm_waitq_flag_handler(wq, flags);
+			break;
+		}
+	} while (IS_WAITQ_SLEEP_OR_WAKE(res));
+
+	return 0;
+}
+
+static int __scm_smc_do(struct device *dev, struct arm_smccc_args *smc,
 			 struct arm_smccc_res *res, bool atomic)
 {
-	int retry_count = 0;
+	int ret, retry_count = 0;
 
 	if (atomic) {
 		__scm_smc_do_quirk(smc, res);
-		return;
+		return 0;
 	}
 
 	do {
 		if (!qcom_scm_allow_multicall)
 			mutex_lock(&qcom_scm_lock);
 
-		__scm_smc_do_quirk(smc, res);
+		ret = scm_smc_do_quirk(dev, smc, res);
 
 		if (!qcom_scm_allow_multicall)
 			mutex_unlock(&qcom_scm_lock);
 
+		if (ret)
+			return ret;
 
 		if (res->a0 == QCOM_SCM_V2_EBUSY) {
 			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
@@ -135,6 +190,8 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
 			msleep(QCOM_SCM_EBUSY_WAIT_MS);
 		}
 	}  while (res->a0 == QCOM_SCM_V2_EBUSY);
+
+	return 0;
 }
 
 
@@ -143,7 +200,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		   struct qcom_scm_res *res, bool atomic)
 {
 	int arglen = desc->arginfo & 0xf;
-	int i;
+	int i, ret;
 	dma_addr_t args_phys = 0;
 	void *args_virt = NULL;
 	size_t alloc_len;
@@ -195,19 +252,24 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
 	}
 
-	__scm_smc_do(&smc, &smc_res, atomic);
+	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
+	/* ret error check follows after args_virt cleanup*/
 
 	if (args_virt) {
 		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
 		kfree(args_virt);
 	}
 
+	if (ret)
+		return ret;
+
 	if (res) {
 		res->result[0] = smc_res.a1;
 		res->result[1] = smc_res.a2;
 		res->result[2] = smc_res.a3;
 	}
 
-	return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
+	ret = (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
 
+	return ret;
 }
-- 
2.7.4

