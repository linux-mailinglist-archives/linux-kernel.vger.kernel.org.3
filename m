Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC24B9A98
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiBQIHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:07:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBQIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:07:18 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 00:07:05 PST
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438727DF36
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:07:05 -0800 (PST)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2022021708055962cabcbb318342df40
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 09:05:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2QoxEb5jjQqEe5geNwJ+mjwTK4TQqzNR+pyl04R918k=;
 b=BJeoUo5/it/wT+H+ZEmjVFPxrprdK5MjxC/I8iTA4A7lN7w1BGGOiHxoxDbsZ9yxmousFg
 E/Dy6fnC6Vv72qmGtR6qb1VtE7WcQOaxEhXE5npRMZqvysDanY+sQXmxG4O5L8t6ZUp9Dwpo
 fNU+3wn0IytRirJdtmdPAAEq8KW1s=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: fix NULL pointer access due to DLCI release
Date:   Thu, 17 Feb 2022 00:05:52 -0800
Message-Id: <20220217080555.5387-4-daniel.starke@siemens.com>
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

The here fixed commit made the tty hangup asynchronous to avoid a circular
locking warning. I could not reproduce this warning. Furthermore, due to
the asynchronous hangup the function call now gets queued up while the
underlying tty is being freed. Depending on the timing this results in a
NULL pointer access in the global work queue scheduler. To be precise in
process_one_work(). Therefore, the previous commit made the issue worse
which it tried to fix.

This patch fixes this by falling back to the old behavior which uses a
blocking tty hangup call before freeing up the associated tty.

Fixes: 7030082a7415 ("tty: n_gsm: avoid recursive locking with async port hangup")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e63154ef0b6c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1748,7 +1748,12 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 
-		tty_hangup(tty);
+		/* We cannot use tty_hangup() because in tty_kref_put() the tty
+		 * driver assumes that the hangup queue is free and reuses it to
+		 * queue release_one_tty() -> NULL pointer panic in
+		 * process_one_work().
+		 */
+		tty_vhangup(tty);
 
 		tty_port_tty_set(&dlci->port, NULL);
 		tty_kref_put(tty);
-- 
2.25.1

