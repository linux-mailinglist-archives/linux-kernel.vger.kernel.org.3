Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE94DB364
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbiCPOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbiCPOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 287D153B42
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQKY17K5M4BrRuM2rlw2MvxoRzLJI6+f/LllmsWpF+I=;
        b=ZEEHqOiqj0e5s5Lqwffy04kDtS0d+SZOoHPPeKD5jYQYz2B1KweiEaVSesKqLhMUGMYS56
        QMh3gH8a32cOF8QxuzylVh2vodr+UT+dRh62UYODs2fnQsvpCXYAfDt509I03/6VEtmUik
        T4caCi6ErLa2VkW7MvQOamSZzZLa6MM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-5OMsHSpZOEiI2NivE8y1Rg-1; Wed, 16 Mar 2022 10:37:36 -0400
X-MC-Unique: 5OMsHSpZOEiI2NivE8y1Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 277351066558;
        Wed, 16 Mar 2022 14:37:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6895400F73E;
        Wed, 16 Mar 2022 14:37:31 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: [PATCH v4 2/5] serial/8250: Use the cache value of the FCR register
Date:   Wed, 16 Mar 2022 11:36:41 -0300
Message-Id: <20220316143646.13301-3-wander@redhat.com>
In-Reply-To: <20220316143646.13301-1-wander@redhat.com>
References: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
erroneous tries to read the FCR register content, but this register is
write-only.

This patch fixes that by reading the content from the port struct fcr
field.

Thanks to Jon Hunter and Jiri Slaby.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2abb3de11a48..9f3fa9fe2a4e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3410,7 +3410,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
 		port->fifosize > 1 &&
-		(serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
+		(up->fcr & UART_FCR_ENABLE_FIFO) &&
 		/*
 		 * After we put a data in the fifo, the controller will send
 		 * it regardless of the CTS state. Therefore, only use fifo
-- 
2.35.1

