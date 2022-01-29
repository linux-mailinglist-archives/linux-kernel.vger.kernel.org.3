Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225734A2C64
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350676AbiA2HQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:16:20 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52961 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbiA2HQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:19 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id DhxynhQx2eHnVDhxznuAOZ; Sat, 29 Jan 2022 08:16:16 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 29 Jan 2022 08:16:16 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Anatolij Gustschin <agust@denx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        John Bonesio <bones@secretlab.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: platforms: 52xx: Fix a resource leak in an error handling path
Date:   Sat, 29 Jan 2022 08:16:04 +0100
Message-Id: <dec1496d46ccd5311d0f6e9f9ca4238be11bf6a6.1643440531.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling path of mpc52xx_lpbfifo_probe() and a request_irq() is
not balanced by a corresponding free_irq().

Add the missing call, as already done in the remove function.

Fixes: 3c9059d79f5e ("powerpc/5200: add LocalPlus bus FIFO device driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Another strange thing is that the remove function has:
	/* Release the bestcomm transmit task */
	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
but I've not been able to find a corresponding request_irq().

Is it dead code? Is there something missing in the probe?
(...Is it working?...)
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index b91ebebd9ff2..e0049b7df212 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -530,6 +530,7 @@ static int mpc52xx_lpbfifo_probe(struct platform_device *op)
  err_bcom_rx_irq:
 	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
  err_bcom_rx:
+	free_irq(lpbfifo.irq, &lpbfifo);
  err_irq:
 	iounmap(lpbfifo.regs);
 	lpbfifo.regs = NULL;
-- 
2.32.0

