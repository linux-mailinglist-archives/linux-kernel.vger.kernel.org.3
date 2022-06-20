Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D985515ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiFTKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiFTKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:34:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032CF14009;
        Mon, 20 Jun 2022 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721258; x=1687257258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zmxbLYlnkxBAQmR/2fS0geh0ltLbCws9XW57e8DibYw=;
  b=CnnPLy+VcS45pThZbH+pcmb+ICd0uVKBNrha3lgkGMeUGvO1Jtd39+QZ
   uqc3QaUQWGvMH0RkrMkqMliNkFn/iDLWzu5ol7M0Ef2DEcAj0/KXPjyQb
   VCz2Aj1WNVTu5JZ1R6CawehygiYnBwgw1H6i2Tel3siR00hJLnIAp8zxQ
   Qw+UyR8gz4wYl0tf4k9NjvfSKkjkN83CGK8MIM4HsAKXyuMMSHUpzBXte
   coHQqWiKUpqp//AbbKr9urfqFvwTMJ9weY/V2uaVDzTc4LonAvyiodGpz
   w2xPd68L+i9ozDTCq1qgjBelcPXwyT6ibohWzYwbUIbZ6rqNv/WW0mxoG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341543238"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341543238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643055478"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/6] serial: A few cleanups
Date:   Mon, 20 Jun 2022 13:34:02 +0300
Message-Id: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few cleanup to semi-random things I've come across while
reading the code.

The series had initially only patches 3-6 but then msm_serial exploded
during build because of redefining UART_SCR so I had to resolve the
namespace conflict. It would have probably being avoided if there would
have been linux/serial_reg.h but it was recently ruled out:

  https://lore.kernel.org/lkml/CAPDyKFqHLQ8YTc3wzaFOdAA7Ay9RBEfdQC5uN574=oMavi6iCQ@mail.gmail.com/t/

(Now there would 3 items already in serial_reg.h already but it would
leave only async_icount into serial.h so the same problem in other
file).

Ilpo Järvinen (6):
  serial: msm: Convert container_of UART_TO_MSM to static inline
  serial: msm: Rename UART_* defines to MSM_UART_*
  serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
  serial: 8250: Use C99 array initializer & define UART_REG_UNMAPPED
  cleanup: Use UART_XMIT_SIZE
  serial: Consolidate BOTH_EMPTY use

 arch/mips/ath79/early_printk.c           |   9 +-
 drivers/accessibility/speakup/serialio.h |   3 +-
 drivers/tty/amiserial.c                  |  18 +-
 drivers/tty/mips_ejtag_fdc.c             |   2 +-
 drivers/tty/serial/8250/8250_early.c     |   4 +-
 drivers/tty/serial/8250/8250_port.c      |  50 +--
 drivers/tty/serial/meson_uart.c          |   2 +-
 drivers/tty/serial/msm_serial.c          | 550 ++++++++++++-----------
 drivers/tty/serial/omap-serial.c         |   7 +-
 drivers/tty/serial/owl-uart.c            |   2 +-
 drivers/tty/serial/pch_uart.c            |   7 +-
 drivers/tty/serial/pxa.c                 |   5 +-
 drivers/tty/serial/rda-uart.c            |   2 +-
 drivers/tty/serial/sunsu.c               |   4 +-
 drivers/tty/serial/vr41xx_siu.c          |   4 +-
 include/linux/serial.h                   |  15 +-
 include/linux/serial_core.h              |   1 +
 include/uapi/linux/serial_reg.h          |   4 +-
 18 files changed, 343 insertions(+), 346 deletions(-)

-- 
2.30.2

