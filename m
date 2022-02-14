Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1C4B4223
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiBNGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:52:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiBNGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:52:55 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF85575CA;
        Sun, 13 Feb 2022 22:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644821568; x=1676357568;
  h=from:to:cc:subject:date:message-id;
  bh=ojcr7DDhqDkikqEiKbkcxRNoy2Jf+c3116uPV7yRjMY=;
  b=u4+q1r7LpLMBk3QQ7SSRijaNgyx6xOE7MhkmqPpVo7iNd+lzCI8e+uOg
   37r7QuXXT0mP3pC+v01fzaPrno3Cvhr/bp7s/VyFKVe/fxvZFJwFg/wyv
   CmBeYaf29bfU3c2ntLq6GyPpM9mLYUHzXCjbs1A+p8RfOT0644cSYKa+p
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Feb 2022 22:52:48 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Feb 2022 22:52:46 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2022 12:22:27 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0B67B4470; Mon, 14 Feb 2022 12:22:27 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux@armlinux.org.uk, mani@kernel.org,
        linus.walleij@linaro.org, dianders@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/8] Add APCS support for SDX65
Date:   Mon, 14 Feb 2022 12:22:20 +0530
Message-Id: <1644821540-17928-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds APCS mailbox and clock support for SDX65. The APCS IP
in SDX65 provides IPC and clock functionalities. Hence, mailbox support
is added to the "qcom-apcs-ipc-mailbox" driver and a dedicated clock
driver "apcs-sdx65" is added.

Thanks,
Rohit

Rohit Agarwal (8):
  dt-bindings: mailbox: Add binding for SDX65 APCS
  mailbox: qcom: Add support for SDX65 APCS IPC
  dt-bindings: clock: Add A7 PLL binding for SDX65
  clk: qcom: Add A7 PLL support for SDX65
  ARM: dts: qcom: sdx65: Add support for A7 PLL clock
  ARM: dts: qcom: sdx65: Add support for APCS block
  clk: qcom: Add SDX65 APCS clock controller support
  ARM: configs: qcom_defconfig: Enable SDX65 APCS clock

 .../devicetree/bindings/clock/qcom,a7pll.yaml      |   3 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   1 +
 arch/arm/boot/dts/qcom-sdx65.dtsi                  |  17 +++
 arch/arm/configs/qcom_defconfig                    |   1 +
 drivers/clk/qcom/Kconfig                           |  15 ++-
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/a7-pll.c                          |   1 +
 drivers/clk/qcom/apcs-sdx65.c                      | 130 +++++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   5 +
 9 files changed, 170 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/qcom/apcs-sdx65.c

-- 
2.7.4

