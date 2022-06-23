Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915785588C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiFWT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiFWT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:28:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898038C7E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D915B822BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FA3C341C7;
        Thu, 23 Jun 2022 18:56:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N+t2hT05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656010585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m8IGjXi+OafdxBoHhxfAF344yqZtECufo9TiVXLnZWw=;
        b=N+t2hT0565x5dv1NAiKhxbVchvgOmlJvT9QKww4m9mC1u2lexF8z5PQRIG8+Jf/uH2CIRC
        V2mEwVmnptmFriHBt/7IOnbBWJgh7IRh2L2l3TqN+yO5HqBj09e7XeY1yDwCJr9nm8KTfb
        BOfhD44AjkUvIt7Sejhdy2DvtAiL+Bg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0c863fe7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 23 Jun 2022 18:56:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.19-rc4
Date:   Thu, 23 Jun 2022 20:54:46 +0200
Message-Id: <20220623185446.1351600-1-Jason@zx2c4.com>
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

Please pull the following random number generator fixes for 5.19-rc4:

- A change to schedule the interrupt randomness mixing less often, yet credit
  a little more each time, to reduce overhead during interrupt storms.

- Squelch an undesired pr_warn() from __ratelimit(), which was causing
  problems in the reporters' CI.

- A trivial comment fix.

Thanks,
Jason


The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc4-for-linus

for you to fetch changes up to 63b8ea5e4f1a87dea4d3114293fc8e96a8f193d7:

  random: update comment from copy_to_user() -> copy_to_iter() (2022-06-20 11:06:17 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 5.19-rc4.
----------------------------------------------------------------

Jason A. Donenfeld (3):
      random: schedule mix_interrupt_randomness() less often
      random: quiet urandom warning ratelimit suppression message
      random: update comment from copy_to_user() -> copy_to_iter()

 drivers/char/random.c           |  6 +++---
 include/linux/ratelimit_types.h | 12 ++++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)
