Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4C596988
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiHQGZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiHQGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:25:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6E6BCEF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:25:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v2so17797208lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=KN8ieklDNnllJV+sd1urCJWbos+kkEs+18oVPhNUVEo=;
        b=PkhXuYu9V57YljPlg9VcvUICzlbuHHYsKNyYvjsP2HT7SLNxqr7/inYZae8+TbKpIc
         0JrJLXXBzWQCr/61pmYjpJSw/bsNF3B0nTWFI0ZlwUYFmNgBGiJ5QDJkZtTAaRBI9mtL
         hdslGKUPMnnAI+jzgOFBLwngGdQ85/HLM2/aZmaa0UZU7OY92+Z+gaBbZ406ZS55x2od
         M3cdfkIrunJ7wuAnvPNuiavn4dIUeQ8aX/MRDxGO+qoIN5lH3t8KASxO6WnrkPqvKoyo
         LP527eOElSCA1qWk3PEMFVclm2SEJS5ygL9HRCBFFTmNHeE8amnan8mTK1fTTMsyNOCi
         UH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=KN8ieklDNnllJV+sd1urCJWbos+kkEs+18oVPhNUVEo=;
        b=UWpTx/10z0kEPhrJwt8O8EYNxaST9fXjbhX58QYXcU9n1V0veag1TX2CM6WFz0Njhr
         tIUgyHGwmYPgNbvzC5T9VTDH5K8Yuz3ImBkQuf8+/DCy9TCZh4trCzirqQYkoMdxbpC7
         RzDpMJkde/j8uaMDtUFRGsJSAmj5JKHXtXKI/QmlCAsjHKXQHW3vbD4AS/gytxpV2DPb
         6dKwWMPJDOQQKQJgWySLvibz73pM1SBVBtEey/4fdz+qlhVX0hAiWoiVkGsOpUxnHeI7
         KqS1KU0gwLUyArLRPad0EfZqCbDUlP4/vFo93Y+XWSSngNXteqCZVoL/w4lfOuAeROy+
         2BmA==
X-Gm-Message-State: ACgBeo3PVgbtz5lM6qJW3QxBu9BQtvC/wdJCTrHQPxyXD/UZCGn2uRLK
        VkbuWO1MbUohpiaO9GVM8Heg4mxZ7dk/eRyQ
X-Google-Smtp-Source: AA6agR5jP6i49LecEthLo6IZ5XOqdnke8i/EWGaJrdTdHkmCcnTMeckyGGO1KOR3pZE7rataHyPKwQ==
X-Received: by 2002:a05:6512:3503:b0:481:4470:4128 with SMTP id h3-20020a056512350300b0048144704128mr7947645lfs.303.1660717524141;
        Tue, 16 Aug 2022 23:25:24 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id c2-20020a196542000000b0048af437ce87sm1577050lfj.183.2022.08.16.23.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:25:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: memopry-controllers: fsl,imx8m-ddrc: restrict opp-table to objects
Date:   Wed, 17 Aug 2022 09:25:19 +0300
Message-Id: <20220817062519.20010-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enfoerce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
index 445e46feda69..fc2e7de10331 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
@@ -47,7 +47,8 @@ properties:
       - const: apb
 
   operating-points-v2: true
-  opp-table: true
+  opp-table:
+    type: object
 
 required:
   - reg
-- 
2.34.1

