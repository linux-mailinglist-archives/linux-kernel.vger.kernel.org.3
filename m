Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524AC4FBA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbiDKLBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbiDKLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:01:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95984C3F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:59:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z12so5278472edl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zw3vSAK0pJhTjl0Tya4Qny5h2u5hqroyCgDzzcOD6F4=;
        b=JQeWz9JruHE6fvJG/mAZuZxY/g7URi8MDaPjHIdq/u3Taoj39k1J8FMGd25pw6oHk2
         hgo3QpiJ+fgVAE6hhqRhbXLssCANlOVUY7wGthfaFuvsqSU9O8q+LBsDfiUzOjzayZGP
         jSsviHKu4xvFW/58sQjouIHT6ZH+mJ8stvib5ocpr5xpisEtBijU1s1eOgOn4WRhwtco
         IDlGjrsx1Mj34NOM5xqzrkHOyYx3h/tdXWsDelEhLijhPJJfXz3gfNT0eNB/PjqgIh4z
         3dNRcnaQYwdVbBSbnEquje6EeCN4Xw2IpvrTccj3aF1ngh0kQ/RaV/kM+Vqeo/nGz/4m
         bhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zw3vSAK0pJhTjl0Tya4Qny5h2u5hqroyCgDzzcOD6F4=;
        b=NbZGtpyE+42lA0KdTpa+1LiOE3vLEbbEFrc6Sfu6Fj3zQsIPZK7fGnJHd6HJxkIbTw
         09lfWtUk8K8aO5ZhtRlGSSmiHabcisQBsV83aitorrxBD3DdCBnqDMAwOe37qoZw0SVx
         xuDhUkMqNqyejiXs/g43VrCZIyz5QeJiYDL4Tb4byA6k3BXESWQLNtN2euTQWrzKIRl6
         c1uQnaERuerviBFDPXKbW7ZUOnwH/YwTdpw8KnfZmNCEB+6HXGlLoz0Klk5HXmTnVysO
         HzRVTeeb2+bxrPmdatkMQ+/wol27SNDkMoMeQi6MHlYx0kXjfn/BZPIxO1v5Fx1nmAGA
         Smdw==
X-Gm-Message-State: AOAM531ivVV7v3+0ZoNs+lxsa333/GqGzLM2xwBJGkA3yB/UITpE7XVR
        5sRDrCq2qUv6Tji1s6NFUYX8Yw==
X-Google-Smtp-Source: ABdhPJyEOy7ko1JKO6Gp9yC03o5o0k/8DcPcwlJQDltuZcFVFm1jJVVIip/g86PxqzRvehue9AHgHg==
X-Received: by 2002:a05:6402:4248:b0:419:4583:eaa2 with SMTP id g8-20020a056402424800b004194583eaa2mr32575686edb.376.1649674747020;
        Mon, 11 Apr 2022 03:59:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kk23-20020a170907767700b006e8a6e53a7bsm70276ejc.139.2022.04.11.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:59:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] regulator: dt-bindings: qcom,rpmh: document h and k ID
Date:   Mon, 11 Apr 2022 12:59:03 +0200
Message-Id: <20220411105903.230733-1-krzysztof.kozlowski@linaro.org>
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

Document used PMIC IDs: 'h' (sm8450-hdk, sm8450-qrd) and 'k'
(sc7280-crd).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index e28ee9e46788..2714a790ff83 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -78,7 +78,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f]
+    enum: [a, b, c, d, e, f, h, k]
 
   qcom,always-wait-for-ack:
     description: |
-- 
2.32.0

