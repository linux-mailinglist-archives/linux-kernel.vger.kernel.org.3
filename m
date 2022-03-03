Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1468D4CC422
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiCCRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCCRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDD841A06D4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nWuChtuorkbR8bi2fuEBkhXKG6YncunWUr1sjejPCEc=;
        b=G3dGv6UhN8Ny0YLGI7RVrLcjc8CnJhYFtTmJ53OWYou7mYJW9iVBiVQOIVuvzaSyaj0ulx
        dOAW3Zkkxk0UzpAysiRrMGcm+e1TTSxDp6XzTlRfMVFLq0vQl9vrOHnALpWo4QAcWhpxLP
        SkgdOXT7BOcC0FS0TtLUtWQ2xgBUoCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-tkaHtBEGMXOsRfyuDc2Iiw-1; Thu, 03 Mar 2022 12:39:40 -0500
X-MC-Unique: tkaHtBEGMXOsRfyuDc2Iiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 001181006AA6;
        Thu,  3 Mar 2022 17:39:39 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB329804F7;
        Thu,  3 Mar 2022 17:39:14 +0000 (UTC)
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
Subject: [PATCH v7 0/6] Raspberry Pi Sense HAT driver
Date:   Thu,  3 Mar 2022 12:39:29 -0500
Message-Id: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a set of drivers for operating the Sense HAT
peripheral device. This board is an add on for the Raspberry Pi that is
designed to connect using the GPIO connector and communicates via I2C.

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

Changes since v6:
	- we store the regmap for the sensehat inside the child structs
	  so that we don't need to look it up every time in the functions
	  that want to use it. Thanks to Nicolás Sáenz for the suggestion.
	- Changed userspace layout of the display driver to rgb565 triples
	  and removed the gamma table lookup and the associated ioctl. If
	  the user wants to recreate linear brightness scaling, they can
	  use a lookup table on their end. Doing this also removes a lot
	  of error checking and general code complexity, so I think removing
	  this feature is actually for the better.
	- Replaced if statement with call to `min_t` function in display
	  read and write functions.
	- Replaced the custom llseek implementation with a call to
	  `fixed_size_llseek`. Thanks to Miguel Ojeda for all of these
	  great suggestions.
	- Fixed issues with the yaml device tree bindings we missed last
	  time due to not having yamllint installed. Thanks for Rob Herring
	  (well his bot on his behalf :^)) for this suggestion.

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
 .../input/raspberrypi,sensehat-joystick.yaml  |  33 +++
 .../bindings/mfd/raspberrypi,sensehat.yaml    |  69 +++++++
 MAINTAINERS                                   |  11 +
 drivers/auxdisplay/Kconfig                    |   8 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 188 ++++++++++++++++++
 drivers/input/joystick/Kconfig                |  11 +
 drivers/input/joystick/Makefile               |   1 +
 drivers/input/joystick/sensehat-joystick.c    | 128 ++++++++++++
 drivers/mfd/simple-mfd-i2c.c                  |   1 +
 sensehat.dtbs                                 |  54 +++++
 12 files changed, 532 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 sensehat.dtbs

-- 
2.31.1

