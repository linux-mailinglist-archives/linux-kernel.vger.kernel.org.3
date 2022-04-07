Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF74F4F8084
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiDGNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiDGNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:31:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB31DEA99
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F367CB82550
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F1C385A4;
        Thu,  7 Apr 2022 13:29:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="epcuhlWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649338150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qObuXHClc+i9mHKRfOaWzpAGmVZkXnc9biUP3z0QmFk=;
        b=epcuhlWYuLtFZ2+2Rm1AIyRmkzs1qbto7CxYO23vdxq8sU5SptnbwNba/x95AeexQ2P8EJ
        4RThbLugPc6JUvfanlltcZ41Q2mIemiNw8Ng0VP5NM/sHwfSjdRsfFKQtmbkViJ4Xrv7OB
        MiiKOP4uQfB0nmX9vncud0eytTgMMqw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24aebd1a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 13:29:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.18-rc2
Date:   Thu,  7 Apr 2022 15:28:39 +0200
Message-Id: <20220407132839.496822-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following five fixes to the RNG for 5.18-rc2:

- Another fixup to the fast_init/crng_init split, this time in how much
  entropy is being credited, from Jan Varho.

- As discussed, we now opportunistically call try_to_generate_entropy() in
  /dev/urandom reads, as a replacement for the reverted commit. I opted to not
  do the more invasive wait_for_random_bytes() change at least for now,
  preferring to do something smaller and more obvious for the time being, but
  maybe that can be revisited as things evolve later.

- Userspace can use FUSE or userfaultfd or simply move a process to idle
  priority in order to make a read from the random device never complete,
  which breaks forward secrecy, fixed by overwriting sensitive bytes early on
  in the function.

- Jann Horn noticed that /dev/urandom reads were only checking for pending
  signals if need_resched() was true, a bug going back to the genesis commit,
  now fixed by always checking for signal_pending() and calling
  cond_resched(). This explains various noticeable signal delivery delays I've
  seen in programs over the years that do long reads from /dev/urandom.

- In order to be more like other devices (e.g. /dev/zero) and to mitigate the
  impact of fixing the above bug, which has been around forever (users have
  never really needed to check the return value of read() for medium-sized
  reads and so perhaps many didn't), we now move signal checking to the bottom
  part of the loop, and do so every PAGE_SIZE-bytes.

Thanks,
Jason

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc2-for-linus

for you to fetch changes up to e3c1c4fd9e6d14059ed93ebfe15e1c57793b1a05:

  random: check for signals every PAGE_SIZE chunk of /dev/[u]random (2022-04-07 01:36:37 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 5.18-rc2.
----------------------------------------------------------------

Jan Varho (1):
      random: do not split fast init input in add_hwgenerator_randomness()

Jann Horn (1):
      random: check for signal_pending() outside of need_resched() check

Jason A. Donenfeld (3):
      random: opportunistically initialize on /dev/urandom reads
      random: do not allow user to keep crng key around on stack
      random: check for signals every PAGE_SIZE chunk of /dev/[u]random

 drivers/char/random.c | 74 +++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)
