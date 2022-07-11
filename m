Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE300570121
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiGKLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGKLtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:49:16 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB51115C;
        Mon, 11 Jul 2022 04:49:14 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8GhDu023853;
        Mon, 11 Jul 2022 13:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=IBdPZD/lgcjOqxf5WRf16r/XmqP10xUsJSLa25j+xfA=;
 b=q5Z5UPwAbRwN0wgwvmFjR8apZhP7Beg8MBFKZ3jAatKXy0zj0iG1LLJ+TpVCWXYGHJ4u
 x8YWumDgNLUd+JCBXNTKcwTsgDspuNjx8c+R5ZS7LfSJuRAyfKqoOym4gTLi4Jm5HDCX
 uM+2Imkm+gziVTW9vIzPp3fAb0fidJTdH7Sah4AcV1M3kLwCF4H3mF/gk16P6OTRSc8p
 yRdK0oYHRJgOu8pCoRdNv0XoDPeHRmSH6cgacwyO2qosMClnwbJY0ADTqXiwoTJD8IAk
 WUWmkz2jIbwFY0JD+GKeV29auv5EpKyv5JPVbnWX6DOVUkC9GK9LPF82niTg/CiKtV/I Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h6xtak3vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 13:48:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3D3C10002A;
        Mon, 11 Jul 2022 13:48:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB69C21D384;
        Mon, 11 Jul 2022 13:48:46 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 11 Jul
 2022 13:48:46 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/4] usb: typec: ucsi: add support for stm32g0
Date:   Mon, 11 Jul 2022 13:48:27 +0200
Message-ID: <20220711114831.25205-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_17,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32G0 provides an integrated USB Type-C and power delivery interface [1].
It can be programmed with a firmware [2] to act as a PPM. Currently it
implements UCSI protocol over I2C interface. A GPIO is used as an interrupt
line.

This series adds a driver to support it, including:
- dt-bindings documentation
- optional STM32G0 firmware control and update, over a secondary I2C address
- power management

[1] https://wiki.st.com/stm32mcu/wiki/Introduction_to_USB_Power_Delivery_with_STM32
[2] https://github.com/STMicroelectronics/x-cube-ucsi

Changes in v2:
- Krzysztof's review comments on dt-bindings: update commit message, use ports,
  use unevaluatedProperties: false for usb-connector schema, define maxItems
  for power-domains, adopt generic node names, remove quotes.
- Christophe's comments on driver:
  use kmalloc instead of kzalloc
  Use-after-free of buf: directly print the offset

Fabrice Gasnier (4):
  dt-bindings: usb: typec: add bindings for stm32g0 controller
  usb: typec: ucsi: stm32g0: add support for stm32g0 i2c controller
  usb: typec: ucsi: stm32g0: add bootloader support
  usb: typec: ucsi: stm32g0: add support for power management

 .../bindings/usb/st,typec-stm32g0.yaml        |  90 ++
 drivers/usb/typec/ucsi/Kconfig                |  10 +
 drivers/usb/typec/ucsi/Makefile               |   1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c         | 777 ++++++++++++++++++
 4 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
 create mode 100644 drivers/usb/typec/ucsi/ucsi_stm32g0.c

-- 
2.25.1

