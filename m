Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990CC509D65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388297AbiDUKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388170AbiDUKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D822539;
        Thu, 21 Apr 2022 03:17:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80D0E215FD;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZDmSqxvMSMnzvD66zwNXx1oaFSysSwdXwirsm7uH1U=;
        b=GdUI6X2P8dy3i3Mu4rned74AooRfbQ15jokbXg46TXhM39+Ah83oDRuCoZVCW+Qwe5ivC2
        0CGoI/G+RpI2bVmxOrlPHcbYRCduFA7rpCxysh3nf7su51vnFq3tSqdcQ/M0gr53YEWyjT
        WNgfRv2b3YmkcjxXqqnWvoLnQot1q3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZDmSqxvMSMnzvD66zwNXx1oaFSysSwdXwirsm7uH1U=;
        b=w05mHH6TFR+f4ofcPE4b0aaD79QbvniAyOjRKMuudWzlCYtlN0x7roK1X0sp8vLvhNezkD
        KZ/TMG3Dq/VwMkCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E8932C145;
        Thu, 21 Apr 2022 10:17:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/7] serial: sunplus-uart: mark sunplus_console_ports[] static
Date:   Thu, 21 Apr 2022 12:17:02 +0200
Message-Id: <20220421101708.5640-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421101708.5640-1-jslaby@suse.cz>
References: <20220421101708.5640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used only in the driver, so declare it as local to silence this
correct sparse warning:
sunplus-uart.c:501:26: warning: symbol 'sunplus_console_ports' was not declared. Should it be static?

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/sunplus-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 9f15922e681b..60c73662f955 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -498,7 +498,7 @@ static const struct uart_ops sunplus_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
-struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
+static struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
 
 static void sunplus_uart_console_putchar(struct uart_port *port,
 					 unsigned char ch)
-- 
2.36.0

