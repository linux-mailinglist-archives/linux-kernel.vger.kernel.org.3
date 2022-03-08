Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78A74D16A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbiCHLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbiCHLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:52:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CF2E0BD;
        Tue,  8 Mar 2022 03:51:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A466E210E6;
        Tue,  8 Mar 2022 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646740314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69P3WCvNQdmaauvrWwLLWv+JvvLFhAucBSS7dtHIT54=;
        b=ggdVg7np2tGJKqgZ5jFpCPc1kTDHGsCkDyZVJzRDSLbmTdTmNmi9zqDO0RlvPK3GK66o4Z
        cZq2tuAaHpnnrF5/K/6HAi9eJB05LleVIdeB5WTrkGCy7W6MQnu/qy/ni1O3Rl/C7wnMpw
        8KGZ/2STi7r0gp2nN8lu6pwpetQzNcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646740314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69P3WCvNQdmaauvrWwLLWv+JvvLFhAucBSS7dtHIT54=;
        b=rPfaPKU76W/EgMh3Q7YoRzz8uPGhVrJ5RoATNjdMiNvN+6aphcqxzb3KefnxFLK8wGwwcJ
        hdEcOTN3ZLS7/7Bg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23D43A3B81;
        Tue,  8 Mar 2022 11:51:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Hyeonkook Kim <hk619.kim@samsung.com>
Subject: [PATCH] serial: samsung_tty: do not unlock port->lock for uart_write_wakeup()
Date:   Tue,  8 Mar 2022 12:51:53 +0100
Message-Id: <20220308115153.4225-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
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

The commit c15c3747ee32 (serial: samsung: fix potential soft lockup
during uart write) added an unlock of port->lock before
uart_write_wakeup() and a lock after it. It was always problematic to
write data from tty_ldisc_ops::write_wakeup and it was even documented
that way. We fixed the line disciplines to conform to this recently.
So if there is still a missed one, we should fix them instead of this
workaround.

On the top of that, s3c24xx_serial_tx_dma_complete() in this driver
still holds the port->lock while calling uart_write_wakeup().

So revert the wrap added by the commit above.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Hyeonkook Kim <hk619.kim@samsung.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/samsung_tty.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 95018a847023..ab26520c9c21 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -921,11 +921,8 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 		return;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-		spin_unlock(&port->lock);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-		spin_lock(&port->lock);
-	}
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
-- 
2.35.1

