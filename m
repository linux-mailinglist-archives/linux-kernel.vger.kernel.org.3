Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9559905D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbiHRWSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiHRWSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:18:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D202CDDE;
        Thu, 18 Aug 2022 15:18:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j21so335201ejs.0;
        Thu, 18 Aug 2022 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xnTJw9peaanO9bpfnpkWaFIO93QzJllU7e4KFWjN4UM=;
        b=jDuEd75sJEshQT8ppy93ER+pccWlVxGnzW2rN5fleCnftQWLBj3USAsf+/MaiyzrZ7
         yiXvwCzLMrJo7GMpwcYB8oSrAbxlA5BeukuUerdkma7tg64/Fk28uMXIQ0e9AF6NGGzs
         mvfSyLrqA5gj3ndjQeY2u24qtmPoP2yZHWuIhfHhIPBimLMz8OaVi8CTKH19nzMXHhP9
         qlxid9IwvMTt0YEnxZrSmrJd/8fa2IVhlJwtVJShrV/LhIX8MNEDqLtB8P1HKdmFoHr0
         NWIDG05viofNI3A7zKSVsqNeQZ1EGW7/KrFKExFIsHb0FCPMZhT7m6TwxUw4QRHGANVO
         zyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xnTJw9peaanO9bpfnpkWaFIO93QzJllU7e4KFWjN4UM=;
        b=4OG6F1hzERHSp5bMIyBCGzih6zPHyjXfrJsYi4r6I5CK3+k35ayFbTwqW9tu5Xy/PM
         UVPhyVJFtum5eiw0YPj02S4wVc+1/5PtxQ1+1nfvPTEdavgueGYJ1WmS4sBg/Nyi0nA/
         l5wYryJ9FOhOsxNIxr4/owhR+HjJb5ta/tPYwE3jBHX9SQ9eD412UddNyitstEojHxCY
         PE+4YA1lXowNQJh899sizUN5AYKGD4Vkg5QT1eDqoTaX+vheaxIPlEc+VLLEAu+s4fc3
         r+1GllXLeth2C38aXfKxOWCbB4mGt5I3fUGtRvbjdyXTZ83DGLckddZfoaDMfUoh0PC5
         J7KQ==
X-Gm-Message-State: ACgBeo0B9bE1xszTvcmHSDHvh49xHbtB0Oi/rbtMO7MkMxyJTX4nL9oz
        imrMPe40FQgrJQ9HriboTZs=
X-Google-Smtp-Source: AA6agR5YPBSpZL/TaFItfmYZ9gZ3irXfyw8Ewko/wP+9OKDgHkHJn048gCU8EH3oM2u4hfgfQY5vIg==
X-Received: by 2002:a17:906:dc89:b0:731:67eb:b60b with SMTP id cs9-20020a170906dc8900b0073167ebb60bmr3016985ejc.614.1660861098296;
        Thu, 18 Aug 2022 15:18:18 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id t19-20020a1709060c5300b00731747c3107sm1378315ejf.73.2022.08.18.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:18:17 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v8 1/5] dt-bindings: mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Fri, 19 Aug 2022 00:18:11 +0200
Message-Id: <20220818221815.346233-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Document compatible for the PMP8074 PMIC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v8:
* Add to dtschema now that its available instead
* Drop ACK as we are dealing with dtschema now

Changes in v7:
* Fixup commit description
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 65cbc6dee545..a05ae172fccc 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -66,6 +66,7 @@ properties:
           - qcom,pmi8998
           - qcom,pmk8350
           - qcom,pmm8155au
+          - qcom,pmp8074
           - qcom,pmr735a
           - qcom,pmr735b
           - qcom,pms405
-- 
2.37.2

