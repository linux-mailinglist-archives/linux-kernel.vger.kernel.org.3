Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE30544E89
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiFIORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFIORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:17:09 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E97737B0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654784228;
  x=1686320228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c6IxUXe9FriEr7JTTrdaoFq1HFGprqK8RycGUKJdb+Y=;
  b=OFKcrGsYNfHLxlrTzZhPY7jOwUtLTRo7S6FfR8hMpsXvUeOXZzwJDueI
   UzWAemWJwlhGOMvyW9wp+g3MtT0NFWoKFN9lsHi/ur4MShZVV/hk5OSw/
   4dXaLnDPSOssZivAluR0nMgtHui4aTOC+G9ygZVqiCmKt54cgkRJUICiL
   HRNHi52SSRZ33lm9rwClP8Df6h+jjnkru0It/o8Pc1jJfcfgxUJUbTVTR
   HJHEksqwPP/uHTHEJroCYfJUaI76NmCd+aGSqono3LoxXtmsZRzH5zFxv
   OpXUusfLyHuue/VIG41F+2fPBmGLrt3j1x0bJ8NSwfpPGrJc/FuS9lm1G
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] tty: goldfish: Fix free_irq() on remove
Date:   Thu, 9 Jun 2022 16:17:04 +0200
Message-ID: <20220609141704.1080024-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the correct dev_id to free_irq() to fix this splat when the driver
is unbound:

 WARNING: CPU: 0 PID: 30 at kernel/irq/manage.c:1895 free_irq
 Trying to free already-free IRQ 65
 Call Trace:
  warn_slowpath_fmt
  free_irq
  goldfish_tty_remove
  platform_remove
  device_remove
  device_release_driver_internal
  device_driver_detach
  unbind_store
  drv_attr_store
  ...

Fixes: 465893e18878e119 ("tty: goldfish: support platform_device with id -1")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/goldfish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c7968aecd870..d02de3f0326f 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -426,7 +426,7 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	tty_unregister_device(goldfish_tty_driver, qtty->console.index);
 	iounmap(qtty->base);
 	qtty->base = NULL;
-	free_irq(qtty->irq, pdev);
+	free_irq(qtty->irq, qtty);
 	tty_port_destroy(&qtty->port);
 	goldfish_tty_current_line_count--;
 	if (goldfish_tty_current_line_count == 0)
-- 
2.34.1

