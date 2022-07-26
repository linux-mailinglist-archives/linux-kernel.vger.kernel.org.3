Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4A580E91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiGZIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiGZIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:08:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3D2B1A8;
        Tue, 26 Jul 2022 01:07:59 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q6Zgok008998;
        Tue, 26 Jul 2022 10:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=HVvobxygxJWw+3L3+H2mjH9wVwihqtM6fjUpIWckSr0=;
 b=0eOSvSD6ZebQSx5nuxxu2Cd4cqj9q4mxGTMdkLuLCclGcNRaBRSUdr43ifPf4PGk/8+d
 +JOtYZzj+J9gwlpDceC8PvPisoPpJBw/RSeb3k8l2Qcc/1N6PFLuMJ9KKgQaLnYG6q/T
 /fc2cxrUZjbUQCFKP3D4+1KPqZj/gRTrz2rL6bhQCGVKpts6Sdg0kB66XCmHApIo6rR/
 PCaDdu/gpUtQIdH9f/ub85PFjrGyYR0kX9wbM79/6EU19mw2heOSA6PNQdTxWVlrYj8R
 q32Rj3r7UfP7NrWkShitdpwASfYEoCkQXeuNVFzLC7PsePsGM0WYuwh4CIRSNlv/vmid 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hg7vhen7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:07:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8ED1610002A;
        Tue, 26 Jul 2022 10:07:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C55412128A3;
        Tue, 26 Jul 2022 10:07:30 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 26 Jul
 2022 10:07:29 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <alexandre.torgue@foss.st.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <arnd@arndb.de>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/4] usb: misc: adopt onboard hub support on stm32mp1 boards
Date:   Tue, 26 Jul 2022 10:07:04 +0200
Message-ID: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_02,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USB2514B HUB found on stm32mp1 boards:
- Extend the ehci-generic dt-binding to fully use the usb-hcd.yaml, and so
  the usb-device.yaml.
- Add usb-device compatible ("usbVID,PID") for the USB2514B USB2.0 HUB to
  the onboard_usb_hub driver.
- Add relevant device tree node to stm32mp15 DK boards.
- Enable the onboard_usb_hub driver on multi_v7 platforms.

Changes in v2:
- Follow Matthias review comments
- dt-bindings reviewed by Rob

Fabrice Gasnier (4):
  dt-bindings: usb: generic-ehci: allow usb-hcd schema properties
  usb: misc: onboard-hub: add support for Microchip USB2514B USB 2.0 hub
  ARM: dts: stm32: add support for USB2514B onboard hub on
    stm32mp15xx-dkx
  ARM: multi_v7_defconfig: enable USB onboard HUB driver

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 7 +------
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                  | 8 ++++++++
 arch/arm/configs/multi_v7_defconfig                     | 1 +
 drivers/usb/misc/onboard_usb_hub.c                      | 2 ++
 drivers/usb/misc/onboard_usb_hub.h                      | 1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.25.1

