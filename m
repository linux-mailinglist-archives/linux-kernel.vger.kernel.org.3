Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA9506028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiDRXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiDRXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:20:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9FE23BF8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t2so11101341qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGBuACRZ04g6eXXx9CXhc711yGsiIwo7BTuVUQLo/jM=;
        b=G3M7J2O5fbNDam/Y7wWtwO5oA+WoYmzO9/zF1ye07nxXMQvQMMCgSua+DdGg/Dzs4m
         iU8SUNeel2RNbTUSXTaZLngqjTqH9tou5OPzyYqHt92aR0aSHi8S8fPPeTrwqkCxRAeO
         LT4pFnU4i9IrYrafJ7/snP7CCh6S4W9Jspcls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGBuACRZ04g6eXXx9CXhc711yGsiIwo7BTuVUQLo/jM=;
        b=F7OGHmZFDVH7fb9wrHvTR+3qO/JmJAAqg/3jd+NFV25d36ASF2F53IEhRo4OqCx6dA
         J9HOZwpB/ogtgsTUgOPZ9jEs7L501hYAO25vSN+XVzdFXPHFkPwovjekxjc9iTQRpyxO
         ErBPy/pbMXuPYOzT8bD+y39jI9K26kxBKgofpfLSNYMZWnumuNQvHzMdf2ojn7HHmASQ
         PyMusQa6edVNYfGwCdO+j0R7+5uzN9D0+Er1OdzpGEwUfz6OjqwC78NTzYUjrckRwJZc
         lYuATluwcOUDUsck2DOBPTGq6izANOble9dVwOiXTqOtvtT0G1vZn7sSSit0nTBFF+TY
         H5EA==
X-Gm-Message-State: AOAM533w9L2X8K1JLPsTMTm1tSiW0CCTvOtuBGhF+bw5Ik3m9iMB2wc7
        m1hXm3ei+2VYeoiyQEXjG+eO1Q==
X-Google-Smtp-Source: ABdhPJxioJWtCIZdI8QrOclHvABvNGY9w+WxiL5bLKmhJNjlF1WwIj69Ea9szcH4umCtMgFfGbSBKQ==
X-Received: by 2002:ac8:5c14:0:b0:2f2:121:66d4 with SMTP id i20-20020ac85c14000000b002f2012166d4mr3945977qti.675.1650323885286;
        Mon, 18 Apr 2022 16:18:05 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f17cba4930sm8214048qtx.85.2022.04.18.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:18:05 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Aashay Shringarpure <aashay@google.com>,
        Yi Chou <yich@google.com>,
        Shervin Oloumi <enlightened@google.com>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH 2/5] net: atlantic:  fix "frag[0] not initialized"
Date:   Mon, 18 Apr 2022 16:17:43 -0700
Message-Id: <20220418231746.2464800-3-grundler@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418231746.2464800-1-grundler@chromium.org>
References: <20220418231746.2464800-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In aq_ring_rx_clean(), if buff->is_eop is not set AND
buff->len < AQ_CFG_RX_HDR_SIZE, then hdr_len remains equal to
buff->len and skb_add_rx_frag(xxx, *0*, ...) is not called.

The loop following this code starts calling skb_add_rx_frag() starting
with i=1 and thus frag[0] is never initialized. Since i is initialized
to zero at the top of the primary loop, we can just reference and
post-increment i instead of hardcoding the 0 when calling
skb_add_rx_frag() the first time.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 77e76c9efd32..440423b0e8ea 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -446,7 +446,7 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		       ALIGN(hdr_len, sizeof(long)));
 
 		if (buff->len - hdr_len > 0) {
-			skb_add_rx_frag(skb, 0, buff->rxdata.page,
+			skb_add_rx_frag(skb, i++, buff->rxdata.page,
 					buff->rxdata.pg_off + hdr_len,
 					buff->len - hdr_len,
 					AQ_CFG_RX_FRAME_MAX);
@@ -455,7 +455,6 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 
 		if (!buff->is_eop) {
 			buff_ = buff;
-			i = 1U;
 			do {
 				next_ = buff_->next;
 				buff_ = &self->buff_ring[next_];
-- 
2.36.0.rc0.470.gd361397f0d-goog

