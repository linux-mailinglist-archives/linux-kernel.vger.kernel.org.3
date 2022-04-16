Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF270503352
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiDPDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDPDBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17990D5F;
        Fri, 15 Apr 2022 19:58:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g18so18129155ejc.10;
        Fri, 15 Apr 2022 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXwXtnkkynlf3OpFEL2MaE3G+9L74/QRDs/KqCc+vz8=;
        b=NSNbWsgohv9oHu/RpiT2zekHIhOQEZl6CrfvUaGxjzco1wyFBSttQIidkzq3IazBkC
         0+Fva2HN+4q9JhswjZMjdep4/GWg18/k+vdTXM+5VRtORMqTBPR1qB/KCWJeQPqc8osS
         2iLlDVWE1LXbBGFXDs7wiDf3aTLuHwakk/eqxlPQXlpzgPGO4D0IAFfd+yYWexuMHL8S
         5gYhJhPNBFxaZbDohyFe4fDAKLli55+Th99dUb/svX4c+cjWwJw5FsVFHyc25FXl+LKF
         kvn9q1oPq/kZZEJT0vZBZT/bf01oJlxKIwm2M7VTTTBtYlrPHqEfE05+vMZJ2P+b/51e
         xS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXwXtnkkynlf3OpFEL2MaE3G+9L74/QRDs/KqCc+vz8=;
        b=C8SQkGmfqPfWaWKn8ZwM0q0ho7Lae9Il3lcGsiwMAmem019C1d9ZpvCbL457OTNlIV
         NIBd9MkktAeVaQzOtK9jIHnxEMiEQloRoa1+bZatXCzwddFyaAe9L5izzP7a61RFiYet
         1K6sR4kjpSl0/XlWHigigd67wTebas8tR5r+iwQOyKb62bjc4rNC+53bsWpsp0pNKakt
         nM2tmltgf9K3rke9TPO1sf6p3IJBP46h6wn9L4pvKlik+VgBeDqdcc3BXTsWZdJyKOqx
         g9xqAR1iKKPguj3X378/VJtm6CJxvFMDpx86F+eBkSce/U8F2n/QAyzV42tj5dD8t1VS
         hjZQ==
X-Gm-Message-State: AOAM530+/uPuoXscqgD+A6n4X//mHeT2a0dWrE306gAIsNAhrNdebAVb
        u3H7LjyhV2DrThhDwSgeruE=
X-Google-Smtp-Source: ABdhPJynHEAo+1wTM34aauaYVhPQLnhbFqp351AQHwEmwbcdYXSJesrayye6Cb6KzCFaFYW1jKB2Aw==
X-Received: by 2002:a17:907:ea1:b0:6e8:917b:6b6f with SMTP id ho33-20020a1709070ea100b006e8917b6b6fmr1320790ejc.409.1650077918706;
        Fri, 15 Apr 2022 19:58:38 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:58:38 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 0/9] Add support for MSM8996 Pro
Date:   Sat, 16 Apr 2022 06:56:28 +0400
Message-Id: <20220416025637.83484-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
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

MSM8996 Pro (also known as MSM8996SG) is a newer revision of MSM8996
with different CPU/CBF/GPU frequencies and CPR parameters. Its CBF clock
also has a different divisor.

This series handles the difference in the CBF clock and adds a new DTSI for
MSM8996 Pro with CPU and GPU OPPs. It also removes reading msm-id from SMEM
in qcom-cpufreq-nvmem as it becomes no longer necessary with the introduction.
of a separate device tree. Separating MSM8996 and MSM8996 Pro will help with
implementing CBF scaling and CPR; as they have different CPR parameters
and CPU:CBF OPP mapping which is difficult to implement in the same cluster
OPP tables.

Dependencies:
- clk: qcom: msm8996-cpu: Add CBF support
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dybcio@somainline.org/#t
- arm64: dts: qcom: msm8996: Add support for the CBF clock
  https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-2-konrad.dybcio@somainline.org/

Changes since v1:
- Rebase DT changes on already merged patches[1][2].
- Add more details to commit messages.
- Split removing MSM8996 Pro speed bin bits from opp-supported-hw into
  a separate patch.
- Rename msm8996-xiaomi-scorpio.dts to msm8996pro-xiaomi-scorpio.dts

[1] https://lore.kernel.org/linux-arm-msm/20220203072226.51482-1-y.oudjana@protonmail.com/T/#m6e1341ccfa50d11d221ba8c618f73c21a83b8acb
[2] https://lore.kernel.org/linux-arm-msm/20220203072226.51482-1-y.oudjana@protonmail.com/T/#m36f194cd9da1fee7058a88412985aab10c499fa7

Yassine Oudjana (9):
  dt-bindings: clk: qcom: msm8996-apcc: Add CBF
  dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
  clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
  cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo speedbin
  dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
  arm64: dts: qcom: msm8996: Remove MSM8996 Pro speed bins from cluster
    OPP tables
  dt-bindings: arm: qcom: Add MSM8996 Pro compatible
  arm64: dts: qcom: msm8996: Add MSM8996 Pro support
  arm64: dts: qcom: msm8996-xiaomi-scorpio: Use MSM8996 Pro

 .../devicetree/bindings/arm/qcom.yaml         |   5 +
 .../bindings/clock/qcom,msm8996-apcc.yaml     |  11 +-
 .../bindings/opp/opp-v2-kryo-cpu.yaml         |  56 ++--
 arch/arm64/boot/dts/qcom/Makefile             |   2 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   3 -
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |   1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  82 ++---
 ...rpio.dts => msm8996pro-xiaomi-scorpio.dts} |   4 +-
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      | 281 ++++++++++++++++++
 drivers/clk/qcom/clk-cpu-8996.c               |  61 ++--
 drivers/cpufreq/Kconfig.arm                   |   1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  75 +----
 12 files changed, 410 insertions(+), 172 deletions(-)
 rename arch/arm64/boot/dts/qcom/{msm8996-xiaomi-scorpio.dts => msm8996pro-xiaomi-scorpio.dts} (99%)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

-- 
2.35.1

