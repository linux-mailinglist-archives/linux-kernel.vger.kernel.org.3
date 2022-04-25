Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB550EB03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiDYVKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiDYVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:10:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7164738
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so462743pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pa6zrNLxEFTJIYew9I+MslyE/BqjUU2Vfh9xpblR54=;
        b=Shoz3tJtEfbeJHLbZbbAtm+y0n+qLrUd1IsVnLxx+HlgH0lU5Bzat9UjXBvtUxxkcZ
         fWVUxh4HAjy8+bLXQnIQG4pqK/T/ki1Ts5oXpNSWDKVq5nlj2zefrPxGz04zSJctnqww
         MdFeL7gkO8jwSYpuKBh4ELKQF7TnQPSYm6R2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pa6zrNLxEFTJIYew9I+MslyE/BqjUU2Vfh9xpblR54=;
        b=pbxoZ9PCTJtyKJTrMQcQePIJY/iJKQB/g0yvzUgWK7zEszRvEn6b8QdYMQqbO6Ely2
         BeMhhmp4VfwMHOsC8HuU/y9Ca7iEM60HY2C1Wsa2MDuhRVsNawvK6CsKqGWITGoZ7Ec/
         yOFsipU3flwmuVGrn4IDdG8JoYyNUeZdQAXj78iFl+dUdRJeihm64P/BpqhPQWCJmwtv
         nHMBRaeByqqFhNVoz4z6Jzt9z/AP2YNzMC7NYjUkzuGoQBN+86WJtJ/WZk9MuZsQUQqa
         O8PCakPrMT6vL+U+ABRySEPA4lUiL1/lA9JeGiaJtFoZ22SQnvUU9CWa+KqXnTseO6Rr
         Pd4A==
X-Gm-Message-State: AOAM533R3EjbxZUSWBLni+6dBViV1YfFVioYK/rQxa2/4+TYhGlC8wjt
        BTGuLBAy6xxlzUpC6jcScoxV7w==
X-Google-Smtp-Source: ABdhPJx+uxbkSaPe2+0BH9EheOMTgYzUOtVzJymppogmrFVLTMjQ1PWdb8ch86SegBtXfRZtKHInSQ==
X-Received: by 2002:a17:902:cf0f:b0:15a:24e0:d9b0 with SMTP id i15-20020a170902cf0f00b0015a24e0d9b0mr19745380plg.42.1650920833478;
        Mon, 25 Apr 2022 14:07:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:b820:7f63:f3dd:3da])
        by smtp.gmail.com with ESMTPSA id b20-20020a62a114000000b0050d231e08ffsm8523202pff.37.2022.04.25.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:07:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-phy@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, quic_kalyant@quicinc.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: msm/dp: List supplies in the bindings
Date:   Mon, 25 Apr 2022 14:06:42 -0700
Message-Id: <20220425140619.1.Ibfde5a26a7182c4b478d570c23d2649823ac2cce@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220425210643.2420919-1-dianders@chromium.org>
References: <20220425210643.2420919-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're supposed to list the supplies in the dt bindings but there are
none in the DP controller bindings. Looking at the Linux driver and
existing device trees, we can see that two supplies are expected:
- vdda-0p9-supply
- vdda-1p2-supply

Let's list them both in the bindings. Note that the datasheet for
sc7280 doesn't describe these supplies very verbosely. For the 0p9
supply, for instance, it says "Power for eDP 0.9 V circuits". This
this is obvious from the property name, we don't bother cluttering the
bindings with a description.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/display/msm/dp-controller.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index cd05cfd76536..dba31108db51 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -76,6 +76,9 @@ properties:
   "#sound-dai-cells":
     const: 0
 
+  vdda-0p9-supply: true
+  vdda-1p2-supply: true
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     properties:
@@ -137,6 +140,9 @@ examples:
 
         power-domains = <&rpmhpd SC7180_CX>;
 
+        vdda-0p9-supply = <&vdda_usb_ss_dp_core>;
+        vdda-1p2-supply = <&vdda_usb_ss_dp_1p2>;
+
         ports {
             #address-cells = <1>;
             #size-cells = <0>;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

