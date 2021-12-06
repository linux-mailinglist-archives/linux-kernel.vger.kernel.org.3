Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E415C4697FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbhLFOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60022 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245501AbhLFOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 539B6612D5;
        Mon,  6 Dec 2021 14:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55326C341C6;
        Mon,  6 Dec 2021 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799577;
        bh=vbo400VvG70VmVO0c1fHxdYCTThG7ymXdDT5Rxgnj/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jglx2R2W3TPsM8w3YF3aN3tL9E2D8JjYM5DsnL4586y47/IYDCz8PjuusksiQxygP
         KqnOM2pSjug3XlAosiVGtRF9SaQ8wqV9lOmga/lzYgRRjPHm9jZx/TF2bDROlJYbBQ
         H4leyjzNDtwh7Z/DkRaWWC4CF87RHSc63UrT7fN6WuuC3BerXytnlm3vllQ3u/06NJ
         RYdDGBOheyQRMzvDEHLH2MBBP02cX8fhB6MHs+H72zh2tLGSWX6m4cR83UnY/xr9nN
         WAAQJVscPw8C0rw+ObE4M/CYYKqE6qF+d2LI9kpecPRjSW99rg0kfEKDGzP8WCZHuH
         TIwOupCI9gMxg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>,
        Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH 16/19] samples: add Rust examples
Date:   Mon,  6 Dec 2021 15:03:10 +0100
Message-Id: <20211206140313.5653-17-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of Rust modules that showcase how Rust modules look like
and how to use the abstracted kernel features.

These samples also double as tests in the CI.

The semaphore sample comes with a C version for comparison.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Signed-off-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 samples/Kconfig                        |   2 +
 samples/Makefile                       |   1 +
 samples/rust/Kconfig                   | 113 +++++++++++++
 samples/rust/Makefile                  |  12 ++
 samples/rust/rust_chrdev.rs            |  50 ++++++
 samples/rust/rust_minimal.rs           |  38 +++++
 samples/rust/rust_miscdev.rs           | 149 +++++++++++++++++
 samples/rust/rust_module_parameters.rs |  72 +++++++++
 samples/rust/rust_print.rs             |  57 +++++++
 samples/rust/rust_random.rs            |  61 +++++++
 samples/rust/rust_semaphore.rs         | 174 ++++++++++++++++++++
 samples/rust/rust_semaphore_c.c        | 212 +++++++++++++++++++++++++
 samples/rust/rust_stack_probing.rs     |  40 +++++
 samples/rust/rust_sync.rs              |  81 ++++++++++
 14 files changed, 1062 insertions(+)
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

