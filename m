Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF24847CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiADS0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:26:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51756 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234693AbiADS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:26:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204FQG3J032620;
        Tue, 4 Jan 2022 19:25:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=XMDrVIuvNH3fh4lFKIvoouUMZ8NmXg79A55JIgisRYA=;
 b=O5WJ2huiYSjhIacOMhYyx29Hx+JTOTC6s1yq0Umm2iyJlpC2q7y7UQHgoYvP5eImd/S4
 0N/GnMcgWQaLLRtxY2VTZfvZabQn9Q7eUb9y3KX6/RgqOct+28lItlrzGGgi54ZTHdKS
 MetA6Oy+RA5FW1Da9HD9wO90dNqn7acpW8pjj+6gIH449h451oLac5n6HvzU32zIwmPF
 bdzrVMn269IoUcbrtFHwVC3gl5rlYF5MTgqujXAb1KkZWS65a1ssHHjvrNRJJF5dk4BH
 x8tAQuhAcZDMYpEv74iSEAUaBSgZntP0wCaj0NL3lrbkgAUicZEGd7C6BNfXhMsYjwHl Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagrc7wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:25:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61F69100034;
        Tue,  4 Jan 2022 19:25:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A7DB24D5E6;
        Tue,  4 Jan 2022 19:25:49 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan 2022 19:25:48
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
Subject: [PATCH 1/4] serial: stm32: move tx dma terminate DMA to shutdown
Date:   Tue, 4 Jan 2022 19:24:42 +0100
Message-ID: <20220104182445.4195-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104182445.4195-1-valentin.caron@foss.st.com>
References: <20220104182445.4195-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terminate DMA transaction and clear CR3_DMAT when shutdown is requested,
instead of when remove is requested. If DMA transfer is not stopped in
shutdown ops, driver will fail to start a new DMA transfer after next
startup ops.

Fixes: 3489187204eb ("serial: stm32: adding dma support")

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3244e7f6818c..6cfc3bec6749 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -883,6 +883,11 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	u32 val, isr;
 	int ret;
 
+	if (stm32_port->tx_dma_busy) {
+		dmaengine_terminate_async(stm32_port->tx_ch);
+		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+	}
+
 	/* Disable modem control interrupts */
 	stm32_usart_disable_ms(port);
 
@@ -1570,7 +1575,6 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	writel_relaxed(cr3, port->membase + ofs->cr3);
 
 	if (stm32_port->tx_ch) {
-		dmaengine_terminate_async(stm32_port->tx_ch);
 		stm32_usart_of_dma_tx_remove(stm32_port, pdev);
 		dma_release_channel(stm32_port->tx_ch);
 	}
-- 
2.17.1

