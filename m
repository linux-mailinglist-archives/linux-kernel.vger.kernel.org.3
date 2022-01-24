Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68A49793C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiAXHOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiAXHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 30C231F3B1;
        Mon, 24 Jan 2022 07:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuFLtxRTZL+pX7slRT+76aLI4pj2eN835rL2gxEVyNc=;
        b=1vuZeHBxeugR58gp3v3yE6fTC0JJS7f5aj7+jm7YwtHitujDJ77QYawVEPNlDpGLpQEvu3
        iF6pnKt9MKEHhnWOgsW8oNzVpJ8nsbYbcGK849hgZIJ6YFXzmoH3lCqIyk19yqPxcd6F35
        2YFl7ZzVjgsU+VzqzAJR7qopDNA75Jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuFLtxRTZL+pX7slRT+76aLI4pj2eN835rL2gxEVyNc=;
        b=5UaXFxKv1tZhQGFjZkseNB3psORNFKkNSpekwvopYFk5NZoxHbuhhjS76zVN+sDuLILq8+
        vuqx+8OaaQH/sOCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5A6FA3B84;
        Mon, 24 Jan 2022 07:14:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/11] tty: tty_port_open, document shutdown vs failed activate
Date:   Mon, 24 Jan 2022 08:14:23 +0100
Message-Id: <20220124071430.14907-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note that ->shutdown is not called when ->activate fails. Just so
we are clear.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 7644834640f1..4282895ede9e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -736,6 +736,9 @@ EXPORT_SYMBOL_GPL(tty_port_install);
  * the device to be ready using tty_port_block_til_ready() (e.g.  raises
  * DTR/CTS and waits for carrier).
  *
+ * Note that @port->ops->shutdown is not called when @port->ops->activate
+ * returns an error (on the contrary, @tty->ops->close is).
+ *
  * Locking: Caller holds tty lock.
  *
  * Note: may drop and reacquire tty lock (in tty_port_block_til_ready()) so
-- 
2.34.1

