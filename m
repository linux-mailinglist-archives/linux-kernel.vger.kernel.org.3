Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C654E2BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350028AbiCUPUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350055AbiCUPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11651FA6B;
        Mon, 21 Mar 2022 08:18:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m30so11325384wrb.1;
        Mon, 21 Mar 2022 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8N4m3sbkCAQ3DmZRfniFRwQwLPXWN85JqeoH01RJVUo=;
        b=C94filCLMSxKzlfN8YoVYKK/GVOugcfp9eNDHh8Wewd9zgGqd5CfAGKQbLGBm3WaWt
         7EQG+8abEHEeb9S4F1SD8/toJmiEbWe859Eytdt9pRVGFX9azMNwMk5gT4Yjl1/bhsCc
         +V4mfmXneJ/QLTwgcnrOQ1Z2PB05yMvA+BppOhusp8bwjb6ULmqi555ZCf4P6PfqEnBb
         IV3keCb/bTkrPMXa4z843svAMg/fOcF8F6UD9TGN/qLWEbLbc31ZfpAK/pRn9A+B8lDj
         dtKhtRBL062vuPxrHRTcgnyRWt/E+QVxsHpax9NB3SrA/A7T8As1WjkKerxU6eMNhq1X
         2sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N4m3sbkCAQ3DmZRfniFRwQwLPXWN85JqeoH01RJVUo=;
        b=ZhGuVhlrubH/E7YXVO3nmHMxm3yXIFkLHNRjt0JYnLhwDEQJ3Q/WnOJ2JMPUhfy+Ek
         hSxugIPSXtPbltdqU8rxQrsgnS9HkHoJBvkNSTQApAeu4OfQ7zK2GYEXqwF2xgFIh6ez
         nzyh5V65QywpbvS2/6drtJDpMEJoL/+sYj/6o3574owBTcxmmNLhM5SUYV2knY/W0eN0
         Yo32BZF3PIG0BPrOm2il9i74wVp/hXWSeDgbsuEW7bgOheTo0/1XPwhTBQqqhQ3kZvPq
         RIm5l90u5HAlHjyxw/xoMhv4ArDvl1FGPnVjzbdtJZQsFiGNa+adYde9+6K8ULpk73EV
         YmdQ==
X-Gm-Message-State: AOAM533tfi2uev/nHy78uKLxmqgRLAaYtwFh6L36DToBNJhZDRKSQxml
        EpQ7emoISq2PJbHtlkUXx9s=
X-Google-Smtp-Source: ABdhPJyKAuoGB/4DrEEbrhxAJ1e2YtHXkT3+BpuZbYJrT+Ds6PYPVGKivMZsOyPfMs2hVmW1p7rH3A==
X-Received: by 2002:a05:6000:1142:b0:203:fe14:e313 with SMTP id d2-20020a056000114200b00203fe14e313mr10373618wrx.448.1647875881485;
        Mon, 21 Mar 2022 08:18:01 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:18:01 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 15/18] dt-bindings: clock: Add L2 clocks to qcom,krait-cc Documentation
Date:   Mon, 21 Mar 2022 15:48:22 +0100
Message-Id: <20220321144825.11736-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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
Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
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

