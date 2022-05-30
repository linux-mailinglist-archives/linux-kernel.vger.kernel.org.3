Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748C7538833
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbiE3UWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbiE3UVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:21:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28ACE3B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:21:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x17so6966666wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1vM38OHwAw07wuSGNIKDmB9lfDMUrNeDwo+6N+zaQs=;
        b=rbdYWKHYaxO3Oo8biiJo4zPn/Ul+w5RbkvyVOEB3/4mnXnlGjHkQehTA3Koq7wkzna
         FanKAs5XeFi7bavoqnYVyXkGtIJPIdz1+W1Nm8pyYiizUkUEFFw2pkjPoQl2uq6c9/z5
         nSjTLmzejeBhrDY4LRaF1mPc7TLZboHRNtzkdVCZAYdDl8Tw1T1NXswiZGzXbcHfoePd
         uFR+KgaUg1jZpAie1lzpXFgk/wiMyjpTZdAZ5Dmq3QX0LgO3CAmoNXcqRjRrVBXUeK9q
         othnVsbT+f1fp5rxwduR7JhVfhUemm9rQOBeheHbp9zfpzNfinf4FFdNzteofmqhara0
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1vM38OHwAw07wuSGNIKDmB9lfDMUrNeDwo+6N+zaQs=;
        b=pMfEyry9Aksb4SuQwF1Na+vc3KzDYAiJMSLW50CQTcqenXxHRqmCRR65v0qmLphxyb
         dCiUjEp6C+ttnhup6vuuwj5z+M5ENZIJC1ibd4nTgSJJDlpc0Q06IWsRkhJ3mOEqnWNb
         Rv37XIEibUWfTLdFPwyx005zLHrxds3IEWtFqF/FGfz2mQkPxoyqhfJeFvZynq+G9zRJ
         coc+p3ESGGbLascbglgCfDE8nfGLoYn7yFv9HjePlLDCPXl8hfuQCyXzP0v9IH9ngD56
         NhJLTMEOv4ndSQmenwE8sfkg4z8+QCdzm/e8fOkq7FY27SNoofL4I47LcuGRV3k1/FC7
         +2Tw==
X-Gm-Message-State: AOAM533NIoZ1aS/nQttTDh4SEgCZntNPzIKz7dlDthgOIx4x3fzZYraC
        suFJqfNb5AhjC56FYoO61Sk99g==
X-Google-Smtp-Source: ABdhPJzqnMXzNaCigIjz1GAjTxyI8tshTxFw9D7Ucx2lKOehy+yE5Khqw9vdo4X+p+YlrV2WOmcARw==
X-Received: by 2002:adf:fb04:0:b0:20c:dcbb:95bc with SMTP id c4-20020adffb04000000b0020cdcbb95bcmr47590696wrr.393.1653942112182;
        Mon, 30 May 2022 13:21:52 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id q9-20020a1cf309000000b0039754d1d327sm261860wmq.13.2022.05.30.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:21:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] pwm: mediatek: add MT8365 support
Date:   Mon, 30 May 2022 22:21:35 +0200
Message-Id: <20220530202136.906407-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530202136.906407-1-fparent@baylibre.com>
References: <20220530202136.906407-1-fparent@baylibre.com>
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

Add support for PWM on MT8365

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 568b13a48717..fd586bc51c5f 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -294,6 +294,12 @@ static const struct pwm_mediatek_of_data mt8183_pwm_data = {
 	.has_ck_26m_sel = true,
 };
 
+static const struct pwm_mediatek_of_data mt8365_pwm_data = {
+	.num_pwms = 3,
+	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
+};
+
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
@@ -307,6 +313,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
 	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
+	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
 	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
 	{ },
 };
-- 
2.36.1

