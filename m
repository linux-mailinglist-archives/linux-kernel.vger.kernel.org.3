Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C257E210
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiGVNHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiGVNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:07:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4FE1F6;
        Fri, 22 Jul 2022 06:07:07 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M9svFj006924;
        Fri, 22 Jul 2022 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=FhrNx+4+JOjQW89HIHGVVBlDYUJXAfCGDiAxKAfPtus=;
 b=hlfZ1EE+wt1OOsKGZ7jOskbuhjqMJwr4VdS0D4dqt0s48Q6QPk2Z80hd8YFVXVMYY6/n
 TUQQAQf0JO8iVnmWDFuX6EJTs5V2ohr3keSZ2umB3ZZis8VgOlaZkZUNbcp38xIKLJQH
 HlGT2a6CQN8htfPktetRHJy8xkqb0BKwtiC0otLv6W67o3jlpHJG0X9pWvH+1M5RHcnG
 PQbKaK0KuZ+cA+pyp1lH7KqTsvc76tEkJldtWKceVaul4J4e6PTzbB1VURU0dObqi4PH
 bTm57i9WhpGV1YMszlysk8mRhNkXE+Cvf+8fsfSkFHZZKc3hDRR8RgtcezqvsYcodPGe +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp6jxut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 15:06:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1CDCD10002A;
        Fri, 22 Jul 2022 15:06:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0798E228A4F;
        Fri, 22 Jul 2022 15:06:38 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Jul
 2022 15:06:37 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mka@chromium.org>,
        <alexandre.torgue@foss.st.com>
CC:     <arnd@arndb.de>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/4] usb: misc: adopt onboard hub support on stm32mp1 boards
Date:   Fri, 22 Jul 2022 15:05:50 +0200
Message-ID: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
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

