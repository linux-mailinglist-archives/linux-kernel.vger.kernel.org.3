Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8723849B5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577894AbiAYOGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447682AbiAYOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:04:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C82C061759
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:04:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r82-20020a1c4455000000b0034e043aaac7so1268837wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+7m9c6+tICmx+J1ftWROCi4bc6ojQg4S57ifagA0uM=;
        b=mFQdAfdev5U2TqyxB3I54X63jvt+DC7/4Zd/FbzlYq4fjrBQpug+WeE706yaaGyu9S
         ImnNfYcSh/pyH3xi4Tg/Mnl1z4j78E2Cmn2MTD9RsRL2GKvves8at9bLZaxp8q+FsGaa
         b0K6BZJvEb1I27gtlobflVIFpTV9SfDUgha9C3u2RMcjZQFDWeuoXI74rGucII6lgDb8
         8rEjlgiwlMSLOY9qUkB23pnd1XTWDpBf4Fe9jZLXWf9Z0AxsqZs72APGrLEnnUly+qFz
         YK0wlRLS7KKZBH33QTzkEQ6ttVCskX71ubONlllTq8z/iTJyaELOumQNsQBupdXX7z4w
         NiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+7m9c6+tICmx+J1ftWROCi4bc6ojQg4S57ifagA0uM=;
        b=6k0IRJuOfMNimBDocWhO3ossXVn3H+TYJ5vGBgRMEwgBdGPp/D6nLcd2TAdooNQ65w
         HxUOOX/YhvL/vi7Wlo8kmlgXyjsq8gb5CleUMemjeuQ+L5yXlOO+25VgRKHfzQ5Ui70C
         OmCVAsJ0DjlymFoBROe21kX0lmRZbkWNksqSYiuaXPb72R7HAWy2kis66eywxGaO1ePk
         I8Fw5eIrBR1qt4GwysExTkjJZHrhLvaNayMN9RfBAOvjAIn8+BLrBEU4/rbZj6UI0kHU
         THv6y3WV8qQMNicfjEtnVKdFKIfSbOl2lE8o4yIxfWP/csYe/BA66xSR7oYc9gP9rsaF
         ZimA==
X-Gm-Message-State: AOAM530RbLFvyvY8bi753p1dPPEerlEgkRLAHDjzDHq5CSRwbdHZ//Pq
        fJst2jNxu1gWbIKjcVG9cfXlMA==
X-Google-Smtp-Source: ABdhPJx2wn9CJfIg0IjmZPyyjXixkaffitwYuLYggFLg9dtYWzrpNO9tIfTkq/Uhj23KmYTSmTBWLw==
X-Received: by 2002:a05:600c:20b:: with SMTP id 11mr3019668wmi.146.1643119438576;
        Tue, 25 Jan 2022 06:03:58 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l20sm711430wms.24.2022.01.25.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:03:57 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, clemens@ladisch.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] hpet: remove unused writeq/readq function definitions
Date:   Tue, 25 Jan 2022 14:03:52 +0000
Message-Id: <20220125140352.4085290-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On all arch using hpet, only i386 miss writeq/readq.
Instead of rewriting them, use linux/io-64-nonatomic-lo-hi.h which
already have them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/char/hpet.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 563dfae3b8da..55bd63c97d00 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/poll.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
@@ -120,22 +121,6 @@ static struct hpets *hpets;
 #define	HPET_PERIODIC		0x0004
 #define	HPET_SHARED_IRQ		0x0008
 
-
-#ifndef readq
-static inline unsigned long long readq(void __iomem *addr)
-{
-	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
-}
-#endif
-
-#ifndef writeq
-static inline void writeq(unsigned long long v, void __iomem *addr)
-{
-	writel(v & 0xffffffff, addr);
-	writel(v >> 32, addr + 4);
-}
-#endif
-
 static irqreturn_t hpet_interrupt(int irq, void *data)
 {
 	struct hpet_dev *devp;
-- 
2.34.1

