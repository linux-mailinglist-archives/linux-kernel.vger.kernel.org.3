Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B118347F6C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhLZMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:39:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhLZMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:39:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90507210F5;
        Sun, 26 Dec 2021 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640522382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L6SnzlwOy04Nj28pFCvKVf47U0XVkOy/oPjs2htLF3w=;
        b=dLxn/cgoekHZQRivda9x6l8dI85OY9vaopld+9sFhX8m2uco7CqKFJxkXmJRFe50zL+RVR
        5URHwIH5IFhQ7aHeV8i1Jz9HSOpeEdV7SLjBcf+ZGpN5uc1b0SlBxSnhYudW6W1d68P5Wt
        nogAfdBxitQSBMvbyLsEKTLnBJXbliM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640522382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L6SnzlwOy04Nj28pFCvKVf47U0XVkOy/oPjs2htLF3w=;
        b=+QWx0BjfZR0CDrM4YYxCkmo9c2y3zxYzzbRQUD+9mWQPt9OScVJEmPuRvadrrexggWC4nw
        ZlEJn/siuUn67KAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A4B01330B;
        Sun, 26 Dec 2021 12:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8JeIGY5iyGFaGQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 26 Dec 2021 12:39:42 +0000
Date:   Sun, 26 Dec 2021 13:39:46 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.16-rc7
Message-ID: <YchikpZ6h1ViNUDv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple more x86/urgent fixes for 5.16.

Thx.

---

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc7

for you to fetch changes up to 57690554abe135fee81d6ac33cc94d75a7e224bb:

  x86/pkey: Fix undefined behaviour with PKRU_WD_BIT (2021-12-19 22:44:34 +0100)

----------------------------------------------------------------
- Prevent potential undefined behavior due to shifting pkey constants into the sign bit

- Move the EFI memory reservation code *after* the efi= cmdline parsing has happened

- Revert two commits which turned out to be the wrong direction to chase
when accommodating early memblock reservations consolidation and command line parameters
parsing

----------------------------------------------------------------
Andrew Cooper (1):
      x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

Borislav Petkov (2):
      Revert "x86/boot: Mark prepare_command_line() __init"
      Revert "x86/boot: Pull up cmdline preparation and early param parsing"

Mike Rapoport (1):
      x86/boot: Move EFI range reservation after cmdline parsing

 arch/x86/include/asm/pkru.h |  4 +--
 arch/x86/kernel/setup.c     | 72 +++++++++++++++++++--------------------------
 2 files changed, 32 insertions(+), 44 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
