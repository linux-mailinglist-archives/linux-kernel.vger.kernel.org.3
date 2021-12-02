Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F936465A28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbhLBAEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:04:13 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:53315 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353902AbhLBAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638403243; x=1669939243;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=T9wXr1cGD+ZTV92qLqbzIyRrhycRLxu645SkksvngmE=;
  b=E7oJTSXM8w8S9idjuRvdrRpdP6E+gD0OrYWsyJoM9F91eR1K+HMd3iRX
   JmrBBOVRNXA/xgVJ5Aagc7/tAZg7sz6iyy3+A1yaoJ1LHz4Y3Hs5zKPT4
   5Qlj8/mSAtiBQ8Wn4wwFhmuG0mY+i7nIRVLxfODj0c5lZyAFZ50Pvkq/U
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 16:00:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:00:42 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:00:42 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:00:39 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [RESEND PATCH v3 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Thu, 2 Dec 2021 08:00:02 +0800
Message-ID: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Resend the series and cc irqchip maintainers.

  Remove [v2 07/10], it's no longer needed after this change:
	https://lore.kernel.org/all/20211118034719.28971-1-quic_collinsd@quicinc.com/T/#u
  In [v3 07/10], update the author email to match with Signed-off-by.
  In [v3 10/10], address issues in qcom,spmi-pmic-arb.yaml


Abhijeet Dharmapurikar (1):
  spmi: pmic-arb: handle spurious interrupt

Ashay Jaiswal (1):
  spmi: pmic-arb: add support to dispatch interrupt based on IRQ status

David Collins (6):
  spmi: pmic-arb: check apid against limits before calling irq handler
  spmi: pmic-arb: correct duplicate APID to PPID mapping logic
  spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
  bindings: spmi: spmi-pmic-arb: mark interrupt properties as optional
  spmi: pmic-arb: make interrupt support optional
  spmi: pmic-arb: increase SPMI transaction timeout delay

Fenglin Wu (1):
  dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format

Subbaraman Narayanamurthy (1):
  spmi: pmic-arb: do not ack and clear peripheral interrupts in
    cleanup_irq

 .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  65 ----------
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++
 Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
 drivers/spmi/spmi-pmic-arb.c                       | 137 +++++++++++++++------
 4 files changed, 226 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

-- 
2.7.4

