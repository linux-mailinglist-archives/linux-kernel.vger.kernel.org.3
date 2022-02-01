Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF14A5B94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiBALwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiBALwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:52:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86CCC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 03:52:06 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nErhS-0003Vm-14; Tue, 01 Feb 2022 12:51:54 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nErhL-00GmlN-SF; Tue, 01 Feb 2022 12:51:47 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Dillon Min <dillon.minfei@gmail.com>, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH] spi: stm32: ignore Rx queue not empty in stm32f4 Tx only mode
Date:   Tue,  1 Feb 2022 12:51:41 +0100
Message-Id: <20220201115142.3999860-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32F4_SPI_SR_RXNE and STM32F4_SPI_SR_OVR are distinct bits in the same
status register.  ~STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE is thus
equal to ~STM32F4_SPI_SR_OVR.

The original intention was likely for transmission-only transfers to
ignore interrupts both for when the Rx queue has bytes (RXNE) as well
as when these bytes haven't been read in time (OVR).

Fix the typo by adding the missing parenthesis.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Noticed reading driver code. Untested on actual Hardware.
If you can test this, please do.
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9bd3fd1652f7..56062f88881d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -763,7 +763,7 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 	if (!spi->cur_usedma && (spi->cur_comm == SPI_SIMPLEX_TX ||
 				 spi->cur_comm == SPI_3WIRE_TX)) {
 		/* OVR flag shouldn't be handled for TX only mode */
-		sr &= ~STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE;
+		sr &= ~(STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE);
 		mask |= STM32F4_SPI_SR_TXE;
 	}
 
-- 
2.30.2

