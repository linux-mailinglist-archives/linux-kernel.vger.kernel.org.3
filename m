Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C037B4847CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiADS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:26:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234722AbiADS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:26:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204Fl3C0000695;
        Tue, 4 Jan 2022 19:25:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=EmaCNQG+Q/QyoPh8mOP54/7kFsIBopyu5UuhmradxZs=;
 b=BKGF4CyHWjrDxUepRGn9XQ1x9hMvi9YZY3Un7Q0/jtwtjscLVPrknE1BI2SAtCpQYrDi
 ghIqX9rg4RzOgIQg/eg/x61g+ShihDnzZ18nlwcl/pQp/x0ARXcwuDDHypj+OIOd1tBp
 5FYbAKMjsJwDaOlTOdleIrf9FreWd6n2Axvv2xIwmVcIqUv+kyDX3Hzvh4pkKXsJ527+
 mp53s8rgxgsnK6dal/GBDFbWyhxcxvEPM5UopuDjeecqz1YF6JPUt/kH5CRiIRb39gr9
 MtNDCjt+5lHP1yad4PT6T7SABGheKkS0KDlqcaVjmTr7MBtM2mMkJJyDr2jUC22OuUZM 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagrc7wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:25:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE803100034;
        Tue,  4 Jan 2022 19:25:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D868224D5E6;
        Tue,  4 Jan 2022 19:25:50 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 19:25:50
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
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
Subject: [PATCH 3/4] serial: stm32: fix flow control transfer in DMA mode
Date:   Tue, 4 Jan 2022 19:24:44 +0100
Message-ID: <20220104182445.4195-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104182445.4195-1-valentin.caron@foss.st.com>
References: <20220104182445.4195-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If flow control is enabled, framework will call stop_tx to
pause transfer and then call start_tx to resume transfer.

Clear USART_CR3_DMAT bit in stop_tx ops to pause DMA transfer.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 52755a576bc2..788e002688f2 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -707,8 +707,11 @@ static void stm32_usart_stop_tx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct serial_rs485 *rs485conf = &port->rs485;
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	stm32_usart_tx_interrupt_disable(port);
+	if (stm32_usart_tx_dma_started(stm32_port) && stm32_usart_tx_dma_enabled(stm32_port))
+		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
-- 
2.17.1

