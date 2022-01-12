Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED8748CBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbiALTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:16:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47844 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356778AbiALTQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:16:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA5791F3A2;
        Wed, 12 Jan 2022 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642014971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TcT2PUc5Pyj9rHuLDkN3R7ggFBNTnzIyUPp6E8UkKvg=;
        b=j5y14WMnR1LuqXwZyekRUlKmgJJRkz0DPW1KRq0IBZkZ8k31wUqIg6mOpFPlu7IjiTSFAF
        v6218GRQN4ARICuHP+6IoqPlCUU82u/8TvUagVesrsD6RTbmd0dap5F5Z4E/estAfH28/9
        Fb7SkcJPY26fvZRPmMhfohTkuUA0u+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642014971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TcT2PUc5Pyj9rHuLDkN3R7ggFBNTnzIyUPp6E8UkKvg=;
        b=Jdq83or/74/W5xwUI+C67zdSfAPpc8QCKWdVAWECa7tZcKSP5TjwKHyYMZEDgwijx7lL2j
        sJ9Fcurf/5EWb7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A208B13E18;
        Wed, 12 Jan 2022 19:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w7EjJ/so32G0FwAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 12 Jan 2022 19:16:11 +0000
Date:   Wed, 12 Jan 2022 20:16:14 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v5.17
Message-ID: <Yd8o/hxM/OH3mdQR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/core pile for 5.17.

This one got delayed a bit due to a testcase failure. But that has been
taken care of now and the last (newest) patch is the fix.

Thx.

---

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.17_rc1

for you to fetch changes up to 9cdbeec4096804083944d05da96bbaf59a1eb4f9:

  x86/entry_32: Fix segment exceptions (2022-01-12 16:38:25 +0100)

----------------------------------------------------------------
- Get rid of all the .fixup sections because this generates
misleading/wrong stacktraces and confuse RELIABLE_STACKTRACE and
LIVEPATCH as the backtrace misses the function which is being fixed up.

- Add Straight Light Speculation mitigation support which uses a new
compiler switch -mharden-sls= which sticks an INT3 after a RET or an
indirect branch in order to block speculation after them. Reportedly,
CPUs do speculate behind such insns.

- The usual set of cleanups and improvements

----------------------------------------------------------------
Eric Dumazet (1):
      x86/csum: Rewrite/optimize csum_partial()

