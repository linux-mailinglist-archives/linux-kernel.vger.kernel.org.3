Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC640570185
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiGKMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGKMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:01:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3137F9A;
        Mon, 11 Jul 2022 05:01:50 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B7rbCu031037;
        Mon, 11 Jul 2022 14:01:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=0D+QICwuMJjMUowKXseLMhNC9cUJEgGQwNXk/NCdjUw=;
 b=UivEsLwxVhimION6NOwNAtbhDi8OL/LYzSHUWU9t0R7ZR6ESp6XW9LDyxJW7TmdzhBZR
 jR9nKRG3q04PfXzUZ1aWBA7Qnc7gZba7InffVwnbMeVWJen6lePQdXhlIyo83ajQbONg
 LRwtZaQlIiSqnLD/PiugkXeuYV3uKAGX8qlX/wayd+JD2DlpZihZcHstjtvHSX+o/Ya0
 VS1SP/9YSHmLgq4+ysD7WlKuVyVZ9y4ROZkUo5Ho5EG9EHDnOUIBCqgRbCGd4OeqvxQI
 pThaCzl7vpceT5YsLoRf4cAMckON1LK2lP2h+/QFXz4aYi1djDIcNqM8StxrhW8vgvmf kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h6y3mu6g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 14:01:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F9B610002A;
        Mon, 11 Jul 2022 14:01:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A5F721ED2B;
        Mon, 11 Jul 2022 14:01:41 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 11 Jul
 2022 14:01:39 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 4/4] usb: typec: ucsi: stm32g0: add support for power management
Date:   Mon, 11 Jul 2022 14:01:22 +0200
Message-ID: <20220711120122.25804-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_17,2022-07-08_01,2022-06-22_01
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
index b1d891c9a92c0..061551d464f12 100644
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

