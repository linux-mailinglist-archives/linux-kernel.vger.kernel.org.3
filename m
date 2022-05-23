Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E953199E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiEWSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiEWSam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:30:42 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 11:05:04 PDT
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C601E64F4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:05:03 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4L6Q4V0G5fz4x0WL
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:56:26 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:4593:272c:6293:e2cc])
        by andre.telenet-ops.be with bizsmtp
        id aHvN2700U2jQL2A01HvNXx; Mon, 23 May 2022 19:55:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntCH4-001MLx-1F; Mon, 23 May 2022 19:55:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ntCH3-003z4C-A1; Mon, 23 May 2022 19:55:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        noreply@ellerman.id.au
Subject: [PATCH next] m68k: virt: Switch to new sys-off handler API
Date:   Mon, 23 May 2022 19:55:20 +0200
Message-Id: <20220523175520.949681-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On m68k with CONFIG_VIRT=y (e.g. virt_defconfig or allmodconfig):

    arch/m68k/virt/config.c: In function ‘config_virt’:
    arch/m68k/virt/config.c:129:2: error: ‘mach_power_off’ undeclared (first use in this function); did you mean ‘pm_power_off’?
      129 |  mach_power_off = virt_halt;
	  |  ^~~~~~~~~~~~~~
	  |  pm_power_off

Commit 05d51e42df06f021 ("m68k: Introduce a virtual m68k machine")
introduced a new user of mach_power_off.
Convert it to the new sys-off handler API, too.

Reported-by: noreply@ellerman.id.au
Fixes: f0f7e5265b3b37b0 ("m68k: Switch to new sys-off handler API")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/virt/config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
index 68d29c8b87e18840..632ba200ad425245 100644
--- a/arch/m68k/virt/config.c
+++ b/arch/m68k/virt/config.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <linux/serial_core.h>
 #include <clocksource/timer-goldfish.h>
 
@@ -126,5 +127,6 @@ void __init config_virt(void)
 	mach_get_model = virt_get_model;
 	mach_reset = virt_reset;
 	mach_halt = virt_halt;
-	mach_power_off = virt_halt;
+
+	register_platform_power_off(virt_halt);
 }
-- 
2.25.1

