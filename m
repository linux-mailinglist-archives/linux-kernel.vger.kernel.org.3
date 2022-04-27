Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B8510DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356585AbiD0BF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356556AbiD0BFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:05:49 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575845780;
        Tue, 26 Apr 2022 18:02:38 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 933D91B3;
        Tue, 26 Apr 2022 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651021357;
        bh=EeIK9PTg8rt6iLK9xsWDK8s27aTwF2TDPocS/GpHidw=;
        h=From:To:Cc:Subject:Date:From;
        b=RP4ihxzhTiLuLRHmFcRKfLNc6MiWABggR5EhKClQ/AQCg03BS53P/B1CwLuDOMKEY
         TKypMdoURE7BoEDEBJppH1ifp9cuskSnYxwsLPiim97InbREi16MIw5+GXEqfl3OGO
         ZniQuLPOupww1kEarHX+QuthS/MBu/4lEDqnIir0=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] hwmon: (nct6775) Convert to regmap, add i2c support
Date:   Tue, 26 Apr 2022 18:01:47 -0700
Message-Id: <20220427010154.29749-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v4 of my effort to add i2c support to the nct6775 hwmon
driver.

Changes since v3 [0]:
 - Reverted to dedicated DT binding file, added
   nuvoton,tsi-channel-mask property and support for it to the i2c
   driver
 - Reverted file names to the ones in v2 [Guenter]
 - Added patch 5 converting S_I* permissions macros to octal [Guenter]
 - R-B tags from Joel on patches 2-4
 - Tiny comment-formatting tweak to appease checkpatch on patch 6

Changes since v2 [1]:
 - Fixed wrong parenthesization in nct6775_write_value()
 - Moved DT binding to trivial-devices.yml instead of a dedicated file
   [Guenter]
 - Renamed drivers and Kconfig symbols to keep existing platform
   driver as "nct6775" (SENSORS_NCT6775) and the core module as
   "nct6775-core" (SENSORS_NCT6775_CORE) [Guenter]
 - Fixed SENSORS_NCT6775_CORE Kconfig to select REGMAP, removed
   erroneous REGMAP_I2C selection from SENSORS_NCT6775_I2C [Guenter]

Changes since v1 [2]:
 - Added preparatory patch converting driver to regmap API [Guenter]
 - Replaced ENOSPC with ENOBUFS and removed WARN_ON() in
   nct6775_add_attr_group() [Guenter]
 - Added dedicated symbol namespace [Guenter]
 - Removed nct6775_write_temp() and nct6775_update_device() symbol
   exports [Guenter]
 - Reordered patches to put dt-bindings patch first [Krzysztof]

[0] https://lore.kernel.org/openbmc/20220426071848.11619-1-zev@bewilderbeest.net/
[1] https://lore.kernel.org/linux-hwmon/20220309005047.5107-1-zev@bewilderbeest.net/
[2] https://lore.kernel.org/linux-hwmon/20220226133047.6226-1-zev@bewilderbeest.net/

A slightly edited version of the previous cover letter follows:


This patch series augments the existing nct6775 driver with support
for the hardware's i2c interface; along the way it converts the driver
to use the regmap API, and splits the LPC-specific platform driver
into a separate module from the interface-independent core.

Thus far the nct6775 driver has only supported the LPC interface,
which is the main interface by which the Super-I/O chip is typically
connected to the host (x86) processor.

However, these chips also provide an i2c interface, which can provide
a way for a BMC to also monitor sensor readings from them.  On some
systems (such as the ASRock Rack ROMED8HM3 and X570-D4U) this may be
the only way for the BMC to monitor host CPU temperatures (e.g. to
indirectly access a TSI interface); this functionality is thus an
important component of enabling OpenBMC to support such systems.

In such an arrangement the Super-I/O chip is simultaneously controlled
by two independent processors (the host and the BMC) which typically
do not coordinate their accesses with each other.  In order to avoid
conflicts between the two, the i2c driver avoids all writes to the
device, since the BMC's needs with the hardware are merely that it be
able to retrieve sensor readings.  This allows the host processor to
remain ultimately in control of the chip and unaware of the BMC's use
of it at all.

The sole exception to the "no writes" rule for the i2c driver is for
the bank-select register -- while I haven't been able to find any
explicit statement in the Nuvoton datasheets guaranteeing this,
testing via manual register accesses (as detailed in [3]) has
indicated that, as one might hope, the i2c interface has its own
bank-select register independent of the one used by the LPC interface.

In terms of code structure, the approach taken in this series is to
first convert the driver's register accesses to the regmap API, and
then split the LPC-specific parts of it out into a separate module
(retaining the current "nct6775" name), leaving the
interface-independent parts in a generic driver (called nct6775-core).
The nct6775-i2c driver is then added as an additional consumer of the
nct6775-core module's functionality (essentially just providing its
own set of regmap read/write callback functions).

The first patch adds the chips supported by the nct6775 driver to
Documentation/device-tree-bindings/trivial-devices.yml.  The second
patch contains the change to convert all register accesses to use a
regmap.  The third and fourth patches make some relatively small
infrastructural changes to the driver, and the fifth cleans up a bunch
of checkpatch complaints prior to the main split patch.  The
core/platform driver split is in the sixth patch, and the final patch
adds the i2c driver itself.

The nct6775 and nct6775-i2c drivers have both been tested on the
NCT6779D in an ASRock ROMED8HM3 system and the NCT6798 [4] in an
ASRock X570-D4U (the latter thanks to Renze, CCed); both seem to work
as expected on both systems.  I don't have access to any asuswmi
hardware, so testing of the nct6775-platform driver on that to ensure
it doesn't break there would be appreciated (Oleksandr, perhaps?).


Thanks,
Zev

[3] https://lore.kernel.org/linux-hwmon/YhttzgDtGpcTniyw@hatter.bewilderbeest.net/
[4] Though it's physically labeled (mislabeled?) as an NCT6796, for
    what that's worth.

Zev Weiss (7):
  dt-bindings: hwmon: Add nuvoton,nct6775
  hwmon: (nct6775) Convert register access to regmap API
  hwmon: (nct6775) Rearrange attr-group initialization
  hwmon: (nct6775) Add read-only mode
  hwmon: (nct6775) Convert S_I* permissions macros to octal
  hwmon: (nct6775) Split core and platform driver
  hwmon: (nct6775) Add i2c driver

 .../bindings/hwmon/nuvoton,nct6775.yaml       |   56 +
 MAINTAINERS                                   |   12 +-
 drivers/hwmon/Kconfig                         |   31 +-
 drivers/hwmon/Makefile                        |    3 +
 drivers/hwmon/{nct6775.c => nct6775-core.c}   | 2445 +++++------------
 drivers/hwmon/nct6775-i2c.c                   |  195 ++
 drivers/hwmon/nct6775-platform.c              | 1226 +++++++++
 drivers/hwmon/nct6775.h                       |  252 ++
 8 files changed, 2455 insertions(+), 1765 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 rename drivers/hwmon/{nct6775.c => nct6775-core.c} (66%)
 create mode 100644 drivers/hwmon/nct6775-i2c.c
 create mode 100644 drivers/hwmon/nct6775-platform.c
 create mode 100644 drivers/hwmon/nct6775.h

-- 
2.36.0

