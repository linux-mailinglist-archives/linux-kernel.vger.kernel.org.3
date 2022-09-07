Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35805B0E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIGUuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiIGUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816C2EF3D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662583789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9MgklvzpOudjdiKZlpMkkXwau8zREX7ev+fmxYPY5o=;
        b=CJ7mme6kUhJjEQFa+GBLMyphFR0qU66kNW7u2QqplnUKiKdyB9pkvzawqUcL4rX6eOx1NU
        0fJNMbB4JO6rKShlETIzqpfRN0jbbk+Be7nfavI00Ju4Lsk61ptQPQ2gOob9PoI/6HdO7d
        FZoOaV4vWAEPetn1Jt3PVDedCICZxBQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-vRpdtkHPPm2giq2eeeXoYA-1; Wed, 07 Sep 2022 16:49:47 -0400
X-MC-Unique: vRpdtkHPPm2giq2eeeXoYA-1
Received: by mail-qt1-f198.google.com with SMTP id ew6-20020a05622a514600b0035990b1ae0bso2149401qtb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=L9MgklvzpOudjdiKZlpMkkXwau8zREX7ev+fmxYPY5o=;
        b=DI/eNTxdCC/iXpAuZ92+wJwx0uGcFJ4DxRjkLDoNRDWHgP4oy/Ib0JhtbfADVN7xjP
         TPkqVcFrtUPdn3nyq0dEHibGcVbC9YrOe1YoiBo60A4ilrUQBsoCbivJFU28vdJy7Ckf
         XNt2rWvVhLSp+w9VyOyew7xHLKWL7fuK6hbFv5gIi100TwZ4E/n40tBDL9eCNIzvqDx1
         gPKF2IaGG/kVLyf1537luFGXYISEjyclCJpNVspaTBZSeA58SWNYju4o0sUyxyX2TBNt
         CinO25IUBdCg9vpIkkszYm1bAgfNNA7wSSEY5tFz1Q+SNPb+kYPXcKnQwYzZTQIWgRGf
         YfAw==
X-Gm-Message-State: ACgBeo3S59CdBdmKWSgsPeRcUhY7ySJsOzPmiehS7dqUNi+SkGW37YH6
        JdzCI3OMf8lJCyGwz9q7eL/UfOmS6DotsF5yg79hvebUGxgiPtqv9dmj4pZkHbvq8RJg/odc2SI
        ok3axmSrNN2MyOd0CFUG//h70
X-Received: by 2002:a05:620a:e15:b0:6bc:980:dbaf with SMTP id y21-20020a05620a0e1500b006bc0980dbafmr4067248qkm.315.1662583786942;
        Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Uvw6ERXn2n408EEsRhz6gdjgairFOEkZj2t3LD9zz3Z5jzRjbPNP12PjV8iIutge5yVDzbA==
X-Received: by 2002:a05:620a:e15:b0:6bc:980:dbaf with SMTP id y21-20020a05620a0e1500b006bc0980dbafmr4067227qkm.315.1662583786664;
        Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
Received: from halaneylaptop.redhat.com ([2600:1700:1ff0:d0e0::a])
        by smtp.gmail.com with ESMTPSA id k18-20020ac81412000000b003445b83de67sm12599790qtj.3.2022.09.07.13.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:49:46 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Johan Hovold <johan+kernel@kernel.org>
Subject: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
Date:   Wed,  7 Sep 2022 15:49:24 -0500
Message-Id: <20220907204924.173030-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RPMH regulators it doesn't make sense to indicate
regulator-allow-set-load without saying what modes you can switch to,
so be sure to indicate a dependency on regulator-allowed-modes.

In general this is true for any regulators that are setting modes
instead of setting a load directly, for example RPMH regulators. A
counter example would be RPM based regulators, which set a load
change directly instead of a mode change. In the RPM case
regulator-allow-set-load alone is sufficient to describe the regulator
(the regulator can change its output current, here's the new load),
but in the RPMH case what valid operating modes exist must also be
stated to properly describe the regulator (the new load is this, what
is the optimum mode for this regulator with that load, let's change to
that mode now).

With this in place devicetree validation can catch issues like this:

    /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
            From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

Where the RPMH regulator hardware is described as being settable, but
there are no modes described to set it to!

Suggested-by: Johan Hovold <johan+kernel@kernel.org>
Reviewed-by: Johan Hovold <johan+kernel@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

v2: https://lore.kernel.org/linux-arm-msm/20220906201959.69920-1-ahalaney@redhat.com/
Changes since v2:
  - Updated commit message to explain how this is a property of the
    hardware, and why it only applies to certain regulators like RPMH
    (Johan + Krzysztof recommendation)
  - Added Johan + Douglas' R-B tags

v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
Changes since v1:
  - Dropped first two patches in the series as they were user error
    (thanks Krzysztof for highlighting this!)
  - No change in the remaining patch

 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 9a36bee750af..92ff4d59ba20 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -99,12 +99,16 @@ properties:
     type: object
     $ref: "regulator.yaml#"
     description: BOB regulator node.
+    dependencies:
+      regulator-allow-set-load: ["regulator-allowed-modes"]
 
 patternProperties:
   "^(smps|ldo|lvs)[0-9]+$":
     type: object
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
+    dependencies:
+      regulator-allow-set-load: ["regulator-allowed-modes"]
 
 required:
   - compatible
-- 
2.37.2

