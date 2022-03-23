Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421684E4F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiCWJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiCWJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:20:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949174DC5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B98FCE1F58
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979FAC340E8;
        Wed, 23 Mar 2022 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648027122;
        bh=/wCR7uCIhqQMFawjAZEiDwsQ9sNq4HlFijF33c6lPdE=;
        h=Date:From:To:cc:Subject:From;
        b=IZQcbS6zhOFZvahSngKGSCFxGf0I+lvP1TlZ+BBjz1O4J9KKWA71jeLbotwyW/m0S
         lgNOuV3gB/UrupQ3vct9gaaUg/QIaIBILuX3/JXGPR9jfCKfB1teaUeim0NkCLbhg+
         m0Euaesdlz49Gl85GzRz8AWsgrH8wGFdXhuFIX5sEns1sHBM/xJMyokfsp4Piszo5N
         dGJRVXpMxxk9pRBaiOGKYYkwr20C+3yfkeBdD6QV3vJtGdlRn7PIaN6v7hpOYTsW3T
         m3ip8fW2pYuvNgRO+tOWo6iRrwqigYJ6svkwJ0yjR3zJyLEHXeSLIdMcCHMhZRYzTe
         Tm3ISCtrV6siQ==
Date:   Wed, 23 Mar 2022 10:18:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.18
Message-ID: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem updates for 5.18 merge widnow. Highlights:

=====
- rework of generic input handling which ultimately makes the processing 
  of tablet events more generic and reliable (Benjamin Tissoires)
- fixes for handling unnumbered reports fully correctly in i2c-hid (Angela 
  Czubak, Dmitry Torokhov)
- untangling of intermingled code for sending and handling output 
  reports in i2c-hid (Dmitry Torokhov)
- Apple magic keyboard support improvements for newer models (José Expósito)
- Apple T2 Macs support improvements (Aun-Ali Zaidi, Paul Pawlowski)
- driver for Razer Blackwidow keyboards (Jelle van der Waa)
- driver for SiGma Micro keyboards (Desmond Lim)
- integration of first part of DIGImend patches in order to 
  ultimately vastly improve Linux support of tablets (Nikolai Kondrashov, 
  José Expósito)
=====

Thanks.

----------------------------------------------------------------
Aditya Garg (1):
      HID: apple: Add fn mapping for MacBook Pros with Touch Bar

Angela Czubak (1):
      HID: i2c-hid: fix handling numbered reports with IDs of 15 and above

Aun-Ali Zaidi (1):
      HID: apple: Add necessary IDs and configuration for T2 Macs.

Benjamin Tissoires (12):
      HID: core: statically allocate read buffers
      HID: core: de-duplicate some code in hid_input_field()
      HID: core: split data fetching from processing in hid_input_field()
      HID: input: tag touchscreens as such if the physical is not there
      HID: input: rework spaghetti code with switch statements
      HID: input: move up out-of-range processing of input values
      HID: compute an ordered list of input fields to process
      HID: core: for input reports, process the usages by priority list
      HID: input: enforce Invert usage to be processed before InRange
      HID: input: remove the need for HID_QUIRK_INVERT
      HID: input: accommodate priorities for slotted devices
      Input: docs: add more details on the use of BTN_TOOL

Christophe JAILLET (1):
      HID: amd_sfh: Remove useless DMA-32 fallback configuration

Desmond Lim (1):
      HID: add SiGma Micro driver

Dmitry Torokhov (11):
      HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports
      HID: i2c-hid: use "struct i2c_hid" as argument in most calls
      HID: i2c-hid: refactor reset command
      HID: i2c-hid: explicitly code setting and sending reports
      HID: i2c-hid: define i2c_hid_read_register() and use it
      HID: i2c-hid: create a helper for SET_POWER command
      HID: i2c-hid: convert i2c_hid_execute_reset() to use i2c_hid_xfer()
      HID: i2c-hid: rework i2c_hid_get_report() to use i2c_hid_xfer()
      HID: i2c-hid: use helpers to do endian conversion in i2c_hid_get_input()
      HID: i2c-hid: no longer need raw access to HID descriptor structure
      HID: i2c-hid: note that I2C xfer buffers are DMA-safe

