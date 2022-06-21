Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4855360A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352921AbiFUPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352881AbiFUPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:25:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498D2B1A2;
        Tue, 21 Jun 2022 08:25:01 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LCQIIO032482;
        Tue, 21 Jun 2022 17:24:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=1DjHc8YrbaZYa2K0821Lb5I79I/6OnNRBe5v5W+s1JU=;
 b=Pq2DYeD/8pUdcymCVVOeGSCBbH1/E4xbkBFva0+FbL8lZo1k/0Q14hP4PHN7gtAnbt+J
 op+pEHSTIcNhbKzPvtCyp1yEqjJRNEPlnY9g4tkF3Ezr/iavQT/pQy7IEjSBlzSMc/Xh
 rYNMAsd5e82qL3fbIKld2Nyelu3I0Wz24gNLEgGtMb5YVIUgQcZLciZBGQ4RFu+ZzKsm
 8gFNK67iBklzO9x+UYcy/bMYz1eoZt4f1ihdD2bibq8ox3UPlJeusxd3W0mpHUboZk/S
 AyQKp/E1yyfWYkmGuNMc1KcF/IW2DjaVFSqqiuH763Sn1wrPm0sD+akLy8F0lfh4kStL yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gu9vcjtxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:24:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95E70100034;
        Tue, 21 Jun 2022 17:24:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FB2722ECD8;
        Tue, 21 Jun 2022 17:24:36 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 17:24:34 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <stern@rowland.harvard.edu>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/4] usb: host: add TPL support to ehci ohci and dwc2
Date:   Tue, 21 Jun 2022 17:23:46 +0200
Message-ID: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Target Peripheral List (TPL) support is used to identify targeted
devices during Embedded Host (EH) compliance testing. Add TPL support
setting from device tree on ehci-platform, ohci-platform and dwc2 drivers.
Also document TPL support in DWC2 dt-bindings.

Changes in v2:
- Document TPL support in DWC2 dt-bindings
- Spell TPL and EH
- Add collected ack

Amelie Delaunay (3):
  usb: host: ohci-platform: add TPL support
  usb: host: ehci-platform: add TPL support
  usb: dwc2: host: add TPL support

Fabrice Gasnier (1):
  dt-bindings: usb: dwc2: document TPL support

 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 drivers/usb/dwc2/hcd.c                          | 3 +++
 drivers/usb/host/ehci-platform.c                | 2 ++
 drivers/usb/host/ohci-platform.c                | 3 +++
 4 files changed, 11 insertions(+)

-- 
2.25.1

