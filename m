Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C829C4C78EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiB1Tqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiB1Tqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:46:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C91FEF98
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so65623wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEFtl1Tv/8nxJX+EKBZcS0Lbq1ln6/kUirDV/Y73Tsk=;
        b=lQx2VbY+csJAyRFIt7eX5IaDOBUSlUvZt2a4k6mP7i9oFSuU1NpSPZPT3UjEEWpzwf
         3FRL8thZISZKU9o4hTP4wiuTTrK/BOfBbC1Dy94eU72AZnpZ7KVccfHPwLpL0NG+NKsg
         TMhNvapt7Mw2X+/IgEG5S1+gJlimzjha+FvLB/Solu0vabZAkAAXtf5cPnTcefa/VVz1
         hbbJYTsQh//MB+2TqZhHAzPEljRiaX5ydBw8Yl69/4HLp4au5KCeNB/CXOTLKfldQr0R
         CMlaeqCy1JhbCKIadokaJUGICFsQ7w8zqpaVrXbTK2FBgrrf+ESmvcBRbeJRAGB7aJws
         5Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEFtl1Tv/8nxJX+EKBZcS0Lbq1ln6/kUirDV/Y73Tsk=;
        b=mEWw7RL9Ha83EnLjyveAj4k/RD7AKoyG6L6H3sfDfqaZg1oA3X/TeY7xi85f8fiIVX
         l/U94/tsVcKBvd4l0oDuxFeZ4X+W7EG8c4d+OoalZhABRM7uiG37W+MICyXVeBSUtVWy
         8rZpoVuHO62gku1F5Om7FB+gBkYZOoOpSnfDgSqJ2DsnblhUJ0drspLKwUSJHgoSBzjJ
         EdvhcYQ5v1JfLgzWE0Za3r324dqd+6+hUevCH/Nxueqk8KME6mgrBUfAmiPH16zFHYVh
         jKaWO6tktvnJtOv0rWOG74hkQxpXy10V5qNxxS3GlQDDRwL7B+lDcng2acAbmfBh0sHY
         njxA==
X-Gm-Message-State: AOAM532QOzEZ4I1c2tDotbUKGwECNDeANRyyGfilgGUoYfCw5YyOM3cU
        QgtVc9VfL5UVyBsgO+yD1yg/2g==
X-Google-Smtp-Source: ABdhPJxdGc/N0K/WMNBAxdA2Xy90225k29BBt3Jrxn5PKmQwrQNvHXH7fJ0r/q2b37gubKletRecXw==
X-Received: by 2002:a05:600c:a51:b0:381:3dc6:c724 with SMTP id c17-20020a05600c0a5100b003813dc6c724mr12829847wmq.106.1646077246583;
        Mon, 28 Feb 2022 11:40:46 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:46 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 04/16] crypto: rockchip: fix privete/private typo
Date:   Mon, 28 Feb 2022 19:40:25 +0000
Message-Id: <20220228194037.1600509-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
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
2.34.1

