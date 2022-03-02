Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20144CA207
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiCBKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbiCBKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:20:41 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4191AE0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:19:58 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j5-20020a63e745000000b00378c359fac3so877039pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Yq89WbWr/nKtI2RVDgbrgWiRqIUUvQxU4ZRP/u39Tc4=;
        b=lm4zJUzyhqzs2nvdFpXSR0vlIVib2Ri38tWVjvsqeYEdwiEB/dxkr1OjSZBdKRIhWP
         mOqCavmFBymWwOrD0rp4KYZUr0Ol+p86D4yAkeZDMOBUmioLtRyAM0Y1Re2kFojye2S9
         /6G7U6K078XM38L9pSWDyY9HW4BfENWa5utIpmtqViWK+Ug7VhxoX0G30P6Y/VM7NA3s
         8b6NdWbCkU5JymN+ENB5BeIRq7YDKcgcMbdIW4IuZbqJ1MlPQtNZSq9tFLPP/uvLtCWz
         rPBhwC6kcAIriegH5SODZ3BROXUxIylYmljIiX+77sNZvgtnxxVDyiMyoxqUfQzcmhKN
         yNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Yq89WbWr/nKtI2RVDgbrgWiRqIUUvQxU4ZRP/u39Tc4=;
        b=qFgvX4hyKxJa5/xbYb0lsCSpvqXwDQgDwKHKMrCh12h3G/s7euoalNArgGgCzOftd8
         uhF9qx2maMN7aF29LQX3A0dfQkxsw81ZUmkr+fS2jEMlo2vHg2Y8oB9yKfyhCmvWNb2F
         o65FzqEWzAyGMn1Rbkie01x/P3GebktnEUV2YjJF4tJaMFmxfTzlVBz3grcQ7NuIwQYw
         wNLtTQsuv1v1qkyeKky7jNSYo4/TR1SgHaMq2NDUosbCT31k/fsm0j8t4LJUoXTrkLBG
         YajPhcubg0FIEXfi5YuA86SjvMetQIfDAXAw1Fi2Qg8j5P0B3Awfz9iGael1sV9Id42N
         YLkA==
X-Gm-Message-State: AOAM530xUxkVcOXfk3qDxyaokhSbmNwDtvAbxYv27g1uJltnDSTRKxcM
        E7BgZc4VRG/7mdOU5H4Lhf0dbWf1PpvpvA==
X-Google-Smtp-Source: ABdhPJzEXQNhD0xqT2s2x//pYYtesl+TerhASD0Ziddn/5GiSvMBYaO6FAMA2Ou6p+she/JPNCFbtFSgjrrJtQ==
X-Received: from woodylin.ntc.corp.google.com ([2401:fa00:fc:202:3ddc:5127:fcb7:1fad])
 (user=woodylin job=sendgmr) by 2002:a17:903:2285:b0:151:4b38:298e with SMTP
 id b5-20020a170903228500b001514b38298emr20044336plh.36.1646216397851; Wed, 02
 Mar 2022 02:19:57 -0800 (PST)
Date:   Wed,  2 Mar 2022 18:19:25 +0800
Message-Id: <20220302101925.210810-1-woodylin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] serial: samsung: Add samsung_early_read to support early kgdboc
From:   Woody Lin <woodylin@google.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, woodylin@google.com,
        markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'kgdboc_earlycon_init' looks for boot console that has both .read
and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
console to support kgdboc.

Signed-off-by: Woody Lin <woodylin@google.com>
---
 drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d002a4e48ed9..eeb30d016ff1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
 
 struct samsung_early_console_data {
 	u32 txfull_mask;
+	u32 rxfifo_mask;
 };
 
 static void samsung_early_busyuart(struct uart_port *port)
@@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, samsung_early_putc);
 }
 
+static int samsung_early_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	struct samsung_early_console_data *data = dev->port.private_data;
+	int ch, ufstat, num_read = 0;
+
+	while (num_read < n) {
+		ufstat = rd_regl(&dev->port, S3C2410_UFSTAT);
+		if (!(ufstat & data->rxfifo_mask))
+			break;
+		ch = rd_reg(&dev->port, S3C2410_URXH);
+		if (ch == NO_POLL_CHAR)
+			break;
+
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+
 static int __init samsung_early_console_setup(struct earlycon_device *device,
 					      const char *opt)
 {
@@ -2990,12 +3011,14 @@ static int __init samsung_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = samsung_early_write;
+	device->con->read = samsung_early_read;
 	return 0;
 }
 
 /* S3C2410 */
 static struct samsung_early_console_data s3c2410_early_console_data = {
 	.txfull_mask = S3C2410_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2410_UFSTAT_RXFULL | S3C2410_UFSTAT_RXMASK,
 };
 
 static int __init s3c2410_early_console_setup(struct earlycon_device *device,
@@ -3011,6 +3034,7 @@ OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 /* S3C2412, S3C2440, S3C64xx */
 static struct samsung_early_console_data s3c2440_early_console_data = {
 	.txfull_mask = S3C2440_UFSTAT_TXFULL,
+	.rxfifo_mask = S3C2440_UFSTAT_RXFULL | S3C2440_UFSTAT_RXMASK,
 };
 
 static int __init s3c2440_early_console_setup(struct earlycon_device *device,
@@ -3030,6 +3054,7 @@ OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 /* S5PV210, Exynos */
 static struct samsung_early_console_data s5pv210_early_console_data = {
 	.txfull_mask = S5PV210_UFSTAT_TXFULL,
+	.rxfifo_mask = S5PV210_UFSTAT_RXFULL | S5PV210_UFSTAT_RXMASK,
 };
 
 static int __init s5pv210_early_console_setup(struct earlycon_device *device,
-- 
2.35.1.574.g5d30c73bfb-goog

