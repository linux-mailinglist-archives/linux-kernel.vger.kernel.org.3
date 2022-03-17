Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4674DBF58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiCQGWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCQGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:22:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37ED1CC0;
        Wed, 16 Mar 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647497560; x=1679033560;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yAjKArgG+UzEZta3g6kqWrjnT6A3ODfHAc9WTuI1vFk=;
  b=vTkTc2ESNlTbBvH1wTvMWx/23A94EtQBvGmxHELikZTrdNuAwa+70RIG
   PIZfz5BH2K8Mk6GuOgDhw3o72QUCmDiixASvxfTe5rJlBHdzC+tF1MN4M
   aPWzkSXHGMXmHvTi68yS2rGj+AFGksszKSZIgd3zc83WKzHdo6bRrKdjr
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Mar 2022 23:12:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:12:38 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 23:12:38 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 23:12:36 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v6 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Thu, 17 Mar 2022 14:12:05 +0800
Message-ID: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
  Rebased [v5 08/10] on 
    https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/#t

Changes in v5:
  Drop [v4 11/11] because of a similar change is under review:
    https://lore.kernel.org/linux-arm-msm/YdRJcv2kpp1vgUTb@robh.at.kernel.org/T/#t

Changes in v4:
  In [v4 02/11], separated spurious interrupt handling.
  In [v4 03/11], added Fixes tag for ("spmi: pmic-arb: do not ack and clear peripheral").
  In [v4 11/11], updated the binding to address few warnings in "make dtbs_check"

Changes in v3:
  Drop [v2 07/10] as this is no longer needed after this change:
		50fc4c8cd240 ("spmi: spmi-pmic-arb: fix irq_set_type race condition")
  In [v3 07/10], updated the author email to match with Signed-off-by.
  In [v3 10/10], added the binding change in this series, and addressed issues in "make dt_binding_check"

Changes in v2:
  In [v2 01/10], added code to handle spurious interrupt.
  In [v2 03/10], adressed minor comments to update the code logic.
  In [v2 04/10], minor update to detect spurious interrupt.
  In [v2 05/10], added Fixes tag.
  In [v2 07/10], added Fixes tag and updated commit text to explain the problem.
  In [v2 08/10], added binding change to make interrupt properties as optional.
  In [v2 09/10], updated to check presence of "interrupt-controller" property.


Abhijeet Dharmapurikar (1):
  spmi: pmic-arb: add a print in cleanup_irq

Ashay Jaiswal (1):
  spmi: pmic-arb: add support to dispatch interrupt based on IRQ status

David Collins (6):
  spmi: pmic-arb: check apid against limits before calling irq handler
  spmi: pmic-arb: correct duplicate APID to PPID mapping logic
  spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
  dt-bindings: spmi: spmi-pmic-arb: make interrupt properties as
    optional
  spmi: pmic-arb: make interrupt support optional
  spmi: pmic-arb: increase SPMI transaction timeout delay

Fenglin Wu (1):
  spmi: pmic-arb: handle spurious interrupt

Subbaraman Narayanamurthy (1):
  spmi: pmic-arb: do not ack and clear peripheral interrupts in
    cleanup_irq

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   3 -
 drivers/spmi/spmi-pmic-arb.c                       | 136 +++++++++++++++------
 2 files changed, 96 insertions(+), 43 deletions(-)

-- 
2.7.4

