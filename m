Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A5D59D142
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiHWGZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbiHWGZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:25:13 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:25:12 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C765060524
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:25:12 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202208230624079cde02a96a41454f16
        for <linux-kernel@vger.kernel.org>;
        Tue, 23 Aug 2022 08:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yrhprMDTlGL4plZ3xVQSKewwsGW84oYrlZ/o+UkYd40=;
 b=T66vzWwTQYCS/dpWOxW1+UKUvi2PHm9vChyFSVHBhw8LKY76bcJ2zRaRSmLVQUGiiNFpVN
 xX0ipuwSOIhDZC2CjXRfVwhVzO33WOVlWlBKM+nt9+taN5K6vuzUBdPRiO/JCFlK0nwHCs5E
 iiBuWZ7CsaI6mt4zLIPg65OCWES0c=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 6/6] tty: n_gsm: add debug bit for user payload
Date:   Tue, 23 Aug 2022 08:22:59 +0200
Message-Id: <20220823062259.4754-6-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

A debug bit to output a complete transmission dump exists. Sometimes only
the user frames are relevant. Add an additional bit which limits the
transmission dump output to user data frames if set.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 +++++
 1 file changed, 5 insertions(+)

No changes since v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fcf2d52d5095..f3f0668f0a73 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -69,6 +69,7 @@ module_param(debug, int, 0600);
 #define DBG_DATA	(1 << 2) /* Data transmission details. */
 #define DBG_ERRORS	(1 << 3) /* Details for fail conditions. */
 #define DBG_TTY		(1 << 4) /* Transmission statistics for DLCI TTYs. */
+#define DBG_PAYLOAD	(1 << 5) /* Limits DBG_DUMP to payload frames. */
 
 /* Defaults: these are from the specification */
 
@@ -598,6 +599,10 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 {
 	if (!(debug & DBG_DUMP))
 		return;
+	/* Only show user payload frames if debug & DBG_PAYLOAD */
+	if (!(debug & DBG_PAYLOAD) && addr != 0)
+		if ((control & ~PF) == UI || (control & ~PF) == UIH)
+			return;
 
 	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
 
-- 
2.34.1

