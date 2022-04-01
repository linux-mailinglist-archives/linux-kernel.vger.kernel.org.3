Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72D84EFC46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiDAVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiDAVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:42:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF210264F7E;
        Fri,  1 Apr 2022 14:40:41 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 26C4122175;
        Fri,  1 Apr 2022 23:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648849239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A4r7gbpLPTw7uIVHGZDL1psjd1Qy6q/owkzUh+0E5Lk=;
        b=loWxT5ONk/ZsI3rHaw9O20y+SGezp66XDSqu+aap4deITrN/tsZFsKhWYrVn1R+6v4tFMC
        LMVmzwTcPgpQl4JVHIsyY0P2QDbgvmlFUtnUd/0haEix9nurugvXxTuVrcyGStPHZCrsYB
        MmN3m2r66k7uuMcrNte9HwYGRpcIu5Y=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 0/4] hwmon: add lan9668 driver
Date:   Fri,  1 Apr 2022 23:40:28 +0200
Message-Id: <20220401214032.3738095-1-michael@walle.cc>
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

Add a temperature and fan controller driver for the Microchip LAN9668 SoC.

The temperature sensor uses a polynomial to calculate the actual
temperature. Fortunately, the bt1-pvt already has such a calculation.
It seems that the LAN9668 uses the same Analog Bits sensor as the
BT1 although with a different characteristic. To be able to reuse the
code move it to lib/ as it seems pretty generic to calculate any
polynomial using integers only, which might also be used by other parts
of the kernel. Another option might be to move the code to hwmon-poly.c,
I'm not sure. Thoughts?

I also plan on submitting patches to add temperature sensor support for
the GPYxxx and LAN8814 PHYs which also use polynomial_calc().

The last two patches adds the actual driver and the dt-binding for it.

changes since v3:
 - validate input frequency in lan966x_hwmon_write_pwm_freq()
 - enable sensor before registering hwmon device
 - automatically disable sensor when driver is removed
 - set the required clock devider in case someone changed the
   hardware default before the driver is loaded
 - remove extra empty lines

changes since v2:
 - strip unwanted copy pasta.. oops
 - use "select REGMAP" instead of "depends on"

changes since v1:
 - add doc string to polynomial_calc(), moved the comment
   into the function.
 - add missing "select POLYNOMIAL" to the bt1_pvt driver
   Kconfig symbol
 - add hwmon driver documentation
 - cache sys_clk rate during probe
 - add missing ERR_CAST()
 - adapted comment for the PPS->RPM calculation
 - add temporary variable in lan966x_hwmon_read_pwm_freq()

Michael Walle (4):
  lib: add generic polynomial calculation
  hwmon: (bt1-pvt) use generic polynomial functions
  dt-bindings: hwmon: add Microchip LAN966x bindings
  hwmon: add driver for the Microchip LAN966x SoC

 .../bindings/hwmon/microchip,lan966x.yaml     |  53 +++
 Documentation/hwmon/lan966x.rst               |  40 ++
 drivers/hwmon/Kconfig                         |  13 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/bt1-pvt.c                       |  50 +--
 drivers/hwmon/lan966x-hwmon.c                 | 418 ++++++++++++++++++
 include/linux/polynomial.h                    |  35 ++
 lib/Kconfig                                   |   3 +
 lib/Makefile                                  |   2 +
 lib/polynomial.c                              | 108 +++++
 10 files changed, 686 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,lan966x.yaml
 create mode 100644 Documentation/hwmon/lan966x.rst
 create mode 100644 drivers/hwmon/lan966x-hwmon.c
 create mode 100644 include/linux/polynomial.h
 create mode 100644 lib/polynomial.c

-- 
2.30.2

