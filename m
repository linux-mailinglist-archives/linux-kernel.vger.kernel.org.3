Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8134A89C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352757AbiBCRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:19:00 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352545AbiBCRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:18:57 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213CZt9O018956;
        Thu, 3 Feb 2022 18:16:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=RCtJ3BeJ8WdtSkBXKlo8ykGWUNMUkxUiYAgibZ776yE=;
 b=kFJZSrJOJieZ0E4n1DrSB9goEOB7XdPiGKJUqd/Nj2IfP8FwNGO6YV5EuVBcJ6T17LN7
 Bz4UzOhgwDBuUqM8R5P+Q6u+OdgH5aBD9eVtnfdrUX4TMPtoj3a3zagVwaUTXNFMtCft
 x1hisnnRewj5V4lwBZyCIrPMP2NmemLAwx7XiUhSfom3QiEzQ2fnQ/EJI2KlvhLuHi4U
 0bCsHtcjjUuaGn2Ogvn/bt2Qx8lnobxmtFojyj6rDRNwLwNsTsVhstQnuCUDf1tTMVaT
 QiHSjBV0Qx0PTq0rebbUztoVjV8uWVnQ/95cop5xagYsrVMHh7iRAw++GbtL0JJQxvau aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dyrujqpqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:16:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD873100038;
        Thu,  3 Feb 2022 18:16:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7B19229A73;
        Thu,  3 Feb 2022 18:16:48 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:16:48
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
Subject: [PATCH 2/2] serial: stm32: enable / disable wake irqs for mcrtl_gpio wakeup sources
Date:   Thu, 3 Feb 2022 18:16:44 +0100
Message-ID: <20220203171644.12231-3-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171644.12231-1-erwan.leray@foss.st.com>
References: <20220203171644.12231-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable mctrl_gpio wake_irq if device_may_wakeup when usart is suspended,
and disable mctrl_gpios wake_irq if device_may_wakeup when usart is
resumed.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3244e7f6818c..df86c53e62a7 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1708,6 +1708,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 	if (enable) {
 		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_UESM);
 		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_WUFIE);
+		mctrl_gpio_enable_irq_wake(stm32_port->gpios);
 
 		/*
 		 * When DMA is used for reception, it must be disabled before
@@ -1734,7 +1735,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 			if (ret)
 				return ret;
 		}
-
+		mctrl_gpio_disable_irq_wake(stm32_port->gpios);
 		stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_UESM);
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 	}
-- 
2.17.1

