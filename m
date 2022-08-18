Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E059873C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiHRPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHRPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:20:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB25A8BC;
        Thu, 18 Aug 2022 08:20:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w15so2044817ljw.1;
        Thu, 18 Aug 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b9wCYvC96JPicNbrqKnkOA8G+Rw2Lk6t7ci0InegnBs=;
        b=eekMHeORo01AxqyAJmifyPy7LLjzUm83uw/itOrs67RfjfH7QrdRVTR3m1N5ekMwSS
         2akfXp+REPa4dUrwg0/ERTkVaeOGXeQwM1KMrUw6A3lEwrujVz+OS77hRAhgN6fz1HXp
         qLP+Y64sYfenjyWATHsmb8++jm04xgfqpRgjaMiJZ99qSKCe7sRWHLz1lWzsE+ou4rpb
         VQ5ZonXuJjIDOxey5hZ3rNFgSl0DnTUPElO24V38nVsOZBVaR3EMD1kChRRw1YjdoYzL
         osGCU/PlWe1biLbpynLNV7axwBRIkOLNydPFkYkc5k60w8tIUzKSs1ZOHUgJWyjCLEcI
         orTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b9wCYvC96JPicNbrqKnkOA8G+Rw2Lk6t7ci0InegnBs=;
        b=HDOzRdi8hG+levFtm4j0FNJgeVZC3TrkQUaTK9eP+PRVK8GHlOW9f4jMg48Sb8lCHF
         rjXd/9hq2II81iO7z1TQvWqCqzm3j6JUwuDU4bIs9oha+6e48uJUqF24w+mUsiZxXWxS
         Fn+a49IT45sC3lghRjZQQevDN9jqDhDksf4xB7LSNWRDzMWaGQPN70xvMj7szk3h7wiR
         5XYHA7UQqaGIavaFordpiT3KDjBIhu5HPXYA+TG4HYVhKcDQc28CdXWflkdkMupI1Cyc
         1i4+acwY4k2ez6t2fN9iqbjNzpCkunRFo5zxJc7wmTrPWSHWP0IiiphjnMILgCHWIzxo
         ziHw==
X-Gm-Message-State: ACgBeo23uUDjRXCwLj3cAPAdnIO3Peq0bUrUKSLtb4T7pF++zs0SuFpG
        jwkYnwQSTV4GDz9nC34mMK/GpPfWJHw=
X-Google-Smtp-Source: AA6agR4jX84I9P/Z2FshKJ5Sdge2u7OGIq29s+E4Xql2l8JMuKu0kVvsPkfeyjLLBfPyIC5TT+Bi6w==
X-Received: by 2002:a05:651c:50e:b0:25f:f52b:3c91 with SMTP id o14-20020a05651c050e00b0025ff52b3c91mr1106680ljp.391.1660836013072;
        Thu, 18 Aug 2022 08:20:13 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b0025df5f38da8sm263859lja.119.2022.08.18.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:20:12 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add DISPCC driver for SM6115
Date:   Thu, 18 Aug 2022 17:18:19 +0200
Message-Id: <20220818151850.19917-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce support for SM6115 display clock controller,
this driver is based on QCM2290 one.

Adam Skladowski (2):
  dt-bindings: clock: add QCOM SM6115 display clock bindings
  clk: qcom: Add display clock controller driver for SM6115

 .../bindings/clock/qcom,dispcc-sm6115.yaml    |  88 +++
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/dispcc-sm6115.c              | 615 ++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm6115.h    |  36 +
 5 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6115.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sm6115.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6115.h

-- 
2.25.1

