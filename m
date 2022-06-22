Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C506E556F16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377402AbiFVX3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377502AbiFVX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:28:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B441994
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:28:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i15so16675004plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOZXlpuTA4Ot1JmkfebL6RgPQAjlDzmYkpBsGcpYO4U=;
        b=BuF+GiXUAd96Z8jA1Wo9P8THiXA15NaBEneYMk1PzxwtnrOPyp+BlEKjTIyKGJmvdX
         4fFyjuJg5BY4/LXXM08VkiY6+W+akDO4Qu5PoRiMC0oncmWM9fiL7ahsv9SERwLS5nfz
         J2mqWdrWz3H5fMjIjeT3W8IMUf5+LIxw5xNKf2pGZCh9HbwdAM0EXYK5X1JszaUu340k
         XUCKTtUKqvrdoB0a6oiJ/9VR+Oz+1R/ssyHaR9CB1w8VvNvSqLAR0819ypOXVmhkLCQ+
         1RDXmu08ICzlkgW33YS9j/YtC1+Xht93kFTQfMEITJFQMp7sxFpOG69ATZmT9gGDTvN1
         XBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOZXlpuTA4Ot1JmkfebL6RgPQAjlDzmYkpBsGcpYO4U=;
        b=3WhKSSlsiLWwR6GoZNaGaru+6oqZ3wF32Ga2XyfyuXKSL/D/C+JXAnShEdyGUX1owC
         lBdnFkDADoDQpnBpXiyutEkVn1T7XpHNKY5i552iG2MnUPvGMcVXru0aghnf9Mi5VOuT
         7kGu4phyVENgmmhQ+YnXczu8+0NcqPKVAfP+JBUBfOH1Z6BgZDxTw8YIIs5O8ZAmfgHc
         H0byf4x3ThOCjzGj8OHnuxyRqHNzs30nyky+TrGe055SBfOjKvtn90/+XLysfN+pUuax
         MQnR9+P4Hf+pYHyWHM3+sGxKpzGPgCih5VM04B1QkmsiRbCLNw0nHTOhRrUPQNSVChxW
         DlGQ==
X-Gm-Message-State: AJIora9KQ8r0ULln4hJuKm4fWACUZbghGX6aiEvTn40M66pY2uaJPWEI
        QLLV1DCoNOEexFU4CW5WmGKHfQ==
X-Google-Smtp-Source: AGRyM1tXaBZIVfnxvpWSWJkbsbF+iTtzFv7VJqGMzqzj5sRt7jR8NKUashW6BYNbEuQ3eWyUmAXDMA==
X-Received: by 2002:a17:902:e888:b0:16a:1b3d:aac4 with SMTP id w8-20020a170902e88800b0016a1b3daac4mr21214976plg.80.1655940537015;
        Wed, 22 Jun 2022 16:28:57 -0700 (PDT)
Received: from prec5560.. (71-212-119-14.tukw.qwest.net. [71.212.119.14])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b001622c377c3esm13297863plo.117.2022.06.22.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:28:56 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, robert.foss@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v7 0/6] SM8350 Display/GPU clock enablement
Date:   Thu, 23 Jun 2022 01:28:40 +0200
Message-Id: <20220622232846.852771-1-robert.foss@linaro.org>
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

Changes since v2
 - Dropped "clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED"
 - Dropped "clk: qcom: sm8250-dispcc: Flag shared RCGs as assumed enable"
 - Dropped "clk: qcom: rcg2: Cache rate changes for parked RCGs"

Changes since v3:
 - Dropped RBs & SoBs for bigger changes
 - Changed author to me for patches with big changes

Changes since v5:
 - Reverted dispcc-sm8350 split from dispcc-sm8250
   and related .index changes - Bjorn
 - Re-added Tags that were thrown out due to the 
   above revert


Jonathan Marek (2):
  clk: qcom: add support for SM8350 DISPCC
  dt-bindings: clock: Add Qcom SM8350 DISPCC bindings

Robert Foss (4):
  arm64: dts: qcom: sm8350: Replace integers with rpmpd defines
  clk: qcom: add support for SM8350 GPUCC
  dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
  arm64: dts: qcom: sm8350: Add DISPCC node

 .../bindings/clock/qcom,dispcc-sm8x50.yaml    |   6 +-
 .../bindings/clock/qcom,gpucc-sm8350.yaml     |  72 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  42 +-
 drivers/clk/qcom/Kconfig                      |  14 +-
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/dispcc-sm8250.c              |  63 +-
 drivers/clk/qcom/gpucc-sm8350.c               | 637 ++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm8350.h    |   1 +
 include/dt-bindings/clock/qcom,gpucc-sm8350.h |  52 ++
 9 files changed, 874 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
 create mode 100644 drivers/clk/qcom/gpucc-sm8350.c
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h

-- 
2.34.1

