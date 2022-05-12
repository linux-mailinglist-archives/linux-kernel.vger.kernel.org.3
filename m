Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DC55250F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355793AbiELPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbiELPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:10:46 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F1B5F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:10:40 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l15so3743879ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOgHbfj1z9x8AM1kqdr9IhGDZyiiSFcLmzAdQEoyfaQ=;
        b=fRABJ8HyGFX71otkrr5FftjCDwBBddBTCZDYZOdT49Am4zy4q+9ONol2dB625OXVGs
         buL/orF3YMUKOihWwv+iKweSSVAu4ETlleQlEbzX+6lhqoXtY7gvK4asdIIA3l4SvwIz
         TNaF3x2PoIP6x5L8by9m1GKPbOk02zEIn47dc8mFX8CGu1V3x4HHDAaNN3TkuzUKMnYJ
         0alIWPaAFZ1Ll9URbqngDcweZie36Mwhz8TMiOBIeUCRkXG05A/LQe2RN85qf+h1qY2w
         k4fqSVSWYtZvrFn+/EowBvfTn/+v7ehXnx20ljqKcnB2YRlgSNb4x9kp46kvxgO0dFKZ
         KtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOgHbfj1z9x8AM1kqdr9IhGDZyiiSFcLmzAdQEoyfaQ=;
        b=4gHoCNXUwTiOLse0b2dPjsq3LM9Wi/K9Hi4Lvl36Z66fNYzes2E8FskvuvWdk5iDz+
         jV1h1RKvWysSoQh9rImnX/QJ+Nacg7uzZuOaKh1UErb68AL7JEhlaAwkoeD19T9PNSGX
         M7eP1KE/BD9s6NC/E12dZ/L0KEKyorjf8FE+nnDQypuoZauOXKJN4IAXV62L7RQp28LX
         Umx1Fw4agM/tTvFFZp1q3mtXcmC6R6VreJgehMz6IydWDicXRxwNgwwKm5jXc6ASfZrc
         D6hqLX3CqOgiZfLd0fUmA1849X7rLLdnNRfPdxPh+QFinN8iDzCe7GXARTCYMRh4CESw
         rwzA==
X-Gm-Message-State: AOAM532nP/hzf2+ms2zAlkPiEjMqOPlX1ka28UjvO/SDMdxNXOC7fzxD
        rLodJ0/jQe350+cZH6glyo8uUA==
X-Google-Smtp-Source: ABdhPJzLmDHREoZVAiAK++xyPN2j5zeEm9VkEoK9bMJ2NMUJWjGTJDzeUr9CQWyTjreeECbUUgRuRg==
X-Received: by 2002:a05:6e02:1808:b0:2cf:41d7:7a20 with SMTP id a8-20020a056e02180800b002cf41d77a20mr251580ilv.300.1652368239478;
        Thu, 12 May 2022 08:10:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p15-20020a6b8d0f000000b0065a47e16f3fsm18217iod.17.2022.05.12.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:10:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     lkp@intel.com, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: ipa: record proper RX transaction count
Date:   Thu, 12 May 2022 10:10:32 -0500
Message-Id: <20220512151033.211592-3-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512151033.211592-1-elder@linaro.org>
References: <20220512151033.211592-1-elder@linaro.org>
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

Each time we are notified that some number of transactions on an RX
channel has completed, we record the number of bytes that have been
transferred since the previous notification.  We also track the
number of transactions completed, but that is not currently being
calculated correctly; we're currently counting the number of such
notifications, but each notification can represent many transaction
completions.  Fix this.

Fixes: 650d1603825d8 ("soc: qcom: ipa: the generic software interface")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index bc981043cc808..a701178a1d139 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1367,9 +1367,10 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 	struct gsi_event *event_done;
 	struct gsi_event *event;
 	struct gsi_trans *trans;
+	u32 trans_count = 0;
 	u32 byte_count = 0;
-	u32 old_index;
 	u32 event_avail;
+	u32 old_index;
 
 	trans_info = &channel->trans_info;
 
@@ -1390,6 +1391,7 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 	do {
 		trans->len = __le16_to_cpu(event->len);
 		byte_count += trans->len;
+		trans_count++;
 
 		/* Move on to the next event and transaction */
 		if (--event_avail)
@@ -1401,7 +1403,7 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 
 	/* We record RX bytes when they are received */
 	channel->byte_count += byte_count;
-	channel->trans_count++;
+	channel->trans_count += trans_count;
 }
 
 /* Initialize a ring, including allocating DMA memory for its entries */
-- 
2.32.0

