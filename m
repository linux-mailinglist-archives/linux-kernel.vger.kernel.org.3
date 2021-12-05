Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B456D468A72
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhLELMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:12:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60332 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhLELMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:12:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89E0721921;
        Sun,  5 Dec 2021 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638702566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O+5PzANN5oWDrMN31Q5Lsb48UzG5TL6AKMggdswkBGA=;
        b=VON2QSI7n8oX1YoLBoY0wrWzyvOoRQTrMef1UV8ze9dRvUodPK3ftonpxsryeyG9SnX9sM
        fJgOTI70eEP4diLL08wHqr1TldIGNYwz5pvPqWFNO5oX0kvXRDy2HML7C9Gr+XZgSO4Fuo
        m2ETYXEXbhEWSReoSt0khvrqofwirAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638702566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O+5PzANN5oWDrMN31Q5Lsb48UzG5TL6AKMggdswkBGA=;
        b=/94SRQEH1lj9H2b78deo+rfOPr+o0pdM5nTWmJ2wIUj7724Ikg+k8hk8/oy+1YwxfTbVdg
        PgYjjhCFpYp/G0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FD0413466;
        Sun,  5 Dec 2021 11:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 24TjGuadrGGoVwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 05 Dec 2021 11:09:26 +0000
Date:   Sun, 5 Dec 2021 12:09:28 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.16-rc4
Message-ID: <Yayd6FkzkKcOZKlc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of x86/urgent fixes which accumulated in the last
two weeks.

Thx.

---

The following changes since commit c0f2077baa4113f38f008b8e912b9fb3ff8d43df:

  x86/boot: Mark prepare_command_line() __init (2021-11-24 12:20:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc4

for you to fetch changes up to 5c8f6a2e316efebb3ba93d8c1af258155dcf5632:

  x86/xen: Add xenpv_restore_regs_and_return_to_usermode() (2021-12-03 19:21:15 +0100)

----------------------------------------------------------------
- Fix a couple of SWAPGS fencing issues in the x86 entry code

- Use the proper operand types in __{get,put}_user() to prevent
truncation in SEV-ES string io

- Make sure the kernel mappings are present in trampoline_pgd in order
to prevent any potential accesses to unmapped memory after switching to
it

- Fix a trivial list corruption in objtool's pv_ops validation

- Disable the clocksource watchdog for TSC on platforms which claim
that the TSC is constant, doesn't stop in sleep states, CPU has TSC
adjust and the number of sockets of the platform are max 2, to prevent
erroneous markings of the TSC as unstable.

- Make sure TSC adjust is always checked not only when going idle

- Prevent a stack leak by initializing struct _fpx_sw_bytes properly in
the FPU code

- Fix INTEL_FAM6_RAPTORLAKE define naming to adhere to the convention

----------------------------------------------------------------
Feng Tang (2):
      x86/tsc: Add a timer to make sure TSC_adjust is always checked
      x86/tsc: Disable clocksource watchdog for TSC on qualified platorms

Joerg Roedel (1):
      x86/64/mm: Map all kernel memory into trampoline_pgd

Lai Jiangshan (3):
      x86/entry: Add a fence for kernel entry SWAPGS in paranoid_entry()
      x86/entry: Use the correct fence macro after swapgs in kernel CR3
      x86/xen: Add xenpv_restore_regs_and_return_to_usermode()

Marco Elver (1):
      x86/fpu/signal: Initialize sw_bytes in save_xstate_epilog()

Michael Sterritt (1):
      x86/sev: Fix SEV-ES INS/OUTS instructions for word, dword, and qword

Peter Zijlstra (1):
      objtool: Fix pv_ops noinstr validation

Tony Luck (1):
      x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

 arch/x86/entry/entry_64.S           | 35 +++++++++++------------
 arch/x86/include/asm/intel-family.h |  2 +-
 arch/x86/kernel/fpu/signal.c        |  2 +-
 arch/x86/kernel/sev.c               | 57 +++++++++++++++++++++++++------------
 arch/x86/kernel/tsc.c               | 28 +++++++++++++++---
 arch/x86/kernel/tsc_sync.c          | 41 ++++++++++++++++++++++++++
 arch/x86/realmode/init.c            | 12 +++++++-
 arch/x86/xen/xen-asm.S              | 20 +++++++++++++
 tools/objtool/elf.c                 |  1 +
 tools/objtool/objtool.c             |  4 +++
 10 files changed, 159 insertions(+), 43 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
