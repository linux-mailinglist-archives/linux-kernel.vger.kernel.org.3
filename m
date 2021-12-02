Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3374660BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbhLBJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:56:11 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41185 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356667AbhLBJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638438760; x=1669974760;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tC5LXKjUKwQxEKmuAm29KfJD1uoIp9cEC1FTYO6jNx0=;
  b=cNaKUN5m3J5HsuNAUK8rmgObCal5up7QQ503RjG4LJRjnRODARJpPuDE
   TJgTJ4hLPOLeno0s8E9Dz0F42PcZQ/jyU+fm7Gb56w1mkem8vshAbKOmK
   1sRq95xkVnDBKUHP6A1Az9arP+8qDDhufiW5IXNTrKhv22gQ9MuRk09uW
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Dec 2021 01:52:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:52:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:32 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:52:27 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 0/8] Add Embedded USB Debugger (EUD) driver
Date:   Thu, 2 Dec 2021 15:21:19 +0530
Message-ID: <cover.1638430506.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Changes in V2

*Fixed the yaml issue and also implemeted comments on yaml in V1.

Changes in V1

* EUD has now been mapped as a separate DT node as it is an independent QCOM IP.

* EUD is attached to the connector child of dwc3 via port end point since EUD
  driver needs the connector for role-switching.

* EUD driver has been moved now to drivers/soc/qcom/qcom_eud.c.

* All the comments from version 0 of the patch has been implemented.

Souradeep Chowdhury (8):
  dt-bindings: Add the yaml bindings for EUD
  dt-bindings: connector: Add property for EUD type-C connector
  bindings: usb: dwc3: Update dwc3 properties for EUD connector
  usb: dwc3: drd: Register the eud connector child node for dwc3
  soc: qcom: eud: Add driver support for Embedded USB Debugger(EUD)
  arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
  arm64: dts: qcom: sc7280: Set the default dr_mode for usb2
  MAINTAINERS: Add maintainer entry for EUD

 Documentation/ABI/testing/sysfs-driver-eud         |   9 +
 .../bindings/connector/usb-connector.yaml          |   4 +
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |  50 ++++
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   6 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |   4 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  25 ++
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qcom_eud.c                        | 268 +++++++++++++++++++++
 drivers/usb/dwc3/drd.c                             |  26 ++
 11 files changed, 411 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-eud
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
 create mode 100644 drivers/soc/qcom/qcom_eud.c

--
2.7.4

