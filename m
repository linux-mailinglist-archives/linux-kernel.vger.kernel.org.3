Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC70353EBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiFFO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbiFFO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:58:18 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9B0140A6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:58:17 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D8D91FF808;
        Mon,  6 Jun 2022 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654527496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMDzIUH01c9Xmou891SUin6Y2SHspdo6jDEEnRQIDZg=;
        b=BhZLT0bNjLOlGCma7K7u9yCrwmEdw+TSDMwUUXqotxtjL2P+p1/MVVB9D1jDWuLOn2iyT0
        gP1xiXcT/gw6lYTUDScsWG2WkRk8nkFmQfqiWBQnLuPTV/s+8Xdvv59A9CqFXT3TO5Z59o
        qk7SEqx+On9gOSAzKwIFmYy27GLwxLPfaGRu/OOM1UsTdnXjjmarbbRMfgpxPao6F5/rvS
        3AcH2+ZpEH/k/m1G+o+rUe2I7MMlFspjTTAtzFw99PbZUQmTRSTsNW/liLVDMIbe4eLsNA
        SvqRX1NE3ZExU2v6lRR3vKZxyuSVOrHGdwAfqO9taenTtS9xCs4N0jEDoFxLGw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] ARM: at91: setup outer cache .write_sec() callback if needed
Date:   Mon,  6 Jun 2022 16:57:01 +0200
Message-Id: <20220606145701.185552-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606145701.185552-1-clement.leger@bootlin.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running under OP-TEE, the L2 cache is configured by OP-TEE and the
sam platform code does not allow any modification yet. Setup a dummy
.write_sec() callback to avoid triggering exceptions when Linux tries
to modify the L2 cache configuration.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/sama5.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index de5dd28b392e..d1a9e940a785 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -9,13 +9,27 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/outercache.h>
 #include <asm/system_misc.h>
 
 #include "generic.h"
 #include "sam_secure.h"
 
+static void sama5_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+	/* OP-TEE configures the L2 cache and does not allow modifying it yet */
+}
+
+static void __init sama5_secure_cache_init(void)
+{
+	sam_secure_init();
+	if (sam_linux_is_in_normal_world())
+		outer_cache.write_sec = sama5_l2c310_write_sec;
+}
+
 static void __init sama5_dt_device_init(void)
 {
 	of_platform_default_populate(NULL, NULL, NULL);
@@ -30,6 +44,7 @@ static const char *const sama5_dt_board_compat[] __initconst = {
 DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 	/* Maintainer: Atmel */
 	.init_machine	= sama5_dt_device_init,
+	.init_early	= sama5_secure_cache_init,
 	.dt_compat	= sama5_dt_board_compat,
 MACHINE_END
 
@@ -41,6 +56,7 @@ static const char *const sama5_alt_dt_board_compat[] __initconst = {
 DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	/* Maintainer: Atmel */
 	.init_machine	= sama5_dt_device_init,
+	.init_early	= sama5_secure_cache_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
@@ -60,6 +76,7 @@ static const char *const sama5d2_compat[] __initconst = {
 DT_MACHINE_START(sama5d2, "Atmel SAMA5")
 	/* Maintainer: Atmel */
 	.init_machine	= sama5d2_init,
+	.init_early	= sama5_secure_cache_init,
 	.dt_compat	= sama5d2_compat,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
-- 
2.36.1

