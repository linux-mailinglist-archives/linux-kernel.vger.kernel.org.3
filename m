Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B05A8BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiIACuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIACuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:50:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C4AAFAC7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:50:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t129so16241860pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vRLuEkdNy1fBdLOZl2aXbS/add3r8iSPYp1YgEamjYs=;
        b=HMwVyG1PNfJKgUHB1iTPa4M9DuilLNN2zHDA1/IRFtUCoS7BAo+CPcP6zpbqEu9+dE
         e5TEMrWQesGS76GCy2LD2Eq6dO2W5TZw6y/U3diBOQZAWTkvwZD0KGZjIUYcaqb9qMab
         CZhohIskvzBwH8zDP1/hsl3BUkGrSvRcQ1bcZxHA6vIDZ7OLcEDjTVmLEFXg8MhnN4Dg
         qOfsdE6MPur/0eTu2EqGlA4GyqiQHrI//2p7zOf+0mjz53Ud0uQdiwiDRpKjZdV/6dEm
         apR/CTn61FVpLMVM8v4RCTlolwVEe0gIK6YCBbGyeD5rhd7ZRkgxqhTONIDGd38jy2Eq
         FEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vRLuEkdNy1fBdLOZl2aXbS/add3r8iSPYp1YgEamjYs=;
        b=ufqEeDswnG4LmXF5xx0canDMUJ3W+UshdNkQtkcgZCwCVOB0ZmC5S42DwNyHYWv+Nk
         aDzsLgaCld93dS0+t5VZS3NnzVWHOUC+kaEHrZpgwCtPaLO3nUjnWo6i9T7ZpBRsxPJ7
         dC8mCIRPUCjtv/MdtnXZMJYmIaTnKJL8xKvw2eScKiVvx3QwgWo963IgDQvcTp5tU/CT
         9ZYcjgW0CTdfkByNyG7czjJvZXbqWlP2FKXkpe3cOBe8+0dGQdYRu4E56RcWZPld+jVV
         G83Upxy5sj2UjzjBy7cvZD/9M9XNE+BJefeOoUsjLZiEy8M7t7I8rXfDIcVdEgY2OtU5
         /Mpg==
X-Gm-Message-State: ACgBeo0ACXOVRsQmy2Vu8frX4vBvCgablY8+x7X5xD+Z1zbFJQQBX1MY
        EJwaTvqu6K7y0DhoR0lsRSTZViosukC7i8Pc
X-Google-Smtp-Source: AA6agR7nzY2XkFPjxfMg34hMPF7OlA9HM9vfePoPgfuxCOtvGt/dleDK2qbHqpI+9yvESlc3EUkZlw==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr24662710pgj.539.1662000609291;
        Wed, 31 Aug 2022 19:50:09 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id f9-20020aa79689000000b00528a097aeffsm12014222pfk.118.2022.08.31.19.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 19:50:08 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Thu,  1 Sep 2022 02:49:57 +0000
Message-Id: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pazquel360 is an extension project based on pazquel.
We create 3 sku on pazquel360:
   sku 20 for LTE with physical SIM _and_ eSIM and WiFi
   sku 21 for WiFi only
   sku 22 for LTE with only a physical SIM
 Both sku20 and sku22 are LTE SKUs.
 One has the eSIM stuffed and one doesn't.
 There is a single shared device tree for the two.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v3:
 1. Adjust the format of the changelog.

---
 Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..851cf5edb582 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -459,6 +459,17 @@ properties:
           - const: google,pazquel-sku2
           - const: qcom,sc7180
 
+      - description: Google Pazquel360 with LTE (newest rev)
+        items:
+          - const: google,pazquel-sku22
+          - const: google,pazquel-sku20
+          - const: qcom,sc7180
+
+      - description: Google Pazquel360 with WiFi (newest rev)
+        items:
+          - const: google,pazquel-sku21
+          - const: qcom,sc7180
+
       - description: Sharp Dynabook Chromebook C1 (rev1)
         items:
           - const: google,pompom-rev1
-- 
2.17.1

