Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D568F470CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbhLJWPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:15:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhLJWPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639174286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xC4saXAsIYDXDAYM+rJuOIGLvQ/uru54qjORVmamxO4=;
        b=Iwq5O/5jeHsRNQ1qBcSu+Ug+ecveqJXoP2V//W2+mgP3qPiytYa0gYZZ9Y1mIudjTH03tl
        jzBg63iOuECsxEYpiyj+OdxhJZZoWUGeJl5Hqsn3rAzcisEmQ3zgGvzl1oSluLzKwCAEab
        5DOlWRFnK+kRxhuNDszXE0TAIuu8Ci8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-DAQ6Un3pM5y4e24g7eOd_Q-1; Fri, 10 Dec 2021 17:11:23 -0500
X-MC-Unique: DAQ6Un3pM5y4e24g7eOd_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C0310168C0;
        Fri, 10 Dec 2021 22:11:21 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 761E5694DE;
        Fri, 10 Dec 2021 22:11:07 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V5 0/6] Raspberry Pi Sense HAT driver
Date:   Fri, 10 Dec 2021 17:10:27 -0500
Message-Id: <20211210221033.912430-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a set of drivers for operating the Sense HAT
peripheral device. This board is an add on for the Raspberry Pi that is
designed to connect using the GPIO connector via I2C.

It features:
	- a joystick
	- an 8x8 RGB LED matrix display
	- a whole bunch of environmental sensors with their own drivers
	  (those are already in upstream Linux)

This is a refactor of the work of Serge Schneider, the author of a
version of this driver that is currently in the Raspberry Pi downstream
kernel. We modified his code to make it suitable for upstream Linux.

A couple of tests are available for the driver in this repo:
https://github.com/underground-software/sensehat/tree/master/tests
	- color_test displays various solid colors on the LED panel
	- framebuffer_test displays a single lit cell that is
	  controllable via the arrow keys or the joystick

For more information about the Sense HAT, visit:
https://www.raspberrypi.org/products/sense-hat/

Issues fixed since v4:
	- Removed the regmap readable/writeable register functions
	  because they necessitated putting lots of internal details
	  in the header. Moved those details back into .c files
	  (Thanks to Matthias Brugger for the suggestion).
	- Added ifdef blocks to only attempt to register the children
	  devices the user wants according to kconfig (Thanks to
	  Thomas Weißschuh for the suggestion).
	- Corrected kconfig dependencies for joystick and display
	  so that they now also depend on i2c being enabled
	  (Thanks to Randy Dunlap for the suggestion).
	- Simplified the control flow in display ioctl (Thanks to
	  Matthias Brugger for the suggestion).
	- Signed off on the patch sets correctly with co-developed-by
	  (Thanks to Miguel Ojeda for the correction).

Improvements since v4:
	- Removed fallback compatible string from downstream overlay
	  and having dropped support for it, wrote a new overlay and
	  binding that uses the interrupt and interrupt-parent
	  properties as opposed to a downstream hack, thus simplifying
	  the registration logic for joystick (Thanks to Rob Herring
	  for the suggestion).

Suggestions from v4 not addressed yet:
	- Use mfd_cells for the joystick and display platform devices
	  (as suggested by Matthias Brugger) or remove sensehat-core.c
	  entirely and use simple-mfd-i2c instead (as suggested by
	  Nicolás Sáenz Julienne).
	  	- while these suggestions might make great improvements
	  	  for a version two of the driver they would require a
	  	  large rewrite to move all of the complexity in core
	  	  elsewhere. While certainly possible and something
	  	  we want to iterate on and achieve eventually, we
	  	  think saving it for down the road makes sense at this
	  	  time.
	- Modify the userspace interface of the display driver so it
	  matches the internal representation used by the uC on the
	  other end of the wire to try and eliminate the overhead of
	  reformatting it.
	  	- The format is still compatible with the downstream
	  	  version of this driver meaning that porting existing
	  	  applications for the sensehat to work with this driver
	  	  is currently trivial. Changing this interface would make
	  	  it less so. Although certainly not impossible, it is a
	  	  downside to be considered.
	  	- The "complexity" of unpacking the bit packed the data
	  	  is a current cost, but it has the added benefit of
	  	  automatically restricting the values to 0-31. New
	  	  logic would need to be added to clamp or wrap out of
	  	  bounds values that might be just as expensive.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Charles Mirabile (6):
  drivers/mfd: sensehat: Raspberry Pi Sense HAT core driver
  drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick
    driver
  drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
  dt-bindings: mfd: sensehat: Raspberry Pi Sense HAT schema
  MAINTAINERS: Add sensehat driver authors to MAINTAINERS
  DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

 .../bindings/mfd/raspberrypi,sensehat.yaml    |  54 ++++
 MAINTAINERS                                   |  11 +
 drivers/auxdisplay/Kconfig                    |   8 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 268 ++++++++++++++++++
 drivers/input/joystick/Kconfig                |   8 +
 drivers/input/joystick/Makefile               |   1 +
 drivers/input/joystick/sensehat-joystick.c    | 119 ++++++++
 drivers/mfd/Kconfig                           |   8 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/sensehat-core.c                   | 157 ++++++++++
 include/linux/mfd/sensehat.h                  |  51 ++++
 sensehat.dtbs                                 |  44 +++
 13 files changed, 731 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 drivers/mfd/sensehat-core.c
 create mode 100644 include/linux/mfd/sensehat.h
 create mode 100644 sensehat.dtbs

-- 
2.31.1

