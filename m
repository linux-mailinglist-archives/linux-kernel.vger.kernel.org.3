Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C594C4697D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbhLFOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbhLFOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB3C061A83;
        Mon,  6 Dec 2021 06:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA604B810AF;
        Mon,  6 Dec 2021 14:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9147C341C2;
        Mon,  6 Dec 2021 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799539;
        bh=+KClFSC7MEMDiG91hO9GSetg7OPMpw5z5hZj1PIAOBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jouR8CWzTr15OkaKDq9sqN7BWVJ32xzTHN8+4eSaNECvrTKrA1KPxMY65G6Db9DKS
         UlA1tsEIA/GbQhcYp+eqoAYgI+/WdYIVKEJav6tS3ahpTyCVUo2IPbwyfLfP0H5meW
         VJLxLAFAJh6pZjqtIM7y0LImv5d/KA+7yxRq59yXD0RtQDO7LNonOCEX2/DGf5MbCz
         JddE0R3TyUs45lmXubJZNk60kU1PxLCq4MX99eEwiEfk/MhXRhOQVPiArONYryXRv9
         9AiMPk7Sv8QZVbDkjxb/3RRaw1JJMBwkDYSVuagsko4ho4fpiDumXMZou7cpdzH0Ma
         CTbkBow+o4b9g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>
Subject: [PATCH 06/19] rust: add `alloc` crate
Date:   Mon,  6 Dec 2021 15:03:00 +0100
Message-Id: <20211206140313.5653-7-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This crate is a subset of the Rust standard library `alloc`, with some
additions on top.

This is needed because upstream support for fallible allocations
is a work in progress (i.e. the `try_*` versions of methods which
return a `Result` instead of panicking).

Having the library in-tree also gives us a bit more freedom to
experiment with new interfaces and allows us to iterate quickly.

Eventually, the goal is to have everything the kernel needs in
upstream `alloc` and drop it from the kernel tree.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Matthew Bakhtiari <dev@mtbk.me>
Signed-off-by: Matthew Bakhtiari <dev@mtbk.me>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/alloc/README.md              |   32 +
 rust/alloc/alloc.rs               |  424 ++++
 rust/alloc/borrow.rs              |  498 +++++
 rust/alloc/boxed.rs               | 1844 ++++++++++++++++
 rust/alloc/collections/mod.rs     |  155 ++
 rust/alloc/fmt.rs                 |  583 +++++
 rust/alloc/lib.rs                 |  212 ++
 rust/alloc/macros.rs              |  126 ++
 rust/alloc/raw_vec.rs             |  612 ++++++
 rust/alloc/slice.rs               | 1275 +++++++++++
 rust/alloc/str.rs                 |  621 ++++++
 rust/alloc/string.rs              | 2857 +++++++++++++++++++++++++
 rust/alloc/vec/drain.rs           |  158 ++
 rust/alloc/vec/drain_filter.rs    |  145 ++
 rust/alloc/vec/into_iter.rs       |  356 +++
 rust/alloc/vec/is_zero.rs         |  106 +
 rust/alloc/vec/mod.rs             | 3327 +++++++++++++++++++++++++++++
 rust/alloc/vec/partial_eq.rs      |   49 +
 rust/alloc/vec/set_len_on_drop.rs |   30 +
 rust/alloc/vec/spec_extend.rs     |  172 ++
 20 files changed, 13582 insertions(+)
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

diff --git a/rust/alloc/README.md b/rust/alloc/README.md
new file mode 100644
index 000000000000..a1bcc2cef0e6
--- /dev/null
+++ b/rust/alloc/README.md
@@ -0,0 +1,32 @@
+# `alloc`
+
+These source files come from the Rust standard library, hosted in
+the https://github.com/rust-lang/rust repository. For copyright
+details, see https://github.com/rust-lang/rust/blob/master/COPYRIGHT.
+
+Please note that these files should be kept as close as possible to
+upstream. In general, only additions should be performed (e.g. new
+methods). Eventually, changes should make it into upstream so that,
+at some point, this fork can be dropped from the kernel tree.
+
+
+## Rationale
+
+On one hand, kernel folks wanted to keep `alloc` in-tree to have more
+freedom in both workflow and actual features if actually needed
+(e.g. receiver types if we ended up using them), which is reasonable.
+
+On the other hand, Rust folks wanted to keep `alloc` as close as
+upstream as possible and avoid as much divergence as possible, which
+is also reasonable.
+
+We agreed on a middle-ground: we would keep a subset of `alloc`
+in-tree that would be as small and as close as possible to upstream.
+Then, upstream can start adding the functions that we add to `alloc`
+etc., until we reach a point where the kernel already knows exactly
+what it needs in `alloc` and all the new methods are merged into
+upstream, so that we can drop `alloc` from the kernel tree and go back
+to using the upstream one.
+
+By doing this, the kernel can go a bit faster now, and Rust can
+slowly incorporate and discuss the changes as needed.
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
new file mode 100644
index 000000000000..4a0c85dde928
--- /dev/null
+++ b/rust/alloc/alloc.rs
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! Memory allocation APIs
+
+#![stable(feature = "alloc_module", since = "1.28.0")]
+
+#[cfg(not(test))]
+use core::intrinsics;
+use core::intrinsics::{min_align_of_val, size_of_val};
+
+use core::ptr::Unique;
+#[cfg(not(test))]
+use core::ptr::{self, NonNull};
+
+#[stable(feature = "alloc_module", since = "1.28.0")]
+#[doc(inline)]
+pub use core::alloc::*;
+
+#[cfg(test)]
+mod tests;
+
+extern "Rust" {
+    // These are the magic symbols to call the global allocator.  rustc generates
+    // them to call `__rg_alloc` etc. if there is a `#[global_allocator]` attribute
+    // (the code expanding that attribute macro generates those functions), or to call
+    // the default implementations in libstd (`__rdl_alloc` etc. in `library/std/src/alloc.rs`)
+    // otherwise.
+    // The rustc fork of LLVM also special-cases these function names to be able to optimize them
+    // like `malloc`, `realloc`, and `free`, respectively.
+    #[rustc_allocator]
+    #[rustc_allocator_nounwind]
+    fn __rust_alloc(size: usize, align: usize) -> *mut u8;
+    #[rustc_allocator_nounwind]
+    fn __rust_dealloc(ptr: *mut u8, size: usize, align: usize);
+    #[rustc_allocator_nounwind]
+    fn __rust_realloc(ptr: *mut u8, old_size: usize, align: usize, new_size: usize) -> *mut u8;
+    #[rustc_allocator_nounwind]
+    fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8;
+}
+
+/// The global memory allocator.
+///
+/// This type implements the [`Allocator`] trait by forwarding calls
+/// to the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// Note: while this type is unstable, the functionality it provides can be
+/// accessed through the [free functions in `alloc`](self#functions).
+#[unstable(feature = "allocator_api", issue = "32838")]
+#[derive(Copy, Clone, Default, Debug)]
+#[cfg(not(test))]
+pub struct Global;
+
+#[cfg(test)]
+pub use std::alloc::Global;
+
+/// Allocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::alloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `alloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::alloc`].
+///
+/// # Examples
+///
+/// ```
+/// use std::alloc::{alloc, dealloc, Layout};
+///
+/// unsafe {
+///     let layout = Layout::new::<u16>();
+///     let ptr = alloc(layout);
+///
+///     *(ptr as *mut u16) = 42;
+///     assert_eq!(*(ptr as *mut u16), 42);
+///
+///     dealloc(ptr, layout);
+/// }
+/// ```
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[inline]
+pub unsafe fn alloc(layout: Layout) -> *mut u8 {
+    unsafe { __rust_alloc(layout.size(), layout.align()) }
+}
+
+/// Deallocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::dealloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `dealloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::dealloc`].
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[inline]
+pub unsafe fn dealloc(ptr: *mut u8, layout: Layout) {
+    unsafe { __rust_dealloc(ptr, layout.size(), layout.align()) }
+}
+
+/// Reallocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::realloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `realloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::realloc`].
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[inline]
+pub unsafe fn realloc(ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
+    unsafe { __rust_realloc(ptr, layout.size(), layout.align(), new_size) }
+}
+
+/// Allocate zero-initialized memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::alloc_zeroed`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `alloc_zeroed` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::alloc_zeroed`].
+///
+/// # Examples
+///
+/// ```
+/// use std::alloc::{alloc_zeroed, dealloc, Layout};
+///
+/// unsafe {
+///     let layout = Layout::new::<u16>();
+///     let ptr = alloc_zeroed(layout);
+///
+///     assert_eq!(*(ptr as *mut u16), 0);
+///
+///     dealloc(ptr, layout);
+/// }
+/// ```
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[inline]
+pub unsafe fn alloc_zeroed(layout: Layout) -> *mut u8 {
+    unsafe { __rust_alloc_zeroed(layout.size(), layout.align()) }
+}
+
+#[cfg(not(test))]
+impl Global {
+    #[inline]
+    fn alloc_impl(&self, layout: Layout, zeroed: bool) -> Result<NonNull<[u8]>, AllocError> {
+        match layout.size() {
+            0 => Ok(NonNull::slice_from_raw_parts(layout.dangling(), 0)),
+            // SAFETY: `layout` is non-zero in size,
+            size => unsafe {
+                let raw_ptr = if zeroed { alloc_zeroed(layout) } else { alloc(layout) };
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                Ok(NonNull::slice_from_raw_parts(ptr, size))
+            },
+        }
+    }
+
+    // SAFETY: Same as `Allocator::grow`
+    #[inline]
+    unsafe fn grow_impl(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+        zeroed: bool,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        debug_assert!(
+            new_layout.size() >= old_layout.size(),
+            "`new_layout.size()` must be greater than or equal to `old_layout.size()`"
+        );
+
+        match old_layout.size() {
+            0 => self.alloc_impl(new_layout, zeroed),
+
+            // SAFETY: `new_size` is non-zero as `old_size` is greater than or equal to `new_size`
+            // as required by safety conditions. Other conditions must be upheld by the caller
+            old_size if old_layout.align() == new_layout.align() => unsafe {
+                let new_size = new_layout.size();
+
+                // `realloc` probably checks for `new_size >= old_layout.size()` or something similar.
+                intrinsics::assume(new_size >= old_layout.size());
+
+                let raw_ptr = realloc(ptr.as_ptr(), old_layout, new_size);
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                if zeroed {
+                    raw_ptr.add(old_size).write_bytes(0, new_size - old_size);
+                }
+                Ok(NonNull::slice_from_raw_parts(ptr, new_size))
+            },
+
+            // SAFETY: because `new_layout.size()` must be greater than or equal to `old_size`,
+            // both the old and new memory allocation are valid for reads and writes for `old_size`
+            // bytes. Also, because the old allocation wasn't yet deallocated, it cannot overlap
+            // `new_ptr`. Thus, the call to `copy_nonoverlapping` is safe. The safety contract
+            // for `dealloc` must be upheld by the caller.
+            old_size => unsafe {
+                let new_ptr = self.alloc_impl(new_layout, zeroed)?;
+                ptr::copy_nonoverlapping(ptr.as_ptr(), new_ptr.as_mut_ptr(), old_size);
+                self.deallocate(ptr, old_layout);
+                Ok(new_ptr)
+            },
+        }
+    }
+}
+
+#[unstable(feature = "allocator_api", issue = "32838")]
+#[cfg(not(test))]
+unsafe impl Allocator for Global {
+    #[inline]
+    fn allocate(&self, layout: Layout) -> Result<NonNull<[u8]>, AllocError> {
+        self.alloc_impl(layout, false)
+    }
+
+    #[inline]
+    fn allocate_zeroed(&self, layout: Layout) -> Result<NonNull<[u8]>, AllocError> {
+        self.alloc_impl(layout, true)
+    }
+
+    #[inline]
+    unsafe fn deallocate(&self, ptr: NonNull<u8>, layout: Layout) {
+        if layout.size() != 0 {
+            // SAFETY: `layout` is non-zero in size,
+            // other conditions must be upheld by the caller
+            unsafe { dealloc(ptr.as_ptr(), layout) }
+        }
+    }
+
+    #[inline]
+    unsafe fn grow(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: all conditions must be upheld by the caller
+        unsafe { self.grow_impl(ptr, old_layout, new_layout, false) }
+    }
+
+    #[inline]
+    unsafe fn grow_zeroed(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: all conditions must be upheld by the caller
+        unsafe { self.grow_impl(ptr, old_layout, new_layout, true) }
+    }
+
+    #[inline]
+    unsafe fn shrink(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        debug_assert!(
+            new_layout.size() <= old_layout.size(),
+            "`new_layout.size()` must be smaller than or equal to `old_layout.size()`"
+        );
+
+        match new_layout.size() {
+            // SAFETY: conditions must be upheld by the caller
+            0 => unsafe {
+                self.deallocate(ptr, old_layout);
+                Ok(NonNull::slice_from_raw_parts(new_layout.dangling(), 0))
+            },
+
+            // SAFETY: `new_size` is non-zero. Other conditions must be upheld by the caller
+            new_size if old_layout.align() == new_layout.align() => unsafe {
+                // `realloc` probably checks for `new_size <= old_layout.size()` or something similar.
+                intrinsics::assume(new_size <= old_layout.size());
+
+                let raw_ptr = realloc(ptr.as_ptr(), old_layout, new_size);
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                Ok(NonNull::slice_from_raw_parts(ptr, new_size))
+            },
+
+            // SAFETY: because `new_size` must be smaller than or equal to `old_layout.size()`,
+            // both the old and new memory allocation are valid for reads and writes for `new_size`
+            // bytes. Also, because the old allocation wasn't yet deallocated, it cannot overlap
+            // `new_ptr`. Thus, the call to `copy_nonoverlapping` is safe. The safety contract
+            // for `dealloc` must be upheld by the caller.
+            new_size => unsafe {
+                let new_ptr = self.allocate(new_layout)?;
+                ptr::copy_nonoverlapping(ptr.as_ptr(), new_ptr.as_mut_ptr(), new_size);
+                self.deallocate(ptr, old_layout);
+                Ok(new_ptr)
+            },
+        }
+    }
+}
+
+/// The allocator for unique pointers.
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[lang = "exchange_malloc"]
+#[inline]
+unsafe fn exchange_malloc(size: usize, align: usize) -> *mut u8 {
+    let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+    match Global.allocate(layout) {
+        Ok(ptr) => ptr.as_mut_ptr(),
+        Err(_) => handle_alloc_error(layout),
+    }
+}
+
+#[cfg_attr(not(test), lang = "box_free")]
+#[inline]
+// This signature has to be the same as `Box`, otherwise an ICE will happen.
+// When an additional parameter to `Box` is added (like `A: Allocator`), this has to be added here as
+// well.
+// For example if `Box` is changed to  `struct Box<T: ?Sized, A: Allocator>(Unique<T>, A)`,
+// this function has to be changed to `fn box_free<T: ?Sized, A: Allocator>(Unique<T>, A)` as well.
+pub(crate) unsafe fn box_free<T: ?Sized, A: Allocator>(ptr: Unique<T>, alloc: A) {
+    unsafe {
+        let size = size_of_val(ptr.as_ref());
+        let align = min_align_of_val(ptr.as_ref());
+        let layout = Layout::from_size_align_unchecked(size, align);
+        alloc.deallocate(ptr.cast().into(), layout)
+    }
+}
+
+// # Allocation error handler
+
+#[cfg(not(no_global_oom_handling))]
+extern "Rust" {
+    // This is the magic symbol to call the global alloc error handler.  rustc generates
+    // it to call `__rg_oom` if there is a `#[alloc_error_handler]`, or to call the
+    // default implementations below (`__rdl_oom`) otherwise.
+    #[rustc_allocator_nounwind]
+    fn __rust_alloc_error_handler(size: usize, align: usize) -> !;
+}
+
+/// Abort on memory allocation error or failure.
+///
+/// Callers of memory allocation APIs wishing to abort computation
+/// in response to an allocation error are encouraged to call this function,
+/// rather than directly invoking `panic!` or similar.
+///
+/// The default behavior of this function is to print a message to standard error
+/// and abort the process.
+/// It can be replaced with [`set_alloc_error_hook`] and [`take_alloc_error_hook`].
+///
+/// [`set_alloc_error_hook`]: ../../std/alloc/fn.set_alloc_error_hook.html
+/// [`take_alloc_error_hook`]: ../../std/alloc/fn.take_alloc_error_hook.html
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[rustc_allocator_nounwind]
+#[cold]
+pub fn handle_alloc_error(layout: Layout) -> ! {
+    unsafe {
+        __rust_alloc_error_handler(layout.size(), layout.align());
+    }
+}
+
+// For alloc test `std::alloc::handle_alloc_error` can be used directly.
+#[cfg(all(not(no_global_oom_handling), test))]
+pub use std::alloc::handle_alloc_error;
+
+#[cfg(all(not(no_global_oom_handling), not(any(target_os = "hermit", test))))]
+#[doc(hidden)]
+#[allow(unused_attributes)]
+#[unstable(feature = "alloc_internals", issue = "none")]
+pub mod __alloc_error_handler {
+    use crate::alloc::Layout;
+
+    // called via generated `__rust_alloc_error_handler`
+
+    // if there is no `#[alloc_error_handler]`
+    #[rustc_std_internal_symbol]
+    pub unsafe extern "C" fn __rdl_oom(size: usize, _align: usize) -> ! {
+        panic!("memory allocation of {} bytes failed", size)
+    }
+
+    // if there is an `#[alloc_error_handler]`
+    #[rustc_std_internal_symbol]
+    pub unsafe extern "C" fn __rg_oom(size: usize, align: usize) -> ! {
+        let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+        extern "Rust" {
+            #[lang = "oom"]
+            fn oom_impl(layout: Layout) -> !;
+        }
+        unsafe { oom_impl(layout) }
+    }
+}
+
+/// Specialize clones into pre-allocated, uninitialized memory.
+/// Used by `Box::clone` and `Rc`/`Arc::make_mut`.
+pub(crate) trait WriteCloneIntoRaw: Sized {
+    unsafe fn write_clone_into_raw(&self, target: *mut Self);
+}
+
+impl<T: Clone> WriteCloneIntoRaw for T {
+    #[inline]
+    default unsafe fn write_clone_into_raw(&self, target: *mut Self) {
+        // Having allocated *first* may allow the optimizer to create
+        // the cloned value in-place, skipping the local and move.
+        unsafe { target.write(self.clone()) };
+    }
+}
+
+impl<T: Copy> WriteCloneIntoRaw for T {
+    #[inline]
+    unsafe fn write_clone_into_raw(&self, target: *mut Self) {
+        // We can always copy in-place, without ever involving a local value.
+        unsafe { target.copy_from_nonoverlapping(self, 1) };
+    }
+}
diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
new file mode 100644
index 000000000000..7885168b81ba
--- /dev/null
+++ b/rust/alloc/borrow.rs
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! A module for working with borrowed data.
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+use core::cmp::Ordering;
+use core::hash::{Hash, Hasher};
+use core::ops::Deref;
+#[cfg(not(no_global_oom_handling))]
+use core::ops::{Add, AddAssign};
+
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::borrow::{Borrow, BorrowMut};
+
+use crate::fmt;
+#[cfg(not(no_global_oom_handling))]
+use crate::string::String;
+
+use Cow::*;
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, B: ?Sized> Borrow<B> for Cow<'a, B>
+where
+    B: ToOwned,
+    <B as ToOwned>::Owned: 'a,
+{
+    fn borrow(&self) -> &B {
+        &**self
+    }
+}
+
+/// A generalization of `Clone` to borrowed data.
+///
+/// Some types make it possible to go from borrowed to owned, usually by
+/// implementing the `Clone` trait. But `Clone` works only for going from `&T`
+/// to `T`. The `ToOwned` trait generalizes `Clone` to construct owned data
+/// from any borrow of a given type.
+#[cfg_attr(not(test), rustc_diagnostic_item = "ToOwned")]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub trait ToOwned {
+    /// The resulting type after obtaining ownership.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    type Owned: Borrow<Self>;
+
+    /// Creates owned data from borrowed data, usually by cloning.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s: &str = "a";
+    /// let ss: String = s.to_owned();
+    ///
+    /// let v: &[i32] = &[1, 2];
+    /// let vv: Vec<i32> = v.to_owned();
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use = "cloning is often expensive and is not expected to have side effects"]
+    fn to_owned(&self) -> Self::Owned;
+
+    /// Uses borrowed data to replace owned data, usually by cloning.
+    ///
+    /// This is borrow-generalized version of `Clone::clone_from`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// # #![feature(toowned_clone_into)]
+    /// let mut s: String = String::new();
+    /// "hello".clone_into(&mut s);
+    ///
+    /// let mut v: Vec<i32> = Vec::new();
+    /// [1, 2][..].clone_into(&mut v);
+    /// ```
+    #[unstable(feature = "toowned_clone_into", reason = "recently added", issue = "41263")]
+    fn clone_into(&self, target: &mut Self::Owned) {
+        *target = self.to_owned();
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> ToOwned for T
+where
+    T: Clone,
+{
+    type Owned = T;
+    fn to_owned(&self) -> T {
+        self.clone()
+    }
+
+    fn clone_into(&self, target: &mut T) {
+        target.clone_from(self);
+    }
+}
+
+/// A clone-on-write smart pointer.
+///
+/// The type `Cow` is a smart pointer providing clone-on-write functionality: it
+/// can enclose and provide immutable access to borrowed data, and clone the
+/// data lazily when mutation or ownership is required. The type is designed to
+/// work with general borrowed data via the `Borrow` trait.
+///
+/// `Cow` implements `Deref`, which means that you can call
+/// non-mutating methods directly on the data it encloses. If mutation
+/// is desired, `to_mut` will obtain a mutable reference to an owned
+/// value, cloning if necessary.
+///
+/// If you need reference-counting pointers, note that
+/// [`Rc::make_mut`][crate::rc::Rc::make_mut] and
+/// [`Arc::make_mut`][crate::sync::Arc::make_mut] can provide clone-on-write
+/// functionality as well.
+///
+/// # Examples
+///
+/// ```
+/// use std::borrow::Cow;
+///
+/// fn abs_all(input: &mut Cow<[i32]>) {
+///     for i in 0..input.len() {
+///         let v = input[i];
+///         if v < 0 {
+///             // Clones into a vector if not already owned.
+///             input.to_mut()[i] = -v;
+///         }
+///     }
+/// }
+///
+/// // No clone occurs because `input` doesn't need to be mutated.
+/// let slice = [0, 1, 2];
+/// let mut input = Cow::from(&slice[..]);
+/// abs_all(&mut input);
+///
+/// // Clone occurs because `input` needs to be mutated.
+/// let slice = [-1, 0, 1];
+/// let mut input = Cow::from(&slice[..]);
+/// abs_all(&mut input);
+///
+/// // No clone occurs because `input` is already owned.
+/// let mut input = Cow::from(vec![-1, 0, 1]);
+/// abs_all(&mut input);
+/// ```
+///
+/// Another example showing how to keep `Cow` in a struct:
+///
+/// ```
+/// use std::borrow::Cow;
+///
+/// struct Items<'a, X: 'a> where [X]: ToOwned<Owned = Vec<X>> {
+///     values: Cow<'a, [X]>,
+/// }
+///
+/// impl<'a, X: Clone + 'a> Items<'a, X> where [X]: ToOwned<Owned = Vec<X>> {
+///     fn new(v: Cow<'a, [X]>) -> Self {
+///         Items { values: v }
+///     }
+/// }
+///
+/// // Creates a container from borrowed values of a slice
+/// let readonly = [1, 2];
+/// let borrowed = Items::new((&readonly[..]).into());
+/// match borrowed {
+///     Items { values: Cow::Borrowed(b) } => println!("borrowed {:?}", b),
+///     _ => panic!("expect borrowed value"),
+/// }
+///
+/// let mut clone_on_write = borrowed;
+/// // Mutates the data from slice into owned vec and pushes a new value on top
+/// clone_on_write.values.to_mut().push(3);
+/// println!("clone_on_write = {:?}", clone_on_write.values);
+///
+/// // The data was mutated. Let check it out.
+/// match clone_on_write {
+///     Items { values: Cow::Owned(_) } => println!("clone_on_write contains owned data"),
+///     _ => panic!("expect owned data"),
+/// }
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(test), rustc_diagnostic_item = "Cow")]
+pub enum Cow<'a, B: ?Sized + 'a>
+where
+    B: ToOwned,
+{
+    /// Borrowed data.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    Borrowed(#[stable(feature = "rust1", since = "1.0.0")] &'a B),
+
+    /// Owned data.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    Owned(#[stable(feature = "rust1", since = "1.0.0")] <B as ToOwned>::Owned),
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized + ToOwned> Clone for Cow<'_, B> {
+    fn clone(&self) -> Self {
+        match *self {
+            Borrowed(b) => Borrowed(b),
+            Owned(ref o) => {
+                let b: &B = o.borrow();
+                Owned(b.to_owned())
+            }
+        }
+    }
+
+    fn clone_from(&mut self, source: &Self) {
+        match (self, source) {
+            (&mut Owned(ref mut dest), &Owned(ref o)) => o.borrow().clone_into(dest),
+            (t, s) => *t = s.clone(),
+        }
+    }
+}
+
+impl<B: ?Sized + ToOwned> Cow<'_, B> {
+    /// Returns true if the data is borrowed, i.e. if `to_mut` would require additional work.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(cow_is_borrowed)]
+    /// use std::borrow::Cow;
+    ///
+    /// let cow = Cow::Borrowed("moo");
+    /// assert!(cow.is_borrowed());
+    ///
+    /// let bull: Cow<'_, str> = Cow::Owned("...moo?".to_string());
+    /// assert!(!bull.is_borrowed());
+    /// ```
+    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
+    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
+    pub const fn is_borrowed(&self) -> bool {
+        match *self {
+            Borrowed(_) => true,
+            Owned(_) => false,
+        }
+    }
+
+    /// Returns true if the data is owned, i.e. if `to_mut` would be a no-op.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(cow_is_borrowed)]
+    /// use std::borrow::Cow;
+    ///
+    /// let cow: Cow<'_, str> = Cow::Owned("moo".to_string());
+    /// assert!(cow.is_owned());
+    ///
+    /// let bull = Cow::Borrowed("...moo?");
+    /// assert!(!bull.is_owned());
+    /// ```
+    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
+    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
+    pub const fn is_owned(&self) -> bool {
+        !self.is_borrowed()
+    }
+
+    /// Acquires a mutable reference to the owned form of the data.
+    ///
+    /// Clones the data if it is not already owned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let mut cow = Cow::Borrowed("foo");
+    /// cow.to_mut().make_ascii_uppercase();
+    ///
+    /// assert_eq!(
+    ///   cow,
+    ///   Cow::Owned(String::from("FOO")) as Cow<str>
+    /// );
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn to_mut(&mut self) -> &mut <B as ToOwned>::Owned {
+        match *self {
+            Borrowed(borrowed) => {
+                *self = Owned(borrowed.to_owned());
+                match *self {
+                    Borrowed(..) => unreachable!(),
+                    Owned(ref mut owned) => owned,
+                }
+            }
+            Owned(ref mut owned) => owned,
+        }
+    }
+
+    /// Extracts the owned data.
+    ///
+    /// Clones the data if it is not already owned.
+    ///
+    /// # Examples
+    ///
+    /// Calling `into_owned` on a `Cow::Borrowed` clones the underlying data
+    /// and becomes a `Cow::Owned`:
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let s = "Hello world!";
+    /// let cow = Cow::Borrowed(s);
+    ///
+    /// assert_eq!(
+    ///   cow.into_owned(),
+    ///   String::from(s)
+    /// );
+    /// ```
+    ///
+    /// Calling `into_owned` on a `Cow::Owned` is a no-op:
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let s = "Hello world!";
+    /// let cow: Cow<str> = Cow::Owned(String::from(s));
+    ///
+    /// assert_eq!(
+    ///   cow.into_owned(),
+    ///   String::from(s)
+    /// );
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_owned(self) -> <B as ToOwned>::Owned {
+        match self {
+            Borrowed(borrowed) => borrowed.to_owned(),
+            Owned(owned) => owned,
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_deref", issue = "88955")]
+impl<B: ?Sized + ToOwned> const Deref for Cow<'_, B>
+where
+    B::Owned: ~const Borrow<B>,
+{
+    type Target = B;
+
+    fn deref(&self) -> &B {
+        match *self {
+            Borrowed(borrowed) => borrowed,
+            Owned(ref owned) => owned.borrow(),
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Eq for Cow<'_, B> where B: Eq + ToOwned {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Ord for Cow<'_, B>
+where
+    B: Ord + ToOwned,
+{
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, 'b, B: ?Sized, C: ?Sized> PartialEq<Cow<'b, C>> for Cow<'a, B>
+where
+    B: PartialEq<C> + ToOwned,
+    C: ToOwned,
+{
+    #[inline]
+    fn eq(&self, other: &Cow<'b, C>) -> bool {
+        PartialEq::eq(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, B: ?Sized> PartialOrd for Cow<'a, B>
+where
+    B: PartialOrd + ToOwned,
+{
+    #[inline]
+    fn partial_cmp(&self, other: &Cow<'a, B>) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> fmt::Debug for Cow<'_, B>
+where
+    B: fmt::Debug + ToOwned<Owned: fmt::Debug>,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match *self {
+            Borrowed(ref b) => fmt::Debug::fmt(b, f),
+            Owned(ref o) => fmt::Debug::fmt(o, f),
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> fmt::Display for Cow<'_, B>
+where
+    B: fmt::Display + ToOwned<Owned: fmt::Display>,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match *self {
+            Borrowed(ref b) => fmt::Display::fmt(b, f),
+            Owned(ref o) => fmt::Display::fmt(o, f),
+        }
+    }
+}
+
+#[stable(feature = "default", since = "1.11.0")]
+impl<B: ?Sized> Default for Cow<'_, B>
+where
+    B: ToOwned<Owned: Default>,
+{
+    /// Creates an owned Cow<'a, B> with the default value for the contained owned value.
+    fn default() -> Self {
+        Owned(<B as ToOwned>::Owned::default())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Hash for Cow<'_, B>
+where
+    B: Hash + ToOwned,
+{
+    #[inline]
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        Hash::hash(&**self, state)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + ToOwned> AsRef<T> for Cow<'_, T> {
+    fn as_ref(&self) -> &T {
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> Add<&'a str> for Cow<'a, str> {
+    type Output = Cow<'a, str>;
+
+    #[inline]
+    fn add(mut self, rhs: &'a str) -> Self::Output {
+        self += rhs;
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> Add<Cow<'a, str>> for Cow<'a, str> {
+    type Output = Cow<'a, str>;
+
+    #[inline]
+    fn add(mut self, rhs: Cow<'a, str>) -> Self::Output {
+        self += rhs;
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> AddAssign<&'a str> for Cow<'a, str> {
+    fn add_assign(&mut self, rhs: &'a str) {
+        if self.is_empty() {
+            *self = Cow::Borrowed(rhs)
+        } else if !rhs.is_empty() {
+            if let Cow::Borrowed(lhs) = *self {
+                let mut s = String::with_capacity(lhs.len() + rhs.len());
+                s.push_str(lhs);
+                *self = Cow::Owned(s);
+            }
+            self.to_mut().push_str(rhs);
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> AddAssign<Cow<'a, str>> for Cow<'a, str> {
+    fn add_assign(&mut self, rhs: Cow<'a, str>) {
+        if self.is_empty() {
+            *self = rhs
+        } else if !rhs.is_empty() {
+            if let Cow::Borrowed(lhs) = *self {
+                let mut s = String::with_capacity(lhs.len() + rhs.len());
+                s.push_str(lhs);
+                *self = Cow::Owned(s);
+            }
+            self.to_mut().push_str(&rhs);
+        }
+    }
+}
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
new file mode 100644
index 000000000000..ffaa9c5459f2
--- /dev/null
+++ b/rust/alloc/boxed.rs
@@ -0,0 +1,1844 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! A pointer type for heap allocation.
+//!
+//! [`Box<T>`], casually referred to as a 'box', provides the simplest form of
+//! heap allocation in Rust. Boxes provide ownership for this allocation, and
+//! drop their contents when they go out of scope. Boxes also ensure that they
+//! never allocate more than `isize::MAX` bytes.
+//!
+//! # Examples
+//!
+//! Move a value from the stack to the heap by creating a [`Box`]:
+//!
+//! ```
+//! let val: u8 = 5;
+//! let boxed: Box<u8> = Box::new(val);
+//! ```
+//!
+//! Move a value from a [`Box`] back to the stack by [dereferencing]:
+//!
+//! ```
+//! let boxed: Box<u8> = Box::new(5);
+//! let val: u8 = *boxed;
+//! ```
+//!
+//! Creating a recursive data structure:
+//!
+//! ```
+//! #[derive(Debug)]
+//! enum List<T> {
+//!     Cons(T, Box<List<T>>),
+//!     Nil,
+//! }
+//!
+//! let list: List<i32> = List::Cons(1, Box::new(List::Cons(2, Box::new(List::Nil))));
+//! println!("{:?}", list);
+//! ```
+//!
+//! This will print `Cons(1, Cons(2, Nil))`.
+//!
+//! Recursive structures must be boxed, because if the definition of `Cons`
+//! looked like this:
+//!
+//! ```compile_fail,E0072
+//! # enum List<T> {
+//! Cons(T, List<T>),
+//! # }
+//! ```
+//!
+//! It wouldn't work. This is because the size of a `List` depends on how many
+//! elements are in the list, and so we don't know how much memory to allocate
+//! for a `Cons`. By introducing a [`Box<T>`], which has a defined size, we know how
+//! big `Cons` needs to be.
+//!
+//! # Memory layout
+//!
+//! For non-zero-sized values, a [`Box`] will use the [`Global`] allocator for
+//! its allocation. It is valid to convert both ways between a [`Box`] and a
+//! raw pointer allocated with the [`Global`] allocator, given that the
+//! [`Layout`] used with the allocator is correct for the type. More precisely,
+//! a `value: *mut T` that has been allocated with the [`Global`] allocator
+//! with `Layout::for_value(&*value)` may be converted into a box using
+//! [`Box::<T>::from_raw(value)`]. Conversely, the memory backing a `value: *mut
+//! T` obtained from [`Box::<T>::into_raw`] may be deallocated using the
+//! [`Global`] allocator with [`Layout::for_value(&*value)`].
+//!
+//! For zero-sized values, the `Box` pointer still has to be [valid] for reads
+//! and writes and sufficiently aligned. In particular, casting any aligned
+//! non-zero integer literal to a raw pointer produces a valid pointer, but a
+//! pointer pointing into previously allocated memory that since got freed is
+//! not valid. The recommended way to build a Box to a ZST if `Box::new` cannot
+//! be used is to use [`ptr::NonNull::dangling`].
+//!
+//! So long as `T: Sized`, a `Box<T>` is guaranteed to be represented
+//! as a single pointer and is also ABI-compatible with C pointers
+//! (i.e. the C type `T*`). This means that if you have extern "C"
+//! Rust functions that will be called from C, you can define those
+//! Rust functions using `Box<T>` types, and use `T*` as corresponding
+//! type on the C side. As an example, consider this C header which
+//! declares functions that create and destroy some kind of `Foo`
+//! value:
+//!
+//! ```c
+//! /* C header */
+//!
+//! /* Returns ownership to the caller */
+//! struct Foo* foo_new(void);
+//!
+//! /* Takes ownership from the caller; no-op when invoked with null */
+//! void foo_delete(struct Foo*);
+//! ```
+//!
+//! These two functions might be implemented in Rust as follows. Here, the
+//! `struct Foo*` type from C is translated to `Box<Foo>`, which captures
+//! the ownership constraints. Note also that the nullable argument to
+//! `foo_delete` is represented in Rust as `Option<Box<Foo>>`, since `Box<Foo>`
+//! cannot be null.
+//!
+//! ```
+//! #[repr(C)]
+//! pub struct Foo;
+//!
+//! #[no_mangle]
+//! pub extern "C" fn foo_new() -> Box<Foo> {
+//!     Box::new(Foo)
+//! }
+//!
+//! #[no_mangle]
+//! pub extern "C" fn foo_delete(_: Option<Box<Foo>>) {}
+//! ```
+//!
+//! Even though `Box<T>` has the same representation and C ABI as a C pointer,
+//! this does not mean that you can convert an arbitrary `T*` into a `Box<T>`
+//! and expect things to work. `Box<T>` values will always be fully aligned,
+//! non-null pointers. Moreover, the destructor for `Box<T>` will attempt to
+//! free the value with the global allocator. In general, the best practice
+//! is to only use `Box<T>` for pointers that originated from the global
+//! allocator.
+//!
+//! **Important.** At least at present, you should avoid using
+//! `Box<T>` types for functions that are defined in C but invoked
+//! from Rust. In those cases, you should directly mirror the C types
+//! as closely as possible. Using types like `Box<T>` where the C
+//! definition is just using `T*` can lead to undefined behavior, as
+//! described in [rust-lang/unsafe-code-guidelines#198][ucg#198].
+//!
+//! [ucg#198]: https://github.com/rust-lang/unsafe-code-guidelines/issues/198
+//! [dereferencing]: core::ops::Deref
+//! [`Box::<T>::from_raw(value)`]: Box::from_raw
+//! [`Global`]: crate::alloc::Global
+//! [`Layout`]: crate::alloc::Layout
+//! [`Layout::for_value(&*value)`]: crate::alloc::Layout::for_value
+//! [valid]: ptr#safety
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+use core::any::Any;
+use core::borrow;
+use core::cmp::Ordering;
+use core::convert::{From, TryFrom};
+use core::fmt;
+use core::future::Future;
+use core::hash::{Hash, Hasher};
+#[cfg(not(no_global_oom_handling))]
+use core::iter::FromIterator;
+use core::iter::{FusedIterator, Iterator};
+use core::marker::{Unpin, Unsize};
+use core::mem;
+use core::ops::{
+    CoerceUnsized, Deref, DerefMut, DispatchFromDyn, Generator, GeneratorState, Receiver,
+};
+use core::pin::Pin;
+use core::ptr::{self, Unique};
+use core::stream::Stream;
+use core::task::{Context, Poll};
+
+#[cfg(not(no_global_oom_handling))]
+use crate::alloc::{handle_alloc_error, WriteCloneIntoRaw};
+use crate::alloc::{AllocError, Allocator, Global, Layout};
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::Cow;
+use crate::raw_vec::RawVec;
+#[cfg(not(no_global_oom_handling))]
+use crate::str::from_boxed_utf8_unchecked;
+#[cfg(not(no_global_oom_handling))]
+use crate::vec::Vec;
+
+/// A pointer type for heap allocation.
+///
+/// See the [module-level documentation](../../std/boxed/index.html) for more.
+#[lang = "owned_box"]
+#[fundamental]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub struct Box<
+    T: ?Sized,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+>(Unique<T>, A);
+
+impl<T> Box<T> {
+    /// Allocates memory on the heap and then places `x` into it.
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let five = Box::new(5);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline(always)]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub fn new(x: T) -> Self {
+        box x
+    }
+
+    /// Constructs a new box with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::new_uninit();
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    #[inline]
+    pub fn new_uninit() -> Box<mem::MaybeUninit<T>> {
+        Self::new_uninit_in(Global)
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let zero = Box::<u32>::new_zeroed();
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0)
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed() -> Box<mem::MaybeUninit<T>> {
+        Self::new_zeroed_in(Global)
+    }
+
+    /// Constructs a new `Pin<Box<T>>`. If `T` does not implement `Unpin`, then
+    /// `x` will be pinned in memory and unable to be moved.
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "pin", since = "1.33.0")]
+    #[must_use]
+    #[inline(always)]
+    pub fn pin(x: T) -> Pin<Box<T>> {
+        (box x).into()
+    }
+
+    /// Allocates memory on the heap then places `x` into it,
+    /// returning an error if the allocation fails
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// let five = Box::try_new(5)?;
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new(x: T) -> Result<Self, AllocError> {
+        Self::try_new_in(x, Global)
+    }
+
+    /// Constructs a new box with uninitialized contents on the heap,
+    /// returning an error if the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::try_new_uninit()?;
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub fn try_new_uninit() -> Result<Box<mem::MaybeUninit<T>>, AllocError> {
+        Box::try_new_uninit_in(Global)
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes on the heap
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let zero = Box::<u32>::try_new_zeroed()?;
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub fn try_new_zeroed() -> Result<Box<mem::MaybeUninit<T>>, AllocError> {
+        Box::try_new_zeroed_in(Global)
+    }
+}
+
+impl<T, A: Allocator> Box<T, A> {
+    /// Allocates memory in the given allocator then places `x` into it.
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let five = Box::new_in(5, System);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[must_use]
+    #[inline]
+    pub fn new_in(x: T, alloc: A) -> Self {
+        let mut boxed = Self::new_uninit_in(alloc);
+        unsafe {
+            boxed.as_mut_ptr().write(x);
+            boxed.assume_init()
+        }
+    }
+
+    /// Allocates memory in the given allocator then places `x` into it,
+    /// returning an error if the allocation fails
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let five = Box::try_new_in(5, System)?;
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new_in(x: T, alloc: A) -> Result<Self, AllocError> {
+        let mut boxed = Self::try_new_uninit_in(alloc)?;
+        unsafe {
+            boxed.as_mut_ptr().write(x);
+            Ok(boxed.assume_init())
+        }
+    }
+
+    /// Constructs a new box with uninitialized contents in the provided allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut five = Box::<u32, _>::new_uninit_in(System);
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    pub fn new_uninit_in(alloc: A) -> Box<mem::MaybeUninit<T>, A> {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
+        // That would make code size bigger.
+        match Box::try_new_uninit_in(alloc) {
+            Ok(m) => m,
+            Err(_) => handle_alloc_error(layout),
+        }
+    }
+
+    /// Constructs a new box with uninitialized contents in the provided allocator,
+    /// returning an error if the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut five = Box::<u32, _>::try_new_uninit_in(System)?;
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    pub fn try_new_uninit_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError> {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        let ptr = alloc.allocate(layout)?.cast();
+        unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes in the provided allocator.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let zero = Box::<u32, _>::new_zeroed_in(System);
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0)
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[cfg(not(no_global_oom_handling))]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed_in(alloc: A) -> Box<mem::MaybeUninit<T>, A> {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
+        // That would make code size bigger.
+        match Box::try_new_zeroed_in(alloc) {
+            Ok(m) => m,
+            Err(_) => handle_alloc_error(layout),
+        }
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes in the provided allocator,
+    /// returning an error if the allocation fails,
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let zero = Box::<u32, _>::try_new_zeroed_in(System)?;
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    pub fn try_new_zeroed_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError> {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        let ptr = alloc.allocate_zeroed(layout)?.cast();
+        unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
+    }
+
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement `Unpin`, then
+    /// `x` will be pinned in memory and unable to be moved.
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[must_use]
+    #[inline(always)]
+    pub fn pin_in(x: T, alloc: A) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        Self::new_in(x, alloc).into()
+    }
+
+    /// Converts a `Box<T>` into a `Box<[T]>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    #[unstable(feature = "box_into_boxed_slice", issue = "71582")]
+    pub fn into_boxed_slice(boxed: Self) -> Box<[T], A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(boxed);
+        unsafe { Box::from_raw_in(raw as *mut [T; 1], alloc) }
+    }
+
+    /// Consumes the `Box`, returning the wrapped value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(box_into_inner)]
+    ///
+    /// let c = Box::new(5);
+    ///
+    /// assert_eq!(Box::into_inner(c), 5);
+    /// ```
+    #[unstable(feature = "box_into_inner", issue = "80437")]
+    #[inline]
+    pub fn into_inner(boxed: Self) -> T {
+        *boxed
+    }
+}
+
+impl<T> Box<[T]> {
+    /// Constructs a new boxed slice with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::new_uninit_slice(3);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_uninit_slice(len: usize) -> Box<[mem::MaybeUninit<T>]> {
+        unsafe { RawVec::with_capacity(len).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents, with the memory
+    /// being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let values = Box::<[u32]>::new_zeroed_slice(3);
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0])
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed_slice(len: usize) -> Box<[mem::MaybeUninit<T>]> {
+        unsafe { RawVec::with_capacity_zeroed(len).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents. Returns an error if
+    /// the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::try_new_uninit_slice(3)?;
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3]);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new_uninit_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
+        unsafe {
+            let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
+                Ok(l) => l,
+                Err(_) => return Err(AllocError),
+            };
+            let ptr = Global.allocate(layout)?;
+            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
+        }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents, with the memory
+    /// being filled with `0` bytes. Returns an error if the allocation fails
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let values = Box::<[u32]>::try_new_zeroed_slice(3)?;
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0]);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new_zeroed_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
+        unsafe {
+            let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
+                Ok(l) => l,
+                Err(_) => return Err(AllocError),
+            };
+            let ptr = Global.allocate_zeroed(layout)?;
+            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
+        }
+    }
+}
+
+impl<T, A: Allocator> Box<[T], A> {
+    /// Constructs a new boxed slice with uninitialized contents in the provided allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut values = Box::<[u32], _>::new_uninit_slice_in(3, System);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_uninit_slice_in(len: usize, alloc: A) -> Box<[mem::MaybeUninit<T>], A> {
+        unsafe { RawVec::with_capacity_in(len, alloc).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents in the provided allocator,
+    /// with the memory being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let values = Box::<[u32], _>::new_zeroed_slice_in(3, System);
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0])
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed_slice_in(len: usize, alloc: A) -> Box<[mem::MaybeUninit<T>], A> {
+        unsafe { RawVec::with_capacity_zeroed_in(len, alloc).into_box(len) }
+    }
+}
+
+impl<T, A: Allocator> Box<mem::MaybeUninit<T>, A> {
+    /// Converts to `Box<T, A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with [`MaybeUninit::assume_init`],
+    /// it is up to the caller to guarantee that the value
+    /// really is in an initialized state.
+    /// Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    ///
+    /// [`MaybeUninit::assume_init`]: mem::MaybeUninit::assume_init
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::new_uninit();
+    ///
+    /// let five: Box<u32> = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub unsafe fn assume_init(self) -> Box<T, A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(self);
+        unsafe { Box::from_raw_in(raw as *mut T, alloc) }
+    }
+}
+
+impl<T, A: Allocator> Box<[mem::MaybeUninit<T>], A> {
+    /// Converts to `Box<[T], A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with [`MaybeUninit::assume_init`],
+    /// it is up to the caller to guarantee that the values
+    /// really are in an initialized state.
+    /// Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    ///
+    /// [`MaybeUninit::assume_init`]: mem::MaybeUninit::assume_init
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::new_uninit_slice(3);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub unsafe fn assume_init(self) -> Box<[T], A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(self);
+        unsafe { Box::from_raw_in(raw as *mut [T], alloc) }
+    }
+}
+
+impl<T: ?Sized> Box<T> {
+    /// Constructs a box from a raw pointer.
+    ///
+    /// After calling this function, the raw pointer is owned by the
+    /// resulting `Box`. Specifically, the `Box` destructor will call
+    /// the destructor of `T` and free the allocated memory. For this
+    /// to be safe, the memory must have been allocated in accordance
+    /// with the [memory layout] used by `Box` .
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because improper use may lead to
+    /// memory problems. For example, a double-free may occur if the
+    /// function is called twice on the same raw pointer.
+    ///
+    /// The safety conditions are described in the [memory layout] section.
+    ///
+    /// # Examples
+    ///
+    /// Recreate a `Box` which was previously converted to a raw pointer
+    /// using [`Box::into_raw`]:
+    /// ```
+    /// let x = Box::new(5);
+    /// let ptr = Box::into_raw(x);
+    /// let x = unsafe { Box::from_raw(ptr) };
+    /// ```
+    /// Manually create a `Box` from scratch by using the global allocator:
+    /// ```
+    /// use std::alloc::{alloc, Layout};
+    ///
+    /// unsafe {
+    ///     let ptr = alloc(Layout::new::<i32>()) as *mut i32;
+    ///     // In general .write is required to avoid attempting to destruct
+    ///     // the (uninitialized) previous contents of `ptr`, though for this
+    ///     // simple example `*ptr = 5` would have worked as well.
+    ///     ptr.write(5);
+    ///     let x = Box::from_raw(ptr);
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    /// [`Layout`]: crate::Layout
+    #[stable(feature = "box_raw", since = "1.4.0")]
+    #[inline]
+    pub unsafe fn from_raw(raw: *mut T) -> Self {
+        unsafe { Self::from_raw_in(raw, Global) }
+    }
+}
+
+impl<T: ?Sized, A: Allocator> Box<T, A> {
+    /// Constructs a box from a raw pointer in the given allocator.
+    ///
+    /// After calling this function, the raw pointer is owned by the
+    /// resulting `Box`. Specifically, the `Box` destructor will call
+    /// the destructor of `T` and free the allocated memory. For this
+    /// to be safe, the memory must have been allocated in accordance
+    /// with the [memory layout] used by `Box` .
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because improper use may lead to
+    /// memory problems. For example, a double-free may occur if the
+    /// function is called twice on the same raw pointer.
+    ///
+    ///
+    /// # Examples
+    ///
+    /// Recreate a `Box` which was previously converted to a raw pointer
+    /// using [`Box::into_raw_with_allocator`]:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let x = Box::new_in(5, System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// let x = unsafe { Box::from_raw_in(ptr, alloc) };
+    /// ```
+    /// Manually create a `Box` from scratch by using the system allocator:
+    /// ```
+    /// #![feature(allocator_api, slice_ptr_get)]
+    ///
+    /// use std::alloc::{Allocator, Layout, System};
+    ///
+    /// unsafe {
+    ///     let ptr = System.allocate(Layout::new::<i32>())?.as_mut_ptr() as *mut i32;
+    ///     // In general .write is required to avoid attempting to destruct
+    ///     // the (uninitialized) previous contents of `ptr`, though for this
+    ///     // simple example `*ptr = 5` would have worked as well.
+    ///     ptr.write(5);
+    ///     let x = Box::from_raw_in(ptr, System);
+    /// }
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    /// [`Layout`]: crate::Layout
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub unsafe fn from_raw_in(raw: *mut T, alloc: A) -> Self {
+        Box(unsafe { Unique::new_unchecked(raw) }, alloc)
+    }
+
+    /// Consumes the `Box`, returning a wrapped raw pointer.
+    ///
+    /// The pointer will be properly aligned and non-null.
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Box`. In particular, the
+    /// caller should properly destroy `T` and release the memory, taking
+    /// into account the [memory layout] used by `Box`. The easiest way to
+    /// do this is to convert the raw pointer back into a `Box` with the
+    /// [`Box::from_raw`] function, allowing the `Box` destructor to perform
+    /// the cleanup.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::into_raw(b)` instead of `b.into_raw()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    /// Converting the raw pointer back into a `Box` with [`Box::from_raw`]
+    /// for automatic cleanup:
+    /// ```
+    /// let x = Box::new(String::from("Hello"));
+    /// let ptr = Box::into_raw(x);
+    /// let x = unsafe { Box::from_raw(ptr) };
+    /// ```
+    /// Manual cleanup by explicitly running the destructor and deallocating
+    /// the memory:
+    /// ```
+    /// use std::alloc::{dealloc, Layout};
+    /// use std::ptr;
+    ///
+    /// let x = Box::new(String::from("Hello"));
+    /// let p = Box::into_raw(x);
+    /// unsafe {
+    ///     ptr::drop_in_place(p);
+    ///     dealloc(p as *mut u8, Layout::new::<String>());
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    #[stable(feature = "box_raw", since = "1.4.0")]
+    #[inline]
+    pub fn into_raw(b: Self) -> *mut T {
+        Self::into_raw_with_allocator(b).0
+    }
+
+    /// Consumes the `Box`, returning a wrapped raw pointer and the allocator.
+    ///
+    /// The pointer will be properly aligned and non-null.
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Box`. In particular, the
+    /// caller should properly destroy `T` and release the memory, taking
+    /// into account the [memory layout] used by `Box`. The easiest way to
+    /// do this is to convert the raw pointer back into a `Box` with the
+    /// [`Box::from_raw_in`] function, allowing the `Box` destructor to perform
+    /// the cleanup.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::into_raw_with_allocator(b)` instead of `b.into_raw_with_allocator()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    /// Converting the raw pointer back into a `Box` with [`Box::from_raw_in`]
+    /// for automatic cleanup:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let x = Box::new_in(String::from("Hello"), System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// let x = unsafe { Box::from_raw_in(ptr, alloc) };
+    /// ```
+    /// Manual cleanup by explicitly running the destructor and deallocating
+    /// the memory:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::{Allocator, Layout, System};
+    /// use std::ptr::{self, NonNull};
+    ///
+    /// let x = Box::new_in(String::from("Hello"), System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// unsafe {
+    ///     ptr::drop_in_place(ptr);
+    ///     let non_null = NonNull::new_unchecked(ptr);
+    ///     alloc.deallocate(non_null.cast(), Layout::new::<String>());
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn into_raw_with_allocator(b: Self) -> (*mut T, A) {
+        let (leaked, alloc) = Box::into_unique(b);
+        (leaked.as_ptr(), alloc)
+    }
+
+    #[unstable(
+        feature = "ptr_internals",
+        issue = "none",
+        reason = "use `Box::leak(b).into()` or `Unique::from(Box::leak(b))` instead"
+    )]
+    #[inline]
+    #[doc(hidden)]
+    pub fn into_unique(b: Self) -> (Unique<T>, A) {
+        // Box is recognized as a "unique pointer" by Stacked Borrows, but internally it is a
+        // raw pointer for the type system. Turning it directly into a raw pointer would not be
+        // recognized as "releasing" the unique pointer to permit aliased raw accesses,
+        // so all raw pointer methods have to go through `Box::leak`. Turning *that* to a raw pointer
+        // behaves correctly.
+        let alloc = unsafe { ptr::read(&b.1) };
+        (Unique::from(Box::leak(b)), alloc)
+    }
+
+    /// Returns a reference to the underlying allocator.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::allocator(&b)` instead of `b.allocator()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(b: &Self) -> &A {
+        &b.1
+    }
+
+    /// Consumes and leaks the `Box`, returning a mutable reference,
+    /// `&'a mut T`. Note that the type `T` must outlive the chosen lifetime
+    /// `'a`. If the type has only static references, or none at all, then this
+    /// may be chosen to be `'static`.
+    ///
+    /// This function is mainly useful for data that lives for the remainder of
+    /// the program's life. Dropping the returned reference will cause a memory
+    /// leak. If this is not acceptable, the reference should first be wrapped
+    /// with the [`Box::from_raw`] function producing a `Box`. This `Box` can
+    /// then be dropped which will properly destroy `T` and release the
+    /// allocated memory.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::leak(b)` instead of `b.leak()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    ///
+    /// Simple usage:
+    ///
+    /// ```
+    /// let x = Box::new(41);
+    /// let static_ref: &'static mut usize = Box::leak(x);
+    /// *static_ref += 1;
+    /// assert_eq!(*static_ref, 42);
+    /// ```
+    ///
+    /// Unsized data:
+    ///
+    /// ```
+    /// let x = vec![1, 2, 3].into_boxed_slice();
+    /// let static_ref = Box::leak(x);
+    /// static_ref[0] = 4;
+    /// assert_eq!(*static_ref, [4, 2, 3]);
+    /// ```
+    #[stable(feature = "box_leak", since = "1.26.0")]
+    #[inline]
+    pub fn leak<'a>(b: Self) -> &'a mut T
+    where
+        A: 'a,
+    {
+        unsafe { &mut *mem::ManuallyDrop::new(b).0.as_ptr() }
+    }
+
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// This is also available via [`From`].
+    #[unstable(feature = "box_into_pin", issue = "62370")]
+    pub fn into_pin(boxed: Self) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        // It's not possible to move or replace the insides of a `Pin<Box<T>>`
+        // when `T: !Unpin`,  so it's safe to pin it directly without any
+        // additional requirements.
+        unsafe { Pin::new_unchecked(boxed) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T: ?Sized, A: Allocator> Drop for Box<T, A> {
+    fn drop(&mut self) {
+        // FIXME: Do nothing, drop is currently performed by compiler.
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Default> Default for Box<T> {
+    /// Creates a `Box<T>`, with the `Default` value for T.
+    fn default() -> Self {
+        box T::default()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> Default for Box<[T]> {
+    fn default() -> Self {
+        Box::<[T; 0]>::new([])
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "default_box_extra", since = "1.17.0")]
+impl Default for Box<str> {
+    fn default() -> Self {
+        unsafe { from_boxed_utf8_unchecked(Default::default()) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Box<T, A> {
+    /// Returns a new box with a `clone()` of this box's contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = Box::new(5);
+    /// let y = x.clone();
+    ///
+    /// // The value is the same
+    /// assert_eq!(x, y);
+    ///
+    /// // But they are unique objects
+    /// assert_ne!(&*x as *const i32, &*y as *const i32);
+    /// ```
+    #[inline]
+    fn clone(&self) -> Self {
+        // Pre-allocate memory to allow writing the cloned value directly.
+        let mut boxed = Self::new_uninit_in(self.1.clone());
+        unsafe {
+            (**self).write_clone_into_raw(boxed.as_mut_ptr());
+            boxed.assume_init()
+        }
+    }
+
+    /// Copies `source`'s contents into `self` without creating a new allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = Box::new(5);
+    /// let mut y = Box::new(10);
+    /// let yp: *const i32 = &*y;
+    ///
+    /// y.clone_from(&x);
+    ///
+    /// // The value is the same
+    /// assert_eq!(x, y);
+    ///
+    /// // And no allocation occurred
+    /// assert_eq!(yp, &*y);
+    /// ```
+    #[inline]
+    fn clone_from(&mut self, source: &Self) {
+        (**self).clone_from(&(**source));
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_slice_clone", since = "1.3.0")]
+impl Clone for Box<str> {
+    fn clone(&self) -> Self {
+        // this makes a copy of the data
+        let buf: Box<[u8]> = self.as_bytes().into();
+        unsafe { from_boxed_utf8_unchecked(buf) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + PartialEq, A: Allocator> PartialEq for Box<T, A> {
+    #[inline]
+    fn eq(&self, other: &Self) -> bool {
+        PartialEq::eq(&**self, &**other)
+    }
+    #[inline]
+    fn ne(&self, other: &Self) -> bool {
+        PartialEq::ne(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + PartialOrd, A: Allocator> PartialOrd for Box<T, A> {
+    #[inline]
+    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+    #[inline]
+    fn lt(&self, other: &Self) -> bool {
+        PartialOrd::lt(&**self, &**other)
+    }
+    #[inline]
+    fn le(&self, other: &Self) -> bool {
+        PartialOrd::le(&**self, &**other)
+    }
+    #[inline]
+    fn ge(&self, other: &Self) -> bool {
+        PartialOrd::ge(&**self, &**other)
+    }
+    #[inline]
+    fn gt(&self, other: &Self) -> bool {
+        PartialOrd::gt(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Ord, A: Allocator> Ord for Box<T, A> {
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Eq, A: Allocator> Eq for Box<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Hash, A: Allocator> Hash for Box<T, A> {
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        (**self).hash(state);
+    }
+}
+
+#[stable(feature = "indirect_hasher_impl", since = "1.22.0")]
+impl<T: ?Sized + Hasher, A: Allocator> Hasher for Box<T, A> {
+    fn finish(&self) -> u64 {
+        (**self).finish()
+    }
+    fn write(&mut self, bytes: &[u8]) {
+        (**self).write(bytes)
+    }
+    fn write_u8(&mut self, i: u8) {
+        (**self).write_u8(i)
+    }
+    fn write_u16(&mut self, i: u16) {
+        (**self).write_u16(i)
+    }
+    fn write_u32(&mut self, i: u32) {
+        (**self).write_u32(i)
+    }
+    fn write_u64(&mut self, i: u64) {
+        (**self).write_u64(i)
+    }
+    fn write_u128(&mut self, i: u128) {
+        (**self).write_u128(i)
+    }
+    fn write_usize(&mut self, i: usize) {
+        (**self).write_usize(i)
+    }
+    fn write_i8(&mut self, i: i8) {
+        (**self).write_i8(i)
+    }
+    fn write_i16(&mut self, i: i16) {
+        (**self).write_i16(i)
+    }
+    fn write_i32(&mut self, i: i32) {
+        (**self).write_i32(i)
+    }
+    fn write_i64(&mut self, i: i64) {
+        (**self).write_i64(i)
+    }
+    fn write_i128(&mut self, i: i128) {
+        (**self).write_i128(i)
+    }
+    fn write_isize(&mut self, i: isize) {
+        (**self).write_isize(i)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "from_for_ptrs", since = "1.6.0")]
+impl<T> From<T> for Box<T> {
+    /// Converts a `T` into a `Box<T>`
+    ///
+    /// The conversion allocates on the heap and moves `t`
+    /// from the stack into it.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let x = 5;
+    /// let boxed = Box::new(5);
+    ///
+    /// assert_eq!(Box::from(x), boxed);
+    /// ```
+    fn from(t: T) -> Self {
+        Box::new(t)
+    }
+}
+
+#[stable(feature = "pin", since = "1.33.0")]
+impl<T: ?Sized, A: Allocator> From<Box<T, A>> for Pin<Box<T, A>>
+where
+    A: 'static,
+{
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    fn from(boxed: Box<T, A>) -> Self {
+        Box::into_pin(boxed)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_slice", since = "1.17.0")]
+impl<T: Copy> From<&[T]> for Box<[T]> {
+    /// Converts a `&[T]` into a `Box<[T]>`
+    ///
+    /// This conversion allocates on the heap
+    /// and performs a copy of `slice`.
+    ///
+    /// # Examples
+    /// ```rust
+    /// // create a &[u8] which will be used to create a Box<[u8]>
+    /// let slice: &[u8] = &[104, 101, 108, 108, 111];
+    /// let boxed_slice: Box<[u8]> = Box::from(slice);
+    ///
+    /// println!("{:?}", boxed_slice);
+    /// ```
+    fn from(slice: &[T]) -> Box<[T]> {
+        let len = slice.len();
+        let buf = RawVec::with_capacity(len);
+        unsafe {
+            ptr::copy_nonoverlapping(slice.as_ptr(), buf.ptr(), len);
+            buf.into_box(slice.len()).assume_init()
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_cow", since = "1.45.0")]
+impl<T: Copy> From<Cow<'_, [T]>> for Box<[T]> {
+    /// Converts a `Cow<'_, [T]>` into a `Box<[T]>`
+    ///
+    /// When `cow` is the `Cow::Borrowed` variant, this
+    /// conversion allocates on the heap and copies the
+    /// underlying slice. Otherwise, it will try to reuse the owned
+    /// `Vec`'s allocation.
+    #[inline]
+    fn from(cow: Cow<'_, [T]>) -> Box<[T]> {
+        match cow {
+            Cow::Borrowed(slice) => Box::from(slice),
+            Cow::Owned(slice) => Box::from(slice),
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_slice", since = "1.17.0")]
+impl From<&str> for Box<str> {
+    /// Converts a `&str` into a `Box<str>`
+    ///
+    /// This conversion allocates on the heap
+    /// and performs a copy of `s`.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let boxed: Box<str> = Box::from("hello");
+    /// println!("{}", boxed);
+    /// ```
+    #[inline]
+    fn from(s: &str) -> Box<str> {
+        unsafe { from_boxed_utf8_unchecked(Box::from(s.as_bytes())) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_cow", since = "1.45.0")]
+impl From<Cow<'_, str>> for Box<str> {
+    /// Converts a `Cow<'_, str>` into a `Box<str>`
+    ///
+    /// When `cow` is the `Cow::Borrowed` variant, this
+    /// conversion allocates on the heap and copies the
+    /// underlying `str`. Otherwise, it will try to reuse the owned
+    /// `String`'s allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use std::borrow::Cow;
+    ///
+    /// let unboxed = Cow::Borrowed("hello");
+    /// let boxed: Box<str> = Box::from(unboxed);
+    /// println!("{}", boxed);
+    /// ```
+    ///
+    /// ```rust
+    /// # use std::borrow::Cow;
+    /// let unboxed = Cow::Owned("hello".to_string());
+    /// let boxed: Box<str> = Box::from(unboxed);
+    /// println!("{}", boxed);
+    /// ```
+    #[inline]
+    fn from(cow: Cow<'_, str>) -> Box<str> {
+        match cow {
+            Cow::Borrowed(s) => Box::from(s),
+            Cow::Owned(s) => Box::from(s),
+        }
+    }
+}
+
+#[stable(feature = "boxed_str_conv", since = "1.19.0")]
+impl<A: Allocator> From<Box<str, A>> for Box<[u8], A> {
+    /// Converts a `Box<str>` into a `Box<[u8]>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// # Examples
+    /// ```rust
+    /// // create a Box<str> which will be used to create a Box<[u8]>
+    /// let boxed: Box<str> = Box::from("hello");
+    /// let boxed_str: Box<[u8]> = Box::from(boxed);
+    ///
+    /// // create a &[u8] which will be used to create a Box<[u8]>
+    /// let slice: &[u8] = &[104, 101, 108, 108, 111];
+    /// let boxed_slice = Box::from(slice);
+    ///
+    /// assert_eq!(boxed_slice, boxed_str);
+    /// ```
+    #[inline]
+    fn from(s: Box<str, A>) -> Self {
+        let (raw, alloc) = Box::into_raw_with_allocator(s);
+        unsafe { Box::from_raw_in(raw as *mut [u8], alloc) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_array", since = "1.45.0")]
+impl<T, const N: usize> From<[T; N]> for Box<[T]> {
+    /// Converts a `[T; N]` into a `Box<[T]>`
+    ///
+    /// This conversion moves the array to newly heap-allocated memory.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let boxed: Box<[u8]> = Box::from([4, 2]);
+    /// println!("{:?}", boxed);
+    /// ```
+    fn from(array: [T; N]) -> Box<[T]> {
+        box array
+    }
+}
+
+#[stable(feature = "boxed_slice_try_from", since = "1.43.0")]
+impl<T, const N: usize> TryFrom<Box<[T]>> for Box<[T; N]> {
+    type Error = Box<[T]>;
+
+    /// Attempts to convert a `Box<[T]>` into a `Box<[T; N]>`.
+    ///
+    /// The conversion occurs in-place and does not require a
+    /// new memory allocation.
+    ///
+    /// # Errors
+    ///
+    /// Returns the old `Box<[T]>` in the `Err` variant if
+    /// `boxed_slice.len()` does not equal `N`.
+    fn try_from(boxed_slice: Box<[T]>) -> Result<Self, Self::Error> {
+        if boxed_slice.len() == N {
+            Ok(unsafe { Box::from_raw(Box::into_raw(boxed_slice) as *mut [T; N]) })
+        } else {
+            Err(boxed_slice)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any, A> {
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() {
+            unsafe {
+                let (raw, alloc): (*mut dyn Any, _) = Box::into_raw_with_allocator(self);
+                Ok(Box::from_raw_in(raw as *mut T, alloc))
+            }
+        } else {
+            Err(self)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any + Send, A> {
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any + Send>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() {
+            unsafe {
+                let (raw, alloc): (*mut (dyn Any + Send), _) = Box::into_raw_with_allocator(self);
+                Ok(Box::from_raw_in(raw as *mut T, alloc))
+            }
+        } else {
+            Err(self)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any + Send + Sync, A> {
+    #[inline]
+    #[stable(feature = "box_send_sync_any_downcast", since = "1.51.0")]
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any + Send + Sync>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() {
+            unsafe {
+                let (raw, alloc): (*mut (dyn Any + Send + Sync), _) =
+                    Box::into_raw_with_allocator(self);
+                Ok(Box::from_raw_in(raw as *mut T, alloc))
+            }
+        } else {
+            Err(self)
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Display + ?Sized, A: Allocator> fmt::Display for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Debug + ?Sized, A: Allocator> fmt::Debug for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized, A: Allocator> fmt::Pointer for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        // It's not possible to extract the inner Uniq directly from the Box,
+        // instead we cast it to a *const which aliases the Unique
+        let ptr: *const T = &**self;
+        fmt::Pointer::fmt(&ptr, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized, A: Allocator> Deref for Box<T, A> {
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized, A: Allocator> DerefMut for Box<T, A> {
+    fn deref_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+#[unstable(feature = "receiver_trait", issue = "none")]
+impl<T: ?Sized, A: Allocator> Receiver for Box<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: Iterator + ?Sized, A: Allocator> Iterator for Box<I, A> {
+    type Item = I::Item;
+    fn next(&mut self) -> Option<I::Item> {
+        (**self).next()
+    }
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (**self).size_hint()
+    }
+    fn nth(&mut self, n: usize) -> Option<I::Item> {
+        (**self).nth(n)
+    }
+    fn last(self) -> Option<I::Item> {
+        BoxIter::last(self)
+    }
+}
+
+trait BoxIter {
+    type Item;
+    fn last(self) -> Option<Self::Item>;
+}
+
+impl<I: Iterator + ?Sized, A: Allocator> BoxIter for Box<I, A> {
+    type Item = I::Item;
+    default fn last(self) -> Option<I::Item> {
+        #[inline]
+        fn some<T>(_: Option<T>, x: T) -> Option<T> {
+            Some(x)
+        }
+
+        self.fold(None, some)
+    }
+}
+
+/// Specialization for sized `I`s that uses `I`s implementation of `last()`
+/// instead of the default.
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: Iterator, A: Allocator> BoxIter for Box<I, A> {
+    fn last(self) -> Option<I::Item> {
+        (*self).last()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: DoubleEndedIterator + ?Sized, A: Allocator> DoubleEndedIterator for Box<I, A> {
+    fn next_back(&mut self) -> Option<I::Item> {
+        (**self).next_back()
+    }
+    fn nth_back(&mut self, n: usize) -> Option<I::Item> {
+        (**self).nth_back(n)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: ExactSizeIterator + ?Sized, A: Allocator> ExactSizeIterator for Box<I, A> {
+    fn len(&self) -> usize {
+        (**self).len()
+    }
+    fn is_empty(&self) -> bool {
+        (**self).is_empty()
+    }
+}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<I: FusedIterator + ?Sized, A: Allocator> FusedIterator for Box<I, A> {}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: FnOnce<Args> + ?Sized, A: Allocator> FnOnce<Args> for Box<F, A> {
+    type Output = <F as FnOnce<Args>>::Output;
+
+    extern "rust-call" fn call_once(self, args: Args) -> Self::Output {
+        <F as FnOnce<Args>>::call_once(*self, args)
+    }
+}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: FnMut<Args> + ?Sized, A: Allocator> FnMut<Args> for Box<F, A> {
+    extern "rust-call" fn call_mut(&mut self, args: Args) -> Self::Output {
+        <F as FnMut<Args>>::call_mut(self, args)
+    }
+}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: Fn<Args> + ?Sized, A: Allocator> Fn<Args> for Box<F, A> {
+    extern "rust-call" fn call(&self, args: Args) -> Self::Output {
+        <F as Fn<Args>>::call(self, args)
+    }
+}
+
+#[unstable(feature = "coerce_unsized", issue = "27732")]
+impl<T: ?Sized + Unsize<U>, U: ?Sized, A: Allocator> CoerceUnsized<Box<U, A>> for Box<T, A> {}
+
+#[unstable(feature = "dispatch_from_dyn", issue = "none")]
+impl<T: ?Sized + Unsize<U>, U: ?Sized> DispatchFromDyn<Box<U>> for Box<T, Global> {}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "boxed_slice_from_iter", since = "1.32.0")]
+impl<I> FromIterator<I> for Box<[I]> {
+    fn from_iter<T: IntoIterator<Item = I>>(iter: T) -> Self {
+        iter.into_iter().collect::<Vec<_>>().into_boxed_slice()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_slice_clone", since = "1.3.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Box<[T], A> {
+    fn clone(&self) -> Self {
+        let alloc = Box::allocator(self).clone();
+        self.to_vec_in(alloc).into_boxed_slice()
+    }
+
+    fn clone_from(&mut self, other: &Self) {
+        if self.len() == other.len() {
+            self.clone_from_slice(&other);
+        } else {
+            *self = other.clone();
+        }
+    }
+}
+
+#[stable(feature = "box_borrow", since = "1.1.0")]
+impl<T: ?Sized, A: Allocator> borrow::Borrow<T> for Box<T, A> {
+    fn borrow(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(feature = "box_borrow", since = "1.1.0")]
+impl<T: ?Sized, A: Allocator> borrow::BorrowMut<T> for Box<T, A> {
+    fn borrow_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+#[stable(since = "1.5.0", feature = "smart_ptr_as_ref")]
+impl<T: ?Sized, A: Allocator> AsRef<T> for Box<T, A> {
+    fn as_ref(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(since = "1.5.0", feature = "smart_ptr_as_ref")]
+impl<T: ?Sized, A: Allocator> AsMut<T> for Box<T, A> {
+    fn as_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+/* Nota bene
+ *
+ *  We could have chosen not to add this impl, and instead have written a
+ *  function of Pin<Box<T>> to Pin<T>. Such a function would not be sound,
+ *  because Box<T> implements Unpin even when T does not, as a result of
+ *  this impl.
+ *
+ *  We chose this API instead of the alternative for a few reasons:
+ *      - Logically, it is helpful to understand pinning in regard to the
+ *        memory region being pointed to. For this reason none of the
+ *        standard library pointer types support projecting through a pin
+ *        (Box<T> is the only pointer type in std for which this would be
+ *        safe.)
+ *      - It is in practice very useful to have Box<T> be unconditionally
+ *        Unpin because of trait objects, for which the structural auto
+ *        trait functionality does not apply (e.g., Box<dyn Foo> would
+ *        otherwise not be Unpin).
+ *
+ *  Another type with the same semantics as Box but only a conditional
+ *  implementation of `Unpin` (where `T: Unpin`) would be valid/safe, and
+ *  could have a method to project a Pin<T> from it.
+ */
+#[stable(feature = "pin", since = "1.33.0")]
+impl<T: ?Sized, A: Allocator> Unpin for Box<T, A> where A: 'static {}
+
+#[unstable(feature = "generator_trait", issue = "43122")]
+impl<G: ?Sized + Generator<R> + Unpin, R, A: Allocator> Generator<R> for Box<G, A>
+where
+    A: 'static,
+{
+    type Yield = G::Yield;
+    type Return = G::Return;
+
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+        G::resume(Pin::new(&mut *self), arg)
+    }
+}
+
+#[unstable(feature = "generator_trait", issue = "43122")]
+impl<G: ?Sized + Generator<R>, R, A: Allocator> Generator<R> for Pin<Box<G, A>>
+where
+    A: 'static,
+{
+    type Yield = G::Yield;
+    type Return = G::Return;
+
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+        G::resume((*self).as_mut(), arg)
+    }
+}
+
+#[stable(feature = "futures_api", since = "1.36.0")]
+impl<F: ?Sized + Future + Unpin, A: Allocator> Future for Box<F, A>
+where
+    A: 'static,
+{
+    type Output = F::Output;
+
+    fn poll(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Self::Output> {
+        F::poll(Pin::new(&mut *self), cx)
+    }
+}
+
+#[unstable(feature = "async_stream", issue = "79024")]
+impl<S: ?Sized + Stream + Unpin> Stream for Box<S> {
+    type Item = S::Item;
+
+    fn poll_next(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Option<Self::Item>> {
+        Pin::new(&mut **self).poll_next(cx)
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (**self).size_hint()
+    }
+}
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
new file mode 100644
index 000000000000..ab83867b985a
--- /dev/null
+++ b/rust/alloc/collections/mod.rs
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! Collection types.
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[cfg(not(no_global_oom_handling))]
+pub mod binary_heap;
+#[cfg(not(no_global_oom_handling))]
+mod btree;
+#[cfg(not(no_global_oom_handling))]
+pub mod linked_list;
+#[cfg(not(no_global_oom_handling))]
+pub mod vec_deque;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub mod btree_map {
+    //! A map based on a B-Tree.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub use super::btree::map::*;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub mod btree_set {
+    //! A set based on a B-Tree.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub use super::btree::set::*;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use binary_heap::BinaryHeap;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use btree_map::BTreeMap;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use btree_set::BTreeSet;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use linked_list::LinkedList;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use vec_deque::VecDeque;
+
+use crate::alloc::{Layout, LayoutError};
+use core::fmt::Display;
+
+/// The error type for `try_reserve` methods.
+#[derive(Clone, PartialEq, Eq, Debug)]
+#[stable(feature = "try_reserve", since = "1.57.0")]
+pub struct TryReserveError {
+    kind: TryReserveErrorKind,
+}
+
+impl TryReserveError {
+    /// Details about the allocation that caused the error
+    #[inline]
+    #[unstable(
+        feature = "try_reserve_kind",
+        reason = "Uncertain how much info should be exposed",
+        issue = "48043"
+    )]
+    pub fn kind(&self) -> TryReserveErrorKind {
+        self.kind.clone()
+    }
+}
+
+/// Details of the allocation that caused a `TryReserveError`
+#[derive(Clone, PartialEq, Eq, Debug)]
+#[unstable(
+    feature = "try_reserve_kind",
+    reason = "Uncertain how much info should be exposed",
+    issue = "48043"
+)]
+pub enum TryReserveErrorKind {
+    /// Error due to the computed capacity exceeding the collection's maximum
+    /// (usually `isize::MAX` bytes).
+    CapacityOverflow,
+
+    /// The memory allocator returned an error
+    AllocError {
+        /// The layout of allocation request that failed
+        layout: Layout,
+
+        #[doc(hidden)]
+        #[unstable(
+            feature = "container_error_extra",
+            issue = "none",
+            reason = "\
+            Enable exposing the allocator’s custom error value \
+            if an associated type is added in the future: \
+            https://github.com/rust-lang/wg-allocators/issues/23"
+        )]
+        non_exhaustive: (),
+    },
+}
+
+#[unstable(
+    feature = "try_reserve_kind",
+    reason = "Uncertain how much info should be exposed",
+    issue = "48043"
+)]
+impl From<TryReserveErrorKind> for TryReserveError {
+    #[inline]
+    fn from(kind: TryReserveErrorKind) -> Self {
+        Self { kind }
+    }
+}
+
+#[unstable(feature = "try_reserve_kind", reason = "new API", issue = "48043")]
+impl From<LayoutError> for TryReserveErrorKind {
+    /// Always evaluates to [`TryReserveErrorKind::CapacityOverflow`].
+    #[inline]
+    fn from(_: LayoutError) -> Self {
+        TryReserveErrorKind::CapacityOverflow
+    }
+}
+
+#[stable(feature = "try_reserve", since = "1.57.0")]
+impl Display for TryReserveError {
+    fn fmt(
+        &self,
+        fmt: &mut core::fmt::Formatter<'_>,
+    ) -> core::result::Result<(), core::fmt::Error> {
+        fmt.write_str("memory allocation failed")?;
+        let reason = match self.kind {
+            TryReserveErrorKind::CapacityOverflow => {
+                " because the computed capacity exceeded the collection's maximum"
+            }
+            TryReserveErrorKind::AllocError { .. } => {
+                " because the memory allocator returned a error"
+            }
+        };
+        fmt.write_str(reason)
+    }
+}
+
+/// An intermediate trait for specialization of `Extend`.
+#[doc(hidden)]
+trait SpecExtend<I: IntoIterator> {
+    /// Extends `self` with the contents of the given iterator.
+    fn spec_extend(&mut self, iter: I);
+}
diff --git a/rust/alloc/fmt.rs b/rust/alloc/fmt.rs
new file mode 100644
index 000000000000..6a3fadcaf5dd
--- /dev/null
+++ b/rust/alloc/fmt.rs
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! Utilities for formatting and printing `String`s.
+//!
+//! This module contains the runtime support for the [`format!`] syntax extension.
+//! This macro is implemented in the compiler to emit calls to this module in
+//! order to format arguments at runtime into strings.
+//!
+//! # Usage
+//!
+//! The [`format!`] macro is intended to be familiar to those coming from C's
+//! `printf`/`fprintf` functions or Python's `str.format` function.
+//!
+//! Some examples of the [`format!`] extension are:
+//!
+//! ```
+//! format!("Hello");                 // => "Hello"
+//! format!("Hello, {}!", "world");   // => "Hello, world!"
+//! format!("The number is {}", 1);   // => "The number is 1"
+//! format!("{:?}", (3, 4));          // => "(3, 4)"
+//! format!("{value}", value=4);      // => "4"
+//! format!("{} {}", 1, 2);           // => "1 2"
+//! format!("{:04}", 42);             // => "0042" with leading zeros
+//! format!("{:#?}", (100, 200));     // => "(
+//!                                   //       100,
+//!                                   //       200,
+//!                                   //     )"
+//! ```
+//!
+//! From these, you can see that the first argument is a format string. It is
+//! required by the compiler for this to be a string literal; it cannot be a
+//! variable passed in (in order to perform validity checking). The compiler
+//! will then parse the format string and determine if the list of arguments
+//! provided is suitable to pass to this format string.
+//!
+//! To convert a single value to a string, use the [`to_string`] method. This
+//! will use the [`Display`] formatting trait.
+//!
+//! ## Positional parameters
+//!
+//! Each formatting argument is allowed to specify which value argument it's
+//! referencing, and if omitted it is assumed to be "the next argument". For
+//! example, the format string `{} {} {}` would take three parameters, and they
+//! would be formatted in the same order as they're given. The format string
+//! `{2} {1} {0}`, however, would format arguments in reverse order.
+//!
+//! Things can get a little tricky once you start intermingling the two types of
+//! positional specifiers. The "next argument" specifier can be thought of as an
+//! iterator over the argument. Each time a "next argument" specifier is seen,
+//! the iterator advances. This leads to behavior like this:
+//!
+//! ```
+//! format!("{1} {} {0} {}", 1, 2); // => "2 1 1 2"
+//! ```
+//!
+//! The internal iterator over the argument has not been advanced by the time
+//! the first `{}` is seen, so it prints the first argument. Then upon reaching
+//! the second `{}`, the iterator has advanced forward to the second argument.
+//! Essentially, parameters that explicitly name their argument do not affect
+//! parameters that do not name an argument in terms of positional specifiers.
+//!
+//! A format string is required to use all of its arguments, otherwise it is a
+//! compile-time error. You may refer to the same argument more than once in the
+//! format string.
+//!
+//! ## Named parameters
+//!
+//! Rust itself does not have a Python-like equivalent of named parameters to a
+//! function, but the [`format!`] macro is a syntax extension that allows it to
+//! leverage named parameters. Named parameters are listed at the end of the
+//! argument list and have the syntax:
+//!
+//! ```text
+//! identifier '=' expression
+//! ```
+//!
+//! For example, the following [`format!`] expressions all use named argument:
+//!
+//! ```
+//! format!("{argument}", argument = "test");   // => "test"
+//! format!("{name} {}", 1, name = 2);          // => "2 1"
+//! format!("{a} {c} {b}", a="a", b='b', c=3);  // => "a 3 b"
+//! ```
+//!
+//! It is not valid to put positional parameters (those without names) after
+//! arguments that have names. Like with positional parameters, it is not
+//! valid to provide named parameters that are unused by the format string.
+//!
+//! # Formatting Parameters
+//!
+//! Each argument being formatted can be transformed by a number of formatting
+//! parameters (corresponding to `format_spec` in [the syntax](#syntax)). These
+//! parameters affect the string representation of what's being formatted.
+//!
+//! ## Width
+//!
+//! ```
+//! // All of these print "Hello x    !"
+//! println!("Hello {:5}!", "x");
+//! println!("Hello {:1$}!", "x", 5);
+//! println!("Hello {1:0$}!", 5, "x");
+//! println!("Hello {:width$}!", "x", width = 5);
+//! ```
+//!
+//! This is a parameter for the "minimum width" that the format should take up.
+//! If the value's string does not fill up this many characters, then the
+//! padding specified by fill/alignment will be used to take up the required
+//! space (see below).
+//!
+//! The value for the width can also be provided as a [`usize`] in the list of
+//! parameters by adding a postfix `$`, indicating that the second argument is
+//! a [`usize`] specifying the width.
+//!
+//! Referring to an argument with the dollar syntax does not affect the "next
+//! argument" counter, so it's usually a good idea to refer to arguments by
+//! position, or use named arguments.
+//!
+//! ## Fill/Alignment
+//!
+//! ```
+//! assert_eq!(format!("Hello {:<5}!", "x"),  "Hello x    !");
+//! assert_eq!(format!("Hello {:-<5}!", "x"), "Hello x----!");
+//! assert_eq!(format!("Hello {:^5}!", "x"),  "Hello   x  !");
+//! assert_eq!(format!("Hello {:>5}!", "x"),  "Hello     x!");
+//! ```
+//!
+//! The optional fill character and alignment is provided normally in conjunction with the
+//! [`width`](#width) parameter. It must be defined before `width`, right after the `:`.
+//! This indicates that if the value being formatted is smaller than
+//! `width` some extra characters will be printed around it.
+//! Filling comes in the following variants for different alignments:
+//!
+//! * `[fill]<` - the argument is left-aligned in `width` columns
+//! * `[fill]^` - the argument is center-aligned in `width` columns
+//! * `[fill]>` - the argument is right-aligned in `width` columns
+//!
+//! The default [fill/alignment](#fillalignment) for non-numerics is a space and
+//! left-aligned. The
+//! default for numeric formatters is also a space character but with right-alignment. If
+//! the `0` flag (see below) is specified for numerics, then the implicit fill character is
+//! `0`.
+//!
+//! Note that alignment might not be implemented by some types. In particular, it
+//! is not generally implemented for the `Debug` trait.  A good way to ensure
+//! padding is applied is to format your input, then pad this resulting string
+//! to obtain your output:
+//!
+//! ```
+//! println!("Hello {:^15}!", format!("{:?}", Some("hi"))); // => "Hello   Some("hi")   !"
+//! ```
+//!
+//! ## Sign/`#`/`0`
+//!
+//! ```
+//! assert_eq!(format!("Hello {:+}!", 5), "Hello +5!");
+//! assert_eq!(format!("{:#x}!", 27), "0x1b!");
+//! assert_eq!(format!("Hello {:05}!", 5),  "Hello 00005!");
+//! assert_eq!(format!("Hello {:05}!", -5), "Hello -0005!");
+//! assert_eq!(format!("{:#010x}!", 27), "0x0000001b!");
+//! ```
+//!
+//! These are all flags altering the behavior of the formatter.
+//!
+//! * `+` - This is intended for numeric types and indicates that the sign
+//!         should always be printed. Positive signs are never printed by
+//!         default, and the negative sign is only printed by default for signed values.
+//!         This flag indicates that the correct sign (`+` or `-`) should always be printed.
+//! * `-` - Currently not used
+//! * `#` - This flag indicates that the "alternate" form of printing should
+//!         be used. The alternate forms are:
+//!     * `#?` - pretty-print the [`Debug`] formatting (adds linebreaks and indentation)
+//!     * `#x` - precedes the argument with a `0x`
+//!     * `#X` - precedes the argument with a `0x`
+//!     * `#b` - precedes the argument with a `0b`
+//!     * `#o` - precedes the argument with a `0o`
+//! * `0` - This is used to indicate for integer formats that the padding to `width` should
+//!         both be done with a `0` character as well as be sign-aware. A format
+//!         like `{:08}` would yield `00000001` for the integer `1`, while the
+//!         same format would yield `-0000001` for the integer `-1`. Notice that
+//!         the negative version has one fewer zero than the positive version.
+//!         Note that padding zeros are always placed after the sign (if any)
+//!         and before the digits. When used together with the `#` flag, a similar
+//!         rule applies: padding zeros are inserted after the prefix but before
+//!         the digits. The prefix is included in the total width.
+//!
+//! ## Precision
+//!
+//! For non-numeric types, this can be considered a "maximum width". If the resulting string is
+//! longer than this width, then it is truncated down to this many characters and that truncated
+//! value is emitted with proper `fill`, `alignment` and `width` if those parameters are set.
+//!
+//! For integral types, this is ignored.
+//!
+//! For floating-point types, this indicates how many digits after the decimal point should be
+//! printed.
+//!
+//! There are three possible ways to specify the desired `precision`:
+//!
+//! 1. An integer `.N`:
+//!
+//!    the integer `N` itself is the precision.
+//!
+//! 2. An integer or name followed by dollar sign `.N$`:
+//!
+//!    use format *argument* `N` (which must be a `usize`) as the precision.
+//!
+//! 3. An asterisk `.*`:
+//!
+//!    `.*` means that this `{...}` is associated with *two* format inputs rather than one: the
+//!    first input holds the `usize` precision, and the second holds the value to print. Note that
+//!    in this case, if one uses the format string `{<arg>:<spec>.*}`, then the `<arg>` part refers
+//!    to the *value* to print, and the `precision` must come in the input preceding `<arg>`.
+//!
+//! For example, the following calls all print the same thing `Hello x is 0.01000`:
+//!
+//! ```
+//! // Hello {arg 0 ("x")} is {arg 1 (0.01) with precision specified inline (5)}
+//! println!("Hello {0} is {1:.5}", "x", 0.01);
+//!
+//! // Hello {arg 1 ("x")} is {arg 2 (0.01) with precision specified in arg 0 (5)}
+//! println!("Hello {1} is {2:.0$}", 5, "x", 0.01);
+//!
+//! // Hello {arg 0 ("x")} is {arg 2 (0.01) with precision specified in arg 1 (5)}
+//! println!("Hello {0} is {2:.1$}", "x", 5, 0.01);
+//!
+//! // Hello {next arg ("x")} is {second of next two args (0.01) with precision
+//! //                          specified in first of next two args (5)}
+//! println!("Hello {} is {:.*}",    "x", 5, 0.01);
+//!
+//! // Hello {next arg ("x")} is {arg 2 (0.01) with precision
+//! //                          specified in its predecessor (5)}
+//! println!("Hello {} is {2:.*}",   "x", 5, 0.01);
+//!
+//! // Hello {next arg ("x")} is {arg "number" (0.01) with precision specified
+//! //                          in arg "prec" (5)}
+//! println!("Hello {} is {number:.prec$}", "x", prec = 5, number = 0.01);
+//! ```
+//!
+//! While these:
+//!
+//! ```
+//! println!("{}, `{name:.*}` has 3 fractional digits", "Hello", 3, name=1234.56);
+//! println!("{}, `{name:.*}` has 3 characters", "Hello", 3, name="1234.56");
+//! println!("{}, `{name:>8.*}` has 3 right-aligned characters", "Hello", 3, name="1234.56");
+//! ```
+//!
+//! print three significantly different things:
+//!
+//! ```text
+//! Hello, `1234.560` has 3 fractional digits
+//! Hello, `123` has 3 characters
+//! Hello, `     123` has 3 right-aligned characters
+//! ```
+//!
+//! ## Localization
+//!
+//! In some programming languages, the behavior of string formatting functions
+//! depends on the operating system's locale setting. The format functions
+//! provided by Rust's standard library do not have any concept of locale and
+//! will produce the same results on all systems regardless of user
+//! configuration.
+//!
+//! For example, the following code will always print `1.5` even if the system
+//! locale uses a decimal separator other than a dot.
+//!
+//! ```
+//! println!("The value is {}", 1.5);
+//! ```
+//!
+//! # Escaping
+//!
+//! The literal characters `{` and `}` may be included in a string by preceding
+//! them with the same character. For example, the `{` character is escaped with
+//! `{{` and the `}` character is escaped with `}}`.
+//!
+//! ```
+//! assert_eq!(format!("Hello {{}}"), "Hello {}");
+//! assert_eq!(format!("{{ Hello"), "{ Hello");
+//! ```
+//!
+//! # Syntax
+//!
+//! To summarize, here you can find the full grammar of format strings.
+//! The syntax for the formatting language used is drawn from other languages,
+//! so it should not be too alien. Arguments are formatted with Python-like
+//! syntax, meaning that arguments are surrounded by `{}` instead of the C-like
+//! `%`. The actual grammar for the formatting syntax is:
+//!
+//! ```text
+//! format_string := text [ maybe_format text ] *
+//! maybe_format := '{' '{' | '}' '}' | format
+//! format := '{' [ argument ] [ ':' format_spec ] '}'
+//! argument := integer | identifier
+//!
+//! format_spec := [[fill]align][sign]['#']['0'][width]['.' precision]type
+//! fill := character
+//! align := '<' | '^' | '>'
+//! sign := '+' | '-'
+//! width := count
+//! precision := count | '*'
+//! type := '' | '?' | 'x?' | 'X?' | identifier
+//! count := parameter | integer
+//! parameter := argument '$'
+//! ```
+//! In the above grammar, `text` must not contain any `'{'` or `'}'` characters.
+//!
+//! # Formatting traits
+//!
+//! When requesting that an argument be formatted with a particular type, you
+//! are actually requesting that an argument ascribes to a particular trait.
+//! This allows multiple actual types to be formatted via `{:x}` (like [`i8`] as
+//! well as [`isize`]). The current mapping of types to traits is:
+//!
+//! * *nothing* ⇒ [`Display`]
+//! * `?` ⇒ [`Debug`]
+//! * `x?` ⇒ [`Debug`] with lower-case hexadecimal integers
+//! * `X?` ⇒ [`Debug`] with upper-case hexadecimal integers
+//! * `o` ⇒ [`Octal`]
+//! * `x` ⇒ [`LowerHex`]
+//! * `X` ⇒ [`UpperHex`]
+//! * `p` ⇒ [`Pointer`]
+//! * `b` ⇒ [`Binary`]
+//! * `e` ⇒ [`LowerExp`]
+//! * `E` ⇒ [`UpperExp`]
+//!
+//! What this means is that any type of argument which implements the
+//! [`fmt::Binary`][`Binary`] trait can then be formatted with `{:b}`. Implementations
+//! are provided for these traits for a number of primitive types by the
+//! standard library as well. If no format is specified (as in `{}` or `{:6}`),
+//! then the format trait used is the [`Display`] trait.
+//!
+//! When implementing a format trait for your own type, you will have to
+//! implement a method of the signature:
+//!
+//! ```
+//! # #![allow(dead_code)]
+//! # use std::fmt;
+//! # struct Foo; // our custom type
+//! # impl fmt::Display for Foo {
+//! fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+//! # write!(f, "testing, testing")
+//! # } }
+//! ```
+//!
+//! Your type will be passed as `self` by-reference, and then the function
+//! should emit output into the `f.buf` stream. It is up to each format trait
+//! implementation to correctly adhere to the requested formatting parameters.
+//! The values of these parameters will be listed in the fields of the
+//! [`Formatter`] struct. In order to help with this, the [`Formatter`] struct also
+//! provides some helper methods.
+//!
+//! Additionally, the return value of this function is [`fmt::Result`] which is a
+//! type alias of <code>[Result]<(), [std::fmt::Error]></code>. Formatting implementations
+//! should ensure that they propagate errors from the [`Formatter`] (e.g., when
+//! calling [`write!`]). However, they should never return errors spuriously. That
+//! is, a formatting implementation must and may only return an error if the
+//! passed-in [`Formatter`] returns an error. This is because, contrary to what
+//! the function signature might suggest, string formatting is an infallible
+//! operation. This function only returns a result because writing to the
+//! underlying stream might fail and it must provide a way to propagate the fact
+//! that an error has occurred back up the stack.
+//!
+//! An example of implementing the formatting traits would look
+//! like:
+//!
+//! ```
+//! use std::fmt;
+//!
+//! #[derive(Debug)]
+//! struct Vector2D {
+//!     x: isize,
+//!     y: isize,
+//! }
+//!
+//! impl fmt::Display for Vector2D {
+//!     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+//!         // The `f` value implements the `Write` trait, which is what the
+//!         // write! macro is expecting. Note that this formatting ignores the
+//!         // various flags provided to format strings.
+//!         write!(f, "({}, {})", self.x, self.y)
+//!     }
+//! }
+//!
+//! // Different traits allow different forms of output of a type. The meaning
+//! // of this format is to print the magnitude of a vector.
+//! impl fmt::Binary for Vector2D {
+//!     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+//!         let magnitude = (self.x * self.x + self.y * self.y) as f64;
+//!         let magnitude = magnitude.sqrt();
+//!
+//!         // Respect the formatting flags by using the helper method
+//!         // `pad_integral` on the Formatter object. See the method
+//!         // documentation for details, and the function `pad` can be used
+//!         // to pad strings.
+//!         let decimals = f.precision().unwrap_or(3);
+//!         let string = format!("{:.*}", decimals, magnitude);
+//!         f.pad_integral(true, "", &string)
+//!     }
+//! }
+//!
+//! fn main() {
+//!     let myvector = Vector2D { x: 3, y: 4 };
+//!
+//!     println!("{}", myvector);       // => "(3, 4)"
+//!     println!("{:?}", myvector);     // => "Vector2D {x: 3, y:4}"
+//!     println!("{:10.3b}", myvector); // => "     5.000"
+//! }
+//! ```
+//!
+//! ### `fmt::Display` vs `fmt::Debug`
+//!
+//! These two formatting traits have distinct purposes:
+//!
+//! - [`fmt::Display`][`Display`] implementations assert that the type can be faithfully
+//!   represented as a UTF-8 string at all times. It is **not** expected that
+//!   all types implement the [`Display`] trait.
+//! - [`fmt::Debug`][`Debug`] implementations should be implemented for **all** public types.
+//!   Output will typically represent the internal state as faithfully as possible.
+//!   The purpose of the [`Debug`] trait is to facilitate debugging Rust code. In
+//!   most cases, using `#[derive(Debug)]` is sufficient and recommended.
+//!
+//! Some examples of the output from both traits:
+//!
+//! ```
+//! assert_eq!(format!("{} {:?}", 3, 4), "3 4");
+//! assert_eq!(format!("{} {:?}", 'a', 'b'), "a 'b'");
+//! assert_eq!(format!("{} {:?}", "foo\n", "bar\n"), "foo\n \"bar\\n\"");
+//! ```
+//!
+//! # Related macros
+//!
+//! There are a number of related macros in the [`format!`] family. The ones that
+//! are currently implemented are:
+//!
+//! ```ignore (only-for-syntax-highlight)
+//! format!      // described above
+//! write!       // first argument is a &mut io::Write, the destination
+//! writeln!     // same as write but appends a newline
+//! print!       // the format string is printed to the standard output
+//! println!     // same as print but appends a newline
+//! eprint!      // the format string is printed to the standard error
+//! eprintln!    // same as eprint but appends a newline
+//! format_args! // described below.
+//! ```
+//!
+//! ### `write!`
+//!
+//! This and [`writeln!`] are two macros which are used to emit the format string
+//! to a specified stream. This is used to prevent intermediate allocations of
+//! format strings and instead directly write the output. Under the hood, this
+//! function is actually invoking the [`write_fmt`] function defined on the
+//! [`std::io::Write`] trait. Example usage is:
+//!
+//! ```
+//! # #![allow(unused_must_use)]
+//! use std::io::Write;
+//! let mut w = Vec::new();
+//! write!(&mut w, "Hello {}!", "world");
+//! ```
+//!
+//! ### `print!`
+//!
+//! This and [`println!`] emit their output to stdout. Similarly to the [`write!`]
+//! macro, the goal of these macros is to avoid intermediate allocations when
+//! printing output. Example usage is:
+//!
+//! ```
+//! print!("Hello {}!", "world");
+//! println!("I have a newline {}", "character at the end");
+//! ```
+//! ### `eprint!`
+//!
+//! The [`eprint!`] and [`eprintln!`] macros are identical to
+//! [`print!`] and [`println!`], respectively, except they emit their
+//! output to stderr.
+//!
+//! ### `format_args!`
+//!
+//! This is a curious macro used to safely pass around
+//! an opaque object describing the format string. This object
+//! does not require any heap allocations to create, and it only
+//! references information on the stack. Under the hood, all of
+//! the related macros are implemented in terms of this. First
+//! off, some example usage is:
+//!
+//! ```
+//! # #![allow(unused_must_use)]
+//! use std::fmt;
+//! use std::io::{self, Write};
+//!
+//! let mut some_writer = io::stdout();
+//! write!(&mut some_writer, "{}", format_args!("print with a {}", "macro"));
+//!
+//! fn my_fmt_fn(args: fmt::Arguments) {
+//!     write!(&mut io::stdout(), "{}", args);
+//! }
+//! my_fmt_fn(format_args!(", or a {} too", "function"));
+//! ```
+//!
+//! The result of the [`format_args!`] macro is a value of type [`fmt::Arguments`].
+//! This structure can then be passed to the [`write`] and [`format`] functions
+//! inside this module in order to process the format string.
+//! The goal of this macro is to even further prevent intermediate allocations
+//! when dealing with formatting strings.
+//!
+//! For example, a logging library could use the standard formatting syntax, but
+//! it would internally pass around this structure until it has been determined
+//! where output should go to.
+//!
+//! [`fmt::Result`]: Result "fmt::Result"
+//! [Result]: core::result::Result "std::result::Result"
+//! [std::fmt::Error]: Error "fmt::Error"
+//! [`write`]: write() "fmt::write"
+//! [`to_string`]: crate::string::ToString::to_string "ToString::to_string"
+//! [`write_fmt`]: ../../std/io/trait.Write.html#method.write_fmt
+//! [`std::io::Write`]: ../../std/io/trait.Write.html
+//! [`print!`]: ../../std/macro.print.html "print!"
+//! [`println!`]: ../../std/macro.println.html "println!"
+//! [`eprint!`]: ../../std/macro.eprint.html "eprint!"
+//! [`eprintln!`]: ../../std/macro.eprintln.html "eprintln!"
+//! [`fmt::Arguments`]: Arguments "fmt::Arguments"
+//! [`format`]: format() "fmt::format"
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[unstable(feature = "fmt_internals", issue = "none")]
+pub use core::fmt::rt;
+#[stable(feature = "fmt_flags_align", since = "1.28.0")]
+pub use core::fmt::Alignment;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::Error;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{write, ArgumentV1, Arguments};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{Binary, Octal};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{Debug, Display};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{DebugList, DebugMap, DebugSet, DebugStruct, DebugTuple};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{Formatter, Result, Write};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{LowerExp, UpperExp};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::fmt::{LowerHex, Pointer, UpperHex};
+
+#[cfg(not(no_global_oom_handling))]
+use crate::string;
+
+/// The `format` function takes an [`Arguments`] struct and returns the resulting
+/// formatted string.
+///
+/// The [`Arguments`] instance can be created with the [`format_args!`] macro.
+///
+/// # Examples
+///
+/// Basic usage:
+///
+/// ```
+/// use std::fmt;
+///
+/// let s = fmt::format(format_args!("Hello, {}!", "world"));
+/// assert_eq!(s, "Hello, world!");
+/// ```
+///
+/// Please note that using [`format!`] might be preferable.
+/// Example:
+///
+/// ```
+/// let s = format!("Hello, {}!", "world");
+/// assert_eq!(s, "Hello, world!");
+/// ```
+///
+/// [`format_args!`]: core::format_args
+/// [`format!`]: crate::format
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub fn format(args: Arguments<'_>) -> string::String {
+    let capacity = args.estimated_capacity();
+    let mut output = string::String::with_capacity(capacity);
+    output.write_fmt(args).expect("a formatting trait implementation returned an error");
+    output
+}
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
new file mode 100644
index 000000000000..713d7b992b17
--- /dev/null
+++ b/rust/alloc/lib.rs
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! # The Rust core allocation and collections library
+//!
+//! This library provides smart pointers and collections for managing
+//! heap-allocated values.
+//!
+//! This library, like libcore, normally doesn’t need to be used directly
+//! since its contents are re-exported in the [`std` crate](../std/index.html).
+//! Crates that use the `#![no_std]` attribute however will typically
+//! not depend on `std`, so they’d use this crate instead.
+//!
+//! ## Boxed values
+//!
+//! The [`Box`] type is a smart pointer type. There can only be one owner of a
+//! [`Box`], and the owner can decide to mutate the contents, which live on the
+//! heap.
+//!
+//! This type can be sent among threads efficiently as the size of a `Box` value
+//! is the same as that of a pointer. Tree-like data structures are often built
+//! with boxes because each node often has only one owner, the parent.
+//!
+//! ## Reference counted pointers
+//!
+//! The [`Rc`] type is a non-threadsafe reference-counted pointer type intended
+//! for sharing memory within a thread. An [`Rc`] pointer wraps a type, `T`, and
+//! only allows access to `&T`, a shared reference.
+//!
+//! This type is useful when inherited mutability (such as using [`Box`]) is too
+//! constraining for an application, and is often paired with the [`Cell`] or
+//! [`RefCell`] types in order to allow mutation.
+//!
+//! ## Atomically reference counted pointers
+//!
+//! The [`Arc`] type is the threadsafe equivalent of the [`Rc`] type. It
+//! provides all the same functionality of [`Rc`], except it requires that the
+//! contained type `T` is shareable. Additionally, [`Arc<T>`][`Arc`] is itself
+//! sendable while [`Rc<T>`][`Rc`] is not.
+//!
+//! This type allows for shared access to the contained data, and is often
+//! paired with synchronization primitives such as mutexes to allow mutation of
+//! shared resources.
+//!
+//! ## Collections
+//!
+//! Implementations of the most common general purpose data structures are
+//! defined in this library. They are re-exported through the
+//! [standard collections library](../std/collections/index.html).
+//!
+//! ## Heap interfaces
+//!
+//! The [`alloc`](alloc/index.html) module defines the low-level interface to the
+//! default global allocator. It is not compatible with the libc allocator API.
+//!
+//! [`Arc`]: sync
+//! [`Box`]: boxed
+//! [`Cell`]: core::cell
+//! [`Rc`]: rc
+//! [`RefCell`]: core::cell
+
+// To run liballoc tests without x.py without ending up with two copies of liballoc, Miri needs to be
+// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
+// rustc itself never sets the feature, so this line has no affect there.
+#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
+#![allow(unused_attributes)]
+#![stable(feature = "alloc", since = "1.36.0")]
+#![doc(
+    html_playground_url = "https://play.rust-lang.org/",
+    issue_tracker_base_url = "https://github.com/rust-lang/rust/issues/",
+    test(no_crate_inject, attr(allow(unused_variables), deny(warnings)))
+)]
+#![cfg_attr(
+    not(bootstrap),
+    doc(cfg_hide(
+        not(test),
+        not(any(test, bootstrap)),
+        any(not(feature = "miri-test-libstd"), test, doctest),
+        no_global_oom_handling,
+        not(no_global_oom_handling),
+        target_has_atomic = "ptr"
+    ))
+)]
+#![no_std]
+#![needs_allocator]
+#![warn(deprecated_in_future)]
+#![warn(missing_docs)]
+#![warn(missing_debug_implementations)]
+#![allow(explicit_outlives_requirements)]
+#![deny(unsafe_op_in_unsafe_fn)]
+#![feature(rustc_allow_const_fn_unstable)]
+#![cfg_attr(not(test), feature(generator_trait))]
+#![cfg_attr(test, feature(test))]
+#![cfg_attr(test, feature(new_uninit))]
+#![feature(allocator_api)]
+#![feature(array_chunks)]
+#![feature(array_methods)]
+#![feature(array_windows)]
+#![feature(allow_internal_unstable)]
+#![feature(arbitrary_self_types)]
+#![feature(async_stream)]
+#![feature(box_patterns)]
+#![feature(box_syntax)]
+#![feature(cfg_sanitize)]
+#![feature(cfg_target_has_atomic)]
+#![feature(coerce_unsized)]
+#![cfg_attr(not(no_global_oom_handling), feature(const_btree_new))]
+#![feature(const_fn_trait_bound)]
+#![feature(cow_is_borrowed)]
+#![feature(const_cow_is_borrowed)]
+#![feature(const_trait_impl)]
+#![feature(destructuring_assignment)]
+#![feature(dispatch_from_dyn)]
+#![feature(core_intrinsics)]
+#![feature(dropck_eyepatch)]
+#![feature(exact_size_is_empty)]
+#![feature(exclusive_range_pattern)]
+#![feature(extend_one)]
+#![feature(fmt_internals)]
+#![feature(fn_traits)]
+#![feature(fundamental)]
+#![feature(inplace_iteration)]
+// Technically, this is a bug in rustdoc: rustdoc sees the documentation on `#[lang = slice_alloc]`
+// blocks is for `&[T]`, which also has documentation using this feature in `core`, and gets mad
+// that the feature-gate isn't enabled. Ideally, it wouldn't check for the feature gate for docs
+// from other crates, but since this can only appear for lang items, it doesn't seem worth fixing.
+#![feature(intra_doc_pointers)]
+#![feature(iter_advance_by)]
+#![feature(iter_zip)]
+#![feature(lang_items)]
+#![feature(layout_for_ptr)]
+#![feature(negative_impls)]
+#![feature(never_type)]
+#![feature(nll)]
+#![feature(nonnull_slice_from_raw_parts)]
+#![feature(auto_traits)]
+#![feature(option_result_unwrap_unchecked)]
+#![feature(pattern)]
+#![feature(ptr_internals)]
+#![feature(rustc_attrs)]
+#![feature(receiver_trait)]
+#![feature(min_specialization)]
+#![feature(set_ptr_value)]
+#![feature(slice_ptr_get)]
+#![feature(slice_ptr_len)]
+#![feature(slice_range)]
+#![feature(staged_api)]
+#![feature(str_internals)]
+#![feature(trusted_len)]
+#![feature(unboxed_closures)]
+#![feature(unicode_internals)]
+#![feature(unsize)]
+#![feature(unsized_fn_params)]
+#![feature(allocator_internals)]
+#![feature(slice_partition_dedup)]
+#![feature(maybe_uninit_extra, maybe_uninit_slice, maybe_uninit_uninit_array)]
+#![feature(alloc_layout_extra)]
+#![feature(trusted_random_access)]
+#![feature(try_trait_v2)]
+#![feature(associated_type_bounds)]
+#![feature(slice_group_by)]
+#![feature(decl_macro)]
+#![feature(doc_cfg)]
+#![cfg_attr(not(bootstrap), feature(doc_cfg_hide))]
+// Allow testing this library
+
+#[cfg(test)]
+#[macro_use]
+extern crate std;
+#[cfg(test)]
+extern crate test;
+
+// Module with internal macros used by other modules (needs to be included before other modules).
+#[macro_use]
+mod macros;
+
+// Heaps provided for low-level allocation strategies
+
+pub mod alloc;
+
+// Primitive types using the heaps above
+
+// Need to conditionally define the mod from `boxed.rs` to avoid
+// duplicating the lang-items when building in test cfg; but also need
+// to allow code to have `use boxed::Box;` declarations.
+#[cfg(not(test))]
+pub mod boxed;
+#[cfg(test)]
+mod boxed {
+    pub use std::boxed::Box;
+}
+pub mod borrow;
+pub mod collections;
+pub mod fmt;
+pub mod raw_vec;
+#[cfg(not(no_rc))]
+pub mod rc;
+pub mod slice;
+pub mod str;
+pub mod string;
+#[cfg(all(not(no_sync), target_has_atomic = "ptr"))]
+pub mod sync;
+#[cfg(all(not(no_global_oom_handling), target_has_atomic = "ptr"))]
+pub mod task;
+#[cfg(test)]
+mod tests;
+pub mod vec;
+
+#[doc(hidden)]
+#[unstable(feature = "liballoc_internals", issue = "none", reason = "implementation detail")]
+pub mod __export {
+    pub use core::format_args;
+}
diff --git a/rust/alloc/macros.rs b/rust/alloc/macros.rs
new file mode 100644
index 000000000000..73c435152418
--- /dev/null
+++ b/rust/alloc/macros.rs
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+/// Creates a [`Vec`] containing the arguments.
+///
+/// `vec!` allows `Vec`s to be defined with the same syntax as array expressions.
+/// There are two forms of this macro:
+///
+/// - Create a [`Vec`] containing a given list of elements:
+///
+/// ```
+/// let v = vec![1, 2, 3];
+/// assert_eq!(v[0], 1);
+/// assert_eq!(v[1], 2);
+/// assert_eq!(v[2], 3);
+/// ```
+///
+/// - Create a [`Vec`] from a given element and size:
+///
+/// ```
+/// let v = vec![1; 3];
+/// assert_eq!(v, [1, 1, 1]);
+/// ```
+///
+/// Note that unlike array expressions this syntax supports all elements
+/// which implement [`Clone`] and the number of elements doesn't have to be
+/// a constant.
+///
+/// This will use `clone` to duplicate an expression, so one should be careful
+/// using this with types having a nonstandard `Clone` implementation. For
+/// example, `vec![Rc::new(1); 5]` will create a vector of five references
+/// to the same boxed integer value, not five references pointing to independently
+/// boxed integers.
+///
+/// Also, note that `vec![expr; 0]` is allowed, and produces an empty vector.
+/// This will still evaluate `expr`, however, and immediately drop the resulting value, so
+/// be mindful of side effects.
+///
+/// [`Vec`]: crate::vec::Vec
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[macro_export]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[allow_internal_unstable(box_syntax, liballoc_internals)]
+macro_rules! vec {
+    () => (
+        $crate::__rust_force_expr!($crate::vec::Vec::new())
+    );
+    ($elem:expr; $n:expr) => (
+        $crate::__rust_force_expr!($crate::vec::from_elem($elem, $n))
+    );
+    ($($x:expr),+ $(,)?) => (
+        $crate::__rust_force_expr!(<[_]>::into_vec(box [$($x),+]))
+    );
+}
+
+// HACK(japaric): with cfg(test) the inherent `[T]::into_vec` method, which is
+// required for this macro definition, is not available. Instead use the
+// `slice::into_vec`  function which is only available with cfg(test)
+// NB see the slice::hack module in slice.rs for more information
+#[cfg(test)]
+macro_rules! vec {
+    () => (
+        $crate::vec::Vec::new()
+    );
+    ($elem:expr; $n:expr) => (
+        $crate::vec::from_elem($elem, $n)
+    );
+    ($($x:expr),*) => (
+        $crate::slice::into_vec(box [$($x),*])
+    );
+    ($($x:expr,)*) => (vec![$($x),*])
+}
+
+/// Creates a `String` using interpolation of runtime expressions.
+///
+/// The first argument `format!` receives is a format string. This must be a string
+/// literal. The power of the formatting string is in the `{}`s contained.
+///
+/// Additional parameters passed to `format!` replace the `{}`s within the
+/// formatting string in the order given unless named or positional parameters
+/// are used; see [`std::fmt`] for more information.
+///
+/// A common use for `format!` is concatenation and interpolation of strings.
+/// The same convention is used with [`print!`] and [`write!`] macros,
+/// depending on the intended destination of the string.
+///
+/// To convert a single value to a string, use the [`to_string`] method. This
+/// will use the [`Display`] formatting trait.
+///
+/// [`std::fmt`]: ../std/fmt/index.html
+/// [`print!`]: ../std/macro.print.html
+/// [`write!`]: core::write
+/// [`to_string`]: crate::string::ToString
+/// [`Display`]: core::fmt::Display
+///
+/// # Panics
+///
+/// `format!` panics if a formatting trait implementation returns an error.
+/// This indicates an incorrect implementation
+/// since `fmt::Write for String` never returns an error itself.
+///
+/// # Examples
+///
+/// ```
+/// format!("test");
+/// format!("hello {}", "world!");
+/// format!("x = {}, y = {y}", 10, y = 30);
+/// ```
+#[macro_export]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(test), rustc_diagnostic_item = "format_macro")]
+macro_rules! format {
+    ($($arg:tt)*) => {{
+        let res = $crate::fmt::format($crate::__export::format_args!($($arg)*));
+        res
+    }}
+}
+
+/// Force AST node to an expression to improve diagnostics in pattern position.
+#[doc(hidden)]
+#[macro_export]
+#[unstable(feature = "liballoc_internals", issue = "none", reason = "implementation detail")]
+macro_rules! __rust_force_expr {
+    ($e:expr) => {
+        $e
+    };
+}
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
new file mode 100644
index 000000000000..ac86e0f63dd9
--- /dev/null
+++ b/rust/alloc/raw_vec.rs
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#![unstable(feature = "raw_vec_internals", reason = "implementation detail", issue = "none")]
+#![doc(hidden)]
+
+use core::alloc::LayoutError;
+use core::cmp;
+use core::intrinsics;
+use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::ops::Drop;
+use core::ptr::{self, NonNull, Unique};
+use core::slice;
+
+#[cfg(not(no_global_oom_handling))]
+use crate::alloc::handle_alloc_error;
+use crate::alloc::{Allocator, Global, Layout};
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::collections::TryReserveErrorKind::*;
+
+#[cfg(test)]
+mod tests;
+
+enum AllocInit {
+    /// The contents of the new memory are uninitialized.
+    Uninitialized,
+    #[allow(dead_code)]
+    /// The new memory is guaranteed to be zeroed.
+    Zeroed,
+}
+
+/// A low-level utility for more ergonomically allocating, reallocating, and deallocating
+/// a buffer of memory on the heap without having to worry about all the corner cases
+/// involved. This type is excellent for building your own data structures like Vec and VecDeque.
+/// In particular:
+///
+/// * Produces `Unique::dangling()` on zero-sized types.
+/// * Produces `Unique::dangling()` on zero-length allocations.
+/// * Avoids freeing `Unique::dangling()`.
+/// * Catches all overflows in capacity computations (promotes them to "capacity overflow" panics).
+/// * Guards against 32-bit systems allocating more than isize::MAX bytes.
+/// * Guards against overflowing your length.
+/// * Calls `handle_alloc_error` for fallible allocations.
+/// * Contains a `ptr::Unique` and thus endows the user with all related benefits.
+/// * Uses the excess returned from the allocator to use the largest available capacity.
+///
+/// This type does not in anyway inspect the memory that it manages. When dropped it *will*
+/// free its memory, but it *won't* try to drop its contents. It is up to the user of `RawVec`
+/// to handle the actual things *stored* inside of a `RawVec`.
+///
+/// Note that the excess of a zero-sized types is always infinite, so `capacity()` always returns
+/// `usize::MAX`. This means that you need to be careful when round-tripping this type with a
+/// `Box<[T]>`, since `capacity()` won't yield the length.
+#[allow(missing_debug_implementations)]
+pub struct RawVec<T, A: Allocator = Global> {
+    ptr: Unique<T>,
+    cap: usize,
+    alloc: A,
+}
+
+impl<T> RawVec<T, Global> {
+    /// HACK(Centril): This exists because stable `const fn` can only call stable `const fn`, so
+    /// they cannot call `Self::new()`.
+    ///
+    /// If you change `RawVec<T>::new` or dependencies, please take care to not introduce anything
+    /// that would truly const-call something unstable.
+    pub const NEW: Self = Self::new();
+
+    /// Creates the biggest possible `RawVec` (on the system heap)
+    /// without allocating. If `T` has positive size, then this makes a
+    /// `RawVec` with capacity `0`. If `T` is zero-sized, then it makes a
+    /// `RawVec` with capacity `usize::MAX`. Useful for implementing
+    /// delayed allocation.
+    #[must_use]
+    pub const fn new() -> Self {
+        Self::new_in(Global)
+    }
+
+    /// Creates a `RawVec` (on the system heap) with exactly the
+    /// capacity and alignment requirements for a `[T; capacity]`. This is
+    /// equivalent to calling `RawVec::new` when `capacity` is `0` or `T` is
+    /// zero-sized. Note that if `T` is zero-sized this means you will
+    /// *not* get a `RawVec` with the requested capacity.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the requested capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use]
+    #[inline]
+    pub fn with_capacity(capacity: usize) -> Self {
+        Self::with_capacity_in(capacity, Global)
+    }
+
+    /// Tries to create a `RawVec` (on the system heap) with exactly the
+    /// capacity and alignment requirements for a `[T; capacity]`. This is
+    /// equivalent to calling `RawVec::new` when `capacity` is `0` or `T` is
+    /// zero-sized. Note that if `T` is zero-sized this means you will
+    /// *not* get a `RawVec` with the requested capacity.
+    #[inline]
+    pub fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+        Self::try_with_capacity_in(capacity, Global)
+    }
+
+    /// Like `with_capacity`, but guarantees the buffer is zeroed.
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use]
+    #[inline]
+    pub fn with_capacity_zeroed(capacity: usize) -> Self {
+        Self::with_capacity_zeroed_in(capacity, Global)
+    }
+
+    /// Reconstitutes a `RawVec` from a pointer and capacity.
+    ///
+    /// # Safety
+    ///
+    /// The `ptr` must be allocated (on the system heap), and with the given `capacity`.
+    /// The `capacity` cannot exceed `isize::MAX` for sized types. (only a concern on 32-bit
+    /// systems). ZST vectors may have a capacity up to `usize::MAX`.
+    /// If the `ptr` and `capacity` come from a `RawVec`, then this is guaranteed.
+    #[inline]
+    pub unsafe fn from_raw_parts(ptr: *mut T, capacity: usize) -> Self {
+        unsafe { Self::from_raw_parts_in(ptr, capacity, Global) }
+    }
+}
+
+impl<T, A: Allocator> RawVec<T, A> {
+    // Tiny Vecs are dumb. Skip to:
+    // - 8 if the element size is 1, because any heap allocators is likely
+    //   to round up a request of less than 8 bytes to at least 8 bytes.
+    // - 4 if elements are moderate-sized (<= 1 KiB).
+    // - 1 otherwise, to avoid wasting too much space for very short Vecs.
+    const MIN_NON_ZERO_CAP: usize = if mem::size_of::<T>() == 1 {
+        8
+    } else if mem::size_of::<T>() <= 1024 {
+        4
+    } else {
+        1
+    };
+
+    /// Like `new`, but parameterized over the choice of allocator for
+    /// the returned `RawVec`.
+    #[rustc_allow_const_fn_unstable(const_fn)]
+    pub const fn new_in(alloc: A) -> Self {
+        // `cap: 0` means "unallocated". zero-sized types are ignored.
+        Self { ptr: Unique::dangling(), cap: 0, alloc }
+    }
+
+    /// Like `with_capacity`, but parameterized over the choice of
+    /// allocator for the returned `RawVec`.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn with_capacity_in(capacity: usize, alloc: A) -> Self {
+        Self::allocate_in(capacity, AllocInit::Uninitialized, alloc)
+    }
+
+    /// Like `try_with_capacity`, but parameterized over the choice of
+    /// allocator for the returned `RawVec`.
+    #[inline]
+    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
+        Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
+    }
+
+    /// Like `with_capacity_zeroed`, but parameterized over the choice
+    /// of allocator for the returned `RawVec`.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn with_capacity_zeroed_in(capacity: usize, alloc: A) -> Self {
+        Self::allocate_in(capacity, AllocInit::Zeroed, alloc)
+    }
+
+    /// Converts a `Box<[T]>` into a `RawVec<T>`.
+    pub fn from_box(slice: Box<[T], A>) -> Self {
+        unsafe {
+            let (slice, alloc) = Box::into_raw_with_allocator(slice);
+            RawVec::from_raw_parts_in(slice.as_mut_ptr(), slice.len(), alloc)
+        }
+    }
+
+    /// Converts the entire buffer into `Box<[MaybeUninit<T>]>` with the specified `len`.
+    ///
+    /// Note that this will correctly reconstitute any `cap` changes
+    /// that may have been performed. (See description of type for details.)
+    ///
+    /// # Safety
+    ///
+    /// * `len` must be greater than or equal to the most recently requested capacity, and
+    /// * `len` must be less than or equal to `self.capacity()`.
+    ///
+    /// Note, that the requested capacity and `self.capacity()` could differ, as
+    /// an allocator could overallocate and return a greater memory block than requested.
+    pub unsafe fn into_box(self, len: usize) -> Box<[MaybeUninit<T>], A> {
+        // Sanity-check one half of the safety requirement (we cannot check the other half).
+        debug_assert!(
+            len <= self.capacity(),
+            "`len` must be smaller than or equal to `self.capacity()`"
+        );
+
+        let me = ManuallyDrop::new(self);
+        unsafe {
+            let slice = slice::from_raw_parts_mut(me.ptr() as *mut MaybeUninit<T>, len);
+            Box::from_raw_in(slice, ptr::read(&me.alloc))
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    fn allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Self {
+        if mem::size_of::<T>() == 0 {
+            Self::new_in(alloc)
+        } else {
+            // We avoid `unwrap_or_else` here because it bloats the amount of
+            // LLVM IR generated.
+            let layout = match Layout::array::<T>(capacity) {
+                Ok(layout) => layout,
+                Err(_) => capacity_overflow(),
+            };
+            match alloc_guard(layout.size()) {
+                Ok(_) => {}
+                Err(_) => capacity_overflow(),
+            }
+            let result = match init {
+                AllocInit::Uninitialized => alloc.allocate(layout),
+                AllocInit::Zeroed => alloc.allocate_zeroed(layout),
+            };
+            let ptr = match result {
+                Ok(ptr) => ptr,
+                Err(_) => handle_alloc_error(layout),
+            };
+
+            Self {
+                ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
+                cap: Self::capacity_from_bytes(ptr.len()),
+                alloc,
+            }
+        }
+    }
+
+    fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, TryReserveError> {
+        if mem::size_of::<T>() == 0 {
+            return Ok(Self::new_in(alloc));
+        }
+
+        let layout = Layout::array::<T>(capacity).map_err(|_| CapacityOverflow)?;
+        alloc_guard(layout.size())?;
+        let result = match init {
+            AllocInit::Uninitialized => alloc.allocate(layout),
+            AllocInit::Zeroed => alloc.allocate_zeroed(layout),
+        };
+        let ptr = result.map_err(|_| AllocError { layout, non_exhaustive: () })?;
+
+        Ok(Self {
+            ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
+            cap: Self::capacity_from_bytes(ptr.len()),
+            alloc,
+        })
+    }
+
+    /// Reconstitutes a `RawVec` from a pointer, capacity, and allocator.
+    ///
+    /// # Safety
+    ///
+    /// The `ptr` must be allocated (via the given allocator `alloc`), and with the given
+    /// `capacity`.
+    /// The `capacity` cannot exceed `isize::MAX` for sized types. (only a concern on 32-bit
+    /// systems). ZST vectors may have a capacity up to `usize::MAX`.
+    /// If the `ptr` and `capacity` come from a `RawVec` created via `alloc`, then this is
+    /// guaranteed.
+    #[inline]
+    pub unsafe fn from_raw_parts_in(ptr: *mut T, capacity: usize, alloc: A) -> Self {
+        Self { ptr: unsafe { Unique::new_unchecked(ptr) }, cap: capacity, alloc }
+    }
+
+    /// Gets a raw pointer to the start of the allocation. Note that this is
+    /// `Unique::dangling()` if `capacity == 0` or `T` is zero-sized. In the former case, you must
+    /// be careful.
+    #[inline]
+    pub fn ptr(&self) -> *mut T {
+        self.ptr.as_ptr()
+    }
+
+    /// Gets the capacity of the allocation.
+    ///
+    /// This will always be `usize::MAX` if `T` is zero-sized.
+    #[inline(always)]
+    pub fn capacity(&self) -> usize {
+        if mem::size_of::<T>() == 0 { usize::MAX } else { self.cap }
+    }
+
+    /// Returns a shared reference to the allocator backing this `RawVec`.
+    pub fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
+        if mem::size_of::<T>() == 0 || self.cap == 0 {
+            None
+        } else {
+            // We have an allocated chunk of memory, so we can bypass runtime
+            // checks to get our current layout.
+            unsafe {
+                let align = mem::align_of::<T>();
+                let size = mem::size_of::<T>() * self.cap;
+                let layout = Layout::from_size_align_unchecked(size, align);
+                Some((self.ptr.cast().into(), layout))
+            }
+        }
+    }
+
+    /// Ensures that the buffer contains at least enough space to hold `len +
+    /// additional` elements. If it doesn't already have enough capacity, will
+    /// reallocate enough space plus comfortable slack space to get amortized
+    /// *O*(1) behavior. Will limit this behavior if it would needlessly cause
+    /// itself to panic.
+    ///
+    /// If `len` exceeds `self.capacity()`, this may fail to actually allocate
+    /// the requested space. This is not really unsafe, but the unsafe
+    /// code *you* write that relies on the behavior of this function may break.
+    ///
+    /// This is ideal for implementing a bulk-push operation like `extend`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # #![feature(raw_vec_internals)]
+    /// # extern crate alloc;
+    /// # use std::ptr;
+    /// # use alloc::raw_vec::RawVec;
+    /// struct MyVec<T> {
+    ///     buf: RawVec<T>,
+    ///     len: usize,
+    /// }
+    ///
+    /// impl<T: Clone> MyVec<T> {
+    ///     pub fn push_all(&mut self, elems: &[T]) {
+    ///         self.buf.reserve(self.len, elems.len());
+    ///         // reserve would have aborted or panicked if the len exceeded
+    ///         // `isize::MAX` so this is safe to do unchecked now.
+    ///         for x in elems {
+    ///             unsafe {
+    ///                 ptr::write(self.buf.ptr().add(self.len), x.clone());
+    ///             }
+    ///             self.len += 1;
+    ///         }
+    ///     }
+    /// }
+    /// # fn main() {
+    /// #   let mut vector = MyVec { buf: RawVec::new(), len: 0 };
+    /// #   vector.push_all(&[1, 3, 5, 7, 9]);
+    /// # }
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn reserve(&mut self, len: usize, additional: usize) {
+        // Callers expect this function to be very cheap when there is already sufficient capacity.
+        // Therefore, we move all the resizing and error-handling logic from grow_amortized and
+        // handle_reserve behind a call, while making sure that this function is likely to be
+        // inlined as just a comparison and a call if the comparison fails.
+        #[cold]
+        fn do_reserve_and_handle<T, A: Allocator>(
+            slf: &mut RawVec<T, A>,
+            len: usize,
+            additional: usize,
+        ) {
+            handle_reserve(slf.grow_amortized(len, additional));
+        }
+
+        if self.needs_to_grow(len, additional) {
+            do_reserve_and_handle(self, len, additional);
+        }
+    }
+
+    /// The same as `reserve`, but returns on errors instead of panicking or aborting.
+    pub fn try_reserve(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        if self.needs_to_grow(len, additional) {
+            self.grow_amortized(len, additional)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Ensures that the buffer contains at least enough space to hold `len +
+    /// additional` elements. If it doesn't already, will reallocate the
+    /// minimum possible amount of memory necessary. Generally this will be
+    /// exactly the amount of memory necessary, but in principle the allocator
+    /// is free to give back more than we asked for.
+    ///
+    /// If `len` exceeds `self.capacity()`, this may fail to actually allocate
+    /// the requested space. This is not really unsafe, but the unsafe code
+    /// *you* write that relies on the behavior of this function may break.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    pub fn reserve_exact(&mut self, len: usize, additional: usize) {
+        handle_reserve(self.try_reserve_exact(len, additional));
+    }
+
+    /// The same as `reserve_exact`, but returns on errors instead of panicking or aborting.
+    pub fn try_reserve_exact(
+        &mut self,
+        len: usize,
+        additional: usize,
+    ) -> Result<(), TryReserveError> {
+        if self.needs_to_grow(len, additional) { self.grow_exact(len, additional) } else { Ok(()) }
+    }
+
+    /// Shrinks the allocation down to the specified amount. If the given amount
+    /// is 0, actually completely deallocates.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the given amount is *larger* than the current capacity.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    pub fn shrink_to_fit(&mut self, amount: usize) {
+        handle_reserve(self.shrink(amount));
+    }
+
+    /// Tries to shrink the allocation down to the specified amount. If the given amount
+    /// is 0, actually completely deallocates.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the given amount is *larger* than the current capacity.
+    pub fn try_shrink_to_fit(&mut self, amount: usize) -> Result<(), TryReserveError> {
+        self.shrink(amount)
+    }
+}
+
+impl<T, A: Allocator> RawVec<T, A> {
+    /// Returns if the buffer needs to grow to fulfill the needed extra capacity.
+    /// Mainly used to make inlining reserve-calls possible without inlining `grow`.
+    fn needs_to_grow(&self, len: usize, additional: usize) -> bool {
+        additional > self.capacity().wrapping_sub(len)
+    }
+
+    fn capacity_from_bytes(excess: usize) -> usize {
+        debug_assert_ne!(mem::size_of::<T>(), 0);
+        excess / mem::size_of::<T>()
+    }
+
+    fn set_ptr(&mut self, ptr: NonNull<[u8]>) {
+        self.ptr = unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) };
+        self.cap = Self::capacity_from_bytes(ptr.len());
+    }
+
+    // This method is usually instantiated many times. So we want it to be as
+    // small as possible, to improve compile times. But we also want as much of
+    // its contents to be statically computable as possible, to make the
+    // generated code run faster. Therefore, this method is carefully written
+    // so that all of the code that depends on `T` is within it, while as much
+    // of the code that doesn't depend on `T` as possible is in functions that
+    // are non-generic over `T`.
+    fn grow_amortized(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        // This is ensured by the calling contexts.
+        debug_assert!(additional > 0);
+
+        if mem::size_of::<T>() == 0 {
+            // Since we return a capacity of `usize::MAX` when `elem_size` is
+            // 0, getting to here necessarily means the `RawVec` is overfull.
+            return Err(CapacityOverflow.into());
+        }
+
+        // Nothing we can really do about these checks, sadly.
+        let required_cap = len.checked_add(additional).ok_or(CapacityOverflow)?;
+
+        // This guarantees exponential growth. The doubling cannot overflow
+        // because `cap <= isize::MAX` and the type of `cap` is `usize`.
+        let cap = cmp::max(self.cap * 2, required_cap);
+        let cap = cmp::max(Self::MIN_NON_ZERO_CAP, cap);
+
+        let new_layout = Layout::array::<T>(cap);
+
+        // `finish_grow` is non-generic over `T`.
+        let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
+        self.set_ptr(ptr);
+        Ok(())
+    }
+
+    // The constraints on this method are much the same as those on
+    // `grow_amortized`, but this method is usually instantiated less often so
+    // it's less critical.
+    fn grow_exact(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        if mem::size_of::<T>() == 0 {
+            // Since we return a capacity of `usize::MAX` when the type size is
+            // 0, getting to here necessarily means the `RawVec` is overfull.
+            return Err(CapacityOverflow.into());
+        }
+
+        let cap = len.checked_add(additional).ok_or(CapacityOverflow)?;
+        let new_layout = Layout::array::<T>(cap);
+
+        // `finish_grow` is non-generic over `T`.
+        let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
+        self.set_ptr(ptr);
+        Ok(())
+    }
+
+    fn shrink(&mut self, amount: usize) -> Result<(), TryReserveError> {
+        assert!(amount <= self.capacity(), "Tried to shrink to a larger capacity");
+
+        let (ptr, layout) = if let Some(mem) = self.current_memory() { mem } else { return Ok(()) };
+        let new_size = amount * mem::size_of::<T>();
+
+        let ptr = unsafe {
+            let new_layout = Layout::from_size_align_unchecked(new_size, layout.align());
+            self.alloc
+                .shrink(ptr, layout, new_layout)
+                .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
+        };
+        self.set_ptr(ptr);
+        Ok(())
+    }
+}
+
+// This function is outside `RawVec` to minimize compile times. See the comment
+// above `RawVec::grow_amortized` for details. (The `A` parameter isn't
+// significant, because the number of different `A` types seen in practice is
+// much smaller than the number of `T` types.)
+#[inline(never)]
+fn finish_grow<A>(
+    new_layout: Result<Layout, LayoutError>,
+    current_memory: Option<(NonNull<u8>, Layout)>,
+    alloc: &mut A,
+) -> Result<NonNull<[u8]>, TryReserveError>
+where
+    A: Allocator,
+{
+    // Check for the error here to minimize the size of `RawVec::grow_*`.
+    let new_layout = new_layout.map_err(|_| CapacityOverflow)?;
+
+    alloc_guard(new_layout.size())?;
+
+    let memory = if let Some((ptr, old_layout)) = current_memory {
+        debug_assert_eq!(old_layout.align(), new_layout.align());
+        unsafe {
+            // The allocator checks for alignment equality
+            intrinsics::assume(old_layout.align() == new_layout.align());
+            alloc.grow(ptr, old_layout, new_layout)
+        }
+    } else {
+        alloc.allocate(new_layout)
+    };
+
+    memory.map_err(|_| AllocError { layout: new_layout, non_exhaustive: () }.into())
+}
+
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for RawVec<T, A> {
+    /// Frees the memory owned by the `RawVec` *without* trying to drop its contents.
+    fn drop(&mut self) {
+        if let Some((ptr, layout)) = self.current_memory() {
+            unsafe { self.alloc.deallocate(ptr, layout) }
+        }
+    }
+}
+
+// Central function for reserve error handling.
+#[cfg(not(no_global_oom_handling))]
+#[inline]
+fn handle_reserve(result: Result<(), TryReserveError>) {
+    match result.map_err(|e| e.kind()) {
+        Err(CapacityOverflow) => capacity_overflow(),
+        Err(AllocError { layout, .. }) => handle_alloc_error(layout),
+        Ok(()) => { /* yay */ }
+    }
+}
+
+// We need to guarantee the following:
+// * We don't ever allocate `> isize::MAX` byte-size objects.
+// * We don't overflow `usize::MAX` and actually allocate too little.
+//
+// On 64-bit we just need to check for overflow since trying to allocate
+// `> isize::MAX` bytes will surely fail. On 32-bit and 16-bit we need to add
+// an extra guard for this in case we're running on a platform which can use
+// all 4GB in user-space, e.g., PAE or x32.
+
+#[inline]
+fn alloc_guard(alloc_size: usize) -> Result<(), TryReserveError> {
+    if usize::BITS < 64 && alloc_size > isize::MAX as usize {
+        Err(CapacityOverflow.into())
+    } else {
+        Ok(())
+    }
+}
+
+// One central function responsible for reporting capacity overflows. This'll
+// ensure that the code generation related to these panics is minimal as there's
+// only one location which panics rather than a bunch throughout the module.
+#[cfg(not(no_global_oom_handling))]
+fn capacity_overflow() -> ! {
+    panic!("capacity overflow");
+}
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
new file mode 100644
index 000000000000..ddb86eca86c8
--- /dev/null
+++ b/rust/alloc/slice.rs
@@ -0,0 +1,1275 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! A dynamically-sized view into a contiguous sequence, `[T]`.
+//!
+//! *[See also the slice primitive type](slice).*
+//!
+//! Slices are a view into a block of memory represented as a pointer and a
+//! length.
+//!
+//! ```
+//! // slicing a Vec
+//! let vec = vec![1, 2, 3];
+//! let int_slice = &vec[..];
+//! // coercing an array to a slice
+//! let str_slice: &[&str] = &["one", "two", "three"];
+//! ```
+//!
+//! Slices are either mutable or shared. The shared slice type is `&[T]`,
+//! while the mutable slice type is `&mut [T]`, where `T` represents the element
+//! type. For example, you can mutate the block of memory that a mutable slice
+//! points to:
+//!
+//! ```
+//! let x = &mut [1, 2, 3];
+//! x[1] = 7;
+//! assert_eq!(x, &[1, 7, 3]);
+//! ```
+//!
+//! Here are some of the things this module contains:
+//!
+//! ## Structs
+//!
+//! There are several structs that are useful for slices, such as [`Iter`], which
+//! represents iteration over a slice.
+//!
+//! ## Trait Implementations
+//!
+//! There are several implementations of common traits for slices. Some examples
+//! include:
+//!
+//! * [`Clone`]
+//! * [`Eq`], [`Ord`] - for slices whose element type are [`Eq`] or [`Ord`].
+//! * [`Hash`] - for slices whose element type is [`Hash`].
+//!
+//! ## Iteration
+//!
+//! The slices implement `IntoIterator`. The iterator yields references to the
+//! slice elements.
+//!
+//! ```
+//! let numbers = &[0, 1, 2];
+//! for n in numbers {
+//!     println!("{} is a number!", n);
+//! }
+//! ```
+//!
+//! The mutable slice yields mutable references to the elements:
+//!
+//! ```
+//! let mut scores = [7, 8, 9];
+//! for score in &mut scores[..] {
+//!     *score += 1;
+//! }
+//! ```
+//!
+//! This iterator yields mutable references to the slice's elements, so while
+//! the element type of the slice is `i32`, the element type of the iterator is
+//! `&mut i32`.
+//!
+//! * [`.iter`] and [`.iter_mut`] are the explicit methods to return the default
+//!   iterators.
+//! * Further methods that return iterators are [`.split`], [`.splitn`],
+//!   [`.chunks`], [`.windows`] and more.
+//!
+//! [`Hash`]: core::hash::Hash
+//! [`.iter`]: slice::iter
+//! [`.iter_mut`]: slice::iter_mut
+//! [`.split`]: slice::split
+//! [`.splitn`]: slice::splitn
+//! [`.chunks`]: slice::chunks
+//! [`.windows`]: slice::windows
+#![stable(feature = "rust1", since = "1.0.0")]
+// Many of the usings in this module are only used in the test configuration.
+// It's cleaner to just turn off the unused_imports warning than to fix them.
+#![cfg_attr(test, allow(unused_imports, dead_code))]
+
+use core::borrow::{Borrow, BorrowMut};
+#[cfg(not(no_global_oom_handling))]
+use core::cmp::Ordering::{self, Less};
+#[cfg(not(no_global_oom_handling))]
+use core::mem;
+#[cfg(not(no_global_oom_handling))]
+use core::mem::size_of;
+#[cfg(not(no_global_oom_handling))]
+use core::ptr;
+
+use crate::alloc::Allocator;
+use crate::alloc::Global;
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::ToOwned;
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::vec::Vec;
+
+#[unstable(feature = "slice_range", issue = "76393")]
+pub use core::slice::range;
+#[unstable(feature = "array_chunks", issue = "74985")]
+pub use core::slice::ArrayChunks;
+#[unstable(feature = "array_chunks", issue = "74985")]
+pub use core::slice::ArrayChunksMut;
+#[unstable(feature = "array_windows", issue = "75027")]
+pub use core::slice::ArrayWindows;
+#[stable(feature = "slice_get_slice", since = "1.28.0")]
+pub use core::slice::SliceIndex;
+#[stable(feature = "from_ref", since = "1.28.0")]
+pub use core::slice::{from_mut, from_ref};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{from_raw_parts, from_raw_parts_mut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{Chunks, Windows};
+#[stable(feature = "chunks_exact", since = "1.31.0")]
+pub use core::slice::{ChunksExact, ChunksExactMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{ChunksMut, Split, SplitMut};
+#[unstable(feature = "slice_group_by", issue = "80552")]
+pub use core::slice::{GroupBy, GroupByMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{Iter, IterMut};
+#[stable(feature = "rchunks", since = "1.31.0")]
+pub use core::slice::{RChunks, RChunksExact, RChunksExactMut, RChunksMut};
+#[stable(feature = "slice_rsplit", since = "1.27.0")]
+pub use core::slice::{RSplit, RSplitMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{RSplitN, RSplitNMut, SplitN, SplitNMut};
+
+////////////////////////////////////////////////////////////////////////////////
+// Basic slice extension methods
+////////////////////////////////////////////////////////////////////////////////
+
+// HACK(japaric) needed for the implementation of `vec!` macro during testing
+// N.B., see the `hack` module in this file for more details.
+#[cfg(test)]
+pub use hack::into_vec;
+
+// HACK(japaric) needed for the implementation of `Vec::clone` during testing
+// N.B., see the `hack` module in this file for more details.
+#[cfg(test)]
+pub use hack::to_vec;
+
+// HACK(japaric): With cfg(test) `impl [T]` is not available, these three
+// functions are actually methods that are in `impl [T]` but not in
+// `core::slice::SliceExt` - we need to supply these functions for the
+// `test_permutations` test
+mod hack {
+    use core::alloc::Allocator;
+
+    use crate::boxed::Box;
+    use crate::collections::TryReserveError;
+    use crate::vec::Vec;
+
+    // We shouldn't add inline attribute to this since this is used in
+    // `vec!` macro mostly and causes perf regression. See #71204 for
+    // discussion and perf results.
+    pub fn into_vec<T, A: Allocator>(b: Box<[T], A>) -> Vec<T, A> {
+        unsafe {
+            let len = b.len();
+            let (b, alloc) = Box::into_raw_with_allocator(b);
+            Vec::from_raw_parts_in(b as *mut T, len, len, alloc)
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn to_vec<T: ConvertVec, A: Allocator>(s: &[T], alloc: A) -> Vec<T, A> {
+        T::to_vec(s, alloc)
+    }
+
+    #[inline]
+    pub fn try_to_vec<T: TryConvertVec, A: Allocator>(s: &[T], alloc: A) -> Result<Vec<T, A>, TryReserveError> {
+        T::try_to_vec(s, alloc)
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    pub trait ConvertVec {
+        fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A>
+        where
+            Self: Sized;
+    }
+
+    pub trait TryConvertVec {
+        fn try_to_vec<A: Allocator>(s: &[Self], alloc: A) -> Result<Vec<Self, A>, TryReserveError>
+        where
+            Self: Sized;
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    impl<T: Clone> ConvertVec for T {
+        #[inline]
+        default fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A> {
+            struct DropGuard<'a, T, A: Allocator> {
+                vec: &'a mut Vec<T, A>,
+                num_init: usize,
+            }
+            impl<'a, T, A: Allocator> Drop for DropGuard<'a, T, A> {
+                #[inline]
+                fn drop(&mut self) {
+                    // SAFETY:
+                    // items were marked initialized in the loop below
+                    unsafe {
+                        self.vec.set_len(self.num_init);
+                    }
+                }
+            }
+            let mut vec = Vec::with_capacity_in(s.len(), alloc);
+            let mut guard = DropGuard { vec: &mut vec, num_init: 0 };
+            let slots = guard.vec.spare_capacity_mut();
+            // .take(slots.len()) is necessary for LLVM to remove bounds checks
+            // and has better codegen than zip.
+            for (i, b) in s.iter().enumerate().take(slots.len()) {
+                guard.num_init = i;
+                slots[i].write(b.clone());
+            }
+            core::mem::forget(guard);
+            // SAFETY:
+            // the vec was allocated and initialized above to at least this length.
+            unsafe {
+                vec.set_len(s.len());
+            }
+            vec
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    impl<T: Copy> ConvertVec for T {
+        #[inline]
+        fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A> {
+            let mut v = Vec::with_capacity_in(s.len(), alloc);
+            // SAFETY:
+            // allocated above with the capacity of `s`, and initialize to `s.len()` in
+            // ptr::copy_to_non_overlapping below.
+            unsafe {
+                s.as_ptr().copy_to_nonoverlapping(v.as_mut_ptr(), s.len());
+                v.set_len(s.len());
+            }
+            v
+        }
+    }
+
+    impl<T: Clone> TryConvertVec for T {
+        #[inline]
+        default fn try_to_vec<A: Allocator>(s: &[Self], alloc: A) -> Result<Vec<Self, A>, TryReserveError> {
+            struct DropGuard<'a, T, A: Allocator> {
+                vec: &'a mut Vec<T, A>,
+                num_init: usize,
+            }
+            impl<'a, T, A: Allocator> Drop for DropGuard<'a, T, A> {
+                #[inline]
+                fn drop(&mut self) {
+                    // SAFETY:
+                    // items were marked initialized in the loop below
+                    unsafe {
+                        self.vec.set_len(self.num_init);
+                    }
+                }
+            }
+            let mut vec = Vec::try_with_capacity_in(s.len(), alloc)?;
+            let mut guard = DropGuard { vec: &mut vec, num_init: 0 };
+            let slots = guard.vec.spare_capacity_mut();
+            // .take(slots.len()) is necessary for LLVM to remove bounds checks
+            // and has better codegen than zip.
+            for (i, b) in s.iter().enumerate().take(slots.len()) {
+                guard.num_init = i;
+                slots[i].write(b.clone());
+            }
+            core::mem::forget(guard);
+            // SAFETY:
+            // the vec was allocated and initialized above to at least this length.
+            unsafe {
+                vec.set_len(s.len());
+            }
+            Ok(vec)
+        }
+    }
+}
+
+#[lang = "slice_alloc"]
+#[cfg(not(test))]
+impl<T> [T] {
+    /// Sorts the slice.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*n* \* log(*n*)) worst-case.
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable`](slice::sort_unstable).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5, 4, 1, -3, 2];
+    ///
+    /// v.sort();
+    /// assert!(v == [-5, -3, 1, 2, 4]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn sort(&mut self)
+    where
+        T: Ord,
+    {
+        merge_sort(self, |a, b| a.lt(b));
+    }
+
+    /// Sorts the slice with a comparator function.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*n* \* log(*n*)) worst-case.
+    ///
+    /// The comparator function must define a total ordering for the elements in the slice. If
+    /// the ordering is not total, the order of the elements is unspecified. An order is a
+    /// total order if it is (for all `a`, `b` and `c`):
+    ///
+    /// * total and antisymmetric: exactly one of `a < b`, `a == b` or `a > b` is true, and
+    /// * transitive, `a < b` and `b < c` implies `a < c`. The same must hold for both `==` and `>`.
+    ///
+    /// For example, while [`f64`] doesn't implement [`Ord`] because `NaN != NaN`, we can use
+    /// `partial_cmp` as our sort function when we know the slice doesn't contain a `NaN`.
+    ///
+    /// ```
+    /// let mut floats = [5f64, 4.0, 1.0, 3.0, 2.0];
+    /// floats.sort_by(|a, b| a.partial_cmp(b).unwrap());
+    /// assert_eq!(floats, [1.0, 2.0, 3.0, 4.0, 5.0]);
+    /// ```
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable_by`](slice::sort_unstable_by).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [5, 4, 1, 3, 2];
+    /// v.sort_by(|a, b| a.cmp(b));
+    /// assert!(v == [1, 2, 3, 4, 5]);
+    ///
+    /// // reverse sorting
+    /// v.sort_by(|a, b| b.cmp(a));
+    /// assert!(v == [5, 4, 3, 2, 1]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn sort_by<F>(&mut self, mut compare: F)
+    where
+        F: FnMut(&T, &T) -> Ordering,
+    {
+        merge_sort(self, |a, b| compare(a, b) == Less);
+    }
+
+    /// Sorts the slice with a key extraction function.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*m* \* *n* \* log(*n*))
+    /// worst-case, where the key function is *O*(*m*).
+    ///
+    /// For expensive key functions (e.g. functions that are not simple property accesses or
+    /// basic operations), [`sort_by_cached_key`](slice::sort_by_cached_key) is likely to be
+    /// significantly faster, as it does not recompute element keys.
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable_by_key`](slice::sort_unstable_by_key).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5i32, 4, 1, -3, 2];
+    ///
+    /// v.sort_by_key(|k| k.abs());
+    /// assert!(v == [1, 2, -3, 4, -5]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "slice_sort_by_key", since = "1.7.0")]
+    #[inline]
+    pub fn sort_by_key<K, F>(&mut self, mut f: F)
+    where
+        F: FnMut(&T) -> K,
+        K: Ord,
+    {
+        merge_sort(self, |a, b| f(a).lt(&f(b)));
+    }
+
+    /// Sorts the slice with a key extraction function.
+    ///
+    /// During sorting, the key function is called only once per element.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*m* \* *n* + *n* \* log(*n*))
+    /// worst-case, where the key function is *O*(*m*).
+    ///
+    /// For simple key functions (e.g., functions that are property accesses or
+    /// basic operations), [`sort_by_key`](slice::sort_by_key) is likely to be
+    /// faster.
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is based on [pattern-defeating quicksort][pdqsort] by Orson Peters,
+    /// which combines the fast average case of randomized quicksort with the fast worst case of
+    /// heapsort, while achieving linear time on slices with certain patterns. It uses some
+    /// randomization to avoid degenerate cases, but with a fixed seed to always provide
+    /// deterministic behavior.
+    ///
+    /// In the worst case, the algorithm allocates temporary storage in a `Vec<(K, usize)>` the
+    /// length of the slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5i32, 4, 32, -3, 2];
+    ///
+    /// v.sort_by_cached_key(|k| k.to_string());
+    /// assert!(v == [-3, -5, 2, 32, 4]);
+    /// ```
+    ///
+    /// [pdqsort]: https://github.com/orlp/pdqsort
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "slice_sort_by_cached_key", since = "1.34.0")]
+    #[inline]
+    pub fn sort_by_cached_key<K, F>(&mut self, f: F)
+    where
+        F: FnMut(&T) -> K,
+        K: Ord,
+    {
+        // Helper macro for indexing our vector by the smallest possible type, to reduce allocation.
+        macro_rules! sort_by_key {
+            ($t:ty, $slice:ident, $f:ident) => {{
+                let mut indices: Vec<_> =
+                    $slice.iter().map($f).enumerate().map(|(i, k)| (k, i as $t)).collect();
+                // The elements of `indices` are unique, as they are indexed, so any sort will be
+                // stable with respect to the original slice. We use `sort_unstable` here because
+                // it requires less memory allocation.
+                indices.sort_unstable();
+                for i in 0..$slice.len() {
+                    let mut index = indices[i].1;
+                    while (index as usize) < i {
+                        index = indices[index as usize].1;
+                    }
+                    indices[i].1 = index;
+                    $slice.swap(i, index as usize);
+                }
+            }};
+        }
+
+        let sz_u8 = mem::size_of::<(K, u8)>();
+        let sz_u16 = mem::size_of::<(K, u16)>();
+        let sz_u32 = mem::size_of::<(K, u32)>();
+        let sz_usize = mem::size_of::<(K, usize)>();
+
+        let len = self.len();
+        if len < 2 {
+            return;
+        }
+        if sz_u8 < sz_u16 && len <= (u8::MAX as usize) {
+            return sort_by_key!(u8, self, f);
+        }
+        if sz_u16 < sz_u32 && len <= (u16::MAX as usize) {
+            return sort_by_key!(u16, self, f);
+        }
+        if sz_u32 < sz_usize && len <= (u32::MAX as usize) {
+            return sort_by_key!(u32, self, f);
+        }
+        sort_by_key!(usize, self, f)
+    }
+
+    /// Copies `self` into a new `Vec`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s = [10, 40, 30];
+    /// let x = s.to_vec();
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_conversion_suggestion]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn to_vec(&self) -> Vec<T>
+    where
+        T: Clone,
+    {
+        self.to_vec_in(Global)
+    }
+
+    /// Tries to copy `self` into a new `Vec`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s = [10, 40, 30];
+    /// let x = s.try_to_vec().unwrap();
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_to_vec(&self) -> Result<Vec<T>, TryReserveError>
+    where
+        T: Clone,
+    {
+        self.try_to_vec_in(Global)
+    }
+
+    /// Copies `self` into a new `Vec` with an allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let s = [10, 40, 30];
+    /// let x = s.to_vec_in(System);
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub fn to_vec_in<A: Allocator>(&self, alloc: A) -> Vec<T, A>
+    where
+        T: Clone,
+    {
+        // N.B., see the `hack` module in this file for more details.
+        hack::to_vec(self, alloc)
+    }
+
+    /// Tries to copy `self` into a new `Vec` with an allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let s = [10, 40, 30];
+    /// let x = s.try_to_vec_in(System).unwrap();
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_to_vec_in<A: Allocator>(&self, alloc: A) -> Result<Vec<T, A>, TryReserveError>
+    where
+        T: Clone,
+    {
+        // N.B., see the `hack` module in this file for more details.
+        hack::try_to_vec(self, alloc)
+    }
+
+    /// Converts `self` into a vector without clones or allocation.
+    ///
+    /// The resulting vector can be converted back into a box via
+    /// `Vec<T>`'s `into_boxed_slice` method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s: Box<[i32]> = Box::new([10, 40, 30]);
+    /// let x = s.into_vec();
+    /// // `s` cannot be used anymore because it has been converted into `x`.
+    ///
+    /// assert_eq!(x, vec![10, 40, 30]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn into_vec<A: Allocator>(self: Box<Self, A>) -> Vec<T, A> {
+        // N.B., see the `hack` module in this file for more details.
+        hack::into_vec(self)
+    }
+
+    /// Creates a vector by repeating a slice `n` times.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the capacity would overflow.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// assert_eq!([1, 2].repeat(3), vec![1, 2, 1, 2, 1, 2]);
+    /// ```
+    ///
+    /// A panic upon overflow:
+    ///
+    /// ```should_panic
+    /// // this will panic at runtime
+    /// b"0123456789abcdef".repeat(usize::MAX);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "repeat_generic_slice", since = "1.40.0")]
+    pub fn repeat(&self, n: usize) -> Vec<T>
+    where
+        T: Copy,
+    {
+        if n == 0 {
+            return Vec::new();
+        }
+
+        // If `n` is larger than zero, it can be split as
+        // `n = 2^expn + rem (2^expn > rem, expn >= 0, rem >= 0)`.
+        // `2^expn` is the number represented by the leftmost '1' bit of `n`,
+        // and `rem` is the remaining part of `n`.
+
+        // Using `Vec` to access `set_len()`.
+        let capacity = self.len().checked_mul(n).expect("capacity overflow");
+        let mut buf = Vec::with_capacity(capacity);
+
+        // `2^expn` repetition is done by doubling `buf` `expn`-times.
+        buf.extend(self);
+        {
+            let mut m = n >> 1;
+            // If `m > 0`, there are remaining bits up to the leftmost '1'.
+            while m > 0 {
+                // `buf.extend(buf)`:
+                unsafe {
+                    ptr::copy_nonoverlapping(
+                        buf.as_ptr(),
+                        (buf.as_mut_ptr() as *mut T).add(buf.len()),
+                        buf.len(),
+                    );
+                    // `buf` has capacity of `self.len() * n`.
+                    let buf_len = buf.len();
+                    buf.set_len(buf_len * 2);
+                }
+
+                m >>= 1;
+            }
+        }
+
+        // `rem` (`= n - 2^expn`) repetition is done by copying
+        // first `rem` repetitions from `buf` itself.
+        let rem_len = capacity - buf.len(); // `self.len() * rem`
+        if rem_len > 0 {
+            // `buf.extend(buf[0 .. rem_len])`:
+            unsafe {
+                // This is non-overlapping since `2^expn > rem`.
+                ptr::copy_nonoverlapping(
+                    buf.as_ptr(),
+                    (buf.as_mut_ptr() as *mut T).add(buf.len()),
+                    rem_len,
+                );
+                // `buf.len() + rem_len` equals to `buf.capacity()` (`= self.len() * n`).
+                buf.set_len(capacity);
+            }
+        }
+        buf
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(["hello", "world"].concat(), "helloworld");
+    /// assert_eq!([[1, 2], [3, 4]].concat(), [1, 2, 3, 4]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn concat<Item: ?Sized>(&self) -> <Self as Concat<Item>>::Output
+    where
+        Self: Concat<Item>,
+    {
+        Concat::concat(self)
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`, placing a
+    /// given separator between each.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(["hello", "world"].join(" "), "hello world");
+    /// assert_eq!([[1, 2], [3, 4]].join(&0), [1, 2, 0, 3, 4]);
+    /// assert_eq!([[1, 2], [3, 4]].join(&[0, 0][..]), [1, 2, 0, 0, 3, 4]);
+    /// ```
+    #[stable(feature = "rename_connect_to_join", since = "1.3.0")]
+    pub fn join<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Output
+    where
+        Self: Join<Separator>,
+    {
+        Join::join(self, sep)
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`, placing a
+    /// given separator between each.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # #![allow(deprecated)]
+    /// assert_eq!(["hello", "world"].connect(" "), "hello world");
+    /// assert_eq!([[1, 2], [3, 4]].connect(&0), [1, 2, 0, 3, 4]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[rustc_deprecated(since = "1.3.0", reason = "renamed to join")]
+    pub fn connect<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Output
+    where
+        Self: Join<Separator>,
+    {
+        Join::join(self, sep)
+    }
+}
+
+#[lang = "slice_u8_alloc"]
+#[cfg(not(test))]
+impl [u8] {
+    /// Returns a vector containing a copy of this slice where each byte
+    /// is mapped to its ASCII upper case equivalent.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
+    ///
+    /// [`make_ascii_uppercase`]: slice::make_ascii_uppercase
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the uppercase bytes as a new Vec, \
+                  without modifying the original"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_uppercase(&self) -> Vec<u8> {
+        let mut me = self.to_vec();
+        me.make_ascii_uppercase();
+        me
+    }
+
+    /// Returns a vector containing a copy of this slice where each byte
+    /// is mapped to its ASCII lower case equivalent.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
+    ///
+    /// [`make_ascii_lowercase`]: slice::make_ascii_lowercase
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the lowercase bytes as a new Vec, \
+                  without modifying the original"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_lowercase(&self) -> Vec<u8> {
+        let mut me = self.to_vec();
+        me.make_ascii_lowercase();
+        me
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Extension traits for slices over specific kinds of data
+////////////////////////////////////////////////////////////////////////////////
+
+/// Helper trait for [`[T]::concat`](slice::concat).
+///
+/// Note: the `Item` type parameter is not used in this trait,
+/// but it allows impls to be more generic.
+/// Without it, we get this error:
+///
+/// ```error
+/// error[E0207]: the type parameter `T` is not constrained by the impl trait, self type, or predica
+///    --> src/liballoc/slice.rs:608:6
+///     |
+/// 608 | impl<T: Clone, V: Borrow<[T]>> Concat for [V] {
+///     |      ^ unconstrained type parameter
+/// ```
+///
+/// This is because there could exist `V` types with multiple `Borrow<[_]>` impls,
+/// such that multiple `T` types would apply:
+///
+/// ```
+/// # #[allow(dead_code)]
+/// pub struct Foo(Vec<u32>, Vec<String>);
+///
+/// impl std::borrow::Borrow<[u32]> for Foo {
+///     fn borrow(&self) -> &[u32] { &self.0 }
+/// }
+///
+/// impl std::borrow::Borrow<[String]> for Foo {
+///     fn borrow(&self) -> &[String] { &self.1 }
+/// }
+/// ```
+#[unstable(feature = "slice_concat_trait", issue = "27747")]
+pub trait Concat<Item: ?Sized> {
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    /// The resulting type after concatenation
+    type Output;
+
+    /// Implementation of [`[T]::concat`](slice::concat)
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    fn concat(slice: &Self) -> Self::Output;
+}
+
+/// Helper trait for [`[T]::join`](slice::join)
+#[unstable(feature = "slice_concat_trait", issue = "27747")]
+pub trait Join<Separator> {
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    /// The resulting type after concatenation
+    type Output;
+
+    /// Implementation of [`[T]::join`](slice::join)
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    fn join(slice: &Self, sep: Separator) -> Self::Output;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Concat<T> for [V] {
+    type Output = Vec<T>;
+
+    fn concat(slice: &Self) -> Vec<T> {
+        let size = slice.iter().map(|slice| slice.borrow().len()).sum();
+        let mut result = Vec::with_capacity(size);
+        for v in slice {
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Join<&T> for [V] {
+    type Output = Vec<T>;
+
+    fn join(slice: &Self, sep: &T) -> Vec<T> {
+        let mut iter = slice.iter();
+        let first = match iter.next() {
+            Some(first) => first,
+            None => return vec![],
+        };
+        let size = slice.iter().map(|v| v.borrow().len()).sum::<usize>() + slice.len() - 1;
+        let mut result = Vec::with_capacity(size);
+        result.extend_from_slice(first.borrow());
+
+        for v in iter {
+            result.push(sep.clone());
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Join<&[T]> for [V] {
+    type Output = Vec<T>;
+
+    fn join(slice: &Self, sep: &[T]) -> Vec<T> {
+        let mut iter = slice.iter();
+        let first = match iter.next() {
+            Some(first) => first,
+            None => return vec![],
+        };
+        let size =
+            slice.iter().map(|v| v.borrow().len()).sum::<usize>() + sep.len() * (slice.len() - 1);
+        let mut result = Vec::with_capacity(size);
+        result.extend_from_slice(first.borrow());
+
+        for v in iter {
+            result.extend_from_slice(sep);
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Standard trait implementations for slices
+////////////////////////////////////////////////////////////////////////////////
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> Borrow<[T]> for Vec<T> {
+    fn borrow(&self) -> &[T] {
+        &self[..]
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> BorrowMut<[T]> for Vec<T> {
+    fn borrow_mut(&mut self) -> &mut [T] {
+        &mut self[..]
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone> ToOwned for [T] {
+    type Owned = Vec<T>;
+    #[cfg(not(test))]
+    fn to_owned(&self) -> Vec<T> {
+        self.to_vec()
+    }
+
+    #[cfg(test)]
+    fn to_owned(&self) -> Vec<T> {
+        hack::to_vec(self, Global)
+    }
+
+    fn clone_into(&self, target: &mut Vec<T>) {
+        // drop anything in target that will not be overwritten
+        target.truncate(self.len());
+
+        // target.len <= self.len due to the truncate above, so the
+        // slices here are always in-bounds.
+        let (init, tail) = self.split_at(target.len());
+
+        // reuse the contained values' allocations/resources.
+        target.clone_from_slice(init);
+        target.extend_from_slice(tail);
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Sorting
+////////////////////////////////////////////////////////////////////////////////
+
+/// Inserts `v[0]` into pre-sorted sequence `v[1..]` so that whole `v[..]` becomes sorted.
+///
+/// This is the integral subroutine of insertion sort.
+#[cfg(not(no_global_oom_handling))]
+fn insert_head<T, F>(v: &mut [T], is_less: &mut F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    if v.len() >= 2 && is_less(&v[1], &v[0]) {
+        unsafe {
+            // There are three ways to implement insertion here:
+            //
+            // 1. Swap adjacent elements until the first one gets to its final destination.
+            //    However, this way we copy data around more than is necessary. If elements are big
+            //    structures (costly to copy), this method will be slow.
+            //
+            // 2. Iterate until the right place for the first element is found. Then shift the
+            //    elements succeeding it to make room for it and finally place it into the
+            //    remaining hole. This is a good method.
+            //
+            // 3. Copy the first element into a temporary variable. Iterate until the right place
+            //    for it is found. As we go along, copy every traversed element into the slot
+            //    preceding it. Finally, copy data from the temporary variable into the remaining
+            //    hole. This method is very good. Benchmarks demonstrated slightly better
+            //    performance than with the 2nd method.
+            //
+            // All methods were benchmarked, and the 3rd showed best results. So we chose that one.
+            let mut tmp = mem::ManuallyDrop::new(ptr::read(&v[0]));
+
+            // Intermediate state of the insertion process is always tracked by `hole`, which
+            // serves two purposes:
+            // 1. Protects integrity of `v` from panics in `is_less`.
+            // 2. Fills the remaining hole in `v` in the end.
+            //
+            // Panic safety:
+            //
+            // If `is_less` panics at any point during the process, `hole` will get dropped and
+            // fill the hole in `v` with `tmp`, thus ensuring that `v` still holds every object it
+            // initially held exactly once.
+            let mut hole = InsertionHole { src: &mut *tmp, dest: &mut v[1] };
+            ptr::copy_nonoverlapping(&v[1], &mut v[0], 1);
+
+            for i in 2..v.len() {
+                if !is_less(&v[i], &*tmp) {
+                    break;
+                }
+                ptr::copy_nonoverlapping(&v[i], &mut v[i - 1], 1);
+                hole.dest = &mut v[i];
+            }
+            // `hole` gets dropped and thus copies `tmp` into the remaining hole in `v`.
+        }
+    }
+
+    // When dropped, copies from `src` into `dest`.
+    struct InsertionHole<T> {
+        src: *mut T,
+        dest: *mut T,
+    }
+
+    impl<T> Drop for InsertionHole<T> {
+        fn drop(&mut self) {
+            unsafe {
+                ptr::copy_nonoverlapping(self.src, self.dest, 1);
+            }
+        }
+    }
+}
+
+/// Merges non-decreasing runs `v[..mid]` and `v[mid..]` using `buf` as temporary storage, and
+/// stores the result into `v[..]`.
+///
+/// # Safety
+///
+/// The two slices must be non-empty and `mid` must be in bounds. Buffer `buf` must be long enough
+/// to hold a copy of the shorter slice. Also, `T` must not be a zero-sized type.
+#[cfg(not(no_global_oom_handling))]
+unsafe fn merge<T, F>(v: &mut [T], mid: usize, buf: *mut T, is_less: &mut F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    let len = v.len();
+    let v = v.as_mut_ptr();
+    let (v_mid, v_end) = unsafe { (v.add(mid), v.add(len)) };
+
+    // The merge process first copies the shorter run into `buf`. Then it traces the newly copied
+    // run and the longer run forwards (or backwards), comparing their next unconsumed elements and
+    // copying the lesser (or greater) one into `v`.
+    //
+    // As soon as the shorter run is fully consumed, the process is done. If the longer run gets
+    // consumed first, then we must copy whatever is left of the shorter run into the remaining
+    // hole in `v`.
+    //
+    // Intermediate state of the process is always tracked by `hole`, which serves two purposes:
+    // 1. Protects integrity of `v` from panics in `is_less`.
+    // 2. Fills the remaining hole in `v` if the longer run gets consumed first.
+    //
+    // Panic safety:
+    //
+    // If `is_less` panics at any point during the process, `hole` will get dropped and fill the
+    // hole in `v` with the unconsumed range in `buf`, thus ensuring that `v` still holds every
+    // object it initially held exactly once.
+    let mut hole;
+
+    if mid <= len - mid {
+        // The left run is shorter.
+        unsafe {
+            ptr::copy_nonoverlapping(v, buf, mid);
+            hole = MergeHole { start: buf, end: buf.add(mid), dest: v };
+        }
+
+        // Initially, these pointers point to the beginnings of their arrays.
+        let left = &mut hole.start;
+        let mut right = v_mid;
+        let out = &mut hole.dest;
+
+        while *left < hole.end && right < v_end {
+            // Consume the lesser side.
+            // If equal, prefer the left run to maintain stability.
+            unsafe {
+                let to_copy = if is_less(&*right, &**left) {
+                    get_and_increment(&mut right)
+                } else {
+                    get_and_increment(left)
+                };
+                ptr::copy_nonoverlapping(to_copy, get_and_increment(out), 1);
+            }
+        }
+    } else {
+        // The right run is shorter.
+        unsafe {
+            ptr::copy_nonoverlapping(v_mid, buf, len - mid);
+            hole = MergeHole { start: buf, end: buf.add(len - mid), dest: v_mid };
+        }
+
+        // Initially, these pointers point past the ends of their arrays.
+        let left = &mut hole.dest;
+        let right = &mut hole.end;
+        let mut out = v_end;
+
+        while v < *left && buf < *right {
+            // Consume the greater side.
+            // If equal, prefer the right run to maintain stability.
+            unsafe {
+                let to_copy = if is_less(&*right.offset(-1), &*left.offset(-1)) {
+                    decrement_and_get(left)
+                } else {
+                    decrement_and_get(right)
+                };
+                ptr::copy_nonoverlapping(to_copy, decrement_and_get(&mut out), 1);
+            }
+        }
+    }
+    // Finally, `hole` gets dropped. If the shorter run was not fully consumed, whatever remains of
+    // it will now be copied into the hole in `v`.
+
+    unsafe fn get_and_increment<T>(ptr: &mut *mut T) -> *mut T {
+        let old = *ptr;
+        *ptr = unsafe { ptr.offset(1) };
+        old
+    }
+
+    unsafe fn decrement_and_get<T>(ptr: &mut *mut T) -> *mut T {
+        *ptr = unsafe { ptr.offset(-1) };
+        *ptr
+    }
+
+    // When dropped, copies the range `start..end` into `dest..`.
+    struct MergeHole<T> {
+        start: *mut T,
+        end: *mut T,
+        dest: *mut T,
+    }
+
+    impl<T> Drop for MergeHole<T> {
+        fn drop(&mut self) {
+            // `T` is not a zero-sized type, so it's okay to divide by its size.
+            let len = (self.end as usize - self.start as usize) / mem::size_of::<T>();
+            unsafe {
+                ptr::copy_nonoverlapping(self.start, self.dest, len);
+            }
+        }
+    }
+}
+
+/// This merge sort borrows some (but not all) ideas from TimSort, which is described in detail
+/// [here](https://github.com/python/cpython/blob/main/Objects/listsort.txt).
+///
+/// The algorithm identifies strictly descending and non-descending subsequences, which are called
+/// natural runs. There is a stack of pending runs yet to be merged. Each newly found run is pushed
+/// onto the stack, and then some pairs of adjacent runs are merged until these two invariants are
+/// satisfied:
+///
+/// 1. for every `i` in `1..runs.len()`: `runs[i - 1].len > runs[i].len`
+/// 2. for every `i` in `2..runs.len()`: `runs[i - 2].len > runs[i - 1].len + runs[i].len`
+///
+/// The invariants ensure that the total running time is *O*(*n* \* log(*n*)) worst-case.
+#[cfg(not(no_global_oom_handling))]
+fn merge_sort<T, F>(v: &mut [T], mut is_less: F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    // Slices of up to this length get sorted using insertion sort.
+    const MAX_INSERTION: usize = 20;
+    // Very short runs are extended using insertion sort to span at least this many elements.
+    const MIN_RUN: usize = 10;
+
+    // Sorting has no meaningful behavior on zero-sized types.
+    if size_of::<T>() == 0 {
+        return;
+    }
+
+    let len = v.len();
+
+    // Short arrays get sorted in-place via insertion sort to avoid allocations.
+    if len <= MAX_INSERTION {
+        if len >= 2 {
+            for i in (0..len - 1).rev() {
+                insert_head(&mut v[i..], &mut is_less);
+            }
+        }
+        return;
+    }
+
+    // Allocate a buffer to use as scratch memory. We keep the length 0 so we can keep in it
+    // shallow copies of the contents of `v` without risking the dtors running on copies if
+    // `is_less` panics. When merging two sorted runs, this buffer holds a copy of the shorter run,
+    // which will always have length at most `len / 2`.
+    let mut buf = Vec::with_capacity(len / 2);
+
+    // In order to identify natural runs in `v`, we traverse it backwards. That might seem like a
+    // strange decision, but consider the fact that merges more often go in the opposite direction
+    // (forwards). According to benchmarks, merging forwards is slightly faster than merging
+    // backwards. To conclude, identifying runs by traversing backwards improves performance.
+    let mut runs = vec![];
+    let mut end = len;
+    while end > 0 {
+        // Find the next natural run, and reverse it if it's strictly descending.
+        let mut start = end - 1;
+        if start > 0 {
+            start -= 1;
+            unsafe {
+                if is_less(v.get_unchecked(start + 1), v.get_unchecked(start)) {
+                    while start > 0 && is_less(v.get_unchecked(start), v.get_unchecked(start - 1)) {
+                        start -= 1;
+                    }
+                    v[start..end].reverse();
+                } else {
+                    while start > 0 && !is_less(v.get_unchecked(start), v.get_unchecked(start - 1))
+                    {
+                        start -= 1;
+                    }
+                }
+            }
+        }
+
+        // Insert some more elements into the run if it's too short. Insertion sort is faster than
+        // merge sort on short sequences, so this significantly improves performance.
+        while start > 0 && end - start < MIN_RUN {
+            start -= 1;
+            insert_head(&mut v[start..end], &mut is_less);
+        }
+
+        // Push this run onto the stack.
+        runs.push(Run { start, len: end - start });
+        end = start;
+
+        // Merge some pairs of adjacent runs to satisfy the invariants.
+        while let Some(r) = collapse(&runs) {
+            let left = runs[r + 1];
+            let right = runs[r];
+            unsafe {
+                merge(
+                    &mut v[left.start..right.start + right.len],
+                    left.len,
+                    buf.as_mut_ptr(),
+                    &mut is_less,
+                );
+            }
+            runs[r] = Run { start: left.start, len: left.len + right.len };
+            runs.remove(r + 1);
+        }
+    }
+
+    // Finally, exactly one run must remain in the stack.
+    debug_assert!(runs.len() == 1 && runs[0].start == 0 && runs[0].len == len);
+
+    // Examines the stack of runs and identifies the next pair of runs to merge. More specifically,
+    // if `Some(r)` is returned, that means `runs[r]` and `runs[r + 1]` must be merged next. If the
+    // algorithm should continue building a new run instead, `None` is returned.
+    //
+    // TimSort is infamous for its buggy implementations, as described here:
+    // http://envisage-project.eu/timsort-specification-and-verification/
+    //
+    // The gist of the story is: we must enforce the invariants on the top four runs on the stack.
+    // Enforcing them on just top three is not sufficient to ensure that the invariants will still
+    // hold for *all* runs in the stack.
+    //
+    // This function correctly checks invariants for the top four runs. Additionally, if the top
+    // run starts at index 0, it will always demand a merge operation until the stack is fully
+    // collapsed, in order to complete the sort.
+    #[inline]
+    fn collapse(runs: &[Run]) -> Option<usize> {
+        let n = runs.len();
+        if n >= 2
+            && (runs[n - 1].start == 0
+                || runs[n - 2].len <= runs[n - 1].len
+                || (n >= 3 && runs[n - 3].len <= runs[n - 2].len + runs[n - 1].len)
+                || (n >= 4 && runs[n - 4].len <= runs[n - 3].len + runs[n - 2].len))
+        {
+            if n >= 3 && runs[n - 3].len < runs[n - 1].len { Some(n - 3) } else { Some(n - 2) }
+        } else {
+            None
+        }
+    }
+
+    #[derive(Clone, Copy)]
+    struct Run {
+        start: usize,
+        len: usize,
+    }
+}
diff --git a/rust/alloc/str.rs b/rust/alloc/str.rs
new file mode 100644
index 000000000000..29b4aa31745a
--- /dev/null
+++ b/rust/alloc/str.rs
@@ -0,0 +1,621 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! Unicode string slices.
+//!
+//! *[See also the `str` primitive type](str).*
+//!
+//! The `&str` type is one of the two main string types, the other being `String`.
+//! Unlike its `String` counterpart, its contents are borrowed.
+//!
+//! # Basic Usage
+//!
+//! A basic string declaration of `&str` type:
+//!
+//! ```
+//! let hello_world = "Hello, World!";
+//! ```
+//!
+//! Here we have declared a string literal, also known as a string slice.
+//! String literals have a static lifetime, which means the string `hello_world`
+//! is guaranteed to be valid for the duration of the entire program.
+//! We can explicitly specify `hello_world`'s lifetime as well:
+//!
+//! ```
+//! let hello_world: &'static str = "Hello, world!";
+//! ```
+
+#![stable(feature = "rust1", since = "1.0.0")]
+// Many of the usings in this module are only used in the test configuration.
+// It's cleaner to just turn off the unused_imports warning than to fix them.
+#![allow(unused_imports)]
+
+use core::borrow::{Borrow, BorrowMut};
+use core::iter::FusedIterator;
+use core::mem;
+use core::ptr;
+use core::str::pattern::{DoubleEndedSearcher, Pattern, ReverseSearcher, Searcher};
+use core::unicode::conversions;
+
+use crate::borrow::ToOwned;
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::slice::{Concat, Join, SliceIndex};
+use crate::string::String;
+use crate::vec::Vec;
+
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::pattern;
+#[stable(feature = "encode_utf16", since = "1.8.0")]
+pub use core::str::EncodeUtf16;
+#[stable(feature = "split_ascii_whitespace", since = "1.34.0")]
+pub use core::str::SplitAsciiWhitespace;
+#[stable(feature = "split_inclusive", since = "1.53.0")]
+pub use core::str::SplitInclusive;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::SplitWhitespace;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{from_utf8, from_utf8_mut, Bytes, CharIndices, Chars};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{from_utf8_unchecked, from_utf8_unchecked_mut, ParseBoolError};
+#[stable(feature = "str_escape", since = "1.34.0")]
+pub use core::str::{EscapeDebug, EscapeDefault, EscapeUnicode};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{FromStr, Utf8Error};
+#[allow(deprecated)]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{Lines, LinesAny};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{MatchIndices, RMatchIndices};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{Matches, RMatches};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{RSplit, Split};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{RSplitN, SplitN};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::str::{RSplitTerminator, SplitTerminator};
+
+/// Note: `str` in `Concat<str>` is not meaningful here.
+/// This type parameter of the trait only exists to enable another impl.
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<S: Borrow<str>> Concat<str> for [S] {
+    type Output = String;
+
+    fn concat(slice: &Self) -> String {
+        Join::join(slice, "")
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<S: Borrow<str>> Join<&str> for [S] {
+    type Output = String;
+
+    fn join(slice: &Self, sep: &str) -> String {
+        unsafe { String::from_utf8_unchecked(join_generic_copy(slice, sep.as_bytes())) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+macro_rules! specialize_for_lengths {
+    ($separator:expr, $target:expr, $iter:expr; $($num:expr),*) => {{
+        let mut target = $target;
+        let iter = $iter;
+        let sep_bytes = $separator;
+        match $separator.len() {
+            $(
+                // loops with hardcoded sizes run much faster
+                // specialize the cases with small separator lengths
+                $num => {
+                    for s in iter {
+                        copy_slice_and_advance!(target, sep_bytes);
+                        let content_bytes = s.borrow().as_ref();
+                        copy_slice_and_advance!(target, content_bytes);
+                    }
+                },
+            )*
+            _ => {
+                // arbitrary non-zero size fallback
+                for s in iter {
+                    copy_slice_and_advance!(target, sep_bytes);
+                    let content_bytes = s.borrow().as_ref();
+                    copy_slice_and_advance!(target, content_bytes);
+                }
+            }
+        }
+        target
+    }}
+}
+
+#[cfg(not(no_global_oom_handling))]
+macro_rules! copy_slice_and_advance {
+    ($target:expr, $bytes:expr) => {
+        let len = $bytes.len();
+        let (head, tail) = { $target }.split_at_mut(len);
+        head.copy_from_slice($bytes);
+        $target = tail;
+    };
+}
+
+// Optimized join implementation that works for both Vec<T> (T: Copy) and String's inner vec
+// Currently (2018-05-13) there is a bug with type inference and specialization (see issue #36262)
+// For this reason SliceConcat<T> is not specialized for T: Copy and SliceConcat<str> is the
+// only user of this function. It is left in place for the time when that is fixed.
+//
+// the bounds for String-join are S: Borrow<str> and for Vec-join Borrow<[T]>
+// [T] and str both impl AsRef<[T]> for some T
+// => s.borrow().as_ref() and we always have slices
+#[cfg(not(no_global_oom_handling))]
+fn join_generic_copy<B, T, S>(slice: &[S], sep: &[T]) -> Vec<T>
+where
+    T: Copy,
+    B: AsRef<[T]> + ?Sized,
+    S: Borrow<B>,
+{
+    let sep_len = sep.len();
+    let mut iter = slice.iter();
+
+    // the first slice is the only one without a separator preceding it
+    let first = match iter.next() {
+        Some(first) => first,
+        None => return vec![],
+    };
+
+    // compute the exact total length of the joined Vec
+    // if the `len` calculation overflows, we'll panic
+    // we would have run out of memory anyway and the rest of the function requires
+    // the entire Vec pre-allocated for safety
+    let reserved_len = sep_len
+        .checked_mul(iter.len())
+        .and_then(|n| {
+            slice.iter().map(|s| s.borrow().as_ref().len()).try_fold(n, usize::checked_add)
+        })
+        .expect("attempt to join into collection with len > usize::MAX");
+
+    // prepare an uninitialized buffer
+    let mut result = Vec::with_capacity(reserved_len);
+    debug_assert!(result.capacity() >= reserved_len);
+
+    result.extend_from_slice(first.borrow().as_ref());
+
+    unsafe {
+        let pos = result.len();
+        let target = result.get_unchecked_mut(pos..reserved_len);
+
+        // copy separator and slices over without bounds checks
+        // generate loops with hardcoded offsets for small separators
+        // massive improvements possible (~ x2)
+        let remain = specialize_for_lengths!(sep, target, iter; 0, 1, 2, 3, 4);
+
+        // A weird borrow implementation may return different
+        // slices for the length calculation and the actual copy.
+        // Make sure we don't expose uninitialized bytes to the caller.
+        let result_len = reserved_len - remain.len();
+        result.set_len(result_len);
+    }
+    result
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl Borrow<str> for String {
+    #[inline]
+    fn borrow(&self) -> &str {
+        &self[..]
+    }
+}
+
+#[stable(feature = "string_borrow_mut", since = "1.36.0")]
+impl BorrowMut<str> for String {
+    #[inline]
+    fn borrow_mut(&mut self) -> &mut str {
+        &mut self[..]
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ToOwned for str {
+    type Owned = String;
+    #[inline]
+    fn to_owned(&self) -> String {
+        unsafe { String::from_utf8_unchecked(self.as_bytes().to_owned()) }
+    }
+
+    fn clone_into(&self, target: &mut String) {
+        let mut b = mem::take(target).into_bytes();
+        self.as_bytes().clone_into(&mut b);
+        *target = unsafe { String::from_utf8_unchecked(b) }
+    }
+}
+
+/// Methods for string slices.
+#[lang = "str_alloc"]
+#[cfg(not(test))]
+impl str {
+    /// Converts a `Box<str>` into a `Box<[u8]>` without copying or allocating.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = "this is a string";
+    /// let boxed_str = s.to_owned().into_boxed_str();
+    /// let boxed_bytes = boxed_str.into_boxed_bytes();
+    /// assert_eq!(*boxed_bytes, *s.as_bytes());
+    /// ```
+    #[stable(feature = "str_box_extras", since = "1.20.0")]
+    #[inline]
+    pub fn into_boxed_bytes(self: Box<str>) -> Box<[u8]> {
+        self.into()
+    }
+
+    /// Replaces all matches of a pattern with another string.
+    ///
+    /// `replace` creates a new [`String`], and copies the data from this string slice into it.
+    /// While doing so, it attempts to find matches of a pattern. If it finds any, it
+    /// replaces them with the replacement string slice.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = "this is old";
+    ///
+    /// assert_eq!("this is new", s.replace("old", "new"));
+    /// ```
+    ///
+    /// When the pattern doesn't match:
+    ///
+    /// ```
+    /// let s = "this is old";
+    /// assert_eq!(s, s.replace("cookie monster", "little lamb"));
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the replaced string as a new allocation, \
+                  without modifying the original"]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn replace<'a, P: Pattern<'a>>(&'a self, from: P, to: &str) -> String {
+        let mut result = String::new();
+        let mut last_end = 0;
+        for (start, part) in self.match_indices(from) {
+            result.push_str(unsafe { self.get_unchecked(last_end..start) });
+            result.push_str(to);
+            last_end = start + part.len();
+        }
+        result.push_str(unsafe { self.get_unchecked(last_end..self.len()) });
+        result
+    }
+
+    /// Replaces first N matches of a pattern with another string.
+    ///
+    /// `replacen` creates a new [`String`], and copies the data from this string slice into it.
+    /// While doing so, it attempts to find matches of a pattern. If it finds any, it
+    /// replaces them with the replacement string slice at most `count` times.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = "foo foo 123 foo";
+    /// assert_eq!("new new 123 foo", s.replacen("foo", "new", 2));
+    /// assert_eq!("faa fao 123 foo", s.replacen('o', "a", 3));
+    /// assert_eq!("foo foo new23 foo", s.replacen(char::is_numeric, "new", 1));
+    /// ```
+    ///
+    /// When the pattern doesn't match:
+    ///
+    /// ```
+    /// let s = "this is old";
+    /// assert_eq!(s, s.replacen("cookie monster", "little lamb", 10));
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the replaced string as a new allocation, \
+                  without modifying the original"]
+    #[stable(feature = "str_replacen", since = "1.16.0")]
+    pub fn replacen<'a, P: Pattern<'a>>(&'a self, pat: P, to: &str, count: usize) -> String {
+        // Hope to reduce the times of re-allocation
+        let mut result = String::with_capacity(32);
+        let mut last_end = 0;
+        for (start, part) in self.match_indices(pat).take(count) {
+            result.push_str(unsafe { self.get_unchecked(last_end..start) });
+            result.push_str(to);
+            last_end = start + part.len();
+        }
+        result.push_str(unsafe { self.get_unchecked(last_end..self.len()) });
+        result
+    }
+
+    /// Returns the lowercase equivalent of this string slice, as a new [`String`].
+    ///
+    /// 'Lowercase' is defined according to the terms of the Unicode Derived Core Property
+    /// `Lowercase`.
+    ///
+    /// Since some characters can expand into multiple characters when changing
+    /// the case, this function returns a [`String`] instead of modifying the
+    /// parameter in-place.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = "HELLO";
+    ///
+    /// assert_eq!("hello", s.to_lowercase());
+    /// ```
+    ///
+    /// A tricky example, with sigma:
+    ///
+    /// ```
+    /// let sigma = "Σ";
+    ///
+    /// assert_eq!("σ", sigma.to_lowercase());
+    ///
+    /// // but at the end of a word, it's ς, not σ:
+    /// let odysseus = "ὈΔΥΣΣΕΎΣ";
+    ///
+    /// assert_eq!("ὀδυσσεύς", odysseus.to_lowercase());
+    /// ```
+    ///
+    /// Languages without case are not changed:
+    ///
+    /// ```
+    /// let new_year = "农历新年";
+    ///
+    /// assert_eq!(new_year, new_year.to_lowercase());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the lowercase string as a new String, \
+                  without modifying the original"]
+    #[stable(feature = "unicode_case_mapping", since = "1.2.0")]
+    pub fn to_lowercase(&self) -> String {
+        let mut s = String::with_capacity(self.len());
+        for (i, c) in self[..].char_indices() {
+            if c == 'Σ' {
+                // Σ maps to σ, except at the end of a word where it maps to ς.
+                // This is the only conditional (contextual) but language-independent mapping
+                // in `SpecialCasing.txt`,
+                // so hard-code it rather than have a generic "condition" mechanism.
+                // See https://github.com/rust-lang/rust/issues/26035
+                map_uppercase_sigma(self, i, &mut s)
+            } else {
+                match conversions::to_lower(c) {
+                    [a, '\0', _] => s.push(a),
+                    [a, b, '\0'] => {
+                        s.push(a);
+                        s.push(b);
+                    }
+                    [a, b, c] => {
+                        s.push(a);
+                        s.push(b);
+                        s.push(c);
+                    }
+                }
+            }
+        }
+        return s;
+
+        fn map_uppercase_sigma(from: &str, i: usize, to: &mut String) {
+            // See https://www.unicode.org/versions/Unicode7.0.0/ch03.pdf#G33992
+            // for the definition of `Final_Sigma`.
+            debug_assert!('Σ'.len_utf8() == 2);
+            let is_word_final = case_ignoreable_then_cased(from[..i].chars().rev())
+                && !case_ignoreable_then_cased(from[i + 2..].chars());
+            to.push_str(if is_word_final { "ς" } else { "σ" });
+        }
+
+        fn case_ignoreable_then_cased<I: Iterator<Item = char>>(iter: I) -> bool {
+            use core::unicode::{Case_Ignorable, Cased};
+            match iter.skip_while(|&c| Case_Ignorable(c)).next() {
+                Some(c) => Cased(c),
+                None => false,
+            }
+        }
+    }
+
+    /// Returns the uppercase equivalent of this string slice, as a new [`String`].
+    ///
+    /// 'Uppercase' is defined according to the terms of the Unicode Derived Core Property
+    /// `Uppercase`.
+    ///
+    /// Since some characters can expand into multiple characters when changing
+    /// the case, this function returns a [`String`] instead of modifying the
+    /// parameter in-place.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = "hello";
+    ///
+    /// assert_eq!("HELLO", s.to_uppercase());
+    /// ```
+    ///
+    /// Scripts without case are not changed:
+    ///
+    /// ```
+    /// let new_year = "农历新年";
+    ///
+    /// assert_eq!(new_year, new_year.to_uppercase());
+    /// ```
+    ///
+    /// One character can become multiple:
+    /// ```
+    /// let s = "tschüß";
+    ///
+    /// assert_eq!("TSCHÜSS", s.to_uppercase());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "this returns the uppercase string as a new String, \
+                  without modifying the original"]
+    #[stable(feature = "unicode_case_mapping", since = "1.2.0")]
+    pub fn to_uppercase(&self) -> String {
+        let mut s = String::with_capacity(self.len());
+        for c in self[..].chars() {
+            match conversions::to_upper(c) {
+                [a, '\0', _] => s.push(a),
+                [a, b, '\0'] => {
+                    s.push(a);
+                    s.push(b);
+                }
+                [a, b, c] => {
+                    s.push(a);
+                    s.push(b);
+                    s.push(c);
+                }
+            }
+        }
+        s
+    }
+
+    /// Converts a [`Box<str>`] into a [`String`] without copying or allocating.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let string = String::from("birthday gift");
+    /// let boxed_str = string.clone().into_boxed_str();
+    ///
+    /// assert_eq!(boxed_str.into_string(), string);
+    /// ```
+    #[stable(feature = "box_str", since = "1.4.0")]
+    #[inline]
+    pub fn into_string(self: Box<str>) -> String {
+        let slice = Box::<[u8]>::from(self);
+        unsafe { String::from_utf8_unchecked(slice.into_vec()) }
+    }
+
+    /// Creates a new [`String`] by repeating a string `n` times.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the capacity would overflow.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// assert_eq!("abc".repeat(4), String::from("abcabcabcabc"));
+    /// ```
+    ///
+    /// A panic upon overflow:
+    ///
+    /// ```should_panic
+    /// // this will panic at runtime
+    /// "0123456789abcdef".repeat(usize::MAX);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "repeat_str", since = "1.16.0")]
+    pub fn repeat(&self, n: usize) -> String {
+        unsafe { String::from_utf8_unchecked(self.as_bytes().repeat(n)) }
+    }
+
+    /// Returns a copy of this string where each character is mapped to its
+    /// ASCII upper case equivalent.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
+    ///
+    /// To uppercase ASCII characters in addition to non-ASCII characters, use
+    /// [`to_uppercase`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s = "Grüße, Jürgen ❤";
+    ///
+    /// assert_eq!("GRüßE, JüRGEN ❤", s.to_ascii_uppercase());
+    /// ```
+    ///
+    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
+    /// [`to_uppercase`]: #method.to_uppercase
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "to uppercase the value in-place, use `make_ascii_uppercase()`"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_uppercase(&self) -> String {
+        let mut bytes = self.as_bytes().to_vec();
+        bytes.make_ascii_uppercase();
+        // make_ascii_uppercase() preserves the UTF-8 invariant.
+        unsafe { String::from_utf8_unchecked(bytes) }
+    }
+
+    /// Returns a copy of this string where each character is mapped to its
+    /// ASCII lower case equivalent.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
+    ///
+    /// To lowercase ASCII characters in addition to non-ASCII characters, use
+    /// [`to_lowercase`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s = "Grüße, Jürgen ❤";
+    ///
+    /// assert_eq!("grüße, jürgen ❤", s.to_ascii_lowercase());
+    /// ```
+    ///
+    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
+    /// [`to_lowercase`]: #method.to_lowercase
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use = "to lowercase the value in-place, use `make_ascii_lowercase()`"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_lowercase(&self) -> String {
+        let mut bytes = self.as_bytes().to_vec();
+        bytes.make_ascii_lowercase();
+        // make_ascii_lowercase() preserves the UTF-8 invariant.
+        unsafe { String::from_utf8_unchecked(bytes) }
+    }
+
+    /// Tries to create a `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s: &str = "a";
+    /// let ss: String = s.try_to_owned().unwrap();
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_to_owned(&self) -> Result<String, TryReserveError> {
+        unsafe { Ok(String::from_utf8_unchecked(self.as_bytes().try_to_vec()?)) }
+    }
+}
+
+/// Converts a boxed slice of bytes to a boxed string slice without checking
+/// that the string contains valid UTF-8.
+///
+/// # Examples
+///
+/// Basic usage:
+///
+/// ```
+/// let smile_utf8 = Box::new([226, 152, 186]);
+/// let smile = unsafe { std::str::from_boxed_utf8_unchecked(smile_utf8) };
+///
+/// assert_eq!("☺", &*smile);
+/// ```
+#[stable(feature = "str_box_extras", since = "1.20.0")]
+#[must_use]
+#[inline]
+pub unsafe fn from_boxed_utf8_unchecked(v: Box<[u8]>) -> Box<str> {
+    unsafe { Box::from_raw(Box::into_raw(v) as *mut str) }
+}
diff --git a/rust/alloc/string.rs b/rust/alloc/string.rs
new file mode 100644
index 000000000000..a5bdf6df00dc
--- /dev/null
+++ b/rust/alloc/string.rs
@@ -0,0 +1,2857 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! A UTF-8–encoded, growable string.
+//!
+//! This module contains the [`String`] type, the [`ToString`] trait for
+//! converting to strings, and several error types that may result from
+//! working with [`String`]s.
+//!
+//! # Examples
+//!
+//! There are multiple ways to create a new [`String`] from a string literal:
+//!
+//! ```
+//! let s = "Hello".to_string();
+//!
+//! let s = String::from("world");
+//! let s: String = "also this".into();
+//! ```
+//!
+//! You can create a new [`String`] from an existing one by concatenating with
+//! `+`:
+//!
+//! ```
+//! let s = "Hello".to_string();
+//!
+//! let message = s + " world!";
+//! ```
+//!
+//! If you have a vector of valid UTF-8 bytes, you can make a [`String`] out of
+//! it. You can do the reverse too.
+//!
+//! ```
+//! let sparkle_heart = vec![240, 159, 146, 150];
+//!
+//! // We know these bytes are valid, so we'll use `unwrap()`.
+//! let sparkle_heart = String::from_utf8(sparkle_heart).unwrap();
+//!
+//! assert_eq!("💖", sparkle_heart);
+//!
+//! let bytes = sparkle_heart.into_bytes();
+//!
+//! assert_eq!(bytes, [240, 159, 146, 150]);
+//! ```
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[cfg(not(no_global_oom_handling))]
+use core::char::{decode_utf16, REPLACEMENT_CHARACTER};
+use core::fmt;
+use core::hash;
+#[cfg(not(no_global_oom_handling))]
+use core::iter::{from_fn, FromIterator};
+use core::iter::FusedIterator;
+#[cfg(not(no_global_oom_handling))]
+use core::ops::Add;
+#[cfg(not(no_global_oom_handling))]
+use core::ops::AddAssign;
+#[cfg(not(no_global_oom_handling))]
+use core::ops::Bound::{Excluded, Included, Unbounded};
+use core::ops::{self, Index, IndexMut, Range, RangeBounds};
+use core::ptr;
+use core::slice;
+#[cfg(not(no_global_oom_handling))]
+use core::str::lossy;
+use core::str::pattern::Pattern;
+
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::{Cow, ToOwned};
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::str::{self, Chars, Utf8Error};
+#[cfg(not(no_global_oom_handling))]
+use crate::str::{from_boxed_utf8_unchecked, FromStr};
+use crate::vec::Vec;
+
+/// A UTF-8–encoded, growable string.
+///
+/// The `String` type is the most common string type that has ownership over the
+/// contents of the string. It has a close relationship with its borrowed
+/// counterpart, the primitive [`str`].
+///
+/// # Examples
+///
+/// You can create a `String` from [a literal string][`&str`] with [`String::from`]:
+///
+/// [`String::from`]: From::from
+///
+/// ```
+/// let hello = String::from("Hello, world!");
+/// ```
+///
+/// You can append a [`char`] to a `String` with the [`push`] method, and
+/// append a [`&str`] with the [`push_str`] method:
+///
+/// ```
+/// let mut hello = String::from("Hello, ");
+///
+/// hello.push('w');
+/// hello.push_str("orld!");
+/// ```
+///
+/// [`push`]: String::push
+/// [`push_str`]: String::push_str
+///
+/// If you have a vector of UTF-8 bytes, you can create a `String` from it with
+/// the [`from_utf8`] method:
+///
+/// ```
+/// // some bytes, in a vector
+/// let sparkle_heart = vec![240, 159, 146, 150];
+///
+/// // We know these bytes are valid, so we'll use `unwrap()`.
+/// let sparkle_heart = String::from_utf8(sparkle_heart).unwrap();
+///
+/// assert_eq!("💖", sparkle_heart);
+/// ```
+///
+/// [`from_utf8`]: String::from_utf8
+///
+/// # UTF-8
+///
+/// `String`s are always valid UTF-8. This has a few implications, the first of
+/// which is that if you need a non-UTF-8 string, consider [`OsString`]. It is
+/// similar, but without the UTF-8 constraint. The second implication is that
+/// you cannot index into a `String`:
+///
+/// ```compile_fail,E0277
+/// let s = "hello";
+///
+/// println!("The first letter of s is {}", s[0]); // ERROR!!!
+/// ```
+///
+/// [`OsString`]: ../../std/ffi/struct.OsString.html "ffi::OsString"
+///
+/// Indexing is intended to be a constant-time operation, but UTF-8 encoding
+/// does not allow us to do this. Furthermore, it's not clear what sort of
+/// thing the index should return: a byte, a codepoint, or a grapheme cluster.
+/// The [`bytes`] and [`chars`] methods return iterators over the first
+/// two, respectively.
+///
+/// [`bytes`]: str::bytes
+/// [`chars`]: str::chars
+///
+/// # Deref
+///
+/// `String` implements <code>[Deref]<Target = [str]></code>, and so inherits all of [`str`]'s
+/// methods. In addition, this means that you can pass a `String` to a
+/// function which takes a [`&str`] by using an ampersand (`&`):
+///
+/// ```
+/// fn takes_str(s: &str) { }
+///
+/// let s = String::from("Hello");
+///
+/// takes_str(&s);
+/// ```
+///
+/// This will create a [`&str`] from the `String` and pass it in. This
+/// conversion is very inexpensive, and so generally, functions will accept
+/// [`&str`]s as arguments unless they need a `String` for some specific
+/// reason.
+///
+/// In certain cases Rust doesn't have enough information to make this
+/// conversion, known as [`Deref`] coercion. In the following example a string
+/// slice [`&'a str`][`&str`] implements the trait `TraitExample`, and the function
+/// `example_func` takes anything that implements the trait. In this case Rust
+/// would need to make two implicit conversions, which Rust doesn't have the
+/// means to do. For that reason, the following example will not compile.
+///
+/// ```compile_fail,E0277
+/// trait TraitExample {}
+///
+/// impl<'a> TraitExample for &'a str {}
+///
+/// fn example_func<A: TraitExample>(example_arg: A) {}
+///
+/// let example_string = String::from("example_string");
+/// example_func(&example_string);
+/// ```
+///
+/// There are two options that would work instead. The first would be to
+/// change the line `example_func(&example_string);` to
+/// `example_func(example_string.as_str());`, using the method [`as_str()`]
+/// to explicitly extract the string slice containing the string. The second
+/// way changes `example_func(&example_string);` to
+/// `example_func(&*example_string);`. In this case we are dereferencing a
+/// `String` to a [`str`], then referencing the [`str`] back to
+/// [`&str`]. The second way is more idiomatic, however both work to do the
+/// conversion explicitly rather than relying on the implicit conversion.
+///
+/// # Representation
+///
+/// A `String` is made up of three components: a pointer to some bytes, a
+/// length, and a capacity. The pointer points to an internal buffer `String`
+/// uses to store its data. The length is the number of bytes currently stored
+/// in the buffer, and the capacity is the size of the buffer in bytes. As such,
+/// the length will always be less than or equal to the capacity.
+///
+/// This buffer is always stored on the heap.
+///
+/// You can look at these with the [`as_ptr`], [`len`], and [`capacity`]
+/// methods:
+///
+/// ```
+/// use std::mem;
+///
+/// let story = String::from("Once upon a time...");
+///
+// FIXME Update this when vec_into_raw_parts is stabilized
+/// // Prevent automatically dropping the String's data
+/// let mut story = mem::ManuallyDrop::new(story);
+///
+/// let ptr = story.as_mut_ptr();
+/// let len = story.len();
+/// let capacity = story.capacity();
+///
+/// // story has nineteen bytes
+/// assert_eq!(19, len);
+///
+/// // We can re-build a String out of ptr, len, and capacity. This is all
+/// // unsafe because we are responsible for making sure the components are
+/// // valid:
+/// let s = unsafe { String::from_raw_parts(ptr, len, capacity) } ;
+///
+/// assert_eq!(String::from("Once upon a time..."), s);
+/// ```
+///
+/// [`as_ptr`]: str::as_ptr
+/// [`len`]: String::len
+/// [`capacity`]: String::capacity
+///
+/// If a `String` has enough capacity, adding elements to it will not
+/// re-allocate. For example, consider this program:
+///
+/// ```
+/// let mut s = String::new();
+///
+/// println!("{}", s.capacity());
+///
+/// for _ in 0..5 {
+///     s.push_str("hello");
+///     println!("{}", s.capacity());
+/// }
+/// ```
+///
+/// This will output the following:
+///
+/// ```text
+/// 0
+/// 5
+/// 10
+/// 20
+/// 20
+/// 40
+/// ```
+///
+/// At first, we have no memory allocated at all, but as we append to the
+/// string, it increases its capacity appropriately. If we instead use the
+/// [`with_capacity`] method to allocate the correct capacity initially:
+///
+/// ```
+/// let mut s = String::with_capacity(25);
+///
+/// println!("{}", s.capacity());
+///
+/// for _ in 0..5 {
+///     s.push_str("hello");
+///     println!("{}", s.capacity());
+/// }
+/// ```
+///
+/// [`with_capacity`]: String::with_capacity
+///
+/// We end up with a different output:
+///
+/// ```text
+/// 25
+/// 25
+/// 25
+/// 25
+/// 25
+/// 25
+/// ```
+///
+/// Here, there's no need to allocate more memory inside the loop.
+///
+/// [str]: prim@str "str"
+/// [`str`]: prim@str "str"
+/// [`&str`]: prim@str "&str"
+/// [Deref]: core::ops::Deref "ops::Deref"
+/// [`Deref`]: core::ops::Deref "ops::Deref"
+/// [`as_str()`]: String::as_str
+#[derive(PartialOrd, Eq, Ord)]
+#[cfg_attr(not(test), rustc_diagnostic_item = "String")]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub struct String {
+    vec: Vec<u8>,
+}
+
+/// A possible error value when converting a `String` from a UTF-8 byte vector.
+///
+/// This type is the error type for the [`from_utf8`] method on [`String`]. It
+/// is designed in such a way to carefully avoid reallocations: the
+/// [`into_bytes`] method will give back the byte vector that was used in the
+/// conversion attempt.
+///
+/// [`from_utf8`]: String::from_utf8
+/// [`into_bytes`]: FromUtf8Error::into_bytes
+///
+/// The [`Utf8Error`] type provided by [`std::str`] represents an error that may
+/// occur when converting a slice of [`u8`]s to a [`&str`]. In this sense, it's
+/// an analogue to `FromUtf8Error`, and you can get one from a `FromUtf8Error`
+/// through the [`utf8_error`] method.
+///
+/// [`Utf8Error`]: str::Utf8Error "std::str::Utf8Error"
+/// [`std::str`]: core::str "std::str"
+/// [`&str`]: prim@str "&str"
+/// [`utf8_error`]: FromUtf8Error::utf8_error
+///
+/// # Examples
+///
+/// Basic usage:
+///
+/// ```
+/// // some invalid bytes, in a vector
+/// let bytes = vec![0, 159];
+///
+/// let value = String::from_utf8(bytes);
+///
+/// assert!(value.is_err());
+/// assert_eq!(vec![0, 159], value.unwrap_err().into_bytes());
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(no_global_oom_handling), derive(Clone))]
+#[derive(Debug, PartialEq, Eq)]
+pub struct FromUtf8Error {
+    bytes: Vec<u8>,
+    error: Utf8Error,
+}
+
+/// A possible error value when converting a `String` from a UTF-16 byte slice.
+///
+/// This type is the error type for the [`from_utf16`] method on [`String`].
+///
+/// [`from_utf16`]: String::from_utf16
+/// # Examples
+///
+/// Basic usage:
+///
+/// ```
+/// // 𝄞mu<invalid>ic
+/// let v = &[0xD834, 0xDD1E, 0x006d, 0x0075,
+///           0xD800, 0x0069, 0x0063];
+///
+/// assert!(String::from_utf16(v).is_err());
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[derive(Debug)]
+pub struct FromUtf16Error(());
+
+impl String {
+    /// Creates a new empty `String`.
+    ///
+    /// Given that the `String` is empty, this will not allocate any initial
+    /// buffer. While that means that this initial operation is very
+    /// inexpensive, it may cause excessive allocation later when you add
+    /// data. If you have an idea of how much data the `String` will hold,
+    /// consider the [`with_capacity`] method to prevent excessive
+    /// re-allocation.
+    ///
+    /// [`with_capacity`]: String::with_capacity
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::new();
+    /// ```
+    #[inline]
+    #[rustc_const_stable(feature = "const_string_new", since = "1.39.0")]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub const fn new() -> String {
+        String { vec: Vec::new() }
+    }
+
+    /// Creates a new empty `String` with a particular capacity.
+    ///
+    /// `String`s have an internal buffer to hold their data. The capacity is
+    /// the length of that buffer, and can be queried with the [`capacity`]
+    /// method. This method creates an empty `String`, but one with an initial
+    /// buffer that can hold `capacity` bytes. This is useful when you may be
+    /// appending a bunch of data to the `String`, reducing the number of
+    /// reallocations it needs to do.
+    ///
+    /// [`capacity`]: String::capacity
+    ///
+    /// If the given capacity is `0`, no allocation will occur, and this method
+    /// is identical to the [`new`] method.
+    ///
+    /// [`new`]: String::new
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::with_capacity(10);
+    ///
+    /// // The String contains no chars, even though it has capacity for more
+    /// assert_eq!(s.len(), 0);
+    ///
+    /// // These are all done without reallocating...
+    /// let cap = s.capacity();
+    /// for _ in 0..10 {
+    ///     s.push('a');
+    /// }
+    ///
+    /// assert_eq!(s.capacity(), cap);
+    ///
+    /// // ...but this may make the string reallocate
+    /// s.push('a');
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub fn with_capacity(capacity: usize) -> String {
+        String { vec: Vec::with_capacity(capacity) }
+    }
+
+    // HACK(japaric): with cfg(test) the inherent `[T]::to_vec` method, which is
+    // required for this method definition, is not available. Since we don't
+    // require this method for testing purposes, I'll just stub it
+    // NB see the slice::hack module in slice.rs for more information
+    #[inline]
+    #[cfg(test)]
+    pub fn from_str(_: &str) -> String {
+        panic!("not available with cfg(test)");
+    }
+
+    /// Converts a vector of bytes to a `String`.
+    ///
+    /// A string ([`String`]) is made of bytes ([`u8`]), and a vector of bytes
+    /// ([`Vec<u8>`]) is made of bytes, so this function converts between the
+    /// two. Not all byte slices are valid `String`s, however: `String`
+    /// requires that it is valid UTF-8. `from_utf8()` checks to ensure that
+    /// the bytes are valid UTF-8, and then does the conversion.
+    ///
+    /// If you are sure that the byte slice is valid UTF-8, and you don't want
+    /// to incur the overhead of the validity check, there is an unsafe version
+    /// of this function, [`from_utf8_unchecked`], which has the same behavior
+    /// but skips the check.
+    ///
+    /// This method will take care to not copy the vector, for efficiency's
+    /// sake.
+    ///
+    /// If you need a [`&str`] instead of a `String`, consider
+    /// [`str::from_utf8`].
+    ///
+    /// The inverse of this method is [`into_bytes`].
+    ///
+    /// # Errors
+    ///
+    /// Returns [`Err`] if the slice is not UTF-8 with a description as to why the
+    /// provided bytes are not UTF-8. The vector you moved in is also included.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some bytes, in a vector
+    /// let sparkle_heart = vec![240, 159, 146, 150];
+    ///
+    /// // We know these bytes are valid, so we'll use `unwrap()`.
+    /// let sparkle_heart = String::from_utf8(sparkle_heart).unwrap();
+    ///
+    /// assert_eq!("💖", sparkle_heart);
+    /// ```
+    ///
+    /// Incorrect bytes:
+    ///
+    /// ```
+    /// // some invalid bytes, in a vector
+    /// let sparkle_heart = vec![0, 159, 146, 150];
+    ///
+    /// assert!(String::from_utf8(sparkle_heart).is_err());
+    /// ```
+    ///
+    /// See the docs for [`FromUtf8Error`] for more details on what you can do
+    /// with this error.
+    ///
+    /// [`from_utf8_unchecked`]: String::from_utf8_unchecked
+    /// [`Vec<u8>`]: crate::vec::Vec "Vec"
+    /// [`&str`]: prim@str "&str"
+    /// [`into_bytes`]: String::into_bytes
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn from_utf8(vec: Vec<u8>) -> Result<String, FromUtf8Error> {
+        match str::from_utf8(&vec) {
+            Ok(..) => Ok(String { vec }),
+            Err(e) => Err(FromUtf8Error { bytes: vec, error: e }),
+        }
+    }
+
+    /// Converts a slice of bytes to a string, including invalid characters.
+    ///
+    /// Strings are made of bytes ([`u8`]), and a slice of bytes
+    /// ([`&[u8]`][byteslice]) is made of bytes, so this function converts
+    /// between the two. Not all byte slices are valid strings, however: strings
+    /// are required to be valid UTF-8. During this conversion,
+    /// `from_utf8_lossy()` will replace any invalid UTF-8 sequences with
+    /// [`U+FFFD REPLACEMENT CHARACTER`][U+FFFD], which looks like this: �
+    ///
+    /// [byteslice]: prim@slice
+    /// [U+FFFD]: core::char::REPLACEMENT_CHARACTER
+    ///
+    /// If you are sure that the byte slice is valid UTF-8, and you don't want
+    /// to incur the overhead of the conversion, there is an unsafe version
+    /// of this function, [`from_utf8_unchecked`], which has the same behavior
+    /// but skips the checks.
+    ///
+    /// [`from_utf8_unchecked`]: String::from_utf8_unchecked
+    ///
+    /// This function returns a [`Cow<'a, str>`]. If our byte slice is invalid
+    /// UTF-8, then we need to insert the replacement characters, which will
+    /// change the size of the string, and hence, require a `String`. But if
+    /// it's already valid UTF-8, we don't need a new allocation. This return
+    /// type allows us to handle both cases.
+    ///
+    /// [`Cow<'a, str>`]: crate::borrow::Cow "borrow::Cow"
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some bytes, in a vector
+    /// let sparkle_heart = vec![240, 159, 146, 150];
+    ///
+    /// let sparkle_heart = String::from_utf8_lossy(&sparkle_heart);
+    ///
+    /// assert_eq!("💖", sparkle_heart);
+    /// ```
+    ///
+    /// Incorrect bytes:
+    ///
+    /// ```
+    /// // some invalid bytes
+    /// let input = b"Hello \xF0\x90\x80World";
+    /// let output = String::from_utf8_lossy(input);
+    ///
+    /// assert_eq!("Hello �World", output);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn from_utf8_lossy(v: &[u8]) -> Cow<'_, str> {
+        let mut iter = lossy::Utf8Lossy::from_bytes(v).chunks();
+
+        let (first_valid, first_broken) = if let Some(chunk) = iter.next() {
+            let lossy::Utf8LossyChunk { valid, broken } = chunk;
+            if valid.len() == v.len() {
+                debug_assert!(broken.is_empty());
+                return Cow::Borrowed(valid);
+            }
+            (valid, broken)
+        } else {
+            return Cow::Borrowed("");
+        };
+
+        const REPLACEMENT: &str = "\u{FFFD}";
+
+        let mut res = String::with_capacity(v.len());
+        res.push_str(first_valid);
+        if !first_broken.is_empty() {
+            res.push_str(REPLACEMENT);
+        }
+
+        for lossy::Utf8LossyChunk { valid, broken } in iter {
+            res.push_str(valid);
+            if !broken.is_empty() {
+                res.push_str(REPLACEMENT);
+            }
+        }
+
+        Cow::Owned(res)
+    }
+
+    /// Decode a UTF-16–encoded vector `v` into a `String`, returning [`Err`]
+    /// if `v` contains any invalid data.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // 𝄞music
+    /// let v = &[0xD834, 0xDD1E, 0x006d, 0x0075,
+    ///           0x0073, 0x0069, 0x0063];
+    /// assert_eq!(String::from("𝄞music"),
+    ///            String::from_utf16(v).unwrap());
+    ///
+    /// // 𝄞mu<invalid>ic
+    /// let v = &[0xD834, 0xDD1E, 0x006d, 0x0075,
+    ///           0xD800, 0x0069, 0x0063];
+    /// assert!(String::from_utf16(v).is_err());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn from_utf16(v: &[u16]) -> Result<String, FromUtf16Error> {
+        // This isn't done via collect::<Result<_, _>>() for performance reasons.
+        // FIXME: the function can be simplified again when #48994 is closed.
+        let mut ret = String::with_capacity(v.len());
+        for c in decode_utf16(v.iter().cloned()) {
+            if let Ok(c) = c {
+                ret.push(c);
+            } else {
+                return Err(FromUtf16Error(()));
+            }
+        }
+        Ok(ret)
+    }
+
+    /// Decode a UTF-16–encoded slice `v` into a `String`, replacing
+    /// invalid data with [the replacement character (`U+FFFD`)][U+FFFD].
+    ///
+    /// Unlike [`from_utf8_lossy`] which returns a [`Cow<'a, str>`],
+    /// `from_utf16_lossy` returns a `String` since the UTF-16 to UTF-8
+    /// conversion requires a memory allocation.
+    ///
+    /// [`from_utf8_lossy`]: String::from_utf8_lossy
+    /// [`Cow<'a, str>`]: crate::borrow::Cow "borrow::Cow"
+    /// [U+FFFD]: core::char::REPLACEMENT_CHARACTER
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // 𝄞mus<invalid>ic<invalid>
+    /// let v = &[0xD834, 0xDD1E, 0x006d, 0x0075,
+    ///           0x0073, 0xDD1E, 0x0069, 0x0063,
+    ///           0xD834];
+    ///
+    /// assert_eq!(String::from("𝄞mus\u{FFFD}ic\u{FFFD}"),
+    ///            String::from_utf16_lossy(v));
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn from_utf16_lossy(v: &[u16]) -> String {
+        decode_utf16(v.iter().cloned()).map(|r| r.unwrap_or(REPLACEMENT_CHARACTER)).collect()
+    }
+
+    /// Decomposes a `String` into its raw components.
+    ///
+    /// Returns the raw pointer to the underlying data, the length of
+    /// the string (in bytes), and the allocated capacity of the data
+    /// (in bytes). These are the same arguments in the same order as
+    /// the arguments to [`from_raw_parts`].
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `String`. The only way to do
+    /// this is to convert the raw pointer, length, and capacity back
+    /// into a `String` with the [`from_raw_parts`] function, allowing
+    /// the destructor to perform the cleanup.
+    ///
+    /// [`from_raw_parts`]: String::from_raw_parts
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_into_raw_parts)]
+    /// let s = String::from("hello");
+    ///
+    /// let (ptr, len, cap) = s.into_raw_parts();
+    ///
+    /// let rebuilt = unsafe { String::from_raw_parts(ptr, len, cap) };
+    /// assert_eq!(rebuilt, "hello");
+    /// ```
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[unstable(feature = "vec_into_raw_parts", reason = "new API", issue = "65816")]
+    pub fn into_raw_parts(self) -> (*mut u8, usize, usize) {
+        self.vec.into_raw_parts()
+    }
+
+    /// Creates a new `String` from a length, capacity, and pointer.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren't
+    /// checked:
+    ///
+    /// * The memory at `buf` needs to have been previously allocated by the
+    ///   same allocator the standard library uses, with a required alignment of exactly 1.
+    /// * `length` needs to be less than or equal to `capacity`.
+    /// * `capacity` needs to be the correct value.
+    /// * The first `length` bytes at `buf` need to be valid UTF-8.
+    ///
+    /// Violating these may cause problems like corrupting the allocator's
+    /// internal data structures.
+    ///
+    /// The ownership of `buf` is effectively transferred to the
+    /// `String` which may then deallocate, reallocate or change the
+    /// contents of memory pointed to by the pointer at will. Ensure
+    /// that nothing else uses the pointer after calling this
+    /// function.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// use std::mem;
+    ///
+    /// unsafe {
+    ///     let s = String::from("hello");
+    ///
+    // FIXME Update this when vec_into_raw_parts is stabilized
+    ///     // Prevent automatically dropping the String's data
+    ///     let mut s = mem::ManuallyDrop::new(s);
+    ///
+    ///     let ptr = s.as_mut_ptr();
+    ///     let len = s.len();
+    ///     let capacity = s.capacity();
+    ///
+    ///     let s = String::from_raw_parts(ptr, len, capacity);
+    ///
+    ///     assert_eq!(String::from("hello"), s);
+    /// }
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn from_raw_parts(buf: *mut u8, length: usize, capacity: usize) -> String {
+        unsafe { String { vec: Vec::from_raw_parts(buf, length, capacity) } }
+    }
+
+    /// Converts a vector of bytes to a `String` without checking that the
+    /// string contains valid UTF-8.
+    ///
+    /// See the safe version, [`from_utf8`], for more details.
+    ///
+    /// [`from_utf8`]: String::from_utf8
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because it does not check that the bytes passed
+    /// to it are valid UTF-8. If this constraint is violated, it may cause
+    /// memory unsafety issues with future users of the `String`, as the rest of
+    /// the standard library assumes that `String`s are valid UTF-8.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some bytes, in a vector
+    /// let sparkle_heart = vec![240, 159, 146, 150];
+    ///
+    /// let sparkle_heart = unsafe {
+    ///     String::from_utf8_unchecked(sparkle_heart)
+    /// };
+    ///
+    /// assert_eq!("💖", sparkle_heart);
+    /// ```
+    #[inline]
+    #[must_use]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn from_utf8_unchecked(bytes: Vec<u8>) -> String {
+        String { vec: bytes }
+    }
+
+    /// Converts a `String` into a byte vector.
+    ///
+    /// This consumes the `String`, so we do not need to copy its contents.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::from("hello");
+    /// let bytes = s.into_bytes();
+    ///
+    /// assert_eq!(&[104, 101, 108, 108, 111][..], &bytes[..]);
+    /// ```
+    #[inline]
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_bytes(self) -> Vec<u8> {
+        self.vec
+    }
+
+    /// Extracts a string slice containing the entire `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::from("foo");
+    ///
+    /// assert_eq!("foo", s.as_str());
+    /// ```
+    #[inline]
+    #[must_use]
+    #[stable(feature = "string_as_str", since = "1.7.0")]
+    pub fn as_str(&self) -> &str {
+        self
+    }
+
+    /// Converts a `String` into a mutable string slice.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foobar");
+    /// let s_mut_str = s.as_mut_str();
+    ///
+    /// s_mut_str.make_ascii_uppercase();
+    ///
+    /// assert_eq!("FOOBAR", s_mut_str);
+    /// ```
+    #[inline]
+    #[must_use]
+    #[stable(feature = "string_as_str", since = "1.7.0")]
+    pub fn as_mut_str(&mut self) -> &mut str {
+        self
+    }
+
+    /// Appends a given string slice onto the end of this `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// s.push_str("bar");
+    ///
+    /// assert_eq!("foobar", s);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn push_str(&mut self, string: &str) {
+        self.vec.extend_from_slice(string.as_bytes())
+    }
+
+    /// Copies elements from `src` range to the end of the string.
+    ///
+    /// ## Panics
+    ///
+    /// Panics if the starting point or end point do not lie on a [`char`]
+    /// boundary, or if they're out of bounds.
+    ///
+    /// ## Examples
+    ///
+    /// ```
+    /// #![feature(string_extend_from_within)]
+    /// let mut string = String::from("abcde");
+    ///
+    /// string.extend_from_within(2..);
+    /// assert_eq!(string, "abcdecde");
+    ///
+    /// string.extend_from_within(..2);
+    /// assert_eq!(string, "abcdecdeab");
+    ///
+    /// string.extend_from_within(4..8);
+    /// assert_eq!(string, "abcdecdeabecde");
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "string_extend_from_within", issue = "none")]
+    pub fn extend_from_within<R>(&mut self, src: R)
+    where
+        R: RangeBounds<usize>,
+    {
+        let src @ Range { start, end } = slice::range(src, ..self.len());
+
+        assert!(self.is_char_boundary(start));
+        assert!(self.is_char_boundary(end));
+
+        self.vec.extend_from_within(src);
+    }
+
+    /// Returns this `String`'s capacity, in bytes.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::with_capacity(10);
+    ///
+    /// assert!(s.capacity() >= 10);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn capacity(&self) -> usize {
+        self.vec.capacity()
+    }
+
+    /// Ensures that this `String`'s capacity is at least `additional` bytes
+    /// larger than its length.
+    ///
+    /// The capacity may be increased by more than `additional` bytes if it
+    /// chooses, to prevent frequent reallocations.
+    ///
+    /// If you do not want this "at least" behavior, see the [`reserve_exact`]
+    /// method.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity overflows [`usize`].
+    ///
+    /// [`reserve_exact`]: String::reserve_exact
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::new();
+    ///
+    /// s.reserve(10);
+    ///
+    /// assert!(s.capacity() >= 10);
+    /// ```
+    ///
+    /// This might not actually increase the capacity:
+    ///
+    /// ```
+    /// let mut s = String::with_capacity(10);
+    /// s.push('a');
+    /// s.push('b');
+    ///
+    /// // s now has a length of 2 and a capacity of 10
+    /// assert_eq!(2, s.len());
+    /// assert_eq!(10, s.capacity());
+    ///
+    /// // Since we already have an extra 8 capacity, calling this...
+    /// s.reserve(8);
+    ///
+    /// // ... doesn't actually increase.
+    /// assert_eq!(10, s.capacity());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve(&mut self, additional: usize) {
+        self.vec.reserve(additional)
+    }
+
+    /// Ensures that this `String`'s capacity is `additional` bytes
+    /// larger than its length.
+    ///
+    /// Consider using the [`reserve`] method unless you absolutely know
+    /// better than the allocator.
+    ///
+    /// [`reserve`]: String::reserve
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity overflows `usize`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::new();
+    ///
+    /// s.reserve_exact(10);
+    ///
+    /// assert!(s.capacity() >= 10);
+    /// ```
+    ///
+    /// This might not actually increase the capacity:
+    ///
+    /// ```
+    /// let mut s = String::with_capacity(10);
+    /// s.push('a');
+    /// s.push('b');
+    ///
+    /// // s now has a length of 2 and a capacity of 10
+    /// assert_eq!(2, s.len());
+    /// assert_eq!(10, s.capacity());
+    ///
+    /// // Since we already have an extra 8 capacity, calling this...
+    /// s.reserve_exact(8);
+    ///
+    /// // ... doesn't actually increase.
+    /// assert_eq!(10, s.capacity());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve_exact(&mut self, additional: usize) {
+        self.vec.reserve_exact(additional)
+    }
+
+    /// Tries to reserve capacity for at least `additional` more elements to be inserted
+    /// in the given `String`. The collection may reserve more space to avoid
+    /// frequent reallocations. After calling `reserve`, capacity will be
+    /// greater than or equal to `self.len() + additional`. Does nothing if
+    /// capacity is already sufficient.
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &str) -> Result<String, TryReserveError> {
+    ///     let mut output = String::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.push_str(data);
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data("rust").expect("why is the test harness OOMing on 4 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.vec.try_reserve(additional)
+    }
+
+    /// Tries to reserve the minimum capacity for exactly `additional` more elements to
+    /// be inserted in the given `String`. After calling `reserve_exact`,
+    /// capacity will be greater than or equal to `self.len() + additional`.
+    /// Does nothing if the capacity is already sufficient.
+    ///
+    /// Note that the allocator may give the collection more space than it
+    /// requests. Therefore, capacity can not be relied upon to be precisely
+    /// minimal. Prefer [`reserve`] if future insertions are expected.
+    ///
+    /// [`reserve`]: String::reserve
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &str) -> Result<String, TryReserveError> {
+    ///     let mut output = String::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.push_str(data);
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data("rust").expect("why is the test harness OOMing on 4 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve_exact(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.vec.try_reserve_exact(additional)
+    }
+
+    /// Shrinks the capacity of this `String` to match its length.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// s.reserve(100);
+    /// assert!(s.capacity() >= 100);
+    ///
+    /// s.shrink_to_fit();
+    /// assert_eq!(3, s.capacity());
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn shrink_to_fit(&mut self) {
+        self.vec.shrink_to_fit()
+    }
+
+    /// Shrinks the capacity of this `String` with a lower bound.
+    ///
+    /// The capacity will remain at least as large as both the length
+    /// and the supplied value.
+    ///
+    /// If the current capacity is less than the lower limit, this is a no-op.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// s.reserve(100);
+    /// assert!(s.capacity() >= 100);
+    ///
+    /// s.shrink_to(10);
+    /// assert!(s.capacity() >= 10);
+    /// s.shrink_to(0);
+    /// assert!(s.capacity() >= 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "shrink_to", since = "1.56.0")]
+    pub fn shrink_to(&mut self, min_capacity: usize) {
+        self.vec.shrink_to(min_capacity)
+    }
+
+    /// Appends the given [`char`] to the end of this `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("abc");
+    ///
+    /// s.push('1');
+    /// s.push('2');
+    /// s.push('3');
+    ///
+    /// assert_eq!("abc123", s);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn push(&mut self, ch: char) {
+        match ch.len_utf8() {
+            1 => self.vec.push(ch as u8),
+            _ => self.vec.extend_from_slice(ch.encode_utf8(&mut [0; 4]).as_bytes()),
+        }
+    }
+
+    /// Returns a byte slice of this `String`'s contents.
+    ///
+    /// The inverse of this method is [`from_utf8`].
+    ///
+    /// [`from_utf8`]: String::from_utf8
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::from("hello");
+    ///
+    /// assert_eq!(&[104, 101, 108, 108, 111], s.as_bytes());
+    /// ```
+    #[inline]
+    #[must_use]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.vec
+    }
+
+    /// Shortens this `String` to the specified length.
+    ///
+    /// If `new_len` is greater than the string's current length, this has no
+    /// effect.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the string
+    ///
+    /// # Panics
+    ///
+    /// Panics if `new_len` does not lie on a [`char`] boundary.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("hello");
+    ///
+    /// s.truncate(2);
+    ///
+    /// assert_eq!("he", s);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn truncate(&mut self, new_len: usize) {
+        if new_len <= self.len() {
+            assert!(self.is_char_boundary(new_len));
+            self.vec.truncate(new_len)
+        }
+    }
+
+    /// Removes the last character from the string buffer and returns it.
+    ///
+    /// Returns [`None`] if this `String` is empty.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// assert_eq!(s.pop(), Some('o'));
+    /// assert_eq!(s.pop(), Some('o'));
+    /// assert_eq!(s.pop(), Some('f'));
+    ///
+    /// assert_eq!(s.pop(), None);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn pop(&mut self) -> Option<char> {
+        let ch = self.chars().rev().next()?;
+        let newlen = self.len() - ch.len_utf8();
+        unsafe {
+            self.vec.set_len(newlen);
+        }
+        Some(ch)
+    }
+
+    /// Removes a [`char`] from this `String` at a byte position and returns it.
+    ///
+    /// This is an *O*(*n*) operation, as it requires copying every element in the
+    /// buffer.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `idx` is larger than or equal to the `String`'s length,
+    /// or if it does not lie on a [`char`] boundary.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// assert_eq!(s.remove(0), 'f');
+    /// assert_eq!(s.remove(1), 'o');
+    /// assert_eq!(s.remove(0), 'o');
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn remove(&mut self, idx: usize) -> char {
+        let ch = match self[idx..].chars().next() {
+            Some(ch) => ch,
+            None => panic!("cannot remove a char from the end of a string"),
+        };
+
+        let next = idx + ch.len_utf8();
+        let len = self.len();
+        unsafe {
+            ptr::copy(self.vec.as_ptr().add(next), self.vec.as_mut_ptr().add(idx), len - next);
+            self.vec.set_len(len - (next - idx));
+        }
+        ch
+    }
+
+    /// Remove all matches of pattern `pat` in the `String`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(string_remove_matches)]
+    /// let mut s = String::from("Trees are not green, the sky is not blue.");
+    /// s.remove_matches("not ");
+    /// assert_eq!("Trees are green, the sky is blue.", s);
+    /// ```
+    ///
+    /// Matches will be detected and removed iteratively, so in cases where
+    /// patterns overlap, only the first pattern will be removed:
+    ///
+    /// ```
+    /// #![feature(string_remove_matches)]
+    /// let mut s = String::from("banana");
+    /// s.remove_matches("ana");
+    /// assert_eq!("bna", s);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "string_remove_matches", reason = "new API", issue = "72826")]
+    pub fn remove_matches<'a, P>(&'a mut self, pat: P)
+    where
+        P: for<'x> Pattern<'x>,
+    {
+        use core::str::pattern::Searcher;
+
+        let rejections = {
+            let mut searcher = pat.into_searcher(self);
+            // Per Searcher::next:
+            //
+            // A Match result needs to contain the whole matched pattern,
+            // however Reject results may be split up into arbitrary many
+            // adjacent fragments. Both ranges may have zero length.
+            //
+            // In practice the implementation of Searcher::next_match tends to
+            // be more efficient, so we use it here and do some work to invert
+            // matches into rejections since that's what we want to copy below.
+            let mut front = 0;
+            let rejections: Vec<_> = from_fn(|| {
+                let (start, end) = searcher.next_match()?;
+                let prev_front = front;
+                front = end;
+                Some((prev_front, start))
+            })
+            .collect();
+            rejections.into_iter().chain(core::iter::once((front, self.len())))
+        };
+
+        let mut len = 0;
+        let ptr = self.vec.as_mut_ptr();
+
+        for (start, end) in rejections {
+            let count = end - start;
+            if start != len {
+                // SAFETY: per Searcher::next:
+                //
+                // The stream of Match and Reject values up to a Done will
+                // contain index ranges that are adjacent, non-overlapping,
+                // covering the whole haystack, and laying on utf8
+                // boundaries.
+                unsafe {
+                    ptr::copy(ptr.add(start), ptr.add(len), count);
+                }
+            }
+            len += count;
+        }
+
+        unsafe {
+            self.vec.set_len(len);
+        }
+    }
+
+    /// Retains only the characters specified by the predicate.
+    ///
+    /// In other words, remove all characters `c` such that `f(c)` returns `false`.
+    /// This method operates in place, visiting each character exactly once in the
+    /// original order, and preserves the order of the retained characters.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut s = String::from("f_o_ob_ar");
+    ///
+    /// s.retain(|c| c != '_');
+    ///
+    /// assert_eq!(s, "foobar");
+    /// ```
+    ///
+    /// Because the elements are visited exactly once in the original order,
+    /// external state may be used to decide which elements to keep.
+    ///
+    /// ```
+    /// let mut s = String::from("abcde");
+    /// let keep = [false, true, true, false, true];
+    /// let mut iter = keep.iter();
+    /// s.retain(|_| *iter.next().unwrap());
+    /// assert_eq!(s, "bce");
+    /// ```
+    #[inline]
+    #[stable(feature = "string_retain", since = "1.26.0")]
+    pub fn retain<F>(&mut self, mut f: F)
+    where
+        F: FnMut(char) -> bool,
+    {
+        struct SetLenOnDrop<'a> {
+            s: &'a mut String,
+            idx: usize,
+            del_bytes: usize,
+        }
+
+        impl<'a> Drop for SetLenOnDrop<'a> {
+            fn drop(&mut self) {
+                let new_len = self.idx - self.del_bytes;
+                debug_assert!(new_len <= self.s.len());
+                unsafe { self.s.vec.set_len(new_len) };
+            }
+        }
+
+        let len = self.len();
+        let mut guard = SetLenOnDrop { s: self, idx: 0, del_bytes: 0 };
+
+        while guard.idx < len {
+            let ch = unsafe { guard.s.get_unchecked(guard.idx..len).chars().next().unwrap() };
+            let ch_len = ch.len_utf8();
+
+            if !f(ch) {
+                guard.del_bytes += ch_len;
+            } else if guard.del_bytes > 0 {
+                unsafe {
+                    ptr::copy(
+                        guard.s.vec.as_ptr().add(guard.idx),
+                        guard.s.vec.as_mut_ptr().add(guard.idx - guard.del_bytes),
+                        ch_len,
+                    );
+                }
+            }
+
+            // Point idx to the next char
+            guard.idx += ch_len;
+        }
+
+        drop(guard);
+    }
+
+    /// Inserts a character into this `String` at a byte position.
+    ///
+    /// This is an *O*(*n*) operation as it requires copying every element in the
+    /// buffer.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `idx` is larger than the `String`'s length, or if it does not
+    /// lie on a [`char`] boundary.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::with_capacity(3);
+    ///
+    /// s.insert(0, 'f');
+    /// s.insert(1, 'o');
+    /// s.insert(2, 'o');
+    ///
+    /// assert_eq!("foo", s);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn insert(&mut self, idx: usize, ch: char) {
+        assert!(self.is_char_boundary(idx));
+        let mut bits = [0; 4];
+        let bits = ch.encode_utf8(&mut bits).as_bytes();
+
+        unsafe {
+            self.insert_bytes(idx, bits);
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    unsafe fn insert_bytes(&mut self, idx: usize, bytes: &[u8]) {
+        let len = self.len();
+        let amt = bytes.len();
+        self.vec.reserve(amt);
+
+        unsafe {
+            ptr::copy(self.vec.as_ptr().add(idx), self.vec.as_mut_ptr().add(idx + amt), len - idx);
+            ptr::copy_nonoverlapping(bytes.as_ptr(), self.vec.as_mut_ptr().add(idx), amt);
+            self.vec.set_len(len + amt);
+        }
+    }
+
+    /// Inserts a string slice into this `String` at a byte position.
+    ///
+    /// This is an *O*(*n*) operation as it requires copying every element in the
+    /// buffer.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `idx` is larger than the `String`'s length, or if it does not
+    /// lie on a [`char`] boundary.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("bar");
+    ///
+    /// s.insert_str(0, "foo");
+    ///
+    /// assert_eq!("foobar", s);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "insert_str", since = "1.16.0")]
+    pub fn insert_str(&mut self, idx: usize, string: &str) {
+        assert!(self.is_char_boundary(idx));
+
+        unsafe {
+            self.insert_bytes(idx, string.as_bytes());
+        }
+    }
+
+    /// Returns a mutable reference to the contents of this `String`.
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because it does not check that the bytes passed
+    /// to it are valid UTF-8. If this constraint is violated, it may cause
+    /// memory unsafety issues with future users of the `String`, as the rest of
+    /// the standard library assumes that `String`s are valid UTF-8.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("hello");
+    ///
+    /// unsafe {
+    ///     let vec = s.as_mut_vec();
+    ///     assert_eq!(&[104, 101, 108, 108, 111][..], &vec[..]);
+    ///
+    ///     vec.reverse();
+    /// }
+    /// assert_eq!(s, "olleh");
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn as_mut_vec(&mut self) -> &mut Vec<u8> {
+        &mut self.vec
+    }
+
+    /// Returns the length of this `String`, in bytes, not [`char`]s or
+    /// graphemes. In other words, it might not be what a human considers the
+    /// length of the string.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let a = String::from("foo");
+    /// assert_eq!(a.len(), 3);
+    ///
+    /// let fancy_f = String::from("ƒoo");
+    /// assert_eq!(fancy_f.len(), 4);
+    /// assert_eq!(fancy_f.chars().count(), 3);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn len(&self) -> usize {
+        self.vec.len()
+    }
+
+    /// Returns `true` if this `String` has a length of zero, and `false` otherwise.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut v = String::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push('a');
+    /// assert!(!v.is_empty());
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Splits the string into two at the given byte index.
+    ///
+    /// Returns a newly allocated `String`. `self` contains bytes `[0, at)`, and
+    /// the returned `String` contains bytes `[at, len)`. `at` must be on the
+    /// boundary of a UTF-8 code point.
+    ///
+    /// Note that the capacity of `self` does not change.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `at` is not on a `UTF-8` code point boundary, or if it is beyond the last
+    /// code point of the string.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # fn main() {
+    /// let mut hello = String::from("Hello, World!");
+    /// let world = hello.split_off(7);
+    /// assert_eq!(hello, "Hello, ");
+    /// assert_eq!(world, "World!");
+    /// # }
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "string_split_off", since = "1.16.0")]
+    #[must_use = "use `.truncate()` if you don't need the other half"]
+    pub fn split_off(&mut self, at: usize) -> String {
+        assert!(self.is_char_boundary(at));
+        let other = self.vec.split_off(at);
+        unsafe { String::from_utf8_unchecked(other) }
+    }
+
+    /// Truncates this `String`, removing all contents.
+    ///
+    /// While this means the `String` will have a length of zero, it does not
+    /// touch its capacity.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("foo");
+    ///
+    /// s.clear();
+    ///
+    /// assert!(s.is_empty());
+    /// assert_eq!(0, s.len());
+    /// assert_eq!(3, s.capacity());
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn clear(&mut self) {
+        self.vec.clear()
+    }
+
+    /// Creates a draining iterator that removes the specified range in the `String`
+    /// and yields the removed `chars`.
+    ///
+    /// Note: The element range is removed even if the iterator is not
+    /// consumed until the end.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point or end point do not lie on a [`char`]
+    /// boundary, or if they're out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("α is alpha, β is beta");
+    /// let beta_offset = s.find('β').unwrap_or(s.len());
+    ///
+    /// // Remove the range up until the β from the string
+    /// let t: String = s.drain(..beta_offset).collect();
+    /// assert_eq!(t, "α is alpha, ");
+    /// assert_eq!(s, "β is beta");
+    ///
+    /// // A full range clears the string
+    /// s.drain(..);
+    /// assert_eq!(s, "");
+    /// ```
+    #[stable(feature = "drain", since = "1.6.0")]
+    pub fn drain<R>(&mut self, range: R) -> Drain<'_>
+    where
+        R: RangeBounds<usize>,
+    {
+        // Memory safety
+        //
+        // The String version of Drain does not have the memory safety issues
+        // of the vector version. The data is just plain bytes.
+        // Because the range removal happens in Drop, if the Drain iterator is leaked,
+        // the removal will not happen.
+        let Range { start, end } = slice::range(range, ..self.len());
+        assert!(self.is_char_boundary(start));
+        assert!(self.is_char_boundary(end));
+
+        // Take out two simultaneous borrows. The &mut String won't be accessed
+        // until iteration is over, in Drop.
+        let self_ptr = self as *mut _;
+        // SAFETY: `slice::range` and `is_char_boundary` do the appropriate bounds checks.
+        let chars_iter = unsafe { self.get_unchecked(start..end) }.chars();
+
+        Drain { start, end, iter: chars_iter, string: self_ptr }
+    }
+
+    /// Removes the specified range in the string,
+    /// and replaces it with the given string.
+    /// The given string doesn't need to be the same length as the range.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point or end point do not lie on a [`char`]
+    /// boundary, or if they're out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let mut s = String::from("α is alpha, β is beta");
+    /// let beta_offset = s.find('β').unwrap_or(s.len());
+    ///
+    /// // Replace the range up until the β from the string
+    /// s.replace_range(..beta_offset, "Α is capital alpha; ");
+    /// assert_eq!(s, "Α is capital alpha; β is beta");
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "splice", since = "1.27.0")]
+    pub fn replace_range<R>(&mut self, range: R, replace_with: &str)
+    where
+        R: RangeBounds<usize>,
+    {
+        // Memory safety
+        //
+        // Replace_range does not have the memory safety issues of a vector Splice.
+        // of the vector version. The data is just plain bytes.
+
+        // WARNING: Inlining this variable would be unsound (#81138)
+        let start = range.start_bound();
+        match start {
+            Included(&n) => assert!(self.is_char_boundary(n)),
+            Excluded(&n) => assert!(self.is_char_boundary(n + 1)),
+            Unbounded => {}
+        };
+        // WARNING: Inlining this variable would be unsound (#81138)
+        let end = range.end_bound();
+        match end {
+            Included(&n) => assert!(self.is_char_boundary(n + 1)),
+            Excluded(&n) => assert!(self.is_char_boundary(n)),
+            Unbounded => {}
+        };
+
+        // Using `range` again would be unsound (#81138)
+        // We assume the bounds reported by `range` remain the same, but
+        // an adversarial implementation could change between calls
+        unsafe { self.as_mut_vec() }.splice((start, end), replace_with.bytes());
+    }
+
+    /// Converts this `String` into a <code>[Box]<[str]></code>.
+    ///
+    /// This will drop any excess capacity.
+    ///
+    /// [str]: prim@str "str"
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s = String::from("hello");
+    ///
+    /// let b = s.into_boxed_str();
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "box_str", since = "1.4.0")]
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[inline]
+    pub fn into_boxed_str(self) -> Box<str> {
+        let slice = self.vec.into_boxed_slice();
+        unsafe { from_boxed_utf8_unchecked(slice) }
+    }
+}
+
+impl FromUtf8Error {
+    /// Returns a slice of [`u8`]s bytes that were attempted to convert to a `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some invalid bytes, in a vector
+    /// let bytes = vec![0, 159];
+    ///
+    /// let value = String::from_utf8(bytes);
+    ///
+    /// assert_eq!(&[0, 159], value.unwrap_err().as_bytes());
+    /// ```
+    #[must_use]
+    #[stable(feature = "from_utf8_error_as_bytes", since = "1.26.0")]
+    pub fn as_bytes(&self) -> &[u8] {
+        &self.bytes[..]
+    }
+
+    /// Returns the bytes that were attempted to convert to a `String`.
+    ///
+    /// This method is carefully constructed to avoid allocation. It will
+    /// consume the error, moving out the bytes, so that a copy of the bytes
+    /// does not need to be made.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some invalid bytes, in a vector
+    /// let bytes = vec![0, 159];
+    ///
+    /// let value = String::from_utf8(bytes);
+    ///
+    /// assert_eq!(vec![0, 159], value.unwrap_err().into_bytes());
+    /// ```
+    #[must_use = "`self` will be dropped if the result is not used"]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_bytes(self) -> Vec<u8> {
+        self.bytes
+    }
+
+    /// Fetch a `Utf8Error` to get more details about the conversion failure.
+    ///
+    /// The [`Utf8Error`] type provided by [`std::str`] represents an error that may
+    /// occur when converting a slice of [`u8`]s to a [`&str`]. In this sense, it's
+    /// an analogue to `FromUtf8Error`. See its documentation for more details
+    /// on using it.
+    ///
+    /// [`std::str`]: core::str "std::str"
+    /// [`&str`]: prim@str "&str"
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// // some invalid bytes, in a vector
+    /// let bytes = vec![0, 159];
+    ///
+    /// let error = String::from_utf8(bytes).unwrap_err().utf8_error();
+    ///
+    /// // the first byte is invalid here
+    /// assert_eq!(1, error.valid_up_to());
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn utf8_error(&self) -> Utf8Error {
+        self.error
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl fmt::Display for FromUtf8Error {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(&self.error, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl fmt::Display for FromUtf16Error {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt("invalid utf-16: lone surrogate found", f)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl Clone for String {
+    fn clone(&self) -> Self {
+        String { vec: self.vec.clone() }
+    }
+
+    fn clone_from(&mut self, source: &Self) {
+        self.vec.clone_from(&source.vec);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl FromIterator<char> for String {
+    fn from_iter<I: IntoIterator<Item = char>>(iter: I) -> String {
+        let mut buf = String::new();
+        buf.extend(iter);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "string_from_iter_by_ref", since = "1.17.0")]
+impl<'a> FromIterator<&'a char> for String {
+    fn from_iter<I: IntoIterator<Item = &'a char>>(iter: I) -> String {
+        let mut buf = String::new();
+        buf.extend(iter);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a> FromIterator<&'a str> for String {
+    fn from_iter<I: IntoIterator<Item = &'a str>>(iter: I) -> String {
+        let mut buf = String::new();
+        buf.extend(iter);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "extend_string", since = "1.4.0")]
+impl FromIterator<String> for String {
+    fn from_iter<I: IntoIterator<Item = String>>(iter: I) -> String {
+        let mut iterator = iter.into_iter();
+
+        // Because we're iterating over `String`s, we can avoid at least
+        // one allocation by getting the first string from the iterator
+        // and appending to it all the subsequent strings.
+        match iterator.next() {
+            None => String::new(),
+            Some(mut buf) => {
+                buf.extend(iterator);
+                buf
+            }
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_str2", since = "1.45.0")]
+impl FromIterator<Box<str>> for String {
+    fn from_iter<I: IntoIterator<Item = Box<str>>>(iter: I) -> String {
+        let mut buf = String::new();
+        buf.extend(iter);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "herd_cows", since = "1.19.0")]
+impl<'a> FromIterator<Cow<'a, str>> for String {
+    fn from_iter<I: IntoIterator<Item = Cow<'a, str>>>(iter: I) -> String {
+        let mut iterator = iter.into_iter();
+
+        // Because we're iterating over CoWs, we can (potentially) avoid at least
+        // one allocation by getting the first item and appending to it all the
+        // subsequent items.
+        match iterator.next() {
+            None => String::new(),
+            Some(cow) => {
+                let mut buf = cow.into_owned();
+                buf.extend(iterator);
+                buf
+            }
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl Extend<char> for String {
+    fn extend<I: IntoIterator<Item = char>>(&mut self, iter: I) {
+        let iterator = iter.into_iter();
+        let (lower_bound, _) = iterator.size_hint();
+        self.reserve(lower_bound);
+        iterator.for_each(move |c| self.push(c));
+    }
+
+    #[inline]
+    fn extend_one(&mut self, c: char) {
+        self.push(c);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "extend_ref", since = "1.2.0")]
+impl<'a> Extend<&'a char> for String {
+    fn extend<I: IntoIterator<Item = &'a char>>(&mut self, iter: I) {
+        self.extend(iter.into_iter().cloned());
+    }
+
+    #[inline]
+    fn extend_one(&mut self, &c: &'a char) {
+        self.push(c);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a> Extend<&'a str> for String {
+    fn extend<I: IntoIterator<Item = &'a str>>(&mut self, iter: I) {
+        iter.into_iter().for_each(move |s| self.push_str(s));
+    }
+
+    #[inline]
+    fn extend_one(&mut self, s: &'a str) {
+        self.push_str(s);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_str2", since = "1.45.0")]
+impl Extend<Box<str>> for String {
+    fn extend<I: IntoIterator<Item = Box<str>>>(&mut self, iter: I) {
+        iter.into_iter().for_each(move |s| self.push_str(&s));
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "extend_string", since = "1.4.0")]
+impl Extend<String> for String {
+    fn extend<I: IntoIterator<Item = String>>(&mut self, iter: I) {
+        iter.into_iter().for_each(move |s| self.push_str(&s));
+    }
+
+    #[inline]
+    fn extend_one(&mut self, s: String) {
+        self.push_str(&s);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "herd_cows", since = "1.19.0")]
+impl<'a> Extend<Cow<'a, str>> for String {
+    fn extend<I: IntoIterator<Item = Cow<'a, str>>>(&mut self, iter: I) {
+        iter.into_iter().for_each(move |s| self.push_str(&s));
+    }
+
+    #[inline]
+    fn extend_one(&mut self, s: Cow<'a, str>) {
+        self.push_str(&s);
+    }
+}
+
+/// A convenience impl that delegates to the impl for `&str`.
+///
+/// # Examples
+///
+/// ```
+/// assert_eq!(String::from("Hello world").find("world"), Some(6));
+/// ```
+#[unstable(
+    feature = "pattern",
+    reason = "API not fully fleshed out and ready to be stabilized",
+    issue = "27721"
+)]
+impl<'a, 'b> Pattern<'a> for &'b String {
+    type Searcher = <&'b str as Pattern<'a>>::Searcher;
+
+    fn into_searcher(self, haystack: &'a str) -> <&'b str as Pattern<'a>>::Searcher {
+        self[..].into_searcher(haystack)
+    }
+
+    #[inline]
+    fn is_contained_in(self, haystack: &'a str) -> bool {
+        self[..].is_contained_in(haystack)
+    }
+
+    #[inline]
+    fn is_prefix_of(self, haystack: &'a str) -> bool {
+        self[..].is_prefix_of(haystack)
+    }
+
+    #[inline]
+    fn strip_prefix_of(self, haystack: &'a str) -> Option<&'a str> {
+        self[..].strip_prefix_of(haystack)
+    }
+
+    #[inline]
+    fn is_suffix_of(self, haystack: &'a str) -> bool {
+        self[..].is_suffix_of(haystack)
+    }
+
+    #[inline]
+    fn strip_suffix_of(self, haystack: &'a str) -> Option<&'a str> {
+        self[..].strip_suffix_of(haystack)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl PartialEq for String {
+    #[inline]
+    fn eq(&self, other: &String) -> bool {
+        PartialEq::eq(&self[..], &other[..])
+    }
+    #[inline]
+    fn ne(&self, other: &String) -> bool {
+        PartialEq::ne(&self[..], &other[..])
+    }
+}
+
+macro_rules! impl_eq {
+    ($lhs:ty, $rhs: ty) => {
+        #[stable(feature = "rust1", since = "1.0.0")]
+        #[allow(unused_lifetimes)]
+        impl<'a, 'b> PartialEq<$rhs> for $lhs {
+            #[inline]
+            fn eq(&self, other: &$rhs) -> bool {
+                PartialEq::eq(&self[..], &other[..])
+            }
+            #[inline]
+            fn ne(&self, other: &$rhs) -> bool {
+                PartialEq::ne(&self[..], &other[..])
+            }
+        }
+
+        #[stable(feature = "rust1", since = "1.0.0")]
+        #[allow(unused_lifetimes)]
+        impl<'a, 'b> PartialEq<$lhs> for $rhs {
+            #[inline]
+            fn eq(&self, other: &$lhs) -> bool {
+                PartialEq::eq(&self[..], &other[..])
+            }
+            #[inline]
+            fn ne(&self, other: &$lhs) -> bool {
+                PartialEq::ne(&self[..], &other[..])
+            }
+        }
+    };
+}
+
+impl_eq! { String, str }
+impl_eq! { String, &'a str }
+#[cfg(not(no_global_oom_handling))]
+impl_eq! { Cow<'a, str>, str }
+#[cfg(not(no_global_oom_handling))]
+impl_eq! { Cow<'a, str>, &'b str }
+#[cfg(not(no_global_oom_handling))]
+impl_eq! { Cow<'a, str>, String }
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
+impl const Default for String {
+    /// Creates an empty `String`.
+    #[inline]
+    fn default() -> String {
+        String::new()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl fmt::Display for String {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl fmt::Debug for String {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl hash::Hash for String {
+    #[inline]
+    fn hash<H: hash::Hasher>(&self, hasher: &mut H) {
+        (**self).hash(hasher)
+    }
+}
+
+/// Implements the `+` operator for concatenating two strings.
+///
+/// This consumes the `String` on the left-hand side and re-uses its buffer (growing it if
+/// necessary). This is done to avoid allocating a new `String` and copying the entire contents on
+/// every operation, which would lead to *O*(*n*^2) running time when building an *n*-byte string by
+/// repeated concatenation.
+///
+/// The string on the right-hand side is only borrowed; its contents are copied into the returned
+/// `String`.
+///
+/// # Examples
+///
+/// Concatenating two `String`s takes the first by value and borrows the second:
+///
+/// ```
+/// let a = String::from("hello");
+/// let b = String::from(" world");
+/// let c = a + &b;
+/// // `a` is moved and can no longer be used here.
+/// ```
+///
+/// If you want to keep using the first `String`, you can clone it and append to the clone instead:
+///
+/// ```
+/// let a = String::from("hello");
+/// let b = String::from(" world");
+/// let c = a.clone() + &b;
+/// // `a` is still valid here.
+/// ```
+///
+/// Concatenating `&str` slices can be done by converting the first to a `String`:
+///
+/// ```
+/// let a = "hello";
+/// let b = " world";
+/// let c = a.to_string() + b;
+/// ```
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl Add<&str> for String {
+    type Output = String;
+
+    #[inline]
+    fn add(mut self, other: &str) -> String {
+        self.push_str(other);
+        self
+    }
+}
+
+/// Implements the `+=` operator for appending to a `String`.
+///
+/// This has the same behavior as the [`push_str`][String::push_str] method.
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "stringaddassign", since = "1.12.0")]
+impl AddAssign<&str> for String {
+    #[inline]
+    fn add_assign(&mut self, other: &str) {
+        self.push_str(other);
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ops::Index<ops::Range<usize>> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, index: ops::Range<usize>) -> &str {
+        &self[..][index]
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ops::Index<ops::RangeTo<usize>> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, index: ops::RangeTo<usize>) -> &str {
+        &self[..][index]
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ops::Index<ops::RangeFrom<usize>> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, index: ops::RangeFrom<usize>) -> &str {
+        &self[..][index]
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ops::Index<ops::RangeFull> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, _index: ops::RangeFull) -> &str {
+        unsafe { str::from_utf8_unchecked(&self.vec) }
+    }
+}
+#[stable(feature = "inclusive_range", since = "1.26.0")]
+impl ops::Index<ops::RangeInclusive<usize>> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, index: ops::RangeInclusive<usize>) -> &str {
+        Index::index(&**self, index)
+    }
+}
+#[stable(feature = "inclusive_range", since = "1.26.0")]
+impl ops::Index<ops::RangeToInclusive<usize>> for String {
+    type Output = str;
+
+    #[inline]
+    fn index(&self, index: ops::RangeToInclusive<usize>) -> &str {
+        Index::index(&**self, index)
+    }
+}
+
+#[stable(feature = "derefmut_for_string", since = "1.3.0")]
+impl ops::IndexMut<ops::Range<usize>> for String {
+    #[inline]
+    fn index_mut(&mut self, index: ops::Range<usize>) -> &mut str {
+        &mut self[..][index]
+    }
+}
+#[stable(feature = "derefmut_for_string", since = "1.3.0")]
+impl ops::IndexMut<ops::RangeTo<usize>> for String {
+    #[inline]
+    fn index_mut(&mut self, index: ops::RangeTo<usize>) -> &mut str {
+        &mut self[..][index]
+    }
+}
+#[stable(feature = "derefmut_for_string", since = "1.3.0")]
+impl ops::IndexMut<ops::RangeFrom<usize>> for String {
+    #[inline]
+    fn index_mut(&mut self, index: ops::RangeFrom<usize>) -> &mut str {
+        &mut self[..][index]
+    }
+}
+#[stable(feature = "derefmut_for_string", since = "1.3.0")]
+impl ops::IndexMut<ops::RangeFull> for String {
+    #[inline]
+    fn index_mut(&mut self, _index: ops::RangeFull) -> &mut str {
+        unsafe { str::from_utf8_unchecked_mut(&mut *self.vec) }
+    }
+}
+#[stable(feature = "inclusive_range", since = "1.26.0")]
+impl ops::IndexMut<ops::RangeInclusive<usize>> for String {
+    #[inline]
+    fn index_mut(&mut self, index: ops::RangeInclusive<usize>) -> &mut str {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+#[stable(feature = "inclusive_range", since = "1.26.0")]
+impl ops::IndexMut<ops::RangeToInclusive<usize>> for String {
+    #[inline]
+    fn index_mut(&mut self, index: ops::RangeToInclusive<usize>) -> &mut str {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl ops::Deref for String {
+    type Target = str;
+
+    #[inline]
+    fn deref(&self) -> &str {
+        unsafe { str::from_utf8_unchecked(&self.vec) }
+    }
+}
+
+#[stable(feature = "derefmut_for_string", since = "1.3.0")]
+impl ops::DerefMut for String {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut str {
+        unsafe { str::from_utf8_unchecked_mut(&mut *self.vec) }
+    }
+}
+
+/// A type alias for [`Infallible`].
+///
+/// This alias exists for backwards compatibility, and may be eventually deprecated.
+///
+/// [`Infallible`]: core::convert::Infallible "convert::Infallible"
+#[stable(feature = "str_parse_error", since = "1.5.0")]
+pub type ParseError = core::convert::Infallible;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl FromStr for String {
+    type Err = core::convert::Infallible;
+    #[inline]
+    fn from_str(s: &str) -> Result<String, Self::Err> {
+        Ok(String::from(s))
+    }
+}
+
+/// A trait for converting a value to a `String`.
+///
+/// This trait is automatically implemented for any type which implements the
+/// [`Display`] trait. As such, `ToString` shouldn't be implemented directly:
+/// [`Display`] should be implemented instead, and you get the `ToString`
+/// implementation for free.
+///
+/// [`Display`]: fmt::Display
+#[cfg_attr(not(test), rustc_diagnostic_item = "ToString")]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub trait ToString {
+    /// Converts the given value to a `String`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let i = 5;
+    /// let five = String::from("5");
+    ///
+    /// assert_eq!(five, i.to_string());
+    /// ```
+    #[rustc_conversion_suggestion]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    fn to_string(&self) -> String;
+}
+
+/// # Panics
+///
+/// In this implementation, the `to_string` method panics
+/// if the `Display` implementation returns an error.
+/// This indicates an incorrect `Display` implementation
+/// since `fmt::Write for String` never returns an error itself.
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Display + ?Sized> ToString for T {
+    // A common guideline is to not inline generic functions. However,
+    // removing `#[inline]` from this method causes non-negligible regressions.
+    // See <https://github.com/rust-lang/rust/pull/74852>, the last attempt
+    // to try to remove it.
+    #[inline]
+    default fn to_string(&self) -> String {
+        let mut buf = String::new();
+        let mut formatter = core::fmt::Formatter::new(&mut buf);
+        // Bypass format_args!() to avoid write_str with zero-length strs
+        fmt::Display::fmt(self, &mut formatter)
+            .expect("a Display implementation returned an error unexpectedly");
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "char_to_string_specialization", since = "1.46.0")]
+impl ToString for char {
+    #[inline]
+    fn to_string(&self) -> String {
+        String::from(self.encode_utf8(&mut [0; 4]))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "u8_to_string_specialization", since = "1.54.0")]
+impl ToString for u8 {
+    #[inline]
+    fn to_string(&self) -> String {
+        let mut buf = String::with_capacity(3);
+        let mut n = *self;
+        if n >= 10 {
+            if n >= 100 {
+                buf.push((b'0' + n / 100) as char);
+                n %= 100;
+            }
+            buf.push((b'0' + n / 10) as char);
+            n %= 10;
+        }
+        buf.push((b'0' + n) as char);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "i8_to_string_specialization", since = "1.54.0")]
+impl ToString for i8 {
+    #[inline]
+    fn to_string(&self) -> String {
+        let mut buf = String::with_capacity(4);
+        if self.is_negative() {
+            buf.push('-');
+        }
+        let mut n = self.unsigned_abs();
+        if n >= 10 {
+            if n >= 100 {
+                buf.push('1');
+                n -= 100;
+            }
+            buf.push((b'0' + n / 10) as char);
+            n %= 10;
+        }
+        buf.push((b'0' + n) as char);
+        buf
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "str_to_string_specialization", since = "1.9.0")]
+impl ToString for str {
+    #[inline]
+    fn to_string(&self) -> String {
+        String::from(self)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_str_to_string_specialization", since = "1.17.0")]
+impl ToString for Cow<'_, str> {
+    #[inline]
+    fn to_string(&self) -> String {
+        self[..].to_owned()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "string_to_string_specialization", since = "1.17.0")]
+impl ToString for String {
+    #[inline]
+    fn to_string(&self) -> String {
+        self.to_owned()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl AsRef<str> for String {
+    #[inline]
+    fn as_ref(&self) -> &str {
+        self
+    }
+}
+
+#[stable(feature = "string_as_mut", since = "1.43.0")]
+impl AsMut<str> for String {
+    #[inline]
+    fn as_mut(&mut self) -> &mut str {
+        self
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl AsRef<[u8]> for String {
+    #[inline]
+    fn as_ref(&self) -> &[u8] {
+        self.as_bytes()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl From<&str> for String {
+    /// Converts a `&str` into a [`String`].
+    ///
+    /// The result is allocated on the heap.
+    #[inline]
+    fn from(s: &str) -> String {
+        s.to_owned()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "from_mut_str_for_string", since = "1.44.0")]
+impl From<&mut str> for String {
+    /// Converts a `&mut str` into a [`String`].
+    ///
+    /// The result is allocated on the heap.
+    #[inline]
+    fn from(s: &mut str) -> String {
+        s.to_owned()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "from_ref_string", since = "1.35.0")]
+impl From<&String> for String {
+    /// Converts a `&String` into a [`String`].
+    ///
+    /// This clones `s` and returns the clone.
+    #[inline]
+    fn from(s: &String) -> String {
+        s.clone()
+    }
+}
+
+// note: test pulls in libstd, which causes errors here
+#[cfg(not(test))]
+#[stable(feature = "string_from_box", since = "1.18.0")]
+impl From<Box<str>> for String {
+    /// Converts the given boxed `str` slice to a [`String`].
+    /// It is notable that the `str` slice is owned.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s1: String = String::from("hello world");
+    /// let s2: Box<str> = s1.into_boxed_str();
+    /// let s3: String = String::from(s2);
+    ///
+    /// assert_eq!("hello world", s3)
+    /// ```
+    fn from(s: Box<str>) -> String {
+        s.into_string()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_str", since = "1.20.0")]
+impl From<String> for Box<str> {
+    /// Converts the given [`String`] to a boxed `str` slice that is owned.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s1: String = String::from("hello world");
+    /// let s2: Box<str> = Box::from(s1);
+    /// let s3: String = String::from(s2);
+    ///
+    /// assert_eq!("hello world", s3)
+    /// ```
+    fn from(s: String) -> Box<str> {
+        s.into_boxed_str()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "string_from_cow_str", since = "1.14.0")]
+impl<'a> From<Cow<'a, str>> for String {
+    /// Converts a clone-on-write string to an owned
+    /// instance of [`String`].
+    ///
+    /// This extracts the owned string,
+    /// clones the string if it is not already owned.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// // If the string is not owned...
+    /// let cow: Cow<str> = Cow::Borrowed("eggplant");
+    /// // It will allocate on the heap and copy the string.
+    /// let owned: String = String::from(cow);
+    /// assert_eq!(&owned[..], "eggplant");
+    /// ```
+    fn from(s: Cow<'a, str>) -> String {
+        s.into_owned()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a> From<&'a str> for Cow<'a, str> {
+    /// Converts a string slice into a [`Borrowed`] variant.
+    /// No heap allocation is performed, and the string
+    /// is not copied.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// assert_eq!(Cow::from("eggplant"), Cow::Borrowed("eggplant"));
+    /// ```
+    ///
+    /// [`Borrowed`]: crate::borrow::Cow::Borrowed "borrow::Cow::Borrowed"
+    #[inline]
+    fn from(s: &'a str) -> Cow<'a, str> {
+        Cow::Borrowed(s)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a> From<String> for Cow<'a, str> {
+    /// Converts a [`String`] into an [`Owned`] variant.
+    /// No heap allocation is performed, and the string
+    /// is not copied.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// let s = "eggplant".to_string();
+    /// let s2 = "eggplant".to_string();
+    /// assert_eq!(Cow::from(s), Cow::<'static, str>::Owned(s2));
+    /// ```
+    ///
+    /// [`Owned`]: crate::borrow::Cow::Owned "borrow::Cow::Owned"
+    #[inline]
+    fn from(s: String) -> Cow<'a, str> {
+        Cow::Owned(s)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_from_string_ref", since = "1.28.0")]
+impl<'a> From<&'a String> for Cow<'a, str> {
+    /// Converts a [`String`] reference into a [`Borrowed`] variant.
+    /// No heap allocation is performed, and the string
+    /// is not copied.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// let s = "eggplant".to_string();
+    /// assert_eq!(Cow::from(&s), Cow::Borrowed("eggplant"));
+    /// ```
+    ///
+    /// [`Borrowed`]: crate::borrow::Cow::Borrowed "borrow::Cow::Borrowed"
+    #[inline]
+    fn from(s: &'a String) -> Cow<'a, str> {
+        Cow::Borrowed(s.as_str())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_str_from_iter", since = "1.12.0")]
+impl<'a> FromIterator<char> for Cow<'a, str> {
+    fn from_iter<I: IntoIterator<Item = char>>(it: I) -> Cow<'a, str> {
+        Cow::Owned(FromIterator::from_iter(it))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_str_from_iter", since = "1.12.0")]
+impl<'a, 'b> FromIterator<&'b str> for Cow<'a, str> {
+    fn from_iter<I: IntoIterator<Item = &'b str>>(it: I) -> Cow<'a, str> {
+        Cow::Owned(FromIterator::from_iter(it))
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_str_from_iter", since = "1.12.0")]
+impl<'a> FromIterator<String> for Cow<'a, str> {
+    fn from_iter<I: IntoIterator<Item = String>>(it: I) -> Cow<'a, str> {
+        Cow::Owned(FromIterator::from_iter(it))
+    }
+}
+
+#[stable(feature = "from_string_for_vec_u8", since = "1.14.0")]
+impl From<String> for Vec<u8> {
+    /// Converts the given [`String`] to a vector [`Vec`] that holds values of type [`u8`].
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s1 = String::from("hello world");
+    /// let v1 = Vec::from(s1);
+    ///
+    /// for b in v1 {
+    ///     println!("{}", b);
+    /// }
+    /// ```
+    fn from(string: String) -> Vec<u8> {
+        string.into_bytes()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl fmt::Write for String {
+    #[inline]
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        self.push_str(s);
+        Ok(())
+    }
+
+    #[inline]
+    fn write_char(&mut self, c: char) -> fmt::Result {
+        self.push(c);
+        Ok(())
+    }
+}
+
+/// A draining iterator for `String`.
+///
+/// This struct is created by the [`drain`] method on [`String`]. See its
+/// documentation for more.
+///
+/// [`drain`]: String::drain
+#[stable(feature = "drain", since = "1.6.0")]
+pub struct Drain<'a> {
+    /// Will be used as &'a mut String in the destructor
+    string: *mut String,
+    /// Start of part to remove
+    start: usize,
+    /// End of part to remove
+    end: usize,
+    /// Current remaining range to remove
+    iter: Chars<'a>,
+}
+
+#[stable(feature = "collection_debug", since = "1.17.0")]
+impl fmt::Debug for Drain<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_tuple("Drain").field(&self.as_str()).finish()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl Sync for Drain<'_> {}
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl Send for Drain<'_> {}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl Drop for Drain<'_> {
+    fn drop(&mut self) {
+        unsafe {
+            // Use Vec::drain. "Reaffirm" the bounds checks to avoid
+            // panic code being inserted again.
+            let self_vec = (*self.string).as_mut_vec();
+            if self.start <= self.end && self.end <= self_vec.len() {
+                self_vec.drain(self.start..self.end);
+            }
+        }
+    }
+}
+
+impl<'a> Drain<'a> {
+    /// Returns the remaining (sub)string of this iterator as a slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut s = String::from("abc");
+    /// let mut drain = s.drain(..);
+    /// assert_eq!(drain.as_str(), "abc");
+    /// let _ = drain.next().unwrap();
+    /// assert_eq!(drain.as_str(), "bc");
+    /// ```
+    #[must_use]
+    #[stable(feature = "string_drain_as_str", since = "1.55.0")]
+    pub fn as_str(&self) -> &str {
+        self.iter.as_str()
+    }
+}
+
+#[stable(feature = "string_drain_as_str", since = "1.55.0")]
+impl<'a> AsRef<str> for Drain<'a> {
+    fn as_ref(&self) -> &str {
+        self.as_str()
+    }
+}
+
+#[stable(feature = "string_drain_as_str", since = "1.55.0")]
+impl<'a> AsRef<[u8]> for Drain<'a> {
+    fn as_ref(&self) -> &[u8] {
+        self.as_str().as_bytes()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl Iterator for Drain<'_> {
+    type Item = char;
+
+    #[inline]
+    fn next(&mut self) -> Option<char> {
+        self.iter.next()
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        self.iter.size_hint()
+    }
+
+    #[inline]
+    fn last(mut self) -> Option<char> {
+        self.next_back()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl DoubleEndedIterator for Drain<'_> {
+    #[inline]
+    fn next_back(&mut self) -> Option<char> {
+        self.iter.next_back()
+    }
+}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl FusedIterator for Drain<'_> {}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "from_char_for_string", since = "1.46.0")]
+impl From<char> for String {
+    /// Allocates an owned [`String`] from a single character.
+    ///
+    /// # Example
+    /// ```rust
+    /// let c: char = 'a';
+    /// let s: String = String::from(c);
+    /// assert_eq!("a", &s[..]);
+    /// ```
+    #[inline]
+    fn from(c: char) -> Self {
+        c.to_string()
+    }
+}
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
new file mode 100644
index 000000000000..43efc57a7a8d
--- /dev/null
+++ b/rust/alloc/vec/drain.rs
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::{Allocator, Global};
+use core::fmt;
+use core::iter::{FusedIterator, TrustedLen};
+use core::mem::{self};
+use core::ptr::{self, NonNull};
+use core::slice::{self};
+
+use super::Vec;
+
+/// A draining iterator for `Vec<T>`.
+///
+/// This `struct` is created by [`Vec::drain`].
+/// See its documentation for more.
+///
+/// # Example
+///
+/// ```
+/// let mut v = vec![0, 1, 2];
+/// let iter: std::vec::Drain<_> = v.drain(..);
+/// ```
+#[stable(feature = "drain", since = "1.6.0")]
+pub struct Drain<
+    'a,
+    T: 'a,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator + 'a = Global,
+> {
+    /// Index of tail to preserve
+    pub(super) tail_start: usize,
+    /// Length of tail
+    pub(super) tail_len: usize,
+    /// Current remaining range to remove
+    pub(super) iter: slice::Iter<'a, T>,
+    pub(super) vec: NonNull<Vec<T, A>>,
+}
+
+#[stable(feature = "collection_debug", since = "1.17.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Drain<'_, T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_tuple("Drain").field(&self.iter.as_slice()).finish()
+    }
+}
+
+impl<'a, T, A: Allocator> Drain<'a, T, A> {
+    /// Returns the remaining items of this iterator as a slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!['a', 'b', 'c'];
+    /// let mut drain = vec.drain(..);
+    /// assert_eq!(drain.as_slice(), &['a', 'b', 'c']);
+    /// let _ = drain.next().unwrap();
+    /// assert_eq!(drain.as_slice(), &['b', 'c']);
+    /// ```
+    #[must_use]
+    #[stable(feature = "vec_drain_as_slice", since = "1.46.0")]
+    pub fn as_slice(&self) -> &[T] {
+        self.iter.as_slice()
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        unsafe { self.vec.as_ref().allocator() }
+    }
+}
+
+#[stable(feature = "vec_drain_as_slice", since = "1.46.0")]
+impl<'a, T, A: Allocator> AsRef<[T]> for Drain<'a, T, A> {
+    fn as_ref(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl<T: Sync, A: Sync + Allocator> Sync for Drain<'_, T, A> {}
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl<T: Send, A: Send + Allocator> Send for Drain<'_, T, A> {}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> Iterator for Drain<'_, T, A> {
+    type Item = T;
+
+    #[inline]
+    fn next(&mut self) -> Option<T> {
+        self.iter.next().map(|elt| unsafe { ptr::read(elt as *const _) })
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        self.iter.size_hint()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> DoubleEndedIterator for Drain<'_, T, A> {
+    #[inline]
+    fn next_back(&mut self) -> Option<T> {
+        self.iter.next_back().map(|elt| unsafe { ptr::read(elt as *const _) })
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> Drop for Drain<'_, T, A> {
+    fn drop(&mut self) {
+        /// Continues dropping the remaining elements in the `Drain`, then moves back the
+        /// un-`Drain`ed elements to restore the original `Vec`.
+        struct DropGuard<'r, 'a, T, A: Allocator>(&'r mut Drain<'a, T, A>);
+
+        impl<'r, 'a, T, A: Allocator> Drop for DropGuard<'r, 'a, T, A> {
+            fn drop(&mut self) {
+                // Continue the same loop we have below. If the loop already finished, this does
+                // nothing.
+                self.0.for_each(drop);
+
+                if self.0.tail_len > 0 {
+                    unsafe {
+                        let source_vec = self.0.vec.as_mut();
+                        // memmove back untouched tail, update to new length
+                        let start = source_vec.len();
+                        let tail = self.0.tail_start;
+                        if tail != start {
+                            let src = source_vec.as_ptr().add(tail);
+                            let dst = source_vec.as_mut_ptr().add(start);
+                            ptr::copy(src, dst, self.0.tail_len);
+                        }
+                        source_vec.set_len(start + self.0.tail_len);
+                    }
+                }
+            }
+        }
+
+        // exhaust self first
+        while let Some(item) = self.next() {
+            let guard = DropGuard(self);
+            drop(item);
+            mem::forget(guard);
+        }
+
+        // Drop a `DropGuard` to move back the non-drained tail of `self`.
+        DropGuard(self);
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> ExactSizeIterator for Drain<'_, T, A> {
+    fn is_empty(&self) -> bool {
+        self.iter.is_empty()
+    }
+}
+
+#[unstable(feature = "trusted_len", issue = "37572")]
+unsafe impl<T, A: Allocator> TrustedLen for Drain<'_, T, A> {}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<T, A: Allocator> FusedIterator for Drain<'_, T, A> {}
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
new file mode 100644
index 000000000000..b04fce041622
--- /dev/null
+++ b/rust/alloc/vec/drain_filter.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::{Allocator, Global};
+use core::ptr::{self};
+use core::slice::{self};
+
+use super::Vec;
+
+/// An iterator which uses a closure to determine if an element should be removed.
+///
+/// This struct is created by [`Vec::drain_filter`].
+/// See its documentation for more.
+///
+/// # Example
+///
+/// ```
+/// #![feature(drain_filter)]
+///
+/// let mut v = vec![0, 1, 2];
+/// let iter: std::vec::DrainFilter<_, _> = v.drain_filter(|x| *x % 2 == 0);
+/// ```
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+#[derive(Debug)]
+pub struct DrainFilter<
+    'a,
+    T,
+    F,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+> where
+    F: FnMut(&mut T) -> bool,
+{
+    pub(super) vec: &'a mut Vec<T, A>,
+    /// The index of the item that will be inspected by the next call to `next`.
+    pub(super) idx: usize,
+    /// The number of items that have been drained (removed) thus far.
+    pub(super) del: usize,
+    /// The original length of `vec` prior to draining.
+    pub(super) old_len: usize,
+    /// The filter test predicate.
+    pub(super) pred: F,
+    /// A flag that indicates a panic has occurred in the filter test predicate.
+    /// This is used as a hint in the drop implementation to prevent consumption
+    /// of the remainder of the `DrainFilter`. Any unprocessed items will be
+    /// backshifted in the `vec`, but no further items will be dropped or
+    /// tested by the filter predicate.
+    pub(super) panic_flag: bool,
+}
+
+impl<T, F, A: Allocator> DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        self.vec.allocator()
+    }
+}
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Iterator for DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    type Item = T;
+
+    fn next(&mut self) -> Option<T> {
+        unsafe {
+            while self.idx < self.old_len {
+                let i = self.idx;
+                let v = slice::from_raw_parts_mut(self.vec.as_mut_ptr(), self.old_len);
+                self.panic_flag = true;
+                let drained = (self.pred)(&mut v[i]);
+                self.panic_flag = false;
+                // Update the index *after* the predicate is called. If the index
+                // is updated prior and the predicate panics, the element at this
+                // index would be leaked.
+                self.idx += 1;
+                if drained {
+                    self.del += 1;
+                    return Some(ptr::read(&v[i]));
+                } else if self.del > 0 {
+                    let del = self.del;
+                    let src: *const T = &v[i];
+                    let dst: *mut T = &mut v[i - del];
+                    ptr::copy_nonoverlapping(src, dst, 1);
+                }
+            }
+            None
+        }
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (0, Some(self.old_len - self.idx))
+    }
+}
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Drop for DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    fn drop(&mut self) {
+        struct BackshiftOnDrop<'a, 'b, T, F, A: Allocator>
+        where
+            F: FnMut(&mut T) -> bool,
+        {
+            drain: &'b mut DrainFilter<'a, T, F, A>,
+        }
+
+        impl<'a, 'b, T, F, A: Allocator> Drop for BackshiftOnDrop<'a, 'b, T, F, A>
+        where
+            F: FnMut(&mut T) -> bool,
+        {
+            fn drop(&mut self) {
+                unsafe {
+                    if self.drain.idx < self.drain.old_len && self.drain.del > 0 {
+                        // This is a pretty messed up state, and there isn't really an
+                        // obviously right thing to do. We don't want to keep trying
+                        // to execute `pred`, so we just backshift all the unprocessed
+                        // elements and tell the vec that they still exist. The backshift
+                        // is required to prevent a double-drop of the last successfully
+                        // drained item prior to a panic in the predicate.
+                        let ptr = self.drain.vec.as_mut_ptr();
+                        let src = ptr.add(self.drain.idx);
+                        let dst = src.sub(self.drain.del);
+                        let tail_len = self.drain.old_len - self.drain.idx;
+                        src.copy_to(dst, tail_len);
+                    }
+                    self.drain.vec.set_len(self.drain.old_len - self.drain.del);
+                }
+            }
+        }
+
+        let backshift = BackshiftOnDrop { drain: self };
+
+        // Attempt to consume any remaining elements if the filter predicate
+        // has not yet panicked. We'll backshift any remaining elements
+        // whether we've already panicked or if the consumption here panics.
+        if !backshift.drain.panic_flag {
+            backshift.drain.for_each(drop);
+        }
+    }
+}
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
new file mode 100644
index 000000000000..7acd7fb5a09d
--- /dev/null
+++ b/rust/alloc/vec/into_iter.rs
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::{Allocator, Global};
+use crate::raw_vec::RawVec;
+use core::fmt;
+use core::intrinsics::arith_offset;
+use core::iter::{
+    FusedIterator, InPlaceIterable, SourceIter, TrustedLen, TrustedRandomAccessNoCoerce,
+};
+use core::marker::PhantomData;
+use core::mem::{self};
+use core::ptr::{self, NonNull};
+use core::slice::{self};
+
+/// An iterator that moves out of a vector.
+///
+/// This `struct` is created by the `into_iter` method on [`Vec`](super::Vec)
+/// (provided by the [`IntoIterator`] trait).
+///
+/// # Example
+///
+/// ```
+/// let v = vec![0, 1, 2];
+/// let iter: std::vec::IntoIter<_> = v.into_iter();
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_insignificant_dtor]
+pub struct IntoIter<
+    T,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+> {
+    pub(super) buf: NonNull<T>,
+    pub(super) phantom: PhantomData<T>,
+    pub(super) cap: usize,
+    pub(super) alloc: A,
+    pub(super) ptr: *const T,
+    pub(super) end: *const T,
+}
+
+#[stable(feature = "vec_intoiter_debug", since = "1.13.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for IntoIter<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_tuple("IntoIter").field(&self.as_slice()).finish()
+    }
+}
+
+impl<T, A: Allocator> IntoIter<T, A> {
+    /// Returns the remaining items of this iterator as a slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec = vec!['a', 'b', 'c'];
+    /// let mut into_iter = vec.into_iter();
+    /// assert_eq!(into_iter.as_slice(), &['a', 'b', 'c']);
+    /// let _ = into_iter.next().unwrap();
+    /// assert_eq!(into_iter.as_slice(), &['b', 'c']);
+    /// ```
+    #[stable(feature = "vec_into_iter_as_slice", since = "1.15.0")]
+    pub fn as_slice(&self) -> &[T] {
+        unsafe { slice::from_raw_parts(self.ptr, self.len()) }
+    }
+
+    /// Returns the remaining items of this iterator as a mutable slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec = vec!['a', 'b', 'c'];
+    /// let mut into_iter = vec.into_iter();
+    /// assert_eq!(into_iter.as_slice(), &['a', 'b', 'c']);
+    /// into_iter.as_mut_slice()[2] = 'z';
+    /// assert_eq!(into_iter.next().unwrap(), 'a');
+    /// assert_eq!(into_iter.next().unwrap(), 'b');
+    /// assert_eq!(into_iter.next().unwrap(), 'z');
+    /// ```
+    #[stable(feature = "vec_into_iter_as_slice", since = "1.15.0")]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        unsafe { &mut *self.as_raw_mut_slice() }
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    fn as_raw_mut_slice(&mut self) -> *mut [T] {
+        ptr::slice_from_raw_parts_mut(self.ptr as *mut T, self.len())
+    }
+
+    /// Drops remaining elements and relinquishes the backing allocation.
+    ///
+    /// This is roughly equivalent to the following, but more efficient
+    ///
+    /// ```
+    /// # let mut into_iter = Vec::<u8>::with_capacity(10).into_iter();
+    /// (&mut into_iter).for_each(core::mem::drop);
+    /// unsafe { core::ptr::write(&mut into_iter, Vec::new().into_iter()); }
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    pub(super) fn forget_allocation_drop_remaining(&mut self) {
+        let remaining = self.as_raw_mut_slice();
+
+        // overwrite the individual fields instead of creating a new
+        // struct and then overwriting &mut self.
+        // this creates less assembly
+        self.cap = 0;
+        self.buf = unsafe { NonNull::new_unchecked(RawVec::NEW.ptr()) };
+        self.ptr = self.buf.as_ptr();
+        self.end = self.buf.as_ptr();
+
+        unsafe {
+            ptr::drop_in_place(remaining);
+        }
+    }
+}
+
+#[stable(feature = "vec_intoiter_as_ref", since = "1.46.0")]
+impl<T, A: Allocator> AsRef<[T]> for IntoIter<T, A> {
+    fn as_ref(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<T: Send, A: Allocator + Send> Send for IntoIter<T, A> {}
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<T: Sync, A: Allocator> Sync for IntoIter<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> Iterator for IntoIter<T, A> {
+    type Item = T;
+
+    #[inline]
+    fn next(&mut self) -> Option<T> {
+        if self.ptr as *const _ == self.end {
+            None
+        } else if mem::size_of::<T>() == 0 {
+            // purposefully don't use 'ptr.offset' because for
+            // vectors with 0-size elements this would return the
+            // same pointer.
+            self.ptr = unsafe { arith_offset(self.ptr as *const i8, 1) as *mut T };
+
+            // Make up a value of this ZST.
+            Some(unsafe { mem::zeroed() })
+        } else {
+            let old = self.ptr;
+            self.ptr = unsafe { self.ptr.offset(1) };
+
+            Some(unsafe { ptr::read(old) })
+        }
+    }
+
+    #[inline]
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        let exact = if mem::size_of::<T>() == 0 {
+            (self.end as usize).wrapping_sub(self.ptr as usize)
+        } else {
+            unsafe { self.end.offset_from(self.ptr) as usize }
+        };
+        (exact, Some(exact))
+    }
+
+    #[inline]
+    fn advance_by(&mut self, n: usize) -> Result<(), usize> {
+        let step_size = self.len().min(n);
+        let to_drop = ptr::slice_from_raw_parts_mut(self.ptr as *mut T, step_size);
+        if mem::size_of::<T>() == 0 {
+            // SAFETY: due to unchecked casts of unsigned amounts to signed offsets the wraparound
+            // effectively results in unsigned pointers representing positions 0..usize::MAX,
+            // which is valid for ZSTs.
+            self.ptr = unsafe { arith_offset(self.ptr as *const i8, step_size as isize) as *mut T }
+        } else {
+            // SAFETY: the min() above ensures that step_size is in bounds
+            self.ptr = unsafe { self.ptr.add(step_size) };
+        }
+        // SAFETY: the min() above ensures that step_size is in bounds
+        unsafe {
+            ptr::drop_in_place(to_drop);
+        }
+        if step_size < n {
+            return Err(step_size);
+        }
+        Ok(())
+    }
+
+    #[inline]
+    fn count(self) -> usize {
+        self.len()
+    }
+
+    #[doc(hidden)]
+    unsafe fn __iterator_get_unchecked(&mut self, i: usize) -> Self::Item
+    where
+        Self: TrustedRandomAccessNoCoerce,
+    {
+        // SAFETY: the caller must guarantee that `i` is in bounds of the
+        // `Vec<T>`, so `i` cannot overflow an `isize`, and the `self.ptr.add(i)`
+        // is guaranteed to pointer to an element of the `Vec<T>` and
+        // thus guaranteed to be valid to dereference.
+        //
+        // Also note the implementation of `Self: TrustedRandomAccess` requires
+        // that `T: Copy` so reading elements from the buffer doesn't invalidate
+        // them for `Drop`.
+        unsafe {
+            if mem::size_of::<T>() == 0 { mem::zeroed() } else { ptr::read(self.ptr.add(i)) }
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> DoubleEndedIterator for IntoIter<T, A> {
+    #[inline]
+    fn next_back(&mut self) -> Option<T> {
+        if self.end == self.ptr {
+            None
+        } else if mem::size_of::<T>() == 0 {
+            // See above for why 'ptr.offset' isn't used
+            self.end = unsafe { arith_offset(self.end as *const i8, -1) as *mut T };
+
+            // Make up a value of this ZST.
+            Some(unsafe { mem::zeroed() })
+        } else {
+            self.end = unsafe { self.end.offset(-1) };
+
+            Some(unsafe { ptr::read(self.end) })
+        }
+    }
+
+    #[inline]
+    fn advance_back_by(&mut self, n: usize) -> Result<(), usize> {
+        let step_size = self.len().min(n);
+        if mem::size_of::<T>() == 0 {
+            // SAFETY: same as for advance_by()
+            self.end = unsafe {
+                arith_offset(self.end as *const i8, step_size.wrapping_neg() as isize) as *mut T
+            }
+        } else {
+            // SAFETY: same as for advance_by()
+            self.end = unsafe { self.end.offset(step_size.wrapping_neg() as isize) };
+        }
+        let to_drop = ptr::slice_from_raw_parts_mut(self.end as *mut T, step_size);
+        // SAFETY: same as for advance_by()
+        unsafe {
+            ptr::drop_in_place(to_drop);
+        }
+        if step_size < n {
+            return Err(step_size);
+        }
+        Ok(())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ExactSizeIterator for IntoIter<T, A> {
+    fn is_empty(&self) -> bool {
+        self.ptr == self.end
+    }
+}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<T, A: Allocator> FusedIterator for IntoIter<T, A> {}
+
+#[unstable(feature = "trusted_len", issue = "37572")]
+unsafe impl<T, A: Allocator> TrustedLen for IntoIter<T, A> {}
+
+#[doc(hidden)]
+#[unstable(issue = "none", feature = "std_internals")]
+#[rustc_unsafe_specialization_marker]
+pub trait NonDrop {}
+
+// T: Copy as approximation for !Drop since get_unchecked does not advance self.ptr
+// and thus we can't implement drop-handling
+#[unstable(issue = "none", feature = "std_internals")]
+impl<T: Copy> NonDrop for T {}
+
+#[doc(hidden)]
+#[unstable(issue = "none", feature = "std_internals")]
+// TrustedRandomAccess (without NoCoerce) must not be implemented because
+// subtypes/supertypes of `T` might not be `NonDrop`
+unsafe impl<T, A: Allocator> TrustedRandomAccessNoCoerce for IntoIter<T, A>
+where
+    T: NonDrop,
+{
+    const MAY_HAVE_SIDE_EFFECT: bool = false;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_into_iter_clone", since = "1.8.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for IntoIter<T, A> {
+    #[cfg(not(test))]
+    fn clone(&self) -> Self {
+        self.as_slice().to_vec_in(self.alloc.clone()).into_iter()
+    }
+    #[cfg(test)]
+    fn clone(&self) -> Self {
+        crate::slice::to_vec(self.as_slice(), self.alloc.clone()).into_iter()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for IntoIter<T, A> {
+    fn drop(&mut self) {
+        struct DropGuard<'a, T, A: Allocator>(&'a mut IntoIter<T, A>);
+
+        impl<T, A: Allocator> Drop for DropGuard<'_, T, A> {
+            fn drop(&mut self) {
+                unsafe {
+                    // `IntoIter::alloc` is not used anymore after this
+                    let alloc = ptr::read(&self.0.alloc);
+                    // RawVec handles deallocation
+                    let _ = RawVec::from_raw_parts_in(self.0.buf.as_ptr(), self.0.cap, alloc);
+                }
+            }
+        }
+
+        let guard = DropGuard(self);
+        // destroy the remaining elements
+        unsafe {
+            ptr::drop_in_place(guard.0.as_raw_mut_slice());
+        }
+        // now `guard` will be dropped and do the rest
+    }
+}
+
+#[unstable(issue = "none", feature = "inplace_iteration")]
+#[doc(hidden)]
+unsafe impl<T, A: Allocator> InPlaceIterable for IntoIter<T, A> {}
+
+#[unstable(issue = "none", feature = "inplace_iteration")]
+#[doc(hidden)]
+unsafe impl<T, A: Allocator> SourceIter for IntoIter<T, A> {
+    type Source = Self;
+
+    #[inline]
+    unsafe fn as_inner(&mut self) -> &mut Self::Source {
+        self
+    }
+}
+
+// internal helper trait for in-place iteration specialization.
+#[rustc_specialization_trait]
+pub(crate) trait AsIntoIter {
+    type Item;
+    fn as_into_iter(&mut self) -> &mut IntoIter<Self::Item>;
+}
+
+impl<T> AsIntoIter for IntoIter<T> {
+    type Item = T;
+
+    fn as_into_iter(&mut self) -> &mut IntoIter<Self::Item> {
+        self
+    }
+}
diff --git a/rust/alloc/vec/is_zero.rs b/rust/alloc/vec/is_zero.rs
new file mode 100644
index 000000000000..40e1e667c9fb
--- /dev/null
+++ b/rust/alloc/vec/is_zero.rs
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::boxed::Box;
+
+#[rustc_specialization_trait]
+pub(super) unsafe trait IsZero {
+    /// Whether this value is zero
+    fn is_zero(&self) -> bool;
+}
+
+macro_rules! impl_is_zero {
+    ($t:ty, $is_zero:expr) => {
+        unsafe impl IsZero for $t {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                $is_zero(*self)
+            }
+        }
+    };
+}
+
+impl_is_zero!(i16, |x| x == 0);
+impl_is_zero!(i32, |x| x == 0);
+impl_is_zero!(i64, |x| x == 0);
+impl_is_zero!(i128, |x| x == 0);
+impl_is_zero!(isize, |x| x == 0);
+
+impl_is_zero!(u16, |x| x == 0);
+impl_is_zero!(u32, |x| x == 0);
+impl_is_zero!(u64, |x| x == 0);
+impl_is_zero!(u128, |x| x == 0);
+impl_is_zero!(usize, |x| x == 0);
+
+impl_is_zero!(bool, |x| x == false);
+impl_is_zero!(char, |x| x == '\0');
+
+impl_is_zero!(f32, |x: f32| x.to_bits() == 0);
+impl_is_zero!(f64, |x: f64| x.to_bits() == 0);
+
+unsafe impl<T> IsZero for *const T {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        (*self).is_null()
+    }
+}
+
+unsafe impl<T> IsZero for *mut T {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        (*self).is_null()
+    }
+}
+
+// `Option<&T>` and `Option<Box<T>>` are guaranteed to represent `None` as null.
+// For fat pointers, the bytes that would be the pointer metadata in the `Some`
+// variant are padding in the `None` variant, so ignoring them and
+// zero-initializing instead is ok.
+// `Option<&mut T>` never implements `Clone`, so there's no need for an impl of
+// `SpecFromElem`.
+
+unsafe impl<T: ?Sized> IsZero for Option<&T> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.is_none()
+    }
+}
+
+unsafe impl<T: ?Sized> IsZero for Option<Box<T>> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.is_none()
+    }
+}
+
+// `Option<num::NonZeroU32>` and similar have a representation guarantee that
+// they're the same size as the corresponding `u32` type, as well as a guarantee
+// that transmuting between `NonZeroU32` and `Option<num::NonZeroU32>` works.
+// While the documentation officially makes it UB to transmute from `None`,
+// we're the standard library so we can make extra inferences, and we know that
+// the only niche available to represent `None` is the one that's all zeros.
+
+macro_rules! impl_is_zero_option_of_nonzero {
+    ($($t:ident,)+) => {$(
+        unsafe impl IsZero for Option<core::num::$t> {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                self.is_none()
+            }
+        }
+    )+};
+}
+
+impl_is_zero_option_of_nonzero!(
+    NonZeroU8,
+    NonZeroU16,
+    NonZeroU32,
+    NonZeroU64,
+    NonZeroU128,
+    NonZeroI8,
+    NonZeroI16,
+    NonZeroI32,
+    NonZeroI64,
+    NonZeroI128,
+    NonZeroUsize,
+    NonZeroIsize,
+);
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
new file mode 100644
index 000000000000..5e0cf38ad1b4
--- /dev/null
+++ b/rust/alloc/vec/mod.rs
@@ -0,0 +1,3327 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! A contiguous growable array type with heap-allocated contents, written
+//! `Vec<T>`.
+//!
+//! Vectors have *O*(1) indexing, amortized *O*(1) push (to the end) and
+//! *O*(1) pop (from the end).
+//!
+//! Vectors ensure they never allocate more than `isize::MAX` bytes.
+//!
+//! # Examples
+//!
+//! You can explicitly create a [`Vec`] with [`Vec::new`]:
+//!
+//! ```
+//! let v: Vec<i32> = Vec::new();
+//! ```
+//!
+//! ...or by using the [`vec!`] macro:
+//!
+//! ```
+//! let v: Vec<i32> = vec![];
+//!
+//! let v = vec![1, 2, 3, 4, 5];
+//!
+//! let v = vec![0; 10]; // ten zeroes
+//! ```
+//!
+//! You can [`push`] values onto the end of a vector (which will grow the vector
+//! as needed):
+//!
+//! ```
+//! let mut v = vec![1, 2];
+//!
+//! v.push(3);
+//! ```
+//!
+//! Popping values works in much the same way:
+//!
+//! ```
+//! let mut v = vec![1, 2];
+//!
+//! let two = v.pop();
+//! ```
+//!
+//! Vectors also support indexing (through the [`Index`] and [`IndexMut`] traits):
+//!
+//! ```
+//! let mut v = vec![1, 2, 3];
+//! let three = v[2];
+//! v[1] = v[1] + 5;
+//! ```
+//!
+//! [`push`]: Vec::push
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[cfg(not(no_global_oom_handling))]
+use core::cmp;
+use core::cmp::Ordering;
+use core::convert::TryFrom;
+use core::fmt;
+use core::hash::{Hash, Hasher};
+use core::intrinsics::{arith_offset, assume};
+use core::iter;
+#[cfg(not(no_global_oom_handling))]
+use core::iter::FromIterator;
+use core::marker::PhantomData;
+use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::ops::{self, Index, IndexMut, Range, RangeBounds};
+use core::ptr::{self, NonNull};
+use core::slice::{self, SliceIndex};
+
+use crate::alloc::{Allocator, Global};
+use crate::borrow::{Cow, ToOwned};
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::raw_vec::RawVec;
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+pub use self::drain_filter::DrainFilter;
+
+mod drain_filter;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_splice", since = "1.21.0")]
+pub use self::splice::Splice;
+
+#[cfg(not(no_global_oom_handling))]
+mod splice;
+
+#[stable(feature = "drain", since = "1.6.0")]
+pub use self::drain::Drain;
+
+mod drain;
+
+#[cfg(not(no_global_oom_handling))]
+mod cow;
+
+#[cfg(not(no_global_oom_handling))]
+pub(crate) use self::into_iter::AsIntoIter;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use self::into_iter::IntoIter;
+
+mod into_iter;
+
+#[cfg(not(no_global_oom_handling))]
+use self::is_zero::IsZero;
+
+mod is_zero;
+
+#[cfg(not(no_global_oom_handling))]
+mod source_iter_marker;
+
+mod partial_eq;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_elem::SpecFromElem;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_elem;
+
+use self::set_len_on_drop::SetLenOnDrop;
+
+mod set_len_on_drop;
+
+#[cfg(not(no_global_oom_handling))]
+use self::in_place_drop::InPlaceDrop;
+
+#[cfg(not(no_global_oom_handling))]
+mod in_place_drop;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_iter_nested::SpecFromIterNested;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_iter_nested;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_iter::SpecFromIter;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_iter;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_extend::SpecExtend;
+
+use self::spec_extend::TrySpecExtend;
+
+mod spec_extend;
+
+/// A contiguous growable array type, written as `Vec<T>` and pronounced 'vector'.
+///
+/// # Examples
+///
+/// ```
+/// let mut vec = Vec::new();
+/// vec.push(1);
+/// vec.push(2);
+///
+/// assert_eq!(vec.len(), 2);
+/// assert_eq!(vec[0], 1);
+///
+/// assert_eq!(vec.pop(), Some(2));
+/// assert_eq!(vec.len(), 1);
+///
+/// vec[0] = 7;
+/// assert_eq!(vec[0], 7);
+///
+/// vec.extend([1, 2, 3].iter().copied());
+///
+/// for x in &vec {
+///     println!("{}", x);
+/// }
+/// assert_eq!(vec, [7, 1, 2, 3]);
+/// ```
+///
+/// The [`vec!`] macro is provided for convenient initialization:
+///
+/// ```
+/// let mut vec1 = vec![1, 2, 3];
+/// vec1.push(4);
+/// let vec2 = Vec::from([1, 2, 3, 4]);
+/// assert_eq!(vec1, vec2);
+/// ```
+///
+/// It can also initialize each element of a `Vec<T>` with a given value.
+/// This may be more efficient than performing allocation and initialization
+/// in separate steps, especially when initializing a vector of zeros:
+///
+/// ```
+/// let vec = vec![0; 5];
+/// assert_eq!(vec, [0, 0, 0, 0, 0]);
+///
+/// // The following is equivalent, but potentially slower:
+/// let mut vec = Vec::with_capacity(5);
+/// vec.resize(5, 0);
+/// assert_eq!(vec, [0, 0, 0, 0, 0]);
+/// ```
+///
+/// For more information, see
+/// [Capacity and Reallocation](#capacity-and-reallocation).
+///
+/// Use a `Vec<T>` as an efficient stack:
+///
+/// ```
+/// let mut stack = Vec::new();
+///
+/// stack.push(1);
+/// stack.push(2);
+/// stack.push(3);
+///
+/// while let Some(top) = stack.pop() {
+///     // Prints 3, 2, 1
+///     println!("{}", top);
+/// }
+/// ```
+///
+/// # Indexing
+///
+/// The `Vec` type allows to access values by index, because it implements the
+/// [`Index`] trait. An example will be more explicit:
+///
+/// ```
+/// let v = vec![0, 2, 4, 6];
+/// println!("{}", v[1]); // it will display '2'
+/// ```
+///
+/// However be careful: if you try to access an index which isn't in the `Vec`,
+/// your software will panic! You cannot do this:
+///
+/// ```should_panic
+/// let v = vec![0, 2, 4, 6];
+/// println!("{}", v[6]); // it will panic!
+/// ```
+///
+/// Use [`get`] and [`get_mut`] if you want to check whether the index is in
+/// the `Vec`.
+///
+/// # Slicing
+///
+/// A `Vec` can be mutable. On the other hand, slices are read-only objects.
+/// To get a [slice][prim@slice], use [`&`]. Example:
+///
+/// ```
+/// fn read_slice(slice: &[usize]) {
+///     // ...
+/// }
+///
+/// let v = vec![0, 1];
+/// read_slice(&v);
+///
+/// // ... and that's all!
+/// // you can also do it like this:
+/// let u: &[usize] = &v;
+/// // or like this:
+/// let u: &[_] = &v;
+/// ```
+///
+/// In Rust, it's more common to pass slices as arguments rather than vectors
+/// when you just want to provide read access. The same goes for [`String`] and
+/// [`&str`].
+///
+/// # Capacity and reallocation
+///
+/// The capacity of a vector is the amount of space allocated for any future
+/// elements that will be added onto the vector. This is not to be confused with
+/// the *length* of a vector, which specifies the number of actual elements
+/// within the vector. If a vector's length exceeds its capacity, its capacity
+/// will automatically be increased, but its elements will have to be
+/// reallocated.
+///
+/// For example, a vector with capacity 10 and length 0 would be an empty vector
+/// with space for 10 more elements. Pushing 10 or fewer elements onto the
+/// vector will not change its capacity or cause reallocation to occur. However,
+/// if the vector's length is increased to 11, it will have to reallocate, which
+/// can be slow. For this reason, it is recommended to use [`Vec::with_capacity`]
+/// whenever possible to specify how big the vector is expected to get.
+///
+/// # Guarantees
+///
+/// Due to its incredibly fundamental nature, `Vec` makes a lot of guarantees
+/// about its design. This ensures that it's as low-overhead as possible in
+/// the general case, and can be correctly manipulated in primitive ways
+/// by unsafe code. Note that these guarantees refer to an unqualified `Vec<T>`.
+/// If additional type parameters are added (e.g., to support custom allocators),
+/// overriding their defaults may change the behavior.
+///
+/// Most fundamentally, `Vec` is and always will be a (pointer, capacity, length)
+/// triplet. No more, no less. The order of these fields is completely
+/// unspecified, and you should use the appropriate methods to modify these.
+/// The pointer will never be null, so this type is null-pointer-optimized.
+///
+/// However, the pointer might not actually point to allocated memory. In particular,
+/// if you construct a `Vec` with capacity 0 via [`Vec::new`], [`vec![]`][`vec!`],
+/// [`Vec::with_capacity(0)`][`Vec::with_capacity`], or by calling [`shrink_to_fit`]
+/// on an empty Vec, it will not allocate memory. Similarly, if you store zero-sized
+/// types inside a `Vec`, it will not allocate space for them. *Note that in this case
+/// the `Vec` might not report a [`capacity`] of 0*. `Vec` will allocate if and only
+/// if <code>[mem::size_of::\<T>]\() * [capacity]\() > 0</code>. In general, `Vec`'s allocation
+/// details are very subtle --- if you intend to allocate memory using a `Vec`
+/// and use it for something else (either to pass to unsafe code, or to build your
+/// own memory-backed collection), be sure to deallocate this memory by using
+/// `from_raw_parts` to recover the `Vec` and then dropping it.
+///
+/// If a `Vec` *has* allocated memory, then the memory it points to is on the heap
+/// (as defined by the allocator Rust is configured to use by default), and its
+/// pointer points to [`len`] initialized, contiguous elements in order (what
+/// you would see if you coerced it to a slice), followed by <code>[capacity] - [len]</code>
+/// logically uninitialized, contiguous elements.
+///
+/// A vector containing the elements `'a'` and `'b'` with capacity 4 can be
+/// visualized as below. The top part is the `Vec` struct, it contains a
+/// pointer to the head of the allocation in the heap, length and capacity.
+/// The bottom part is the allocation on the heap, a contiguous memory block.
+///
+/// ```text
+///             ptr      len  capacity
+///        +--------+--------+--------+
+///        | 0x0123 |      2 |      4 |
+///        +--------+--------+--------+
+///             |
+///             v
+/// Heap   +--------+--------+--------+--------+
+///        |    'a' |    'b' | uninit | uninit |
+///        +--------+--------+--------+--------+
+/// ```
+///
+/// - **uninit** represents memory that is not initialized, see [`MaybeUninit`].
+/// - Note: the ABI is not stable and `Vec` makes no guarantees about its memory
+///   layout (including the order of fields).
+///
+/// `Vec` will never perform a "small optimization" where elements are actually
+/// stored on the stack for two reasons:
+///
+/// * It would make it more difficult for unsafe code to correctly manipulate
+///   a `Vec`. The contents of a `Vec` wouldn't have a stable address if it were
+///   only moved, and it would be more difficult to determine if a `Vec` had
+///   actually allocated memory.
+///
+/// * It would penalize the general case, incurring an additional branch
+///   on every access.
+///
+/// `Vec` will never automatically shrink itself, even if completely empty. This
+/// ensures no unnecessary allocations or deallocations occur. Emptying a `Vec`
+/// and then filling it back up to the same [`len`] should incur no calls to
+/// the allocator. If you wish to free up unused memory, use
+/// [`shrink_to_fit`] or [`shrink_to`].
+///
+/// [`push`] and [`insert`] will never (re)allocate if the reported capacity is
+/// sufficient. [`push`] and [`insert`] *will* (re)allocate if
+/// <code>[len] == [capacity]</code>. That is, the reported capacity is completely
+/// accurate, and can be relied on. It can even be used to manually free the memory
+/// allocated by a `Vec` if desired. Bulk insertion methods *may* reallocate, even
+/// when not necessary.
+///
+/// `Vec` does not guarantee any particular growth strategy when reallocating
+/// when full, nor when [`reserve`] is called. The current strategy is basic
+/// and it may prove desirable to use a non-constant growth factor. Whatever
+/// strategy is used will of course guarantee *O*(1) amortized [`push`].
+///
+/// `vec![x; n]`, `vec![a, b, c, d]`, and
+/// [`Vec::with_capacity(n)`][`Vec::with_capacity`], will all produce a `Vec`
+/// with exactly the requested capacity. If <code>[len] == [capacity]</code>,
+/// (as is the case for the [`vec!`] macro), then a `Vec<T>` can be converted to
+/// and from a [`Box<[T]>`][owned slice] without reallocating or moving the elements.
+///
+/// `Vec` will not specifically overwrite any data that is removed from it,
+/// but also won't specifically preserve it. Its uninitialized memory is
+/// scratch space that it may use however it wants. It will generally just do
+/// whatever is most efficient or otherwise easy to implement. Do not rely on
+/// removed data to be erased for security purposes. Even if you drop a `Vec`, its
+/// buffer may simply be reused by another allocation. Even if you zero a `Vec`'s memory
+/// first, that might not actually happen because the optimizer does not consider
+/// this a side-effect that must be preserved. There is one case which we will
+/// not break, however: using `unsafe` code to write to the excess capacity,
+/// and then increasing the length to match, is always valid.
+///
+/// Currently, `Vec` does not guarantee the order in which elements are dropped.
+/// The order has changed in the past and may change again.
+///
+/// [`get`]: ../../std/vec/struct.Vec.html#method.get
+/// [`get_mut`]: ../../std/vec/struct.Vec.html#method.get_mut
+/// [`String`]: crate::string::String
+/// [`&str`]: type@str
+/// [`shrink_to_fit`]: Vec::shrink_to_fit
+/// [`shrink_to`]: Vec::shrink_to
+/// [capacity]: Vec::capacity
+/// [`capacity`]: Vec::capacity
+/// [mem::size_of::\<T>]: core::mem::size_of
+/// [len]: Vec::len
+/// [`len`]: Vec::len
+/// [`push`]: Vec::push
+/// [`insert`]: Vec::insert
+/// [`reserve`]: Vec::reserve
+/// [`MaybeUninit`]: core::mem::MaybeUninit
+/// [owned slice]: Box
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(test), rustc_diagnostic_item = "Vec")]
+#[rustc_insignificant_dtor]
+pub struct Vec<T, #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global> {
+    buf: RawVec<T, A>,
+    len: usize,
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Inherent methods
+////////////////////////////////////////////////////////////////////////////////
+
+impl<T> Vec<T> {
+    /// Constructs a new, empty `Vec<T>`.
+    ///
+    /// The vector will not allocate until elements are pushed onto it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # #![allow(unused_mut)]
+    /// let mut vec: Vec<i32> = Vec::new();
+    /// ```
+    #[inline]
+    #[rustc_const_stable(feature = "const_vec_new", since = "1.39.0")]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub const fn new() -> Self {
+        Vec { buf: RawVec::NEW, len: 0 }
+    }
+
+    /// Constructs a new, empty `Vec<T>` with the specified capacity.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub fn with_capacity(capacity: usize) -> Self {
+        Self::with_capacity_in(capacity, Global)
+    }
+
+    /// Tries to construct a new, empty `Vec<T>` with the specified capacity.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::try_with_capacity(10).unwrap();
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    ///
+    /// let mut result = Vec::try_with_capacity(usize::MAX);
+    /// assert!(result.is_err());
+    /// ```
+    #[inline]
+    #[doc(alias = "malloc")]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+        Self::try_with_capacity_in(capacity, Global)
+    }
+
+    /// Creates a `Vec<T>` directly from the raw components of another vector.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren't
+    /// checked:
+    ///
+    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
+    ///   (at least, it's highly likely to be incorrect if it wasn't).
+    /// * `T` needs to have the same size and alignment as what `ptr` was allocated with.
+    ///   (`T` having a less strict alignment is not sufficient, the alignment really
+    ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
+    ///   allocated and deallocated with the same layout.)
+    /// * `length` needs to be less than or equal to `capacity`.
+    /// * `capacity` needs to be the capacity that the pointer was allocated with.
+    ///
+    /// Violating these may cause problems like corrupting the allocator's
+    /// internal data structures. For example it is **not** safe
+    /// to build a `Vec<u8>` from a pointer to a C `char` array with length `size_t`.
+    /// It's also not safe to build one from a `Vec<u16>` and its length, because
+    /// the allocator cares about the alignment, and these two types have different
+    /// alignments. The buffer was allocated with alignment 2 (for `u16`), but after
+    /// turning it into a `Vec<u8>` it'll be deallocated with alignment 1.
+    ///
+    /// The ownership of `ptr` is effectively transferred to the
+    /// `Vec<T>` which may then deallocate, reallocate or change the
+    /// contents of memory pointed to by the pointer at will. Ensure
+    /// that nothing else uses the pointer after calling this
+    /// function.
+    ///
+    /// [`String`]: crate::string::String
+    /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::ptr;
+    /// use std::mem;
+    ///
+    /// let v = vec![1, 2, 3];
+    ///
+    // FIXME Update this when vec_into_raw_parts is stabilized
+    /// // Prevent running `v`'s destructor so we are in complete control
+    /// // of the allocation.
+    /// let mut v = mem::ManuallyDrop::new(v);
+    ///
+    /// // Pull out the various important pieces of information about `v`
+    /// let p = v.as_mut_ptr();
+    /// let len = v.len();
+    /// let cap = v.capacity();
+    ///
+    /// unsafe {
+    ///     // Overwrite memory with 4, 5, 6
+    ///     for i in 0..len as isize {
+    ///         ptr::write(p.offset(i), 4 + i);
+    ///     }
+    ///
+    ///     // Put everything back together into a Vec
+    ///     let rebuilt = Vec::from_raw_parts(p, len, cap);
+    ///     assert_eq!(rebuilt, [4, 5, 6]);
+    /// }
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
+        unsafe { Self::from_raw_parts_in(ptr, length, capacity, Global) }
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    /// Constructs a new, empty `Vec<T, A>`.
+    ///
+    /// The vector will not allocate until elements are pushed onto it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// # #[allow(unused_mut)]
+    /// let mut vec: Vec<i32, _> = Vec::new_in(System);
+    /// ```
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub const fn new_in(alloc: A) -> Self {
+        Vec { buf: RawVec::new_in(alloc), len: 0 }
+    }
+
+    /// Constructs a new, empty `Vec<T, A>` with the specified capacity with the provided
+    /// allocator.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut vec = Vec::with_capacity_in(10, System);
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub fn with_capacity_in(capacity: usize, alloc: A) -> Self {
+        Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
+    }
+
+    /// Tries to construct a new, empty `Vec<T, A>` with the specified capacity
+    /// with the provided allocator.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut vec = Vec::try_with_capacity_in(10, System).unwrap();
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    ///
+    /// let mut result = Vec::try_with_capacity_in(usize::MAX, System);
+    /// assert!(result.is_err());
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
+        Ok(Vec { buf: RawVec::try_with_capacity_in(capacity, alloc)?, len: 0 })
+    }
+
+    /// Creates a `Vec<T, A>` directly from the raw components of another vector.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren't
+    /// checked:
+    ///
+    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
+    ///   (at least, it's highly likely to be incorrect if it wasn't).
+    /// * `T` needs to have the same size and alignment as what `ptr` was allocated with.
+    ///   (`T` having a less strict alignment is not sufficient, the alignment really
+    ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
+    ///   allocated and deallocated with the same layout.)
+    /// * `length` needs to be less than or equal to `capacity`.
+    /// * `capacity` needs to be the capacity that the pointer was allocated with.
+    ///
+    /// Violating these may cause problems like corrupting the allocator's
+    /// internal data structures. For example it is **not** safe
+    /// to build a `Vec<u8>` from a pointer to a C `char` array with length `size_t`.
+    /// It's also not safe to build one from a `Vec<u16>` and its length, because
+    /// the allocator cares about the alignment, and these two types have different
+    /// alignments. The buffer was allocated with alignment 2 (for `u16`), but after
+    /// turning it into a `Vec<u8>` it'll be deallocated with alignment 1.
+    ///
+    /// The ownership of `ptr` is effectively transferred to the
+    /// `Vec<T>` which may then deallocate, reallocate or change the
+    /// contents of memory pointed to by the pointer at will. Ensure
+    /// that nothing else uses the pointer after calling this
+    /// function.
+    ///
+    /// [`String`]: crate::string::String
+    /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// use std::ptr;
+    /// use std::mem;
+    ///
+    /// let mut v = Vec::with_capacity_in(3, System);
+    /// v.push(1);
+    /// v.push(2);
+    /// v.push(3);
+    ///
+    // FIXME Update this when vec_into_raw_parts is stabilized
+    /// // Prevent running `v`'s destructor so we are in complete control
+    /// // of the allocation.
+    /// let mut v = mem::ManuallyDrop::new(v);
+    ///
+    /// // Pull out the various important pieces of information about `v`
+    /// let p = v.as_mut_ptr();
+    /// let len = v.len();
+    /// let cap = v.capacity();
+    /// let alloc = v.allocator();
+    ///
+    /// unsafe {
+    ///     // Overwrite memory with 4, 5, 6
+    ///     for i in 0..len as isize {
+    ///         ptr::write(p.offset(i), 4 + i);
+    ///     }
+    ///
+    ///     // Put everything back together into a Vec
+    ///     let rebuilt = Vec::from_raw_parts_in(p, len, cap, alloc.clone());
+    ///     assert_eq!(rebuilt, [4, 5, 6]);
+    /// }
+    /// ```
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub unsafe fn from_raw_parts_in(ptr: *mut T, length: usize, capacity: usize, alloc: A) -> Self {
+        unsafe { Vec { buf: RawVec::from_raw_parts_in(ptr, capacity, alloc), len: length } }
+    }
+
+    /// Decomposes a `Vec<T>` into its raw components.
+    ///
+    /// Returns the raw pointer to the underlying data, the length of
+    /// the vector (in elements), and the allocated capacity of the
+    /// data (in elements). These are the same arguments in the same
+    /// order as the arguments to [`from_raw_parts`].
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Vec`. The only way to do
+    /// this is to convert the raw pointer, length, and capacity back
+    /// into a `Vec` with the [`from_raw_parts`] function, allowing
+    /// the destructor to perform the cleanup.
+    ///
+    /// [`from_raw_parts`]: Vec::from_raw_parts
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_into_raw_parts)]
+    /// let v: Vec<i32> = vec![-1, 0, 1];
+    ///
+    /// let (ptr, len, cap) = v.into_raw_parts();
+    ///
+    /// let rebuilt = unsafe {
+    ///     // We can now make changes to the components, such as
+    ///     // transmuting the raw pointer to a compatible type.
+    ///     let ptr = ptr as *mut u32;
+    ///
+    ///     Vec::from_raw_parts(ptr, len, cap)
+    /// };
+    /// assert_eq!(rebuilt, [4294967295, 0, 1]);
+    /// ```
+    #[unstable(feature = "vec_into_raw_parts", reason = "new API", issue = "65816")]
+    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
+        let mut me = ManuallyDrop::new(self);
+        (me.as_mut_ptr(), me.len(), me.capacity())
+    }
+
+    /// Decomposes a `Vec<T>` into its raw components.
+    ///
+    /// Returns the raw pointer to the underlying data, the length of the vector (in elements),
+    /// the allocated capacity of the data (in elements), and the allocator. These are the same
+    /// arguments in the same order as the arguments to [`from_raw_parts_in`].
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Vec`. The only way to do
+    /// this is to convert the raw pointer, length, and capacity back
+    /// into a `Vec` with the [`from_raw_parts_in`] function, allowing
+    /// the destructor to perform the cleanup.
+    ///
+    /// [`from_raw_parts_in`]: Vec::from_raw_parts_in
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, vec_into_raw_parts)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut v: Vec<i32, System> = Vec::new_in(System);
+    /// v.push(-1);
+    /// v.push(0);
+    /// v.push(1);
+    ///
+    /// let (ptr, len, cap, alloc) = v.into_raw_parts_with_alloc();
+    ///
+    /// let rebuilt = unsafe {
+    ///     // We can now make changes to the components, such as
+    ///     // transmuting the raw pointer to a compatible type.
+    ///     let ptr = ptr as *mut u32;
+    ///
+    ///     Vec::from_raw_parts_in(ptr, len, cap, alloc)
+    /// };
+    /// assert_eq!(rebuilt, [4294967295, 0, 1]);
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "vec_into_raw_parts", reason = "new API", issue = "65816")]
+    pub fn into_raw_parts_with_alloc(self) -> (*mut T, usize, usize, A) {
+        let mut me = ManuallyDrop::new(self);
+        let len = me.len();
+        let capacity = me.capacity();
+        let ptr = me.as_mut_ptr();
+        let alloc = unsafe { ptr::read(me.allocator()) };
+        (ptr, len, capacity, alloc)
+    }
+
+    /// Returns the number of elements the vector can hold without
+    /// reallocating.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec: Vec<i32> = Vec::with_capacity(10);
+    /// assert_eq!(vec.capacity(), 10);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn capacity(&self) -> usize {
+        self.buf.capacity()
+    }
+
+    /// Reserves capacity for at least `additional` more elements to be inserted
+    /// in the given `Vec<T>`. The collection may reserve more space to avoid
+    /// frequent reallocations. After calling `reserve`, capacity will be
+    /// greater than or equal to `self.len() + additional`. Does nothing if
+    /// capacity is already sufficient.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.reserve(10);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve(&mut self, additional: usize) {
+        self.buf.reserve(self.len, additional);
+    }
+
+    /// Reserves the minimum capacity for exactly `additional` more elements to
+    /// be inserted in the given `Vec<T>`. After calling `reserve_exact`,
+    /// capacity will be greater than or equal to `self.len() + additional`.
+    /// Does nothing if the capacity is already sufficient.
+    ///
+    /// Note that the allocator may give the collection more space than it
+    /// requests. Therefore, capacity can not be relied upon to be precisely
+    /// minimal. Prefer [`reserve`] if future insertions are expected.
+    ///
+    /// [`reserve`]: Vec::reserve
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity overflows `usize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.reserve_exact(10);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve_exact(&mut self, additional: usize) {
+        self.buf.reserve_exact(self.len, additional);
+    }
+
+    /// Tries to reserve capacity for at least `additional` more elements to be inserted
+    /// in the given `Vec<T>`. The collection may reserve more space to avoid
+    /// frequent reallocations. After calling `try_reserve`, capacity will be
+    /// greater than or equal to `self.len() + additional`. Does nothing if
+    /// capacity is already sufficient.
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &[u32]) -> Result<Vec<u32>, TryReserveError> {
+    ///     let mut output = Vec::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.extend(data.iter().map(|&val| {
+    ///         val * 2 + 5 // very complicated
+    ///     }));
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data(&[1, 2, 3]).expect("why is the test harness OOMing on 12 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.buf.try_reserve(self.len, additional)
+    }
+
+    /// Tries to reserve the minimum capacity for exactly `additional`
+    /// elements to be inserted in the given `Vec<T>`. After calling
+    /// `try_reserve_exact`, capacity will be greater than or equal to
+    /// `self.len() + additional` if it returns `Ok(())`.
+    /// Does nothing if the capacity is already sufficient.
+    ///
+    /// Note that the allocator may give the collection more space than it
+    /// requests. Therefore, capacity can not be relied upon to be precisely
+    /// minimal. Prefer [`reserve`] if future insertions are expected.
+    ///
+    /// [`reserve`]: Vec::reserve
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &[u32]) -> Result<Vec<u32>, TryReserveError> {
+    ///     let mut output = Vec::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve_exact(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.extend(data.iter().map(|&val| {
+    ///         val * 2 + 5 // very complicated
+    ///     }));
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data(&[1, 2, 3]).expect("why is the test harness OOMing on 12 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve_exact(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.buf.try_reserve_exact(self.len, additional)
+    }
+
+    /// Shrinks the capacity of the vector as much as possible.
+    ///
+    /// It will drop down as close as possible to the length but the allocator
+    /// may still inform the vector that there is space for a few more elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    /// assert_eq!(vec.capacity(), 10);
+    /// vec.shrink_to_fit();
+    /// assert!(vec.capacity() >= 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn shrink_to_fit(&mut self) {
+        // The capacity is never less than the length, and there's nothing to do when
+        // they are equal, so we can avoid the panic case in `RawVec::shrink_to_fit`
+        // by only calling it with a greater capacity.
+        if self.capacity() > self.len {
+            self.buf.shrink_to_fit(self.len);
+        }
+    }
+
+    /// Tries to shrink the capacity of the vector as much as possible.
+    ///
+    /// It will drop down as close as possible to the length but the allocator
+    /// may still inform the vector that there is space for a few more elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    /// assert_eq!(vec.capacity(), 10);
+    /// vec.try_shrink_to_fit().unwrap();
+    /// assert!(vec.capacity() >= 3);
+    /// ```
+    #[doc(alias = "realloc")]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_shrink_to_fit(&mut self) -> Result<(), TryReserveError> {
+        // The capacity is never less than the length, and there's nothing to do when
+        // they are equal, so we can avoid the panic case in `RawVec::try_shrink_to_fit`
+        // by only calling it with a greater capacity.
+        if self.capacity() <= self.len {
+            return Ok(());
+        }
+
+        self.buf.try_shrink_to_fit(self.len)
+    }
+
+    /// Shrinks the capacity of the vector with a lower bound.
+    ///
+    /// The capacity will remain at least as large as both the length
+    /// and the supplied value.
+    ///
+    /// If the current capacity is less than the lower limit, this is a no-op.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    /// assert_eq!(vec.capacity(), 10);
+    /// vec.shrink_to(4);
+    /// assert!(vec.capacity() >= 4);
+    /// vec.shrink_to(0);
+    /// assert!(vec.capacity() >= 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "shrink_to", since = "1.56.0")]
+    pub fn shrink_to(&mut self, min_capacity: usize) {
+        if self.capacity() > min_capacity {
+            self.buf.shrink_to_fit(cmp::max(self.len, min_capacity));
+        }
+    }
+
+    /// Converts the vector into [`Box<[T]>`][owned slice].
+    ///
+    /// Note that this will drop any excess capacity.
+    ///
+    /// [owned slice]: Box
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = vec![1, 2, 3];
+    ///
+    /// let slice = v.into_boxed_slice();
+    /// ```
+    ///
+    /// Any excess capacity is removed:
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    ///
+    /// assert_eq!(vec.capacity(), 10);
+    /// let slice = vec.into_boxed_slice();
+    /// assert_eq!(slice.into_vec().capacity(), 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_boxed_slice(mut self) -> Box<[T], A> {
+        unsafe {
+            self.shrink_to_fit();
+            let me = ManuallyDrop::new(self);
+            let buf = ptr::read(&me.buf);
+            let len = me.len();
+            buf.into_box(len).assume_init()
+        }
+    }
+
+    /// Tries to convert the vector into [`Box<[T]>`][owned slice].
+    ///
+    /// Note that this will drop any excess capacity.
+    ///
+    /// [owned slice]: Box
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = vec![1, 2, 3];
+    ///
+    /// let slice = v.try_into_boxed_slice().unwrap();
+    /// ```
+    ///
+    /// Any excess capacity is removed:
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    ///
+    /// assert_eq!(vec.capacity(), 10);
+    /// let slice = vec.try_into_boxed_slice().unwrap();
+    /// assert_eq!(slice.into_vec().capacity(), 3);
+    /// ```
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_into_boxed_slice(mut self) -> Result<Box<[T], A>, TryReserveError> {
+        unsafe {
+            self.try_shrink_to_fit()?;
+            let me = ManuallyDrop::new(self);
+            let buf = ptr::read(&me.buf);
+            let len = me.len();
+            Ok(buf.into_box(len).assume_init())
+        }
+    }
+
+    /// Shortens the vector, keeping the first `len` elements and dropping
+    /// the rest.
+    ///
+    /// If `len` is greater than the vector's current length, this has no
+    /// effect.
+    ///
+    /// The [`drain`] method can emulate `truncate`, but causes the excess
+    /// elements to be returned instead of dropped.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// Truncating a five element vector to two elements:
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4, 5];
+    /// vec.truncate(2);
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    ///
+    /// No truncation occurs when `len` is greater than the vector's current
+    /// length:
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.truncate(8);
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    ///
+    /// Truncating when `len == 0` is equivalent to calling the [`clear`]
+    /// method.
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.truncate(0);
+    /// assert_eq!(vec, []);
+    /// ```
+    ///
+    /// [`clear`]: Vec::clear
+    /// [`drain`]: Vec::drain
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn truncate(&mut self, len: usize) {
+        // This is safe because:
+        //
+        // * the slice passed to `drop_in_place` is valid; the `len > self.len`
+        //   case avoids creating an invalid slice, and
+        // * the `len` of the vector is shrunk before calling `drop_in_place`,
+        //   such that no value will be dropped twice in case `drop_in_place`
+        //   were to panic once (if it panics twice, the program aborts).
+        unsafe {
+            // Note: It's intentional that this is `>` and not `>=`.
+            //       Changing it to `>=` has negative performance
+            //       implications in some cases. See #78884 for more.
+            if len > self.len {
+                return;
+            }
+            let remaining_len = self.len - len;
+            let s = ptr::slice_from_raw_parts_mut(self.as_mut_ptr().add(len), remaining_len);
+            self.len = len;
+            ptr::drop_in_place(s);
+        }
+    }
+
+    /// Extracts a slice containing the entire vector.
+    ///
+    /// Equivalent to `&s[..]`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::io::{self, Write};
+    /// let buffer = vec![1, 2, 3, 5, 8];
+    /// io::sink().write(buffer.as_slice()).unwrap();
+    /// ```
+    #[inline]
+    #[stable(feature = "vec_as_slice", since = "1.7.0")]
+    pub fn as_slice(&self) -> &[T] {
+        self
+    }
+
+    /// Extracts a mutable slice of the entire vector.
+    ///
+    /// Equivalent to `&mut s[..]`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::io::{self, Read};
+    /// let mut buffer = vec![0; 3];
+    /// io::repeat(0b101).read_exact(buffer.as_mut_slice()).unwrap();
+    /// ```
+    #[inline]
+    #[stable(feature = "vec_as_slice", since = "1.7.0")]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        self
+    }
+
+    /// Returns a raw pointer to the vector's buffer.
+    ///
+    /// The caller must ensure that the vector outlives the pointer this
+    /// function returns, or else it will end up pointing to garbage.
+    /// Modifying the vector may cause its buffer to be reallocated,
+    /// which would also make any pointers to it invalid.
+    ///
+    /// The caller must also ensure that the memory the pointer (non-transitively) points to
+    /// is never written to (except inside an `UnsafeCell`) using this pointer or any pointer
+    /// derived from it. If you need to mutate the contents of the slice, use [`as_mut_ptr`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = vec![1, 2, 4];
+    /// let x_ptr = x.as_ptr();
+    ///
+    /// unsafe {
+    ///     for i in 0..x.len() {
+    ///         assert_eq!(*x_ptr.add(i), 1 << i);
+    ///     }
+    /// }
+    /// ```
+    ///
+    /// [`as_mut_ptr`]: Vec::as_mut_ptr
+    #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[inline]
+    pub fn as_ptr(&self) -> *const T {
+        // We shadow the slice method of the same name to avoid going through
+        // `deref`, which creates an intermediate reference.
+        let ptr = self.buf.ptr();
+        unsafe {
+            assume(!ptr.is_null());
+        }
+        ptr
+    }
+
+    /// Returns an unsafe mutable pointer to the vector's buffer.
+    ///
+    /// The caller must ensure that the vector outlives the pointer this
+    /// function returns, or else it will end up pointing to garbage.
+    /// Modifying the vector may cause its buffer to be reallocated,
+    /// which would also make any pointers to it invalid.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// // Allocate vector big enough for 4 elements.
+    /// let size = 4;
+    /// let mut x: Vec<i32> = Vec::with_capacity(size);
+    /// let x_ptr = x.as_mut_ptr();
+    ///
+    /// // Initialize elements via raw pointer writes, then set length.
+    /// unsafe {
+    ///     for i in 0..size {
+    ///         *x_ptr.add(i) = i as i32;
+    ///     }
+    ///     x.set_len(size);
+    /// }
+    /// assert_eq!(&*x, &[0, 1, 2, 3]);
+    /// ```
+    #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[inline]
+    pub fn as_mut_ptr(&mut self) -> *mut T {
+        // We shadow the slice method of the same name to avoid going through
+        // `deref_mut`, which creates an intermediate reference.
+        let ptr = self.buf.ptr();
+        unsafe {
+            assume(!ptr.is_null());
+        }
+        ptr
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        self.buf.allocator()
+    }
+
+    /// Forces the length of the vector to `new_len`.
+    ///
+    /// This is a low-level operation that maintains none of the normal
+    /// invariants of the type. Normally changing the length of a vector
+    /// is done using one of the safe operations instead, such as
+    /// [`truncate`], [`resize`], [`extend`], or [`clear`].
+    ///
+    /// [`truncate`]: Vec::truncate
+    /// [`resize`]: Vec::resize
+    /// [`extend`]: Extend::extend
+    /// [`clear`]: Vec::clear
+    ///
+    /// # Safety
+    ///
+    /// - `new_len` must be less than or equal to [`capacity()`].
+    /// - The elements at `old_len..new_len` must be initialized.
+    ///
+    /// [`capacity()`]: Vec::capacity
+    ///
+    /// # Examples
+    ///
+    /// This method can be useful for situations in which the vector
+    /// is serving as a buffer for other code, particularly over FFI:
+    ///
+    /// ```no_run
+    /// # #![allow(dead_code)]
+    /// # // This is just a minimal skeleton for the doc example;
+    /// # // don't use this as a starting point for a real library.
+    /// # pub struct StreamWrapper { strm: *mut std::ffi::c_void }
+    /// # const Z_OK: i32 = 0;
+    /// # extern "C" {
+    /// #     fn deflateGetDictionary(
+    /// #         strm: *mut std::ffi::c_void,
+    /// #         dictionary: *mut u8,
+    /// #         dictLength: *mut usize,
+    /// #     ) -> i32;
+    /// # }
+    /// # impl StreamWrapper {
+    /// pub fn get_dictionary(&self) -> Option<Vec<u8>> {
+    ///     // Per the FFI method's docs, "32768 bytes is always enough".
+    ///     let mut dict = Vec::with_capacity(32_768);
+    ///     let mut dict_length = 0;
+    ///     // SAFETY: When `deflateGetDictionary` returns `Z_OK`, it holds that:
+    ///     // 1. `dict_length` elements were initialized.
+    ///     // 2. `dict_length` <= the capacity (32_768)
+    ///     // which makes `set_len` safe to call.
+    ///     unsafe {
+    ///         // Make the FFI call...
+    ///         let r = deflateGetDictionary(self.strm, dict.as_mut_ptr(), &mut dict_length);
+    ///         if r == Z_OK {
+    ///             // ...and update the length to what was initialized.
+    ///             dict.set_len(dict_length);
+    ///             Some(dict)
+    ///         } else {
+    ///             None
+    ///         }
+    ///     }
+    /// }
+    /// # }
+    /// ```
+    ///
+    /// While the following example is sound, there is a memory leak since
+    /// the inner vectors were not freed prior to the `set_len` call:
+    ///
+    /// ```
+    /// let mut vec = vec![vec![1, 0, 0],
+    ///                    vec![0, 1, 0],
+    ///                    vec![0, 0, 1]];
+    /// // SAFETY:
+    /// // 1. `old_len..0` is empty so no elements need to be initialized.
+    /// // 2. `0 <= capacity` always holds whatever `capacity` is.
+    /// unsafe {
+    ///     vec.set_len(0);
+    /// }
+    /// ```
+    ///
+    /// Normally, here, one would use [`clear`] instead to correctly drop
+    /// the contents and thus not leak memory.
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn set_len(&mut self, new_len: usize) {
+        debug_assert!(new_len <= self.capacity());
+
+        self.len = new_len;
+    }
+
+    /// Removes an element from the vector and returns it.
+    ///
+    /// The removed element is replaced by the last element of the vector.
+    ///
+    /// This does not preserve ordering, but is *O*(1).
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec!["foo", "bar", "baz", "qux"];
+    ///
+    /// assert_eq!(v.swap_remove(1), "bar");
+    /// assert_eq!(v, ["foo", "qux", "baz"]);
+    ///
+    /// assert_eq!(v.swap_remove(0), "foo");
+    /// assert_eq!(v, ["baz", "qux"]);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn swap_remove(&mut self, index: usize) -> T {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("swap_remove index (is {}) should be < len (is {})", index, len);
+        }
+
+        let len = self.len();
+        if index >= len {
+            assert_failed(index, len);
+        }
+        unsafe {
+            // We replace self[index] with the last element. Note that if the
+            // bounds check above succeeds there must be a last element (which
+            // can be self[index] itself).
+            let last = ptr::read(self.as_ptr().add(len - 1));
+            let hole = self.as_mut_ptr().add(index);
+            self.set_len(len - 1);
+            ptr::replace(hole, last)
+        }
+    }
+
+    /// Inserts an element at position `index` within the vector, shifting all
+    /// elements after it to the right.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index > len`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.insert(1, 4);
+    /// assert_eq!(vec, [1, 4, 2, 3]);
+    /// vec.insert(4, 5);
+    /// assert_eq!(vec, [1, 4, 2, 3, 5]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn insert(&mut self, index: usize, element: T) {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("insertion index (is {}) should be <= len (is {})", index, len);
+        }
+
+        let len = self.len();
+        if index > len {
+            assert_failed(index, len);
+        }
+
+        // space for the new element
+        if len == self.buf.capacity() {
+            self.reserve(1);
+        }
+
+        unsafe {
+            // infallible
+            // The spot to put the new value
+            {
+                let p = self.as_mut_ptr().add(index);
+                // Shift everything over to make space. (Duplicating the
+                // `index`th element into two consecutive places.)
+                ptr::copy(p, p.offset(1), len - index);
+                // Write it in, overwriting the first copy of the `index`th
+                // element.
+                ptr::write(p, element);
+            }
+            self.set_len(len + 1);
+        }
+    }
+
+    /// Removes and returns the element at position `index` within the vector,
+    /// shifting all elements after it to the left.
+    ///
+    /// Note: Because this shifts over the remaining elements, it has a
+    /// worst-case performance of O(n). If you don't need the order of elements
+    /// to be preserved, use [`swap_remove`] instead.
+    ///
+    /// [`swap_remove`]: Vec::swap_remove
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    /// assert_eq!(v.remove(1), 2);
+    /// assert_eq!(v, [1, 3]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[track_caller]
+    pub fn remove(&mut self, index: usize) -> T {
+        #[cold]
+        #[inline(never)]
+        #[track_caller]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("removal index (is {}) should be < len (is {})", index, len);
+        }
+
+        let len = self.len();
+        if index >= len {
+            assert_failed(index, len);
+        }
+        unsafe {
+            // infallible
+            let ret;
+            {
+                // the place we are taking from.
+                let ptr = self.as_mut_ptr().add(index);
+                // copy it out, unsafely having a copy of the value on
+                // the stack and in the vector at the same time.
+                ret = ptr::read(ptr);
+
+                // Shift everything down to fill in that spot.
+                ptr::copy(ptr.offset(1), ptr, len - index - 1);
+            }
+            self.set_len(len - 1);
+            ret
+        }
+    }
+
+    /// Retains only the elements specified by the predicate.
+    ///
+    /// In other words, remove all elements `e` such that `f(&e)` returns `false`.
+    /// This method operates in place, visiting each element exactly once in the
+    /// original order, and preserves the order of the retained elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.retain(|&x| x % 2 == 0);
+    /// assert_eq!(vec, [2, 4]);
+    /// ```
+    ///
+    /// Because the elements are visited exactly once in the original order,
+    /// external state may be used to decide which elements to keep.
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4, 5];
+    /// let keep = [false, true, true, false, true];
+    /// let mut iter = keep.iter();
+    /// vec.retain(|_| *iter.next().unwrap());
+    /// assert_eq!(vec, [2, 3, 5]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn retain<F>(&mut self, mut f: F)
+    where
+        F: FnMut(&T) -> bool,
+    {
+        let original_len = self.len();
+        // Avoid double drop if the drop guard is not executed,
+        // since we may make some holes during the process.
+        unsafe { self.set_len(0) };
+
+        // Vec: [Kept, Kept, Hole, Hole, Hole, Hole, Unchecked, Unchecked]
+        //      |<-              processed len   ->| ^- next to check
+        //                  |<-  deleted cnt     ->|
+        //      |<-              original_len                          ->|
+        // Kept: Elements which predicate returns true on.
+        // Hole: Moved or dropped element slot.
+        // Unchecked: Unchecked valid elements.
+        //
+        // This drop guard will be invoked when predicate or `drop` of element panicked.
+        // It shifts unchecked elements to cover holes and `set_len` to the correct length.
+        // In cases when predicate and `drop` never panick, it will be optimized out.
+        struct BackshiftOnDrop<'a, T, A: Allocator> {
+            v: &'a mut Vec<T, A>,
+            processed_len: usize,
+            deleted_cnt: usize,
+            original_len: usize,
+        }
+
+        impl<T, A: Allocator> Drop for BackshiftOnDrop<'_, T, A> {
+            fn drop(&mut self) {
+                if self.deleted_cnt > 0 {
+                    // SAFETY: Trailing unchecked items must be valid since we never touch them.
+                    unsafe {
+                        ptr::copy(
+                            self.v.as_ptr().add(self.processed_len),
+                            self.v.as_mut_ptr().add(self.processed_len - self.deleted_cnt),
+                            self.original_len - self.processed_len,
+                        );
+                    }
+                }
+                // SAFETY: After filling holes, all items are in contiguous memory.
+                unsafe {
+                    self.v.set_len(self.original_len - self.deleted_cnt);
+                }
+            }
+        }
+
+        let mut g = BackshiftOnDrop { v: self, processed_len: 0, deleted_cnt: 0, original_len };
+
+        // process_one return a bool indicates whether the processing element should be retained.
+        #[inline(always)]
+        fn process_one<F, T, A: Allocator, const DELETED: bool>(
+            f: &mut F,
+            g: &mut BackshiftOnDrop<'_, T, A>,
+        ) -> bool
+        where
+            F: FnMut(&T) -> bool,
+        {
+            // SAFETY: Unchecked element must be valid.
+            let cur = unsafe { &mut *g.v.as_mut_ptr().add(g.processed_len) };
+            if !f(cur) {
+                // Advance early to avoid double drop if `drop_in_place` panicked.
+                g.processed_len += 1;
+                g.deleted_cnt += 1;
+                // SAFETY: We never touch this element again after dropped.
+                unsafe { ptr::drop_in_place(cur) };
+                // We already advanced the counter.
+                return false;
+            }
+            if DELETED {
+                // SAFETY: `deleted_cnt` > 0, so the hole slot must not overlap with current element.
+                // We use copy for move, and never touch this element again.
+                unsafe {
+                    let hole_slot = g.v.as_mut_ptr().add(g.processed_len - g.deleted_cnt);
+                    ptr::copy_nonoverlapping(cur, hole_slot, 1);
+                }
+            }
+            g.processed_len += 1;
+            return true;
+        }
+
+        // Stage 1: Nothing was deleted.
+        while g.processed_len != original_len {
+            if !process_one::<F, T, A, false>(&mut f, &mut g) {
+                break;
+            }
+        }
+
+        // Stage 2: Some elements were deleted.
+        while g.processed_len != original_len {
+            process_one::<F, T, A, true>(&mut f, &mut g);
+        }
+
+        // All item are processed. This can be optimized to `set_len` by LLVM.
+        drop(g);
+    }
+
+    /// Removes all but the first of consecutive elements in the vector that resolve to the same
+    /// key.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![10, 20, 21, 30, 20];
+    ///
+    /// vec.dedup_by_key(|i| *i / 10);
+    ///
+    /// assert_eq!(vec, [10, 20, 30, 20]);
+    /// ```
+    #[stable(feature = "dedup_by", since = "1.16.0")]
+    #[inline]
+    pub fn dedup_by_key<F, K>(&mut self, mut key: F)
+    where
+        F: FnMut(&mut T) -> K,
+        K: PartialEq,
+    {
+        self.dedup_by(|a, b| key(a) == key(b))
+    }
+
+    /// Removes all but the first of consecutive elements in the vector satisfying a given equality
+    /// relation.
+    ///
+    /// The `same_bucket` function is passed references to two elements from the vector and
+    /// must determine if the elements compare equal. The elements are passed in opposite order
+    /// from their order in the slice, so if `same_bucket(a, b)` returns `true`, `a` is removed.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["foo", "bar", "Bar", "baz", "bar"];
+    ///
+    /// vec.dedup_by(|a, b| a.eq_ignore_ascii_case(b));
+    ///
+    /// assert_eq!(vec, ["foo", "bar", "baz", "bar"]);
+    /// ```
+    #[stable(feature = "dedup_by", since = "1.16.0")]
+    pub fn dedup_by<F>(&mut self, mut same_bucket: F)
+    where
+        F: FnMut(&mut T, &mut T) -> bool,
+    {
+        let len = self.len();
+        if len <= 1 {
+            return;
+        }
+
+        /* INVARIANT: vec.len() > read >= write > write-1 >= 0 */
+        struct FillGapOnDrop<'a, T, A: core::alloc::Allocator> {
+            /* Offset of the element we want to check if it is duplicate */
+            read: usize,
+
+            /* Offset of the place where we want to place the non-duplicate
+             * when we find it. */
+            write: usize,
+
+            /* The Vec that would need correction if `same_bucket` panicked */
+            vec: &'a mut Vec<T, A>,
+        }
+
+        impl<'a, T, A: core::alloc::Allocator> Drop for FillGapOnDrop<'a, T, A> {
+            fn drop(&mut self) {
+                /* This code gets executed when `same_bucket` panics */
+
+                /* SAFETY: invariant guarantees that `read - write`
+                 * and `len - read` never overflow and that the copy is always
+                 * in-bounds. */
+                unsafe {
+                    let ptr = self.vec.as_mut_ptr();
+                    let len = self.vec.len();
+
+                    /* How many items were left when `same_bucket` paniced.
+                     * Basically vec[read..].len() */
+                    let items_left = len.wrapping_sub(self.read);
+
+                    /* Pointer to first item in vec[write..write+items_left] slice */
+                    let dropped_ptr = ptr.add(self.write);
+                    /* Pointer to first item in vec[read..] slice */
+                    let valid_ptr = ptr.add(self.read);
+
+                    /* Copy `vec[read..]` to `vec[write..write+items_left]`.
+                     * The slices can overlap, so `copy_nonoverlapping` cannot be used */
+                    ptr::copy(valid_ptr, dropped_ptr, items_left);
+
+                    /* How many items have been already dropped
+                     * Basically vec[read..write].len() */
+                    let dropped = self.read.wrapping_sub(self.write);
+
+                    self.vec.set_len(len - dropped);
+                }
+            }
+        }
+
+        let mut gap = FillGapOnDrop { read: 1, write: 1, vec: self };
+        let ptr = gap.vec.as_mut_ptr();
+
+        /* Drop items while going through Vec, it should be more efficient than
+         * doing slice partition_dedup + truncate */
+
+        /* SAFETY: Because of the invariant, read_ptr, prev_ptr and write_ptr
+         * are always in-bounds and read_ptr never aliases prev_ptr */
+        unsafe {
+            while gap.read < len {
+                let read_ptr = ptr.add(gap.read);
+                let prev_ptr = ptr.add(gap.write.wrapping_sub(1));
+
+                if same_bucket(&mut *read_ptr, &mut *prev_ptr) {
+                    // Increase `gap.read` now since the drop may panic.
+                    gap.read += 1;
+                    /* We have found duplicate, drop it in-place */
+                    ptr::drop_in_place(read_ptr);
+                } else {
+                    let write_ptr = ptr.add(gap.write);
+
+                    /* Because `read_ptr` can be equal to `write_ptr`, we either
+                     * have to use `copy` or conditional `copy_nonoverlapping`.
+                     * Looks like the first option is faster. */
+                    ptr::copy(read_ptr, write_ptr, 1);
+
+                    /* We have filled that place, so go further */
+                    gap.write += 1;
+                    gap.read += 1;
+                }
+            }
+
+            /* Technically we could let `gap` clean up with its Drop, but
+             * when `same_bucket` is guaranteed to not panic, this bloats a little
+             * the codegen, so we just do it manually */
+            gap.vec.set_len(gap.write);
+            mem::forget(gap);
+        }
+    }
+
+    /// Appends an element to the back of a collection.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2];
+    /// vec.push(3);
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn push(&mut self, value: T) {
+        // This will panic or abort if we would allocate > isize::MAX bytes
+        // or if the length increment would overflow for zero-sized types.
+        if self.len == self.buf.capacity() {
+            self.reserve(1);
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+    }
+
+    /// Tries to append an element to the back of a collection.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2];
+    /// vec.try_push(3).unwrap();
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_push(&mut self, value: T) -> Result<(), TryReserveError> {
+        if self.len == self.buf.capacity() {
+            self.try_reserve(1)?;
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+        Ok(())
+    }
+
+    /// Removes the last element from a vector and returns it, or [`None`] if it
+    /// is empty.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// assert_eq!(vec.pop(), Some(3));
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn pop(&mut self) -> Option<T> {
+        if self.len == 0 {
+            None
+        } else {
+            unsafe {
+                self.len -= 1;
+                Some(ptr::read(self.as_ptr().add(self.len())))
+            }
+        }
+    }
+
+    /// Moves all the elements of `other` into `Self`, leaving `other` empty.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the number of elements in the vector overflows a `usize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// let mut vec2 = vec![4, 5, 6];
+    /// vec.append(&mut vec2);
+    /// assert_eq!(vec, [1, 2, 3, 4, 5, 6]);
+    /// assert_eq!(vec2, []);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "append", since = "1.4.0")]
+    pub fn append(&mut self, other: &mut Self) {
+        unsafe {
+            self.append_elements(other.as_slice() as _);
+            other.set_len(0);
+        }
+    }
+
+    /// Appends elements to `Self` from other buffer.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    unsafe fn append_elements(&mut self, other: *const [T]) {
+        let count = unsafe { (*other).len() };
+        self.reserve(count);
+        let len = self.len();
+        unsafe { ptr::copy_nonoverlapping(other as *const T, self.as_mut_ptr().add(len), count) };
+        self.len += count;
+    }
+
+    /// Tries to append elements to `Self` from other buffer.
+    #[inline]
+    unsafe fn try_append_elements(&mut self, other: *const [T]) -> Result<(), TryReserveError> {
+        let count = unsafe { (*other).len() };
+        self.try_reserve(count)?;
+        let len = self.len();
+        unsafe { ptr::copy_nonoverlapping(other as *const T, self.as_mut_ptr().add(len), count) };
+        self.len += count;
+        Ok(())
+    }
+
+    /// Creates a draining iterator that removes the specified range in the vector
+    /// and yields the removed items.
+    ///
+    /// When the iterator **is** dropped, all elements in the range are removed
+    /// from the vector, even if the iterator was not fully consumed. If the
+    /// iterator **is not** dropped (with [`mem::forget`] for example), it is
+    /// unspecified how many elements are removed.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    /// let u: Vec<_> = v.drain(1..).collect();
+    /// assert_eq!(v, &[1]);
+    /// assert_eq!(u, &[2, 3]);
+    ///
+    /// // A full range clears the vector
+    /// v.drain(..);
+    /// assert_eq!(v, &[]);
+    /// ```
+    #[stable(feature = "drain", since = "1.6.0")]
+    pub fn drain<R>(&mut self, range: R) -> Drain<'_, T, A>
+    where
+        R: RangeBounds<usize>,
+    {
+        // Memory safety
+        //
+        // When the Drain is first created, it shortens the length of
+        // the source vector to make sure no uninitialized or moved-from elements
+        // are accessible at all if the Drain's destructor never gets to run.
+        //
+        // Drain will ptr::read out the values to remove.
+        // When finished, remaining tail of the vec is copied back to cover
+        // the hole, and the vector length is restored to the new length.
+        //
+        let len = self.len();
+        let Range { start, end } = slice::range(range, ..len);
+
+        unsafe {
+            // set self.vec length's to start, to be safe in case Drain is leaked
+            self.set_len(start);
+            // Use the borrow in the IterMut to indicate borrowing behavior of the
+            // whole Drain iterator (like &mut T).
+            let range_slice = slice::from_raw_parts_mut(self.as_mut_ptr().add(start), end - start);
+            Drain {
+                tail_start: end,
+                tail_len: len - end,
+                iter: range_slice.iter(),
+                vec: NonNull::from(self),
+            }
+        }
+    }
+
+    /// Clears the vector, removing all values.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    ///
+    /// v.clear();
+    ///
+    /// assert!(v.is_empty());
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn clear(&mut self) {
+        self.truncate(0)
+    }
+
+    /// Returns the number of elements in the vector, also referred to
+    /// as its 'length'.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let a = vec![1, 2, 3];
+    /// assert_eq!(a.len(), 3);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Returns `true` if the vector contains no elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = Vec::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push(1);
+    /// assert!(!v.is_empty());
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Splits the collection into two at the given index.
+    ///
+    /// Returns a newly allocated vector containing the elements in the range
+    /// `[at, len)`. After the call, the original vector will be left containing
+    /// the elements `[0, at)` with its previous capacity unchanged.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `at > len`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// let vec2 = vec.split_off(1);
+    /// assert_eq!(vec, [1]);
+    /// assert_eq!(vec2, [2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[must_use = "use `.truncate()` if you don't need the other half"]
+    #[stable(feature = "split_off", since = "1.4.0")]
+    pub fn split_off(&mut self, at: usize) -> Self
+    where
+        A: Clone,
+    {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(at: usize, len: usize) -> ! {
+            panic!("`at` split index (is {}) should be <= len (is {})", at, len);
+        }
+
+        if at > self.len() {
+            assert_failed(at, self.len());
+        }
+
+        if at == 0 {
+            // the new vector can take over the original buffer and avoid the copy
+            return mem::replace(
+                self,
+                Vec::with_capacity_in(self.capacity(), self.allocator().clone()),
+            );
+        }
+
+        let other_len = self.len - at;
+        let mut other = Vec::with_capacity_in(other_len, self.allocator().clone());
+
+        // Unsafely `set_len` and copy items to `other`.
+        unsafe {
+            self.set_len(at);
+            other.set_len(other_len);
+
+            ptr::copy_nonoverlapping(self.as_ptr().add(at), other.as_mut_ptr(), other.len());
+        }
+        other
+    }
+
+    /// Resizes the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with the result of
+    /// calling the closure `f`. The return values from `f` will end up
+    /// in the `Vec` in the order they have been generated.
+    ///
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method uses a closure to create new values on every push. If
+    /// you'd rather [`Clone`] a given value, use [`Vec::resize`]. If you
+    /// want to use the [`Default`] trait to generate values, you can
+    /// pass [`Default::default`] as the second argument.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.resize_with(5, Default::default);
+    /// assert_eq!(vec, [1, 2, 3, 0, 0]);
+    ///
+    /// let mut vec = vec![];
+    /// let mut p = 1;
+    /// vec.resize_with(4, || { p *= 2; p });
+    /// assert_eq!(vec, [2, 4, 8, 16]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_resize_with", since = "1.33.0")]
+    pub fn resize_with<F>(&mut self, new_len: usize, f: F)
+    where
+        F: FnMut() -> T,
+    {
+        let len = self.len();
+        if new_len > len {
+            self.extend_with(new_len - len, ExtendFunc(f));
+        } else {
+            self.truncate(new_len);
+        }
+    }
+
+    /// Consumes and leaks the `Vec`, returning a mutable reference to the contents,
+    /// `&'a mut [T]`. Note that the type `T` must outlive the chosen lifetime
+    /// `'a`. If the type has only static references, or none at all, then this
+    /// may be chosen to be `'static`.
+    ///
+    /// As of Rust 1.57, this method does not reallocate or shrink the `Vec`,
+    /// so the leaked allocation may include unused capacity that is not part
+    /// of the returned slice.
+    ///
+    /// This function is mainly useful for data that lives for the remainder of
+    /// the program's life. Dropping the returned reference will cause a memory
+    /// leak.
+    ///
+    /// # Examples
+    ///
+    /// Simple usage:
+    ///
+    /// ```
+    /// let x = vec![1, 2, 3];
+    /// let static_ref: &'static mut [usize] = x.leak();
+    /// static_ref[0] += 1;
+    /// assert_eq!(static_ref, &[2, 2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_leak", since = "1.47.0")]
+    #[inline]
+    pub fn leak<'a>(self) -> &'a mut [T]
+    where
+        A: 'a,
+    {
+        let mut me = ManuallyDrop::new(self);
+        unsafe { slice::from_raw_parts_mut(me.as_mut_ptr(), me.len) }
+    }
+
+    /// Returns the remaining spare capacity of the vector as a slice of
+    /// `MaybeUninit<T>`.
+    ///
+    /// The returned slice can be used to fill the vector with data (e.g. by
+    /// reading from a file) before marking the data as initialized using the
+    /// [`set_len`] method.
+    ///
+    /// [`set_len`]: Vec::set_len
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_spare_capacity, maybe_uninit_extra)]
+    ///
+    /// // Allocate vector big enough for 10 elements.
+    /// let mut v = Vec::with_capacity(10);
+    ///
+    /// // Fill in the first 3 elements.
+    /// let uninit = v.spare_capacity_mut();
+    /// uninit[0].write(0);
+    /// uninit[1].write(1);
+    /// uninit[2].write(2);
+    ///
+    /// // Mark the first 3 elements of the vector as being initialized.
+    /// unsafe {
+    ///     v.set_len(3);
+    /// }
+    ///
+    /// assert_eq!(&v, &[0, 1, 2]);
+    /// ```
+    #[unstable(feature = "vec_spare_capacity", issue = "75017")]
+    #[inline]
+    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // Note:
+        // This method is not implemented in terms of `split_at_spare_mut`,
+        // to prevent invalidation of pointers to the buffer.
+        unsafe {
+            slice::from_raw_parts_mut(
+                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
+                self.buf.capacity() - self.len,
+            )
+        }
+    }
+
+    /// Returns vector content as a slice of `T`, along with the remaining spare
+    /// capacity of the vector as a slice of `MaybeUninit<T>`.
+    ///
+    /// The returned spare capacity slice can be used to fill the vector with data
+    /// (e.g. by reading from a file) before marking the data as initialized using
+    /// the [`set_len`] method.
+    ///
+    /// [`set_len`]: Vec::set_len
+    ///
+    /// Note that this is a low-level API, which should be used with care for
+    /// optimization purposes. If you need to append data to a `Vec`
+    /// you can use [`push`], [`extend`], [`extend_from_slice`],
+    /// [`extend_from_within`], [`insert`], [`append`], [`resize`] or
+    /// [`resize_with`], depending on your exact needs.
+    ///
+    /// [`push`]: Vec::push
+    /// [`extend`]: Vec::extend
+    /// [`extend_from_slice`]: Vec::extend_from_slice
+    /// [`extend_from_within`]: Vec::extend_from_within
+    /// [`insert`]: Vec::insert
+    /// [`append`]: Vec::append
+    /// [`resize`]: Vec::resize
+    /// [`resize_with`]: Vec::resize_with
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_split_at_spare, maybe_uninit_extra)]
+    ///
+    /// let mut v = vec![1, 1, 2];
+    ///
+    /// // Reserve additional space big enough for 10 elements.
+    /// v.reserve(10);
+    ///
+    /// let (init, uninit) = v.split_at_spare_mut();
+    /// let sum = init.iter().copied().sum::<u32>();
+    ///
+    /// // Fill in the next 4 elements.
+    /// uninit[0].write(sum);
+    /// uninit[1].write(sum * 2);
+    /// uninit[2].write(sum * 3);
+    /// uninit[3].write(sum * 4);
+    ///
+    /// // Mark the 4 elements of the vector as being initialized.
+    /// unsafe {
+    ///     let len = v.len();
+    ///     v.set_len(len + 4);
+    /// }
+    ///
+    /// assert_eq!(&v, &[1, 1, 2, 4, 8, 12, 16]);
+    /// ```
+    #[unstable(feature = "vec_split_at_spare", issue = "81944")]
+    #[inline]
+    pub fn split_at_spare_mut(&mut self) -> (&mut [T], &mut [MaybeUninit<T>]) {
+        // SAFETY:
+        // - len is ignored and so never changed
+        let (init, spare, _) = unsafe { self.split_at_spare_mut_with_len() };
+        (init, spare)
+    }
+
+    /// Safety: changing returned .2 (&mut usize) is considered the same as calling `.set_len(_)`.
+    ///
+    /// This method provides unique access to all vec parts at once in `extend_from_within`.
+    unsafe fn split_at_spare_mut_with_len(
+        &mut self,
+    ) -> (&mut [T], &mut [MaybeUninit<T>], &mut usize) {
+        let Range { start: ptr, end: spare_ptr } = self.as_mut_ptr_range();
+        let spare_ptr = spare_ptr.cast::<MaybeUninit<T>>();
+        let spare_len = self.buf.capacity() - self.len;
+
+        // SAFETY:
+        // - `ptr` is guaranteed to be valid for `len` elements
+        // - `spare_ptr` is pointing one element past the buffer, so it doesn't overlap with `initialized`
+        unsafe {
+            let initialized = slice::from_raw_parts_mut(ptr, self.len);
+            let spare = slice::from_raw_parts_mut(spare_ptr, spare_len);
+
+            (initialized, spare, &mut self.len)
+        }
+    }
+}
+
+impl<T: Clone, A: Allocator> Vec<T, A> {
+    /// Resizes the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with `value`.
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method requires `T` to implement [`Clone`],
+    /// in order to be able to clone the passed value.
+    /// If you need more flexibility (or want to rely on [`Default`] instead of
+    /// [`Clone`]), use [`Vec::resize_with`].
+    /// If you only need to resize to a smaller size, use [`Vec::truncate`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["hello"];
+    /// vec.resize(3, "world");
+    /// assert_eq!(vec, ["hello", "world", "world"]);
+    ///
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.resize(2, 0);
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_resize", since = "1.5.0")]
+    pub fn resize(&mut self, new_len: usize, value: T) {
+        let len = self.len();
+
+        if new_len > len {
+            self.extend_with(new_len - len, ExtendElement(value))
+        } else {
+            self.truncate(new_len);
+        }
+    }
+
+    /// Tries to resize the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with `value`.
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method requires `T` to implement [`Clone`],
+    /// in order to be able to clone the passed value.
+    /// If you need more flexibility (or want to rely on [`Default`] instead of
+    /// [`Clone`]), use [`Vec::resize_with`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["hello"];
+    /// vec.try_resize(3, "world").unwrap();
+    /// assert_eq!(vec, ["hello", "world", "world"]);
+    ///
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.try_resize(2, 0).unwrap();
+    /// assert_eq!(vec, [1, 2]);
+    ///
+    /// let mut vec = vec![42];
+    /// let result = vec.try_resize(usize::MAX, 0);
+    /// assert!(result.is_err());
+    /// ```
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_resize(&mut self, new_len: usize, value: T) -> Result<(), TryReserveError> {
+        let len = self.len();
+
+        if new_len > len {
+            self.try_extend_with(new_len - len, ExtendElement(value))
+        } else {
+            self.truncate(new_len);
+            Ok(())
+        }
+    }
+
+    /// Clones and appends all elements in a slice to the `Vec`.
+    ///
+    /// Iterates over the slice `other`, clones each element, and then appends
+    /// it to this `Vec`. The `other` vector is traversed in-order.
+    ///
+    /// Note that this function is same as [`extend`] except that it is
+    /// specialized to work with slices instead. If and when Rust gets
+    /// specialization this function will likely be deprecated (but still
+    /// available).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.extend_from_slice(&[2, 3, 4]);
+    /// assert_eq!(vec, [1, 2, 3, 4]);
+    /// ```
+    ///
+    /// [`extend`]: Vec::extend
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_extend_from_slice", since = "1.6.0")]
+    pub fn extend_from_slice(&mut self, other: &[T]) {
+        self.spec_extend(other.iter())
+    }
+
+    /// Tries to clone and append all elements in a slice to the `Vec`.
+    ///
+    /// Iterates over the slice `other`, clones each element, and then appends
+    /// it to this `Vec`. The `other` vector is traversed in-order.
+    ///
+    /// Note that this function is same as [`extend`] except that it is
+    /// specialized to work with slices instead. If and when Rust gets
+    /// specialization this function will likely be deprecated (but still
+    /// available).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.try_extend_from_slice(&[2, 3, 4]).unwrap();
+    /// assert_eq!(vec, [1, 2, 3, 4]);
+    /// ```
+    ///
+    /// [`extend`]: Vec::extend
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError> {
+        self.try_spec_extend(other.iter())
+    }
+
+    /// Copies elements from `src` range to the end of the vector.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![0, 1, 2, 3, 4];
+    ///
+    /// vec.extend_from_within(2..);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4]);
+    ///
+    /// vec.extend_from_within(..2);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4, 0, 1]);
+    ///
+    /// vec.extend_from_within(4..8);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4, 0, 1, 4, 2, 3, 4]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_extend_from_within", since = "1.53.0")]
+    pub fn extend_from_within<R>(&mut self, src: R)
+    where
+        R: RangeBounds<usize>,
+    {
+        let range = slice::range(src, ..self.len());
+        self.reserve(range.len());
+
+        // SAFETY:
+        // - `slice::range` guarantees  that the given range is valid for indexing self
+        unsafe {
+            self.spec_extend_from_within(range);
+        }
+    }
+}
+
+// This code generalizes `extend_with_{element,default}`.
+trait ExtendWith<T> {
+    fn next(&mut self) -> T;
+    fn last(self) -> T;
+}
+
+struct ExtendElement<T>(T);
+impl<T: Clone> ExtendWith<T> for ExtendElement<T> {
+    fn next(&mut self) -> T {
+        self.0.clone()
+    }
+    fn last(self) -> T {
+        self.0
+    }
+}
+
+struct ExtendDefault;
+impl<T: Default> ExtendWith<T> for ExtendDefault {
+    fn next(&mut self) -> T {
+        Default::default()
+    }
+    fn last(self) -> T {
+        Default::default()
+    }
+}
+
+struct ExtendFunc<F>(F);
+impl<T, F: FnMut() -> T> ExtendWith<T> for ExtendFunc<F> {
+    fn next(&mut self) -> T {
+        (self.0)()
+    }
+    fn last(mut self) -> T {
+        (self.0)()
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    #[cfg(not(no_global_oom_handling))]
+    /// Extend the vector by `n` values, using the given generator.
+    fn extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) {
+        self.reserve(n);
+
+        unsafe {
+            let mut ptr = self.as_mut_ptr().add(self.len());
+            // Use SetLenOnDrop to work around bug where compiler
+            // might not realize the store through `ptr` through self.set_len()
+            // don't alias.
+            let mut local_len = SetLenOnDrop::new(&mut self.len);
+
+            // Write all elements except the last one
+            for _ in 1..n {
+                ptr::write(ptr, value.next());
+                ptr = ptr.offset(1);
+                // Increment the length in every step in case next() panics
+                local_len.increment_len(1);
+            }
+
+            if n > 0 {
+                // We can write the last element directly without cloning needlessly
+                ptr::write(ptr, value.last());
+                local_len.increment_len(1);
+            }
+
+            // len set by scope guard
+        }
+    }
+
+    /// Try to extend the vector by `n` values, using the given generator.
+    fn try_extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) -> Result<(), TryReserveError> {
+        self.try_reserve(n)?;
+
+        unsafe {
+            let mut ptr = self.as_mut_ptr().add(self.len());
+            // Use SetLenOnDrop to work around bug where compiler
+            // might not realize the store through `ptr` through self.set_len()
+            // don't alias.
+            let mut local_len = SetLenOnDrop::new(&mut self.len);
+
+            // Write all elements except the last one
+            for _ in 1..n {
+                ptr::write(ptr, value.next());
+                ptr = ptr.offset(1);
+                // Increment the length in every step in case next() panics
+                local_len.increment_len(1);
+            }
+
+            if n > 0 {
+                // We can write the last element directly without cloning needlessly
+                ptr::write(ptr, value.last());
+                local_len.increment_len(1);
+            }
+
+            // len set by scope guard
+            Ok(())
+        }
+    }
+}
+
+impl<T: PartialEq, A: Allocator> Vec<T, A> {
+    /// Removes consecutive repeated elements in the vector according to the
+    /// [`PartialEq`] trait implementation.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 2, 3, 2];
+    ///
+    /// vec.dedup();
+    ///
+    /// assert_eq!(vec, [1, 2, 3, 2]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn dedup(&mut self) {
+        self.dedup_by(|a, b| a == b)
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Internal methods and functions
+////////////////////////////////////////////////////////////////////////////////
+
+#[doc(hidden)]
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub fn from_elem<T: Clone>(elem: T, n: usize) -> Vec<T> {
+    <T as SpecFromElem>::from_elem(elem, n, Global)
+}
+
+#[doc(hidden)]
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "allocator_api", issue = "32838")]
+pub fn from_elem_in<T: Clone, A: Allocator>(elem: T, n: usize, alloc: A) -> Vec<T, A> {
+    <T as SpecFromElem>::from_elem(elem, n, alloc)
+}
+
+trait ExtendFromWithinSpec {
+    /// # Safety
+    ///
+    /// - `src` needs to be valid index
+    /// - `self.capacity() - self.len()` must be `>= src.len()`
+    unsafe fn spec_extend_from_within(&mut self, src: Range<usize>);
+}
+
+impl<T: Clone, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
+    default unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
+        // SAFETY:
+        // - len is increased only after initializing elements
+        let (this, spare, len) = unsafe { self.split_at_spare_mut_with_len() };
+
+        // SAFETY:
+        // - caller guaratees that src is a valid index
+        let to_clone = unsafe { this.get_unchecked(src) };
+
+        iter::zip(to_clone, spare)
+            .map(|(src, dst)| dst.write(src.clone()))
+            // Note:
+            // - Element was just initialized with `MaybeUninit::write`, so it's ok to increase len
+            // - len is increased after each element to prevent leaks (see issue #82533)
+            .for_each(|_| *len += 1);
+    }
+}
+
+impl<T: Copy, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
+    unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
+        let count = src.len();
+        {
+            let (init, spare) = self.split_at_spare_mut();
+
+            // SAFETY:
+            // - caller guaratees that `src` is a valid index
+            let source = unsafe { init.get_unchecked(src) };
+
+            // SAFETY:
+            // - Both pointers are created from unique slice references (`&mut [_]`)
+            //   so they are valid and do not overlap.
+            // - Elements are :Copy so it's OK to to copy them, without doing
+            //   anything with the original values
+            // - `count` is equal to the len of `source`, so source is valid for
+            //   `count` reads
+            // - `.reserve(count)` guarantees that `spare.len() >= count` so spare
+            //   is valid for `count` writes
+            unsafe { ptr::copy_nonoverlapping(source.as_ptr(), spare.as_mut_ptr() as _, count) };
+        }
+
+        // SAFETY:
+        // - The elements were just initialized by `copy_nonoverlapping`
+        self.len += count;
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Common trait implementations for Vec
+////////////////////////////////////////////////////////////////////////////////
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ops::Deref for Vec<T, A> {
+    type Target = [T];
+
+    fn deref(&self) -> &[T] {
+        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ops::DerefMut for Vec<T, A> {
+    fn deref_mut(&mut self) -> &mut [T] {
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+trait SpecCloneFrom {
+    fn clone_from(this: &mut Self, other: &Self);
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Clone, A: Allocator> SpecCloneFrom for Vec<T, A> {
+    default fn clone_from(this: &mut Self, other: &Self) {
+        // drop anything that will not be overwritten
+        this.truncate(other.len());
+
+        // self.len <= other.len due to the truncate above, so the
+        // slices here are always in-bounds.
+        let (init, tail) = other.split_at(this.len());
+
+        // reuse the contained values' allocations/resources.
+        this.clone_from_slice(init);
+        this.extend_from_slice(tail);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Copy, A: Allocator> SpecCloneFrom for Vec<T, A> {
+    fn clone_from(this: &mut Self, other: &Self) {
+        this.clear();
+        this.extend_from_slice(other);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Vec<T, A> {
+    #[cfg(not(test))]
+    fn clone(&self) -> Self {
+        let alloc = self.allocator().clone();
+        <[T]>::to_vec_in(&**self, alloc)
+    }
+
+    // HACK(japaric): with cfg(test) the inherent `[T]::to_vec` method, which is
+    // required for this method definition, is not available. Instead use the
+    // `slice::to_vec`  function which is only available with cfg(test)
+    // NB see the slice::hack module in slice.rs for more information
+    #[cfg(test)]
+    fn clone(&self) -> Self {
+        let alloc = self.allocator().clone();
+        crate::slice::to_vec(&**self, alloc)
+    }
+
+    fn clone_from(&mut self, other: &Self) {
+        SpecCloneFrom::clone_from(self, other)
+    }
+}
+
+/// The hash of a vector is the same as that of the corresponding slice,
+/// as required by the `core::borrow::Borrow` implementation.
+///
+/// ```
+/// #![feature(build_hasher_simple_hash_one)]
+/// use std::hash::BuildHasher;
+///
+/// let b = std::collections::hash_map::RandomState::new();
+/// let v: Vec<u8> = vec![0xa8, 0x3c, 0x09];
+/// let s: &[u8] = &[0xa8, 0x3c, 0x09];
+/// assert_eq!(b.hash_one(v), b.hash_one(s));
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Hash, A: Allocator> Hash for Vec<T, A> {
+    #[inline]
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        Hash::hash(&**self, state)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_on_unimplemented(
+    message = "vector indices are of type `usize` or ranges of `usize`",
+    label = "vector indices are of type `usize` or ranges of `usize`"
+)]
+impl<T, I: SliceIndex<[T]>, A: Allocator> Index<I> for Vec<T, A> {
+    type Output = I::Output;
+
+    #[inline]
+    fn index(&self, index: I) -> &Self::Output {
+        Index::index(&**self, index)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_on_unimplemented(
+    message = "vector indices are of type `usize` or ranges of `usize`",
+    label = "vector indices are of type `usize` or ranges of `usize`"
+)]
+impl<T, I: SliceIndex<[T]>, A: Allocator> IndexMut<I> for Vec<T, A> {
+    #[inline]
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> FromIterator<T> for Vec<T> {
+    #[inline]
+    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Vec<T> {
+        <Self as SpecFromIter<T, I::IntoIter>>::from_iter(iter.into_iter())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> IntoIterator for Vec<T, A> {
+    type Item = T;
+    type IntoIter = IntoIter<T, A>;
+
+    /// Creates a consuming iterator, that is, one that moves each value out of
+    /// the vector (from start to end). The vector cannot be used after calling
+    /// this.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = vec!["a".to_string(), "b".to_string()];
+    /// for s in v.into_iter() {
+    ///     // s has type String, not &String
+    ///     println!("{}", s);
+    /// }
+    /// ```
+    #[inline]
+    fn into_iter(self) -> IntoIter<T, A> {
+        unsafe {
+            let mut me = ManuallyDrop::new(self);
+            let alloc = ptr::read(me.allocator());
+            let begin = me.as_mut_ptr();
+            let end = if mem::size_of::<T>() == 0 {
+                arith_offset(begin as *const i8, me.len() as isize) as *const T
+            } else {
+                begin.add(me.len()) as *const T
+            };
+            let cap = me.buf.capacity();
+            IntoIter {
+                buf: NonNull::new_unchecked(begin),
+                phantom: PhantomData,
+                cap,
+                alloc,
+                ptr: begin,
+                end,
+            }
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, T, A: Allocator> IntoIterator for &'a Vec<T, A> {
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    fn into_iter(self) -> slice::Iter<'a, T> {
+        self.iter()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A> {
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    fn into_iter(self) -> slice::IterMut<'a, T> {
+        self.iter_mut()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> Extend<T> for Vec<T, A> {
+    #[inline]
+    fn extend<I: IntoIterator<Item = T>>(&mut self, iter: I) {
+        <Self as SpecExtend<T, I::IntoIter>>::spec_extend(self, iter.into_iter())
+    }
+
+    #[inline]
+    fn extend_one(&mut self, item: T) {
+        self.push(item);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    // leaf method to which various SpecFrom/SpecExtend implementations delegate when
+    // they have no further optimizations to apply
+    #[cfg(not(no_global_oom_handling))]
+    fn extend_desugared<I: Iterator<Item = T>>(&mut self, mut iterator: I) {
+        // This is the case for a general iterator.
+        //
+        // This function should be the moral equivalent of:
+        //
+        //      for item in iterator {
+        //          self.push(item);
+        //      }
+        while let Some(element) = iterator.next() {
+            let len = self.len();
+            if len == self.capacity() {
+                let (lower, _) = iterator.size_hint();
+                self.reserve(lower.saturating_add(1));
+            }
+            unsafe {
+                ptr::write(self.as_mut_ptr().add(len), element);
+                // Since next() executes user code which can panic we have to bump the length
+                // after each step.
+                // NB can't overflow since we would have had to alloc the address space
+                self.set_len(len + 1);
+            }
+        }
+    }
+
+    // leaf method to which various SpecFrom/SpecExtend implementations delegate when
+    // they have no further optimizations to apply
+    fn try_extend_desugared<I: Iterator<Item = T>>(&mut self, mut iterator: I) -> Result<(), TryReserveError> {
+        // This is the case for a general iterator.
+        //
+        // This function should be the moral equivalent of:
+        //
+        //      for item in iterator {
+        //          self.push(item);
+        //      }
+        while let Some(element) = iterator.next() {
+            let len = self.len();
+            if len == self.capacity() {
+                let (lower, _) = iterator.size_hint();
+                self.try_reserve(lower.saturating_add(1))?;
+            }
+            unsafe {
+                ptr::write(self.as_mut_ptr().add(len), element);
+                // NB can't overflow since we would have had to alloc the address space
+                self.set_len(len + 1);
+            }
+        }
+
+        Ok(())
+    }
+
+    /// Creates a splicing iterator that replaces the specified range in the vector
+    /// with the given `replace_with` iterator and yields the removed items.
+    /// `replace_with` does not need to be the same length as `range`.
+    ///
+    /// `range` is removed even if the iterator is not consumed until the end.
+    ///
+    /// It is unspecified how many elements are removed from the vector
+    /// if the `Splice` value is leaked.
+    ///
+    /// The input iterator `replace_with` is only consumed when the `Splice` value is dropped.
+    ///
+    /// This is optimal if:
+    ///
+    /// * The tail (elements in the vector after `range`) is empty,
+    /// * or `replace_with` yields fewer or equal elements than `range`’s length
+    /// * or the lower bound of its `size_hint()` is exact.
+    ///
+    /// Otherwise, a temporary vector is allocated and the tail is moved twice.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    /// let new = [7, 8];
+    /// let u: Vec<_> = v.splice(..2, new).collect();
+    /// assert_eq!(v, &[7, 8, 3]);
+    /// assert_eq!(u, &[1, 2]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "vec_splice", since = "1.21.0")]
+    pub fn splice<R, I>(&mut self, range: R, replace_with: I) -> Splice<'_, I::IntoIter, A>
+    where
+        R: RangeBounds<usize>,
+        I: IntoIterator<Item = T>,
+    {
+        Splice { drain: self.drain(range), replace_with: replace_with.into_iter() }
+    }
+
+    /// Creates an iterator which uses a closure to determine if an element should be removed.
+    ///
+    /// If the closure returns true, then the element is removed and yielded.
+    /// If the closure returns false, the element will remain in the vector and will not be yielded
+    /// by the iterator.
+    ///
+    /// Using this method is equivalent to the following code:
+    ///
+    /// ```
+    /// # let some_predicate = |x: &mut i32| { *x == 2 || *x == 3 || *x == 6 };
+    /// # let mut vec = vec![1, 2, 3, 4, 5, 6];
+    /// let mut i = 0;
+    /// while i < vec.len() {
+    ///     if some_predicate(&mut vec[i]) {
+    ///         let val = vec.remove(i);
+    ///         // your code here
+    ///     } else {
+    ///         i += 1;
+    ///     }
+    /// }
+    ///
+    /// # assert_eq!(vec, vec![1, 4, 5]);
+    /// ```
+    ///
+    /// But `drain_filter` is easier to use. `drain_filter` is also more efficient,
+    /// because it can backshift the elements of the array in bulk.
+    ///
+    /// Note that `drain_filter` also lets you mutate every element in the filter closure,
+    /// regardless of whether you choose to keep or remove it.
+    ///
+    /// # Examples
+    ///
+    /// Splitting an array into evens and odds, reusing the original allocation:
+    ///
+    /// ```
+    /// #![feature(drain_filter)]
+    /// let mut numbers = vec![1, 2, 3, 4, 5, 6, 8, 9, 11, 13, 14, 15];
+    ///
+    /// let evens = numbers.drain_filter(|x| *x % 2 == 0).collect::<Vec<_>>();
+    /// let odds = numbers;
+    ///
+    /// assert_eq!(evens, vec![2, 4, 6, 8, 14]);
+    /// assert_eq!(odds, vec![1, 3, 5, 9, 11, 13, 15]);
+    /// ```
+    #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+    pub fn drain_filter<F>(&mut self, filter: F) -> DrainFilter<'_, T, F, A>
+    where
+        F: FnMut(&mut T) -> bool,
+    {
+        let old_len = self.len();
+
+        // Guard against us getting leaked (leak amplification)
+        unsafe {
+            self.set_len(0);
+        }
+
+        DrainFilter { vec: self, idx: 0, del: 0, old_len, pred: filter, panic_flag: false }
+    }
+}
+
+/// Extend implementation that copies elements out of references before pushing them onto the Vec.
+///
+/// This implementation is specialized for slice iterators, where it uses [`copy_from_slice`] to
+/// append the entire slice at once.
+///
+/// [`copy_from_slice`]: slice::copy_from_slice
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "extend_ref", since = "1.2.0")]
+impl<'a, T: Copy + 'a, A: Allocator + 'a> Extend<&'a T> for Vec<T, A> {
+    fn extend<I: IntoIterator<Item = &'a T>>(&mut self, iter: I) {
+        self.spec_extend(iter.into_iter())
+    }
+
+    #[inline]
+    fn extend_one(&mut self, &item: &'a T) {
+        self.push(item);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+/// Implements comparison of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: PartialOrd, A: Allocator> PartialOrd for Vec<T, A> {
+    #[inline]
+    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Eq, A: Allocator> Eq for Vec<T, A> {}
+
+/// Implements ordering of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Ord, A: Allocator> Ord for Vec<T, A> {
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for Vec<T, A> {
+    fn drop(&mut self) {
+        unsafe {
+            // use drop for [T]
+            // use a raw slice to refer to the elements of the vector as weakest necessary type;
+            // could avoid questions of validity in certain cases
+            ptr::drop_in_place(ptr::slice_from_raw_parts_mut(self.as_mut_ptr(), self.len))
+        }
+        // RawVec handles deallocation
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
+impl<T> const Default for Vec<T> {
+    /// Creates an empty `Vec<T>`.
+    fn default() -> Vec<T> {
+        Vec::new()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> AsRef<Vec<T, A>> for Vec<T, A> {
+    fn as_ref(&self) -> &Vec<T, A> {
+        self
+    }
+}
+
+#[stable(feature = "vec_as_mut", since = "1.5.0")]
+impl<T, A: Allocator> AsMut<Vec<T, A>> for Vec<T, A> {
+    fn as_mut(&mut self) -> &mut Vec<T, A> {
+        self
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> AsRef<[T]> for Vec<T, A> {
+    fn as_ref(&self) -> &[T] {
+        self
+    }
+}
+
+#[stable(feature = "vec_as_mut", since = "1.5.0")]
+impl<T, A: Allocator> AsMut<[T]> for Vec<T, A> {
+    fn as_mut(&mut self) -> &mut [T] {
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone> From<&[T]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&[1, 2, 3][..]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(not(test))]
+    fn from(s: &[T]) -> Vec<T> {
+        s.to_vec()
+    }
+    #[cfg(test)]
+    fn from(s: &[T]) -> Vec<T> {
+        crate::slice::to_vec(s, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_mut", since = "1.19.0")]
+impl<T: Clone> From<&mut [T]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&mut [1, 2, 3][..]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(not(test))]
+    fn from(s: &mut [T]) -> Vec<T> {
+        s.to_vec()
+    }
+    #[cfg(test)]
+    fn from(s: &mut [T]) -> Vec<T> {
+        crate::slice::to_vec(s, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_array", since = "1.44.0")]
+impl<T, const N: usize> From<[T; N]> for Vec<T> {
+    #[cfg(not(test))]
+    fn from(s: [T; N]) -> Vec<T> {
+        <[T]>::into_vec(box s)
+    }
+    /// Allocate a `Vec<T>` and move `s`'s items into it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from([1, 2, 3]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(test)]
+    fn from(s: [T; N]) -> Vec<T> {
+        crate::slice::into_vec(box s)
+    }
+}
+
+#[stable(feature = "vec_from_cow_slice", since = "1.14.0")]
+impl<'a, T> From<Cow<'a, [T]>> for Vec<T>
+where
+    [T]: ToOwned<Owned = Vec<T>>,
+{
+    /// Convert a clone-on-write slice into a vector.
+    ///
+    /// If `s` already owns a `Vec<T>`, it will be returned directly.
+    /// If `s` is borrowing a slice, a new `Vec<T>` will be allocated and
+    /// filled by cloning `s`'s items into it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// let o: Cow<[i32]> = Cow::Owned(vec![1, 2, 3]);
+    /// let b: Cow<[i32]> = Cow::Borrowed(&[1, 2, 3]);
+    /// assert_eq!(Vec::from(o), Vec::from(b));
+    /// ```
+    fn from(s: Cow<'a, [T]>) -> Vec<T> {
+        s.into_owned()
+    }
+}
+
+// note: test pulls in libstd, which causes errors here
+#[cfg(not(test))]
+#[stable(feature = "vec_from_box", since = "1.18.0")]
+impl<T, A: Allocator> From<Box<[T], A>> for Vec<T, A> {
+    /// Convert a boxed slice into a vector by transferring ownership of
+    /// the existing heap allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b: Box<[i32]> = vec![1, 2, 3].into_boxed_slice();
+    /// assert_eq!(Vec::from(b), vec![1, 2, 3]);
+    /// ```
+    fn from(s: Box<[T], A>) -> Self {
+        s.into_vec()
+    }
+}
+
+// note: test pulls in libstd, which causes errors here
+#[cfg(not(no_global_oom_handling))]
+#[cfg(not(test))]
+#[stable(feature = "box_from_vec", since = "1.20.0")]
+impl<T, A: Allocator> From<Vec<T, A>> for Box<[T], A> {
+    /// Convert a vector into a boxed slice.
+    ///
+    /// If `v` has excess capacity, its items will be moved into a
+    /// newly-allocated buffer with exactly the right capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Box::from(vec![1, 2, 3]), vec![1, 2, 3].into_boxed_slice());
+    /// ```
+    fn from(v: Vec<T, A>) -> Self {
+        v.into_boxed_slice()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl From<&str> for Vec<u8> {
+    /// Allocate a `Vec<u8>` and fill it with a UTF-8 string.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from("123"), vec![b'1', b'2', b'3']);
+    /// ```
+    fn from(s: &str) -> Vec<u8> {
+        From::from(s.as_bytes())
+    }
+}
+
+#[stable(feature = "array_try_from_vec", since = "1.48.0")]
+impl<T, A: Allocator, const N: usize> TryFrom<Vec<T, A>> for [T; N] {
+    type Error = Vec<T, A>;
+
+    /// Gets the entire contents of the `Vec<T>` as an array,
+    /// if its size exactly matches that of the requested array.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::convert::TryInto;
+    /// assert_eq!(vec![1, 2, 3].try_into(), Ok([1, 2, 3]));
+    /// assert_eq!(<Vec<i32>>::new().try_into(), Ok([]));
+    /// ```
+    ///
+    /// If the length doesn't match, the input comes back in `Err`:
+    /// ```
+    /// use std::convert::TryInto;
+    /// let r: Result<[i32; 4], _> = (0..10).collect::<Vec<_>>().try_into();
+    /// assert_eq!(r, Err(vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
+    /// ```
+    ///
+    /// If you're fine with just getting a prefix of the `Vec<T>`,
+    /// you can call [`.truncate(N)`](Vec::truncate) first.
+    /// ```
+    /// use std::convert::TryInto;
+    /// let mut v = String::from("hello world").into_bytes();
+    /// v.sort();
+    /// v.truncate(2);
+    /// let [a, b]: [_; 2] = v.try_into().unwrap();
+    /// assert_eq!(a, b' ');
+    /// assert_eq!(b, b'd');
+    /// ```
+    fn try_from(mut vec: Vec<T, A>) -> Result<[T; N], Vec<T, A>> {
+        if vec.len() != N {
+            return Err(vec);
+        }
+
+        // SAFETY: `.set_len(0)` is always sound.
+        unsafe { vec.set_len(0) };
+
+        // SAFETY: A `Vec`'s pointer is always aligned properly, and
+        // the alignment the array needs is the same as the items.
+        // We checked earlier that we have sufficient items.
+        // The items will not double-drop as the `set_len`
+        // tells the `Vec` not to also drop them.
+        let array = unsafe { ptr::read(vec.as_ptr() as *const [T; N]) };
+        Ok(array)
+    }
+}
diff --git a/rust/alloc/vec/partial_eq.rs b/rust/alloc/vec/partial_eq.rs
new file mode 100644
index 000000000000..273e99bed488
--- /dev/null
+++ b/rust/alloc/vec/partial_eq.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::Allocator;
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::Cow;
+
+use super::Vec;
+
+macro_rules! __impl_slice_eq1 {
+    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?, #[$stability:meta]) => {
+        #[$stability]
+        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
+        where
+            T: PartialEq<U>,
+            $($ty: $bound)?
+        {
+            #[inline]
+            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
+            #[inline]
+            fn ne(&self, other: &$rhs) -> bool { self[..] != other[..] }
+        }
+    }
+}
+
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, Vec<U, A>, #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, &[U], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, &mut [U], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] &[T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_ref_slice", since = "1.46.0")] }
+__impl_slice_eq1! { [A: Allocator] &mut [T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_ref_slice", since = "1.46.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, [U], #[stable(feature = "partialeq_vec_for_slice", since = "1.48.0")]  }
+__impl_slice_eq1! { [A: Allocator] [T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_slice", since = "1.48.0")]  }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [A: Allocator] Cow<'_, [T]>, Vec<U, A> where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [] Cow<'_, [T]>, &[U] where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [] Cow<'_, [T]>, &mut [U] where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator, const N: usize] Vec<T, A>, [U; N], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N], #[stable(feature = "rust1", since = "1.0.0")] }
+
+// NOTE: some less important impls are omitted to reduce code bloat
+// FIXME(Centril): Reconsider this?
+//__impl_slice_eq1! { [const N: usize] Vec<A>, &mut [B; N], }
+//__impl_slice_eq1! { [const N: usize] [A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] &[A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] &mut [A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, [B; N], }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, &[B; N], }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, &mut [B; N], }
diff --git a/rust/alloc/vec/set_len_on_drop.rs b/rust/alloc/vec/set_len_on_drop.rs
new file mode 100644
index 000000000000..448bf5076a0b
--- /dev/null
+++ b/rust/alloc/vec/set_len_on_drop.rs
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+// Set the length of the vec when the `SetLenOnDrop` value goes out of scope.
+//
+// The idea is: The length field in SetLenOnDrop is a local variable
+// that the optimizer will see does not alias with any stores through the Vec's data
+// pointer. This is a workaround for alias analysis issue #32155
+pub(super) struct SetLenOnDrop<'a> {
+    len: &'a mut usize,
+    local_len: usize,
+}
+
+impl<'a> SetLenOnDrop<'a> {
+    #[inline]
+    pub(super) fn new(len: &'a mut usize) -> Self {
+        SetLenOnDrop { local_len: *len, len }
+    }
+
+    #[inline]
+    pub(super) fn increment_len(&mut self, increment: usize) {
+        self.local_len += increment;
+    }
+}
+
+impl Drop for SetLenOnDrop<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        *self.len = self.local_len;
+    }
+}
diff --git a/rust/alloc/vec/spec_extend.rs b/rust/alloc/vec/spec_extend.rs
new file mode 100644
index 000000000000..01a9ca0d261c
--- /dev/null
+++ b/rust/alloc/vec/spec_extend.rs
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::Allocator;
+use crate::collections::{TryReserveError, TryReserveErrorKind};
+use core::iter::TrustedLen;
+use core::ptr::{self};
+use core::slice::{self};
+
+use super::{IntoIter, SetLenOnDrop, Vec};
+
+// Specialization trait used for Vec::extend
+#[cfg(not(no_global_oom_handling))]
+pub(super) trait SpecExtend<T, I> {
+    fn spec_extend(&mut self, iter: I);
+}
+
+// Specialization trait used for Vec::try_extend
+pub(super) trait TrySpecExtend<T, I> {
+    fn try_spec_extend(&mut self, iter: I) -> Result<(), TryReserveError>;
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
+where
+    I: Iterator<Item = T>,
+{
+    default fn spec_extend(&mut self, iter: I) {
+        self.extend_desugared(iter)
+    }
+}
+
+impl<T, I, A: Allocator> TrySpecExtend<T, I> for Vec<T, A>
+where
+    I: Iterator<Item = T>,
+{
+    default fn try_spec_extend(&mut self, iter: I) -> Result<(), TryReserveError> {
+        self.try_extend_desugared(iter)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
+where
+    I: TrustedLen<Item = T>,
+{
+    default fn spec_extend(&mut self, iterator: I) {
+        // This is the case for a TrustedLen iterator.
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.reserve(additional);
+            unsafe {
+                let mut ptr = self.as_mut_ptr().add(self.len());
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr, element);
+                    ptr = ptr.offset(1);
+                    // Since the loop executes user code which can panic we have to bump the pointer
+                    // after each step.
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+        } else {
+            // Per TrustedLen contract a `None` upper bound means that the iterator length
+            // truly exceeds usize::MAX, which would eventually lead to a capacity overflow anyway.
+            // Since the other branch already panics eagerly (via `reserve()`) we do the same here.
+            // This avoids additional codegen for a fallback code path which would eventually
+            // panic anyway.
+            panic!("capacity overflow");
+        }
+    }
+}
+
+impl<T, I, A: Allocator> TrySpecExtend<T, I> for Vec<T, A>
+where
+    I: TrustedLen<Item = T>,
+{
+    default fn try_spec_extend(&mut self, iterator: I) -> Result<(), TryReserveError> {
+        // This is the case for a TrustedLen iterator.
+        let (low, high) = iterator.size_hint();
+        if let Some(additional) = high {
+            debug_assert_eq!(
+                low,
+                additional,
+                "TrustedLen iterator's size hint is not exact: {:?}",
+                (low, high)
+            );
+            self.try_reserve(additional)?;
+            unsafe {
+                let mut ptr = self.as_mut_ptr().add(self.len());
+                let mut local_len = SetLenOnDrop::new(&mut self.len);
+                iterator.for_each(move |element| {
+                    ptr::write(ptr, element);
+                    ptr = ptr.offset(1);
+                    // NB can't overflow since we would have had to alloc the address space
+                    local_len.increment_len(1);
+                });
+            }
+            Ok(())
+        } else {
+            Err(TryReserveErrorKind::CapacityOverflow.into())
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
+    fn spec_extend(&mut self, mut iterator: IntoIter<T>) {
+        unsafe {
+            self.append_elements(iterator.as_slice() as _);
+        }
+        iterator.ptr = iterator.end;
+    }
+}
+
+impl<T, A: Allocator> TrySpecExtend<T, IntoIter<T>> for Vec<T, A> {
+    fn try_spec_extend(&mut self, mut iterator: IntoIter<T>) -> Result<(), TryReserveError> {
+        unsafe {
+            self.try_append_elements(iterator.as_slice() as _)?;
+        }
+        iterator.ptr = iterator.end;
+        Ok(())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
+where
+    I: Iterator<Item = &'a T>,
+    T: Clone,
+{
+    default fn spec_extend(&mut self, iterator: I) {
+        self.spec_extend(iterator.cloned())
+    }
+}
+
+impl<'a, T: 'a, I, A: Allocator + 'a> TrySpecExtend<&'a T, I> for Vec<T, A>
+where
+    I: Iterator<Item = &'a T>,
+    T: Clone,
+{
+    default fn try_spec_extend(&mut self, iterator: I) -> Result<(), TryReserveError> {
+        self.try_spec_extend(iterator.cloned())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+where
+    T: Copy,
+{
+    fn spec_extend(&mut self, iterator: slice::Iter<'a, T>) {
+        let slice = iterator.as_slice();
+        unsafe { self.append_elements(slice) };
+    }
+}
+
+impl<'a, T: 'a, A: Allocator + 'a> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+where
+    T: Copy,
+{
+    fn try_spec_extend(&mut self, iterator: slice::Iter<'a, T>) -> Result<(), TryReserveError> {
+        let slice = iterator.as_slice();
+        unsafe { self.try_append_elements(slice) }
+    }
+}
-- 
2.34.0

