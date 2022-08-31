Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06205A8924
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiHaWkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiHaWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:40:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F48A1E3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:40:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h14so6761523ilh.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FNHBw9fAedMEvmueNQFIEpZu4DZG/pmo27+myDmJUYQ=;
        b=T4votMRvaQ5gheXuQ8nqesjK6N7/oipC1fShu8/sYxhIl1eT5ugqduWyPd6Xo+1/m1
         VuA+nHG6q86XBBw7yqRuZEmaynql9i2p8pH6a1wYyx9QGh0Svd5TB2xhmxBU812C8+zV
         ads0kaQW4PeB+o81cfvyjI8czR28khqo+ApnPCQR5kUCBathcxecfY7ABOaTIl4MHyAo
         qKSMdpe7K3dsxrusIH7NKSvPlBJdRGzhQrUccS7GkfaHg0GWyT9OYmG60RO687k0jBal
         Exo24UwsDrQKyOgdf8OphQmvr9O9W4eAQW2C9hJ10xhN3qiVrHWv0jjqhm96JPXc+pao
         pcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FNHBw9fAedMEvmueNQFIEpZu4DZG/pmo27+myDmJUYQ=;
        b=FuawCObxkiBHMWVGe/V9A1Z8Y3sxljjotLjww+5x88jRdkh4BHJ3er7b7I1nATJEBi
         rMPNHk6+D8DbNKeF0fSnbpkXikJ/KKF50tM3WFPnuszD+8w7JmLD/8gO8i+MYarW5rLU
         fDiftp6roDvs3CmgjiHNASEN6PZfDEz/9ZYTL6r7pJv4Jvqv+Mlf3VK1l4bYcvRC/JB/
         bwDQfA4yFyVLpbu6zMq9hnm1EA3+cWsjsyuhlxbzVkam4qqrCIgveDJsuQ6429ErlQkK
         toiR9n5UHjyVzMtHukdSX7Vp6Z3EVHNratcgPozdVhm8zUav0Io3yMTYSmiAKAH8I6O8
         Xktw==
X-Gm-Message-State: ACgBeo1EwzVrtt6ymIqTLc6u/HTwkNYauM8Oh/rXwzzzTFimDT7BSvUo
        BJfxHIdnbaYcXKSLUUVjUJzZOQ==
X-Google-Smtp-Source: AA6agR43T90S0/2mpnSBwJQNSAN7MM04L/zu9Nh52MTHPfKq+mm6Fc/rmuVLv10fg+Ehm7vPtiDGqA==
X-Received: by 2002:a05:6e02:1524:b0:2ec:71c6:7b85 with SMTP id i4-20020a056e02152400b002ec71c67b85mr1042342ilu.237.1661985624914;
        Wed, 31 Aug 2022 15:40:24 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n30-20020a02a19e000000b0034c0db05629sm1392005jah.161.2022.08.31.15.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:40:24 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: ipa: track committed transactions with an ID
Date:   Wed, 31 Aug 2022 17:40:14 -0500
Message-Id: <20220831224017.377745-4-elder@linaro.org>
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

Add a transaction ID field to track the first element in a channel's
transaction array that has been committed, but not yet passed to the
hardware.  Advance the ID when the hardware is notified via doorbell
that TREs from a transaction are ready for consumption.

Temporarily add warnings that verify that the first committed
transaction tracked by the ID matches the first element on the
committed list, both when committing and pending (at doorbell).

