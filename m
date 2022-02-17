Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109734BADCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiBQX5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBQX5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2769A42497;
        Thu, 17 Feb 2022 15:57:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so11626808wra.12;
        Thu, 17 Feb 2022 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVmlOhX5PcDPicm3lYGlBTzA02rk1OQ79iZTV4IdZTk=;
        b=PMom3qB5NG9d/fWPRASFGft/y5FRfzyyJ6Aepa9redZBO+yJ+8f3QW3tXQuPc3Kx6f
         Dr++GnvVTGe4/RlRXsKKpLLumvxoR5hDeKKcuG+N2ZsecERGL6kqnuSzHhgZnlBfro5p
         WJiEPPlVhyzV1Xq4XEs6pZpkEdDkSnBvJLzRM48l6lOn4KaAAKWaf8c1PJocZql1Hk4s
         ce1dWvwtkpk4E0QHDBsq720a1WsRuGpVtF3wWIKjjiimBthtO8oEG+4pEvfLkHH4kg+N
         QOTMbsXFhzo8bctTLup81Ie94p24O4nt41TCUWuWhEeduRt4MO0dJhRKM2nGXKV388R2
         tUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qVmlOhX5PcDPicm3lYGlBTzA02rk1OQ79iZTV4IdZTk=;
        b=EDSyD+HZp6ajeh3p6n136WWrihsisG7Ju0NlxUlZHvYlif2jkY/sFSPorEQuFzvMXG
         iD+/achMohIPDWrS36d/dCNJISQywvCJ9urGecEVkPQ7e5QQbybPEsi/Kgd1Jwm4UB7Q
         PM4GoTI1aY1c28ibS5fTvXWxiDXC6gdYf2RjHh4Fyu4/nesQ6LSvAL6xxf1D5qkV5VCa
         Y8/jJF9lmuuk2V23dcCnpaIFt+6z3TRq/ADP//SjK2RmgP4gfUn7IC/PjfOG6g0fo9QK
         B5j6+JYCC3ZMsD5giuhOKvfbtAy6E8J0hMeiVlYCHb80b7BiSfKYV7lVKkS9S/Bq/YsI
         bZrA==
X-Gm-Message-State: AOAM530R0HlPASYP+H/tWa1bQiI/5uFkhJPKMV6AsQyBvNk2kgoUbCoD
        UIoQlBLLy8ZnACzud6Yw2Oc=
X-Google-Smtp-Source: ABdhPJySbGj8fUBmzrgQ2vpc0iEgvmPl8Q+GfLB1uHIRLyg8RiYytQ2fBJzridL03YC+KIQST+YuAg==
X-Received: by 2002:a5d:518d:0:b0:1e5:8cc9:5aa4 with SMTP id k13-20020a5d518d000000b001e58cc95aa4mr3845386wrv.119.1645142223343;
        Thu, 17 Feb 2022 15:57:03 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:02 -0800 (PST)
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
Subject: [PATCH v4 00/16] Multiple addition and improvement to ipq8064 gcc
Date:   Fri, 18 Feb 2022 00:56:47 +0100
Message-Id: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Ansuel Smith (16):
  dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
  dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
  dt-bindings: clock: Document qcom,gcc-ipq8064 binding
  clk: qcom: gcc-ipq806x: fix wrong naming for gcc_pxo_pll8_pll0
  clk: qcom: gcc-ipq806x: convert parent_names to parent_data
  clk: qcom: gcc-ipq806x: use ARRAY_SIZE for num_parents
  clk: qcom: gcc-ipq806x: drop hardcoded pxo and cxo source clk
  clk: qcom: gcc-ipq806x: add additional freq nss cores
  clk: qcom: gcc-ipq806x: add unusued flag for critical clock
  clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
  clk: qcom: gcc-ipq806x: add additional freq for sdc table
  dt-bindings: clock: add ipq8064 ce5 clk define
  clk: qcom: gcc-ipq806x: add CryptoEngine clocks
  dt-bindings: reset: add ipq8064 ce5 resets
  clk: qcom: gcc-ipq806x: add CryptoEngine resets
  ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064

 .../bindings/clock/qcom,gcc-apq8064.yaml      |  29 +-
 .../bindings/clock/qcom,gcc-ipq8064.yaml      |  76 +++
 .../bindings/clock/qcom,gcc-other.yaml        |  70 ++
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  63 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   8 +-
 drivers/clk/qcom/clk-rcg.c                    |  24 +
 drivers/clk/qcom/gcc-ipq806x.c                | 640 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 9 files changed, 670 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

-- 
2.34.1

