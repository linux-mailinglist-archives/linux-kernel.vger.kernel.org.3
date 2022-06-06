Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7453EBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiFFKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiFFKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2F66207;
        Mon,  6 Jun 2022 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509924; x=1686045924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nl/Cl7bz5pNe4naULcGm3w7oTRumNgiPNhJiqVmMNic=;
  b=G/HkFiUOP21asFpjjl2LoKxG4Jk28WhOxGpUY8oGwfe2l/LrTStkh+dU
   6YnHKiLAEZAeIgXAegB3E0ceyI78JDs/bgirCrOsJAJ5yGAuiDxmnn5V+
   W4b9UMe4yNjqyzsN8wCVl0M9UWgLlIplNvsJfHT4L3+9s8ScVmeimVDEd
   j6ZIUM9TFq/cxLEFA55TgNtecpcGYRfBRNa6Hf07Qi4aPPSeXhmg0sjon
   TS3KTEE183OzoTZ4yJH34qoJq11tb3aYZYDkwKJ/y/er0x4F7HROmWTrO
   Job3m94YqCC2+6E4LMtOgt380CsIRI9QOmKQ0jSbWFpncd27B79R1hmXk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987024"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987024"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523353"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:04:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        alexandre.belloni@bootlin.com, alexandre.torgue@foss.st.com,
        andriy.shevchenko@linux.intel.com,
        bcm-kernel-feedback-list@broadcom.com,
        claudiu.beznea@microchip.com, corbet@lwn.net, festevam@gmail.com,
        f.fainelli@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, nicolas.ferre@microchip.com,
        nsaenz@kernel.org, richard.genoud@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        vz@mleia.com
Subject: [PATCH 00/36] RS485 serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:03:57 +0300
Message-Id: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sanitization to serial_rs485 struct before passing it
to driver's rs485_config. This takes the work Lino Sanfilippo started
(0ed12afa5655^..60efd0513916) a bit further. By moving sanitization of
the rs485 struct into the serial core, per driver rs485_config() is
more into the point, that is, setting up the hw to realize RS485.

The other benefit is that with the sanitization, the other drivers no
longer need to care when new things are added to serial_rs485 as serial
core handles them on the other drivers' behalf. The addressing mode
changes I'll submit separately will take advantage of this. The
addressing mode changes were the main motivator for doing the changes,
however, I believe these changes stand on their feet even w/o
considering the addressing mode changes.

The series is long because per driver changes are split into two
different stages. The key objectives here for the split have been to
keep things bisect safe and to do changes per driver rather than in one
large block. This required 4 stages:

  1) Add datastructure entries & other preps (01-03)
  2) Per driver rs485_supported (04-21)
  3) Sanitization, core taking advantage of rs485_supported (22-24)
  4) Cleanup per driver custom sanitization code (25-36)

As you can see, the downside of this split is that the per driver code
is split to 2+4 patches which makes some things moving less obvious.
Merging them is only possible if the stages 2-4 are done in one large
change (little bits here and there could be left out from it but not
much).

In stage 3 patches, there are a few userspace interface impacting
changes with userspace api regression potential:

  a) Some drivers have not cleared flags/fields in per driver code while
     other drivers have. The old behavior is inconsistent. Now the bits
     will get cleaned up by serial core. I don't believe it's going to
     cause issues.

  b) Init path now sanitizes configuration if rs485_config is being
     called from the init path (mainly coming from dt). It attempts to
     repair some incorrect configurations which seems ok.

     However, if RS485 mode is not enabled at boot, serial_rs485 struct
     gets cleared in order for it to match what the port is configured
     with (RS232). Such clearing implies losing values that were
     configured through dt and that could perhaps be seen as unwanted
     side-effect from having consistent serial_rs485?

     There is also impact for the ioctl path from this clearing of
     serial_rs485 when RS485 is disabled but impact seems minor at most.

  c) Returning -EINVAL for non-legacy flags. This also affects setting
     bits that were previously padding (that is, all flags bits
     currently not defined in include/uapi/linux/serial.h). It was
     possible to put garbage into them earlier but no more. I guess
     this is not very likely a big issue. No non-legacy flags are
     added in this series (the addressing mode changes submitted
     separately will add new flags).

