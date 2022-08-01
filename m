Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15215586401
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiHAGVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiHAGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:21:03 -0400
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347351F3;
        Sun, 31 Jul 2022 23:21:02 -0700 (PDT)
Received: from p54bc6cd6.dip0.t-ipconnect.de ([84.188.108.214] helo=[192.168.1.113]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oIOnU-0005Ym-Qa; Mon, 01 Aug 2022 08:21:00 +0200
Message-ID: <d7078c09-6559-4da9-4fe4-5cd1375692ef@birger-koblitz.de>
Date:   Mon, 1 Aug 2022 08:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
From:   Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH 5/7] spi: realtek-rtl: set transfer mode in,
 transfer_one_message()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1659334862;a63f4424;
X-HE-SMSGID: 1oIOnU-0005Ym-Qa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the SPI transfer function to allow support for parallel IO.
Use transfer_one_message() instead of the generic transfer_one()
for the necessary HW control for the transfer.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/spi/spi-realtek-rtl.c | 84 ++++++++++++++++++++++-------------
  1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 25a90493bf6e..21c0dc16c8cc 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -140,42 +140,66 @@ static void set_mode(struct rtspi *rtspi, unsigned int mode)
  	writel(value, REG(RTL_SPI_SFCSR));
  }

-static int transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
-			struct spi_transfer *xfer)
+static void raw_write(struct rtspi *rtspi, const void *tx_buf, int cnt)
+{
+	while (cnt >= 4) {
+		send4(rtspi, tx_buf);
+		tx_buf += 4;
+		cnt -= 4;
+	}
+	while (cnt) {
+		send1(rtspi, tx_buf);
+		tx_buf++;
+		cnt--;
+	}
+}
+
+static void raw_read(struct rtspi *rtspi, void *rx_buf, int cnt)
+{
+	while (cnt >= 4) {
+		rcv4(rtspi, rx_buf);
+		rx_buf += 4;
+		cnt -= 4;
+	}
+	while (cnt) {
+		rcv1(rtspi, rx_buf);
+		rx_buf++;
+		cnt--;
+	}
+}
+
+static int transfer_one_message(struct spi_controller *ctrl, struct spi_message *m)
  {
  	struct rtspi *rtspi = spi_controller_get_devdata(ctrl);
-	void *rx_buf;
-	const void *tx_buf;
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *xfer = NULL;
+	int status = 0;
  	int cnt;

-	tx_buf = xfer->tx_buf;
-	rx_buf = xfer->rx_buf;
-	cnt = xfer->len;
-	if (tx_buf) {
-		while (cnt >= 4) {
-			send4(rtspi, tx_buf);
-			tx_buf += 4;
-			cnt -= 4;
-		}
-		while (cnt) {
-			send1(rtspi, tx_buf);
-			tx_buf++;
-			cnt--;
-		}
-	} else if (rx_buf) {
-		while (cnt >= 4) {
-			rcv4(rtspi, rx_buf);
-			rx_buf += 4;
-			cnt -= 4;
-		}
-		while (cnt) {
-			rcv1(rtspi, rx_buf);
-			rx_buf++;
-			cnt--;
+	wait_ready(rtspi);
+
+	/* Assert CS */
+	rt_set_cs(spi, false);
+
+	m->actual_length = 0;
+	list_for_each_entry(xfer, &m->transfers, transfer_list) {
+		cnt = xfer->len;
+		if (xfer->rx_buf) {
+			set_mode(rtspi, xfer->rx_nbits);
+			raw_read(rtspi, xfer->rx_buf, cnt);
+		} else if (xfer->tx_buf) {
+			set_mode(rtspi, xfer->tx_nbits);
+			raw_write(rtspi, xfer->tx_buf, cnt);
  		}
+		m->actual_length += xfer->len;
  	}

-	spi_finalize_current_transfer(ctrl);
+	/* Wait until transfer finished and de-assert CS */
+	wait_ready(rtspi);
+	rt_set_cs(spi, true);
+
+	m->status = status;
+	spi_finalize_current_message(ctrl);

  	return 0;
  }
@@ -223,7 +247,7 @@ static int realtek_rtl_spi_probe(struct platform_device *pdev)
  	if (rtspi->dev_flags & SPI_QUAD_SUPPORTED)
  		ctrl->flags |= SPI_TX_QUAD | SPI_RX_QUAD;
  	ctrl->set_cs = rt_set_cs;
-	ctrl->transfer_one = transfer_one;
+	ctrl->transfer_one_message = transfer_one_message;
  	ctrl->num_chipselect = rtspi->dev_flags & SPI_CSMAX_3?4:2;
  	rtspi->cs_all = RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
  	if (rtspi->dev_flags & SPI_CSMAX_3)
-- 
2.25.1

