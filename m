Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77FA4FB9EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbiDKKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345690AbiDKKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9413CC3;
        Mon, 11 Apr 2022 03:45:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CA3C1F864;
        Mon, 11 Apr 2022 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGE3QD6z+mw6oVDHzRqdqpWGIUM4LnUnXOrLoFmEk7o=;
        b=Lh+SCQtDUeJKJSpxBy4Gy/KSBUKznVcw3tchP02SlruZA+o5DZ9lRCfwPuazcOFWAnt044
        oQLlePmyhB4oXPXmCfbgdiluWhNmXtNz8QxvesMqV8lN6d/8ORX+6qZrzKEevGja8EPelm
        SUDQr16mUnEgrGFcuxrCimDf6IDwQqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGE3QD6z+mw6oVDHzRqdqpWGIUM4LnUnXOrLoFmEk7o=;
        b=OvMO7talElJztTKB6xkPxpPfl0t2e4YQ1Nxe9LQ/McMpE2MooOn4yjh+KX04NU01P7lK+Z
        MhYyC5HN/8RIGjAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4EE0BA3B96;
        Mon, 11 Apr 2022 10:45:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/3] tty: serial: altera: use altera_jtaguart_stop_tx()
Date:   Mon, 11 Apr 2022 12:45:06 +0200
Message-Id: <20220411104506.8990-4-jslaby@suse.cz>
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

altera_jtaguart_tx_chars() duplicates what altera_jtaguart_stop_tx()
already does. So instead of the duplication, call the helper instead.

Not only it makes the code cleaner, but it also says what the "if"
really does.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/altera_jtaguart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 1c16345d0a1f..cb791c5149a3 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -168,10 +168,8 @@ static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
 		}
 	}
 
-	if (pending == 0) {
-		pp->imr &= ~ALTERA_JTAGUART_CONTROL_WE_MSK;
-		writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
-	}
+	if (pending == 0)
+		altera_jtaguart_stop_tx(port);
 }
 
 static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
-- 
2.35.1