Cc: alexandre.belloni@bootlin.com
Cc: alexandre.torgue@foss.st.com
Cc: andriy.shevchenko@linux.intel.com
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: claudiu.beznea@microchip.com
Cc: corbet@lwn.net
Cc: festevam@gmail.com
Cc: f.fainelli@gmail.com
Cc: kernel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux@armlinux.org.uk
Cc: linux-doc@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: mcoquelin.stm32@gmail.com
Cc: nicolas.ferre@microchip.com
Cc: nsaenz@kernel.org
Cc: richard.genoud@gmail.com
Cc: rjui@broadcom.com
Cc: sbranden@broadcom.com
Cc: s.hauer@pengutronix.de
Cc: shawnguo@kernel.org
Cc: vz@mleia.com

Ilpo Järvinen (36):
  serial: Add uart_rs485_config()
  serial: Move serial_rs485 sanitization into separate function
  serial: Add rs485_supported to uart_port
  serial: 8250: Create serial8250_em485_supported for em485 users
  serial: 8250_bcm2835aux: Use serial8250_em485_supported
  serial: 8250_dwlib: Fill in rs485_supported
  serial: 8250_exar: Fill in rs485_supported
  serial: 8250_fintek: Fill in rs485_supported
  serial: 8250_lpc18cc: Fill in rs485_supported
  serial: 8250_of: Use serial8250_em485_supported
  serial: 8250_pci: Fill in rs485_supported for pci_fintek
  serial: pl011: Fill in rs485_supported
  serial: ar933x: Fill in rs485_supported
  serial: atmel: Fill in rs485_supported
  serial: fsl_lpuart: Fill in rs485_supported
  serial: imx: Fill in rs485_supported
  serial: max310x: Fill in rs485_supported
  serial: mcf: Fill in rs485_supported
  serial: omap: Fill in rs485_supported
  serial: sc16is7xx: Fill in rs485_supported
  serial: stm32: Fill in rs485_supported
  serial: Sanitize rs485_struct
  serial: Clear rs485 struct when non-RS485 mode is set
  serial: return -EINVAL for non-legacy RS485 flags
  serial: 8250_dwlib: Remove serial_rs485 sanitization
  serial: 8250_fintek: Remove serial_rs485 sanitization
  serial: 8250: lpc18xx: Remove serial_rs485 sanitization
  serial: 8250_pci: Remove serial_rs485 sanitization
  serial: pl011: Remove serial_rs485 sanitization
  serial: fsl_lpuart: Call core's sanitization and remove custom one
  serial: imx: Remove serial_rs485 sanitization
  serial: max310x: Remove serial_rs485 sanitization
  serial: 8250_exar: Remove serial_rs485 assignment
  serial: mcf: Remove serial_rs485 assignment
  serial: sc16is7xx: Remove serial_rs485 assignment
  serial: 8250: Remove serial_rs485 sanitization from em485

 .../driver-api/serial/serial-rs485.rst        |  12 +-
 drivers/tty/serial/8250/8250.h                |   1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c     |   1 +
 drivers/tty/serial/8250/8250_core.c           |   1 +
 drivers/tty/serial/8250/8250_dwlib.c          |  17 +--
 drivers/tty/serial/8250/8250_exar.c           |  14 +-
 drivers/tty/serial/8250/8250_fintek.c         |  29 +++--
 drivers/tty/serial/8250/8250_lpc18xx.c        |  20 +--
 drivers/tty/serial/8250/8250_of.c             |   1 +
 drivers/tty/serial/8250/8250_pci.c            |  24 +---
 drivers/tty/serial/8250/8250_port.c           |  28 ++--
 drivers/tty/serial/amba-pl011.c               |  13 +-
 drivers/tty/serial/ar933x_uart.c              |   7 +
 drivers/tty/serial/atmel_serial.c             |   7 +
 drivers/tty/serial/fsl_lpuart.c               |  25 +---
 drivers/tty/serial/imx.c                      |  19 ++-
 drivers/tty/serial/max310x.c                  |   9 +-
 drivers/tty/serial/mcf.c                      |   7 +-
 drivers/tty/serial/omap-serial.c              |   8 ++
 drivers/tty/serial/sc16is7xx.c                |   8 +-
 drivers/tty/serial/serial_core.c              | 120 ++++++++++++++----
 drivers/tty/serial/stm32-usart.c              |   8 ++
 include/linux/serial_core.h                   |   2 +
 23 files changed, 247 insertions(+), 134 deletions(-)

-- 
2.30.2

