Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047BA5A96FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiIAMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIAMgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:36:43 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FEDFC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=B+SehaGXwjYGSf7G+iS3bDh795Izby0gHEeRvgWvOao=;
        b=Mq2fqu2v/VS1Y035laNkKVWwmBHA/cN2S5Ry+YweGLphHxf2RRku9b045PHCOffUEiR2acDHXWxxC
         1/a1bDlXcO7Wg7af0ezpok0HMpkg8SmaiEdxnbChwEWeSZyBZiuR1fGum2f57XkH5VisTY3Z6PeEt8
         jRgr7DlR7R/aEKYNiG6l4ynzpA8oD/bfoPjJMJ53qZ1E0s8aatPaDx90poNLb97x7P+6B0LGZnlW0+
         c+M8ayfxwKpgigzu8fy66wff/ZWGKV+6ldFffR0dgGNBHIYzdgBwyIKc6uzDnfc0OEwYD8gzasCLyI
         DfgH3jIyMbQ4JLoZYlK6YVoBltKlp9g==
X-MSG-ID: b9ca1510-29f2-11ed-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Casper Andersson <casper.casan@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH] spi: spi.c: Fix queue hang if previous transfer failed
Date:   Thu,  1 Sep 2022 14:36:30 +0200
Message-Id: <20220901123630.1098433-1-david@protonic.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The queue worker always needs to be kicked one final time after a transfer
is done in order to transition to idle (ctlr->busy = false).

Commit 69fa95905d40 ("spi: Ensure the io_mutex is held until
spi_finalize_current_message()") moved this code into
__spi_pump_messages(), but it was executed only if the transfer was
successful. This condition check causes ctlr-busy to stay true in case of
a failed transfer.
This in turn causes that no new work is ever scheduled to the work queue.

Fixes: 69fa95905d40 ("spi: Ensure the io_mutex is held until spi_finalize_current_message()")
Reported-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 83da8862b8f2..7355f4ac4e33 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
-	if (!ret)
-		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
+	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
 	ctlr->cur_msg = NULL;
 	ctlr->fallback = false;
-- 
2.34.1

