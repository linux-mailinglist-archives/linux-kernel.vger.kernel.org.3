Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B9596977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiHQGVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiHQGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:21:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA416F559
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u1so17792938lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f0ZUWiwp6O3VLep1SF30rju7EymJyHwt3q8Tihejmps=;
        b=JBiUhecfwE0OJ5ewX6RIWr8A6Aj/1U+4+9dQ/Cur4oCcoobtA5xAc1vnP9CiOi/r0l
         NzUjhyhUlqGpxoVqv1VR78+xCp/G4UErNTvMuxYFDaGi3gdgc29wz1VsKNVNBn+/QsNo
         Ycmy28yVzhYPi3s6tvEnMyHkPQHVTM7foiC9SwJheBEQN1rpeEfsT8KwUe1lHScdgKOF
         xcR10TnOpkO3lVdZjBgzWa1fsuY6ZOumd4yJvWZih4RzQpbSb/tiazD9vSZ6cuwATx0E
         Lo9BmPXFXwGUfQrGsPwclsoa1pwS63h4xODCN4MB4Y7yVcwFGksQDV0x4eIuq/xtSPMP
         1rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f0ZUWiwp6O3VLep1SF30rju7EymJyHwt3q8Tihejmps=;
        b=QyFtJ9bRATyCKlkzVf7TAtTSYCR3zgsGN3jTa5sEVtrIfBWcfI0J1CJmn96H7L6F92
         MJeDjc6OQXWJycLARTi86XdxecDPRH/kuhyEKH9sBSya7wKO3q8YMvY02MxqOgsBCiPI
         SRgh9Op4Z5hSb1nPFxT8w0D7N5wVznbS9/zfJGi3vfzhvooypgWszHWvPsiH4d1mY5VT
         FxZvvjbr0Sq4YRPHRi25Jd0q7QU/CFd1SPbsZyeurqACUk/h5Z5+8PpKG5aLc0B2cXJY
         vVuv0AT2vOK7bNmv396V+4Jp+IFFClQysils3DQCqDcaa6NXq+tCIypVMWb6Iu/lPICs
         1ZTQ==
X-Gm-Message-State: ACgBeo2Vw59DE9cRNg2lhxdSMBGeVXZOLOAQLqDF+jilDwjSchRjEA+N
        DQaRZSRmup+UCaue2t7z+JNovw==
X-Google-Smtp-Source: AA6agR7RhKLKTQRZcU2x4wPCfXEW3wfDR1kV3FqCuQgTvWFpQZM9cI2Jn3frwZjThfxYfhxQZFOhGQ==
X-Received: by 2002:a19:490b:0:b0:48a:f60f:aaaa with SMTP id w11-20020a19490b000000b0048af60faaaamr7890889lfa.364.1660717267536;
        Tue, 16 Aug 2022 23:21:07 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u27-20020ac258db000000b0048b0062a14fsm1581002lfo.144.2022.08.16.23.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:21:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: display/msm: dpu-sc7180: add missing DPU opp-table
Date:   Wed, 17 Aug 2022 09:20:57 +0300
Message-Id: <20220817062059.18640-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817062059.18640-1-krzysztof.kozlowski@linaro.org>
References: <20220817062059.18640-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'display-controller' child (DPU) of Display SubSystem (MDSS) uses
opp-table, so reference it which allows restricting DPU schema to fixed
list of properties.

Fixes: 3d7a0dd8f39b ("dt-bindings: msm: disp: add yaml schemas for DPU bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
index d3c3e4b07897..4890bc25f3fd 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
@@ -73,6 +73,7 @@ patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
     description: Node containing the properties of DPU.
+    additionalProperties: false
 
     properties:
       compatible:
@@ -114,6 +115,8 @@ patternProperties:
         maxItems: 1
 
       operating-points-v2: true
+      opp-table:
+        type: object
 
       ports:
         $ref: /schemas/graph.yaml#/properties/ports
-- 
2.34.1

