Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892D5741CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiGNDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiGNDT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:19:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBB240A6;
        Wed, 13 Jul 2022 20:19:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so6879785pjr.4;
        Wed, 13 Jul 2022 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z16sKopkYHjN1FnPOO3LV6eRRV3MiPUM2Dv4PfBl0DI=;
        b=U4JVh3ts33oVhhRAbTM4c01uw8QW6+vPU5AqzfkUcw3FPZNY8y02/Y+KIVqy1S4PKY
         5pj7O3afgjTX6R10hLARBk03+f/Hr1YiLgdpLhc/e78LIyjRKfljkvQXJB1hLqJFdRRF
         jdF6c0pxHOTze5Aj9r6r8Nmy8oQi6jZ4fMraezZQo5ANTXWFU5Nc+3Nei8lIvYBuJaFH
         aDPaeHQAbNaqtI5y6YG+jZUe87mlUecRFtkz3v8gPOC9GcuAfGaQCidjOxNgzJyyS0EH
         219BNBZfoqtKx2cfHqVkMALPBSks3/29Di8x9BNKUvXm9NYwBdYLzJtor8iERr1Y+tC/
         OyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z16sKopkYHjN1FnPOO3LV6eRRV3MiPUM2Dv4PfBl0DI=;
        b=WwAzydN/Y+B2LOjKMl9fn7G4SUxfVj0CZ9iy6vTn0Zj41DdECDai5kKS9DbHX602Hj
         CHr2+Jsg8BAfuHxFXSKZdSLRg/OGLfLrBQLw2tmMGKBNqv2xxlRBwlfxJSc/woNFmYD+
         +B1Ia+K7rjHRoz5KNaNiJfjItD50PfxOadqNrTVO3lj+SKpkWGuwT7mw/Tq9iQiuIrh7
         xS+LfqNAp1J7rbOdmrqQcCwseT1rItWra1q0r08xPED6yq4gfBRKabhrCWAywWk9pbxu
         00b5XS7KfDKsmBrxK/Qc01gKh4cy4fiNV0sc/fmsIHjb39dh5tZ3ReWU79SWlhL4ET8x
         6SnA==
X-Gm-Message-State: AJIora+LwLk35UfYP0Z0hH48+5n1bicQwrwVkU6aEstdpaNil8Yrtc7c
        TRyVjICgoBZuZxHe0fbPq4DhNkSS8FA=
X-Google-Smtp-Source: AGRyM1tWJujGTkrezqCP3LyXiasWmr8nGAOJP1sPDZw2284iA56M+LT2CdcvyND93KOnVEX4QwG++Q==
X-Received: by 2002:a17:90b:3149:b0:1f0:3539:e7ae with SMTP id ip9-20020a17090b314900b001f03539e7aemr13877497pjb.80.1657768765569;
        Wed, 13 Jul 2022 20:19:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001ef8ea89a33sm2411453pjb.2.2022.07.13.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:19:24 -0700 (PDT)
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
Subject: [PATCH v3] serial: 8250_bcm7271: Save/restore RTS in suspend/resume
Date:   Wed, 13 Jul 2022 20:13:15 -0700
Message-Id: <20220714031316.404918-1-f.fainelli@gmail.com>
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

Commit 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming
from S2") prevented an early enabling of RTS during resume, but it did
not actively restore the RTS state after resume.

Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming from S2")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- moved set_mctrl within the critical section

Changes in v2:

- reworded the commit message to be clearer

 drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 9b878d023dac..8efdc271eb75 100644
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
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

