Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4E58F6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiHKEJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiHKEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:09:42 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD1883FA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:09:36 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10ea9ef5838so20281149fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=FbyBVVkSTsD0rH2pBff9dZjBx8y4eXFXCA+ofIigL0Y=;
        b=DEsSvYU0VJOGGXLGkZ3xuITgpKtHuIp36XN2zm8qS3+ZCyjgvd5FICtm2IwrAhn5/j
         J3djDlMhE5JP8AWbdLTlxjNg/lb7dI7pejovVAKJDF0j7wQikgAF9/tMRAuSRRi+8YpG
         M1zSdVeWwIajVZJNV4VXl3Je1ZNG+IrKNjqBj04e3wiQ4H+LgL50OKeRmln3teUP2+Yg
         NG9mV6NKA6BUx5y7ZEcEv9/7478GWJVzxfBGATD+C6TrYKhwl96i/R8fX2SYDQJfBPpx
         K+FKOrLeofNUI1VGRpVuC476vwCKYsT2RVwclO28ZW5xL4PUj7jKPJ5tR6zVns6BHSnU
         EOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FbyBVVkSTsD0rH2pBff9dZjBx8y4eXFXCA+ofIigL0Y=;
        b=oIwg4BAAcnWAjQoLoOnItFTgSn7hwg0cUO04YQJiDZkqQvxhGSnTYv8tm8e1lbCJRf
         GbdCK5KBqfoyyNHhxR/FpfT0rim6mvGXHxaj5vsHG+dlvgbqvnkMrjdfW5UdtTKXxxO3
         MAZkkDwY272hkgedN4QvGSd/h4k2unkw/bpch3uxydX3VedDSkiAw/rAjAAxU16eKjag
         ME6RPf/5F7prd03C02KR0PrHwNNVhD661RHNd2H1LxALhWfB6yxViijfkYhjS10yvIuJ
         Z1T43yhgvadz2a4ogl2M5NgcXVQZ9+IyZym3iPjvITF+sm30XEa40HNVSzT3sNRRh0R2
         WdTA==
X-Gm-Message-State: ACgBeo3CnbATnXxvVRJhizI4XZVgFaKp1qIuVbT23o9lUfw7D1BFHG63
        mewlhMASLesfE3QDl7VV5xbadw==
X-Google-Smtp-Source: AA6agR4Kl0Sc/vNnmKypw60vZs57Nt9D4n2cRj/obDDxQFDLMFQiSdh73tTNVaKaRpoJ34ca3j6XYg==
X-Received: by 2002:a05:6870:418f:b0:112:1208:b164 with SMTP id y15-20020a056870418f00b001121208b164mr2962761oac.189.1660190975121;
        Wed, 10 Aug 2022 21:09:35 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z9-20020a056870738900b0010eaeee89a1sm4111321oam.46.2022.08.10.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:09:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clock: qcom: SC8280XP display clock controller
Date:   Wed, 10 Aug 2022 21:12:09 -0700
Message-Id: <20220811041211.3825786-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds binding and implementation of the SC8280XP display clock controller.

Bjorn Andersson (2):
  dt-bindings: clock: Add Qualcomm SC8280XP display clock bindings
  clk: qcom: Add SC8280XP display clock controller

 .../bindings/clock/qcom,dispcc-sc8280xp.yaml  |   98 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/dispcc-sc8280xp.c            | 3218 +++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sc8280xp.h  |  100 +
 5 files changed, 3426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc8280xp.h

-- 
2.35.1

