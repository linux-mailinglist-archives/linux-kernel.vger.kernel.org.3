Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD3509D70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388361AbiDUKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388252AbiDUKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365728E27;
        Thu, 21 Apr 2022 03:17:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25BCC21600;
        Thu, 21 Apr 2022 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJilQ8bhQzcKnYlu51Jw3ZNoqJWqrcIlFOvokPNs7P4=;
        b=0LFDeKlXLqK7riuToQsDBZwBw1UHI1ZSa/PONl16yS69ANd3Vp3DMlN00L5Wi5eA5jRImw
        yjPQDxx7VC3iYY90sye+4oWBtp5PU/yWPH6j0slFsh2dXjNZVr2hgVp1KKECsZcnqxBdIP
        RurrsQMVOI7RLEDOlEZzcmJb2mjxu8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJilQ8bhQzcKnYlu51Jw3ZNoqJWqrcIlFOvokPNs7P4=;
        b=n/AFf/lVGOsWq6bgMByjw29zU+c47oh6LCyXIIhkBnHj/At25vmmvGtZ0LB8wHKgsN4FeF
        etPdJEtqWQEzwrDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F18332C141;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] serial: allow COMPILE_TEST for some drivers
Date:   Thu, 21 Apr 2022 12:17:08 +0200
Message-Id: <20220421101708.5640-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421101708.5640-1-jslaby@suse.cz>
References: <20220421101708.5640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more serial drivers can be compile-tested under certain
circumstances (when building a specific architecture). So allow for
that.

This reduces the need of zillion mach/subarch-specific configs. And
since the 0day bot has only allmodconfig's for some archs, this
increases build coverage there too.

Note that cpm needs a minor update in the header, so that it drags in
at least some defines (CPM2 ones).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/Kconfig             | 6 +++---
 drivers/tty/serial/cpm_uart/cpm_uart.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 20cb103972fa..2d3eed53b43e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -782,7 +782,7 @@ config SERIAL_PMACZILOG_CONSOLE
 
 config SERIAL_CPM
 	tristate "CPM SCC/SMC serial port support"
-	depends on CPM2 || CPM1
+	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
 	select SERIAL_CORE
 	help
 	  This driver supports the SCC and SMC serial ports on Motorola 
@@ -806,7 +806,7 @@ config SERIAL_CPM_CONSOLE
 
 config SERIAL_PIC32
 	tristate "Microchip PIC32 serial support"
-	depends on MACH_PIC32
+	depends on MACH_PIC32 || (MIPS && COMPILE_TEST)
 	select SERIAL_CORE
 	help
 	  If you have a PIC32, this driver supports the serial ports.
@@ -1246,7 +1246,7 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 
 config SERIAL_AR933X
 	tristate "AR933X serial port support"
-	depends on HAVE_CLK && ATH79
+	depends on (HAVE_CLK && ATH79) || (MIPS && COMPILE_TEST)
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 6113b953ce25..8c582779cf22 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -19,6 +19,8 @@ struct gpio_desc;
 #include "cpm_uart_cpm2.h"
 #elif defined(CONFIG_CPM1)
 #include "cpm_uart_cpm1.h"
+#elif defined(CONFIG_COMPILE_TEST)
+#include "cpm_uart_cpm2.h"
 #endif
 
 #define SERIAL_CPM_MAJOR	204
-- 
2.36.0

