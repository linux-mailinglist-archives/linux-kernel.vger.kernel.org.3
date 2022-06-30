Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA92561AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiF3NFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiF3NFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:05:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E722205FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fw3so11241981ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiSqVIzhdKNt6jDuv6m0mtfu6qdlxyAFm39nziCEFfE=;
        b=LdIaWH7US44QX7IILZNcJGjXl7yhOLYLouzEwIoJ+KNAEWGmExBmeIQZ29Suavq9Sq
         i1CYsIEC7qA0DVrwHA7YP+QX9K9GSmVDeH3gMrPLIBDST4ssWU7wyct5XGwQSSc3CIGB
         2Bj+jkPCcjulhWoFk3FltD8ZCS0uh1ilcLU9t5KMSzNulQH4LUuwjNUpm1DPHFDJ9UAE
         4DJHwAs7FYpZz8cymBQusgNw5fcwuJVJ+ZibrrksD3bCOscFayGZt/Kt0OpC/rVLM8yR
         NSaG0wuVOz7wbqxREJ65u90eHApyo+yw6FV9MZayPmbzSwlTXVbSWOH5++gypvQs5aPm
         X9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiSqVIzhdKNt6jDuv6m0mtfu6qdlxyAFm39nziCEFfE=;
        b=Im9+8wz8QgTcFy8DiX1e5BxetaE4XNoGD6qVt7TvWs2CQvGjS7GHE1OR4/9a9Saz+m
         /cs5VFy+/V3+DaszXGdKHTNr3rw+HmmbevpOVm/hvBciNq6EVRAn+YXJ70kv3niDTH5B
         R8N7maL02YsswK1+7qRbMXpA2XVdWlkAYfWObo+EnIJz4nYINJzQAAD53IXFIHdGE/hC
         IFWpwjrTGd85q2BxnR+qApcjxs0s3fV3n5njGpXfYBRLsso4sHNNXA/iZDT36VANDs8u
         f7YDqiPy27Rlw/A5kiKG10l6l5KNbuSs4XEg13YVJXHDIlTEJf0wXy3Hyp6C563yYDJu
         gB7g==
X-Gm-Message-State: AJIora/ujJUAes83xQEjwyO/8nufHrSwaaztJu+lN0aOZkBkYnabIOJT
        3YYA0R3qY7+NcGinDX9AvSlVYQ==
X-Google-Smtp-Source: AGRyM1tZe+0W4d+ICqLzhJw1k47MwurWZZZ6YzgHwcuZ1uK6sFiwanVofJyXP1RnfwHFxl81sOjW8g==
X-Received: by 2002:a17:906:a0cf:b0:726:cbdd:466b with SMTP id bh15-20020a170906a0cf00b00726cbdd466bmr8617602ejb.410.1656594345137;
        Thu, 30 Jun 2022 06:05:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm9124967ejh.76.2022.06.30.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:05:44 -0700 (PDT)
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
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v7 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Thu, 30 Jun 2022 15:05:37 +0200
Message-Id: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
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

Changes since v6
================
1. Patch #2 (driver): use MSM8998 compatible.

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

