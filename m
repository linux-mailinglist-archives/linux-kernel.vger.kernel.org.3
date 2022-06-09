Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00083544B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbiFILxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiFILxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:53:36 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA125B3E7;
        Thu,  9 Jun 2022 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654775616; x=1686311616;
  h=from:to:cc:subject:date:message-id;
  bh=rXxUa0melhK2Wd5mZ1pSFJIMTnkN6Dt+DnEZ70b/m30=;
  b=BC/txaDcE2M+DjkO28/BNAGOaFgN1wYeNUSq/xTGbEkDmlXnR/S0/x9w
   pNjZHEhvKXxaX6VHUtACjDXOLRYfrxlzacp8S9MyyGDQPe+iM0sYyS9Lm
   06chV9qiAwbKjMRs5J79zL6pMji3IaOtgyOngCOSEHLvKPhANummEqxCa
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2022 04:53:34 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2022 04:53:02 -0700
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg02-blr.qualcomm.com with ESMTP; 09 Jun 2022 17:22:53 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id A7CBC4598; Thu,  9 Jun 2022 17:22:51 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, stanimir.varbanov@linaro.org,
        quic_vgarodia@quicinc.com, swboyd@chromium.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] venus: Add support for SSR trigger using fault injection
Date:   Thu,  9 Jun 2022 17:22:46 +0530
Message-Id: <1654775566-21953-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we introduce a new fault injection for SSR trigger.

To trigger the SSR:
 echo 100 > /sys/kernel/debug/venus/fail_ssr/probability
 echo 1 > /sys/kernel/debug/venus/fail_ssr/times

signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c  | 15 ++++++++++++++-
 drivers/media/platform/qcom/venus/dbgfs.c | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/dbgfs.h |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 877eca1..abfa5d6 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -265,6 +265,19 @@ static void venus_assign_register_offsets(struct venus_core *core)
 	}
 }
 
+static irqreturn_t venus_isr_thread(int irq, void *dev_id)
+{
+	struct venus_core *core = dev_id;
+	irqreturn_t ret;
+
+	ret = hfi_isr_thread(irq, dev_id);
+
+	if (ret == IRQ_HANDLED && venus_fault_inject_ssr())
+		hfi_core_trigger_ssr(core, HFI_TEST_SSR_SW_ERR_FATAL);
+
+	return ret;
+}
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -320,7 +333,7 @@ static int venus_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 	init_waitqueue_head(&core->sys_err_done);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
index 52de47f..a0bfb9e 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.c
+++ b/drivers/media/platform/qcom/venus/dbgfs.c
@@ -4,13 +4,31 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/fault-inject.h>
 
 #include "core.h"
 
+#ifdef CONFIG_FAULT_INJECTION
+static DECLARE_FAULT_ATTR(venus_ssr_attr);
+#endif
+
+bool venus_fault_inject_ssr(void)
+{
+#ifdef CONFIG_FAULT_INJECTION
+	return should_fail(&venus_ssr_attr, 1);
+#else
+	return false;
+#endif
+}
+
 void venus_dbgfs_init(struct venus_core *core)
 {
 	core->root = debugfs_create_dir("venus", NULL);
 	debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
+
+#ifdef CONFIG_FAULT_INJECTION
+	fault_create_debugfs_attr("fail_ssr", core->root, &venus_ssr_attr);
+#endif
 }
 
 void venus_dbgfs_deinit(struct venus_core *core)
diff --git a/drivers/media/platform/qcom/venus/dbgfs.h b/drivers/media/platform/qcom/venus/dbgfs.h
index b7b621a..b0d0686 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.h
+++ b/drivers/media/platform/qcom/venus/dbgfs.h
@@ -8,5 +8,6 @@ struct venus_core;
 
 void venus_dbgfs_init(struct venus_core *core);
 void venus_dbgfs_deinit(struct venus_core *core);
+bool venus_fault_inject_ssr(void);
 
 #endif
-- 
2.7.4

