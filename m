Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB749A808
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315999AbiAYCzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:00 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6356 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3409895AbiAYA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643070471; x=1674606471;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=muJislQo56JK8jPw5RkQCrGtoGCd3t6/rtkh2XIwz6w=;
  b=iNIssaEPb42D4keptZxI2lMZU9kDig7VFiMcNPE8l3EbK07jfgeonbXK
   YoScnIPdfqK3DIsA5RIeq3znFMfEVANhQOqz6Gc8PVcvVJulVfFWUqFbz
   ZPU6Jbh9wsWtUGWZqaVCbvdLzt7xZBzFq6qUS7Hvsk7M7VX3GJ3h3nSsI
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jan 2022 16:27:50 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 16:27:49 -0800
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 16:27:49 -0800
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
Subject: [RESEND PATCH 0/2] regulator: scmi: add support for registering SCMI regulators by name
Date:   Mon, 24 Jan 2022 16:27:34 -0800
Message-ID: <cover.1643069954.git.quic_collinsd@quicinc.com>
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

