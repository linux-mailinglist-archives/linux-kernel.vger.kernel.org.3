Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E653A21A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350727AbiFAKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350761AbiFAKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:11:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF16327
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:11:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t5so1494114edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGDdP6h2IKOTMBasdhCmRS5R0RvzDEl9dYrXpeg2bHY=;
        b=D5kyanqz0331s9mE1kNwMkVwCTzgzR7N695F5bpbRHDjcHSpdf4D5N6biKo19ozP2e
         /q47p0mawyATBW+dyoZFKzBFTBrpBCIKP/s51+ufirllagX4yV2BCLAeCQdTICcdyErj
         y2FSwU5BZA3tlmb5i/xIi+cF4gaGYO6h8hGLP0m4ORrdeUjs5+zacnSjFPLKDVMHDfT/
         9SA2PwvEO19n7IDaLPGVRWwiDeTbgpRmR9BB9GjwYETaYR49JuwOYbkMI2LqcNvPOEt+
         10lF0YwRRMbiTaZXGniFi9jhKbqWRqTQ3wrE83uQCHjJk/L9Xp0GL6G/jwNitLcm8Wca
         ND3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGDdP6h2IKOTMBasdhCmRS5R0RvzDEl9dYrXpeg2bHY=;
        b=SajsgppERhDMYWoPR1M6VFrE/u+NKuMbywHsA4W4vbXmIpV/G6PIL4E/bpvuTdfKXL
         QL2nDo6eYZfOhXl3TgAh6aIy8kKzH65I/lNHt3yx5gMKLbwxeFoKMUS1QvxF/ty8uxDK
         jEW4bL+j/wmBtYSEiB+mKq7VA6lvTHKdIjTqtlPxB6ZdhF3izrZ8t6uH+P+Bxsw43cfI
         s1sfY8DpdZkE37rhZpAKi2WyBY18mkcNPbGSUdDTL0d8QHpioa1yAk6jGjUWINkgX2ka
         HT4VTww417mvEZHZcgEvP0tnRPGe1vu7KV6sj6QiDH3zli9h4KxfvgyFeX+F2adM1LuI
         zaJQ==
X-Gm-Message-State: AOAM530Z9Mt3yPbH2Kq+TlOBfELgGhwcsIswTKWR1DQ+rLNFdv5cOGA/
        vr7W0vVwWdWrJWo7kROtBppg5w==
X-Google-Smtp-Source: ABdhPJxn3EzA0LIO8ndRykG2oLKvwSJZm1r7JrONJsqxAntjBUU3KypkYcoH1zZ6bIbQStTsx6PQTQ==
X-Received: by 2002:a05:6402:d9:b0:42a:c890:20b5 with SMTP id i25-20020a05640200d900b0042ac89020b5mr68485817edu.101.1654078306569;
        Wed, 01 Jun 2022 03:11:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm501373ejq.181.2022.06.01.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:11:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Wed,  1 Jun 2022 12:11:36 +0200
Message-Id: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
  dt-bindings: interconnect: qcom,sdm845-cpu-bwmon: add BWMON device
  soc: qcom: icc-bwmon: Add bandwidth monitoring driver
  arm64: defconfig: enable Qualcomm Bandwidth Monitor
  arm64: dts: qcom: sdm845: Add CPU BWMON

 .../interconnect/qcom,sdm845-cpu-bwmon.yaml   |  97 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  54 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/icc-bwmon.c                  | 421 ++++++++++++++++++
 7 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

-- 
2.34.1

