Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AE517A13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiEBWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiEBWpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB2E08F;
        Mon,  2 May 2022 15:41:35 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 72C0F221D4;
        Tue,  3 May 2022 00:41:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tETKb6Fxnn9/6vUpKYVDlMbC/k2NaZsHpF6xUJCmZMM=;
        b=CkqX1gmVFxAan00CryNDBgCXlKtpMgZqI3Tbz9d16d2f12xRPgTDGg+x/7e/DPHQqpsWVq
        7Ahf21mfbNc2CmD4255HX2k+nwuvhiKa5GzOB0sUScCSC3Q2zg9FJDHPxhRWaTwNkO3n7Z
        QK8iUggrfKj3ZT5TK+vvZ3x4Q8REVg8=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 00/13] ARM: dts: lan966x: dtsi improvements and KSwitch D10 support
Date:   Tue,  3 May 2022 00:41:14 +0200
Message-Id: <20220502224127.2604333-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing nodes for the flexcom blocks and a node for the SGPIO
block. Then add basic support for the Kontron KSwitch D10.

The first submission of this patchset was a long time ago. Since
then networking matured and is now working. Thus this now also
contains patches for all the networking related nodes and enables
them on the Kontron D10 switch.

changes since v3:
 - basic d10 switch support dropped the i2c mux and added a
   dedicated bus for the second SFP cage.
 - new patch to add the hwmon node
 - new patches to add the network related nodes and to enable
   the nodes on the d10 switch

changes since v2:
 - add second kontron board variant and moved common stuff into a
   new dtsi
 - moved the uart/i2c nodes inside of the flexcom node
 - moved sgpio child nodes inside of the sgpio node

changes since v1:
 - fixed indendation
 - keep compatible, reg first, move #address-cells and #size-cells
   towards the end

Michael Walle (13):
  ARM: dts: lan966x: swap dma channels for crypto node
  ARM: dts: lan966x: add sgpio node
  ARM: dts: lan966x: add missing uart DMA channel
  ARM: dts: lan966x: add all flexcom usart nodes
  ARM: dts: lan966x: add flexcom SPI nodes
  ARM: dts: lan966x: add flexcom I2C nodes
  ARM: dts: lan966x: add basic Kontron KSwitch D10 support
  ARM: dts: lan966x: add hwmon node
  ARM: dts: lan966x: add MIIM nodes
  ARM: dts: lan966x: add reset switch reset node
  ARM: dts: lan966x: add serdes node
  ARM: dts: lan966x: add switch node
  ARM: dts: kswitch-d10: enable networking

 arch/arm/boot/dts/Makefile                    |   4 +-
 ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts |  94 +++++
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts    |  39 ++
 .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 190 ++++++++++
 arch/arm/boot/dts/lan966x.dtsi                | 353 +++++++++++++++++-
 5 files changed, 676 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi

-- 
2.30.2

