Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44C646875E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355822AbhLDUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355654AbhLDUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:01:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B9C0613F8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 11:58:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so4776940wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 11:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtgprRzraDdcWxVzWCqJEx+6e+lMCp/8Fk0v9/xYiTg=;
        b=LC73kSjhtPfz1OAuQXDdwMpUY1J/PGiz6g7v9Yn8K5ebl8fgyQI5Xw+ulIAJj8h+sY
         KuUIX9tYC9xQOjhmrUhwBUJJv2sPU2dowEKjeE0aqDLAygjCkJHf6CbnUabPkEem3iTm
         3Xy/KfoJYSVoLZqVXWZdSbhl1zXwuFFy+gaKEcPhqKoQbrn+2B+35ePDvAqvjeXRnk3y
         VjHpa3Y/UQPEpzaubQVfSFMcpPgkYkV8ImqjB7WN59Or2PKzXFob1l8ooHecMtGeg11C
         7fHGR2JL093dUwpOv5X919XLZbsitbQtkV1wU8ZKxCd0AJ5Vb4OO361uoKa/ISmfnHDU
         EyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtgprRzraDdcWxVzWCqJEx+6e+lMCp/8Fk0v9/xYiTg=;
        b=HDVvf7EY1IA4Y+vLVWfO9YSNh40qEyCqlzxJxAj4ZdwAf/sKBXCQIYQ7fhj7lDRNiH
         OtUOh+sBEkKQZBoTIOPBICHH3zKEgOLBYyFYSsamfS5FtHRKF1iC2UabEKt/655p9AWs
         gccPju4baTN+M5gT+2WFVsWGr1uIJh81Ck3Abh6yILYBMoJQdslOwZiq+ZVFIiV7Mxf6
         v8t7otkVf9t0IDFeFsBvn9S/ISsmrHtq5BjFeiaySoPEjV5k2VGC+Gd1/4V0lXzUtcii
         oxI1OS9ffHmNDte6dJKbP0HBV+KNceRf+DJRirqMNISl80tlLZFNBsFWOc2xP6FU5Cjc
         7YMg==
X-Gm-Message-State: AOAM530BqZuyDot8UlfAPMF/EZSuXOxGdvMkV/IzrgxfNG8O7YAKc/pf
        9CB49g4RFqBa4JldCQrHzayLqQ==
X-Google-Smtp-Source: ABdhPJzEdB3USItEVjCahP2N6o5ouxcRcAxJwvA99/oPl67wQu6iR7rjcLKXwLDrLg1BLX7vAWevXQ==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr25474214wmj.67.1638647886901;
        Sat, 04 Dec 2021 11:58:06 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b197sm6281503wmb.24.2021.12.04.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 11:58:06 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 5/5] tty: serial: samsung: Fix console registration from module
Date:   Sat,  4 Dec 2021 21:57:57 +0200
Message-Id: <20211204195757.8600-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204195757.8600-1-semen.protsenko@linaro.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On modern Exynos SoCs (like Exynos850) the UART can be implemented as a
part of USI IP-core. In such case, USI driver is used to initialize USI
registers, and it also calls of_platform_populate() to instantiate all
sub-nodes (e.g. serial node) of USI node. When serial driver is
built-in, but USI driver is a module, and CONFIG_SERIAL_SAMSUNG_CONSOLE
is enabled, next call chain will happen when loading USI module from
user space:

    usi_init
      v
    usi_probe
      v
    of_platform_populate
      v
    s3c24xx_serial_probe
      v
    uart_add_one_port
      v
    uart_configure_port
      v
    register_console
      v
    try_enable_new_console
      v
    s3c24xx_serial_console_setup

But because the serial driver is built-in, and
s3c24xx_serial_console_setup() is marked with __init keyword, that
symbol will discarded and long gone by that time already, causing failed
paging request.

That happens during the next config combination:

    EXYNOS_USI=m
    SERIAL_SAMSUNG=y
    SERIAL_SAMSUNG_CONSOLE=y

That config should be completely possible, so rather than limiting
SERIAL_SAMSUNG choice to "m" only when USI=m, remove __init keyword for
all affected functions.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - This patch is added in v2

 drivers/tty/serial/samsung_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 61ccb359620a..d002a4e48ed9 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2500,7 +2500,8 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
 	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
 }
 
-static void __init
+/* Shouldn't be __init, as it can be instantiated from other module */
+static void
 s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			   int *parity, int *bits)
 {
@@ -2563,7 +2564,8 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 	}
 }
 
-static int __init
+/* Shouldn't be __init, as it can be instantiated from other module */
+static int
 s3c24xx_serial_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
-- 
2.30.2

