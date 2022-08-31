Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C495A8917
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiHaWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiHaWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:40:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C983F7B7AA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:40:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v15so5673595iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fKArLUzw6N+hE15V3rYIaHqoaxWoXFuO2t1gN8Zf76U=;
        b=fuP6aMIo/eSsHxECmDrj8dMXLYW1bCtFFRZmMCDqJlDZZuK/ouJoz/Kx4By5cYz7ta
         8W0UwX9UJxa3AtwjFAbHBiE8MisBCZ4lbhBJsjpqONb1+LZJYwvn+rzxSu09JpYZTztK
         B1teChK0WYsFNWmDYNnesQwbwaSGfFLXeiNjvGKZXiU55tyZ+p9GBw1bliUZkEfCd6F5
         6PX45drEUFYci05j13wXWjAUCuxbL+UUHUBy6d7axzVV9BoMgbGINqzPBSFS2Qb9N4zP
         rcCE57D5usnJb3zvv83R5f5zFnZnFkOWsAmmei1OsKZ0i6iv7WUPNJ+X/hVLqmG4KppL
         nK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fKArLUzw6N+hE15V3rYIaHqoaxWoXFuO2t1gN8Zf76U=;
        b=AzdpKSbctAjv9GFTufP+AQoRF7/AiMpaDsPFVvy3PH5qshZfr+k5d9pZU4CYK3P9D7
         OC2lwvK2SR2cfrtFy1VH6VmX8Lil51Q8oTKya0k9DVOpC8Fr1yqMwf3wxZ90ylSZjHh5
         Iuo5F91Ugp7USg1J/fwI63sQr1Fr/TmS+OWkrOo6hj8mk4XOsVJ697Q3wK05XtyMKw9C
         lfpRKQ+hyYpIS90S/cQoggLUMEGBABl0re2L7W5uPD/YtWNUvS6BMMK5m6/GwGY98NIY
         ClaiujNL6N8GK/LcdOTjwLq9ve/LR8sDsFChZhNibnGcuIrOVgU2KHXlRz1GvsyDBIMv
         icvQ==
X-Gm-Message-State: ACgBeo3ykmQdJ1fbY8yTkANipBwzO00Uy5jQtYU0dsWpt3s+KIQumDDs
        66IK164/8WfNmL5uNv26EEAN3w==
X-Google-Smtp-Source: AA6agR6hTYnDxOtkcXvoqmtwe1dB5WhE5hOJx5s9+QGIdkCVOefooukqHqvJlK2PDdPev3LmrCw38w==
X-Received: by 2002:a92:2a0a:0:b0:2d9:2571:f57e with SMTP id r10-20020a922a0a000000b002d92571f57emr15255617ile.154.1661985625908;
        Wed, 31 Aug 2022 15:40:25 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n30-20020a02a19e000000b0034c0db05629sm1392005jah.161.2022.08.31.15.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:40:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: ipa: track pending transactions with an ID
Date:   Wed, 31 Aug 2022 17:40:15 -0500
Message-Id: <20220831224017.377745-5-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831224017.377745-1-elder@linaro.org>
References: <20220831224017.377745-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a transaction ID field to track the first element in the
transaction array that is pending (sent to hardware) but not yet
complete.  Advance the ID when a completion event for a channel
indicates that transactions have completed.

Temporarily add warnings that verify that the first pending
transaction tracked by the ID matches the first element on the
pending list, both when pending and completing, as well as when
resetting the channel.

