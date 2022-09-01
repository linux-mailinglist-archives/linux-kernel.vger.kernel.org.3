Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF87A5A9563
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIALHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIALHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:07:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05421314F2;
        Thu,  1 Sep 2022 04:07:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7DBAA22683;
        Thu,  1 Sep 2022 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662030425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6vjzxB4Ibfz0o69w/iYdHIKC07ztQav3fh9etcwaWjY=;
        b=ze76PvxNMXHs0p67rsZvuOtSORxr4tU2rpdVRqGyuAP81aKL8DmS/kGvKNsY6RY8uvnWMu
        YJoPGfnBY2vHOHtd+vLrjKQkqDKBQ6s6c3MM168LF39SqI1XTRvp1ujJuvNSOVrhO+kDLE
        XPXm6VJpwBx7mO6z7PLD50m3bzTrQ7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662030425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6vjzxB4Ibfz0o69w/iYdHIKC07ztQav3fh9etcwaWjY=;
        b=HPG/QyiFf7fFFkcSakpYQGSHOUTV37lDISPLRMSlqVOde56PoUsDZ2lbHs8eXNjQts9vNy
        pkNd+ZRY+++hXaDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6C3B2C145;
        Thu,  1 Sep 2022 11:07:01 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] tty: TX helpers
Date:   Thu,  1 Sep 2022 13:06:54 +0200
Message-Id: <20220901110657.3305-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces DEFINE_UART_PORT_TX_HELPER +
DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 1/3 for the
details. Comments welcome.

Then it switches drivers to use them. First, to
DEFINE_UART_PORT_TX_HELPER() in 2/3 and then
DEFINE_UART_PORT_TX_HELPER_LIMITED() in 3/3.

The diffstat of patches 2+3 is as follows:
 26 files changed, 191 insertions(+), 823 deletions(-)
which appears to be nice.

Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-riscv@lists.infradead.org

Jiri Slaby (3):
  tty: serial: introduce transmit helper generators
  tty: serial: use DEFINE_UART_PORT_TX_HELPER()
  tty: serial: use DEFINE_UART_PORT_TX_HELPER_LIMITED()

 Documentation/driver-api/serial/driver.rst |  3 +
 drivers/tty/serial/21285.c                 | 33 ++-------
 drivers/tty/serial/altera_jtaguart.c       | 42 +++--------
 drivers/tty/serial/altera_uart.c           | 37 ++--------
 drivers/tty/serial/amba-pl010.c            | 37 ++--------
 drivers/tty/serial/apbuart.c               | 36 ++-------
 drivers/tty/serial/atmel_serial.c          | 29 ++------
 drivers/tty/serial/bcm63xx_uart.c          | 47 +++---------
 drivers/tty/serial/fsl_lpuart.c            | 38 +++-------
 drivers/tty/serial/lantiq.c                | 44 +++--------
 drivers/tty/serial/lpc32xx_hs.c            | 38 ++--------
 drivers/tty/serial/mcf.c                   | 27 ++-----
 drivers/tty/serial/mpc52xx_uart.c          | 44 +----------
 drivers/tty/serial/mps2-uart.c             | 29 +-------
 drivers/tty/serial/mux.c                   | 46 ++++--------
 drivers/tty/serial/mvebu-uart.c            | 40 ++--------
 drivers/tty/serial/mxs-auart.c             | 31 ++------
 drivers/tty/serial/omap-serial.c           | 47 +++---------
 drivers/tty/serial/owl-uart.c              | 35 +--------
 drivers/tty/serial/pxa.c                   | 39 +++-------
 drivers/tty/serial/rp2.c                   | 36 ++-------
 drivers/tty/serial/sa1100.c                | 49 +++++-------
 drivers/tty/serial/serial_txx9.c           | 37 ++--------
 drivers/tty/serial/sifive.c                | 45 ++---------
 drivers/tty/serial/sprd_serial.c           | 38 ++--------
 drivers/tty/serial/st-asc.c                | 50 ++-----------
 drivers/tty/serial/vt8500_serial.c         | 40 ++--------
 include/linux/serial_core.h                | 86 ++++++++++++++++++++++
 28 files changed, 280 insertions(+), 823 deletions(-)

-- 
2.37.2

