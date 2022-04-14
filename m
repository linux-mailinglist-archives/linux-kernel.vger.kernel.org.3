Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D86500A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiDNJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241937AbiDNJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:25 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:59 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817A710E5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:59 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20220414094251ea916a4daebbd414ec
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f8uJbWHJFFD5H0nRQNzeyT23Inb68+j9oWEKy5+IUAY=;
 b=I7mzNPmzozsry4MOVnZMkFyf/U1JZ+6d22EcGOGGD4o8THOXWnESldSxfpZFOj65/fPmG7
 g4Vo/dhpiTsyWZmEqDBahJpHfawG4L8SfICfbgC0CmHmpAM2RApmqrduULSlxQO5PIthYGKD
 /ojEZdEyMuYitAbJEhQG8AzwSCLao=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 16/20] tty: n_gsm: fix invalid command/response bit check for UI/UIH frames
Date:   Thu, 14 Apr 2022 02:42:21 -0700
Message-Id: <20220414094225.4527-16-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.4.3.1 states the CR bit in UI and UIH
frames shall always be set 1 by the initiator and 0 by the responder.
Currently, gsm_queue() has a pre-processor gated (excluded) check which
treats all frames that conform to the standard as malformed frames.
Remove this optional code to avoid confusion and possible breaking changes
in case that someone includes it.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e9a7d9483c1f..f4ec48c0d6d7 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1896,10 +1896,6 @@ static void gsm_queue(struct gsm_mux *gsm)
 	case UI|PF:
 	case UIH:
 	case UIH|PF:
-#if 0
-		if (cr)
-			goto invalid;
-#endif
 		if (dlci == NULL || dlci->state != DLCI_OPEN) {
 			gsm_command(gsm, address, DM|PF);
 			return;
-- 
2.25.1

