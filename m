Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4E507D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358397AbiDSXGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiDSXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:06:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204C24F38;
        Tue, 19 Apr 2022 16:03:32 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D10752223A;
        Wed, 20 Apr 2022 01:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650409410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kQ7hnJaJfKvnMgrnfler+apWCnJJMlM5yxAVFM7iqEg=;
        b=k2kNybmfivvQcZ0q52dAMH5r58qdKjly7kUJjWUSo1aYLyam/xi+o+POemwx8uONIR8nB7
        235ucs7IjjrVQgrBqVLZwzkiPLbuV78zNQp0Qg1qT9Dk2ZQve/psECVGnNrgdE2Rln8vas
        0hfQvHoAK6oC9yHDx3hy5n8YyBAWAh4=
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
Subject: [PATCH v2 0/2] pinctrl: ocelot: add shared reset
Date:   Wed, 20 Apr 2022 01:03:22 +0200
Message-Id: <20220419230324.3221779-1-michael@walle.cc>
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

changes since v1:
 - rebased onto linus' devel tree, former patch was still based on
   v1 of the YAML conversion patch

Michael Walle (2):
  dt-bindings: pinctrl: ocelot: add reset property
  pinctrl: ocelot: add optional shared reset

 .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 8 ++++++++
 drivers/pinctrl/pinctrl-ocelot.c                         | 9 +++++++++
 2 files changed, 17 insertions(+)

-- 
2.30.2

