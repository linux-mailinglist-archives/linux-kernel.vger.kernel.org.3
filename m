Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A406D46F8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhLJB6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:58:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:45209 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230172AbhLJB6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639101314; x=1670637314;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=muJislQo56JK8jPw5RkQCrGtoGCd3t6/rtkh2XIwz6w=;
  b=AuOBczOGLpULJGb4QetP9lnQBPli724acNSH0ojv7Ead4lfbbsPPWmyv
   NG0/5VUxZXOD7pWMA+GFZwjjSFmJTlJ/ywaRNsykTzdtan9aEYoteY3vC
   3Vi4ElsJjVPrGU0VtfqiH/5d/IcUICo+6D5b0dXnlRMppZxXqUJqKBldU
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Dec 2021 17:55:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:55:13 -0800
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 17:55:13 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>
Subject: [PATCH 0/2] regulator: scmi: add support for registering SCMI regulators by name
Date:   Thu, 9 Dec 2021 17:54:40 -0800
Message-ID: <cover.1639099631.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to register SCMI regulator subnodes based on an SCMI
Voltage Domain name specified via the 'regulator-name' device tree
property.  In doing so, make the 'reg' property optional with the
constraint that at least one of 'reg' or 'regulator-name' must be
specified.  If both are specified, then both must match the
Voltage Domain data exposed by the SCMI platform.

Name based SCMI regulator registration helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

David Collins (2):
  dt-bindings: firmware: arm,scmi: define support for name based
    regulators
  regulator: scmi: add support for registering SCMI regulators by name

 .../bindings/firmware/arm,scmi.yaml           | 11 +++-
 drivers/regulator/scmi-regulator.c            | 57 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.17.1

