Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81A5ABD9C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiICHOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiICHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:14:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9D1F2EC;
        Sat,  3 Sep 2022 00:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5019160EC8;
        Sat,  3 Sep 2022 07:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD4EC4347C;
        Sat,  3 Sep 2022 07:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662189277;
        bh=VwDCK1uX2zkbf9p3ekIB3ZLqx39dsScG8neSiyYiD8E=;
        h=Date:From:To:Cc:Subject:From;
        b=a4zrdDSSTZ++zG5djVIAfPe+4cgvAqNoYp2yg/jZze5aoC2hOm6cTqzpLTUHeQoFd
         2ZfobVseY80hB5Lj/bAJkdj8ijqQhv4nuFhgdolmMLCH7WRzZQqWzms4r5nixsh+O9
         fhS0dYHxaacoZF7JsIEWoCNG8zccyDN9L5leGKQI=
Date:   Sat, 3 Sep 2022 09:14:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.0-rc4
Message-ID: <YxL+77uOsLIXRNfd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc4

for you to fetch changes up to 902e02ea9385373ce4b142576eef41c642703955:

  tty: n_gsm: avoid call of sleeping functions from atomic context (2022-08-30 14:40:17 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.0-rc4

Here are some small tty/serial/vt driver fixes for 6.0-rc4 that resolve
a number of reported issues:
  - n_gsm fixups for previous changes that caused problems
  - much-reported serdev crash fix that showed up in 6.0-rc1
  - vt font selection bugfix
  - kerneldoc build warning fixes
  - other tiny serial core fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Fedor Pchelkin (2):
      tty: n_gsm: replace kicktimer with delayed_work
      tty: n_gsm: avoid call of sleeping functions from atomic context

Helge Deller (1):
      vt: Clear selection before changing the font

Mauro Carvalho Chehab (1):
      serial: document start_rx member at struct uart_ops

Mazin Al Haddad (1):
      tty: n_gsm: add sanity check for gsm->receive in gsm_receive_buf()

Sergiu Moga (1):
      tty: serial: atmel: Preserve previous USART mode if RS485 disabled

Shenwei Wang (1):
      serial: fsl_lpuart: RS485 RTS polariy is inverse

Sherry Sun (1):
      tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete

Tetsuo Handa (1):
      tty: n_gsm: initialize more members at gsm_alloc_mux()

Vincent Whitchurch (1):
      tty: Fix lookahead_buf crash with serdev

 drivers/tty/n_gsm.c               | 85 +++++++++++++++++----------------------
 drivers/tty/serial/atmel_serial.c |  4 +-
 drivers/tty/serial/fsl_lpuart.c   |  5 ++-
 drivers/tty/tty_buffer.c          | 14 ++++---
 drivers/tty/vt/vt.c               | 12 ++++--
 include/linux/serial_core.h       |  8 ++++
 6 files changed, 67 insertions(+), 61 deletions(-)
