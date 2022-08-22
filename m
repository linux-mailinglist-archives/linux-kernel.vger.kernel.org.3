Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E759BA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiHVHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHVHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:24:13 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 00:24:09 PDT
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEC29CA7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:24:09 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2022082207230529ca8eb2d3c3701ff6
        for <linux-kernel@vger.kernel.org>;
        Mon, 22 Aug 2022 09:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kG+0qXXrDijXLAMNyyyKqvB26/6HqiXhBVma8IBGVuM=;
 b=RaoNLvrvpsgFs4obdqCMDL5oIMeVq7vmkAuILqAPSqKuHaAR4RHrXCH1+xhnKP2qZHxV5u
 GqNdbblhsfdvBuh9MhKIBYlPJqEsrDwqlwV0vhfwbV7xd4iw1iNWTuE3vJNN1sMb7rKhHGVw
 z0Xre7ZjrGS35t+m93dJynosanSdY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 6/6] tty: n_gsm: add debug bit for user payload
Date:   Mon, 22 Aug 2022 09:21:38 +0200
Message-Id: <20220822072138.3123-6-daniel.starke@siemens.com>
In-Reply-To: <20220822072138.3123-1-daniel.starke@siemens.com>
References: <20220822072138.3123-1-daniel.starke@siemens.com>
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

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e8f10a5f0a8a..676034fb1190 100644
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

