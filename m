Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917304ADBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379089AbiBHPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiBHPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:07:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57CEC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE779CE1A7D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A754C340F7;
        Tue,  8 Feb 2022 15:06:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KrCbqWJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644332814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dWd1BpP+gWy6YldHbtkFbasD6YjFmn1T1mSDW8zn5Wg=;
        b=KrCbqWJ2TIaDff3RPR1pQWOAUnlMm+6KaJ3ReXt3N4832t9hg/TwPafDLydddalxNBumju
        XotfWayNDW+SZkw6E2Wyn9sxg7ot2GX6nb1OGk/PRJqmrGdo+Z4/vBDZ3VCg1O1iXrLtSk
        ZagDtInLzkHwzSqhqm7NeWqUh50Bkb8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f56589a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:06:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.17-rc4
Date:   Tue,  8 Feb 2022 16:06:25 +0100
Message-Id: <20220208150625.374191-1-Jason@zx2c4.com>
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

Please pull the following fixes for 5.17-rc4. This week's pull contains fixes
for the crypto ~vuln I mentioned last week. There are extensive details about
it and some simple PoC code in the commit message of the first patch if you're
curious.

Code-wise, the change is both insubstantial and substantial. It is
insubstantial in that we're talking about removing over 400 lines of old code,
many of which are outdated comments, and replacing them with less than 90
lines, so it's not "big" on the additive side.  On the other hand, it is a
substantial change, as it's doing away with the heart of our entropy collector
that we've had in one form or another forever. It would seem fitting with the
times that we're able to replace gobs of old stuff from the 90s with a boring
cryptographic hash function.

Given that these fixes are for a security issue (albeit a probably relatively
low grade one), sending this mid-cycle feels like the "responsible" thing to
do, and 5.17 will resultantly have a more secure RNG. However, I also would
understand that, diffstat not withstanding, you think this is a bit much and
want to reject this pull until 5.18. Either way works for me, though I
naturally lean heavily toward the former, hence making this pull request in
the first place.

Thanks,
Jason


The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.17-rc4-for-linus

for you to fetch changes up to 966038a49e2b31ff9aa86862295be3915c51dbdd:

  random: make credit_entropy_bits() always safe (2022-02-08 11:53:05 +0100)

----------------------------------------------------------------
Jason A. Donenfeld (5):
      random: use computational hash for entropy extraction
      random: simplify entropy debiting
      random: use linear min-entropy accumulation crediting
      random: always wake up entropy writers after extraction
      random: make credit_entropy_bits() always safe

 drivers/char/random.c         | 499 +++++++-----------------------------------
 include/trace/events/random.h |  30 +--
 2 files changed, 86 insertions(+), 443 deletions(-)
