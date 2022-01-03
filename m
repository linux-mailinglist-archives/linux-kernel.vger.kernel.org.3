Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF529483164
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiACN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:29:56 -0500
Received: from ni.piap.pl ([195.187.100.5]:39880 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbiACN3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:29:55 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 558A6C3F3EF3;
        Mon,  3 Jan 2022 14:29:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 558A6C3F3EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1641216590; bh=mfyAdXWtmPvCapwW6ECM4ZOcBgpyLK52Q0plxKcKvnE=;
        h=From:To:Cc:Subject:Date:From;
        b=MzhBhW+1EiUOLPTs3G4054CEkn8Ck8na9bkyopM7OMBtNagdIeI3xyGCOgDAuTWHw
         OqCoOPt+FwuDyULEFVKUcwlsaNbnvwJa4W/tDRJnoOzpVB93mYlHcGzGG5vXTw5EeR
         miCrGOQXvggKbS3fW+aPccdp8oAEo1V06TqlMKOg=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>, Joe Perches <joe@perches.com>
Subject: [PATCH v7 0/2] On Semi AR0521 sensor driver
Sender: khalasa@piap.pl
Date:   Mon, 03 Jan 2022 14:29:50 +0100
Message-ID: <m3czl9eylt.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, Mauro, media subsystem reviewers,

This is the 7th version of my On Semi AR0521 sensor driver.
Is there anything here that should be changed in order to get it merged?



The documentation patch (1/2) hasn't been changed from v4:

 onnn,ar0521.yaml |  112
 1 file changed, 112 insertions(+)

The actual driver (2/2) stats:

 MAINTAINERS                |    7
 drivers/media/i2c/Kconfig  |   13
 drivers/media/i2c/Makefile |    1
 drivers/media/i2c/ar0521.c | 1093
 4 files changed, 1114 insertions

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
