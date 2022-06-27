Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822B55D0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiF0TBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbiF0TBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:01:09 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377D109E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:01:08 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 3A8F42EFBDC;
        Mon, 27 Jun 2022 21:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656356464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/nk/AcDmx82xo8RzTdRHcXyQgpM8xWRgDJSooyf8KA=;
        b=lXkikKT3QYWdAtg1FNl5bFN3FOKVw1Hl0xcjP5ham0WTgbyh0v/mVK/3kyFGr8ZqCGm6dd
        ojkwMcq9sdaGQzK4Qfm7oYy0x8UxJrq2JfNqX7MpDYK2MKlPYMgdQeSlDNJk96Z1q/x/He
        /UpR3cfOcx/+ajoo5s4dl9Uc8s7jxKd4Vjw0Pk2SifAW0BrgKoRfsdxdsC5ZseOd2rNI3Z
        dLWuwzuifIBCEROuJCDVaECEEYDHMSWNNeL6T5L2e05hd5E/LKgenqwTrV5ZPe7oVqP6OU
        vKXVXmByFnyL7tj+as8NEux7BjKf612cX5RCsBYq2+zAGZ2jSh4QduW6TC4Asw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 2/2] watchdog: realtek-otto: add RTL9310 support
Date:   Mon, 27 Jun 2022 21:00:56 +0200
Message-Id: <629e95e16c8dc812dc5a4ea34a2e2e1ff2faf88c.1656356377.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
References: <84d873d7dd375cd2392f89fa6bd9e0fe5dda4e1c.1656356377.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTL9310 SoC series has a watchdog timer identical to the already
supported SoCs. The peripheral is memory mapped at 0x18003260 and driven
by the Lexra bus clock.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/watchdog/realtek_otto_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 60058a0c3ec4..2a5298c5e8e4 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -366,6 +366,7 @@ static const struct of_device_id otto_wdt_ids[] = {
 	{ .compatible = "realtek,rtl8380-wdt" },
 	{ .compatible = "realtek,rtl8390-wdt" },
 	{ .compatible = "realtek,rtl9300-wdt" },
+	{ .compatible = "realtek,rtl9310-wdt" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, otto_wdt_ids);
-- 
2.36.1

