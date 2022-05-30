Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE86538512
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiE3PjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiE3Pi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:38:58 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5EB69B73
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:46:46 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220530144630d17b30635b74043a1b
        for <linux-kernel@vger.kernel.org>;
        Mon, 30 May 2022 16:46:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UJuQVbGzL7rw+17ZXL97cqh0Je+QI5cDnhvQmUFGp38=;
 b=fvi4+WIdTxAgGA9Ind8Jmq5ooknKaltqiBelcsLSUrkUkXuGkeqdGELoIKeq+2XH2g77O7
 m+XQGtyRFs3vopcNVUcRiQiyc1ELky0S2IQbUhNl0pTE6/vGhRX3CBwp2QuA9ZlZRha4uR+1
 +qhGcB5VqOys8vUjiqZUTiulaIjy0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 7/9] tty: n_gsm: fix packet re-transmission without open control channel
Date:   Mon, 30 May 2022 16:45:10 +0200
Message-Id: <20220530144512.2731-7-daniel.starke@siemens.com>
In-Reply-To: <20220530144512.2731-1-daniel.starke@siemens.com>
References: <20220530144512.2731-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

In the current implementation control packets are re-transmitted even if
the control channel closed down during T2. This is wrong.
Check whether the control channel is open before re-transmitting any
packets. Note that control channel open/close is handled by T1 and not T2
and remains unaffected by this.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

There have been no comments on v2, hence, no change was done.

Link: https://lore.kernel.org/all/20220519070757.2096-7-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b82efb63f4e6..9e4ada510c9f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1624,7 +1624,7 @@ static void gsm_control_retransmit(struct timer_list *t)
 	spin_lock_irqsave(&gsm->control_lock, flags);
 	ctrl = gsm->pending_cmd;
 	if (ctrl) {
-		if (gsm->cretries == 0) {
+		if (gsm->cretries == 0 || !gsm->dlci[0] || gsm->dlci[0]->dead) {
 			gsm->pending_cmd = NULL;
 			ctrl->error = -ETIMEDOUT;
 			ctrl->done = 1;
-- 
2.34.1

