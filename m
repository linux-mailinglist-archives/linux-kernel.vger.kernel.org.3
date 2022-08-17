Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDDC59721A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiHQPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiHQO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:59:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794CC9D649
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s7so734394lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CEQ6kD7E3x3cGbQZ0xWqW+Ktcext0aENc2Q7rleIIpo=;
        b=feRYuCsolaZn/GfCklF8jvHuaRiNNWaaxl9G33ZyVBdxTW6U93OFlzOU5GIDeCTm8l
         1P0DlrEsYbZHJoXirIAj2g9O5O3Wqnu0dXkoAGP0mr2EdrYVOmxRGoDjuN5NRlF2GkDa
         7v4HuRWHwSvl0ZSHvAERaITHcq6zXUogpcpiyl3UQmXN1mZrWiJP43ury2Ts/valcbNN
         RfxIGraBgy333dd3NxqZN7TFNuaNQBr0TevBG5GcUZdnsWPqz2tVLzidrTK/Rx8x+/Q+
         ewEbmiK5rc+VifKQAwAiMFE/MWXmwIrZsSRRnDeH0OPiFm6VOKNRG7rM874GX6f1Z7kH
         XVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CEQ6kD7E3x3cGbQZ0xWqW+Ktcext0aENc2Q7rleIIpo=;
        b=ivv9RMqTvihpJ65XBw7c+fKkK+y9X0j1n8YW9BLrHtuae5jbDhAPykVGgOCzmsrZqm
         9lkK/onDFze1oIqfbTON06JxzbrFgzt5IitXMOCaHYeM3nW8BNXooK+Q0JoOezqLvPz2
         n6GalGG8ib3FJEukfbcjknD0E/A08HT+QWgi028vJCgFA28jZtfMSOEEk9cDQQQcZdSj
         TOh6SpTat0QKjUN+1HArRTF4vqUHqTfaGuwvT/aIDSV4nW9ezVonnHqLCkEWqicCQ8TM
         zgxaI9QiRjKgtCVRIXosQ4M0fE+SLtWjXMYWBWfQtJ/iDyVm8Uq4TXQltOKOjcGQ6MKJ
         09Wg==
X-Gm-Message-State: ACgBeo3EuOimB0J4PlkIJE+KnasikOYljr7etrdcvexhYMfEDxwMTZy/
        TIo60sZzIHH3FYtApb3Tp3Efbg==
X-Google-Smtp-Source: AA6agR6Nx2FQDa0zEk4vlasfmkFU5oeMYo2GN36ypPFcTK/xIcF3J8eP6iggQo6+Iy7irFasJanf+Q==
X-Received: by 2002:a05:6512:6d5:b0:491:a52b:2a47 with SMTP id u21-20020a05651206d500b00491a52b2a47mr6413522lff.608.1660748353048;
        Wed, 17 Aug 2022 07:59:13 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0025fdf9eec1dsm2250454lja.111.2022.08.17.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:59:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 04/17] dt-bindings: hwlock: qcom-hwspinlock: correct example indentation
Date:   Wed, 17 Aug 2022 17:58:48 +0300
Message-Id: <20220817145901.865977-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use some consistent indentation (4-space) for DTS example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/hwlock/qcom-hwspinlock.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
index de98b961fb38..1a3adf75934b 100644
--- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
@@ -43,9 +43,9 @@ additionalProperties: false
 
 examples:
   - |
-        tcsr_mutex: hwlock@1f40000 {
-                compatible = "qcom,tcsr-mutex";
-                reg = <0x01f40000 0x40000>;
-                #hwlock-cells = <1>;
-        };
+    hwlock@1f40000 {
+        compatible = "qcom,tcsr-mutex";
+        reg = <0x01f40000 0x40000>;
+        #hwlock-cells = <1>;
+    };
 ...
-- 
2.34.1

