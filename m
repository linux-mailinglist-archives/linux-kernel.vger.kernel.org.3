Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84139553279
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbiFUMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbiFUMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:50:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD602872B;
        Tue, 21 Jun 2022 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815809; x=1687351809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFtimXlg9dBBb6HEEdgVlKr19m9u0dmma7Bcoe3d/kA=;
  b=AafMsW+POJs1kdIctjFIR/nH0blad+K1W4slcr2+1AmiuhBRHqJ8L/qX
   RBLXRu7t4O5hXXWdMthAwNverqbrcM2UnLY/ICOVzLCWlQk8jwXf/jDae
   HJZvNiMOakoRm2D1AxkAFSYcTgfIGmZSz6vKuZyzXG66Ecs6k2XbQIcIM
   kKmZEIDr2XVqU+WFBBBXlej0mIJlaLiWxr5PWVvKaUe4RN1Ag7Nm8Crcn
   feR7IcMEivD07zpl81nv6JxOmYf2BuSgKhC5DAQdh4sg3sHOD6GFnKatP
   8doe8louxQt7H0h7VXWuq37g9pjmz/58LMhaKB1iJhLA3JgG367VGBdtc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341792947"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341792947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833561536"
Received: from zjeffery-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/6] serial: A few cleanups
Date:   Tue, 21 Jun 2022 15:49:52 +0300
Message-Id: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
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

v2:
- Fix commit summary line prefix

Ilpo Järvinen (6):
  serial: msm: Convert container_of UART_TO_MSM to static inline
  serial: msm: Rename UART_* defines to MSM_UART_*
  serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
  serial: 8250: Use C99 array initializer & define UART_REG_UNMAPPED
  serial: Use UART_XMIT_SIZE
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

