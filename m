Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8450EA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiDYU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbiDYU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:26:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7C1331B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:22:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q23so9600672wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=Z1sd3HVLsayY8MumfB1wqk+G5Kp3bdjZm0cqTrmrLPFHjZGYSNcrtnWvywBiPAmSn2
         04TiThXfxwHVCG3GNw7Jxw77NnGXa4yLERWXHMkEQPtX84Ag7eoITDX6/Xd8vwdUDZyQ
         w5zHTd7q0EhgefgJ1inIYexOMbbbX4sYzmNkhVOn8zuTbnAL7jHg3nzlDi5b4xo9xZNI
         J4GQSYy0zC/VIitJzE0JnS9cHizc/l0tmuDZ9tvDPSthUN8htS08fI4iXq/lpvWHZ3yO
         9bcJtW00geKWrH5VJFQj0RtMuzUp+L/udWp6Y7Sutz+PijghwxtQDWHc8MZ8re5p6z9w
         eoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=a5ZXTc9QK5EtnobIvMHwb74DO3C0KGqmP21UwYsPbr2TqjPZAEEIO5CKPHd8IDQSay
         YsRC4PVdBhF7n+lmVlBvM5hMH+zLygCPZkkRo0+yWZly3bljjOeGbFSkccmzz70OHxTY
         03GxxNAUJ9jKIZmM2Y+kXu8OrDpQstq3mtpZQjLXWqIP09qt5NWbnHQ0t8PJrk/Fh55X
         28mCToOesdEP+oH8U8c662l4mJR9IBQniQgVtf0Au36fa/7KuduC4LsrTkIbcbzg1lEu
         YUGN8LTj+xyA3hoyF6MCeVCb+N1VLN2vp7RvkTEyu+E6QpUK9Gwk14uRl+acqZVrOuwA
         iDiA==
X-Gm-Message-State: AOAM532t9YFxu5LRUr/912N9PqP7hpbsEHu3K/QtspKjNMWWs8LSGCYq
        Fypv5x8NPJoSXPTHH3z/4Sxj5A==
X-Google-Smtp-Source: ABdhPJxNWd3M4cRFr5bsPUuzlFPqKIiWknPAwX3WBYB9OYoVFFs1WSG+KDvw11V6w5QEZWs2ErXxIA==
X-Received: by 2002:a05:6000:54e:b0:20a:d9d2:e6b2 with SMTP id b14-20020a056000054e00b0020ad9d2e6b2mr6361745wrf.178.1650918118290;
        Mon, 25 Apr 2022 13:21:58 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:57 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 32/33] crypto: rockchip: permit to have more than one reset
Date:   Mon, 25 Apr 2022 20:21:18 +0000
Message-Id: <20220425202119.3566743-33-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3399 has 3 resets, so the driver to handle multiple resets.
This is done by using devm_reset_control_array_get_exclusive().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index d6d78b8af57c..9ba9b9e433c4 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -276,7 +276,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	crypto_info->rst = devm_reset_control_get(dev, "crypto-rst");
+	crypto_info->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(crypto_info->rst)) {
 		err = PTR_ERR(crypto_info->rst);
 		goto err_crypto;
-- 
2.35.1

