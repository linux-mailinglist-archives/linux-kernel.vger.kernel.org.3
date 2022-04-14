Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64FB500A57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiDNJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiDNJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:20 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:56 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8839E6E4CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:56 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202204140942460ad6484a77b0a6adff
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PQKsbg+lNJZPyvz7TfsGHHbXuaZxjlFMilmR10dAP5U=;
 b=mOFb7SpzdHyOeMQAAL522kbsqZxYgaSRoemGxte58uYOuG1rUoGTJnS0qLa/OxUt/G69o7
 7mZnS71zHlGNvFTErwwJEzEQp3D9qSMORuHE640TGb95z2w4GCpDCsKC4NPI/XeV3FwMsNgH
 J3MT7vfJ8KMFGRup8k9gTxV7WCaKE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 10/20] tty: n_gsm: fix missing explicit ldisc flush
Date:   Thu, 14 Apr 2022 02:42:15 -0700
Message-Id: <20220414094225.4527-10-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

In gsm_cleanup_mux() the muxer is closed down and all queues are removed.
However, removing the queues is done without explicit control of the
underlying buffers. Flush those before freeing up our queues to ensure
that all outgoing queues are cleared consistently. Otherwise, a new mux
connection establishment attempt may time out while the underlying tty is
still busy sending out the remaining data from the previous connection.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 6b953dfbb155..1430d7f83bd2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2152,6 +2152,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 			gsm_dlci_release(gsm->dlci[i]);
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
+	tty_ldisc_flush(gsm->tty);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_list);
-- 
2.25.1

