Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AF4A89C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352766AbiBCRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:19:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41050 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352675AbiBCRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:18:59 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213FKZHg012451;
        Thu, 3 Feb 2022 18:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=AglS7CjM5YP8DK4AQeHdlXrIgQZulAnAMUNDfA9asfI=;
 b=4xqXISGNWGY2Emt4pZgDgvrVc6aW8PdwBS7cEazVIKK7mVQ5BDnE3x7ddDEQ5zLvlzsL
 sqY4mc2ZpxrkXFwBmTH1E+Hwi73ZO++7xKgqZVK+RZ114598SZTeI2Aw40kRF2d/pdj0
 sQctKqVRERDt+ZDaiu+RoqB5MJBQVGgoOqQVeZ0UXft6uHCB4CSA3m29ICRsCrHF8xE7
 FsxhJMclYTqaCizuhzuhM9UlLpDrfOu+JsLHdqv+sEZUXCpljLB9fMkLBR0Oletzcv9q
 NI59qUmEXDuufa9qJSYrqf0Sh7p/HOAzIJ7juLoWAIANerbjNM2JnbMGoO+TSpNxTFAq uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0c4fje1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:16:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59AD5100034;
        Thu,  3 Feb 2022 18:16:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5150422F7AF;
        Thu,  3 Feb 2022 18:16:48 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:16:47
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] serial: mctrl_gpio: add a new API to enable / disable wake_irq
Date:   Thu, 3 Feb 2022 18:16:43 +0100
Message-ID: <20220203171644.12231-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171644.12231-1-erwan.leray@foss.st.com>
References: <20220203171644.12231-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new API to enable / disable wake_irq in order to enable gpio irqs as
wakeup irqs for the uart port.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index c41d8911ce95..1663b3afc3a0 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -299,4 +299,42 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
 
+void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (!gpios)
+		return;
+
+	if (!gpios->mctrl_on)
+		return;
+
+	for (i = 0; i < UART_GPIO_MAX; ++i) {
+		if (!gpios->irq[i])
+			continue;
+
+		enable_irq_wake(gpios->irq[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_enable_irq_wake);
+
+void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (!gpios)
+		return;
+
+	if (!gpios->mctrl_on)
+		return;
+
+	for (i = 0; i < UART_GPIO_MAX; ++i) {
+		if (!gpios->irq[i])
+			continue;
+
+		disable_irq_wake(gpios->irq[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_irq_wake);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index b134a0ffc894..fc76910fb105 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -91,6 +91,16 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
  */
 void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
 
+/*
+ * Enable gpio wakeup interrupts to enable wake up source.
+ */
+void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios);
+
+/*
+ * Disable gpio wakeup interrupts to enable wake up source.
+ */
+void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios);
+
 #else /* GPIOLIB */
 
 static inline
@@ -142,6 +152,14 @@ static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 {
 }
 
+static inline void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
+{
+}
+
+static inline void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
+{
+}
+
 #endif /* GPIOLIB */
 
 #endif
-- 
2.17.1

