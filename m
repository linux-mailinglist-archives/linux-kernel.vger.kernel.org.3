Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB8587558
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiHBB4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiHBBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7ED4B480;
        Mon,  1 Aug 2022 18:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BDDFB81624;
        Tue,  2 Aug 2022 01:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9293C433D6;
        Tue,  2 Aug 2022 01:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405237;
        bh=o3gZI4jG7cy2b2VDRJfLtgVqzwfGZz2OWNJZJgGbUlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVYu8R+G8vGIJWa2hNt5sVMhaTHK5JcIfeT2hGZi2BP2n9jdQLCWP/inWwwGJI94n
         fLWmjCgFS88FaHDVq0wzcYOFRjsAFUZOQDaf5l91LUCmrOiUNY8Mj+wRCMJH0hGUZb
         nZA+irGGRuc18uw2oSjMRLgg1jCNVIyz5ejT3BqRZqx3kpc8//HZZGxg9q3o48fwsW
         /mhMj9rY3CxEF34iWawKmMsiB4Oj4vJFn9a6uNEQjJvK92XaDyVmPTX3RMyi8LmM9v
         bj75VfxDhJFf4mmevd90KlWoU+lOOLCShyH7M4tYzMFOtZTrdM4DapALamVHyoRuTK
         tFt0rvAV8QOwA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>
Subject: [PATCH v8 28/31] samples: add Rust examples
Date:   Tue,  2 Aug 2022 03:50:15 +0200
Message-Id: <20220802015052.10452-29-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of Rust modules that showcase how Rust modules look like
and how to use the abstracted kernel features, as well as
an example of a Rust host program with several modules.

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
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Signed-off-by: Ayaan Zaidi <zaidi.ayaan@gmail.com>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 samples/Kconfig                        |   2 +
 samples/Makefile                       |   1 +
 samples/rust/Kconfig                   | 165 +++++++++++++++++++
 samples/rust/Makefile                  |  19 +++
 samples/rust/hostprogs/.gitignore      |   3 +
 samples/rust/hostprogs/Makefile        |   5 +
 samples/rust/hostprogs/a.rs            |   7 +
 samples/rust/hostprogs/b.rs            |   5 +
 samples/rust/hostprogs/single.rs       |  12 ++
 samples/rust/rust_chrdev.rs            |  49 ++++++
 samples/rust/rust_echo_server.rs       |  60 +++++++
 samples/rust/rust_fs.rs                |  59 +++++++
 samples/rust/rust_minimal.rs           |  35 ++++
 samples/rust/rust_miscdev.rs           | 142 +++++++++++++++++
 samples/rust/rust_module_parameters.rs |  69 ++++++++
 samples/rust/rust_netfilter.rs         |  54 +++++++
 samples/rust/rust_platform.rs          |  22 +++
 samples/rust/rust_print.rs             |  54 +++++++
 samples/rust/rust_random.rs            |  60 +++++++
 samples/rust/rust_selftests.rs         |  99 ++++++++++++
 samples/rust/rust_semaphore.rs         | 170 ++++++++++++++++++++
 samples/rust/rust_semaphore_c.c        | 212 +++++++++++++++++++++++++
 samples/rust/rust_stack_probing.rs     |  36 +++++
 samples/rust/rust_sync.rs              |  93 +++++++++++
 24 files changed, 1433 insertions(+)
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/hostprogs/.gitignore
 create mode 100644 samples/rust/hostprogs/Makefile
 create mode 100644 samples/rust/hostprogs/a.rs
 create mode 100644 samples/rust/hostprogs/b.rs
 create mode 100644 samples/rust/hostprogs/single.rs
 create mode 100644 samples/rust/rust_chrdev.rs
 create mode 100644 samples/rust/rust_echo_server.rs
 create mode 100644 samples/rust/rust_fs.rs
 create mode 100644 samples/rust/rust_minimal.rs
 create mode 100644 samples/rust/rust_miscdev.rs
 create mode 100644 samples/rust/rust_module_parameters.rs
 create mode 100644 samples/rust/rust_netfilter.rs
 create mode 100644 samples/rust/rust_platform.rs
 create mode 100644 samples/rust/rust_print.rs
 create mode 100644 samples/rust/rust_random.rs
 create mode 100644 samples/rust/rust_selftests.rs
 create mode 100644 samples/rust/rust_semaphore.rs
 create mode 100644 samples/rust/rust_semaphore_c.c
 create mode 100644 samples/rust/rust_stack_probing.rs
 create mode 100644 samples/rust/rust_sync.rs

