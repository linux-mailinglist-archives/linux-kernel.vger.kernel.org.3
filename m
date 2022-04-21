Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF72509B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387138AbiDUJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387061AbiDUJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8E21243;
        Thu, 21 Apr 2022 01:58:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F19C41F753;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TRr5a8I+35GUTDd8hSglfnLjzJ6edowbn+//3H1oS4=;
        b=RxIwFwkNkg5JQd/N7EHcYl1jmRjJk+3yyY2I4gYOa+JZy7x7FXJEZLup32UhvjInc+UPCt
        V8DCfgrQk9O+KlVGcckDU3aWTZ7HCpFb9fU8NBgHLaSc9cLWX7cBC9kbEZ6J9d0f3Ew3OZ
        LvDuFnacCyzOIL+ihlW7dfBvZOaYKjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TRr5a8I+35GUTDd8hSglfnLjzJ6edowbn+//3H1oS4=;
        b=ZwCQNVpFmRkkVCElwSmCgyaROdQDwR9dZiCnTiOjTqzeR/X/Wn7r5zGlLwZXaejDtyFNr5
        xhkfIxKrosAz52AQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C13542C145;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/10] serial: icom: delete empty serial hooks
Date:   Thu, 21 Apr 2022 10:58:07 +0200
Message-Id: <20220421085808.24152-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
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

uart_ops::release_port() and uart_ops::request_port() are not required
by the serial layer. So no need to define empty ones.

Remove them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 8701856e2a2e..e22f37a41764 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1532,15 +1532,6 @@ static const char *icom_type(struct uart_port *port)
 	return "icom";
 }
 
-static void icom_release_port(struct uart_port *port)
-{
-}
-
-static int icom_request_port(struct uart_port *port)
-{
-	return 0;
-}
-
 static void icom_config_port(struct uart_port *port, int flags)
 {
 	port->type = PORT_ICOM;
@@ -1559,8 +1550,6 @@ static const struct uart_ops icom_ops = {
 	.shutdown = icom_close,
 	.set_termios = icom_set_termios,
 	.type = icom_type,
-	.release_port = icom_release_port,
-	.request_port = icom_request_port,
 	.config_port = icom_config_port,
 };
 
-- 
2.36.0

