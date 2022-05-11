Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CFF5233D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiEKNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiEKNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:17:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2BA38BD0;
        Wed, 11 May 2022 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275039; x=1683811039;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4Ruq8MPK8RPwPr0ArhDLKGi3jGEtxoy/4EY/BIcILGw=;
  b=yTPAAQuRlcLgqu6IsTu/9dRuwhw3pzGGIwg/U1j7AV7eMY1yMOjGpNmU
   ubISDJjW/8LXB1ilslf+KIvPDCjYHP7LCctawgTwPH4QbUYNvoq8vot4C
   qUPRyO3do+iy573m8cwzoUtInHGYEGyNdCFo31O6+RYxoSwnM1C8f3AwQ
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 May 2022 06:17:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:18 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:14 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH v2 0/6] Add APSS RSC to Cluster power domain
Date:   Wed, 11 May 2022 18:46:50 +0530
Message-ID: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- First four changes from v1 are already in linux-next, drop them
- Update dt-bindings change to yaml format
- Address Ulf's comments from v1 patches

This series patches 1 to 4 adds/corrects the cpuidle states/
apps_rsc TCS configuration to make it same as downstream kernel.

The patches 5, 6 and 7 adds apps_rsc device to cluster power domain such
that when cluster is going to power down the cluster pre off notification
will program the 'sleep' and 'wake' votes in SLEEP TCS and WAKE TCSes.

The patches 8, 9 and 10 are to program the next wakeup in CONTROL_TCS.

[1], [2] was older way of programming CONTROL_TCS (exporting an API and
calling when last CPU was entering deeper low power mode). Now with patch
number 5,6 and 7 the apps RSC is added to to cluster power domain and hence
these patches are no longer needed with this series.

The series is tested on SM8250 with latest linux-next tag next-20220107.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20190218140210.14631-3-rplsssn@codeaurora.org/
[2] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=59613

Lina Iyer (1):
  soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain

Maulik Shah (5):
  dt-bindings: soc: qcom: Update devicetree binding document for
    rpmh-rsc
  arm64: dts: qcom: Add power-domains property for apps_rsc
  PM: domains: Store the closest hrtimer event of the domain CPUs
  soc: qcom: rpmh-rsc: Save base address of drv
  soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup

 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |   5 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   1 +
 drivers/base/power/domain.c                        |  24 ++++
 drivers/base/power/domain_governor.c               |   1 +
 drivers/soc/qcom/rpmh-internal.h                   |   9 +-
 drivers/soc/qcom/rpmh-rsc.c                        | 146 +++++++++++++++++++--
 drivers/soc/qcom/rpmh.c                            |   4 +-
 include/linux/pm_domain.h                          |   7 +
 11 files changed, 184 insertions(+), 16 deletions(-)

-- 
2.7.4