Remove the temporary warnings added by the previous commit.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.h       |  1 +
 drivers/net/ipa/gsi_trans.c | 45 +++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 6bbbda6f27eae..cc46a9119fc5b 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -85,6 +85,7 @@ struct gsi_trans_info {
 
 	u16 free_id;			/* first free trans in array */
 	u16 allocated_id;		/* first allocated transaction */
+	u16 committed_id;		/* first committed transaction */
 	struct gsi_trans *trans;	/* transaction array */
 	struct gsi_trans **map;		/* TRE -> transaction map */
 
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index d84400e13487f..72da795908fee 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -252,20 +252,17 @@ static void gsi_trans_move_committed(struct gsi_trans *trans)
 
 	list_move_tail(&trans->links, &trans_info->committed);
 
-	trans = list_first_entry_or_null(&trans_info->alloc,
-					 struct gsi_trans, links);
+	trans = list_first_entry(&trans_info->committed,
+				 struct gsi_trans, links);
 
 	spin_unlock_bh(&trans_info->spinlock);
 
 	/* This allocated transaction is now committed */
 	trans_info->allocated_id++;
 
-	if (trans) {
-		trans_index = trans_info->allocated_id % channel->tre_count;
-		WARN_ON(trans != &trans_info->trans[trans_index]);
-	} else {
-		WARN_ON(trans_info->allocated_id != trans_info->free_id);
-	}
+	WARN_ON(trans_info->committed_id == trans_info->allocated_id);
+	trans_index = trans_info->committed_id % channel->tre_count;
+	WARN_ON(trans != &trans_info->trans[trans_index]);
 }
 
 /* Move transactions from the committed list to the pending list */
@@ -273,7 +270,9 @@ static void gsi_trans_move_pending(struct gsi_trans *trans)
 {
 	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
 	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u16 trans_index = trans - &trans_info->trans[0];
 	struct list_head list;
+	u16 delta;
 
 	spin_lock_bh(&trans_info->spinlock);
 
@@ -281,7 +280,22 @@ static void gsi_trans_move_pending(struct gsi_trans *trans)
 	list_cut_position(&list, &trans_info->committed, &trans->links);
 	list_splice_tail(&list, &trans_info->pending);
 
+	trans = list_first_entry_or_null(&trans_info->committed,
+					 struct gsi_trans, links);
+
 	spin_unlock_bh(&trans_info->spinlock);
+
+	/* These committed transactions are now pending */
+	delta = trans_index - trans_info->committed_id + 1;
+	trans_info->committed_id += delta % channel->tre_count;
+
+	if (trans) {
+		trans_index = trans_info->committed_id % channel->tre_count;
+		WARN_ON(trans != &trans_info->trans[trans_index]);
+	} else {
+		WARN_ON(trans_info->committed_id !=
+			trans_info->allocated_id);
+	}
 }
 
 /* Move a transaction and all of its predecessors from the pending list
@@ -392,14 +406,8 @@ struct gsi_trans *gsi_channel_trans_alloc(struct gsi *gsi, u32 channel_id,
 
 	list_add_tail(&trans->links, &trans_info->alloc);
 
-	trans = list_first_entry(&trans_info->alloc, struct gsi_trans, links);
-
 	spin_unlock_bh(&trans_info->spinlock);
 
-	WARN_ON(trans_info->allocated_id == trans_info->free_id);
-	trans_index = trans_info->allocated_id % channel->tre_count;
-	WARN_ON(trans != &trans_info->trans[trans_index]);
-
 	return trans;
 }
 
@@ -428,11 +436,13 @@ void gsi_trans_free(struct gsi_trans *trans)
 	if (!last)
 		return;
 
-	/* Unused transactions are allocated but never committed */
-	if (!trans->used_count)
+	/* Unused transactions are allocated but never committed or pending */
+	if (!trans->used_count) {
 		trans_info->allocated_id++;
-	else
+		trans_info->committed_id++;
+	} else {
 		ipa_gsi_trans_release(trans);
+	}
 
 	/* Releasing the reserved TREs implicitly frees the sgl[] and
 	 * (if present) info[] arrays, plus the transaction itself.
@@ -769,6 +779,7 @@ int gsi_channel_trans_init(struct gsi *gsi, u32 channel_id)
 		return -ENOMEM;
 	trans_info->free_id = 0;	/* all modulo channel->tre_count */
 	trans_info->allocated_id = 0;
+	trans_info->committed_id = 0;
 
 	/* A completion event contains a pointer to the TRE that caused
 	 * the event (which will be the last one used by the transaction).
-- 
2.34.1

