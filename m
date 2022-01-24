Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6839C49794C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiAXHQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:16:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58050 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiAXHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 87C851F3A0;
        Mon, 24 Jan 2022 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+J5pYRJpicKY3hxUjqS2LyMm6N9PtKdlkpBO1kMAA0=;
        b=Bq36DpPCsDV3lc13PK+mNj4UGH7zACOLCz7Mxd/a11pjDKxPMXLJ50cxQbTdg8SQjb45TN
        IJkPiSY03jP9s7PfjvaFltMPmIEPWjqKjiI9xioHHrcGLVCXMxPcNDTI6/X3XJam4xtreK
        HXX7WQBa/ZH2lyG4petofXDJoq6MvHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+J5pYRJpicKY3hxUjqS2LyMm6N9PtKdlkpBO1kMAA0=;
        b=uxvSuvG6mfBfN0cRYTOdIdYcb2UofHC3Tb/8P9eKOeKYtZnQKp1LExO1MQdctskpkZpKjY
        0f8udhq20mZaPcCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 006EEA3B84;
        Mon, 24 Jan 2022 07:14:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 02/11] serial: atmel_serial: include circ_buf.h
Date:   Mon, 24 Jan 2022 08:14:21 +0100
Message-Id: <20220124071430.14907-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atmel_uart_port::rx_ring is defined as struct circ_buf, but circ_buf.h
is not included explicitly in atmel_serial.c. It is included only
implicitly via serial_core.h. Fix this as serial_core.h might not
include that header in the future.

Signed-off-by:Jiri Slaby <jslaby@suse.cz>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c370eddc651b..2d09a89974a2 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -8,6 +8,7 @@
  *
  *  DMA support added by Chip Coldwell.
  */
+#include <linux/circ_buf.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
-- 
2.34.1

