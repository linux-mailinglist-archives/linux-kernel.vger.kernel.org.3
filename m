Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AF4C868C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiCAIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCAIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:34:17 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425526563;
        Tue,  1 Mar 2022 00:33:32 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id D87BCC3F3EED;
        Tue,  1 Mar 2022 09:33:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D87BCC3F3EED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646123610; bh=Yn6AMwzcGivxG7Dr5hi4SZZsXegUo67bapb/bDHeORQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cE+kuV+ABmyQhePYpefvkHpL8GCIH6KWo3YMmLQxeDTw21E/LDf8g5/2s7G+grzR6
         QkKoafqtUv1Gytn7t4DsJylscR3JmEpKQSpEEC8qBLbJX2zp8B+YhuHjLw91KuOjw+
         bBUdYhb2tphJftXcaivyBa/sArD6YbkF+aeCDR4M=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>, Joe Perches <joe@perches.com>
Subject: [PATCH v8 0/2] On Semi AR0521 sensor driver
Sender: khalasa@piap.pl
Date:   Tue, 01 Mar 2022 09:33:29 +0100
Message-ID: <m3pmn66pie.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, Mauro, media subsystem reviewers,

This is the 8th version of my On Semi AR0521 sensor driver.
Is there anything here that should be changed in order to get it merged?
Perhaps it should be added to the staging area instead?


The documentation patch (1/2) hasn't been changed from v4:

 onnn,ar0521.yaml |  112
 1 file changed, 112 insertions(+)

The actual driver (2/2) stats:
 MAINTAINERS                |    7
 drivers/media/i2c/Kconfig  |   13
 drivers/media/i2c/Makefile |    1
 drivers/media/i2c/ar0521.c | 1059
 4 files changed, 1080 insertions

v8:
- dropped the remaining debugs
- added pm_runtime_idle() call
- a couple of cosmetic changes

v7:
- removed AR0521_NUM_SUPPLIES macro: ARRAY_SIZE(ar0521_supply_names)
  is now used directly.

- fixed ar0521_power_off() return type, reported-by: kernel test robot
  <lkp@intel.com> (apparently can't add this tag for the whole patch).

- moved pm_runtime_get_if_in_use()/pm_runtime_put() up the stack.
  The old way was causing problems when used in sensor power_on(),
  before initial pm_runtime setup.

- clearer REGS() macro

v6:
- I reformatted the code to fit in 80 columns. Nobody should be asked to
  make his code worse (and the 80-column version IS worse), and multiple
  high-profile Linux developers (including the top one) appear to share
  my opinion, but nevertheless - if it's something that will make it go
  in, I won't care.

- Basically the same applies to the // comments.

- I have removed the "interval" support (frames per second).
  Unfortunately this cripples the driver further a bit - the userspace
  will not be able to set precise frame timings needed for broadcast
  quality video. I will have to keep a private patch for that.
  Another effect of this change is that the pixel clock is now fixed at
  184 MHz, which by default produces ca. 30 FPS at 2560x1920. This may
  be problematic on systems with less than 4 MIPI lanes, and/or on ones
  which can't support higher frequency MIPI bus (the previous version
  used a calculated clock). Perhaps it will be possible to fix this
  issue in the future, with a couple of core V4L2 changes.

- the driver now provides the .pre_streamon() for setting LP-11 state on
  MIPI data and clock lanes. This is compatible with i.MX6 receiver.

- s_power() converted to SET_RUNTIME_PM_OPS().

- the "initial" I2C registers have been all converted to a table of
  multi-register files, to minimize time spent on I2C bus.

And a lot of smaller changes suggested by Laurent, Sakari, Jacopo, Joe
and possibly others.

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
