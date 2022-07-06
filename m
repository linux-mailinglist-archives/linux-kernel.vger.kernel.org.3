Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC15682A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiGFJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiGFJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:05:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0F424BD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so9615104wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJE9JrNh4HvbwKuPRZxdjE4sOr8yHsnud2KqNuPrCRY=;
        b=zu+LLYNfYMR5w2kmcD+VYvYPTp0nJI+jT7tqr9TOwHrQicaqgP6aWYB4SxDRI4kvXK
         BTpaTst+Kf2CgpT8EMtXXOLZBdyjJltD/PkJYqQZlYlOt0DDcXWpehZHlYpOR0GPscdp
         2MeE5vjRhXLjQHwfeySb9QQrwi8wJaCfBCzq0tYbMV3hxIVrX1u7f0UgFvrHSwmSpmJO
         JsbbVnLZhXi0ihk7Ko9AtHZhwkXPjnk7t7rabDtQouXLzJb5akPuulNS3jm2qpHDr8UB
         l298OPf2l8G1OsnQjwvWuGBdVXJkdMmjJtsLQx3KyFAaqQpNNU/uML10kbrGUrtv9uWt
         k0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJE9JrNh4HvbwKuPRZxdjE4sOr8yHsnud2KqNuPrCRY=;
        b=msDbRitmlqFyiFo4ubHG9acY1GnP+DQGsAYlRGv8zI084ZT+yJqVbtC2EzofJSQrXn
         c4Sb2abIUZNtmSw9dZImNqAKflK4rJ6PQsPnlPgQ7xP7I57DphzZZ/fSYBgtj8H9NtC5
         wi7WikGa2a9l5StwfidTkJAcqvXr5f3WzzxonY4lzfrsRwL06qYp7loYErE9Xh4ty4Td
         fHb6/ovVCi8WhabNuBVLV059JNK3H/G1BTgSJIgurkvWgQrIQc/nzxc0c8Lt6BFc85Rq
         zZYZ7/dovrro9lxhuiif7m+7R9g7XCZn5U16BLOIEz9AN+mEsLvgiuhilTGQLE/zZC3I
         DLcw==
X-Gm-Message-State: AJIora9BUjevIugI5cg248bEo8OBe4s0zB/g/xQcX5euaO/La+Vv+vI7
        hCqHANyhqxtQ22q04DKpH0elgGB5AlOPnQ==
X-Google-Smtp-Source: AGRyM1tEKqZlLUJfN0k4nDeQgcEf9DG4eNIDN0NpdWfXaZGKmEatPTHkXZAc5xBm0SQDd3swFPHszA==
X-Received: by 2002:a05:6000:170e:b0:21d:54ac:6ce8 with SMTP id n14-20020a056000170e00b0021d54ac6ce8mr21083862wrc.43.1657098290976;
        Wed, 06 Jul 2022 02:04:50 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:50 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 17/33] crypto: rockchip: use read_poll_timeout
Date:   Wed,  6 Jul 2022 09:03:56 +0000
Message-Id: <20220706090412.806101-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
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

Reviewed-by: John Keeping <john@metanate.com>
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

