Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95C1527817
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiEOO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiEOO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:27:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A92A277;
        Sun, 15 May 2022 07:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E4FEB80D08;
        Sun, 15 May 2022 14:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77B9C385B8;
        Sun, 15 May 2022 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652624842;
        bh=jxfW/B8+kAu8FgXHxdJgKY55YrIJ9MHmfV08h5wnndg=;
        h=Date:From:To:Cc:Subject:From;
        b=ahzaef+u+qCJLBoizgWyYHAbbArgT0kWT65aEnKpH5SZai2LlVhE8ypU+Ei/dYuCj
         0eFYPPvW+5bYOb2AR/u22TjD0RS5ivy1HOSBekuklNDWBs+zdXV+rXOc4BwnJScsVV
         Tu2XO7yRApmlD9SF/cdYgnffhkRlDTq4FlidVkEY=
Date:   Sun, 15 May 2022 16:27:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.18-rc7
Message-ID: <YoENxyxFu4xUQD6b@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc7

for you to fetch changes up to 401fb66a355eb0f22096cf26864324f8e63c7d78:

  fsl_lpuart: Don't enable interrupts too early (2022-05-05 23:00:21 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.18-rc7

Here are some small tty n_gsm and serial driver fixes for 5.18-rc7 that
resolve reported problems.  They include:
	- n_gsm fixes for reported issues
	- 8250_mtk driver fixes for some platforms
	- fsl_lpuart driver fix for reported problem.
	- digicolor driver fix for reported problem.

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
AngeloGioacchino Del Regno (3):
      serial: 8250_mtk: Fix UART_EFR register address
      serial: 8250_mtk: Make sure to select the right FEATURE_SEL
      serial: 8250_mtk: Fix register address for XON/XOFF character

Daniel Starke (3):
      tty: n_gsm: fix buffer over-read in gsm_dlci_data()
      tty: n_gsm: fix mux activation issues in gsm_config()
      tty: n_gsm: fix invalid gsmtty_write_room() result

Indan Zupancic (1):
      fsl_lpuart: Don't enable interrupts too early

Yang Yingliang (1):
      tty/serial: digicolor: fix possible null-ptr-deref in digicolor_uart_probe()

 drivers/tty/n_gsm.c                  | 20 ++++++++++++--------
 drivers/tty/serial/8250/8250_mtk.c   | 29 ++++++++++++++++++++---------
 drivers/tty/serial/digicolor-usart.c |  5 ++---
 drivers/tty/serial/fsl_lpuart.c      | 18 +++++++++---------
 4 files changed, 43 insertions(+), 29 deletions(-)
