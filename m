Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCE5A8472
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiHaRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHaRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:33:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF7D0764;
        Wed, 31 Aug 2022 10:33:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z20so15391096ljq.3;
        Wed, 31 Aug 2022 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=B1ibTKMyiJ1LGPgA3PPxcMCMVKhW6r012zajDn2nbJ1319vaCA+IRb3tA4cgP5rP9p
         kAiGh6t10dodzzwSCKQDl+9RY5mjPgfQvdkPtY7Geps6kEGIXiCcb3cRd7MjMBUGOdh/
         Xz00ILuGh88a6Hl9/PM8I/ZRdJoUbNkBCK8aGp7MCfWVsBwZUM2j1urOUhASvByoOQgy
         iVwDRKnPe29au1Z3yyVXdWCE830w02/hScwFrFqbbRVGI7pGzF9FLAblPIl/h7caHT2D
         bemcAu+i3QIyvB3YgmJ09053EteVMFhbfAz50P9MNJx4m3cMIYthJeLJAQK8UhJcP2Ys
         JW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mzAbe27dU/1yrwR+00TAM5R4bCuMUl4NRC/4hekP9HI=;
        b=oWRvSovv/qlrLA1WXYNGPS5tsQ3jsAw7lOjDVSkqtSXbTs9bHljT6Wq2bC+FFTtgHe
         VMKTpZ3BCJKMGQ0gZOYP56eOJysBtV9zfTP3YHxGYos/3EywMb8pAIq6VBBA0AWivfK3
         4p7mX9BmdxHl+gMXBJUcQgxNj4nW8hv6h/DdU5bx6AcbYqqxG14HwwfzEe69afG7AY97
         c2mPl0pT55cnl71vv4+VepIEhGYgWAaH3adNkFCRsn9cDPzX3657bxT9CMWrDYsf8Y/5
         /4CFBl8CKEixIFnczKLNr3GAEtnN/nk2V6g7UgH8pRCxT3MBiXrHw65P4FkPnUCaauAi
         hrUw==
X-Gm-Message-State: ACgBeo2vVSzazUV6NI8rRU2svvQqA6QFCBIbAT5juaLFooqt+hGnWaIp
        QJwppOCFZBSlL+t7uo55qkWbJ6+fO1AZ0g==
X-Google-Smtp-Source: AA6agR7foU0giwmkd61m40CCdwIXH4tHyR8XeYu6goP9r09laIhzfqaVhUdo1H3D2jslJCnEZu5bnw==
X-Received: by 2002:a2e:710c:0:b0:264:ed38:e57f with SMTP id m12-20020a2e710c000000b00264ed38e57fmr4376162ljc.189.1661967180167;
        Wed, 31 Aug 2022 10:33:00 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b0049464d05bfcsm1501336lfr.105.2022.08.31.10.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:32:59 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: arm: qcom: Document samsung,matisse-wifi device
Date:   Wed, 31 Aug 2022 20:32:05 +0300
Message-Id: <20220831173207.238080-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
References: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add binding documentation for Samsung Galaxy Tab 4 10.1 (2014) wifi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Change codename to matisse-wifi
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..883ba92f589c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -115,6 +115,7 @@ properties:
           - enum:
               - asus,sparrow
               - lg,lenok
+              - samsung,matisse-wifi
           - const: qcom,apq8026
 
       - items:
-- 
2.34.1

