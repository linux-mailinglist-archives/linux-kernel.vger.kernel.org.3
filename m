Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB013588717
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiHCGA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:00:55 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF331707A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:00:53 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id J7R0oDBQPnnjOJ7R0oabzZ; Wed, 03 Aug 2022 08:00:52 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Aug 2022 08:00:52 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Felipe Balbi <balbi@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: pxa: Fix a memory leak in pxa310_otg_exit()
Date:   Wed,  3 Aug 2022 08:00:44 +0200
Message-Id: <890e3e7329b020356206262e9c3ee57378648e1c.1659506415.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When otg_ulpi_create() is called, 2 kzalloc() are performed.
Only one is freed in pxa310_otg_exit().

The second kzalloc() has been introduced in the commit in the Fixes: tag.

Add the missing kfree().

Fixes: 298b083cf9dd ("usb: otg: ulpi: Start using struct usb_otg")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is NOT compile tested (I never cross compile even if I've been
tolled many times that it was easy...)

Another solution is to use devm_otg_ulpi_create() and further simplify
arch/arm/mach-pxa/pxa3xx-ulpi.c.

This would remove the only caller of otg_ulpi_create() and could also
simplify drivers/usb/phy/phy-ulpi.[ch]
---
 arch/arm/mach-pxa/pxa3xx-ulpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index c29a7f0fa1b0..82b4e2706f86 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -229,6 +229,7 @@ static int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
 
 static void pxa310_otg_exit(void)
 {
+	kfree(u2d->otg->otg);
 	kfree(u2d->otg);
 }
 #else
-- 
2.34.1

