Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510F596DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiHQLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiHQLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95267F12E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu15so7388002wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0TWXetM3NMZztHt4sdNQtoFcwVfPRvz/XyGSjBgjZ0s=;
        b=d/b8hhZEIq0njWTmpwjyW5MAc243Ey7S9DA6DBkylYCCrSwiEQpmioVnEC6E7pe5p0
         QYEgsPlWR48pNEjQPr2GRwKHcROu2lg8P2FJ+FnucSC4iP75FZNV5/JwnrtddXjiLUqV
         TbnlIxgOYLS5iEfu9GOgs+qE6iu76NG8wU6bnafdyG5/dHQKSq129dZpqV6HM9Ql7lJB
         NceEQiYomlrsAHZ0ehurzPJer1l3rJyF4NQRrj4xVcCJZbeACyBTZUxx8gyNvQIgiRAM
         9dLvklNLTXJdmZ/jp9xfkMkauR/yIvcXon2ZtxZscd6IwJP8xVFmvfwtdikNZaw+Sx6D
         z0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0TWXetM3NMZztHt4sdNQtoFcwVfPRvz/XyGSjBgjZ0s=;
        b=rr7+nLIfZ7SLLwidzVhf/w8y9UrXf26fLFydxYsgXmyTSFkPXSbvgV/w6wgB6wbJ6K
         pvVkaYOUTQtuxn0hffVkRAtI78s1Bw4uQ9+feQlC9DPIFn/oqMWclRr5vHskbfMy/I1t
         jsXUrAbz+xpEWiG7CG06fbVCZ0dKNCRx1KtP2lU/e64J+EJVoRmOHVhFz8goE4Vr41Ux
         o+JOYbfjhQeuQhUcqdhd/UB/LRgVcifzFzetSaConYxjVuTInO3ghqsZ/c/mCWw0/8cu
         TvUH3Jd0iM7r/HuM7kfm8LnEPXhbeuOiyiPEQOt07QKc2SGNBjp8ZFuA0AEgA32U/lGF
         9v8w==
X-Gm-Message-State: ACgBeo3JqUoC34e8r+SHXpqjEa7CoP//hdWdhmV4BgfagUZ+HnccJ8EM
        zbY9vu08izDrLLGS9YEvGvrZrA==
X-Google-Smtp-Source: AA6agR5Gyx12+ygPEoV/8uD5EzwdaDQTrnh5H3cr3lgNX92fjtXdNR2QmFtvjbPBHAOeLpXpk3OL8A==
X-Received: by 2002:adf:e603:0:b0:225:2858:4a1f with SMTP id p3-20020adfe603000000b0022528584a1fmr861004wrm.575.1660736316407;
        Wed, 17 Aug 2022 04:38:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003a60edc3a44sm2222695wmq.5.2022.08.17.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] pinctrl: add support for SM8450 LPASS LPI pinctrl
Date:   Wed, 17 Aug 2022 12:38:31 +0100
Message-Id: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

This patchset adds pinctrl driver to support pin configuration for LPASS
(Low Power Audio SubSystem) LPI (Low Power Island) pinctrl on SM8450.
    
This IP is an additional pin control block for Audio Pins on top the
existing SoC Top level pin-controller.
    
Tested this on SM8450 MTP

Thanks,
Srini

Changes since v2:
	- removed unnecessary quotes in bindings
	- remove lable in bindings
	- fixed gpio pattern and remove an extra line

Srinivas Kandagatla (2):
  dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings
  pinctrl: qcom: Add sm8450 lpass lpi pinctrl driver

 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 135 ++++++++++
 drivers/pinctrl/qcom/Kconfig                  |   9 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 240 ++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c

-- 
2.21.0

