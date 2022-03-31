Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E252E4EE353
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiCaVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiCaVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:25:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FF19143C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5836CB82246
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F31C340ED;
        Thu, 31 Mar 2022 21:24:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fB/r6qdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648761840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sALs4lZvrb9B3Tsj203n0DTCr0hil0h1xBNUFunvmHI=;
        b=fB/r6qdubxOsjWK6at1+Chk+BfWOTmY/bCBeGFelHxaippdLUTr7ZcYVveUJuLZKTF/XXB
        uASfYmy7CNkLYBME8pCMXAJXvR4OhZuoz4yXjFFrhqBG8f/USwEh5Baulirtf+3/07xIOs
        r5riDJJNjO3d2ZhVZDo7cBVjdrtsDfQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6d8289b9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 31 Mar 2022 21:24:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.18-rc1
Date:   Thu, 31 Mar 2022 17:23:52 -0400
Message-Id: <20220331212352.182168-1-Jason@zx2c4.com>
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

Please pull 5 small patches for 5.18-rc1:

- If a hardware random number generator passes a sufficiently large chunk of
  entropy to random.c during early boot, we now skip the "fast_init" business
  and let it initialize the RNG. This makes CONFIG_RANDOM_TRUST_BOOTLOADER=y
  actually useful.

- We already have the command line `random.trust_cpu=0/1` option for RDRAND,
  which let distros enable CONFIG_RANDOM_TRUST_CPU=y while placating concerns
  of more paranoid users. Now we add `random.trust_bootloader=0/1` so that
  distros can similarly enable CONFIG_RANDOM_TRUST_BOOTLOADER=y.

- Re-add a comment that got removed by accident in the recent revert.

- Add the spec-compliant ACPI CID for vmgenid, which Microsoft added to the
  vmgenid spec at Ard's request during earlier review.

- Restore build-time randomness via the latent entropy plugin, which was lost
  when we transitioned to using a hash function.

Thanks,
Jason

PS: I noticed that for my previous pull request, in your merge commit, you
replaced my numbered list with a bulleted list, and even went through the
trouble of adjusting the irregular spacing caused by numbers >9. Impressed by
this wild attention to detail, and imagining you clickity-clacking away in
uemacs, I'll stick to hyphen-bullets now.


The following changes since commit 34af78c4e616c359ed428d79fe4758a35d2c5473:

  Merge tag 'iommu-updates-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2022-03-24 19:48:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus

for you to fetch changes up to 1754abb3e7583c570666fa1e1ee5b317e88c89a0:

  random: mix build-time latent entropy into pool at init (2022-03-31 16:43:27 -0400)

----------------------------------------------------------------
Random number generator fixes for Linux 5.18-rc1.

----------------------------------------------------------------
Jason A. Donenfeld (4):
      random: skip fast_init if hwrng provides large chunk of entropy
      random: treat bootloader trust toggle the same way as cpu trust toggle
      random: re-add removed comment about get_random_{u32,u64} reseeding
      random: mix build-time latent entropy into pool at init

Michael Kelley (1):
      virt: vmgenid: recognize new CID added by Hyper-V

 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/char/Kconfig                            |  3 ++-
 drivers/char/random.c                           | 22 +++++++++++++++++-----
 drivers/virt/vmgenid.c                          |  1 +
 4 files changed, 26 insertions(+), 6 deletions(-)
