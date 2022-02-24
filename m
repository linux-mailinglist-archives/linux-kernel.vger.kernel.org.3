Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714504C31FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiBXQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiBXQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE571EAED;
        Thu, 24 Feb 2022 08:48:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so622629wrf.1;
        Thu, 24 Feb 2022 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qC2mYqGoTXViShZoHr6pbNzwWEUucGHpKFO+l2d+FSc=;
        b=GQCfUjrlvwHZwuS2Ls1HYWi7rMgl157zJ/2jT9JxGRb35yQqCTKG+ovw3oIQqSaurz
         aGDTlrKozR9ij/RRdKRsyEgPdv5OSsQ13iNMfgb1rSF7tpDUSrCU7RZoDIPR7UttC9dm
         +JKIeeL9GlnN6tHuxp9iLXYd5erztc7HScYb8R/OvP8bf/J/Xjb/KMxwe3IrQ4UdKmdd
         gR58RWry+XD9pb/EASZUhrigRyDi6N1fuxeNoOzxrToPwi7daAo7md8vLlrgYmj05QAt
         IrRoK7kZBJOq59FXNodteL+LECHsnb0FZjKYDFqrIZAGhfxTuX9nMrv5D97sHPlQYFeV
         7QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qC2mYqGoTXViShZoHr6pbNzwWEUucGHpKFO+l2d+FSc=;
        b=ejadgmiQO7peYSBt/cN0MvfDGvOeuLRtzEqZUs3M52Lzxa5DwNQLrcvjRbzRJtWgjJ
         d0txg6iAeqPIhR1ip5by9WMJlbRjS9vuEr1CAK2mq7EMNdqwxh5zDUE03Qk+Rp7Lufyg
         Y9n4bKhAHNbQlZMx9cch68yngWuJZOzIGqPPU6lPtivBU6Z0l76hsUrV8p/m2AV4D7wb
         pB7DrhADWHvHFZEm0to9AReGbO4bYF/h3MKqOz6YcMHfYsaBsSDIbPzjiHQOWYNmGjhe
         7383p9ehfEdFSfpGqCFkVr+9vK4wuZPKn8nD+G0LPIAN0e+1Gmsjeg/kIUGI/r62z/Ik
         KfhQ==
X-Gm-Message-State: AOAM530dDuRowTUZ5XaHmf9Y5Ed2zP/fzJgCMT9fMH2u6P3lDqgsqKFE
        DWNrvSZYqLOFxWGP6oPlJhlYsOBisW4=
X-Google-Smtp-Source: ABdhPJxpg1xF1+bo1D4mqwqNaT6X7tAImJZ02t3T27PDR9rMxt5usC4H9xCNvEFwvyRWkOMGBbIjYg==
X-Received: by 2002:adf:ec10:0:b0:1e4:b3e3:2ef8 with SMTP id x16-20020adfec10000000b001e4b3e32ef8mr2915883wrn.183.1645721315053;
        Thu, 24 Feb 2022 08:48:35 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:34 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/15] Multiple addition and improvement to ipq8064 gcc
Date:   Thu, 24 Feb 2022 17:48:16 +0100
Message-Id: <20220224164831.21475-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This is an attempt in making the ipq8064 SoC actually usable. Currently
many feature are missing for this SoC and devs user off-the-tree patches
to make it work (example patch for missing clock, patch for cpufreq
driver, patch to add missing node in the dts)

I notice there was some work in modernizing the gcc driver for other
qcom target but this wasn't done for ipq806x. This does exactly this, we
drop any parent_names stuff and we switch to the parent_data way. We
also drop the pxo and cxo source clk from gcc driver and we refer to the
dts for it.

This also add all the missing feature for the nss cores and the
cryptoengine in them. It does also introduce the required flags to make
the RPM actually work and NOT reject any command. There was an attempt
in declaring these clock as core clock in the dts but this ends up in no
serial as the kernel makes these clock not accessible. We just want to
make the kernel NOT disable them if unused nothing more.

At the end we update the ipq8064 dtsi to add the pxo and cxo tag and
declare them in gcc and also fix a problem with tsens probe.

v5:
- Drop patch removing fixed clk
- Use name in parent_data to keep compatibility with old dtb
- Fix error in the documentation commits
- Keep old copyright for gcc documentation
- Fix an error with the rcg floor ops
- Set nss clk based on the device compatible
v4:
- Drop drivers in all the patches.
- Introduce floor ops for sdc
- gcc.yaml to gcc-other.yaml
- gcc-common.yaml to gcc.yaml
v3:
- Rework Documentation with Rob suggestions
v2:
- Fix error from Rob bot.
- Add additional commits to make qcom,gcc.yaml a template
- Squash parent_hws patch with the modernize patch
- Create gcc_pxo instead of using long define.

Ansuel Smith (15):
  dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
  dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
  dt-bindings: clock: document qcom,gcc-ipq8064 binding
  clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
  clk: qcom: gcc-ipq806x: convert parent_names to parent_data
  clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
  clk: qcom: gcc-ipq806x: add additional freq nss cores
  clk: qcom: gcc-ipq806x: add unusued flag for critical clock
  clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
  clk: qcom: gcc-ipq806x: add additional freq for sdc table
  dt-bindings: clock: add ipq8064 ce5 clk define
  clk: qcom: gcc-ipq806x: add CryptoEngine clocks
  dt-bindings: reset: add ipq8064 ce5 resets
  clk: qcom: gcc-ipq806x: add CryptoEngine resets
  ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064

 .../bindings/clock/qcom,gcc-apq8064.yaml      |  29 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml      |  76 ++
 .../bindings/clock/qcom,gcc-other.yaml        |  70 ++
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  59 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
 drivers/clk/qcom/clk-rcg.c                    |  24 +
 drivers/clk/qcom/clk-rcg.h                    |   1 +
 drivers/clk/qcom/gcc-ipq806x.c                | 656 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 10 files changed, 692 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

-- 
2.34.1

