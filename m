Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4F57D738
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiGUXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiGUXFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:05:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A280A77570;
        Thu, 21 Jul 2022 16:05:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t1so5055938lft.8;
        Thu, 21 Jul 2022 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN99ibL27sd89rmTxBxPykp3VIGel2d+t8Lze8xe1vA=;
        b=Y9AIoMiVdrO8GYc0hnyqjpIvRZU+QD+FqI5IzVIcQTQhaP9Ss2mUL3NOebOP6mMn5x
         sPv6U0mfvbDtBaKhUriB1467nEZVTctGfHT2nIvsEEnOM1CORfwRtgJ4EFuX+RLl3iji
         C4DuKBqH+yFNVK7sQnOrKaLwSwQI1xqGQ/LUhDhFo9+gUke3uS6zMoo5SkSloEVFYSXS
         p2y5bKYSySGzma2irXjsA3Qc7bM/LcgI8GDKodh+8n3FP5/XLBLJZxl+d0BMG44RLU0e
         zVrX8hH/MKvCrOw8Z8Mgr59Vqp3P+ZLHeopeO3tkvpMhwfWlvDFWbZKgOKZ7AvPhOAar
         mgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN99ibL27sd89rmTxBxPykp3VIGel2d+t8Lze8xe1vA=;
        b=nFSJtRnWybwlLNmujS2X4bGafZt7XIB1M3++Td3aEChcoTc94/zh07bcdmFSELETjw
         EiQKpX5MbKAWQKnEvgHvFFUCqzYiYTZwmU02CTMSqEC1Ju2Q3mPHyAzYAblYvV466ZAM
         hKCEjPZkyAC/Dnkg97hHgePvl5dB6vpBdP5tWOe/vEzRsdXlPkWC0AGD16BTlIBbPltk
         MWh3Rc421ggaparbbbz3upyNiz9PMww3EhpvBetAm0xC0q52b9NWaZ6FjN5FU/gfHpm8
         A/GtdbEp80s7KwU925ATmbUG/X1DNp5coGMArUgkBnliyzmd0ReYerOnz/Jgu2R0KBmH
         VyPg==
X-Gm-Message-State: AJIora/AtPH2aNG6hwkPAH2+PmL2/noUmybFpkcdw79m2y8zzsTW55C6
        1+kgOQNoPWeCy6GzWRKjqJ45/f9qH/VQxhvpdjQ=
X-Google-Smtp-Source: AGRyM1sSSM9Z5F/yVYXbY1wE294+1rN6YW0jdfZhGDeYYG695Gn4lpXnZehuuS72rACNUs9QqlXljg==
X-Received: by 2002:a05:6512:39cb:b0:48a:ef9:46a6 with SMTP id k11-20020a05651239cb00b0048a0ef946a6mr250675lfu.193.1658444740955;
        Thu, 21 Jul 2022 16:05:40 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id g31-20020a0565123b9f00b0047fb0d5e049sm701360lfv.273.2022.07.21.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:05:40 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
Date:   Fri, 22 Jul 2022 02:02:29 +0300
Message-Id: <20220721230231.98886-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
References: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
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
---
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

