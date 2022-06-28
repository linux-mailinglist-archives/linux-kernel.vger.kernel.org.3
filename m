Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47D55F0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiF1WCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1WCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:02:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A8823142;
        Tue, 28 Jun 2022 15:02:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so14088091pjb.2;
        Tue, 28 Jun 2022 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFZjjIMNrGQUNdyGjNq661RAe1XCAY7EjGGglvxjWmU=;
        b=ZW+Q+XBqU6izYip4tUtC1iWJs+ZBswtOV8IGmxBZoxZTpKoaQQHW25pirWE4GtPElk
         nt9PyfHJRfW8iP17BpqkwGiMEfrvTOufqCKzUUJ8AoB9K52WLnTAMeE6kzjw1Sh8r3jV
         sN5qoKojpOeMoxgR10S972tSm2s4uiySCsoiY+GXM7url2/PWRN6xTt5bdH0fnPlfsav
         eWkNabEnTKXLfOKkMgoF1jeOblIZ2SelwoycPbdW/OCnENWUCrOSV6lov00NML8gCl/k
         Mpp/6TTI5TWHR95GiGHZZwSh+jBdoh/rbO91hl1O1PKOv+4hC4f2c2r5J/A8i8bZbalN
         Xl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFZjjIMNrGQUNdyGjNq661RAe1XCAY7EjGGglvxjWmU=;
        b=n+yuC058N7IHwctWM5U5+z4ApPhOPOKTG1zjyu65sBahtRB+zoHiS330gwqWVh/ERK
         Aqd2ZvKKb4qo9IrEuPB9qdM+Zbb5hVa5VRUNdEUmOtaf0cYWovATulOJTnrTP/1ZC2rP
         QTrELhl/WhnMe+Uzvfp4t+xTHzl4b2kuusQm2eUK9kFGRvYoBQVoMXD2HL/bhOESONcs
         t8i2ZvSX/sX3mBw9w0F84l8jOPkpLIdoWh34NS+Lz1bNhFCyCCqu+1GFmgOSDo7Svhh+
         C5urHRRZtc82Q/kClhB2PGBCLk+xb/heCX4JqnCYUynyOCt+3HBp1eX+qoMD7S0b30zQ
         8XBg==
X-Gm-Message-State: AJIora/+d9t4thmrsnglWW37Gri7E6vXG6eZ+o5vv3NVeHI2lBDpZDJN
        E6W2KGPR/hyTLfXkOsOCycKoDKpP8yM=
X-Google-Smtp-Source: AGRyM1tasQLOKWFUf79ni24TfxrTdpIiTINuU7waAM24VrFFzj5nAB5RCr7pPrNb7zuDRTD2f7RA5A==
X-Received: by 2002:a17:90a:e385:b0:1ec:8b46:dedc with SMTP id b5-20020a17090ae38500b001ec8b46dedcmr46422pjz.29.1656453736439;
        Tue, 28 Jun 2022 15:02:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c12-20020a624e0c000000b005258df61ceesm7419536pfb.90.2022.06.28.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:02:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] serial: 8250_bcm7271: Save/restore RTS in suspend/resume
Date:   Tue, 28 Jun 2022 14:59:01 -0700
Message-Id: <20220628215901.3074262-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

The previous patch prevented an early enabling of RTS during
resume, but it did not actively restore the RTS state after
resume.

Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming from S2")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 9b878d023dac..b9cea38c8aff 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1139,16 +1139,19 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	struct uart_port *port = &up->port;
-
-	serial8250_suspend_port(priv->line);
-	clk_disable_unprepare(priv->baud_mux_clk);
+	unsigned long flags;
 
 	/*
 	 * This will prevent resume from enabling RTS before the
-	 *  baud rate has been resored.
+	 *  baud rate has been restored.
 	 */
+	spin_lock_irqsave(&port->lock, flags);
 	priv->saved_mctrl = port->mctrl;
-	port->mctrl = 0;
+	port->mctrl &= ~TIOCM_RTS;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	serial8250_suspend_port(priv->line);
+	clk_disable_unprepare(priv->baud_mux_clk);
 
 	return 0;
 }
@@ -1158,6 +1161,7 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	struct uart_port *port = &up->port;
+	unsigned long flags;
 	int ret;
 
 	ret = clk_prepare_enable(priv->baud_mux_clk);
@@ -1180,7 +1184,15 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 		start_rx_dma(serial8250_get_port(priv->line));
 	}
 	serial8250_resume_port(priv->line);
-	port->mctrl = priv->saved_mctrl;
+
+	if (priv->saved_mctrl & TIOCM_RTS) {
+		/* Restore RTS */
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl |= TIOCM_RTS;
+		spin_unlock_irqrestore(&port->lock, flags);
+		port->ops->set_mctrl(port, port->mctrl);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

