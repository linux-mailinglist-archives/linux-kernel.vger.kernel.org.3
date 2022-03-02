Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6334CA171
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiCBJ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiCBJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:57:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A49E559;
        Wed,  2 Mar 2022 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646215019; x=1677751019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FY6wwev4tVzVQLPJp8tN5rXAxWrMHWCGBFvKrS5tF/8=;
  b=WiDDT/9suQH4dXrC/CEbJa/UA7Tuz0ZgEF7FZM72JeHtBaJ583TS5yqH
   Fxb8142JGTvFzPQhL/tHQ2GYa8oRYRtIH5u9Y01i0Tdo+m09OhPphV+9L
   tMdKyefwLK4DFTdb610/mfUvVbppBYH1CTH9D+kx5j0noRKn0HjexTTTp
   ZpQbajJO9Bq7wl1m951WrdYlNtSfbWMX0pOq+jY1iaud+XIOB4+mj0zFt
   xDeMUrZIf7f6eupWUL8r7uRBUaMXKRLkXLZMoKGOftzozjVcmO7i24ck8
   ouqLs40ktOMihaYgNdhdL3e6ec2XGtbd4p2E/eMpmK6j32QZsVyVdXUv7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="250939211"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="250939211"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:56:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="551181972"
Received: from abotoi-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.218.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:56:46 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] Add RS485 support to DW UART
Date:   Wed,  2 Mar 2022 11:55:59 +0200
Message-Id: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds RS-485 support to the DW UART driver. The patchset
has two main parts. The first part adds HW support for RS-485 itself
in various modes of operation and the second part focuses on enabling
9th bit addressing mode that can be used on a multipoint RS-485
communications line.

SW half-duplex patch (3/7) depends on UART_CAP_NOTEMT for which there
is existing work from others:
  https://marc.info/?l=linux-kernel&m=161245538311420&w=2
That patchset is not yet applied (and requires revision from its
author).

To configure multipoint addressing, ADDRB flag is added to termios
and two new IOCTLs are added into serial core. On the driver side,
I looked into using mux subsystem but its model didn't seem to match
well enough to how RS-485 multipoint can be operated.

I'm aware of the RS485 changes Lino Sanfilippo recently posted
which will make one assignment in the patchset redundant. I'll make
the adjustment if those get applied.

Ilpo Järvinen (7):
  serial: 8250_dwlib: RS485 HW half duplex support
  serial: 8250_dwlib: RS485 HW full duplex support
  serial: 8250_dwlib: Implement SW half duplex support
  dt_bindings: snps-dw-apb-uart: Add RS485
  serial: termbits: ADDRB to indicate 9th bit addressing mode
  serial: General support for multipoint addresses
  serial: 8250_dwlib: Support for 9th bit multipoint addressing

 .../bindings/serial/snps-dw-apb-uart.yaml     |  17 ++
 .../driver-api/serial/serial-rs485.rst        |  23 +-
 arch/alpha/include/uapi/asm/ioctls.h          |   3 +
 arch/alpha/include/uapi/asm/termbits.h        |   1 +
 arch/mips/include/uapi/asm/ioctls.h           |   3 +
 arch/mips/include/uapi/asm/termbits.h         |   1 +
 arch/parisc/include/uapi/asm/ioctls.h         |   3 +
 arch/parisc/include/uapi/asm/termbits.h       |   1 +
 arch/powerpc/include/uapi/asm/ioctls.h        |   3 +
 arch/powerpc/include/uapi/asm/termbits.h      |   1 +
 arch/sh/include/uapi/asm/ioctls.h             |   3 +
 arch/sparc/include/uapi/asm/ioctls.h          |   3 +
 arch/sparc/include/uapi/asm/termbits.h        |   1 +
 arch/xtensa/include/uapi/asm/ioctls.h         |   3 +
 drivers/tty/amiserial.c                       |   6 +-
 drivers/tty/moxa.c                            |   1 +
 drivers/tty/mxser.c                           |   1 +
 drivers/tty/serial/8250/8250_core.c           |   2 +
 drivers/tty/serial/8250/8250_dwlib.c          | 246 +++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h          |   6 +
 drivers/tty/serial/serial_core.c              |  62 +++++
 drivers/tty/tty_ioctl.c                       |   2 +
 drivers/usb/serial/usb-serial.c               |   5 +-
 include/linux/serial_core.h                   |   6 +
 include/uapi/asm-generic/ioctls.h             |   3 +
 include/uapi/asm-generic/termbits.h           |   1 +
 include/uapi/linux/serial.h                   |  10 +
 27 files changed, 410 insertions(+), 7 deletions(-)

-- 
2.30.2

