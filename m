Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF09509049
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381726AbiDTTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381607AbiDTTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:22:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C9BC92;
        Wed, 20 Apr 2022 12:19:37 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4473922249;
        Wed, 20 Apr 2022 21:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650482375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N4XTCPgNqIDAPYf52P20Kkeakdn4wFzbcBmqF8mhHHE=;
        b=dNMAmBaJio1vD+L4LGHsouTco8j1zjT4tsB1yT6nQsCsf3ZC5YsXpcE7JDuswlKmojtwtw
        z1k23A+FbjjOhgXRv2dlG9wnjdfsoQ/wvsr6jpehLVKKbD6U9ZcBKQLkp3Esi+6tTNvMR9
        HRgEns8AMQ85sEJrLPE4K8CIFYV9XdA=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/2] pinctrl: ocelot: add shared reset
Date:   Wed, 20 Apr 2022 21:19:24 +0200
Message-Id: <20220420191926.3411830-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On LAN966x SoCs, there is an internal reset which is used to reset the
switch core. But this will also reset the GPIO and the SGPIO. Thus add
support for this shared reset line.

changes since v2:
 - use dev_err_probe(), thanks Horatiu

changes since v1:
 - rebased onto linus' devel tree, former patch was still based on
   v1 of the YAML conversion patch

Michael Walle (2):
  dt-bindings: pinctrl: ocelot: add reset property
  pinctrl: ocelot: add optional shared reset

 .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml  | 8 ++++++++
 drivers/pinctrl/pinctrl-ocelot.c                          | 8 ++++++++
 2 files changed, 16 insertions(+)

-- 
2.30.2

