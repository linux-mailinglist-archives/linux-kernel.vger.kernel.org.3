Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F7527B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiEPAzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 20:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiEPAzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 20:55:14 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9542A259;
        Sun, 15 May 2022 17:55:09 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 24G0eWlr022581;
        Mon, 16 May 2022 08:40:32 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 May
 2022 08:54:04 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <jk@codeconstruct.com.au>, <a.kartashev@yadro.com>,
        <patrick.rudolph@9elements.com>, <dphadke@linux.microsoft.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>
Subject: [PATCH v5 0/4] arm: aspeed: Add eSPI support
Date:   Mon, 16 May 2022 08:54:08 +0800
Message-ID: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 24G0eWlr022581
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the driver support for the eSPI controller of Aspeed 5/6th generation SoCs. This controller is a slave device communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire, out-of-band, and flash, and operates at max frequency of 66MHz.

v5:
 - unconditionally set VW GPIO to software mode as suggested by Jeremy
 - add missing DTS node for Aspeed G5 SoCs

v4:
 - fix dt-bindgins error with patternProperties
 - fix data type warning for ARM64 compilation
 - replace header based implementation with .c files
 - add more description for the ioctl interface

v3:
 - remove the redundant patch "clk: aspeed: Add eSPI reset bit"
 - fix missing header inclusion reported by test bot
 - fix dt-bindings error reported by yamllint

v2:
 - remove irqchip implementation
 - merge per-channel drivers into single one to avoid the racing issue
   among eSPI handshake process and driver probing.

Chia-Wei Wang (4):
  dt-bindings: aspeed: Add eSPI controller
  MAINTAINER: Add ASPEED eSPI driver entry
  soc: aspeed: Add eSPI driver
  ARM: dts: aspeed: Add eSPI node

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 +++++
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  17 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  17 +
 drivers/soc/aspeed/Kconfig                    |  11 +
 drivers/soc/aspeed/Makefile                   |   5 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 214 +++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 309 ++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.c        | 352 +++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-ioc.h          | 195 ++++++
 drivers/soc/aspeed/aspeed-espi-oob.c          | 558 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-oob.h          |  70 +++
 drivers/soc/aspeed/aspeed-espi-perif.c        | 511 ++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-perif.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-vw.c           | 142 +++++
 drivers/soc/aspeed/aspeed-espi-vw.h           |  21 +
 17 files changed, 2683 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ioc.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.h

-- 
2.25.1

