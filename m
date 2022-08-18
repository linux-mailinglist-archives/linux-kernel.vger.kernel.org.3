Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0DC598F68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiHRVYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHRVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948551A38
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BE9861645
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37532C433C1;
        Thu, 18 Aug 2022 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660857363;
        bh=XG6KXNr/XhLoTua87y5ZRB7Y9Skb9lfcJy6Wz27JkJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMgqRXl6E+e3GoZDHzlCIykBB0pWNZ0NkQAPALjbu4szobunaHdY2/Ne+HId8sZkS
         WSfq9ZL60LZNBHfKMsBPkKn15QScX76p5QBu96TPg21cb8T5/2xhLuvIfjyxE2dYBd
         fWm9OcaHd/6SUKAZBhgjMxlGwcaN+GQxqhOB5LkOqUnRtj6kKhJ7xxGyMgaBwz97Ie
         oBN2cq/lokWG5WopFDRV2WsX/G0F/NNulC8/xqkMO2JV5qffSrCnJxTPPJjKvfRIOS
         xc3Amxc8G+zSjebuylT9sYVymWghJ7QJyprS2Nn9whOdKbYdUgKagcgzdHNi6Hqhv3
         T286k6z26K0dg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/4] ARM: footbridge: remove leftover from personal-server
Date:   Thu, 18 Aug 2022 23:15:48 +0200
Message-Id: <20220818211550.3272321-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818211550.3272321-1-arnd@kernel.org>
References: <20220818211550.3272321-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The machine was removed a while ago, and the checks are
now useless.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-footbridge/isa.c | 11 +++++------
 drivers/tty/serial/21285.c     |  3 ---
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
index 3375ac23c046..84caccddce44 100644
--- a/arch/arm/mach-footbridge/isa.c
+++ b/arch/arm/mach-footbridge/isa.c
@@ -80,12 +80,11 @@ static int __init footbridge_isa_init(void)
 	int err = 0;
 
 	/* Personal server doesn't have RTC */
-	if (!machine_is_personal_server()) {
-		isa_rtc_init();
-		err = platform_device_register(&rtc_device);
-		if (err)
-			printk(KERN_ERR "Unable to register RTC device: %d\n", err);
-	}
+	isa_rtc_init();
+	err = platform_device_register(&rtc_device);
+	if (err)
+		printk(KERN_ERR "Unable to register RTC device: %d\n", err);
+
 	err = platform_device_register(&serial_device);
 	if (err)
 		printk(KERN_ERR "Unable to register serial device: %d\n", err);
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 7520cc02fd4d..65d6af755567 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -461,9 +461,6 @@ static int __init serial21285_console_setup(struct console *co, char *options)
 	int parity = 'n';
 	int flow = 'n';
 
-	if (machine_is_personal_server())
-		baud = 57600;
-
 	/*
 	 * Check whether an invalid uart number has been specified, and
 	 * if so, search for the first available port that does have
-- 
2.29.2

