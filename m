Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA149015D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiAQFeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiAQFeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:34:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69CC061574;
        Sun, 16 Jan 2022 21:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D1C7B80DCF;
        Mon, 17 Jan 2022 05:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC38C36AED;
        Mon, 17 Jan 2022 05:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397646;
        bh=C6zDtYDsuOnD7taun2btsHbFgZ3DATzTwF9t8BIO3DI=;
        h=From:To:Cc:Subject:Date:From;
        b=fwl4u4NpMTO+Y6EoXititYC08AT8mMeV5s0qZPXtav9sOn2Ewt9P1U6xd1B+qTmb+
         fZEhi97IDarDlxE35CyRKMi6zQFmU+qBhTuvC/o3XPmaJYZB/fDQpL2fZX2+NE6pOh
         1h86ddpzCLPK/rUVNb6qNjQXFaoNHTqdjxRUTobmDi1U/Miid5/DYFR0m5gjzMPquA
         lTTOPKY3rLzBfGhokCp6BinI9KV4E9mu6SdAzAheEH9N8Kb0PcNwcuucjd+BT3UbDl
         vZDEVRl6bPnXDWUCvJk+CBqAVbVG1dETf1yhSlljTZudAkV94n6brEmDycDxMLPed3
         guGxZAZTz4jrA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v3 00/19] Rust support
Date:   Mon, 17 Jan 2022 06:33:30 +0100
Message-Id: <20220117053349.6804-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust support

This is the patch series (v3) to add support for Rust as a second
language to the Linux kernel.

If you are interested in following this effort, please join us in
the mailing list at:

    rust-for-linux@vger.kernel.org

and take a look at the project itself at:

    https://github.com/Rust-for-Linux

As usual, special thanks go to ISRG (Internet Security Research
Group) and Google for their financial support on this endeavor.

Cheers,
Miguel

--

# Rust support

This cover letter explains the major changes and updates done since
the previous ones. For those, please see:

    RFC: https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/
    v1:  https://lore.kernel.org/lkml/20210704202756.29107-1-ojeda@kernel.org/
    v2:  https://lore.kernel.org/lkml/20211206140313.5653-1-ojeda@kernel.org/


## Infrastructure updates

There have been several improvements to the overall Rust support:

  - The compiler has been upgraded to Rust 1.58.0.

  - Added automatic detection of whether there is a suitable Rust
    toolchain available (`CONFIG_RUST_IS_AVAILABLE`, which replaces
    `HAS_RUST`), and made `CONFIG_RUST` depend on it. It also comes
    with an easy way for users/developers to understand why the Rust
    toolchain might not be available: a Makefile target is provided
    (`rustavailable`) which explains why that is the case, using
    the same logic that Kbuild/Kconfig use.

  - Removed the `!COMPILE_TEST` gate, which will eventually allow us
    to increase testing the Rust support in places that run
    `all{yes,mod}config`.

  - Other build system improvements, such as improved cleaning
    behavior.

  - Documentation: reorganization, new section on naming,
    clarifications...


One of the unstable features we need, `-Zsymbol-mangling-version=v0`,
is getting stabilized in 1.59.0. Another one, `maybe_uninit_extra`,
will be in 1.60.0. As usual, please see the following link for the
live list of unstable features we are using:

    https://github.com/Rust-for-Linux/linux/issues/2


## Abstractions and driver updates

Some of the improvements to the abstractions and example drivers are:

  - Added `IdArray` and `IdTable` which will be used in buses to
    allow drivers to specify device ID tables that are guaranteed to
    be zero-terminated at compile time.

  - Updated `amba` to use the new constant device ID table support.

  - Initial common clock framework abstractions.

  - Platform drivers are now defined by implementing a trait.
    Includes a new macro for simplified registration of platform
    drivers and a new sample/template.

  - `dev_*` printing macros.

  - `{read,write}*_relaxed` methods for `IoMem<T>`.

  - Simplified file operations by removing `FileOpener`.

  - Added `ThisModule` to the arguments of driver registration.

  - A basic template for an out-of-tree Linux kernel module written
    in Rust can be found in:

        https://github.com/Rust-for-Linux/rust-out-of-tree-module


## Patch series status

Like we mentioned last time, the Rust support is still to be
considered experimental. However, support is good enough that kernel
developers can start working on the Rust abstractions for subsystems
and write drivers and other modules.

