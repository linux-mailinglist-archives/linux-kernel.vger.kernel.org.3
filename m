Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1022347DF45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbhLWHBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:01:52 -0500
Received: from ni.piap.pl ([195.187.100.5]:44392 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242432AbhLWHBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:01:51 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 02:01:50 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 345C0C3F3EF5;
        Thu, 23 Dec 2021 07:54:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 345C0C3F3EF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1640242474; bh=QsH3ALB18JLQWaw2qwSMArNv7YYytOGVjTzrHnBVUbg=;
        h=From:To:Cc:Subject:Date:From;
        b=Y+G54OCu5+Pp1KPo+OjHnxjgx13kdrHOyLfuahhL10pDK4yLF1wa/cE4QtONU381C
         H+cWBN3Nzo3xNOPDyHOyIpox1ufdCk2fJEo0eFHQNzv2J4RLRz6ywdHKGa8jx4ZQvN
         TzRhynprxDUeNbM15VHlPbZW1auLkIiPFWoTj2LY=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v6 0/2] On Semi AR0521 sensor driver
Sender: khalasa@piap.pl
Date:   Thu, 23 Dec 2021 07:54:33 +0100
Message-ID: <m3ee63hkuu.fsf@t19.piap.pl>
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

This is the 6th version of my On Semi AR0521 sensor driver.

The documentation patch (1/2) hasn't been changed from v4:

 onnn,ar0521.yaml |  112
 1 file changed, 112 insertions(+)

The actual driver (2/2) changes:

 MAINTAINERS                |    7
 drivers/media/i2c/Kconfig  |   13
 drivers/media/i2c/Makefile |    1
 drivers/media/i2c/ar0521.c | 1051
 4 files changed, 1072 insertions(+)

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

- a lot of smaller changes suggested by Laurent, Sakari, Jacopo and
  possibly others.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
