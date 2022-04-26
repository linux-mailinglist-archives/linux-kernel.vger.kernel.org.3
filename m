Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53F510724
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351930AbiDZSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348811AbiDZSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:37:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2760065
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:34:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so37811816ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I36VwtUeuAmuD4bFbNMu6bpDdj7jTQxYDk6uobWAz4I=;
        b=CSDcGpGYwWyi+nQU+QfG4w4xt2JugtgrTpyEtNtutBA+oc3F4R7DvwwsgFe53SR/G7
         DLVv0C0TK6QT41ZWb+XnlfrZ1TGqOyVkbyu6yrZsB+zQYy45spAMBqiBuOubQ9BSXJCu
         LqCOgzzvLvmkdUuyr5nsztZ4LADuWO4RhV18QXGMAH45tlJa5A0kpNl1Q3Z6Qxc4nwZX
         rNO/0HmEoVuUkzBIrzR17BPuAx55VoevddCiX3aW9ftyZwtFIFkrugvakhlWRwpVrpaz
         pBpxTqNbrrlavAVZWw6pICQbfulgC75uUZKZiLq9K7CExLa6qfv3mSIaWdpmZ0w7pQae
         rm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I36VwtUeuAmuD4bFbNMu6bpDdj7jTQxYDk6uobWAz4I=;
        b=qg7tHGie8elbiz0PHpKwnpcoRD02PKGW337n3+UQPdbGnZ9uCjXm8NtNNWRijq1r6C
         tslpIACNBD1wJpcfdyXKZGoWNuVQluQxKsw6tNj6UG/QQNbp3ow/lvE7B1/xAaXZXYUb
         mXFEgeQFl8L1ZXkCxfko6JTDWJsxvCSCII12exqE2gBtbjO8DL5G3Zd3ebXNng9p02gn
         uWFCqNxgCqFwlOa9jE5OkfIup3Nuoc3KmjFDxJM+b7seA18HzkMSkXoibBYy7HRy1Zzq
         AOecVuRMxqZCodKy8n9krqGAs37iJYhO4kFdVPP8p8AotrHqgCPSVv09NmOQxAIsoTUX
         g5hQ==
X-Gm-Message-State: AOAM530aqODRUWrcVN5chhZr2q6ITtQqp867Uq5FQkVWMZgOIrs0ME7a
        h+d6lrGTwywh+yN5QOb+rjxXlw==
X-Google-Smtp-Source: ABdhPJzv66jM6MIqRtt7g5BYGXZjhviSioV3C+dNgc0TitekVscN7XXrq3vvtBMi+cECjIvjLanl0A==
X-Received: by 2002:a17:906:7c93:b0:6cd:341a:a1d5 with SMTP id w19-20020a1709067c9300b006cd341aa1d5mr22084235ejo.698.1650998088759;
        Tue, 26 Apr 2022 11:34:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709060ee100b006e8a49f215dsm5292323eji.73.2022.04.26.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:34:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
Date:   Tue, 26 Apr 2022 20:34:43 +0200
Message-Id: <20220426183443.243113-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung s524ad0xd1 EEPROM should use atmel,24c128 fallback,
according to the AT24 EEPROM bindings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 21fbbf3d8684..71293749ac48 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -129,7 +129,7 @@ &i2c_0 {
 	samsung,i2c-max-bus-freq = <20000>;
 
 	eeprom@50 {
-		compatible = "samsung,s524ad0xd1";
+		compatible = "samsung,s524ad0xd1", "atmel,24c128";
 		reg = <0x50>;
 	};
 
@@ -289,7 +289,7 @@ &i2c_1 {
 	samsung,i2c-max-bus-freq = <20000>;
 
 	eeprom@51 {
-		compatible = "samsung,s524ad0xd1";
+		compatible = "samsung,s524ad0xd1", "atmel,24c128";
 		reg = <0x51>;
 	};
 
-- 
2.32.0

