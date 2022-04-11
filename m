Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B184FBA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbiDKK4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbiDKK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:56:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A0B12;
        Mon, 11 Apr 2022 03:54:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8BED81F38D;
        Mon, 11 Apr 2022 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j1s/ljyl7zRa3Wwc8LKTq4IIoQmYHWi7pP4k8x7uAGE=;
        b=UTiDDmUHwjaSsgqSy4T6CE3RTR8l+AnaXBjXW2ap/oDIsan5ZsvNBm2HM/XMMiOftaqqrK
        A8lEUQKIGeOmYFOU9L4oju9eMuMTurRmqIStodrOOkwJh4c/F3KHeJKmDOUh4E0DAMmp3A
        8iKjxbiu1viVQPm3c0vm7LW//vNl1Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j1s/ljyl7zRa3Wwc8LKTq4IIoQmYHWi7pP4k8x7uAGE=;
        b=91vAcOt5z+ytrUcuWk8bvmToYhRU/F6vOBRZ9r7aVzeI9ni048a5Le5rVB3bf0VrRSxahD
        rYPIYAwSuBxUe4Bg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F00D2A3B87;
        Mon, 11 Apr 2022 10:54:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH 0/3] tty: TX helpers
Date:   Mon, 11 Apr 2022 12:54:02 +0200
Message-Id: <20220411105405.9519-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, this series depends on "tty: various cleanups"
(20220411104506.8990-1-jslaby@suse.cz).

This series introduces uart_port_tx{,_limit}() TX helpers. See PATCH
1/3 for the details. Comments welcome.

Then it switches drivers to use them. First, uart_port_tx() in 2/3 and
then uart_port_tx_limit() in 3/3.

The diffstat of patches 2+3 is as follows:
 27 files changed, 330 insertions(+), 883 deletions(-)
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
  tty: serial: introduce uart_port_tx{,_limit}() helpers
  tty: serial: use uart_port_tx() helper
  tty: serial: use uart_port_tx_limit() helper

 Documentation/driver-api/serial/driver.rst | 28 +++++++++++
 drivers/tty/serial/21285.c                 | 40 ++++++----------
 drivers/tty/serial/altera_jtaguart.c       | 43 +++++------------
 drivers/tty/serial/altera_uart.c           | 47 ++++++-------------
 drivers/tty/serial/amba-pl010.c            | 40 +++-------------
 drivers/tty/serial/apbuart.c               | 37 +++------------
 drivers/tty/serial/atmel_serial.c          | 37 ++++++---------
 drivers/tty/serial/bcm63xx_uart.c          | 48 ++++---------------
 drivers/tty/serial/fsl_lpuart.c            | 49 +++++++-------------
 drivers/tty/serial/lantiq.c                | 50 +++++++-------------
 drivers/tty/serial/lpc32xx_hs.c            | 53 +++++++--------------
 drivers/tty/serial/mcf.c                   | 35 ++++++--------
 drivers/tty/serial/mpc52xx_uart.c          | 54 +++++++---------------
 drivers/tty/serial/mps2-uart.c             | 44 ++++++------------
 drivers/tty/serial/mux.c                   | 48 ++++++-------------
 drivers/tty/serial/mvebu-uart.c            | 47 ++++++-------------
 drivers/tty/serial/mxs-auart.c             | 43 ++++++++---------
 drivers/tty/serial/omap-serial.c           | 53 ++++++---------------
 drivers/tty/serial/owl-uart.c              | 47 ++++++-------------
 drivers/tty/serial/pxa.c                   | 43 ++++-------------
 drivers/tty/serial/rp2.c                   | 36 ++++-----------
 drivers/tty/serial/sa1100.c                | 50 ++++++++------------
 drivers/tty/serial/serial_core.c           | 53 +++++++++++++++++++++
 drivers/tty/serial/serial_txx9.c           | 40 +++-------------
 drivers/tty/serial/sifive.c                | 48 +++----------------
 drivers/tty/serial/sprd_serial.c           | 41 +++-------------
 drivers/tty/serial/st-asc.c                | 51 +++-----------------
 drivers/tty/serial/vr41xx_siu.c            | 42 +++--------------
 drivers/tty/serial/vt8500_serial.c         | 47 ++++++-------------
 include/linux/serial_core.h                |  9 ++++
 30 files changed, 420 insertions(+), 883 deletions(-)

-- 
2.35.1

