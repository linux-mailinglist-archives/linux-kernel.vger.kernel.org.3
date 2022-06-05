Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E953DC58
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbiFEOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbiFEOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:47:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D55FBA;
        Sun,  5 Jun 2022 07:47:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q1so24509732ejz.9;
        Sun, 05 Jun 2022 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tcw7h7wb8BE8oW7NJUYk/qOSs6p8a/jo+wYZpgwb+VQ=;
        b=JX3yxOQEIfFjwrYv+PF7gJ2N8/lPC0p0PIc//iibkF+NSAJho/LtSUJLc2ZcLXVji7
         Xie1usLzB7TPbtPROnLXFnPNdxoUoj/10+7xf3hbeqSLH4KO/Mu+GabeNM9xpBavKxGI
         vy3QmgbrQW/IIc5edGBqMtSbif5+m/rCXZePNKDTecmmKfrF9Pxxi/T7c5INNtTZXUzv
         rkYFunLKqxoviIWrgZ+NWdv8C0+hBmXO8SlmLgnEB0GFvGe6sSbDR43SQKfJ5PINFMns
         Z87uUYlt7/pkfRto4GhwHamHrGaJmyHSPP7mIBeriy+NwU4P3CRVo+odp7ZdKvjp2UR2
         EXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tcw7h7wb8BE8oW7NJUYk/qOSs6p8a/jo+wYZpgwb+VQ=;
        b=akqdYVIVLRUNdf61Q3cH82SuAfIwytTAKfowJzDVBpJba83R5UG+PqrKKWgvs0a2At
         XvVx0tBlJY9qHyQer62IHZrozIJsPqPtefqMK9Ma0RPrTztl3L5Xlxw3l6kZB0qQ6y6S
         uZbr/RcaDRBccmZ2bdKWy/0GP69pglrKSoejtnTHFbPzT4lg3EwyeXA/KplUEy4SbFLJ
         EcKXxxnAhUz8+Z+XKb9J6ADyNqd4hv/i76Si4iNzudfO4xG3K1VzNpNmW2PrtuMuwpAB
         CCGnw+KOyPDE5jzthXKvZAYlQHophEqPFbyN/LEEmL16hgz7djYU7u0fPSlA4LU7NwGy
         UvPQ==
X-Gm-Message-State: AOAM5336T2mL2v3kERspnUVyuyNfv6dmF3g7MAgeZSS0jwG4umYhdhis
        YDdz099qHoSGAkzuuNEBxGLTOG3AgbU=
X-Google-Smtp-Source: ABdhPJwT55ZOVcJ3Yk4iuMj9iWxAseLJSUtYksVIiJaNj2thJGh/5xXNaO1l6CJMrFw8/5aZSBm/uw==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr17613796ejc.81.1654440446517;
        Sun, 05 Jun 2022 07:47:26 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b0042dd4ccccf5sm6854254edv.82.2022.06.05.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:47:26 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 1/4] serial: max310x: use regmap methods for SPI batch operations
Date:   Sun,  5 Jun 2022 17:46:56 +0300
Message-Id: <20220605144659.4169853-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605144659.4169853-1-demonsingur@gmail.com>
References: <20220605144659.4169853-1-demonsingur@gmail.com>
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

