Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3374EFB05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351954AbiDAUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351902AbiDAUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95197270853
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c7so5895640wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=Lb5n5i1kwsqsUD6MLQa4/+zikxINvmV9nVCpdINstuKiWo2HdMvTxFY4aFDIf2sBMv
         xhK/WSKGvRbKlkgg0/gcnon7jwZS/MiiceXvKhVxta9CC2zf9BXRIwNGu9eXjrTHMkkv
         q4OmpvGSlvQhAHJzBHuBgWL4bzeTclylXt8HUZyufKBXPc/IvjDZPD1FOijx7fzvlao8
         eAa5fHLIj2HkX+q/YzcXh+jGMn+t12W0HpV6MKr9jdPNPwncYfgOTsDXQvaxFIgblndy
         8DzmudmGlHF2p6bo5rSXP+JPEPM4CfyJWY+BYQBialeanp8CO7vj7/HWcSxLWsHd1pZg
         Dq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=bMMtxWt4llaE1JGKzGwj2aE4bblHxH7i2T9bCLirfrd0cwaBrkruAt2BWYnqebIa4X
         aBEEKr475zG68rBbjYTEc2JPAV72sSC23WzcqfZWPf5GonfqdSXMfOXQx/74dk9UYDrg
         46dCEWivnD4eqakNN4N3NcFwIFnCEGLQpwFnXlPheYcTlLmAXDiNMhvMgfVYUbRM9oL8
         yQTVntfcEb3/tu4TaqeYwk+NvHBX29RnOBoekSjuYCTkIdVprJA70nWV+NS9WahgPKGV
         hb1iLUtEzh/PNVbzJLmHJJapNuDJeGOeWT8/K3RFihnQt3eCOuSc+7tKotZV8lv/T3cf
         v/eQ==
X-Gm-Message-State: AOAM5325ISQfRuF8Le/DFghDpFSwSfmkJRKuz7PTx2iNix3XhP9NY3VA
        o21wB5Li6PxvxF8R03+Wgcdd4Q==
X-Google-Smtp-Source: ABdhPJxq4j0JuvVD2vxeCC6tsWwu2zvkWUWadDcEg3yk+W7I/ic5Au/8aGiSXKdMb00gDQUTn9smhA==
X-Received: by 2002:a05:6000:1ac9:b0:205:8461:5664 with SMTP id i9-20020a0560001ac900b0020584615664mr8830350wry.123.1648844292144;
        Fri, 01 Apr 2022 13:18:12 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Fri,  1 Apr 2022 20:17:33 +0000
Message-Id: <20220401201804.2867154-3-clabbe@baylibre.com>
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

crypto_info->dev is not yet set, so use pdev->dev instead.

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

