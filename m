Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8B4F95C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiDHM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiDHM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:29:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510EA33DCAB;
        Fri,  8 Apr 2022 05:27:25 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2389j3P9000551;
        Fri, 8 Apr 2022 14:27:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=selector1;
 bh=OzzsSeRZXTJPRZje9ui1T8+kROrim9zZTezfZrmqwVA=;
 b=g9pEZNsoYYlGs5g2LsrK5fLiu589Fxw1KHMSO0CId/eEqsrdIBXj6aKTW+eD8ltMsGgE
 Lmo260J0JhOSP7+0q6M1B/R9dJ8DCktbMGqZ4jU2MR7bKblxcZXYXDj/HLenA4x6JuV1
 GxpxUrt+JnIKxaEH85wK6gRR3zIVInqb0/T9CmSzK552YxFgLzHvfOtY4DTLLw1xbbZ5
 UDIaiJV5O85hvXJlE1uKarAfUTL6j0LghhtsifE0PWAyBmwTkxVuycc8aH7RWkhJKjM4
 kfPbnN04JyVNJ+xhM1hlbpHavSUKqxYxE4CW7HuDrOs7s5HvpWs8CQinBrJROwov5khc 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f9wr7r1p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:27:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8EA7B100038;
        Fri,  8 Apr 2022 14:27:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8666321A21E;
        Fri,  8 Apr 2022 14:27:03 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 8 Apr 2022 14:27:03
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
Subject: [PATCH V2 1/3] serial: stm32: remove infinite loop possibility in putchar function
Date:   Fri, 8 Apr 2022 14:26:34 +0200
Message-ID: <20220408122636.505737-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408122636.505737-1-valentin.caron@foss.st.com>
References: <20220408122636.505737-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
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

Rework stm32_usart_console_putchar() function in order to anticipate
the case where the character can never be sent.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 12 +++++++++---
 drivers/tty/serial/stm32-usart.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 87b5cd4c9743..83895da84891 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1645,10 +1645,16 @@ static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	u32 isr;
+	int ret;
 
-	while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
-		cpu_relax();
-
+	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr, isr,
+						(isr & USART_SR_TXE), 100,
+						STM32_USART_TIMEOUT_USEC);
+	if (ret != 0) {
+		dev_err(port->dev, "Error while sending data in UART TX : %d\n", ret);
+		return;
+	}
 	writel_relaxed(ch, port->membase + ofs->tdr);
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index feab952aec16..d734c4a5fd24 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -251,6 +251,8 @@ struct stm32_usart_info stm32h7_info = {
 #define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
 #define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
+#define STM32_USART_TIMEOUT_USEC USEC_PER_SEC /* 1s timeout in µs */
+
 struct stm32_port {
 	struct uart_port port;
 	struct clk *clk;
-- 
2.25.1

