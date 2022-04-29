Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E2514E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbiD2PDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377404AbiD2PDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:03:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01174C44C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 42F79CE3328
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A48AC385A4;
        Fri, 29 Apr 2022 14:59:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KVyVqPbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651244388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iKlno7VBe2fPIENTdl1+MrvfLtH93gm20I7RGPxqKUs=;
        b=KVyVqPbvSuXdAz4Zx0UuPzSEwTLOi7WMfPytfEnW1CJvQ/4Wi4dVqR0yJ6aajKX62By6G2
        DnzqBIWZrdt9LgEme5BSy9gUUoUmp1xZ1MsyzyUGKVSXdYOzD+V02yAMtQPf4nGA3/8vqR
        SB1wuY72bvfSu64ThqDLWkd1L/8NvrI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ababb638 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 29 Apr 2022 14:59:48 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.18-rc5
Date:   Fri, 29 Apr 2022 16:59:35 +0200
Message-Id: <20220429145935.2549453-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following two sets of fixes for 5.18-rc5:

- Eric noticed that the memmove() in crng_fast_key_erasure() was bogus, so
  this has been changed to a memcpy() and the confusing situation clarified
  with a detailed comment.

- [Half]SipHash documentation updates from Bagas and Eric, after Eric pointed
  out that the use of HalfSipHash in random.c made a bit of the text
  potentially misleading.

That's it since the push I sent you in rc3 -- really very small -- so
hopefully things are done for 5.18.

Thanks,
Jason


The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc5-for-linus

for you to fetch changes up to 5a7e470e460fb90657343d843732325e53bb875f:

  Documentation: siphash: disambiguate HalfSipHash algorithm from hsiphash functions (2022-04-25 17:26:40 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 5.18-rc5.
----------------------------------------------------------------

Bagas Sanjaya (2):
      Documentation: siphash: convert danger note to warning for HalfSipHash
      Documentation: siphash: enclose HalfSipHash usage example in the literal block

Eric Biggers (1):
      Documentation: siphash: disambiguate HalfSipHash algorithm from hsiphash functions

Jason A. Donenfeld (1):
      random: document crng_fast_key_erasure() destination possibility

 Documentation/security/siphash.rst | 46 +++++++++++++++++++++++---------------
 drivers/char/random.c              |  9 +++++++-
 2 files changed, 36 insertions(+), 19 deletions(-)
