Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B939565134
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGDJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGDJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:45:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCE6305;
        Mon,  4 Jul 2022 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656927927; x=1688463927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VKsSywBsVlwI44RKg1+Y9KR6umXYJC/eD872YN1rLhg=;
  b=CGK1VUtKfPD1KTHkpQJA50x5GY8z4D5FCKrItNJfnSYrXPwfeBqhFO3L
   9G8LFSeQ2FU5trjfLQzvR3emr1FVeUy4gYvf4HnkctK8vuDQeD5I1LVS+
   pfXZ2VXZXanVTc1REFSHLkO2r1M+xELz/nivNXitH1DEmcCktgEM+3Kg1
   B04yBL2GTS61j04TezDet8fpIWGAB9P8eAssdsONG0IXDInbYOokc4rfx
   Mf1xfyvdLaT5cUCzDYWPDvLwPU3srq1xwM3mgERjAuiXKLqlWtQSp1pbs
   ck+EytdrC2N5amWDT2U477E8d5vKCWj5MBw1UcSybbrY4FXcPWymTdNrm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="266111766"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266111766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:45:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649508686"
Received: from bclindho-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:45:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] serial: RS485 termination improvements
Date:   Mon,  4 Jul 2022 12:45:13 +0300
Message-Id: <20220704094515.6831-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves termination handling for RS485. Effectively,
.rs485_supported is made a per port and the termination flag is enabled
when DT configures termination. The downside of this is that embedded
struct consumes a little bit of more memory, especially as struct
serial_rs485 has the padding field.

There is other problem on this area besides the one addressed by this
series which is new since the introduction of .rs485_supported. Lino's
patch series addresses the ability to tweak the termination through
->rs485_config() for any driver.

For kernel uses, struct kserial_rs485 version of serial_rs485 could be
added and both .rs485 and .rs485_supported converted to it leaving
struct_rs485 only for UAPI use. This series, howver, doesn't attempt
it. It seems relatively easy to build it on top of these changes
though.


Ilpo Järvinen (2):
  serial: Embed rs485_supported
  serial: RS485 termination is supported if DT provides one

 drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
 drivers/tty/serial/8250/8250_dwlib.c      |  4 ++--
 drivers/tty/serial/8250/8250_exar.c       |  2 +-
 drivers/tty/serial/8250/8250_fintek.c     |  4 ++--
 drivers/tty/serial/8250/8250_lpc18xx.c    |  2 +-
 drivers/tty/serial/8250/8250_of.c         |  2 +-
 drivers/tty/serial/8250/8250_pci.c        |  2 +-
 drivers/tty/serial/amba-pl011.c           |  2 +-
 drivers/tty/serial/ar933x_uart.c          |  4 ++--
 drivers/tty/serial/atmel_serial.c         |  2 +-
 drivers/tty/serial/fsl_lpuart.c           |  2 +-
 drivers/tty/serial/imx.c                  |  4 ++--
 drivers/tty/serial/max310x.c              |  2 +-
 drivers/tty/serial/mcf.c                  |  4 ++--
 drivers/tty/serial/omap-serial.c          |  2 +-
 drivers/tty/serial/sc16is7xx.c            |  2 +-
 drivers/tty/serial/serial_core.c          | 10 ++++++----
 drivers/tty/serial/stm32-usart.c          |  2 +-
 include/linux/serial_core.h               |  2 +-
 19 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.30.2

