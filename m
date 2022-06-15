Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C854CF38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355365AbiFOQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351361AbiFOQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:39 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3A340DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e66so11901536pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6dWtN6JS61iJPZCoy25a1Ek81mQCcvRmSG+rHnd6IM=;
        b=Jq50bywAEAIc9z9c0NiXsJMlHs054omA+BzgwjRtP7uWKt5yDKdix5WgOkrjfxBzco
         i7D7SvwPnwuXZwooDA0MobkQ22sh60FKpnhOq+iJETcWOv6EmoT2fN2alyh0Nk2ECE73
         9ZCWJV+H7XVtHBNdd0UHAzF0Wj/pz1wBmJpfYJOXf3VlfTJvKobzlLvSCXllsdDdC4VJ
         G0HomL9ahay9JRaVZfTuqnQXsclwWcktSjCgIlIGZSIv88mZhz2tCmLmYdAjmciMLRo5
         SkenroUSWzV3NS+Qg9WCdKsIRlTjoP7YUFxLXSHXpN+Yi67vBFl6ijmvANN9sWRqyjTd
         2L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6dWtN6JS61iJPZCoy25a1Ek81mQCcvRmSG+rHnd6IM=;
        b=0dky8qsRa1qUzNvs0KSG8U31j6sCaE848nmtF7ezDsLNvCfOP//KLHBSbpQkAFh9NZ
         Znl0CoJ5Z+AcWTn4TIq0i8Uf4I329De/bbgW5bJW7C4gsgjlUTBGXDij4cOatoG4GWif
         BfdIxioumckMAqN1TKMMnvOLjzHMP5nUoHUJRfHSNB5iVor7HX56LCWrU2z9uyAkW6Ya
         IP2oV1S+/yzVqCvLmQ7ah9U4yPKaabM6Vk/ml6/i1B+hU08kOJ9ATf0foVAOQgsImStC
         X+V6uRE/L79Y7QAFKqIFY8n7VZe7NkeCdqnCFalLEkKapf+n3RePR6tpRyel6pVnSokq
         mL5g==
X-Gm-Message-State: AJIora9MyWMndwRIi7OprpibtaEdVU5OlD/8mrhI7EB18fGBwJAWXJr/
        xtfAGTBoeYCDhuklv1mpmaC0AQ==
X-Google-Smtp-Source: AGRyM1sOuPiCrNsH9UB2zWAkGK6dCRv6+fmJT7YepeQkAYQHA+7UBn+6UMUP45kiSulxxF7jRNAV7g==
X-Received: by 2002:a05:6a00:170b:b0:51b:cf4b:9187 with SMTP id h11-20020a056a00170b00b0051bcf4b9187mr539797pfc.15.1655312375308;
        Wed, 15 Jun 2022 09:59:35 -0700 (PDT)
Received: from localhost.localdomain ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b003fd1111d73csm10618513pgc.4.2022.06.15.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:59:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: don't pass channel when mapping transaction
Date:   Wed, 15 Jun 2022 11:59:26 -0500
Message-Id: <20220615165929.5924-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615165929.5924-1-elder@linaro.org>
References: <20220615165929.5924-1-elder@linaro.org>
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

Change gsi_channel_trans_map() so it derives the channel used from
the transaction.  Pass the index of the *first* TRE used by the
transaction, and have the called function account for the fact that
the last one used is what's important.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index 54a2400cb560e..cf646dc8e36a3 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -214,10 +214,14 @@ void *gsi_trans_pool_alloc_dma(struct gsi_trans_pool *pool, dma_addr_t *addr)
 	return pool->base + offset;
 }
 
-/* Map a given ring entry index to the transaction associated with it */
-static void gsi_channel_trans_map(struct gsi_channel *channel, u32 index,
-				  struct gsi_trans *trans)
+/* Map a TRE ring entry index to the transaction it is associated with */
+static void gsi_trans_map(struct gsi_trans *trans, u32 index)
 {
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+
+	/* The completion event will indicate the last TRE used */
+	index += trans->used_count - 1;
+
 	/* Note: index *must* be used modulo the ring count here */
 	channel->trans_info.map[index % channel->tre_ring.count] = trans;
 }
@@ -568,15 +572,15 @@ static void __gsi_trans_commit(struct gsi_trans *trans, bool ring_db)
 		gsi_trans_tre_fill(dest_tre, addr, len, last_tre, bei, opcode);
 		dest_tre++;
 	}
+	/* Associate the TRE with the transaction */
+	gsi_trans_map(trans, tre_ring->index);
+
 	tre_ring->index += trans->used_count;
 
 	trans->len = byte_count;
 	if (channel->toward_ipa)
 		gsi_trans_tx_committed(trans);
 
-	/* Associate the last TRE with the transaction */
-	gsi_channel_trans_map(channel, tre_ring->index - 1, trans);
-
 	gsi_trans_move_pending(trans);
 
 	/* Ring doorbell if requested, or if all TREs are allocated */
-- 
2.34.1

