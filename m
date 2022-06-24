Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA9559DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiFXPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFXPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:54:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BE2B249;
        Fri, 24 Jun 2022 08:54:52 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OACoqK008409;
        Fri, 24 Jun 2022 17:54:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=4r2PCbf64n8yNmLDUAE0q0TrU9hPbWG72osAS8laDjs=;
 b=6fpoD94BsSrRP+1zS8jaMalI9UEVkeKgfUQn7CmysKIb4WPdV5LrLZ77EFHYcse6d63p
 qWo9yPM3PqDuWRtVP33gWxhKD4fL61SRb1NWYKVCF5hrmkIbAnr2dYKYm7Jwxwx6K1Jo
 ZZXX0hmS0zkCsrUKp2jm9DZGYtP6qWOl8tyNSkhXoJ58VdRz6PPPy2lIX6bDxnqQFs6+
 2pg+QjUJdmMvgrW8hLpGam9rJ2KLVUd1qcT7SvAPeM516zEN7xgglUroVU+KF5kuH7Ji
 UDpurqGdq3y1lXFnzwv2ylPadS3huOfGjTZb2nTZyUnp9VUejl5tbgwmqTMbYU9mXmqM sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gwbaqhn89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 17:54:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BD7F10002A;
        Fri, 24 Jun 2022 17:54:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95EC1226FB9;
        Fri, 24 Jun 2022 17:54:30 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 24 Jun
 2022 17:54:27 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <robh+dt@kernel.org>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 4/4] usb: typec: ucsi: stm32g0: add support for power management
Date:   Fri, 24 Jun 2022 17:54:13 +0200
Message-ID: <20220624155413.399190-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type-C connector can be used as a wakeup source (typically to detect
changes on the port, attach or detach...).
Add suspend / resume routines to enable wake irqs, and signal a wakeup
event in case the IRQ has fired while in suspend.
The i2c core is doing the necessary initialization when the "wakeup-source"
flag is provided.
Note: the interrupt handler shouldn't be called before the i2c bus resumes.
So, the interrupts are disabled during suspend period, and re-enabled
upon resume, to avoid i2c transfer while suspended, from the irq handler.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 91222f4e07aee..1c7f4b92eba7c 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -66,6 +66,8 @@ struct ucsi_stm32g0 {
 	unsigned long flags;
 	const char *fw_name;
 	struct ucsi *ucsi;
+	bool suspended;
+	bool wakeup_event;
 };
 
 /*
@@ -416,6 +418,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 	u32 cci;
 	int ret;
 
+	if (g0->suspended)
+		g0->wakeup_event = true;
+
 	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
 	if (ret)
 		return IRQ_NONE;
@@ -696,6 +701,52 @@ static int ucsi_stm32g0_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int ucsi_stm32g0_suspend(struct device *dev)
+{
+	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
+	struct i2c_client *client = g0->client;
+
+	if (g0->in_bootloader)
+		return 0;
+
+	/* Keep the interrupt disabled until the i2c bus has been resumed */
+	disable_irq(client->irq);
+
+	g0->suspended = true;
+	g0->wakeup_event = false;
+
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int ucsi_stm32g0_resume(struct device *dev)
+{
+	struct ucsi_stm32g0 *g0 = dev_get_drvdata(dev);
+	struct i2c_client *client = g0->client;
+
+	if (g0->in_bootloader)
+		return 0;
+
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
+		disable_irq_wake(client->irq);
+
+	enable_irq(client->irq);
+
+	/* Enforce any pending handler gets called to signal a wakeup_event */
+	synchronize_irq(client->irq);
+
+	if (g0->wakeup_event)
+		pm_wakeup_event(g0->dev, 0);
+
+	g0->suspended = false;
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_stm32g0_pm_ops, ucsi_stm32g0_suspend, ucsi_stm32g0_resume);
+
 static const struct of_device_id __maybe_unused ucsi_stm32g0_typec_of_match[] = {
 	{ .compatible = "st,stm32g0-typec" },
 	{},
@@ -712,6 +763,7 @@ static struct i2c_driver ucsi_stm32g0_i2c_driver = {
 	.driver = {
 		.name = "ucsi-stm32g0-i2c",
 		.of_match_table = of_match_ptr(ucsi_stm32g0_typec_of_match),
+		.pm = pm_sleep_ptr(&ucsi_stm32g0_pm_ops),
 	},
 	.probe = ucsi_stm32g0_probe,
 	.remove = ucsi_stm32g0_remove,
-- 
2.25.1

