Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FA4E2E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiCUQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347366AbiCUQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECC4F7F5C;
        Mon, 21 Mar 2022 09:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6BC6135B;
        Mon, 21 Mar 2022 16:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3218DC340F0;
        Mon, 21 Mar 2022 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647880269;
        bh=G0Iu+15P7J/9+ldVRS0Kh3E5nSoQYqiC6yNgO0mYsEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTgGMiUOnY9NUs9Paagrn3RqiWs3DMFROmXDzrmjp2mFPLDMuvl3ii3I9iu1SerXt
         +07UC/3W+PlrohAX6bdBg7l2105J3TrzDhL4mQ2Exar1y1loJhL3ewsTNRKPyaqCzw
         5Lve8Zl9+L0MwDENJOFUB4jwOvhQFqv9tog8YZizwfB678fPIdj+Fjlui7SJ+5huqc
         M7Ne8y+jhNudkxj81RdQIA13wJPUs4vRNPma2aw6VO9apynGJgtiS7e0csbEP0rMyp
         QpjFShIauPSoKuKGwz2Dau6V7egM2fH8oZaAIu6M+02biOcDcV/OdwscuTLravWi7M
         J1JsrsVCYvjaA==
Received: by pali.im (Postfix)
        id 5D6F6C77; Mon, 21 Mar 2022 17:31:06 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] serial: core: Document why UPF_SPD_CUST is not handled in uart_get_baud_rate()
Date:   Mon, 21 Mar 2022 17:30:53 +0100
Message-Id: <20220321163055.4058-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220321163055.4058-1-pali@kernel.org>
References: <20220321163055.4058-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch in uart_get_baud_rate() function is missing case for UPF_SPD_CUST
flag. It is not obvious why it is missing here, so add comments explaining
how deprecated UPF_SPD_CUST flag is handled and how drivers should call
uart_get_baud_rate() and uart_get_divisor() functions.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/serial_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1e738f265eea..d8fc2616d62b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -364,7 +364,17 @@ EXPORT_SYMBOL(uart_update_timeout);
  *
  *	Decode the termios structure into a numeric baud rate,
  *	taking account of the magic 38400 baud rate (with spd_*
- *	flags), and mapping the %B0 rate to 9600 baud.
+ *	flags, except cust), and mapping the %B0 rate to 9600 baud.
+ *
+ *	UPF_SPD_CUST flag is not handled in this function as it applies
+ *	to the custom divisor. When UPF_SPD_CUST flag is active and in
+ *	use then this function returns value 38400 and not the correct
+ *	baud rate.
+ *
+ *	Drivers should call uart_get_divisor() function with baud rate
+ *	returned from this function to calculate clock divisor. Function
+ *	uart_get_divisor() then handles UPF_SPD_CUST flag with magic
+ *	baud rate value 38400 and returns the correct custom divisor.
  *
  *	If the new baud rate is invalid, try the old termios setting.
  *	If it's still invalid, we try 9600 baud.
@@ -396,6 +406,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 	case UPF_SPD_WARP:
 		altbaud = 460800;
 		break;
+	/* Flag UPF_SPD_CUST is not handed here, see description why. */
 	default:
 		altbaud = 38400;
 		break;
@@ -462,6 +473,8 @@ EXPORT_SYMBOL(uart_get_baud_rate);
  *	@baud: desired baud rate
  *
  *	Calculate the uart clock divisor for the port.
+ *
+ *	Handles also special case when UPF_SPD_CUST flag is in use.
  */
 unsigned int
 uart_get_divisor(struct uart_port *port, unsigned int baud)
-- 
2.20.1

