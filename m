Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825165AF281
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiIFR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiIFR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:28:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05EB29839
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:19:51 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l6so6310850ilk.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zZbEcuX0tdGW7P2MaUSSUsEhwbNAXlnJUrhgFzH+WmQ=;
        b=I0njSX+tXOi0JgBd1TyTJqM9z+wnQ1XLkog8MwTlzh2ydkCBZMPz/yUwAhOX2G7qiw
         bWh33JM8bI7MWixDFomd9+Py89DNjn9W/8GB39vf09N3gM/0fhG8TGiu9DCJoOKZdVun
         kG0YZB6ONQoDZrzjGoIXIFhRaQh8cqaVfjNjD9e+7qyb89hs0LkSK8tysKGpo8zSTqb4
         Tt1n/N3nW5aFaEIxf+0I43/PY61PcZE3kIuqK+bQhN8s48dTBcOhG5slGSKSaffeSZMo
         TNbF53ZwrxaELtt/9SMWOsZfrlfGe4rTfkW0R2eqePgH/TmnmCr4zbQk29kfHw2H23Q3
         3VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zZbEcuX0tdGW7P2MaUSSUsEhwbNAXlnJUrhgFzH+WmQ=;
        b=4a3WXXuoIHiTLhP45AFkTABfYAZ5WPcItuFZuZc79EHNHDBzoPLX5hYYotmpWTLbuY
         r7e+yP9u0N5YkGccHqnWV4PzV4E6lIG+ovX4qINZxtTQgS53rYMAVQQFIqhKfY0jeh/u
         uq95kHu1IimoV5+BLUtDeSPzOR3bf/QOe9wI5MH0XaRwfnytUlCFOd7uzI1vAi7ordm/
         qjn30DTrC4OkqSrvrbvrgXEFqlB2L9awsDZBRxkNEZ6MATPQc+IIm3vDSl64PUSGJ5pk
         UDzKP52ZriWoy3k4dhL0wYV2hu1QqMCKZeXBrVR28en98vARJ1QKJOv/6ATknCUej7gN
         2Ofg==
X-Gm-Message-State: ACgBeo2ZOZTIBUPTFI2cOK/scDJnHrQui7iPqjzAgCYRGFmNDzsOB8Lv
        Lvmx0HVzY7bLX4Tg7hgIeznjxxpb1JCAxg==
X-Google-Smtp-Source: AA6agR7XdHZspGzRaTMyCUViyeFlimDqc98GcZ+u5jnNk0/i4g7QUV6klrH8oqlC3vAYFZYZ4k5ZFA==
X-Received: by 2002:a05:6e02:19cb:b0:2eb:3cd1:105e with SMTP id r11-20020a056e0219cb00b002eb3cd1105emr17590197ill.235.1662484791034;
        Tue, 06 Sep 2022 10:19:51 -0700 (PDT)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e020c2a00b002eb3f5fc4easm5292204ilg.27.2022.09.06.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:19:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: ipa: update channel in gsi_channel_trans_complete()
Date:   Tue,  6 Sep 2022 12:19:41 -0500
Message-Id: <20220906171942.957704-5-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906171942.957704-1-elder@linaro.org>
References: <20220906171942.957704-1-elder@linaro.org>
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

Have gsi_channel_trans_complete() update the known state from
hardware rather than doing so in gsi_channel_poll_one().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c         | 5 +----
 drivers/net/ipa/gsi_private.h | 8 ++++++++
 drivers/net/ipa/gsi_trans.c   | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 16df699009a86..5471843b665fc 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1475,7 +1475,7 @@ void gsi_channel_doorbell(struct gsi_channel *channel)
 }
 
 /* Consult hardware, move any newly completed transactions to completed list */
-static struct gsi_trans *gsi_channel_update(struct gsi_channel *channel)
+struct gsi_trans *gsi_channel_update(struct gsi_channel *channel)
 {
 	u32 evt_ring_id = channel->evt_ring_id;
 	struct gsi *gsi = channel->gsi;
@@ -1529,9 +1529,6 @@ static struct gsi_trans *gsi_channel_poll_one(struct gsi_channel *channel)
 
 	/* Get the first transaction from the completed list */
 	trans = gsi_channel_trans_complete(channel);
-	if (!trans)	/* List is empty; see if there's more to do */
-		trans = gsi_channel_update(channel);
-
 	if (trans)
 		gsi_trans_move_polled(trans);
 
diff --git a/drivers/net/ipa/gsi_private.h b/drivers/net/ipa/gsi_private.h
index 0b2516fa21b5d..a937811bb1bb7 100644
--- a/drivers/net/ipa/gsi_private.h
+++ b/drivers/net/ipa/gsi_private.h
@@ -94,6 +94,14 @@ void gsi_channel_trans_exit(struct gsi_channel *channel);
  */
 void gsi_channel_doorbell(struct gsi_channel *channel);
 
+/* gsi_channel_update() - Update knowledge of channel hardware state
+ * @channel:	Channel whose doorbell should be rung
+ *
+ * Consult hardware, move any newly completed transactions to a
+ * channel's completed list
+ */
+struct gsi_trans *gsi_channel_update(struct gsi_channel *channel);
+
 /**
  * gsi_ring_virt() - Return virtual address for a ring entry
  * @ring:	Ring whose address is to be translated
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index a3ae0ca4813c6..0b78ae904bacf 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -241,7 +241,7 @@ struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
 	u16 trans_id = trans_info->completed_id;
 
 	if (trans_id == trans_info->pending_id)
-		return NULL;
+		return gsi_channel_update(channel);
 
 	return &trans_info->trans[trans_id %= channel->tre_count];
 }
-- 
2.34.1

