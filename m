Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C635388D0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiE3WOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiE3WOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:14:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BAD5D5F7;
        Mon, 30 May 2022 15:14:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h19so7096996edj.0;
        Mon, 30 May 2022 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tcw7h7wb8BE8oW7NJUYk/qOSs6p8a/jo+wYZpgwb+VQ=;
        b=KRtOg3sD6ksVEizMT8xbk1CGtMAEAcC4rwk/8/z4uq/lozs9E/1jPnZ/59uP6eXRIe
         IO5fGFqWiNAIZtqBWaN/GUif65mztAqqdbI1eOGKkvt9VJDDdtA36ru/lds5czBDlbNw
         +zzUPW3FG8E1TQT3dgl+gPPjJugewEcbffgVKOJ6G7NBTGukNqHU1L4QAC9fXvvp7u7V
         Kov9V72LIxasw8//Ojrirf7YsLxk4Bv9FUo/idi06mW+mlj6I6O3fywjTdcPVJBcxdvO
         mCcWS/oSW+HKNQTp+SpPW5HgPgH7S6u/ysfRl1kVSMGK4GtCBU9kKQz5YGUIXe66FOZg
         9a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tcw7h7wb8BE8oW7NJUYk/qOSs6p8a/jo+wYZpgwb+VQ=;
        b=uSK66jNZo9zdQ0bDz/DUalOIiEpErJpPry2LU8UhAckYb8v9Ln4ZNZKGqsge+JpMNo
         wWdWIhDRMhHtxwIRliAsXwU74a+KRxkiVs8JOVZikKkPAQinQEQsD28cg0NRi7qrkrOB
         fT/LACf4qBSuArV/KzKM7DQrClr7rBX7Q+7RVBc3UwDe8BdFqTGY9T3cSarJZ0cB1nyv
         76pA9JErriFk4VYSRyKmInkFZl2VY6OGa6wWTX7xZe9J53mmk/wVL+J80zw933yea2tg
         EUVJJJuZ5myhYLoD5fVT6b67G3PDazppHxo1BUGQsushTxM7bQu5W4KI4mVn7DGDcVUx
         Nmcg==
X-Gm-Message-State: AOAM532m/+Xmpky3n0GlZQC+Ghmr2qgwRP5t872VtziOj2a3Jkj/p+XM
        BznXpGC+mrv4dPfXe9K4goh9R5DPWKE=
X-Google-Smtp-Source: ABdhPJyOZh7MEWvb1fnDNrYpL8RK+Xx2D3HceU25XfIY4Nn6sekFW6SoDgoxacZX5dkRq0uPVBmsNw==
X-Received: by 2002:aa7:d4c9:0:b0:42d:cbf0:bfb1 with SMTP id t9-20020aa7d4c9000000b0042dcbf0bfb1mr10286216edr.278.1653948882134;
        Mon, 30 May 2022 15:14:42 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id a92-20020a509ee5000000b0042dbc55f6e4sm4485850edf.7.2022.05.30.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 15:14:41 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH 1/4] serial: max310x: use regmap methods for SPI batch operations
Date:   Tue, 31 May 2022 01:14:26 +0300
Message-Id: <20220530221429.1248083-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The SPI batch read/write operations can be implemented as simple
regmap raw read and write, which will also try to do a gather
write just as it is done here.

Use the regmap raw read and write methods.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/tty/serial/max310x.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0b6ea52d133..46887a4ffea4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -259,8 +259,6 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 
-	u8 wr_header;
-	u8 rd_header;
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
@@ -623,32 +621,18 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->wr_header,
-			.len = sizeof(one->wr_header),
-		}, {
-			.tx_buf = txbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+	u8 reg = port->iobase + MAX310X_THR_REG;
+
+	regmap_raw_write(s->regmap, reg, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->rd_header,
-			.len = sizeof(one->rd_header),
-		}, {
-			.rx_buf = rxbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+	u8 reg = port->iobase + MAX310X_RHR_REG;
+
+	regmap_raw_read(s->regmap, reg, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1368,10 +1352,6 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
-		/* Initialize SPI-transfer buffers */
-		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
-				    MAX310X_WRITE_BIT;
-		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-- 
2.36.1

