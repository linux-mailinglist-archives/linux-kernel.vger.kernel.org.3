Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270A24EA9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiC2IxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiC2Iwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:52:49 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619451E5A;
        Tue, 29 Mar 2022 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648543865; x=1680079865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wWjkIsGoRiHdG4LM9QjPl/bqZpReNK5RcM9UVleK3mw=;
  b=B/LEcAqrLIBOv2FnFFlIoYTbhf5KrkcjpWjSVjnLtv3EWUt8MWmQn/YM
   gQxOx68OfTLViQewQl9BN48BzHSAyNq9fvkrGzt1xQaA3CyepQN2RtSAQ
   M2Uph0WgHgf+QorVEC06yTvxZyOzNiaJyzbKlpPYA8rpnHknQapLgN23T
   SIS5WEbbHmWNGJ0qpgQl7zCYWKH2inbOn/FT861wvrsm6qe00uKTYa7Lr
   yvB0a5uRt8/bL9WCtFiGR3xAnRviotlgORj1OMmb4oxLpOtp7hCerzGJJ
   +nZyViWsl5xhFHn4YRrWaasi/SCtavgPTM9iIIh8YofrvOiD63F2G8hLc
   g==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="22954136"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Mar 2022 10:51:02 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 29 Mar 2022 10:51:02 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 29 Mar 2022 10:51:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648543862; x=1680079862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wWjkIsGoRiHdG4LM9QjPl/bqZpReNK5RcM9UVleK3mw=;
  b=QnE21zjVvkmAd27D8EsS86mdmONZwM+HOwPgYUSQiDVnnsYDKln6YqXl
   OmVNDhiYFx/Bp9SJHkUZzCLOm5mqZAYchtNIoUEfrTeTZjnNXtsSujAx4
   2hRgsMh6hFDxBKLVCmF67V9xuGvDB0V3NvJUC+Zc23k9A/3N2ARR1FbKx
   akYeJdHw/sMW8dAAxzhhjPumbIt+ixH4k/gw8dR1TQnbmS/k6M32YqTJ+
   /Ewm4RryjznrgfTj/CDDSAZ4zjfsv4lOeJ9LQ2Xx0yC1jVelMdIO1rzuj
   wr3cGjsdIZn+Hb21E1aFaBubxnFHM0hRIBkBYSWUklcIeuw3qlBnIHoeB
   g==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643670000"; 
   d="scan'208";a="22954135"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Mar 2022 10:51:02 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C47F3280065;
        Tue, 29 Mar 2022 10:51:01 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] serial: Revert RS485 polarity change on UART open
Date:   Tue, 29 Mar 2022 10:50:50 +0200
Message-Id: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the change of the RS485 polarity in
commit d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
might have made sense based on the original intention of the
rs485-rts-active-low flag (*), this is not how it is implemented in
various drivers:

At least the 8250 and the i.MX UART drivers interpret rs485-rts-active-low
the other way around. For these drivers, said change broke the initial
state of the RTS pin after opening the UART, making it impossible to
receive data until after the first send.

I considered fixing up the drivers to match the polarity used for the
initial state, however doing so would break all existing Device Trees
that configure RS485 for one of these drivers. Reverting the change
makes RS485 work correctly again on these devices.

[(*) My understanding of the mentioned commit's description is that
rs485-rts-active-low should have referred to the electical signal level
of the RTS pin, rather than the logical RTS state as understood by the
UART controller.]

Fixes: d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
Fixes: 2dd8a74fddd2 ("serial: core: Initialize rs485 RTS polarity already on probe")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

Skimming through a few other drivers with RS485 support, many other
implementation are in agreement with the 8250 and i.MX drivers. This seems
to be the case for the OMAP and the STM32 drivers. The PL011 driver on the
other hand seems to disagree, so it will need to be fixed if the intention
is to make all drivers consistent (preferable by someone who is familiar
with that hardware and can test the change).

It is unfortunate that different drivers disagree here, as any fix to
make things more consistent will break some users. One way to avoid that
would be to deprecate the rs485-rts-active-low flag altogether and replace
it with something new that is implemented consistently...

I can also propose a clarification for the DT binding documentation, if
this revert is how we want to proceed with the issue.

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6a8963caf954..c1c8bd712a59 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2390,7 +2390,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		spin_lock_irqsave(&port->lock, flags);
 		port->mctrl &= TIOCM_DTR;
 		if (port->rs485.flags & SER_RS485_ENABLED &&
-		    !(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
+		    !(port->rs485.flags & SER_RS485_RTS_ON_SEND))
 			port->mctrl |= TIOCM_RTS;
 		port->ops->set_mctrl(port, port->mctrl);
 		spin_unlock_irqrestore(&port->lock, flags);
-- 
2.25.1

