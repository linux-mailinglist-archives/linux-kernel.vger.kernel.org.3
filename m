Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81FF4B686C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiBOKAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:00:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiBOKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:00:50 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2D10E077;
        Tue, 15 Feb 2022 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644919241; x=1676455241;
  h=from:to:cc:subject:date:message-id;
  bh=lYN6Qt8tApo+mea5juR8zMaYnSACX0anmwkxsl1TNos=;
  b=Cg9ZfaWptoawplX5DPprpkQKtST1gKNBq7h+cl3OU5+UAFdLiTfjSwn9
   6PraFl+iH2725PB3dCbxdPooLlVczplWVeqVx0iaYrDKF/YJ8O2ThdRQh
   HTZP7/8Do2lLomca0/VPZCc5fR1A23cMNjEuspT7TCsGUPFMEMfPj/cM9
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 02:00:40 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Feb 2022 02:00:38 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Feb 2022 15:30:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 2A906466C; Tue, 15 Feb 2022 15:30:23 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 0/7] Add APCS support for SDX65
Date:   Tue, 15 Feb 2022 15:30:20 +0530
Message-Id: <1644919220-27041-1-git-send-email-quic_rohiagar@quicinc.com>
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

