Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1B492B83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiARQte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:49:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50674 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiARQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:49:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA05B8159B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B50C340E0;
        Tue, 18 Jan 2022 16:49:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MePl9iYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642524568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D57DudwSqXwMHBPnWuXkPiCXPHFdtonW45twGTCs/kI=;
        b=MePl9iYXyzyMzt2R7q6uKoLQZGfBggT0/0wxeIC5QIkoQIsL2KJ+o6do5/nuHGFDjNkFUu
        yglMO2kW/HugiDIywXOp1HwdctV2L7auOXV6KI/VGZyUI3klul5xSH9Nh03P8MTCVTfKrr
        IojST5fBiaw1zXfUAzTiNTipkRE7mpk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 954df8b7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 18 Jan 2022 16:49:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [GIT PULL] random number generator fixes for 5.17-rc1
Date:   Tue, 18 Jan 2022 17:49:06 +0100
Message-Id: <20220118164906.402468-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following fixes, intended for 5.17-rc1:

1) Some Kconfig changes resulted in BIG_KEYS being unselectable, which Justin
   sent a patch to fix.

2) Geert pointed out that moving to BLAKE2s bloated vmlinux on little
   machines, like m68k, so we now compensate for this.

3) Numerous style and house cleaning fixes, meant to have a cleaner base for
   future changes.

Thanks,
Jason

The following changes since commit fe81ba137ebcc7f236780996a0b375732c07e85c:

  Merge tag 'ata-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata (2022-01-18 10:14:49 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-rc1-for-linus

for you to fetch changes up to a254a0e4093fce8c832414a83940736067eed515:

  random: simplify arithmetic function flow in account() (2022-01-18 13:03:56 +0100)

----------------------------------------------------------------
Jason A. Donenfeld (14):
      lib/crypto: blake2s: move hmac construction into wireguard
      lib/crypto: sha1: re-roll loops to reduce code size
      random: cleanup poolinfo abstraction
      random: cleanup integer types
      random: remove incomplete last_data logic
      random: remove unused extract_entropy() reserved argument
      random: rather than entropy_store abstraction, use global
      random: remove unused OUTPUT_POOL constants
      random: de-duplicate INPUT_POOL constants
      random: prepend remaining pool constants with POOL_
      random: cleanup fractional entropy shift constants
      random: access input_pool_data directly rather than through pointer
      random: selectively clang-format where it makes sense
      random: simplify arithmetic function flow in account()

Justin M. Forbes (1):
      lib/crypto: add prompts back to crypto libraries

Schspa Shi (1):
      random: fix typo in comments

 crypto/Kconfig                |   2 -
 drivers/char/random.c         | 627 ++++++++++++++++++------------------------
 drivers/net/wireguard/noise.c |  45 ++-
 include/crypto/blake2s.h      |   3 -
 include/trace/events/random.h |  56 ++--
 lib/Kconfig                   |   2 +
 lib/crypto/Kconfig            |  17 +-
 lib/crypto/blake2s-selftest.c |  31 ---
 lib/crypto/blake2s.c          |  37 ---
 lib/sha1.c                    |  95 +------
 10 files changed, 352 insertions(+), 563 deletions(-)
