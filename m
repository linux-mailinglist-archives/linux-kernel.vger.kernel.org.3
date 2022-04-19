Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E0506743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350221AbiDSI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350187AbiDSI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:56:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9422B19;
        Tue, 19 Apr 2022 01:54:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23J7qMxT019642;
        Tue, 19 Apr 2022 10:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=PmNWK/G60m8uo7lwEsmyR6Xq46F+sObo1bwuEDT0XE8=;
 b=SxJeaShrIX/myy4DuDAbnnV6ji+0iFymXGHJxhAQ2JoZSELXBHCdM54eGtGKBtvFmhfb
 J3gxQESWWzMDKrqJ9W92ohgucGCQhV6h+yt2ZM0yihqLGx6zRG3k2pfiJ9qrlt0z10TB
 bkQBjKBIVm5T8af4SQfz4kvivI3bHcP3pbNTageSo/OkTTextNYrToX/Zf6rivG1BC7m
 KEEPipPenmd5nrq0iMnTRn0KGlIzeWC2nhpRh1wTF8Ozf69UAowOeVij2Mn3po08feaA
 atqVnhQpPFEdG/droQ0FOc82rNwhFD2iO/EeGGW+RxBZ4Od1Y3uKORmFfkvtgVwNjfrp ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fh09kpfpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 10:53:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60EFE100039;
        Tue, 19 Apr 2022 10:53:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B7CE2053D3;
        Tue, 19 Apr 2022 10:53:48 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 19 Apr 2022 10:53:47
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 3/3] serial: stm32: add earlycon support
Date:   Tue, 19 Apr 2022 10:53:30 +0200
Message-ID: <20220419085330.1178925-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419085330.1178925-1-valentin.caron@foss.st.com>
References: <20220419085330.1178925-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_03,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early console support in stm32 uart driver.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/Kconfig       |  1 +
 drivers/tty/serial/stm32-usart.c | 51 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

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
index 8aefb286bd88..f75691e72729 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1761,6 +1761,57 @@ static struct console stm32_console = {
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

