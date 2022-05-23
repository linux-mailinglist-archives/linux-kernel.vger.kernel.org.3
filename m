Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A54531CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiEWT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiEWT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:29:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01E1A04AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:10:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a9so12445616pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zBXBCt3D3bhNz3r9T/oOszODed7Ga1kkD6pwGMzxJqk=;
        b=SxqJ/OYVpyZurf4Q5r8MPyFpYwzL02ImZlnnKu5GVbVLy9zjRAGk9eUvVk1tv/hpyq
         TJrM0iTWl+xvPsJxXjUDW5t0+WdiMmfzyVnD1BGidI3+2EK5aLeqL9HIqIeiU/PA8yID
         e3+YSPjaLBuKHDMtEaC4pPn80ntPf3HyapPDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zBXBCt3D3bhNz3r9T/oOszODed7Ga1kkD6pwGMzxJqk=;
        b=t7ty0gooGhiE8nR5MPP36pnUjzH5k7CApS6pQTxeKt9zgv3ErEuFeMvccgkQzVz5UY
         7GaSCrTTu6bCaRBKy0dgFNhJwTd0JUX6NdLdbUfFhrNfL7UnpRc5ft5guoRujbSjCTrh
         XZHnY9fhXf5E72uiY7s6biEIdO3xfHRXKZc8Mf1OHt4sQinHNQlh/RB6Th8TqXTYtpGS
         0vyaOwJdKA0O9tL9G2ujrTPolTrRLQqmjRGEHx4WRi4rp2dPc35h1M5i4fz53XcUEcBv
         zEEGk5dyeLM0RioEoNCN5HL5ZhzZXLpgtcYo07EtLC7wE3xuSuUrggWNwAzEzckdPye9
         Qmlw==
X-Gm-Message-State: AOAM5339vePetJjSg8/frnXc/lxWT6GR8+uTVZcO7MxNeIG1nXUdsHXW
        524GvgsF9RlXi34Dsq0EdICDPw==
X-Google-Smtp-Source: ABdhPJx9ToxAmWubx4HH2hqA/3d3oQgh495M77Fhz6M2R686Qg7x2GiKmADOAJrZJcRhehKDLSK8hg==
X-Received: by 2002:a62:bd14:0:b0:50d:4bec:ff78 with SMTP id a20-20020a62bd14000000b0050d4becff78mr25182644pff.71.1653333006165;
        Mon, 23 May 2022 12:10:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b001618644d8b5sm5486020plt.154.2022.05.23.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:10:05 -0700 (PDT)
Date:   Mon, 23 May 2022 12:10:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Bill Wendling <morbo@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>
Subject: [GIT PULL] kernel hardening updates for v5.19-rc1
Message-ID: <202205231146.E8C6085@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these kernel hardening updates for v5.19-rc1. As hardening
features are now supported by various combinations of native GCC,
native Clang, and GCC plugins, the dependencies don't allow for a clean
separation between a "gcc plugins" tree and a "clang features" tree, and
similarly, the tweaks for the "small" LSMs (e.g. LoadPin) don't really
make sense to carry separately either. So, here is the combined tree,
which I was already heading toward during the last merge window.

Please note there are 2 easy conflicts to deal with, but I wanted to
make sure they were clear and to give some context for why they happened:

1) drivers/misc/lkdtm/stackleak.c
	char-misc
        	73f62e60d80c ("lkdtm: Move crashtype definitions into each category")
	hardening:
        	f03a50938dec ("lkdtm/stackleak: prevent unexpected stack usage")

   73f62e60d80c is a larger refactoring of how all the LKDTM tests are
   registered with the LKDTM core, but the stackleak test updates depend on
   the arm64 changes, so these came via separate trees. The resolution is
   easy; the linux-next notes are here:
   https://lore.kernel.org/linux-next/202205091610.4375DD0A@keescook/

2) include/linux/netfs.h
	fscache
		713423282ae1 ("netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context")
	hardening
		3b5eed3c71a2 ("netfs: Eliminate Clang randstruct warning")

   3b5eed3c71a2 can be entirely dropped in favor of 713423282ae1, which
   is the more complete solution, keeping both Clang and GCC happy.
   3b5eed3c71a2 was committed before GCC 12 was released and 713423282ae1
   was being worked on right up until yesterday, so to keep the commit history
   intact and avoid Clang-specific allmodconfig warnings to appear, I kept it
   in the hardening tree rather than doing a revert just to avoid the conflict.
   The linux-next notes are here:
   https://lore.kernel.org/linux-next/20220523205716.4a641c41@canb.auug.org.au/

Thanks!

-Kees

The following changes since commit a19944809fe9942e6a96292490717904d0690c21:

  Merge tag 'hardening-v5.18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2022-04-12 14:29:40 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kernel-hardening-v5.19-rc1

for you to fetch changes up to ed5edd5a70b9525085403f193786395179ea303d:

  loadpin: stop using bdevname (2022-05-16 16:02:21 -0700)

----------------------------------------------------------------
kernel-hardening updates for v5.19-rc1

- usercopy hardening expanded to check other allocation types
  (Matthew Wilcox, Yuanzheng Song)

- arm64 stackleak behavioral improvements (Mark Rutland)

