Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC55D57F620
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiGXRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGXRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:25:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F1A10FDD;
        Sun, 24 Jul 2022 10:24:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b34so5488397ljr.7;
        Sun, 24 Jul 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzzappSQtTkOMAtMriBW1gNBijXJuuoCP7t8bnvHFRQ=;
        b=X49vyZ5hV1IUPScJ5zWwUZLwmJG6u3WA4H2k55I4favrQmTGiaUC3+pc9Uhas9/zU1
         82CFBs2eXXuwGHCX71DMXC2TUVUfaEv0jIY2pUrCBW7zM+0CXPx6X5wbComhB76fVbPN
         E1l8rqqlUBUW7QZOv8Ui7uoUxRoKdJfqfxtYvvNjTDnM6FL6iVjqKkPbid1+v8k60UPr
         U52fEa4rOrbuLFAfVssKhT52abNuxhukJab3lzpQ877ouMW05veLY/weuLqhzf2wVeQ7
         itNw/1OkXg2b38e5ggJW41igNDW/HUmpJIlxoxgoYqqNS5y04r1E/fBIcVnc98aFYhlY
         5ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzzappSQtTkOMAtMriBW1gNBijXJuuoCP7t8bnvHFRQ=;
        b=dZQI0tmic4Mf8EVnYEYT0gYxmym1jH4UUUJ52XBo48QqibG8moY0spY0FAoEBkVRTA
         Yq7RuDX+yO4FowX74qMfqcGW/EmxCsbs2Gme/YOtoTZoBYWlXZoz4snmqJ0Cir2ia/2N
         V8ZzBRy6+DmpoepF/Tj1lhWEVftYCZCIHp3oay+KOm70fkzcrunnNxokcUxblGqs3UzV
         a1Y5o2ODcdWBh9e+FrEA4jLWZ/u8by7zmTV+Cprh8ZNKEJA/Co2rcldXSpS648BMmH6V
         mIzI6mkqIwFPcSTKMm/qrORopmwUqx9gRxWn/1lsBIgL8M5V7iPzV452NJYIqvsPnM8v
         hcag==
X-Gm-Message-State: AJIora+RZ6s4XV8Xt9hPyboMgt92WS32tNJRMPu31dvKOfgXI1U/aPXo
        /GZ0R4+TsTNJufbz/5cUOySS6xFrTkMN+3XC858=
X-Google-Smtp-Source: AGRyM1sd8l4ptrULcdgHJaOOHAigxaiQxUgXtoWErgSJOPXiPZ03tvRYpJS9zBVF/tKJqLIrn+0o4g==
X-Received: by 2002:a2e:895a:0:b0:25d:6815:98ff with SMTP id b26-20020a2e895a000000b0025d681598ffmr2867171ljk.189.1658683497738;
        Sun, 24 Jul 2022 10:24:57 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a19f247000000b0048a73d83b7csm1928322lfk.133.2022.07.24.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 10:24:57 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
Date:   Sun, 24 Jul 2022 20:24:40 +0300
Message-Id: <20220724172442.87830-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) wifi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Change codename to matisse-wifi
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..5b5b0e0ee8e7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -104,6 +104,7 @@ properties:
           - enum:
               - asus,sparrow
               - lg,lenok
+              - samsung,matisse-wifi
           - const: qcom,apq8026
 
       - items:
-- 
2.34.1