diff --git a/samples/Kconfig b/samples/Kconfig
index 470ee3baf2e1..0d81c00289ee 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -263,6 +263,8 @@ config SAMPLE_CORESIGHT_SYSCFG
 	  This demonstrates how a user may create their own CoreSight
 	  configurations and easily load them into the system at runtime.
 
+source "samples/rust/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 701e912ab5af..9832ef3f8fcb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -35,3 +35,4 @@ subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
+obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
new file mode 100644
index 000000000000..861b35318b4d
--- /dev/null
+++ b/samples/rust/Kconfig
@@ -0,0 +1,165 @@
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
+config SAMPLE_RUST_PLATFORM
+	tristate "Platform device driver"
+	help
+	  This option builds the Rust platform device driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_platform.
+
+config SAMPLE_RUST_FS
+	tristate "File system"
+	help
+	  This option builds the Rust file system sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_fs.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_NETFILTER
+	tristate "Network filter module"
+	help
+	  This option builds the Rust netfilter module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_netfilter.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_ECHO_SERVER
+	tristate "Echo server module"
+	help
+	  This option builds the Rust echo server  module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_echo_server.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_HOSTPROGS
+	bool "Host programs"
+	help
+	  This option builds the Rust host program samples.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_SELFTESTS
+	tristate "Self tests"
+	help
+	  This option builds the self test cases for Rust.
+
+	  If unsure, say N.
+
+endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
new file mode 100644
index 000000000000..420bcefeb082
--- /dev/null
+++ b/samples/rust/Makefile
@@ -0,0 +1,19 @@
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
+obj-$(CONFIG_SAMPLE_RUST_PLATFORM)		+= rust_platform.o
+obj-$(CONFIG_SAMPLE_RUST_NETFILTER)		+= rust_netfilter.o
+obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)		+= rust_echo_server.o
+obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
+obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
+
+subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/hostprogs/.gitignore b/samples/rust/hostprogs/.gitignore
new file mode 100644
index 000000000000..a6c173da5048
--- /dev/null
+++ b/samples/rust/hostprogs/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+single
diff --git a/samples/rust/hostprogs/Makefile b/samples/rust/hostprogs/Makefile
new file mode 100644
index 000000000000..8ddcbd7416db
--- /dev/null
+++ b/samples/rust/hostprogs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+hostprogs-always-y := single
+
+single-rust := y
diff --git a/samples/rust/hostprogs/a.rs b/samples/rust/hostprogs/a.rs
new file mode 100644
index 000000000000..f7a4a3d0f4e0
--- /dev/null
+++ b/samples/rust/hostprogs/a.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample: module `a`.
+
+pub(crate) fn f(x: i32) {
+    println!("The number is {}.", x);
+}
diff --git a/samples/rust/hostprogs/b.rs b/samples/rust/hostprogs/b.rs
new file mode 100644
index 000000000000..c1675890648f
--- /dev/null
+++ b/samples/rust/hostprogs/b.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample: module `b`.
+
+pub(crate) const CONSTANT: i32 = 42;
diff --git a/samples/rust/hostprogs/single.rs b/samples/rust/hostprogs/single.rs
new file mode 100644
index 000000000000..8c48a119339a
--- /dev/null
+++ b/samples/rust/hostprogs/single.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample.
+
+mod a;
+mod b;
+
+fn main() {
+    println!("Hello world!");
+
+    a::f(b::CONSTANT);
+}
diff --git a/samples/rust/rust_chrdev.rs b/samples/rust/rust_chrdev.rs
new file mode 100644
index 000000000000..52f6e652d1a6
--- /dev/null
+++ b/samples/rust/rust_chrdev.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust character device sample.
+
+use kernel::prelude::*;
+use kernel::{chrdev, file};
+
+module! {
+    type: RustChrdev,
+    name: b"rust_chrdev",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust character device sample",
+    license: b"GPL",
+}
+
+struct RustFile;
+
+#[vtable]
+impl file::Operations for RustFile {
+    fn open(_shared: &(), _file: &file::File) -> Result {
+        Ok(())
+    }
+}
+
+struct RustChrdev {
+    _dev: Pin<Box<chrdev::Registration<2>>>,
+}
+
+impl kernel::Module for RustChrdev {
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
diff --git a/samples/rust/rust_echo_server.rs b/samples/rust/rust_echo_server.rs
new file mode 100644
index 000000000000..5fc802f4dc33
--- /dev/null
+++ b/samples/rust/rust_echo_server.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust echo server sample.
+
+use kernel::{
+    kasync::executor::{workqueue::Executor as WqExecutor, AutoStopHandle, Executor},
+    kasync::net::{TcpListener, TcpStream},
+    net::{self, Ipv4Addr, SocketAddr, SocketAddrV4},
+    prelude::*,
+    spawn_task,
+    sync::{Ref, RefBorrow},
+};
+
+async fn echo_server(stream: TcpStream) -> Result {
+    let mut buf = [0u8; 1024];
+    loop {
+        let n = stream.read(&mut buf).await?;
+        if n == 0 {
+            return Ok(());
+        }
+        stream.write_all(&buf[..n]).await?;
+    }
+}
+
+async fn accept_loop(listener: TcpListener, executor: Ref<impl Executor>) {
+    loop {
+        if let Ok(stream) = listener.accept().await {
+            let _ = spawn_task!(executor.as_ref_borrow(), echo_server(stream));
+        }
+    }
+}
+
+fn start_listener(ex: RefBorrow<'_, impl Executor + Send + Sync + 'static>) -> Result {
+    let addr = SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::ANY, 8080));
+    let listener = TcpListener::try_new(net::init_ns(), &addr)?;
+    spawn_task!(ex, accept_loop(listener, ex.into()))?;
+    Ok(())
+}
+
+struct RustEchoServer {
+    _handle: AutoStopHandle<dyn Executor>,
+}
+
+impl kernel::Module for RustEchoServer {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        let handle = WqExecutor::try_new(kernel::workqueue::system())?;
+        start_listener(handle.executor())?;
+        Ok(Self {
+            _handle: handle.into(),
+        })
+    }
+}
+
+module! {
+    type: RustEchoServer,
+    name: b"rust_echo_server",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust tcp echo sample",
+    license: b"GPL v2",
+}
diff --git a/samples/rust/rust_fs.rs b/samples/rust/rust_fs.rs
new file mode 100644
index 000000000000..d286b396dd17
--- /dev/null
+++ b/samples/rust/rust_fs.rs
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust file system sample.
+
+use kernel::prelude::*;
+use kernel::{c_str, fs};
+
+module_fs! {
+    type: RustFs,
+    name: b"rust_fs",
+    author: b"Rust for Linux Contributors",
+    license: b"GPL",
+}
+
+struct RustFs;
+
+#[vtable]
+impl fs::Context<Self> for RustFs {
+    type Data = ();
+
+    kernel::define_fs_params! {(),
+        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(()) } },
+        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n"); Ok(()) } },
+        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(()) } },
+        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(()) } },
+        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n"); Ok(()) } },
+        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n"); Ok(()) } },
+        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(()) } },
+        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(()) } },
+        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n"); Ok(()) } },
+        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
+            pr_info!("enum passed-in: {v}\n"); Ok(()) }
+        },
+    }
+
+    fn try_new() -> Result {
+        pr_info!("context created!\n");
+        Ok(())
+    }
+}
+
+impl fs::Type for RustFs {
+    type Context = Self;
+    const SUPER_TYPE: fs::Super = fs::Super::Independent;
+    const NAME: &'static CStr = c_str!("rustfs");
+    const FLAGS: i32 = fs::flags::USERNS_MOUNT;
+
+    fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBlock<Self>> {
+        let sb = sb.init(
+            (),
+            &fs::SuperParams {
+                magic: 0x72757374,
+                ..fs::SuperParams::DEFAULT
+            },
+        )?;
+        let sb = sb.init_root()?;
+        Ok(sb)
+    }
+}
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
new file mode 100644
index 000000000000..6e1a926c6f62
--- /dev/null
+++ b/samples/rust/rust_minimal.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: RustMinimal,
+    name: b"rust_minimal",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust minimal sample",
+    license: b"GPL",
+}
+
+struct RustMinimal {
+    message: String,
+}
+
+impl kernel::Module for RustMinimal {
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
index 000000000000..647b77864f10
--- /dev/null
+++ b/samples/rust/rust_miscdev.rs
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust miscellaneous device sample.
+
+use kernel::prelude::*;
+use kernel::{
+    file::{self, File},
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
+    license: b"GPL",
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
+#[vtable]
+impl file::Operations for Token {
+    type Data = Ref<SharedState>;
+    type OpenData = Ref<SharedState>;
+
+    fn open(shared: &Ref<SharedState>, _file: &File) -> Result<Self::Data> {
+        Ok(shared.clone())
+    }
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
+                    return Err(EINTR);
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
+                    return Err(EINTR);
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
+    _dev: Pin<Box<miscdev::Registration<Token>>>,
+}
+
+impl kernel::Module for RustMiscdev {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust miscellaneous device sample (init)\n");
+
+        let state = SharedState::try_new()?;
+
+        Ok(RustMiscdev {
+            _dev: miscdev::Registration::new_pinned(fmt!("{name}"), state)?,
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
index 000000000000..12fe5e738e83
--- /dev/null
+++ b/samples/rust/rust_module_parameters.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust module parameters sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: RustModuleParameters,
+    name: b"rust_module_parameters",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust module parameters sample",
+    license: b"GPL",
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
+impl kernel::Module for RustModuleParameters {
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
diff --git a/samples/rust/rust_netfilter.rs b/samples/rust/rust_netfilter.rs
new file mode 100644
index 000000000000..4bd5c07fee8c
--- /dev/null
+++ b/samples/rust/rust_netfilter.rs
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust netfilter sample.
+
+use kernel::net;
+use kernel::net::filter::{self as netfilter, inet, Disposition, Family};
+use kernel::prelude::*;
+
+module! {
+    type: RustNetfilter,
+    name: b"rust_netfilter",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust netfilter sample",
+    license: b"GPL",
+}
+
+struct RustNetfilter {
+    _in: Pin<Box<netfilter::Registration<Self>>>,
+    _out: Pin<Box<netfilter::Registration<Self>>>,
+}
+
+impl netfilter::Filter for RustNetfilter {
+    fn filter(_: (), skb: &net::SkBuff) -> Disposition {
+        let data = skb.head_data();
+        pr_info!(
+            "packet headlen={}, len={}, first bytes={:02x?}\n",
+            data.len(),
+            skb.len(),
+            &data[..core::cmp::min(10, data.len())]
+        );
+        Disposition::Accept
+    }
+}
+
+impl kernel::Module for RustNetfilter {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        Ok(Self {
+            _in: netfilter::Registration::new_pinned(
+                Family::INet(inet::Hook::PreRouting),
+                0,
+                net::init_ns().into(),
+                None,
+                (),
+            )?,
+            _out: netfilter::Registration::new_pinned(
+                Family::INet(inet::Hook::PostRouting),
+                0,
+                net::init_ns().into(),
+                None,
+                (),
+            )?,
+        })
+    }
+}
diff --git a/samples/rust/rust_platform.rs b/samples/rust/rust_platform.rs
new file mode 100644
index 000000000000..f62784676919
--- /dev/null
+++ b/samples/rust/rust_platform.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust platform device driver sample.
+
+use kernel::{module_platform_driver, of, platform, prelude::*};
+
+module_platform_driver! {
+    type: Driver,
+    name: b"rust_platform",
+    license: b"GPL",
+}
+
+struct Driver;
+impl platform::Driver for Driver {
+    kernel::define_of_id_table! {(), [
+        (of::DeviceId::Compatible(b"rust,sample"), None),
+    ]}
+
+    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result {
+        Ok(())
+    }
+}
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
new file mode 100644
index 000000000000..30d96e025d89
--- /dev/null
+++ b/samples/rust/rust_print.rs
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust printing macros sample.
+
+use kernel::prelude::*;
+use kernel::{pr_cont, str::CStr, ThisModule};
+
+module! {
+    type: RustPrint,
+    name: b"rust_print",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust printing macros sample",
+    license: b"GPL",
+}
+
+struct RustPrint;
+
+impl kernel::Module for RustPrint {
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
index 000000000000..771c7a940b3d
--- /dev/null
+++ b/samples/rust/rust_random.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust random device.
+//!
+//! Adapted from Alex Gaynor's original available at
+//! <https://github.com/alex/just-use/blob/master/src/lib.rs>.
+
+use kernel::{
+    file::{self, File},
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    prelude::*,
+};
+
+module_misc_device! {
+    type: RandomFile,
+    name: b"rust_random",
+    author: b"Rust for Linux Contributors",
+    description: b"Just use /dev/urandom: Now with early-boot safety",
+    license: b"GPL",
+}
+
+struct RandomFile;
+
+#[vtable]
+impl file::Operations for RandomFile {
+    fn open(_data: &(), _file: &File) -> Result {
+        Ok(())
+    }
+
+    fn read(_this: (), file: &File, buf: &mut impl IoBufferWriter, _: u64) -> Result<usize> {
+        let total_len = buf.len();
+        let mut chunkbuf = [0; 256];
+
+        while !buf.is_empty() {
+            let len = chunkbuf.len().min(buf.len());
+            let chunk = &mut chunkbuf[0..len];
+            let blocking = (file.flags() & file::flags::O_NONBLOCK) == 0;
+
+            if blocking {
+                kernel::random::getrandom(chunk)?;
+            } else {
+                kernel::random::getrandom_nonblock(chunk)?;
+            }
+            buf.write_slice(chunk)?;
+        }
+        Ok(total_len)
+    }
+
+    fn write(_this: (), _file: &File, buf: &mut impl IoBufferReader, _: u64) -> Result<usize> {
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
diff --git a/samples/rust/rust_selftests.rs b/samples/rust/rust_selftests.rs
new file mode 100644
index 000000000000..965c48fd0e29
--- /dev/null
+++ b/samples/rust/rust_selftests.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Self test cases for Rust.
+
+use kernel::prelude::*;
+// Keep the `use` for a test in its test function. Module-level `use`s are only for the test
+// framework.
+
+module! {
+    type: RustSelftests,
+    name: b"rust_selftests",
+    author: b"Rust for Linux Contributors",
+    description: b"Self test cases for Rust",
+    license: b"GPL",
+}
+
+struct RustSelftests;
+
+/// A summary of testing.
+///
+/// A test can
+///
+/// * pass (successfully), or
+/// * fail (without hitting any error), or
+/// * hit an error (interrupted).
+///
+/// This is the type that differentiates the first two (pass and fail) cases.
+///
+/// When a test hits an error, the test function should skip and return the error. Note that this
+/// doesn't mean the test fails, for example if the system doesn't have enough memory for
+/// testing, the test function may return an `Err(ENOMEM)` and skip.
+#[allow(dead_code)]
+enum TestSummary {
+    Pass,
+    Fail,
+}
+
+use TestSummary::Fail;
+use TestSummary::Pass;
+
+macro_rules! do_tests {
+    ($($name:ident),*) => {
+        let mut total = 0;
+        let mut pass = 0;
+        let mut fail = 0;
+
+        $({
+            total += 1;
+
+            match $name() {
+                Ok(Pass) => {
+                    pass += 1;
+                    pr_info!("{} passed!", stringify!($name));
+                },
+                Ok(Fail) => {
+                    fail += 1;
+                    pr_info!("{} failed!", stringify!($name));
+                },
+                Err(err) => {
+                    pr_info!("{} hit error {:?}", stringify!($name), err);
+                }
+            }
+        })*
+
+        pr_info!("{} tests run, {} passed, {} failed, {} hit errors\n",
+                 total, pass, fail, total - pass - fail);
+
+        if total == pass {
+            pr_info!("All tests passed. Congratulations!\n");
+        }
+    }
+}
+
+/// An example of test.
+#[allow(dead_code)]
+fn test_example() -> Result<TestSummary> {
+    // `use` declarations for the test can be put here, e.g. `use foo::bar;`.
+
+    // Always pass.
+    Ok(Pass)
+}
+
+impl kernel::Module for RustSelftests {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust self tests (init)\n");
+
+        do_tests! {
+            test_example // TODO: Remove when there is at least a real test.
+        };
+
+        Ok(RustSelftests)
+    }
+}
+
+impl Drop for RustSelftests {
+    fn drop(&mut self) {
+        pr_info!("Rust self tests (exit)\n");
+    }
+}
diff --git a/samples/rust/rust_semaphore.rs b/samples/rust/rust_semaphore.rs
new file mode 100644
index 000000000000..e91f82a6abfb
--- /dev/null
+++ b/samples/rust/rust_semaphore.rs
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust semaphore sample.
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
+use core::sync::atomic::{AtomicU64, Ordering};
+use kernel::{
+    condvar_init,
+    file::{self, File, IoctlCommand, IoctlHandler},
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
+    license: b"GPL",
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
+                return Err(EINTR);
+            }
+        }
+        inner.count -= 1;
+        Ok(())
+    }
+}
+
+#[vtable]
+impl file::Operations for FileState {
+    type Data = Box<Self>;
+    type OpenData = Ref<Semaphore>;
+
+    fn open(shared: &Ref<Semaphore>, _file: &File) -> Result<Box<Self>> {
+        Ok(Box::try_new(Self {
+            read_count: AtomicU64::new(0),
+            shared: shared.clone(),
+        })?)
+    }
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
+    _dev: Pin<Box<Registration<FileState>>>,
+}
+
+impl kernel::Module for RustSemaphore {
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
+            _dev: Registration::new_pinned(fmt!("{name}"), sema.into())?,
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
+            _ => Err(EINVAL),
+        }
+    }
+
+    fn write(this: &Self, _: &File, cmd: u32, reader: &mut UserSlicePtrReader) -> Result<i32> {
+        match cmd {
+            IOCTL_SET_READ_COUNT => {
+                this.read_count.store(reader.read()?, Ordering::Relaxed);
+                Ok(0)
+            }
+            _ => Err(EINVAL),
+        }
+    }
+}
diff --git a/samples/rust/rust_semaphore_c.c b/samples/rust/rust_semaphore_c.c
new file mode 100644
index 000000000000..7672b0b4c105
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
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Rust for Linux Contributors");
+MODULE_DESCRIPTION("Rust semaphore sample (in C, for comparison)");
diff --git a/samples/rust/rust_stack_probing.rs b/samples/rust/rust_stack_probing.rs
new file mode 100644
index 000000000000..1448fe8e1b56
--- /dev/null
+++ b/samples/rust/rust_stack_probing.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust stack probing sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: RustStackProbing,
+    name: b"rust_stack_probing",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust stack probing sample",
+    license: b"GPL",
+}
+
+struct RustStackProbing;
+
+impl kernel::Module for RustStackProbing {
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
index 000000000000..46637ace2f7f
--- /dev/null
+++ b/samples/rust/rust_sync.rs
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust synchronisation primitives sample.
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
+    license: b"GPL",
+}
+
+kernel::init_static_sync! {
+    static SAMPLE_MUTEX: Mutex<u32> = 10;
+    static SAMPLE_CONDVAR: CondVar;
+}
+
+struct RustSync;
+
+impl kernel::Module for RustSync {
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
+        // Test static mutex + condvar.
+        *SAMPLE_MUTEX.lock() = 20;
+
+        {
+            let mut guard = SAMPLE_MUTEX.lock();
+            while *guard != 20 {
+                let _ = SAMPLE_CONDVAR.wait(&mut guard);
+            }
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
2.37.1

