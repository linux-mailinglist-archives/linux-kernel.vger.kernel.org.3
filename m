Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E164697BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbhLFOIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:08:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59358 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbhLFOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:08:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF29612D0;
        Mon,  6 Dec 2021 14:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B97C341C2;
        Mon,  6 Dec 2021 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799520;
        bh=U+nFFMlovDiK2XFO14MdOmwB2XgJmbN1pY/r0iMfD2E=;
        h=From:To:Cc:Subject:Date:From;
        b=r6+xdTpqHlge8t7GqfziA8Rd/l5cKO4ArFzD3BLKJmbRfLNU+iQpMaMWG7qdovEG8
         GUDUJZq8OItFNgZCww5z/QMIN4kbrU+Z4Xr9M800IAHB5azmveO/YPltus7HhLUcrl
         MS+gNk/tM7pNT1niJifOQZb/E+s1z3kgz+x8P3TLYkjlVfpikUcEkK4tnGL/1wQU6Y
         FtZhvOEvDUNQoqNtxQLvEStbtqwJ3OMs0w976A0x2bW7ytJ3BJwM63QSkb8qECJyZD
         KXXGwmKc+brbaQ27M+Yh7yfjo11o97vMDt2MdGfAjz0qitF/WwnnD1Ja0b1Rj5ag82
         vRSw4gEWLwGUw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 00/19] Rust support
Date:   Mon,  6 Dec 2021 15:02:54 +0100
Message-Id: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rust support

This is the patch series (v2) to add support for Rust as a second
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
v1, plus a few extra notes and news. For the previous cover letters,
please see:

  RFC: https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/
  v1:  https://lore.kernel.org/lkml/20210704202756.29107-1-ojeda@kernel.org/


## Infrastructure updates

There have been several improvements to the overall Rust support.
The following sections cover some of these.


### Stable compiler & Rust Edition 2021

We moved from the beta Rust compiler to using stable releases,
migrating each time a new one gets released. Currently we just moved
to Rust 1.57.0, released last Thursday.

By upgrading the compiler, we have been able to take off the list
a few unstable features we were using: `const_fn_transmute`,
`const_panic`, `const_unreachable_unchecked`, `core_panic` and
`try_reserve`. For an up-to-date list on the features and other
wishlists we have, please see:

    https://github.com/Rust-for-Linux/linux/issues/2

We will keep upgrading until we do not rely on any unstable features;
at which point we may want to start declaring a minimum Rust version
is supported, like it is done for e.g. GCC and Clang.

Similarly, we also migrated to the 2021 edition of the Rust language.


### Customizing `core` and `alloc`

We added a couple more "modularization" options to `alloc` in order
to disable some features we do not need: `no_rc` and `no_sync`.

We would like to thank upstream Rust for working with us on
upstreaming these so that the kernel use case is well supported
(or, more precisely, the "combination" of options the kernel needs).

Upstream `core` has added `no_fp_fmt_parse` too, which we are using.


### Stricter code, docs and new lints

Following the `CONFIG_WERROR` discussions, we are trying to do our
bit by making the option apply to Rust code and having our CI build
with it enabled.

We also enabled a bunch of extra Rust compiler diagnostics and Clippy
lints. We may need to disable some of them in the future if they
prove too noisy or disruptive, but we think this is the best time
to try them out. For instance, one of them checks that no unreachable
public items are present.

One difference with respect to C here is that Rust diagnostics are
slightly more natural to disable within code, which we may allow us to
be more strict in the general case.


## Abstractions and driver updates

We added abstractions for sequence locks, power management callbacks,
io memory (`readX`/`writeX`), irq chips & high-level flow handlers,
gpio chips (including irq ones), devices, amba devices & drivers and
credentials.

There is improved driver support with bus-independent infrastructure,
revocable objects, revocable mutexes, efficient bit iterators, better
panic diagnostics and simplified pointer wrappers.

In addition, we improved and simplified `Ref` (`refcount_t`-backed)
objects and replaced all instances of Rust's `Arc` by it. Completely
removed `Arc` and `Rc` from the `alloc` crate.

A new driver for PL061 gpio devices was implemented and is submitted
as an RFC patch.


## Patch series status

Like we mentioned last time, the Rust support is still to be
considered experimental. However, support is good enough that kernel
developers can start working on the Rust abstractions for subsystems
and write drivers and other modules.

