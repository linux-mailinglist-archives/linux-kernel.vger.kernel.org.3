Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCD4B9A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiBQIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:07:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiBQIH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:07:28 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:07:09 PST
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDD27F284
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:07:09 -0800 (PST)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202202170806016044ca43e6dfafbea2
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 09:06:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=b4XQwcsAcfoBdhr0FTblO5I+qrC5OxsrZ4b1kwFO1ds=;
 b=Vm7L1uvfzBWOywg+1xfnqErDAnxpaT8I6HRkth8NIwLZl9HWNGJjPi++sFQq8vZ9pnxywv
 nZrVAgXtCYtBWO+m9iIqe0wtmiRKObZplqqrNkKoS2POJ6Skf9b46ITJrCrrZn1Cjs/Dh015
 WwHsQTlBnSzrOU0KSmb3eanrXZL5I=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: fix deadlock in gsmtty_open()
Date:   Thu, 17 Feb 2022 00:05:55 -0800
Message-Id: <20220217080555.5387-7-daniel.starke@siemens.com>
In-Reply-To: <20220217080555.5387-1-daniel.starke@siemens.com>
References: <20220217080555.5387-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation the user may open a virtual tty which then
could fail to establish the underlying DLCI. The function gsmtty_open()
gets stuck in tty_port_block_til_ready() while waiting for a carrier rise.
This happens if the remote side fails to acknowledge the link establishment
request in time or completely. At some point gsm_dlci_close() is called
to abort the link establishment attempt. The function tries to inform the
associated virtual tty by performing a hangup. But the blocking loop within
tty_port_block_til_ready() is not informed about this event.
The patch proposed here fixes this by resetting the initialization state of
the virtual tty to ensure the loop exits and triggering it to make
tty_port_block_til_ready() return.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e61a47c349e3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1451,6 +1451,9 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
 		kfifo_reset(&dlci->fifo);
+		/* Ensure that gsmtty_open() can return. */
+		tty_port_set_initialized(&dlci->port, 0);
+		wake_up_interruptible(&dlci->port.open_wait);
 	} else
 		dlci->gsm->dead = true;
 	/* Unregister gsmtty driver,report gsmtty dev remove uevent for user */
-- 
2.25.1

