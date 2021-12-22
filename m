Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1F47CBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbhLVDge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:36:34 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:59384 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229997AbhLVDgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:36:32 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADnyRYlncJhLv+ABA--.46045S2;
        Wed, 22 Dec 2021 11:36:05 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] serial: mps2-uart: Check for error irq
Date:   Wed, 22 Dec 2021 11:36:04 +0800
Message-Id: <20211222033604.1049339-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADnyRYlncJhLv+ABA--.46045S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4fXr48WF4DurW3Gr15Arb_yoW8Jry3p3
        WktrWDury8GFWrtwnrZF4DAF45uwsYqa47W34ag34a9wn5JFnxW34fCr9IkF1kZr4UJFWS
        yrs8JF4F9a48Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjQBMtUUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find that platform_get_irq() will not always succeed.
It will return error irq in case there is no suitable irq.
Therefore, it might be better to check it if order to avoid the use of
error irq.

Fixes: 041f031def33 ("serial: mps2-uart: add MPS2 UART driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/tty/serial/mps2-uart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 587b42f754cb..117d9896051f 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -585,10 +585,20 @@ static int mps2_init_port(struct platform_device *pdev,
 
 	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
 		mps_port->port.irq = platform_get_irq(pdev, 0);
+		if (mps_port->port.irq < 0)
+			return mps_port->port.irq;
 	} else {
 		mps_port->rx_irq = platform_get_irq(pdev, 0);
+		if (mps_port->rx_irq < 0)
+			return mps_port->rx_irq;
+
 		mps_port->tx_irq = platform_get_irq(pdev, 1);
+		if (mps_port->tx_irq < 0)
+			return mps_port->tx_irq;
+
 		mps_port->port.irq = platform_get_irq(pdev, 2);
+		if (mps_port->port.irq < 0)
+			return mps_port->port.irq;
 	}
 
 	return ret;
-- 
2.25.1

