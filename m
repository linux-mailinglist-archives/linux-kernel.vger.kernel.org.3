Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D4540515
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiFGRVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbiFGRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:19:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B501059C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:19:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so23874563edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KX0bvh9m5E/An1OjTL+Smck+4fFRXA35dGwS1mx4sTY=;
        b=HdD2iWwBA/mOFqDrrcz6IVv4pA1shuP94FuOt6TAbNVUz/e1eyD5yR+WnH/wu3VSDZ
         596J3iXVGEo5x+W8EkRYpK4tLSON8Fu7rwYyMw5xFJlwVzhZjdBTFJ8XQd3WwartRkIu
         cV7K3pNHQQ6sLNZmoA0T6htoG+WddpbXW55gjBV9yxwu1/8Hi95VBmZ4tsfU9DnwwXpw
         Z11TWY0PAr1bNOTtSJ05MERk8QSNpHPXD5tEQeU/udodTEMiS7MGzU62SHMmpx5dFHOV
         P2BLQFrGP2D3COQ1JktO4lSScTgNf4gWS+2Us85oj44X6h7OZn9qiEFPr4DwVArcwInJ
         +cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KX0bvh9m5E/An1OjTL+Smck+4fFRXA35dGwS1mx4sTY=;
        b=Ckf9BsJl7658cAeqfjtc6kzHxKWaPCv7nEFaM2RfK1lI2uYFRPGlk/vVfVLwhVPV19
         RR3YHDC5WdjZ7qxQjtpVIA5Efac2sDGrgwP6GRLdg8oL97xC9XYvxo7/c/qZ4zG7vpQ7
         9Vj1Q6JZnffhfajSU8uxhLXLNZQaqJZLfXClvc+5jYkrQoW/wxSxWz757J8FzO10p7Ta
         Wz1KZ0jrsDTIUpjvZVZWUxw2PC+APEPG0J8jWEyCdv5AW6iJV4v8vkPyFoRufmJfK8i9
         nU8GpnjjD77wivwiif+Y2xqoV8wkR9OECAOy5nj472ZyyCNqrL+mhx5BeH5ej9c+VS1D
         Ighg==
X-Gm-Message-State: AOAM533rMCddlYtmMmNKO1KUvTyHI4vq6cZxY+DdKVpwdaPiIdcrxWo1
        hXCGFiTT6OgUJ6UIc4LpkC/1NQ==
X-Google-Smtp-Source: ABdhPJwELVQdJ1/xgKo/4yZziUTGQ1/q8sy5fh1006WK7I0N8jOxyQPRBme9y/J6qNArUlGumT09xw==
X-Received: by 2002:aa7:c752:0:b0:42d:ee9d:5ace with SMTP id c18-20020aa7c752000000b0042dee9d5acemr35123602eds.318.1654622344434;
        Tue, 07 Jun 2022 10:19:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:19:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 13/14] arm64: dts: qcom: sdm845: add dedicated IMEM and syscon compatibles
Date:   Tue,  7 Jun 2022 19:18:47 +0200
Message-Id: <20220607171848.535128-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper compatibles to the IMEM device node:
1. syscon to allow accessing memory from other devices,
2. dedicated compatible as required for syscon and simple-mfd nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 6e13aab15931..1fa1436dd68c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4722,7 +4722,7 @@ spmi_bus: spmi@c440000 {
 		};
 
 		sram@146bf000 {
-			compatible = "simple-mfd";
+			compatible = "qcom,sdm845-imem", "syscon", "simple-mfd";
 			reg = <0 0x146bf000 0 0x1000>;
 
 			#address-cells = <1>;
-- 
2.34.1

