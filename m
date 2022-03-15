Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7E4D9270
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbiCOCJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiCOCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:09:25 -0400
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57E13F42
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:08:09 -0700 (PDT)
Received: from excmbx-17.um.gwdg.de ([134.76.9.228] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <alexander.vorwerk@stud.uni-goettingen.de>)
        id 1nTwbX-000Co3-PR; Tue, 15 Mar 2022 03:08:07 +0100
Received: from notebook.fritz.box (10.250.9.199) by excmbx-17.um.gwdg.de
 (134.76.9.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2375.24; Tue, 15
 Mar 2022 03:08:07 +0100
From:   Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Subject: [PATCH] tty: serial: jsm: fix two assignments in if conditions
Date:   Tue, 15 Mar 2022 03:07:45 +0100
Message-ID: <20220315020745.15752-1-alexander.vorwerk@stud.uni-goettingen.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: excmbx-11.um.gwdg.de (134.76.9.220) To excmbx-17.um.gwdg.de
 (134.76.9.228)
X-Virus-Scanned: (clean) by clamav
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes two warnings reported of the form
"ERROR: do not use assignment in if condition"
reported by checkpatch.pl.

Signed-off-by: Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
---
 drivers/tty/serial/jsm/jsm_neo.c | 3 ++-
 drivers/tty/serial/jsm/jsm_tty.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index c6f927a76c3b..29158be88027 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -291,7 +291,8 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 	ch->ch_cached_lsr = 0;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = tail - head - 1) < 0)
+	qleft = tail - head - 1;
+	if (qleft < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index d74cbbbf33c6..cb58bdec2f43 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -749,7 +749,8 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	int qleft;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+	qleft = ch->ch_r_tail - ch->ch_r_head - 1;
+	if (qleft < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
-- 
2.17.1

