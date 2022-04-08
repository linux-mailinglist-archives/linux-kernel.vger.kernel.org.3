Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC34F95C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiDHM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiDHM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:29:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366A33DCAC;
        Fri,  8 Apr 2022 05:27:26 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2389i7HP000594;
        Fri, 8 Apr 2022 14:27:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=kl/405WO6BWkxCmfDNNimImVgYIdQ5yPoKlOLHS/+kc=;
 b=yjXu8DxGT9GVFUcdu8MFk0cHGGuYhB/tXiRBU3q8ICaJp+5a/oLaw5E6PAlAiXvEbRrA
 fEs6bgmd3k4/O2G3GfVHU2p6HKJkpzSbF7hTX9acyqHRKTxQ9zuAB2xjenwTAtQPiHqR
 ySb5z4ze8xkxUIP4JHcD4SutI4+yv/uDcgn+iWI6Q0ZNYF4wCw8MVIoiakN5Nfhv/q6j
 0WypSfw5hWNSwmzZ0ckAHKVeDK10mguIGmzaWUl2mXVIiGLbXpPY4E9UBGjHDxouvXGe
 X7lKQRSjESg8IC9Av/PWp15FOqHN/akBb3nj1yKMFo6iw9hRVdAbhYA6vUgSMBNue+gd EQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f9wr7r1pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:27:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BDA310002A;
        Fri,  8 Apr 2022 14:27:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9409221A21E;
        Fri,  8 Apr 2022 14:27:04 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 8 Apr 2022 14:27:04
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH V2 3/3] serial: stm32: add earlycon support
Date:   Fri, 8 Apr 2022 14:26:36 +0200
Message-ID: <20220408122636.505737-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408122636.505737-1-valentin.caron@foss.st.com>
References: <20220408122636.505737-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early console support in stm32 uart driver.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 drivers/tty/serial/Kconfig                    |  1 +
 drivers/tty/serial/stm32-usart.c              | 51 +++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..e941c3351c7a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1264,6 +1264,12 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+		stm32,<addr>
+			Use early console provided by ST Microelectronics
+			serial driver for STM32 SoCs. A valid base address
+			must be provided, and the serial port must already
+			be setup and configured.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6949e883ffab..ed59de8d2e11 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1443,6 +1443,7 @@ config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
 	depends on SERIAL_STM32=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 
 config SERIAL_MVEBU_UART
 	bool "Marvell EBU serial port support"
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4307c822afe4..65988e6efaa2 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1766,6 +1766,57 @@ static struct console stm32_console = {
 #define STM32_SERIAL_CONSOLE NULL
 #endif /* CONFIG_SERIAL_STM32_CONSOLE */
 
+#ifdef CONFIG_SERIAL_EARLYCON
+static void early_stm32_usart_console_putchar(struct uart_port *port, unsigned char ch)
+{
+	struct stm32_usart_info *info = port->private_data;
+
+	while (!(readl_relaxed(port->membase + info->ofs.isr) & USART_SR_TXE))
+		cpu_relax();
+
+	writel_relaxed(ch, port->membase + info->ofs.tdr);
+}
+
+static void early_stm32_serial_write(struct console *console, const char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+
+	uart_console_write(port, s, count, early_stm32_usart_console_putchar);
+}
+
+static int __init early_stm32_h7_serial_setup(struct earlycon_device *device, const char *options)
+{
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+	device->port.private_data = &stm32h7_info;
+	device->con->write = early_stm32_serial_write;
+	return 0;
+}
+
+static int __init early_stm32_f7_serial_setup(struct earlycon_device *device, const char *options)
+{
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+	device->port.private_data = &stm32f7_info;
+	device->con->write = early_stm32_serial_write;
+	return 0;
+}
+
+static int __init early_stm32_f4_serial_setup(struct earlycon_device *device, const char *options)
+{
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+	device->port.private_data = &stm32f4_info;
+	device->con->write = early_stm32_serial_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(stm32, "st,stm32h7-uart", early_stm32_h7_serial_setup);
+OF_EARLYCON_DECLARE(stm32, "st,stm32f7-uart", early_stm32_f7_serial_setup);
+OF_EARLYCON_DECLARE(stm32, "st,stm32-uart", early_stm32_f4_serial_setup);
+#endif /* CONFIG_SERIAL_EARLYCON */
+
 static struct uart_driver stm32_usart_driver = {
 	.driver_name	= DRIVER_NAME,
 	.dev_name	= STM32_SERIAL_NAME,
-- 
2.25.1

