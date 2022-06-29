Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A72560204
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiF2ODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiF2ODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:03:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F67679
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u12so32757751eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X21RDYcZyPdAdSSiWnF38ilXDUTAkDc85p4urcENWOs=;
        b=zp6x20OMhnXPHzNNi8WXugTMQFDEqCtld64Is1YD14JQCItQk0qaYwSpD1zeZmO/I8
         JAn4GAgxjF8nFRDdIP2xbh0uvfE6wa7w+sVJK0IYyM6Qon7wsewcSuTMpXS6grEENUuN
         2sjKO2jNlLLJlPyw2lmQv6YAx0oZrDL1pJels5dy2jy8xSAoHvKwYmCvMYX5UFmUxutN
         Dw3BPl8BD99rKr5Dkz5RInSpxo55gFMUql9l4hDDPxF3KLe54xNhT03VZhL3ypi0L8an
         eAOLZqhsA/+wNgGGEXH5My3uVM/1A7Zh+G97JQmTZ654pB613w5h0CkjgVuJ/YNmI5qf
         sV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X21RDYcZyPdAdSSiWnF38ilXDUTAkDc85p4urcENWOs=;
        b=ehTp4ldyloBjUJu4Uz95nj5Dx3qmEnmLixOQbhna4T1IGGh6dTokmOGunodKRGUspg
         arJneyBSOlUgUyWKi2dE4iOBxAVz2De+FoZG1YQfvueeyipFEhQcJw5NmqNH2Dz3lko8
         /wNaNmYpYqtVHn2dPz536we4JKJ0a+bThlg7ENlighF89VNl/dHMdVysB7nDIWv+MFxA
         JQ5QkPe2yJJSlFjXrop/WimyGPEuLd7HZtEM+qpgoSZPsWiSAFAg2HB+lk+Y9UxY4dHr
         uGn0NPaKAfaf2dTbruK6NTXQRjtfOrWqXoW8nn0/jbuUXgzz0lQbMpCjMA6bIprQm4kt
         fbXQ==
X-Gm-Message-State: AJIora8KunZq4S6LCmpeJzNjpLEAMTZ6AgvxKULoa3gyFNEiCcoDOVIF
        9Wg/8V0lNYA2fTnX327NrEKhLQ==
X-Google-Smtp-Source: AGRyM1vfBpeK5a2y8Ai17mRG/zLK0C47Ezcpl3fOTQHlpYcTCUwBcZxJdjE29jGIN0w0jpEOhFnqJg==
X-Received: by 2002:a17:906:9245:b0:726:3b57:1046 with SMTP id c5-20020a170906924500b007263b571046mr3576647ejx.221.1656511386646;
        Wed, 29 Jun 2022 07:03:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm7739260ejk.153.2022.06.29.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:03:05 -0700 (PDT)
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
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v6 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Wed, 29 Jun 2022 16:02:58 +0200
Message-Id: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
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

Changes since v5
================
1. Rename compatible (and files) to qcom,msm8998-llcc-bwmon as Rajendra suggested.
   Keep the reviews/acks as the change is not significant.
2. Update comment in DTS, update description in bindings and in Kconfig.

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

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  dt-bindings: interconnect: qcom,msm8998-cpu-bwmon: add BWMON device
  soc: qcom: icc-bwmon: Add bandwidth monitoring driver
  arm64: defconfig: enable Qualcomm Bandwidth Monitor
  arm64: dts: qcom: sdm845: Add CPU BWMON

 .../interconnect/qcom,msm8998-llcc-bwmon.yaml |  85 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  37 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/icc-bwmon.c                  | 421 ++++++++++++++++++
 7 files changed, 567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

-- 
2.34.1

