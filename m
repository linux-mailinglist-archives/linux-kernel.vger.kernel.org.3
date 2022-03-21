Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E14E34B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiCUXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiCUXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB27DE09B;
        Mon, 21 Mar 2022 16:45:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d7so22756302wrb.7;
        Mon, 21 Mar 2022 16:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/YdzwT6SzO2Fufqs+3VjNkZ7pK2lc35vBubZjd9sSo=;
        b=qpCSDArJms2zr0r7JCBIwZbWYktgyNWaD+UYTox41F+eoSSHLpHWuIsAJgfshcGHLP
         SE5K8ag3YOdyO662rINwWMtyXK6xx6hcNeGvd21cyCrH88775/jvotIOPPmb15YMUisa
         Nn2PsFfNZOLiUwGjVdU5w7TBdyAaLbniOzgvZFp8p6LNONda7INuMplQxLYxG8WnZzH9
         +bMtiKhfL0lQPxbZHOsDJHwDweNKwMoU+Qjn6mX4qALSFqR8vBijGFzy3gLbfa7QGoir
         CXWq2ZS8eeVCa74m+DEiLzOoBY8TdYK+UZVJlVFaV3h77ou8JrUfA5SGpHMLvO+eVeNX
         WgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/YdzwT6SzO2Fufqs+3VjNkZ7pK2lc35vBubZjd9sSo=;
        b=IkoN4MRQQClIbrNbZRx43LNUEHklb0AjigqCVT2DwnsNOd7+8g5o1IJ7Yyy2iWC/Zf
         iABRrL/NDOkPSwv0hTKytN3Njex7/FWZVUZW39gOizO7+lxwjy1l/wQB02Oa1Ui408+6
         rElDTvRRcjYY3vEYZtPlV05rDgwMv23We9ybdY7Ii4eKthu5f5CeGrND+DCtwjsxYzzW
         8HdNcKS3SzlgC5RIKW1GTY4LWA/++8RUurR8zNjQE/asL+4EE33eeVKGNQ1LVO+ycVck
         +7hmn0kM8IKKmfp9SBi8qW2pQJaM0XLmn8/mbHSecg9LX/C+XMxctdxJhKsJgbpfLUtq
         xtaw==
X-Gm-Message-State: AOAM5302hDgHeUh9w63RUB7jSvN6Ixbm0cQCpaM9AyoMNocKenBDgAZP
        pdOU2txSYhc9cBzzxlDyOjs=
X-Google-Smtp-Source: ABdhPJwzrJh8StunMpQ1GvycDhtu+wkcSpS1ivCr2z0tEccGE0oiuOpn6/dMDUC/19y7M9+cmDrg0Q==
X-Received: by 2002:adf:e4c2:0:b0:204:6d8:ce9a with SMTP id v2-20020adfe4c2000000b0020406d8ce9amr8714240wrm.189.1647906328047;
        Mon, 21 Mar 2022 16:45:28 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:27 -0700 (PDT)
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
Subject: [PATCH v6 15/18] dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
Date:   Tue, 22 Mar 2022 00:15:45 +0100
Message-Id: <20220321231548.14276-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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
Documentation. The driver keep support for both old (it did already used
these clocks and we keep the same naming scheme) and this new
implementation and should prevent any regression by this fixup.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/clock/qcom,krait-cc.yaml       | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
index e879bfbe67ac..de4320a85764 100644
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -26,6 +26,8 @@ properties:
       - description: phandle to CPU0 aux clock
       - description: phandle to CPU1 aux clock
       - description: phandle to QSB fixed clk
+      - description: phandle to hfpll for L2 mux
+      - description: phandle to L2 aux clock
 
   clock-names:
     items:
@@ -34,6 +36,8 @@ properties:
       - const: acpu0_aux
       - const: acpu1_aux
       - const: qsb
+      - const: hfpll_l2
+      - const: acpu_l2_aux
 
   '#clock-cells':
     const: 1
@@ -51,9 +55,11 @@ examples:
     clock-controller {
       compatible = "qcom,krait-cc-v1";
       clocks = <&hfpll0>, <&hfpll1>,
-               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
+               <&acpu0_aux>, <&acpu1_aux>, <&qsb>,
+               <&hfpll_l2>, <&acpu_l2_aux>;
       clock-names = "hfpll0", "hfpll1",
-                    "acpu0_aux", "acpu1_aux", "qsb";
+                    "acpu0_aux", "acpu1_aux", "qsb",
+                    "hfpll_l2", "acpu_l2_aux";
       #clock-cells = <1>;
     };
 ...
-- 
2.34.1

