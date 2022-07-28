Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF6583876
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiG1GLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiG1GLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:11:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4980632063;
        Wed, 27 Jul 2022 23:11:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 822BE5C139;
        Thu, 28 Jul 2022 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjCOQgH4RpUDh/wYtzUE+ZmKCQK5DBNZmsdvQ8H4t+0=;
        b=NzMpDmd3B2SJHlhk51+rXf87IQNbDOEXVAbh4N4LULGPmVWgAGw67DGI7Z/IdX1O8/rRu0
        zL6kIzQ+i/55ik/CZkaviqEKhm3kBMu8+sseTKO6qrUhm/akLwclvKo1xtn2Egt4k4p0kI
        U2g1Te86n/49KM+D3w3fC6TJ6wan7jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjCOQgH4RpUDh/wYtzUE+ZmKCQK5DBNZmsdvQ8H4t+0=;
        b=XEpB2ENVrLxuZ7zqPI+L+R3dTewb49xKyFZanlAEHRbvDsS/NwAx/bw7lMjb2njXIW2rdN
        +j6quu5K4gjwTZCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 433E22C141;
        Thu, 28 Jul 2022 06:10:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/6] Documentation: serial: move GPIO kernel-doc to the functions
Date:   Thu, 28 Jul 2022 08:10:53 +0200
Message-Id: <20220728061056.20799-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728061056.20799-1-jslaby@suse.cz>
References: <20220728061056.20799-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO uart functions are documented in Documentation. Move and
transform this documentation into kernel-doc directly in the code and
reference it in Documentation using kernel-doc:.

This makes it easier to update, maintain and check by the build.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst | 32 ++-------------
 drivers/tty/serial/serial_mctrl_gpio.c     | 48 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index ac9620e97f4b..cae280f39189 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -94,31 +94,7 @@ Modem control lines via GPIO
 
 Some helpers are provided in order to set/get modem control lines via GPIO.
 
-mctrl_gpio_init(port, idx):
-	This will get the {cts,rts,...}-gpios from device tree if they are
-	present and request them, set direction etc, and return an
-	allocated structure. `devm_*` functions are used, so there's no need
-	to call mctrl_gpio_free().
-	As this sets up the irq handling make sure to not handle changes to the
-	gpio input lines in your driver, too.
-
-mctrl_gpio_free(dev, gpios):
-	This will free the requested gpios in mctrl_gpio_init().
-	As `devm_*` functions are used, there's generally no need to call
-	this function.
-
-mctrl_gpio_to_gpiod(gpios, gidx)
-	This returns the gpio_desc structure associated to the modem line
-	index.
-
-mctrl_gpio_set(gpios, mctrl):
-	This will sets the gpios according to the mctrl state.
-
-mctrl_gpio_get(gpios, mctrl):
-	This will update mctrl with the gpios values.
-
-mctrl_gpio_enable_ms(gpios):
-	Enables irqs and handling of changes to the ms lines.
-
-mctrl_gpio_disable_ms(gpios):
-	Disables irqs and handling of changes to the ms lines.
+.. kernel-doc:: drivers/tty/serial/serial_mctrl_gpio.c
+   :identifiers: mctrl_gpio_init mctrl_gpio_free mctrl_gpio_to_gpiod
+           mctrl_gpio_set mctrl_gpio_get mctrl_gpio_enable_ms
+           mctrl_gpio_disable_ms
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 1663b3afc3a0..7d5aaa8d422b 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -42,6 +42,13 @@ static bool mctrl_gpio_flags_is_dir_out(unsigned int idx)
 	return mctrl_gpios_desc[idx].flags & GPIOD_FLAGS_BIT_DIR_OUT;
 }
 
+/**
+ * mctrl_gpio_set - set gpios according to mctrl state
+ * @gpios: gpios to set
+ * @mctrl: state to set
+ *
+ * Set the gpios according to the mctrl state.
+ */
 void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 {
 	enum mctrl_gpio_idx i;
@@ -63,6 +70,12 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
+/**
+ * mctrl_gpio_to_gpiod - obtain gpio_desc of modem line index
+ * @gpios: gpios to look into
+ * @gidx: index of the modem line
+ * Returns: the gpio_desc structure associated to the modem line index
+ */
 struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 				      enum mctrl_gpio_idx gidx)
 {
@@ -73,6 +86,14 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
 
+/**
+ * mctrl_gpio_get - update mctrl with the gpios values.
+ * @gpios: gpios to get the info from
+ * @mctrl: mctrl to set
+ * Returns: modified mctrl (the same value as in @mctrl)
+ *
+ * Update mctrl with the gpios values.
+ */
 unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
 {
 	enum mctrl_gpio_idx i;
@@ -189,6 +210,17 @@ static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+/**
+ * mctrl_gpio_init - initialize uart gpios
+ * @port: port to initialize gpios for
+ * @idx: index of the gpio in the @port's device
+ *
+ * This will get the {cts,rts,...}-gpios from device tree if they are present
+ * and request them, set direction etc, and return an allocated structure.
+ * `devm_*` functions are used, so there's no need to call mctrl_gpio_free().
+ * As this sets up the irq handling, make sure to not handle changes to the
+ * gpio input lines in your driver, too.
+ */
 struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 {
 	struct mctrl_gpios *gpios;
@@ -235,6 +267,14 @@ struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_init);
 
+/**
+ * mctrl_gpio_free - explicitly free uart gpios
+ * @dev: uart port's device
+ * @gpios: gpios structure to be freed
+ *
+ * This will free the requested gpios in mctrl_gpio_init(). As `devm_*`
+ * functions are used, there's generally no need to call this function.
+ */
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 {
 	enum mctrl_gpio_idx i;
@@ -253,6 +293,10 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_free);
 
+/**
+ * mctrl_gpio_enable_ms - enable irqs and handling of changes to the ms lines
+ * @gpios: gpios to enable
+ */
 void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 {
 	enum mctrl_gpio_idx i;
@@ -278,6 +322,10 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
 
+/**
+ * mctrl_gpio_disable_ms - disable irqs and handling of changes to the ms lines
+ * @gpios: gpios to disable
+ */
 void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 {
 	enum mctrl_gpio_idx i;
-- 
2.37.1

