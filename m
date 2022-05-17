Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875752AD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353077AbiEQUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353028AbiEQUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766C5252C;
        Tue, 17 May 2022 13:53:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j28so419212eda.13;
        Tue, 17 May 2022 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdGw4UXoqhDZ4Yx6wA89AwB/5uJ2w5076ZwgHhnkRac=;
        b=NIHvR9JJCNSyndwq3YMPz9lghV2QPlxX6Ld0kXQ1tPs9SEiGk9U0/SXU/NdNZxex3Y
         KYYzIyOH7P6PyRgr0s8QPaJ172GBJHVKOhGNZJFZPYhq1koX4UmGTAYEyxRapLdZ9tXZ
         HrxjAVFnQ7zz/0YYteQdQK22mcDOOO8KcuxEwgQJgHcqyJSDoSOFADs/5VrxXISUkm8h
         cJCVzGtt7GtepvYJx8725XCw7Z2xpY4HyzP4K5jzHzI4enbzx6JQKIWk5Jq3cQnAjkMr
         QUDshXVjCQ9SN1C1Yk/r/x8Tj85fB2JwsHBxMcl66Eqe7HWo9Jyv3bIt5yx9pHCmHCKo
         5/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdGw4UXoqhDZ4Yx6wA89AwB/5uJ2w5076ZwgHhnkRac=;
        b=c7FGvUwdeMorcK4H1fZMIJdstkJeMtcJrA9hzEEUbjQJz/HKmJjRnUt+NlMy7YXSiF
         xfWWpUk96mD5ka/C4320Py5QsFkoSMRDwEvnU56GVNLZ+u7ns7H0qxYhSyiHLbdQsATk
         5gAacUTs0nxmxl7NdcBrQb0LOhsE4DYldQiPUckFS6PBy5GBhK1FSZEKvWg1udNEE4Y7
         LSxS2qQMmiJHrXXyhRKN7mtiErVu8RM3bc+NeGY44iw7Vb3ynDV4317rQUisSJtHx98d
         0KTH5wfIpUZ8GuxNTcbx7/oRqW0pffkM2/D7tz4veHl/7AFmjdReUbI0RfnHn0+70Hdn
         4Vzg==
X-Gm-Message-State: AOAM53097+AHySWuY8FcexDv5MvGyXK2hw7CqsELBW/7THYFYayUkfKZ
        LGFyErSjMqXNEfsZrc1axt8=
X-Google-Smtp-Source: ABdhPJwoqXYfraNQ/M6ll9AZ9/fKwYy67cJWapFU6TcBNAldlrLMI4/f4ICiJGjL7rtoRPb4krCimg==
X-Received: by 2002:a05:6402:2789:b0:427:bc78:85c9 with SMTP id b9-20020a056402278900b00427bc7885c9mr21336458ede.50.1652820827995;
        Tue, 17 May 2022 13:53:47 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090651d600b006f3ef214e10sm120907ejk.118.2022.05.17.13.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:47 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 3/6] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Tue, 17 May 2022 22:53:38 +0200
Message-Id: <20220517205341.536587-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517205341.536587-1-robimarko@gmail.com>
References: <20220517205341.536587-1-robimarko@gmail.com>
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

Document the PMP8074 PMIC compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Add supply matching
---
 .../bindings/regulator/qcom,spmi-regulator.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 7f51e305eaae..334ba9e5e177 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,pm8950-regulators
       - qcom,pm8994-regulators
       - qcom,pmi8994-regulators
+      - qcom,pmp8074-regulators
       - qcom,pms405-regulators
 
   interrupts: true
@@ -280,6 +281,17 @@ allOf:
         vdd_l1-supply: true
       patternProperties:
         "^vdd_s[1-3]-supply$": true
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmp8074-regulators
+    then:
+      properties:
+        vdd_l10_l11_l12_l13-supply: true
+      patternProperties:
+        "^vdd_s[3-4]-supply$": true
   - if:
       properties:
         compatible:
-- 
2.36.1

