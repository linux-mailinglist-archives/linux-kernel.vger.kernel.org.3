Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA955F9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiF2HxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiF2HxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:53:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C53983E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:52:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z41so2451656ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teySt0pfe1Fl6EJ0ZuEY5uNGoMIrDwOQRCk/lxEIa6o=;
        b=K64DhEKw+AgSltwOxeQ0c8C2FCcOksM+do+eTV2cix59m6OCYKyc+vihLA6PvjPt5w
         ykY1AAZVLxLoAZaR5ANvBE7mLZIjHIRqZnAsj4yrdwi+4qGGDUOF0ITL7XXWIAtVIZHN
         G2NzNZEGMlHSvs50P0UP6jQNtgYxAtlOMV2babYIvwCUWqWMGa/nmhqDQgpm7Pm9zfgv
         JMRZg5pCWXmqINVYZNiZ+MJPj521yLOf+3LWNrE4TTLoNblS50LpH3uQq22PqOEiiGBd
         OcwkZBk4Z8XweCXaFuXSPj5c+aEaDZwTYN2Wi9VwCq0cTJZFTR/kcQaAy9UAFvbTTsWJ
         u24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=teySt0pfe1Fl6EJ0ZuEY5uNGoMIrDwOQRCk/lxEIa6o=;
        b=YhZDOu41tY6XWSmFSX/MEdBjlj4dLqS9rsLNGNTQzgsjFu1LRPD9XGqg/lM41lJFSD
         oWFLt9RjTFO7q1W0XXvsNh0dqsCS7NPZM238bCiE9wIiQVIsVnB7jaK35n129K8Yg/Nm
         3EeSd6ZnnJLPp+iDAb2CblN6tJ9jrRoP191Pe9BTAqndBndNUDaPXPLdoBGYyw49aq7F
         lBfxZFiApzs30UCVEMvgC3RbJjtmwsfPJjvv9VciAlSbsO568ewiQRKSAA8Y/4rXJ8vC
         eKl0uhzi3LSYrMWdiuGze+/d/xagU64TV9C2x7VnAfDlAI+dHpi9bncwdFvTnnBeYLwL
         fCpQ==
X-Gm-Message-State: AJIora9+/zQap5tWfv1OQxUoH76REkN+E2DF1XI8RhcDYon3Ur8qHzMI
        BmiybGfvp2YsznshZiXd172r9g==
X-Google-Smtp-Source: AGRyM1ve+eWHy1pLQJ5e60zFGg+uYODIvAuCqfuQnHIBJbRUTWOoZhbqbgueEeoU9X5EA5kdTqKv8g==
X-Received: by 2002:aa7:cb83:0:b0:435:9170:8e3b with SMTP id r3-20020aa7cb83000000b0043591708e3bmr2539172edt.144.1656489174232;
        Wed, 29 Jun 2022 00:52:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t2-20020a056402020200b00437db6acaeesm432173edv.95.2022.06.29.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:52:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Wed, 29 Jun 2022 09:52:46 +0200
Message-Id: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Changes since v4
================
1. Patch #1 (binding): Use qcom,msm8998-cpu-bwmon fallback compatible, only one
   interconnect. Rename to qcom,msm8998-cpu-bwmon.yaml. This reflects
   discussion with Bjorn, about the proper fallback compatible. Driver was
   tested only on SDM845, so only that one compatible is actually implemented.
   Keep the reviews/acks as the change is not significant.
2. Patch #4 (DTS): Use qcom,msm8998-cpu-bwmon fallback compatible, only one
   interconnect, use the LLCC bandwidth in OPP.

remove unused irq_enable (kbuild robot);
Changes since v3
================
1. Patch #2 (bwmon): remove unused irq_enable (kbuild robot);
   split bwmon_clear() into clearing counters and interrupts, so bwmon_start()
   does not clear the counters twice.

Changes since v2
================
1. Spent a lot of time on benchmarking and learning the BWMON behavior.
2. Drop PM/OPP patch - applied.
3. Patch #1: drop opp-avg-kBps.
4. Patch #2: Add several comments explaining pieces of code and BWMON, extend
   commit msg with measurements, extend help message, add new #defines to document
   some magic values, reorder bwmon clear/disable/enable operations to match
   downstream source and document this with comments, fix unit count from 1 MB
   to 65 kB.
5. Patch #4: drop opp-avg-kBps.
6. Add accumulated Rb tags.

Changes since v1
================
1. Add defconfig change.
2. Fix missing semicolon in MODULE_AUTHOR.
3. Add original downstream (msm-4.9 tree) copyrights to the driver.

Description
===========
BWMON is a data bandwidth monitor providing throughput/bandwidth over certain
interconnect links in a SoC.  It might be used to gather current bus usage and
vote for interconnect bandwidth, thus adjusting the bus speed based on actual
usage.

The work is built on top of Thara Gopinath's patches with several cleanups,
changes and simplifications.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: interconnect: qcom,msm8998-cpu-bwmon: add BWMON device
  soc: qcom: icc-bwmon: Add bandwidth monitoring driver
  arm64: defconfig: enable Qualcomm Bandwidth Monitor
  arm64: dts: qcom: sdm845: Add CPU BWMON

 .../interconnect/qcom,msm8998-cpu-bwmon.yaml  |  80 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  38 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/icc-bwmon.c                  | 421 ++++++++++++++++++
 7 files changed, 563 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

-- 
2.34.1

