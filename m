Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA24CC539
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCCSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCCSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:31:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE219531E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:30:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i8so9163584wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuvsRmPDO09MSdIx8vAMU7t/nouGoOL2ZN/qMXFh58k=;
        b=Hbf9/wv68kwaXVkEegngQEUKQcm15yC0u8RRemH1z2Je1e/9MSAYBVn3/mq+K5WMxj
         MzKfwbDa3OVKPhWmu+DbRf1V+riL7bCIvJ2P8FxY0vNnsAW0vCqYM0YjZDiG4O8+HzEs
         5oFEYInfrbPvvxV8YXK6O3AJB7wPU5EseqjEAzCKaECCIz+5lS3VmZ1tCY6V89G0I5pl
         JI7ZzF5mPZjAqfBPTwiZRl/NbXQT1LWLR3T3ZI0yQRwpRORykRFJ+imEDMlO6Mg4tRHC
         O7Si/cLTvvYao7JIPymPX0BYhh2ksxvTqDPaunldyFYpmF/0fXPSvNtfOoMgETtBZuuA
         vLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuvsRmPDO09MSdIx8vAMU7t/nouGoOL2ZN/qMXFh58k=;
        b=V3OHMaOnZ+G8StL8L4ZIsN3OscxG/qiRkSFEr+khjQo6IBtJQe3QZ22fCpRmvfFpbw
         Gg2oRsqLl2hL/NNQ54Q/twwLpzr6TrqX/MTUZJcQWZHK291qLCdz8E791HBANxBwymrJ
         0HdmGgjtP3wDuYH2zhEJTqme91/81iRo3mI/Avj3/3vse5vLv8+NLfkXMGEBe7e6uVz7
         oSFBxc5lbU4GyYP0svo94s5AOTu/RKHqkxgxWIntoDFGNcbEO8C7dPXwx/vTUV7JIGM4
         rBii3MWVfzoMPedJB8GGWFh2A0J/emcFBHk8e9aG5FYcaFuBjjqyDtvHE2eXwYAU8bSR
         mkiQ==
X-Gm-Message-State: AOAM530z7/65OH86xel57Q/caVwpasyHJ07CUpXD2BSNuNfHMSWEFNyJ
        AmlCQKwOL5vWFM6ddRal6CY=
X-Google-Smtp-Source: ABdhPJy+wIvczzoar5JaRhmBzxewnGNYTLuTAQtAEKn24qO5eQsokznO6HaqjVW7QU2RNoDvRBlXYQ==
X-Received: by 2002:adf:ed12:0:b0:1ef:585d:bfcd with SMTP id a18-20020adfed12000000b001ef585dbfcdmr25109218wro.570.1646332254959;
        Thu, 03 Mar 2022 10:30:54 -0800 (PST)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id x11-20020adfdccb000000b001e57922b8b6sm2639047wrm.43.2022.03.03.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:30:54 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] firewire: core: extend card->lock in fw_core_handle_bus_reset
Date:   Thu,  3 Mar 2022 19:30:38 +0100
Message-Id: <20220303183038.54126-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

card->local_node and card->bm_retries are both always accessed under
card->lock.
fw_core_handle_bus_reset has a check whose condition depends on
card->local_node and whose body writes to card->bm_retries.
Both of these accesses are not under card->lock. Move the lock acquiring
of card->lock to before this check such that these accesses do happen
when card->lock is held.
fw_destroy_nodes is called inside the check.
Since fw_destroy_nodes already acquires card->lock inside its function
body, move this out to the callsites of fw_destroy_nodes.
Also add a comment to indicate which locking is necessary when calling
fw_destroy_nodes.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/firewire/core-card.c     | 3 +++
 drivers/firewire/core-topology.c | 9 +++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 54be88167c60..f3b3953cac83 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -668,6 +668,7 @@ EXPORT_SYMBOL_GPL(fw_card_release);
 void fw_core_remove_card(struct fw_card *card)
 {
 	struct fw_card_driver dummy_driver = dummy_driver_template;
+	unsigned long flags;
 
 	card->driver->update_phy_reg(card, 4,
 				     PHY_LINK_ACTIVE | PHY_CONTENDER, 0);
@@ -682,7 +683,9 @@ void fw_core_remove_card(struct fw_card *card)
 	dummy_driver.stop_iso		= card->driver->stop_iso;
 	card->driver = &dummy_driver;
 
+	spin_lock_irqsave(&card->lock, flags);
 	fw_destroy_nodes(card);
+	spin_unlock_irqrestore(&card->lock, flags);
 
 	/* Wait for all users, especially device workqueue jobs, to finish. */
 	fw_card_put(card);
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index b63d55f5ebd3..f40c81534381 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -375,16 +375,13 @@ static void report_found_node(struct fw_card *card,
 	card->bm_retries = 0;
 }
 
+/* Must be called with card->lock held */
 void fw_destroy_nodes(struct fw_card *card)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&card->lock, flags);
 	card->color++;
 	if (card->local_node != NULL)
 		for_each_fw_node(card, card->local_node, report_lost_node);
 	card->local_node = NULL;
-	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static void move_tree(struct fw_node *node0, struct fw_node *node1, int port)
@@ -510,6 +507,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	struct fw_node *local_node;
 	unsigned long flags;
 
+	spin_lock_irqsave(&card->lock, flags);
+
 	/*
 	 * If the selfID buffer is not the immediate successor of the
 	 * previously processed one, we cannot reliably compare the
@@ -521,8 +520,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		card->bm_retries = 0;
 	}
 
-	spin_lock_irqsave(&card->lock, flags);
-
 	card->broadcast_channel_allocated = card->broadcast_channel_auto_allocated;
 	card->node_id = node_id;
 	/*
-- 
2.35.1

