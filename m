Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564115682A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGFJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiGFJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:05:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DD224BE6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so7903496wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YefmDD2ry3pwsMvqRhlFBCTRYluZUGamucEuHQLyttA=;
        b=L7ciS97RLhOsfeKYlDlu8uDqvlYHu5nruqE3Z1CfDRdMSrwQf6knk8+pVieatsISs9
         Of0f745OYA404hCWfAOC33y8Pbuj//tIzFKT9F2/QfHQUVaxwVZMuc1GzxHfe+YMU8ny
         BQx7w2gmkVRQTqY3MKq88QPjKEt3J4loRHPXZ36XuTbmtcWnrcf2QPeNSlp+WJUPnDSR
         UyUTpl7VQhBGKBKHal/IkqvfX8qeyQeUzJ5lcUXnAc1g2VUHq2A+KSJ6AHAWqGG+3lPV
         iKP1cFPhrjskyhvHotSobOUfRmL7bKKpio+ustI4Pb/bGnI//Z/2vFkrxfdirWuHiWYa
         2vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YefmDD2ry3pwsMvqRhlFBCTRYluZUGamucEuHQLyttA=;
        b=jZmcTUoB+bbJNk7VdSP16Zb0LUt1DQ7j1kGRM4pyPqNXdsA2P6/Ie+KNhhIGIImnse
         0lyutm0+uH6RESbFTqFrY0y9EfNZAWz+sNXmzSUAUWDwKf/uAt1AmWmMGcTaO88Khybz
         6eZtOEV7eJY5ugZWrzpW6+mQsjdg+OlnVxwgW1vR2EZiEa3AqOI3PZNY6xvffjhB4Myz
         1gKBNU4MnvK1fjDeVQbIReRn9k8C86ymJJ0MfQLW+JWT2+Nx6Qy62Til6mniScr3pe6d
         awxeRizGYJPwTm9HvTv5kzogC+CH08P2MhkVGlWiGqXT6Yfr0RrAN7Bt7OmXrk7+NA9s
         UxvQ==
X-Gm-Message-State: AJIora87cpEkFlibnamBSd+AMOwBoWfQh8CVjR4eWfCfZGzrBDGjrbxl
        lkVXxvhqy9qdTMAaUJkIAdm1qw==
X-Google-Smtp-Source: AGRyM1tP38P1u6ggCE6YQXSuG57GyJD05zvmba2ae23fJzXhQ4yWNHlDdFkZuypKNNeZIaGw6Pz+fw==
X-Received: by 2002:adf:fb08:0:b0:21b:af81:2ffd with SMTP id c8-20020adffb08000000b0021baf812ffdmr36962812wrr.685.1657098291934;
        Wed, 06 Jul 2022 02:04:51 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 18/33] crypto: rockchip: fix style issue
Date:   Wed,  6 Jul 2022 09:03:57 +0000
Message-Id: <20220706090412.806101-19-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some warning reported by checkpatch

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 1fbab86c9238..fae779d73c84 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -336,7 +336,7 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 
 	/* for fallback */
 	tctx->fallback_tfm = crypto_alloc_ahash(alg_name, 0,
-					       CRYPTO_ALG_NEED_FALLBACK);
+						CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(tctx->fallback_tfm)) {
 		dev_err(tctx->dev->dev, "Could not load fallback driver.\n");
 		return PTR_ERR(tctx->fallback_tfm);
@@ -394,8 +394,8 @@ struct rk_crypto_tmp rk_ahash_sha1 = {
 				  .cra_init = rk_cra_hash_init,
 				  .cra_exit = rk_cra_hash_exit,
 				  .cra_module = THIS_MODULE,
-				  }
-			 }
+			}
+		}
 	}
 };
 
@@ -424,8 +424,8 @@ struct rk_crypto_tmp rk_ahash_sha256 = {
 				  .cra_init = rk_cra_hash_init,
 				  .cra_exit = rk_cra_hash_exit,
 				  .cra_module = THIS_MODULE,
-				  }
-			 }
+			}
+		}
 	}
 };
 
@@ -454,7 +454,7 @@ struct rk_crypto_tmp rk_ahash_md5 = {
 				  .cra_init = rk_cra_hash_init,
 				  .cra_exit = rk_cra_hash_exit,
 				  .cra_module = THIS_MODULE,
-				  }
 			}
+		}
 	}
 };
-- 
2.35.1

