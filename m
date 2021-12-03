Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344C04678B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbhLCNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLCNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:51:48 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB324C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:48:23 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by michel.telenet-ops.be with bizsmtp
        id RpoN260023eLghq06poN31; Fri, 03 Dec 2021 14:48:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8vF-002LaQ-M5; Fri, 03 Dec 2021 14:48:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt8vF-000lIk-0m; Fri, 03 Dec 2021 14:48:21 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] gpiolib: Let gpiod_add_lookup_table() call gpiod_add_lookup_tables()
Date:   Fri,  3 Dec 2021 14:48:17 +0100
Message-Id: <6be62f21a1e9bf754e37f130d62870698b88a11c.1638539208.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This saves 20 bytes on arm32, and 44 bytes on arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Interestingly, making gpiod_add_lookup_table() a static inline function
in <linux/gpio/machine.h> instead would increase the caller's code size
by 68 bytes on arm32...
---
 drivers/gpio/gpiolib.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abfbf546d1599ebc..85168f88a7fec774 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3487,11 +3487,7 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
  */
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table)
 {
-	mutex_lock(&gpio_lookup_lock);
-
-	list_add_tail(&table->list, &gpio_lookup_list);
-
-	mutex_unlock(&gpio_lookup_lock);
+	gpiod_add_lookup_tables(&table, 1);
 }
 EXPORT_SYMBOL_GPL(gpiod_add_lookup_table);
 
-- 
2.25.1

