Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D04DB36A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356687AbiCPOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350119AbiCPOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10A8D614F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdaRFj6Txp5dVh+5ToS7luAujkKT+3c923Qns25TpZk=;
        b=GjWrayXvHTOPiXT5oLEmbk3pJ47Lk5ACFAY5ZhcYnQHoNt72J60Ehs8xpUSuZBk4MTjMuF
        cUtBagfNoREKE3GtvMz4j3xVAQZSGzUGdvD5CrwsrB8agOn4mScunSqKQ7jKeMnwdEMB3F
        EdAW8LYjO0/6v/6MAky5Qk4IIs3nAxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-PX3TcyXXMn21kXKpX9Klgg-1; Wed, 16 Mar 2022 10:37:52 -0400
X-MC-Unique: PX3TcyXXMn21kXKpX9Klgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 453D91801388;
        Wed, 16 Mar 2022 14:37:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 132C1400F73E;
        Wed, 16 Mar 2022 14:37:47 +0000 (UTC)
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
Subject: [PATCH v4 5/5] serial/8250: Only use fifo after the port is initialized in console_write
Date:   Wed, 16 Mar 2022 11:36:44 -0300
Message-Id: <20220316143646.13301-6-wander@redhat.com>
In-Reply-To: <20220316143646.13301-1-wander@redhat.com>
References: <20220316143646.13301-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial driver set the value of uart_8250_port.fcr in the function
serial8250_config_port, but only writes the value to the controller
register later in the initalization code.

That opens a small window in which is not safe to use the fifo for
console write.

Make sure the port is initialized correctly before reading the FCR
cached value.

Unfortunately, I lost track of who originally reported the issue. If
s/he is reading this, please speak up so I can give you the due credit.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4acf620be241..7e2227161555 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		!(up->capabilities & UART_CAP_MINI) &&
 		up->tx_loadsz > 1 &&
 		(up->fcr & UART_FCR_ENABLE_FIFO) &&
+		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
 		/*
 		 * After we put a data in the fifo, the controller will send
 		 * it regardless of the CTS state. Therefore, only use fifo
-- 
2.35.1

