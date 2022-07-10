Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24D56CFB5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGJPVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGJPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:21:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F3A46F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C0FB80955
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 15:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC25CC3411E;
        Sun, 10 Jul 2022 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657466491;
        bh=cFR4r+OUsNc5EddjcX3rp0pvn2lEkDokCA1fWCgPZ2Q=;
        h=Date:From:To:Cc:Subject:From;
        b=VAHuxJSOoRnSmkT9iWZdZom9RZ7uM1F9MstnhVkm9jmW7rhtKzNJlmq38FJbJqsdF
         9LnqYKpTxQY8ee+jRlqZGiV6OPBOh+wcJzgRimaYoPfS8FJhnX1K3/lw157TCGIOm8
         CXfGNuemln6TNLPWNFxqn+1sAzn9CI08a2qxcbno=
Date:   Sun, 10 Jul 2022 17:21:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes 5.19-rc6
Message-ID: <YsrueF8EfYIOyCk/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc6

for you to fetch changes up to 2cd37c2e72449a7add6da1183d20a6247d6db111:

  misc: rtsx_usb: set return value in rsp_buf alloc err path (2022-07-02 16:20:56 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.19-rc6

Here are 4 small char/misc driver fixes for 5.19-rc6 to resolve some
reported issues.  They only affect 2 drivers:
	- rtsx_usb: fix for of-reported DMA warning error, the driver
	  was handling memory buffers in odd ways, it has now been fixed
	  up to be much simpler and correct by Shuah.
	- at25 eeprom driver bugfix for reported problem

All of these have been in linux-next for a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      eeprom: at25: Rework buggy read splitting

Shuah Khan (3):
      misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
      misc: rtsx_usb: use separate command and response buffers
      misc: rtsx_usb: set return value in rsp_buf alloc err path

 drivers/misc/cardreader/rtsx_usb.c | 27 +++++++++++++++++++--------
 drivers/misc/eeprom/at25.c         | 26 ++++++++++++--------------
 include/linux/rtsx_usb.h           |  2 --
 3 files changed, 31 insertions(+), 24 deletions(-)
