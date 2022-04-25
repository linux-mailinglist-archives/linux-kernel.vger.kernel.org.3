Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74B50EA65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiDYUY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245215AbiDYUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:24:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA41240E7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s21so7783697wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=cjdUL5ziwMdVVzxEZfjvHaBI6lZy+g4kq+A+FnrRkmEkrc1OCo1c8EOePImy851jRh
         VtX6/UqmPqERLcaYk7hQUdHDg/s12FxN3i5UtlSfCAkMklTiyFCXjfj42xGgCic9g/nX
         bUZzne+cMIxyiImXuVpHZWU9rYO9rgS99eCwtWZvNymgjGqQWEqibDQIHjTCZ+lfjcus
         NhZDP6bEC32OZSBmgcQp76ToZliVUG5jBSMPXKUeK7hTUPSePsFXyGNqa56shlptqGQF
         ok0UC9qZerwTR6GhsZ2B4vzKk17v+JS1MM4dO1v2ht5xnVgCrJb3PjAWcCCIG43qYn/p
         p3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=RDZ3kLmYVdAS5UEdoNxoBZqKwD9I9Bw1RV+hCRXRRZ+InDeJpIFrdHbBAK0CP4Zvhg
         kjbPhF0k84fz6qhTiAX5ygS8HLzw6Uj2QT08vvI+C+dLAyqdFWq160+31SvhOmX8ialw
         GXvDGTtINpIDwqv1lBRiVCyic3+wpucb3RNt3cov4DUYz6Gpk4sCUmt5TgNiy0uVspV6
         DIT2RVsybstWSIQ/Hd6GOYkR/JQyd00I8MrlGI8ZU3TEo/6e9alXvCx0Y5FyWr4ksxgm
         dz+KHHuiNougWcJzrYr8qEb8D4zSRQ4G0gQUdPTrDnO/F8ZovNPjw1eeiNkPUsQvAFb4
         oXrQ==
X-Gm-Message-State: AOAM531w0FDihwYmH8Hgbg9p+vgePm5Yc6l2orY2izqD+0c5aIZgLlES
        72KVgVQ8UabmguQ/J//DCSw9vw==
X-Google-Smtp-Source: ABdhPJzL6+kxK9MVCVjQ4Y/GIq9uyP+e4ezvDNb7cOKbfr1jUlJXTmUrz7NENZTHhyxXzHwxo+k7QQ==
X-Received: by 2002:adf:c64c:0:b0:20a:79c7:4bf2 with SMTP id u12-20020adfc64c000000b0020a79c74bf2mr15549306wrg.587.1650918091538;
        Mon, 25 Apr 2022 13:21:31 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 04/33] crypto: rockchip: fix privete/private typo
Date:   Mon, 25 Apr 2022 20:20:50 +0000
Message-Id: <20220425202119.3566743-5-clabbe@baylibre.com>
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

This fix a simple typo on private word.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 2fa7131e4060..656d6795d400 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -235,7 +235,7 @@ struct rk_ahash_ctx {
 	struct crypto_ahash		*fallback_tfm;
 };
 
-/* the privete variable of hash for fallback */
+/* the private variable of hash for fallback */
 struct rk_ahash_rctx {
 	struct ahash_request		fallback_req;
 	u32				mode;
-- 
2.35.1

