Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120054E2E18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351209AbiCUQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351187AbiCUQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619BAFCBC8;
        Mon, 21 Mar 2022 09:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 022D0B81891;
        Mon, 21 Mar 2022 16:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B930C340F2;
        Mon, 21 Mar 2022 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647880269;
        bh=wG7sX/hncO57KXrCuRz1PGNOImxeZapEiK9Kq930zNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2a2zvqi5KkgK3ug6zMo8M2KiEfY5iBXVJmdAz8Pcp93J2Oy/A8Ejt/6R4KzhMcB6
         vwjt7X995yqZBAjMQIGW8rTaFdUbNUL7oynCUFXlh6ibNytu/A92a3LWSjsOUQGAAf
         82lVEbPF7kO+YtjsKq1nTKfYVPh/6b1yg9Skon4ARLESadww1SzWBCF7/Zz/QGs1AS
         mi/Y2bUniHpiNBf8s2zDBhhn+0l7lbgZJWdHo0FxS7DLwk0on96mdRuPFYI1FjWBN9
         TtL354F3lUX3MWCsamOCVjODvT13yhoRcCsivK9Qo1+u8VofhdczroAkH5238/yB4C
         IGqQ1D2lk073Q==
Received: by pali.im (Postfix)
        id D0A93EEB; Mon, 21 Mar 2022 17:31:06 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] serial: core: Fix function uart_update_timeout() to handle UPF_SPD_CUST flag
Date:   Mon, 21 Mar 2022 17:30:54 +0100
Message-Id: <20220321163055.4058-3-pali@kernel.org>
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

Function uart_update_timeout() currently handles UPF_SPD_HI, UPF_SPD_VHI,
UPF_SPD_SHI and UPF_SPD_WARP flags thanks to how uart_get_baud_rate()
works and how should be used. uart_get_baud_rate() already translates these
4 special flags to real baud rate value and therefore uart_update_timeout()
is called with the correct baud rate argument.

What is not handled in this function is the last remaining flag
UPF_SPD_CUST. It is because uart_get_baud_rate() returns hardcoded value
38400 when UPF_SPD_CUST is set and in use.

Implement support for UPF_SPD_CUST in uart_update_timeout(), so
port->timeout is calculated also when UPF_SPD_CUST flag is set.

For calculation use base uart clock and custom divisor. This calculation
does not have to be precise for all UART hardware but this the best
approximation which can be done. It is for sure better than hardcoded baud
rate value 38400.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/serial_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d8fc2616d62b..34e085a038fe 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -343,6 +343,16 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 {
 	unsigned int size;
 
+	/*
+	 * Old custom speed handling. See function uart_get_divisor()
+	 * and description in uart_get_baud_rate() function.
+	 * This calculation does not have to be precise for all UART
+	 * hardware but it is the best approximation which we can do here
+	 * as we do not know the exact baud rate.
+	 */
+	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
+		baud = DIV_ROUND_CLOSEST(port->uartclk, 16 * port->custom_divisor);
+
 	size = tty_get_frame_size(cflag) * port->fifosize;
 
 	/*
-- 
2.20.1

