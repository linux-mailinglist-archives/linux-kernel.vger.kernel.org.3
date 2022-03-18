Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43DE4DE273
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiCRU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiCRU1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:27:14 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13E28AC5C;
        Fri, 18 Mar 2022 13:25:54 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4249822239;
        Fri, 18 Mar 2022 21:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647635152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CjYRXqLQZoAevpessURi47tpYDs5HOjG6CCvnj8Lq/A=;
        b=UGDvv1muvDVuBFBFxe+oKlWyNQbWK8xcz1dbOZi7U6a0lqz+5N7oR4WgV5CO9SK6QTXFee
        jNnl7id9IaKKts1wqH7fBGYCytK4PBXmg3UKJ2bwRnRvyASU1lc6rQt86cC0FZPpbx0gux
        eY6P8V1Q77ZTIPx136VDfFr3Z99pomo=
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
Subject: [PATCH v2 0/8] pinctrl: ocelot: convert to YAML format
Date:   Fri, 18 Mar 2022 21:25:39 +0100
Message-Id: <20220318202547.1650687-1-michael@walle.cc>
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

changes since v1:
 - drop "Device Tree Binding" from the title of the binding
 - describe reg properties and provide minItems and set it differently
   depending on the compatible string
 - skip interrupt description
 - move required section after patternProperties

Michael Walle (8):
  MIPS: mscc: jaguar2: fix pinctrl nodes
  MIPS: mscc: ocelot: fix MIIM1 pinctrl node name
  MIPS: mscc: ocelot: fix PHY interrupt pinctrl node name
  MIPS: mscc: ocelot: fix load/save GPIO pinctrl name
  MIPS: mscc: serval: fix pinctrl node names
  arm64: dts: sparx5: fix pinctrl node names
  ARM: dts: lan9662-pcb8291: fix pinctrl node name
  dt-bindings: pinctrl: convert ocelot-pinctrl to YAML format

 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |  42 -------
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 108 ++++++++++++++++++
 arch/arm/boot/dts/lan966x-pcb8291.dts         |   2 +-
 .../dts/microchip/sparx5_pcb134_board.dtsi    |  26 ++---
 .../dts/microchip/sparx5_pcb135_board.dtsi    |  10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts    |  10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb111.dts    |  10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb118.dts    |   6 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           |   4 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts     |   6 +-
 arch/mips/boot/dts/mscc/serval_common.dtsi    |  14 +--
 11 files changed, 152 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml

-- 
2.30.2

