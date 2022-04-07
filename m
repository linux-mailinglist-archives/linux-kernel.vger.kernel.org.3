Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF744F7F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiDGMd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiDGMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:33:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A27111DD9;
        Thu,  7 Apr 2022 05:31:52 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237Apxw5009451;
        Thu, 7 Apr 2022 14:31:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=RkFXAMUowl44G0ueDYkkdPxY3P5C7zGyMGGVecJva2Y=;
 b=qJPsPhDZNG7ILBg3j48jtq6ErUELDESuHXm8DHNK8PBe/l67FlCniqBVRqsdv4SN28RJ
 D3rJheR7BVVq0p76whC2zhZ1hK8lvaFDrrp1q0epEIeRAXDNLWqdyh/Ua/Pw7kKQOLDO
 /Bbw2aMHu1Fm1C4wbvfBqp3R969k50EN9BKcijzI/9NwW+FwbvSK3zV9Gizu//WHmIZ+
 Pr/OnX4NEaCCX105iMnOydeqq3iqLl7Iumb/XeY75IxYmu0XAViHW1BiIWZeMr1xJUVx
 KyMoHVxk+wRmdcpM9YgHR6N6Ew1D69ViTlh9xFHjo1h5q5GhIBxrBoAKgHTNiDPZhX8s 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f8x4rkxq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:31:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA063100034;
        Thu,  7 Apr 2022 14:31:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1A8A21A23E;
        Thu,  7 Apr 2022 14:31:23 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 7 Apr 2022 14:31:23
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
Subject: [PATCH 2/3] serial: stm32: add KGDB support
Date:   Thu, 7 Apr 2022 14:31:08 +0200
Message-ID: <20220407123109.132035-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407123109.132035-1-valentin.caron@foss.st.com>
References: <20220407123109.132035-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_01,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for KGDB in stm32 serial driver by implementing characters
polling callbacks (poll_init, poll_get_char and poll_put_char).

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 83895da84891..d2cf789c7997 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -37,6 +37,7 @@
 
 static void stm32_usart_stop_tx(struct uart_port *port);
 static void stm32_usart_transmit_chars(struct uart_port *port);
+static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch);
 
 static inline struct stm32_port *to_stm32_port(struct uart_port *port)
 {
@@ -1222,6 +1223,34 @@ static void stm32_usart_pm(struct uart_port *port, unsigned int state,
 	}
 }
 
+#if defined(CONFIG_CONSOLE_POLL)
+
+ /* Callbacks for characters polling in debug context (i.e. KGDB). */
+static int stm32_usart_poll_init(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+
+	return clk_prepare_enable(stm32_port->clk);
+}
+
+static int stm32_usart_poll_get_char(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	unsigned int ret;
+
+	if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_RXNE))
+		return NO_POLL_CHAR;
+
+	return readl_relaxed(port->membase + ofs->rdr) & stm32_port->rdr_mask;
+}
+
+static void stm32_usart_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	stm32_usart_console_putchar(port, ch);
+}
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops stm32_uart_ops = {
 	.tx_empty	= stm32_usart_tx_empty,
 	.set_mctrl	= stm32_usart_set_mctrl,
@@ -1243,6 +1272,11 @@ static const struct uart_ops stm32_uart_ops = {
 	.request_port	= stm32_usart_request_port,
 	.config_port	= stm32_usart_config_port,
 	.verify_port	= stm32_usart_verify_port,
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_init      = stm32_usart_poll_init,
+	.poll_get_char	= stm32_usart_poll_get_char,
+	.poll_put_char	= stm32_usart_poll_put_char,
+#endif /* CONFIG_CONSOLE_POLL */
 };
 
 /*
@@ -1640,8 +1674,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_SERIAL_STM32_CONSOLE
-static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch)
+static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -1658,6 +1691,7 @@ static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch
 	writel_relaxed(ch, port->membase + ofs->tdr);
 }
 
+#ifdef CONFIG_SERIAL_STM32_CONSOLE
 static void stm32_usart_console_write(struct console *co, const char *s,
 				      unsigned int cnt)
 {
-- 
2.25.1

