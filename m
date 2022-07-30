Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73058591A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiG3IPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3IPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:15:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D8931204;
        Sat, 30 Jul 2022 01:15:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so484476edi.8;
        Sat, 30 Jul 2022 01:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDKdfvPOf+QF5S75zEZ60inDKg0zQa4zxUMz/3qhhjw=;
        b=DNtXLewhpCPQLRrV9vJP88Wd/gtXOmm1g4F0jz/hX6gcANzNKy9dwk3dSCHzvR+W57
         FypKwlCO3pVgSJz7VYrEZPrau8uTKFrCbpxmHeKVk43fpGXFQQVR0aSRmKIieq6rd+JX
         Bej6a8Gxht2dRKBI/CNaSUrIzG80adNH4O0yzfDU/7Y9e8rI4hJwQstUA1i5wJ8Oqk1q
         Po9znxzhjgczBk5ZXfHdq2o+bYsBFy76e8bzcRWoN/SQMk5HXJQm7qFsJ0JLn88w4dRA
         vqEaG76jkYFpqu7uKxdozerZxLqG05wGZ0vCc2Harb06XlH3sD47fLHbUvxKQPdGgEty
         n4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDKdfvPOf+QF5S75zEZ60inDKg0zQa4zxUMz/3qhhjw=;
        b=WX5UMGxfdka7Q+HX0gttIX47//HzuGcbGbZxORoogGms9xSY2CORUN++vX9ZLrGv10
         6GQUCswPOv1wxr86rb2euY74sc/YaISPlIdet6uTPPJHimbwSR0gWvddupTa0zgzGRZI
         FcySQKRb7HAZkL16e2IVNHp/zCtGmJBXj+hgIizctaCza7UcGwzKAAUO8QSh39hilMLv
         B5i9UjejWqpdN2Z4/DPL0ek6z+X3AgPAzecuX794oMO0t6YzMDZHgdczHiFKi5JRR/ql
         nN+LuLCL8Ea1t+6h9FUECMkUlra3N4bhOebau5hdYvnib7yksS9XcY+gOcErn2Phn4Jn
         95WQ==
X-Gm-Message-State: AJIora97hW3icuFDKTSgr61Lcc5jyvuz8HuzcgjTbtpIQivJZEhGGSBd
        oPnRRtMlQUzvbhsPuLvwMe4=
X-Google-Smtp-Source: AGRyM1uTyvrUCgI2ZHsKNbsaTwkFs3WZ8T8oiv1D4riyc+QhF01hJpWu5BF/4iTsm1VaMtQSxJbZ4A==
X-Received: by 2002:aa7:cd84:0:b0:43c:532b:65e9 with SMTP id x4-20020aa7cd84000000b0043c532b65e9mr7245047edv.330.1659168944114;
        Sat, 30 Jul 2022 01:15:44 -0700 (PDT)
Received: from ainazi.fritz.box (p200300d09725550031ca3b9b629d79a8.dip0.t-ipconnect.de. [2003:d0:9725:5500:31ca:3b9b:629d:79a8])
        by smtp.gmail.com with ESMTPSA id zo6-20020a170906ff4600b006feed200464sm2623673ejb.131.2022.07.30.01.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 01:15:43 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: phy: qcom,usb-hs-phy: add definition for MSM8960
Date:   Sat, 30 Jul 2022 10:15:36 +0200
Message-Id: <20220730081536.14511-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84923720-30a6-1a49-48f6-96e078a46743@linaro.org>
References: <84923720-30a6-1a49-48f6-96e078a46743@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the changes introduced by MSM8960 inclusion.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---

v2:
 - Rewrite commit message (subject prefix)

 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index 0655e485b260..b3075c5ab887 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
 
-- 
2.34.1

