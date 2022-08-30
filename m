Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099225A5CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiH3HaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiH3HaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:30:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7B2CDE4;
        Tue, 30 Aug 2022 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661844608; x=1693380608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJ3xfpDB50oRsgZT9ZtW5Rny2olH7LNef/rdMxD09qY=;
  b=K0iTiSVSw/KrtGuBfpDY9jTfXJ53BrdGf6ps40Egp3LmimweCqVGFKH1
   lmgT1/0SJ5At74T+6iPTqacwiFLuBfBTw1rZo83FMpBkZKGGBAPRxr2LT
   Zep9nn7dWWCPVmg4znUxDSPinj8x7mxw/HrLaQmJuMUONQagCb3wPnT5p
   lltIBsHt7mQrEoX2ggOP1u9Qimvuqmdi3/8kec1l7b4+UgH8LCeAlH12e
   ThaEElEbCTjuTNUI79JuktDUf6g7N+f/x+m86pGVdQzYpKYtthrU6U5vQ
   uJpwQlpT21LY16E2u+mXGEr9r8TZirEymLhiSKFLDy3Q6GgWLpb17cV1R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282077215"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282077215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641262611"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:30:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] serial: Create kserial_rs485 to get rid of padding
Date:   Tue, 30 Aug 2022 10:29:52 +0300
Message-Id: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serial_rs485 contains padding at the end to make extending it easier.
Create kserial_rs485 counterpart w/o padding for kernel use leaving
serial_rs485 only to be used for uapi.

v2:
- Address style comments (from Andy)
- Convert most of the serial_rs485 & kserial_rs485 inline comments to
  kernel doc

Ilpo Järvinen (4):
  serial: Rename vars in uart_get_rs485_config()
  serial: add helpers to copy serial_rs485 from/to userspace
  serial: Convert serial_rs485 to kernel doc
  serial: Add kserial_rs485 to avoid wasted space due to .padding

 .../driver-api/serial/serial-rs485.rst        |  2 +-
 drivers/tty/serial/8250/8250.h                |  4 +-
 drivers/tty/serial/8250/8250_dwlib.c          |  6 +-
 drivers/tty/serial/8250/8250_exar.c           | 12 +--
 drivers/tty/serial/8250/8250_fintek.c         |  6 +-
 drivers/tty/serial/8250/8250_lpc18xx.c        |  4 +-
 drivers/tty/serial/8250/8250_pci.c            |  4 +-
 drivers/tty/serial/8250/8250_port.c           |  4 +-
 drivers/tty/serial/amba-pl011.c               |  4 +-
 drivers/tty/serial/ar933x_uart.c              |  8 +-
 drivers/tty/serial/atmel_serial.c             |  4 +-
 drivers/tty/serial/fsl_lpuart.c               |  6 +-
 drivers/tty/serial/imx.c                      |  6 +-
 drivers/tty/serial/max310x.c                  |  4 +-
 drivers/tty/serial/mcf.c                      |  4 +-
 drivers/tty/serial/omap-serial.c              |  6 +-
 drivers/tty/serial/sc16is7xx.c                |  6 +-
 drivers/tty/serial/serial_core.c              | 87 +++++++++++++------
 drivers/tty/serial/stm32-usart.c              | 12 +--
 include/linux/serial_core.h                   | 29 ++++++-
 include/uapi/linux/serial.h                   | 63 +++++++++-----
 21 files changed, 181 insertions(+), 100 deletions(-)

-- 
2.30.2

