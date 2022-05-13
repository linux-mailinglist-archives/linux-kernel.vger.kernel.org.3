Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC55267C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382602AbiEMQ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382583AbiEMQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:59:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4B15729
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so8306228pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88cXYGf2a3kEgwR2h8/l8Xtu/XQd7ToHbj5N0nGGw1w=;
        b=HWDMU6p8QL0lxHSVeZUBZ132GR7Wb/czeaoslJWtHKkO7mZz1EoT6XHkzDCfv8Xjdd
         HmeU5J64qoIfIYJcFd2eVFe0oweFCcwmexA0qL49JwyAcGUtmLtYIGXvM9rST/evubfw
         sj+jEWmV3gMHJInhMLAN7qiCKmdGz7xewrbZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88cXYGf2a3kEgwR2h8/l8Xtu/XQd7ToHbj5N0nGGw1w=;
        b=w8d/nSL+CrcYktZkn1wz9cLMVjEUkCf9DM0m7hgLwUwQ9nde6H3z6joeLv/2ulKZiG
         4+/ipNfbuscQ8BfTd/Wd43cjzeXnz7Xr+ENLdxDija4KarYc7cCF51MCVq6Worr1sYco
         BVECipMPIJxrXuq3kz4c3qXJ5Ux2iq5Mfwc/bsktc9Q883axG999O5/Q0v5EHp2IEn5v
         vvfZnQKb/5UxGe1AlnbG9tPChFA1Uah6QrgzgiViBKS6QurFd5iAxmlY1RChfgUdyvUc
         kEtIFb+FISdy01iZ/9hMDQlihhHurS4Ua4EHnKHzW23bjrA/UPxXs/nIYSffcOPuzOas
         K3VA==
X-Gm-Message-State: AOAM532EhLFwe5lMLR8U9N8LKMMXY9bu5SO/IDkyNDk8atByrxhTf1em
        OdIm5m9WkA5HJK80wZYcBugrgQ==
X-Google-Smtp-Source: ABdhPJzuCUTXcWeOfQkKVdQE5i6ogThov0/FQ+KjF6lDOyjbO1edZB2GNn5rmCQtZkF4nj7fOJzBMg==
X-Received: by 2002:a17:903:240a:b0:14e:dad4:5ce4 with SMTP id e10-20020a170903240a00b0014edad45ce4mr5717988plo.125.1652461186049;
        Fri, 13 May 2022 09:59:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f334:6f80:82ed:5653])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b001d97f7fca06sm1824548pjl.24.2022.05.13.09.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:59:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
Date:   Fri, 13 May 2022 09:59:18 -0700
Message-Id: <20220513095722.v2.2.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This copy-pastes compatibles from sc7180-based boards from the device
trees to the yaml file so that `make dtbs_check` will be happy.

NOTES:
- I make no attempt to try to share an "item" for all sc7180 based
  Chromebooks. Because of the revision matching scheme used by the
  Chromebook bootloader, at times we need a different number of
  revisions listed.
- Some of the odd entries in here (like google,homestar-rev23 or the
  fact that "Google Lazor Limozeen without Touchscreen" changed from
  sku5 to sku6) are not typos but simply reflect reality.
- Many revisions of boards here never actually went to consumers, but
  they are still in use within various companies that were involved in
  Chromebook development. Since Chromebooks are developed with an
  "upstream first" methodology, having these revisions supported with
  upstream Linux is important. Making it easy for Chromebooks to be
  developed with an "upstream first" methodology is valuable to the
  upstream community because it improves the quality of upstream and
  gets Chromebooks supported with vanilla upstream faster.

This patch also adds a link to the Chromebook boot flow documentation
to explain that Chromebooks don't use the scheme described for the
Qualcomm bootloader.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The link added here will (obviously) not function until the
documentation patch makes it to mainline. Presumably folks who want to
read it in the meantime can find it pretty easily. If there's a better
way to link this then please let me know.

Changes in v2:
- Add link to doc about how Chromebook devicetrees work.
- Use a "description" instead of a comment for each item.
- Use the marketing name instead of the code name where possible.

 .../devicetree/bindings/arm/qcom.yaml         | 187 +++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..8ec0805f4996 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -90,6 +90,11 @@ description: |
   A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
   foundry 2.
 
