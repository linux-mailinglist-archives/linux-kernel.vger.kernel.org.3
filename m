Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4504514835
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358416AbiD2Ldq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358319AbiD2Ldo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:33:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9FD40A2C;
        Fri, 29 Apr 2022 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651231826; x=1682767826;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jMTG5SXGjaMKkhyrHvsIzlgYob8tP4EWEjH+QjXCAbk=;
  b=uNvQiYMsBP8Px4BSETkLqtDPHiqiNJ33FMTLyu0dN4Xtbh3Kwoo8XaCS
   Z/t67tstqTi8gGib10vpXUoFDUG7KmhY1yhpW9z0UyqQAW9jJoeT6DXoT
   44VBDAHQl+IN7AN0eKDZRE4bEBSnTZIJd02Vo7vG1FU3FOKGhV41aXoJD
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 04:30:24 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:30:23 -0700
Received: from bgodavar-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:30:19 -0700
From:   Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mka@chromium.org>, <linux-bluetooth@vger.kernel.org>,
        <quic_hemantg@quicinc.com>, <quic_saluvala@quicinc.com>,
        <quic_rjliao@quicinc.com>, <mcchou@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: [PATCH v1 0/3] WAR to handle WCN6750 hardware issue
Date:   Fri, 29 Apr 2022 15:57:50 +0530
Message-ID: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On WCN6750 sometimes observed AON power source takes 100ms
time to fully discharge voltage during OFF. As WCN6750 is
combo chip for WLAN and BT. If any of the tech area ON is
triggered during discharge phase, it fails to turn ON.
To overcome this hardware issue, During BT ON, driver check
for WLAN_EN pin status. If it high, it will pull BT_EN to high
immediately else it will wait for 100ms assuming WLAN was just
powered OFF and then BT_EN will be pulled to high.

Balakrishna Godavarthi (3):
  dt-bindings: net: bluetooth: Add wlan-gpio entry for wcn6750
  arm64: dts: qcom: sc7280: Add wlan enable gpio to bluetooth node
  Bluetooth: hci_qca: WAR to handle WCN6750 HW issue

 .../bindings/net/qualcomm-bluetooth.yaml           |  6 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           |  1 +
 drivers/bluetooth/hci_qca.c                        | 30 +++++++++++++++++-----
 3 files changed, 31 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