The current series has just arrived in `linux-next`, thus the first
run will happen in a day. Similarly, the preview docs for this series
can be seen at:

    https://rust-for-linux.github.io/docs/kernel/

From now on, we will also start submitting the patches regularly,
every two weeks or so.


## Industry and academia support

In addition to the statements from Arm, Google and Microsoft from
the previous cover letter, we have one from Red Hat this time:

  There is interest in using Rust for kernel work that Red Hat
  is considering.


## Conferences, meetings and liaisons

Kangrejos, the Rust for Linux conference we announced last time,
took place before LPC (made possible by Jonathan Corbet et. al. and
LPC's infrastructure). Thanks everyone that joined!

    https://kangrejos.com

We would also want to thank you the venues we were invited to:

  - Linaro Virtual Connect 2021 Fall
  - Clang Built Linux Meetup II turbo
  - Linux Plumbers Conference 2021 (quite a few Rust-related talks
    from us and others as well!)
  - Samsung Engineering Summit 2021
  - Linux Foundation Live Mentorship Series

There will also be a talk in the Open Source Summit Japan this month.

We also want to thank Niko Matsakis and the Rust CTCFT (Cross Team
Collaboration Fun Times) team for inviting us to present our work
and our needs from Rust.


## Other related news

### `rustc_codegen_gcc` merged

The GCC backend for the Rust compiler (through `libgccjit`, although
used for ahead-of-time compilation) was merged into upstream Rust:

    https://github.com/rust-lang/rustc_codegen_gcc

If the backend keeps progressing, we hope to soon be able to start
experimenting with compiling the Rust side of the kernel with GCC!


### Compiler Explorer improvements

This useful online tool added support for `rustc_codegen_gcc`.
Together with GCC Rust and `mrustc`, the site now supports all the
alternative Rust compilers. See a live example at:

    https://godbolt.org/z/6br9Ef73E

They are also adding further options for Rust we requested, e.g. MIR
and macro expansion views are already live on the site.


## Acknowledgements

The signatures in the main commits correspond to the people that
wrote code that has ended up in them at the present time. For details
on contributions to code and discussions, please see our repository:

    https://github.com/Rust-for-Linux/linux

However, we would like to give credit to everyone that has contributed
in one way or another to the Rust for Linux project. Since the v1:

  - bjorn3 and Gary Guo for all the input on Rust compiler details
    and all the reviews and suggestions.

  - Jonathan Corbet and the LPC organizers for lending us the Linux
    Plumbers Conference infrastructure so that we could have an easy
    time setting up Kangrejos.

  - Josh Triplett for reviewing the Rust CTCFT presentation.

  - Robin Randhawa for reviewing the Linaro Connect presentation.

  - Viresh Kumar for his work on adding Rust bindings to `libgpiod`.

  - Philip Herrons (and his supporters Open Source Security and
    Embecosm) et. al. for their ongoing work on GCC Rust.

  - Antoni Boucher (and his supporters) et. al. for their ongoing
    work on `rustc_codegen_gcc`.

  - Mats Larsen, Marc Poulhiès et. al. for their ongoing work on
    improving Rust support in Compiler Explorer.

  - All the Rust and LLVM contributors taking a look into codegen
    and other issues we have raised.

  - Many folks that have reported issues, tested the project,
    helped spread the word, joined discussions and contributed in
    other ways!

Please also see the acknowledgements on the previous cover letters.


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

 .gitignore                                  |    5 +
 .rustfmt.toml                               |   12 +
 Documentation/doc-guide/kernel-doc.rst      |    3 +
 Documentation/index.rst                     |    1 +
 Documentation/kbuild/kbuild.rst             |    4 +
 Documentation/process/changes.rst           |   13 +
 Documentation/rust/arch-support.rst         |   35 +
 Documentation/rust/assets/favicon-16x16.png |  Bin 0 -> 798 bytes
 Documentation/rust/assets/favicon-32x32.png |  Bin 0 -> 2076 bytes
 Documentation/rust/assets/rust-logo.png     |  Bin 0 -> 53976 bytes
 Documentation/rust/coding.rst               |   91 +
 Documentation/rust/docs.rst                 |  101 +
 Documentation/rust/index.rst                |   21 +
 Documentation/rust/quick-start.rst          |  212 ++
 MAINTAINERS                                 |   14 +
 Makefile                                    |  146 +-
 arch/arm/rust/target.json                   |   27 +
 arch/arm64/rust/target.json                 |   34 +
 arch/powerpc/rust/target.json               |   29 +
 arch/riscv/Makefile                         |    1 +
 arch/riscv/rust/rv32ima.json                |   36 +
 arch/riscv/rust/rv32imac.json               |   36 +
 arch/riscv/rust/rv64ima.json                |   36 +
 arch/riscv/rust/rv64imac.json               |   36 +
 arch/x86/rust/target.json                   |   36 +
 drivers/android/Kconfig                     |    7 +
 drivers/android/Makefile                    |    2 +
 drivers/android/allocation.rs               |  266 ++
 drivers/android/context.rs                  |   79 +
 drivers/android/defs.rs                     |   99 +
 drivers/android/node.rs                     |  476 +++
 drivers/android/process.rs                  |  964 ++++++
 drivers/android/range_alloc.rs              |  189 ++
 drivers/android/rust_binder.rs              |  114 +
 drivers/android/thread.rs                   |  871 +++++
 drivers/android/transaction.rs              |  326 ++
 drivers/gpio/Kconfig                        |    8 +
 drivers/gpio/Makefile                       |    1 +
 drivers/gpio/gpio_pl061_rust.rs             |  362 ++
 include/linux/kallsyms.h                    |    2 +-
 include/linux/spinlock.h                    |   17 +-
 include/uapi/linux/android/binder.h         |   28 +-
 init/Kconfig                                |   31 +-
 kernel/kallsyms.c                           |   26 +-
 kernel/livepatch/core.c                     |    4 +-
 kernel/printk/printk.c                      |    5 +-
 lib/Kconfig.debug                           |  144 +
 lib/vsprintf.c                              |   12 +
 rust/.gitignore                             |    7 +
 rust/Makefile                               |  353 ++
 rust/alloc/README.md                        |   32 +
 rust/alloc/alloc.rs                         |  424 +++
 rust/alloc/borrow.rs                        |  498 +++
 rust/alloc/boxed.rs                         | 1844 ++++++++++
 rust/alloc/collections/mod.rs               |  155 +
 rust/alloc/fmt.rs                           |  583 ++++
 rust/alloc/lib.rs                           |  212 ++
 rust/alloc/macros.rs                        |  126 +
 rust/alloc/raw_vec.rs                       |  612 ++++
 rust/alloc/slice.rs                         | 1275 +++++++
 rust/alloc/str.rs                           |  621 ++++
 rust/alloc/string.rs                        | 2857 ++++++++++++++++
 rust/alloc/vec/drain.rs                     |  158 +
 rust/alloc/vec/drain_filter.rs              |  145 +
 rust/alloc/vec/into_iter.rs                 |  356 ++
 rust/alloc/vec/is_zero.rs                   |  106 +
 rust/alloc/vec/mod.rs                       | 3327 +++++++++++++++++++
 rust/alloc/vec/partial_eq.rs                |   49 +
 rust/alloc/vec/set_len_on_drop.rs           |   30 +
 rust/alloc/vec/spec_extend.rs               |  172 +
 rust/bindgen_parameters                     |   13 +
 rust/build_error.rs                         |   29 +
 rust/compiler_builtins.rs                   |   57 +
 rust/exports.c                              |   16 +
 rust/helpers.c                              |  436 +++
 rust/kernel/allocator.rs                    |   65 +
 rust/kernel/amba.rs                         |  276 ++
 rust/kernel/bindings.rs                     |   47 +
 rust/kernel/bindings_helper.h               |   30 +
 rust/kernel/buffer.rs                       |   52 +
 rust/kernel/build_assert.rs                 |   80 +
 rust/kernel/c_types.rs                      |  119 +
 rust/kernel/chrdev.rs                       |  212 ++
 rust/kernel/cred.rs                         |   73 +
 rust/kernel/device.rs                       |  206 ++
 rust/kernel/driver.rs                       |  198 ++
 rust/kernel/error.rs                        |  542 +++
 rust/kernel/file.rs                         |  141 +
 rust/kernel/file_operations.rs              |  723 ++++
 rust/kernel/gpio.rs                         |  475 +++
 rust/kernel/io_buffer.rs                    |  153 +
 rust/kernel/io_mem.rs                       |  207 ++
 rust/kernel/iov_iter.rs                     |   81 +
 rust/kernel/irq.rs                          |  408 +++
 rust/kernel/lib.rs                          |  256 ++
 rust/kernel/linked_list.rs                  |  247 ++
 rust/kernel/miscdev.rs                      |  166 +
 rust/kernel/module_param.rs                 |  497 +++
 rust/kernel/of.rs                           |  101 +
 rust/kernel/pages.rs                        |  162 +
 rust/kernel/platdev.rs                      |  152 +
 rust/kernel/power.rs                        |  118 +
 rust/kernel/prelude.rs                      |   33 +
 rust/kernel/print.rs                        |  441 +++
 rust/kernel/random.rs                       |   50 +
 rust/kernel/raw_list.rs                     |  361 ++
 rust/kernel/rbtree.rs                       |  562 ++++
 rust/kernel/revocable.rs                    |  163 +
 rust/kernel/security.rs                     |   36 +
 rust/kernel/static_assert.rs                |   39 +
 rust/kernel/std_vendor.rs                   |  150 +
 rust/kernel/str.rs                          |  375 +++
 rust/kernel/sync/arc.rs                     |  500 +++
 rust/kernel/sync/condvar.rs                 |  137 +
 rust/kernel/sync/guard.rs                   |  181 +
 rust/kernel/sync/locked_by.rs               |  112 +
 rust/kernel/sync/mod.rs                     |   92 +
 rust/kernel/sync/mutex.rs                   |  111 +
 rust/kernel/sync/revocable_mutex.rs         |  184 +
 rust/kernel/sync/seqlock.rs                 |  201 ++
 rust/kernel/sync/spinlock.rs                |  180 +
 rust/kernel/sysctl.rs                       |  197 ++
 rust/kernel/task.rs                         |  182 +
 rust/kernel/types.rs                        |  486 +++
 rust/kernel/user_ptr.rs                     |  175 +
 rust/macros/helpers.rs                      |   79 +
 rust/macros/lib.rs                          |   94 +
 rust/macros/module.rs                       |  622 ++++
 samples/Kconfig                             |    2 +
 samples/Makefile                            |    1 +
 samples/rust/Kconfig                        |  113 +
 samples/rust/Makefile                       |   12 +
 samples/rust/rust_chrdev.rs                 |   50 +
 samples/rust/rust_minimal.rs                |   38 +
 samples/rust/rust_miscdev.rs                |  149 +
 samples/rust/rust_module_parameters.rs      |   72 +
 samples/rust/rust_print.rs                  |   57 +
 samples/rust/rust_random.rs                 |   61 +
 samples/rust/rust_semaphore.rs              |  174 +
 samples/rust/rust_semaphore_c.c             |  212 ++
 samples/rust/rust_stack_probing.rs          |   40 +
 samples/rust/rust_sync.rs                   |   81 +
 scripts/Makefile.build                      |   22 +
 scripts/Makefile.debug                      |   10 +
 scripts/Makefile.lib                        |   12 +
 scripts/Makefile.modfinal                   |    8 +-
 scripts/decode_stacktrace.sh                |   14 +
 scripts/generate_rust_analyzer.py           |  133 +
 scripts/is_rust_module.sh                   |   19 +
 scripts/kallsyms.c                          |   40 +-
 scripts/kconfig/confdata.c                  |   75 +
 scripts/rust-version.sh                     |   31 +
 tools/include/linux/kallsyms.h              |    2 +-
 tools/include/linux/lockdep.h               |    2 +-
 tools/lib/perf/include/perf/event.h         |    2 +-
 tools/lib/symbol/kallsyms.h                 |    2 +-
 156 files changed, 32369 insertions(+), 50 deletions(-)
 create mode 100644 .rustfmt.toml
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/assets/favicon-16x16.png
 create mode 100644 Documentation/rust/assets/favicon-32x32.png
 create mode 100644 Documentation/rust/assets/rust-logo.png
 create mode 100644 Documentation/rust/coding.rst
 create mode 100644 Documentation/rust/docs.rst
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
 create mode 100644 rust/kernel/platdev.rs
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
 create mode 100644 samples/rust/rust_print.rs
 create mode 100644 samples/rust/rust_random.rs
 create mode 100644 samples/rust/rust_semaphore.rs
 create mode 100644 samples/rust/rust_semaphore_c.c
 create mode 100644 samples/rust/rust_stack_probing.rs
 create mode 100644 samples/rust/rust_sync.rs
 create mode 100755 scripts/generate_rust_analyzer.py
 create mode 100755 scripts/is_rust_module.sh
 create mode 100755 scripts/rust-version.sh

-- 
2.34.0

