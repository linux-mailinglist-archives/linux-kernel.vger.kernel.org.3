Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF49452F538
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbiETVjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353700AbiETVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:38:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1965185CB9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:38:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c14so8781643pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWtQy18NHiRxt6AViZq9XS9Ltp9ovI+UMyFyos+TlvM=;
        b=AeMNMUPxDTpnponUI2VVPS+IBwMWOgFOqvanLUDanSyUwW9DSYtS2FdS1o8GE6yiXX
         FE0e85Wed3AFMu6RJgphc+wun1FPjNiGzCCq2h7IUF/SEUPZc+2VxSe8jAgB/MLtNPNT
         Mziws4nOQL/JFrbvkct6vg0WTtfELBHOeF/Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWtQy18NHiRxt6AViZq9XS9Ltp9ovI+UMyFyos+TlvM=;
        b=ZYYHraOucyZPkpIjo+9p3f+xsKMUPIPpFSOLMBrTnWfmoAm7JHX8sgV2SGqwVQEvlT
         ObKAn4j8Q+s42t+S3AXFs5dHGtuO1tWigAwENf61+Z21T+I6Hyhqk5dgVkomdWnvrdtf
         yjXOJhqBBBPGJQry3XA9XnPY78MKDj8hOUUnrolCWQBrPdSVZ/EHvsDrpItxvYb2x19l
         dtsXipJApYiARuRu8o/ZduyBmMsZiPu4SxiQ7HHXPx5SEwYohEyGqnVdooBLLfp98mKC
         t1DgCBarPD55UFL7ORXkpXAoUNyuH1M5PaPjXGmtJhgKL2GQZJuKuZyKpeLX0oSXWQ0Z
         QgDg==
X-Gm-Message-State: AOAM533o48mMXtAKx6BdtWPwvkCHsRIye4yL116omfR/m5bFxmWF5RjC
        8sgokkeKGx6+HayJyhnWxUwKQA==
X-Google-Smtp-Source: ABdhPJwRN2ADkPxgOCgbxV2GyRfXZPFSY8hDPygQjsWZ7+m29s/Dlk2ByzUOzGfiyO96H7CStX/r2w==
X-Received: by 2002:a63:220e:0:b0:3c6:d818:19ff with SMTP id i14-20020a63220e000000b003c6d81819ffmr9950684pgi.486.1653082735906;
        Fri, 20 May 2022 14:38:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b090:3896:c312:c4df])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm2070864pjg.37.2022.05.20.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:38:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
Date:   Fri, 20 May 2022 14:38:43 -0700
Message-Id: <20220520143502.v4.3.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

One other note here is that, though the bootloader effectively treats
the list of compatibles in a given device tree as unordered, some
people would prefer future boards to list higher-numbered revisions
first in the list. Chromebooks here are not changing and typically
list lower revisions first just to avoid churn.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v3)

Changes in v3:
- Split link to Chromebook boot doc into a separate patch.
- Added a note to desc about revision ordering within a device tree.

Changes in v2:
- Add link to doc about how Chromebook devicetrees work.
- Use a "description" instead of a comment for each item.
- Use the marketing name instead of the code name where possible.

 .../devicetree/bindings/arm/qcom.yaml         | 182 +++++++++++++++++-
 1 file changed, 181 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5ac28e11ea7b..01e40ea40724 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -219,11 +219,191 @@ properties:
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
2.36.1.124.g0e6072fb45-goog

