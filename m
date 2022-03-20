Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152E74E1CD6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiCTQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiCTQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FC35878;
        Sun, 20 Mar 2022 09:28:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so17834267wrh.11;
        Sun, 20 Mar 2022 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qRtsVAPxX/wF3ggS905Ro7HdL9aEX5lsc5TyiG/7c78=;
        b=JqaVsAmhfX0Fve5yXMBmHnyBHEMhsgne53GGQD6lBVVdb8U/oaZn7RFwZPUXnC0tY5
         WitNW173nYZno9TIcMGPTZ89FIj6cojanyG149wwIdXk/70Im2PnKl2uWJLm6ejL+Og+
         lAtyvcSivxznZ9fEyDoV/XvmMmmtljrUJJcpUFnF6rOvGjXKe38CFxQunDzoCVYkEPmE
         puy6+3QuuCx+asqln5k5ZMILqXMXMMtY/L/Fr3gUgsAcRo/5VcIaNRtcZ2Bz4HC95KHR
         NoUxCin9/9ArTbXfFYItzoJqC2IXSxNLdeBVXqSHO7rkw9AUrcBUVTvPxxwr3mC/JpY4
         euqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRtsVAPxX/wF3ggS905Ro7HdL9aEX5lsc5TyiG/7c78=;
        b=jeb6dfjJfqRgROfDm+pILUCavD0WrurWYbjd2teN/woNwSleqvDdfSSCx7N/xa4qrY
         RZSpyO49j+S3Ik61K87juo6fTYOrhi6atlpDqiCJ/U5fQ2XxhbusAyOzx3yhg4bW6sNL
         2399r98dVhkDkYxKrt1O0qWmPTup9DWfZ/9Cl/NNF1z78QKOfa+YcybYZUZsEVAZXM48
         y5UVIgQuRxh+rX1VC2tiXSwrNiBJ8NGNU2TQow4YHD4Gc5HCsBw6Uwc2czAqQUzR1n9k
         uffTMnxMz1dYfIgAIKq4TyNJ5o9AhzyEzrBfAC6xen4KI3FTTk35UZgsEpH2Xs3k54/r
         6lQA==
X-Gm-Message-State: AOAM532JLahdhlbEqw/w6Oj6G4r6QjGFD7PZZZRrgmrwJpDPNLG3+cw8
        pMln/BdrYBsuOXqWzJzyhV0=
X-Google-Smtp-Source: ABdhPJyswx/N6Mf45Tx+CCDovof4k2lv/7Eksi2cebeXeKLVMuGKQ9ow3fbMEOvwR3RYz32KZsWolA==
X-Received: by 2002:a05:6000:50b:b0:203:da9e:596e with SMTP id a11-20020a056000050b00b00203da9e596emr15387642wrf.382.1647793707752;
        Sun, 20 Mar 2022 09:28:27 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 15/18] dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
Date:   Sun, 20 Mar 2022 12:34:27 +0100
Message-Id: <20220320113430.26076-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
and the hfpll_l2 clock to be provided. Add these missing clocks to the
Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/clock/qcom,krait-cc.yaml          | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
index 3223fce915bb..f89b70ab01ae 100644
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
@@ -52,8 +56,8 @@ examples:
       compatible = "qcom,krait-cc-v1";
       clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
                <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
-      clock-names = "hfpll0", "hfpll1",
-                    "acpu0_aux", "acpu1_aux", "qsb";
+      clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+                    "acpu0_aux", "acpu1_aux", "acpu_l2_aux", "qsb";
       #clock-cells = <1>;
     };
 ...
-- 
2.34.1

