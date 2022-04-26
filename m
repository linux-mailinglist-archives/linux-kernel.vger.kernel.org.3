Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216DA50FB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbiDZK6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbiDZK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:58:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406B1659B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:55:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so35290599ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0m5ZZfG1YF2A40apHuhZaDOYLmk1gRk32TzITEEDGDI=;
        b=Sj4lS5VAzOQWv+TQxwwUvECq3rxmplzfBmjrZe5aKAF7b8hDpfF+lRipnxkDq0Y5A6
         jFgby37Ulk4+z/NsxQQRcHrbB3bmt4abfSjOPgu6zkse+wPSVdmS0xe9MPXLwPsC/S3c
         BJ7cJEOy+vzS/vz7Ubfef1c/ehj4FTlDBwQxmdKjxG4DyT2yw2x0UOHDy4k63XsI8yt9
         aXKjkFopVKwUTwocjytCYjsx9EaPfnl/ul9Czu9jz8OpW8qeeqIWHc/WiRl9qRKuBuB0
         zZdcuezjbsT3Z8gGc28kWBc0BItP4FUxlnol2dRTTIbVyXEAu5tEo09QlG93jcLbKOyA
         TnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0m5ZZfG1YF2A40apHuhZaDOYLmk1gRk32TzITEEDGDI=;
        b=tq4HoX/G5d3DH6YFBwTRgJbSW0kUnEzompLcPbAqVsW+mWoKHGw/lfXr9Cwc9GPGxn
         JbUC42PWT9rkf6bkcGTFuEc7Yo+szrArCKEIlnQ0BD0+X2p0uPxGoI+v/xn5YwW7ksV+
         wxAEEIpyhvmzmE3i8i94EPFK1QBCeSgE+sneEJKhJnNm/kvSGaDTlSnXqauEvl6iEabc
         tnNOYDvom3ElMk1x0IXqFFWnm04s+2K5pkXrlBgQXUgbDpuFwB/FqR+7botZ5Zmo4A+l
         8OlVy4jcEgU1UOiPvK8eovNPJ0j39H/M7WCpxSjBrL9IzB2FUuQxQY6aEuSUPN7QVMH+
         HRFg==
X-Gm-Message-State: AOAM533ehkBoYmgQFVsty/KXcmgz7qC8V1iitQGEKzeGZYQRsjByQM/o
        zU9GYL3x/MW6LcN2aSXdepoqig==
X-Google-Smtp-Source: ABdhPJwzco/w60SSupURIzYxoiPHR7O0hkeySk1FSa+XINU2RjSsH+0aJ4xgXXn/8T/1vSpoNH44Og==
X-Received: by 2002:a17:907:e8d:b0:6f3:9721:dbf6 with SMTP id ho13-20020a1709070e8d00b006f39721dbf6mr9134713ejc.448.1650970512188;
        Tue, 26 Apr 2022 03:55:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s5-20020a508dc5000000b004241a4abbdfsm6062843edh.45.2022.04.26.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:55:11 -0700 (PDT)
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
Subject: [PATCH v3 3/3] regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on PMR735A
Date:   Tue, 26 Apr 2022 12:55:01 +0200
Message-Id: <20220426105501.73200-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
References: <20220426105501.73200-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMR735A comes with vdd-l7-bob-supply supply which was previously not
documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 6b99897fa404..9a36bee750af 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -313,6 +313,7 @@ allOf:
         vdd-l3-supply: true
         vdd-l4-supply: true
         vdd-l5-l6-supply: true
+        vdd-l7-bob-supply: true
       patternProperties:
         "^vdd-s[1-3]-supply$": true
 
-- 
2.32.0

