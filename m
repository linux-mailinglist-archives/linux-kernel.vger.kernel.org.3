Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA24BDD43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiBULKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355457AbiBULKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:10:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67325EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:41:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1042252wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMcxbuw6I6KTX07OCnquH99Hzxoc4oIUIzEIajyR3Yc=;
        b=aMCfeRwMKXBIimw4TBzFj85xCm0lDCzNtDN3dZXJfWrWc8IMyECCsBq1jslJuMWLHy
         HPqXKulqgipa6mBmEnn3JkU1Fzyysnl3d0uPk8ZcCK1uB2h8QWIoIFz0Oi7aOSn6UyJT
         jz7UkphKfHQ3vkotJZQMqe7nz7jpjJwpJfEAC+zJnixrP10IOWuqj98gYkPjuJ+gC/vH
         jojjMJ7onKKHgKWFrmqLjvfC3Ey2hNdM8ls6yx7buwvz4XLb+g8y70tgum0Y585u3hTP
         DEHw8byPVcc2LGlL7ssk8DcnqRAAFhU3VhBKjF50BmesxaMG4BKmUTE8wbIEHCVz+nm1
         Mjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMcxbuw6I6KTX07OCnquH99Hzxoc4oIUIzEIajyR3Yc=;
        b=PRz/lvBlKojE+JOLjInExK/x+eHzQHG2KvF5ujiwi/R7Rf1doOTw/XUtBxTffNca9e
         aUM1N/p3mEISOiBHgzk3CenJE+TQGCKnAlgULlwBK0aguOJEZuTdHXbwej9aFVwcBY7v
         oUYirui4mpf+4N9k7Yfz3C+WNVTPhLK/rMEoYss7OMogFZG1QMQR3ssugNiWddApdlja
         yi/YZJm68lJutZrpFAcoIf/jMCjRafyZWZdlK9lGLWBXpYJDXI0GWBwdYX4XkhfKOnXD
         nsLhzn7Mvl/9mP3/2EFI/0VqwmVOC8Hy0VCk0hF1UNntlICH5SA5WARYDLSrE1XmI7Ul
         C6Cw==
X-Gm-Message-State: AOAM531urlH+Mc0isxOLJIwHhSlLlPw3zuT/dL/s3jLK1Z/5xwAR0cJi
        aM3E0me79J9c4D7C9HbXg8xErA==
X-Google-Smtp-Source: ABdhPJxXek3z/IqIcPNmes42fE7hmTRzBr2LPQ2Ztup4nG4rhEXOxSj7rikJ7T2bKIhQwvS4iJMWGw==
X-Received: by 2002:a05:600c:1583:b0:346:3f83:6b8 with SMTP id r3-20020a05600c158300b003463f8306b8mr16940773wmf.75.1645440102448;
        Mon, 21 Feb 2022 02:41:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0037c06fe68casm7584817wmq.44.2022.02.21.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:41:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Date:   Mon, 21 Feb 2022 10:41:27 +0000
Message-Id: <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the Qualcomm SoundWire Controller instances like the ones that are
connected to RX path along with Headset connections support Waking up
Controller from Low power clock stop state.

Add support to this wake up interrupt.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3b2eb95a7e96..b9b76031307b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slimbus.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -154,6 +155,7 @@ struct qcom_swrm_ctrl {
 	u8 rd_cmd_id;
 	int irq;
 	unsigned int version;
+	int wake_irq;
 	int num_din_ports;
 	int num_dout_ports;
 	int cols_index;
@@ -503,6 +505,46 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 	return 0;
 }
 
+static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
+{
+	struct qcom_swrm_ctrl *swrm = dev_id;
+	int ret = IRQ_HANDLED;
+	struct sdw_slave *slave;
+
+	clk_prepare_enable(swrm->hclk);
+
+	if (swrm->wake_irq > 0) {
+		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
+			disable_irq_nosync(swrm->wake_irq);
+	}
+
+	/*
+	 * resume all the slaves which must have potentially generated this
+	 * interrupt, this should also wake the controller at the same time.
+	 * this is much safer than waking controller directly that will deadlock!
+	 */
+	list_for_each_entry(slave, &swrm->bus.slaves, node) {
+		ret = pm_runtime_get_sync(&slave->dev);
+		if (ret < 0 && ret != -EACCES) {
+			dev_err_ratelimited(swrm->dev,
+					    "pm_runtime_get_sync failed in %s, ret %d\n",
+					    __func__, ret);
+			pm_runtime_put_noidle(&slave->dev);
+			ret = IRQ_NONE;
+			goto err;
+		}
+	}
+
+	list_for_each_entry(slave, &swrm->bus.slaves, node) {
+		pm_runtime_mark_last_busy(&slave->dev);
+		pm_runtime_put_autosuspend(&slave->dev);
+	}
+err:
+	clk_disable_unprepare(swrm->hclk);
+	return IRQ_HANDLED;
+}
+
+
 static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 {
 	struct qcom_swrm_ctrl *swrm = dev_id;
@@ -1340,6 +1382,19 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
+	if (ctrl->wake_irq > 0) {
+		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
+						qcom_swrm_wake_irq_handler,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						"swr_wake_irq", ctrl);
+		if (ret) {
+			dev_err(dev, "Failed to request soundwire wake irq\n");
+			goto err_init;
+		}
+	}
+
+
 	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
@@ -1424,6 +1479,11 @@ static int swrm_runtime_resume(struct device *dev)
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
+	if (ctrl->wake_irq > 0) {
+		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
+			disable_irq_nosync(ctrl->wake_irq);
+	}
+
 	clk_prepare_enable(ctrl->hclk);
 
 	if (ctrl->clk_stop_bus_reset) {
@@ -1485,6 +1545,11 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 
 	usleep_range(300, 305);
 
+	if (ctrl->wake_irq > 0) {
+		if (irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
+			enable_irq(ctrl->wake_irq);
+	}
+
 	return 0;
 }
 
-- 
2.21.0

