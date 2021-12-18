Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C54479B44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhLROSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhLROSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:18:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92745C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:18:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d38so10934740lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 06:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8WblaGQz6ryFLLScobJs94F8J4OLcqDAEfLcm+yyh0=;
        b=yc8tP4MlDZSg4AdI5pHBDGftlda0VXP5X0IlC3TWVo9w2K2ZN5SWTp8jA4hP9dLiPo
         ZX1pVuXizbjf96W/2nbusiFg9RJxmH3KrL2XBuY8xYMW+iCd92g3Dil3o0ZeAX3k5Bie
         KQHXUtvs+KbzMhU6daiiX4iXs37lT3dNyyNdcXRq0GWGj+b2ckcm9tXshITgu4zHR8OG
         YufYsoNyB3+SoGw73WUPodX35eKa6eH1vIZ/0ZT7IhTJ2RGo3lHhcapmuVc9Or6u1A3N
         QnAHAWob+XWwyOMmjn2w7uVcOobbcAT0NKBHkp4HsO2NZSX5h9FQK6v+gZZ6625mRcW0
         fBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8WblaGQz6ryFLLScobJs94F8J4OLcqDAEfLcm+yyh0=;
        b=oEsyvqOo0+Lgbr6pOIQGk19nXmErckRkhFoFiSWl+dyMbtWAh+3toavLpIj0HVDd3e
         4rSuXqpHcrKcLx5s5U+b7yb0EEjl5vEfmdQS741zwOWHHPGlZtebYv4oSPHK9grYq8GV
         S/CTBRekHQa5aPYonJnh5sLeagnL3FCf/3NmMT3MB3RjGETqyvmzDROa0ELECNdl9d1k
         ayALCluzRGsXCJdCyH8YORL3pJWU4CISEeignwT4FCfdIlXBKy9+N71NoCYnH04MZ7kU
         HWPaW1If38HoP8tMVnahZrD0+6KN/mQlWX2Ft4uICOXn75TrlhMrKwz9WkafZfErpNdV
         Xe9g==
X-Gm-Message-State: AOAM533rIUH3bSJS8WrVKKCz4jYei1/nbltbHaMGXDuxBBjRpPwff4+k
        rzFuhBUoF43sRhc5rvR2xy4Wyg==
X-Google-Smtp-Source: ABdhPJzXjz2tTMJmjt40/RFro16gjNCDz+Z5KLHalhlo8N1+TMUrFVsxT4Eqo8wt2a8/geGJNNxtnQ==
X-Received: by 2002:a05:6512:1296:: with SMTP id u22mr7223644lfs.296.1639837085853;
        Sat, 18 Dec 2021 06:18:05 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id o11sm1952040ljc.100.2021.12.18.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:18:05 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
Date:   Sat, 18 Dec 2021 17:17:54 +0300
Message-Id: <20211218141754.503661-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
References: <20211218141754.503661-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two different PCIe PHYs on SM8450, one having one lane and
another with two lanes. Add support for second (gen4, two lanes) PHY.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index d18075cb2b5d..41a8d00bd576 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -51,6 +51,7 @@ properties:
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
       - qcom,sm8450-qmp-gen3x1-pcie-phy
+      - qcom,sm8450-qmp-gen4x2-pcie-phy
       - qcom,sm8450-qmp-ufs-phy
       - qcom,sdx55-qmp-pcie-phy
       - qcom,sdx55-qmp-usb3-uni-phy
@@ -335,6 +336,7 @@ allOf:
               - qcom,sm8250-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-modem-pcie-phy
               - qcom,sm8450-qmp-gen3x1-pcie-phy
+              - qcom,sm8450-qmp-gen4x2-pcie-phy
     then:
       properties:
         clocks:
-- 
2.34.1

