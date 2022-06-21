Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3290A553ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354111AbiFUTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354039AbiFUTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:55:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755BC28E14;
        Tue, 21 Jun 2022 12:55:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o10so20837363edi.1;
        Tue, 21 Jun 2022 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=Of9IoRCLVu5v+Z5ddV72KVppR+laNfguuEbqBT5OxjDsIhtr+p6dJ/ayxexE+Sp95w
         AL7Usr1LVie3Eb1navS8t/NjDHi785NBlKMjwQxUfqRXb7nlwke06jd4rqynA3G/byjs
         Grk2pg+h1sHX1kPsFz8cNXb8NIuw2a9m8NtV4Utxid4HcOR+aO8saZiBTI8ym9I7po1C
         /JBOAqF6Dr83/efUf7dTKR/C9wzPKahL9hsqG7xg78iMZai05Or3WvaUV9+nSqUrgESO
         8Gp6NjYLslicqBfYbhOtT/V1hdNpF3p1pEZWqLX5VQ21b1qmvNkSc5vFhkKs88zKnkP2
         IcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=c1O+BgW+aPqeBvqQOQxFXkSUe6n/jVdStzBNKiimRGDd4ss8nK/us+IjOG1rT60dj9
         AygCvfQCpzOu68VpEwrSc93aJ0z2PaKo76ukoiy8tAIFvnfj3bfyy2IC4w0GtFx7Y3FL
         HlF9vo3nveZgaTXNoDK5fLwt9owVW0YMDFO0WQT3V/nEmkhlwHiRNeRL7Ff/Egw6682F
         /nA5z4mzOGtyGr6KE9XrAKquAHFNDAm5gNJfZfHj80BPinjY7krOflUVhNzwG422WwTs
         W23AjNVO08m5mtCB/yCbUqRhrG3rL13IRfwGHhDzp7XDWhkq3yjTut5k3fbbj23OHN3w
         hrSQ==
X-Gm-Message-State: AJIora8mSEnhPDOX31gt4jK/vkBSw07qcRkmMcRQKMd/hXYyIbe4frNk
        cloyH/ImVnPkU49bA/cYVPXN/qGzJ9dvCA==
X-Google-Smtp-Source: AGRyM1ulGRkk8/kYxv1RJHx/pF7nhbd80DwOp0kNIGeWuw+yvL/4Hu1TFD9TVkzAJDaXo9RG9b8lFA==
X-Received: by 2002:a05:6402:354d:b0:435:93f9:fc0b with SMTP id f13-20020a056402354d00b0043593f9fc0bmr6587948edd.288.1655841316086;
        Tue, 21 Jun 2022 12:55:16 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id b14-20020a056402084e00b0043565c79879sm10713114edz.43.2022.06.21.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:55:15 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3 PHY binding
Date:   Tue, 21 Jun 2022 21:55:11 +0200
Message-Id: <20220621195512.1760362-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621195512.1760362-1-robimarko@gmail.com>
References: <20220621195512.1760362-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has 2 different single lane PCIe PHY-s, one Gen2 and one Gen3.
Gen2 one is already supported, document the bindings for the Gen3 one.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 8b850c5ab116..220788ce215f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq6018-qmp-usb3-phy
+      - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-pcie-phy
@@ -312,6 +313,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-gen3-pcie-phy
               - qcom,ipq8074-qmp-pcie-phy
     then:
       properties:
-- 
2.36.1

