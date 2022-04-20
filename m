Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A3508599
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377581AbiDTKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377526AbiDTKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:17:53 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 03:15:06 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073795FAC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:15:05 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022042010140175f691674f7a4a6724
        for <linux-kernel@vger.kernel.org>;
        Wed, 20 Apr 2022 12:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w+mbL/67Hch5JUwEcTboXqb1l8rminXIVsrzq7Luffo=;
 b=Krsx5rnRuD4AR43fkbyB1prXGvQAjNyAVzM+oGDcml/1YXLY0bMF3Hh7NyRCuRSdxObq/G
 BNbJBngBQxCXbCQbfFotYkXk83isu4h3UqosezrfPuJpTBXOE+BmGI+O2fz2nifVqlHlSU1n
 1SkHcDw+IzRea+yZhwX1D1+jO7tHI=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 2/3] tty: n_gsm: clean up dead code in gsm_queue()
Date:   Wed, 20 Apr 2022 03:13:45 -0700
Message-Id: <20220420101346.3315-2-daniel.starke@siemens.com>
In-Reply-To: <20220420101346.3315-1-daniel.starke@siemens.com>
References: <20220420101346.3315-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Remove commented out code as it is never used and if anyone accidentally
turned it on, it would be broken.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ----
 1 file changed, 4 deletions(-)

The commit title and message was adjusted as recommended in the remarks for
the original patch. This is only a cleanup now and not a fix. The remark
for backporting was also removed. The code change remains as it was
originally.
This is version 3 of the patch because the second version was missing the
change remarks.

Link: https://lore.kernel.org/all/YlkRO6fAPCuWyT1Y@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 07d03447cdfd..1b4077006744 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1894,10 +1894,6 @@ static void gsm_queue(struct gsm_mux *gsm)
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

