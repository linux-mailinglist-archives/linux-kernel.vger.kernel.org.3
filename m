Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD88949D40F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiAZVFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiAZVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB79C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso607176wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snYrFJ12aUfxHMb2aqbQr58aBrO9I7pzj7+8V1Dw+/A=;
        b=4ulCosohtZpKHKk1OWZvg15RfCT5UKS1+RX7vVL4SOremHHI031JCQQpK4rmR26rrz
         sncnRcjqlcn/aNLuhLe4gpkJdGxAwSaAVhujtXACxeo0tMhyIzkskAWEDshjgajbUUoL
         MbRYqeK7HlPbBOuLGz2L6FtBtVuHO34J9qm0UEcmJkTXsxGQbUKvq+K8PWToMHofCpNG
         wd+ln/PqR7hEzYAsc9qOup9JfzLBm7EN+RLBDTgA+lb5G0AnXlIjaGZhzAMnW5gxEoKx
         c/dstabSdqeOY1eOIDthWf6qFk12kiX5Hfz5wlAg5/tyBbYSkbpR6JTqUYSVEBVkWTh3
         zOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snYrFJ12aUfxHMb2aqbQr58aBrO9I7pzj7+8V1Dw+/A=;
        b=lFpFToTzvd3P74zoXcmRazow7xlRhErm9nM2b5TjG7yugl+ziGyScBXKxnFBNpDY5n
         tEBco5uzwSMskR4TJeuSbAtOw1rScAnRH6xAfV71jZdq0AVszO4y77jqfF3W6SLvSQZy
         tmXYyQ2LYx700mUZl2u3/I04J78i6G8A4qTGTeltGy6n4gSx/nSooUeNJJG3Wt+5gi7w
         3P5q05ZzLu8vu0P7RRp/lXLv61RgetANhVSMIQR/Km9VgweIZn4QMT/1JBtJoHi5aXux
         pn6CTHA9t39Z8iugxfs70Qe2FkR83OkMVyl8ZRWfEGD3hWRNLpfe157c4WhZHBpftLRO
         8sQQ==
X-Gm-Message-State: AOAM5301ziizy5HSYC4cik5PL3Rp+AK9NHV7C2tWtbU4WfU9G4hi8ES8
        VKuIgVrxHB9Iux5FZPNQk8Njsw==
X-Google-Smtp-Source: ABdhPJw+yWKxm6iGT9HIPz6Vr8isQ+lpFIiKvyXZgf1R+aoAldml+w5ZXDElVXNYI3y5J0Jnqz5IVA==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr488729wmj.94.1643231095799;
        Wed, 26 Jan 2022 13:04:55 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 6/8] crypto: sun8i-ss: remove redundant test
Date:   Wed, 26 Jan 2022 21:04:39 +0000
Message-Id: <20220126210441.3661782-7-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fallback tests were redundant with what sun8i_ss_hash_need_fallback() already do.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index ef3020bc9547..7ebd11d3ff7d 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -287,21 +287,11 @@ int sun8i_ss_hash_digest(struct ahash_request *areq)
 	struct sun8i_ss_alg_template *algt;
 	struct sun8i_ss_dev *ss;
 	struct crypto_engine *engine;
-	struct scatterlist *sg;
-	int nr_sgs, e, i;
+	int e;
 
 	if (sun8i_ss_hash_need_fallback(areq))
 		return sun8i_ss_hash_digest_fb(areq);
 
-	nr_sgs = sg_nents(areq->src);
-	if (nr_sgs > MAX_SG - 1)
-		return sun8i_ss_hash_digest_fb(areq);
-
-	for_each_sg(areq->src, sg, nr_sgs, i) {
-		if (sg->length % 4 || !IS_ALIGNED(sg->offset, sizeof(u32)))
-			return sun8i_ss_hash_digest_fb(areq);
-	}
-
 	algt = container_of(alg, struct sun8i_ss_alg_template, alg.hash);
 	ss = algt->ss;
 
-- 
2.34.1