diff --git a/samples/Kconfig b/samples/Kconfig
index 43d2e9aa557f..a3a5166837b1 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -241,6 +241,8 @@ config SAMPLE_WATCH_QUEUE
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 
+source "samples/rust/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 4bcd6b93bffa..d66f49a9f080 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
new file mode 100644
index 000000000000..183a3c4dc80c
--- /dev/null
+++ b/samples/rust/Kconfig
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig SAMPLES_RUST
+	bool "Rust samples"
+	depends on RUST
+	help
+	  You can build sample Rust kernel code here.
+
+	  If unsure, say N.
+
+if SAMPLES_RUST
+
+config SAMPLE_RUST_MINIMAL
+	tristate "Minimal"
+	help
+	  This option builds the Rust minimal module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_minimal.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_PRINT
+	tristate "Printing macros"
+	help
+	  This option builds the Rust printing macros sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_print.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_MODULE_PARAMETERS
+	tristate "Module parameters"
+	help
+	  This option builds the Rust module parameters sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_module_parameters.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_SYNC
+	tristate "Synchronisation primitives"
+	help
+	  This option builds the Rust synchronisation primitives sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_sync.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_CHRDEV
+	tristate "Character device"
+	help
+	  This option builds the Rust character device sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_chrdev.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_MISCDEV
+	tristate "Miscellaneous device"
+	help
+	  This option builds the Rust miscellaneous device sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_miscdev.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_STACK_PROBING
+	tristate "Stack probing"
+	help
+	  This option builds the Rust stack probing sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_stack_probing.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_SEMAPHORE
+	tristate "Semaphore"
+	help
+	  This option builds the Rust semaphore sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_semaphore.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_SEMAPHORE_C
+	tristate "Semaphore (in C, for comparison)"
+	help
+	  This option builds the Rust semaphore sample (in C, for comparison).
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_semaphore_c.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_RANDOM
+	tristate "Random"
+	help
+	  This option builds the Rust random sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_random.
+
+	  If unsure, say N.
+
+endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
new file mode 100644
index 000000000000..48bc871ea1f8
--- /dev/null
+++ b/samples/rust/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_MODULE_PARAMETERS)	+= rust_module_parameters.o
+obj-$(CONFIG_SAMPLE_RUST_SYNC)			+= rust_sync.o
+obj-$(CONFIG_SAMPLE_RUST_CHRDEV)		+= rust_chrdev.o
+obj-$(CONFIG_SAMPLE_RUST_MISCDEV)		+= rust_miscdev.o
+obj-$(CONFIG_SAMPLE_RUST_STACK_PROBING)		+= rust_stack_probing.o
+obj-$(CONFIG_SAMPLE_RUST_SEMAPHORE)		+= rust_semaphore.o
+obj-$(CONFIG_SAMPLE_RUST_SEMAPHORE_C)		+= rust_semaphore_c.o
+obj-$(CONFIG_SAMPLE_RUST_RANDOM)		+= rust_random.o
diff --git a/samples/rust/rust_chrdev.rs b/samples/rust/rust_chrdev.rs
new file mode 100644
index 000000000000..5a37c59019d7
--- /dev/null
+++ b/samples/rust/rust_chrdev.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust character device sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+use kernel::{chrdev, file_operations::FileOperations};
+
+module! {
+    type: RustChrdev,
+    name: b"rust_chrdev",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust character device sample",
+    license: b"GPL v2",
+}
+
+#[derive(Default)]
+struct RustFile;
+
+impl FileOperations for RustFile {
+    kernel::declare_file_operations!();
+}
+
+struct RustChrdev {
+    _dev: Pin<Box<chrdev::Registration<2>>>,
+}
+
+impl KernelModule for RustChrdev {
+    fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust character device sample (init)\n");
+
+        let mut chrdev_reg = chrdev::Registration::new_pinned(name, 0, module)?;
+
+        // Register the same kind of device twice, we're just demonstrating
+        // that you can use multiple minors. There are two minors in this case
+        // because its type is `chrdev::Registration<2>`
+        chrdev_reg.as_mut().register::<RustFile>()?;
+        chrdev_reg.as_mut().register::<RustFile>()?;
+
+        Ok(RustChrdev { _dev: chrdev_reg })
+    }
+}
+
+impl Drop for RustChrdev {
+    fn drop(&mut self) {
+        pr_info!("Rust character device sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
new file mode 100644
index 000000000000..3276dbe8ae94
--- /dev/null
+++ b/samples/rust/rust_minimal.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+
+module! {
+    type: RustMinimal,
+    name: b"rust_minimal",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust minimal sample",
+    license: b"GPL v2",
+}
+
+struct RustMinimal {
+    message: String,
+}
+
+impl KernelModule for RustMinimal {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust minimal sample (init)\n");
+        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+
+        Ok(RustMinimal {
+            message: "on the heap!".try_to_owned()?,
+        })
+    }
+}
+
+impl Drop for RustMinimal {
+    fn drop(&mut self) {
+        pr_info!("My message is {}\n", self.message);
+        pr_info!("Rust minimal sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_miscdev.rs b/samples/rust/rust_miscdev.rs
new file mode 100644
index 000000000000..65dd40027524
--- /dev/null
+++ b/samples/rust/rust_miscdev.rs
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust miscellaneous device sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+use kernel::{
+    file::File,
+    file_operations::{FileOpener, FileOperations},
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    miscdev,
+    sync::{CondVar, Mutex, Ref, RefBorrow, UniqueRef},
+};
+
+module! {
+    type: RustMiscdev,
+    name: b"rust_miscdev",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust miscellaneous device sample",
+    license: b"GPL v2",
+}
+
+const MAX_TOKENS: usize = 3;
+
+struct SharedStateInner {
+    token_count: usize,
+}
+
+struct SharedState {
+    state_changed: CondVar,
+    inner: Mutex<SharedStateInner>,
+}
+
+impl SharedState {
+    fn try_new() -> Result<Ref<Self>> {
+        let mut state = Pin::from(UniqueRef::try_new(Self {
+            // SAFETY: `condvar_init!` is called below.
+            state_changed: unsafe { CondVar::new() },
+            // SAFETY: `mutex_init!` is called below.
+            inner: unsafe { Mutex::new(SharedStateInner { token_count: 0 }) },
+        })?);
+
+        // SAFETY: `state_changed` is pinned when `state` is.
+        let pinned = unsafe { state.as_mut().map_unchecked_mut(|s| &mut s.state_changed) };
+        kernel::condvar_init!(pinned, "SharedState::state_changed");
+
+        // SAFETY: `inner` is pinned when `state` is.
+        let pinned = unsafe { state.as_mut().map_unchecked_mut(|s| &mut s.inner) };
+        kernel::mutex_init!(pinned, "SharedState::inner");
+
+        Ok(state.into())
+    }
+}
+
+struct Token;
+
+impl FileOpener<Ref<SharedState>> for Token {
+    fn open(shared: &Ref<SharedState>, _file: &File) -> Result<Self::Wrapper> {
+        Ok(shared.clone())
+    }
+}
+
+impl FileOperations for Token {
+    type Wrapper = Ref<SharedState>;
+
+    kernel::declare_file_operations!(read, write);
+
+    fn read(
+        shared: RefBorrow<'_, SharedState>,
+        _: &File,
+        data: &mut impl IoBufferWriter,
+        offset: u64,
+    ) -> Result<usize> {
+        // Succeed if the caller doesn't provide a buffer or if not at the start.
+        if data.is_empty() || offset != 0 {
+            return Ok(0);
+        }
+
+        {
+            let mut inner = shared.inner.lock();
+
+            // Wait until we are allowed to decrement the token count or a signal arrives.
+            while inner.token_count == 0 {
+                if shared.state_changed.wait(&mut inner) {
+                    return Err(Error::EINTR);
+                }
+            }
+
+            // Consume a token.
+            inner.token_count -= 1;
+        }
+
+        // Notify a possible writer waiting.
+        shared.state_changed.notify_all();
+
+        // Write a one-byte 1 to the reader.
+        data.write_slice(&[1u8; 1])?;
+        Ok(1)
+    }
+
+    fn write(
+        shared: RefBorrow<'_, SharedState>,
+        _: &File,
+        data: &mut impl IoBufferReader,
+        _offset: u64,
+    ) -> Result<usize> {
+        {
+            let mut inner = shared.inner.lock();
+
+            // Wait until we are allowed to increment the token count or a signal arrives.
+            while inner.token_count == MAX_TOKENS {
+                if shared.state_changed.wait(&mut inner) {
+                    return Err(Error::EINTR);
+                }
+            }
+
+            // Increment the number of token so that a reader can be released.
+            inner.token_count += 1;
+        }
+
+        // Notify a possible reader waiting.
+        shared.state_changed.notify_all();
+        Ok(data.len())
+    }
+}
+
+struct RustMiscdev {
+    _dev: Pin<Box<miscdev::Registration<Ref<SharedState>>>>,
+}
+
+impl KernelModule for RustMiscdev {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust miscellaneous device sample (init)\n");
+
+        let state = SharedState::try_new()?;
+
+        Ok(RustMiscdev {
+            _dev: miscdev::Registration::new_pinned::<Token>(name, None, state)?,
+        })
+    }
+}
+
+impl Drop for RustMiscdev {
+    fn drop(&mut self) {
+        pr_info!("Rust miscellaneous device sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_module_parameters.rs b/samples/rust/rust_module_parameters.rs
new file mode 100644
index 000000000000..5e4c39648010
--- /dev/null
+++ b/samples/rust/rust_module_parameters.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust module parameters sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+
+module! {
+    type: RustModuleParameters,
+    name: b"rust_module_parameters",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust module parameters sample",
+    license: b"GPL v2",
+    params: {
+        my_bool: bool {
+            default: true,
+            permissions: 0,
+            description: b"Example of bool",
+        },
+        my_i32: i32 {
+            default: 42,
+            permissions: 0o644,
+            description: b"Example of i32",
+        },
+        my_str: str {
+            default: b"default str val",
+            permissions: 0o644,
+            description: b"Example of a string param",
+        },
+        my_usize: usize {
+            default: 42,
+            permissions: 0o644,
+            description: b"Example of usize",
+        },
+        my_array: ArrayParam<i32, 3> {
+            default: [0, 1],
+            permissions: 0,
+            description: b"Example of array",
+        },
+    },
+}
+
+struct RustModuleParameters;
+
+impl KernelModule for RustModuleParameters {
+    fn init(_name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust module parameters sample (init)\n");
+
+        {
+            let lock = module.kernel_param_lock();
+            pr_info!("Parameters:\n");
+            pr_info!("  my_bool:    {}\n", my_bool.read());
+            pr_info!("  my_i32:     {}\n", my_i32.read(&lock));
+            pr_info!(
+                "  my_str:     {}\n",
+                core::str::from_utf8(my_str.read(&lock))?
+            );
+            pr_info!("  my_usize:   {}\n", my_usize.read(&lock));
+            pr_info!("  my_array:   {:?}\n", my_array.read());
+        }
+
+        Ok(RustModuleParameters)
+    }
+}
+
+impl Drop for RustModuleParameters {
+    fn drop(&mut self) {
+        pr_info!("Rust module parameters sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
new file mode 100644
index 000000000000..1b4d14a2d9cc
--- /dev/null
+++ b/samples/rust/rust_print.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust printing macros sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+use kernel::{pr_cont, str::CStr, ThisModule};
+
+module! {
+    type: RustPrint,
+    name: b"rust_print",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust printing macros sample",
+    license: b"GPL v2",
+}
+
+struct RustPrint;
+
+impl KernelModule for RustPrint {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust printing macros sample (init)\n");
+
+        pr_emerg!("Emergency message (level 0) without args\n");
+        pr_alert!("Alert message (level 1) without args\n");
+        pr_crit!("Critical message (level 2) without args\n");
+        pr_err!("Error message (level 3) without args\n");
+        pr_warn!("Warning message (level 4) without args\n");
+        pr_notice!("Notice message (level 5) without args\n");
+        pr_info!("Info message (level 6) without args\n");
+
+        pr_info!("A line that");
+        pr_cont!(" is continued");
+        pr_cont!(" without args\n");
+
+        pr_emerg!("{} message (level {}) with args\n", "Emergency", 0);
+        pr_alert!("{} message (level {}) with args\n", "Alert", 1);
+        pr_crit!("{} message (level {}) with args\n", "Critical", 2);
+        pr_err!("{} message (level {}) with args\n", "Error", 3);
+        pr_warn!("{} message (level {}) with args\n", "Warning", 4);
+        pr_notice!("{} message (level {}) with args\n", "Notice", 5);
+        pr_info!("{} message (level {}) with args\n", "Info", 6);
+
+        pr_info!("A {} that", "line");
+        pr_cont!(" is {}", "continued");
+        pr_cont!(" with {}\n", "args");
+
+        Ok(RustPrint)
+    }
+}
+
+impl Drop for RustPrint {
+    fn drop(&mut self) {
+        pr_info!("Rust printing macros sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_random.rs b/samples/rust/rust_random.rs
new file mode 100644
index 000000000000..ef28c5f84f71
--- /dev/null
+++ b/samples/rust/rust_random.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust random device
+//!
+//! Adapted from Alex Gaynor's original available at
+//! <https://github.com/alex/just-use/blob/master/src/lib.rs>.
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::{
+    file::File,
+    file_operations::FileOperations,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    prelude::*,
+};
+
+#[derive(Default)]
+struct RandomFile;
+
+impl FileOperations for RandomFile {
+    kernel::declare_file_operations!(read, write, read_iter, write_iter);
+
+    fn read(_this: &Self, file: &File, buf: &mut impl IoBufferWriter, _: u64) -> Result<usize> {
+        let total_len = buf.len();
+        let mut chunkbuf = [0; 256];
+
+        while !buf.is_empty() {
+            let len = chunkbuf.len().min(buf.len());
+            let chunk = &mut chunkbuf[0..len];
+
+            if file.is_blocking() {
+                kernel::random::getrandom(chunk)?;
+            } else {
+                kernel::random::getrandom_nonblock(chunk)?;
+            }
+            buf.write_slice(chunk)?;
+        }
+        Ok(total_len)
+    }
+
+    fn write(_this: &Self, _file: &File, buf: &mut impl IoBufferReader, _: u64) -> Result<usize> {
+        let total_len = buf.len();
+        let mut chunkbuf = [0; 256];
+        while !buf.is_empty() {
+            let len = chunkbuf.len().min(buf.len());
+            let chunk = &mut chunkbuf[0..len];
+            buf.read_slice(chunk)?;
+            kernel::random::add_randomness(chunk);
+        }
+        Ok(total_len)
+    }
+}
+
+module_misc_device! {
+    type: RandomFile,
+    name: b"rust_random",
+    author: b"Rust for Linux Contributors",
+    description: b"Just use /dev/urandom: Now with early-boot safety",
+    license: b"GPL v2",
+}
diff --git a/samples/rust/rust_semaphore.rs b/samples/rust/rust_semaphore.rs
new file mode 100644
index 000000000000..28f7a34d2942
--- /dev/null
+++ b/samples/rust/rust_semaphore.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust semaphore sample
+//!
+//! A counting semaphore that can be used by userspace.
+//!
+//! The count is incremented by writes to the device. A write of `n` bytes results in an increment
+//! of `n`. It is decremented by reads; each read results in the count being decremented by 1. If
+//! the count is already zero, a read will block until another write increments it.
+//!
+//! This can be used in user space from the shell for example  as follows (assuming a node called
+//! `semaphore`): `cat semaphore` decrements the count by 1 (waiting for it to become non-zero
+//! before decrementing); `echo -n 123 > semaphore` increments the semaphore by 3, potentially
+//! unblocking up to 3 blocked readers.
+
+#![no_std]
+#![feature(allocator_api, global_asm, generic_associated_types)]
+
+use core::sync::atomic::{AtomicU64, Ordering};
+use kernel::{
+    condvar_init, declare_file_operations,
+    file::File,
+    file_operations::{FileOpener, FileOperations, IoctlCommand, IoctlHandler},
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    miscdev::Registration,
+    mutex_init,
+    prelude::*,
+    sync::{CondVar, Mutex, Ref, UniqueRef},
+    user_ptr::{UserSlicePtrReader, UserSlicePtrWriter},
+};
+
+module! {
+    type: RustSemaphore,
+    name: b"rust_semaphore",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust semaphore sample",
+    license: b"GPL v2",
+}
+
+struct SemaphoreInner {
+    count: usize,
+    max_seen: usize,
+}
+
+struct Semaphore {
+    changed: CondVar,
+    inner: Mutex<SemaphoreInner>,
+}
+
+struct FileState {
+    read_count: AtomicU64,
+    shared: Ref<Semaphore>,
+}
+
+impl FileState {
+    fn consume(&self) -> Result {
+        let mut inner = self.shared.inner.lock();
+        while inner.count == 0 {
+            if self.shared.changed.wait(&mut inner) {
+                return Err(Error::EINTR);
+            }
+        }
+        inner.count -= 1;
+        Ok(())
+    }
+}
+
+impl FileOpener<Ref<Semaphore>> for FileState {
+    fn open(shared: &Ref<Semaphore>, _file: &File) -> Result<Box<Self>> {
+        Ok(Box::try_new(Self {
+            read_count: AtomicU64::new(0),
+            shared: shared.clone(),
+        })?)
+    }
+}
+
+impl FileOperations for FileState {
+    declare_file_operations!(read, write, ioctl);
+
+    fn read(this: &Self, _: &File, data: &mut impl IoBufferWriter, offset: u64) -> Result<usize> {
+        if data.is_empty() || offset > 0 {
+            return Ok(0);
+        }
+        this.consume()?;
+        data.write_slice(&[0u8; 1])?;
+        this.read_count.fetch_add(1, Ordering::Relaxed);
+        Ok(1)
+    }
+
+    fn write(this: &Self, _: &File, data: &mut impl IoBufferReader, _offs: u64) -> Result<usize> {
+        {
+            let mut inner = this.shared.inner.lock();
+            inner.count = inner.count.saturating_add(data.len());
+            if inner.count > inner.max_seen {
+                inner.max_seen = inner.count;
+            }
+        }
+
+        this.shared.changed.notify_all();
+        Ok(data.len())
+    }
+
+    fn ioctl(this: &Self, file: &File, cmd: &mut IoctlCommand) -> Result<i32> {
+        cmd.dispatch::<Self>(this, file)
+    }
+}
+
+struct RustSemaphore {
+    _dev: Pin<Box<Registration<Ref<Semaphore>>>>,
+}
+
+impl KernelModule for RustSemaphore {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust semaphore sample (init)\n");
+
+        let mut sema = Pin::from(UniqueRef::try_new(Semaphore {
+            // SAFETY: `condvar_init!` is called below.
+            changed: unsafe { CondVar::new() },
+
+            // SAFETY: `mutex_init!` is called below.
+            inner: unsafe {
+                Mutex::new(SemaphoreInner {
+                    count: 0,
+                    max_seen: 0,
+                })
+            },
+        })?);
+
+        // SAFETY: `changed` is pinned when `sema` is.
+        let pinned = unsafe { sema.as_mut().map_unchecked_mut(|s| &mut s.changed) };
+        condvar_init!(pinned, "Semaphore::changed");
+
+        // SAFETY: `inner` is pinned when `sema` is.
+        let pinned = unsafe { sema.as_mut().map_unchecked_mut(|s| &mut s.inner) };
+        mutex_init!(pinned, "Semaphore::inner");
+
+        Ok(Self {
+            _dev: Registration::new_pinned::<FileState>(name, None, sema.into())?,
+        })
+    }
+}
+
+impl Drop for RustSemaphore {
+    fn drop(&mut self) {
+        pr_info!("Rust semaphore sample (exit)\n");
+    }
+}
+
+const IOCTL_GET_READ_COUNT: u32 = 0x80086301;
+const IOCTL_SET_READ_COUNT: u32 = 0x40086301;
+
+impl IoctlHandler for FileState {
+    type Target<'a> = &'a Self;
+
+    fn read(this: &Self, _: &File, cmd: u32, writer: &mut UserSlicePtrWriter) -> Result<i32> {
+        match cmd {
+            IOCTL_GET_READ_COUNT => {
+                writer.write(&this.read_count.load(Ordering::Relaxed))?;
+                Ok(0)
+            }
+            _ => Err(Error::EINVAL),
+        }
+    }
+
+    fn write(this: &Self, _: &File, cmd: u32, reader: &mut UserSlicePtrReader) -> Result<i32> {
+        match cmd {
+            IOCTL_SET_READ_COUNT => {
+                this.read_count.store(reader.read()?, Ordering::Relaxed);
+                Ok(0)
+            }
+            _ => Err(Error::EINVAL),
+        }
+    }
+}
diff --git a/samples/rust/rust_semaphore_c.c b/samples/rust/rust_semaphore_c.c
new file mode 100644
index 000000000000..cdc121d4030d
--- /dev/null
+++ b/samples/rust/rust_semaphore_c.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rust semaphore sample (in C, for comparison)
+ *
+ * This is a C implementation of `rust_semaphore.rs`. Refer to the description
+ * in that file for details on the device.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/refcount.h>
+#include <linux/wait.h>
+
+#define IOCTL_GET_READ_COUNT _IOR('c', 1, u64)
+#define IOCTL_SET_READ_COUNT _IOW('c', 1, u64)
+
+struct semaphore_state {
+	struct kref ref;
+	struct miscdevice miscdev;
+	wait_queue_head_t changed;
+	struct mutex mutex;
+	size_t count;
+	size_t max_seen;
+};
+
+struct file_state {
+	atomic64_t read_count;
+	struct semaphore_state *shared;
+};
+
+static int semaphore_consume(struct semaphore_state *state)
+{
+	DEFINE_WAIT(wait);
+
+	mutex_lock(&state->mutex);
+	while (state->count == 0) {
+		prepare_to_wait(&state->changed, &wait, TASK_INTERRUPTIBLE);
+		mutex_unlock(&state->mutex);
+		schedule();
+		finish_wait(&state->changed, &wait);
+		if (signal_pending(current))
+			return -EINTR;
+		mutex_lock(&state->mutex);
+	}
+
+	state->count--;
+	mutex_unlock(&state->mutex);
+
+	return 0;
+}
+
+static int semaphore_open(struct inode *nodp, struct file *filp)
+{
+	struct semaphore_state *shared =
+		container_of(filp->private_data, struct semaphore_state, miscdev);
+	struct file_state *state;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	kref_get(&shared->ref);
+	state->shared = shared;
+	atomic64_set(&state->read_count, 0);
+
+	filp->private_data = state;
+
+	return 0;
+}
+
+static ssize_t semaphore_write(struct file *filp, const char __user *buffer, size_t count,
+			       loff_t *ppos)
+{
+	struct file_state *state = filp->private_data;
+	struct semaphore_state *shared = state->shared;
+
+	mutex_lock(&shared->mutex);
+
+	shared->count += count;
+	if (shared->count < count)
+		shared->count = SIZE_MAX;
+
+	if (shared->count > shared->max_seen)
+		shared->max_seen = shared->count;
+
+	mutex_unlock(&shared->mutex);
+
+	wake_up_all(&shared->changed);
+
+	return count;
+}
+
+static ssize_t semaphore_read(struct file *filp, char __user *buffer,
+			      size_t count, loff_t *ppos)
+{
+	struct file_state *state = filp->private_data;
+	char c = 0;
+	int ret;
+
+	if (count == 0 || *ppos > 0)
+		return 0;
+
+	ret = semaphore_consume(state->shared);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(buffer, &c, sizeof(c)))
+		return -EFAULT;
+
+	atomic64_add(1, &state->read_count);
+	*ppos += 1;
+	return 1;
+}
+
+static long semaphore_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct file_state *state = filp->private_data;
+	void __user *buffer = (void __user *)arg;
+	u64 value;
+
+	switch (cmd) {
+	case IOCTL_GET_READ_COUNT:
+		value = atomic64_read(&state->read_count);
+		if (copy_to_user(buffer, &value, sizeof(value)))
+			return -EFAULT;
+		return 0;
+	case IOCTL_SET_READ_COUNT:
+		if (copy_from_user(&value, buffer, sizeof(value)))
+			return -EFAULT;
+		atomic64_set(&state->read_count, value);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void semaphore_free(struct kref *kref)
+{
+	struct semaphore_state *device;
+
+	device = container_of(kref, struct semaphore_state, ref);
+	kfree(device);
+}
+
+static int semaphore_release(struct inode *nodp, struct file *filp)
+{
+	struct file_state *state = filp->private_data;
+
+	kref_put(&state->shared->ref, semaphore_free);
+	kfree(state);
+	return 0;
+}
+
+static const struct file_operations semaphore_fops = {
+	.owner = THIS_MODULE,
+	.open = semaphore_open,
+	.read = semaphore_read,
+	.write = semaphore_write,
+	.compat_ioctl = semaphore_ioctl,
+	.release = semaphore_release,
+};
+
+static struct semaphore_state *device;
+
+static int __init semaphore_init(void)
+{
+	int ret;
+	struct semaphore_state *state;
+
+	pr_info("Rust semaphore sample (in C, for comparison) (init)\n");
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	mutex_init(&state->mutex);
+	kref_init(&state->ref);
+	init_waitqueue_head(&state->changed);
+
+	state->miscdev.fops = &semaphore_fops;
+	state->miscdev.minor = MISC_DYNAMIC_MINOR;
+	state->miscdev.name = "semaphore";
+
+	ret = misc_register(&state->miscdev);
+	if (ret < 0) {
+		kfree(state);
+		return ret;
+	}
+
+	device = state;
+
+	return 0;
+}
+
+static void __exit semaphore_exit(void)
+{
+	pr_info("Rust semaphore sample (in C, for comparison) (exit)\n");
+
+	misc_deregister(&device->miscdev);
+	kref_put(&device->ref, semaphore_free);
+}
+
+module_init(semaphore_init);
+module_exit(semaphore_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Rust for Linux Contributors");
+MODULE_DESCRIPTION("Rust semaphore sample (in C, for comparison)");
diff --git a/samples/rust/rust_stack_probing.rs b/samples/rust/rust_stack_probing.rs
new file mode 100644
index 000000000000..4f44fade96aa
--- /dev/null
+++ b/samples/rust/rust_stack_probing.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust stack probing sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+#![feature(bench_black_box)]
+
+use kernel::prelude::*;
+
+module! {
+    type: RustStackProbing,
+    name: b"rust_stack_probing",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust stack probing sample",
+    license: b"GPL v2",
+}
+
+struct RustStackProbing;
+
+impl KernelModule for RustStackProbing {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust stack probing sample (init)\n");
+
+        // Including this large variable on the stack will trigger
+        // stack probing on the supported archs.
+        // This will verify that stack probing does not lead to
+        // any errors if we need to link `__rust_probestack`.
+        let x: [u64; 514] = core::hint::black_box([5; 514]);
+        pr_info!("Large array has length: {}\n", x.len());
+
+        Ok(RustStackProbing)
+    }
+}
+
+impl Drop for RustStackProbing {
+    fn drop(&mut self) {
+        pr_info!("Rust stack probing sample (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_sync.rs b/samples/rust/rust_sync.rs
new file mode 100644
index 000000000000..f71f8928d16e
--- /dev/null
+++ b/samples/rust/rust_sync.rs
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust synchronisation primitives sample
+
+#![no_std]
+#![feature(allocator_api, global_asm)]
+
+use kernel::prelude::*;
+use kernel::{
+    condvar_init, mutex_init, spinlock_init,
+    sync::{CondVar, Mutex, SpinLock},
+};
+
+module! {
+    type: RustSync,
+    name: b"rust_sync",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust synchronisation primitives sample",
+    license: b"GPL v2",
+}
+
+struct RustSync;
+
+impl KernelModule for RustSync {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust synchronisation primitives sample (init)\n");
+
+        // Test mutexes.
+        {
+            // SAFETY: `init` is called below.
+            let mut data = Pin::from(Box::try_new(unsafe { Mutex::new(0) })?);
+            mutex_init!(data.as_mut(), "RustSync::init::data1");
+            *data.lock() = 10;
+            pr_info!("Value: {}\n", *data.lock());
+
+            // SAFETY: `init` is called below.
+            let mut cv = Pin::from(Box::try_new(unsafe { CondVar::new() })?);
+            condvar_init!(cv.as_mut(), "RustSync::init::cv1");
+
+            {
+                let mut guard = data.lock();
+                while *guard != 10 {
+                    let _ = cv.wait(&mut guard);
+                }
+            }
+            cv.notify_one();
+            cv.notify_all();
+            cv.free_waiters();
+        }
+
+        // Test spinlocks.
+        {
+            // SAFETY: `init` is called below.
+            let mut data = Pin::from(Box::try_new(unsafe { SpinLock::new(0) })?);
+            spinlock_init!(data.as_mut(), "RustSync::init::data2");
+            *data.lock() = 10;
+            pr_info!("Value: {}\n", *data.lock());
+
+            // SAFETY: `init` is called below.
+            let mut cv = Pin::from(Box::try_new(unsafe { CondVar::new() })?);
+            condvar_init!(cv.as_mut(), "RustSync::init::cv2");
+            {
+                let mut guard = data.lock();
+                while *guard != 10 {
+                    let _ = cv.wait(&mut guard);
+                }
+            }
+            cv.notify_one();
+            cv.notify_all();
+            cv.free_waiters();
+        }
+
+        Ok(RustSync)
+    }
+}
+
+impl Drop for RustSync {
+    fn drop(&mut self) {
+        pr_info!("Rust synchronisation primitives sample (exit)\n");
+    }
+}
-- 
2.34.0

