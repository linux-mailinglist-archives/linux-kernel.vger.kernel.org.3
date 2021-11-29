Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF3460FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhK2I2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:28:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5134 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243228AbhK2IZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638174161; x=1669710161;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Vdv644seXr3JpXcWqkBFBRtWY5zHvZJrlfxhQL0LOvc=;
  b=vcihdosgRjMey0i6kvfQNbPWCEVvz0R+sjlrCdVo1I+a8tWeV8Ym/PE9
   Ntj/YoeXUVKsqNgV9N4tZMmXQqA6F1yZgGoU4K32X+H0aRLw2ZxjwrSbq
   BM5Xi8afiOA7B+oRi1mWmYEpeo7xndfGRwc4SPeD+dQj23N0Kr7m0CaUM
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 00:22:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:22:40 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:22:40 -0800
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 00:22:38 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>
Subject: [PATCH v3 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Mon, 29 Nov 2021 16:22:07 +0800
Message-ID: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

