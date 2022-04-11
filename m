Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD74FBCBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbiDKNHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiDKNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:07:00 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85712AAC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:04:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b509:6862:2557:437a])
        by andre.telenet-ops.be with bizsmtp
        id HR4j2700F1G7NMJ01R4jp7; Mon, 11 Apr 2022 15:04:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtil-000ATM-9G; Mon, 11 Apr 2022 15:04:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtik-009Jdx-S8; Mon, 11 Apr 2022 15:04:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Randy Dunlap <randy.dunlap@oracle.com>, Mark Laws <mdl@60hz.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] Input: serio - decouple libps2 from i8042
Date:   Mon, 11 Apr 2022 15:04:39 +0200
Message-Id: <fb55a85ccc61c4ca54775565037eb05a252ccef8.1649682025.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 4097461897df9104 ("Input: i8042 - break load dependency
between atkbd/psmouse and i8042"), the libps2 driver no longer uses any
functionality from the i8042 driver.  Hence the meat of commit
fed94549edc90b15 ("Input: libps2 - fix dependancy on i8042") can be
reverted.

Remove the obsolete inclusion of <linux/i8042.h> from the libps2 driver.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Does this actually work?
---
 drivers/input/serio/Kconfig  | 1 -
 drivers/input/serio/libps2.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index f39b7b3f79421538..2d875f4d95f41116 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -177,7 +177,6 @@ config SERIO_SGI_IOC3
 
 config SERIO_LIBPS2
 	tristate "PS/2 driver library"
-	depends on SERIO_I8042 || SERIO_I8042=n
 	help
 	  Say Y here if you are using a driver for device connected
 	  to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 250e213cc80c68be..f5980eb980868dc7 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/serio.h>
-#include <linux/i8042.h>
 #include <linux/libps2.h>
 
 #define DRIVER_DESC	"PS/2 driver library"
-- 
2.25.1