The current series has just arrived in `linux-next`, thus the first
run will happen in a day. Similarly, the preview docs for this series
can be seen at:

    https://rust-for-linux.github.io/docs/kernel/


## Conferences, meetings and liaisons

We would want to thank you the venues we were invited to:

  - Open Source Summit Japan 2021


## Acknowledgements

The signatures in the main commits correspond to the people that
wrote code that has ended up in them at the present time. For details
on contributions to code and discussions, please see our repository:

    https://github.com/Rust-for-Linux/linux

However, we would like to give credit to everyone that has contributed
in one way or another to the Rust for Linux project. Since the
previous cover letter:

  - Nick Desaulniers, Masahiro Yamada and Greg Kroah-Hartman for
    their reviews & feedback on the previous round.

  - Maciej Falkowski for adding the initial common clock framework
    abstractions and the `{read,write}*_relaxed` methods to
    `IoMem<T>`.

  - Daniel Xu for improving the docs and `File`.

  - Mauro Baladés for improving the CI.

  - SeongJae Park for the `rust-next` patch to fix the `-mm` tree.

  - Hsiang-Cheng Yang for fixing a typo.

  - bjorn3 and Gary Guo for all the input on Rust compiler details
    and all the reviews and suggestions.

  - Josh Triplett for pushing `-Zsymbol-mangling-version=v0` to the
    finish line.

  - Philip Herrons (and his supporters Open Source Security and
    Embecosm) et. al. for their ongoing work on GCC Rust.

  - Antoni Boucher (and his supporters) et. al. for their ongoing
    work on `rustc_codegen_gcc`.

  - Mats Larsen, Marc Poulhiès et. al. for their ongoing work on
    improving Rust support in Compiler Explorer.

  - Many folks that have reported issues, tested the project,
    helped spread the word, joined discussions and contributed in
    other ways!

Please see also the acknowledgements on the previous cover letters.


Boqun Feng (1):
  kallsyms: use the correct buffer size for symbols

Gary Guo (2):
  rust: add `build_error` crate
  vsprintf: add new `%pA` format specifier

Miguel Ojeda (13):
  kallsyms: support "big" kernel symbols
  kallsyms: increase maximum kernel symbol length to 512
  rust: add C helpers
  rust: add `compiler_builtins` crate
  rust: add `alloc` crate
  rust: add `macros` crate
  rust: export generated symbols
  scripts: add `generate_rust_analyzer.py`
  scripts: decode_stacktrace: demangle Rust symbols
  docs: add Rust documentation
  Kbuild: add Rust support
  samples: add Rust examples
  MAINTAINERS: Rust

