Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83FF4DB369
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356518AbiCPOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352078AbiCPOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 340CC1153
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647441470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZaBOHHPLNjvfmElpKvHnRzsqHkOS0kCz5AlxDf27Y0=;
        b=AgUy5px7iuBosQ6mnMzRa3xE2wp/T9V/VtFqnpa/6fDXykEHjJ5gUFIWutmJap3ILSFgeF
        l680IHaiQBvma1X2c6Si0IODk0R1iUHwdYMEjBSjkqHVD8LUq2C0a+PuqZBHFAQ0teN5xQ
        Sf4NiIAPZySkj1e46wNNr1JQm1pS2wo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-6djy7wGgOFS_AAbKSifDNg-1; Wed, 16 Mar 2022 10:37:46 -0400
X-MC-Unique: 6djy7wGgOFS_AAbKSifDNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3A2529DD9A7;
        Wed, 16 Mar 2022 14:37:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1BB6400F73E;
        Wed, 16 Mar 2022 14:37:42 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Johan Hovold <johan@kernel.org>,
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
Subject: [PATCH v4 4/5] serial/8250: exclude BCM283x from console_fifo_write
Date:   Wed, 16 Mar 2022 11:36:43 -0300
Message-Id: <20220316143646.13301-5-wander@redhat.com>
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

From Phil's original patch:

"""
The mini-UART on BCM283x is doubly crippled - it has 8-byte FIFOs and
the THRE bit indicates that the TX FIFO is not-full rather than empty.

The optimisation to enable the use of the FIFO assumes that it is safe
to write fifosize bytes whenever THRE is set, but the BCM283x quirk
(indicated by the presence of UART_CAP_MINI) makes it necessary to
check the FIFO state after each byte.

See: https://github.com/raspberrypi/linux/issues/4849
"""

Thanks to Phil Elwell for reporting the issue and providing the original
patch.

Reported-by: Phil Elwell <phil@raspberrypi.com>
Co-author: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d3a93e5d55f7..4acf620be241 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3409,6 +3409,11 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	}
 
 	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
+		/*
+		 * BCM283x requires to check the fifo
+		 * after each byte.
+		 */
+		!(up->capabilities & UART_CAP_MINI) &&
 		up->tx_loadsz > 1 &&
 		(up->fcr & UART_FCR_ENABLE_FIFO) &&
 		/*
-- 
2.35.1

