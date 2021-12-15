Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F55476632
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhLOWsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:48:37 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41783 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhLOWse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:48:34 -0500
Received: by mail-oi1-f169.google.com with SMTP id u74so33740668oie.8;
        Wed, 15 Dec 2021 14:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVZp2O1bgQSzgVKDDYQ7zXcpNDwg2s+vJLNvfCjA4TU=;
        b=ocw2Zms2nLLuYV86MpdyfHj4O+xWZIOObLYN99xK2WWNeb0Z4t3t/nix2Fx7ncHjMC
         /M/B+HemxH/+vOtBVnLAg7P42ZHwkyrOjyp7BQc1ZyN4nkrAM7PodJ2STq8wgJfXmNaM
         aaEaoWjCZBPNS+uzj3Pm+XHr/eGhzxWaWn990LfYIKxDT1hDHcEmsb74dLioD5BL0OsS
         mDfGVKzdqWnhVqD8eBtItjJNX9ho0wMraBIBSGDQ1mDpy+k3QOVwCr6yQkNCUtoRG4jK
         Pmf3ynPUnPlOQKasdR7QOgF81M5aihS7jl7G9UF9Z4LvAlorS0eBuP+NUKpL3GGzt6XU
         ewWA==
X-Gm-Message-State: AOAM532InGAfBM/NGc1jT6+soQth5erszqv2DzMMXy6NlUV+HoLq2Vcq
        v6MAhtYUQ8WAxXEC7xVNuQ==
X-Google-Smtp-Source: ABdhPJx7VQqNodJ+ys7iCxU+Xhbvhx1AxiRqI2o3wjFxGWm6aG2Y1O8aDrEtY5PSi4+u53dTQs4v2g==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr1910864oiw.117.1639608513898;
        Wed, 15 Dec 2021 14:48:33 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id e16sm721130ook.38.2021.12.15.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:48:33 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: atmel: Use platform_get_irq() to get the interrupt
Date:   Wed, 15 Dec 2021 16:48:31 -0600
Message-Id: <20211215224832.1985402-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing platform device resources directly has long been deprecated for
DT as IRQ resources may not be available at device creation time. Drivers
continuing to use static IRQ resources is blocking removing the static setup
from the DT core code.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2c99a47a2535..9e57bfe523cf 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2479,7 +2479,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->fifosize		= 1;
 	port->dev		= &pdev->dev;
 	port->mapbase		= mpdev->resource[0].start;
-	port->irq		= mpdev->resource[1].start;
+	port->irq		= platform_get_irq(mpdev, 0);
 	port->rs485_config	= atmel_config_rs485;
 	port->iso7816_config	= atmel_config_iso7816;
 	port->membase		= NULL;
-- 
2.32.0

