Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B85A77B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiHaHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiHaHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:40:36 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 00:40:32 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C365B69F3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:40:28 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220831073924be6e54522e0d4eb31d
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nGvVUAIr6EVotI+lAvFGhAT1Y/xk9oR6QAFXkdDhLEw=;
 b=oZui0olsoyaKWY7sY/5bHi3zMsJicM6TzSPdIdIm3NgxLhoz8IU8gqcWDcHqtBzxpyKIQw
 ljw95J1G0F30ZF1feFaean/JYoLMtO3+D90EnCxSDV53kptic3fUOcb3DwpKyWynp9q6npC9
 u5FgaM+l7xBh+cqAva+9x280PeFYo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 6/6] tty: n_gsm: add debug bit for user payload
Date:   Wed, 31 Aug 2022 09:38:00 +0200
Message-Id: <20220831073800.7459-6-daniel.starke@siemens.com>
In-Reply-To: <20220831073800.7459-1-daniel.starke@siemens.com>
References: <20220831073800.7459-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Incorporated review comments from Jiri Slaby since v2:
- changed (1 << n) to BIT(n) in the debug macro definitions

Link: https://lore.kernel.org/all/1d8d0d72-a5b7-724e-a70a-71d9fd3330c4@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f8a8c4059907..6588b84eed96 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -69,6 +69,7 @@ module_param(debug, int, 0600);
 #define DBG_DATA	BIT(2) /* Data transmission details. */
 #define DBG_ERRORS	BIT(3) /* Details for fail conditions. */
 #define DBG_TTY		BIT(4) /* Transmission statistics for DLCI TTYs. */
+#define DBG_PAYLOAD	BIT(5) /* Limits DBG_DUMP to payload frames. */
 
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

