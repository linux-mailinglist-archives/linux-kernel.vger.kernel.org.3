Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0F050602F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiDRXVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiDRXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:20:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A723BDF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f14so2630180qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dcJHoI59iupk/XZrTeiSOhbOxLwLKCBzj4Z2fI2tTc=;
        b=LhCy4Xw3XN068oiUmiq1/1Q8uv7ZgPx8f0g98Osy317QhjxRDf3CkOOZPc1ftvYJnJ
         gxOnCH8bESAgzEqHoyAL70WuiVudZ2fj2ItxFXVGHqPNIU0Hj+kI/gpT7q3dnW+7t9YN
         ffDvkK5FKc6Flz2lKRs5lZvpB7Mi0a3S+yVSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dcJHoI59iupk/XZrTeiSOhbOxLwLKCBzj4Z2fI2tTc=;
        b=0Yj2yTokhygUgy8FqlQjzc3FkklROLTHy329MDrmZ20DEPWL81CnEM6wbJ/5yRTiA5
         u0kLuWcgxwzz7bb2rujErK4w7ziCMYicBu/qoo3F+QDJn1gDntEA24WaEM8+s+1gHQ3V
         pJ64sFZpTR4x/SZ8susdIqSTee+XCZV0hgLu4Or11X64DJj62/R/7yB5A/dRgWuy8RWy
         6ClQ78y0vU2NyujyDiWggZoAnma7LjL3fYDmOrqvVGXHJLE3AG0yVoieaIDwoN/T8s7i
         wnYIxIt5h74Kj3XPdumcDFiCRZGP1uRkg7elFVu/MJaYyaEec5KfucALzPWya3u4g1Ur
         bcoA==
X-Gm-Message-State: AOAM532I8Fd6Ze6+bvkUN27MCe+FNzASoU0uJ29kDZ9kkuSBpZXB+nJG
        PMLTzs6NPq5CsA2z66N+1g9RDw==
X-Google-Smtp-Source: ABdhPJzVmagn0Rfc5cXZudhsLyucFUBeBfCKmqRoxtX4m60vigQt1WYkqD8XBGNWp/r7n0HZ6vDLmg==
X-Received: by 2002:ac8:5206:0:b0:2f1:e8cc:7800 with SMTP id r6-20020ac85206000000b002f1e8cc7800mr8620403qtn.501.1650323889668;
        Mon, 18 Apr 2022 16:18:09 -0700 (PDT)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f17cba4930sm8214048qtx.85.2022.04.18.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:18:09 -0700 (PDT)
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
Subject: [PATCH 5/5] net: atlantic: verify hw_head_ is reasonable
Date:   Mon, 18 Apr 2022 16:17:46 -0700
Message-Id: <20220418231746.2464800-6-grundler@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220418231746.2464800-1-grundler@chromium.org>
References: <20220418231746.2464800-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bounds check hw_head index to verify it lies within the TX buffer ring.

Unexpected values of hw_head may cause aq_ring_tx_clean to double
dev_kfree_skb_any already cleaned parts of the ring.

Reported-by: Aashay Shringarpure <aashay@google.com>
Reported-by: Yi Chou <yich@google.com>
Reported-by: Shervin Oloumi <enlightened@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index e72b9d86f6ad..9b6b93bb3e86 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -889,6 +889,27 @@ int hw_atl_b0_hw_ring_tx_head_update(struct aq_hw_s *self,
 		err = -ENXIO;
 		goto err_exit;
 	}
+
+	/* Validate that the new hw_head_ is reasonable. */
+	if (hw_head_ >= ring->size) {
+		err = -ENXIO;
+		goto err_exit;
+	}
+
+	if (ring->sw_head >= ring->sw_tail) {
+		/* Head index hasn't wrapped around to below tail index. */
+		if (hw_head_ < ring->sw_head && hw_head_ >= ring->sw_tail) {
+			err = -ENXIO;
+			goto err_exit;
+		}
+	} else {
+		/* Head index has wrapped around and is below tail index. */
+		if (hw_head_ < ring->sw_head || hw_head_ >= ring->sw_tail) {
+			err = -ENXIO;
+			goto err_exit;
+		}
+	}
+
 	ring->hw_head = hw_head_;
 	err = aq_hw_err_from_flags(self);
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

