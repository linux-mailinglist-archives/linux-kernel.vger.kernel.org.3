Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3254509D68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388356AbiDUKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379764AbiDUKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3A925C40;
        Thu, 21 Apr 2022 03:17:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A201921110;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Nre80yG3dX3kSQn05Ue/XY8zsmy/wEbfiIp5CM7yac=;
        b=TJ/aeHQEIzst0dMgWVyDEvZKl/9sw9YXVuYCt8QqePeQOp9t3zw4y+ZemPqnfHX0JeSwLo
        qG0p04wrGwFk9y6F0HzAdxVKzgVA2fwLJ+m7SzJ/H83v1FB01BWFvMQjpNxERG0dPHv6BU
        hLUBPEGbD0sA/xuXErAwnV1c3LZlQzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Nre80yG3dX3kSQn05Ue/XY8zsmy/wEbfiIp5CM7yac=;
        b=3eN1T6Khp94LhXBTUA9ggDKKjg5/dPqrHN0XPr5EiyCaynzS9pjA1tywpAY8AcGd/oTjLm
        BEoFnS8Af8dY+HBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 602062C141;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5/7] serial: qcom: use check for empty instead of pending
Date:   Thu, 21 Apr 2022 12:17:06 +0200
Message-Id: <20220421101708.5640-6-jslaby@suse.cz>
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

The code wants to know if the circ buffer is empty, so use the proper
macro.

No functional change intended, just saner function name used for that
use case.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1543a6028856..f4961022d7d0 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -507,7 +507,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		 */
 		qcom_geni_serial_poll_tx_done(uport);
 
-		if (uart_circ_chars_pending(&uport->state->xmit)) {
+		if (!uart_circ_empty(&uport->state->xmit)) {
 			irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
-- 
2.36.0

