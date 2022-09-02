Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB395AB9BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiIBVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:02:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B6BD742
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:02:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h78so2614377iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Sg94S1ohGjSO+2FVqvQ4ZE3HnavccZA0F79TKZotqVs=;
        b=o9qQ43NUmTFDtsWINhDRhOkVGXDvg/H28BHjXIDDAEPud8d9lSZEHUA9LlfLcwHDva
         dDJrZm3qqB7nsHYvewhltyadSReDKbLEevaB19KsVU52naGDx6JOHOJbQoZRzgZSIefV
         Mjh8BpDYLeeU7W+p+wCeM3NkaxlEUjad5u5Y3KDzZjrW9rc3n4EkJOcAgM3qWWCco72i
         nK+I1s6KAqk9x+sVXzB7SYmj6Jr+vuF3BFsPwSrc4l0Tl8vi5J0aGvw4SSXChJvldh9L
         SWd3rTClLlqPJ08BIsCVeKPVQ8STXdNwTyxLN4xcn/gUFRdqFD7JOoY9w3LZqYgsvmId
         3jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sg94S1ohGjSO+2FVqvQ4ZE3HnavccZA0F79TKZotqVs=;
        b=hfjEv5At7i5aSOrpiknPBixiELReQk0SHjeKpdtsdB2AfkRnizpLyaCfWVetVPUdKP
         CUFUO1cnhUIflhBDtjkuRleJmbLy0f/ko6UFDkJyoVAYU7DMMIQs9Xeg8X6t34By8vw7
         /XKZ0ueCK1e+yH5ATOYDnT4Cwy74epNHfYyf5bVdU5sUBn6vwVlfJ527tkDj+CLaMmRr
         mKt2RJ/RS/dwwqzw/62aFNwMzNxKGKgd88jQ3OLReCY+Jw0M52tANNpc43jjOJz3Hy8y
         az878jRoEg5Rc+iLXb1ZGUQ90E0IxYT+pSWTF3mMF2X95nVdBI/cpFhA34cf9Ski9gPP
         TdPg==
X-Gm-Message-State: ACgBeo2p2LhaXHzMI+NGfLblA0bes+tHVyQ/DhVaZ4Ok8ksVDt1LLu/E
        PfGblaWUEehqvtTAe7jsUnUw4w==
X-Google-Smtp-Source: AA6agR4bipgwhYJcj70+tEd37INbaqRP3sa2haOjLbdU0WafJ0IULWIhc59GMUjKLG7TzCpXBhBeFQ==
X-Received: by 2002:a05:6638:2613:b0:346:e2c5:aa4e with SMTP id m19-20020a056638261300b00346e2c5aa4emr20374986jat.160.1662152548689;
        Fri, 02 Sep 2022 14:02:28 -0700 (PDT)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i7-20020a0566022c8700b00689e718d971sm1259208iow.51.2022.09.02.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:02:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] net: ipa: verify a few more IDs
Date:   Fri,  2 Sep 2022 16:02:18 -0500
Message-Id: <20220902210218.745873-7-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902210218.745873-1-elder@linaro.org>
References: <20220902210218.745873-1-elder@linaro.org>
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

The completed transaction list is used in gsi_channel_trans_complete()
to return the next transaction in completed state.

Add some temporary checks to verify the transaction indicated by the
completed ID matches the one first in this list.

Similarly, we use the pending and completed transaction lists when
cancelling pending transactions in gsi_channel_trans_cancel_pending().

Add temporary checks there to verify the transactions indicated by
IDs match those tracked by these lists.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 46 ++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index b4a6f2b563566..05ab4d052c68b 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -237,8 +237,24 @@ gsi_channel_trans_mapped(struct gsi_channel *channel, u32 index)
 /* Return the oldest completed transaction for a channel (or null) */
 struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
 {
-	return list_first_entry_or_null(&channel->trans_info.complete,
-					struct gsi_trans, links);
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u16 trans_id = trans_info->completed_id;
+	struct gsi_trans *trans;
+
+	trans = list_first_entry_or_null(&trans_info->complete,
+					 struct gsi_trans, links);
+
+	if (!trans) {
+		WARN_ON(trans_id != trans_info->pending_id);
+		return NULL;
+	}
+
+	if (!WARN_ON(trans_id == trans_info->pending_id)) {
+		trans_id %= channel->tre_count;
+		WARN_ON(trans != &trans_info->trans[trans_id]);
+	}
+
+	return trans;
 }
 
 /* Move a transaction from the allocated list to the committed list */
@@ -690,6 +706,8 @@ void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
 {
 	struct gsi_trans_info *trans_info = &channel->trans_info;
 	struct gsi_trans *trans;
+	struct gsi_trans *first;
+	struct gsi_trans *last;
 	bool cancelled;
 
 	/* channel->gsi->mutex is held by caller */
@@ -701,11 +719,33 @@ void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
 
 	list_splice_tail_init(&trans_info->pending, &trans_info->complete);
 
+	first = list_first_entry_or_null(&trans_info->complete,
+					 struct gsi_trans, links);
+	last = list_last_entry_or_null(&trans_info->complete,
+				       struct gsi_trans, links);
+
 	spin_unlock_bh(&trans_info->spinlock);
 
+	/* All pending transactions are now completed */
+	WARN_ON(cancelled != (trans_info->pending_id !=
+				trans_info->committed_id));
+
+	trans_info->pending_id = trans_info->committed_id;
+
 	/* Schedule NAPI polling to complete the cancelled transactions */
-	if (cancelled)
+	if (cancelled) {
+		u16 trans_id;
+
 		napi_schedule(&channel->napi);
+
+		trans_id = trans_info->completed_id;
+		trans = &trans_info->trans[trans_id % channel->tre_count];
+		WARN_ON(trans != first);
+
+		trans_id = trans_info->pending_id - 1;
+		trans = &trans_info->trans[trans_id % channel->tre_count];
+		WARN_ON(trans != last);
+	}
 }
 
 /* Issue a command to read a single byte from a channel */
-- 
2.34.1

