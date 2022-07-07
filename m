Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF956A113
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiGGLd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiGGLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:33:54 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56922A708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:33:50 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20220707113347b436a0426659325429
        for <linux-kernel@vger.kernel.org>;
        Thu, 07 Jul 2022 13:33:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=4zrox7ZlHscR7GaMrL4oS4/tk+1RCzBT6lJQ3JfJL0o=;
 b=HUiTBM6BLE6FL/IKNjsboP7hCLX6YfsV25sCaqNvdbwN9jig4jMsRx9/uwSTllrWuoV43E
 9GKrXZbk+hxwly5vX37zBkkvykw6ywSzvzTvTJyG7O2RLNkKWEZMal1sxbYQN6SW61zW5FkZ
 vghSkA6GzHoyVr16NOIQH9xf+uCZY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 1/4] tty: n_gsm: fix wrong T1 retry count handling
Date:   Thu,  7 Jul 2022 13:32:20 +0200
Message-Id: <20220707113223.3685-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.7.3 states that the valid range for the
maximum number of retransmissions (N2) is from 0 to 255 (both including).
gsm_dlci_t1() handles this number incorrectly by performing N2 - 1
retransmission attempts. Setting N2 to zero results in more than 255
retransmission attempts.
Fix gsm_dlci_t1() to comply with 3GPP 27.010.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

No changes have been applied compared to v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ba399a660573..1a70e7ae90cc 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1805,8 +1805,8 @@ static void gsm_dlci_t1(struct timer_list *t)
 
 	switch (dlci->state) {
 	case DLCI_OPENING:
-		dlci->retries--;
 		if (dlci->retries) {
+			dlci->retries--;
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else if (!dlci->addr && gsm->control == (DM | PF)) {
@@ -1821,8 +1821,8 @@ static void gsm_dlci_t1(struct timer_list *t)
 
 		break;
 	case DLCI_CLOSING:
-		dlci->retries--;
 		if (dlci->retries) {
+			dlci->retries--;
 			gsm_command(dlci->gsm, dlci->addr, DISC|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else
-- 
2.34.1

