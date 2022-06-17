Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FA54F298
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380679AbiFQIPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380002AbiFQIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395567D36;
        Fri, 17 Jun 2022 01:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED6161FA8;
        Fri, 17 Jun 2022 08:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DEC3411B;
        Fri, 17 Jun 2022 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655453698;
        bh=BcesR8rZSyM4ByqxVA2X7+5nZ1ydk3/oB9XEIqKmikU=;
        h=Date:From:To:Cc:Subject:From;
        b=bAFIjonXE/UkzMqxJTJnxJE6DsWRB4Xp5Nwbw5hzhNo2pNPzZBhM9x2t69CRSOoo+
         CL3Vvkpu2pRFrjB32ajpgxiGlaeDiRAkuiR2byJQDpe8fhJ6fYJiIMnDcZkCfRL4Vj
         HJPn8ad5IVMPe0n6CbYTNT7Py7yuLqzBLLxhkmvo=
Date:   Fri, 17 Jun 2022 10:14:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.19-rc3
Message-ID: <Yqw4AJGmhTSfzc97@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc3

for you to fetch changes up to be03b0651ffd8bab69dfd574c6818b446c0753ce:

  serial: 8250: Store to lsr_save_flags after lsr read (2022-06-10 13:52:19 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.19-rc3

Here are some small tty and serial driver fixes for 5.19-rc3 to resolve
some reported problems:
	- 8250 lsr read bugfix
	- n_gsm line discipline allocation fix
	- qcom serial driver fix for reported lockups that happened in
	  -rc1
	- goldfish tty driver fix

All have been in linux-next for a while now with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ilpo Järvinen (1):
      serial: 8250: Store to lsr_save_flags after lsr read

Tony Lindgren (1):
      tty: n_gsm: Debug output allocation must use GFP_ATOMIC

Vijaya Krishna Nivarthi (2):
      serial: core: Introduce callback for start_rx and do stop_rx in suspend only if this callback implementation is present.
      tty: serial: qcom-geni-serial: Implement start_rx callback

Vincent Whitchurch (1):
      tty: goldfish: Fix free_irq() on remove

 drivers/tty/goldfish.c                | 2 +-
 drivers/tty/n_gsm.c                   | 2 +-
 drivers/tty/serial/8250/8250_port.c   | 2 ++
 drivers/tty/serial/qcom_geni_serial.c | 1 +
 drivers/tty/serial/serial_core.c      | 9 ++++++---
 include/linux/serial_core.h           | 1 +
 6 files changed, 12 insertions(+), 5 deletions(-)
