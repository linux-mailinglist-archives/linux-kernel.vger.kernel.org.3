Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA54FFEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiDMTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbiDMTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1971ECA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so3964367wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=XR0T/nYjcUz0ghN3xV+oUnmLR+tTIQbtkq8WJA9G0IIG5S0jsm+Nz5NEwHcwPeymXb
         uHJ6gjhMxHBbRqmViTPBrfxHJam2yiu6WT/3DifHjfhY15huHGawHuKtuJyAZC/3P9qG
         pPNOoIE6NnTVFyf+9CO5p0XOeKvFzwlYLnhD+pTQvfo7PGEXuIHHL1gWiTDSILv7DjdK
         pEftTtda9lhM8H8omnWDOvbRPzlv+73beALZmIjhBwUdA0ASDVvy50/+URh2DjQ35vnj
         G+jEzI7wjpO1q1E3Q7SE4UA+bguUkL6QJTzcNuyhZjoQtN0D0ROvO17flSdoH+DDtcVV
         Sshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=Ev9z/MMQKdCNTgqaetCcle2imnqiXDB9i33bzkqjQ+qXliZ7/vhe1TUx4Uult40s9h
         lHtPv4mrJavjpHRklqqDjswKzQ+HXqo98mStPdIkTWlb/HEPDxzPT2RCMV0enAZAHxiX
         JMHHj3YsutnKPuy6LY6x9nUUkqzQfR70mlCJ3vvXbLlPpYCJoq28AvHm74fHeia9sVf6
         I3rrd3APxLkwVI6mR3VtS8tw65IzylYDID/qc1RtAIjWLQORrXQqttDUB7aXdT/l0SSF
         HCq1NY6IUjS78sE64U22Xpef/TMKP1FN1FeEl31qj9RNb/5+04tz+WQh3T6VhyHRLNqQ
         evBw==
X-Gm-Message-State: AOAM533UUYx/VxKYNN1tuMLluESJuWCCtz0ja5dV1LtigUE9naIFfHd7
        imYYFDtPXQDlrV+u8fF5E+NyRw==
X-Google-Smtp-Source: ABdhPJwU/3cxqhT4VHenbUuq4+V8wc7KxrpdVQahA+nxn2yulLFrGoMim28IVZ30TyU4XOfIPGMJ9g==
X-Received: by 2002:a5d:591c:0:b0:207:a060:426c with SMTP id v28-20020a5d591c000000b00207a060426cmr231404wrd.305.1649876875218;
        Wed, 13 Apr 2022 12:07:55 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 31/33] crypto: rockchip: rk_ahash_reg_init use crypto_info from parameter
Date:   Wed, 13 Apr 2022 19:07:11 +0000
Message-Id: <20220413190713.1427956-32-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk_ahash_reg_init() use crypto_info from TFM context, since we will
remove it, let's take if from parameters.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index d1bf68cb390d..30f78256c955 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -78,12 +78,10 @@ static int zero_message_process(struct ahash_request *req)
 	return 0;
 }
 
-static void rk_ahash_reg_init(struct ahash_request *req)
+static void rk_ahash_reg_init(struct ahash_request *req,
+			      struct rk_crypto_info *dev)
 {
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *dev = tctx->dev;
 	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
@@ -281,7 +279,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
-	rk_ahash_reg_init(areq);
+	rk_ahash_reg_init(areq, rkc);
 
 	while (sg) {
 		reinit_completion(&rkc->complete);
-- 
2.35.1