Peter Zijlstra (31):
      x86: Move RETPOLINE*_CFLAGS to arch Makefile
      x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
      x86/lib/atomic64_386_32: Rename things
      x86: Prepare asm files for straight-line-speculation
      x86: Prepare inline-asm for straight-line-speculation
      objtool: Add straight-line-speculation validation
      x86/alternative: Relax text_poke_bp() constraint
      x86: Add straight-line-speculation mitigation
      bitfield.h: Fix "type of reg too small for mask" test
      x86/mmx_32: Remove X86_USE_3DNOW
      x86/copy_user_64: Remove .fixup usage
      x86/copy_mc_64: Remove .fixup usage
      x86/entry_64: Remove .fixup usage
      x86/entry_32: Remove .fixup usage
      x86/extable: Extend extable functionality
      x86/msr: Remove .fixup usage
      x86/futex: Remove .fixup usage
      x86/uaccess: Remove .fixup usage
      x86/xen: Remove .fixup usage
      x86/fpu: Remove .fixup usage
      x86/segment: Remove .fixup usage
      x86/kvm: Remove .fixup usage
      x86/vmx: Remove .fixup usage
      x86/checksum_32: Remove .fixup usage
      x86/sgx: Remove .fixup usage
      x86/usercopy_32: Simplify __copy_user_intel_nocache()
      x86/usercopy: Remove .fixup usage
      x86/word-at-a-time: Remove .fixup usage
      x86: Remove .fixup section
      objtool: Remove .fixup handling
      x86/entry_32: Fix segment exceptions

 Makefile                                       |  11 -
 arch/x86/Kconfig                               |  14 +-
 arch/x86/Kconfig.cpu                           |   4 -
 arch/x86/Makefile                              |  16 +
 arch/x86/boot/compressed/efi_thunk_64.S        |   2 +-
 arch/x86/boot/compressed/head_64.S             |   8 +-
 arch/x86/boot/compressed/mem_encrypt.S         |   6 +-
 arch/x86/crypto/aegis128-aesni-asm.S           |  48 +--
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S        |   2 +-
 arch/x86/crypto/aesni-intel_asm.S              |  56 ++--
 arch/x86/crypto/aesni-intel_avx-x86_64.S       |  40 +--
 arch/x86/crypto/blake2s-core.S                 |   4 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S       |  12 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S    |  14 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S   |  14 +-
 arch/x86/crypto/camellia-x86_64-asm_64.S       |  12 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S      |  12 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S      |  10 +-
 arch/x86/crypto/chacha-avx2-x86_64.S           |   6 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S       |   6 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S          |   8 +-
 arch/x86/crypto/crc32-pclmul_asm.S             |   2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S      |   2 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S         |   2 +-
 arch/x86/crypto/des3_ede-asm_64.S              |   4 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S      |   6 +-
 arch/x86/crypto/nh-avx2-x86_64.S               |   2 +-
 arch/x86/crypto/nh-sse2-x86_64.S               |   2 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S    |  10 +-
 arch/x86/crypto/serpent-avx2-asm_64.S          |  10 +-
 arch/x86/crypto/serpent-sse2-i586-asm_32.S     |   6 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S   |   6 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S         |   2 +-
 arch/x86/crypto/sha1_ni_asm.S                  |   2 +-
 arch/x86/crypto/sha1_ssse3_asm.S               |   2 +-
 arch/x86/crypto/sha256-avx-asm.S               |   2 +-
 arch/x86/crypto/sha256-avx2-asm.S              |   2 +-
 arch/x86/crypto/sha256-ssse3-asm.S             |   2 +-
 arch/x86/crypto/sha256_ni_asm.S                |   2 +-
 arch/x86/crypto/sha512-avx-asm.S               |   2 +-
 arch/x86/crypto/sha512-avx2-asm.S              |   2 +-
 arch/x86/crypto/sha512-ssse3-asm.S             |   2 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S         |  12 +-
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S        |   8 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S    |  10 +-
 arch/x86/crypto/twofish-i586-asm_32.S          |   4 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S   |   6 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S        |   4 +-
 arch/x86/entry/entry_32.S                      |  37 +--
 arch/x86/entry/entry_64.S                      |  23 +-
 arch/x86/entry/thunk_32.S                      |   2 +-
 arch/x86/entry/thunk_64.S                      |   2 +-
 arch/x86/entry/vdso/vdso-layout.lds.S          |   1 -
 arch/x86/entry/vdso/vdso32/system_call.S       |   2 +-
 arch/x86/entry/vdso/vsgx.S                     |   2 +-
 arch/x86/entry/vsyscall/vsyscall_emu_64.S      |   6 +-
 arch/x86/include/asm/asm.h                     |  37 +++
 arch/x86/include/asm/extable.h                 |   6 +-
 arch/x86/include/asm/extable_fixup_types.h     |  59 +++-
 arch/x86/include/asm/futex.h                   |  28 +-
 arch/x86/include/asm/insn-eval.h               |   2 +
 arch/x86/include/asm/linkage.h                 |  14 +
 arch/x86/include/asm/mmx.h                     |  15 -
 arch/x86/include/asm/msr.h                     |  26 +-
 arch/x86/include/asm/page_32.h                 |  14 -
 arch/x86/include/asm/paravirt.h                |   2 +-
 arch/x86/include/asm/qspinlock_paravirt.h      |   4 +-
 arch/x86/include/asm/required-features.h       |   4 -
 arch/x86/include/asm/segment.h                 |   9 +-
 arch/x86/include/asm/sgx.h                     |  18 ++
 arch/x86/include/asm/static_call.h             |   2 +-
 arch/x86/include/asm/string_32.h               |  33 ---
 arch/x86/include/asm/uaccess.h                 |  39 ++-
 arch/x86/include/asm/word-at-a-time.h          |  66 +++--
 arch/x86/include/asm/xen/page.h                |  14 +-
 arch/x86/kernel/acpi/wakeup_32.S               |   6 +-
 arch/x86/kernel/alternative.c                  |  51 +++-
 arch/x86/kernel/cpu/sgx/encls.h                |  36 +--
 arch/x86/kernel/fpu/legacy.h                   |   6 +-
 arch/x86/kernel/fpu/xstate.h                   |   6 +-
 arch/x86/kernel/ftrace.c                       |   2 +-
 arch/x86/kernel/ftrace_32.S                    |   6 +-
 arch/x86/kernel/ftrace_64.S                    |   8 +-
 arch/x86/kernel/head_32.S                      |   2 +-
 arch/x86/kernel/irqflags.S                     |   2 +-
 arch/x86/kernel/kprobes/core.c                 |   2 +-
 arch/x86/kernel/paravirt.c                     |   4 +-
 arch/x86/kernel/relocate_kernel_32.S           |  10 +-
 arch/x86/kernel/relocate_kernel_64.S           |  10 +-
 arch/x86/kernel/sev_verify_cbit.S              |   2 +-
 arch/x86/kernel/static_call.c                  |   5 +-
 arch/x86/kernel/verify_cpu.S                   |   4 +-
 arch/x86/kernel/vmlinux.lds.S                  |   1 -
 arch/x86/kvm/emulate.c                         |  16 +-
 arch/x86/kvm/svm/vmenter.S                     |   4 +-
 arch/x86/kvm/vmx/vmenter.S                     |  14 +-
 arch/x86/kvm/vmx/vmx_ops.h                     |  16 +-
 arch/x86/lib/Makefile                          |   1 -
 arch/x86/lib/atomic64_386_32.S                 |  86 +++---
 arch/x86/lib/atomic64_cx8_32.S                 |  16 +-
 arch/x86/lib/checksum_32.S                     |  27 +-
 arch/x86/lib/clear_page_64.S                   |   6 +-
 arch/x86/lib/cmpxchg16b_emu.S                  |   4 +-
 arch/x86/lib/cmpxchg8b_emu.S                   |   4 +-
 arch/x86/lib/copy_mc_64.S                      |  18 +-
 arch/x86/lib/copy_page_64.S                    |   4 +-
 arch/x86/lib/copy_user_64.S                    |  42 +--
 arch/x86/lib/csum-copy_64.S                    |   2 +-
 arch/x86/lib/csum-partial_64.c                 | 183 ++++++------
 arch/x86/lib/error-inject.c                    |   3 +-
 arch/x86/lib/getuser.S                         |  22 +-
 arch/x86/lib/hweight.S                         |   6 +-
 arch/x86/lib/insn-eval.c                       |  71 +++--
 arch/x86/lib/iomap_copy_64.S                   |   2 +-
 arch/x86/lib/memcpy_32.c                       |   4 -
 arch/x86/lib/memcpy_64.S                       |  12 +-
 arch/x86/lib/memmove_64.S                      |   4 +-
 arch/x86/lib/memset_64.S                       |   6 +-
 arch/x86/lib/mmx_32.c                          | 388 -------------------------
 arch/x86/lib/msr-reg.S                         |   4 +-
 arch/x86/lib/putuser.S                         |   6 +-
 arch/x86/lib/retpoline.S                       |   4 +-
 arch/x86/lib/usercopy_32.c                     |  67 ++---
 arch/x86/lib/usercopy_64.c                     |   8 +-
 arch/x86/math-emu/div_Xsig.S                   |   2 +-
 arch/x86/math-emu/div_small.S                  |   2 +-
 arch/x86/math-emu/mul_Xsig.S                   |   6 +-
 arch/x86/math-emu/polynom_Xsig.S               |   2 +-
 arch/x86/math-emu/reg_norm.S                   |   6 +-
 arch/x86/math-emu/reg_round.S                  |   2 +-
 arch/x86/math-emu/reg_u_add.S                  |   2 +-
 arch/x86/math-emu/reg_u_div.S                  |   2 +-
 arch/x86/math-emu/reg_u_mul.S                  |   2 +-
 arch/x86/math-emu/reg_u_sub.S                  |   2 +-
 arch/x86/math-emu/round_Xsig.S                 |   4 +-
 arch/x86/math-emu/shr_Xsig.S                   |   8 +-
 arch/x86/math-emu/wm_shrx.S                    |  16 +-
 arch/x86/mm/extable.c                          | 113 +++++--
 arch/x86/mm/mem_encrypt_boot.S                 |   4 +-
 arch/x86/net/bpf_jit_comp.c                    |   2 +-
 arch/x86/platform/efi/efi_stub_32.S            |   2 +-
 arch/x86/platform/efi/efi_stub_64.S            |   2 +-
 arch/x86/platform/efi/efi_thunk_64.S           |   2 +-
 arch/x86/platform/olpc/xo1-wakeup.S            |   6 +-
 arch/x86/power/hibernate_asm_32.S              |   4 +-
 arch/x86/power/hibernate_asm_64.S              |   4 +-
 arch/x86/um/checksum_32.S                      |   4 +-
 arch/x86/um/setjmp_32.S                        |   2 +-
 arch/x86/um/setjmp_64.S                        |   2 +-
 arch/x86/xen/xen-asm.S                         |  12 +-
 arch/x86/xen/xen-head.S                        |   2 +-
 include/linux/bitfield.h                       |  19 +-
 samples/ftrace/ftrace-direct-modify.c          |   4 +-
 samples/ftrace/ftrace-direct-too.c             |   2 +-
 samples/ftrace/ftrace-direct.c                 |   2 +-
 scripts/Makefile.build                         |   3 +-
 scripts/link-vmlinux.sh                        |   3 +
 tools/arch/x86/include/asm/required-features.h |   4 -
 tools/objtool/arch/x86/decode.c                |  13 +-
 tools/objtool/builtin-check.c                  |   3 +-
 tools/objtool/check.c                          |  22 +-
 tools/objtool/include/objtool/arch.h           |   1 +
 tools/objtool/include/objtool/builtin.h        |   2 +-
 163 files changed, 1047 insertions(+), 1349 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
