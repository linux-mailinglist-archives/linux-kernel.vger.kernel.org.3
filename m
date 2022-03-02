Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5DD4CA428
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiCBLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiCBLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:50:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0BB4581
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:49:41 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ev5-20020a17090aeac500b001bc3cb23d4cso1969968pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d8Le9zjXLTZJ+dCcHcXMiX4PKgrIUfbKBFSNaT4aJ2w=;
        b=PqRZKdx/ZIHo22zRMv/XRRfiBCD45pWfFJSP3z5DrY/wrv/KtrvRL5HfxR5sENwPYz
         uL2lKGp6OBIbqLcp8G0NyxK4SPAkkPKXvHXp28cTEunJh2kabzQi2Hr6hOsay14tz6NC
         JM82YWY4QoaFAk03psAExHx8Ama6xUAchr0rBJyy0HbuxedHQjJP7QX660Uly83eJT50
         m0mgCn7m4ZtGFZc2j2hOzaSj2y+lEDdvyBXl35P0rIG4i6uEQ3r0cUQJD1R0d6HU5l2F
         gjBiuhD/gtXXv99FTZVz8UPYP3oo+C4A9QyLRUSF4KaLi2DanuxZqv6YFXbBjUUoW/1c
         rQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d8Le9zjXLTZJ+dCcHcXMiX4PKgrIUfbKBFSNaT4aJ2w=;
        b=QGg2kwGpJ+WP8iDdXjBiVDmwcddvSzcpqLsE53pNRGL/bzVAv5btfXpiLIfvVmdJ6/
         1JW0n11nO/yfJs1Eek8vsJjR11gRPUFgIXuIQX6EkQeEwpNQp1AT/8SUHVgC6+PtREa1
         TspxQBYn2kQbksjMyc4zSFADqQfVktnn398cyysdhW8dCI2CBwHCOjakTdHVSvLvxdRz
         Fa3VPfG0ivTn8tLug9Gsnc05TFR3nOo4uQdZXTtXkGp+adjvbSyvnZOF1/VN06UDnWBI
         HmSWp7nRcmz0eBmEJ2Xaet8fzL/ue71/fUGMz4945ay5F7p+nfxr+BBO+aACkjV9roi3
         jMAA==
X-Gm-Message-State: AOAM533SK+nQ9FQ9gHyEwIxkJ9vvKDPBjhN/Y6/oExM1sTgRLcN9izez
        2cg0IEQjkeTGtFS0lRj+wPEPgYPrQzjvNg==
X-Google-Smtp-Source: ABdhPJyFbde461Cotj6o6U7pY+L7SCINXBc+8oYRbBDI7yWBVpv1h2/5q5mXlKhGaSmiOZviZye58OpK8JE9dA==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:7e73:baee:4e7:d626])
 (user=woodylin job=sendgmr) by 2002:a17:902:7c94:b0:14d:77d2:a72e with SMTP
 id y20-20020a1709027c9400b0014d77d2a72emr31145588pll.153.1646221780681; Wed,
 02 Mar 2022 03:49:40 -0800 (PST)
Date:   Wed,  2 Mar 2022 19:49:23 +0800
Message-Id: <20220302114923.144523-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] serial: samsung: Add samsung_early_read to support early
 kgdboc
From:   Woody Lin <woodylin@google.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, woodylin@google.com,
        markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'kgdboc_earlycon_init' looks for boot console that has both .read
and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
console to support kgdboc.

Signed-off-by: Woody Lin <woodylin@google.com>
---
v2:
add 'const' to 'struct samsung_early_console_data *data'
---
 drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..12233c2d2a44 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
 
 struct samsung_early_console_data {
 	u32 txfull_mask;
+	u32 rxfifo_mask;
 };
 
 static void samsung_early_busyuart(struct uart_port *port)
@@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, samsung_early_putc);
 }
 
+static int samsung_early_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	const struct samsung_early_console_data *data = dev->port.private_data;
+	int ch, ufstat, num_read = 0;
+
+	while (num_read < n) {
+		ufstat = rd_regl(&dev->port, S3C2410_UFSTAT);
+		if (!(ufstat & data->rxfifo_mask))
+			break;
+		ch = rd_reg(&dev->port, S3C2410_URXH);
+		if (ch == NO_POLL_CHAR)
+			break;
+
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+
 static int __init samsung_early_console_setup(struct earlycon_device *device,
 					      const char *opt)
 {
@@ -2990,12 +3011,14 @@ static int __init samsung_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = samsung_early_write;
+	device->con->read = samsung_early_read;
 	return 0;
 }
 
 /* S3C2410 */
 static struct samsung_early_console_data s3c2410_early_console_data = {
 	.txfull_mask = S3C2410_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2410_UFSTAT_RXFULL | S3C2410_UFSTAT_RXMASK,
 };
 
 static int __init s3c2410_early_console_setup(struct earlycon_device *device,
@@ -3011,6 +3034,7 @@ OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 /* S3C2412, S3C2440, S3C64xx */
 static struct samsung_early_console_data s3c2440_early_console_data = {
 	.txfull_mask = S3C2440_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2440_UFSTAT_RXFULL | S3C2440_UFSTAT_RXMASK,
 };
 
 static int __init s3c2440_early_console_setup(struct earlycon_device *device,
@@ -3030,6 +3054,7 @@ OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 /* S5PV210, Exynos */
 static struct samsung_early_console_data s5pv210_early_console_data = {
 	.txfull_mask = S5PV210_UFSTAT_TXFULL,
+	.rxfifo_mask = S5PV210_UFSTAT_RXFULL | S5PV210_UFSTAT_RXMASK,
 };
 
 static int __init s5pv210_early_console_setup(struct earlycon_device *device,
-- 
2.35.1.574.g5d30c73bfb-goog