Wedson Almeida Filho (3):
  rust: add `kernel` crate
  [RFC] drivers: gpio: PrimeCell PL061 in Rust
  [RFC] drivers: android: Binder IPC in Rust

 .gitignore                                   |    5 +
 .rustfmt.toml                                |   12 +
 Documentation/doc-guide/kernel-doc.rst       |    3 +
 Documentation/index.rst                      |    1 +
 Documentation/kbuild/kbuild.rst              |    4 +
 Documentation/process/changes.rst            |   42 +
 Documentation/rust/arch-support.rst          |   35 +
 Documentation/rust/assets/favicon-16x16.png  |  Bin 0 -> 798 bytes
 Documentation/rust/assets/favicon-32x32.png  |  Bin 0 -> 2076 bytes
 Documentation/rust/assets/rust-logo.png      |  Bin 0 -> 53976 bytes
 Documentation/rust/coding-guidelines.rst     |  151 +
 Documentation/rust/general-information.rst   |   80 +
 Documentation/rust/index.rst                 |   21 +
 Documentation/rust/quick-start.rst           |  231 ++
 MAINTAINERS                                  |   16 +
 Makefile                                     |  152 +-
 arch/arm/rust/target.json                    |   27 +
 arch/arm64/rust/target.json                  |   34 +
 arch/powerpc/rust/target.json                |   29 +
 arch/riscv/Makefile                          |    1 +
 arch/riscv/rust/rv32ima.json                 |   36 +
 arch/riscv/rust/rv32imac.json                |   36 +
 arch/riscv/rust/rv64ima.json                 |   36 +
 arch/riscv/rust/rv64imac.json                |   36 +
 arch/x86/rust/target.json                    |   36 +
 drivers/android/Kconfig                      |    7 +
 drivers/android/Makefile                     |    2 +
 drivers/android/allocation.rs                |  266 ++
 drivers/android/context.rs                   |   80 +
 drivers/android/defs.rs                      |   99 +
 drivers/android/node.rs                      |  476 +++
 drivers/android/process.rs                   |  964 +++++
 drivers/android/range_alloc.rs               |  189 +
 drivers/android/rust_binder.rs               |  114 +
 drivers/android/thread.rs                    |  871 +++++
 drivers/android/transaction.rs               |  326 ++
 drivers/gpio/Kconfig                         |    8 +
 drivers/gpio/Makefile                        |    1 +
 drivers/gpio/gpio_pl061_rust.rs              |  362 ++
 include/linux/kallsyms.h                     |    2 +-
 include/linux/spinlock.h                     |   17 +-
 include/uapi/linux/android/binder.h          |   28 +-
 init/Kconfig                                 |   44 +-
 kernel/kallsyms.c                            |   26 +-
 kernel/livepatch/core.c                      |    4 +-
 kernel/printk/printk.c                       |    5 +-
 lib/Kconfig.debug                            |  144 +
 lib/rust.h                                   |   14 +
 lib/vsprintf.c                               |    7 +
 rust/.gitignore                              |    7 +
 rust/Makefile                                |  352 ++
 rust/alloc/README.md                         |   32 +
 rust/alloc/alloc.rs                          |  427 +++
 rust/alloc/borrow.rs                         |  498 +++
 rust/alloc/boxed.rs                          | 1847 ++++++++++
 rust/alloc/collections/mod.rs                |  156 +
 rust/alloc/fmt.rs                            |  601 ++++
 rust/alloc/lib.rs                            |  217 ++
 rust/alloc/macros.rs                         |  126 +
 rust/alloc/raw_vec.rs                        |  549 +++
 rust/alloc/slice.rs                          | 1279 +++++++
 rust/alloc/str.rs                            |  624 ++++
 rust/alloc/string.rs                         | 2864 +++++++++++++++
 rust/alloc/vec/drain.rs                      |  159 +
 rust/alloc/vec/drain_filter.rs               |  145 +
 rust/alloc/vec/into_iter.rs                  |  356 ++
 rust/alloc/vec/is_zero.rs                    |  106 +
 rust/alloc/vec/mod.rs                        | 3359 ++++++++++++++++++
 rust/alloc/vec/partial_eq.rs                 |   49 +
 rust/alloc/vec/set_len_on_drop.rs            |   30 +
 rust/alloc/vec/spec_extend.rs                |  172 +
 rust/bindgen_parameters                      |   13 +
 rust/build_error.rs                          |   29 +
 rust/compiler_builtins.rs                    |   57 +
 rust/exports.c                               |   16 +
 rust/helpers.c                               |  508 +++
 rust/kernel/allocator.rs                     |   65 +
 rust/kernel/amba.rs                          |  259 ++
 rust/kernel/bindings.rs                      |   47 +
 rust/kernel/bindings_helper.h                |   31 +
 rust/kernel/buffer.rs                        |   52 +
 rust/kernel/build_assert.rs                  |   80 +
 rust/kernel/c_types.rs                       |  119 +
 rust/kernel/chrdev.rs                        |  209 ++
 rust/kernel/clk.rs                           |   75 +
 rust/kernel/cred.rs                          |   73 +
 rust/kernel/device.rs                        |  549 +++
 rust/kernel/driver.rs                        |  440 +++
 rust/kernel/error.rs                         |  542 +++
 rust/kernel/file.rs                          |  147 +
 rust/kernel/file_operations.rs               |  726 ++++
 rust/kernel/gpio.rs                          |  477 +++
 rust/kernel/io_buffer.rs                     |  153 +
 rust/kernel/io_mem.rs                        |  227 ++
 rust/kernel/iov_iter.rs                      |   81 +
 rust/kernel/irq.rs                           |  409 +++
 rust/kernel/lib.rs                           |  262 ++
 rust/kernel/linked_list.rs                   |  247 ++
 rust/kernel/miscdev.rs                       |  196 +
 rust/kernel/module_param.rs                  |  497 +++
 rust/kernel/of.rs                            |   63 +
 rust/kernel/pages.rs                         |  162 +
 rust/kernel/platform.rs                      |  224 ++
 rust/kernel/power.rs                         |  118 +
 rust/kernel/prelude.rs                       |   36 +
 rust/kernel/print.rs                         |  441 +++
 rust/kernel/random.rs                        |   50 +
 rust/kernel/raw_list.rs                      |  361 ++
 rust/kernel/rbtree.rs                        |  562 +++
 rust/kernel/revocable.rs                     |  163 +
 rust/kernel/security.rs                      |   36 +
 rust/kernel/static_assert.rs                 |   39 +
 rust/kernel/std_vendor.rs                    |  150 +
 rust/kernel/str.rs                           |  375 ++
 rust/kernel/sync/arc.rs                      |  500 +++
 rust/kernel/sync/condvar.rs                  |  138 +
 rust/kernel/sync/guard.rs                    |  181 +
 rust/kernel/sync/locked_by.rs                |  112 +
 rust/kernel/sync/mod.rs                      |   92 +
 rust/kernel/sync/mutex.rs                    |  112 +
 rust/kernel/sync/revocable_mutex.rs          |  184 +
 rust/kernel/sync/seqlock.rs                  |  202 ++
 rust/kernel/sync/spinlock.rs                 |  180 +
 rust/kernel/sysctl.rs                        |  197 +
 rust/kernel/task.rs                          |  182 +
 rust/kernel/types.rs                         |  486 +++
 rust/kernel/user_ptr.rs                      |  175 +
 rust/macros/helpers.rs                       |   79 +
 rust/macros/lib.rs                           |   94 +
 rust/macros/module.rs                        |  622 ++++
 samples/Kconfig                              |    2 +
 samples/Makefile                             |    1 +
 samples/rust/Kconfig                         |  123 +
 samples/rust/Makefile                        |   13 +
 samples/rust/rust_chrdev.rs                  |   53 +
 samples/rust/rust_minimal.rs                 |   38 +
 samples/rust/rust_miscdev.rs                 |  147 +
 samples/rust/rust_module_parameters.rs       |   72 +
 samples/rust/rust_platform.rs                |   25 +
 samples/rust/rust_print.rs                   |   57 +
 samples/rust/rust_random.rs                  |   64 +
 samples/rust/rust_semaphore.rs               |  175 +
 samples/rust/rust_semaphore_c.c              |  212 ++
 samples/rust/rust_stack_probing.rs           |   40 +
 samples/rust/rust_sync.rs                    |   81 +
 scripts/Kconfig.include                      |    6 +-
 scripts/Makefile.build                       |   22 +
 scripts/Makefile.debug                       |   10 +
 scripts/Makefile.lib                         |   12 +
 scripts/Makefile.modfinal                    |    8 +-
 scripts/cc-version.sh                        |   12 +-
 scripts/decode_stacktrace.sh                 |   14 +
 scripts/generate_rust_analyzer.py            |  133 +
 scripts/is_rust_module.sh                    |   19 +
 scripts/kallsyms.c                           |   40 +-
 scripts/kconfig/confdata.c                   |   75 +
 scripts/min-tool-version.sh                  |    6 +
 scripts/rust-is-available-bindgen-libclang.h |    2 +
 scripts/rust-is-available.sh                 |  159 +
 tools/include/linux/kallsyms.h               |    2 +-
 tools/lib/perf/include/perf/event.h          |    2 +-
 tools/lib/symbol/kallsyms.h                  |    2 +-
 162 files changed, 33506 insertions(+), 58 deletions(-)
 create mode 100644 .rustfmt.toml
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/assets/favicon-16x16.png
 create mode 100644 Documentation/rust/assets/favicon-32x32.png
 create mode 100644 Documentation/rust/assets/rust-logo.png
 create mode 100644 Documentation/rust/coding-guidelines.rst
 create mode 100644 Documentation/rust/general-information.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst
 create mode 100644 arch/arm/rust/target.json
 create mode 100644 arch/arm64/rust/target.json
 create mode 100644 arch/powerpc/rust/target.json
 create mode 100644 arch/riscv/rust/rv32ima.json
 create mode 100644 arch/riscv/rust/rv32imac.json
 create mode 100644 arch/riscv/rust/rv64ima.json
 create mode 100644 arch/riscv/rust/rv64imac.json
 create mode 100644 arch/x86/rust/target.json
 create mode 100644 drivers/android/allocation.rs
 create mode 100644 drivers/android/context.rs
 create mode 100644 drivers/android/defs.rs
 create mode 100644 drivers/android/node.rs
 create mode 100644 drivers/android/process.rs
 create mode 100644 drivers/android/range_alloc.rs
 create mode 100644 drivers/android/rust_binder.rs
 create mode 100644 drivers/android/thread.rs
 create mode 100644 drivers/android/transaction.rs
 create mode 100644 drivers/gpio/gpio_pl061_rust.rs
 create mode 100644 lib/rust.h
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Makefile
 create mode 100644 rust/alloc/README.md
 create mode 100644 rust/alloc/alloc.rs
 create mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/alloc/boxed.rs
 create mode 100644 rust/alloc/collections/mod.rs
 create mode 100644 rust/alloc/fmt.rs
 create mode 100644 rust/alloc/lib.rs
 create mode 100644 rust/alloc/macros.rs
 create mode 100644 rust/alloc/raw_vec.rs
 create mode 100644 rust/alloc/slice.rs
 create mode 100644 rust/alloc/str.rs
 create mode 100644 rust/alloc/string.rs
 create mode 100644 rust/alloc/vec/drain.rs
 create mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/into_iter.rs
 create mode 100644 rust/alloc/vec/is_zero.rs
 create mode 100644 rust/alloc/vec/mod.rs
 create mode 100644 rust/alloc/vec/partial_eq.rs
 create mode 100644 rust/alloc/vec/set_len_on_drop.rs
 create mode 100644 rust/alloc/vec/spec_extend.rs
 create mode 100644 rust/bindgen_parameters
 create mode 100644 rust/build_error.rs
 create mode 100644 rust/compiler_builtins.rs
 create mode 100644 rust/exports.c
 create mode 100644 rust/helpers.c
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/amba.rs
 create mode 100644 rust/kernel/bindings.rs
 create mode 100644 rust/kernel/bindings_helper.h
 create mode 100644 rust/kernel/buffer.rs
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/c_types.rs
 create mode 100644 rust/kernel/chrdev.rs
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cred.rs
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/file_operations.rs
 create mode 100644 rust/kernel/gpio.rs
 create mode 100644 rust/kernel/io_buffer.rs
 create mode 100644 rust/kernel/io_mem.rs
 create mode 100644 rust/kernel/iov_iter.rs
 create mode 100644 rust/kernel/irq.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/linked_list.rs
 create mode 100644 rust/kernel/miscdev.rs
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/of.rs
 create mode 100644 rust/kernel/pages.rs
 create mode 100644 rust/kernel/platform.rs
 create mode 100644 rust/kernel/power.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/random.rs
 create mode 100644 rust/kernel/raw_list.rs
 create mode 100644 rust/kernel/rbtree.rs
 create mode 100644 rust/kernel/revocable.rs
 create mode 100644 rust/kernel/security.rs
 create mode 100644 rust/kernel/static_assert.rs
 create mode 100644 rust/kernel/std_vendor.rs
 create mode 100644 rust/kernel/str.rs
 create mode 100644 rust/kernel/sync/arc.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/guard.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/sync/mod.rs
 create mode 100644 rust/kernel/sync/mutex.rs
 create mode 100644 rust/kernel/sync/revocable_mutex.rs
 create mode 100644 rust/kernel/sync/seqlock.rs
 create mode 100644 rust/kernel/sync/spinlock.rs
 create mode 100644 rust/kernel/sysctl.rs
 create mode 100644 rust/kernel/task.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/kernel/user_ptr.rs
 create mode 100644 rust/macros/helpers.rs
 create mode 100644 rust/macros/lib.rs
 create mode 100644 rust/macros/module.rs
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/rust_chrdev.rs
 create mode 100644 samples/rust/rust_minimal.rs
 create mode 100644 samples/rust/rust_miscdev.rs
 create mode 100644 samples/rust/rust_module_parameters.rs
 create mode 100644 samples/rust/rust_platform.rs
 create mode 100644 samples/rust/rust_print.rs
 create mode 100644 samples/rust/rust_random.rs
 create mode 100644 samples/rust/rust_semaphore.rs
 create mode 100644 samples/rust/rust_semaphore_c.c
 create mode 100644 samples/rust/rust_stack_probing.rs
 create mode 100644 samples/rust/rust_sync.rs
 create mode 100755 scripts/generate_rust_analyzer.py
 create mode 100755 scripts/is_rust_module.sh
 create mode 100644 scripts/rust-is-available-bindgen-libclang.h
 create mode 100755 scripts/rust-is-available.sh

-- 
2.34.1

