Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE65684C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiGFKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiGFKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9F255B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v14so21322074wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cCIfCk0PS+dyz7rIB5P1DspSw8HOWC+zkE/AUtkHdQ=;
        b=Z3MQlNslvaTMUV7hT9QSB1qCJO04cKka/LCo0Hpq1NFnKVQrV47fDAhLVW5Qd84ZXz
         MkJZTY0wRA/73J5fOdU1iGmElV8FnlHVJsaHAzsjSFt3zfx0UkKybH0M68/AfzmdS+ut
         feC4ixr95nHpKfEAccTy09sCrXJBl231/N1Rsw114Q/9L8tnaK12HRgeHLbJaigumjUA
         aPZCysoZ47CeHEoLdMHhd1bQIMXbinwK5dSgIoJGLNzmowmzB0dCSn8MXJIEtd1IJ5dT
         xXEhvAiqX8DUOgaI1xflB4E3UGbMcU7YpKBG9pObYMcdsYfPBPCRDixo4LYbP31Z47tJ
         eqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cCIfCk0PS+dyz7rIB5P1DspSw8HOWC+zkE/AUtkHdQ=;
        b=N6A1MuD6pqcrXT3CCmfEUukJ2I4cjnWenvGiZyngbjWqrycPPD/2T3AvVkhjiDXDJR
         yYYgfj40ToVQ6TTgk+e24mbPZ4jUYz8VvLXs/eoZskI98iAo3q5llAcG6A6AsZaod7ty
         gwe8TbicQME0KtpzfUkhZ8zZtWKiKbrOnyeauBwTCHcEpwegK54jUyQsnqezn+Lcv0+i
         2FThhui7oIIGOW04n1d+J/4cGfR1ntiW9x+3B25IqrVe7hpkfxfYqWvzNrYEH2BnBhh/
         kjRT0m0/afYCIuAjWFflmguhq4Z8Mc2KmmrreU/h+0c9s7KieHR2MaytNvuwVeiPvdDh
         +Bzg==
X-Gm-Message-State: AJIora9kRCIdkWGoGQzfZCO1dTBqGHtUnzR2dq6WYIRHeZE5GEqUma/Y
        ArbNXxBJMbl5v/FvuMF0qv+DHQ==
X-Google-Smtp-Source: AGRyM1s4jud/t0ZiR3YanCaX6xahLItsT+TBGh9qS5k8TO7r1/mjAxsB2m9Ma8RHDVvJnsF8C8sUzA==
X-Received: by 2002:a05:6000:1acc:b0:21c:439c:7074 with SMTP id i12-20020a0560001acc00b0021c439c7074mr34665051wry.686.1657102053306;
        Wed, 06 Jul 2022 03:07:33 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] dt-bindings: nvmem: mediatek: efuse: add support mt8183
Date:   Wed,  6 Jul 2022 11:06:25 +0100
Message-Id: <20220706100627.6534-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
References: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Add "mediatek,mt8183-efuse" to fix dtbs check warning.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index f6e01ddb7499..7c7233e29ecf 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -28,6 +28,7 @@ properties:
               - mediatek,mt7622-efuse
               - mediatek,mt7623-efuse
               - mediatek,mt8173-efuse
+              - mediatek,mt8183-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
-- 
2.25.1

