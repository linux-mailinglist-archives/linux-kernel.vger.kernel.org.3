Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF5519994
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbiEDIWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiEDIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:21:48 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A62317F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:18:06 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220504081804bd89c3fceea64181bf
        for <linux-kernel@vger.kernel.org>;
        Wed, 04 May 2022 10:18:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=givcKcPjIx5sD2l4pl+6VjcrPMHyRzWU5ISndNhsXmE=;
 b=Uqv1JdNruTqnKaiNdczbMn3KY9J758mW2IfxbjXsfdMN/5m/YyE++8YhwrUKW9D2lATKea
 cLlWRTCHypejgHj3MuZat3Dn8lvFwzVvn4Sy+vNSjV1Phq28DqVECqq5ZMBLu79OmHmFVQqK
 grPpItO5O8IO5FpKlqwvqa9PUNA/o=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/3] tty: n_gsm: fix mux activation issues in gsm_config()
Date:   Wed,  4 May 2022 10:17:32 +0200
Message-Id: <20220504081733.3494-2-daniel.starke@siemens.com>
In-Reply-To: <20220504081733.3494-1-daniel.starke@siemens.com>
References: <20220504081733.3494-1-daniel.starke@siemens.com>
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

The current implementation activates the mux if it was restarted and opens
the control channel if the mux was previously closed and we are now acting
as initiator instead of responder, which is the default setting.
This has two issues.
1) No mux is activated if we keep all default values and only switch to
initiator. The control channel is not allocated but will be opened next
which results in a NULL pointer dereference.
2) Switching the configuration after it was once configured while keeping
the initiator value the same will not reopen the control channel if it was
closed due to parameter incompatibilities. The mux remains dead.

Fix 1) by always activating the mux if it is dead after configuration.
Fix 2) by always opening the control channel after mux activation.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9b0b435cf26e..bcb714031d69 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2352,6 +2352,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 {
+	int ret = 0;
 	int need_close = 0;
 	int need_restart = 0;
 
@@ -2419,10 +2420,13 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * FIXME: We need to separate activation/deactivation from adding
 	 * and removing from the mux array
 	 */
-	if (need_restart)
-		gsm_activate_mux(gsm);
-	if (gsm->initiator && need_close)
-		gsm_dlci_begin_open(gsm->dlci[0]);
+	if (gsm->dead) {
+		ret = gsm_activate_mux(gsm);
+		if (ret)
+			return ret;
+		if (gsm->initiator)
+			gsm_dlci_begin_open(gsm->dlci[0]);
+	}
 	return 0;
 }
 
-- 
2.34.1

