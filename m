Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE04B9D75
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiBQKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:46:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiBQKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:46:25 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329529410D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:46:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 76045461;
        Thu, 17 Feb 2022 02:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645094769;
        bh=FlSQwzHbM/dm7ihzl/D1hs0n0mSNJjDHh9U0M7jfQIE=;
        h=From:To:Cc:Subject:Date:From;
        b=n5WX/GH076Iwu6gmIk+RreldVcm2JdHFvzMzZQ75ipleGhFmWoGrrPk5hr6RuKrK6
         UriL9lAVcJRIYaAG0q79ZiAqJ9DOsHolkEonu2PhUubNtLygi1qDIHSt5sHE1GDwLq
         bkd3kcs7p/pTchNHOdK09foDsUXph9gA0CBBJG80=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 0/4] misc: Add power-efuse driver
Date:   Thu, 17 Feb 2022 02:44:40 -0800
Message-Id: <20220217104444.7695-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series is another incarnation of some previous efforts [0]
at enabling userspace access to the OPERATION state (and now status
flags) of PMBus devices, specifically with respect to efuses
protecting general-purpose power outputs.  This functionality is an
important component enabling a port of OpenBMC to the Delta AHE-50DC
Open19 power shelf [1].

The first patch extends the pmbus core's regulator support with an
implementation of the .get_error_flags() operation, mapping PMBus
status flags to REGULATOR_ERROR_* flags where possible, and the second
patch adds regulator support for the lm25066 driver.  These two
patches are essentially independent of the power-efuse driver (and
each other) and could potentially be applicable individually, but are
necessary for the power-efuse driver to be useful on the AHE-50DC.

The third and fourth patches add dt-bindings and the implementation of
the power-efuse driver, respectively.  The driver is fairly simple; it
merely provides a sysfs interface to enable, disable, and retrieve
error flags from an underlying regulator.

There is one aspect of its usage of the regulator API I'm a bit
uncertain about, however: this driver seems like a case where an
exclusive 'get' of the regulator (i.e. devm_regulator_get_exclusive()
instead of devm_regulator_get() in efuse_probe()) would be
appropriate, since in the intended usage no other device should be
using an efuse's regulator.  With an exclusive get though, the
regulator's use_count and the consumer's enable_count don't balance
out properly to allow the enable/disable operations to work properly
(the former ending up one more than the latter, leading to
enable_count underflows on attempts to disable the regulator).  So at
least for now it's using a non-exclusive get -- I'd be happy to hear
any pointers on a way to allow an exclusive get to work here, though.


Thanks,
Zev

[0] https://lore.kernel.org/openbmc/YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net/
[1] https://www.open19.org/marketplace/delta-16kw-power-shelf/

Zev Weiss (4):
  hwmon: (pmbus) Add get_error_flags support to regulator ops
  hwmon: (pmbus) lm25066: Add regulator support
  dt-bindings: Add power-efuse binding
  misc: Add power-efuse driver

 .../devicetree/bindings/misc/power-efuse.yaml |  37 +++
 MAINTAINERS                                   |   5 +
 drivers/hwmon/pmbus/Kconfig                   |   7 +
 drivers/hwmon/pmbus/lm25066.c                 |  14 ++
 drivers/hwmon/pmbus/pmbus_core.c              |  97 ++++++++
 drivers/misc/Kconfig                          |  15 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/power-efuse.c                    | 221 ++++++++++++++++++
 8 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
 create mode 100644 drivers/misc/power-efuse.c

-- 
2.35.1

