Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9014656F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352910AbhLAUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352784AbhLAUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:17:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B27C061759;
        Wed,  1 Dec 2021 12:14:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so2645530pjb.1;
        Wed, 01 Dec 2021 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9Lo2A1Ul89gn2S8E5V5+SdXZxQLnnxOuUt3GsgTEvpQ=;
        b=pNBn5/tp8/NtIWCvs36HBTf+sUUpLVP3TTtCZKxBtZm7Vqa8+9Q2l4YFZjtsltxB2X
         8Ti3C32iPuZzfcpMQqN/JhxnQjt4WvKMh9D4T79URDTFFp8YTRMyDzIWfKfLhj/9eE6k
         uc0LUeApR9CyBm9SwBjQUOZLSSEZYX7kj/b6K+3EsKH4/doQPpS9DAEFVwJYvqvMFvVC
         yeNfMEdHmbztnk9Nwu/WB6NkOzS2elwWpABr8EZ5VCoOw3VAtT3TFAX52VL4FNA18t8Q
         FpAISBn8Hr7Ie+/IlSwe8DR+wR74jDc46ij/o30aDGFLbLelgI9ZJAhpywmYphoLU/DU
         euGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Lo2A1Ul89gn2S8E5V5+SdXZxQLnnxOuUt3GsgTEvpQ=;
        b=XgxXTedTuyze+//I5s+uNtvqShiCyhPZbz4rI+YZB6ZuMsvgWPxDLgNtFIrrm1BL7z
         Y/Hy3UuC4OtSa/FOOaGmUscW+Kbic4Jpi835DVXM/t9eodYnEM1AR4kw+EFp9XMPHpXX
         dkWKxOvUclpSEESrzaPpzdr5z5Y09o1c78xLyrpUkx5FsHVgOWmw5CmthX1g2PGWhDqy
         0wzrkLCGr/ZZcW5qdhsVzuReSlAsBZY44Av/+6NpmYv2aof+iGEq7yFanNR6jWLigGfk
         khkrdYdqtnRAfFp+xMGIFoluvjhO8AtN+y+O7pkN/R/Db282Ee4pVTecNZArgaBiATEB
         0pFQ==
X-Gm-Message-State: AOAM531lUtZ+n9f0hxr9PnNGRMULPVrxMYgcBk9p1bWXJIGWi+yZ1Lm6
        3smT1H/+euvIbC+GqY3mWZns6g9suFdLUg==
X-Google-Smtp-Source: ABdhPJx6jJyy6FiASq43/D4ckzF5pfdHigWSUu5U0eRdxj9GgxRdL1+CT/IDNPzHBzNRios22CJe3A==
X-Received: by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP id o23-20020a170902779700b0014388c37ff1mr10025356pll.22.1638389673912;
        Wed, 01 Dec 2021 12:14:33 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id ls14sm147648pjb.49.2021.12.01.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:14:33 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_bcm7271: UART errors after resuming from S2
Date:   Wed,  1 Dec 2021 15:14:02 -0500
Message-Id: <20211201201402.47446-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a small window in time during resume where the hardware
flow control signal RTS can be asserted (which allows a sender to
resume sending data to the UART) but the baud rate has not yet
been restored. This will cause corrupted data and FRAMING, OVERRUN
and BREAK errors. This is happening because the MCTRL register is
shadowed in uart_port struct and is later used during resume to set
the MCTRL register during both serial8250_do_startup() and
uart_resume_port(). Unfortunately, serial8250_do_startup()
happens before the UART baud rate is restored. The fix is to clear
the shadowed mctrl value at the end of suspend and restore it at the
end of resume.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 7f656fac503f..5163d60756b7 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -237,6 +237,7 @@ struct brcmuart_priv {
 	u32		rx_err;
 	u32		rx_timeout;
 	u32		rx_abort;
+	u32		saved_mctrl;
 };
 
 static struct dentry *brcmuart_debugfs_root;
@@ -1133,16 +1134,27 @@ static int brcmuart_remove(struct platform_device *pdev)
 static int __maybe_unused brcmuart_suspend(struct device *dev)
 {
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_port *port = &up->port;
 
 	serial8250_suspend_port(priv->line);
 	clk_disable_unprepare(priv->baud_mux_clk);
 
+	/*
+	 * This will prevent resume from enabling RTS before the
+	 *  baud rate has been resored.
+	 */
+	priv->saved_mctrl = port->mctrl;
+	port->mctrl = 0;
+
 	return 0;
 }
 
 static int __maybe_unused brcmuart_resume(struct device *dev)
 {
 	struct brcmuart_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	struct uart_port *port = &up->port;
 	int ret;
 
 	ret = clk_prepare_enable(priv->baud_mux_clk);
@@ -1165,6 +1177,7 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 		start_rx_dma(serial8250_get_port(priv->line));
 	}
 	serial8250_resume_port(priv->line);
+	port->mctrl = priv->saved_mctrl;
 	return 0;
 }
 

base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
-- 
2.17.1

