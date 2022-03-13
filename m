Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D34D7683
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiCMPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiCMPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:47:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16E27DA8C;
        Sun, 13 Mar 2022 08:46:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CAF7922238;
        Sun, 13 Mar 2022 16:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647186407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qr92Pc8f/RQIdb/jQELsOvKeAwDBP677Kf4wYZGCxVo=;
        b=QCgjEFenp5SXsc1n3zjS+T7Np6AzPSFSZHn5rrOU7ccyPW5lJPcPI2z10pmJvKeWzWukFb
        +NVsUZFVP0HTBCQ0Q8kiYGH2Loc8ja13OnD17bnZSW2XFjjWeJrWH/IBh0jVtKfXAJ/P2q
        ysQ0fmzj5F/npfnHK3AOZwoqb+xyioI=
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
Subject: [PATCH RFC v1 0/2] pinctrl: ocelot: add shared reset
Date:   Sun, 13 Mar 2022 16:46:38 +0100
Message-Id: <20220313154640.63813-1-michael@walle.cc>
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

On LAN966x SoCs, there is an internal reset which is used to reset the
switch core. But this will also reset the GPIO and the SGPIO. Thus add
support for this shared reset line.

Marked as RFC because it depends on
https://lore.kernel.org/linux-devicetree/20220313152924.61931-1-michael@walle.cc/

Michael Walle (2):
  dt-bindings: pinctrl: ocelot: add reset property
  pinctrl: ocelot: add optional shared reset

 .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 8 ++++++++
 drivers/pinctrl/pinctrl-ocelot.c                         | 9 +++++++++
 2 files changed, 17 insertions(+)

-- 
2.30.2

