Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200ED5033B7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiDPDBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDPDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D623AF896C;
        Fri, 15 Apr 2022 19:59:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t25so11800753edt.9;
        Fri, 15 Apr 2022 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8om3/knLnhhG4AZcuyl9X2HNsxuXO+MW4AfG9LQR6o=;
        b=hgnDw/iftSk9w45kN9E7/UHf5/8CzFQOF36nyUbxDfzrbsQbNzF58RyHlJjHPr7E9F
         QFvIN1aREo+FteujnsleN6puR+1brkYB455yvWdMFV5SZNdNbqwGK6FTnOzowDaXk/2J
         s2IqKkdVKykzMqu9p3DHC/pghhfLYImELEiXs6g56Yb0YCbCTtQ6QQd256ozCmYXLgDI
         P+hidnwSxl12niOkNkxWGEUyTShay3gYN7EAgjGaZTAiAtrR06i9p+nxXDWSVcdzauJ2
         HnXqIoIIMRqSX0lG3N7Lp3vv6BHGtzali7oFnHH7BKODUJ0iLAd0grVi8hzG/dTwuK2h
         Ctzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8om3/knLnhhG4AZcuyl9X2HNsxuXO+MW4AfG9LQR6o=;
        b=xZbnjs45C1qNbHmYMZr//fIOWnAAGEPGgX+r3X8sXzOQvB1M725sXcrN9WCDduE/f1
         1P9RnT8/hi5/+p661zNCbr85SFzcOwcqA94rKqGPfj5E3tsKT2tDwbmkDqSC8PI9jfi9
         JWhv0uUCFl9lxUmfrHHzC5V076uAxLDS8urEF5WTltLGOIeEBLaDR0CvL9yTbOrs7odQ
         qFWJ5SCp7Lv3qU0pUl/2vugHZ+d9VE633ZNe3CjRUdYNNW/cHoLNN0o8rWK503T3mHHk
         wQwCsRSf/UbH1ew21isrGuHUiE9YPMUIxW4qhNlCUaSR19h9OEgB6q0ll7fCxdyQdxht
         WzNQ==
X-Gm-Message-State: AOAM530YQBOu9coRrGvPL6zP3q5JDMvW+LRPCz9GHUF43hpYEBwDdQV6
        D0cMBLa6KeC/uUaX20hqCXg=
X-Google-Smtp-Source: ABdhPJz07yKKKwudNA9mqsoF8b1wkNUIlIo1hllzGzSKs052jMo6ZXsCDEV2/vHNAoEVVaBzC7j9tg==
X-Received: by 2002:a05:6402:4402:b0:41e:8f24:1602 with SMTP id y2-20020a056402440200b0041e8f241602mr1955727eda.249.1650077944174;
        Fri, 15 Apr 2022 19:59:04 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:59:03 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 7/9] dt-bindings: arm: qcom: Add MSM8996 Pro compatible
Date:   Sat, 16 Apr 2022 06:56:35 +0400
Message-Id: <20220416025637.83484-8-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

Add a qcom,msm8996pro compatible and move xiaomi,scorpio to the
same items list as it.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 129cdd246223..dcf2e0102857 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -186,7 +186,12 @@ properties:
               - sony,kagura-row
               - sony,keyaki-row
               - xiaomi,gemini
+          - const: qcom,msm8996
+
+      - items:
+          - enum:
               - xiaomi,scorpio
+          - const: qcom,msm8996pro
           - const: qcom,msm8996
 
       - items:
-- 
2.35.1

