Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FC4DCD53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiCQSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiCQSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECE421FF5E;
        Thu, 17 Mar 2022 11:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9FD2B81F78;
        Thu, 17 Mar 2022 18:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3FFC340EE;
        Thu, 17 Mar 2022 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540725;
        bh=/PqWNxQk7afiCj8ndjljLUz7p47QK6C/VWa+XVRQFuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEJgjmCNjNa7ZfMEha8y5fYWvqDU4bHhzWP4zNdOAY5erxzndc+p5q7JtyAd/xE3q
         lbsLi66lFtm6zE7lWCVLMpWt5PRv+Vb6BVr2R1ppM4nJWzx5qNspLp629v/9pawTXF
         uSzu5yUoDLATGaK8KkGXqlqyoUHAll/sxA18lA1Wv2xpUmjzqm6KqrV74rC4SRKhl/
         PnggALPj6OwV4UM6eHs5E2M2RVS/T1MDZ8z0wUibS6JY1DqV5gc1j/eLSUqPrteNoV
         Psdj/VWo06hjuJf2SjSH0Ohbg/Bx7TkE1FnixfpSPj941aEoN9Ytb/i1f/AlsRJUrz
         xr9ZwBhMZd5mA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?q?L=C3=A9o=20Lanteri=20Thauvin?= 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v5 10/20] rust: add `kernel` crate
Date:   Thu, 17 Mar 2022 19:09:58 +0100
Message-Id: <20220317181032.15436-11-ojeda@kernel.org>
In-Reply-To: <20220317181032.15436-1-ojeda@kernel.org>
References: <20220317181032.15436-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@google.com>

The `kernel` crate currently includes all the abstractions that wrap
kernel features written in C.

These abstractions call the C side of the kernel via the generated
bindings with the `bindgen` tool. Modules developed in Rust should
never call the bindings themselves.

In the future, as the abstractions grow in number, we may need
to split this crate into several, possibly following a similar
subdivision in subsystems as the kernel itself and/or moving
the code to the actual subsystems.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Co-developed-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Dan Robertson <daniel.robertson@starlab.io>
Signed-off-by: Dan Robertson <daniel.robertson@starlab.io>
Co-developed-by: Viktor Garske <viktor@v-gar.de>
Signed-off-by: Viktor Garske <viktor@v-gar.de>
Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
Co-developed-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
Signed-off-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
Co-developed-by: Niklas Mohrin <dev@niklasmohrin.de>
Signed-off-by: Niklas Mohrin <dev@niklasmohrin.de>
Co-developed-by: Gioh Kim <gurugio@gmail.com>
Signed-off-by: Gioh Kim <gurugio@gmail.com>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Co-developed-by: Morgan Bartlett <mjmouse9999@gmail.com>
Signed-off-by: Morgan Bartlett <mjmouse9999@gmail.com>
Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/allocator.rs      |  65 +++
 rust/kernel/amba.rs           | 259 ++++++++++
 rust/kernel/bindings.rs       |  47 ++
 rust/kernel/bindings_helper.h |  37 ++
 rust/kernel/build_assert.rs   |  80 ++++
 rust/kernel/c_types.rs        | 119 +++++
 rust/kernel/chrdev.rs         | 207 ++++++++
 rust/kernel/clk.rs            |  75 +++
 rust/kernel/cred.rs           |  73 +++
 rust/kernel/device.rs         | 554 +++++++++++++++++++++
 rust/kernel/driver.rs         | 440 +++++++++++++++++
 rust/kernel/error.rs          | 560 ++++++++++++++++++++++
 rust/kernel/file.rs           | 873 ++++++++++++++++++++++++++++++++++
 rust/kernel/gpio.rs           | 478 +++++++++++++++++++
 rust/kernel/hwrng.rs          | 242 ++++++++++
 rust/kernel/io_buffer.rs      | 153 ++++++
 rust/kernel/io_mem.rs         | 237 +++++++++
 rust/kernel/iov_iter.rs       |  81 ++++
 rust/kernel/irq.rs            | 409 ++++++++++++++++
 rust/kernel/lib.rs            | 260 ++++++++++
 rust/kernel/linked_list.rs    | 247 ++++++++++
 rust/kernel/miscdev.rs        | 291 ++++++++++++
 rust/kernel/mm.rs             | 149 ++++++
 rust/kernel/module_param.rs   | 498 +++++++++++++++++++
 rust/kernel/of.rs             |  63 +++
 rust/kernel/pages.rs          | 144 ++++++
 rust/kernel/platform.rs       | 224 +++++++++
 rust/kernel/power.rs          | 118 +++++
 rust/kernel/prelude.rs        |  36 ++
 rust/kernel/print.rs          | 414 ++++++++++++++++
 rust/kernel/random.rs         |  50 ++
 rust/kernel/raw_list.rs       | 361 ++++++++++++++
 rust/kernel/rbtree.rs         | 562 ++++++++++++++++++++++
 rust/kernel/revocable.rs      | 163 +++++++
 rust/kernel/security.rs       |  36 ++
 rust/kernel/static_assert.rs  |  39 ++
 rust/kernel/std_vendor.rs     | 150 ++++++
 rust/kernel/str.rs            | 592 +++++++++++++++++++++++
 rust/kernel/sysctl.rs         | 199 ++++++++
 rust/kernel/task.rs           | 182 +++++++
 rust/kernel/types.rs          | 569 ++++++++++++++++++++++
 rust/kernel/user_ptr.rs       | 175 +++++++
 42 files changed, 10511 insertions(+)
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/amba.rs
 create mode 100644 rust/kernel/bindings.rs
 create mode 100644 rust/kernel/bindings_helper.h
 create mode 100644 rust/kernel/build_assert.rs
 create mode 100644 rust/kernel/c_types.rs
 create mode 100644 rust/kernel/chrdev.rs
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cred.rs
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/gpio.rs
 create mode 100644 rust/kernel/hwrng.rs
 create mode 100644 rust/kernel/io_buffer.rs
 create mode 100644 rust/kernel/io_mem.rs
 create mode 100644 rust/kernel/iov_iter.rs
 create mode 100644 rust/kernel/irq.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/linked_list.rs
 create mode 100644 rust/kernel/miscdev.rs
 create mode 100644 rust/kernel/mm.rs
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
 create mode 100644 rust/kernel/sysctl.rs
 create mode 100644 rust/kernel/task.rs
 create mode 100644 rust/kernel/types.rs
 create mode 100644 rust/kernel/user_ptr.rs

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
new file mode 100644
index 000000000000..4c5d2fc6f206
--- /dev/null
+++ b/rust/kernel/allocator.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Allocator support.
+
+use core::alloc::{GlobalAlloc, Layout};
+use core::ptr;
+
+use crate::bindings;
+use crate::c_types;
+
+struct KernelAllocator;
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // `krealloc()` is used instead of `kmalloc()` because the latter is
+        // an inline function and cannot be bound to as a result.
+        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
+        unsafe {
+            bindings::kfree(ptr as *const c_types::c_void);
+        }
+    }
+}
+
+#[global_allocator]
+static ALLOCATOR: KernelAllocator = KernelAllocator;
+
+// `rustc` only generates these for some crate types. Even then, we would need
+// to extract the object file that has them from the archive. For the moment,
+// let's generate them ourselves instead.
+//
+// Note that `#[no_mangle]` implies exported too, nowadays.
+#[no_mangle]
+fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
+    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+}
+
+#[no_mangle]
+fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
+    unsafe { bindings::kfree(ptr as *const c_types::c_void) };
+}
+
+#[no_mangle]
+fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            ptr as *const c_types::c_void,
+            new_size,
+            bindings::GFP_KERNEL,
+        ) as *mut u8
+    }
+}
+
+#[no_mangle]
+fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            core::ptr::null(),
+            size,
+            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+        ) as *mut u8
+    }
+}
diff --git a/rust/kernel/amba.rs b/rust/kernel/amba.rs
new file mode 100644
index 000000000000..1775eda7dce6
--- /dev/null
+++ b/rust/kernel/amba.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Amba devices and drivers.
+//!
+//! C header: [`include/linux/amba/bus.h`](../../../../include/linux/amba/bus.h)
+
+use crate::{
+    bindings, c_types, device, driver, error::from_kernel_result, io_mem::Resource, power,
+    str::CStr, to_result, types::PointerWrapper, Result, ThisModule,
+};
+
+/// A registration of an amba driver.
+pub type Registration<T> = driver::Registration<Adapter<T>>;
+
+/// Id of an Amba device.
+#[derive(Clone, Copy)]
+pub struct DeviceId {
+    /// Device id.
+    pub id: u32,
+
+    /// Mask that identifies which bits are valid in the device id.
+    pub mask: u32,
+}
+
+// SAFETY: `ZERO` is all zeroed-out and `to_rawid` stores `offset` in `amba_id::data`.
+unsafe impl const driver::RawDeviceId for DeviceId {
+    type RawType = bindings::amba_id;
+    const ZERO: Self::RawType = bindings::amba_id {
+        id: 0,
+        mask: 0,
+        data: core::ptr::null_mut(),
+    };
+
+    fn to_rawid(&self, offset: isize) -> Self::RawType {
+        bindings::amba_id {
+            id: self.id,
+            mask: self.mask,
+            data: offset as _,
+        }
+    }
+}
+
+/// An amba driver.
+pub trait Driver {
+    /// Data stored on device by driver.
+    type Data: PointerWrapper + Send + Sync + driver::DeviceRemoval = ();
+
+    /// The type that implements the power-management operations.
+    ///
+    /// The default is a type that implements no power-management operations. Drivers that do
+    /// implement them need to specify the type (commonly [`Self`]).
+    type PowerOps: power::Operations<Data = Self::Data> = power::NoOperations<Self::Data>;
+
+    /// The type holding information about each device id supported by the driver.
+    type IdInfo: 'static = ();
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: Option<driver::IdTable<'static, DeviceId, Self::IdInfo>> = None;
+
+    /// Probes for the device with the given id.
+    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Self::Data>;
+
+    /// Cleans any resources up that are associated with the device.
+    ///
+    /// This is called when the driver is detached from the device.
+    fn remove(_data: &Self::Data) {}
+}
+
+/// An adapter for the registration of Amba drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver> driver::DriverOps for Adapter<T> {
+    type RegType = bindings::amba_driver;
+
+    unsafe fn register(
+        reg: *mut bindings::amba_driver,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: By the safety requirements of this function (defined in the trait defintion),
+        // `reg` is non-null and valid.
+        let amba = unsafe { &mut *reg };
+        amba.drv.name = name.as_char_ptr();
+        amba.drv.owner = module.0;
+        amba.probe = Some(probe_callback::<T>);
+        amba.remove = Some(remove_callback::<T>);
+        if let Some(t) = T::ID_TABLE {
+            amba.id_table = t.as_ref();
+        }
+        if cfg!(CONFIG_PM) {
+            // SAFETY: `probe_callback` sets the driver data after calling `T::Data::into_pointer`,
+            // and we guarantee that `T::Data` is the same as `T::PowerOps::Data` by a constraint
+            // in the type declaration.
+            amba.drv.pm = unsafe { power::OpsTable::<T::PowerOps>::build() };
+        }
+        // SAFETY: By the safety requirements of this function, `reg` is valid and fully
+        // initialised.
+        to_result(|| unsafe { bindings::amba_driver_register(reg) })
+    }
+
+    unsafe fn unregister(reg: *mut bindings::amba_driver) {
+        // SAFETY: By the safety requirements of this function (defined in the trait definition),
+        // `reg` was passed (and updated) by a previous successful call to `amba_driver_register`.
+        unsafe { bindings::amba_driver_unregister(reg) };
+    }
+}
+
+unsafe extern "C" fn probe_callback<T: Driver>(
+    adev: *mut bindings::amba_device,
+    aid: *const bindings::amba_id,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: `adev` is valid by the contract with the C code. `dev` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of `dev`.
+        let mut dev = unsafe { Device::from_ptr(adev) };
+        // SAFETY: `aid` is valid by the requirements the contract with the C code.
+        let offset = unsafe { (*aid).data };
+        let info = if offset.is_null() {
+            None
+        } else {
+            // SAFETY: The offset comes from a previous call to `offset_from` in `IdArray::new`,
+            // which guarantees that the resulting pointer is within the table.
+            let ptr = unsafe { aid.cast::<u8>().offset(offset as _).cast::<Option<T::IdInfo>>() };
+            // SAFETY: The id table has a static lifetime, so `ptr` is guaranteed to be valid for
+            // read.
+            unsafe { (&*ptr).as_ref() }
+        };
+        let data = T::probe(&mut dev, info)?;
+        let ptr = T::Data::into_pointer(data);
+        // SAFETY: `adev` is valid for write by the contract with the C code.
+        unsafe { bindings::amba_set_drvdata(adev, ptr as _) };
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn remove_callback<T: Driver>(adev: *mut bindings::amba_device) {
+    // SAFETY: `adev` is valid by the contract with the C code.
+    let ptr = unsafe { bindings::amba_get_drvdata(adev) };
+    // SAFETY: The value returned by `amba_get_drvdata` was stored by a previous call to
+    // `amba_set_drvdata` in `probe_callback` above; the value comes from a call to
+    // `T::Data::into_pointer`.
+    let data = unsafe { T::Data::from_pointer(ptr) };
+    T::remove(&data);
+    <T::Data as driver::DeviceRemoval>::device_remove(&data);
+}
+
+/// An Amba device.
+///
+/// # Invariants
+///
+/// The field `ptr` is non-null and valid for the lifetime of the object.
+pub struct Device {
+    ptr: *mut bindings::amba_device,
+    res: Option<Resource>,
+}
+
+impl Device {
+    /// Creates a new device from the given pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be non-null and valid. It must remain valid for the lifetime of the returned
+    /// instance.
+    unsafe fn from_ptr(ptr: *mut bindings::amba_device) -> Self {
+        // SAFETY: The safety requirements of the function ensure that `ptr` is valid.
+        let dev = unsafe { &mut *ptr };
+        // INVARIANT: The safety requirements of the function ensure the lifetime invariant.
+        Self {
+            ptr,
+            res: Resource::new(dev.res.start, dev.res.end),
+        }
+    }
+
+    /// Returns the io mem resource associated with the device, if there is one.
+    ///
+    /// Ownership of the resource is transferred to the caller, so subsequent calls to this
+    /// function will return [`None`].
+    pub fn take_resource(&mut self) -> Option<Resource> {
+        self.res.take()
+    }
+
+    /// Returns the index-th irq associated with the device, if one exists.
+    pub fn irq(&self, index: usize) -> Option<u32> {
+        // SAFETY: By the type invariants, `self.ptr` is valid for read.
+        let dev = unsafe { &*self.ptr };
+        if index >= dev.irq.len() || dev.irq[index] == 0 {
+            None
+        } else {
+            Some(dev.irq[index])
+        }
+    }
+}
+
+// SAFETY: The device returned by `raw_device` is the raw Amba device.
+unsafe impl device::RawDevice for Device {
+    fn raw_device(&self) -> *mut bindings::device {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { &mut (*self.ptr).dev }
+    }
+}
+
+/// Declares a kernel module that exposes a single amba driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::prelude::*;
+/// # use kernel::{amba, define_amba_id_table, module_amba_driver};
+/// #
+/// struct MyDriver;
+/// impl amba::Driver for MyDriver {
+///     // [...]
+/// #   fn probe(_dev: &mut amba::Device, _id: Option<&Self::IdInfo>) -> Result {
+/// #       Ok(())
+/// #   }
+/// #   define_amba_id_table! {(), [
+/// #       ({ id: 0x00041061, mask: 0x000fffff }, None),
+/// #   ]}
+/// }
+///
+/// module_amba_driver! {
+///     type: MyDriver,
+///     name: b"module_name",
+///     author: b"Author name",
+///     license: b"GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_amba_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::amba::Adapter<T>, { $($f)* });
+    };
+}
+
+/// Defines the id table for amba devices.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::{amba, define_amba_id_table};
+/// #
+/// # struct Sample;
+/// # impl kernel::amba::Driver for Sample {
+/// #   fn probe(_dev: &mut amba::Device, _id: Option<&Self::IdInfo>) -> Result {
+/// #       Ok(())
+/// #   }
+///     define_amba_id_table! {(), [
+///         ({ id: 0x00041061, mask: 0x000fffff }, None),
+///     ]}
+/// # }
+/// ```
+#[macro_export]
+macro_rules! define_amba_id_table {
+    ($data_type:ty, $($t:tt)*) => {
+        type IdInfo = $data_type;
+        $crate::define_id_table!(ID_TABLE, $crate::amba::DeviceId, $data_type, $($t)*);
+    };
+}
diff --git a/rust/kernel/bindings.rs b/rust/kernel/bindings.rs
new file mode 100644
index 000000000000..29a21030688e
--- /dev/null
+++ b/rust/kernel/bindings.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings.
+//!
+//! Imports the generated bindings by `bindgen`.
+
+// See https://github.com/rust-lang/rust-bindgen/issues/1651.
+#![cfg_attr(test, allow(deref_nullptr))]
+#![cfg_attr(test, allow(unaligned_references))]
+#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
+#![allow(
+    clippy::all,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+mod bindings_raw {
+    // Use glob import here to expose all helpers.
+    // Symbols defined within the module will take precedence to the glob import.
+    pub use super::bindings_helper::*;
+    use crate::c_types;
+    include!(concat!(env!("OBJTREE"), "/rust/bindings_generated.rs"));
+}
+
+// When both a directly exposed symbol and a helper exists for the same function,
+// the directly exposed symbol is preferred and the helper becomes dead code, so
+// ignore the warning here.
+#[allow(dead_code)]
+mod bindings_helper {
+    // Import the generated bindings for types.
+    use super::bindings_raw::*;
+    use crate::c_types;
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings_helpers_generated.rs"
+    ));
+}
+
+pub use bindings_raw::*;
+
+pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const __GFP_HIGHMEM: gfp_t = ___GFP_HIGHMEM;
diff --git a/rust/kernel/bindings_helper.h b/rust/kernel/bindings_helper.h
new file mode 100644
index 000000000000..4151cb25f52d
--- /dev/null
+++ b/rust/kernel/bindings_helper.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header that contains the code (mostly headers) for which Rust bindings
+ * will be automatically generated by `bindgen`.
+ *
+ * Sorted alphabetically.
+ */
+
+#include <asm/io.h>
+#include <linux/amba/bus.h>
+#include <linux/cdev.h>
+#include <linux/clk.h>
+#include <linux/errname.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gpio/driver.h>
+#include <linux/hw_random.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/random.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+#include <linux/uaccess.h>
+#include <linux/uio.h>
+#include <uapi/linux/android/binder.h>
+
+/* `bindgen` gets confused at certain things. */
+const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
new file mode 100644
index 000000000000..f726927185c0
--- /dev/null
+++ b/rust/kernel/build_assert.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Build-time assert.
+
+/// Fails the build if the code path calling `build_error!` can possibly be executed.
+///
+/// If the macro is executed in const context, `build_error!` will panic.
+/// If the compiler or optimizer cannot guarantee that `build_error!` can never
+/// be called, a build error will be triggered.
+///
+/// # Examples
+/// ```
+/// # use kernel::build_error;
+/// #[inline]
+/// fn foo(a: usize) -> usize {
+///     a.checked_add(1).unwrap_or_else(|| build_error!("overflow"))
+/// }
+/// ```
+#[macro_export]
+macro_rules! build_error {
+    () => {{
+        $crate::build_error("")
+    }};
+    ($msg:expr) => {{
+        $crate::build_error($msg)
+    }};
+}
+
+/// Asserts that a boolean expression is `true` at compile time.
+///
+/// If the condition is evaluated to `false` in const context, `build_assert!`
+/// will panic. If the compiler or optimizer cannot guarantee the condition will
+/// be evaluated to `true`, a build error will be triggered.
+///
+/// [`static_assert!`] should be preferred to `build_assert!` whenever possible.
+///
+/// # Examples
+///
+/// These examples show that different types of [`assert!`] will trigger errors
+/// at different stage of compilation. It is preferred to err as early as
+/// possible, so [`static_assert!`] should be used whenever possible.
+/// ```compile_fail
+/// # use kernel::prelude::*;
+/// fn foo() {
+///     static_assert!(1 > 1); // Compile-time error
+///     build_assert!(1 > 1); // Build-time error
+///     assert!(1 > 1); // Run-time error
+/// }
+/// ```
+///
+/// When the condition refers to generic parameters or parameters of an inline function,
+/// [`static_assert!`] cannot be used. Use `build_assert!` in this scenario.
+/// ```no_run
+/// # use kernel::prelude::*;
+/// fn foo<const N: usize>() {
+///     // `static_assert!(N > 1);` is not allowed
+///     build_assert!(N > 1); // Build-time check
+///     assert!(N > 1); // Run-time check
+/// }
+///
+/// #[inline]
+/// fn bar(n: usize) {
+///     // `static_assert!(n > 1);` is not allowed
+///     build_assert!(n > 1); // Build-time check
+///     assert!(n > 1); // Run-time check
+/// }
+/// ```
+#[macro_export]
+macro_rules! build_assert {
+    ($cond:expr $(,)?) => {{
+        if !$cond {
+            $crate::build_error(concat!("assertion failed: ", stringify!($cond)));
+        }
+    }};
+    ($cond:expr, $msg:expr) => {{
+        if !$cond {
+            $crate::build_error($msg);
+        }
+    }};
+}
diff --git a/rust/kernel/c_types.rs b/rust/kernel/c_types.rs
new file mode 100644
index 000000000000..07593a3ba8be
--- /dev/null
+++ b/rust/kernel/c_types.rs
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! C types for the bindings.
+//!
+//! The bindings generated by `bindgen` use these types to map to the C ones.
+//!
+//! C's standard integer types may differ in width depending on
+//! the architecture, thus we need to conditionally compile those.
+
+#![allow(non_camel_case_types)]
+
+#[cfg(any(target_arch = "arm", target_arch = "x86", target_arch = "riscv32",))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i32;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u32;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `int`, i.e. it is an [`i32`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For some 32-bit architectures like this one, the kernel defines it as
+    /// `unsigned int`, i.e. it is an [`u32`].
+    pub type c_size_t = usize;
+}
+
+#[cfg(any(
+    target_arch = "aarch64",
+    target_arch = "x86_64",
+    target_arch = "powerpc64",
+    target_arch = "riscv64",
+))]
+mod c {
+    /// C `void` type.
+    pub type c_void = core::ffi::c_void;
+
+    /// C `char` type.
+    pub type c_char = i8;
+
+    /// C `signed char` type.
+    pub type c_schar = i8;
+
+    /// C `unsigned char` type.
+    pub type c_uchar = u8;
+
+    /// C `short` type.
+    pub type c_short = i16;
+
+    /// C `unsigned short` type.
+    pub type c_ushort = u16;
+
+    /// C `int` type.
+    pub type c_int = i32;
+
+    /// C `unsigned int` type.
+    pub type c_uint = u32;
+
+    /// C `long` type.
+    pub type c_long = i64;
+
+    /// C `unsigned long` type.
+    pub type c_ulong = u64;
+
+    /// C `long long` type.
+    pub type c_longlong = i64;
+
+    /// C `unsigned long long` type.
+    pub type c_ulonglong = u64;
+
+    /// C `ssize_t` type (typically defined in `<sys/types.h>` by POSIX).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `long`, i.e. it is an [`i64`].
+    pub type c_ssize_t = isize;
+
+    /// C `size_t` type (typically defined in `<stddef.h>`).
+    ///
+    /// For 64-bit architectures like this one, the kernel defines it as
+    /// `unsigned long`, i.e. it is an [`u64`].
+    pub type c_size_t = usize;
+}
+
+pub use c::*;
diff --git a/rust/kernel/chrdev.rs b/rust/kernel/chrdev.rs
new file mode 100644
index 000000000000..889a2f74fca1
--- /dev/null
+++ b/rust/kernel/chrdev.rs
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Character devices.
+//!
+//! Also called "char devices", `chrdev`, `cdev`.
+//!
+//! C header: [`include/linux/cdev.h`](../../../../include/linux/cdev.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#char-devices>
+
+use alloc::boxed::Box;
+use core::convert::TryInto;
+use core::marker::PhantomPinned;
+use core::pin::Pin;
+
+use crate::bindings;
+use crate::c_types;
+use crate::error::{code::*, Error, Result};
+use crate::file;
+use crate::str::CStr;
+
+/// Character device.
+///
+/// # Invariants
+///
+///   - [`self.0`] is valid and non-null.
+///   - [`(*self.0).ops`] is valid, non-null and has static lifetime.
+///   - [`(*self.0).owner`] is valid and, if non-null, has module lifetime.
+struct Cdev(*mut bindings::cdev);
+
+impl Cdev {
+    fn alloc(
+        fops: &'static bindings::file_operations,
+        module: &'static crate::ThisModule,
+    ) -> Result<Self> {
+        // SAFETY: FFI call.
+        let cdev = unsafe { bindings::cdev_alloc() };
+        if cdev.is_null() {
+            return Err(ENOMEM);
+        }
+        // SAFETY: `cdev` is valid and non-null since `cdev_alloc()`
+        // returned a valid pointer which was null-checked.
+        unsafe {
+            (*cdev).ops = fops;
+            (*cdev).owner = module.0;
+        }
+        // INVARIANTS:
+        //   - [`self.0`] is valid and non-null.
+        //   - [`(*self.0).ops`] is valid, non-null and has static lifetime,
+        //     because it was coerced from a reference with static lifetime.
+        //   - [`(*self.0).owner`] is valid and, if non-null, has module lifetime,
+        //     guaranteed by the [`ThisModule`] invariant.
+        Ok(Self(cdev))
+    }
+
+    fn add(&mut self, dev: bindings::dev_t, count: c_types::c_uint) -> Result {
+        // SAFETY: According to the type invariants:
+        //   - [`self.0`] can be safely passed to [`bindings::cdev_add`].
+        //   - [`(*self.0).ops`] will live at least as long as [`self.0`].
+        //   - [`(*self.0).owner`] will live at least as long as the
+        //     module, which is an implicit requirement.
+        let rc = unsafe { bindings::cdev_add(self.0, dev, count) };
+        if rc != 0 {
+            return Err(Error::from_kernel_errno(rc));
+        }
+        Ok(())
+    }
+}
+
+impl Drop for Cdev {
+    fn drop(&mut self) {
+        // SAFETY: [`self.0`] is valid and non-null by the type invariants.
+        unsafe {
+            bindings::cdev_del(self.0);
+        }
+    }
+}
+
+struct RegistrationInner<const N: usize> {
+    dev: bindings::dev_t,
+    used: usize,
+    cdevs: [Option<Cdev>; N],
+    _pin: PhantomPinned,
+}
+
+/// Character device registration.
+///
+/// May contain up to a fixed number (`N`) of devices. Must be pinned.
+pub struct Registration<const N: usize> {
+    name: &'static CStr,
+    minors_start: u16,
+    this_module: &'static crate::ThisModule,
+    inner: Option<RegistrationInner<N>>,
+}
+
+impl<const N: usize> Registration<{ N }> {
+    /// Creates a [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    ///
+    /// This associated function is intended to be used when you need to avoid
+    /// a memory allocation, e.g. when the [`Registration`] is a member of
+    /// a bigger structure inside your [`crate::KernelModule`] instance. If you
+    /// are going to pin the registration right away, call
+    /// [`Self::new_pinned()`] instead.
+    pub fn new(
+        name: &'static CStr,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> Self {
+        Registration {
+            name,
+            minors_start,
+            this_module,
+            inner: None,
+        }
+    }
+
+    /// Creates a pinned [`Registration`] object for a character device.
+    ///
+    /// This does *not* register the device: see [`Self::register()`].
+    pub fn new_pinned(
+        name: &'static CStr,
+        minors_start: u16,
+        this_module: &'static crate::ThisModule,
+    ) -> Result<Pin<Box<Self>>> {
+        Ok(Pin::from(Box::try_new(Self::new(
+            name,
+            minors_start,
+            this_module,
+        ))?))
+    }
+
+    /// Registers a character device.
+    ///
+    /// You may call this once per device type, up to `N` times.
+    pub fn register<T: file::Operations<OpenData = ()>>(self: Pin<&mut Self>) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.inner.is_none() {
+            let mut dev: bindings::dev_t = 0;
+            // SAFETY: Calling unsafe function. `this.name` has `'static`
+            // lifetime.
+            let res = unsafe {
+                bindings::alloc_chrdev_region(
+                    &mut dev,
+                    this.minors_start.into(),
+                    N.try_into()?,
+                    this.name.as_char_ptr(),
+                )
+            };
+            if res != 0 {
+                return Err(Error::from_kernel_errno(res));
+            }
+            const NONE: Option<Cdev> = None;
+            this.inner = Some(RegistrationInner {
+                dev,
+                used: 0,
+                cdevs: [NONE; N],
+                _pin: PhantomPinned,
+            });
+        }
+
+        let mut inner = this.inner.as_mut().unwrap();
+        if inner.used == N {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The adapter doesn't retrieve any state yet, so it's compatible with any
+        // registration.
+        let fops = unsafe { file::OperationsVtable::<Self, T>::build() };
+        let mut cdev = Cdev::alloc(fops, this.this_module)?;
+        cdev.add(inner.dev + inner.used as bindings::dev_t, 1)?;
+        inner.cdevs[inner.used].replace(cdev);
+        inner.used += 1;
+        Ok(())
+    }
+}
+
+impl<const N: usize> file::OpenAdapter<()> for Registration<{ N }> {
+    unsafe fn convert(_inode: *mut bindings::inode, _file: *mut bindings::file) -> *const () {
+        // TODO: Update the SAFETY comment on the call to `FileOperationsVTable::build` above once
+        // this is updated to retrieve state.
+        &()
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl<const N: usize> Sync for Registration<{ N }> {}
+
+impl<const N: usize> Drop for Registration<{ N }> {
+    fn drop(&mut self) {
+        if let Some(inner) = self.inner.as_mut() {
+            // Replicate kernel C behaviour: drop [`Cdev`]s before calling
+            // [`bindings::unregister_chrdev_region`].
+            for i in 0..inner.used {
+                inner.cdevs[i].take();
+            }
+            // SAFETY: [`self.inner`] is Some, so [`inner.dev`] was previously
+            // created using [`bindings::alloc_chrdev_region`].
+            unsafe {
+                bindings::unregister_chrdev_region(inner.dev, N.try_into().unwrap());
+            }
+        }
+    }
+}
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..46d3b81f5688
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Common clock framework.
+//!
+//! C header: [`include/linux/clk.h`](../../../../include/linux/clk.h)
+
+use crate::{bindings, error::Result, to_result};
+use core::mem::ManuallyDrop;
+
+/// Represents `struct clk *`.
+///
+/// # Invariants
+///
+/// The pointer is valid.
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Creates new clock structure from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid.
+    pub unsafe fn new(clk: *mut bindings::clk) -> Self {
+        Self(clk)
+    }
+
+    /// Returns value of the rate field of `struct clk`.
+    pub fn get_rate(&self) -> usize {
+        // SAFETY: The pointer is valid by the type invariant.
+        unsafe { bindings::clk_get_rate(self.0) as usize }
+    }
+
+    /// Prepares and enables the underlying hardware clock.
+    ///
+    /// This function should not be called in atomic context.
+    pub fn prepare_enable(self) -> Result<EnabledClk> {
+        // SAFETY: The pointer is valid by the type invariant.
+        to_result(|| unsafe { bindings::clk_prepare_enable(self.0) })?;
+        Ok(EnabledClk(self))
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: The pointer is valid by the type invariant.
+        unsafe { bindings::clk_put(self.0) };
+    }
+}
+
+/// A clock variant that is prepared and enabled.
+pub struct EnabledClk(Clk);
+
+impl EnabledClk {
+    /// Returns value of the rate field of `struct clk`.
+    pub fn get_rate(&self) -> usize {
+        self.0.get_rate()
+    }
+
+    /// Disables and later unprepares the underlying hardware clock prematurely.
+    ///
+    /// This function should not be called in atomic context.
+    pub fn disable_unprepare(self) -> Clk {
+        let mut clk = ManuallyDrop::new(self);
+        // SAFETY: The pointer is valid by the type invariant.
+        unsafe { bindings::clk_disable_unprepare(clk.0 .0) };
+        core::mem::replace(&mut clk.0, Clk(core::ptr::null_mut()))
+    }
+}
+
+impl Drop for EnabledClk {
+    fn drop(&mut self) {
+        // SAFETY: The pointer is valid by the type invariant.
+        unsafe { bindings::clk_disable_unprepare(self.0 .0) };
+    }
+}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
new file mode 100644
index 000000000000..1602aa6935ca
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](../../../../include/linux/cred.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
+
+use crate::bindings;
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref};
+
+/// Wraps the kernel's `struct cred`.
+///
+/// # Invariants
+///
+/// The pointer `Credential::ptr` is non-null and valid. Its reference count is also non-zero.
+pub struct Credential {
+    pub(crate) ptr: *const bindings::cred,
+}
+
+impl Clone for Credential {
+    fn clone(&self) -> Self {
+        // SAFETY: The type invariants guarantee that `self.ptr` has a non-zero reference count.
+        let ptr = unsafe { bindings::get_cred(self.ptr) };
+
+        // INVARIANT: We incremented the reference count to account for the new `Credential` being
+        // created.
+        Self { ptr }
+    }
+}
+
+impl Drop for Credential {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that `ptr` has a non-zero reference count.
+        unsafe { bindings::put_cred(self.ptr) };
+    }
+}
+
+/// A wrapper for [`Credential`] that doesn't automatically decrement the refcount when dropped.
+///
+/// We need the wrapper because [`ManuallyDrop`] alone would allow callers to call
+/// [`ManuallyDrop::into_inner`]. This would allow an unsafe sequence to be triggered without
+/// `unsafe` blocks because it would trigger an unbalanced call to `put_cred`.
+///
+/// # Invariants
+///
+/// The wrapped [`Credential`] remains valid for the lifetime of the object.
+pub struct CredentialRef<'a> {
+    cred: ManuallyDrop<Credential>,
+    _p: PhantomData<&'a ()>,
+}
+
+impl CredentialRef<'_> {
+    /// Constructs a new [`struct cred`] wrapper that doesn't change its reference count.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *const bindings::cred) -> Self {
+        Self {
+            cred: ManuallyDrop::new(Credential { ptr }),
+            _p: PhantomData,
+        }
+    }
+}
+
+impl Deref for CredentialRef<'_> {
+    type Target = Credential;
+
+    fn deref(&self) -> &Self::Target {
+        self.cred.deref()
+    }
+}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
new file mode 100644
index 000000000000..05a9484cbcd4
--- /dev/null
+++ b/rust/kernel/device.rs
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic devices that are part of the kernel's driver model.
+//!
+//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
+
+#[cfg(CONFIG_COMMON_CLK)]
+use crate::{clk::Clk, error::from_kernel_err_ptr};
+
+use crate::{
+    bindings,
+    revocable::{Revocable, RevocableGuard},
+    str::CStr,
+    sync::{NeedsLockClass, RevocableMutex, RevocableMutexGuard, UniqueRef},
+    Result,
+};
+use core::{
+    fmt,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+};
+
+#[cfg(CONFIG_PRINTK)]
+use crate::{c_str, c_types};
+
+/// A raw device.
+///
+/// # Safety
+///
+/// Implementers must ensure that the `*mut device` returned by [`RawDevice::raw_device`] is
+/// related to `self`, that is, actions on it will affect `self`. For example, if one calls
+/// `get_device`, then the refcount on the device represented by `self` will be incremented.
+///
+/// Additionally, implementers must ensure that the device is never renamed. Commit a5462516aa994
+/// has details on why `device_rename` should not be used.
+pub unsafe trait RawDevice {
+    /// Returns the raw `struct device` related to `self`.
+    fn raw_device(&self) -> *mut bindings::device;
+
+    /// Returns the name of the device.
+    fn name(&self) -> &CStr {
+        let ptr = self.raw_device();
+
+        // SAFETY: `ptr` is valid because `self` keeps it alive.
+        let name = unsafe { bindings::dev_name(ptr) };
+
+        // SAFETY: The name of the device remains valid while it is alive (because the device is
+        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
+        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
+        // by the compiler because of their lifetimes).
+        unsafe { CStr::from_char_ptr(name) }
+    }
+
+    /// Lookups a clock producer consumed by this device.
+    ///
+    /// Returns a managed reference to the clock producer.
+    #[cfg(CONFIG_COMMON_CLK)]
+    fn clk_get(&self, id: Option<&CStr>) -> Result<Clk> {
+        let id_ptr = match id {
+            Some(cstr) => cstr.as_char_ptr(),
+            None => core::ptr::null(),
+        };
+
+        // SAFETY: `id_ptr` is optional and may be either a valid pointer
+        // from the type invariant or NULL otherwise.
+        let clk_ptr = unsafe { from_kernel_err_ptr(bindings::clk_get(self.raw_device(), id_ptr)) }?;
+
+        // SAFETY: Clock is initialized with valid pointer returned from `bindings::clk_get` call.
+        unsafe { Ok(Clk::new(clk_ptr)) }
+    }
+
+    /// Prints an emergency-level message (level 0) prefixed with device information.
+    ///
+    /// More details are available from [`dev_emerg`].
+    fn pr_emerg(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_EMERG, args) };
+    }
+
+    /// Prints an alert-level message (level 1) prefixed with device information.
+    ///
+    /// More details are available from [`dev_alert`].
+    fn pr_alert(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_ALERT, args) };
+    }
+
+    /// Prints a critical-level message (level 2) prefixed with device information.
+    ///
+    /// More details are available from [`dev_crit`].
+    fn pr_crit(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_CRIT, args) };
+    }
+
+    /// Prints an error-level message (level 3) prefixed with device information.
+    ///
+    /// More details are available from [`dev_err`].
+    fn pr_err(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_ERR, args) };
+    }
+
+    /// Prints a warning-level message (level 4) prefixed with device information.
+    ///
+    /// More details are available from [`dev_warn`].
+    fn pr_warn(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_WARNING, args) };
+    }
+
+    /// Prints a notice-level message (level 5) prefixed with device information.
+    ///
+    /// More details are available from [`dev_notice`].
+    fn pr_notice(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_NOTICE, args) };
+    }
+
+    /// Prints an info-level message (level 6) prefixed with device information.
+    ///
+    /// More details are available from [`dev_info`].
+    fn pr_info(&self, args: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+        unsafe { self.printk(bindings::KERN_INFO, args) };
+    }
+
+    /// Prints a debug-level message (level 7) prefixed with device information.
+    ///
+    /// More details are available from [`dev_dbg`].
+    fn pr_dbg(&self, args: fmt::Arguments<'_>) {
+        if cfg!(debug_assertions) {
+            // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+            unsafe { self.printk(bindings::KERN_DEBUG, args) };
+        }
+    }
+
+    /// Prints the provided message to the console.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `klevel` is null-terminated; in particular, one of the
+    /// `KERN_*`constants, for example, `KERN_CRIT`, `KERN_ALERT`, etc.
+    #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+    unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
+        // SAFETY: `klevel` is null-terminated and one of the kernel constants. `self.raw_device`
+        // is valid because `self` is valid. The "%pA" format string expects a pointer to
+        // `fmt::Arguments`, which is what we're passing as the last argument.
+        #[cfg(CONFIG_PRINTK)]
+        unsafe {
+            bindings::_dev_printk(
+                klevel as *const _ as *const c_types::c_char,
+                self.raw_device(),
+                c_str!("%pA").as_char_ptr(),
+                &msg as *const _ as *const c_types::c_void,
+            )
+        };
+    }
+}
+
+/// A ref-counted device.
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+pub struct Device {
+    pub(crate) ptr: *mut bindings::device,
+}
+
+// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
+// from any thread.
+unsafe impl Sync for Device {}
+
+impl Device {
+    /// Creates a new device instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
+    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
+        unsafe { bindings::get_device(ptr) };
+        // INVARIANT: The safety requirements satisfy all but one invariant, which is that `self`
+        // owns a reference. This is satisfied by the call to `get_device` above.
+        Self { ptr }
+    }
+
+    /// Creates a new device instance from an existing [`RawDevice`] instance.
+    pub fn from_dev(dev: &dyn RawDevice) -> Self {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { Self::new(dev.raw_device()) }
+    }
+}
+
+// SAFETY: The device returned by `raw_device` is the one for which we hold a reference.
+unsafe impl RawDevice for Device {
+    fn raw_device(&self) -> *mut bindings::device {
+        self.ptr
+    }
+}
+
+impl Drop for Device {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::put_device(self.ptr) };
+    }
+}
+
+/// Device data.
+///
+/// When a device is removed (for whatever reason, for example, because the device was unplugged or
+/// because the user decided to unbind the driver), the driver is given a chance to clean its state
+/// up, and all io resources should ideally not be used anymore.
+///
+/// However, the device data is reference-counted because other subsystems hold pointers to it. So
+/// some device state must be freed and not used anymore, while others must remain accessible.
+///
+/// This struct separates the device data into three categories:
+///   1. Registrations: are destroyed when the device is removed, but before the io resources
+///      become inaccessible.
+///   2. Io resources: are available until the device is removed.
+///   3. General data: remain available as long as the ref count is nonzero.
+///
+/// This struct implements the `DeviceRemoval` trait so that it can clean resources up even if not
+/// explicitly called by the device drivers.
+pub struct Data<T, U, V> {
+    registrations: RevocableMutex<T>,
+    resources: Revocable<U>,
+    general: V,
+}
+
+/// Safely creates an new reference-counted instance of [`Data`].
+#[doc(hidden)]
+#[macro_export]
+macro_rules! new_device_data {
+    ($reg:expr, $res:expr, $gen:expr, $name:literal) => {{
+        static mut CLASS1: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        static mut CLASS2: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        let regs = $reg;
+        let res = $res;
+        let gen = $gen;
+        let name = $crate::c_str!($name);
+        // SAFETY: `CLASS1` and `CLASS2` are never used by Rust code directly; the C portion of the
+        // kernel may change it though.
+        unsafe {
+            $crate::device::Data::try_new(
+                regs,
+                res,
+                gen,
+                name,
+                CLASS1.as_mut_ptr(),
+                CLASS2.as_mut_ptr(),
+            )
+        }
+    }};
+}
+
+impl<T, U, V> Data<T, U, V> {
+    /// Creates a new instance of `Data`.
+    ///
+    /// It is recommended that the [`new_device_data`] macro be used as it automatically creates
+    /// the lock classes.
+    ///
+    /// # Safety
+    ///
+    /// `key1` and `key2` must point to valid memory locations and remain valid until `self` is
+    /// dropped.
+    pub unsafe fn try_new(
+        registrations: T,
+        resources: U,
+        general: V,
+        name: &'static CStr,
+        key1: *mut bindings::lock_class_key,
+        key2: *mut bindings::lock_class_key,
+    ) -> Result<Pin<UniqueRef<Self>>> {
+        let mut ret = Pin::from(UniqueRef::try_new(Self {
+            // SAFETY: We call `RevocableMutex::init` below.
+            registrations: unsafe { RevocableMutex::new(registrations) },
+            resources: Revocable::new(resources),
+            general,
+        })?);
+
+        // SAFETY: `Data::registrations` is pinned when `Data` is.
+        let pinned = unsafe { ret.as_mut().map_unchecked_mut(|d| &mut d.registrations) };
+
+        // SAFETY: The safety requirements of this function satisfy those of `RevocableMutex::init`.
+        unsafe { pinned.init(name, key1, key2) };
+        Ok(ret)
+    }
+
+    /// Returns the resources if they're still available.
+    pub fn resources(&self) -> Option<RevocableGuard<'_, U>> {
+        self.resources.try_access()
+    }
+
+    /// Returns the locked registrations if they're still available.
+    pub fn registrations(&self) -> Option<RevocableMutexGuard<'_, T>> {
+        self.registrations.try_lock()
+    }
+}
+
+impl<T, U, V> crate::driver::DeviceRemoval for Data<T, U, V> {
+    fn device_remove(&self) {
+        // We revoke the registrations first so that resources are still available to them during
+        // unregistration.
+        self.registrations.revoke();
+
+        // Release resources now. General data remains available.
+        self.resources.revoke();
+    }
+}
+
+impl<T, U, V> Deref for Data<T, U, V> {
+    type Target = V;
+
+    fn deref(&self) -> &V {
+        &self.general
+    }
+}
+
+impl<T, U, V> DerefMut for Data<T, U, V> {
+    fn deref_mut(&mut self) -> &mut V {
+        &mut self.general
+    }
+}
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! dev_printk {
+    ($method:ident, $dev:expr, $($f:tt)*) => {
+        {
+            // We have an explicity `use` statement here so that callers of this macro are not
+            // required to explicitly use the `RawDevice` trait to use its functions.
+            use $crate::device::RawDevice;
+            ($dev).$method(core::format_args!($($f)*));
+        }
+    }
+}
+
+/// Prints an emergency-level message (level 0) prefixed with device information.
+///
+/// This level should be used if the system is unusable.
+///
+/// Equivalent to the kernel's `dev_emerg` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_emerg!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_emerg {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_emerg, $($f)*); }
+}
+
+/// Prints an alert-level message (level 1) prefixed with device information.
+///
+/// This level should be used if action must be taken immediately.
+///
+/// Equivalent to the kernel's `dev_alert` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_alert!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_alert {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_alert, $($f)*); }
+}
+
+/// Prints a critical-level message (level 2) prefixed with device information.
+///
+/// This level should be used in critical conditions.
+///
+/// Equivalent to the kernel's `dev_crit` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_crit!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_crit {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_crit, $($f)*); }
+}
+
+/// Prints an error-level message (level 3) prefixed with device information.
+///
+/// This level should be used in error conditions.
+///
+/// Equivalent to the kernel's `dev_err` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_err!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_err {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_err, $($f)*); }
+}
+
+/// Prints a warning-level message (level 4) prefixed with device information.
+///
+/// This level should be used in warning conditions.
+///
+/// Equivalent to the kernel's `dev_warn` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_warn!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_warn {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_warn, $($f)*); }
+}
+
+/// Prints a notice-level message (level 5) prefixed with device information.
+///
+/// This level should be used in normal but significant conditions.
+///
+/// Equivalent to the kernel's `dev_notice` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_notice!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_notice {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_notice, $($f)*); }
+}
+
+/// Prints an info-level message (level 6) prefixed with device information.
+///
+/// This level should be used for informational messages.
+///
+/// Equivalent to the kernel's `dev_info` macro.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_info!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_info {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_info, $($f)*); }
+}
+
+/// Prints a debug-level message (level 7) prefixed with device information.
+///
+/// This level should be used for debug messages.
+///
+/// Equivalent to the kernel's `dev_dbg` macro, except that it doesn't support dynamic debug yet.
+///
+/// Mimics the interface of [`std::print!`]. More information about the syntax is available from
+/// [`core::fmt`] and [`alloc::format!`].
+///
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+///
+/// fn example(dev: &Device) {
+///     dev_dbg!(dev, "hello {}\n", "there");
+/// }
+/// ```
+#[macro_export]
+macro_rules! dev_dbg {
+    ($($f:tt)*) => { $crate::dev_printk!(pr_dbg, $($f)*); }
+}
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
new file mode 100644
index 000000000000..21fa790b1dc9
--- /dev/null
+++ b/rust/kernel/driver.rs
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
+//!
+//! Each bus/subsystem is expected to implement [`DriverOps`], which allows drivers to register
+//! using the [`Registration`] class.
+
+use crate::{error::code::*, str::CStr, sync::Ref, KernelModule, Result, ThisModule};
+use alloc::boxed::Box;
+use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, pin::Pin};
+
+/// A subsystem (e.g., PCI, Platform, Amba, etc.) that allows drivers to be written for it.
+pub trait DriverOps {
+    /// The type that holds information about the registration. This is typically a struct defined
+    /// by the C portion of the kernel.
+    type RegType: Default;
+
+    /// Registers a driver.
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid, initialised, and writable memory. It may be modified by this
+    /// function to hold registration state.
+    ///
+    /// On success, `reg` must remain pinned and valid until the matching call to
+    /// [`DriverOps::unregister`].
+    unsafe fn register(
+        reg: *mut Self::RegType,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result;
+
+    /// Unregisters a driver previously registered with [`DriverOps::register`].
+    ///
+    /// # Safety
+    ///
+    /// `reg` must point to valid writable memory, initialised by a previous successful call to
+    /// [`DriverOps::register`].
+    unsafe fn unregister(reg: *mut Self::RegType);
+}
+
+/// The registration of a driver.
+pub struct Registration<T: DriverOps> {
+    is_registered: bool,
+    concrete_reg: UnsafeCell<T::RegType>,
+}
+
+// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
+// share references to it with multiple threads as nothing can be done.
+unsafe impl<T: DriverOps> Sync for Registration<T> {}
+
+impl<T: DriverOps> Registration<T> {
+    /// Creates a new instance of the registration object.
+    pub fn new() -> Self {
+        Self {
+            is_registered: false,
+            concrete_reg: UnsafeCell::new(T::RegType::default()),
+        }
+    }
+
+    /// Allocates a pinned registration object and registers it.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned(name: &'static CStr, module: &'static ThisModule) -> Result<Pin<Box<Self>>> {
+        let mut reg = Pin::from(Box::try_new(Self::new())?);
+        reg.as_mut().register(name, module)?;
+        Ok(reg)
+    }
+
+    /// Registers a driver with its subsystem.
+    ///
+    /// It must be pinned because the memory block that represents the registration is potentially
+    /// self-referential.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.is_registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `concrete_reg` was initialised via its default constructor. It is only freed
+        // after `Self::drop` is called, which first calls `T::unregister`.
+        unsafe { T::register(this.concrete_reg.get(), name, module) }?;
+
+        this.is_registered = true;
+        Ok(())
+    }
+}
+
+impl<T: DriverOps> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: DriverOps> Drop for Registration<T> {
+    fn drop(&mut self) {
+        if self.is_registered {
+            // SAFETY: This path only runs if a previous call to `T::register` completed
+            // successfully.
+            unsafe { T::unregister(self.concrete_reg.get()) };
+        }
+    }
+}
+
+/// Conversion from a device id to a raw device id.
+///
+/// This is meant to be implemented by buses/subsystems so that they can use [`IdTable`] to
+/// guarantee (at compile-time) zero-termination of device id tables provided by drivers.
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///   - [`RawDeviceId::ZERO`] is actually a zeroed-out version of the raw device id.
+///   - [`RawDeviceId::to_rawid`] stores `offset` in the context/data field of the raw device id so
+///     that buses can recover the pointer to the data.
+pub unsafe trait RawDeviceId {
+    /// The raw type that holds the device id.
+    ///
+    /// Id tables created from [`Self`] are going to hold this type in its zero-terminated array.
+    type RawType: Copy;
+
+    /// A zeroed-out representation of the raw device id.
+    ///
+    /// Id tables created from [`Self`] use [`Self::ZERO`] as the sentinel to indicate the end of
+    /// the table.
+    const ZERO: Self::RawType;
+
+    /// Converts an id into a raw id.
+    ///
+    /// `offset` is the offset from the memory location where the raw device id is stored to the
+    /// location where its associated context information is stored. Implementations must store
+    /// this in the appropriate context/data field of the raw type.
+    fn to_rawid(&self, offset: isize) -> Self::RawType;
+}
+
+/// A zero-terminated device id array, followed by context data.
+#[repr(C)]
+pub struct IdArray<T: RawDeviceId, U, const N: usize> {
+    ids: [T::RawType; N],
+    sentinel: T::RawType,
+    id_infos: [Option<U>; N],
+}
+
+impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
+    /// Creates a new instance of the array.
+    ///
+    /// The contents are derived from the given identifiers and context information.
+    pub const fn new(ids: [T; N], infos: [Option<U>; N]) -> Self
+    where
+        T: ~const RawDeviceId + Copy,
+    {
+        let mut array = Self {
+            ids: [T::ZERO; N],
+            sentinel: T::ZERO,
+            id_infos: infos,
+        };
+        let mut i = 0usize;
+        while i < N {
+            // SAFETY: Both pointers are within `array` (or one byte beyond), consequently they are
+            // derived from the same allocated object. We are using a `u8` pointer, whose size 1,
+            // so the pointers are necessarily 1-byte aligned.
+            let offset = unsafe {
+                (&array.id_infos[i] as *const _ as *const u8)
+                    .offset_from(&array.ids[i] as *const _ as _)
+            };
+            array.ids[i] = ids[i].to_rawid(offset);
+            i += 1;
+        }
+        array
+    }
+
+    /// Returns an `IdTable` backed by `self`.
+    ///
+    /// This is used to essentially erase the array size.
+    pub const fn as_table(&self) -> IdTable<'_, T, U> {
+        IdTable {
+            first: &self.ids[0],
+            _p: PhantomData,
+        }
+    }
+}
+
+/// A device id table.
+///
+/// The table is guaranteed to be zero-terminated and to be followed by an array of context data of
+/// type `Option<U>`.
+pub struct IdTable<'a, T: RawDeviceId, U> {
+    first: &'a T::RawType,
+    _p: PhantomData<&'a U>,
+}
+
+impl<T: RawDeviceId, U> const AsRef<T::RawType> for IdTable<'_, T, U> {
+    fn as_ref(&self) -> &T::RawType {
+        self.first
+    }
+}
+
+/// Counts the number of parenthesis-delimited, comma-separated items.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::count_paren_items;
+///
+/// assert_eq!(0, count_paren_items!());
+/// assert_eq!(1, count_paren_items!((A)));
+/// assert_eq!(1, count_paren_items!((A),));
+/// assert_eq!(2, count_paren_items!((A), (B)));
+/// assert_eq!(2, count_paren_items!((A), (B),));
+/// assert_eq!(3, count_paren_items!((A), (B), (C)));
+/// assert_eq!(3, count_paren_items!((A), (B), (C),));
+/// ```
+#[macro_export]
+macro_rules! count_paren_items {
+    (($($item:tt)*), $($remaining:tt)*) => { 1 + $crate::count_paren_items!($($remaining)*) };
+    (($($item:tt)*)) => { 1 };
+    () => { 0 };
+}
+
+/// Converts a comma-separated list of pairs into an array with the first element. That is, it
+/// discards the second element of the pair.
+///
+/// Additionally, it automatically introduces a type if the first element is warpped in curly
+/// braces, for example, if it's `{v: 10}`, it becomes `X { v: 10 }`; this is to avoid repeating
+/// the type.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::first_item;
+///
+/// #[derive(PartialEq, Debug)]
+/// struct X {
+///     v: u32,
+/// }
+///
+/// assert_eq!([] as [X; 0], first_item!(X, ));
+/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y)));
+/// assert_eq!([X { v: 10 }], first_item!(X, ({ v: 10 }, Y),));
+/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y)));
+/// assert_eq!([X { v: 10 }], first_item!(X, (X { v: 10 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }], first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, ({ v: 10 }, Y), ({ v: 20 }, Y), ({v: 30}, Y),));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y)));
+/// assert_eq!([X { v: 10 }, X { v: 20 }, X { v: 30 }],
+///            first_item!(X, (X { v: 10 }, Y), (X { v: 20 }, Y), (X {v: 30}, Y),));
+/// ```
+#[macro_export]
+macro_rules! first_item {
+    ($id_type:ty, $(({$($first:tt)*}, $second:expr)),* $(,)?) => {
+        {
+            type IdType = $id_type;
+            [$(IdType{$($first)*},)*]
+        }
+    };
+    ($id_type:ty, $(($first:expr, $second:expr)),* $(,)?) => { [$($first,)*] };
+}
+
+/// Converts a comma-separated list of pairs into an array with the second element. That is, it
+/// discards the first element of the pair.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::second_item;
+///
+/// assert_eq!([] as [u32; 0], second_item!());
+/// assert_eq!([10u32], second_item!((X, 10u32)));
+/// assert_eq!([10u32], second_item!((X, 10u32),));
+/// assert_eq!([10u32], second_item!(({X}, 10u32)));
+/// assert_eq!([10u32], second_item!(({X}, 10u32),));
+/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20)));
+/// assert_eq!([10u32, 20], second_item!((X, 10u32), (X, 20),));
+/// assert_eq!([10u32, 20], second_item!(({X}, 10u32), ({X}, 20)));
+/// assert_eq!([10u32, 20], second_item!(({X}, 10u32), ({X}, 20),));
+/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30)));
+/// assert_eq!([10u32, 20, 30], second_item!((X, 10u32), (X, 20), (X, 30),));
+/// assert_eq!([10u32, 20, 30], second_item!(({X}, 10u32), ({X}, 20), ({X}, 30)));
+/// assert_eq!([10u32, 20, 30], second_item!(({X}, 10u32), ({X}, 20), ({X}, 30),));
+/// ```
+#[macro_export]
+macro_rules! second_item {
+    ($(({$($first:tt)*}, $second:expr)),* $(,)?) => { [$($second,)*] };
+    ($(($first:expr, $second:expr)),* $(,)?) => { [$($second,)*] };
+}
+
+/// Defines a new constant [`IdArray`] with a concise syntax.
+///
+/// It is meant to be used by buses and subsystems to create a similar macro with their device id
+/// type already specified, i.e., with fewer parameters to the end user.
+///
+/// # Examples
+///
+/// ```
+/// #![feature(const_trait_impl)]
+/// # use kernel::{define_id_array, driver::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl const RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+///     fn to_rawid(&self, offset: isize) -> Self::RawType {
+///         (self.0 as u64 + 1, offset)
+///     }
+/// }
+///
+/// define_id_array!(A1, Id, (), []);
+/// define_id_array!(A2, Id, &'static [u8], [(Id(10), None)]);
+/// define_id_array!(A3, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
+/// define_id_array!(A4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
+/// define_id_array!(A5, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
+/// define_id_array!(A6, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
+/// define_id_array!(A7, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
+/// define_id_array!(A8, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
+/// ```
+#[macro_export]
+macro_rules! define_id_array {
+    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
+        const $table_name:
+            $crate::driver::IdArray<$id_type, $data_type, { $crate::count_paren_items!($($t)*) }> =
+                $crate::driver::IdArray::new(
+                    $crate::first_item!($id_type, $($t)*), $crate::second_item!($($t)*));
+    };
+}
+
+/// Defines a new constant [`IdTable`] with a concise syntax.
+///
+/// It is meant to be used by buses and subsystems to create a similar macro with their device id
+/// type already specified, i.e., with fewer parameters to the end user.
+///
+/// # Examples
+///
+/// ```
+/// #![feature(const_trait_impl)]
+/// # use kernel::{define_id_table, driver::RawDeviceId};
+///
+/// #[derive(Copy, Clone)]
+/// struct Id(u32);
+///
+/// // SAFETY: `ZERO` is all zeroes and `to_rawid` stores `offset` as the second element of the raw
+/// // device id pair.
+/// unsafe impl const RawDeviceId for Id {
+///     type RawType = (u64, isize);
+///     const ZERO: Self::RawType = (0, 0);
+///     fn to_rawid(&self, offset: isize) -> Self::RawType {
+///         (self.0 as u64 + 1, offset)
+///     }
+/// }
+///
+/// define_id_table!(T1, Id, &'static [u8], [(Id(10), None)]);
+/// define_id_table!(T2, Id, &'static [u8], [(Id(10), Some(b"id1")), ]);
+/// define_id_table!(T3, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2"))]);
+/// define_id_table!(T4, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), Some(b"id2")), ]);
+/// define_id_table!(T5, Id, &'static [u8], [(Id(10), None), (Id(20), Some(b"id2")), ]);
+/// define_id_table!(T6, Id, &'static [u8], [(Id(10), Some(b"id1")), (Id(20), None), ]);
+/// define_id_table!(T7, Id, &'static [u8], [(Id(10), None), (Id(20), None), ]);
+/// ```
+#[macro_export]
+macro_rules! define_id_table {
+    ($table_name:ident, $id_type:ty, $data_type:ty, [ $($t:tt)* ]) => {
+        const $table_name: Option<$crate::driver::IdTable<'static, $id_type, $data_type>> = {
+            $crate::define_id_array!(ARRAY, $id_type, $data_type, [ $($t)* ]);
+            Some(ARRAY.as_table())
+        };
+    };
+}
+
+/// Custom code within device removal.
+pub trait DeviceRemoval {
+    /// Cleans resources up when the device is removed.
+    ///
+    /// This is called when a device is removed and offers implementers the chance to run some code
+    /// that cleans state up.
+    fn device_remove(&self);
+}
+
+impl DeviceRemoval for () {
+    fn device_remove(&self) {}
+}
+
+impl<T: DeviceRemoval> DeviceRemoval for Ref<T> {
+    fn device_remove(&self) {
+        self.deref().device_remove();
+    }
+}
+
+impl<T: DeviceRemoval> DeviceRemoval for Box<T> {
+    fn device_remove(&self) {
+        self.deref().device_remove();
+    }
+}
+
+/// A kernel module that only registers the given driver on init.
+///
+/// This is a helper struct to make it easier to define single-functionality modules, in this case,
+/// modules that offer a single driver.
+pub struct Module<T: DriverOps> {
+    _driver: Pin<Box<Registration<T>>>,
+}
+
+impl<T: DriverOps> KernelModule for Module<T> {
+    fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        Ok(Self {
+            _driver: Registration::new_pinned(name, module)?,
+        })
+    }
+}
+
+/// Declares a kernel module that exposes a single driver.
+///
+/// It is meant to be used as a helper by other subsystems so they can more easily expose their own
+/// macros.
+#[macro_export]
+macro_rules! module_driver {
+    (<$gen_type:ident>, $driver_ops:ty, { type: $type:ty, $($f:tt)* }) => {
+        type Ops<$gen_type> = $driver_ops;
+        type ModuleType = $crate::driver::Module<Ops<$type>>;
+        $crate::prelude::module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
new file mode 100644
index 000000000000..65cf1e7597cf
--- /dev/null
+++ b/rust/kernel/error.rs
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel errors.
+//!
+//! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
+
+use crate::str::CStr;
+use crate::{bindings, c_types};
+use alloc::{
+    alloc::{AllocError, LayoutError},
+    collections::TryReserveError,
+};
+use core::convert::From;
+use core::fmt;
+use core::num::TryFromIntError;
+use core::str::{self, Utf8Error};
+
+/// Contains the C-compatible error codes.
+pub mod code {
+    macro_rules! declare_err {
+        ($err:tt $(,)? $($doc:expr),+) => {
+            $(
+            #[doc = $doc]
+            )*
+            pub const $err: super::Error = super::Error(-(crate::bindings::$err as i32));
+        };
+    }
+
+    declare_err!(EPERM, "Operation not permitted.");
+
+    declare_err!(ENOENT, "No such file or directory.");
+
+    declare_err!(ESRCH, "No such process.");
+
+    declare_err!(EINTR, "Interrupted system call.");
+
+    declare_err!(EIO, "I/O error.");
+
+    declare_err!(ENXIO, "No such device or address.");
+
+    declare_err!(E2BIG, "Argument list too long.");
+
+    declare_err!(ENOEXEC, "Exec format error.");
+
+    declare_err!(EBADF, "Bad file number.");
+
+    declare_err!(ECHILD, "Exec format error.");
+
+    declare_err!(EAGAIN, "Try again.");
+
+    declare_err!(ENOMEM, "Out of memory.");
+
+    declare_err!(EACCES, "Permission denied.");
+
+    declare_err!(EFAULT, "Bad address.");
+
+    declare_err!(ENOTBLK, "Block device required.");
+
+    declare_err!(EBUSY, "Device or resource busy.");
+
+    declare_err!(EEXIST, "File exists.");
+
+    declare_err!(EXDEV, "Cross-device link.");
+
+    declare_err!(ENODEV, "No such device.");
+
+    declare_err!(ENOTDIR, "Not a directory.");
+
+    declare_err!(EISDIR, "Is a directory.");
+
+    declare_err!(EINVAL, "Invalid argument.");
+
+    declare_err!(ENFILE, "File table overflow.");
+
+    declare_err!(EMFILE, "Too many open files.");
+
+    declare_err!(ENOTTY, "Not a typewriter.");
+
+    declare_err!(ETXTBSY, "Text file busy.");
+
+    declare_err!(EFBIG, "File too large.");
+
+    declare_err!(ENOSPC, "No space left on device.");
+
+    declare_err!(ESPIPE, "Illegal seek.");
+
+    declare_err!(EROFS, "Read-only file system.");
+
+    declare_err!(EMLINK, "Too many links.");
+
+    declare_err!(EPIPE, "Broken pipe.");
+
+    declare_err!(EDOM, "Math argument out of domain of func.");
+
+    declare_err!(ERANGE, "Math result not representable.");
+
+    declare_err!(EDEADLK, "Resource deadlock would occur");
+
+    declare_err!(ENAMETOOLONG, "File name too long");
+
+    declare_err!(ENOLCK, "No record locks available");
+
+    declare_err!(
+        ENOSYS,
+        "Invalid system call number.",
+        "",
+        "This error code is special: arch syscall entry code will return",
+        "[`ENOSYS`] if users try to call a syscall that doesn't exist.",
+        "To keep failures of syscalls that really do exist distinguishable from",
+        "failures due to attempts to use a nonexistent syscall, syscall",
+        "implementations should refrain from returning [`ENOSYS`]."
+    );
+
+    declare_err!(ENOTEMPTY, "Directory not empty.");
+
+    declare_err!(ELOOP, "Too many symbolic links encountered.");
+
+    declare_err!(EWOULDBLOCK, "Operation would block.");
+
+    declare_err!(ENOMSG, "No message of desired type.");
+
+    declare_err!(EIDRM, "Identifier removed.");
+
+    declare_err!(ECHRNG, "Channel number out of range.");
+
+    declare_err!(EL2NSYNC, "Level 2 not synchronized.");
+
+    declare_err!(EL3HLT, "Level 3 halted.");
+
+    declare_err!(EL3RST, "Level 3 reset.");
+
+    declare_err!(ELNRNG, "Link number out of range.");
+
+    declare_err!(EUNATCH, "Protocol driver not attached.");
+
+    declare_err!(ENOCSI, "No CSI structure available.");
+
+    declare_err!(EL2HLT, "Level 2 halted.");
+
+    declare_err!(EBADE, "Invalid exchange.");
+
+    declare_err!(EBADR, "Invalid request descriptor.");
+
+    declare_err!(EXFULL, "Exchange full.");
+
+    declare_err!(ENOANO, "No anode.");
+
+    declare_err!(EBADRQC, "Invalid request code.");
+
+    declare_err!(EBADSLT, "Invalid slot.");
+
+    declare_err!(EDEADLOCK, "Resource deadlock would occur.");
+
+    declare_err!(EBFONT, "Bad font file format.");
+
+    declare_err!(ENOSTR, "Device not a stream.");
+
+    declare_err!(ENODATA, "No data available.");
+
+    declare_err!(ETIME, "Timer expired.");
+
+    declare_err!(ENOSR, "Out of streams resources.");
+
+    declare_err!(ENONET, "Machine is not on the network.");
+
+    declare_err!(ENOPKG, "Package not installed.");
+
+    declare_err!(EREMOTE, "Object is remote.");
+
+    declare_err!(ENOLINK, "Link has been severed.");
+
+    declare_err!(EADV, "Advertise error.");
+
+    declare_err!(ESRMNT, "Srmount error.");
+
+    declare_err!(ECOMM, "Communication error on send.");
+
+    declare_err!(EPROTO, "Protocol error.");
+
+    declare_err!(EMULTIHOP, "Multihop attempted.");
+
+    declare_err!(EDOTDOT, "RFS specific error.");
+
+    declare_err!(EBADMSG, "Not a data message.");
+
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
+
+    declare_err!(ENOTUNIQ, "Name not unique on network.");
+
+    declare_err!(EBADFD, "File descriptor in bad state.");
+
+    declare_err!(EREMCHG, "Remote address changed.");
+
+    declare_err!(ELIBACC, "Can not access a needed shared library.");
+
+    declare_err!(ELIBBAD, "Accessing a corrupted shared library.");
+
+    declare_err!(ELIBSCN, ".lib section in a.out corrupted.");
+
+    declare_err!(ELIBMAX, "Attempting to link in too many shared libraries.");
+
+    declare_err!(ELIBEXEC, "Cannot exec a shared library directly.");
+
+    declare_err!(EILSEQ, "Illegal byte sequence.");
+
+    declare_err!(ERESTART, "Interrupted system call should be restarted.");
+
+    declare_err!(ESTRPIPE, "Streams pipe error.");
+
+    declare_err!(EUSERS, "Too many users.");
+
+    declare_err!(ENOTSOCK, "Socket operation on non-socket.");
+
+    declare_err!(EDESTADDRREQ, "Destination address required.");
+
+    declare_err!(EMSGSIZE, "Message too long.");
+
+    declare_err!(EPROTOTYPE, "Protocol wrong type for socket.");
+
+    declare_err!(ENOPROTOOPT, "Protocol not available.");
+
+    declare_err!(EPROTONOSUPPORT, "Protocol not supported.");
+
+    declare_err!(ESOCKTNOSUPPORT, "Socket type not supported.");
+
+    declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
+
+    declare_err!(EPFNOSUPPORT, "Protocol family not supported.");
+
+    declare_err!(EAFNOSUPPORT, "Address family not supported by protocol.");
+
+    declare_err!(EADDRINUSE, "Address already in use.");
+
+    declare_err!(EADDRNOTAVAIL, "Cannot assign requested address.");
+
+    declare_err!(ENETDOWN, "Network is down.");
+
+    declare_err!(ENETUNREACH, "Network is unreachable.");
+
+    declare_err!(ENETRESET, "Network dropped connection because of reset.");
+
+    declare_err!(ECONNABORTED, "Software caused connection abort.");
+
+    declare_err!(ECONNRESET, "Connection reset by peer.");
+
+    declare_err!(ENOBUFS, "No buffer space available.");
+
+    declare_err!(EISCONN, "Transport endpoint is already connected.");
+
+    declare_err!(ENOTCONN, "Transport endpoint is not connected.");
+
+    declare_err!(ESHUTDOWN, "Cannot send after transport endpoint shutdown.");
+
+    declare_err!(ETOOMANYREFS, "Too many references: cannot splice.");
+
+    declare_err!(ETIMEDOUT, "Connection timed out.");
+
+    declare_err!(ECONNREFUSED, "Connection refused.");
+
+    declare_err!(EHOSTDOWN, "Host is down.");
+
+    declare_err!(EHOSTUNREACH, "No route to host.");
+
+    declare_err!(EALREADY, "Operation already in progress.");
+
+    declare_err!(EINPROGRESS, "Operation now in progress.");
+
+    declare_err!(ESTALE, "Stale file handle.");
+
+    declare_err!(EUCLEAN, "Structure needs cleaning.");
+
+    declare_err!(ENOTNAM, "Not a XENIX named type file.");
+
+    declare_err!(ENAVAIL, "No XENIX semaphores available.");
+
+    declare_err!(EISNAM, "Is a named type file.");
+
+    declare_err!(EREMOTEIO, "Remote I/O error.");
+
+    declare_err!(EDQUOT, "Quota exceeded.");
+
+    declare_err!(ENOMEDIUM, "No medium found.");
+
+    declare_err!(EMEDIUMTYPE, "Wrong medium type.");
+
+    declare_err!(ECANCELED, "Operation Canceled.");
+
+    declare_err!(ENOKEY, "Required key not available.");
+
+    declare_err!(EKEYEXPIRED, "Key has expired.");
+
+    declare_err!(EKEYREVOKED, "Key has been revoked.");
+
+    declare_err!(EKEYREJECTED, "Key was rejected by service.");
+
+    declare_err!(EOWNERDEAD, "Owner died.", "", "For robust mutexes.");
+
+    declare_err!(ENOTRECOVERABLE, "State not recoverable.");
+
+    declare_err!(ERFKILL, "Operation not possible due to RF-kill.");
+
+    declare_err!(EHWPOISON, "Memory page has hardware error.");
+
+    declare_err!(ERESTARTSYS, "Restart the system call.");
+
+    declare_err!(ENOTSUPP, "Operation is not supported.");
+}
+
+/// Generic integer kernel error.
+///
+/// The kernel defines a set of integer generic error codes based on C and
+/// POSIX ones. These codes may have a more specific meaning in some contexts.
+///
+/// # Invariants
+///
+/// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct Error(c_types::c_int);
+
+impl Error {
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
+    /// be returned in such a case.
+    pub(crate) fn from_kernel_errno(errno: c_types::c_int) -> Error {
+        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
+            // TODO: Make it a `WARN_ONCE` once available.
+            crate::pr_warn!(
+                "attempted to create `Error` with out of range `errno`: {}",
+                errno
+            );
+            return code::EINVAL;
+        }
+
+        // INVARIANT: The check above ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
+    /// Creates an [`Error`] from a kernel error code.
+    ///
+    /// # Safety
+    ///
+    /// `errno` must be within error code range (i.e. `>= -MAX_ERRNO && < 0`).
+    pub(crate) unsafe fn from_kernel_errno_unchecked(errno: c_types::c_int) -> Error {
+        // INVARIANT: The contract ensures the type invariant
+        // will hold.
+        Error(errno)
+    }
+
+    /// Returns the kernel error code.
+    pub fn to_kernel_errno(self) -> c_types::c_int {
+        self.0
+    }
+
+    /// Returns a string representing the error, if one exists.
+    #[cfg(not(testlib))]
+    pub fn name(&self) -> Option<&'static CStr> {
+        // SAFETY: Just an FFI call, there are no extra safety requirements.
+        let ptr = unsafe { bindings::errname(-self.0) };
+        if ptr.is_null() {
+            None
+        } else {
+            // SAFETY: The string returned by `errname` is static and `NUL`-terminated.
+            Some(unsafe { CStr::from_char_ptr(ptr) })
+        }
+    }
+
+    /// Returns a string representing the error, if one exists.
+    ///
+    /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
+    /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
+    /// run in userspace.
+    #[cfg(testlib)]
+    pub fn name(&self) -> Option<&'static CStr> {
+        None
+    }
+}
+
+impl fmt::Debug for Error {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self.name() {
+            // Print out number if no name can be found.
+            None => f.debug_tuple("Error").field(&-self.0).finish(),
+            // SAFETY: These strings are ASCII-only.
+            Some(name) => f
+                .debug_tuple(unsafe { str::from_utf8_unchecked(name) })
+                .finish(),
+        }
+    }
+}
+
+impl From<TryFromIntError> for Error {
+    fn from(_: TryFromIntError) -> Error {
+        code::EINVAL
+    }
+}
+
+impl From<Utf8Error> for Error {
+    fn from(_: Utf8Error) -> Error {
+        code::EINVAL
+    }
+}
+
+impl From<TryReserveError> for Error {
+    fn from(_: TryReserveError) -> Error {
+        code::ENOMEM
+    }
+}
+
+impl From<LayoutError> for Error {
+    fn from(_: LayoutError) -> Error {
+        code::ENOMEM
+    }
+}
+
+impl From<core::fmt::Error> for Error {
+    fn from(_: core::fmt::Error) -> Error {
+        code::EINVAL
+    }
+}
+
+/// A [`Result`] with an [`Error`] error type.
+///
+/// To be used as the return type for functions that may fail.
+///
+/// # Error codes in C and Rust
+///
+/// In C, it is common that functions indicate success or failure through
+/// their return value; modifying or returning extra data through non-`const`
+/// pointer parameters. In particular, in the kernel, functions that may fail
+/// typically return an `int` that represents a generic error code. We model
+/// those as [`Error`].
+///
+/// In Rust, it is idiomatic to model functions that may fail as returning
+/// a [`Result`]. Since in the kernel many functions return an error code,
+/// [`Result`] is a type alias for a [`core::result::Result`] that uses
+/// [`Error`] as its error type.
+///
+/// Note that even if a function does not return anything when it succeeds,
+/// it should still be modeled as returning a `Result` rather than
+/// just an [`Error`].
+pub type Result<T = ()> = core::result::Result<T, Error>;
+
+impl From<AllocError> for Error {
+    fn from(_: AllocError) -> Error {
+        code::ENOMEM
+    }
+}
+
+// # Invariant: `-bindings::MAX_ERRNO` fits in an `i16`.
+crate::static_assert!(bindings::MAX_ERRNO <= -(i16::MIN as i32) as u32);
+
+pub(crate) fn from_kernel_result_helper<T>(r: Result<T>) -> T
+where
+    T: From<i16>,
+{
+    match r {
+        Ok(v) => v,
+        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
+        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
+        // therefore a negative `errno` always fits in an `i16` and will not overflow.
+        Err(e) => T::from(e.to_kernel_errno() as i16),
+    }
+}
+
+/// Transforms a [`crate::error::Result<T>`] to a kernel C integer result.
+///
+/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
+/// from inside `extern "C"` functions that need to return an integer
+/// error result.
+///
+/// `T` should be convertible to an `i16` via `From<i16>`.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::from_kernel_result;
+/// # use kernel::c_types;
+/// # use kernel::bindings;
+/// unsafe extern "C" fn probe_callback(
+///     pdev: *mut bindings::platform_device,
+/// ) -> c_types::c_int {
+///     from_kernel_result! {
+///         let ptr = devm_alloc(pdev)?;
+///         bindings::platform_set_drvdata(pdev, ptr);
+///         Ok(0)
+///     }
+/// }
+/// ```
+macro_rules! from_kernel_result {
+    ($($tt:tt)*) => {{
+        $crate::error::from_kernel_result_helper((|| {
+            $($tt)*
+        })())
+    }};
+}
+
+pub(crate) use from_kernel_result;
+
+/// Transform a kernel "error pointer" to a normal pointer.
+///
+/// Some kernel C API functions return an "error pointer" which optionally
+/// embeds an `errno`. Callers are supposed to check the returned pointer
+/// for errors. This function performs the check and converts the "error pointer"
+/// to a normal pointer in an idiomatic fashion.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::prelude::*;
+/// # use kernel::from_kernel_err_ptr;
+/// # use kernel::c_types;
+/// # use kernel::bindings;
+/// fn devm_platform_ioremap_resource(
+///     pdev: &mut PlatformDevice,
+///     index: u32,
+/// ) -> Result<*mut c_types::c_void> {
+///     // SAFETY: FFI call.
+///     unsafe {
+///         from_kernel_err_ptr(bindings::devm_platform_ioremap_resource(
+///             pdev.to_ptr(),
+///             index,
+///         ))
+///     }
+/// }
+/// ```
+// TODO: Remove `dead_code` marker once an in-kernel client is available.
+#[allow(dead_code)]
+pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+    // CAST: Casting a pointer to `*const c_types::c_void` is always valid.
+    let const_ptr: *const c_types::c_void = ptr.cast();
+    // SAFETY: The FFI function does not deref the pointer.
+    if unsafe { bindings::IS_ERR(const_ptr) } {
+        // SAFETY: The FFI function does not deref the pointer.
+        let err = unsafe { bindings::PTR_ERR(const_ptr) };
+        // CAST: If `IS_ERR()` returns `true`,
+        // then `PTR_ERR()` is guaranteed to return a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
+        // which always fits in an `i16`, as per the invariant above.
+        // And an `i16` always fits in an `i32`. So casting `err` to
+        // an `i32` can never overflow, and is always valid.
+        //
+        // SAFETY: `IS_ERR()` ensures `err` is a
+        // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
+        return Err(unsafe { Error::from_kernel_errno_unchecked(err as i32) });
+    }
+    Ok(ptr)
+}
+
+/// Calls a kernel function that returns an integer error code on failure and converts the result
+/// to a [`Result`].
+pub fn to_result(func: impl FnOnce() -> c_types::c_int) -> Result {
+    let err = func();
+    if err < 0 {
+        Err(Error::from_kernel_errno(err))
+    } else {
+        Ok(())
+    }
+}
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..7f4adfd4b80a
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,873 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
+
+use crate::{
+    bindings, c_types,
+    cred::CredentialRef,
+    error::{code::*, from_kernel_result, Error, Result},
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    iov_iter::IovIter,
+    mm,
+    sync::CondVar,
+    types::PointerWrapper,
+    user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter},
+};
+use core::convert::{TryFrom, TryInto};
+use core::{marker, mem, mem::ManuallyDrop, ops::Deref, ptr};
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// The pointer `File::ptr` is non-null and valid. Its reference count is also non-zero.
+pub struct File {
+    pub(crate) ptr: *mut bindings::file,
+}
+
+impl File {
+    /// Constructs a new [`struct file`] wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn from_fd(fd: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = unsafe { bindings::fget(fd) };
+        if ptr.is_null() {
+            return Err(EBADF);
+        }
+
+        // INVARIANTS: We checked that `ptr` is non-null, so it is valid. `fget` increments the ref
+        // count before returning.
+        Ok(Self { ptr })
+    }
+
+    /// Returns the current seek/cursor/pointer position (`struct file::f_pos`).
+    pub fn pos(&self) -> u64 {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_pos as u64 }
+    }
+
+    /// Returns whether the file is in blocking mode.
+    pub fn is_blocking(&self) -> bool {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_flags & bindings::O_NONBLOCK == 0 }
+    }
+
+    /// Returns the credentials of the task that originally opened the file.
+    pub fn cred(&self) -> CredentialRef<'_> {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        let ptr = unsafe { (*self.ptr).f_cred };
+        // SAFETY: The lifetimes of `self` and `CredentialRef` are tied, so it is guaranteed that
+        // the credential pointer remains valid (because the file is still alive, and it doesn't
+        // change over the lifetime of a file).
+        unsafe { CredentialRef::from_ptr(ptr) }
+    }
+
+    /// Returns the flags associated with the file.
+    pub fn flags(&self) -> u32 {
+        // SAFETY: `File::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).f_flags }
+    }
+}
+
+impl Drop for File {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that `File::ptr` has a non-zero reference count.
+        unsafe { bindings::fput(self.ptr) };
+    }
+}
+
+/// A wrapper for [`File`] that doesn't automatically decrement the refcount when dropped.
+///
+/// We need the wrapper because [`ManuallyDrop`] alone would allow callers to call
+/// [`ManuallyDrop::into_inner`]. This would allow an unsafe sequence to be triggered without
+/// `unsafe` blocks because it would trigger an unbalanced call to `fput`.
+///
+/// # Invariants
+///
+/// The wrapped [`File`] remains valid for the lifetime of the object.
+pub(crate) struct FileRef(ManuallyDrop<File>);
+
+impl FileRef {
+    /// Constructs a new [`struct file`] wrapper that doesn't change its reference count.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::file) -> Self {
+        Self(ManuallyDrop::new(File { ptr }))
+    }
+}
+
+impl Deref for FileRef {
+    type Target = File;
+
+    fn deref(&self) -> &Self::Target {
+        self.0.deref()
+    }
+}
+
+/// A file descriptor reservation.
+///
+/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
+/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
+/// out of available slots), but commit and drop never fail (and are mutually exclusive).
+pub struct FileDescriptorReservation {
+    fd: u32,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn new(flags: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let fd = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_kernel_errno(fd));
+        }
+        Ok(Self { fd: fd as _ })
+    }
+
+    /// Returns the file descriptor number that was reserved.
+    pub fn reserved_fd(&self) -> u32 {
+        self.fd
+    }
+
+    /// Commits the reservation.
+    ///
+    /// The previously reserved file descriptor is bound to `file`.
+    pub fn commit(self, file: File) {
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
+        // guaranteed to have an owned ref count by its type invariants.
+        unsafe { bindings::fd_install(self.fd, file.ptr) };
+
+        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
+        // the destructors.
+        core::mem::forget(self);
+        core::mem::forget(file);
+    }
+}
+
+impl Drop for FileDescriptorReservation {
+    fn drop(&mut self) {
+        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
+        unsafe { bindings::put_unused_fd(self.fd) };
+    }
+}
+
+/// Wraps the kernel's `struct poll_table_struct`.
+///
+/// # Invariants
+///
+/// The pointer `PollTable::ptr` is null or valid.
+pub struct PollTable {
+    ptr: *mut bindings::poll_table_struct,
+}
+
+impl PollTable {
+    /// Constructors a new `struct poll_table_struct` wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be either null or a valid pointer for the lifetime of the object.
+    unsafe fn from_ptr(ptr: *mut bindings::poll_table_struct) -> Self {
+        Self { ptr }
+    }
+
+    /// Associates the given file and condition variable to this poll table. It means notifying the
+    /// condition variable will notify the poll table as well; additionally, the association
+    /// between the condition variable and the file will automatically be undone by the kernel when
+    /// the file is destructed. To unilaterally remove the association before then, one can call
+    /// [`CondVar::free_waiters`].
+    ///
+    /// # Safety
+    ///
+    /// If the condition variable is destroyed before the file, then [`CondVar::free_waiters`] must
+    /// be called to ensure that all waiters are flushed out.
+    pub unsafe fn register_wait<'a>(&self, file: &'a File, cv: &'a CondVar) {
+        if self.ptr.is_null() {
+            return;
+        }
+
+        // SAFETY: `PollTable::ptr` is guaranteed to be valid by the type invariants and the null
+        // check above.
+        let table = unsafe { &*self.ptr };
+        if let Some(proc) = table._qproc {
+            // SAFETY: All pointers are known to be valid.
+            unsafe { proc(file.ptr as _, cv.wait_list.get(), self.ptr) }
+        }
+    }
+}
+
+/// Equivalent to [`std::io::SeekFrom`].
+///
+/// [`std::io::SeekFrom`]: https://doc.rust-lang.org/std/io/enum.SeekFrom.html
+pub enum SeekFrom {
+    /// Equivalent to C's `SEEK_SET`.
+    Start(u64),
+
+    /// Equivalent to C's `SEEK_END`.
+    End(i64),
+
+    /// Equivalent to C's `SEEK_CUR`.
+    Current(i64),
+}
+
+pub(crate) struct OperationsVtable<A, T>(marker::PhantomData<A>, marker::PhantomData<T>);
+
+impl<A: OpenAdapter<T::OpenData>, T: Operations> OperationsVtable<A, T> {
+    /// Called by the VFS when an inode should be opened.
+    ///
+    /// Calls `T::open` on the returned value of `A::convert`.
+    ///
+    /// # Safety
+    ///
+    /// The returned value of `A::convert` must be a valid non-null pointer and
+    /// `T:open` must return a valid non-null pointer on an `Ok` result.
+    unsafe extern "C" fn open_callback(
+        inode: *mut bindings::inode,
+        file: *mut bindings::file,
+    ) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `A::convert` must return a valid non-null pointer that
+            // should point to data in the inode or file that lives longer
+            // than the following use of `T::open`.
+            let arg = unsafe { A::convert(inode, file) };
+            // SAFETY: The C contract guarantees that `file` is valid. Additionally,
+            // `fileref` never outlives this function, so it is guaranteed to be
+            // valid.
+            let fileref = unsafe { FileRef::from_ptr(file) };
+            // SAFETY: `arg` was previously returned by `A::convert` and must
+            // be a valid non-null pointer.
+            let ptr = T::open(unsafe { &*arg }, &fileref)?.into_pointer();
+            // SAFETY: The C contract guarantees that `private_data` is available
+            // for implementers of the file operations (no other C code accesses
+            // it), so we know that there are no concurrent threads/CPUs accessing
+            // it (it's not visible to any other Rust code).
+            unsafe { (*file).private_data = ptr as *mut c_types::c_void };
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn read_callback(
+        file: *mut bindings::file,
+        buf: *mut c_types::c_char,
+        len: c_types::c_size_t,
+        offset: *mut bindings::loff_t,
+    ) -> c_types::c_ssize_t {
+        from_kernel_result! {
+            let mut data = unsafe { UserSlicePtr::new(buf as *mut c_types::c_void, len).writer() };
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+            // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+            let read = T::read(
+                f,
+                unsafe { &FileRef::from_ptr(file) },
+                &mut data,
+                unsafe { *offset }.try_into()?,
+            )?;
+            unsafe { (*offset) += bindings::loff_t::try_from(read).unwrap() };
+            Ok(read as _)
+        }
+    }
+
+    unsafe extern "C" fn read_iter_callback(
+        iocb: *mut bindings::kiocb,
+        raw_iter: *mut bindings::iov_iter,
+    ) -> isize {
+        from_kernel_result! {
+            let mut iter = unsafe { IovIter::from_ptr(raw_iter) };
+            let file = unsafe { (*iocb).ki_filp };
+            let offset = unsafe { (*iocb).ki_pos };
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let read =
+                T::read(f, unsafe { &FileRef::from_ptr(file) }, &mut iter, offset.try_into()?)?;
+            unsafe { (*iocb).ki_pos += bindings::loff_t::try_from(read).unwrap() };
+            Ok(read as _)
+        }
+    }
+
+    unsafe extern "C" fn write_callback(
+        file: *mut bindings::file,
+        buf: *const c_types::c_char,
+        len: c_types::c_size_t,
+        offset: *mut bindings::loff_t,
+    ) -> c_types::c_ssize_t {
+        from_kernel_result! {
+            let mut data = unsafe { UserSlicePtr::new(buf as *mut c_types::c_void, len).reader() };
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            // No `FMODE_UNSIGNED_OFFSET` support, so `offset` must be in [0, 2^63).
+            // See discussion in https://github.com/fishinabarrel/linux-kernel-module-rust/pull/113
+            let written = T::write(
+                f,
+                unsafe { &FileRef::from_ptr(file) },
+                &mut data,
+                unsafe { *offset }.try_into()?
+            )?;
+            unsafe { (*offset) += bindings::loff_t::try_from(written).unwrap() };
+            Ok(written as _)
+        }
+    }
+
+    unsafe extern "C" fn write_iter_callback(
+        iocb: *mut bindings::kiocb,
+        raw_iter: *mut bindings::iov_iter,
+    ) -> isize {
+        from_kernel_result! {
+            let mut iter = unsafe { IovIter::from_ptr(raw_iter) };
+            let file = unsafe { (*iocb).ki_filp };
+            let offset = unsafe { (*iocb).ki_pos };
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let written =
+                T::write(f, unsafe { &FileRef::from_ptr(file) }, &mut iter, offset.try_into()?)?;
+            unsafe { (*iocb).ki_pos += bindings::loff_t::try_from(written).unwrap() };
+            Ok(written as _)
+        }
+    }
+
+    unsafe extern "C" fn release_callback(
+        _inode: *mut bindings::inode,
+        file: *mut bindings::file,
+    ) -> c_types::c_int {
+        let ptr = mem::replace(unsafe { &mut (*file).private_data }, ptr::null_mut());
+        T::release(unsafe { T::Data::from_pointer(ptr as _) }, unsafe {
+            &FileRef::from_ptr(file)
+        });
+        0
+    }
+
+    unsafe extern "C" fn llseek_callback(
+        file: *mut bindings::file,
+        offset: bindings::loff_t,
+        whence: c_types::c_int,
+    ) -> bindings::loff_t {
+        from_kernel_result! {
+            let off = match whence as u32 {
+                bindings::SEEK_SET => SeekFrom::Start(offset.try_into()?),
+                bindings::SEEK_CUR => SeekFrom::Current(offset),
+                bindings::SEEK_END => SeekFrom::End(offset),
+                _ => return Err(EINVAL),
+            };
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let off = T::seek(f, unsafe { &FileRef::from_ptr(file) }, off)?;
+            Ok(off as bindings::loff_t)
+        }
+    }
+
+    unsafe extern "C" fn unlocked_ioctl_callback(
+        file: *mut bindings::file,
+        cmd: c_types::c_uint,
+        arg: c_types::c_ulong,
+    ) -> c_types::c_long {
+        from_kernel_result! {
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+            let ret = T::ioctl(f, unsafe { &FileRef::from_ptr(file) }, &mut cmd)?;
+            Ok(ret as _)
+        }
+    }
+
+    unsafe extern "C" fn compat_ioctl_callback(
+        file: *mut bindings::file,
+        cmd: c_types::c_uint,
+        arg: c_types::c_ulong,
+    ) -> c_types::c_long {
+        from_kernel_result! {
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let mut cmd = IoctlCommand::new(cmd as _, arg as _);
+            let ret = T::compat_ioctl(f, unsafe { &FileRef::from_ptr(file) }, &mut cmd)?;
+            Ok(ret as _)
+        }
+    }
+
+    unsafe extern "C" fn mmap_callback(
+        file: *mut bindings::file,
+        vma: *mut bindings::vm_area_struct,
+    ) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+
+            // SAFETY: The C API guarantees that `vma` is valid for the duration of this call.
+            // `area` only lives within this call, so it is guaranteed to be valid.
+            let mut area = unsafe { mm::virt::Area::from_ptr(vma) };
+
+            // SAFETY: The C API guarantees that `file` is valid for the duration of this call,
+            // which is longer than the lifetime of the file reference.
+            T::mmap(f, unsafe { &FileRef::from_ptr(file) }, &mut area)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn fsync_callback(
+        file: *mut bindings::file,
+        start: bindings::loff_t,
+        end: bindings::loff_t,
+        datasync: c_types::c_int,
+    ) -> c_types::c_int {
+        from_kernel_result! {
+            let start = start.try_into()?;
+            let end = end.try_into()?;
+            let datasync = datasync != 0;
+            // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+            // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the
+            // `release` callback, which the C API guarantees that will be called only when all
+            // references to `file` have been released, so we know it can't be called while this
+            // function is running.
+            let f = unsafe { T::Data::borrow((*file).private_data) };
+            let res = T::fsync(f, unsafe { &FileRef::from_ptr(file) }, start, end, datasync)?;
+            Ok(res.try_into().unwrap())
+        }
+    }
+
+    unsafe extern "C" fn poll_callback(
+        file: *mut bindings::file,
+        wait: *mut bindings::poll_table_struct,
+    ) -> bindings::__poll_t {
+        // SAFETY: `private_data` was initialised by `open_callback` with a value returned by
+        // `T::Data::into_pointer`. `T::Data::from_pointer` is only called by the `release`
+        // callback, which the C API guarantees that will be called only when all references to
+        // `file` have been released, so we know it can't be called while this function is running.
+        let f = unsafe { T::Data::borrow((*file).private_data) };
+        match T::poll(f, unsafe { &FileRef::from_ptr(file) }, unsafe {
+            &PollTable::from_ptr(wait)
+        }) {
+            Ok(v) => v,
+            Err(_) => bindings::POLLERR,
+        }
+    }
+
+    const VTABLE: bindings::file_operations = bindings::file_operations {
+        open: Some(Self::open_callback),
+        release: Some(Self::release_callback),
+        read: if T::TO_USE.read {
+            Some(Self::read_callback)
+        } else {
+            None
+        },
+        write: if T::TO_USE.write {
+            Some(Self::write_callback)
+        } else {
+            None
+        },
+        llseek: if T::TO_USE.seek {
+            Some(Self::llseek_callback)
+        } else {
+            None
+        },
+
+        check_flags: None,
+        compat_ioctl: if T::TO_USE.compat_ioctl {
+            Some(Self::compat_ioctl_callback)
+        } else {
+            None
+        },
+        copy_file_range: None,
+        fallocate: None,
+        fadvise: None,
+        fasync: None,
+        flock: None,
+        flush: None,
+        fsync: if T::TO_USE.fsync {
+            Some(Self::fsync_callback)
+        } else {
+            None
+        },
+        get_unmapped_area: None,
+        iterate: None,
+        iterate_shared: None,
+        iopoll: None,
+        lock: None,
+        mmap: if T::TO_USE.mmap {
+            Some(Self::mmap_callback)
+        } else {
+            None
+        },
+        mmap_supported_flags: 0,
+        owner: ptr::null_mut(),
+        poll: if T::TO_USE.poll {
+            Some(Self::poll_callback)
+        } else {
+            None
+        },
+        read_iter: if T::TO_USE.read_iter {
+            Some(Self::read_iter_callback)
+        } else {
+            None
+        },
+        remap_file_range: None,
+        sendpage: None,
+        setlease: None,
+        show_fdinfo: None,
+        splice_read: None,
+        splice_write: None,
+        unlocked_ioctl: if T::TO_USE.ioctl {
+            Some(Self::unlocked_ioctl_callback)
+        } else {
+            None
+        },
+        write_iter: if T::TO_USE.write_iter {
+            Some(Self::write_iter_callback)
+        } else {
+            None
+        },
+    };
+
+    /// Builds an instance of [`struct file_operations`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) const unsafe fn build() -> &'static bindings::file_operations {
+        &Self::VTABLE
+    }
+}
+
+/// Represents which fields of [`struct file_operations`] should be populated with pointers.
+pub struct ToUse {
+    /// The `read` field of [`struct file_operations`].
+    pub read: bool,
+
+    /// The `read_iter` field of [`struct file_operations`].
+    pub read_iter: bool,
+
+    /// The `write` field of [`struct file_operations`].
+    pub write: bool,
+
+    /// The `write_iter` field of [`struct file_operations`].
+    pub write_iter: bool,
+
+    /// The `llseek` field of [`struct file_operations`].
+    pub seek: bool,
+
+    /// The `unlocked_ioctl` field of [`struct file_operations`].
+    pub ioctl: bool,
+
+    /// The `compat_ioctl` field of [`struct file_operations`].
+    pub compat_ioctl: bool,
+
+    /// The `fsync` field of [`struct file_operations`].
+    pub fsync: bool,
+
+    /// The `mmap` field of [`struct file_operations`].
+    pub mmap: bool,
+
+    /// The `poll` field of [`struct file_operations`].
+    pub poll: bool,
+}
+
+/// A constant version where all values are to set to `false`, that is, all supported fields will
+/// be set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    read: false,
+    read_iter: false,
+    write: false,
+    write_iter: false,
+    seek: false,
+    ioctl: false,
+    compat_ioctl: false,
+    fsync: false,
+    mmap: false,
+    poll: false,
+};
+
+/// Defines the [`Operations::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_file_operations {
+    () => {
+        const TO_USE: $crate::file::ToUse = $crate::file::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        const TO_USE: kernel::file::ToUse =
+            $crate::file::ToUse {
+                $($i: true),+ ,
+                ..$crate::file::USE_NONE
+            };
+    };
+}
+
+/// Allows the handling of ioctls defined with the `_IO`, `_IOR`, `_IOW`, and `_IOWR` macros.
+///
+/// For each macro, there is a handler function that takes the appropriate types as arguments.
+pub trait IoctlHandler: Sync {
+    /// The type of the first argument to each associated function.
+    type Target<'a>;
+
+    /// Handles ioctls defined with the `_IO` macro, that is, with no buffer as argument.
+    fn pure(_this: Self::Target<'_>, _file: &File, _cmd: u32, _arg: usize) -> Result<i32> {
+        Err(EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOR` macro, that is, with an output buffer provided as
+    /// argument.
+    fn read(
+        _this: Self::Target<'_>,
+        _file: &File,
+        _cmd: u32,
+        _writer: &mut UserSlicePtrWriter,
+    ) -> Result<i32> {
+        Err(EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOW` macro, that is, with an input buffer provided as
+    /// argument.
+    fn write(
+        _this: Self::Target<'_>,
+        _file: &File,
+        _cmd: u32,
+        _reader: &mut UserSlicePtrReader,
+    ) -> Result<i32> {
+        Err(EINVAL)
+    }
+
+    /// Handles ioctls defined with the `_IOWR` macro, that is, with a buffer for both input and
+    /// output provided as argument.
+    fn read_write(
+        _this: Self::Target<'_>,
+        _file: &File,
+        _cmd: u32,
+        _data: UserSlicePtr,
+    ) -> Result<i32> {
+        Err(EINVAL)
+    }
+}
+
+/// Represents an ioctl command.
+///
+/// It can use the components of an ioctl command to dispatch ioctls using
+/// [`IoctlCommand::dispatch`].
+pub struct IoctlCommand {
+    cmd: u32,
+    arg: usize,
+    user_slice: Option<UserSlicePtr>,
+}
+
+impl IoctlCommand {
+    /// Constructs a new [`IoctlCommand`].
+    fn new(cmd: u32, arg: usize) -> Self {
+        let size = (cmd >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK;
+
+        // SAFETY: We only create one instance of the user slice per ioctl call, so TOCTOU issues
+        // are not possible.
+        let user_slice = Some(unsafe { UserSlicePtr::new(arg as _, size as _) });
+        Self {
+            cmd,
+            arg,
+            user_slice,
+        }
+    }
+
+    /// Dispatches the given ioctl to the appropriate handler based on the value of the command. It
+    /// also creates a [`UserSlicePtr`], [`UserSlicePtrReader`], or [`UserSlicePtrWriter`]
+    /// depending on the direction of the buffer of the command.
+    ///
+    /// It is meant to be used in implementations of [`Operations::ioctl`] and
+    /// [`Operations::compat_ioctl`].
+    pub fn dispatch<T: IoctlHandler>(
+        &mut self,
+        handler: T::Target<'_>,
+        file: &File,
+    ) -> Result<i32> {
+        let dir = (self.cmd >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK;
+        if dir == bindings::_IOC_NONE {
+            return T::pure(handler, file, self.cmd, self.arg);
+        }
+
+        let data = self.user_slice.take().ok_or(EINVAL)?;
+        const READ_WRITE: u32 = bindings::_IOC_READ | bindings::_IOC_WRITE;
+        match dir {
+            bindings::_IOC_WRITE => T::write(handler, file, self.cmd, &mut data.reader()),
+            bindings::_IOC_READ => T::read(handler, file, self.cmd, &mut data.writer()),
+            READ_WRITE => T::read_write(handler, file, self.cmd, data),
+            _ => Err(EINVAL),
+        }
+    }
+
+    /// Returns the raw 32-bit value of the command and the ptr-sized argument.
+    pub fn raw(&self) -> (u32, usize) {
+        (self.cmd, self.arg)
+    }
+}
+
+/// Trait for extracting file open arguments from kernel data structures.
+///
+/// This is meant to be implemented by registration managers.
+pub trait OpenAdapter<T: Sync> {
+    /// Converts untyped data stored in [`struct inode`] and [`struct file`] (when [`struct
+    /// file_operations::open`] is called) into the given type. For example, for `miscdev`
+    /// devices, a pointer to the registered [`struct miscdev`] is stored in [`struct
+    /// file::private_data`].
+    ///
+    /// # Safety
+    ///
+    /// This function must be called only when [`struct file_operations::open`] is being called for
+    /// a file that was registered by the implementer. The returned pointer must be valid and
+    /// not-null.
+    unsafe fn convert(_inode: *mut bindings::inode, _file: *mut bindings::file) -> *const T;
+}
+
+/// Corresponds to the kernel's `struct file_operations`.
+///
+/// You implement this trait whenever you would create a `struct file_operations`.
+///
+/// File descriptors may be used from multiple threads/processes concurrently, so your type must be
+/// [`Sync`]. It must also be [`Send`] because [`Operations::release`] will be called from the
+/// thread that decrements that associated file's refcount to zero.
+pub trait Operations {
+    /// The methods to use to populate [`struct file_operations`].
+    const TO_USE: ToUse;
+
+    /// The type of the context data returned by [`Operations::open`] and made available to
+    /// other methods.
+    type Data: PointerWrapper + Send + Sync = ();
+
+    /// The type of the context data passed to [`Operations::open`].
+    type OpenData: Sync = ();
+
+    /// Creates a new instance of this file.
+    ///
+    /// Corresponds to the `open` function pointer in `struct file_operations`.
+    fn open(context: &Self::OpenData, file: &File) -> Result<Self::Data>;
+
+    /// Cleans up after the last reference to the file goes away.
+    ///
+    /// Note that context data is moved, so it will be freed automatically unless the
+    /// implementation moves it elsewhere.
+    ///
+    /// Corresponds to the `release` function pointer in `struct file_operations`.
+    fn release(_data: Self::Data, _file: &File) {}
+
+    /// Reads data from this file to the caller's buffer.
+    ///
+    /// Corresponds to the `read` and `read_iter` function pointers in `struct file_operations`.
+    fn read(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _writer: &mut impl IoBufferWriter,
+        _offset: u64,
+    ) -> Result<usize> {
+        Err(EINVAL)
+    }
+
+    /// Writes data from the caller's buffer to this file.
+    ///
+    /// Corresponds to the `write` and `write_iter` function pointers in `struct file_operations`.
+    fn write(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _reader: &mut impl IoBufferReader,
+        _offset: u64,
+    ) -> Result<usize> {
+        Err(EINVAL)
+    }
+
+    /// Changes the position of the file.
+    ///
+    /// Corresponds to the `llseek` function pointer in `struct file_operations`.
+    fn seek(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _offset: SeekFrom,
+    ) -> Result<u64> {
+        Err(EINVAL)
+    }
+
+    /// Performs IO control operations that are specific to the file.
+    ///
+    /// Corresponds to the `unlocked_ioctl` function pointer in `struct file_operations`.
+    fn ioctl(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _cmd: &mut IoctlCommand,
+    ) -> Result<i32> {
+        Err(ENOTTY)
+    }
+
+    /// Performs 32-bit IO control operations on that are specific to the file on 64-bit kernels.
+    ///
+    /// Corresponds to the `compat_ioctl` function pointer in `struct file_operations`.
+    fn compat_ioctl(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _cmd: &mut IoctlCommand,
+    ) -> Result<i32> {
+        Err(ENOTTY)
+    }
+
+    /// Syncs pending changes to this file.
+    ///
+    /// Corresponds to the `fsync` function pointer in `struct file_operations`.
+    fn fsync(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _start: u64,
+        _end: u64,
+        _datasync: bool,
+    ) -> Result<u32> {
+        Err(EINVAL)
+    }
+
+    /// Maps areas of the caller's virtual memory with device/file memory.
+    ///
+    /// Corresponds to the `mmap` function pointer in `struct file_operations`.
+    fn mmap(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _vma: &mut mm::virt::Area,
+    ) -> Result {
+        Err(EINVAL)
+    }
+
+    /// Checks the state of the file and optionally registers for notification when the state
+    /// changes.
+    ///
+    /// Corresponds to the `poll` function pointer in `struct file_operations`.
+    fn poll(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _file: &File,
+        _table: &PollTable,
+    ) -> Result<u32> {
+        Ok(bindings::POLLIN | bindings::POLLOUT | bindings::POLLRDNORM | bindings::POLLWRNORM)
+    }
+}
diff --git a/rust/kernel/gpio.rs b/rust/kernel/gpio.rs
new file mode 100644
index 000000000000..2e4365dfcf74
--- /dev/null
+++ b/rust/kernel/gpio.rs
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Support for gpio device drivers.
+//!
+//! C header: [`include/linux/gpio/driver.h`](../../../../include/linux/gpio/driver.h)
+
+use crate::{
+    bindings, c_types, device, error::code::*, error::from_kernel_result, types::PointerWrapper,
+    Error, Result,
+};
+use core::{
+    cell::UnsafeCell,
+    marker::{PhantomData, PhantomPinned},
+    pin::Pin,
+};
+
+#[cfg(CONFIG_GPIOLIB_IRQCHIP)]
+pub use irqchip::{ChipWithIrqChip, RegistrationWithIrqChip};
+
+/// The direction of a gpio line.
+pub enum LineDirection {
+    /// Direction is input.
+    In = bindings::GPIO_LINE_DIRECTION_IN as _,
+
+    /// Direction is output.
+    Out = bindings::GPIO_LINE_DIRECTION_OUT as _,
+}
+
+/// A gpio chip.
+pub trait Chip {
+    /// Context data associated with the gpio chip.
+    ///
+    /// It determines the type of the context data passed to each of the methods of the trait.
+    type Data: PointerWrapper + Sync + Send;
+
+    /// The methods to use to populate [`struct gpio_chip`]. This is typically populated with
+    /// [`declare_gpio_chip_operations`].
+    const TO_USE: ToUse;
+
+    /// Returns the direction of the given gpio line.
+    fn get_direction(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _offset: u32,
+    ) -> Result<LineDirection> {
+        Err(ENOTSUPP)
+    }
+
+    /// Configures the direction as input of the given gpio line.
+    fn direction_input(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _offset: u32,
+    ) -> Result {
+        Err(EIO)
+    }
+
+    /// Configures the direction as output of the given gpio line.
+    ///
+    /// The value that will be initially output is also specified.
+    fn direction_output(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _offset: u32,
+        _value: bool,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Returns the current value of the given gpio line.
+    fn get(_data: <Self::Data as PointerWrapper>::Borrowed<'_>, _offset: u32) -> Result<bool> {
+        Err(EIO)
+    }
+
+    /// Sets the value of the given gpio line.
+    fn set(_data: <Self::Data as PointerWrapper>::Borrowed<'_>, _offset: u32, _value: bool) {}
+}
+
+/// Represents which fields of [`struct gpio_chip`] should be populated with pointers.
+///
+/// This is typically populated with the [`declare_gpio_chip_operations`] macro.
+pub struct ToUse {
+    /// The `get_direction` field of [`struct gpio_chip`].
+    pub get_direction: bool,
+
+    /// The `direction_input` field of [`struct gpio_chip`].
+    pub direction_input: bool,
+
+    /// The `direction_output` field of [`struct gpio_chip`].
+    pub direction_output: bool,
+
+    /// The `get` field of [`struct gpio_chip`].
+    pub get: bool,
+
+    /// The `set` field of [`struct gpio_chip`].
+    pub set: bool,
+}
+
+/// A constant version where all values are set to `false`, that is, all supported fields will be
+/// set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    get_direction: false,
+    direction_input: false,
+    direction_output: false,
+    get: false,
+    set: false,
+};
+
+/// Defines the [`Chip::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_gpio_chip_operations {
+    () => {
+        const TO_USE: $crate::gpio::ToUse = $crate::gpio::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        #[allow(clippy::needless_update)]
+        const TO_USE: $crate::gpio::ToUse =
+            $crate::gpio::ToUse {
+                $($i: true),+ ,
+                ..$crate::gpio::USE_NONE
+            };
+    };
+}
+
+/// A registration of a gpio chip.
+pub struct Registration<T: Chip> {
+    gc: UnsafeCell<bindings::gpio_chip>,
+    parent: Option<device::Device>,
+    _p: PhantomData<T>,
+    _pin: PhantomPinned,
+}
+
+impl<T: Chip> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new() -> Self {
+        Self {
+            parent: None,
+            gc: UnsafeCell::new(bindings::gpio_chip::default()),
+            _pin: PhantomPinned,
+            _p: PhantomData,
+        }
+    }
+
+    /// Registers a gpio chip with the rest of the kernel.
+    pub fn register(
+        self: Pin<&mut Self>,
+        gpio_count: u16,
+        base: Option<i32>,
+        parent: &dyn device::RawDevice,
+        data: T::Data,
+    ) -> Result {
+        if self.parent.is_some() {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        {
+            let gc = this.gc.get_mut();
+
+            // Set up the callbacks.
+            gc.request = Some(bindings::gpiochip_generic_request);
+            gc.free = Some(bindings::gpiochip_generic_free);
+            if T::TO_USE.get_direction {
+                gc.get_direction = Some(get_direction_callback::<T>);
+            }
+            if T::TO_USE.direction_input {
+                gc.direction_input = Some(direction_input_callback::<T>);
+            }
+            if T::TO_USE.direction_output {
+                gc.direction_output = Some(direction_output_callback::<T>);
+            }
+            if T::TO_USE.get {
+                gc.get = Some(get_callback::<T>);
+            }
+            if T::TO_USE.set {
+                gc.set = Some(set_callback::<T>);
+            }
+
+            // When a base is not explicitly given, use -1 for one to be picked.
+            if let Some(b) = base {
+                gc.base = b;
+            } else {
+                gc.base = -1;
+            }
+
+            gc.ngpio = gpio_count;
+            gc.parent = parent.raw_device();
+            gc.label = parent.name().as_char_ptr();
+
+            // TODO: Define `gc.owner` as well.
+        }
+
+        let data_pointer = <T::Data as PointerWrapper>::into_pointer(data);
+        // SAFETY: `gc` was initilised above, so it is valid.
+        let ret = unsafe {
+            bindings::gpiochip_add_data_with_key(
+                this.gc.get(),
+                data_pointer as _,
+                core::ptr::null_mut(),
+                core::ptr::null_mut(),
+            )
+        };
+        if ret < 0 {
+            // SAFETY: `data_pointer` was returned by `into_pointer` above.
+            unsafe { T::Data::from_pointer(data_pointer) };
+            return Err(Error::from_kernel_errno(ret));
+        }
+
+        this.parent = Some(device::Device::from_dev(parent));
+        Ok(())
+    }
+}
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
+// or CPUs, so it is safe to share it.
+unsafe impl<T: Chip> Sync for Registration<T> {}
+
+// SAFETY: Registration with and unregistration from the gpio subsystem can happen from any thread.
+// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is ok to move
+// `Registration` to different threads.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: Chip> Send for Registration<T> {}
+
+impl<T: Chip> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: Chip> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        if self.parent.is_some() {
+            // Get a pointer to the data stored in chip before destroying it.
+            // SAFETY: `gc` was during registration, which is guaranteed to have succeeded (because
+            // `parent` is `Some(_)`, so it remains valid.
+            let data_pointer = unsafe { bindings::gpiochip_get_data(self.gc.get()) };
+
+            // SAFETY: By the same argument above, `gc` is still valid.
+            unsafe { bindings::gpiochip_remove(self.gc.get()) };
+
+            // Free data as well.
+            // SAFETY: `data_pointer` was returned by `into_pointer` during registration.
+            unsafe { <T::Data as PointerWrapper>::from_pointer(data_pointer) };
+        }
+    }
+}
+
+unsafe extern "C" fn get_direction_callback<T: Chip>(
+    gc: *mut bindings::gpio_chip,
+    offset: c_types::c_uint,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The value stored as chip data was returned by `into_pointer` during registration.
+        let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+        Ok(T::get_direction(data, offset)? as i32)
+    }
+}
+
+unsafe extern "C" fn direction_input_callback<T: Chip>(
+    gc: *mut bindings::gpio_chip,
+    offset: c_types::c_uint,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The value stored as chip data was returned by `into_pointer` during registration.
+        let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+        T::direction_input(data, offset)?;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn direction_output_callback<T: Chip>(
+    gc: *mut bindings::gpio_chip,
+    offset: c_types::c_uint,
+    value: c_types::c_int,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The value stored as chip data was returned by `into_pointer` during registration.
+        let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+        T::direction_output(data, offset, value != 0)?;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn get_callback<T: Chip>(
+    gc: *mut bindings::gpio_chip,
+    offset: c_types::c_uint,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The value stored as chip data was returned by `into_pointer` during registration.
+        let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+        let v = T::get(data, offset)?;
+        Ok(v as _)
+    }
+}
+
+unsafe extern "C" fn set_callback<T: Chip>(
+    gc: *mut bindings::gpio_chip,
+    offset: c_types::c_uint,
+    value: c_types::c_int,
+) {
+    // SAFETY: The value stored as chip data was returned by `into_pointer` during registration.
+    let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+    T::set(data, offset, value != 0);
+}
+
+#[cfg(CONFIG_GPIOLIB_IRQCHIP)]
+mod irqchip {
+    use super::*;
+    use crate::irq;
+
+    /// A gpio chip that includes an irq chip.
+    pub trait ChipWithIrqChip: Chip {
+        /// Implements the irq flow for the gpio chip.
+        fn handle_irq_flow(
+            _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+            _desc: &irq::Descriptor,
+            _domain: &irq::Domain,
+        );
+    }
+
+    /// A registration of a gpio chip that includes an irq chip.
+    pub struct RegistrationWithIrqChip<T: ChipWithIrqChip> {
+        reg: Registration<T>,
+        irq_chip: UnsafeCell<bindings::irq_chip>,
+        parent_irq: u32,
+    }
+
+    impl<T: ChipWithIrqChip> RegistrationWithIrqChip<T> {
+        /// Creates a new [`RegistrationWithIrqChip`] but does not register it yet.
+        ///
+        /// It is allowed to move.
+        pub fn new() -> Self {
+            Self {
+                reg: Registration::new(),
+                irq_chip: UnsafeCell::new(bindings::irq_chip::default()),
+                parent_irq: 0,
+            }
+        }
+
+        /// Registers a gpio chip and its irq chip with the rest of the kernel.
+        pub fn register<U: irq::Chip<Data = T::Data>>(
+            mut self: Pin<&mut Self>,
+            gpio_count: u16,
+            base: Option<i32>,
+            parent: &dyn device::RawDevice,
+            data: T::Data,
+            parent_irq: u32,
+        ) -> Result {
+            if self.reg.parent.is_some() {
+                // Already registered.
+                return Err(EINVAL);
+            }
+
+            // SAFETY: We never move out of `this`.
+            let this = unsafe { self.as_mut().get_unchecked_mut() };
+
+            // Initialise the irq_chip.
+            {
+                let irq_chip = this.irq_chip.get_mut();
+                irq_chip.name = parent.name().as_char_ptr();
+
+                // SAFETY: The gpio subsystem configures a pointer to `gpio_chip` as the irq chip
+                // data, so we use `IrqChipAdapter` to convert to the `T::Data`, which is the same
+                // as `irq::Chip::Data` per the bound above.
+                unsafe { irq::init_chip::<IrqChipAdapter<U>>(irq_chip) };
+            }
+
+            // Initialise gc irq state.
+            {
+                let girq = &mut this.reg.gc.get_mut().irq;
+                girq.chip = this.irq_chip.get();
+                // SAFETY: By leaving `parent_handler_data` set to `null`, the gpio subsystem
+                // initialises it to a pointer to the gpio chip, which is what `FlowHandler<T>`
+                // expects.
+                girq.parent_handler = unsafe { irq::new_flow_handler::<FlowHandler<T>>() };
+                girq.num_parents = 1;
+                girq.parents = &mut this.parent_irq;
+                this.parent_irq = parent_irq;
+                girq.default_type = bindings::IRQ_TYPE_NONE;
+                girq.handler = Some(bindings::handle_bad_irq);
+            }
+
+            // SAFETY: `reg` is pinned when `self` is.
+            let pinned = unsafe { self.map_unchecked_mut(|r| &mut r.reg) };
+            pinned.register(gpio_count, base, parent, data)
+        }
+    }
+
+    impl<T: ChipWithIrqChip> Default for RegistrationWithIrqChip<T> {
+        fn default() -> Self {
+            Self::new()
+        }
+    }
+
+    // SAFETY: `RegistrationWithIrqChip` doesn't offer any methods or access to fields when shared
+    // between threads or CPUs, so it is safe to share it.
+    unsafe impl<T: ChipWithIrqChip> Sync for RegistrationWithIrqChip<T> {}
+
+    // SAFETY: Registration with and unregistration from the gpio subsystem (including irq chips for
+    // them) can happen from any thread. Additionally, `T::Data` (which is dropped during
+    // unregistration) is `Send`, so it is ok to move `Registration` to different threads.
+    #[allow(clippy::non_send_fields_in_send_ty)]
+    unsafe impl<T: ChipWithIrqChip> Send for RegistrationWithIrqChip<T> where T::Data: Send {}
+
+    struct FlowHandler<T: ChipWithIrqChip>(PhantomData<T>);
+
+    impl<T: ChipWithIrqChip> irq::FlowHandler for FlowHandler<T> {
+        type Data = *mut bindings::gpio_chip;
+
+        fn handle_irq_flow(gc: *mut bindings::gpio_chip, desc: &irq::Descriptor) {
+            // SAFETY: `FlowHandler` is only used in gpio chips, and it is removed when the gpio is
+            // unregistered, so we know that `gc` must still be valid. We also know that the value
+            // stored as gpio data was returned by `T::Data::into_pointer` again because
+            // `FlowHandler` is a private structure only used in this way.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc)) };
+
+            // SAFETY: `gc` is valid (see comment above), so we can dereference it.
+            let domain = unsafe { irq::Domain::from_ptr((*gc).irq.domain) };
+
+            T::handle_irq_flow(data, desc, &domain);
+        }
+    }
+
+    /// Adapter from an irq chip with `gpio_chip` pointer as context to one where the gpio chip
+    /// data is passed as context.
+    struct IrqChipAdapter<T: irq::Chip>(PhantomData<T>);
+
+    impl<T: irq::Chip> irq::Chip for IrqChipAdapter<T> {
+        type Data = *mut bindings::gpio_chip;
+        const TO_USE: irq::ToUse = T::TO_USE;
+
+        fn ack(gc: *mut bindings::gpio_chip, irq_data: &irq::IrqData) {
+            // SAFETY: `IrqChipAdapter` is a private struct, only used when the data stored in the
+            // gpio chip is known to come from `T::Data`, and only valid while the gpio chip is
+            // registered, so `gc` is valid.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc as _)) };
+            T::ack(data, irq_data);
+        }
+
+        fn mask(gc: *mut bindings::gpio_chip, irq_data: &irq::IrqData) {
+            // SAFETY: `IrqChipAdapter` is a private struct, only used when the data stored in the
+            // gpio chip is known to come from `T::Data`, and only valid while the gpio chip is
+            // registered, so `gc` is valid.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc as _)) };
+            T::mask(data, irq_data);
+        }
+
+        fn unmask(gc: *mut bindings::gpio_chip, irq_data: &irq::IrqData) {
+            // SAFETY: `IrqChipAdapter` is a private struct, only used when the data stored in the
+            // gpio chip is known to come from `T::Data`, and only valid while the gpio chip is
+            // registered, so `gc` is valid.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc as _)) };
+            T::unmask(data, irq_data);
+        }
+
+        fn set_type(
+            gc: *mut bindings::gpio_chip,
+            irq_data: &mut irq::LockedIrqData,
+            flow_type: u32,
+        ) -> Result<irq::ExtraResult> {
+            // SAFETY: `IrqChipAdapter` is a private struct, only used when the data stored in the
+            // gpio chip is known to come from `T::Data`, and only valid while the gpio chip is
+            // registered, so `gc` is valid.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc as _)) };
+            T::set_type(data, irq_data, flow_type)
+        }
+
+        fn set_wake(gc: *mut bindings::gpio_chip, irq_data: &irq::IrqData, on: bool) -> Result {
+            // SAFETY: `IrqChipAdapter` is a private struct, only used when the data stored in the
+            // gpio chip is known to come from `T::Data`, and only valid while the gpio chip is
+            // registered, so `gc` is valid.
+            let data = unsafe { T::Data::borrow(bindings::gpiochip_get_data(gc as _)) };
+            T::set_wake(data, irq_data, on)
+        }
+    }
+}
diff --git a/rust/kernel/hwrng.rs b/rust/kernel/hwrng.rs
new file mode 100644
index 000000000000..a50de9510631
--- /dev/null
+++ b/rust/kernel/hwrng.rs
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Hardware Random Number Generator.
+//!
+//! C header: [`include/linux/hw_random.h`](../../../../include/linux/hw_random.h)
+
+use alloc::{boxed::Box, slice::from_raw_parts_mut};
+
+use crate::{
+    bindings, c_types, error::code::*, error::from_kernel_result, str::CString, to_result,
+    types::PointerWrapper, Result, ScopeGuard,
+};
+
+use core::{cell::UnsafeCell, fmt, marker::PhantomData, pin::Pin};
+
+/// This trait is implemented in order to provide callbacks to `struct hwrng`.
+pub trait Operations {
+    /// The methods to use to populate [`struct hwrng`].
+    const TO_USE: ToUse;
+
+    /// The pointer type that will be used to hold user-defined data type.
+    type Data: PointerWrapper + Send + Sync = ();
+
+    /// Initialization callback, can be left undefined.
+    fn init(_data: <Self::Data as PointerWrapper>::Borrowed<'_>) -> Result {
+        Err(EINVAL)
+    }
+
+    /// Cleanup callback, can be left undefined.
+    fn cleanup(_data: Self::Data) {}
+
+    /// Read data into the provided buffer.
+    /// Drivers can fill up to max bytes of data into the buffer.
+    /// The buffer is aligned for any type and its size is a multiple of 4 and >= 32 bytes.
+    fn read(
+        data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        buffer: &mut [u8],
+        wait: bool,
+    ) -> Result<u32>;
+}
+
+/// Registration structure for Hardware Random Number Generator driver.
+pub struct Registration<T: Operations> {
+    hwrng: UnsafeCell<bindings::hwrng>,
+    name: Option<CString>,
+    registered: bool,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> Registration<T> {
+    /// Creates new instance of registration.
+    ///
+    /// The data must be registered.
+    pub fn new() -> Self {
+        Self {
+            hwrng: UnsafeCell::new(bindings::hwrng::default()),
+            name: None,
+            registered: false,
+            _p: PhantomData,
+        }
+    }
+
+    /// Returns a registered and pinned, heap-allocated representation of the registration.
+    pub fn new_pinned(
+        name: fmt::Arguments<'_>,
+        quality: u16,
+        data: T::Data,
+    ) -> Result<Pin<Box<Self>>> {
+        let mut reg = Pin::from(Box::try_new(Self::new())?);
+        reg.as_mut().register(name, quality, data)?;
+        Ok(reg)
+    }
+
+    /// Registers a hwrng device within the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents
+    /// the registration may be self-referential.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: fmt::Arguments<'_>,
+        quality: u16,
+        data: T::Data,
+    ) -> Result {
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        if this.registered {
+            return Err(EINVAL);
+        }
+
+        let data_pointer = data.into_pointer();
+
+        // SAFETY: `data_pointer` comes from the call to `data.into_pointer()` above.
+        let guard = ScopeGuard::new(|| unsafe {
+            T::Data::from_pointer(data_pointer);
+        });
+
+        let name = CString::try_from_fmt(name)?;
+
+        // SAFETY: Registration is pinned and contains allocated and set to zero `bindings::hwrng` structure.
+        Self::init_hwrng(
+            unsafe { &mut *this.hwrng.get() },
+            &name,
+            quality,
+            data_pointer,
+        );
+
+        // SAFETY: `bindings::hwrng` is initialized above which guarantees safety.
+        to_result(|| unsafe { bindings::hwrng_register(this.hwrng.get()) })?;
+
+        this.registered = true;
+        this.name = Some(name);
+        guard.dismiss();
+        Ok(())
+    }
+
+    fn init_hwrng(
+        hwrng: &mut bindings::hwrng,
+        name: &CString,
+        quality: u16,
+        data: *const c_types::c_void,
+    ) {
+        hwrng.name = name.as_char_ptr();
+
+        hwrng.init = if T::TO_USE.init {
+            Some(Self::init_callback)
+        } else {
+            None
+        };
+        hwrng.cleanup = if T::TO_USE.cleanup {
+            Some(Self::cleanup_callback)
+        } else {
+            None
+        };
+        hwrng.data_present = None;
+        hwrng.data_read = None;
+        hwrng.read = Some(Self::read_callback);
+
+        hwrng.priv_ = data as _;
+        hwrng.quality = quality;
+
+        // SAFETY: All fields are properly initialized as
+        // remaining fields `list`, `ref` and `cleanup_done` are already
+        // zeroed by `bindings::hwrng::default()` call.
+    }
+
+    unsafe extern "C" fn init_callback(rng: *mut bindings::hwrng) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `priv` private data field was initialized during creation of
+            // the `bindings::hwrng` in `Self::init_hwrng` method. This callback is only
+            // called once the driver is registered.
+            let data = unsafe { T::Data::borrow((*rng).priv_ as *const _) };
+            T::init(data)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn cleanup_callback(rng: *mut bindings::hwrng) {
+        // SAFETY: `priv` private data field was initialized during creation of
+        // the `bindings::hwrng` in `Self::init_hwrng` method. This callback is only
+        // called once the driver is registered.
+        let data = unsafe { T::Data::from_pointer((*rng).priv_ as *const _) };
+        T::cleanup(data);
+    }
+
+    unsafe extern "C" fn read_callback(
+        rng: *mut bindings::hwrng,
+        data: *mut c_types::c_void,
+        max: usize,
+        wait: bindings::bool_,
+    ) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `priv` private data field was initialized during creation of
+            // the `bindings::hwrng` in `Self::init_hwrng` method. This callback is only
+            // called once the driver is registered.
+            let drv_data = unsafe { T::Data::borrow((*rng).priv_ as *const _) };
+
+            // SAFETY: Slice is created from `data` and `max` arguments that are C's buffer
+            // along with its size in bytes that are safe for this conversion.
+            let buffer = unsafe { from_raw_parts_mut(data as *mut u8, max) };
+            let ret = T::read(drv_data, buffer, wait)?;
+            Ok(ret as _)
+        }
+    }
+}
+
+impl<T: Operations> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// Represents which callbacks of [`struct hwrng`] should be populated with pointers.
+pub struct ToUse {
+    /// The `init` field of [`struct hwrng`].
+    pub init: bool,
+
+    /// The `cleanup` field of [`struct hwrng`].
+    pub cleanup: bool,
+}
+
+/// A constant version where all values are to set to `false`, that is, all supported fields will
+/// be set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    init: false,
+    cleanup: false,
+};
+
+/// Defines the [`Operations::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_hwrng_operations {
+    () => {
+        const TO_USE: $crate::hwrng::ToUse = $crate::hwrng::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        #[allow(clippy::needless_update)]
+        const TO_USE: kernel::hwrng::ToUse =
+            $crate::hwrng::ToUse {
+                $($i: true),+ ,
+                ..$crate::hwrng::USE_NONE
+            };
+    };
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads.
+unsafe impl<T: Operations> Sync for Registration<T> {}
+
+// SAFETY: `Registration` is not restricted to a single thread,
+// its `T::Data` is also `Send` so it may be moved to different threads.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: Operations> Send for Registration<T> {}
+
+impl<T: Operations> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        // SAFETY: The instance of Registration<T> is unregistered only
+        // after being initialized and registered before.
+        if self.registered {
+            unsafe { bindings::hwrng_unregister(self.hwrng.get()) };
+        }
+    }
+}
diff --git a/rust/kernel/io_buffer.rs b/rust/kernel/io_buffer.rs
new file mode 100644
index 000000000000..ccecc4763aca
--- /dev/null
+++ b/rust/kernel/io_buffer.rs
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Buffers used in IO.
+
+use crate::Result;
+use alloc::vec::Vec;
+use core::mem::{size_of, MaybeUninit};
+
+/// Represents a buffer to be read from during IO.
+pub trait IoBufferReader {
+    /// Returns the number of bytes left to be read from the io buffer.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    fn len(&self) -> usize;
+
+    /// Returns `true` if no data is available in the io buffer.
+    fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Reads raw data from the io buffer into a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The output buffer must be valid.
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result;
+
+    /// Reads all data remaining in the io buffer.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to mapped, readable memory.
+    fn read_all(&mut self) -> Result<Vec<u8>> {
+        let mut data = Vec::<u8>::new();
+        data.try_resize(self.len(), 0)?;
+
+        // SAFETY: The output buffer is valid as we just allocated it.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len())? };
+        Ok(data)
+    }
+
+    /// Reads a byte slice from the io buffer.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size of the user slice or
+    /// if the address does not currently point to mapped, readable memory.
+    fn read_slice(&mut self, data: &mut [u8]) -> Result {
+        // SAFETY: The output buffer is valid as it's coming from a live reference.
+        unsafe { self.read_raw(data.as_mut_ptr(), data.len()) }
+    }
+
+    /// Reads the contents of a plain old data (POD) type from the io buffer.
+    fn read<T: ReadableFromBytes>(&mut self) -> Result<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        // SAFETY: The buffer is valid as it was just allocated.
+        unsafe { self.read_raw(out.as_mut_ptr() as _, size_of::<T>()) }?;
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+}
+
+/// Represents a buffer to be written to during IO.
+pub trait IoBufferWriter {
+    /// Returns the number of bytes left to be written into the io buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    fn len(&self) -> usize;
+
+    /// Returns `true` if the io buffer cannot hold any additional data.
+    fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Writes zeroes to the io buffer.
+    ///
+    /// Differently from the other write functions, `clear` will zero as much as it can and update
+    /// the writer internal state to reflect this. It will, however, return an error if it cannot
+    /// clear `len` bytes.
+    ///
+    /// For example, if a caller requests that 100 bytes be cleared but a segfault happens after
+    /// 20 bytes, then EFAULT is returned and the writer is advanced by 20 bytes.
+    fn clear(&mut self, len: usize) -> Result;
+
+    /// Writes a byte slice into the io buffer.
+    ///
+    /// Returns `EFAULT` if the byte slice is bigger than the remaining size of the io buffer or if
+    /// the address does not currently point to mapped, writable memory.
+    fn write_slice(&mut self, data: &[u8]) -> Result {
+        // SAFETY: The input buffer is valid as it's coming from a live reference.
+        unsafe { self.write_raw(data.as_ptr(), data.len()) }
+    }
+
+    /// Writes raw data to the io buffer from a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The input buffer must be valid.
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result;
+
+    /// Writes the contents of the given data into the io buffer.
+    fn write<T: WritableToBytes>(&mut self, data: &T) -> Result {
+        // SAFETY: The input buffer is valid as it's coming from a live
+        // reference to a type that implements `WritableToBytes`.
+        unsafe { self.write_raw(data as *const T as _, size_of::<T>()) }
+    }
+}
+
+/// Specifies that a type is safely readable from byte slices.
+///
+/// Not all types can be safely read from byte slices; examples from
+/// <https://doc.rust-lang.org/reference/behavior-considered-undefined.html> include `bool`
+/// that must be either `0` or `1`, and `char` that cannot be a surrogate or above `char::MAX`.
+///
+/// # Safety
+///
+/// Implementers must ensure that the type is made up only of types that can be safely read from
+/// arbitrary byte sequences (e.g., `u32`, `u64`, etc.).
+pub unsafe trait ReadableFromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl ReadableFromBytes for u8 {}
+unsafe impl ReadableFromBytes for u16 {}
+unsafe impl ReadableFromBytes for u32 {}
+unsafe impl ReadableFromBytes for u64 {}
+unsafe impl ReadableFromBytes for usize {}
+unsafe impl ReadableFromBytes for i8 {}
+unsafe impl ReadableFromBytes for i16 {}
+unsafe impl ReadableFromBytes for i32 {}
+unsafe impl ReadableFromBytes for i64 {}
+unsafe impl ReadableFromBytes for isize {}
+
+/// Specifies that a type is safely writable to byte slices.
+///
+/// This means that we don't read undefined values (which leads to UB) in preparation for writing
+/// to the byte slice. It also ensures that no potentially sensitive information is leaked into the
+/// byte slices.
+///
+/// # Safety
+///
+/// A type must not include padding bytes and must be fully initialised to safely implement
+/// [`WritableToBytes`] (i.e., it doesn't contain [`MaybeUninit`] fields). A composition of
+/// writable types in a structure is not necessarily writable because it may result in padding
+/// bytes.
+pub unsafe trait WritableToBytes {}
+
+// SAFETY: Initialised instances of the following types have no uninitialised portions.
+unsafe impl WritableToBytes for u8 {}
+unsafe impl WritableToBytes for u16 {}
+unsafe impl WritableToBytes for u32 {}
+unsafe impl WritableToBytes for u64 {}
+unsafe impl WritableToBytes for usize {}
+unsafe impl WritableToBytes for i8 {}
+unsafe impl WritableToBytes for i16 {}
+unsafe impl WritableToBytes for i32 {}
+unsafe impl WritableToBytes for i64 {}
+unsafe impl WritableToBytes for isize {}
diff --git a/rust/kernel/io_mem.rs b/rust/kernel/io_mem.rs
new file mode 100644
index 000000000000..19df48d8e2f8
--- /dev/null
+++ b/rust/kernel/io_mem.rs
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory-mapped IO.
+//!
+//! C header: [`include/asm-generic/io.h`](../../../../include/asm-generic/io.h)
+
+#![allow(dead_code)]
+
+use crate::{bindings, error::code::*, Result};
+use core::convert::TryInto;
+
+/// Represents a memory resource.
+pub struct Resource {
+    offset: bindings::resource_size_t,
+    size: bindings::resource_size_t,
+}
+
+impl Resource {
+    pub(crate) fn new(
+        start: bindings::resource_size_t,
+        end: bindings::resource_size_t,
+    ) -> Option<Self> {
+        if start == 0 {
+            return None;
+        }
+        Some(Self {
+            offset: start,
+            size: end.checked_sub(start)?.checked_add(1)?,
+        })
+    }
+}
+
+/// Represents a memory block of at least `SIZE` bytes.
+///
+/// # Invariants
+///
+/// `ptr` is a non-null and valid address of at least `SIZE` bytes and returned by an `ioremap`
+/// variant. `ptr` is also 8-byte aligned.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::io_mem::{IoMem, Resource};
+///
+/// fn test(res: Resource) -> Result {
+///     // Create an io mem block of at least 100 bytes.
+///     // SAFETY: No DMA operations are initiated through `mem`.
+///     let mem = unsafe { IoMem::<100>::try_new(res) }?;
+///
+///     // Read one byte from offset 10.
+///     let v = mem.readb(10);
+///
+///     // Write value to offset 20.
+///     mem.writeb(v, 20);
+///
+///     Ok(())
+/// }
+///
+/// ```
+pub struct IoMem<const SIZE: usize> {
+    ptr: usize,
+}
+
+macro_rules! define_read {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+        /// Reads IO data from the given offset known, at compile time.
+        ///
+        /// If the offset is not known at compile time, the build will fail.
+        $(#[$attr])*
+        pub fn $name(&self, offset: usize) -> $type_name {
+            Self::check_offset::<$type_name>(offset);
+            let ptr = self.ptr.wrapping_add(offset);
+            // SAFETY: The type invariants guarantee that `ptr` is a valid pointer. The check above
+            // guarantees that the code won't build if `offset` makes the read go out of bounds
+            // (including the type size).
+            unsafe { bindings::$name(ptr as _) }
+        }
+
+        /// Reads IO data from the given offset.
+        ///
+        /// It fails if/when the offset (plus the type size) is out of bounds.
+        $(#[$attr])*
+        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
+            if !Self::offset_ok::<$type_name>(offset) {
+                return Err(EINVAL);
+            }
+            let ptr = self.ptr.wrapping_add(offset);
+            // SAFETY: The type invariants guarantee that `ptr` is a valid pointer. The check above
+            // returns an error if `offset` would make the read go out of bounds (including the
+            // type size).
+            Ok(unsafe { bindings::$name(ptr as _) })
+        }
+    };
+}
+
+macro_rules! define_write {
+    ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) => {
+        /// Writes IO data to the given offset, known at compile time.
+        ///
+        /// If the offset is not known at compile time, the build will fail.
+        $(#[$attr])*
+        pub fn $name(&self, value: $type_name, offset: usize) {
+            Self::check_offset::<$type_name>(offset);
+            let ptr = self.ptr.wrapping_add(offset);
+            // SAFETY: The type invariants guarantee that `ptr` is a valid pointer. The check above
+            // guarantees that the code won't link if `offset` makes the write go out of bounds
+            // (including the type size).
+            unsafe { bindings::$name(value, ptr as _) }
+        }
+
+        /// Writes IO data to the given offset.
+        ///
+        /// It fails if/when the offset (plus the type size) is out of bounds.
+        $(#[$attr])*
+        pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
+            if !Self::offset_ok::<$type_name>(offset) {
+                return Err(EINVAL);
+            }
+            let ptr = self.ptr.wrapping_add(offset);
+            // SAFETY: The type invariants guarantee that `ptr` is a valid pointer. The check above
+            // returns an error if `offset` would make the write go out of bounds (including the
+            // type size).
+            unsafe { bindings::$name(value, ptr as _) };
+            Ok(())
+        }
+    };
+}
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    /// Tries to create a new instance of a memory block.
+    ///
+    /// The resource described by `res` is mapped into the CPU's address space so that it can be
+    /// accessed directly. It is also consumed by this function so that it can't be mapped again
+    /// to a different address.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that either (a) the resulting interface cannot be used to initiate DMA
+    /// operations, or (b) that DMA operations initiated via the returned interface use DMA handles
+    /// allocated through the `dma` module.
+    pub unsafe fn try_new(res: Resource) -> Result<Self> {
+        // Check that the resource has at least `SIZE` bytes in it.
+        if res.size < SIZE.try_into()? {
+            return Err(EINVAL);
+        }
+
+        // To be able to check pointers at compile time based only on offsets, we need to guarantee
+        // that the base pointer is minimally aligned. So we conservatively expect at least 8 bytes.
+        if res.offset % 8 != 0 {
+            crate::pr_err!("Physical address is not 64-bit aligned: {:x}", res.offset);
+            return Err(EDOM);
+        }
+
+        // Try to map the resource.
+        // SAFETY: Just mapping the memory range.
+        let addr = unsafe { bindings::ioremap(res.offset, res.size as _) };
+        if addr.is_null() {
+            Err(ENOMEM)
+        } else {
+            // INVARIANT: `addr` is non-null and was returned by `ioremap`, so it is valid. It is
+            // also 8-byte aligned because we checked it above.
+            Ok(Self { ptr: addr as usize })
+        }
+    }
+
+    const fn offset_ok<T>(offset: usize) -> bool {
+        let type_size = core::mem::size_of::<T>();
+        if let Some(end) = offset.checked_add(type_size) {
+            end <= SIZE && offset % type_size == 0
+        } else {
+            false
+        }
+    }
+
+    fn offset_ok_of_val<T: ?Sized>(offset: usize, value: &T) -> bool {
+        let value_size = core::mem::size_of_val(value);
+        let value_alignment = core::mem::align_of_val(value);
+        if let Some(end) = offset.checked_add(value_size) {
+            end <= SIZE && offset % value_alignment == 0
+        } else {
+            false
+        }
+    }
+
+    const fn check_offset<T>(offset: usize) {
+        crate::build_assert!(Self::offset_ok::<T>(offset), "IoMem offset overflow");
+    }
+
+    define_read!(readb, try_readb, u8);
+    define_read!(readw, try_readw, u16);
+    define_read!(readl, try_readl, u32);
+    define_read!(
+        #[cfg(CONFIG_64BIT)]
+        readq,
+        try_readq,
+        u64
+    );
+
+    define_read!(readb_relaxed, try_readb_relaxed, u8);
+    define_read!(readw_relaxed, try_readw_relaxed, u16);
+    define_read!(readl_relaxed, try_readl_relaxed, u32);
+    define_read!(
+        #[cfg(CONFIG_64BIT)]
+        readq_relaxed,
+        try_readq_relaxed,
+        u64
+    );
+
+    define_write!(writeb, try_writeb, u8);
+    define_write!(writew, try_writew, u16);
+    define_write!(writel, try_writel, u32);
+    define_write!(
+        #[cfg(CONFIG_64BIT)]
+        writeq,
+        try_writeq,
+        u64
+    );
+
+    define_write!(writeb_relaxed, try_writeb_relaxed, u8);
+    define_write!(writew_relaxed, try_writew_relaxed, u16);
+    define_write!(writel_relaxed, try_writel_relaxed, u32);
+    define_write!(
+        #[cfg(CONFIG_64BIT)]
+        writeq_relaxed,
+        try_writeq_relaxed,
+        u64
+    );
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, `self.ptr` is a value returned by a previous successful
+        // call to `ioremap`.
+        unsafe { bindings::iounmap(self.ptr as _) };
+    }
+}
diff --git a/rust/kernel/iov_iter.rs b/rust/kernel/iov_iter.rs
new file mode 100644
index 000000000000..b9b8dc882bd0
--- /dev/null
+++ b/rust/kernel/iov_iter.rs
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO vector iterators.
+//!
+//! C header: [`include/linux/uio.h`](../../../../include/linux/uio.h)
+
+use crate::{
+    bindings,
+    error::code::*,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    Result,
+};
+
+/// Wraps the kernel's `struct iov_iter`.
+///
+/// # Invariants
+///
+/// The pointer `IovIter::ptr` is non-null and valid.
+pub struct IovIter {
+    ptr: *mut bindings::iov_iter,
+}
+
+impl IovIter {
+    fn common_len(&self) -> usize {
+        // SAFETY: `IovIter::ptr` is guaranteed to be valid by the type invariants.
+        unsafe { (*self.ptr).count }
+    }
+
+    /// Constructs a new [`struct iov_iter`] wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::iov_iter) -> Self {
+        // INVARIANTS: the safety contract ensures the type invariant will hold.
+        Self { ptr }
+    }
+}
+
+impl IoBufferWriter for IovIter {
+    fn len(&self) -> usize {
+        self.common_len()
+    }
+
+    fn clear(&mut self, mut len: usize) -> Result {
+        while len > 0 {
+            // SAFETY: `IovIter::ptr` is guaranteed to be valid by the type invariants.
+            let written = unsafe { bindings::iov_iter_zero(len, self.ptr) };
+            if written == 0 {
+                return Err(EFAULT);
+            }
+
+            len -= written;
+        }
+        Ok(())
+    }
+
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        let res = unsafe { bindings::copy_to_iter(data as _, len, self.ptr) };
+        if res != len {
+            Err(EFAULT)
+        } else {
+            Ok(())
+        }
+    }
+}
+
+impl IoBufferReader for IovIter {
+    fn len(&self) -> usize {
+        self.common_len()
+    }
+
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        let res = unsafe { bindings::copy_from_iter(out as _, len, self.ptr) };
+        if res != len {
+            Err(EFAULT)
+        } else {
+            Ok(())
+        }
+    }
+}
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 000000000000..ca62849a5dc0
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupts and interrupt chips.
+//!
+//! See <https://www.kernel.org/doc/Documentation/core-api/genericirq.rst>.
+//!
+//! C headers: [`include/linux/irq.h`](../../../../include/linux/irq.h) and
+//! [`include/linux/interrupt.h`](../../../../include/linux/interrupt.h).
+
+#![allow(dead_code)]
+
+use crate::{bindings, c_types, error::from_kernel_result, types::PointerWrapper, Error, Result};
+use core::ops::Deref;
+
+/// The type of irq hardware numbers.
+pub type HwNumber = bindings::irq_hw_number_t;
+
+/// Wraps the kernel's `struct irq_data`.
+///
+/// # Invariants
+///
+/// The pointer `IrqData::ptr` is non-null and valid.
+pub struct IrqData {
+    ptr: *mut bindings::irq_data,
+}
+
+impl IrqData {
+    /// Creates a new `IrqData` instance from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is non-null and valid when the function is called, and that
+    /// it remains valid for the lifetime of the return [`IrqData`] instance.
+    unsafe fn from_ptr(ptr: *mut bindings::irq_data) -> Self {
+        // INVARIANTS: By the safety requirements, the instance we're creating satisfies the type
+        // invariants.
+        Self { ptr }
+    }
+
+    /// Returns the hardware irq number.
+    pub fn hwirq(&self) -> HwNumber {
+        // SAFETY: By the type invariants, it's ok to dereference `ptr`.
+        unsafe { (*self.ptr).hwirq }
+    }
+}
+
+/// Wraps the kernel's `struct irq_data` when it is locked.
+///
+/// Being locked allows additional operations to be performed on the data.
+pub struct LockedIrqData(IrqData);
+
+impl LockedIrqData {
+    /// Sets the high-level irq flow handler to the builtin one for level-triggered irqs.
+    pub fn set_level_handler(&mut self) {
+        // SAFETY: By the type invariants of `self.0`, we know `self.0.ptr` is valid.
+        unsafe { bindings::irq_set_handler_locked(self.0.ptr, Some(bindings::handle_level_irq)) };
+    }
+
+    /// Sets the high-level irq flow handler to the builtin one for edge-triggered irqs.
+    pub fn set_edge_handler(&mut self) {
+        // SAFETY: By the type invariants of `self.0`, we know `self.0.ptr` is valid.
+        unsafe { bindings::irq_set_handler_locked(self.0.ptr, Some(bindings::handle_edge_irq)) };
+    }
+
+    /// Sets the high-level irq flow handler to the builtin one for bad irqs.
+    pub fn set_bad_handler(&mut self) {
+        // SAFETY: By the type invariants of `self.0`, we know `self.0.ptr` is valid.
+        unsafe { bindings::irq_set_handler_locked(self.0.ptr, Some(bindings::handle_bad_irq)) };
+    }
+}
+
+impl Deref for LockedIrqData {
+    type Target = IrqData;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+/// Extra information returned by some of the [`Chip`] methods on success.
+pub enum ExtraResult {
+    /// Indicates that the caller (irq core) will update the descriptor state.
+    None = bindings::IRQ_SET_MASK_OK as _,
+
+    /// Indicates that the callee (irq chip implementation) already updated the descriptor state.
+    NoCopy = bindings::IRQ_SET_MASK_OK_NOCOPY as _,
+
+    /// Same as [`ExtraResult::None`] in terms of updating descriptor state. It is used in stacked
+    /// irq chips to indicate that descendant chips should be skipped.
+    Done = bindings::IRQ_SET_MASK_OK_DONE as _,
+}
+
+/// An irq chip.
+///
+/// It is a trait for the functions defined in [`struct irq_chip`].
+///
+/// [`struct irq_chip`]: ../../../include/linux/irq.h
+pub trait Chip: Sized {
+    /// The type of the context data stored in the irq chip and made available on each callback.
+    type Data: PointerWrapper;
+
+    /// The methods to use to populate [`struct irq_chip`]. This is typically populated with
+    /// [`declare_irq_chip_operations`].
+    const TO_USE: ToUse;
+
+    /// Called at the start of a new interrupt.
+    fn ack(data: <Self::Data as PointerWrapper>::Borrowed<'_>, irq_data: &IrqData);
+
+    /// Masks an interrupt source.
+    fn mask(data: <Self::Data as PointerWrapper>::Borrowed<'_>, irq_data: &IrqData);
+
+    /// Unmasks an interrupt source.
+    fn unmask(_data: <Self::Data as PointerWrapper>::Borrowed<'_>, irq_data: &IrqData);
+
+    /// Sets the flow type of an interrupt.
+    ///
+    /// The flow type is a combination of the constants in [`Type`].
+    fn set_type(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _irq_data: &mut LockedIrqData,
+        _flow_type: u32,
+    ) -> Result<ExtraResult> {
+        Ok(ExtraResult::None)
+    }
+
+    /// Enables or disables power-management wake-on of an interrupt.
+    fn set_wake(
+        _data: <Self::Data as PointerWrapper>::Borrowed<'_>,
+        _irq_data: &IrqData,
+        _on: bool,
+    ) -> Result {
+        Ok(())
+    }
+}
+
+/// Initialises `chip` with the callbacks defined in `T`.
+///
+/// # Safety
+///
+/// The caller must ensure that the value stored in the irq chip data is the result of calling
+/// [`PointerWrapper::into_pointer] for the [`T::Data`] type.
+pub(crate) unsafe fn init_chip<T: Chip>(chip: &mut bindings::irq_chip) {
+    chip.irq_ack = Some(irq_ack_callback::<T>);
+    chip.irq_mask = Some(irq_mask_callback::<T>);
+    chip.irq_unmask = Some(irq_unmask_callback::<T>);
+
+    if T::TO_USE.set_type {
+        chip.irq_set_type = Some(irq_set_type_callback::<T>);
+    }
+
+    if T::TO_USE.set_wake {
+        chip.irq_set_wake = Some(irq_set_wake_callback::<T>);
+    }
+}
+
+/// Represents which fields of [`struct irq_chip`] should be populated with pointers.
+///
+/// This is typically populated with the [`declare_irq_chip_operations`] macro.
+pub struct ToUse {
+    /// The `irq_set_type` field of [`struct irq_chip`].
+    pub set_type: bool,
+
+    /// The `irq_set_wake` field of [`struct irq_chip`].
+    pub set_wake: bool,
+}
+
+/// A constant version where all values are to set to `false`, that is, all supported fields will
+/// be set to null pointers.
+pub const USE_NONE: ToUse = ToUse {
+    set_type: false,
+    set_wake: false,
+};
+
+/// Defines the [`Chip::TO_USE`] field based on a list of fields to be populated.
+#[macro_export]
+macro_rules! declare_irq_chip_operations {
+    () => {
+        const TO_USE: $crate::irq::ToUse = $crate::irq::USE_NONE;
+    };
+    ($($i:ident),+) => {
+        #[allow(clippy::needless_update)]
+        const TO_USE: $crate::irq::ToUse =
+            $crate::irq::ToUse {
+                $($i: true),+ ,
+                ..$crate::irq::USE_NONE
+            };
+    };
+}
+
+/// Enables or disables power-management wake-on for the given irq number.
+pub fn set_wake(irq: u32, on: bool) -> Result {
+    // SAFETY: Just an FFI call, there are no extra requirements for safety.
+    let ret = unsafe { bindings::irq_set_irq_wake(irq, on as _) };
+    if ret < 0 {
+        Err(Error::from_kernel_errno(ret))
+    } else {
+        Ok(())
+    }
+}
+
+unsafe extern "C" fn irq_ack_callback<T: Chip>(irq_data: *mut bindings::irq_data) {
+    // SAFETY: The safety requirements of `init_chip`, which is the only place that uses this
+    // callback, ensure that the value stored as irq chip data comes from a previous call to
+    // `PointerWrapper::into_pointer`.
+    let data = unsafe { T::Data::borrow(bindings::irq_data_get_irq_chip_data(irq_data)) };
+
+    // SAFETY: The value returned by `IrqData` is only valid until the end of this function, and
+    // `irq_data` is guaranteed to be valid until then (by the contract with C code).
+    T::ack(data, unsafe { &IrqData::from_ptr(irq_data) })
+}
+
+unsafe extern "C" fn irq_mask_callback<T: Chip>(irq_data: *mut bindings::irq_data) {
+    // SAFETY: The safety requirements of `init_chip`, which is the only place that uses this
+    // callback, ensure that the value stored as irq chip data comes from a previous call to
+    // `PointerWrapper::into_pointer`.
+    let data = unsafe { T::Data::borrow(bindings::irq_data_get_irq_chip_data(irq_data)) };
+
+    // SAFETY: The value returned by `IrqData` is only valid until the end of this function, and
+    // `irq_data` is guaranteed to be valid until then (by the contract with C code).
+    T::mask(data, unsafe { &IrqData::from_ptr(irq_data) })
+}
+
+unsafe extern "C" fn irq_unmask_callback<T: Chip>(irq_data: *mut bindings::irq_data) {
+    // SAFETY: The safety requirements of `init_chip`, which is the only place that uses this
+    // callback, ensure that the value stored as irq chip data comes from a previous call to
+    // `PointerWrapper::into_pointer`.
+    let data = unsafe { T::Data::borrow(bindings::irq_data_get_irq_chip_data(irq_data)) };
+
+    // SAFETY: The value returned by `IrqData` is only valid until the end of this function, and
+    // `irq_data` is guaranteed to be valid until then (by the contract with C code).
+    T::unmask(data, unsafe { &IrqData::from_ptr(irq_data) })
+}
+
+unsafe extern "C" fn irq_set_type_callback<T: Chip>(
+    irq_data: *mut bindings::irq_data,
+    flow_type: c_types::c_uint,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The safety requirements of `init_chip`, which is the only place that uses this
+        // callback, ensure that the value stored as irq chip data comes from a previous call to
+        // `PointerWrapper::into_pointer`.
+        let data = unsafe { T::Data::borrow(bindings::irq_data_get_irq_chip_data(irq_data)) };
+
+        // SAFETY: The value returned by `IrqData` is only valid until the end of this function, and
+        // `irq_data` is guaranteed to be valid until then (by the contract with C code).
+        let ret = T::set_type(data, &mut LockedIrqData(unsafe { IrqData::from_ptr(irq_data) }), flow_type)?;
+        Ok(ret as _)
+    }
+}
+
+unsafe extern "C" fn irq_set_wake_callback<T: Chip>(
+    irq_data: *mut bindings::irq_data,
+    on: c_types::c_uint,
+) -> c_types::c_int {
+    from_kernel_result! {
+        // SAFETY: The safety requirements of `init_chip`, which is the only place that uses this
+        // callback, ensure that the value stored as irq chip data comes from a previous call to
+        // `PointerWrapper::into_pointer`.
+        let data = unsafe { T::Data::borrow(bindings::irq_data_get_irq_chip_data(irq_data)) };
+
+        // SAFETY: The value returned by `IrqData` is only valid until the end of this function, and
+        // `irq_data` is guaranteed to be valid until then (by the contract with C code).
+        T::set_wake(data, unsafe { &IrqData::from_ptr(irq_data) }, on != 0)?;
+        Ok(0)
+    }
+}
+
+/// Contains constants that describes how an interrupt can be triggered.
+///
+/// It is tagged with `non_exhaustive` to prevent users from instantiating it.
+#[non_exhaustive]
+pub struct Type;
+
+impl Type {
+    /// The interrupt cannot be triggered.
+    pub const NONE: u32 = bindings::IRQ_TYPE_NONE;
+
+    /// The interrupt is triggered when the signal goes from low to high.
+    pub const EDGE_RISING: u32 = bindings::IRQ_TYPE_EDGE_RISING;
+
+    /// The interrupt is triggered when the signal goes from high to low.
+    pub const EDGE_FALLING: u32 = bindings::IRQ_TYPE_EDGE_FALLING;
+
+    /// The interrupt is triggered when the signal goes from low to high and when it goes to high
+    /// to low.
+    pub const EDGE_BOTH: u32 = bindings::IRQ_TYPE_EDGE_BOTH;
+
+    /// The interrupt is triggered while the signal is held high.
+    pub const LEVEL_HIGH: u32 = bindings::IRQ_TYPE_LEVEL_HIGH;
+
+    /// The interrupt is triggered while the signal is held low.
+    pub const LEVEL_LOW: u32 = bindings::IRQ_TYPE_LEVEL_LOW;
+}
+
+/// Wraps the kernel's `struct irq_desc`.
+///
+/// # Invariants
+///
+/// The pointer `Descriptor::ptr` is non-null and valid.
+pub struct Descriptor {
+    pub(crate) ptr: *mut bindings::irq_desc,
+}
+
+impl Descriptor {
+    /// Constructs a new `struct irq_desc` wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the returned object.
+    unsafe fn from_ptr(ptr: *mut bindings::irq_desc) -> Self {
+        // INVARIANT: The safety requirements ensure the invariant.
+        Self { ptr }
+    }
+
+    /// Calls `chained_irq_enter` and returns a guard that calls `chained_irq_exit` once dropped.
+    ///
+    /// It is meant to be used by chained irq handlers to dispatch irqs to the next handlers.
+    pub fn enter_chained(&self) -> ChainedGuard<'_> {
+        // SAFETY: By the type invariants, `ptr` is always non-null and valid.
+        let irq_chip = unsafe { bindings::irq_desc_get_chip(self.ptr) };
+
+        // SAFETY: By the type invariants, `ptr` is always non-null and valid. `irq_chip` was just
+        // returned from `ptr`, so it is still valid too.
+        unsafe { bindings::chained_irq_enter(irq_chip, self.ptr) };
+        ChainedGuard {
+            desc: self,
+            irq_chip,
+        }
+    }
+}
+
+/// A guard to call `chained_irq_exit` after `chained_irq_enter` was called.
+///
+/// It is also used as evidence that a previous `chained_irq_enter` was called. So there are no
+/// public constructors and it is only created after indeed calling `chained_irq_enter`.
+pub struct ChainedGuard<'a> {
+    desc: &'a Descriptor,
+    irq_chip: *mut bindings::irq_chip,
+}
+
+impl Drop for ChainedGuard<'_> {
+    fn drop(&mut self) {
+        // SAFETY: The lifetime of `ChainedGuard` guarantees that `self.desc` remains valid, so it
+        // also guarantess `irq_chip` (which was returned from it) and `self.desc.ptr` (guaranteed
+        // by the type invariants).
+        unsafe { bindings::chained_irq_exit(self.irq_chip, self.desc.ptr) };
+    }
+}
+
+/// Wraps the kernel's `struct irq_domain`.
+///
+/// # Invariants
+///
+/// The pointer `Domain::ptr` is non-null and valid.
+pub struct Domain {
+    ptr: *mut bindings::irq_domain,
+}
+
+impl Domain {
+    /// Constructs a new `struct irq_domain` wrapper.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the returned object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::irq_domain) -> Self {
+        // INVARIANT: The safety requirements ensure the invariant.
+        Self { ptr }
+    }
+
+    /// Invokes the chained handler of the given hw irq of the given domain.
+    ///
+    /// It requires evidence that `chained_irq_enter` was called, which is done by passing a
+    /// `ChainedGuard` instance.
+    pub fn generic_handle_chained(&self, hwirq: u32, _guard: &ChainedGuard<'_>) {
+        // SAFETY: `ptr` is valid by the type invariants.
+        unsafe { bindings::generic_handle_domain_irq(self.ptr, hwirq) };
+    }
+}
+
+/// A high-level irq flow handler.
+pub trait FlowHandler {
+    /// The data associated with the handler.
+    type Data: PointerWrapper;
+
+    /// Implements the irq flow for the given descriptor.
+    fn handle_irq_flow(data: <Self::Data as PointerWrapper>::Borrowed<'_>, desc: &Descriptor);
+}
+
+/// Returns the raw irq flow handler corresponding to the (high-level) one defined in `T`.
+///
+/// # Safety
+///
+/// The caller must ensure that the value stored in the irq handler data (as returned by
+/// `irq_desc_get_handler_data`) is the result of calling [`PointerWrapper::into_pointer] for the
+/// [`T::Data`] type.
+pub(crate) unsafe fn new_flow_handler<T: FlowHandler>() -> bindings::irq_flow_handler_t {
+    Some(irq_flow_handler::<T>)
+}
+
+unsafe extern "C" fn irq_flow_handler<T: FlowHandler>(desc: *mut bindings::irq_desc) {
+    // SAFETY: By the safety requirements of `new_flow_handler`, we know that the value returned by
+    // `irq_desc_get_handler_data` comes from calling `T::Data::into_pointer`. `desc` is valid by
+    // the C API contract.
+    let data = unsafe { T::Data::borrow(bindings::irq_desc_get_handler_data(desc)) };
+
+    // SAFETY: The C API guarantees that `desc` is valid for the duration of this call, which
+    // outlives the lifetime returned by `from_desc`.
+    T::handle_irq_flow(data, &unsafe { Descriptor::from_ptr(desc) });
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
new file mode 100644
index 000000000000..269c552ecda0
--- /dev/null
+++ b/rust/kernel/lib.rs
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` crate.
+//!
+//! This crate contains the kernel APIs that have been ported or wrapped for
+//! usage by Rust code in the kernel and is shared by all of them.
+//!
+//! In other words, all the rest of the Rust code in the kernel (e.g. kernel
+//! modules written in Rust) depends on [`core`], [`alloc`] and this crate.
+//!
+//! If you need a kernel C API that is not ported or wrapped yet here, then
+//! do so first instead of bypassing this crate.
+
+#![no_std]
+#![feature(allocator_api)]
+#![feature(associated_type_defaults)]
+#![feature(concat_idents)]
+#![feature(const_fn_trait_bound)]
+#![feature(const_mut_refs)]
+#![feature(const_ptr_offset_from)]
+#![feature(const_refs_to_cell)]
+#![feature(const_trait_impl)]
+#![feature(doc_cfg)]
+#![feature(generic_associated_types)]
+#![feature(maybe_uninit_extra)]
+#![feature(ptr_metadata)]
+#![feature(receiver_trait)]
+#![feature(coerce_unsized)]
+#![feature(dispatch_from_dyn)]
+#![feature(unsize)]
+
+// Ensure conditional compilation based on the kernel configuration works;
+// otherwise we may silently break things like initcall handling.
+#[cfg(not(CONFIG_RUST))]
+compile_error!("Missing kernel configuration for conditional compilation");
+
+#[cfg(not(test))]
+#[cfg(not(testlib))]
+mod allocator;
+
+#[doc(hidden)]
+pub mod bindings;
+
+#[cfg(CONFIG_ARM_AMBA)]
+pub mod amba;
+pub mod c_types;
+pub mod chrdev;
+#[cfg(CONFIG_COMMON_CLK)]
+pub mod clk;
+pub mod cred;
+pub mod device;
+pub mod driver;
+pub mod error;
+pub mod file;
+pub mod gpio;
+pub mod hwrng;
+pub mod irq;
+pub mod miscdev;
+pub mod mm;
+pub mod pages;
+pub mod power;
+pub mod revocable;
+pub mod security;
+pub mod str;
+pub mod task;
+
+pub mod linked_list;
+mod raw_list;
+pub mod rbtree;
+
+#[doc(hidden)]
+pub mod module_param;
+
+mod build_assert;
+pub mod prelude;
+pub mod print;
+pub mod random;
+mod static_assert;
+#[doc(hidden)]
+pub mod std_vendor;
+pub mod sync;
+
+#[cfg(any(CONFIG_SYSCTL, doc))]
+#[doc(cfg(CONFIG_SYSCTL))]
+pub mod sysctl;
+
+pub mod io_buffer;
+pub mod io_mem;
+pub mod iov_iter;
+pub mod of;
+pub mod platform;
+mod types;
+pub mod user_ptr;
+
+#[doc(hidden)]
+pub use build_error::build_error;
+
+pub use crate::error::{to_result, Error, Result};
+pub use crate::types::{bit, bits_iter, Bool, False, Mode, Opaque, ScopeGuard, True};
+
+use core::marker::PhantomData;
+
+/// Page size defined in terms of the `PAGE_SHIFT` macro from C.
+///
+/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
+pub const PAGE_SIZE: usize = 1 << bindings::PAGE_SHIFT;
+
+/// Prefix to appear before log messages printed from within the kernel crate.
+const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
+
+/// The top level entrypoint to implementing a kernel module.
+///
+/// For any teardown or cleanup operations, your type may implement [`Drop`].
+pub trait KernelModule: Sized + Sync {
+    /// Called at module initialization time.
+    ///
+    /// Use this method to perform whatever setup or registration your module
+    /// should do.
+    ///
+    /// Equivalent to the `module_init` macro in the C API.
+    fn init(name: &'static str::CStr, module: &'static ThisModule) -> Result<Self>;
+}
+
+/// Equivalent to `THIS_MODULE` in the C API.
+///
+/// C header: `include/linux/export.h`
+pub struct ThisModule(*mut bindings::module);
+
+// SAFETY: `THIS_MODULE` may be used from all threads within a module.
+unsafe impl Sync for ThisModule {}
+
+impl ThisModule {
+    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be equal to the right `THIS_MODULE`.
+    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
+        ThisModule(ptr)
+    }
+
+    /// Locks the module parameters to access them.
+    ///
+    /// Returns a [`KParamGuard`] that will release the lock when dropped.
+    pub fn kernel_param_lock(&self) -> KParamGuard<'_> {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case.
+        #[cfg(CONFIG_SYSFS)]
+        unsafe {
+            bindings::kernel_param_lock(self.0)
+        }
+
+        KParamGuard {
+            #[cfg(CONFIG_SYSFS)]
+            this_module: self,
+            phantom: PhantomData,
+        }
+    }
+}
+
+/// Scoped lock on the kernel parameters of [`ThisModule`].
+///
+/// Lock will be released when this struct is dropped.
+pub struct KParamGuard<'a> {
+    #[cfg(CONFIG_SYSFS)]
+    this_module: &'a ThisModule,
+    phantom: PhantomData<&'a ()>,
+}
+
+#[cfg(CONFIG_SYSFS)]
+impl<'a> Drop for KParamGuard<'a> {
+    fn drop(&mut self) {
+        // SAFETY: `kernel_param_lock` will check if the pointer is null and
+        // use the built-in mutex in that case. The existance of `self`
+        // guarantees that the lock is held.
+        unsafe { bindings::kernel_param_unlock(self.this_module.0) }
+    }
+}
+
+/// Calculates the offset of a field from the beginning of the struct it belongs to.
+///
+/// # Example
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::offset_of;
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     // This prints `8`.
+///     pr_info!("{}\n", offset_of!(Test, b));
+/// }
+/// ```
+#[macro_export]
+macro_rules! offset_of {
+    ($type:ty, $($f:tt)*) => {{
+        let tmp = core::mem::MaybeUninit::<$type>::uninit();
+        let outer = tmp.as_ptr();
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The pointer is valid and aligned, just not initialised; `addr_of` ensures that
+        // we don't actually read from `outer` (which would be UB) nor create an intermediate
+        // reference.
+        let inner = unsafe { core::ptr::addr_of!((*outer).$($f)*) } as *const u8;
+        // To avoid warnings when nesting `unsafe` blocks.
+        #[allow(unused_unsafe)]
+        // SAFETY: The two pointers are within the same allocation block.
+        unsafe { inner.offset_from(outer as *const u8) }
+    }}
+}
+
+/// Produces a pointer to an object from a pointer to one of its fields.
+///
+/// # Safety
+///
+/// Callers must ensure that the pointer to the field is in fact a pointer to the specified field,
+/// as opposed to a pointer to another object of the same type. If this condition is not met,
+/// any dereference of the resulting pointer is UB.
+///
+/// # Example
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::container_of;
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// fn test() {
+///     let test = Test { a: 10, b: 20 };
+///     let b_ptr = &test.b;
+///     let test_alias = container_of!(b_ptr, Test, b);
+///     // This prints `true`.
+///     pr_info!("{}\n", core::ptr::eq(&test, test_alias));
+/// }
+/// ```
+#[macro_export]
+macro_rules! container_of {
+    ($ptr:expr, $type:ty, $($f:tt)*) => {{
+        let ptr = $ptr as *const _ as *const u8;
+        let offset = $crate::offset_of!($type, $($f)*);
+        ptr.wrapping_offset(-offset) as *const $type
+    }}
+}
+
+#[cfg(not(any(testlib, test)))]
+#[panic_handler]
+fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
+    pr_emerg!("{}\n", info);
+    // SAFETY: FFI call.
+    unsafe { bindings::BUG() };
+    // Bindgen currently does not recognize `__noreturn` so `BUG` returns `()`
+    // instead of `!`.
+    // https://github.com/rust-lang/rust-bindgen/issues/2094
+    loop {}
+}
diff --git a/rust/kernel/linked_list.rs b/rust/kernel/linked_list.rs
new file mode 100644
index 000000000000..3330edcc7ca8
--- /dev/null
+++ b/rust/kernel/linked_list.rs
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linked lists.
+//!
+//! TODO: This module is a work in progress.
+
+use alloc::boxed::Box;
+use core::ptr::NonNull;
+
+pub use crate::raw_list::{Cursor, GetLinks, Links};
+use crate::{raw_list, raw_list::RawList, sync::Ref};
+
+// TODO: Use the one from `kernel::file_operations::PointerWrapper` instead.
+/// Wraps an object to be inserted in a linked list.
+pub trait Wrapper<T: ?Sized> {
+    /// Converts the wrapped object into a pointer that represents it.
+    fn into_pointer(self) -> NonNull<T>;
+
+    /// Converts the object back from the pointer representation.
+    ///
+    /// # Safety
+    ///
+    /// The passed pointer must come from a previous call to [`Wrapper::into_pointer()`].
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self;
+
+    /// Returns a reference to the wrapped object.
+    fn as_ref(&self) -> &T;
+}
+
+impl<T: ?Sized> Wrapper<T> for Box<T> {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::new(Box::into_raw(self)).unwrap()
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        unsafe { Box::from_raw(ptr.as_ptr()) }
+    }
+
+    fn as_ref(&self) -> &T {
+        AsRef::as_ref(self)
+    }
+}
+
+impl<T: ?Sized> Wrapper<T> for Ref<T> {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::new(Ref::into_raw(self) as _).unwrap()
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        // SAFETY: The safety requirements of `from_pointer` satisfy the ones from `Ref::from_raw`.
+        unsafe { Ref::from_raw(ptr.as_ptr() as _) }
+    }
+
+    fn as_ref(&self) -> &T {
+        AsRef::as_ref(self)
+    }
+}
+
+impl<T: ?Sized> Wrapper<T> for &T {
+    fn into_pointer(self) -> NonNull<T> {
+        NonNull::from(self)
+    }
+
+    unsafe fn from_pointer(ptr: NonNull<T>) -> Self {
+        unsafe { &*ptr.as_ptr() }
+    }
+
+    fn as_ref(&self) -> &T {
+        self
+    }
+}
+
+/// A descriptor of wrapped list elements.
+pub trait GetLinksWrapped: GetLinks {
+    /// Specifies which wrapper (e.g., `Box` and `Arc`) wraps the list entries.
+    type Wrapped: Wrapper<Self::EntryType>;
+}
+
+impl<T: ?Sized> GetLinksWrapped for Box<T>
+where
+    Box<T>: GetLinks,
+{
+    type Wrapped = Box<<Box<T> as GetLinks>::EntryType>;
+}
+
+impl<T: GetLinks + ?Sized> GetLinks for Box<T> {
+    type EntryType = T::EntryType;
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        <T as GetLinks>::get_links(data)
+    }
+}
+
+impl<T: ?Sized> GetLinksWrapped for Ref<T>
+where
+    Ref<T>: GetLinks,
+{
+    type Wrapped = Ref<<Ref<T> as GetLinks>::EntryType>;
+}
+
+impl<T: GetLinks + ?Sized> GetLinks for Ref<T> {
+    type EntryType = T::EntryType;
+
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        <T as GetLinks>::get_links(data)
+    }
+}
+
+/// A linked list.
+///
+/// Elements in the list are wrapped and ownership is transferred to the list while the element is
+/// in the list.
+pub struct List<G: GetLinksWrapped> {
+    list: RawList<G>,
+}
+
+impl<G: GetLinksWrapped> List<G> {
+    /// Constructs a new empty linked list.
+    pub fn new() -> Self {
+        Self {
+            list: RawList::new(),
+        }
+    }
+
+    /// Returns whether the list is empty.
+    pub fn is_empty(&self) -> bool {
+        self.list.is_empty()
+    }
+
+    /// Adds the given object to the end (back) of the list.
+    ///
+    /// It is dropped if it's already on this (or another) list; this can happen for
+    /// reference-counted objects, so dropping means decrementing the reference count.
+    pub fn push_back(&mut self, data: G::Wrapped) {
+        let ptr = data.into_pointer();
+
+        // SAFETY: We took ownership of the entry, so it is safe to insert it.
+        if !unsafe { self.list.push_back(ptr.as_ref()) } {
+            // If insertion failed, rebuild object so that it can be freed.
+            // SAFETY: We just called `into_pointer` above.
+            unsafe { G::Wrapped::from_pointer(ptr) };
+        }
+    }
+
+    /// Inserts the given object after `existing`.
+    ///
+    /// It is dropped if it's already on this (or another) list; this can happen for
+    /// reference-counted objects, so dropping means decrementing the reference count.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `existing` points to a valid entry that is on the list.
+    pub unsafe fn insert_after(&mut self, existing: NonNull<G::EntryType>, data: G::Wrapped) {
+        let ptr = data.into_pointer();
+        let entry = unsafe { &*existing.as_ptr() };
+        if unsafe { !self.list.insert_after(entry, ptr.as_ref()) } {
+            // If insertion failed, rebuild object so that it can be freed.
+            unsafe { G::Wrapped::from_pointer(ptr) };
+        }
+    }
+
+    /// Removes the given entry.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `data` is either on this list or in no list. It being on another
+    /// list leads to memory unsafety.
+    pub unsafe fn remove(&mut self, data: &G::Wrapped) -> Option<G::Wrapped> {
+        let entry_ref = Wrapper::as_ref(data);
+        if unsafe { self.list.remove(entry_ref) } {
+            Some(unsafe { G::Wrapped::from_pointer(NonNull::from(entry_ref)) })
+        } else {
+            None
+        }
+    }
+
+    /// Removes the element currently at the front of the list and returns it.
+    ///
+    /// Returns `None` if the list is empty.
+    pub fn pop_front(&mut self) -> Option<G::Wrapped> {
+        let front = self.list.pop_front()?;
+        // SAFETY: Elements on the list were inserted after a call to `into_pointer `.
+        Some(unsafe { G::Wrapped::from_pointer(front) })
+    }
+
+    /// Returns a cursor starting on the first (front) element of the list.
+    pub fn cursor_front(&self) -> Cursor<'_, G> {
+        self.list.cursor_front()
+    }
+
+    /// Returns a mutable cursor starting on the first (front) element of the list.
+    pub fn cursor_front_mut(&mut self) -> CursorMut<'_, G> {
+        CursorMut::new(self.list.cursor_front_mut())
+    }
+}
+
+impl<G: GetLinksWrapped> Default for List<G> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<G: GetLinksWrapped> Drop for List<G> {
+    fn drop(&mut self) {
+        while self.pop_front().is_some() {}
+    }
+}
+
+/// A list cursor that allows traversing a linked list and inspecting & mutating elements.
+pub struct CursorMut<'a, G: GetLinksWrapped> {
+    cursor: raw_list::CursorMut<'a, G>,
+}
+
+impl<'a, G: GetLinksWrapped> CursorMut<'a, G> {
+    fn new(cursor: raw_list::CursorMut<'a, G>) -> Self {
+        Self { cursor }
+    }
+
+    /// Returns the element the cursor is currently positioned on.
+    pub fn current(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.current()
+    }
+
+    /// Removes the element the cursor is currently positioned on.
+    ///
+    /// After removal, it advances the cursor to the next element.
+    pub fn remove_current(&mut self) -> Option<G::Wrapped> {
+        let ptr = self.cursor.remove_current()?;
+
+        // SAFETY: Elements on the list were inserted after a call to `into_pointer `.
+        Some(unsafe { G::Wrapped::from_pointer(ptr) })
+    }
+
+    /// Returns the element immediately after the one the cursor is positioned on.
+    pub fn peek_next(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.peek_next()
+    }
+
+    /// Returns the element immediately before the one the cursor is positioned on.
+    pub fn peek_prev(&mut self) -> Option<&mut G::EntryType> {
+        self.cursor.peek_prev()
+    }
+
+    /// Moves the cursor to the next element.
+    pub fn move_next(&mut self) {
+        self.cursor.move_next();
+    }
+}
diff --git a/rust/kernel/miscdev.rs b/rust/kernel/miscdev.rs
new file mode 100644
index 000000000000..e1a2401031cf
--- /dev/null
+++ b/rust/kernel/miscdev.rs
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Miscellaneous devices.
+//!
+//! C header: [`include/linux/miscdevice.h`](../../../../include/linux/miscdevice.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
+
+use crate::bindings;
+use crate::error::{code::*, Error, Result};
+use crate::file;
+use crate::{device, str::CStr, str::CString, KernelModule, ThisModule};
+use alloc::boxed::Box;
+use core::marker::PhantomPinned;
+use core::{fmt, mem::MaybeUninit, pin::Pin};
+
+/// Options which can be used to configure how a misc device is registered.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{c_str, device::RawDevice, file, miscdev, prelude::*};
+/// pub fn example(
+///     reg: Pin<&mut miscdev::Registration<impl file::Operations<OpenData = ()>>>,
+///     parent: &dyn RawDevice,
+/// ) -> Result {
+///     miscdev::Options::new()
+///         .mode(0o600)
+///         .minor(10)
+///         .parent(parent)
+///         .register(reg, fmt!("sample"), ())
+/// }
+/// ```
+#[derive(Default)]
+pub struct Options<'a> {
+    minor: Option<i32>,
+    mode: Option<u16>,
+    parent: Option<&'a dyn device::RawDevice>,
+}
+
+impl<'a> Options<'a> {
+    /// Creates new [`Options`] instance with the required fields.
+    pub const fn new() -> Self {
+        Self {
+            minor: None,
+            mode: None,
+            parent: None,
+        }
+    }
+
+    /// Sets the minor device number.
+    pub const fn minor(&mut self, v: i32) -> &mut Self {
+        self.minor = Some(v);
+        self
+    }
+
+    /// Sets the device mode.
+    ///
+    /// This is usually an octal number and describes who can perform read/write/execute operations
+    /// on the device.
+    pub const fn mode(&mut self, m: u16) -> &mut Self {
+        self.mode = Some(m);
+        self
+    }
+
+    /// Sets the device parent.
+    pub const fn parent(&mut self, p: &'a dyn device::RawDevice) -> &mut Self {
+        self.parent = Some(p);
+        self
+    }
+
+    /// Registers a misc device using the configured options.
+    pub fn register<T: file::Operations>(
+        &self,
+        reg: Pin<&mut Registration<T>>,
+        name: fmt::Arguments<'_>,
+        open_data: T::OpenData,
+    ) -> Result {
+        reg.register_with_options(name, open_data, self)
+    }
+
+    /// Allocates a new registration of a misc device and completes the registration with the
+    /// configured options.
+    pub fn register_new<T: file::Operations>(
+        &self,
+        name: fmt::Arguments<'_>,
+        open_data: T::OpenData,
+    ) -> Result<Pin<Box<Registration<T>>>> {
+        let mut r = Pin::from(Box::try_new(Registration::new())?);
+        self.register(r.as_mut(), name, open_data)?;
+        Ok(r)
+    }
+}
+
+/// A registration of a miscellaneous device.
+///
+/// # Invariants
+///
+/// `Context` is always initialised when `registered` is `true`, and not initialised otherwise.
+pub struct Registration<T: file::Operations> {
+    registered: bool,
+    mdev: bindings::miscdevice,
+    name: Option<CString>,
+    _pin: PhantomPinned,
+
+    /// Context initialised on construction and made available to all file instances on
+    /// [`file::Operations::open`].
+    open_data: MaybeUninit<T::OpenData>,
+}
+
+impl<T: file::Operations> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new() -> Self {
+        // INVARIANT: `registered` is `false` and `open_data` is not initialised.
+        Self {
+            registered: false,
+            mdev: bindings::miscdevice::default(),
+            name: None,
+            _pin: PhantomPinned,
+            open_data: MaybeUninit::uninit(),
+        }
+    }
+
+    /// Registers a miscellaneous device.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned(name: fmt::Arguments<'_>, open_data: T::OpenData) -> Result<Pin<Box<Self>>> {
+        Options::new().register_new(name, open_data)
+    }
+
+    /// Registers a miscellaneous device with the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: fmt::Arguments<'_>,
+        open_data: T::OpenData,
+    ) -> Result {
+        Options::new().register(self, name, open_data)
+    }
+
+    /// Registers a miscellaneous device with the rest of the kernel. Additional optional settings
+    /// are provided via the `opts` parameter.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential.
+    pub fn register_with_options(
+        self: Pin<&mut Self>,
+        name: fmt::Arguments<'_>,
+        open_data: T::OpenData,
+        opts: &Options<'_>,
+    ) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        let name = CString::try_from_fmt(name)?;
+
+        // SAFETY: The adapter is compatible with `misc_register`.
+        this.mdev.fops = unsafe { file::OperationsVtable::<Self, T>::build() };
+        this.mdev.name = name.as_char_ptr();
+        this.mdev.minor = opts.minor.unwrap_or(bindings::MISC_DYNAMIC_MINOR as i32);
+        this.mdev.mode = opts.mode.unwrap_or(0);
+        this.mdev.parent = opts
+            .parent
+            .map_or(core::ptr::null_mut(), |p| p.raw_device());
+
+        // We write to `open_data` here because as soon as `misc_register` succeeds, the file can be
+        // opened, so we need `open_data` configured ahead of time.
+        //
+        // INVARIANT: `registered` is set to `true`, but `open_data` is also initialised.
+        this.registered = true;
+        this.open_data.write(open_data);
+
+        let ret = unsafe { bindings::misc_register(&mut this.mdev) };
+        if ret < 0 {
+            // INVARIANT: `registered` is set back to `false` and the `open_data` is destructued.
+            this.registered = false;
+            // SAFETY: `open_data` was initialised a few lines above.
+            unsafe { this.open_data.assume_init_drop() };
+            return Err(Error::from_kernel_errno(ret));
+        }
+
+        this.name = Some(name);
+
+        Ok(())
+    }
+}
+
+impl<T: file::Operations> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: file::Operations> file::OpenAdapter<T::OpenData> for Registration<T> {
+    unsafe fn convert(
+        _inode: *mut bindings::inode,
+        file: *mut bindings::file,
+    ) -> *const T::OpenData {
+        // SAFETY: The caller must guarantee that `file` is valid.
+        let reg = crate::container_of!(unsafe { (*file).private_data }, Self, mdev);
+
+        // SAFETY: This function is only called while the misc device is still registered, so the
+        // registration must be valid. Additionally, the type invariants guarantee that while the
+        // miscdev is registered, `open_data` is initialised.
+        unsafe { (*reg).open_data.as_ptr() }
+    }
+}
+
+// SAFETY: The only method is `register()`, which requires a (pinned) mutable `Registration`, so it
+// is safe to pass `&Registration` to multiple threads because it offers no interior mutability.
+unsafe impl<T: file::Operations> Sync for Registration<T> {}
+
+// SAFETY: All functions work from any thread. So as long as the `Registration::open_data` is
+// `Send`, so is `Registration<T>`.
+unsafe impl<T: file::Operations> Send for Registration<T> where T::OpenData: Send {}
+
+impl<T: file::Operations> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        if self.registered {
+            // SAFETY: `registered` being `true` indicates that a previous call to  `misc_register`
+            // succeeded.
+            unsafe { bindings::misc_deregister(&mut self.mdev) };
+
+            // SAFETY: The type invariant guarantees that `open_data` is initialised when
+            // `registered` is `true`.
+            unsafe { self.open_data.assume_init_drop() };
+        }
+    }
+}
+
+/// Kernel module that exposes a single miscdev device implemented by `T`.
+pub struct Module<T: file::Operations<OpenData = ()>> {
+    _dev: Pin<Box<Registration<T>>>,
+}
+
+impl<T: file::Operations<OpenData = ()>> KernelModule for Module<T> {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        Ok(Self {
+            _dev: Registration::new_pinned(crate::fmt!("{name}"), ())?,
+        })
+    }
+}
+
+/// Declares a kernel module that exposes a single misc device.
+///
+/// The `type` argument should be a type which implements the [`FileOpener`] trait. Also accepts
+/// various forms of kernel metadata.
+///
+/// C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+///
+/// [`FileOpener`]: ../kernel/file_operations/trait.FileOpener.html
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::prelude::*;
+///
+/// module_misc_device! {
+///     type: MyFile,
+///     name: b"my_miscdev_kernel_module",
+///     author: b"Rust for Linux Contributors",
+///     description: b"My very own misc device kernel module!",
+///     license: b"GPL v2",
+/// }
+///
+/// #[derive(Default)]
+/// struct MyFile;
+///
+/// impl kernel::file::Operations for MyFile {
+///     kernel::declare_file_operations!();
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_misc_device {
+    (type: $type:ty, $($f:tt)*) => {
+        type ModuleType = kernel::miscdev::Module<$type>;
+        module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..322f94f501e0
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory management.
+//!
+//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
+
+use crate::{bindings, pages, to_result, Result};
+
+/// Virtual memory.
+pub mod virt {
+    use super::*;
+
+    /// A wrapper for the kernel's `struct vm_area_struct`.
+    ///
+    /// It represents an area of virtual memory.
+    ///
+    /// # Invariants
+    ///
+    /// `vma` is always non-null and valid.
+    pub struct Area {
+        vma: *mut bindings::vm_area_struct,
+    }
+
+    impl Area {
+        /// Creates a new instance of a virtual memory area.
+        ///
+        /// # Safety
+        ///
+        /// Callers must ensure that `vma` is non-null and valid for the duration of the new area's
+        /// lifetime.
+        pub(crate) unsafe fn from_ptr(vma: *mut bindings::vm_area_struct) -> Self {
+            // INVARIANTS: The safety requirements guarantee the invariants.
+            Self { vma }
+        }
+
+        /// Returns the flags associated with the virtual memory area.
+        ///
+        /// The possible flags are a combination of the constants in [`flags`].
+        pub fn flags(&self) -> usize {
+            // SAFETY: `self.vma` is valid by the type invariants.
+            unsafe { (*self.vma).vm_flags as _ }
+        }
+
+        /// Sets the flags associated with the virtual memory area.
+        ///
+        /// The possible flags are a combination of the constants in [`flags`].
+        pub fn set_flags(&mut self, flags: usize) {
+            // SAFETY: `self.vma` is valid by the type invariants.
+            unsafe { (*self.vma).vm_flags = flags as _ };
+        }
+
+        /// Returns the start address of the virtual memory area.
+        pub fn start(&self) -> usize {
+            // SAFETY: `self.vma` is valid by the type invariants.
+            unsafe { (*self.vma).vm_start as _ }
+        }
+
+        /// Returns the end address of the virtual memory area.
+        pub fn end(&self) -> usize {
+            // SAFETY: `self.vma` is valid by the type invariants.
+            unsafe { (*self.vma).vm_end as _ }
+        }
+
+        /// Maps a single page at the given address within the virtual memory area.
+        pub fn insert_page(&mut self, address: usize, page: &pages::Pages<0>) -> Result {
+            // SAFETY: The page is guaranteed to be order 0 by the type system. The range of
+            // `address` is already checked by `vm_insert_page`. `self.vma` and `page.pages` are
+            // guaranteed by their repective type invariants to be valid.
+            to_result(|| unsafe { bindings::vm_insert_page(self.vma, address as _, page.pages) })
+        }
+    }
+
+    /// Container for [`Area`] flags.
+    pub mod flags {
+        use crate::bindings;
+
+        /// No flags are set.
+        pub const NONE: usize = bindings::VM_NONE as _;
+
+        /// Mapping allows reads.
+        pub const READ: usize = bindings::VM_READ as _;
+
+        /// Mapping allows writes.
+        pub const WRITE: usize = bindings::VM_WRITE as _;
+
+        /// Mapping allows execution.
+        pub const EXEC: usize = bindings::VM_EXEC as _;
+
+        /// Mapping is shared.
+        pub const SHARED: usize = bindings::VM_SHARED as _;
+
+        /// Mapping may be updated to allow reads.
+        pub const MAYREAD: usize = bindings::VM_MAYREAD as _;
+
+        /// Mapping may be updated to allow writes.
+        pub const MAYWRITE: usize = bindings::VM_MAYWRITE as _;
+
+        /// Mapping may be updated to allow execution.
+        pub const MAYEXEC: usize = bindings::VM_MAYEXEC as _;
+
+        /// Mapping may be updated to be shared.
+        pub const MAYSHARE: usize = bindings::VM_MAYSHARE as _;
+
+        /// Do not copy this vma on fork.
+        pub const DONTCOPY: usize = bindings::VM_DONTCOPY as _;
+
+        /// Cannot expand with mremap().
+        pub const DONTEXPAND: usize = bindings::VM_DONTEXPAND as _;
+
+        /// Lock the pages covered when they are faulted in.
+        pub const LOCKONFAULT: usize = bindings::VM_LOCKONFAULT as _;
+
+        /// Is a VM accounted object.
+        pub const ACCOUNT: usize = bindings::VM_ACCOUNT as _;
+
+        /// should the VM suppress accounting.
+        pub const NORESERVE: usize = bindings::VM_NORESERVE as _;
+
+        /// Huge TLB Page VM.
+        pub const HUGETLB: usize = bindings::VM_HUGETLB as _;
+
+        /// Synchronous page faults.
+        pub const SYNC: usize = bindings::VM_SYNC as _;
+
+        /// Architecture-specific flag.
+        pub const ARCH_1: usize = bindings::VM_ARCH_1 as _;
+
+        /// Wipe VMA contents in child..
+        pub const WIPEONFORK: usize = bindings::VM_WIPEONFORK as _;
+
+        /// Do not include in the core dump.
+        pub const DONTDUMP: usize = bindings::VM_DONTDUMP as _;
+
+        /// Not soft dirty clean area.
+        pub const SOFTDIRTY: usize = bindings::VM_SOFTDIRTY as _;
+
+        /// Can contain "struct page" and pure PFN pages.
+        pub const MIXEDMAP: usize = bindings::VM_MIXEDMAP as _;
+
+        /// MADV_HUGEPAGE marked this vma.
+        pub const HUGEPAGE: usize = bindings::VM_HUGEPAGE as _;
+
+        /// MADV_NOHUGEPAGE marked this vma.
+        pub const NOHUGEPAGE: usize = bindings::VM_NOHUGEPAGE as _;
+
+        /// KSM may merge identical pages.
+        pub const MERGEABLE: usize = bindings::VM_MERGEABLE as _;
+    }
+}
diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
new file mode 100644
index 000000000000..5065dffa817e
--- /dev/null
+++ b/rust/kernel/module_param.rs
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for module parameters.
+//!
+//! C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+
+use crate::error::{code::*, from_kernel_result};
+use crate::str::{CStr, Formatter};
+use core::fmt::Write;
+
+/// Types that can be used for module parameters.
+///
+/// Note that displaying the type in `sysfs` will fail if
+/// [`alloc::string::ToString::to_string`] (as implemented through the
+/// [`core::fmt::Display`] trait) writes more than [`PAGE_SIZE`]
+/// bytes (including an additional null terminator).
+///
+/// [`PAGE_SIZE`]: `crate::PAGE_SIZE`
+pub trait ModuleParam: core::fmt::Display + core::marker::Sized {
+    /// The `ModuleParam` will be used by the kernel module through this type.
+    ///
+    /// This may differ from `Self` if, for example, `Self` needs to track
+    /// ownership without exposing it or allocate extra space for other possible
+    /// parameter values. See [`StringParam`] or [`ArrayParam`] for examples.
+    type Value: ?Sized;
+
+    /// Whether the parameter is allowed to be set without an argument.
+    ///
+    /// Setting this to `true` allows the parameter to be passed without an
+    /// argument (e.g. just `module.param` instead of `module.param=foo`).
+    const NOARG_ALLOWED: bool;
+
+    /// Convert a parameter argument into the parameter value.
+    ///
+    /// `None` should be returned when parsing of the argument fails.
+    /// `arg == None` indicates that the parameter was passed without an
+    /// argument. If `NOARG_ALLOWED` is set to `false` then `arg` is guaranteed
+    /// to always be `Some(_)`.
+    ///
+    /// Parameters passed at boot time will be set before [`kmalloc`] is
+    /// available (even if the module is loaded at a later time). However, in
+    /// this case, the argument buffer will be valid for the entire lifetime of
+    /// the kernel. So implementations of this method which need to allocate
+    /// should first check that the allocator is available (with
+    /// [`crate::bindings::slab_is_available`]) and when it is not available
+    /// provide an alternative implementation which doesn't allocate. In cases
+    /// where the allocator is not available it is safe to save references to
+    /// `arg` in `Self`, but in other cases a copy should be made.
+    ///
+    /// [`kmalloc`]: ../../../include/linux/slab.h
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self>;
+
+    /// Get the current value of the parameter for use in the kernel module.
+    ///
+    /// This function should not be used directly. Instead use the wrapper
+    /// `read` which will be generated by [`macros::module`].
+    fn value(&self) -> &Self::Value;
+
+    /// Set the module parameter from a string.
+    ///
+    /// Used to set the parameter value when loading the module or when set
+    /// through `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// If `val` is non-null then it must point to a valid null-terminated
+    /// string. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn set_param(
+        val: *const crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        let arg = if val.is_null() {
+            None
+        } else {
+            Some(unsafe { CStr::from_char_ptr(val).as_bytes() })
+        };
+        match Self::try_from_param_arg(arg) {
+            Some(new_value) => {
+                let old_value = unsafe { (*param).__bindgen_anon_1.arg as *mut Self };
+                let _ = unsafe { core::ptr::replace(old_value, new_value) };
+                0
+            }
+            None => EINVAL.to_kernel_errno(),
+        }
+    }
+
+    /// Write a string representation of the current parameter value to `buf`.
+    ///
+    /// Used for displaying the current parameter value in `sysfs`.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must be a buffer of length at least `kernel::PAGE_SIZE` that is
+    /// writeable. The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn get_param(
+        buf: *mut crate::c_types::c_char,
+        param: *const crate::bindings::kernel_param,
+    ) -> crate::c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: The C contracts guarantees that the buffer is at least `PAGE_SIZE` bytes.
+            let mut f = unsafe { Formatter::from_buffer(buf.cast(), crate::PAGE_SIZE) };
+            unsafe { write!(f, "{}\0", *((*param).__bindgen_anon_1.arg as *mut Self)) }?;
+            Ok(f.bytes_written().try_into()?)
+        }
+    }
+
+    /// Drop the parameter.
+    ///
+    /// Called when unloading a module.
+    ///
+    /// # Safety
+    ///
+    /// The `arg` field of `param` must be an instance of `Self`.
+    unsafe extern "C" fn free(arg: *mut crate::c_types::c_void) {
+        unsafe { core::ptr::drop_in_place(arg as *mut Self) };
+    }
+}
+
+/// Trait for parsing integers.
+///
+/// Strings begining with `0x`, `0o`, or `0b` are parsed as hex, octal, or
+/// binary respectively. Strings beginning with `0` otherwise are parsed as
+/// octal. Anything else is parsed as decimal. A leading `+` or `-` is also
+/// permitted. Any string parsed by [`kstrtol()`] or [`kstrtoul()`] will be
+/// successfully parsed.
+///
+/// [`kstrtol()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtol
+/// [`kstrtoul()`]: https://www.kernel.org/doc/html/latest/core-api/kernel-api.html#c.kstrtoul
+trait ParseInt: Sized {
+    fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError>;
+    fn checked_neg(self) -> Option<Self>;
+
+    fn from_str_unsigned(src: &str) -> Result<Self, core::num::ParseIntError> {
+        let (radix, digits) = if let Some(n) = src.strip_prefix("0x") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0X") {
+            (16, n)
+        } else if let Some(n) = src.strip_prefix("0o") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0O") {
+            (8, n)
+        } else if let Some(n) = src.strip_prefix("0b") {
+            (2, n)
+        } else if let Some(n) = src.strip_prefix("0B") {
+            (2, n)
+        } else if src.starts_with('0') {
+            (8, src)
+        } else {
+            (10, src)
+        };
+        Self::from_str_radix(digits, radix)
+    }
+
+    fn from_str(src: &str) -> Option<Self> {
+        match src.bytes().next() {
+            None => None,
+            Some(b'-') => Self::from_str_unsigned(&src[1..]).ok()?.checked_neg(),
+            Some(b'+') => Some(Self::from_str_unsigned(&src[1..]).ok()?),
+            Some(_) => Some(Self::from_str_unsigned(src).ok()?),
+        }
+    }
+}
+
+macro_rules! impl_parse_int {
+    ($ty:ident) => {
+        impl ParseInt for $ty {
+            fn from_str_radix(src: &str, radix: u32) -> Result<Self, core::num::ParseIntError> {
+                $ty::from_str_radix(src, radix)
+            }
+
+            fn checked_neg(self) -> Option<Self> {
+                self.checked_neg()
+            }
+        }
+    };
+}
+
+impl_parse_int!(i8);
+impl_parse_int!(u8);
+impl_parse_int!(i16);
+impl_parse_int!(u16);
+impl_parse_int!(i32);
+impl_parse_int!(u32);
+impl_parse_int!(i64);
+impl_parse_int!(u64);
+impl_parse_int!(isize);
+impl_parse_int!(usize);
+
+macro_rules! impl_module_param {
+    ($ty:ident) => {
+        impl ModuleParam for $ty {
+            type Value = $ty;
+
+            const NOARG_ALLOWED: bool = false;
+
+            fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+                let bytes = arg?;
+                let utf8 = core::str::from_utf8(bytes).ok()?;
+                <$ty as crate::module_param::ParseInt>::from_str(utf8)
+            }
+
+            fn value(&self) -> &Self::Value {
+                self
+            }
+        }
+    };
+}
+
+#[doc(hidden)]
+#[macro_export]
+/// Generate a static [`kernel_param_ops`](../../../include/linux/moduleparam.h) struct.
+///
+/// # Example
+/// ```ignore
+/// make_param_ops!(
+///     /// Documentation for new param ops.
+///     PARAM_OPS_MYTYPE, // Name for the static.
+///     MyType // A type which implements [`ModuleParam`].
+/// );
+/// ```
+macro_rules! make_param_ops {
+    ($ops:ident, $ty:ty) => {
+        $crate::make_param_ops!(
+            #[doc=""]
+            $ops,
+            $ty
+        );
+    };
+    ($(#[$meta:meta])* $ops:ident, $ty:ty) => {
+        $(#[$meta])*
+        ///
+        /// Static [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+        /// struct generated by [`make_param_ops`].
+        pub static $ops: $crate::bindings::kernel_param_ops = $crate::bindings::kernel_param_ops {
+            flags: if <$ty as $crate::module_param::ModuleParam>::NOARG_ALLOWED {
+                $crate::bindings::KERNEL_PARAM_OPS_FL_NOARG
+            } else {
+                0
+            },
+            set: Some(<$ty as $crate::module_param::ModuleParam>::set_param),
+            get: Some(<$ty as $crate::module_param::ModuleParam>::get_param),
+            free: Some(<$ty as $crate::module_param::ModuleParam>::free),
+        };
+    };
+}
+
+impl_module_param!(i8);
+impl_module_param!(u8);
+impl_module_param!(i16);
+impl_module_param!(u16);
+impl_module_param!(i32);
+impl_module_param!(u32);
+impl_module_param!(i64);
+impl_module_param!(u64);
+impl_module_param!(isize);
+impl_module_param!(usize);
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i8`].
+    PARAM_OPS_I8,
+    i8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u8`].
+    PARAM_OPS_U8,
+    u8
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i16`].
+    PARAM_OPS_I16,
+    i16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u16`].
+    PARAM_OPS_U16,
+    u16
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i32`].
+    PARAM_OPS_I32,
+    i32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u32`].
+    PARAM_OPS_U32,
+    u32
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`i64`].
+    PARAM_OPS_I64,
+    i64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`u64`].
+    PARAM_OPS_U64,
+    u64
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`isize`].
+    PARAM_OPS_ISIZE,
+    isize
+);
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`usize`].
+    PARAM_OPS_USIZE,
+    usize
+);
+
+impl ModuleParam for bool {
+    type Value = bool;
+
+    const NOARG_ALLOWED: bool = true;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        match arg {
+            None => Some(true),
+            Some(b"y") | Some(b"Y") | Some(b"1") | Some(b"true") => Some(true),
+            Some(b"n") | Some(b"N") | Some(b"0") | Some(b"false") => Some(false),
+            _ => None,
+        }
+    }
+
+    fn value(&self) -> &Self::Value {
+        self
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`bool`].
+    PARAM_OPS_BOOL,
+    bool
+);
+
+/// An array of at __most__ `N` values.
+///
+/// # Invariant
+///
+/// The first `self.used` elements of `self.values` are initialized.
+pub struct ArrayParam<T, const N: usize> {
+    values: [core::mem::MaybeUninit<T>; N],
+    used: usize,
+}
+
+impl<T, const N: usize> ArrayParam<T, { N }> {
+    fn values(&self) -> &[T] {
+        // SAFETY: The invariant maintained by `ArrayParam` allows us to cast
+        // the first `self.used` elements to `T`.
+        unsafe {
+            &*(&self.values[0..self.used] as *const [core::mem::MaybeUninit<T>] as *const [T])
+        }
+    }
+}
+
+impl<T: Copy, const N: usize> ArrayParam<T, { N }> {
+    const fn new() -> Self {
+        // INVARIANT: The first `self.used` elements of `self.values` are
+        // initialized.
+        ArrayParam {
+            values: [core::mem::MaybeUninit::uninit(); N],
+            used: 0,
+        }
+    }
+
+    const fn push(&mut self, val: T) {
+        if self.used < N {
+            // INVARIANT: The first `self.used` elements of `self.values` are
+            // initialized.
+            self.values[self.used] = core::mem::MaybeUninit::new(val);
+            self.used += 1;
+        }
+    }
+
+    /// Create an instance of `ArrayParam` initialized with `vals`.
+    ///
+    /// This function is only meant to be used in the [`module::module`] macro.
+    pub const fn create(vals: &[T]) -> Self {
+        let mut result = ArrayParam::new();
+        let mut i = 0;
+        while i < vals.len() {
+            result.push(vals[i]);
+            i += 1;
+        }
+        result
+    }
+}
+
+impl<T: core::fmt::Display, const N: usize> core::fmt::Display for ArrayParam<T, { N }> {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        for val in self.values() {
+            write!(f, "{},", val)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: Copy + core::fmt::Display + ModuleParam, const N: usize> ModuleParam
+    for ArrayParam<T, { N }>
+{
+    type Value = [T];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        arg.and_then(|args| {
+            let mut result = Self::new();
+            for arg in args.split(|b| *b == b',') {
+                result.push(T::try_from_param_arg(Some(arg))?);
+            }
+            Some(result)
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.values()
+    }
+}
+
+/// A C-style string parameter.
+///
+/// The Rust version of the [`charp`] parameter. This type is meant to be
+/// used by the [`macros::module`] macro, not handled directly. Instead use the
+/// `read` method generated by that macro.
+///
+/// [`charp`]: ../../../include/linux/moduleparam.h
+pub enum StringParam {
+    /// A borrowed parameter value.
+    ///
+    /// Either the default value (which is static in the module) or borrowed
+    /// from the original argument buffer used to set the value.
+    Ref(&'static [u8]),
+
+    /// A value that was allocated when the parameter was set.
+    ///
+    /// The value needs to be freed when the parameter is reset or the module is
+    /// unloaded.
+    Owned(alloc::vec::Vec<u8>),
+}
+
+impl StringParam {
+    fn bytes(&self) -> &[u8] {
+        match self {
+            StringParam::Ref(bytes) => *bytes,
+            StringParam::Owned(vec) => &vec[..],
+        }
+    }
+}
+
+impl core::fmt::Display for StringParam {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        let bytes = self.bytes();
+        match core::str::from_utf8(bytes) {
+            Ok(utf8) => write!(f, "{}", utf8),
+            Err(_) => write!(f, "{:?}", bytes),
+        }
+    }
+}
+
+impl ModuleParam for StringParam {
+    type Value = [u8];
+
+    const NOARG_ALLOWED: bool = false;
+
+    fn try_from_param_arg(arg: Option<&'static [u8]>) -> Option<Self> {
+        // SAFETY: It is always safe to call [`slab_is_available`](../../../include/linux/slab.h).
+        let slab_available = unsafe { crate::bindings::slab_is_available() };
+        arg.and_then(|arg| {
+            if slab_available {
+                let mut vec = alloc::vec::Vec::new();
+                vec.try_extend_from_slice(arg).ok()?;
+                Some(StringParam::Owned(vec))
+            } else {
+                Some(StringParam::Ref(arg))
+            }
+        })
+    }
+
+    fn value(&self) -> &Self::Value {
+        self.bytes()
+    }
+}
+
+make_param_ops!(
+    /// Rust implementation of [`kernel_param_ops`](../../../include/linux/moduleparam.h)
+    /// for [`StringParam`].
+    PARAM_OPS_STR,
+    StringParam
+);
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
new file mode 100644
index 000000000000..cdcd83244337
--- /dev/null
+++ b/rust/kernel/of.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Devicetree and Open Firmware abstractions.
+//!
+//! C header: [`include/linux/of_*.h`](../../../../include/linux/of_*.h)
+
+use crate::{bindings, driver, str::BStr};
+
+/// An open firmware device id.
+#[derive(Clone, Copy)]
+pub enum DeviceId {
+    /// An open firmware device id where only a compatible string is specified.
+    Compatible(&'static BStr),
+}
+
+/// Defines a const open firmware device id table that also carries per-entry data/context/info.
+///
+/// The name of the const is `OF_DEVICE_ID_TABLE`, which is what buses are expected to name their
+/// open firmware tables.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::define_of_id_table;
+/// use kernel::of;
+///
+/// define_of_id_table! {u32, [
+///     (of::DeviceId::Compatible(b"test-device1,test-device2"), Some(0xff)),
+///     (of::DeviceId::Compatible(b"test-device3"), None),
+/// ]};
+/// ```
+#[macro_export]
+macro_rules! define_of_id_table {
+    ($data_type:ty, $($t:tt)*) => {
+        $crate::define_id_table!(OF_DEVICE_ID_TABLE, $crate::of::DeviceId, $data_type, $($t)*);
+    };
+}
+
+// SAFETY: `ZERO` is all zeroed-out and `to_rawid` stores `offset` in `of_device_id::data`.
+unsafe impl const driver::RawDeviceId for DeviceId {
+    type RawType = bindings::of_device_id;
+    const ZERO: Self::RawType = bindings::of_device_id {
+        name: [0; 32],
+        type_: [0; 32],
+        compatible: [0; 128],
+        data: core::ptr::null(),
+    };
+
+    fn to_rawid(&self, offset: isize) -> Self::RawType {
+        let DeviceId::Compatible(compatible) = self;
+        let mut id = Self::ZERO;
+        let mut i = 0;
+        while i < compatible.len() {
+            // If `compatible` does not fit in `id.compatible`, an "index out of bounds" build time
+            // error will be triggered.
+            id.compatible[i] = compatible[i] as _;
+            i += 1;
+        }
+        id.compatible[i] = b'\0' as _;
+        id.data = offset as _;
+        id
+    }
+}
diff --git a/rust/kernel/pages.rs b/rust/kernel/pages.rs
new file mode 100644
index 000000000000..02c0d500fae4
--- /dev/null
+++ b/rust/kernel/pages.rs
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+//!
+//! TODO: This module is a work in progress.
+
+use crate::{
+    bindings, c_types, error::code::*, io_buffer::IoBufferReader, user_ptr::UserSlicePtrReader,
+    Result, PAGE_SIZE,
+};
+use core::{marker::PhantomData, ptr};
+
+/// A set of physical pages.
+///
+/// `Pages` holds a reference to a set of pages of order `ORDER`. Having the order as a generic
+/// const allows the struct to have the same size as a pointer.
+///
+/// # Invariants
+///
+/// The pointer `Pages::pages` is valid and points to 2^ORDER pages.
+pub struct Pages<const ORDER: u32> {
+    pub(crate) pages: *mut bindings::page,
+}
+
+impl<const ORDER: u32> Pages<ORDER> {
+    /// Allocates a new set of contiguous pages.
+    pub fn new() -> Result<Self> {
+        // TODO: Consider whether we want to allow callers to specify flags.
+        // SAFETY: This only allocates pages. We check that it succeeds in the next statement.
+        let pages = unsafe {
+            bindings::alloc_pages(
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
+                ORDER,
+            )
+        };
+        if pages.is_null() {
+            return Err(ENOMEM);
+        }
+        // INVARIANTS: We checked that the allocation above succeeded>
+        Ok(Self { pages })
+    }
+
+    /// Copies data from the given [`UserSlicePtrReader`] into the pages.
+    pub fn copy_into_page(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(EINVAL)?;
+
+        // SAFETY: We ensured that the buffer was valid with the check above.
+        unsafe { reader.read_raw((mapping.ptr as usize + offset) as _, len) }?;
+        Ok(())
+    }
+
+    /// Maps the pages and reads from them into the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the destination buffer is valid for the given length.
+    /// Additionally, if the raw buffer is intended to be recast, they must ensure that the data
+    /// can be safely cast; [`crate::io_buffer::ReadableFromBytes`] has more details about it.
+    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(EINVAL)?;
+        unsafe { ptr::copy((mapping.ptr as *mut u8).add(offset), dest, len) };
+        Ok(())
+    }
+
+    /// Maps the pages and writes into them from the given bufer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the buffer is valid for the given length. Additionally, if the
+    /// page is (or will be) mapped by userspace, they must ensure that no kernel data is leaked
+    /// through padding if it was cast from another type; [`crate::io_buffer::WritableToBytes`] has
+    /// more details about it.
+    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        // TODO: For now this only works on the first page.
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+        if end > PAGE_SIZE {
+            return Err(EINVAL);
+        }
+
+        let mapping = self.kmap(0).ok_or(EINVAL)?;
+        unsafe { ptr::copy(src, (mapping.ptr as *mut u8).add(offset), len) };
+        Ok(())
+    }
+
+    /// Maps the page at index `index`.
+    fn kmap(&self, index: usize) -> Option<PageMapping<'_>> {
+        if index >= 1usize << ORDER {
+            return None;
+        }
+
+        // SAFETY: We checked above that `index` is within range.
+        let page = unsafe { self.pages.add(index) };
+
+        // SAFETY: `page` is valid based on the checks above.
+        let ptr = unsafe { bindings::kmap(page) };
+        if ptr.is_null() {
+            return None;
+        }
+
+        Some(PageMapping {
+            page,
+            ptr,
+            _phantom: PhantomData,
+        })
+    }
+}
+
+impl<const ORDER: u32> Drop for Pages<ORDER> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know the pages are allocated with the given order.
+        unsafe { bindings::__free_pages(self.pages, ORDER) };
+    }
+}
+
+struct PageMapping<'a> {
+    page: *mut bindings::page,
+    ptr: *mut c_types::c_void,
+    _phantom: PhantomData<&'a i32>,
+}
+
+impl Drop for PageMapping<'_> {
+    fn drop(&mut self) {
+        // SAFETY: An instance of `PageMapping` is created only when `kmap` succeeded for the given
+        // page, so it is safe to unmap it here.
+        unsafe { bindings::kunmap(self.page) };
+    }
+}
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
new file mode 100644
index 000000000000..8b912c21068b
--- /dev/null
+++ b/rust/kernel/platform.rs
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Platform devices and drivers.
+//!
+//! Also called `platdev`, `pdev`.
+//!
+//! C header: [`include/linux/platform_device.h`](../../../../include/linux/platform_device.h)
+
+use crate::{
+    bindings, c_types,
+    device::{self, RawDevice},
+    driver,
+    error::{from_kernel_result, Result},
+    of,
+    str::CStr,
+    to_result,
+    types::PointerWrapper,
+    ThisModule,
+};
+
+/// A registration of a platform driver.
+pub type Registration<T> = driver::Registration<Adapter<T>>;
+
+/// An adapter for the registration of platform drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver> driver::DriverOps for Adapter<T> {
+    type RegType = bindings::platform_driver;
+
+    unsafe fn register(
+        reg: *mut bindings::platform_driver,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: By the safety requirements of this function (defined in the trait defintion),
+        // `reg` is non-null and valid.
+        let pdrv = unsafe { &mut *reg };
+
+        pdrv.driver.name = name.as_char_ptr();
+        pdrv.probe = Some(Self::probe_callback);
+        pdrv.remove = Some(Self::remove_callback);
+        if let Some(t) = T::OF_DEVICE_ID_TABLE {
+            pdrv.driver.of_match_table = t.as_ref();
+        }
+        // SAFETY:
+        //   - `pdrv` lives at least until the call to `platform_driver_unregister()` returns.
+        //   - `name` pointer has static lifetime.
+        //   - `module.0` lives at least as long as the module.
+        //   - `probe()` and `remove()` are static functions.
+        //   - `of_match_table` is either a raw pointer with static lifetime,
+        //      as guaranteed by the [`driver::IdTable`] type, or null.
+        to_result(|| unsafe { bindings::__platform_driver_register(reg, module.0) })
+    }
+
+    unsafe fn unregister(reg: *mut bindings::platform_driver) {
+        // SAFETY: By the safety requirements of this function (defined in the trait definition),
+        // `reg` was passed (and updated) by a previous successful call to
+        // `platform_driver_register`.
+        unsafe { bindings::platform_driver_unregister(reg) };
+    }
+}
+
+impl<T: Driver> Adapter<T> {
+    fn get_id_info(dev: &Device) -> Option<&'static T::IdInfo> {
+        let table = T::OF_DEVICE_ID_TABLE?;
+
+        // SAFETY: `table` has static lifetime, so it is valid for read. `dev` is guaranteed to be
+        // valid while it's alive, so is the raw device returned by it.
+        let id = unsafe { bindings::of_match_device(table.as_ref(), dev.raw_device()) };
+        if id.is_null() {
+            return None;
+        }
+
+        // SAFETY: `id` is a pointer within the static table, so it's always valid.
+        let offset = unsafe { (*id).data };
+        if offset.is_null() {
+            return None;
+        }
+
+        // SAFETY: The offset comes from a previous call to `offset_from` in `IdArray::new`, which
+        // guarantees that the resulting pointer is within the table.
+        let ptr = unsafe {
+            id.cast::<u8>()
+                .offset(offset as _)
+                .cast::<Option<T::IdInfo>>()
+        };
+
+        // SAFETY: The id table has a static lifetime, so `ptr` is guaranteed to be valid for read.
+        unsafe { (&*ptr).as_ref() }
+    }
+
+    extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `pdev` is valid by the contract with the C code. `dev` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `pdev`.
+            let mut dev = unsafe { Device::from_ptr(pdev) };
+            let info = Self::get_id_info(&dev);
+            let data = T::probe(&mut dev, info)?;
+            // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+            unsafe { bindings::platform_set_drvdata(pdev, data.into_pointer() as _) };
+            Ok(0)
+        }
+    }
+
+    extern "C" fn remove_callback(pdev: *mut bindings::platform_device) -> c_types::c_int {
+        from_kernel_result! {
+            // SAFETY: `pdev` is guaranteed to be a valid, non-null pointer.
+            let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
+            // SAFETY:
+            //   - we allocated this pointer using `T::Data::into_pointer`,
+            //     so it is safe to turn back into a `T::Data`.
+            //   - the allocation happened in `probe`, no-one freed the memory,
+            //     `remove` is the canonical kernel location to free driver data. so OK
+            //     to convert the pointer back to a Rust structure here.
+            let data = unsafe { T::Data::from_pointer(ptr) };
+            let ret = T::remove(&data);
+            <T::Data as driver::DeviceRemoval>::device_remove(&data);
+            ret?;
+            Ok(0)
+        }
+    }
+}
+
+/// A platform driver.
+pub trait Driver {
+    /// Data stored on device by driver.
+    ///
+    /// Corresponds to the data set or retrieved via the kernel's
+    /// `platform_{set,get}_drvdata()` functions.
+    ///
+    /// Require that `Data` implements `PointerWrapper`. We guarantee to
+    /// never move the underlying wrapped data structure. This allows
+    type Data: PointerWrapper + Send + Sync + driver::DeviceRemoval = ();
+
+    /// The type holding information about each device id supported by the driver.
+    type IdInfo: 'static = ();
+
+    /// The table of device ids supported by the driver.
+    const OF_DEVICE_ID_TABLE: Option<driver::IdTable<'static, of::DeviceId, Self::IdInfo>> = None;
+
+    /// Platform driver probe.
+    ///
+    /// Called when a new platform device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device, id_info: Option<&Self::IdInfo>) -> Result<Self::Data>;
+
+    /// Platform driver remove.
+    ///
+    /// Called when a platform device is removed.
+    /// Implementers should prepare the device for complete removal here.
+    fn remove(_data: &Self::Data) -> Result {
+        Ok(())
+    }
+}
+
+/// A platform device.
+///
+/// # Invariants
+///
+/// The field `ptr` is non-null and valid for the lifetime of the object.
+pub struct Device {
+    ptr: *mut bindings::platform_device,
+}
+
+impl Device {
+    /// Creates a new device from the given pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be non-null and valid. It must remain valid for the lifetime of the returned
+    /// instance.
+    unsafe fn from_ptr(ptr: *mut bindings::platform_device) -> Self {
+        // INVARIANT: The safety requirements of the function ensure the lifetime invariant.
+        Self { ptr }
+    }
+
+    /// Returns id of the platform device.
+    pub fn id(&self) -> i32 {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { (*self.ptr).id }
+    }
+}
+
+// SAFETY: The device returned by `raw_device` is the raw platform device.
+unsafe impl device::RawDevice for Device {
+    fn raw_device(&self) -> *mut bindings::device {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { &mut (*self.ptr).dev }
+    }
+}
+
+/// Declares a kernel module that exposes a single platform driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::prelude::*;
+/// # use kernel::{platform, define_of_id_table, module_platform_driver};
+/// #
+/// struct MyDriver;
+/// impl platform::Driver for MyDriver {
+///     // [...]
+/// #   fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result {
+/// #       Ok(())
+/// #   }
+/// #   define_of_id_table! {(), [
+/// #       (of::DeviceId::Compatible(b"brcm,bcm2835-rng"), None),
+/// #   ]}
+/// }
+///
+/// module_platform_driver! {
+///     type: MyDriver,
+///     name: b"module_name",
+///     author: b"Author name",
+///     license: b"GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_platform_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
+    };
+}
diff --git a/rust/kernel/power.rs b/rust/kernel/power.rs
new file mode 100644
index 000000000000..e318b5d9f0c0
--- /dev/null
+++ b/rust/kernel/power.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Power management interfaces.
+//!
+//! C header: [`include/linux/pm.h`](../../../../include/linux/pm.h)
+
+#![allow(dead_code)]
+
+use crate::{bindings, c_types, error::from_kernel_result, types::PointerWrapper, Result};
+use core::marker::PhantomData;
+
+/// Corresponds to the kernel's `struct dev_pm_ops`.
+///
+/// It is meant to be implemented by drivers that support power-management operations.
+pub trait Operations {
+    /// The type of the context data stored by the driver on each device.
+    type Data: PointerWrapper + Sync + Send;
+
+    /// Called before the system goes into a sleep state.
+    fn suspend(_data: <Self::Data as PointerWrapper>::Borrowed<'_>) -> Result {
+        Ok(())
+    }
+
+    /// Called after the system comes back from a sleep state.
+    fn resume(_data: <Self::Data as PointerWrapper>::Borrowed<'_>) -> Result {
+        Ok(())
+    }
+
+    /// Called before creating a hibernation image.
+    fn freeze(_data: <Self::Data as PointerWrapper>::Borrowed<'_>) -> Result {
+        Ok(())
+    }
+
+    /// Called after the system is restored from a hibernation image.
+    fn restore(_data: <Self::Data as PointerWrapper>::Borrowed<'_>) -> Result {
+        Ok(())
+    }
+}
+
+macro_rules! pm_callback {
+    ($callback:ident, $method:ident) => {
+        unsafe extern "C" fn $callback<T: Operations>(
+            dev: *mut bindings::device,
+        ) -> c_types::c_int {
+            from_kernel_result! {
+                // SAFETY: `dev` is valid as it was passed in by the C portion.
+                let ptr = unsafe { bindings::dev_get_drvdata(dev) };
+                // SAFETY: By the safety requirements of `OpsTable::build`, we know that `ptr` came
+                // from a previous call to `T::Data::into_pointer`.
+                let data = unsafe { T::Data::borrow(ptr) };
+                T::$method(data)?;
+                Ok(0)
+            }
+        }
+    };
+}
+
+pm_callback!(suspend_callback, suspend);
+pm_callback!(resume_callback, resume);
+pm_callback!(freeze_callback, freeze);
+pm_callback!(restore_callback, restore);
+
+pub(crate) struct OpsTable<T: Operations>(PhantomData<*const T>);
+
+impl<T: Operations> OpsTable<T> {
+    const VTABLE: bindings::dev_pm_ops = bindings::dev_pm_ops {
+        prepare: None,
+        complete: None,
+        suspend: Some(suspend_callback::<T>),
+        resume: Some(resume_callback::<T>),
+        freeze: Some(freeze_callback::<T>),
+        thaw: None,
+        poweroff: None,
+        restore: Some(restore_callback::<T>),
+        suspend_late: None,
+        resume_early: None,
+        freeze_late: None,
+        thaw_early: None,
+        poweroff_late: None,
+        restore_early: None,
+        suspend_noirq: None,
+        resume_noirq: None,
+        freeze_noirq: None,
+        thaw_noirq: None,
+        poweroff_noirq: None,
+        restore_noirq: None,
+        runtime_suspend: None,
+        runtime_resume: None,
+        runtime_idle: None,
+    };
+
+    /// Builds an instance of `struct dev_pm_ops`.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `dev_get_drvdata` will result in a value returned by
+    /// [`T::Data::into_pointer`].
+    pub(crate) const unsafe fn build() -> &'static bindings::dev_pm_ops {
+        &Self::VTABLE
+    }
+}
+
+/// Implements the [`Operations`] trait as no-ops.
+///
+/// This is useful when one doesn't want to provide the implementation of any power-manager related
+/// operation.
+pub struct NoOperations<T: PointerWrapper>(PhantomData<T>);
+
+impl<T: PointerWrapper + Send + Sync> Operations for NoOperations<T> {
+    type Data = T;
+}
+
+// SAFETY: `NoOperation` provides no functionality, it is safe to send a reference to it to
+// different threads.
+unsafe impl<T: PointerWrapper> Sync for NoOperations<T> {}
+
+// SAFETY: `NoOperation` provides no functionality, it is safe to send it to different threads.
+unsafe impl<T: PointerWrapper> Send for NoOperations<T> {}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
new file mode 100644
index 000000000000..cc5894fba420
--- /dev/null
+++ b/rust/kernel/prelude.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` prelude.
+//!
+//! These are the most common items used by Rust code in the kernel,
+//! intended to be imported by all Rust code, for convenience.
+//!
+//! # Examples
+//!
+//! ```
+//! use kernel::prelude::*;
+//! ```
+
+pub use core::pin::Pin;
+
+pub use alloc::{boxed::Box, string::String, vec::Vec};
+
+pub use macros::module;
+
+pub use super::build_assert;
+
+pub use super::{
+    dbg, dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn, fmt,
+    pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn,
+};
+
+pub use super::module_misc_device;
+
+#[cfg(CONFIG_ARM_AMBA)]
+pub use super::module_amba_driver;
+
+pub use super::static_assert;
+
+pub use super::{error::code::*, Error, KernelModule, Result};
+
+pub use super::{str::CStr, ThisModule};
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
new file mode 100644
index 000000000000..59e92f74cd8d
--- /dev/null
+++ b/rust/kernel/print.rs
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Printing facilities.
+//!
+//! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html>
+
+use core::fmt;
+
+use crate::{
+    c_types::{c_char, c_void},
+    str::RawFormatter,
+};
+
+#[cfg(CONFIG_PRINTK)]
+use crate::bindings;
+
+// Called from `vsprintf` with format specifier `%pA`.
+#[no_mangle]
+unsafe fn rust_fmt_argument(buf: *mut c_char, end: *mut c_char, ptr: *const c_void) -> *mut c_char {
+    use fmt::Write;
+    // SAFETY: The C contract guarantees that `buf` is valid if it's less than `end`.
+    let mut w = unsafe { RawFormatter::from_ptrs(buf.cast(), end.cast()) };
+    let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
+    w.pos().cast()
+}
+
+/// Format strings.
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+pub mod format_strings {
+    use crate::bindings;
+
+    /// The length we copy from the `KERN_*` kernel prefixes.
+    const LENGTH_PREFIX: usize = 2;
+
+    /// The length of the fixed format strings.
+    pub const LENGTH: usize = 10;
+
+    /// Generates a fixed format string for the kernel's [`_printk`].
+    ///
+    /// The format string is always the same for a given level, i.e. for a
+    /// given `prefix`, which are the kernel's `KERN_*` constants.
+    ///
+    /// [`_printk`]: ../../../../include/linux/printk.h
+    const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
+        // Ensure the `KERN_*` macros are what we expect.
+        assert!(prefix[0] == b'\x01');
+        if is_cont {
+            assert!(prefix[1] == b'c');
+        } else {
+            assert!(prefix[1] >= b'0' && prefix[1] <= b'7');
+        }
+        assert!(prefix[2] == b'\x00');
+
+        let suffix: &[u8; LENGTH - LENGTH_PREFIX] = if is_cont {
+            b"%pA\0\0\0\0\0"
+        } else {
+            b"%s: %pA\0"
+        };
+
+        [
+            prefix[0], prefix[1], suffix[0], suffix[1], suffix[2], suffix[3], suffix[4], suffix[5],
+            suffix[6], suffix[7],
+        ]
+    }
+
+    // Generate the format strings at compile-time.
+    //
+    // This avoids the compiler generating the contents on the fly in the stack.
+    //
+    // Furthermore, `static` instead of `const` is used to share the strings
+    // for all the kernel.
+    pub static EMERG: [u8; LENGTH] = generate(false, bindings::KERN_EMERG);
+    pub static ALERT: [u8; LENGTH] = generate(false, bindings::KERN_ALERT);
+    pub static CRIT: [u8; LENGTH] = generate(false, bindings::KERN_CRIT);
+    pub static ERR: [u8; LENGTH] = generate(false, bindings::KERN_ERR);
+    pub static WARNING: [u8; LENGTH] = generate(false, bindings::KERN_WARNING);
+    pub static NOTICE: [u8; LENGTH] = generate(false, bindings::KERN_NOTICE);
+    pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
+    pub static DEBUG: [u8; LENGTH] = generate(false, bindings::KERN_DEBUG);
+    pub static CONT: [u8; LENGTH] = generate(true, bindings::KERN_CONT);
+}
+
+/// Prints a message via the kernel's [`_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// # Safety
+///
+/// The format string must be one of the ones in [`format_strings`], and
+/// the module name must be null-terminated.
+///
+/// [`_printk`]: ../../../../include/linux/_printk.h
+#[doc(hidden)]
+#[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+pub unsafe fn call_printk(
+    format_string: &[u8; format_strings::LENGTH],
+    module_name: &[u8],
+    args: fmt::Arguments<'_>,
+) {
+    // `_printk` does not seem to fail in any path.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            format_string.as_ptr() as _,
+            module_name.as_ptr(),
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Prints a message via the kernel's [`_printk`] for the `CONT` level.
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// [`_printk`]: ../../../../include/linux/printk.h
+#[doc(hidden)]
+#[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+pub fn call_printk_cont(args: fmt::Arguments<'_>) {
+    // `_printk` does not seem to fail in any path.
+    //
+    // SAFETY: The format string is fixed.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            format_strings::CONT.as_ptr() as _,
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Performs formatting and forwards the string to [`call_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+#[cfg(not(testlib))]
+#[macro_export]
+macro_rules! print_macro (
+    // The non-continuation cases (most of them, e.g. `INFO`).
+    ($format_string:path, false, $($arg:tt)+) => (
+        // SAFETY: This hidden macro should only be called by the documented
+        // printing macros which ensure the format string is one of the fixed
+        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+        // by the `module!` proc macro or fixed values defined in a kernel
+        // crate.
+        unsafe {
+            $crate::print::call_printk(
+                &$format_string,
+                crate::__LOG_PREFIX,
+                format_args!($($arg)+),
+            );
+        }
+    );
+
+    // The `CONT` case.
+    ($format_string:path, true, $($arg:tt)+) => (
+        $crate::print::call_printk_cont(
+            format_args!($($arg)+),
+        );
+    );
+);
+
+/// Stub for doctests
+#[cfg(testlib)]
+#[macro_export]
+macro_rules! print_macro (
+    ($format_string:path, $e:expr, $($arg:tt)+) => (
+        ()
+    );
+);
+
+// We could use a macro to generate these macros. However, doing so ends
+// up being a bit ugly: it requires the dollar token trick to escape `$` as
+// well as playing with the `doc` attribute. Furthermore, they cannot be easily
+// imported in the prelude due to [1]. So, for the moment, we just write them
+// manually, like in the C side; while keeping most of the logic in another
+// macro, i.e. [`print_macro`].
+//
+// [1]: https://github.com/rust-lang/rust/issues/52234
+
+/// Prints an emergency-level message (level 0).
+///
+/// Use this level if the system is unusable.
+///
+/// Equivalent to the kernel's [`pr_emerg`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_emerg`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_emerg
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_emerg!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_emerg (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::EMERG, false, $($arg)*)
+    )
+);
+
+/// Prints an alert-level message (level 1).
+///
+/// Use this level if action must be taken immediately.
+///
+/// Equivalent to the kernel's [`pr_alert`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_alert`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_alert
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_alert!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_alert (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ALERT, false, $($arg)*)
+    )
+);
+
+/// Prints a critical-level message (level 2).
+///
+/// Use this level for critical conditions.
+///
+/// Equivalent to the kernel's [`pr_crit`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_crit`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_crit
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_crit!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_crit (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CRIT, false, $($arg)*)
+    )
+);
+
+/// Prints an error-level message (level 3).
+///
+/// Use this level for error conditions.
+///
+/// Equivalent to the kernel's [`pr_err`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_err`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_err
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_err!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_err (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::ERR, false, $($arg)*)
+    )
+);
+
+/// Prints a warning-level message (level 4).
+///
+/// Use this level for warning conditions.
+///
+/// Equivalent to the kernel's [`pr_warn`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_warn`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_warn
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_warn!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_warn (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::WARNING, false, $($arg)*)
+    )
+);
+
+/// Prints a notice-level message (level 5).
+///
+/// Use this level for normal but significant conditions.
+///
+/// Equivalent to the kernel's [`pr_notice`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_notice`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_notice
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_notice!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_notice (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::NOTICE, false, $($arg)*)
+    )
+);
+
+/// Prints an info-level message (level 6).
+///
+/// Use this level for informational messages.
+///
+/// Equivalent to the kernel's [`pr_info`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_info`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_info
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_info!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_info (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::INFO, false, $($arg)*)
+    )
+);
+
+/// Prints a debug-level message (level 7).
+///
+/// Use this level for debug messages.
+///
+/// Equivalent to the kernel's [`pr_debug`] macro, except that it doesn't support dynamic debug
+/// yet.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_debug`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_debug
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// pr_debug!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_debug (
+    ($($arg:tt)*) => (
+        if cfg!(debug_assertions) {
+            $crate::print_macro!($crate::print::format_strings::DEBUG, false, $($arg)*)
+        }
+    )
+);
+
+/// Continues a previous log message in the same line.
+///
+/// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
+///
+/// Equivalent to the kernel's [`pr_cont`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// [`alloc::format!`] for information about the formatting syntax.
+///
+/// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_cont
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::pr_cont;
+/// pr_info!("hello");
+/// pr_cont!(" {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_cont (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::CONT, true, $($arg)*)
+    )
+);
diff --git a/rust/kernel/random.rs b/rust/kernel/random.rs
new file mode 100644
index 000000000000..6e0e847f909e
--- /dev/null
+++ b/rust/kernel/random.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Random numbers.
+//!
+//! C header: [`include/linux/random.h`](../../../../include/linux/random.h)
+
+use core::convert::TryInto;
+
+use crate::{bindings, c_types, error::code::*, Error, Result};
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// Ensures that the CSPRNG has been seeded before generating any random bytes,
+/// and will block until it is ready.
+pub fn getrandom(dest: &mut [u8]) -> Result {
+    let res = unsafe { bindings::wait_for_random_bytes() };
+    if res != 0 {
+        return Err(Error::from_kernel_errno(res));
+    }
+
+    unsafe {
+        bindings::get_random_bytes(
+            dest.as_mut_ptr() as *mut c_types::c_void,
+            dest.len().try_into()?,
+        );
+    }
+    Ok(())
+}
+
+/// Fills a byte slice with random bytes generated from the kernel's CSPRNG.
+///
+/// If the CSPRNG is not yet seeded, returns an `Err(EAGAIN)` immediately.
+pub fn getrandom_nonblock(dest: &mut [u8]) -> Result {
+    if !unsafe { bindings::rng_is_initialized() } {
+        return Err(EAGAIN);
+    }
+    getrandom(dest)
+}
+
+/// Contributes the contents of a byte slice to the kernel's entropy pool.
+///
+/// Does *not* credit the kernel entropy counter though.
+pub fn add_randomness(data: &[u8]) {
+    unsafe {
+        bindings::add_device_randomness(
+            data.as_ptr() as *const c_types::c_void,
+            data.len().try_into().unwrap(),
+        );
+    }
+}
diff --git a/rust/kernel/raw_list.rs b/rust/kernel/raw_list.rs
new file mode 100644
index 000000000000..4bc4f4a24ad5
--- /dev/null
+++ b/rust/kernel/raw_list.rs
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Raw lists.
+//!
+//! TODO: This module is a work in progress.
+
+use core::{
+    cell::UnsafeCell,
+    ptr,
+    ptr::NonNull,
+    sync::atomic::{AtomicBool, Ordering},
+};
+
+/// A descriptor of list elements.
+///
+/// It describes the type of list elements and provides a function to determine how to get the
+/// links to be used on a list.
+///
+/// A type that may be in multiple lists simultaneously neneds to implement one of these for each
+/// simultaneous list.
+pub trait GetLinks {
+    /// The type of the entries in the list.
+    type EntryType: ?Sized;
+
+    /// Returns the links to be used when linking an entry within a list.
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType>;
+}
+
+/// The links used to link an object on a linked list.
+///
+/// Instances of this type are usually embedded in structures and returned in calls to
+/// [`GetLinks::get_links`].
+pub struct Links<T: ?Sized> {
+    inserted: AtomicBool,
+    entry: UnsafeCell<ListEntry<T>>,
+}
+
+impl<T: ?Sized> Links<T> {
+    /// Constructs a new [`Links`] instance that isn't inserted on any lists yet.
+    pub fn new() -> Self {
+        Self {
+            inserted: AtomicBool::new(false),
+            entry: UnsafeCell::new(ListEntry::new()),
+        }
+    }
+
+    fn acquire_for_insertion(&self) -> bool {
+        self.inserted
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
+            .is_ok()
+    }
+
+    fn release_after_removal(&self) {
+        self.inserted.store(false, Ordering::Release);
+    }
+}
+
+impl<T: ?Sized> Default for Links<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+struct ListEntry<T: ?Sized> {
+    next: Option<NonNull<T>>,
+    prev: Option<NonNull<T>>,
+}
+
+impl<T: ?Sized> ListEntry<T> {
+    fn new() -> Self {
+        Self {
+            next: None,
+            prev: None,
+        }
+    }
+}
+
+/// A linked list.
+///
+/// # Invariants
+///
+/// The links of objects added to a list are owned by the list.
+pub(crate) struct RawList<G: GetLinks> {
+    head: Option<NonNull<G::EntryType>>,
+}
+
+impl<G: GetLinks> RawList<G> {
+    pub(crate) fn new() -> Self {
+        Self { head: None }
+    }
+
+    pub(crate) fn is_empty(&self) -> bool {
+        self.head.is_none()
+    }
+
+    fn insert_after_priv(
+        &mut self,
+        existing: &G::EntryType,
+        new_entry: &mut ListEntry<G::EntryType>,
+        new_ptr: Option<NonNull<G::EntryType>>,
+    ) {
+        {
+            // SAFETY: It's safe to get the previous entry of `existing` because the list cannot
+            // change.
+            let existing_links = unsafe { &mut *G::get_links(existing).entry.get() };
+            new_entry.next = existing_links.next;
+            existing_links.next = new_ptr;
+        }
+
+        new_entry.prev = Some(NonNull::from(existing));
+
+        // SAFETY: It's safe to get the next entry of `existing` because the list cannot change.
+        let next_links =
+            unsafe { &mut *G::get_links(new_entry.next.unwrap().as_ref()).entry.get() };
+        next_links.prev = new_ptr;
+    }
+
+    /// Inserts the given object after `existing`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `existing` points to a valid entry that is on the list.
+    pub(crate) unsafe fn insert_after(
+        &mut self,
+        existing: &G::EntryType,
+        new: &G::EntryType,
+    ) -> bool {
+        let links = G::get_links(new);
+        if !links.acquire_for_insertion() {
+            // Nothing to do if already inserted.
+            return false;
+        }
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let new_entry = unsafe { &mut *links.entry.get() };
+        self.insert_after_priv(existing, new_entry, Some(NonNull::from(new)));
+        true
+    }
+
+    fn push_back_internal(&mut self, new: &G::EntryType) -> bool {
+        let links = G::get_links(new);
+        if !links.acquire_for_insertion() {
+            // Nothing to do if already inserted.
+            return false;
+        }
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let new_entry = unsafe { &mut *links.entry.get() };
+        let new_ptr = Some(NonNull::from(new));
+        match self.back() {
+            // SAFETY: `back` is valid as the list cannot change.
+            Some(back) => self.insert_after_priv(unsafe { back.as_ref() }, new_entry, new_ptr),
+            None => {
+                self.head = new_ptr;
+                new_entry.next = new_ptr;
+                new_entry.prev = new_ptr;
+            }
+        }
+        true
+    }
+
+    pub(crate) unsafe fn push_back(&mut self, new: &G::EntryType) -> bool {
+        self.push_back_internal(new)
+    }
+
+    fn remove_internal(&mut self, data: &G::EntryType) -> bool {
+        let links = G::get_links(data);
+
+        // SAFETY: The links are now owned by the list, so it is safe to get a mutable reference.
+        let entry = unsafe { &mut *links.entry.get() };
+        let next = if let Some(next) = entry.next {
+            next
+        } else {
+            // Nothing to do if the entry is not on the list.
+            return false;
+        };
+
+        if ptr::eq(data, next.as_ptr()) {
+            // We're removing the only element.
+            self.head = None
+        } else {
+            // Update the head if we're removing it.
+            if let Some(raw_head) = self.head {
+                if ptr::eq(data, raw_head.as_ptr()) {
+                    self.head = Some(next);
+                }
+            }
+
+            // SAFETY: It's safe to get the previous entry because the list cannot change.
+            unsafe { &mut *G::get_links(entry.prev.unwrap().as_ref()).entry.get() }.next =
+                entry.next;
+
+            // SAFETY: It's safe to get the next entry because the list cannot change.
+            unsafe { &mut *G::get_links(next.as_ref()).entry.get() }.prev = entry.prev;
+        }
+
+        // Reset the links of the element we're removing so that we know it's not on any list.
+        entry.next = None;
+        entry.prev = None;
+        links.release_after_removal();
+        true
+    }
+
+    /// Removes the given entry.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `data` is either on this list or in no list. It being on another
+    /// list leads to memory unsafety.
+    pub(crate) unsafe fn remove(&mut self, data: &G::EntryType) -> bool {
+        self.remove_internal(data)
+    }
+
+    fn pop_front_internal(&mut self) -> Option<NonNull<G::EntryType>> {
+        let head = self.head?;
+        // SAFETY: The head is on the list as we just got it from there and it cannot change.
+        unsafe { self.remove(head.as_ref()) };
+        Some(head)
+    }
+
+    pub(crate) fn pop_front(&mut self) -> Option<NonNull<G::EntryType>> {
+        self.pop_front_internal()
+    }
+
+    pub(crate) fn front(&self) -> Option<NonNull<G::EntryType>> {
+        self.head
+    }
+
+    pub(crate) fn back(&self) -> Option<NonNull<G::EntryType>> {
+        // SAFETY: The links of head are owned by the list, so it is safe to get a reference.
+        unsafe { &*G::get_links(self.head?.as_ref()).entry.get() }.prev
+    }
+
+    pub(crate) fn cursor_front(&self) -> Cursor<'_, G> {
+        Cursor::new(self, self.front())
+    }
+
+    pub(crate) fn cursor_front_mut(&mut self) -> CursorMut<'_, G> {
+        CursorMut::new(self, self.front())
+    }
+}
+
+struct CommonCursor<G: GetLinks> {
+    cur: Option<NonNull<G::EntryType>>,
+}
+
+impl<G: GetLinks> CommonCursor<G> {
+    fn new(cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self { cur }
+    }
+
+    fn move_next(&mut self, list: &RawList<G>) {
+        match self.cur.take() {
+            None => self.cur = list.head,
+            Some(cur) => {
+                if let Some(head) = list.head {
+                    // SAFETY: We have a shared ref to the linked list, so the links can't change.
+                    let links = unsafe { &*G::get_links(cur.as_ref()).entry.get() };
+                    if links.next.unwrap() != head {
+                        self.cur = links.next;
+                    }
+                }
+            }
+        }
+    }
+
+    fn move_prev(&mut self, list: &RawList<G>) {
+        match list.head {
+            None => self.cur = None,
+            Some(head) => {
+                let next = match self.cur.take() {
+                    None => head,
+                    Some(cur) => {
+                        if cur == head {
+                            return;
+                        }
+                        cur
+                    }
+                };
+                // SAFETY: There's a shared ref to the list, so the links can't change.
+                let links = unsafe { &*G::get_links(next.as_ref()).entry.get() };
+                self.cur = links.prev;
+            }
+        }
+    }
+}
+
+/// A list cursor that allows traversing a linked list and inspecting elements.
+pub struct Cursor<'a, G: GetLinks> {
+    cursor: CommonCursor<G>,
+    list: &'a RawList<G>,
+}
+
+impl<'a, G: GetLinks> Cursor<'a, G> {
+    fn new(list: &'a RawList<G>, cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self {
+            list,
+            cursor: CommonCursor::new(cur),
+        }
+    }
+
+    /// Returns the element the cursor is currently positioned on.
+    pub fn current(&self) -> Option<&'a G::EntryType> {
+        let cur = self.cursor.cur?;
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &*cur.as_ptr() })
+    }
+
+    /// Moves the cursor to the next element.
+    pub fn move_next(&mut self) {
+        self.cursor.move_next(self.list);
+    }
+}
+
+pub(crate) struct CursorMut<'a, G: GetLinks> {
+    cursor: CommonCursor<G>,
+    list: &'a mut RawList<G>,
+}
+
+impl<'a, G: GetLinks> CursorMut<'a, G> {
+    fn new(list: &'a mut RawList<G>, cur: Option<NonNull<G::EntryType>>) -> Self {
+        Self {
+            list,
+            cursor: CommonCursor::new(cur),
+        }
+    }
+
+    pub(crate) fn current(&mut self) -> Option<&mut G::EntryType> {
+        let cur = self.cursor.cur?;
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *cur.as_ptr() })
+    }
+
+    /// Removes the entry the cursor is pointing to and advances the cursor to the next entry. It
+    /// returns a raw pointer to the removed element (if one is removed).
+    pub(crate) fn remove_current(&mut self) -> Option<NonNull<G::EntryType>> {
+        let entry = self.cursor.cur?;
+        self.cursor.move_next(self.list);
+        // SAFETY: The entry is on the list as we just got it from there and it cannot change.
+        unsafe { self.list.remove(entry.as_ref()) };
+        Some(entry)
+    }
+
+    pub(crate) fn peek_next(&mut self) -> Option<&mut G::EntryType> {
+        let mut new = CommonCursor::new(self.cursor.cur);
+        new.move_next(self.list);
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *new.cur?.as_ptr() })
+    }
+
+    pub(crate) fn peek_prev(&mut self) -> Option<&mut G::EntryType> {
+        let mut new = CommonCursor::new(self.cursor.cur);
+        new.move_prev(self.list);
+        // SAFETY: Objects must be kept alive while on the list.
+        Some(unsafe { &mut *new.cur?.as_ptr() })
+    }
+
+    pub(crate) fn move_next(&mut self) {
+        self.cursor.move_next(self.list);
+    }
+}
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
new file mode 100644
index 000000000000..71112e306ec3
--- /dev/null
+++ b/rust/kernel/rbtree.rs
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Red-black trees.
+//!
+//! C header: [`include/linux/rbtree.h`](../../../../include/linux/rbtree.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.html>
+
+use crate::{bindings, Result};
+use alloc::boxed::Box;
+use core::{
+    cmp::{Ord, Ordering},
+    iter::{IntoIterator, Iterator},
+    marker::PhantomData,
+    mem::MaybeUninit,
+    ptr::{addr_of_mut, NonNull},
+};
+
+struct Node<K, V> {
+    links: bindings::rb_node,
+    key: K,
+    value: V,
+}
+
+/// A red-black tree with owned nodes.
+///
+/// It is backed by the kernel C red-black trees.
+///
+/// # Invariants
+///
+/// Non-null parent/children pointers stored in instances of the `rb_node` C struct are always
+/// valid, and pointing to a field of our internal representation of a node.
+///
+/// # Examples
+///
+/// In the example below we do several operations on a tree. We note that insertions may fail if
+/// the system is out of memory.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::rbtree::RBTree;
+///
+/// fn rbtest() -> Result {
+///     // Create a new tree.
+///     let mut tree = RBTree::new();
+///
+///     // Insert three elements.
+///     tree.try_insert(20, 200)?;
+///     tree.try_insert(10, 100)?;
+///     tree.try_insert(30, 300)?;
+///
+///     // Check the nodes we just inserted.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Print all elements.
+///     for (key, value) in &tree {
+///         pr_info!("{} = {}\n", key, value);
+///     }
+///
+///     // Replace one of the elements.
+///     tree.try_insert(10, 1000)?;
+///
+///     // Check that the tree reflects the replacement.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &1000));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Change the value of one of the elements.
+///     *tree.get_mut(&30).unwrap() = 3000;
+///
+///     // Check that the tree reflects the update.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &1000));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &3000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Remove an element.
+///     tree.remove(&10);
+///
+///     // Check that the tree reflects the removal.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &3000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Update all values.
+///     for value in tree.values_mut() {
+///         *value *= 10;
+///     }
+///
+///     // Check that the tree reflects the changes to values.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&20, &2000));
+///         assert_eq!(iter.next().unwrap(), (&30, &30000));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we first allocate a node, acquire a spinlock, then insert the node into
+/// the tree. This is useful when the insertion context does not allow sleeping, for example, when
+/// holding a spinlock.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::{rbtree::RBTree, sync::SpinLock};
+///
+/// fn insert_test(tree: &SpinLock<RBTree<u32, u32>>) -> Result {
+///     // Pre-allocate node. This may fail (as it allocates memory).
+///     let node = RBTree::try_allocate_node(10, 100)?;
+///
+///     // Insert node while holding the lock. It is guaranteed to succeed with no allocation
+///     // attempts.
+///     let mut guard = tree.lock();
+///     guard.insert(node);
+///     Ok(())
+/// }
+/// ```
+///
+/// In the example below, we reuse an existing node allocation from an element we removed.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::rbtree::RBTree;
+///
+/// fn reuse_test() -> Result {
+///     // Create a new tree.
+///     let mut tree = RBTree::new();
+///
+///     // Insert three elements.
+///     tree.try_insert(20, 200)?;
+///     tree.try_insert(10, 100)?;
+///     tree.try_insert(30, 300)?;
+///
+///     // Check the nodes we just inserted.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert_eq!(iter.next().unwrap(), (&30, &300));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Remove a node, getting back ownership of it.
+///     let existing = tree.remove_node(&30).unwrap();
+///
+///     // Check that the tree reflects the removal.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     // Turn the node into a reservation so that we can reuse it with a different key/value.
+///     let reservation = existing.into_reservation();
+///
+///     // Insert a new node into the tree, reusing the previous allocation. This is guaranteed to
+///     // succeed (no memory allocations).
+///     tree.insert(reservation.into_node(15, 150));
+///
+///     // Check that the tree reflect the new insertion.
+///     {
+///         let mut iter = tree.iter();
+///         assert_eq!(iter.next().unwrap(), (&10, &100));
+///         assert_eq!(iter.next().unwrap(), (&15, &150));
+///         assert_eq!(iter.next().unwrap(), (&20, &200));
+///         assert!(iter.next().is_none());
+///     }
+///
+///     Ok(())
+/// }
+/// ```
+pub struct RBTree<K, V> {
+    root: bindings::rb_root,
+    _p: PhantomData<Node<K, V>>,
+}
+
+impl<K, V> RBTree<K, V> {
+    /// Creates a new and empty tree.
+    pub fn new() -> Self {
+        Self {
+            // INVARIANT: There are no nodes in the tree, so the invariant holds vacuously.
+            root: bindings::rb_root::default(),
+            _p: PhantomData,
+        }
+    }
+
+    /// Tries to insert a new value into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// Returns an error if it cannot allocate memory for the new node.
+    pub fn try_insert(&mut self, key: K, value: V) -> Result<Option<RBTreeNode<K, V>>>
+    where
+        K: Ord,
+    {
+        Ok(self.insert(Self::try_allocate_node(key, value)?))
+    }
+
+    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
+    /// call to [`RBTree::insert`].
+    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
+        Ok(RBTreeNodeReservation {
+            node: Box::try_new(MaybeUninit::uninit())?,
+        })
+    }
+
+    /// Allocates and initialiases a node that can be inserted into the tree via
+    /// [`RBTree::insert`].
+    pub fn try_allocate_node(key: K, value: V) -> Result<RBTreeNode<K, V>> {
+        Ok(Self::try_reserve_node()?.into_node(key, value))
+    }
+
+    /// Inserts a new node into the tree.
+    ///
+    /// It overwrites a node if one already exists with the same key and returns it (containing the
+    /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
+    ///
+    /// This function always succeeds.
+    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>>
+    where
+        K: Ord,
+    {
+        let RBTreeNode { node } = node;
+        let node = Box::into_raw(node);
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+        let mut new_link: &mut *mut bindings::rb_node = &mut self.root.rb_node;
+        let mut parent = core::ptr::null_mut();
+        while !new_link.is_null() {
+            let this = crate::container_of!(*new_link, Node<K, V>, links);
+
+            parent = *new_link;
+
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
+            // valid until the node is removed.
+            match unsafe { (*node).key.cmp(&(*this).key) } {
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => new_link = unsafe { &mut (*parent).rb_left },
+                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => new_link = unsafe { &mut (*parent).rb_right },
+                Ordering::Equal => {
+                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
+                    // It remains valid because we "forgot" it with `Box::into_raw`.
+                    // SAFETY: All pointers are non-null and valid (parent, despite the name, really
+                    // is the node we're replacing).
+                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
+
+                    // INVARIANT: The node is being returned and the caller may free it, however,
+                    // it was removed from the tree. So the invariants still hold.
+                    return Some(RBTreeNode {
+                        // SAFETY: `this` was a node in the tree, so it is valid.
+                        node: unsafe { Box::from_raw(this as _) },
+                    });
+                }
+            }
+        }
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: All pointers are non-null and valid (`*new_link` is null, but `new_link` is a
+        // mutable reference).
+        unsafe { bindings::rb_link_node(node_links, parent, new_link) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
+        None
+    }
+
+    /// Returns a node with the given key, if one exists.
+    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>>
+    where
+        K: Ord,
+    {
+        let mut node = self.root.rb_node;
+        while !node.is_null() {
+            let this = crate::container_of!(node, Node<K, V>, links);
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            node = match key.cmp(unsafe { &(*this).key }) {
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => unsafe { (*node).rb_left },
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => unsafe { (*node).rb_right },
+                Ordering::Equal => return NonNull::new(this as _),
+            }
+        }
+        None
+    }
+
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V>
+    where
+        K: Ord,
+    {
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        self.find(key).map(|node| unsafe { &node.as_ref().value })
+    }
+
+    /// Returns a mutable reference to the value corresponding to the key.
+    pub fn get_mut(&mut self, key: &K) -> Option<&mut V>
+    where
+        K: Ord,
+    {
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        self.find(key)
+            .map(|mut node| unsafe { &mut node.as_mut().value })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the node that was removed if one exists, or [`None`] otherwise.
+    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>>
+    where
+        K: Ord,
+    {
+        let mut node = self.find(key)?;
+
+        // SAFETY: The `find` return value is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        Some(RBTreeNode {
+            // SAFETY: The `find` return value was a node in the tree, so it is valid.
+            node: unsafe { Box::from_raw(node.as_ptr()) },
+        })
+    }
+
+    /// Removes the node with the given key from the tree.
+    ///
+    /// It returns the value that was removed if one exists, or [`None`] otherwise.
+    pub fn remove(&mut self, key: &K) -> Option<V>
+    where
+        K: Ord,
+    {
+        let node = self.remove_node(key)?;
+        let RBTreeNode { node } = node;
+        let Node {
+            links: _,
+            key: _,
+            value,
+        } = *node;
+        Some(value)
+    }
+
+    /// Returns an iterator over the tree nodes, sorted by key.
+    pub fn iter(&self) -> RBTreeIterator<'_, K, V> {
+        RBTreeIterator {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns a mutable iterator over the tree nodes, sorted by key.
+    pub fn iter_mut(&mut self) -> RBTreeIteratorMut<'_, K, V> {
+        RBTreeIteratorMut {
+            _tree: PhantomData,
+            // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
+    pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
+        self.iter().map(|(k, _)| k)
+    }
+
+    /// Returns an iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values(&self) -> impl Iterator<Item = &'_ V> {
+        self.iter().map(|(_, v)| v)
+    }
+
+    /// Returns a mutable iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
+        self.iter_mut().map(|(_, v)| v)
+    }
+}
+
+impl<K, V> Default for RBTree<K, V> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<K, V> Drop for RBTree<K, V> {
+    fn drop(&mut self) {
+        // SAFETY: `root` is valid as it's embedded in `self` and we have a valid `self`.
+        let mut next = unsafe { bindings::rb_first_postorder(&self.root) };
+
+        // INVARIANT: The loop invariant is that all tree nodes from `next` in postorder are valid.
+        while !next.is_null() {
+            let this = crate::container_of!(next, Node<K, V>, links);
+
+            // Find out what the next node is before disposing of the current one.
+            // SAFETY: `next` and all nodes in postorder are still valid.
+            next = unsafe { bindings::rb_next_postorder(next) };
+
+            // INVARIANT: This is the destructor, so we break the type invariant during clean-up,
+            // but it is not observable. The loop invariant is still maintained.
+            // SAFETY: `this` is valid per the loop invariant.
+            unsafe { Box::from_raw(this as *mut Node<K, V>) };
+        }
+    }
+}
+
+impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
+    type Item = (&'a K, &'a V);
+    type IntoIter = RBTreeIterator<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+/// An iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter`].
+pub struct RBTreeIterator<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> Iterator for RBTreeIterator<'a, K, V> {
+    type Item = (&'a K, &'a V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        let cur = crate::container_of!(self.next, Node<K, V>, links);
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &(*cur).value) })
+    }
+}
+
+impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
+    type Item = (&'a K, &'a mut V);
+    type IntoIter = RBTreeIteratorMut<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// A mutable iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter_mut`].
+pub struct RBTreeIteratorMut<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> Iterator for RBTreeIteratorMut<'a, K, V> {
+    type Item = (&'a K, &'a mut V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        let cur = crate::container_of!(self.next, Node<K, V>, links) as *mut Node<K, V>;
+
+        // SAFETY: The reference to the tree used to create the iterator outlives the iterator, so
+        // the tree cannot change (except for the value of previous nodes, but those don't affect
+        // the iteration process). By the tree invariant, all nodes are valid.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &mut (*cur).value) })
+    }
+}
+
+/// A memory reservation for a red-black tree node.
+///
+/// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
+/// can be obtained by directly allocating it ([`RBTree::try_reserve_node`]) or by "uninitialising"
+/// ([`RBTreeNode::into_reservation`]) an actual node (usually returned by some operation like
+/// removal from a tree).
+pub struct RBTreeNodeReservation<K, V> {
+    node: Box<MaybeUninit<Node<K, V>>>,
+}
+
+impl<K, V> RBTreeNodeReservation<K, V> {
+    /// Initialises a node reservation.
+    ///
+    /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
+    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
+        let node_ptr = self.node.as_mut_ptr();
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).links).write(bindings::rb_node::default()) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).key).write(key) };
+        // SAFETY: `node_ptr` is valid, and so are its fields.
+        unsafe { addr_of_mut!((*node_ptr).value).write(value) };
+        let raw = Box::into_raw(self.node);
+        RBTreeNode {
+            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose fields have all been
+            // initialised. Additionally, it has the same layout as `Node`.
+            node: unsafe { Box::from_raw(raw as _) },
+        }
+    }
+}
+
+/// A red-black tree node.
+///
+/// The node is fully initialised (with key and value) and can be inserted into a tree without any
+/// extra allocations or failure paths.
+pub struct RBTreeNode<K, V> {
+    node: Box<Node<K, V>>,
+}
+
+impl<K, V> RBTreeNode<K, V> {
+    /// "Uninitialises" a node.
+    ///
+    /// It then becomes a reservation that can be re-initialised into a different node (i.e., with
+    /// a different key and/or value).
+    ///
+    /// The existing key and value are dropped in-place as part of this operation, that is, memory
+    /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
+    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
+        let raw = Box::into_raw(self.node);
+        let mut ret = RBTreeNodeReservation {
+            // SAFETY: The pointer came from a valid `Node`, which has the same layout as
+            // `MaybeUninit<Node>`.
+            node: unsafe { Box::from_raw(raw as _) },
+        };
+        // SAFETY: Although the type is `MaybeUninit<Node>`, we know it has been initialised
+        // because it came from a `Node`. So it is safe to drop it.
+        unsafe { core::ptr::drop_in_place(ret.node.as_mut_ptr()) };
+        ret
+    }
+}
diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
new file mode 100644
index 000000000000..9cc65ca3a1b6
--- /dev/null
+++ b/rust/kernel/revocable.rs
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Revocable objects.
+//!
+//! The [`Revocable`] type wraps other types and allows access to them to be revoked. The existence
+//! of a [`RevocableGuard`] ensures that objects remain valid.
+
+use crate::bindings;
+use core::{
+    cell::UnsafeCell,
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::drop_in_place,
+    sync::atomic::{AtomicBool, Ordering},
+};
+
+/// An object that can become inaccessible at runtime.
+///
+/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
+/// [`RevocableGuard`] are dropped), the wrapped object is also dropped.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::revocable::Revocable;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn add_two(v: &Revocable<Example>) -> Option<u32> {
+///     let guard = v.try_access()?;
+///     Some(guard.a + guard.b)
+/// }
+///
+/// fn example() {
+///     let v = Revocable::new(Example { a: 10, b: 20 });
+///     assert_eq!(add_two(&v), Some(30));
+///     v.revoke();
+///     assert_eq!(add_two(&v), None);
+/// }
+/// ```
+pub struct Revocable<T: ?Sized> {
+    is_available: AtomicBool,
+    data: ManuallyDrop<UnsafeCell<T>>,
+}
+
+// SAFETY: `Revocable` is `Send` if the wrapped object is also `Send`. This is because while the
+// functionality exposed by `Revocable` can be accessed from any thread/CPU, it is possible that
+// this isn't supported by the wrapped object.
+unsafe impl<T: ?Sized + Send> Send for Revocable<T> {}
+
+// SAFETY: `Revocable` is `Sync` if the wrapped object is both `Send` and `Sync`. We require `Send`
+// from the wrapped object as well because  of `Revocable::revoke`, which can trigger the `Drop`
+// implementation of the wrapped object from an arbitrary thread.
+unsafe impl<T: ?Sized + Sync + Send> Sync for Revocable<T> {}
+
+impl<T> Revocable<T> {
+    /// Creates a new revocable instance of the given data.
+    pub fn new(data: T) -> Self {
+        Self {
+            is_available: AtomicBool::new(true),
+            data: ManuallyDrop::new(UnsafeCell::new(data)),
+        }
+    }
+}
+
+impl<T: ?Sized> Revocable<T> {
+    /// Tries to access the \[revocable\] wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
+    /// remain accessible while the guard is alive. In such cases, callers are not allowed to sleep
+    /// because another CPU may be waiting to complete the revocation of this object.
+    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
+        let guard = RevocableGuard::new(self.data.get());
+        if self.is_available.load(Ordering::Relaxed) {
+            Some(guard)
+        } else {
+            None
+        }
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Access to the object is revoked immediately to new callers of [`Revocable::try_access`]. If
+    /// there are concurrent users of the object (i.e., ones that called [`Revocable::try_access`]
+    /// beforehand and still haven't dropped the returned guard), this function waits for the
+    /// concurrent access to complete before dropping the wrapped object.
+    pub fn revoke(&self) {
+        if self
+            .is_available
+            .compare_exchange(true, false, Ordering::Relaxed, Ordering::Relaxed)
+            .is_ok()
+        {
+            // SAFETY: Just an FFI call, there are no further requirements.
+            unsafe { bindings::synchronize_rcu() };
+
+            // SAFETY: We know `self.data` is valid because only one CPU can succeed the
+            // `compare_exchange` above that takes `is_available` from `true` to `false`.
+            unsafe { drop_in_place(self.data.get()) };
+        }
+    }
+}
+
+impl<T: ?Sized> Drop for Revocable<T> {
+    fn drop(&mut self) {
+        // Drop only if the data hasn't been revoked yet (in which case it has already been
+        // dropped).
+        if *self.is_available.get_mut() {
+            // SAFETY: We know `self.data` is valid because no other CPU has changed
+            // `is_available` to `false` yet, and no other CPU can do it anymore because this CPU
+            // holds the only reference (mutable) to `self` now.
+            unsafe { drop_in_place(self.data.get()) };
+        }
+    }
+}
+
+/// A guard that allows access to a revocable object and keeps it alive.
+///
+/// CPUs may not sleep while holding on to [`RevocableGuard`] because it's in atomic context
+/// holding the RCU read-side lock.
+///
+/// # Invariants
+///
+/// The RCU read-side lock is held while the guard is alive.
+pub struct RevocableGuard<'a, T: ?Sized> {
+    data_ref: *const T,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> RevocableGuard<'_, T> {
+    fn new(data_ref: *const T) -> Self {
+        // SAFETY: Just an FFI call, there are no further requirements.
+        unsafe { bindings::rcu_read_lock() };
+
+        // INVARIANTS: The RCU read-side lock was just acquired.
+        Self {
+            data_ref,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> Drop for RevocableGuard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that we hold the RCU read-side lock.
+        unsafe { bindings::rcu_read_unlock() };
+    }
+}
+
+impl<T: ?Sized> Deref for RevocableGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariants, we hold the rcu read-side lock, so the object is
+        // guaranteed to remain valid.
+        unsafe { &*self.data_ref }
+    }
+}
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..2004d01233f4
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](../../../../include/linux/security.h).
+
+use crate::{bindings, cred::Credential, file::File, to_result, Result};
+
+/// Calls the security modules to determine if the given task can become the manager of a binder
+/// context.
+pub fn binder_set_context_mgr(mgr: &Credential) -> Result {
+    // SAFETY: By the `Credential` invariants, `mgr.ptr` is valid.
+    to_result(|| unsafe { bindings::security_binder_set_context_mgr(mgr.ptr) })
+}
+
+/// Calls the security modules to determine if binder transactions are allowed from task `from` to
+/// task `to`.
+pub fn binder_transaction(from: &Credential, to: &Credential) -> Result {
+    // SAFETY: By the `Credential` invariants, `from.ptr` and `to.ptr` are valid.
+    to_result(|| unsafe { bindings::security_binder_transaction(from.ptr, to.ptr) })
+}
+
+/// Calls the security modules to determine if task `from` is allowed to send binder objects
+/// (owned by itself or other processes) to task `to` through a binder transaction.
+pub fn binder_transfer_binder(from: &Credential, to: &Credential) -> Result {
+    // SAFETY: By the `Credential` invariants, `from.ptr` and `to.ptr` are valid.
+    to_result(|| unsafe { bindings::security_binder_transfer_binder(from.ptr, to.ptr) })
+}
+
+/// Calls the security modules to determine if task `from` is allowed to send the given file to
+/// task `to` (which would get its own file descriptor) through a binder transaction.
+pub fn binder_transfer_file(from: &Credential, to: &Credential, file: &File) -> Result {
+    // SAFETY: By the `Credential` invariants, `from.ptr` and `to.ptr` are valid. Similarly, by the
+    // `File` invariants, `file.ptr` is also valid.
+    to_result(|| unsafe { bindings::security_binder_transfer_file(from.ptr, to.ptr, file.ptr) })
+}
diff --git a/rust/kernel/static_assert.rs b/rust/kernel/static_assert.rs
new file mode 100644
index 000000000000..a80d8ab57564
--- /dev/null
+++ b/rust/kernel/static_assert.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Static assert.
+
+/// Static assert (i.e. compile-time assert).
+///
+/// Similar to C11 [`_Static_assert`] and C++11 [`static_assert`].
+///
+/// The feature may be added to Rust in the future: see [RFC 2790].
+///
+/// [`_Static_assert`]: https://en.cppreference.com/w/c/language/_Static_assert
+/// [`static_assert`]: https://en.cppreference.com/w/cpp/language/static_assert
+/// [RFC 2790]: https://github.com/rust-lang/rfcs/issues/2790
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// static_assert!(42 > 24);
+/// static_assert!(core::mem::size_of::<u8>() == 1);
+///
+/// const X: &[u8] = b"bar";
+/// static_assert!(X[1] == 'a' as u8);
+///
+/// const fn f(x: i32) -> i32 {
+///     x + 2
+/// }
+/// static_assert!(f(40) == 42);
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($condition:expr) => {
+        // Based on the latest one in `rustc`'s one before it was [removed].
+        //
+        // [removed]: https://github.com/rust-lang/rust/commit/c2dad1c6b9f9636198d7c561b47a2974f5103f6d
+        #[allow(dead_code)]
+        const _: () = [()][!($condition) as usize];
+    };
+}
diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
new file mode 100644
index 000000000000..492388d7ce10
--- /dev/null
+++ b/rust/kernel/std_vendor.rs
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! The contents of this file come from the Rust standard library, hosted in the
+//! <https://github.com/rust-lang/rust> repository. For copyright details, see
+//! <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
+
+/// [`std::dbg`], but using [`pr_info`] instead of [`eprintln`].
+///
+/// Prints and returns the value of a given expression for quick and dirty
+/// debugging.
+///
+/// An example:
+///
+/// ```rust
+/// let a = 2;
+/// let b = dbg!(a * 2) + 1;
+/// //      ^-- prints: [src/main.rs:2] a * 2 = 4
+/// assert_eq!(b, 5);
+/// ```
+///
+/// The macro works by using the `Debug` implementation of the type of
+/// the given expression to print the value with [`printk`] along with the
+/// source location of the macro invocation as well as the source code
+/// of the expression.
+///
+/// Invoking the macro on an expression moves and takes ownership of it
+/// before returning the evaluated expression unchanged. If the type
+/// of the expression does not implement `Copy` and you don't want
+/// to give up ownership, you can instead borrow with `dbg!(&expr)`
+/// for some expression `expr`.
+///
+/// The `dbg!` macro works exactly the same in release builds.
+/// This is useful when debugging issues that only occur in release
+/// builds or when debugging in release mode is significantly faster.
+///
+/// Note that the macro is intended as a debugging tool and therefore you
+/// should avoid having uses of it in version control for long periods
+/// (other than in tests and similar).
+///
+/// # Stability
+///
+/// The exact output printed by this macro should not be relied upon
+/// and is subject to future changes.
+///
+/// # Further examples
+///
+/// With a method call:
+///
+/// ```rust
+/// fn foo(n: usize) {
+///     if let Some(_) = dbg!(n.checked_sub(4)) {
+///         // ...
+///     }
+/// }
+///
+/// foo(3)
+/// ```
+///
+/// This prints to the kernel log:
+///
+/// ```text,ignore
+/// [src/main.rs:4] n.checked_sub(4) = None
+/// ```
+///
+/// Naive factorial implementation:
+///
+/// ```rust
+/// fn factorial(n: u32) -> u32 {
+///     if dbg!(n <= 1) {
+///         dbg!(1)
+///     } else {
+///         dbg!(n * factorial(n - 1))
+///     }
+/// }
+///
+/// dbg!(factorial(4));
+/// ```
+///
+/// This prints to the kernel log:
+///
+/// ```text,ignore
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = false
+/// [src/main.rs:3] n <= 1 = true
+/// [src/main.rs:4] 1 = 1
+/// [src/main.rs:5] n * factorial(n - 1) = 2
+/// [src/main.rs:5] n * factorial(n - 1) = 6
+/// [src/main.rs:5] n * factorial(n - 1) = 24
+/// [src/main.rs:11] factorial(4) = 24
+/// ```
+///
+/// The `dbg!(..)` macro moves the input:
+///
+/// ```compile_fail
+/// /// A wrapper around `usize` which importantly is not Copyable.
+/// #[derive(Debug)]
+/// struct NoCopy(usize);
+///
+/// let a = NoCopy(42);
+/// let _ = dbg!(a); // <-- `a` is moved here.
+/// let _ = dbg!(a); // <-- `a` is moved again; error!
+/// ```
+///
+/// You can also use `dbg!()` without a value to just print the
+/// file and line whenever it's reached.
+///
+/// Finally, if you want to `dbg!(..)` multiple values, it will treat them as
+/// a tuple (and return it, too):
+///
+/// ```
+/// assert_eq!(dbg!(1usize, 2u32), (1, 2));
+/// ```
+///
+/// However, a single argument with a trailing comma will still not be treated
+/// as a tuple, following the convention of ignoring trailing commas in macro
+/// invocations. You can use a 1-tuple directly if you need one:
+///
+/// ```
+/// assert_eq!(1, dbg!(1u32,)); // trailing comma ignored
+/// assert_eq!((1,), dbg!((1u32,))); // 1-tuple
+/// ```
+///
+/// [`std::dbg`]: https://doc.rust-lang.org/std/macro.dbg.html
+/// [`eprintln`]: https://doc.rust-lang.org/std/macro.eprintln.html
+/// [`printk`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html
+#[macro_export]
+macro_rules! dbg {
+    // NOTE: We cannot use `concat!` to make a static string as a format argument
+    // of `pr_info!` because `file!` could contain a `{` or
+    // `$val` expression could be a block (`{ .. }`), in which case the `pr_info!`
+    // will be malformed.
+    () => {
+        $crate::pr_info!("[{}:{}]\n", ::core::file!(), ::core::line!())
+    };
+    ($val:expr $(,)?) => {
+        // Use of `match` here is intentional because it affects the lifetimes
+        // of temporaries - https://stackoverflow.com/a/48732525/1063961
+        match $val {
+            tmp => {
+                $crate::pr_info!("[{}:{}] {} = {:#?}\n",
+                    ::core::file!(), ::core::line!(), ::core::stringify!($val), &tmp);
+                tmp
+            }
+        }
+    };
+    ($($val:expr),+ $(,)?) => {
+        ($($crate::dbg!($val)),+,)
+    };
+}
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
new file mode 100644
index 000000000000..0be85038c0d5
--- /dev/null
+++ b/rust/kernel/str.rs
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! String representations.
+
+use alloc::vec::Vec;
+use core::fmt::{self, Write};
+use core::ops::{self, Deref, Index};
+
+use crate::{bindings, c_types, error::code::*, Error};
+
+/// Byte string without UTF-8 validity guarantee.
+///
+/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
+pub type BStr = [u8];
+
+/// Creates a new [`BStr`] from a string literal.
+///
+/// `b_str!` converts the supplied string literal to byte string, so non-ASCII
+/// characters can be included.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::b_str;
+/// # use kernel::str::BStr;
+/// const MY_BSTR: &'static BStr = b_str!("My awesome BStr!");
+/// ```
+#[macro_export]
+macro_rules! b_str {
+    ($str:literal) => {{
+        const S: &'static str = $str;
+        const C: &'static $crate::str::BStr = S.as_bytes();
+        C
+    }};
+}
+
+/// Possible errors when using conversion functions in [`CStr`].
+#[derive(Debug, Clone, Copy)]
+pub enum CStrConvertError {
+    /// Supplied bytes contain an interior `NUL`.
+    InteriorNul,
+
+    /// Supplied bytes are not terminated by `NUL`.
+    NotNulTerminated,
+}
+
+impl From<CStrConvertError> for Error {
+    #[inline]
+    fn from(_: CStrConvertError) -> Error {
+        EINVAL
+    }
+}
+
+/// A string that is guaranteed to have exactly one `NUL` byte, which is at the
+/// end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+#[repr(transparent)]
+pub struct CStr([u8]);
+
+impl CStr {
+    /// Returns the length of this string excluding `NUL`.
+    #[inline]
+    pub const fn len(&self) -> usize {
+        self.len_with_nul() - 1
+    }
+
+    /// Returns the length of this string with `NUL`.
+    #[inline]
+    pub const fn len_with_nul(&self) -> usize {
+        // SAFETY: This is one of the invariant of `CStr`.
+        // We add a `unreachable_unchecked` here to hint the optimizer that
+        // the value returned from this function is non-zero.
+        if self.0.is_empty() {
+            unsafe { core::hint::unreachable_unchecked() };
+        }
+        self.0.len()
+    }
+
+    /// Returns `true` if the string only includes `NUL`.
+    #[inline]
+    pub const fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Wraps a raw C string pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
+    /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
+    /// must not be mutated.
+    #[inline]
+    pub unsafe fn from_char_ptr<'a>(ptr: *const c_types::c_char) -> &'a Self {
+        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
+        // to a `NUL`-terminated C string.
+        let len = unsafe { bindings::strlen(ptr) } + 1;
+        // SAFETY: Lifetime guaranteed by the safety precondition.
+        let bytes = unsafe { core::slice::from_raw_parts(ptr as _, len as _) };
+        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
+        // As we have added 1 to `len`, the last byte is known to be `NUL`.
+        unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
+    }
+
+    /// Creates a [`CStr`] from a `[u8]`.
+    ///
+    /// The provided slice must be `NUL`-terminated, does not contain any
+    /// interior `NUL` bytes.
+    pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError> {
+        if bytes.is_empty() {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        if bytes[bytes.len() - 1] != 0 {
+            return Err(CStrConvertError::NotNulTerminated);
+        }
+        let mut i = 0;
+        // `i + 1 < bytes.len()` allows LLVM to optimize away bounds checking,
+        // while it couldn't optimize away bounds checks for `i < bytes.len() - 1`.
+        while i + 1 < bytes.len() {
+            if bytes[i] == 0 {
+                return Err(CStrConvertError::InteriorNul);
+            }
+            i += 1;
+        }
+        // SAFETY: We just checked that all properties hold.
+        Ok(unsafe { Self::from_bytes_with_nul_unchecked(bytes) })
+    }
+
+    /// Creates a [`CStr`] from a `[u8]`, panic if input is not valid.
+    ///
+    /// This function is only meant to be used by `c_str!` macro, so
+    /// crates using `c_str!` macro don't have to enable `const_panic` feature.
+    #[doc(hidden)]
+    pub const fn from_bytes_with_nul_unwrap(bytes: &[u8]) -> &Self {
+        match Self::from_bytes_with_nul(bytes) {
+            Ok(v) => v,
+            Err(_) => panic!("string contains interior NUL"),
+        }
+    }
+
+    /// Creates a [`CStr`] from a `[u8]` without performing any additional
+    /// checks.
+    ///
+    /// # Safety
+    ///
+    /// `bytes` *must* end with a `NUL` byte, and should only have a single
+    /// `NUL` byte (or the string will be truncated).
+    #[inline]
+    pub const unsafe fn from_bytes_with_nul_unchecked(bytes: &[u8]) -> &CStr {
+        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
+        unsafe { core::mem::transmute(bytes) }
+    }
+
+    /// Returns a C pointer to the string.
+    #[inline]
+    pub const fn as_char_ptr(&self) -> *const c_types::c_char {
+        self.0.as_ptr() as _
+    }
+
+    /// Convert the string to a byte slice without the trailing 0 byte.
+    #[inline]
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.0[..self.len()]
+    }
+
+    /// Convert the string to a byte slice containing the trailing 0 byte.
+    #[inline]
+    pub const fn as_bytes_with_nul(&self) -> &[u8] {
+        &self.0
+    }
+
+    /// Yields a [`&str`] slice if the [`CStr`] contains valid UTF-8.
+    ///
+    /// If the contents of the [`CStr`] are valid UTF-8 data, this
+    /// function will return the corresponding [`&str`] slice. Otherwise,
+    /// it will return an error with details of where UTF-8 validation failed.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::str::CStr;
+    /// let cstr = CStr::from_bytes_with_nul(b"foo\0").unwrap();
+    /// assert_eq!(cstr.to_str(), Ok("foo"));
+    /// ```
+    #[inline]
+    pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
+        core::str::from_utf8(self.as_bytes())
+    }
+
+    /// Unsafely convert this [`CStr`] into a [`&str`], without checking for
+    /// valid UTF-8.
+    ///
+    /// # Safety
+    ///
+    /// The contents must be valid UTF-8.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// // SAFETY: String literals are guaranteed to be valid UTF-8
+    /// // by the Rust compiler.
+    /// let bar = c_str!("ツ");
+    /// assert_eq!(unsafe { bar.as_str_unchecked() }, "ツ");
+    /// ```
+    #[inline]
+    pub unsafe fn as_str_unchecked(&self) -> &str {
+        unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
+    }
+}
+
+impl fmt::Display for CStr {
+    /// Formats printable ASCII characters, escaping the rest.
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// let penguin = c_str!("🐧");
+    /// assert_eq!(format!("{}", penguin), "\\xf0\\x9f\\x90\\xa7");
+    ///
+    /// let ascii = c_str!("so \"cool\"");
+    /// assert_eq!(format!("{}", ascii), "so \"cool\"");
+    /// ```
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        for &c in self.as_bytes() {
+            if (0x20..0x7f).contains(&c) {
+                // Printable character
+                f.write_char(c as char)?;
+            } else {
+                write!(f, "\\x{:02x}", c)?;
+            }
+        }
+        Ok(())
+    }
+}
+
+impl fmt::Debug for CStr {
+    /// Formats printable ASCII characters with a double quote on either end, escaping the rest.
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::str::CStr;
+    /// let penguin = c_str!("🐧");
+    /// assert_eq!(format!("{:?}", penguin), "\"\\xf0\\x9f\\x90\\xa7\"");
+    ///
+    /// // embedded double quotes are escaped
+    /// let ascii = c_str!("so \"cool\"");
+    /// assert_eq!(format!("{:?}", ascii), "\"so \\\"cool\\\"\"");
+    /// ```
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.write_str("\"")?;
+        for &c in self.as_bytes() {
+            match c {
+                // Printable characters
+                b'\"' => f.write_str("\\\"")?,
+                0x20..=0x7e => f.write_char(c as char)?,
+                _ => write!(f, "\\x{:02x}", c)?,
+            }
+        }
+        f.write_str("\"")
+    }
+}
+
+impl AsRef<BStr> for CStr {
+    #[inline]
+    fn as_ref(&self) -> &BStr {
+        self.as_bytes()
+    }
+}
+
+impl Deref for CStr {
+    type Target = BStr;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_bytes()
+    }
+}
+
+impl Index<ops::RangeFrom<usize>> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, index: ops::RangeFrom<usize>) -> &Self::Output {
+        // Delegate bounds checking to slice.
+        // Assign to _ to mute clippy's unnecessary operation warning.
+        let _ = &self.as_bytes()[index.start..];
+        // SAFETY: We just checked the bounds.
+        unsafe { Self::from_bytes_with_nul_unchecked(&self.0[index.start..]) }
+    }
+}
+
+impl Index<ops::RangeFull> for CStr {
+    type Output = CStr;
+
+    #[inline]
+    fn index(&self, _index: ops::RangeFull) -> &Self::Output {
+        self
+    }
+}
+
+mod private {
+    use core::ops;
+
+    // Marker trait for index types that can be forward to `BStr`.
+    pub trait CStrIndex {}
+
+    impl CStrIndex for usize {}
+    impl CStrIndex for ops::Range<usize> {}
+    impl CStrIndex for ops::RangeInclusive<usize> {}
+    impl CStrIndex for ops::RangeToInclusive<usize> {}
+}
+
+impl<Idx> Index<Idx> for CStr
+where
+    Idx: private::CStrIndex,
+    BStr: Index<Idx>,
+{
+    type Output = <BStr as Index<Idx>>::Output;
+
+    #[inline]
+    fn index(&self, index: Idx) -> &Self::Output {
+        &self.as_bytes()[index]
+    }
+}
+
+/// Creates a new [`CStr`] from a string literal.
+///
+/// The string literal should not contain any `NUL` bytes.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::c_str;
+/// # use kernel::str::CStr;
+/// const MY_CSTR: &'static CStr = c_str!("My awesome CStr!");
+/// ```
+#[macro_export]
+macro_rules! c_str {
+    ($str:expr) => {{
+        const S: &str = concat!($str, "\0");
+        const C: &$crate::str::CStr = $crate::str::CStr::from_bytes_with_nul_unwrap(S.as_bytes());
+        C
+    }};
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_cstr_to_str() {
+        let good_bytes = b"\xf0\x9f\xa6\x80\0";
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
+        let checked_str = checked_cstr.to_str().unwrap();
+        assert_eq!(checked_str, "🦀");
+    }
+
+    #[test]
+    #[should_panic]
+    fn test_cstr_to_str_panic() {
+        let bad_bytes = b"\xc3\x28\0";
+        let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
+        checked_cstr.to_str().unwrap();
+    }
+
+    #[test]
+    fn test_cstr_as_str_unchecked() {
+        let good_bytes = b"\xf0\x9f\x90\xA7\0";
+        let checked_cstr = CStr::from_bytes_with_nul(good_bytes).unwrap();
+        let unchecked_str = unsafe { checked_cstr.as_str_unchecked() };
+        assert_eq!(unchecked_str, "🐧");
+    }
+}
+
+/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
+///
+/// It does not fail if callers write past the end of the buffer so that they can calculate the
+/// size required to fit everything.
+///
+/// # Invariants
+///
+/// The memory region between `pos` (inclusive) and `end` (exclusive) is valid for writes if `pos`
+/// is less than `end`.
+pub(crate) struct RawFormatter {
+    // Use `usize` to use `saturating_*` functions.
+    beg: usize,
+    pos: usize,
+    end: usize,
+}
+
+impl RawFormatter {
+    /// Creates a new instance of [`RawFormatter`] with an empty buffer.
+    fn new() -> Self {
+        // INVARIANT: The buffer is empty, so the region that needs to be writable is empty.
+        Self {
+            beg: 0,
+            pos: 0,
+            end: 0,
+        }
+    }
+
+    /// Creates a new instance of [`RawFormatter`] with the given buffer pointers.
+    ///
+    /// # Safety
+    ///
+    /// If `pos` is less than `end`, then the region between `pos` (inclusive) and `end`
+    /// (exclusive) must be valid for writes for the lifetime of the returned [`RawFormatter`].
+    pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
+        // INVARIANT: The safety requierments guarantee the type invariants.
+        Self {
+            beg: pos as _,
+            pos: pos as _,
+            end: end as _,
+        }
+    }
+
+    /// Creates a new instance of [`RawFormatter`] with the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
+    /// for the lifetime of the returned [`RawFormatter`].
+    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
+        let pos = buf as usize;
+        // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
+        // guarantees that the memory region is valid for writes.
+        Self {
+            pos,
+            beg: pos,
+            end: pos.saturating_add(len),
+        }
+    }
+
+    /// Returns the current insert position.
+    ///
+    /// N.B. It may point to invalid memory.
+    pub(crate) fn pos(&self) -> *mut u8 {
+        self.pos as _
+    }
+
+    /// Return the number of bytes written to the formatter.
+    pub(crate) fn bytes_written(&self) -> usize {
+        self.pos - self.beg
+    }
+}
+
+impl fmt::Write for RawFormatter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        // `pos` value after writing `len` bytes. This does not have to be bounded by `end`, but we
+        // don't want it to wrap around to 0.
+        let pos_new = self.pos.saturating_add(s.len());
+
+        // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
+        let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);
+
+        if len_to_copy > 0 {
+            // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
+            // yet, so it is valid for write per the type invariants.
+            unsafe {
+                core::ptr::copy_nonoverlapping(
+                    s.as_bytes().as_ptr(),
+                    self.pos as *mut u8,
+                    len_to_copy,
+                )
+            };
+        }
+
+        self.pos = pos_new;
+        Ok(())
+    }
+}
+
+/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
+///
+/// Fails if callers attempt to write more than will fit in the buffer.
+pub(crate) struct Formatter(RawFormatter);
+
+impl Formatter {
+    /// Creates a new instance of [`Formatter`] with the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
+    /// for the lifetime of the returned [`Formatter`].
+    pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
+        // SAFETY: The safety requirements of this function satisfy those of the callee.
+        Self(unsafe { RawFormatter::from_buffer(buf, len) })
+    }
+}
+
+impl Deref for Formatter {
+    type Target = RawFormatter;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl fmt::Write for Formatter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        self.0.write_str(s)?;
+
+        // Fail the request if we go past the end of the buffer.
+        if self.0.pos > self.0.end {
+            Err(fmt::Error)
+        } else {
+            Ok(())
+        }
+    }
+}
+
+/// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
+///
+/// Used for interoperability with kernel APIs that take C strings.
+///
+/// # Invariants
+///
+/// The string is always `NUL`-terminated and contains no other `NUL` bytes.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::str::CString;
+///
+/// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwrap();
+/// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
+///
+/// let tmp = "testing";
+/// let s = CString::try_from_fmt(fmt!("{tmp}{}", 123)).unwrap();
+/// assert_eq!(s.as_bytes_with_nul(), "testing123\0".as_bytes());
+///
+/// // This fails because it has an embedded `NUL` byte.
+/// let s = CString::try_from_fmt(fmt!("a\0b{}", 123));
+/// assert_eq!(s.is_ok(), false);
+/// ```
+pub struct CString {
+    buf: Vec<u8>,
+}
+
+impl CString {
+    /// Creates an instance of [`CString`] from the given formatted arguments.
+    pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
+        // Calculate the size needed (formatted string plus `NUL` terminator).
+        let mut f = RawFormatter::new();
+        f.write_fmt(args)?;
+        f.write_str("\0")?;
+        let size = f.bytes_written();
+
+        // Allocate a vector with the required number of bytes, and write to it.
+        let mut buf = Vec::try_with_capacity(size)?;
+        // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
+        let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
+        f.write_fmt(args)?;
+        f.write_str("\0")?;
+
+        // SAFETY: The number of bytes that can be written to `f` is bounded by `size`, which is
+        // `buf`'s capacity. The contents of the buffer have been initialised by writes to `f`.
+        unsafe { buf.set_len(f.bytes_written()) };
+
+        // Check that there are no `NUL` bytes before the end.
+        // SAFETY: The buffer is valid for read because `f.bytes_written()` is bounded by `size`
+        // (which the minimum buffer size) and is non-zero (we wrote at least the `NUL` terminator)
+        // so `f.bytes_written() - 1` doesn't underflow.
+        let ptr = unsafe { bindings::memchr(buf.as_ptr().cast(), 0, (f.bytes_written() - 1) as _) };
+        if !ptr.is_null() {
+            return Err(EINVAL);
+        }
+
+        // INVARIANT: We wrote the `NUL` terminator and checked above that no other `NUL` bytes
+        // exist in the buffer.
+        Ok(Self { buf })
+    }
+}
+
+impl Deref for CString {
+    type Target = CStr;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the string is `NUL`-terminated and that no
+        // other `NUL` bytes exist.
+        unsafe { CStr::from_bytes_with_nul_unchecked(self.buf.as_slice()) }
+    }
+}
+
+/// A convenience alias for [`core::format_args`].
+#[macro_export]
+macro_rules! fmt {
+    ($($f:tt)*) => ( core::format_args!($($f)*) )
+}
diff --git a/rust/kernel/sysctl.rs b/rust/kernel/sysctl.rs
new file mode 100644
index 000000000000..63bf76d03d93
--- /dev/null
+++ b/rust/kernel/sysctl.rs
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! System control.
+//!
+//! C header: [`include/linux/sysctl.h`](../../../../include/linux/sysctl.h)
+//!
+//! Reference: <https://www.kernel.org/doc/Documentation/sysctl/README>
+
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+use core::mem;
+use core::ptr;
+use core::sync::atomic;
+
+use crate::{
+    bindings, c_types,
+    error::code::*,
+    io_buffer::IoBufferWriter,
+    str::CStr,
+    types,
+    user_ptr::{UserSlicePtr, UserSlicePtrWriter},
+    Result,
+};
+
+/// Sysctl storage.
+pub trait SysctlStorage: Sync {
+    /// Writes a byte slice.
+    fn store_value(&self, data: &[u8]) -> (usize, Result);
+
+    /// Reads via a [`UserSlicePtrWriter`].
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, Result);
+}
+
+fn trim_whitespace(mut data: &[u8]) -> &[u8] {
+    while !data.is_empty() && (data[0] == b' ' || data[0] == b'\t' || data[0] == b'\n') {
+        data = &data[1..];
+    }
+    while !data.is_empty()
+        && (data[data.len() - 1] == b' '
+            || data[data.len() - 1] == b'\t'
+            || data[data.len() - 1] == b'\n')
+    {
+        data = &data[..data.len() - 1];
+    }
+    data
+}
+
+impl<T> SysctlStorage for &T
+where
+    T: SysctlStorage,
+{
+    fn store_value(&self, data: &[u8]) -> (usize, Result) {
+        (*self).store_value(data)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, Result) {
+        (*self).read_value(data)
+    }
+}
+
+impl SysctlStorage for atomic::AtomicBool {
+    fn store_value(&self, data: &[u8]) -> (usize, Result) {
+        let result = match trim_whitespace(data) {
+            b"0" => {
+                self.store(false, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            b"1" => {
+                self.store(true, atomic::Ordering::Relaxed);
+                Ok(())
+            }
+            _ => Err(EINVAL),
+        };
+        (data.len(), result)
+    }
+
+    fn read_value(&self, data: &mut UserSlicePtrWriter) -> (usize, Result) {
+        let value = if self.load(atomic::Ordering::Relaxed) {
+            b"1\n"
+        } else {
+            b"0\n"
+        };
+        (value.len(), data.write_slice(value))
+    }
+}
+
+/// Holds a single `sysctl` entry (and its table).
+pub struct Sysctl<T: SysctlStorage> {
+    inner: Box<T>,
+    // Responsible for keeping the `ctl_table` alive.
+    _table: Box<[bindings::ctl_table]>,
+    header: *mut bindings::ctl_table_header,
+}
+
+// SAFETY: The only public method we have is `get()`, which returns `&T`, and
+// `T: Sync`. Any new methods must adhere to this requirement.
+unsafe impl<T: SysctlStorage> Sync for Sysctl<T> {}
+
+unsafe extern "C" fn proc_handler<T: SysctlStorage>(
+    ctl: *mut bindings::ctl_table,
+    write: c_types::c_int,
+    buffer: *mut c_types::c_void,
+    len: *mut usize,
+    ppos: *mut bindings::loff_t,
+) -> c_types::c_int {
+    // If we are reading from some offset other than the beginning of the file,
+    // return an empty read to signal EOF.
+    if unsafe { *ppos } != 0 && write == 0 {
+        unsafe { *len = 0 };
+        return 0;
+    }
+
+    let data = unsafe { UserSlicePtr::new(buffer, *len) };
+    let storage = unsafe { &*((*ctl).data as *const T) };
+    let (bytes_processed, result) = if write != 0 {
+        let data = match data.read_all() {
+            Ok(r) => r,
+            Err(e) => return e.to_kernel_errno(),
+        };
+        storage.store_value(&data)
+    } else {
+        let mut writer = data.writer();
+        storage.read_value(&mut writer)
+    };
+    unsafe { *len = bytes_processed };
+    unsafe { *ppos += *len as bindings::loff_t };
+    match result {
+        Ok(()) => 0,
+        Err(e) => e.to_kernel_errno(),
+    }
+}
+
+impl<T: SysctlStorage> Sysctl<T> {
+    /// Registers a single entry in `sysctl`.
+    pub fn register(
+        path: &'static CStr,
+        name: &'static CStr,
+        storage: T,
+        mode: types::Mode,
+    ) -> Result<Sysctl<T>> {
+        if name.contains(&b'/') {
+            return Err(EINVAL);
+        }
+
+        let storage = Box::try_new(storage)?;
+        let mut table = Vec::try_with_capacity(2)?;
+        table.try_push(bindings::ctl_table {
+            procname: name.as_char_ptr(),
+            mode: mode.as_int(),
+            data: &*storage as *const T as *mut c_types::c_void,
+            proc_handler: Some(proc_handler::<T>),
+
+            maxlen: 0,
+            child: ptr::null_mut(),
+            poll: ptr::null_mut(),
+            extra1: ptr::null_mut(),
+            extra2: ptr::null_mut(),
+        })?;
+        table.try_push(unsafe { mem::zeroed() })?;
+        let mut table = table.try_into_boxed_slice()?;
+
+        let result = unsafe { bindings::register_sysctl(path.as_char_ptr(), table.as_mut_ptr()) };
+        if result.is_null() {
+            return Err(ENOMEM);
+        }
+
+        Ok(Sysctl {
+            inner: storage,
+            _table: table,
+            header: result,
+        })
+    }
+
+    /// Gets the storage.
+    pub fn get(&self) -> &T {
+        &self.inner
+    }
+}
+
+impl<T: SysctlStorage> Drop for Sysctl<T> {
+    fn drop(&mut self) {
+        unsafe {
+            bindings::unregister_sysctl_table(self.header);
+        }
+        self.header = ptr::null_mut();
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_trim_whitespace() {
+        assert_eq!(trim_whitespace(b"foo    "), b"foo");
+        assert_eq!(trim_whitespace(b"    foo"), b"foo");
+        assert_eq!(trim_whitespace(b"  foo  "), b"foo");
+    }
+}
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
new file mode 100644
index 000000000000..7a2aff0e9219
--- /dev/null
+++ b/rust/kernel/task.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Tasks (threads and processes).
+//!
+//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
+
+use crate::bindings;
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref};
+
+/// Wraps the kernel's `struct task_struct`.
+///
+/// # Invariants
+///
+/// The pointer `Task::ptr` is non-null and valid. Its reference count is also non-zero.
+///
+/// # Examples
+///
+/// The following is an example of getting the PID of the current thread with zero additional cost
+/// when compared to the C version:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// # fn test() {
+/// Task::current().pid();
+/// # }
+/// ```
+///
+/// Getting the PID of the current process, also zero additional cost:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// # fn test() {
+/// Task::current().group_leader().pid();
+/// # }
+/// ```
+///
+/// Getting the current task and storing it in some struct. The reference count is automatically
+/// incremented when creating `State` and decremented when it is dropped:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::task::Task;
+///
+/// struct State {
+///     creator: Task,
+///     index: u32,
+/// }
+///
+/// impl State {
+///     fn new() -> Self {
+///         Self {
+///             creator: Task::current().clone(),
+///             index: 0,
+///         }
+///     }
+/// }
+/// ```
+pub struct Task {
+    pub(crate) ptr: *mut bindings::task_struct,
+}
+
+// SAFETY: Given that the task is referenced, it is OK to send it to another thread.
+unsafe impl Send for Task {}
+
+// SAFETY: It's OK to access `Task` through references from other threads because we're either
+// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
+// synchronised by C code (e.g., `signal_pending`).
+unsafe impl Sync for Task {}
+
+/// The type of process identifiers (PIDs).
+type Pid = bindings::pid_t;
+
+impl Task {
+    /// Returns a task reference for the currently executing task/thread.
+    pub fn current<'a>() -> TaskRef<'a> {
+        // SAFETY: Just an FFI call.
+        let ptr = unsafe { bindings::get_current() };
+
+        // SAFETY: If the current thread is still running, the current task is valid. Given
+        // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread (where
+        // it could potentially outlive the caller).
+        unsafe { TaskRef::from_ptr(ptr) }
+    }
+
+    /// Returns the group leader of the given task.
+    pub fn group_leader(&self) -> TaskRef<'_> {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        let ptr = unsafe { (*self.ptr).group_leader };
+
+        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
+        // and given that a task has a reference to its group leader, we know it must be valid for
+        // the lifetime of the returned task reference.
+        unsafe { TaskRef::from_ptr(ptr) }
+    }
+
+    /// Returns the PID of the given task.
+    pub fn pid(&self) -> Pid {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        unsafe { (*self.ptr).pid }
+    }
+
+    /// Determines whether the given task has pending signals.
+    pub fn signal_pending(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.ptr` is non-null and valid.
+        unsafe { bindings::signal_pending(self.ptr) != 0 }
+    }
+}
+
+impl PartialEq for Task {
+    fn eq(&self, other: &Self) -> bool {
+        self.ptr == other.ptr
+    }
+}
+
+impl Eq for Task {}
+
+impl Clone for Task {
+    fn clone(&self) -> Self {
+        // SAFETY: The type invariants guarantee that `self.ptr` has a non-zero reference count.
+        unsafe { bindings::get_task_struct(self.ptr) };
+
+        // INVARIANT: We incremented the reference count to account for the new `Task` being
+        // created.
+        Self { ptr: self.ptr }
+    }
+}
+
+impl Drop for Task {
+    fn drop(&mut self) {
+        // INVARIANT: We may decrement the refcount to zero, but the `Task` is being dropped, so
+        // this is not observable.
+        // SAFETY: The type invariants guarantee that `Task::ptr` has a non-zero reference count.
+        unsafe { bindings::put_task_struct(self.ptr) };
+    }
+}
+
+/// A wrapper for [`Task`] that doesn't automatically decrement the refcount when dropped.
+///
+/// We need the wrapper because [`ManuallyDrop`] alone would allow callers to call
+/// [`ManuallyDrop::into_inner`]. This would allow an unsafe sequence to be triggered without
+/// `unsafe` blocks because it would trigger an unbalanced call to `put_task_struct`.
+///
+/// We make this explicitly not [`Send`] so that we can use it to represent the current thread
+/// without having to increment/decrement its reference count.
+///
+/// # Invariants
+///
+/// The wrapped [`Task`] remains valid for the lifetime of the object.
+pub struct TaskRef<'a> {
+    task: ManuallyDrop<Task>,
+    _not_send: PhantomData<(&'a (), *mut ())>,
+}
+
+impl TaskRef<'_> {
+    /// Constructs a new `struct task_struct` wrapper that doesn't change its reference count.
+    ///
+    /// # Safety
+    ///
+    /// The pointer `ptr` must be non-null and valid for the lifetime of the object.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::task_struct) -> Self {
+        Self {
+            task: ManuallyDrop::new(Task { ptr }),
+            _not_send: PhantomData,
+        }
+    }
+}
+
+// SAFETY: It is OK to share a reference to the current thread with another thread because we know
+// the owner cannot go away while the shared reference exists (and `Task` itself is `Sync`).
+unsafe impl Sync for TaskRef<'_> {}
+
+impl Deref for TaskRef<'_> {
+    type Target = Task;
+
+    fn deref(&self) -> &Self::Target {
+        self.task.deref()
+    }
+}
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
new file mode 100644
index 000000000000..28b93055e8b8
--- /dev/null
+++ b/rust/kernel/types.rs
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel types.
+//!
+//! C header: [`include/linux/types.h`](../../../../include/linux/types.h)
+
+use crate::{
+    bindings, c_types,
+    sync::{Ref, RefBorrow},
+};
+use alloc::boxed::Box;
+use core::{
+    cell::UnsafeCell,
+    mem::MaybeUninit,
+    ops::{self, Deref, DerefMut},
+    pin::Pin,
+};
+
+/// Permissions.
+///
+/// C header: [`include/uapi/linux/stat.h`](../../../../include/uapi/linux/stat.h)
+///
+/// C header: [`include/linux/stat.h`](../../../../include/linux/stat.h)
+pub struct Mode(bindings::umode_t);
+
+impl Mode {
+    /// Creates a [`Mode`] from an integer.
+    pub fn from_int(m: u16) -> Mode {
+        Mode(m)
+    }
+
+    /// Returns the mode as an integer.
+    pub fn as_int(&self) -> u16 {
+        self.0
+    }
+}
+
+/// Used to convert an object into a raw pointer that represents it.
+///
+/// It can eventually be converted back into the object. This is used to store objects as pointers
+/// in kernel data structures, for example, an implementation of [`FileOperations`] in `struct
+/// file::private_data`.
+pub trait PointerWrapper {
+    /// Type of values borrowed between calls to [`PointerWrapper::into_pointer`] and
+    /// [`PointerWrapper::from_pointer`].
+    type Borrowed<'a>;
+
+    /// Returns the raw pointer.
+    fn into_pointer(self) -> *const c_types::c_void;
+
+    /// Returns a borrowed value.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`PointerWrapper::into_pointer`].
+    /// Additionally, [`PointerWrapper::from_pointer`] can only be called after *all* values
+    /// returned by [`PointerWrapper::borrow`] have been dropped.
+    unsafe fn borrow<'a>(ptr: *const c_types::c_void) -> Self::Borrowed<'a>;
+
+    /// Returns the instance back from the raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The passed pointer must come from a previous call to [`PointerWrapper::into_pointer()`].
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self;
+}
+
+impl<T: 'static> PointerWrapper for Box<T> {
+    type Borrowed<'a> = &'a T;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        Box::into_raw(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const c_types::c_void) -> &'a T {
+        // SAFETY: The safety requirements for this function ensure that the object is still alive,
+        // so it is safe to dereference the raw pointer.
+        // The safety requirements also ensure that the object remains alive for the lifetime of
+        // the returned value.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        // SAFETY: The passed pointer comes from a previous call to [`Self::into_pointer()`].
+        unsafe { Box::from_raw(ptr as _) }
+    }
+}
+
+impl<T: 'static> PointerWrapper for Ref<T> {
+    type Borrowed<'a> = RefBorrow<'a, T>;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        Ref::into_usize(self) as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const c_types::c_void) -> RefBorrow<'a, T> {
+        // SAFETY: The safety requirements for this function ensure that the underlying object
+        // remains valid for the lifetime of the returned value.
+        unsafe { Ref::borrow_usize(ptr as _) }
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        // SAFETY: The passed pointer comes from a previous call to [`Self::into_pointer()`].
+        unsafe { Ref::from_usize(ptr as _) }
+    }
+}
+
+impl<T: PointerWrapper + Deref> PointerWrapper for Pin<T> {
+    type Borrowed<'a> = T::Borrowed<'a>;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        // SAFETY: We continue to treat the pointer as pinned by returning just a pointer to it to
+        // the caller.
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+        inner.into_pointer()
+    }
+
+    unsafe fn borrow<'a>(ptr: *const c_types::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: The safety requirements for this function are the same as the ones for
+        // `T::borrow`.
+        unsafe { T::borrow(ptr) }
+    }
+
+    unsafe fn from_pointer(p: *const c_types::c_void) -> Self {
+        // SAFETY: The object was originally pinned.
+        // The passed pointer comes from a previous call to `inner::into_pointer()`.
+        unsafe { Pin::new_unchecked(T::from_pointer(p)) }
+    }
+}
+
+impl<T> PointerWrapper for *mut T {
+    type Borrowed<'a> = *mut T;
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        self as _
+    }
+
+    unsafe fn borrow<'a>(ptr: *const c_types::c_void) -> Self::Borrowed<'a> {
+        ptr as _
+    }
+
+    unsafe fn from_pointer(ptr: *const c_types::c_void) -> Self {
+        ptr as _
+    }
+}
+
+impl PointerWrapper for () {
+    type Borrowed<'a> = ();
+
+    fn into_pointer(self) -> *const c_types::c_void {
+        // We use 1 to be different from a null pointer.
+        1usize as _
+    }
+
+    unsafe fn borrow<'a>(_: *const c_types::c_void) -> Self::Borrowed<'a> {}
+
+    unsafe fn from_pointer(_: *const c_types::c_void) -> Self {}
+}
+
+/// Runs a cleanup function/closure when dropped.
+///
+/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
+///
+/// # Examples
+///
+/// In the example below, we have multiple exit paths and we want to log regardless of which one is
+/// taken:
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::ScopeGuard;
+/// fn example1(arg: bool) {
+///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     // Do something...
+/// }
+/// ```
+///
+/// In the example below, we want to log the same message on all early exits but a different one on
+/// the main exit path:
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::ScopeGuard;
+/// fn example2(arg: bool) {
+///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
+///
+///     if arg {
+///         return;
+///     }
+///
+///     // (Other early returns...)
+///
+///     log.dismiss();
+///     pr_info!("example2 no early return\n");
+/// }
+/// ```
+///
+/// In the example below, we need a mutable object (the vector) to be accessible within the log
+/// function, so we wrap it in the [`ScopeGuard`]:
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::ScopeGuard;
+/// fn example3(arg: bool) -> Result {
+///     let mut vec =
+///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
+///
+///     vec.try_push(10u8)?;
+///     if arg {
+///         return Ok(());
+///     }
+///     vec.try_push(20u8)?;
+///     Ok(())
+/// }
+/// ```
+///
+/// # Invariants
+///
+/// The value stored in the struct is nearly always `Some(_)`, except between
+/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
+/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
+/// callers won't be able to use it anymore.
+pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
+
+impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
+    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
+    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
+        // INVARIANT: The struct is being initialised with `Some(_)`.
+        Self(Some((data, cleanup_func)))
+    }
+
+    /// Prevents the cleanup function from running and returns the guarded data.
+    pub fn dismiss(mut self) -> T {
+        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
+        // because this function consumes `self`.
+        self.0.take().unwrap().0
+    }
+}
+
+impl ScopeGuard<(), Box<dyn FnOnce(())>> {
+    /// Creates a new guarded object with the given cleanup function.
+    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
+        ScopeGuard::new_with_data((), move |_| cleanup())
+    }
+}
+
+impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // The type invariants guarantee that `unwrap` will succeed.
+        &self.0.as_ref().unwrap().0
+    }
+}
+
+impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
+    fn deref_mut(&mut self) -> &mut T {
+        // The type invariants guarantee that `unwrap` will succeed.
+        &mut self.0.as_mut().unwrap().0
+    }
+}
+
+impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
+    fn drop(&mut self) {
+        // Run the cleanup function if one is still present.
+        if let Some((data, cleanup)) = self.0.take() {
+            cleanup(data)
+        }
+    }
+}
+
+/// Stores an opaque value.
+///
+/// This is meant to be used with FFI objects that are never interpreted by Rust code.
+pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
+
+impl<T> Opaque<T> {
+    /// Creates a new opaque value.
+    pub fn new(value: T) -> Self {
+        Self(MaybeUninit::new(UnsafeCell::new(value)))
+    }
+
+    /// Creates an uninitialised value.
+    pub const fn uninit() -> Self {
+        Self(MaybeUninit::uninit())
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub fn get(&self) -> *mut T {
+        UnsafeCell::raw_get(self.0.as_ptr())
+    }
+}
+
+/// A bitmask.
+///
+/// It has a restriction that all bits must be the same, except one. For example, `0b1110111` and
+/// `0b1000` are acceptable masks.
+#[derive(Clone, Copy)]
+pub struct Bit<T> {
+    index: T,
+    inverted: bool,
+}
+
+/// Creates a bit mask with a single bit set.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::bit;
+/// let mut x = 0xfeu32;
+///
+/// assert_eq!(x & bit(0), 0);
+/// assert_eq!(x & bit(1), 2);
+/// assert_eq!(x & bit(2), 4);
+/// assert_eq!(x & bit(3), 8);
+///
+/// x |= bit(0);
+/// assert_eq!(x, 0xff);
+///
+/// x &= !bit(1);
+/// assert_eq!(x, 0xfd);
+///
+/// x &= !bit(7);
+/// assert_eq!(x, 0x7d);
+///
+/// let y: u64 = bit(34).into();
+/// assert_eq!(y, 0x400000000);
+///
+/// assert_eq!(y | bit(35), 0xc00000000);
+/// ```
+pub fn bit<T: Copy>(index: T) -> Bit<T> {
+    Bit {
+        index,
+        inverted: false,
+    }
+}
+
+impl<T: Copy> ops::Not for Bit<T> {
+    type Output = Self;
+    fn not(self) -> Self {
+        Self {
+            index: self.index,
+            inverted: !self.inverted,
+        }
+    }
+}
+
+/// Implemented by integer types that allow counting the number of trailing zeroes.
+pub trait TrailingZeros {
+    /// Returns the number of trailing zeroes in the binary representation of `self`.
+    fn trailing_zeros(&self) -> u32;
+}
+
+macro_rules! define_unsigned_number_traits {
+    ($type_name:ty) => {
+        impl TrailingZeros for $type_name {
+            fn trailing_zeros(&self) -> u32 {
+                <$type_name>::trailing_zeros(*self)
+            }
+        }
+
+        impl<T: Copy> core::convert::From<Bit<T>> for $type_name
+        where
+            Self: ops::Shl<T, Output = Self> + core::convert::From<u8> + ops::Not<Output = Self>,
+        {
+            fn from(v: Bit<T>) -> Self {
+                let c = Self::from(1u8) << v.index;
+                if v.inverted {
+                    !c
+                } else {
+                    c
+                }
+            }
+        }
+
+        impl<T: Copy> ops::BitAnd<Bit<T>> for $type_name
+        where
+            Self: ops::Shl<T, Output = Self> + core::convert::From<u8>,
+        {
+            type Output = Self;
+            fn bitand(self, rhs: Bit<T>) -> Self::Output {
+                self & Self::from(rhs)
+            }
+        }
+
+        impl<T: Copy> ops::BitOr<Bit<T>> for $type_name
+        where
+            Self: ops::Shl<T, Output = Self> + core::convert::From<u8>,
+        {
+            type Output = Self;
+            fn bitor(self, rhs: Bit<T>) -> Self::Output {
+                self | Self::from(rhs)
+            }
+        }
+
+        impl<T: Copy> ops::BitAndAssign<Bit<T>> for $type_name
+        where
+            Self: ops::Shl<T, Output = Self> + core::convert::From<u8>,
+        {
+            fn bitand_assign(&mut self, rhs: Bit<T>) {
+                *self &= Self::from(rhs)
+            }
+        }
+
+        impl<T: Copy> ops::BitOrAssign<Bit<T>> for $type_name
+        where
+            Self: ops::Shl<T, Output = Self> + core::convert::From<u8>,
+        {
+            fn bitor_assign(&mut self, rhs: Bit<T>) {
+                *self |= Self::from(rhs)
+            }
+        }
+    };
+}
+
+define_unsigned_number_traits!(u8);
+define_unsigned_number_traits!(u16);
+define_unsigned_number_traits!(u32);
+define_unsigned_number_traits!(u64);
+define_unsigned_number_traits!(usize);
+
+/// Returns an iterator over the set bits of `value`.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::bits_iter;
+///
+/// let mut iter = bits_iter(5usize);
+/// assert_eq!(iter.next().unwrap(), 0);
+/// assert_eq!(iter.next().unwrap(), 2);
+/// assert!(iter.next().is_none());
+/// ```
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::bits_iter;
+///
+/// fn print_bits(x: usize) {
+///     for bit in bits_iter(x) {
+///         println!("{}", bit);
+///     }
+/// }
+/// ```
+#[inline]
+pub fn bits_iter<T>(value: T) -> impl Iterator<Item = u32>
+where
+    T: core::cmp::PartialEq
+        + From<u8>
+        + ops::Shl<u32, Output = T>
+        + ops::Not<Output = T>
+        + ops::BitAndAssign
+        + TrailingZeros,
+{
+    struct BitIterator<U> {
+        value: U,
+    }
+
+    impl<U> Iterator for BitIterator<U>
+    where
+        U: core::cmp::PartialEq
+            + From<u8>
+            + ops::Shl<u32, Output = U>
+            + ops::Not<Output = U>
+            + ops::BitAndAssign
+            + TrailingZeros,
+    {
+        type Item = u32;
+
+        #[inline]
+        fn next(&mut self) -> Option<u32> {
+            if self.value == U::from(0u8) {
+                return None;
+            }
+            let ret = self.value.trailing_zeros();
+            self.value &= !(U::from(1u8) << ret);
+            Some(ret)
+        }
+    }
+
+    BitIterator { value }
+}
+
+/// A trait for boolean types.
+///
+/// This is meant to be used in type states to allow booelan constraints in implementation blocks.
+/// In the example below, the implementation containing `MyType::set_value` could _not_ be
+/// constrained to type states containing `Writable = true` if `Writable` were a constant instead
+/// of a type.
+///
+/// # Safety
+///
+/// No additional implementations of [`Bool`] should be provided, as [`True`] and [`False`] are
+/// already provided.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{Bool, False, True};
+/// use core::marker::PhantomData;
+///
+/// // Type state specifies whether the type is writable.
+/// trait MyTypeState {
+///     type Writable: Bool;
+/// }
+///
+/// // In state S1, the type is writable.
+/// struct S1;
+/// impl MyTypeState for S1 {
+///     type Writable = True;
+/// }
+///
+/// // In state S2, the type is not writable.
+/// struct S2;
+/// impl MyTypeState for S2 {
+///     type Writable = False;
+/// }
+///
+/// struct MyType<T: MyTypeState> {
+///     value: u32,
+///     _p: PhantomData<T>,
+/// }
+///
+/// impl<T: MyTypeState> MyType<T> {
+///     fn new(value: u32) -> Self {
+///         Self {
+///             value,
+///             _p: PhantomData,
+///         }
+///     }
+/// }
+///
+/// // This implementation block only applies if the type state is writable.
+/// impl<T> MyType<T>
+/// where
+///     T: MyTypeState<Writable = True>,
+/// {
+///     fn set_value(&mut self, v: u32) {
+///         self.value = v;
+///     }
+/// }
+///
+/// pub(crate) fn test() {
+///     let mut x = MyType::<S1>::new(10);
+///     let mut y = MyType::<S2>::new(20);
+///
+///     x.set_value(30);
+///
+///     // The code below fails to compile because `S2` is not writable.
+///     // y.set_value(40);
+/// }
+/// ```
+pub unsafe trait Bool {}
+
+/// Represents the `true` value for types with [`Bool`] bound.
+pub struct True;
+
+// SAFETY: This is one of the only two implementations of `Bool`.
+unsafe impl Bool for True {}
+
+/// Represents the `false` value for types wth [`Bool`] bound.
+pub struct False;
+
+// SAFETY: This is one of the only two implementations of `Bool`.
+unsafe impl Bool for False {}
diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
new file mode 100644
index 000000000000..8489e80923c7
--- /dev/null
+++ b/rust/kernel/user_ptr.rs
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uaccess.h)
+
+use crate::{
+    bindings, c_types,
+    error::code::*,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    Result,
+};
+use alloc::vec::Vec;
+
+/// A reference to an area in userspace memory, which can be either
+/// read-only or read-write.
+///
+/// All methods on this struct are safe: invalid pointers return
+/// `EFAULT`. Concurrent access, *including data races to/from userspace
+/// memory*, is permitted, because fundamentally another userspace
+/// thread/process could always be modifying memory at the same time
+/// (in the same way that userspace Rust's [`std::io`] permits data races
+/// with the contents of files on disk). In the presence of a race, the
+/// exact byte values read/written are unspecified but the operation is
+/// well-defined. Kernelspace code should validate its copy of data
+/// after completing a read, and not expect that multiple reads of the
+/// same address will return the same value.
+///
+/// All APIs enforce the invariant that a given byte of memory from userspace
+/// may only be read once. By preventing double-fetches we avoid TOCTOU
+/// vulnerabilities. This is accomplished by taking `self` by value to prevent
+/// obtaining multiple readers on a given [`UserSlicePtr`], and the readers
+/// only permitting forward reads.
+///
+/// Constructing a [`UserSlicePtr`] performs no checks on the provided
+/// address and length, it can safely be constructed inside a kernel thread
+/// with no current userspace process. Reads and writes wrap the kernel APIs
+/// `copy_from_user` and `copy_to_user`, which check the memory map of the
+/// current process and enforce that the address range is within the user
+/// range (no additional calls to `access_ok` are needed).
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+pub struct UserSlicePtr(*mut c_types::c_void, usize);
+
+impl UserSlicePtr {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// # Safety
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlicePtr`] per user memory block as it reads each byte at
+    /// most once.
+    pub unsafe fn new(ptr: *mut c_types::c_void, length: usize) -> Self {
+        UserSlicePtr(ptr, length)
+    }
+
+    /// Reads the entirety of the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, readable memory.
+    pub fn read_all(self) -> Result<Vec<u8>> {
+        self.reader().read_all()
+    }
+
+    /// Constructs a [`UserSlicePtrReader`].
+    pub fn reader(self) -> UserSlicePtrReader {
+        UserSlicePtrReader(self.0, self.1)
+    }
+
+    /// Writes the provided slice into the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, writable memory (in which case some data from before the
+    /// fault may be written), or `data` is larger than the user slice
+    /// (in which case no data is written).
+    pub fn write_all(self, data: &[u8]) -> Result {
+        self.writer().write_slice(data)
+    }
+
+    /// Constructs a [`UserSlicePtrWriter`].
+    pub fn writer(self) -> UserSlicePtrWriter {
+        UserSlicePtrWriter(self.0, self.1)
+    }
+
+    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrWriter`].
+    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWriter) {
+        (
+            UserSlicePtrReader(self.0, self.1),
+            UserSlicePtrWriter(self.0, self.1),
+        )
+    }
+}
+
+/// A reader for [`UserSlicePtr`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSlicePtrReader(*mut c_types::c_void, usize);
+
+impl IoBufferReader for UserSlicePtrReader {
+    /// Returns the number of bytes left to be read from this.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Reads raw data from the user slice into a raw kernel buffer.
+    ///
+    /// # Safety
+    ///
+    /// The output buffer must be valid.
+    unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(EFAULT);
+        }
+        let res = unsafe { bindings::copy_from_user(out as _, self.0, len as _) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+}
+
+/// A writer for [`UserSlicePtr`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSlicePtrWriter(*mut c_types::c_void, usize);
+
+impl IoBufferWriter for UserSlicePtrWriter {
+    fn len(&self) -> usize {
+        self.1
+    }
+
+    fn clear(&mut self, mut len: usize) -> Result {
+        let mut ret = Ok(());
+        if len > self.1 {
+            ret = Err(EFAULT);
+            len = self.1;
+        }
+
+        // SAFETY: The buffer will be validated by `clear_user`. We ensure that `len` is within
+        // bounds in the check above.
+        let left = unsafe { bindings::clear_user(self.0, len as _) } as usize;
+        if left != 0 {
+            ret = Err(EFAULT);
+            len -= left;
+        }
+
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        ret
+    }
+
+    unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        if len > self.1 || len > u32::MAX as usize {
+            return Err(EFAULT);
+        }
+        let res = unsafe { bindings::copy_to_user(self.0, data as _, len as _) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+}
-- 
2.35.1

