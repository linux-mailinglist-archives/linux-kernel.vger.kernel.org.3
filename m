Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574884D9CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348835AbiCONxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiCONxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:53:49 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120653706
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:52:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1dc0:e57f:6975:ecb9])
        by andre.telenet-ops.be with bizsmtp
        id 6dsZ2700S3jtd4z01dsZVM; Tue, 15 Mar 2022 14:52:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nU7bF-004ZU2-Dv; Tue, 15 Mar 2022 14:52:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nU7bF-002jOr-2N; Tue, 15 Mar 2022 14:52:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: SERIAL_SUNPLUS should depend on ARCH_SUNPLUS
Date:   Tue, 15 Mar 2022 14:52:32 +0100
Message-Id: <59f46272ab5b16853acac4d585c3333cfd394223.1647352195.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunplus serial ports are only present on Sunplus SoCs.  Hence add a
dependency on ARCH_SUNPLUS, to prevent asking the user about this driver
when configuring a kernel without Sunplus SoC support.

Fixes: 9e8d5470325f25be ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c00a3..5551192560bb49d3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,7 +1566,7 @@ config SERIAL_LITEUART_CONSOLE
 
 config SERIAL_SUNPLUS
 	tristate "Sunplus UART support"
-	depends on OF || COMPILE_TEST
+	depends on ARCH_SUNPLUS || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Select this option if you would like to use Sunplus serial port on
-- 
2.25.1

