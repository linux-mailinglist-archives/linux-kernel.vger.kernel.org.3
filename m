Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40404D766D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiCMPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiCMPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:31:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE427CC0;
        Sun, 13 Mar 2022 08:29:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 39CDC22238;
        Sun, 13 Mar 2022 16:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647185385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=thrnb94/ICCp7bDqYxQzY7ZZwtZvmddmHTgT7F76JX4=;
        b=so0einbshdNaW3wd7EixWOPh8a5LJubFBq9N1MCzKDJtf2Zzu/UuwyYi9Khkk0iPli5HzJ
        owF5F+euywZEiJXzRiMSQJ3aihn6qQRSjVRUwIGL5p+JOU8bcvw+8tUMPcS6QGAF33RiZd
        BeFsBXP03p5fydd+jr5PGh+S0xkHCcc=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 0/8] pinctrl: ocelot: convert to YAML format
Date:   Sun, 13 Mar 2022 16:29:16 +0100
Message-Id: <20220313152924.61931-1-michael@walle.cc>
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

Convert the pinctrl ocelot binding to the new YAML format. Pin
configuration nodes should have a "-pins" postfix. But unfortunately,
there are many device trees which don't follow this. First rename
all these nodes and then convert the binding to the YAML format so
that the validation will pass.

Because there were no maintainers before and there is none in
MAINTAINERS I added Alexandre Belloni and Lars Povlsen, juding by
the commits - to the binding as maintainers. Please tell me if you
disagree.

Michael Walle (8):
  MIPS: mscc: jaguar2: fix pinctrl nodes
  MIPS: mscc: ocelot: fix MIIM1 pinctrl node name
  MIPS: mscc: ocelot: fix PHY interrupt pinctrl node name
  MIPS: mscc: ocelot: fix load/save GPIO pinctrl name
  MIPS: mscc: serval: fix pinctrl node names
  arm64: dts: sparx5: fix pinctrl node names
  ARM: dts: lan9662-pcb8291: fix pinctrl node name
  dt-bindings: pinctrl: convert ocelot-pinctrl to YAML format

 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  | 42 ---------
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 94 +++++++++++++++++++
 arch/arm/boot/dts/lan966x-pcb8291.dts         |  2 +-
 .../dts/microchip/sparx5_pcb134_board.dtsi    | 26 ++---
 .../dts/microchip/sparx5_pcb135_board.dtsi    | 10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts    | 10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb111.dts    | 10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb118.dts    |  6 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           |  4 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts     |  6 +-
 arch/mips/boot/dts/mscc/serval_common.dtsi    | 14 +--
 11 files changed, 138 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml

-- 
2.30.2

