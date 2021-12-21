Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA16A47BA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhLUHUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:20:43 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16920 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhLUHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640071242; x=1671607242;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5apnI+NFP5ph+MQ6/FXEzCVP6wQpf+R+4+RH8/BQ9W4=;
  b=JTYjEv0O15GKHCkn1EwKZiF6oULouassbNPUNxRRRCyozsEK0JDIhHFI
   guN99GIcnt24UNDgVGpEyEIjV49lIyo0J0ZnQpPM+EpW2JI32g+8bWKSq
   V/DE5qfwoUPP3V6+Nkzktkhc2lcr9iExnwvSaRkPtG8WLlk77a/UNYwGN
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Dec 2021 23:20:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:20:41 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:41 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 23:20:39 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v4 00/11] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Tue, 21 Dec 2021 15:19:58 +0800
Message-ID: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  bindings: spmi: spmi-pmic-arb: mark interrupt properties as optional
  spmi: pmic-arb: make interrupt support optional
  spmi: pmic-arb: increase SPMI transaction timeout delay

Fenglin Wu (2):
  spmi: pmic-arb: handle spurious interrupt
  dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format

Subbaraman Narayanamurthy (1):
  spmi: pmic-arb: do not ack and clear peripheral interrupts in
    cleanup_irq

 .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  65 ---------
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 146 +++++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                       | 136 +++++++++++++------
 3 files changed, 242 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

-- 
2.7.4

