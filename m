Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59CC4FFE88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiDMTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiDMTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234946E564
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x3so1681126wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=0+C6Qtec0B3cxtI8hQ7+5AaUwzZpKeedDIxHRwF6kg26C6z5E0gQg5fzxViZaXWWr0
         LpKCYiZx9zOnCr073zRxmkE9adjWpuBQUT3gFIoOFljLl7uwaTd2u5qVi1uhD4dve56I
         XFpmauVUwU0ui+/bi1s26wYA/KKin38UZO1pca6AYJlesBKqq9LeZLLtx7u/c1e+Ve4V
         3r73e52rOJ9RRfEXzhHTV9vGNCVOy0/bzpNhSRqg5gxQZMtSvBNPDpy8S5YkD2AZqWeJ
         zZVxrxDU37WfINUNkiCvOJHaoR824Ta6zLOQbiWLzCOfO5BDMOgdDBdRaGfVg10SosMZ
         XkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=OMkE4YHdIwVkWQeWcHhmg6PnznqsWsIo7+gA4J/JV541h3lnd6ucD6b3OmAr4yFFtt
         +sO+iF8yhcwNf60i15ijzhPwTgiKHWohPK9XCaB+o5gGRodQUx2avWDPQD/ofqiNl5Bk
         VgPnaTQsvktkqxdBs+TxDDjensrBXbftZmL9HSOLyqpMa6SPwcuKcczk1etY2kJZKYI/
         y3bWWGHZ2j76299bi+U2YOf7P9W6cfb5IXqEcvD1HDKltcuvpqSFDd/YsACQx3gNcTUO
         QTY0R3jQxVv1AvcfT3UcBh3cErSUJBvze4ccGL07ksJUEqbRZy3NbR5Bo6n+bobhX3e7
         5fzg==
X-Gm-Message-State: AOAM532k9GinsAjhyD9LE9FDzPG/VWUprzyquMNlRiKjdlDuO38JMYpY
        lvJpA3QO1AAwj34bD2B5gdNHAA==
X-Google-Smtp-Source: ABdhPJx1Gjtc8izayGqu0sc2TncLxcVz1bg9m/bNlpID/7ijNYiFAxDc3MO/z1/WPyNVBlTUDwaRUQ==
X-Received: by 2002:a05:600c:3493:b0:38e:bbbb:26f7 with SMTP id a19-20020a05600c349300b0038ebbbb26f7mr167635wmq.114.1649876843673;
        Wed, 13 Apr 2022 12:07:23 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:23 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Wed, 13 Apr 2022 19:06:42 +0000
Message-Id: <20220413190713.1427956-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
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

