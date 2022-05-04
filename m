Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9E51A02C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350155AbiEDNGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbiEDNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:06:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421B377E0;
        Wed,  4 May 2022 06:03:09 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244A6Oxs016063;
        Wed, 4 May 2022 15:02:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=thMF4CPlkTsnZstfuDPh8HVl0o2Yyz4DhhVhNaGVUps=;
 b=2qokIaFqOEp/FXAivRHLXQwfKtxNjCCZENfb4vNYvO/+VzMxONx79mBqLl3SMjLaGaGE
 mP3Fc9FLIUNTzD5ePCe9yefrHAKFfrEnrUnpKBC7KHFvjezEsLEkfGjys50xJHnUQklD
 HMP5KoJ5tuLTcP6OkKXwu4jgPIV1GQuhP2OJ9kzkAP+NMawrCgIcIZ1zsVyJcslKqsGr
 yLkDPyNW+i2TYAg1jxuTofrbZCLPUrUaZw7MczHBKKBHHE1Y1mGF2jTSyDMIsgEijErp
 3TqNf2ZzhGT41UpLkR6VPTnXU0erM80zilESEUNqB+UxWN5pamwsmHuh/wM4ZuywMXmp Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frvf0m4ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 15:02:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DEE810002A;
        Wed,  4 May 2022 15:02:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A50B21FE9E;
        Wed,  4 May 2022 15:02:40 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 15:02:39
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] rtc: stm32: add alarm out and LSCO features.
Date:   Wed, 4 May 2022 15:02:27 +0200
Message-ID: <20220504130233.330983-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32MP1x SOCs, RTC is able to output some signals on its own pins.

This series add the possibility to select two of these signals on
RTC pins :
 - LSCO (Low Speed Clock Output) that allow to output LSE clock on a pin.
   On STM32MP1x Discovery boards this feature is used to generate a clock
   to Wifi/Bluetooth module.
 - Alarm out that allow to send a pulse on a pin when alarm A of the RTC
   expires.

Amelie Delaunay (2):
  dt-bindings: rtc: stm32: add st,lsco optional property to select
    output
  rtc: stm32: add Low Speed Clock Output (LSCO) support

Gabriel Fernandez (2):
  ARM: dts: stm32: add RTC LSCO support on stm32mp157c-dk2
  ARM: dts: stm32: add RTC LSCO support on stm32mp135f-dk

Valentin Caron (2):
  dt-bindings: rtc: stm32: add alarm A out property to select output
  rtc: stm32: add alarm A out feature

 .../devicetree/bindings/rtc/st,stm32-rtc.yaml |  37 +++
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi      |   6 +
 arch/arm/boot/dts/stm32mp135f-dk.dts          |   4 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |   6 +
 arch/arm/boot/dts/stm32mp157c-dk2.dts         |   7 +
 drivers/rtc/Kconfig                           |   1 +
 drivers/rtc/rtc-stm32.c                       | 210 ++++++++++++++++++
 include/dt-bindings/rtc/rtc-stm32.h           |  14 ++
 8 files changed, 285 insertions(+)
 create mode 100644 include/dt-bindings/rtc/rtc-stm32.h

-- 
2.25.1

