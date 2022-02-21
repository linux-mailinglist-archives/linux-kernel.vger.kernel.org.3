Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DB4BD545
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiBUFXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:23:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344342AbiBUFX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:29 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B05E5F;
        Sun, 20 Feb 2022 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420988; x=1676956988;
  h=from:to:cc:subject:date:message-id;
  bh=WmfTeWrq0HTnCZuEY4P08kf3e5l4DUxFzYiQSkBr06A=;
  b=grZKgFwLqelZNaHDHDSnXFJ6eaMVsPieu4pIPb7yBWYapY1nWeIlje5Z
   MIFsIrRBlTKuxaNsK3Kn3bliwZifc+8XsWf2i0rMBjNTMKHZQjACot04b
   jmagQKmCixIOIseKgzgkDUIKTOcovH8DIJ8q6SX2ILU5KbKBMqdyHgqq7
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:07 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:04 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 8481F46C2; Mon, 21 Feb 2022 10:52:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/7] Add APCS support for SDX65
Date:   Mon, 21 Feb 2022 10:52:26 +0530
Message-Id: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
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

Changes from v2:
 - Addressed Stephen's comments and made necessary changes.
 - Rebased on top

Changes from v1:
 - Addressed Mani's comments and made necessary changes.
 - Removed the last patch from the series as it became redundant after making changes.

This series adds APCS mailbox and clock support for SDX65. The APCS IP
in SDX65 provides IPC and clock functionalities. Hence, mailbox support
is added to the "qcom-apcs-ipc-mailbox" driver and a dedicated clock
driver "apcs-sdx65" is added.

Thanks,
Rohit

Rohit Agarwal (7):
  dt-bindings: mailbox: Add binding for SDX65 APCS
  mailbox: qcom: Add support for SDX65 APCS IPC
  dt-bindings: clock: Add A7 PLL binding for SDX65
  clk: qcom: Add A7 PLL support for SDX65
  ARM: dts: qcom: sdx65: Add support for A7 PLL clock
  ARM: dts: qcom: sdx65: Add support for APCS block
  clk: qcom: Add SDX65 APCS clock controller support

 Documentation/devicetree/bindings/clock/qcom,a7pll.yaml |  3 ++-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml         |  1 +
 arch/arm/boot/dts/qcom-sdx65.dtsi                       | 17 +++++++++++++++++
 drivers/clk/qcom/Kconfig                                | 12 ++++++------
 drivers/clk/qcom/a7-pll.c                               |  1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                 |  5 +++++
 6 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.7.4

