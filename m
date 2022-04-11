Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF84FB9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiDKKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbiDKKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2734E12AF9;
        Mon, 11 Apr 2022 03:45:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DC90B215FD;
        Mon, 11 Apr 2022 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UaJrwZ35b5PfLiZGtmO7k6+jGdgy3u8eolCyPOX7Bk=;
        b=WAn0BHpI1gjrWAB2lZTv6/O863lJPaj+fkkxp9elG+Y23v1HIpKZkN39HG4HC5YyUIq+x/
        5oZkQJ1pheh0Cyo/6dub+XCm+DB5ayJ0ukYDaMujhVQx2Ds1+He5rMDGreZkwRWuN5Jfj1
        d4v9Zp8IgppQQ0kF0vMpHEEOeIjNxis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UaJrwZ35b5PfLiZGtmO7k6+jGdgy3u8eolCyPOX7Bk=;
        b=V8KzJC8CDfB1m4EVRw7Zzz+GDlgn2EueI8gPP6kCEUDh6GmZcZrUqLNZUejFmaSJ6CLH5B
        4x7OHYwFBFpAh6CQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A985DA3B89;
        Mon, 11 Apr 2022 10:45:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] tty: serial: mpc52xx_uart: remove double ifdeffery
Date:   Mon, 11 Apr 2022 12:45:04 +0200
Message-Id: <20220411104506.8990-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411104506.8990-1-jslaby@suse.cz>
References: <20220411104506.8990-1-jslaby@suse.cz>
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

The code now contains:
 #ifdef CONFIG_PPC_MPC512x
 ...
 #endif

 #ifdef CONFIG_PPC_MPC512x
 ...
 #endif

So remove the endif+ifdef from the middle, provided it's about the same
define.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpc52xx_uart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3acc0f185762..c4b590dd6f23 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -754,9 +754,6 @@ static void mpc512x_psc_get_irq(struct uart_port *port, struct device_node *np)
 	port->irqflags = IRQF_SHARED;
 	port->irq = psc_fifoc_irq;
 }
-#endif
-
-#ifdef CONFIG_PPC_MPC512x
 
 #define PSC_5125(port) ((struct mpc5125_psc __iomem *)((port)->membase))
 #define FIFO_5125(port) ((struct mpc512x_psc_fifo __iomem *)(PSC_5125(port)+1))
-- 
2.35.1

