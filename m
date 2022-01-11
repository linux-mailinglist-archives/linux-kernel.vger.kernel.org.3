Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895AB48A8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiAKHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:52:53 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44096 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiAKHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:52:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AD864614E2C4;
        Tue, 11 Jan 2022 08:52:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2ZT5CSczOSjH; Tue, 11 Jan 2022 08:52:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2A582614E2CB;
        Tue, 11 Jan 2022 08:52:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D7MJJ8k-LbO6; Tue, 11 Jan 2022 08:52:50 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0607E614E2C4;
        Tue, 11 Jan 2022 08:52:50 +0100 (CET)
Date:   Tue, 11 Jan 2022 08:52:49 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <10132756.248426.1641887569979.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for 5.17
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Index: RsIVnHqP6wx+gtlWtggyZBf0Dh/AXA==
Thread-Topic: UML updates for 5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 1c3e979bf3e225e5b4b810b24712b16254d608b6:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2021-12-21 09:30:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.17-rc1

for you to fetch changes up to db0dd9cee82270e032123169ceff659eced5115d:

  um: virtio_uml: Allow probing from devicetree (2021-12-22 20:40:05 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- set_fs removal
- Devicetree support
- Many cleanups from Al
- Various virtio and build related fixes

----------------------------------------------------------------
Al Viro (15):
      uml: trim unused junk from arch/x86/um/sys_call_table_*.c
      um: move amd64 variant of mmap(2) to arch/x86/um/syscalls_64.c
      logic_io instance of iounmap() needs volatile on argument
      um: stop polluting the namespace with registers.h contents
      uml/i386: missing include in barrier.h
      um: kill unused cpu()
      um: remove a dangling extern of syscall_trace()
      um: unexport handle_page_fault()
      um, x86: bury crypto_tfm_ctx_offset
      um: common-offsets.h debriding...
      um: header debriding - activate_ipi()
      um: header debriding - mem_user.h
      um: header debriding - net_*.h
      um: header debriding - os.h
      um: header debriding - sigio.h

Changcheng Deng (1):
      um: Replace if (cond) BUG() with BUG_ON()

Christoph Hellwig (1):
      um: remove set_fs

Johannes Berg (8):
      um: fix ndelay/udelay defines
      um: rename set_signals() to um_set_signals()
      uml: x86: add FORCE to user_constants.h
      um: gitignore: Add kernel/capflags.c
      um: virt-pci: Fix 32-bit compile
      lib/logic_iomem: Fix 32-bit build
      lib/logic_iomem: Fix operation on 32-bit
      um: virtio_uml: Fix time-travel external time propagation

Randy Dunlap (1):
      um: registers: Rename function names to avoid conflicts and build problems

Sjoerd Simons (1):
      hostfs: Fix writeback of dirty pages

Vincent Whitchurch (3):
      um: Extract load file helper from initrd.c
      um: Add devicetree support
      um: virtio_uml: Allow probing from devicetree

Yang Guang (1):
      um: Use swap() to make code cleaner

 arch/um/.gitignore                      |  1 +
 arch/um/Kconfig                         |  2 +-
 arch/um/drivers/virt-pci.c              |  8 ++---
 arch/um/drivers/virtio_uml.c            | 54 +++++++++++++++++++++++++++--
 arch/um/include/asm/delay.h             |  4 +--
 arch/um/include/asm/irqflags.h          |  4 +--
 arch/um/include/asm/processor-generic.h |  2 +-
 arch/um/include/asm/thread_info.h       |  4 ---
 arch/um/include/asm/uaccess.h           | 21 ++++++++++--
 arch/um/include/shared/common-offsets.h | 15 --------
 arch/um/include/shared/irq_user.h       |  1 -
 arch/um/include/shared/kern_util.h      |  2 --
 arch/um/include/shared/longjmp.h        |  2 +-
 arch/um/include/shared/mem_user.h       |  5 ---
 arch/um/include/shared/net_kern.h       |  2 --
 arch/um/include/shared/net_user.h       |  1 -
 arch/um/include/shared/os.h             | 17 ++-------
 arch/um/include/shared/registers.h      |  6 ++--
 arch/um/include/shared/sigio.h          |  1 -
 arch/um/kernel/Makefile                 |  4 ++-
 arch/um/kernel/dtb.c                    | 41 ++++++++++++++++++++++
 arch/um/kernel/exec.c                   |  1 +
 arch/um/kernel/initrd.c                 | 48 +++-----------------------
 arch/um/kernel/ksyms.c                  |  2 +-
 arch/um/kernel/load_file.c              | 61 +++++++++++++++++++++++++++++++++
 arch/um/kernel/mem.c                    |  3 +-
 arch/um/kernel/process.c                |  6 +---
 arch/um/kernel/skas/uaccess.c           | 25 --------------
 arch/um/kernel/syscall.c                | 28 ---------------
 arch/um/kernel/trap.c                   |  1 -
 arch/um/kernel/um_arch.c                |  3 ++
 arch/um/kernel/um_arch.h                | 14 ++++++++
 arch/um/os-Linux/registers.c            |  4 +--
 arch/um/os-Linux/sigio.c                | 13 ++++---
 arch/um/os-Linux/signal.c               |  8 ++---
 arch/um/os-Linux/start_up.c             |  2 +-
 arch/x86/kernel/asm-offsets.c           |  3 --
 arch/x86/um/Makefile                    |  2 +-
 arch/x86/um/asm/barrier.h               |  1 +
 arch/x86/um/asm/segment.h               |  8 -----
 arch/x86/um/os-Linux/registers.c        |  1 +
 arch/x86/um/ptrace_32.c                 |  1 +
 arch/x86/um/ptrace_64.c                 |  1 +
 arch/x86/um/shared/sysdep/syscalls_64.h |  3 --
 arch/x86/um/signal.c                    |  1 +
 arch/x86/um/sys_call_table_32.c         |  4 ---
 arch/x86/um/sys_call_table_64.c         | 17 ---------
 arch/x86/um/syscalls_64.c               | 14 +++++++-
 fs/hostfs/hostfs_kern.c                 |  3 ++
 include/asm-generic/logic_io.h          |  2 +-
 lib/logic_iomem.c                       | 23 +++++++------
 51 files changed, 265 insertions(+), 235 deletions(-)
 create mode 100644 arch/um/kernel/dtb.c
 create mode 100644 arch/um/kernel/load_file.c
 delete mode 100644 arch/um/kernel/syscall.c
 create mode 100644 arch/um/kernel/um_arch.h
