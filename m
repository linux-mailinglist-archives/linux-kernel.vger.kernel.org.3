Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66424A9F60
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbiBDSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348470AbiBDSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:43:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F4C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14A1D61B8D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5D8C004E1;
        Fri,  4 Feb 2022 18:43:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oLtI2kzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644000194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iavG/6YX0OnRoBXRJgreGNa2RBdmSXEeKgyIv3qSIgs=;
        b=oLtI2kzVZm+h1+BdNesVIkAcWWwHfn9PHiFT8eYCFZyum1qpSsv2gxV5BMLADP81XtkDBF
        32vO/bgJTc47cZwkDKySz+MBvurkXZaPqUhWGhA1KNyfNL2Mjzm1DDk8fW4NoagG3VA5v3
        Z2dS5FV4UURO+CqX9gHh48munUrVxoU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 711a7e14 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 18:43:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.17-rc3
Date:   Fri,  4 Feb 2022 19:42:42 +0100
Message-Id: <20220204184242.106531-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please pull the following fixes for 5.17-rc3. There are a few other patches in
my tree that fix an age old crypto ~vuln, but I think I'll give those a few
more days to stew on the list before submitting. So expect to hear from me
about that next week. For this week, we have:

1) A fix to make more frequent use of hwgenerator randomness, from Dominik.

2) More cleanups to the boot initialization sequence, from Dominik.

3) A fix for an old shortcoming with the ZAP ioctl, from me.

4) A workaround for a still unfixed Clang CFI/FullLTO compiler bug, from me.
   On one hand, it's a bummer to commit workarounds for experimental compiler
   features that have bugs. But on the other, I think this actually improves
   the code somewhat, independent of the bug. So a win-win.

Thanks,
Jason

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.17-rc3-for-linus

for you to fetch changes up to 9d5505f1eebeca778074a0260ed077fd85f8792c:

  random: only call crng_finalize_init() for primary_crng (2022-02-04 19:22:32 +0100)

----------------------------------------------------------------
Dominik Brodowski (3):
      random: continually use hwgenerator randomness
      random: access primary_pool directly rather than through pointer
      random: only call crng_finalize_init() for primary_crng

Jason A. Donenfeld (2):
      lib/crypto: blake2s: avoid indirect calls to compression function for Clang CFI
      random: wake up /dev/random writers after zap

 arch/arm/crypto/blake2s-shash.c   |  4 ++--
 arch/x86/crypto/blake2s-shash.c   |  4 ++--
 crypto/blake2s_generic.c          |  4 ++--
 drivers/char/random.c             | 39 +++++++++++++++++++++-----------------
 include/crypto/internal/blake2s.h | 40 ++++++++++++++++++++++++---------------
 lib/crypto/blake2s.c              |  4 ++--
 6 files changed, 55 insertions(+), 40 deletions(-)
