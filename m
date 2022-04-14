Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB7500A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbiDNJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbiDNJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:20 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:55 PDT
Received: from mta-64-227.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746E6FF58
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:55 -0700 (PDT)
Received: by mta-64-227.flowmailer.net with ESMTPSA id 20220414094247654e0b0b8fc9adedd5
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wiF23XObNbK0UPCKxihGtA9aFYAmV/dIBUR0MDgOqIs=;
 b=GrKeR/n/sbvCoxbddvGvy3y6V4S0/lRGJEyrSW9xatcp7KFXlbvYJ8EuLIzZUWqeoqKA6Q
 6GIkCD1Y2PLMBefrImjhGlqrdioLJOHWcpG/m6DHMwmFsABXUnWBGQ2+RzPnMOxXa3A/3E5n
 XV4yvkOOyGmLpudAKIThBdO/JvD84=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 11/20] tty: n_gsm: fix wrong command retry handling
Date:   Thu, 14 Apr 2022 02:42:16 -0700
Message-Id: <20220414094225.4527-11-daniel.starke@siemens.com>
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

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.7.3 states that the valid range for the
maximum number of retransmissions (N2) is from 0 to 255 (both including).
gsm_config() fails to limit this range correctly. Furthermore,
gsm_control_retransmit() handles this number incorrectly by performing
N2 - 1 retransmission attempts. Setting N2 to zero results in more than 255
retransmission attempts.
Fix the range check in gsm_config() and the value handling in
gsm_control_send() and gsm_control_retransmit() to comply with 3GPP 27.010.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1430d7f83bd2..628bda5f0622 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1354,7 +1354,6 @@ static void gsm_control_retransmit(struct timer_list *t)
 	spin_lock_irqsave(&gsm->control_lock, flags);
 	ctrl = gsm->pending_cmd;
 	if (ctrl) {
-		gsm->cretries--;
 		if (gsm->cretries == 0) {
 			gsm->pending_cmd = NULL;
 			ctrl->error = -ETIMEDOUT;
@@ -1363,6 +1362,7 @@ static void gsm_control_retransmit(struct timer_list *t)
 			wake_up(&gsm->event);
 			return;
 		}
+		gsm->cretries--;
 		gsm_control_transmit(gsm, ctrl);
 		mod_timer(&gsm->t2_timer, jiffies + gsm->t2 * HZ / 100);
 	}
@@ -1403,7 +1403,7 @@ static struct gsm_control *gsm_control_send(struct gsm_mux *gsm,
 
 	/* If DLCI0 is in ADM mode skip retries, it won't respond */
 	if (gsm->dlci[0]->mode == DLCI_MODE_ADM)
-		gsm->cretries = 1;
+		gsm->cretries = 0;
 	else
 		gsm->cretries = gsm->n2;
 
@@ -2343,7 +2343,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	/* Check the MRU/MTU range looks sane */
 	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
 		return -EINVAL;
-	if (c->n2 < 3)
+	if (c->n2 > 255)
 		return -EINVAL;
 	if (c->encapsulation > 1)	/* Basic, advanced, no I */
 		return -EINVAL;
-- 
2.25.1

