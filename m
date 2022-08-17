Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC415970F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbiHQOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiHQOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:22:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F99018E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e15so19260811lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ts76PcyKw0jM6XarGajWHwsIAiV4DTWPpPPo0AWZtJA=;
        b=JOJbWVLtHO6s9Pc8HcJChhshshhY2T/4/MCUDhf62a1FLjYupcZU4YieZWuff3QUQe
         Bmo0/osTc77ZNgs2QpSJ/S1IZwE0FFgGMork/YRXtt0HXbvNAc2oKtrarCpQcTHhRbBN
         D8qpKos+7Rlv+L1SnE5uF1nlfkG27KdJLiPgyDruh48s8nP7qfekstOKH4inFZUl4VnL
         fjNdITKaE2d8NE6egykSQK+x6FklOvlT/bKuSrN43tASRXm7eJwdrFK13Ut38I9Z8cBo
         MfL2onHGHoYx8kkYpPIA552aF+WAulZML5pi8jS7IuhYExm0MSnI1zqu2cX1RTLBa4Jp
         KPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ts76PcyKw0jM6XarGajWHwsIAiV4DTWPpPPo0AWZtJA=;
        b=ZV7wBHFNGMFygpmLFCLR147EDQzhOY7qB0540PMPoa1v7IuByEltqz9OCbeArTx8Du
         VUNVZafA91L0RmOyAPG2Cai8/OVx1WNkZFpb3JZFpbiPJnOsgMcwdwudgCnUNT3s7CDX
         I6VxC8Vm+gZne6glIt2UYEkQ7EXtEnoPF4P2DQzjJ2nZ/Jsq3TV5TWhP5dezvoWER2hs
         TOEwDKCKeXydRU7ycre0R9C0jopvQHq3yJx48sUAUmbZclRlcRAhCFseG/mOrlJsbfir
         zVok1+WFa8Zz09f0m1X2D/nI1/LU3yBz7nGhWfC2zT9WOsoOL22hQEbWtjN4QFY0DWxS
         o0Og==
X-Gm-Message-State: ACgBeo34/rBR8xpeELwTV91bv+/+unP9pF/PrdeSH9eZr9Qrq5Wl7VGf
        JM0XTP5wlLajNQbm6EmiEez7GA==
X-Google-Smtp-Source: AA6agR4qGhm3oKo5ILBcJJjEibUlASlIQgN2sJ66ZGB2EpL2gJQJVh0eh9J0qhasVYm0uW5uTG0XAA==
X-Received: by 2002:a05:6512:ba4:b0:48a:f185:db17 with SMTP id b36-20020a0565120ba400b0048af185db17mr8107080lfv.107.1660746173606;
        Wed, 17 Aug 2022 07:22:53 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f7722b73csm1704647lfo.142.2022.08.17.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:22:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] dt-bindings: phy: hisilicon,hi3670-usb3: simplify example
Date:   Wed, 17 Aug 2022 17:22:44 +0300
Message-Id: <20220817142246.828762-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon and simple-mfd cannot be used without device specific compatible,
so simplify the example to fix this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/hisilicon,hi3670-usb3.yaml   | 26 ++++++-------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
index ebd78acfe2de..1cb00dbcd4c5 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
@@ -52,22 +52,12 @@ additionalProperties: false
 
 examples:
   - |
-    bus {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      usb3_otg_bc: usb3_otg_bc@ff200000 {
-        compatible = "syscon", "simple-mfd";
-        reg = <0x0 0xff200000 0x0 0x1000>;
-
-        usb_phy {
-          compatible = "hisilicon,hi3670-usb-phy";
-          #phy-cells = <0>;
-          hisilicon,pericrg-syscon = <&crg_ctrl>;
-          hisilicon,pctrl-syscon = <&pctrl>;
-          hisilicon,sctrl-syscon = <&sctrl>;
-          hisilicon,eye-diagram-param = <0xfdfee4>;
-          hisilicon,tx-vboost-lvl = <0x5>;
-        };
-      };
+    usb-phy {
+        compatible = "hisilicon,hi3670-usb-phy";
+        #phy-cells = <0>;
+        hisilicon,pericrg-syscon = <&crg_ctrl>;
+        hisilicon,pctrl-syscon = <&pctrl>;
+        hisilicon,sctrl-syscon = <&sctrl>;
+        hisilicon,eye-diagram-param = <0xfdfee4>;
+        hisilicon,tx-vboost-lvl = <0x5>;
     };
-- 
2.34.1

