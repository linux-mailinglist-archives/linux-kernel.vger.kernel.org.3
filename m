Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB1497145
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiAWLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiAWLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:19:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97EC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:19:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JhVxh3rF5z4xkH;
        Sun, 23 Jan 2022 22:19:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1642936762;
        bh=rjiXIAoujbqKcL6bu1UAXJuKBGJPBbV6NTCD/DODPuc=;
        h=From:To:Cc:Subject:Date:From;
        b=CIWtkFV1KPYsCJBegjyHovnQTEK0CgrZDkz/fLMO3ChM6hrmp9lETUzn7Q+c6cXK/
         u5TlM3xNOwapFFmKakK7Ofu5cTZUEU+hOgvKKawnim4TPEJA3KPGjahgWynhFOdX7c
         5XRlssJuxGxyYoQKgx8/Mhq/R8oeP3zk0y/MxSGGp1aivIe1TkKqXdXzil3Dg1CSp8
         10/8Zeabrx5blc4wJCdApbdJscVbm3t7SZ5/DSIZZiD2ZohYdQMHvIoLfTK+agyMSx
         +S+moaX+0vAmydQbJMX0mYEL4GR2P7aSXe4dSf/jBRzb0FkaRS3Z0MzS18GqxqCkdH
         lAMgzTvqaWOzQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        daniel@iogearbox.net, johan.almbladh@anyfinetworks.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-2 tag
Date:   Sun, 23 Jan 2022 22:19:16 +1100
Message-ID: <877daqu2bv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 5.17.

There's a change to kernel/bpf and one in tools/bpf, both have Daniel's ack.

cheers


The following changes since commit 29ec39fcf11e4583eb8d5174f756ea109c77cc44:

  Merge tag 'powerpc-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2022-01-14 15:17:26 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-2

for you to fetch changes up to aee101d7b95a03078945681dd7f7ea5e4a1e7686:

  powerpc/64s: Mask SRR0 before checking against the masked NIP (2022-01-18 10:25:18 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.17 #2

 - A series of bpf fixes, including an oops fix and some codegen fixes.

 - Fix a regression in syscall_get_arch() for compat processes.

 - Fix boot failure on some 32-bit systems with KASAN enabled.

 - A couple of other build/minor fixes.

Thanks to: Athira Rajeev, Christophe Leroy, Dmitry V. Levin, Jiri Olsa, Johan Almbladh,
Maxime Bizon, Naveen N. Rao, Nicholas Piggin.

- ------------------------------------------------------------------
Athira Rajeev (1):
      powerpc/perf: Only define power_pmu_wants_prompt_pmi() for CONFIG_PPC64

Christophe Leroy (3):
      powerpc/audit: Fix syscall_get_arch()
      powerpc/time: Fix build failure due to do_hard_irq_enable() on PPC32
      powerpc/32s: Fix kasan_init_region() for KASAN

Naveen N. Rao (5):
      bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()
      powerpc32/bpf: Fix codegen for bpf-to-bpf calls
      powerpc/bpf: Update ldimm64 instructions during extra pass
      tools/bpf: Rename 'struct event' to avoid naming conflict
      powerpc64/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06

Nicholas Piggin (1):
      powerpc/64s: Mask SRR0 before checking against the masked NIP


 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 +
 arch/powerpc/include/asm/hw_irq.h             |  2 +-
 arch/powerpc/include/asm/ppc-opcode.h         |  1 +
 arch/powerpc/include/asm/syscall.h            |  4 +-
 arch/powerpc/include/asm/thread_info.h        |  2 +
 arch/powerpc/kernel/interrupt_64.S            |  2 +
 arch/powerpc/mm/book3s32/mmu.c                | 10 ++--
 arch/powerpc/mm/kasan/book3s_32.c             | 59 ++++++++++----------
 arch/powerpc/net/bpf_jit_comp.c               | 29 ++++++++--
 arch/powerpc/net/bpf_jit_comp32.c             |  9 +++
 arch/powerpc/net/bpf_jit_comp64.c             | 29 ++++++----
 arch/powerpc/perf/core-book3s.c               | 58 ++++++++++---------
 kernel/bpf/stackmap.c                         |  5 +-
 tools/bpf/runqslower/runqslower.bpf.c         |  2 +-
 tools/bpf/runqslower/runqslower.c             |  2 +-
 tools/bpf/runqslower/runqslower.h             |  2 +-
 16 files changed, 131 insertions(+), 87 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmHtOYQACgkQUevqPMjh
pYAZHw//UQj2TYAqdcrkDE2tz81s6/ifbnHsypz4vU9YV8muJUFsXpt9MPbvQhoq
gvUnG3gkMNoXxQ+YDKa2ygN/MLC78ch+4VYWyGGzNcpqVxKWhPqbH/Gt7KvMGOZr
LtnUCYjw462GBGrU7VI+yg9ki4c/pRzcSGoU4w346Q2/xIWdcNDb2aZ9a9MiYMCw
/SBOpwj2hPhFQsAINVujXgrIHlybon+cDGJdPQptBSqvEq24wFu+F+elzXBcJvfm
tVoAe81C077AhT8EGwyM9mTvTmBie+0jgZAkGVsvrUsbJJJY3FV/s923Fc9+lm/m
SMD4Pn8ZaN+dPMRUgCMaUZFjCKTyBx182ELlqraZtTTZvFXXt/ZtM5BCvXZqreZU
6XPFs+xMvJN4ZatdVM724hKhR9UoDaDer0zDcMvj1Yqr5E5LL1cl9ZG0fPeIYPdg
+tMKCWxvx64OWYwZNyeGr12JNvtrzWruvO/2TD60gGdqXIQH39ds8voaW6AUJOeX
xWP5UdEeh1LUPTb5HIEloy7K9QsUlE+fJ+3McbPk2vL01TBbrAjLymPdqCKEDGWe
Z74u7iRjggXEopUOLQPQS4L60P/T6a+5oq2j0eUh4NCWXlJA4Iyfez/76BIiov3L
qHNn4PjNXNQzR5r9xuhTe+WSZselnCnaVZgqsYnptkfdps5Yd6w=
=bxy0
-----END PGP SIGNATURE-----
