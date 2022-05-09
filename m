Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32F51F7A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiEII7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiEIIxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:53:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862AE195BE1;
        Mon,  9 May 2022 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652086170; x=1683622170;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5uZDOrDyWhl4JrBtHMF+1wZx+yLzlXX1NZxBrijfkes=;
  b=J16So74tH2BhDzM7X286u3P7rBRzFUJK39lgCPEKEeOCBQt6GMu4Tmoy
   kM6HxTU/9MqqnTNG/3uL5h9hG9zF8fBzWjRP/P2plC9GZ1jzJeX5rQPVB
   p+oltsteOWLZsRbO9FGj09h6aP21e2Zddt10GoI7iIJrGryevpjssav6B
   cLagP1+cFpyXc2HQhc1iRt6Pw3gOT3Um1BchP0xcbiII6ZALtfUsrLSaj
   MwsZKTO5p4NRmbNZW4bZJIf+clMUDJOB8Mx3eTAbJrIerSc6HtQHbdgny
   A2bKqt3wI0oragKp4VldvfZ8oUK/1NC+Ocg3rzY0NzTaXR7POoElMdKAc
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="162812517"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 01:49:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 01:49:27 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 01:49:22 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 0/4] Add support for lan966 flexcom multiplexer
Date:   Mon, 9 May 2022 14:19:16 +0530
Message-ID: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements driver for lan966 flexcom multiplexer.
Converts atmel-flexcom.txt bindings to yaml format and add new
compatible string for lan966 flexcom.

This patch also adds dt bindings for lan966 flexcom multiplexer.

v1 -> v2:
- addressed comments for atmel,flexcom.yaml.
- added child node and its parameters properly in flexcom bindings.
- added ref to mux-consumer.yaml.
- added ref to mux-controller.yaml in lan966-flx-mux.yaml
- added MODULE() stuff in lan966 mux driver.

Kavyasree Kotagiri (4):
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add lan966 compatible string and mux
    properties
  dt-bindings: mux: Add lan966 flexcom mux controller
  mux: lan966: Add support for flexcom mux controller

 .../bindings/mfd/atmel,flexcom.yaml           | 142 ++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 --------
 .../mux/microchip,lan966-flx-mux.yaml         |  51 +++++++
 arch/arm/mach-at91/Kconfig                    |   2 +
 drivers/mfd/atmel-flexcom.c                   |  55 ++++++-
 drivers/mux/Kconfig                           |  12 ++
 drivers/mux/Makefile                          |   2 +
 drivers/mux/lan966-flx.c                      | 121 +++++++++++++++
 8 files changed, 384 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
 create mode 100644 drivers/mux/lan966-flx.c

-- 
2.17.1

