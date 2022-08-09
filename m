Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866158E20D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiHIVqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHIVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:46:30 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EA6AA37;
        Tue,  9 Aug 2022 14:46:28 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id x64so10732766iof.1;
        Tue, 09 Aug 2022 14:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XayUQlMIJx4xqOBJefuvZF3U4IgYP7XvIIx28FpBAnA=;
        b=eLE1Er+Tjxy0sqv7FEaqa1z67i9nZMaFmlaSucZ0xq2zgOa0FZXcle+BRMnoQOlpSN
         AMy91AFhDar6o9qE+FBHSur/E7r7EJZV62/6M0BjPd0krk4lZHG9Lq2QFoJ0J0qOAnkG
         otkhnN4J36gD16lCxXIZ/jBwCmkOWkXdXjz/QP86mOSjmdjQAau+IZqLDQeI7V9PHazq
         PFGaL3uLWokvYVHXDYuLJU+OfLgCDB7QWZXGe5xq9zxnERGjLXUAIsqg+G2FY7PvfnXz
         STxcaqHhwDVMiO7RxiM5clCFyPykyr2EeDRqhxtw+bL42yG9UmzbzJar5FeQbqvVw8CD
         aa+A==
X-Gm-Message-State: ACgBeo1pF64TJf0LX2wJ6wmNEahDfr74EboiyGtWBKBtyyZsn/hAoRPg
        WKgcyQWWOiio2x2YP00XOhrg5OBsWg==
X-Google-Smtp-Source: AA6agR6R8kEAP+IPIQBOiX7Ad+dvYoKbJlhBhksjCpkjIYXd3lyzd52WO+7FVBtQSJ6kMmEEugnQWA==
X-Received: by 2002:a05:6638:41a9:b0:342:e3ac:b242 with SMTP id az41-20020a05663841a900b00342e3acb242mr6664252jab.295.1660081587753;
        Tue, 09 Aug 2022 14:46:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05660208cf00b006842e02b527sm1588648ioz.16.2022.08.09.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:46:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: Fix example 'gpio-ranges' size
Date:   Tue,  9 Aug 2022 15:45:56 -0600
Message-Id: <20220809214556.2489822-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'gpio-ranges' entries have a fixed size of 1 phandle plus arg 3 cells.
The qcom,ipq6018-pinctrl example is a cell short:

Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.example.dtb: pinctrl@1000000: gpio-ranges:0: [1, 0, 80] is too short
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/gpio/gpio.yaml

Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I can send to Linus before rc1.
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index b83c7f476e19..931e5c190ead 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -144,7 +144,7 @@ examples:
               #interrupt-cells = <2>;
               gpio-controller;
               #gpio-cells = <2>;
-              gpio-ranges = <&tlmm 0 80>;
+              gpio-ranges = <&tlmm 0 0 80>;
 
               serial3-pinmux {
                       pins = "gpio44", "gpio45";
-- 
2.34.1