- arm64 CFI code gen improvement (Sami Tolvanen)

- LoadPin LSM block dev API adjustment (Christoph Hellwig)

- Clang randstruct support (Bill Wendling, Kees Cook)

----------------------------------------------------------------
Bill Wendling (1):
      security: don't treat structure as an array of struct hlist_head

Christoph Hellwig (1):
      loadpin: stop using bdevname

Kees Cook (12):
      netfs: Eliminate Clang randstruct warning
      sancov: Split plugin build from plugin CFLAGS
      randstruct: Reorganize Kconfigs and attribute macros
      randstruct: Split randstruct Makefile and CFLAGS
      randstruct: Move seed generation into scripts/basic/
      randstruct: Enable Clang support
      randomize_kstack: Improve docs on requirements/rationale
      gcc-plugins: Change all version strings match kernel
      big_keys: Use struct for internal payload
      niu: Silence randstruct warnings
      af_unix: Silence randstruct GCC plugin warning
      gcc-plugins: randstruct: Remove cast exception handling

Mark Rutland (14):
      arm64: stackleak: fix current_top_of_stack()
      stackleak: move skip_erasing() check earlier
      stackleak: remove redundant check
      stackleak: rework stack low bound handling
      stackleak: clarify variable names
      stackleak: rework stack high bound handling
      stackleak: rework poison scanning
      lkdtm/stackleak: avoid spurious failure
      lkdtm/stackleak: rework boundary management
      lkdtm/stackleak: prevent unexpected stack usage
      lkdtm/stackleak: check stack boundaries
      stackleak: add on/off stack variants
      arm64: entry: use stackleak_erase_on_task_stack()
      lkdtm/stackleak: fix CONFIG_GCC_PLUGIN_STACKLEAK=n

Matthew Wilcox (Oracle) (4):
      mm/usercopy: Check kmap addresses properly
      mm/usercopy: Detect vmalloc overruns
      mm/usercopy: Detect large folio overruns
      usercopy: Remove HARDENED_USERCOPY_PAGESPAN

Sami Tolvanen (1):
      cfi: Use __builtin_function_start

Yuanzheng Song (1):
      mm: usercopy: move the virt_addr_valid() below the is_vmalloc_addr()

 Documentation/dontdiff                        |   1 +
 Documentation/kbuild/reproducible-builds.rst  |   8 +-
 Makefile                                      |   1 +
 arch/Kconfig                                  |   5 +-
 arch/arm/vdso/Makefile                        |   2 +-
 arch/arm64/include/asm/compiler.h             |  16 ---
 arch/arm64/include/asm/processor.h            |  10 +-
 arch/arm64/kernel/entry.S                     |   2 +-
 arch/arm64/kernel/vdso/Makefile               |   3 +-
 arch/riscv/Kconfig                            |   2 +-
 arch/sparc/vdso/Makefile                      |   3 +-
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/include/asm/highmem.h                |   1 +
 arch/x86/mm/pti.c                             |   2 +-
 drivers/misc/lkdtm/stackleak.c                | 145 ++++++++++++++++++--------
 drivers/net/ethernet/sun/niu.c                |  41 ++++++--
 include/linux/compiler-clang.h                |  10 ++
 include/linux/compiler-gcc.h                  |   8 --
 include/linux/compiler_types.h                |  14 +--
 include/linux/highmem-internal.h              |  10 ++
 include/linux/netfs.h                         |   4 +-
 include/linux/randomize_kstack.h              |  27 ++++-
 include/linux/stackleak.h                     |  55 +++++++++-
 include/linux/vermagic.h                      |  10 +-
 kernel/panic.c                                |   2 +-
 kernel/stackleak.c                            | 105 +++++++++++--------
 mm/usercopy.c                                 |  91 +++++-----------
 net/unix/af_unix.c                            |   8 +-
 scripts/Makefile.gcc-plugins                  |  22 ++--
 scripts/Makefile.randstruct                   |  17 +++
 scripts/basic/.gitignore                      |   1 +
 scripts/basic/Makefile                        |  11 ++
 scripts/gcc-plugins/Kconfig                   |  38 -------
 scripts/gcc-plugins/Makefile                  |  24 +++--
 scripts/gcc-plugins/gen-random-seed.sh        |   9 --
 scripts/gcc-plugins/latent_entropy_plugin.c   |   2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c |  89 +---------------
 scripts/gcc-plugins/sancov_plugin.c           |   2 +-
 scripts/gcc-plugins/stackleak_plugin.c        |   2 +-
 scripts/gcc-plugins/structleak_plugin.c       |   2 +-
 scripts/gen-randstruct-seed.sh                |   7 ++
 security/Kconfig                              |  13 +--
 security/Kconfig.hardening                    |  73 +++++++++++++
 security/keys/big_key.c                       |  73 +++++++------
 security/loadpin/loadpin.c                    |   5 +-
 security/security.c                           |   9 +-
 46 files changed, 539 insertions(+), 449 deletions(-)
 create mode 100644 scripts/Makefile.randstruct
 delete mode 100755 scripts/gcc-plugins/gen-random-seed.sh
 create mode 100755 scripts/gen-randstruct-seed.sh

-- 
Kees Cook
