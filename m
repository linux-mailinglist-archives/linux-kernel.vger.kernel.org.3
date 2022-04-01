Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1B4EF7AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbiDAQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352304AbiDAQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:11:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D162CAE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:37:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bq8so6605995ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lN//07PpztSXdT/l1Q7wLTBSohg5QXeX41GRcjjA3w=;
        b=Vo0NRVJYkpcefUMBQNkTXCviEnXt1+lBlj4Abpz62bbTjfS0Sn+p0Pk39BMnELOYuM
         6oEErk+Ps2ZVnkRzixmeXtsSM/1Xdr7hYOxDzCCt2rqDILc+8TZM0bug69MvwshLKCkF
         O7gPC+UAFdKHU5A9aTWAckLrCJZ1J8x5xDXJlws+iBjLYBqBB4LBXfkWK6Lol4GJCAC3
         E0noTsYOaokePlBZvCvMIJNR69pCZ9jq8Im39RpvGdxjUf7uIqufPhL6Fhr/vpZZSolU
         XdcF26Zm/HQF+k7io+1KQQ6txw65+jf7I5goC/Ah1rff8x7V3yvbfalBJz9isIsfpbGW
         OMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lN//07PpztSXdT/l1Q7wLTBSohg5QXeX41GRcjjA3w=;
        b=ih5kFuTyZnN8UE7W+9sNkMDcJJnH8PvhoFtizB1Nzt84wRW6/IXy/9PS6I9afsZl8k
         6pZ4gA5EuZXtW1qRioUNQuCdWiGDP8wSB156TiQhzS23cdz8mHqI2o9a8rTQ7MixEhue
         mbz2uWZqoeS4CiF79J6sUMkqm0rWJNRHlnGsir7WPvcQXO2cA6M1g/QMKf+FBjenESji
         h87JxgE/7dXhzL2PI1l6siXl+2uXq9bdd6QvlgKYztisly090+8dzdgY7+3RcM9SQlWB
         J/poEqSGHWdHCFN4N2Bq4ni5rbMVtrJfoTn2hK+WQPfymaRERtwtBeFoRBbmy1IKpDJw
         VBjg==
X-Gm-Message-State: AOAM531+XvFYOnnoDyMayxmbrtfxvdnF9HZhR/kT/W0en3W50RW3b2rP
        EVaaBmtvWdDkWel4iUAJEXEAmw==
X-Google-Smtp-Source: ABdhPJzn/CErWgq1p027Y/X/ko5lxEZxVAH5Rdh4zhZYEfDKLon+ss8aVA0mnp2U936AqAjG4TNByA==
X-Received: by 2002:a17:906:1615:b0:6bb:150f:adf8 with SMTP id m21-20020a170906161500b006bb150fadf8mr358897ejd.272.1648827436142;
        Fri, 01 Apr 2022 08:37:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dm8-20020a170907948800b006dfe5b317d3sm1150187ejc.75.2022.04.01.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:37:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] regulator: dt-bindings: richtek,rt4801: minor comments adjustments
Date:   Fri,  1 Apr 2022 17:37:11 +0200
Message-Id: <20220401153711.1057853-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Correct grammar in 'enable-gpios' description and remove useless comment
about regulator nodes, because these are obvious from patternProperties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct also "spefied"
---
 .../bindings/regulator/richtek,rt4801-regulator.yaml       | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
index 235e593b3b2c..4a4dfa7d9d09 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -17,9 +17,6 @@ description: |
   Datasheet is available at
   https://www.richtek.com/assets/product_file/RT4801H/DS4801H-00.pdf
 
-#The valid names for RT4801 regulator nodes are:
-#DSVP, DSVN
-
 properties:
   compatible:
     enum:
@@ -33,8 +30,8 @@ properties:
       The first one is ENP to enable DSVP, and second one is ENM to enable DSVN.
       Number of GPIO in the array list could be 1 or 2.
       If only one gpio is specified, only one gpio used to control ENP/ENM.
-      Else both are spefied, DSVP/DSVN could be controlled individually.
-      Othersie, this property not specified. treat both as always-on regulator.
+      Else if both are specified, DSVP/DSVN could be controlled individually.
+      If this property not specified, treat both as always-on regulators.
     minItems: 1
     maxItems: 2
 
-- 
2.32.0

