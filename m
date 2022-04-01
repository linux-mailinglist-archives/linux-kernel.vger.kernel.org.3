Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A217A4EFB13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352011AbiDAUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351937AbiDAUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C136270877
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so2154956wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=KxcxtcbRb2QPgVauezedV7SNYLp5vmgrnnYhE00v0LZbmM6JqQASdazz176kksIVQY
         BxP0dW3xTidets43zID6Q986jQbuLAr4pLOapROvgXbDtduSqxudXk+/9sMDk14WaxAN
         3sWgsBLDqkr3F5a9fha4I7gWSvQgzr/2JSEFmnLw+/sbOWbztPJ08dTZjIo2eE2Ls79B
         tsPtZoP74ZxmBwAT54g9XchOKH1wC4lE0Q+l+SZTgFFXRRF+ryEdl8J3M2byJeg7C5Xr
         GLmmyLryweoDTXnscdokkziggZBgAOkIV+73uachetlN83ZCXh3cjjbb0xvzO97UKSGH
         HnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=LPcfd9p0wK8I6vmIKACp2u5FjMasGD2r98MYfTbfWjPTZL21AKrZy1xGXbnaaEO/n9
         Ri2fPJd958xRJuXK2hsn7+Q22EepG9LDgZMaDnTzoFZmvnuDUdnZcZA+DmWQxQ7fV2dG
         EgVpYQBQrN8qpiBXuYJvfcgCsVNCrjTH2WUlVQZoG4Jr3iy6+kwPjQyLzwCMl6pKpjPb
         VyaAFBF3y2mIrgCrMy7Jws0FWTKwCni7PZijFtUcq+9ZzRallQaDJl43dc4EYFP8sjdQ
         5fPQy64dewzVguGBaS/oclP9gL/dT3V+85wi3UMEqh1O3/yjyKVfYGI1boga53uQuM0X
         uuww==
X-Gm-Message-State: AOAM531gDQmKu/16IXMyGPsEVY3vSITQts3ynKBwo3KCxQhP8Jzs3SUT
        C3OhvN8S/CtVQVd/00UhUnQxEA==
X-Google-Smtp-Source: ABdhPJyaIe8Lc7psoRcrDK2ZUQlV88j42ewUBPlq5iu0doBl94rx+Sy8DDzBtsVAMdfXe0hJ+AFlRQ==
X-Received: by 2002:a1c:7302:0:b0:38c:bb21:faf7 with SMTP id d2-20020a1c7302000000b0038cbb21faf7mr10125930wmb.31.1648844293709;
        Fri, 01 Apr 2022 13:18:13 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 04/33] crypto: rockchip: fix privete/private typo
Date:   Fri,  1 Apr 2022 20:17:35 +0000
Message-Id: <20220401201804.2867154-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
2.35.1

