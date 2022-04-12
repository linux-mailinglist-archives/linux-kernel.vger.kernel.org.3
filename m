Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94344FD9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383254AbiDLJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377813AbiDLHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:54:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96354BE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so8534115eju.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pv2aqZRlphXWsbP7cW1sdTxff7zf/E+Tb0dBz6Xzybk=;
        b=CGQ+cvNQPiW1N+0YWA5QTSHV6wmHCk1tJeAjVrtTCEvsr8Hr8PZD6PtNdWbAz1TYzn
         mZbI1PHjuEgNMaqvDmLALYdhX/eHunKIFatZAfFftsCKV5wA/9pD4zkChZaM+KmasgHx
         h7iibJXs89G0Rw1QnYFdm0bFSi95W7vbOYBl1GjuigDiQjMC/wgnl9p2x9kij87RyvFW
         0EM9c1fVcAVt8Eiwg4BaLgemPnlyIbVyU39hmXaMArNEwktcDbIH93kY2zc8RbzEORSH
         +ABCJ9yBiJjuj+uQo39Z2+YXFQCucl0YGSj6c4da0IVH3m5E1WSEZPq42ZNVyg56w8Xx
         tZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pv2aqZRlphXWsbP7cW1sdTxff7zf/E+Tb0dBz6Xzybk=;
        b=r7NRebug6/0j6AFFNBos0QQICIJ+JrWnmimiVoXJcHuRm4XQP/KpHV+3SAxHD7IA00
         T0SXJNQniLXVgsRCv7jWNkYd7fMsNadt0psQXsoSORsG1gmQL8KxdhJI7ZS08Et5q3A7
         ARGOdBUMhDY8OA75P8OcMMJKZ18ZkGwvr35qkfsAzAyE7mi2+xYMjh+aKQA4T4OQgR8e
         5QjUKVYM+FwpqF8Hq7ooJvQIwORLCtmKM2NpU9LBkCspEVJV5HQmAEuUGdj/TGvMwO1o
         6PwNSzjy8KzjLJ1ud7UDKRF4wbE6KuqxzfO6IO2dpaQWEoU1Yj/kEmWOpwKc1TsDG4YH
         nILw==
X-Gm-Message-State: AOAM530CwBTe6Nedu0zUlZ/+502uCRWOOLcrJ0y5YXYaeYFubzpQeUDD
        KCIjm5pWMfh9tIIAqDVJxCbIAA==
X-Google-Smtp-Source: ABdhPJxHKnTad9NwMMXwBWu5O2m24wgLf6WwV/9jLSfuK5qK+/e+fwOG6L1BjL4extYRmojEioi7fg==
X-Received: by 2002:a17:906:9b8f:b0:6db:ab62:4713 with SMTP id dd15-20020a1709069b8f00b006dbab624713mr33710398ejc.738.1649748693523;
        Tue, 12 Apr 2022 00:31:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm12571234edl.28.2022.04.12.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:31:33 -0700 (PDT)
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
Subject: [PATCH v2 2/2] regulator: dt-bindings: qcom,rpmh: document vdd-l7-bob-supply on PMR735A
Date:   Tue, 12 Apr 2022 09:31:23 +0200
Message-Id: <20220412073123.27229-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
References: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 773536fe37c7..96d51449524a 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -347,6 +347,7 @@ $defs:
         vdd-l3-supply: true
         vdd-l4-supply: true
         vdd-l5-l6-supply: true
+        vdd-l7-bob-supply: true
       patternProperties:
         "^vdd-s[1-3]-supply$": true
 
-- 
2.32.0

