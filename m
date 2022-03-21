Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA34E2D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350849AbiCUQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350760AbiCUQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:10:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50E8289AB;
        Mon, 21 Mar 2022 09:08:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so11741177wrd.6;
        Mon, 21 Mar 2022 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVanjMije3tfr+7CJiXhw1cTBweJMi/rMWXgUO9gp0o=;
        b=HXG6PA70QlczQc7Abjaqi9vHx+i/pBG7lVF2wBfT7YRq1Pj0I4AjaHaatc3CFovSQQ
         lWjYxQGah/Vf0RIbBGni/DLL4Kt7+wosaHq9HIVC8z76ljKCuJ5S9RbREjLhj6g3HNN+
         lVtePer/xFibKJu/DTxlVS7dnjTcFgAlS8oz38ZQQFAeRHiKHtsJyGUB7ydzspYIBHGS
         Q9B66KMV2mFHzN0O0S4HWFKQV0ROq2vbsFQqxLsyZJXij33I4kKV6lQigOhKMy/Y/B3v
         XyL2p+mcYc3oLFakvWLDTbQxofrg7vCUs0qJiS8jRk/NR+GER1SBDQtZTAZI5L0WlE9B
         ps4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVanjMije3tfr+7CJiXhw1cTBweJMi/rMWXgUO9gp0o=;
        b=7mGZllTwxUhCo236MQ/fwEPW9JgltCTpy38TjMKFhMHshX2QYpAWGnBMsy2W6bKxDA
         Ht48pzqXijm/lolOdnxvn+dgP920YKU7FnRgoUM4FyCJnwE8vIYvSwmqTvvKpvKrl1yS
         naovbeXlvwgZZ3zA5pC50jsBSZtjSvrhl2QJ3h8XDT6iSYtJTMQwbU9Ponyfd7mBAXt5
         CLutbYjQ9ZfW46LNeAsTFuRNvMR66+IySZJKH/5+skaP+rRuKK/GxQ5DHC8s8zkzIooe
         7bFDSAalzrmfb7qeJExPgjziKVL2vsPpfxQi8aU5IZptmci6f1eLrnx3pTVWia42jQ4k
         wrfA==
X-Gm-Message-State: AOAM531ClaGrb4/7wA7aUME0p/B7A0uJP3uwa9bJoltyYKZBvuYh7p7n
        Asm+CXb1VRWYPTdGbag46Gw=
X-Google-Smtp-Source: ABdhPJwQr5BVVhyr1pH11AUAgf0kvBtQ/dHCSW91R7Iqz6Z+51XEcZ0O6DndQlz9X9Y6DyZN3fmIrQ==
X-Received: by 2002:adf:e752:0:b0:203:ff72:b085 with SMTP id c18-20020adfe752000000b00203ff72b085mr9793719wrn.609.1647878911302;
        Mon, 21 Mar 2022 09:08:31 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:30 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 15/18] dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
Date:   Mon, 21 Mar 2022 16:38:52 +0100
Message-Id: <20220321153855.12082-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
and the hfpll_l2 clock to be provided. Add these missing clocks to the
Documentation. The driver keep support for both old and this new
implementation and should prevent any regression by this fixup.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/clock/qcom,krait-cc.yaml     | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
index e879bfbe67ac..f89b70ab01ae 100644
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -23,16 +23,20 @@ properties:
     items:
       - description: phandle to hfpll for CPU0 mux
       - description: phandle to hfpll for CPU1 mux
+      - description: phandle to hfpll for L2 mux
       - description: phandle to CPU0 aux clock
       - description: phandle to CPU1 aux clock
+      - description: phandle to L2 aux clock
       - description: phandle to QSB fixed clk
 
   clock-names:
     items:
       - const: hfpll0
       - const: hfpll1
+      - const: hfpll_l2
       - const: acpu0_aux
       - const: acpu1_aux
+      - const: acpu_l2_aux
       - const: qsb
 
   '#clock-cells':
@@ -50,10 +54,10 @@ examples:
   - |
     clock-controller {
       compatible = "qcom,krait-cc-v1";
-      clocks = <&hfpll0>, <&hfpll1>,
-               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
-      clock-names = "hfpll0", "hfpll1",
-                    "acpu0_aux", "acpu1_aux", "qsb";
+      clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
+               <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+                    "acpu0_aux", "acpu1_aux", "acpu_l2_aux", "qsb";
       #clock-cells = <1>;
     };
 ...
-- 
2.34.1

