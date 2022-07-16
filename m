Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60C9576C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiGPGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPGYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:24:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA31166;
        Fri, 15 Jul 2022 23:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1054AB82F59;
        Sat, 16 Jul 2022 06:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED4EC34114;
        Sat, 16 Jul 2022 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657952639;
        bh=frL6siHTa6fUVExEQbZVmGTfG0v/tIpGTzGGqskWCYw=;
        h=Date:From:To:Cc:Subject:From;
        b=Rg3c867podKrznMOMMlTIT4O+xOF4VjJuhl9Nl9PkaX43bTN9CsJnd1LSEm71e8Jf
         9xL/caoqrOhSi0wDOa8IMmYiQDXkO7Cu/A/oVSZ9mObJHljekOXZdr+o/bOYEv977p
         wxBIPTZ0Qb/I1gsc/w+4uVrm2YLYT5RkQOeKkzBk=
Date:   Sat, 16 Jul 2022 08:23:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.19-rc7
Message-ID: <YtJZegRfm6IsdY/i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc7

for you to fetch changes up to a501ab75e7624d133a5a3c7ec010687c8b961d23:

  tty: use new tty_insert_flip_string_and_push_buffer() in pty_write() (2022-07-08 15:16:28 +0200)

----------------------------------------------------------------
TTY / Serial driver fixes for 5.19-rc7

Here are some TTY and Serial driver fixes for 5.19-rc7.  They resolve a
number of reported problems including:
	- long time bug in pty_write() that has been reported in the
	  past.
	- 8250 driver fixes
	- new serial device ids
	- vt overlapping data copy bugfix
	- other tiny serial driver bugfixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Biju Das (1):
      serial: 8250: dw: Fix the macro RZN1_UART_xDMACR_8_WORD_BURST

Chanho Park (1):
      tty: serial: samsung_tty: set dma burst_size to 1

Ilpo Järvinen (4):
      serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
      serial: 8250: Fix __stop_tx() & DMA Tx restart races
      serial: stm32: Clear prev values before setting RTS delays
      serial: 8250: Fix PM usage_count for console handover

Jiri Slaby (2):
      tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
      tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()

Marcin Wojtas (1):
      serial: 8250: dw: enable using pdata with ACPI

Max Staudt (1):
      tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver

Pali Rohár (1):
      serial: mvebu-uart: correctly report configured baudrate value

Yangxi Xiang (1):
      vt: fix memory overlapping when deleting chars in the buffer

Yi Yang (1):
      serial: 8250: fix return error code in serial8250_request_std_resource()

 drivers/tty/pty.c                   | 14 ++---------
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_dma.c  |  6 ++---
 drivers/tty/serial/8250/8250_dw.c   | 26 ++++++++++-----------
 drivers/tty/serial/8250/8250_port.c |  6 +++--
 drivers/tty/serial/amba-pl011.c     | 23 +++++++++++++++++--
 drivers/tty/serial/mvebu-uart.c     | 25 ++++++++++----------
 drivers/tty/serial/samsung_tty.c    |  5 ++--
 drivers/tty/serial/serial_core.c    |  5 ----
 drivers/tty/serial/stm32-usart.c    |  2 ++
 drivers/tty/tty.h                   |  3 +++
 drivers/tty/tty_buffer.c            | 46 +++++++++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c                 |  2 +-
 include/linux/serial_core.h         |  5 ++++
 include/uapi/linux/tty.h            |  3 ++-
 15 files changed, 116 insertions(+), 59 deletions(-)
