Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76E4A7CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348529AbiBCAZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239246AbiBCAZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643847943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9ZQYqdbCEdIW0rdKYmSkTNvVSn6qBN3RtXQqCV8wMvU=;
        b=dps7btC5soRI7xF9mQGEQq3w6NzcAOjzuOxQckBLB3iZ4BHO29a2l9raLoseP6iMgnItbe
        e5DN5QRRUu3Vk7qH+gOvApYRqVPw4DfLg0qRm62IAFhEa17XYpbYRU3f3rl9O6Njn/E2vj
        heszXzRd+52rpZ2g5xUGhp6myfH5HXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-Vqa5I9KnO1G2j8vtwQWFGg-1; Wed, 02 Feb 2022 19:25:40 -0500
X-MC-Unique: Vqa5I9KnO1G2j8vtwQWFGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85C81054F97;
        Thu,  3 Feb 2022 00:25:38 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4454EC7F;
        Thu,  3 Feb 2022 00:25:27 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com
Subject: [PATCH 0/6] Raspberry Pi Sense HAT driver
Date:   Wed,  2 Feb 2022 19:25:15 -0500
Message-Id: <20220203002521.162878-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a set of drivers for operating the Sense HAT
peripheral device. This board is an add on for the Raspberry Pi that is
designed to connect using the GPIO connector and communicate via I2C.

It features:
	- a joystick
	- an 8x8 RGB LED matrix display
	- a whole bunch of environmental sensors with their own drivers
	  (those are already in upstream Linux)

This is a refactor of the work of Serge Schneider, the author of a
version of this driver that is currently in the Raspberry Pi downstream
kernel. We modified his code to make it suitable for upstream Linux.

A couple of tests are available for the driver in the test folder in
this repo: https://github.com/underground-software/sensehat.git
	- sensehat_joystick_test logs the input events from the
	  joystick to the console
	- sensehat_display_test displays various solid colors on
	  the LED panel.
	- full_sensehat_test displays a single lit cell that can be
	  moved with the joystick. Pressing the joystick ends the
	  program.

For more information about the Sense HAT, visit:
https://www.raspberrypi.org/products/sense-hat/

Improvements since v5:
	- The sensehat core driver has been removed and its functionality
	  is now performed by simply adding the sensehat compatible string
	  to the simple_mfd_i2c driver.
	- the subdrivers now read information about their SMB registers and
	  irqs from their own device tree meaning that these values are now
	  configurable and no longer hard coded into the driver.
	- As a result of removing the core driver and making each subdriver
	  handle its own internal data itself, the drivers have finally become
	  completely independent and so now it is finally truly possible to
	  use more than one sensehat or more than one of its sub components
	  in theory. (though in practice this would require modifying the
	  firmware on the board).

Fixes since v5:
	- the joystick has been changed to use BTN_DPAD and BTN_SELECT
	  instead of the arrow keys and enter, and lots of small issues
	  with the joystick code have been fixed (thanks to Dmitry
	  Torokhov for these suggestions)
	- all forward declarations have been removed from the driver
	  (thanks to Miguel Ojeda and Stefan Wahren for this suggestion)
	- the userspace interface of the display driver has been changed to
	  remove the need to process and copy the data as much before it can
	  be sent to the device. (thanks to Matthias Brugger for this
	  suggestion)
	- fixed issue with interrupt parent property in device tree binding
	  (thanks to Rob Herring for this suggestion)

charliemirabile (6):
  drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
  drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick
    driver
  drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
  dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
  MAINTAINERS: Add sensehat driver authors to MAINTAINERS
  DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

 .../raspberrypi,sensehat-display.yaml         |  32 +++
 .../input/raspberrypi,sensehat-joystick.yaml  |  37 +++
 .../bindings/mfd/raspberrypi,sensehat.yaml    |  68 +++++
 MAINTAINERS                                   |  12 +
 drivers/auxdisplay/Kconfig                    |   8 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 264 ++++++++++++++++++
 drivers/input/joystick/Kconfig                |  11 +
 drivers/input/joystick/Makefile               |   1 +
 drivers/input/joystick/sensehat-joystick.c    | 128 +++++++++
 drivers/mfd/simple-mfd-i2c.c                  |   1 +
 include/uapi/linux/sensehat.h                 |  28 ++
 sensehat.dtbs                                 |  56 ++++
 13 files changed, 647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 include/uapi/linux/sensehat.h
 create mode 100644 sensehat.dtbs

-- 
2.31.1

