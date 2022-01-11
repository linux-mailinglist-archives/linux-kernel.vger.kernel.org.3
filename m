Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CE748B28C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiAKQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:45:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244179AbiAKQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:45:45 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BBoEdc023994;
        Tue, 11 Jan 2022 17:45:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=HadlWm8vPa6gLGI+Lp8NuxhfCBgbLjPprgpIUAa/Nhs=;
 b=5D3HQTTKTA+NA0N4Kr33bvBZnp8rDT3ckfd7OqdskD1Qn79//ciQiEh6dpWgWCYzFmjb
 dKBNwWNI3XcSoYBr2+3DA4ENzVecprnEAxsuzOsY0/sHkNNEIbpuEELuBF2QLdiu/N7R
 iXQPfEEqO+3ZYK/kRg0Lz5NwsyLA/cIYgDAHBn/B+LmFof+Myf2Qy4A0EtSw+K/yo53f
 cyN0PRiBhYMX1qeJhRY2hqIlg30GJeolRX0cmOYk3PEoY72+ubBjbaq49JVT3Bo+awKg
 dZodkOS/T6mxs2l2CErR6I8tUBqWEY8zJ4B+sLTd8b9+WLmaQ39pG3JDYa7XU8eiMrj6 jQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dh9cb9c6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 17:45:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2A4710002A;
        Tue, 11 Jan 2022 17:45:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB358245FC8;
        Tue, 11 Jan 2022 17:45:26 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 17:45:26
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] serial: stm32: fix software flow control transfer
Date:   Tue, 11 Jan 2022 17:44:41 +0100
Message-ID: <20220111164441.6178-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111164441.6178-1-valentin.caron@foss.st.com>
References: <20220111164441.6178-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x_char is ignored by stm32_usart_start_tx() when xmit buffer is empty.

Fix start_tx condition to allow x_char to be sent.

Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c1b8828451c8..9570002d07e7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -742,7 +742,7 @@ static void stm32_usart_start_tx(struct uart_port *port)
 	struct serial_rs485 *rs485conf = &port->rs485;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit) && !port->x_char)
 		return;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
-- 
2.17.1