Remove the temporary warnings added by the previous commit.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.h       |  1 +
 drivers/net/ipa/gsi_trans.c | 46 ++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index cc46a9119fc5b..f23e7e562585e 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -86,6 +86,7 @@ struct gsi_trans_info {
 	u16 free_id;			/* first free trans in array */
 	u16 allocated_id;		/* first allocated transaction */
 	u16 committed_id;		/* first committed transaction */
+	u16 pending_id;			/* first pending transaction */
 	struct gsi_trans *trans;	/* transaction array */
 	struct gsi_trans **map;		/* TRE -> transaction map */
 
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 72da795908fee..5e3b4f673d9fb 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -246,23 +246,15 @@ static void gsi_trans_move_committed(struct gsi_trans *trans)
 {
 	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
 	struct gsi_trans_info *trans_info = &channel->trans_info;
-	u16 trans_index;
 
 	spin_lock_bh(&trans_info->spinlock);
 
 	list_move_tail(&trans->links, &trans_info->committed);
 
-	trans = list_first_entry(&trans_info->committed,
-				 struct gsi_trans, links);
-
 	spin_unlock_bh(&trans_info->spinlock);
 
 	/* This allocated transaction is now committed */
 	trans_info->allocated_id++;
-
-	WARN_ON(trans_info->committed_id == trans_info->allocated_id);
-	trans_index = trans_info->committed_id % channel->tre_count;
-	WARN_ON(trans != &trans_info->trans[trans_index]);
 }
 
 /* Move transactions from the committed list to the pending list */
@@ -280,8 +272,8 @@ static void gsi_trans_move_pending(struct gsi_trans *trans)
 	list_cut_position(&list, &trans_info->committed, &trans->links);
 	list_splice_tail(&list, &trans_info->pending);
 
-	trans = list_first_entry_or_null(&trans_info->committed,
-					 struct gsi_trans, links);
+	trans = list_first_entry(&trans_info->pending,
+				 struct gsi_trans, links);
 
 	spin_unlock_bh(&trans_info->spinlock);
 
@@ -289,13 +281,9 @@ static void gsi_trans_move_pending(struct gsi_trans *trans)
 	delta = trans_index - trans_info->committed_id + 1;
 	trans_info->committed_id += delta % channel->tre_count;
 
-	if (trans) {
-		trans_index = trans_info->committed_id % channel->tre_count;
-		WARN_ON(trans != &trans_info->trans[trans_index]);
-	} else {
-		WARN_ON(trans_info->committed_id !=
-			trans_info->allocated_id);
-	}
+	WARN_ON(trans_info->pending_id == trans_info->committed_id);
+	trans_index = trans_info->pending_id % channel->tre_count;
+	WARN_ON(trans != &trans_info->trans[trans_index]);
 }
 
 /* Move a transaction and all of its predecessors from the pending list
@@ -305,7 +293,9 @@ void gsi_trans_move_complete(struct gsi_trans *trans)
 {
 	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
 	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u16 trans_index = trans - trans_info->trans;
 	struct list_head list;
+	u16 delta;
 
 	spin_lock_bh(&trans_info->spinlock);
 
@@ -313,7 +303,23 @@ void gsi_trans_move_complete(struct gsi_trans *trans)
 	list_cut_position(&list, &trans_info->pending, &trans->links);
 	list_splice_tail(&list, &trans_info->complete);
 
+	trans = list_first_entry_or_null(&trans_info->pending,
+					 struct gsi_trans, links);
+
 	spin_unlock_bh(&trans_info->spinlock);
+
+	/* These pending transactions are now completed */
+	delta = trans_index - trans_info->pending_id + 1;
+	delta %= channel->tre_count;
+	trans_info->pending_id += delta;
+
+	if (trans) {
+		trans_index = trans_info->pending_id % channel->tre_count;
+		WARN_ON(trans != &trans_info->trans[trans_index]);
+	} else {
+		WARN_ON(trans_info->pending_id !=
+			trans_info->committed_id);
+	}
 }
 
 /* Move a transaction from the completed list to the polled list */
@@ -436,10 +442,13 @@ void gsi_trans_free(struct gsi_trans *trans)
 	if (!last)
 		return;
 
-	/* Unused transactions are allocated but never committed or pending */
+	/* Unused transactions are allocated but never committed, pending,
+	 * or completed.
+	 */
 	if (!trans->used_count) {
 		trans_info->allocated_id++;
 		trans_info->committed_id++;
+		trans_info->pending_id++;
 	} else {
 		ipa_gsi_trans_release(trans);
 	}
@@ -780,6 +789,7 @@ int gsi_channel_trans_init(struct gsi *gsi, u32 channel_id)
 	trans_info->free_id = 0;	/* all modulo channel->tre_count */
 	trans_info->allocated_id = 0;
 	trans_info->committed_id = 0;
+	trans_info->pending_id = 0;
 
 	/* A completion event contains a pointer to the TRE that caused
 	 * the event (which will be the last one used by the transaction).
-- 
2.34.1

