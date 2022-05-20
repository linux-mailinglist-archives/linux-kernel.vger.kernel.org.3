Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10652EC20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbiETMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349275AbiETMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:32:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295AD163296
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:32:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q130so9514313ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReOeJsmpu+BaTYzKPPlHlTM1nf1CXN91im4L/TGzwnQ=;
        b=T+BpzhqCcc47SVS46L/C2eaaTAuGxPim3Dpd1AGzVgfY9fKxUxjdQVT11ctfdzIqWh
         AMBdWNJkqo4QlKvyeaR6TZQmkIlIAgxrNfOPPI7qC2asA4rjJBENKdQxHt2CDCVob7Kt
         J48mgDFSpKxjpy8+/IK8mfshOK4UoQnCU7N0BlGobM29FAb2ZaM7JbwoHnRAhjSyAyG/
         Cq8NSPyQCl169pkfceEhwck2bZM1wcTD75/a39cjg4cPxLbwSMhwRehdfRV0/yZW6mYT
         +duaabFguvu1GJjaumgRtz2mlGV9j7cm6IkTCai23UsAogDhxT/iHPiOX77h09nzXUv4
         BZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ReOeJsmpu+BaTYzKPPlHlTM1nf1CXN91im4L/TGzwnQ=;
        b=lSLkPVDL4gd4CH3HfRIpJNja7MlE0S79GC2Omk0pwn4vS8+2Gc/EhbhlQv/ib+5Y8c
         CnrPXKNBglGSfL5mzc9Xnx2X7fdg+IHjaw9PnKcpTDkKnVrdbcAqPZBb1tHNe3zBUUzD
         bgnQzxe79CnarStDWnDnme7dKtVvnykK1iz7+FDcG/6+OIK5NR8O6uTuo4/+qA4QsYFn
         jkMMh8ev+/j5WwJr6Pm5VFFxoCbDo7nPtjlI6qNhuG1nwlhKIk4ZCDQ+PDLXAjiABl2v
         GWeDoVeE2HaWFqWVIHBMWeUPIhdspMV87qtZfzzwn95KBaM2dL9mLN+kFuPsm/MFeh5I
         IGAg==
X-Gm-Message-State: AOAM5320FJPoOGmNl8TkQh8pdQ2F14HIqZoZzbfZ33aqOmKNTa5lPggL
        NRLZg2W3tEtLmu5e2xtX19cMQA==
X-Google-Smtp-Source: ABdhPJyqsu3QP5zYukyBbNps+EoU12GdYm3/EwEJjlf/QAtklRQgTb5YX55m+lF1PO6hyFX9/gavwA==
X-Received: by 2002:a2e:9d93:0:b0:253:c9bd:288 with SMTP id c19-20020a2e9d93000000b00253c9bd0288mr5413369ljj.223.1653049976431;
        Fri, 20 May 2022 05:32:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b0047255d211bfsm643973lfs.238.2022.05.20.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:32:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
Date:   Fri, 20 May 2022 14:32:44 +0200
Message-Id: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The MSM8916 Alcatel OneTouch Idol 3 does not use MTP fallbacks in
compatibles:

  msm8916-alcatel-idol347.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
    ['alcatel,idol347', 'qcom,msm8916'] is too short

Reported-by: Rob Herring <robh@kernel.org>
Fixes: e9dd2f7204ed ("dt-bindings: arm: qcom: Document alcatel,idol347 board")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..b7dd61df7ec0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -153,14 +153,13 @@ properties:
           - const: qcom,msm8974
 
       - items:
-          - enum:
-              - alcatel,idol347
           - const: qcom,msm8916-mtp/1
           - const: qcom,msm8916-mtp
           - const: qcom,msm8916
 
       - items:
           - enum:
+              - alcatel,idol347
               - longcheer,l8150
               - samsung,a3u-eur
               - samsung,a5u-eur
-- 
2.32.0

