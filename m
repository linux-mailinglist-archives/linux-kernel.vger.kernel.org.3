Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220F5A89B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiIAAIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIAAIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:08:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3136E1155
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Hd91EW3kjcTC8uTz0Z3zEpV5uiB9H4sNzGD2aIxgxZU=; b=rcvUCGONI388kgK0ZU64Ib34VB
        4F8NPsyi5KKll3lXXfQevIhUB9EArHeYUpNHHhSEPDxQTqZU5EQnU8AD88EiT88cxH4CbNDcanlr4
        QAOO+VKgC1rAkDsxpt73gen/VYjtZgrwaiEbWz05NDGADFbSnjjdMfMdTQXFGR0Za1EljFFA4Bw+D
        2h33M5pbKyZTAbvjvASm30SG51Z63MPlxY5GgxhokN4NnWmMEm0CXF9m858vrxFQL2j7BLeFKhb0D
        5O1oHIWYqz2Nn/D2xCRUkE2/y/kN6SaEytBtIepaImo/QI0u2chRgGvnfQIwL+iEQOs5bq5sh8zbY
        NvG6gBjQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTXky-005Yw5-FT; Thu, 01 Sep 2022 00:08:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Qin Jian <qinjian@cqplus1.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH v2] ARM: sunplus: fix serial console kconfig and build problems
Date:   Wed, 31 Aug 2022 17:08:21 -0700
Message-Id: <20220901000821.15376-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kconfig dependency warnings and subsequent build errors:

WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
  Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=n])
  Selected by [y]:
  - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
  Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
  Selected by [y]:
  - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

(samples, not all:)
drivers/tty/serial/sunplus-uart.c:342: undefined reference to `uart_get_baud_rate'
arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:379: undefined reference to `uart_update_timeout'
drivers/tty/serial/sunplus-uart.c:526: undefined reference to `uart_console_write'
arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:274: undefined reference to `tty_flip_buffer_push'
arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o:(.data+0xa8): undefined reference to `uart_console_device'
drivers/tty/serial/sunplus-uart.c:720: undefined reference to `uart_register_driver'
arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:726: undefined reference to `uart_unregister_driver'
drivers/tty/serial/sunplus-uart.c:551: undefined reference to `uart_parse_options'
arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.c:553: undefined reference to `uart_set_options'

This is the same technique that is used 2 times in
arch/arm/mach-versatile/Kconfig.

Fixes: 0aa94eea8d95 ("ARM: sunplus: Add initial support for Sunplus SP7021 SoC")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Qin Jian <qinjian@cqplus1.com>
Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 6.0-rc3
v2: refresh;
    add KernelVersion & patches@armlinux email;

 arch/arm/mach-sunplus/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-sunplus/Kconfig
+++ b/arch/arm/mach-sunplus/Kconfig
@@ -18,8 +18,8 @@ config SOC_SP7021
 	select ARM_PSCI
 	select PINCTRL
 	select PINCTRL_SPPCTL
-	select SERIAL_SUNPLUS
-	select SERIAL_SUNPLUS_CONSOLE
+	select SERIAL_SUNPLUS if TTY
+	select SERIAL_SUNPLUS_CONSOLE if TTY
 	help
 	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
 	  Cortex-A7 with various peripherals (e.g.: I2C, SPI, SDIO,
