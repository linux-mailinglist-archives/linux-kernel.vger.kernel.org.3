Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAC4C28AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiBXJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiBXJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0D285AA3;
        Thu, 24 Feb 2022 01:56:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6325C212B8;
        Thu, 24 Feb 2022 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mi7kRn8+80MSMtlJoq/glAA6uvH6O77jShLeUaAMftM=;
        b=Ld+6MGs1+cYUZ06k75aF5WtEQey1+qh3gW31FPPXM7XUJgc9JNtwVjG0XH5xWJV9LU5xLL
        7AbU5tcOwSFSq8PddGs5NlH7S3YPH0gOaP0jKs1uNBY7YaQdY93jfJnCfPBpIhXi2eDzk3
        Sgryb+HSyxyFxE7EJolJLUQpwo5B7Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mi7kRn8+80MSMtlJoq/glAA6uvH6O77jShLeUaAMftM=;
        b=9geI1vQuvIGVF6Vd3C0FZJerDi6chs0XQZMG8JvJpNoRfeDxZSTa/AmydCrrhfNHjquwQY
        qpO6DPXGhsC5m/AQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2CD29A3B83;
        Thu, 24 Feb 2022 09:56:00 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 4/5] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
Date:   Thu, 24 Feb 2022 10:55:57 +0100
Message-Id: <20220224095558.30929-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224095558.30929-1-jslaby@suse.cz>
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a generic UART_LCR_WLEN() macro and the tty_get_char_size()
helper, we can remove all those repeated switch-cases in drivers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sdio_uart.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 04c0823e0359..e6eb5bd6e440 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -250,21 +250,7 @@ static void sdio_uart_change_speed(struct sdio_uart_port *port,
 	unsigned char cval, fcr = 0;
 	unsigned int baud, quot;
 
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-- 
2.35.1

