Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210074DE124
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiCRSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiCRSj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:39:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579A8A6D1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:38:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so18588972ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbg2RlFA/4puyAOuKWmpEc0rQD4bbwwHtg4uOvJP+0I=;
        b=CLaL56CILexB1XmewhSYD+RMOauS6TXFrSrM09e8FX6dz3NqqKNQuLoBTJMloetORm
         bdsFhPuyeJBgQwXMcWioPB3uOCRhCKZb15XtU05+uB3I/TOXoWs0CISSxKayf95mroVa
         zaN5A7mGN1VgxSGahkm6Hmy6lrxAOme+8PJ/Bg44Gec/QYLJhyXIkqJWp/aoVAjJBRDd
         iaJvbVkvpG1j0vgmX6D8dbAeG9ARk291ldzH5/YvTUVsXIBVvVMPQIy0XqBLGXbG8oyA
         rlLhDlE7/MTvg8kEayMeztg9JDPF7plFAz3CxDj+7gO6QzrJx2fjQ+NM9TO8eirumasp
         aoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbg2RlFA/4puyAOuKWmpEc0rQD4bbwwHtg4uOvJP+0I=;
        b=ABSkxjPNpa/rNgztqrAbarrtIwwh41GMtCzpE06MarIIYppY1s4WT2/aXiWyeF5mwK
         UX+EZEWd/xxuP556TJ2g29ialMSwWE6XC41ya5PTb/Nhb8w5R3ojyXgDA5lPd4mjC+cZ
         LGU7qusS74Vk0vHdmCtsg5tKLp6P/47pY7S0VcfqJFIKF3Q8FKcwzCYKQ9LyR9n5wnBe
         OmpT9BOQdg2MzQTFCSs2vQ2TbmGlFZwN8ZKGufcVFwX1nZl5fA7xdyH5rPl6ANkPjc1g
         4tzzUSoOeOn2ody9PENk8FOC75BfrRS/Vv8p0dSw+fBxLxmw/h6x/fPM1EudnRWa+y97
         nBug==
X-Gm-Message-State: AOAM533sVxDzFms+YsHGSz1I5M7J3ez3S+posY2ok3Oe7/CGbHEYfEbL
        BFQlPojUL/hRhdnA2s8jV0pbJx2NWTHpjQ==
X-Google-Smtp-Source: ABdhPJy9l9NnPcxCTwrHttfVSh2VeMF/NE86kvBCodu5fsRVccCePBYOvZuaZPfCKvJyw5yFTLlEtQ==
X-Received: by 2002:a17:906:6a02:b0:6d7:cda:2cf7 with SMTP id qw2-20020a1709066a0200b006d70cda2cf7mr9874936ejc.53.1647628227733;
        Fri, 18 Mar 2022 11:30:27 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id y8-20020a50eb08000000b00418b114469csm4567551edp.52.2022.03.18.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:30:27 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY bindings
Date:   Fri, 18 Mar 2022 19:30:00 +0100
Message-Id: <20220318183004.858707-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318183004.858707-1-luca.weiss@fairphone.com>
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
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

Document the compatible string for the UFS PHY found in SM6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e20d9b087bb8..934aa9101ddd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -39,6 +39,7 @@ properties:
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sm6115-qmp-ufs-phy
+      - qcom,sm6350-qmp-ufs-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
-- 
2.35.1

