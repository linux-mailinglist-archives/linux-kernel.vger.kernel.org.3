Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58638530001
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbiEVAck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbiEVAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:32:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B2840A27
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y12so12136084ior.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDjvNwQr73WDdKShZZtiXObHhvvbcnoL8/p/PaQfpbU=;
        b=eek14q3Lwl6FAankzSVWLllAf1o0oev61OR+Nqb0yCryCj2XIc9UKZsg4fXQNtpO58
         seEPphVQELgMmDZ9O7JfVNyWieVwPFpfnLscMX/OhRDXlgQkEXwCM+3FfB5zOWHAqCu9
         pyuYB6VfS6nxxAQi2QEnGInu4AnsJkeLkjx/73Uxer5HzbuwZbHL4flDGCPnOlj27j77
         XuerVRpKO/9B55nFn+O0/1AY7xj+/lzr4L4Mmr7Zs6iWnq9zaBIbrgBDdpLvGBTjGcuz
         V/saFSfzJv7AAJcP3nH/brw1GYRAGDfictuChY49STFdyRjX9cLEXcH6xoE/sZkSp+5Z
         2kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDjvNwQr73WDdKShZZtiXObHhvvbcnoL8/p/PaQfpbU=;
        b=UGl9AzNj6dY4/y2IQonDJMGTCSWF75pqqRZM/MEomFLqLSKArh6YgTA1udk57WbwRR
         suEJlaN+9ki2uJB9MT2l+Jg34QaOu4kZPam5US7Z7g+MKeYN2LnrWThm4qWlq/ugM13f
         zkmjItndRsUgNr+uwXF01hGo4eJDsYGMPz6ggEIKxetx/RMSX4n73P53SZ9CTP4cGiGU
         ov0hsglnSijmJ799KJkBDPhw8d4OHVTn1+PDG6pOXHDqUZgNQwsB0hCjgBiAeGisl12d
         mZW6OfEmE6mFFHMhE6BxY6TCwuvfnEAtuo/NXq5bkl34OQZd0SdvgEVtz9Yd3n6MOoO6
         E28A==
X-Gm-Message-State: AOAM531DodC/GvA2SLP6mnYslEJFdi4niEH3oiSt7SsnYt9me/SZNVfd
        aSzqLa8cYvIx6l8LDZ4B/11PTg==
X-Google-Smtp-Source: ABdhPJxlJWDFbCYtcr3ZvCg2ar0i8GMB37v/oJ4mq3nsyLJfP/UhPrIn/3a6SYMYXxtMxEXA/fdBoQ==
X-Received: by 2002:a5d:9ccb:0:b0:660:6a38:60eb with SMTP id w11-20020a5d9ccb000000b006606a3860ebmr3692744iow.110.1653179547944;
        Sat, 21 May 2022 17:32:27 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b0032b5e78bfcbsm1757115jaj.135.2022.05.21.17.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 17:32:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/9] net: ipa: make endpoint HOLB drop configurable
Date:   Sat, 21 May 2022 19:32:15 -0500
Message-Id: <20220522003223.1123705-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220522003223.1123705-1-elder@linaro.org>
References: <20220522003223.1123705-1-elder@linaro.org>
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

Add a new Boolean flag for RX endpoints defining whether HOLB drop
is initially enabled or disabled for the endpoint.  All existing AP
endpoints should have HOLB drop disabled.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 8 ++++++--
 drivers/net/ipa/ipa_endpoint.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 0f489723689c5..3ad97fbf6884e 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1554,8 +1554,12 @@ static void ipa_endpoint_program(struct ipa_endpoint *endpoint)
 	ipa_endpoint_init_hdr_metadata_mask(endpoint);
 	ipa_endpoint_init_mode(endpoint);
 	ipa_endpoint_init_aggr(endpoint);
-	if (!endpoint->toward_ipa)
-		ipa_endpoint_init_hol_block_disable(endpoint);
+	if (!endpoint->toward_ipa) {
+		if (endpoint->config.rx.holb_drop)
+			ipa_endpoint_init_hol_block_enable(endpoint, 0);
+		else
+			ipa_endpoint_init_hol_block_disable(endpoint);
+	}
 	ipa_endpoint_init_deaggr(endpoint);
 	ipa_endpoint_init_rsrc_grp(endpoint);
 	ipa_endpoint_init_seq(endpoint);
diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 39a12c249f66d..3ab62fb892ec6 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -60,6 +60,7 @@ struct ipa_endpoint_tx {
  * @buffer_size:	requested receive buffer size (bytes)
  * @pad_align:		power-of-2 boundary to which packet payload is aligned
  * @aggr_close_eof:	whether aggregation closes on end-of-frame
+ * @holb_drop:		whether to drop packets to avoid head-of-line blocking
  *
  * With each packet it transfers, the IPA hardware can perform certain
  * transformations of its packet data.  One of these is adding pad bytes
@@ -74,6 +75,7 @@ struct ipa_endpoint_rx {
 	u32 buffer_size;
 	u32 pad_align;
 	bool aggr_close_eof;
+	bool holb_drop;
 };
 
 /**
-- 
2.32.0

