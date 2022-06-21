Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDE553A91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353964AbiFUTaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353910AbiFUTa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:30:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3752CC93;
        Tue, 21 Jun 2022 12:30:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so17990290edb.5;
        Tue, 21 Jun 2022 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=oXAGreYOm6U9pkVcl9Owt93RMP3LFNzhel4cXUURi1+uamUoHKQlBRtaTQlJppmyAj
         eFiw72IyqgxlG3Dz6+OaTr+bjEnQr0oR+hDtIVgawtP4SIzfAv63nSnld1DOeUzRB936
         egOB5PYHb4AxUnGW7OCfsa+m/0ATVAh4pQWv/XPgGHY4LJQl/b87RVo/skV86oGQZrCZ
         Db+ogTLsBqWZ1pvNWGuy8WnZgmtEWNRgsErqjG9YsY9y9AGwsSl9jMAvFz/koxDg5SWi
         f/zyywZMxA4OuIHWpQWuRdRgvlDecPSPardqoiiHij1MgPFDoCCwFxXMt3cn5eWAQmzg
         nXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7nxHvlawisf1+yiWy1FwkyOpuVc183YG++a4GngDmg=;
        b=CaUb7jtL0UiSGS7tsgPACm9nXDAUGHQAyiBwe7QfolPnQGl6IZxKA/RzUgeRFsCsbh
         AngpEfu7aWUUWK5yjdkBAsQtdnixHz6yLmQEHbgYGx/UMnDa/N1D+eCzJdPly4yTeeWg
         tNka761M3D4M+IgPhoIJHVfJ9T8oeLpRf0XR4Z22WYDN0oEt/9kyV9I5AidsJAKEWpoy
         M0y23FnCCXk9Y1uGayjhnz026eFlpmkwbz6STEDFQwegyNx+xx6v9uUF8cx3s+NJGSOu
         +vk85obZewDVe23NmvEqqxNoTy7dS9m6H5DxaD1oyG54zNd8OXStd7Yzt67xuYIhrYAs
         hH9Q==
X-Gm-Message-State: AJIora91VnS+iZIH+/Fu8H/Aq9lm2aPLzrRivnq3rdOx2HVEwpt5fUU2
        /a119uSd8X+u6r72jNAwy5r3RBED58ZBiA==
X-Google-Smtp-Source: AGRyM1v/BRBFCbfV/aJCwAu15pD6PbiuWQeXNXuVos3juQeJtOqFdMNjTED86FlGFPoPwuckz/DiQg==
X-Received: by 2002:a05:6402:50:b0:431:69fc:eff4 with SMTP id f16-20020a056402005000b0043169fceff4mr36767169edu.243.1655839824459;
        Tue, 21 Jun 2022 12:30:24 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id f5-20020a1709064dc500b00706287ba061sm8020586ejw.180.2022.06.21.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:30:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3 PHY binding
Date:   Tue, 21 Jun 2022 21:30:19 +0200
Message-Id: <20220621193020.1630180-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621193020.1630180-1-robimarko@gmail.com>
References: <20220621193020.1630180-1-robimarko@gmail.com>
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

