Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96DE565247
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiGDK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiGDK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:28:54 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60E2625;
        Mon,  4 Jul 2022 03:28:52 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D3743240011;
        Mon,  4 Jul 2022 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656930530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mVNeD3Iv241MMSKHzOkGYtB1tl0gPyGEB3cP/1HVpvs=;
        b=SiMelcI0U7jOc5EkaiVeqWum1ZWBMzMkRIuBNV+3SoR454c5gN0G5D4lCQ42V1hF7cOgx/
        +e+PNAIB69dQ5zGlbsSDUYaJ5JmdFdU3ng2klGnIuV7WZbR+Z5t3JnE6T/LnACBTIR7FEf
        PgyOksjZE1aBZRh7ahXSg0aQwB8BvUCIW1DWKG1S3hQMsIAdI/TbU0CdSHVp07tiGN97LU
        uHlScGJPZ+YiPPSIEckbwPqOeU2bF3tK56g0K4XK1+WolAYfKikCQKLWVUbtIBlKBWQbMS
        RuyfP1orrzsPzzA2CRPBVwq8Hum3YmEpQdir0ly/QFlk0l/v97WxAAlApwg1JA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v5 0/3] Microchip LAN966x USB device support
Date:   Mon,  4 Jul 2022 12:28:42 +0200
Message-Id: <20220704102845.168438-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add support for the USB device controller available on
the Microchip LAN966x SOCs (LAN9662 and LAN9668).

Both SOCs have the same controller and this controller is also the
same as the one present on the SAMAD3 SOC.

Regards,
Herve

Changes v2:
- Avoid wildcards in the DT compatible string
- Rename the DT node

Changes v3:
- Add Krzysztof's 'Acked-by' on patch 2/3
- Change node insertion point (sort nodes by base addresses) on patch 3/3

Changes v4:
- rebase on top of v5.19-rc1

Changes v5:
- Rename dts node to avoid the following DTC warnings (make W=1 dtbs):
    ...
    DTC     arch/arm/boot/dts/lan966x-pcb8291.dtb
    arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
    /soc/usb@e0808000: simple-bus unit address format error, expected "200000"
    ...

Herve Codina (3):
  clk: lan966x: Fix the lan966x clock gate register address
  dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
  ARM: dts: lan966x: Add UDPHS support

 Documentation/devicetree/bindings/usb/atmel-usb.txt |  3 +++
 arch/arm/boot/dts/lan966x.dtsi                      | 11 +++++++++++
 drivers/clk/clk-lan966x.c                           |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.35.3

