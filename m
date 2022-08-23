Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711359EC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiHWTRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiHWTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAAB9DFBE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661277241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TXflbSC5tHD7xm5BV+GID2rnjcVpFjBzb3khdAvZHwc=;
        b=aiSrApeVQRCV5afz+g2eaiXn+QH3I5rT82b7tIizf7wUMVMlxBk3eWf1okCmWfn7do6yyf
        lhj5Hj3REQb9Zl/PlzSQtn1jd2WbIn0wCizPVmStF1GzlVruqzDZXhUx5oK+iiTCN8AKGl
        Lib90lH1i7Kgcre5O8EVImlapgKSG7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-abMaWBBLNqWjaziZRWeopw-1; Tue, 23 Aug 2022 13:42:34 -0400
X-MC-Unique: abMaWBBLNqWjaziZRWeopw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89A8E8032F1;
        Tue, 23 Aug 2022 17:42:33 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.33.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE6CB14152E0;
        Tue, 23 Aug 2022 17:42:32 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Date:   Tue, 23 Aug 2022 13:41:53 -0400
Message-Id: <20220823174158.45579-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since v9:
	- The driver for the sensehat joystick was accepted upstream so
	  it is no longer included in this patchset.
	- Some of the people involved in the development of earlier
	  versions of these patches are no longer involved in the project
	  so they have been removed from the list of maintainers and the
	  patches.
	- The code is completely unchanged and so based on the discussions
	  from version 9 of the patches, it should be ready to be merged.

My appologies for the long delay between v9 and v10 especially given the
fact that there are no changes to the code. We appreciate the maintainers'
patience and guidance throughout all 10 versions of this sensehat patchset,
and we are excited for this driver to hopefully be fully accepted.

Best - Charlie

Co-developed-by: Joel Slebodnick <jslebodn@redhat.com>
Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>

Charles Mirabile (5):
  drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
  drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
  dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
  MAINTAINERS: Add sensehat driver authors to MAINTAINERS
  DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

 .../raspberrypi,sensehat-display.yaml         |  26 +++
 .../input/raspberrypi,sensehat-joystick.yaml  |  31 +++
 .../bindings/mfd/raspberrypi,sensehat.yaml    |  57 +++++
 MAINTAINERS                                   |  10 +
 drivers/auxdisplay/Kconfig                    |   8 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 205 ++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                  |   1 +
 sensehat.dtbs                                 |  52 +++++
 9 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
 create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 sensehat.dtbs

-- 
2.31.1

