Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2364C28B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiBXJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiBXJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFA285AA4;
        Thu, 24 Feb 2022 01:56:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9B6EA1F44C;
        Thu, 24 Feb 2022 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yL3OrD93751tjdTWgqtYW3vZmFiVRVbclLaKF5e268=;
        b=dZPjGftc8DmBWAbVxU6MpC9JWpuJADlKpUXhT3+VziYC1Sr/U5W+kBX0Oibr+0qrRIXnoC
        70kmWIy7XgaYCZ3LMdLxd68VF5Owk+Z6xwYN5R3bBB0u4jr2pVhvc3CoTxdMMCsyy4Fn0H
        kwI+xy/RCq2z87BKgPEFyHUIoEkiXKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yL3OrD93751tjdTWgqtYW3vZmFiVRVbclLaKF5e268=;
        b=5eHk5bbCB/yNM/pwLcOCwRP1XGxtQaWU8YoAcTrSqhs8UnLlyxCMj/37N+Fs0vWtEVB+NO
        HpypL1XQYT0tgZDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 729AFA3B97;
        Thu, 24 Feb 2022 09:56:00 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/5] mxser: make use of UART_LCR_WLEN() + tty_get_char_size()
Date:   Thu, 24 Feb 2022 10:55:58 +0100
Message-Id: <20220224095558.30929-5-jslaby@suse.cz>
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
---
 drivers/tty/mxser.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 836c9eca2946..6ebd3e4ed859 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -588,21 +588,7 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	}
 
 	/* byte size and parity */
-	switch (cflag & CSIZE) {
-	default:
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(tty->termios.c_cflag));
 
 	if (cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-- 
2.35.1

