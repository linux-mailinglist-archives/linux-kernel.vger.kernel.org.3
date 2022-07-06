Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8605684C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiGFKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGFKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7164255BB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b26so21339779wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJaroou6RFRRIcoYQ6MD8TjOea6cFRR/OWy8aALAjLE=;
        b=W9NhYK4AWqLyIUUY6oJm55UzVT5vblwkS9xHir1qGjEcynj40iM+PLyqch+tvCKsUW
         VC+8LqHVu4zt7B3dnRPcfwf/yT8LVkbr5PvqGC2MLMuDzLMzzAEVeRE+2Nl/36sdExC0
         EOzeLmYUAB4TXq5srHzeL2nvQjNOrbu5cEbO9dE963RSU9IFNnPYV9TQ97k9tTexDxSF
         qpmRE/HI6rzZHR5Jp4QCL7WJuy2mfGElCTANCpRK6IhX3xGifPIFQwOPBNhkmAXKOV2+
         URHH2ooYP6ABX7qRaUffUrjZQC1UgsuPjlRbMIQmZUke2PN+iucW5T26j3JzHHvkpgKz
         yxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJaroou6RFRRIcoYQ6MD8TjOea6cFRR/OWy8aALAjLE=;
        b=P+LasdiTh6bULaScEgAS2Bc88yHd1DZ4ZvVi02trbgUbTaC5yVMSsj1GIItkSn7vyj
         evjtOZmWfP6VdUkDEJAFwxNBg9l9IGtXFsPmNspxoUTxtUtyGwvVZBarSnW4YVrxGwoR
         jNdEBuksRYKseIvcVaCvQUg4U+ohvcvzBo0UzQWsi0A3qNGfnqt5MR8A4pH+cRn7Aqnc
         Y5x5hgVixrQjLwhWob2/ddzFZiKp1HoPjS94BxOm1I50/kvKBnMPF2NmQPGG9ar9VcDW
         2xK8FgTZN1kNlY2pbEDabdQK1REszCDs7VImJTaQYYSilnWoJUuqxKzkYJOPR/ynzIr8
         aaBA==
X-Gm-Message-State: AJIora+bDQOpU4E0k/J6CSsaazpJYuag5qsNXF8x/WU7x8AtXOU6ULJ1
        xJPbwsCtcqTHprl62J52Upc8rw==
X-Google-Smtp-Source: AGRyM1u7Bwmcpy1A9qZ3DV/VjB4V3kkZw+jedmFXANJaSDuijXRT2hie3nh2G0M2gMVmAaA5QTOrnQ==
X-Received: by 2002:a05:6000:15c3:b0:21b:ac2b:d5f5 with SMTP id y3-20020a05600015c300b0021bac2bd5f5mr35562481wry.607.1657102054434;
        Wed, 06 Jul 2022 03:07:34 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/7] dt-bindings: nvmem: mediatek: efuse: add support for mt8186
Date:   Wed,  6 Jul 2022 11:06:26 +0100
Message-Id: <20220706100627.6534-7-srinivas.kandagatla@linaro.org>
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

From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Add compatible for mt8186 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 7c7233e29ecf..b5a1109f2ee1 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -29,6 +29,7 @@ properties:
               - mediatek,mt7623-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
+              - mediatek,mt8186-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
-- 
2.25.1

