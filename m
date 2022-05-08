Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4771451EF61
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357966AbiEHTLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiEHTEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D5BE3A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so9639574wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5vq5Bgg0GZnREfAKsIq2BCzfZlNqniOuDOVX7ptgS8=;
        b=JM69r6XBahlTafzNdFRMQ1zAiMSwqONkuy9jTWoq4dOtKpEQTtc4Z9JnYmHyCxVRZX
         78YFg923+WPzFGVNs+Hh2YvCfgzWoV6BqgfF2DHvAQJgfHbk+mZ6b8mLNVdwRWxbXHLY
         2V0+26mKwFr2aM6fpbMVOb5SVsV+nRRXv+18LoiPaxOo4lQ+j1C7NMHavr+ac/UsFr3z
         xyEzJhII5AHAeoXsvKU5ve+pMrWl06AFrpn3LQZc4RGFxOF3FaZ1ZLjps9WrDgiQUYcM
         2BoRqu5UpP9V19J43GDtRI+sMHk6XTjB0qPhBOQer+HEBd6n4FPg/o7mt5y1t80tfpNo
         f2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5vq5Bgg0GZnREfAKsIq2BCzfZlNqniOuDOVX7ptgS8=;
        b=p+uI63AgDxxlUS2pbRSNuY1ftUUivoUCbGGERK5vUB1hjYFt+qOwpbQ6wDVwvD/THZ
         IAgFzcdMzWPy9DMG+d3cOvtZSSyyXUr/hgoRDpkaicP/VM0+gJ0CFavRoPKopvaDrxo/
         ZktXBp8hyZnjnSfNmfPfLkL0mf4nOJhnjx08xM0DrJn/S2C9kbNWhI2wifHV0f6ZAtjp
         5LPLYcFde8ZBrYLDebyi5EgfwlmheGESEajOHzl6hmCROxLiGerjpqxIxWUxiNPCeVJ+
         xOGuIYTX+7UEapDbX9A2ywYCZgZM7pm4OOikFlez8GraVBwMEI8h2no0pAh9mHynunrw
         DZLw==
X-Gm-Message-State: AOAM531q/wl8xe7JwJUNXEuwX7EwaZ6HpYZqc+rFh86Ld0mU1A/s/Bl0
        QRPtU87XYaDyXm1G42aMQQjGiA==
X-Google-Smtp-Source: ABdhPJwuHXGm8xhJzulSq8r+KdksEF7KcqMZvOMvhqAwQXJoVgrWUqGFUSaQq8+qZfP3sZ2OZkpN8g==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id q22-20020a1ce916000000b0037cf44f0573mr19376737wmc.179.1652036422599;
        Sun, 08 May 2022 12:00:22 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 17/33] crypto: rockchip: use read_poll_timeout
Date:   Sun,  8 May 2022 18:59:41 +0000
Message-Id: <20220508185957.3629088-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

Use read_poll_timeout instead of open coding it.
In the same time, fix indentation of related comment.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 137013bd4410..1fbab86c9238 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -10,6 +10,7 @@
  */
 #include <linux/device.h>
 #include <asm/unaligned.h>
+#include <linux/iopoll.h>
 #include "rk3288_crypto.h"
 
 /*
@@ -295,18 +296,17 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		sg = sg_next(sg);
 	}
 
-		/*
-		 * it will take some time to process date after last dma
-		 * transmission.
-		 *
-		 * waiting time is relative with the last date len,
-		 * so cannot set a fixed time here.
-		 * 10us makes system not call here frequently wasting
-		 * efficiency, and make it response quickly when dma
-		 * complete.
-		 */
-	while (!CRYPTO_READ(tctx->dev, RK_CRYPTO_HASH_STS))
-		udelay(10);
+	/*
+	 * it will take some time to process date after last dma
+	 * transmission.
+	 *
+	 * waiting time is relative with the last date len,
+	 * so cannot set a fixed time here.
+	 * 10us makes system not call here frequently wasting
+	 * efficiency, and make it response quickly when dma
+	 * complete.
+	 */
+	readl_poll_timeout(tctx->dev->reg + RK_CRYPTO_HASH_STS, v, v == 0, 10, 1000);
 
 	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
 		v = readl(tctx->dev->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
-- 
2.35.1

