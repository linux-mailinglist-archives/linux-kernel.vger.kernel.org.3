Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED9B49C39F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiAZGcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:32:36 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7996 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiAZGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643178755; x=1674714755;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CA/L4iq490CnFtokIeJ5JrWOXn3/MldoWR4UmXsDSuM=;
  b=ERDKKhx0Xx9C/iWEfC88aXN66ZiylNP499rFBi+OxETcTYP+7IHo6V2g
   LjIFnDpNjZeL3cxCKj8tpSEj7NL04gpelBHo26ral8+tlGGrzO3CetMEB
   9YCt33yo76z7hNg9OplRDYGIKp+SJ7X05Y3bJvEYYGOgLQb+WzAfIwkr6
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Jan 2022 22:32:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 22:32:34 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 22:32:34 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 22:32:31 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH v5 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Wed, 26 Jan 2022 14:31:42 +0800
Message-ID: <1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  bindings: spmi: spmi-pmic-arb: mark interrupt properties as optional
  spmi: pmic-arb: make interrupt support optional
  spmi: pmic-arb: increase SPMI transaction timeout delay

Fenglin Wu (1):
  spmi: pmic-arb: handle spurious interrupt

Subbaraman Narayanamurthy (1):
  spmi: pmic-arb: do not ack and clear peripheral interrupts in
    cleanup_irq

 .../bindings/spmi/qcom,spmi-pmic-arb.txt           |   2 +
 drivers/spmi/spmi-pmic-arb.c                       | 136 +++++++++++++++------
 2 files changed, 98 insertions(+), 40 deletions(-)

-- 
2.7.4

