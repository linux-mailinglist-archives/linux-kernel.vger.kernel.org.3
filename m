Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063254CF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351200AbiFOQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350013AbiFOQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A742E9E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so2685941pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpIVO5Kfmx2LoU227Q0lbW/FLezMOp+ICqcp8J2B6FI=;
        b=MZpYEqAM/KX+Nu/O0mwQPCl2GJDQG3BQQBIWo9GaDMMfvVfCJGL0yTeCPiq6izrFor
         CLalTVjKv5Om+Cux+Qz7lkVbo11fce/QEbQgl6yrV3kM9xpUTvIC97MEWVhPJNmkx4ek
         kYzMko73AHKQlsafOON8jgXe47eiuTBrgT2N+lLMWYzOg6QvB/nJeo/zuZNlti9vCp8O
         TasXSMtCNQppiXD8b+sRBIKGg5m8MhLLlDxeN113kjn8sb4bcyfWdYmIG4Yh5wzG+3mZ
         vqrsHrJNvdQSYy/7vLm+m89jH3MfBWZKrbtU0WA3P4YNxenrKmwd4KLX6X/unKSD4LQr
         VTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpIVO5Kfmx2LoU227Q0lbW/FLezMOp+ICqcp8J2B6FI=;
        b=MISzEd39DBvh7VzToOks8qOu3pFErR+8Ny87xV7eYlYHblAXycOI4czTLtv24h8TLh
         BJYffMlWpP0FGOO1DpRB95iYaYc3PX3I9pxVqWIuyVeMaasO/EL6cvT9Om4+Lbb3yIor
         9CQ+Zm31FYgFa+/EDrGhyczs4TSAeTS2MKaTm5fr4XQ99bW79nvVI20tOuNhUAJn5i2G
         sgbp1LD4kT1ps1aUVIOpk5aZd4L/jJP+NZ4pAYl4AHiKcPBHzJdnURnidDYkhT2VZqrY
         Fh+8TDbBf5Mgf+GbKVXF8XsoVqnYqOQKlMeWJqfGuqRqEpq9J7hcB0JrDP/fGQ1HsKBs
         NHkg==
X-Gm-Message-State: AJIora9NIl2UmBj8+e5LUZunhohDSvc9VEIk62/PasFa4hHSmeut4289
        6kQ+J+xo2C0ooeDFIYGqq9st+Q==
X-Google-Smtp-Source: AGRyM1ufbWyrUR7cMW1ED5blXTBvzX2GdcvoY3l2cczUqBWYxE8jz8arVAs7v/PQtOd+NX0fEFbhxQ==
X-Received: by 2002:a17:902:f541:b0:163:f64a:6127 with SMTP id h1-20020a170902f54100b00163f64a6127mr596561plf.134.1655312374000;
        Wed, 15 Jun 2022 09:59:34 -0700 (PDT)
Received: from localhost.localdomain ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b003fd1111d73csm10618513pgc.4.2022.06.15.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:59:33 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: don't assume one channel per event ring
Date:   Wed, 15 Jun 2022 11:59:25 -0500
Message-Id: <20220615165929.5924-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615165929.5924-1-elder@linaro.org>
References: <20220615165929.5924-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_evt_ring_rx_update(), use gsi_event_trans() repeatedly
to find the transaction associated with an event, rather than
assuming consecutive events are associated with the same channel.
This removes the only caller of gsi_trans_pool_next(), so get rid
of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c         | 14 ++++++--------
 drivers/net/ipa/gsi_private.h |  3 ---
 drivers/net/ipa/gsi_trans.c   | 16 ----------------
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index df8af1f00fc8b..0e9064c043adf 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1366,15 +1366,11 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 {
 	struct gsi_channel *channel = evt_ring->channel;
 	struct gsi_ring *ring = &evt_ring->ring;
-	struct gsi_trans_info *trans_info;
 	struct gsi_event *event_done;
 	struct gsi_event *event;
-	struct gsi_trans *trans;
 	u32 event_avail;
 	u32 old_index;
 
-	trans_info = &channel->trans_info;
-
 	/* We'll start with the oldest un-processed event.  RX channels
 	 * replenish receive buffers in single-TRE transactions, so we
 	 * can just map that event to its transaction.  Transactions
@@ -1382,9 +1378,6 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 	 */
 	old_index = ring->index;
 	event = gsi_ring_virt(ring, old_index);
-	trans = gsi_event_trans(channel->gsi, event);
-	if (!trans)
-		return;
 
 	/* Compute the number of events to process before we wrap,
 	 * and determine when we'll be done processing events.
@@ -1392,6 +1385,12 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 	event_avail = ring->count - old_index % ring->count;
 	event_done = gsi_ring_virt(ring, index);
 	do {
+		struct gsi_trans *trans;
+
+		trans = gsi_event_trans(channel->gsi, event);
+		if (!trans)
+			return;
+
 		trans->len = __le16_to_cpu(event->len);
 
 		/* Move on to the next event and transaction */
@@ -1399,7 +1398,6 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 			event++;
 		else
 			event = gsi_ring_virt(ring, 0);
-		trans = gsi_trans_pool_next(&trans_info->pool, trans);
 	} while (event != event_done);
 }
 
diff --git a/drivers/net/ipa/gsi_private.h b/drivers/net/ipa/gsi_private.h
index 74cbc287fc715..0b2516fa21b5d 100644
--- a/drivers/net/ipa/gsi_private.h
+++ b/drivers/net/ipa/gsi_private.h
@@ -16,9 +16,6 @@ struct gsi_channel;
 
 #define GSI_RING_ELEMENT_SIZE	16	/* bytes; must be a power of 2 */
 
-/* Return the entry that follows one provided in a transaction pool */
-void *gsi_trans_pool_next(struct gsi_trans_pool *pool, void *element);
-
 /**
  * gsi_trans_move_complete() - Mark a GSI transaction completed
  * @trans:	Transaction to commit
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index a110be72f70b6..54a2400cb560e 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -214,22 +214,6 @@ void *gsi_trans_pool_alloc_dma(struct gsi_trans_pool *pool, dma_addr_t *addr)
 	return pool->base + offset;
 }
 
-/* Return the pool element that immediately follows the one given.
- * This only works done if elements are allocated one at a time.
- */
-void *gsi_trans_pool_next(struct gsi_trans_pool *pool, void *element)
-{
-	void *end = pool->base + pool->count * pool->size;
-
-	WARN_ON(element < pool->base);
-	WARN_ON(element >= end);
-	WARN_ON(pool->max_alloc != 1);
-
-	element += pool->size;
-
-	return element < end ? element : pool->base;
-}
-
 /* Map a given ring entry index to the transaction associated with it */
 static void gsi_channel_trans_map(struct gsi_channel *channel, u32 index,
 				  struct gsi_trans *trans)
-- 
2.34.1