+  There are many devices in the list below that run the standard ChromeOS
+  bootloader setup and use the open source depthcharge bootloader to boot the
+  OS. These devices do not use the scheme described above. For details, see:
+  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/chromebook-boot-flow.rst
+
 properties:
   $nodename:
     const: "/"
@@ -214,11 +219,191 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
-      - items:
+      - description: Qualcomm Technologies, Inc. SC7180 IDP
+        items:
           - enum:
               - qcom,sc7180-idp
           - const: qcom,sc7180
 
+      - description: HP Chromebook x2 11c (rev1 - 2)
+        items:
+          - const: google,coachz-rev1
+          - const: google,coachz-rev2
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c (newest rev)
+        items:
+          - const: google,coachz
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c with LTE (rev1 - 2)
+        items:
+          - const: google,coachz-rev1-sku0
+          - const: google,coachz-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: HP Chromebook x2 11c with LTE (newest rev)
+        items:
+          - const: google,coachz-sku0
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (rev2)
+        items:
+          - const: google,homestar-rev2
+          - const: google,homestar-rev23
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (rev3)
+        items:
+          - const: google,homestar-rev3
+          - const: qcom,sc7180
+
+      - description: Lenovo Chromebook Duet 5 13 (newest rev)
+        items:
+          - const: google,homestar
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev0)
+        items:
+          - const: google,lazor-rev0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev1 - 2)
+        items:
+          - const: google,lazor-rev1
+          - const: google,lazor-rev2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (rev3 - 8)
+        items:
+          - const: google,lazor-rev3
+          - const: google,lazor-rev4
+          - const: google,lazor-rev5
+          - const: google,lazor-rev6
+          - const: google,lazor-rev7
+          - const: google,lazor-rev8
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 (newest rev)
+        items:
+          - const: google,lazor
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev1 - 2)
+        items:
+          - const: google,lazor-rev1-sku2
+          - const: google,lazor-rev2-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 8)
+        items:
+          - const: google,lazor-rev3-sku2
+          - const: google,lazor-rev4-sku2
+          - const: google,lazor-rev5-sku2
+          - const: google,lazor-rev6-sku2
+          - const: google,lazor-rev7-sku2
+          - const: google,lazor-rev8-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
+        items:
+          - const: google,lazor-sku2
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (rev1 - 2)
+        items:
+          - const: google,lazor-rev1-sku0
+          - const: google,lazor-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (rev3 - 8)
+        items:
+          - const: google,lazor-rev3-sku0
+          - const: google,lazor-rev4-sku0
+          - const: google,lazor-rev5-sku0
+          - const: google,lazor-rev6-sku0
+          - const: google,lazor-rev7-sku0
+          - const: google,lazor-rev8-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE (newest rev)
+        items:
+          - const: google,lazor-sku0
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 (rev4 - rev8)
+        items:
+          - const: google,lazor-rev4-sku4
+          - const: google,lazor-rev5-sku4
+          - const: google,lazor-rev6-sku4
+          - const: google,lazor-rev7-sku4
+          - const: google,lazor-rev8-sku4
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 (newest rev)
+        items:
+          - const: google,lazor-sku4
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (rev4)
+        items:
+          - const: google,lazor-rev4-sku5
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev8)
+        items:
+          - const: google,lazor-rev5-sku5
+          - const: google,lazor-rev5-sku6
+          - const: google,lazor-rev6-sku6
+          - const: google,lazor-rev7-sku6
+          - const: google,lazor-rev8-sku6
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen (newest rev)
+        items:
+          - const: google,lazor-sku6
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (rev1)
+        items:
+          - const: google,pompom-rev1
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (rev2)
+        items:
+          - const: google,pompom-rev2
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 (newest rev)
+        items:
+          - const: google,pompom
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (rev1)
+        items:
+          - const: google,pompom-rev1-sku0
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (rev2)
+        items:
+          - const: google,pompom-rev2-sku0
+          - const: qcom,sc7180
+
+      - description: Sharp Dynabook Chromebook C1 with LTE (newest rev)
+        items:
+          - const: google,pompom-sku0
+          - const: qcom,sc7180
+
+      - description: Google Trogdor (newest rev)
+        items:
+          - const: google,trogdor
+          - const: qcom,sc7180
+
+      - description: Google Trogdor with LTE (newest rev)
+        items:
+          - const: google,trogdor-sku0
+          - const: qcom,sc7180
+
       - items:
           - enum:
               - qcom,sc7280-crd
-- 
2.36.0.550.gb090851708-goog

