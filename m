Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988852CDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiESH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiESH51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:57:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2363C49E;
        Thu, 19 May 2022 00:57:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5265E21B2F;
        Thu, 19 May 2022 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652947041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z4alrCp3n4M0QAnk7ntgmbNwbf4GzlpevASy3Qy1ZPA=;
        b=oDq8z7z9nwwgvEFVsyo8Bs3jDH/asiWOWdV+gl7rHnQDKeMRVNUWBRSef6oc+dYPa5mwQJ
        y6b6XcUcXmSCECjDzY7kwtKlKzGUDUa7keDKShBDmOAWW9Fp71iHZCUwA73xjtoMAZanNG
        fT7EkOEev5IbII4H+ep9ou8U38R28T0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652947041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z4alrCp3n4M0QAnk7ntgmbNwbf4GzlpevASy3Qy1ZPA=;
        b=P9J+Ym70oKtZgRoiVhlbUKzD3IseUrsaIDdKZdyKzAYraA86AU22KUaPpks3D1wlb7IXt0
        TsYa8mM5YxxOp6Bg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A8862C141;
        Thu, 19 May 2022 07:57:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] serial: amba-pl011: move header content to .c
Date:   Thu, 19 May 2022 09:57:20 +0200
Message-Id: <20220519075720.31402-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point keeping the header content separated. In this case, it
is only an enum. So move the enum to the appropriate source file.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++--
 drivers/tty/serial/amba-pl011.h | 35 ---------------------------------
 2 files changed, 30 insertions(+), 37 deletions(-)
 delete mode 100644 drivers/tty/serial/amba-pl011.h

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 98c45a57e6e9..97ef41cb2721 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -42,8 +42,6 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 
-#include "amba-pl011.h"
-
 #define UART_NR			14
 
 #define SERIAL_AMBA_MAJOR	204
@@ -55,6 +53,36 @@
 #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
+enum {
+	REG_DR,
+	REG_ST_DMAWM,
+	REG_ST_TIMEOUT,
+	REG_FR,
+	REG_LCRH_RX,
+	REG_LCRH_TX,
+	REG_IBRD,
+	REG_FBRD,
+	REG_CR,
+	REG_IFLS,
+	REG_IMSC,
+	REG_RIS,
+	REG_MIS,
+	REG_ICR,
+	REG_DMACR,
+	REG_ST_XFCR,
+	REG_ST_XON1,
+	REG_ST_XON2,
+	REG_ST_XOFF1,
+	REG_ST_XOFF2,
+	REG_ST_ITCR,
+	REG_ST_ITIP,
+	REG_ST_ABCR,
+	REG_ST_ABIMSC,
+
+	/* The size of the array - must be last */
+	REG_ARRAY_SIZE,
+};
+
 static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 	[REG_DR] = UART01x_DR,
 	[REG_FR] = UART01x_FR,
diff --git a/drivers/tty/serial/amba-pl011.h b/drivers/tty/serial/amba-pl011.h
deleted file mode 100644
index 077eb12a3472..000000000000
--- a/drivers/tty/serial/amba-pl011.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef AMBA_PL011_H
-#define AMBA_PL011_H
-
-enum {
-	REG_DR,
-	REG_ST_DMAWM,
-	REG_ST_TIMEOUT,
-	REG_FR,
-	REG_LCRH_RX,
-	REG_LCRH_TX,
-	REG_IBRD,
-	REG_FBRD,
-	REG_CR,
-	REG_IFLS,
-	REG_IMSC,
-	REG_RIS,
-	REG_MIS,
-	REG_ICR,
-	REG_DMACR,
-	REG_ST_XFCR,
-	REG_ST_XON1,
-	REG_ST_XON2,
-	REG_ST_XOFF1,
-	REG_ST_XOFF2,
-	REG_ST_ITCR,
-	REG_ST_ITIP,
-	REG_ST_ABCR,
-	REG_ST_ABIMSC,
-
-	/* The size of the array - must be last */
-	REG_ARRAY_SIZE,
-};
-
-#endif
-- 
2.36.1

