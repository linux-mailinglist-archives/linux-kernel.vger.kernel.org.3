Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A457489FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiAJS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:57:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiAJS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:57:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6111721124;
        Mon, 10 Jan 2022 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641841035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xwi73Spe+sr4zgK9bhBUD3Rn36h7XCBxW+7r/jlCxTo=;
        b=08/feHhTwXfHs1c8boGRnYov2+UGS9ckQANU5EANxPHmBIElt6atj+lRYYVAfWIaj0w/7y
        5EzzgjWRn9oNQeLa2GTANIjidEBHuPRlU+dvuYVNm53g3LcA9lRr/350rV+jnOJZX1WXCw
        57p477N0ii+EuqVuA0khGfIsFX5NmYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641841035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xwi73Spe+sr4zgK9bhBUD3Rn36h7XCBxW+7r/jlCxTo=;
        b=qmUhI0EkN7kePyb3wOpnFaNvp4tXJz271k0ITFvLB9DL1uicAGvkG2ZxKPc8szKzLw0FRy
        CfZMqMQJrT14sSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 456F213B27;
        Mon, 10 Jan 2022 18:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jk5sEIuB3GHcaQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 18:57:15 +0000
Date:   Mon, 10 Jan 2022 19:57:19 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/entry for v5.17
Message-ID: <YdyBj2BpUyFa5ux8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a separate thread_info.flags accessors conversion branch
which has been agreed upon to go through tip.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_entry_for_v5.17_rc1

for you to fetch changes up to 985faa78687de6e583cfd8b8094d87dcb80c33a6:

  powerpc: Snapshot thread flags (2021-12-01 00:06:44 +0100)

----------------------------------------------------------------
- Add a set of thread_info.flags accessors which snapshot it before
accesing it in order to prevent any potential data races, and convert
all users to those new accessors

----------------------------------------------------------------
Mark Rutland (11):
      thread_info: Add helpers to snapshot thread flags
      x86: Snapshot thread flags
      entry: Snapshot thread flags
      sched: Snapshot thread flags
      alpha: Snapshot thread flags
      ARM: Snapshot thread flags
      arm64: Snapshot thread flags
      microblaze: Snapshot thread flags
      openrisc: Snapshot thread flags
      powerpc: Avoid discarding flags in system_call_exception()
      powerpc: Snapshot thread flags

 arch/alpha/kernel/signal.c          |  2 +-
 arch/arm/kernel/signal.c            |  2 +-
 arch/arm/mm/alignment.c             |  2 +-
 arch/arm64/kernel/entry-common.c    |  2 +-
 arch/arm64/kernel/ptrace.c          |  4 ++--
 arch/arm64/kernel/signal.c          |  2 +-
 arch/arm64/kernel/syscall.c         |  4 ++--
 arch/microblaze/kernel/signal.c     |  2 +-
 arch/openrisc/kernel/signal.c       |  2 +-
 arch/powerpc/kernel/interrupt.c     | 15 +++++++--------
 arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
 arch/x86/kernel/process.c           |  8 ++++----
 arch/x86/kernel/process.h           |  4 ++--
 arch/x86/mm/tlb.c                   |  2 +-
 include/linux/entry-kvm.h           |  2 +-
 include/linux/thread_info.h         | 14 ++++++++++++++
 kernel/entry/common.c               |  4 ++--
 kernel/entry/kvm.c                  |  4 ++--
 kernel/sched/core.c                 |  2 +-
 19 files changed, 46 insertions(+), 34 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
