Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEF517D75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiECGgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiECGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98935381BC;
        Mon,  2 May 2022 23:31:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55CAA210EE;
        Tue,  3 May 2022 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8MmPzwl2lp0qT4RRcx9jpE3gXaEx+C80zfCSbZItmk=;
        b=yZZZ1Yhj6WFqcOB3T+dFkHRx2YoQ5v/uB+PvpARHCw993viZeYyyhq3xz4jhtE04+2uN7n
        El/xQlhJrrLYAag7oux4z4LwaVTcDCpATDil6UwNU5eMlIvy60sgUfo4Jmu5X6UGcSx98d
        2yGhv9HZyl43GG0APYfF9Xu8+XtBCaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8MmPzwl2lp0qT4RRcx9jpE3gXaEx+C80zfCSbZItmk=;
        b=CU0X0MZaKwV/xK5wQtV1xuEyVMoMa27yyHT1O9L2exNLpphfc/eEeZScW/lrIJJ+P1ZGIA
        4mGTJesrWn1SyCCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F3BD22C149;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Andrei Pistirica <andrei.pistirica@microchip.com>
Subject: [PATCH 11/11] serial: pic32: restore disabled irqs in pic32_uart_startup()
Date:   Tue,  3 May 2022 08:31:22 +0200
Message-Id: <20220503063122.20957-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
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

pic32_uart_startup() disables interrupts by local_irq_save(). But the
function never enables them. The serial core only holds a mutex, so irqs
are not restored.

So how could this driver work? This irq handling was already present in
the driver's initial commit 157b9394709ed (serial: pic32_uart: Add PIC32
UART driver).

So is it a candidate for removal? Anyone has a contact to the author:
Andrei Pistirica (I believe the one below -- @microchip.com -- will
bounce)? Or to someone else @microchip.com?

Cc: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index c5584628f8c4..b399aac530fe 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -564,6 +564,8 @@ static int pic32_uart_startup(struct uart_port *port)
 	/* enable all interrupts and eanable uart */
 	pic32_uart_en_and_unmask(port);
 
+	local_irq_restore(flags);
+
 	enable_irq(sport->irq_rx);
 
 	return 0;
-- 
2.36.0

