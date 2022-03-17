Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04E64DCFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiCQU5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCQU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51E154496
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so2977212wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDPzallkxZHrwYGOlhVbPbIqdaMTkxdkI7weP88y4Cg=;
        b=F+oR8ZJqpHJsxjl0c3X+43Uxvn4qu91BG1wLTrWZa6BEx6hfV5Bx/jtufjc4fYKiTd
         niZ2DOD0y9nTtR8fpiSZUYWmZK8Lo9L4gznSGEYBYNMW1luvYr8hG4WEjWcA9J3aX8ka
         xGrIauj8hye7PYByLPCzkKEihjbxWMv6ygX10GFjp9BWh+R7d9qEu1i1rqTEu9q2AlG6
         ld3rIaiffB/vSsYldxmLqijnWhwpwc1RYBsaVsBBD2IW71FqrifEycqj2MTUMa9O4iz1
         +1e4YA2nImwikiTMxsrDb06O99jUtwND3MDsXl/ru1HXCmMVl+EFN+C5Dz8tuhG7PJjx
         Ckjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDPzallkxZHrwYGOlhVbPbIqdaMTkxdkI7weP88y4Cg=;
        b=Id85szXMImydftBYbee7qBzy1ZmseBj7+9re7wSCqiNvp5QTv3s8xgtmUtNr2QONz3
         vnL6SLGPcvInvtcswyEAeU0demtJEzznEeHKZmRqkpQUI2EucSaJZ/hVhMeCDEo7yo+Z
         3m1I+5k0N0rOsQyrYVW5A2SzgCmF5phb4Rm9Fkfeqb8jmwMAjIkUDAJPtWViYjrde5N1
         INkjG/lgsL+gIbaA9cNMeXoK6wG5PkYW8t8+fS/KtF/uXtYJ4suZuOmhmygpAnc/IAQ+
         rvFUPrIFv/+0CrOMkjd6E8op+Q7DlPlFHoHs+oQwLRi0h2+GmdRAjVFVyZPWcgTUta+W
         PX4w==
X-Gm-Message-State: AOAM531yk4wvegC6G38K+T9nzbWHQvcxG6N2RYUjJn4bBwS/sOy3Fwhb
        RZkRVL3TwTwFCZ4ho2TD36d+vg==
X-Google-Smtp-Source: ABdhPJyA6v3tzW6pBOq5BDaDhMkbXkD+9ITBlMrutFmQXIA+EA1OcHttTwjC8fP3bmUU6MYWk44YAg==
X-Received: by 2002:a05:600c:1f11:b0:38c:6ce7:69c5 with SMTP id bd17-20020a05600c1f1100b0038c6ce769c5mr5690186wmb.64.1647550572234;
        Thu, 17 Mar 2022 13:56:12 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 01/19] crypto: sun8i-ce: Fix minor style issue
Date:   Thu, 17 Mar 2022 20:55:47 +0000
Message-Id: <20220317205605.3924836-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
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

This patch remove a double blank line.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 35e3cadccac2..01d032e08825 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -398,7 +398,6 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
 	sktfm->reqsize = sizeof(struct sun8i_cipher_req_ctx) +
 			 crypto_skcipher_reqsize(op->fallback_tfm);
 
-
 	dev_info(op->ce->dev, "Fallback for %s is %s\n",
 		 crypto_tfm_alg_driver_name(&sktfm->base),
 		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)));
-- 
2.34.1

