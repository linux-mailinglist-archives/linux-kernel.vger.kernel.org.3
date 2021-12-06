Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3697646A086
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444173AbhLFQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:05:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48600 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1444071AbhLFQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:02:02 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6AQR5W010379;
        Mon, 6 Dec 2021 16:58:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6j4JfF7PbNsMncG3LrQqk6YgpvQ6hOU4ElFAtx3ffEM=;
 b=ZM9ZGLVdYE0/DUA5HJ3p9ahKRAbDyOel66t2LdNl1YNPuCcewhYtfNI4SLBXBZD5SyEB
 p/M5p7cOE8qadKdsur5r389hh/m0as+etEIVgkQjSvjIqVRciYXsvJQDsT1x4bwbzU5l
 YWhognaGjW22khtobrFlzCw83i5U9xcgB8pZG01Yyg3MUveK3DetQTnEEDE6PWVgMlcB
 Acpasp71la5dl8R2ZYJrGpB8gta4AnIFJ/041lvvNL0kkzpY+zynQbiKn2tvU/xxUKag
 FYon4hJx05n5GtaVL3Qfy7J3JT7VA9pnQtg2n4s7UzLnX11hcjs3l2mNeNVE2Zi4a43S 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csb4j3dx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:58:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FA1510002A;
        Mon,  6 Dec 2021 16:58:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23E6820930D;
        Mon,  6 Dec 2021 16:58:21 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 6 Dec 2021 16:58:20
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 0/3] usb: dwc2: drd: add support for role-switch-default-mode
Date:   Mon, 6 Dec 2021 16:56:40 +0100
Message-ID: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the role-switch-default-mode binding, to configure
the controller default mode, when the role is USB_ROLE_NONE.

This has been tested on STM32MP15 DK2 board, with:
 &usbotg_hs {
 	phys = <&usbphyc_port1 0>;
 	phy-names = "usb2-phy";
 	usb-role-switch;
 	dr_mode = "peripheral";
 	role-switch-default-mode = "peripheral";
 	status = "okay";
 }

Fabrice Gasnier (3):
  dt-bindings: usb: document role-switch-default-mode property in dwc2
  usb: dwc2: drd: add role-switch-default-node support
  usb: dwc2: drd: restore role and overrides upon resume

 Documentation/devicetree/bindings/usb/dwc2.yaml |  3 ++
 drivers/usb/dwc2/core.h                         |  3 ++
 drivers/usb/dwc2/drd.c                          | 51 ++++++++++++++++++++++++-
 drivers/usb/dwc2/platform.c                     | 10 +++--
 4 files changed, 61 insertions(+), 6 deletions(-)

-- 
2.7.4

