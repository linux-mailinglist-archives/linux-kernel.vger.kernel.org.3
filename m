Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8D500A49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiDNJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiDNJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:41 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:44:00 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB3716C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:44:00 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220414094252b3c44950e05427b1f3
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qo+J4Lih8268JeqdwObz7YR4B/SLCefExJgGvrS1nSY=;
 b=jsHEiAIF2Jf6ldjL7SBTyTHT55mj4nYgv6c0+epwdy+uBGwb9KUizKzVG1KGiSJZZcx2q7
 uemSzfZw7idF4wiY2HiQgt2xYGgtcPtXPdzhuxi1/ei02mxHSQFJOk9RTEDjw/Dtbc91SCQ3
 9HqZDdg/aeWd/BrYVXjGyfEooWstE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 18/20] tty: n_gsm: fix implicit CR bit encoding in address field
Date:   Thu, 14 Apr 2022 02:42:23 -0700
Message-Id: <20220414094225.4527-18-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.2.1.2 describes the encoding of the
address field within the frame header. It is made up of the DLCI address,
command/response (CR) bit and EA bit.
Use the predefined CR value instead of a plain 2 in alignment to the
remaining code and to make the encoding obvious.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1e135a71860f..ecd2ecc61b14 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -754,7 +754,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
 	*--dp = msg->ctrl;
 	if (gsm->initiator)
-		*--dp = (msg->addr << 2) | 2 | EA;
+		*--dp = (msg->addr << 2) | CR | EA;
 	else
 		*--dp = (msg->addr << 2) | EA;
 	*fcs = gsm_fcs_add_block(INIT_FCS, dp , msg->data - dp);
-- 
2.25.1

