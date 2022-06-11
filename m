Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78673547628
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiFKPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D405B3D5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C5A61133
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 15:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A9DC3411B;
        Sat, 11 Jun 2022 15:36:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BBCK2Ueh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654961795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e75fwoVrRuGhp3YiS0HYmNv/4VqYGaRyfSU9HaRISQc=;
        b=BBCK2UehCB9TjOqfXshwAZdcmlzcx15SPC8gRCvGORWgx5JzsFMXqDrGhc6+Ns9fdxf0Wm
        gPmksc6gu8U/DX2JQGomO0KAK7OzxduRM+fesDZBzgimWckS3fYIkfHDQs9A8a5KHYjPJ4
        vKzYKk5MyYhA120Fh5vL+1/3ARY/I20=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dc19a339 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 11 Jun 2022 15:36:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.19-rc2
Date:   Sat, 11 Jun 2022 17:36:11 +0200
Message-Id: <20220611153611.828415-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following random number generator fixes for 5.19-rc2:

- A fix for a 5.19 regression for a case in which early device tree
  initializes the RNG, which flips a static branch. On most plaforms, jump
  labels aren't initialized until much later, so this caused splats. On a few
  mailing list threads, we cooked up easy fixes for arm64, arm32, and risc-v.
  But then things looked slightly more involved for xtensa, powerpc, arc, and
  mips. And at that point, when we're patching 7 architectures in a place
  before the console is even available, it seems like the cost/risk just
  wasn't worth it. So random.c works around it now by checking the already
  exported `static_key_initialized` boolean, as though somebody already ran
  into this issue in the past. I'm not super jazzed about that; it'd be
  prettier to not have to complicate downstream code. But I suppose it's
  practical.

- A few small code nits and adding a missing __init annotation.

- A change to the default config values to use the cpu and bootloader's seeds
  for initializing the RNG earlier. This brings them into line with what all
  the distros do (Fedora/RHEL, Debian, Ubuntu, Gentoo, Arch, NixOS, Alpine,
  SUSE, and Void... at least), and moreover will now give us test coverage in
  various test beds that might have caught the above device tree bug earlier.

- A change to WireGuard CI's configuration to increase test coverage around
  the RNG.

- A documentation comment fix to unrelated maintainerless CRC code that I was
  asked to take, I guess because it has to do with polynomials (which the RNG
  thankfully no longer uses).

Thanks,
Jason

The following changes since commit e71e60cd74df9386c3f684c54888f2367050b831:

  Merge tag 'dma-mapping-5.19-2022-06-06' of git://git.infradead.org/users/hch/dma-mapping (2022-06-06 17:56:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc2-for-linus

for you to fetch changes up to 17b0128a136d43e5f8f268631f48bc267373ebff:

  wireguard: selftests: use maximum cpu features and allow rng seeding (2022-06-11 15:38:08 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 5.19-rc2.
----------------------------------------------------------------

Jason A. Donenfeld (7):
      random: avoid checking crng_ready() twice in random_init()
      random: mark bootloader randomness code as __init
      random: account for arch randomness in bits
      random: do not use jump labels before they are initialized
      random: credit cpu and bootloader seeds by default
      random: remove rng_has_arch_random()
      wireguard: selftests: use maximum cpu features and allow rng seeding

Roger Knecht (1):
      crc-itu-t: fix typo in CRC ITU-T polynomial comment

 drivers/char/Kconfig                               | 50 ++++++++++++++--------
 drivers/char/random.c                              | 39 ++++++++---------
 include/linux/crc-itu-t.h                          |  2 +-
 include/linux/random.h                             |  3 +-
 lib/crc-itu-t.c                                    |  2 +-
 lib/vsprintf.c                                     |  3 +-
 tools/testing/selftests/wireguard/qemu/Makefile    | 28 ++++++------
 tools/testing/selftests/wireguard/qemu/init.c      |  3 ++
 .../testing/selftests/wireguard/qemu/kernel.config |  3 ++
 9 files changed, 71 insertions(+), 62 deletions(-)
