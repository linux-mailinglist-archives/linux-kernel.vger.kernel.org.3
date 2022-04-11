Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657944FBA79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiDKLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbiDKLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:06:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9F44761
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so7048628ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLZ9QFNTOo+e+4B3gFn1AL6Uth7YED0Q2wsCtU1CceQ=;
        b=apM2h1ms5c+iI/NSYW3yyfH81cEjMRDAnDYfuDCWwG+CkJbHHtJ9BlBeGWDh5ZQb6E
         1UNZVL+969e58TvdEsH6dwakbcbEXRfAmSdbIUQ+wZOAgassczKahWx5K4wTfYcig1ZV
         QW6N1HrY0/Pg639vIev2F7sB4N1aSBCgkf1wSSzcQdbkX96/KLwYMgSY+pXa37/Mjd9O
         7or+dmYzX0vrgIooU5m0z+eKFcCpB3pDEBCQZ52gN7TtfvZpyUuQ3oTgl54+fgM/puKv
         PyDBsRR3rD/UVUs96QkjqCZHWvSz2ED0aI6n0hcL1Is6BQN45aGr7p8ED70GsmBVNLrR
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLZ9QFNTOo+e+4B3gFn1AL6Uth7YED0Q2wsCtU1CceQ=;
        b=qUdyNHjDu9kfceV3au+aPYdH8s1UYe3bZObzXFzLo5h2t9w+IbYrT8G++CS6wm9HE6
         XGsboTbZPTdsQsUDR6Os6wUXOkGdeJKgL/ttn1OXQ2kkYW+JhrDGhNw/1xSYQOuKIPfT
         szppjMzsUnPFk/FmT2piKCQjV8F+KWpbM9z9laFvlB5bc7yq61qQB6kwjvJ3wjs0bRto
         tJf/CwzvnC/bDH7w2nTmF+Du0sdfZjGkvuC7/OSfPenVQFRZTho2CSIlGwcj7H4qvrMv
         X3bBodzzpf7r8881MGKrZaBynwu5rgSukfV8Pxz01s0N9SZob+19UV0WXFG59c/YnoTk
         rkJw==
X-Gm-Message-State: AOAM532l77UxwfRBYb5LChd4RX927phpoMf5RaHJ1mOPposnSiSbR8ik
        QJoHs5KaG4b6bcr7aWS8ZXM9DA==
X-Google-Smtp-Source: ABdhPJzOFbGMPqgKmzqRB7SXP1KsdleWb89TPTqiFSR+KZ7uozFAHd0F3yhLU9CzFeARCrylPJtzUw==
X-Received: by 2002:a17:906:3144:b0:6ce:de5d:5e3b with SMTP id e4-20020a170906314400b006cede5d5e3bmr29463811eje.689.1649675033144;
        Mon, 11 Apr 2022 04:03:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm11074074edl.28.2022.04.11.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:03:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH 2/2] regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on PMR735A
Date:   Mon, 11 Apr 2022 13:03:44 +0200
Message-Id: <20220411110344.231903-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
References: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
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

The PMR735A comes with vdd-l7-bob-supply supply.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/qcom,rpmh-regulator-supplies.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml
index 26baa6f2edc7..df50fcefb3e5 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml
@@ -223,6 +223,7 @@ allOf:
         vdd-l3-supply: true
         vdd-l4-supply: true
         vdd-l5-l6-supply: true
+        vdd-l7-bob-supply: true
 
   - if:
       properties:
-- 
2.32.0

