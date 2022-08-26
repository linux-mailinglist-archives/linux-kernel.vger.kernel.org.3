Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA45A29E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245523AbiHZOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiHZOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:46:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D346D83F4;
        Fri, 26 Aug 2022 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661525199; x=1693061199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lrkbEel9E6B0PP9dLyPE/JPHK7dXu9ZUcZME2ofOvao=;
  b=MCVpipV8m8sFMuZSPETVk3YLbtN2TGwSxV5TXIFPHMqgJBQIYPEHbWSe
   aWArAABYu29RuuE57c/KgZuWL6/bjpiQVCMMxVyTpWFDY8qUfnYBEWJhM
   RyIAEJGLJtUw8RSf0aWuObPv14cqhc4Vu/JX09hhf3k6wpqHJrkTRHJmy
   ivNzMGx8w8VrkpCTIqpzIRDFm12/0X60/wAHG5mPvfddda+5o42RBWzLT
   4OYCmoy01ccHH0sOT6NeBjLGxSvbyNxsVe+zAJnTjuQ19Q9eoaWIiFJJv
   nd64cg0FMgVdOmFEBGFq4TmQL5WdaIXBCnDnM+z7qSdsVBUMvm9fjuaKP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295792955"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295792955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671488293"
Received: from syeghiay-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.41.100])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 07:46:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] serial: Create kserial_rs485 to get rid of padding
Date:   Fri, 26 Aug 2022 17:46:26 +0300
Message-Id: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serial_rs485 contains padding at the end to make extending it easier.
Create kserial_rs485 counterpart w/o padding for kernel use leaving
serial_rs485 only to be used for uapi.

Ilpo Järvinen (3):
  serial: Rename vars in uart_get_rs485_config()
  serial: add helpers to copy serial_rs485 from/to userspace
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
 drivers/tty/serial/serial_core.c              | 81 +++++++++++++------
 drivers/tty/serial/stm32-usart.c              | 12 +--
 include/linux/serial_core.h                   | 20 ++++-
 include/uapi/linux/serial.h                   |  3 +-
 21 files changed, 127 insertions(+), 79 deletions(-)

-- 
2.30.2

