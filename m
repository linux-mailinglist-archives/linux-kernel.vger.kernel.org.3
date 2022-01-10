Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0144894C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbiAJJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiAJJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:10:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F08C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 393F5B811ED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0614AC36AED;
        Mon, 10 Jan 2022 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641805803;
        bh=VIqhAU2pVdEDiisoS0V5nboTuSGQjfm7ex9hbJXWznE=;
        h=Date:From:To:cc:Subject:From;
        b=hVF4oDWu4oJ+XjnM6kChFSF2fwWl1peIapz2Lvo2PCw5sNU1gGAYpYta2F77lA6R9
         Go5bRqJEq5BmlAtNYViCof7IWFmg87tdFUhEwDeJ6XCWaY8NzB0K8zbBmCm9orhRNp
         1h/PCBefIwHQ/IrewzYO86hceWWXwfcH6lB9V8XYLEMdWXk7jaSGRHb9IIqYJqkdV+
         C2eK88aPW+ONH0G7Vn24TEnb+5eKqM5z3f6YzyqaZ11o4A9Bn/t6Lagfyr009m5gJb
         ls/I9X7R6Urzmo38O+h6JCK6cr4YpGM5k4y9Z2A/gNjjWbQT/EB12TEOI0+30rfbND
         kZG/unTAQr3bw==
Date:   Mon, 10 Jan 2022 10:09:59 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID subsystem for 5.17
Message-ID: <nycvar.YFH.7.76.2201101000520.28059@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem updates for 5.17 merge window. Highligts:

=====
- support for USI style pens (Tero Kristo, Mika Westerberg)
- quirk for devices that need inverted X/Y axes (Alistair Francis)
- small core code cleanups and deduplication (Benjamin Tissoires)
- Apple Magic Keyboard support improvements (José Expósito, Alex 
  Henrie, Benjamin Berg)
- locking performance improvement for hidraw code (André Almeida)
- PM wakeup support for i2c-hid driver (Matthias Kaehlcke
- new driver to support for LetSketch device (Hans de Goede)
- proper batter reporting for hid-magicmouse USB-connected devices (José 
  Expósito)
=====

----------------------------------------------------------------
Alex Henrie (2):
      HID: apple: Add 2021 Magic Keyboard with fingerprint reader
      HID: apple: Add 2021 Magic Keyboard with number pad

Alistair Francis (2):
      HID: quirks: Allow inverting the absolute X/Y values
      HID: i2c-hid-of: Expose the touchscreen-inverted properties

André Almeida (1):
      HID: hidraw: Replace hidraw device table mutex with a rwsem

Benjamin Berg (1):
      HID: apple: Add 2021 magic keyboard FN key mapping

Benjamin Tissoires (2):
      HID: add suspend/resume helpers
      HID: do not inline some hid_hw_ functions

Christophe JAILLET (1):
      HID: magicmouse: Fix an error handling path in magicmouse_probe()

Filipe Laíns (1):
      HID: logitech: add myself as a reviewer

Hans de Goede (1):
      HID: Add new Letsketch tablet driver

José Expósito (11):
      HID: magicmouse: Report battery level over USB
      HID: apple: Do not reset quirks when the Fn key is not found
      HID: apple: Use BIT to define quirks
      HID: apple: Report Magic Keyboard battery over USB
      HID: magicmouse: set device name when it has been personalized
      HID: magicmouse: set Magic Trackpad 2021 name
      HID: apple: Add Magic Keyboard 2021 with fingerprint reader FN key mapping
      HID: hid-uclogic-params: Invalid parameter check in uclogic_params_init
      HID: hid-uclogic-params: Invalid parameter check in uclogic_params_get_str_desc
      HID: hid-uclogic-params: Invalid parameter check in uclogic_params_huion_init
      HID: hid-uclogic-params: Invalid parameter check in uclogic_params_frame_init_v1_buttonpad

Lukas Bulwahn (1):
      HID: address kernel-doc warnings

Matthias Kaehlcke (1):
      HID: i2c-hid: Report wakeup events

Mika Westerberg (4):
      HID: Add map_msc() to avoid boilerplate code
      HID: hid-input: Add suffix also for HID_DG_PEN
      HID: input: Make hidinput_find_field() static
      HID: debug: Add USI usages

Tero Kristo (1):
      HID: Add hid usages for USI style pens

Yang Li (1):
      HID: intel-ish-hid: ishtp-fw-loader: Fix a kernel-doc formatting issue

Ye Xiang (1):
      HID: intel-ish-hid: ipc: Specify no cache snooping on TGL and ADL

chiminghao (1):
      HID: thrustmaster use swap() to make code cleaner

 .../devicetree/bindings/input/hid-over-i2c.txt     |   2 +
 MAINTAINERS                                        |  13 +
 drivers/hid/Kconfig                                |  14 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-apple.c                            | 146 +++++++++-
 drivers/hid/hid-core.c                             |  93 ++++++
 drivers/hid/hid-debug.c                            |  35 +++
 drivers/hid/hid-ids.h                              |   5 +
 drivers/hid/hid-input.c                            |  26 +-
 drivers/hid/hid-letsketch.c                        | 322 +++++++++++++++++++++
 drivers/hid/hid-magicmouse.c                       | 115 +++++++-
 drivers/hid/hid-multitouch.c                       |   3 -
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hid-tmff.c                             |   8 +-
 drivers/hid/hid-uclogic-params.c                   |  31 +-
 drivers/hid/hidraw.c                               |  34 +--
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |   2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  24 +-
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c            |   2 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                   |  10 +-
 drivers/hid/i2c-hid/i2c-hid.h                      |   2 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   6 +-
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |   3 +-
 drivers/hid/surface-hid/surface_hid_core.c         |  25 +-
 drivers/hid/usbhid/hid-core.c                      |  19 +-
 include/linux/hid.h                                |  99 +++----
 26 files changed, 863 insertions(+), 178 deletions(-)
 create mode 100644 drivers/hid/hid-letsketch.c

-- 
Jiri Kosina
SUSE Labs

