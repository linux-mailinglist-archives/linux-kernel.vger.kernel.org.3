Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655E247E276
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347988AbhLWLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:41:07 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:39632 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhLWLlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:41:06 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowABHTVk3YMRh1DJnBA--.40873S2;
        Thu, 23 Dec 2021 19:40:40 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] serial: mps2-uart: Check for error irq
Date:   Thu, 23 Dec 2021 19:40:38 +0800
Message-Id: <20211223114038.1306663-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTVk3YMRh1DJnBA--.40873S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7Jr1rCr43GF1kZw4DCFg_yoW8Xr1kpF
        4ktFZ8JrW8GayfWasrXF1UJa13C3yvqa9rJa42934293WrJFnrC34rGFnIvF1kZrWDJr4f
        Xa15tF48uF10vaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbeT5PUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 23, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> Check the types.

That's right.
I correct previous version, using error variable to check.

Fixes: 041f031def33 ("serial: mps2-uart: add MPS2 UART driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

*Change 1.USing error variable to check.
---
 drivers/tty/serial/mps2-uart.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..24a52300d8d9 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -584,11 +584,29 @@ static int mps2_init_port(struct platform_device *pdev,
 
 
 	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
-		mps_port->port.irq = platform_get_irq(pdev, 0);
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
+			return ret;
+
+		mps_port->port.irq = ret;
 	} else {
-		mps_port->rx_irq = platform_get_irq(pdev, 0);
-		mps_port->tx_irq = platform_get_irq(pdev, 1);
-		mps_port->port.irq = platform_get_irq(pdev, 2);
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
+			return ret;
+
+		mps_port->rx_irq = ret;
+
+		ret = platform_get_irq(pdev, 1);
+		if (ret < 0)
+			return ret;
+
+		mps_port->tx_irq = ret;
+
+		ret = platform_get_irq(pdev, 2);
+		if (ret < 0)
+			return ret;
+
+		mps_port->port.irq = ret;
 	}
 
 	return ret;
-- 
2.25.1

