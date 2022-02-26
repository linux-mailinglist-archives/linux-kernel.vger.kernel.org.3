Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F84C5634
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiBZNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0E3B3F8;
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s14so11179002edw.0;
        Sat, 26 Feb 2022 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G95SuKemJxh11ok9i1WXoegVNlvszeJo6wuVMMd2jWs=;
        b=eJ/xith4Pn/4QNOeLdhHcvLiHVE0N3uY5Son0nTcVkSD+mhXvNRAWAKA5gZL8B8l28
         CnWuncYnsf5p6uF9beJd54ZDEhQL+5R7Cbesbc9BFypz6JC4hQgFf0e7INvvFm1fewdk
         wFOiBw2H8TIqTXzqlhNbIIKSUYP7WZ9h1oAiIju3PL8N3vWbeXVRuwUU9oMDwc6+CLGZ
         mxMZDUNxj/LtWW/ytsQV9KiDfyakrsKuwIkEdF+YY9FrPrtONjkD9QCCcqYm7ZvihWzu
         XcuCYThQotrGcgnzuNooZbQbF1WmtHBsChqUQYcexL55HNAbZwAS1OU2R0cOpZPgf4LK
         k09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G95SuKemJxh11ok9i1WXoegVNlvszeJo6wuVMMd2jWs=;
        b=g+Rq0R26uC6yqs6mw1/XLYWp0QWtQnsi/p4q/e7DDgf0ER5vMvKIUXvL/7RGwWJb8f
         lJ9vt8rv83D/cpNOlMRlZSi1SYiHWtoxqSur1/kOf2qY7M2GRP/0nX3BvrAoMzWi43ky
         13YoellTGM0F5F6B/R9ozaBySWjwia2LEDnM5jGOfzECL7WQTr0x9G/M59bs/s2MCPdD
         VxPb9DReulw11r1yQJH1Rl1bC5AOFdNnhyuJ3O4xTwaveECZVividm4sdv2T0ovub4+G
         jl3Kj0GnlQhU2CHhJJwkQEwQc9/sQD+xj30MgR8Zaw6qDIjlOoLHH/D6MQ2tgFhBxJb0
         bt3g==
X-Gm-Message-State: AOAM533s4K12wEblHo0+cih1rHWA1x4RDiy+iENW/wTlV+SUF5WTJHVc
        RP/tUCs5n+yvN2FHmUStgks=
X-Google-Smtp-Source: ABdhPJxh9CfzhMlk7lGsPE13DbkIji9VVtaVrBWSubsyx0GxFVrH/T/5copPZlQuhD0nbVUwFq/IdQ==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr11821316edt.246.1645883556900;
        Sat, 26 Feb 2022 05:52:36 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:36 -0800 (PST)
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
Subject: [PATCH v6 00/15] Multiple addition and improvement to ipq8064 gcc
Date:   Sat, 26 Feb 2022 14:52:20 +0100
Message-Id: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

v6:
- Add more info about the changed define
- Fixed wrong definition for pxo/cxo parent map
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
 drivers/clk/qcom/gcc-ipq806x.c                | 649 +++++++++++++-----
 include/dt-bindings/clock/qcom,gcc-ipq806x.h  |   5 +-
 include/dt-bindings/reset/qcom,gcc-ipq806x.h  |   5 +
 10 files changed, 685 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

-- 
2.34.1

