Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB3517D74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiECGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiECGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F2381B9;
        Mon,  2 May 2022 23:31:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DCB041F747;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kglfxKG8tOeOX0Y7XjujhzV++vy+pMPUwg+1PazJyZA=;
        b=fu+k0L0lbktlDQMhsGobm0GybDiRtyawngc3BfVZGH+Pay8xZK9HFACmzMTR4IH/dQS+Q8
        lLldzCGZZzpWkDxYHMf42yxtTtIZPe6cEvkGgrCqbVSSbcnVz7KZbdV4ys3I/ttbV0bDJb
        c5SVBIa5ULbc/85AFKDe71CVzM9t5FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kglfxKG8tOeOX0Y7XjujhzV++vy+pMPUwg+1PazJyZA=;
        b=MUHdNmBrGDdkFUrm72yoGJX8ErNImRxRpNdiwPihjoTRAnyX20PPcp53moOpxH501//RV1
        +HVrWVp104M9NuDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B37FB2C141;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/11] serial: pic32: free up irq names correctly
Date:   Tue,  3 May 2022 08:31:21 +0200
Message-Id: <20220503063122.20957-11-jslaby@suse.cz>
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

struct pic32_sport contains built-up names for irqs. These are freed
only in error path of pic32_uart_startup(). And even there, the freeing
happens before free_irq().

So fix this by:
* moving frees after free_irq(), and
* add frees to pic32_uart_shutdown() -- the opposite of
  pic32_uart_startup().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 990603fe8a8d..c5584628f8c4 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -569,14 +569,14 @@ static int pic32_uart_startup(struct uart_port *port)
 	return 0;
 
 out_t:
-	kfree(sport->irq_tx_name);
 	free_irq(sport->irq_tx, port);
+	kfree(sport->irq_tx_name);
 out_r:
-	kfree(sport->irq_rx_name);
 	free_irq(sport->irq_rx, port);
+	kfree(sport->irq_rx_name);
 out_f:
-	kfree(sport->irq_fault_name);
 	free_irq(sport->irq_fault, port);
+	kfree(sport->irq_fault_name);
 out_done:
 	return ret;
 }
@@ -595,8 +595,11 @@ static void pic32_uart_shutdown(struct uart_port *port)
 
 	/* free all 3 interrupts for this UART */
 	free_irq(sport->irq_fault, port);
+	kfree(sport->irq_fault_name);
 	free_irq(sport->irq_tx, port);
+	kfree(sport->irq_tx_name);
 	free_irq(sport->irq_rx, port);
+	kfree(sport->irq_rx_name);
 }
 
 /* serial core request to change current uart setting */
-- 
2.36.0

