Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743E57BD88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiGTSOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiGTSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:14:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC165D4A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:14:07 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EECyoUSDFoEdDEECyo6cT8; Wed, 20 Jul 2022 20:14:05 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 20:14:05 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] scsi: hpsa: Simplify {clear|set}_bit() parameters
Date:   Wed, 20 Jul 2022 20:14:02 +0200
Message-Id: <c3429a22023f58e5e5cc65d6cd7e83fb2bd9b870.1658340442.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
References: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

{clear|set}_bit() can take an almost arbitrarily large bit number, so there
is no need to manually compute addresses. This is just redundant.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/hpsa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 0612ca681200..f8e832b1bc46 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6233,8 +6233,7 @@ static struct CommandList *cmd_alloc(struct ctlr_info *h)
 			offset = (i + 1) % HPSA_NRESERVED_CMDS;
 			continue;
 		}
-		set_bit(i & (BITS_PER_LONG - 1),
-			h->cmd_pool_bits + (i / BITS_PER_LONG));
+		set_bit(i, h->cmd_pool_bits);
 		break; /* it's ours now. */
 	}
 	hpsa_cmd_partial_init(h, i, c);
@@ -6261,8 +6260,7 @@ static void cmd_free(struct ctlr_info *h, struct CommandList *c)
 		int i;
 
 		i = c - h->cmd_pool;
-		clear_bit(i & (BITS_PER_LONG - 1),
-			  h->cmd_pool_bits + (i / BITS_PER_LONG));
+		clear_bit(i, h->cmd_pool_bits);
 	}
 }
 
-- 
2.34.1

