Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC05654EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiGDMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiGDMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:17:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826611C02
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:17:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx13so10874986ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUHK7FLYbuKzqzrEAJR7c+KmgynCicbvnzdwq2sVmI8=;
        b=qhGqzsRhvCQs96kxKr5liLm7CKnA5+AxQKaP7OUrSyE4miumGZmhLNRAY2bNN0cdG0
         tbq1CKueAVpYgR8igSgddjOXqb/SFJYJ6Iibuw61vvhHQeMSnDmvUpnb+T606fX0f7IA
         BJ1cOh1LCMp/yfnsjiipMNB5wf8ns7EZEGywTGDYeDrE39DlZrx5iD1AyL3QoxJ244cZ
         ihoaXY+mlgrU556tQjtFi64zXHLkqUXYEZaLuneoNwkVmbeRWuxfmsaMQTMIiU4zfWEH
         vaTCsQpX/xK9tBmMV10XgCArYaZXMJ8TCvXAhP9qZyR2cQAUHwVBV8oGnX7FjTNkAgcV
         Cdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUHK7FLYbuKzqzrEAJR7c+KmgynCicbvnzdwq2sVmI8=;
        b=snKwTWIdXq8McgTjz37U6QFttiIVFMmKUKUoUax7S+JZAbBnmKqYD8/H4siQg2L3Ji
         TvxhUyYKnwbaUjiZlIlLp8eqp0zPO2KJdp6X/EzTfSe1GBdri8q3Dh+I2QdhTXWqDKoD
         MZNCY+esrZKfjVO5JilNaemH7vXMK4E0UDJNFwo1QjlIEsDe4vIcuq1x6CmvsKr0Qqve
         Fmm9ZT2KpNATkxzrCU6x31t7+hTH0ctMPYdlRFTsqsPUl5Ne10vUC33w93FUrNol6s49
         loSDcEpi+AbuhjiOiXU0veqz0Rnb7hgnqLNWnQfFL8xZGHq3KbyAMk5FXb2BS1Lw8EsI
         tinQ==
X-Gm-Message-State: AJIora+DRo1+58WzrnxiNnfLrt0TSQogt/FVVfUw6bgABmvmhHG6qB+2
        iRLa7e20EOMP59pJ7sF12Eix3A==
X-Google-Smtp-Source: AGRyM1t47gezqmzrWMhZ7+1YcO1f62HYaF93Yupewcz7b4aXcA0k50BaEbcGuyttIrsyH+ED5YUW+w==
X-Received: by 2002:a2e:a453:0:b0:25a:96d0:b15 with SMTP id v19-20020a2ea453000000b0025a96d00b15mr16015890ljn.228.1656937054339;
        Mon, 04 Jul 2022 05:17:34 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u11-20020a05651220cb00b0047faa01edd9sm5102149lfr.229.2022.07.04.05.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:17:33 -0700 (PDT)
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
Subject: [PATCH v8 0/4] soc/arm64: qcom: Add initial version of bwmon
Date:   Mon,  4 Jul 2022 14:17:26 +0200
Message-Id: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
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

Changes since v7
================
1. After discussions with Bjorn and Rajendra, go back to "SoC-bwmon"
   compatible, so without "llcc".  The other bwmon instance - between
   LLCC and DDR - should be called LLCC.

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

 .../interconnect/qcom,msm8998-bwmon.yaml      |  86 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  37 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/icc-bwmon.c                  | 421 ++++++++++++++++++
 7 files changed, 568 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
 create mode 100644 drivers/soc/qcom/icc-bwmon.c

-- 
2.34.1

