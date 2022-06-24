Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9C55A315
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiFXUyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:54:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D397B377;
        Fri, 24 Jun 2022 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656104076; x=1687640076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OGRCWcSZbuCnqCgexufNep7K7yBOQCMz/pRFnb9S8RA=;
  b=UywqbOgwdqdkICfDYnAaHz5oVdDodF6dfOdW6zIk6MnjoyocElrRJwEQ
   FJ80LKF/DSy97F2RrpV3vsVc/TjVwjPFV3S14m6MjAZXYlxU3oqLgJmLn
   t2Pg5L2MnXrz+vUkN54QTncaFD7kZFHELY8EZ0LAvzDkfdjArvWMcW/zs
   m3Uil9cJPZ8MLQZXnDB33zfr7BXSLkRVOc4K2a/pIPPJrsdoihCn8+iim
   paBmkM6S90xx1eAMUJ3LkRZQDV0dliTOybZUh2iwWxB0mru7Gv3emckuL
   aLEK6R0o4/e6yMEdl9SqQ6Ad6BUknbqhgV2LwOrdlo/MNlHg+RryiHOXP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="306556523"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="306556523"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:54:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593384218"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:54:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/6] serial: A few cleanups
Date:   Fri, 24 Jun 2022 23:54:18 +0300
Message-Id: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v3:
- Remove one useless comment
- Improve changelog texts

v2:
- Fix commit summary line prefix


Ilpo Järvinen (6):
  serial: msm: Convert container_of UART_TO_MSM to static inline
  serial: msm: Rename UART_* defines to MSM_UART_*
  serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
  serial: 8250: Use C99 array initializer & define UART_REG_UNMAPPED
  serial: Convert SERIAL_XMIT_SIZE to UART_XMIT_SIZE
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
 include/uapi/linux/serial_reg.h          |   4 +-
 17 files changed, 342 insertions(+), 346 deletions(-)

-- 
2.30.2

