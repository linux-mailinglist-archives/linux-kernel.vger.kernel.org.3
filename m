Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58E4896D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiAJK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:58:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbiAJK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:58:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D15F621127;
        Mon, 10 Jan 2022 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641812282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nBHGZKrvzpx27LUU5EbRQT8a0DqomXiI3hKsTWEbZ5Y=;
        b=jD+SUF7CH8cX8gSrmXD+d0chcnVdNr0stZHr/LXSHokDm6xQE87epsb1f9biDxBP3b6s27
        XjXMnBiPw0a42+etsAiUo/nW1mStRCTjIqHdpzU1UQvY9WJ5Of1IBRYTP3bxPKOEW07Kry
        Pg8NQZwjFUafbMr/XwlnwXZrpPmwWAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641812282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nBHGZKrvzpx27LUU5EbRQT8a0DqomXiI3hKsTWEbZ5Y=;
        b=mIV0lo/NlwmbfOap/8Mp0qHVBXwui0xETxwGVQ0Ivyo8NdJWQRuBSLHJuhFxUfURwWtEka
        8wSAlRfJzxkrI4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA1CD13A98;
        Mon, 10 Jan 2022 10:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q+EzLDoR3GGlXwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:58:02 +0000
Date:   Mon, 10 Jan 2022 11:58:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/mm for v5.17
Message-ID: <YdwRQtklg28Rlwnf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the set of x86/mm changes for 5.17.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_v5.17_rc1

for you to fetch changes up to b64dfcde1ca9cb82e38e573753f0c0db8fb841c2:

  x86/mm: Prevent early boot triple-faults with instrumentation (2021-12-22 11:51:20 +0100)

----------------------------------------------------------------
- Flush *all* mappings from the TLB after switching to the trampoline
pagetable to prevent any stale entries' presence

- Flush global mappings from the TLB, in addition to the CR3-write,
after switching off of the trampoline_pgd during boot to clear the
identity mappings

- Prevent instrumentation issues resulting from the above changes

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mm: Prevent early boot triple-faults with instrumentation

Ingo Molnar (1):
      x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>

Joerg Roedel (3):
      x86/realmode: Add comment for Global bit usage in trampoline_pgd
      x86/mm/64: Flush global TLB on boot and AP bringup
      x86/mm: Flush global TLB when switching to trampoline page-table

Sebastian Andrzej Siewior (1):
      x86/mm: Include spinlock_t definition in pgtable.

 arch/x86/include/asm/page_64.h  |  1 +
 arch/x86/include/asm/pgtable.h  |  1 +
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/include/asm/tlbflush.h |  5 +++++
 arch/x86/kernel/cpu/common.c    |  2 +-
 arch/x86/kernel/head64.c        | 14 ++++++++++++++
 arch/x86/kernel/head_64.S       | 19 ++++++++++++++++++-
 arch/x86/kernel/reboot.c        | 12 ++----------
 arch/x86/mm/init.c              |  5 +++++
 arch/x86/mm/tlb.c               |  8 ++------
 arch/x86/realmode/init.c        | 26 ++++++++++++++++++++++++++
 11 files changed, 76 insertions(+), 18 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
