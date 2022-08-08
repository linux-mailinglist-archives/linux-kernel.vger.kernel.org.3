Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F558C415
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiHHHfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiHHHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:35:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57762F2;
        Mon,  8 Aug 2022 00:35:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so6976808wmb.5;
        Mon, 08 Aug 2022 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pLEgpHosko6zu68c6+83D0WlNXTrwkqBiWooJQ+HKoQ=;
        b=cq8Fvz9C8dLGc6CoNBTF+yrNT1H8Tn+yQYmIQGBUgXdaXAMTBGLYBCUnfWAp1CI1b6
         dLqkHUFfhLQgykuG906XpztRXRLu/6N66uLz+eoFCnAOM08YCx9K+dwLQSyGjfa3/MPS
         Daip3brjzwOqDj7u8MMDuhwarPFkz7yUzCAQV1GN9ZY1mO4d4jo4+s4MsJEs5GfnnxqD
         D3gAMyln9hmlpQA1TRZAahCZK29B5Zzynho9AgHS8UwZSJH8tWd48gHCuBRKyfDSiKB6
         XzvjgpzIpH67I5ldfoDgY7ieQi7wfgy4f3uBQSL5wqc3zhsJImUkIQuh2j/A9hmGgBkO
         DKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pLEgpHosko6zu68c6+83D0WlNXTrwkqBiWooJQ+HKoQ=;
        b=SE/MeDxaUdrm9ReBzoDqQfPlJ/H0j+mqIGk4I8u0GdQAS59AVSH5WFO+65oDZpJaq7
         6lDUOn5KS371VYE7Y+3Cr6MZZWlCNL7xqOnh8Ymgt40cM5uPitZB1n9p7n0VboShLJZY
         oOpnjsLB/tsQMvX32fr6YWZlBT4OX6OmmPIVwttOUngiEI1ImsqH4dus6kRwq+dYV4LS
         IawjXGeFFjPxWbdk4AKPfWimRpCz1hnuweljnDvfAEkGJi7GVzhUQQtH79wA/sBaEu8e
         Gcm5Hzp6dKjqO/Ah9dLbnZwfNYwWSFlTcxo7tJEDXCSRfbFuA6oABo84mEt8ZJ0uvJVZ
         ktFQ==
X-Gm-Message-State: ACgBeo30Dp/r3QRXeWfkDbBvO7MoFXeUJ3GfA2luetT/V8R+pidjtOZ+
        R47GR9OTEYryZTaREWP5C1w=
X-Google-Smtp-Source: AA6agR7kVfS/9XyLbPXQt2uarhmODIi0OmqVGWosfq2GffwDrR1g/fyPlTEGtvz1TmjY+gG4nmjmQA==
X-Received: by 2002:a05:600c:4e92:b0:3a3:2a1c:d005 with SMTP id f18-20020a05600c4e9200b003a32a1cd005mr16859487wmq.170.1659944128671;
        Mon, 08 Aug 2022 00:35:28 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:35:28 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] power: supply: Add driver for Qualcomm SMBCHG
Date:   Mon,  8 Aug 2022 08:34:51 +0100
Message-Id: <20220808073459.396278-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds a driver for the switch-mode battery charger found on PMICs
such as PMI8994, and referred to in the vendor kernel[1] as smbcharger or
SMBCHG. More details on this block can be found in the last patch message.

This driver currently supports the charger blocks of PMI8994 and PMI8996.
PMI8950 was also to be supported, but it was dropped due to some last minute
issues, to be brought back at a later time once ready.

The OTG regulator remains unused on devices where the charger is enabled in
this series due to lack of a consumer. Applying a patch[2] adding vbus-supply
to DWC3 allows it to enable the OTG regulator making USB host without
external power possible.

[1] https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c
[2] https://lore.kernel.org/linux-usb/20200805061744.20404-1-mike.looijmans@topic.nl/

Yassine Oudjana (8):
  dt-bindings: power: supply: Add DT schema for Qualcomm SMBCHG
  arm64: dts: qcom: pmi8994: Add SMBCHG
  arm64: dts: qcom: pmi8996: Add SMBCHG
  arm64: dts: qcom: msm8996-xiaomi-*: Add battery data
  arm64: dts: qcom: msm8996-xiaomi-*: Enable SMBCHG
  soc: qcom: Add PMIC secure register write helpers
  util_macros.h: Add macro to find closest smaller value in array
  power: supply: Add driver for Qualcomm SMBCHG

 .../bindings/power/supply/qcom,smbchg.yaml    |  205 ++
 MAINTAINERS                                   |   16 +
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   15 +
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |    5 +
 .../boot/dts/qcom/msm8996-xiaomi-natrium.dts  |    5 +
 .../boot/dts/qcom/msm8996-xiaomi-scorpio.dts  |    5 +
 arch/arm64/boot/dts/qcom/pmi8994.dtsi         |   72 +
 arch/arm64/boot/dts/qcom/pmi8996.dtsi         |    4 +
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom-smbchg.c            | 1664 +++++++++++++++++
 drivers/power/supply/qcom-smbchg.h            |  428 +++++
 drivers/soc/qcom/Kconfig                      |    4 +
 drivers/soc/qcom/Makefile                     |    1 +
 drivers/soc/qcom/pmic-sec-write.c             |   82 +
 include/linux/util_macros.h                   |   22 +
 include/soc/qcom/pmic-sec-write.h             |    9 +
 17 files changed, 2549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smbchg.yaml
 create mode 100644 drivers/power/supply/qcom-smbchg.c
 create mode 100644 drivers/power/supply/qcom-smbchg.h
 create mode 100644 drivers/soc/qcom/pmic-sec-write.c
 create mode 100644 include/soc/qcom/pmic-sec-write.h

-- 
2.37.1

