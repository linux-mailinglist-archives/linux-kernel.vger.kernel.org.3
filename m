Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4D49793F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiAXHOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbiAXHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CD5CE21902;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XV46mzSFv8kv8sW667zWAvqoI5/aaUPrjGx3ycspT9I=;
        b=LnArH9YVgLUePBhEZ7D2MpDGNGRl1mADe9cRNVwpNKaUsCebjqQnOYfKMj6CtqyyLyhc4S
        203VydnMQIgnVj3DgvkzX8FZv0lJmhv+Ot1bSA2vzJkIv7GWKCaJuTgonOnMlvLaMU3MaF
        W1KZQpmHl9Y0bP/8ZfDMQnhMjb5TboU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XV46mzSFv8kv8sW667zWAvqoI5/aaUPrjGx3ycspT9I=;
        b=yQhwMBpYouWrHMRaskqFjlnJI9PsZ2Gr1nwaBjsxtM7MCcLssC2OmO+4l8naWrbPUgJsLR
        +63dkfvhOvussjCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86DB9A3B88;
        Mon, 24 Jan 2022 07:14:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH 09/11] serial: fsl_linflexuart: don't call uart_write_wakeup() twice
Date:   Mon, 24 Jan 2022 08:14:28 +0100
Message-Id: <20220124071430.14907-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linflex_txint() calls linflex_transmit_buffer() which calls
uart_write_wakeup(). So there is no point to repeat it in
linflex_txint() again -- remove it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 81a04039b6c1..e72cba085743 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -217,10 +217,6 @@ static irqreturn_t linflex_txint(int irq, void *dev_id)
 	}
 
 	linflex_transmit_buffer(sport);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(sport);
-
 out:
 	spin_unlock_irqrestore(&sport->lock, flags);
 	return IRQ_HANDLED;
-- 
2.34.1