Gustavo A. R. Silva (1):
      HID: google: Use struct_size() helper in kzalloc()

Gwendal Grignou (1):
      HID: intel-ish-hid: Use dma_alloc_coherent for firmware update

Jelle van der Waa (1):
      HID: Add driver for Razer Blackwidow keyboards

Jiri Kosina (1):
      HID: apple: properly reflect LEDS dependency

José Expósito (5):
      HID: apple: Refactor key translation setup
      HID: apple: Magic Keyboard first generation FN key mapping
      HID: apple: Magic Keyboard 2015 FN key mapping
      HID: apple: Report Magic Keyboard 2021 battery over USB
      HID: apple: Report Magic Keyboard 2021 with fingerprint reader battery over USB

Nikolai Kondrashov (16):
      HID: uclogic: Support Huion tilt reporting
      HID: uclogic: Rename Huion HS64 PID to Huion Tablet 2
      HID: uclogic: Support Huion 13th frame button
      HID: uclogic: Split pen and frame raw event handling
      HID: uclogic: Access pen/frame params directly in raw_event handling
      HID: uclogic: Skip non-input raw events earlier
      HID: uclogic: Handle virtual frame reports
      HID: uclogic: Remove pen usage masking
      HID: uclogic: Replace pen_frame_flag with subreport_list
      HID: uclogic: Switch to matching subreport bytes
      HID: uclogic: Specify total report size to buttonpad macro
      HID: uclogic: Use different constants for frame report IDs
      HID: uclogic: Use "frame" instead of "buttonpad"
      HID: uclogic: Put version first in rdesc namespace
      HID: uclogic: Define report IDs before their descriptors
      HID: uclogic: Support multiple frame input devices

Paul Pawlowski (1):
      HID: apple: Add support for keyboard backlight on certain T2 Macs.

Yang Li (1):
      HID: i2c-hid: remove unneeded semicolon

 Documentation/input/event-codes.rst         |   6 +-
 drivers/hid/Kconfig                         |  19 +++
 drivers/hid/Makefile                        |   2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c      |   7 +-
 drivers/hid/hid-apple.c                     | 305 +++++++++++++++++++++++++++++++----
 drivers/hid/hid-core.c                      | 280 ++++++++++++++++++++++++++++----
 drivers/hid/hid-google-hammer.c             |   2 +-
 drivers/hid/hid-ids.h                       |  14 +-
 drivers/hid/hid-input.c                     | 364 ++++++++++++++++++++++++++++++++++--------
 drivers/hid/hid-quirks.c                    |  16 ++
 drivers/hid/hid-razer.c                     | 125 +++++++++++++++
 drivers/hid/hid-sigmamicro.c                | 130 +++++++++++++++
 drivers/hid/hid-uclogic-core.c              | 258 ++++++++++++++++++------------
 drivers/hid/hid-uclogic-params.c            | 198 +++++++++++------------
 drivers/hid/hid-uclogic-params.h            |  92 ++++++-----
 drivers/hid/hid-uclogic-rdesc.c             |  69 ++++----
 drivers/hid/hid-uclogic-rdesc.h             |  38 ++---
 drivers/hid/i2c-hid/i2c-hid-core.c          | 591 ++++++++++++++++++++++++++++++++++++--------------------------------
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c |  29 +---
 include/linux/hid.h                         |  23 ++-
 20 files changed, 1827 insertions(+), 741 deletions(-)
 create mode 100644 drivers/hid/hid-razer.c
 create mode 100644 drivers/hid/hid-sigmamicro.c


-- 
Jiri Kosina
SUSE Labs

