Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4634E35C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiCVAtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiCVAtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:49:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B356275C8;
        Mon, 21 Mar 2022 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647910068; x=1679446068;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=C5lTDdOfMPAE0ajPAQDA9bQQeuDZypCaA114x2yCVZU=;
  b=b5elKTMmROsEj45tUc83YMI6w6gAzXPsz0x7YOdzBAvScUgneGdazAvS
   E7IiglN7xATYSiU169dSKMC9YxYqCe+8Q3TJTSFrrfnFM16tTClZPWjdE
   LfasyRA4XCKGtBc4grRX+8JJ8tSRdIh06j1QJ1Ys0jaOYHyt7/R6UgOwo
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 17:47:48 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:47:47 -0700
Received: from collinsd-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 17:47:47 -0700
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
Subject: [PATCH v2 0/2] regulator: scmi: add support for registering SCMI regulators by name
Date:   Mon, 21 Mar 2022 17:47:18 -0700
Message-ID: <cover.1647909090.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to register SCMI regulator subnodes based on an SCMI
Voltage Domain name specified via the "arm,scmi-domain-name" device
tree property.  In doing so, make the "reg" property optional with
the constraint that at least one of "reg" or "arm,scmi-domain-name"
must be specified.  If both are specified, then both must match the
Voltage Domain data exposed by the SCMI platform.

Name based SCMI regulator registration helps ensure that an SCMI
agent doesn't need to be aware of the numbering scheme used for
Voltage Domains by the SCMI platform.  It also ensures that the
correct Voltage Domain is selected for a given physical regulator.
This cannot be guaranteed with numeric Voltage Domain IDs alone.

Changes in v2:
- Replaced usage of DT property "regulator-name" with "arm,scmi-domain-name".

v1 of this patch series can be found at [1].

[1]: https://lore.kernel.org/lkml/cover.1643069954.git.quic_collinsd@quicinc.com/T/

David Collins (2):
  dt-bindings: firmware: arm,scmi: define support for name based
    regulators
  regulator: scmi: add support for registering SCMI regulators by name

 .../bindings/firmware/arm,scmi.yaml           | 15 ++++-
 drivers/regulator/scmi-regulator.c            | 58 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 6 deletions(-)

-- 
2.17.1

