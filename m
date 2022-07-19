Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1657A1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiGSOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiGSOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:39:59 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9054AD2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:35:58 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l11so5592391ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzUp16TsQa3JipHhgAlv6J/Xx8dlsb3ilhBhSisObpk=;
        b=NHP7zdBWXkjeJbTso42Mfy3WczpsvYvgt2g0BtRjbaDuzK7gAp4tTNO/KfRwMLHfXK
         oCWc/97TA933XwvT7jeL6qgY3jVrsbnWtwQilJtx2FFR4vJrqmBgyOf5xj0xat6dmoMn
         47JTIS9l9YAMm4WnJVH1Qm9Ko8UspQ4/+hH1uy6AjeDP5wi/dCPzK05Ix/UQAQBPGHnd
         vfqXnx1pERL3UZRnuoQCPHCpZlabG56bJMCfbpPze9Kw6XnPZ5lcGs/NrSCM28buLEKL
         KDJgHgbvywytGVtRxMos3k+Mr2aTOLqQBLz9PYVQVCd+tly+rr8z/rGqYnzRXZH3+KhV
         8qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzUp16TsQa3JipHhgAlv6J/Xx8dlsb3ilhBhSisObpk=;
        b=iLSbrcOvT8UU2ywUyD/jevUvmZCSxzMPyrZioTXCa5oF80eAnlUAFb5JfEqX1u/vtB
         V+oaN4e1130K3dr6b8u+kUQDtdQuDlfjyObN1EsneQnKMYVeonhDCaNL/01LRFnr+Yzq
         xmY3wLoP9JTwg3v0bQRcam1IQ6SwCMr2pijgV3PA8r/CeVXJM/aWKG1zSOBlqWaN6eSP
         YnyAZyyAQPOMPhJlIFRz2fE+6arpCVoYwv9o6MWh0+SRl40AwJt8sNl3jMi7KAEFb/CZ
         NjVqjRwnVYjFRwxWUoQqeJQbKMT4AFcdTrN1RC5nq8MH5irPz+pIpE8EvSNbQOPe6F9N
         4xBA==
X-Gm-Message-State: AJIora/grdSwiLouyhy8dA/Xstz8396OlNSoPbaHVxfhafJ1eOU0fm2/
        Pu9DPOjk/xB49y5pH0azGSz87A==
X-Google-Smtp-Source: AGRyM1tEqutqSPSRY0g9Km97DNuoMzKB13fGREF6wrXyd+UMVywqUlXmZ3GUf5fudnDZ8+Y3cIJ5hg==
X-Received: by 2002:a05:6e02:1bad:b0:2da:d6d0:a58 with SMTP id n13-20020a056e021bad00b002dad6d00a58mr16080808ili.19.1658241358253;
        Tue, 19 Jul 2022 07:35:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t16-20020a056602141000b00675a83bc1e3sm7286559iov.13.2022.07.19.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:35:57 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: add a transaction committed list
Date:   Tue, 19 Jul 2022 09:35:49 -0500
Message-Id: <20220719143553.280908-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719143553.280908-1-elder@linaro.org>
References: <20220719143553.280908-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently put a transaction on the pending list when it has
been committed.  But until the channel's doorbell rings, these
transactions aren't actually "owned" by the hardware yet.

Add a new "committed" state (and list), to represent transactions
that have been committed but not yet sent to hardware.  Define
"pending" to mean committed transactions that have been sent
to hardware but have not yet completed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c       |  5 ++++-
 drivers/net/ipa/gsi.h       |  3 ++-
 drivers/net/ipa/gsi_trans.c | 24 +++++++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 4e46974a69ecd..c70fd4bab1d68 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -718,6 +718,9 @@ static struct gsi_trans *gsi_channel_trans_last(struct gsi_channel *channel)
 	 */
 	if (channel->toward_ipa) {
 		list = &trans_info->alloc;
+		if (!list_empty(list))
+			goto done;
+		list = &trans_info->committed;
 		if (!list_empty(list))
 			goto done;
 		list = &trans_info->pending;
@@ -1363,7 +1366,7 @@ gsi_event_trans(struct gsi *gsi, struct gsi_event *event)
  * first *unfilled* event in the ring (following the last filled one).
  *
  * Events are sequential within the event ring, and transactions are
- * sequential within the transaction pool.
+ * sequential within the transaction array.
  *
  * Note that @index always refers to an element *within* the event ring.
  */
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index bad1a78a96ede..d06fc46431d5b 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -88,7 +88,8 @@ struct gsi_trans_info {
 
 	spinlock_t spinlock;		/* protects updates to the lists */
 	struct list_head alloc;		/* allocated, not committed */
-	struct list_head pending;	/* committed, awaiting completion */
+	struct list_head committed;	/* committed, awaiting doorbell */
+	struct list_head pending;	/* pending, awaiting completion */
 	struct list_head complete;	/* completed, awaiting poll */
 	struct list_head polled;	/* returned by gsi_channel_poll_one() */
 };
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 29496ca15825f..1db7497a64745 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -241,15 +241,31 @@ struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
 					struct gsi_trans, links);
 }
 
-/* Move a transaction from the allocated list to the pending list */
+/* Move a transaction from the allocated list to the committed list */
+static void gsi_trans_move_committed(struct gsi_trans *trans)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+
+	spin_lock_bh(&trans_info->spinlock);
+
+	list_move_tail(&trans->links, &trans_info->committed);
+
+	spin_unlock_bh(&trans_info->spinlock);
+}
+
+/* Move transactions from the committed list to the pending list */
 static void gsi_trans_move_pending(struct gsi_trans *trans)
 {
 	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
 	struct gsi_trans_info *trans_info = &channel->trans_info;
+	struct list_head list;
 
 	spin_lock_bh(&trans_info->spinlock);
 
-	list_move_tail(&trans->links, &trans_info->pending);
+	/* Move this transaction and all predecessors to the pending list */
+	list_cut_position(&list, &trans_info->committed, &trans->links);
+	list_splice_tail(&list, &trans_info->pending);
 
 	spin_unlock_bh(&trans_info->spinlock);
 }
@@ -581,13 +597,14 @@ static void __gsi_trans_commit(struct gsi_trans *trans, bool ring_db)
 	if (channel->toward_ipa)
 		gsi_trans_tx_committed(trans);
 
-	gsi_trans_move_pending(trans);
+	gsi_trans_move_committed(trans);
 
 	/* Ring doorbell if requested, or if all TREs are allocated */
 	if (ring_db || !atomic_read(&channel->trans_info.tre_avail)) {
 		/* Report what we're handing off to hardware for TX channels */
 		if (channel->toward_ipa)
 			gsi_trans_tx_queued(trans);
+		gsi_trans_move_pending(trans);
 		gsi_channel_doorbell(channel);
 	}
 }
@@ -747,6 +764,7 @@ int gsi_channel_trans_init(struct gsi *gsi, u32 channel_id)
 
 	spin_lock_init(&trans_info->spinlock);
 	INIT_LIST_HEAD(&trans_info->alloc);
+	INIT_LIST_HEAD(&trans_info->committed);
 	INIT_LIST_HEAD(&trans_info->pending);
 	INIT_LIST_HEAD(&trans_info->complete);
 	INIT_LIST_HEAD(&trans_info->polled);
-- 
2.34.1

