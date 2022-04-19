Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76468507B41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357373AbiDSUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiDSUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3833EF2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650401557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=imCp+JsaIm/bSieIDD/PHFkvB8BPNj7+q9MVdr3ZbWA=;
        b=TXdlIzfD+t6TMte8Qrp6iZ6doMpKkKAFUTFxhWPLKM6rYhDZ5xeXPhh2T/mZ7u7U9Auvri
        0ezUEqCVMfvp7dyC6wKwjCNOfD9LHyqT7wi7x6fU3N4Ex83Yjq6Xpr9NJfaESsGHu9bueA
        ZtWUcb6CbHvLF/LbpeFtnHtYZlVEGvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-4TqlOTCVP0-wXw59DWzblg-1; Tue, 19 Apr 2022 16:52:33 -0400
X-MC-Unique: 4TqlOTCVP0-wXw59DWzblg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2046B1097B17;
        Tue, 19 Apr 2022 20:52:18 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88DB82166B1B;
        Tue, 19 Apr 2022 20:52:11 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Date:   Tue, 19 Apr 2022 16:51:52 -0400
Message-Id: <20220419205158.28088-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v8:
	- Fixed a few small things in the device tree bindings.
	I forgot to include the fact that Rob Herring had already
	reviewed them when I posted v8, so Krzysztof Kozlowski
	jumped in and offered his input. The suggestions were good
	so we decided to include them. Sorry for the confusion.
	- Corrected a typo in the description of the display driver.
	The format of the special file used by the driver was changed
	in v8 and this was described in the cover letter of the patch,
	but not in the actual note attached to that patch. This is now
	fixed.

Co-developed-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Daniel Bauman <dbauman@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>

Charles Mirabile (6):
  drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
  drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick
    driver
  drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
  dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
  MAINTAINERS: Add sensehat driver authors to MAINTAINERS
  DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

 .../raspberrypi,sensehat-display.yaml         |  27 +++
 .../input/raspberrypi,sensehat-joystick.yaml  |  32 +++
 .../bindings/mfd/raspberrypi,sensehat.yaml    |  58 +++++
 MAINTAINERS                                   |  11 +
 drivers/auxdisplay/Kconfig                    |   8 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 205 ++++++++++++++++++
 drivers/input/joystick/Kconfig                |  11 +
 drivers/input/joystick/Makefile               |   1 +
 drivers/input/joystick/sensehat-joystick.c    | 137 ++++++++++++
 drivers/mfd/simple-mfd-i2c.c                  |   1 +
 sensehat.dtbs                                 |  52 +++++
 12 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 sensehat.dtbs

-- 
2.31.1

