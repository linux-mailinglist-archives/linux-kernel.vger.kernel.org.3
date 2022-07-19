Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D923579610
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiGSJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiGSJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7312424BF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so582372wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUvxPK3wvjz6wrAaAefISZM8lHT5S+UWYfl0mNo8LFc=;
        b=yHuO7w+m2vULMOjaZc4jlaxpkVrzCUrrdDP2o6ziPAlg3ZOJ2O6uxfX/jHClmyyvgp
         oLIeGKDr1apXl4s1XErTsBIAYR4IQi8e9vvW2wG7ObcE0aFF1+XaDkRn1dFKX0UBAC97
         ICsHn0c+gS1vCcpo/rZkd/oRhDingBIytUi0ySbOSWlXf5OTdfdrkf+4tvt+2B2S8VE9
         8xjerX9Pz+0n52KqxkX1J/XDGHVLeTiXnWiLNeY5wVQ0PZmVq5cSJpLIXsO0mG8wVRyx
         RRufeAcyTnsdI/8j2qSsdq4CY71oEDad8pI3iNc07eLJS2yNy6bBSEDQBO2E0+TyWEjC
         zcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUvxPK3wvjz6wrAaAefISZM8lHT5S+UWYfl0mNo8LFc=;
        b=lwA0NkrrPNNgEcZrLvnUGjFw6c3+abx39gOlQaKDYB/3lk3D4aJy2xXPHXGhbyWC5G
         07SRScI5MkjQnO0LdWqBZTH2plRCPzv0Ommkm6R/3sfwiBK158xartadEApEkWKjCy98
         jwQuFUpa/X9PxAbQD3+3siBheArWcBRSdEaTXNEGn/kOdJID+7EgSBzRSr4thP4ZO+am
         jvKr7CbrGu2/401jYmcVBFjdmkhFB48enPFdfllXzNmrt2ntVBkc4GzYyuHEkFPalCPA
         twTcp95QwbtEf2Fz7jalgFsV6NSjGD7g3JFAdjr8z3GGUvfKVTP2KfTLpeV9CGs5n7Iz
         DGSA==
X-Gm-Message-State: AJIora/A3vKBlakIG3Fdt9308Q8bZqLRCbk88OGXJMG1sKukO7GLezte
        l1NQy27DctZl6Opa/vRIFeVEFw==
X-Google-Smtp-Source: AGRyM1sxc5nUpteA5h6hsnpiYbZzru/E61N6j0MEK1Rw9B+2HbLK/90dY900bz+A845w3aSu+hCg6w==
X-Received: by 2002:a05:600c:3b91:b0:3a3:1cbe:d531 with SMTP id n17-20020a05600c3b9100b003a31cbed531mr7005748wms.159.1658222294054;
        Tue, 19 Jul 2022 02:18:14 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:13 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 14/14] arm64: defconfig: Add tps65219 power-button as module
Date:   Tue, 19 Jul 2022 11:17:42 +0200
Message-Id: <20220719091742.3221-15-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds defconfig option to support TPS65219 PMIC power-button.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f031dd6a9f76..988397574e3c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -412,6 +412,7 @@ CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
+CONFIG_INPUT_TPS65219_PWRBUTTON=m
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
 CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_PWM_VIBRA=m
-- 
2.17.1

