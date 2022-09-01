Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F295A9794
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIAM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiIAM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD8972B7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so1308850wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5oq+K0wpCSsh7jUwt6+vmm/hcvr/21v0i001Dyw+Eww=;
        b=DdLEChHulzdasOuIWPUlvh6/dx1pv3JVup4WbLGKn8GZsDUWAeHKhRXg8s3zgqoS4D
         zfCnpWVLLQgQDTgIhJgSaYxq+gtoHzG1yztUdHZk7U1Vb9/PzweyZfmYzy1j7qGMYnp8
         hFCGKvNcS5LLVeuc54F3KGX0w2Fvuf2SVvVrsx43CmfrvZ2Evu8fU0KYNTCojgdBwW2W
         hNxd2bhrWhmMpKUWXkZmaHK8C8bnBhnTyQ2tpAXZMXzIXdGgb/jPCxZvPqxoSXN2wKUA
         UwqbbkRJlL8aUniD+sedCbytuSuM+u96t5FxdGx5lcNS93a0JsxwRVL+Bc8tVYjmaGEJ
         G4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5oq+K0wpCSsh7jUwt6+vmm/hcvr/21v0i001Dyw+Eww=;
        b=zV7c01xXEsJ/mEIrFJvQOvUvCa4cK8lnMIAon7jQ+pAjpplpt7FhA2eQwUPuXAYYLR
         LNzsy8/HonCrLxhwQTWONQDl7aoWOAbcYMRUfjaBtBnjvk5uPt8qVue+ha0ayNSc0Wci
         lEe3hbKPx+Ds+qzAo+Uo7I4Ho517TqZYjRZ9nleT/scUQkdzlY4ecJG0ldKjkR8i2ZWI
         NJURPsjJSBXcPwYaTTh1b3woGJyIvFgeSKQnts9BMvssu+dgxlK1338vjF0n7aYDN75O
         KHgKW+l/PdSOj9JoT+WYYy8IcnqlEepVTcWTLlZ2rZhLybFrDbW+PiCaxcmq6ss/EBLy
         CbIA==
X-Gm-Message-State: ACgBeo0FFw7yol7bodtnosf3O5RLzLEBEMsAM0onslnY0wW4RbCOfXw7
        UTnpyeXlw2wuIDcY8Fu1WyKYJA==
X-Google-Smtp-Source: AA6agR7sSVB8GDqHA/SNdpU3efGHrOX2Si3u7vU37Gf21cUjmMfyxBMIMocd/FwxLdJzZOAFR16rnQ==
X-Received: by 2002:a05:600c:1e88:b0:3a6:2ca3:f7f2 with SMTP id be8-20020a05600c1e8800b003a62ca3f7f2mr5333101wmb.7.1662037038960;
        Thu, 01 Sep 2022 05:57:18 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v9 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Thu,  1 Sep 2022 12:56:39 +0000
Message-Id: <20220901125710.3733083-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
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

crypto_info->dev is not yet set, so use pdev->dev instead.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 45cc5f766788..21d3f1458584 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -381,7 +381,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 			       "rk-crypto", pdev);
 
 	if (err) {
-		dev_err(crypto_info->dev, "irq request failed.\n");
+		dev_err(&pdev->dev, "irq request failed.\n");
 		goto err_crypto;
 	}
 
-- 
2.35.1

