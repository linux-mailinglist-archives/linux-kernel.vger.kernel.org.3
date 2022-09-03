Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE5AC05A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiICRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiICRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C257893;
        Sat,  3 Sep 2022 10:42:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fc24so517778ejc.3;
        Sat, 03 Sep 2022 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P73eOPxMdP7ah0azvc46uUcxJLF7hXluonfSDW4iPlU=;
        b=FYOYYO7nA9ih7qSra3mlwk6cojp6M3gau8L+lT1NiJEBEDzwc2bRy8XaTLRtlfODRr
         QtBLcFU4zoeXc497oR4/gjCSmBsK8iHSng2AkmYTe2VBit0wS9d2QtHkXgac+yqTpQ6Q
         PWshtu4YhbKLHDVbyCi4iyZu6umUqKu6iazVT+PI1AwQlObMBrB4q2vAmOTt/X8apFVm
         S3wkuKLdMEp09hkDog5j1l6otrarLNqiGTyTNtXyxTa5S9ZIMEG+sce/KM14a1/MiAWW
         +kVcVUC/Bt25Gg9v68V+UtCY5tmqd/43flHA9EHX3A6Pe/U97YLBouDCnIJPqtXtlx9j
         KRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P73eOPxMdP7ah0azvc46uUcxJLF7hXluonfSDW4iPlU=;
        b=nadoRIdifWdj52kfvdIu+KJ2QfLoFbxf2CBrdE6abKjJH0kXfWToyP2FVGGwHuU1jD
         hy1gDPxoVVfTR/VoqFxc/qjgg7H28o0QQwW9Orc2nnPjP3yMxf2OIOC1xIhoRhDxtYFv
         9W968luaLkodAvi/ncVKv+nfG5COKLUKZedq3OcWoRAyJrHLvJz5XZDjmiEbsepqSG95
         qBaMpJ7aN2UcnzcrPuLeokL1ylbIMZtNPNReRhg5u24T6qdH3cEPk5awBlDE1AZDrAqn
         xSe3g3qssZ82BLHuhS6InsYLQUbV8p7XCf8ute6TdhB16HsrggZKFsyyM8zwoEAiYG3E
         7LXg==
X-Gm-Message-State: ACgBeo0i2306S/ttWEddQV1WWtUNzENzMxT/zUd4bxxP6CvgTtp75rOM
        Cup0dh9XePRgYr6+dJb48uY=
X-Google-Smtp-Source: AA6agR693gMoJ12Yqon2WkSOZAzj4/Z+NxE82MtUpcccaXpmS5XBS56s6uLjexZ6F/Bhee5HkNkQ6Q==
X-Received: by 2002:a17:906:8a5c:b0:73d:7f4a:b951 with SMTP id gx28-20020a1709068a5c00b0073d7f4ab951mr30384322ejc.481.1662226947822;
        Sat, 03 Sep 2022 10:42:27 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0073d83f80b05sm2745035ejh.94.2022.09.03.10.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:27 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] dt-bindings: pinctrl: qcom: sm6115: Add reserved ranges
Date:   Sat,  3 Sep 2022 20:41:45 +0300
Message-Id: <20220903174150.3566935-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

Ideally this and similar common properties will be inherited so you
won't need to paste them in every pinctrl binding.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index a7a2bb8bff46..d8443811767d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -49,6 +49,8 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  gpio-reserved-ranges: true
+
   wakeup-parent: true
 
 #PIN CONFIGURATION NODES
-- 
2.37.2

