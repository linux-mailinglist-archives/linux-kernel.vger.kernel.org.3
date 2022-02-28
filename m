Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDA4C635D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiB1GvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiB1GvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:51:10 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC254F444;
        Sun, 27 Feb 2022 22:50:29 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Mon, 28 Feb 2022
 14:50:27 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Yu Tu <yu.tu@amlogic.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tty: serial: meson: Fix the compile link error reported by kernel test robot
Date:   Mon, 28 Feb 2022 14:49:10 +0800
Message-ID: <20220228064910.11636-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describes the calculation of the UART baud rate clock using a clock
frame. Forgot to add in Kconfig kernel test Robot compilation error
due to COMMON_CLK dependency.

Fixes: 44023b8e1f14 ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..a0f2b82fc18b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
 config SERIAL_MESON
 	tristate "Meson serial port support"
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on COMMON_CLK
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Amlogic

base-commit: c2faf737abfb10f88f2d2612d573e9edc3c42c37
-- 
2.33.1

