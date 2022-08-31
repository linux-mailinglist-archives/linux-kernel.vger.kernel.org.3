Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1EA5A846C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiHaRcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:32:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C761B69EB;
        Wed, 31 Aug 2022 10:32:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j14so10603257lfu.4;
        Wed, 31 Aug 2022 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5VALg+D6J+K1cxaRPHkE4qwyAwVr/8BsiuNpsQnPT1A=;
        b=UNSZ1NnpZPSlxf4TkHa5/hCot3Eu1K8kQR/i7+yU61pTOElBq2+ic6//uFwZFOFh7A
         3Sic8dcNJ0h26laIt5DWgfvOMQLAAFc6vBxRT8OgEiejrAHuJLCCYnxipeko+opPtjHJ
         zHFKfsztX0z2+uQkgHKOy+DEZfOdZAHz33+LcfRncoI37TdCtxHU5ppQ7XWqjfCVDzDx
         7rYlnKAmi0AtBsMLcowJQsUUJNm4bUXwlqLNGInij+VsgRPFkE5sWm6WDRK7R862tlvx
         LqnE7AmNbf+ZCI4EuF1jKltuDJWXTKUO6Tk31+t+w00iTuJCAVYgXGIBD2ycB3LiC7pk
         LdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5VALg+D6J+K1cxaRPHkE4qwyAwVr/8BsiuNpsQnPT1A=;
        b=4XcH4Nih+tp0uLTSgh8juggsZZsAHdcv5fUBWvPOJrhfHt/ipKGwQ/pqhsnWx0QunD
         S7AdLI3k5Mwx59UwH2p7wcZl4MlwiMRgYm/FqLCMUsr9d/hIkEhcp73udkPGP4zCiaKb
         cMwvwk+Tcerd+ZLMV7IYH71AF+uKPZJHGptIWJu2cLCRhH1wvnERXFnQYl1nzK3Z/tNS
         xRNQUtWi4/gSsOimkevsvHdOzpnhi1s3o2tyBjPXUJrQ4GlmiFVeUhfzvM0QZR7x9KEU
         0Htc+cJJCgzo1Isa25w6iGAseuOQu6dBWRNKJfTls7YEpvXHUS9u6sy8iC7bdeIs1gb6
         DDyg==
X-Gm-Message-State: ACgBeo0Ds5ygOK8ISSogm/6ZpTJYg6PRAdeWrnr3sF3qc0/pziVRqCtf
        zBKo67Nl6O3iJOcDiR8qOdEwgSW1UYg9pw==
X-Google-Smtp-Source: AA6agR6yyhPiGt3OabOdX8232Eoh26OgwYDSQDwscZ2AhrwIP+36gM6l74SH+BBSMi+NhzZujq/WcQ==
X-Received: by 2002:a05:6512:3048:b0:494:70b5:4425 with SMTP id b8-20020a056512304800b0049470b54425mr3890749lfb.68.1661967154416;
        Wed, 31 Aug 2022 10:32:34 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b0049464d05bfcsm1501336lfr.105.2022.08.31.10.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:32:33 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Wed, 31 Aug 2022 20:32:03 +0300
Message-Id: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

Changes in v4:
  - Move delete-node to memory-region
  - Move usb-switch node to blsp_i2c4

Changes in v3:
  - Fix sdhc_2 bus width
  - Reorder includes

Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id from device dts
  - Rename pm8226 gpio node

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matisse-wifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 453 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 465 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

-- 
2.34.1

