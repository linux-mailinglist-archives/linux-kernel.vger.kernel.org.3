Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114050EA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiDYUZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiDYUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:25:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5B12D205
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so235010wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5vq5Bgg0GZnREfAKsIq2BCzfZlNqniOuDOVX7ptgS8=;
        b=K5apVdfdWrDo9ukPlzrj9+9KY0m9iTK/hWQiRgYqK4IyaLYt/oe+4gOgJEV1Ut+JLy
         3bGm/+BOtad6o7dyE4SKlF+fJJGsTMS/oci4c8fLSGu5VUOhJQnmQsBasBbtYncRjs+j
         LF64bbzC0iIrv0RN1Um6AYNLpbmblKVdJ6d6Fj/UNxdJDg7nrrPiqzuq+S67FRdDF7D3
         tY9wn2O0FcbC5IaVjD5RoHZIrNowsysvogyf6bzlLrc+IXBkzr0UpUQRhqRbpsB8MTRq
         P7b4e1mRhMecvuvTBsQojNto+5d0H229E2d0lqiA8J7qZniSkmkc/t8/S67ocGA9GLNu
         2pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5vq5Bgg0GZnREfAKsIq2BCzfZlNqniOuDOVX7ptgS8=;
        b=wk1NfJpF3BxBYiiehWEU6fftpWgWpBIyrtEyKDkN8iWhND836LAgywMwsNv8qTttIG
         bdGD5Q6Wq3IjCmMzSvYRoJMDei+8nPTBXhmJd3DJmRBPBKypiPUUevUqDgRuXVHidueu
         AIX+Q0Vhu6IBlK5xijlQ6EFu+TOKmeSvBfHgj6yuf6sv9IDyM727OZFhLpXuBb7L4Z8L
         gcP2A1u6rUF+Ut/tdHIPektjN6UR4Fgv/PfeVA06Q+wk798UbTDVWZdyfu+HsEDm4bJ0
         Hh3gesPVMpgY8GCVNtRRhfFZb043h8UvI6e0zLzmggOa29AtI0CFpR0Mg9LyWrjbU+zO
         tduw==
X-Gm-Message-State: AOAM530+iy9hMEKWJsvfhEWEbkZYEYHVkk48ZrDLAapEzB/hwjCamGqr
        ecFiSzppsaNVZQM0sIhrjrFx2g==
X-Google-Smtp-Source: ABdhPJxiTR3Xs8owoOBUUZ1RHATewVGrE2jNvNEZzcFLtdHPjVHWqKyvmVdU63TsDULIwyoN/yCu1g==
X-Received: by 2002:a05:600c:348f:b0:393:dcff:f95b with SMTP id a15-20020a05600c348f00b00393dcfff95bmr15403757wmq.76.1650918103942;
        Mon, 25 Apr 2022 13:21:43 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 17/33] crypto: rockchip: use read_poll_timeout
Date:   Mon, 25 Apr 2022 20:21:03 +0000
Message-Id: <20220425202119.3566743-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

