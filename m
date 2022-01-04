Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C756484146
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiADL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:59:39 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3679 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbiADL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641297576; x=1672833576;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OP/lvMMVw+0Of1bLjB7oFFNrCpJbfhAYUrbKN8w8Buw=;
  b=GdmSlTDNAvmAkh19lgc529irUOYGoTjFnCjBNuGLqYQOw4a7d0i33nXJ
   Aotdl4KVlzcntM1RKoUaJ5S/BuxqWnK1BM67XbSl44Rmhhkt+0wuybbhY
   0ou2ZmZAR/94GhDKR3uVh/a0d5pLBfP87urafCQ39t3X1MjvDb/7KFNJc
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jan 2022 03:59:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:59:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:34 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:30 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 0/7] Add Embedded USB Debugger (EUD) driver
Date:   Tue, 4 Jan 2022 17:28:13 +0530
Message-ID: <cover.1641288286.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches that implements a driver for the control
peripheral, EUD (Embedded USB Debugger). The EUD is a mini-USB hub
implemented on chip to support the USB-based debug and trace capabilities.
Apart from debug capabilities, EUD has a control peripheral. Control
Peripheral is on when EUD is on and gets signals like USB attach, pet
EUD etc. EUD driver listens to events like USB attach or detach and then
informs the USB about these events via ROLE-SWITCH. At regular intervals,
the EUD driver receives an interrupt to pet the driver indicating that
the software is functional.

Changes in V3

* Removed the patch for registration of EUD connector as it is no longer
  required.
  
* Added the description to include EUD in usb-connector.yaml  

* Implemented comments on V2 of the patch.

Changes in V2

* Fixed the yaml issue and also implemented comments on yaml in V1.

Changes in V1

* EUD has now been mapped as a separate DT node as it is an independent QCOM IP.

* EUD is attached to the connector child of dwc3 via port end point since EUD
  driver needs the connector for role-switching.

* EUD driver has been moved now to drivers/soc/qcom/qcom_eud.c.

* All the comments from version 0 of the patch has been implemented.

Souradeep Chowdhury (7):
  dt-bindings: Add the yaml bindings for EUD
  dt-bindings: connector: Add property for EUD type-C connector
  bindings: usb: dwc3: Update dwc3 properties for EUD connector
  soc: qcom: eud: Add driver support for Embedded USB Debugger(EUD)
  arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
  arm64: dts: qcom: sc7280: Set the default dr_mode for usb2
  MAINTAINERS: Add maintainer entry for EUD

 Documentation/ABI/testing/sysfs-driver-eud         |   9 +
 .../bindings/connector/usb-connector.yaml          |   7 +-
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |  50 ++++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   6 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   4 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  25 ++
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qcom_eud.c                        | 260 +++++++++++++++++++++
 10 files changed, 379 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
 create mode 100644 drivers/soc/qcom/qcom_eud.c

-- 
2.7.4

