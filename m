Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F651E460
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445543AbiEGFbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445621AbiEGFa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BF703F5;
        Fri,  6 May 2022 22:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011B360A22;
        Sat,  7 May 2022 05:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0404BC385AE;
        Sat,  7 May 2022 05:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901187;
        bh=EUdyAMy+ZnJ5VAGIZpNhMuJJsOorwiXaPiUcWmCSMbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiECgjumCgKSYtzcwjWl3XvIIdF/B6zvWeMcznO7ahUqxm+w9PmydeWAneRAFQzc7
         +Is7UFotgbnIBjqu5bLrXZpuk9L1vxC9PE5k9gp97dj96Cearff5QwXxjeOw9awOdU
         mdQny4xnekJXPQG3/VbLQecuCArXKHkPWqMoZEkmCqDGl5vTN9I/W+JFbAJ9J0EVfh
         VPBGXq4INtUh+JQEYyz6OgiY8hTHQxckTqeDTi6NNecznNJJINf2HEp84YdBoJ4nIO
         JQSWBlDE4xohbRg6BTNlznnPwKC90tdhrAFA1PhWHtScnIeFRa8DUB9F9Ptatc2zGu
         5gKYAn6uOTZ6w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>
Subject: [PATCH v6 08/23] rust: adapt `alloc` crate to the kernel
Date:   Sat,  7 May 2022 07:24:06 +0200
Message-Id: <20220507052451.12890-9-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This customizes the subset of the Rust standard library `alloc` that
was just imported as-is, mainly by:

  - Adding SPDX license identifiers.

  - Skipping `rc` and `sync` modules via new `cfg`s.

  - Skipping the `vec!` macro.

  - Addding fallible (`try_*`) versions of existing infallible methods
    (i.e. returning a `Result` instead of panicking).

    Since the standard library requires stable/unstable attributes,
    these additions are annotated with:

        #[stable(feature = "kernel", since = "1.0.0")]

    Using "kernel" as the feature allows to have the additions
    clearly marked. The "1.0.0" version is just a placeholder.

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
 rust/alloc/README.md              |  32 +++
 rust/alloc/alloc.rs               |   2 +
 rust/alloc/borrow.rs              |   2 +
 rust/alloc/boxed.rs               |   2 +
 rust/alloc/collections/mod.rs     |   2 +
 rust/alloc/fmt.rs                 |   2 +
 rust/alloc/lib.rs                 |   5 +-
 rust/alloc/macros.rs              |   4 +-
 rust/alloc/raw_vec.rs             |  50 ++++-
 rust/alloc/slice.rs               |  93 ++++++++-
 rust/alloc/str.rs                 |  19 ++
 rust/alloc/string.rs              |   6 +-
 rust/alloc/vec/drain.rs           |   2 +
 rust/alloc/vec/drain_filter.rs    |   2 +
 rust/alloc/vec/into_iter.rs       |   2 +
 rust/alloc/vec/is_zero.rs         |   2 +
 rust/alloc/vec/mod.rs             | 313 +++++++++++++++++++++++++++++-
 rust/alloc/vec/partial_eq.rs      |   2 +
 rust/alloc/vec/set_len_on_drop.rs |   2 +
 rust/alloc/vec/spec_extend.rs     |  87 +++++++++
 20 files changed, 622 insertions(+), 9 deletions(-)
 create mode 100644 rust/alloc/README.md

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
index 9d4f9af91a5e..cea3b747673f 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Memory allocation APIs
 
 #![stable(feature = "alloc_module", since = "1.28.0")]
diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
index 63234ee91f09..8e1d8a764641 100644
--- a/rust/alloc/borrow.rs
+++ b/rust/alloc/borrow.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A module for working with borrowed data.
 
 #![stable(feature = "rust1", since = "1.0.0")]
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index f753189c6830..921fcef75e4b 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A pointer type for heap allocation.
 //!
 //! [`Box<T>`], casually referred to as a 'box', provides the simplest form of
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
index 628a5b155673..1eec265b28f8 100644
--- a/rust/alloc/collections/mod.rs
+++ b/rust/alloc/collections/mod.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Collection types.
 
 #![stable(feature = "rust1", since = "1.0.0")]
diff --git a/rust/alloc/fmt.rs b/rust/alloc/fmt.rs
index aeb7554f8e91..be75e6637442 100644
--- a/rust/alloc/fmt.rs
+++ b/rust/alloc/fmt.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Utilities for formatting and printing `String`s.
 //!
 //! This module contains the runtime support for the [`format!`] syntax extension.
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 6da32df57efb..085dc005170a 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! # The Rust core allocation and collections library
 //!
 //! This library provides smart pointers and collections for managing
@@ -204,11 +206,12 @@ mod boxed {
 pub mod borrow;
 pub mod collections;
 pub mod fmt;
+#[cfg(not(no_rc))]
 pub mod rc;
 pub mod slice;
 pub mod str;
 pub mod string;
-#[cfg(target_has_atomic = "ptr")]
+#[cfg(all(not(no_sync), target_has_atomic = "ptr"))]
 pub mod sync;
 #[cfg(all(not(no_global_oom_handling), target_has_atomic = "ptr"))]
 pub mod task;
diff --git a/rust/alloc/macros.rs b/rust/alloc/macros.rs
index d3e9e65c3fe5..47ebcd5277d1 100644
--- a/rust/alloc/macros.rs
+++ b/rust/alloc/macros.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 /// Creates a [`Vec`] containing the arguments.
 ///
 /// `vec!` allows `Vec`s to be defined with the same syntax as array expressions.
@@ -34,7 +36,7 @@
 /// be mindful of side effects.
 ///
 /// [`Vec`]: crate::vec::Vec
-#[cfg(not(test))]
+#[cfg(all(not(no_global_oom_handling), not(test)))]
 #[macro_export]
 #[stable(feature = "rust1", since = "1.0.0")]
 #[rustc_diagnostic_item = "vec_macro"]
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index 8fa0242ca9a9..018c4657f580 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 #![unstable(feature = "raw_vec_internals", reason = "unstable const warnings", issue = "none")]
 
 use core::alloc::LayoutError;
@@ -18,10 +20,10 @@ use crate::collections::TryReserveErrorKind::*;
 #[cfg(test)]
 mod tests;
 
-#[cfg(not(no_global_oom_handling))]
 enum AllocInit {
     /// The contents of the new memory are uninitialized.
     Uninitialized,
+    #[allow(dead_code)]
     /// The new memory is guaranteed to be zeroed.
     Zeroed,
 }
@@ -132,6 +134,13 @@ impl<T, A: Allocator> RawVec<T, A> {
         Self::allocate_in(capacity, AllocInit::Uninitialized, alloc)
     }
 
+    /// Like `try_with_capacity`, but parameterized over the choice of
+    /// allocator for the returned `RawVec`.
+    #[inline]
+    pub fn try_with_capacity_in(capacity: usize, alloc: A) -> Result<Self, TryReserveError> {
+        Self::try_allocate_in(capacity, AllocInit::Uninitialized, alloc)
+    }
+
     /// Like `with_capacity_zeroed`, but parameterized over the choice
     /// of allocator for the returned `RawVec`.
     #[cfg(not(no_global_oom_handling))]
@@ -201,6 +210,29 @@ impl<T, A: Allocator> RawVec<T, A> {
         }
     }
 
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
+        // Allocators currently return a `NonNull<[u8]>` whose length
+        // matches the size requested. If that ever changes, the capacity
+        // here should change to `ptr.len() / mem::size_of::<T>()`.
+        Ok(Self {
+            ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
+            cap: capacity,
+            alloc,
+        })
+    }
+
     /// Reconstitutes a `RawVec` from a pointer, capacity, and allocator.
     ///
     /// # Safety
@@ -309,6 +341,12 @@ impl<T, A: Allocator> RawVec<T, A> {
         }
     }
 
+    /// The same as `reserve_for_push`, but returns on errors instead of panicking or aborting.
+    #[inline(never)]
+    pub fn try_reserve_for_push(&mut self, len: usize) -> Result<(), TryReserveError> {
+        self.grow_amortized(len, 1)
+    }
+
     /// Ensures that the buffer contains at least enough space to hold `len +
     /// additional` elements. If it doesn't already, will reallocate the
     /// minimum possible amount of memory necessary. Generally this will be
@@ -354,6 +392,16 @@ impl<T, A: Allocator> RawVec<T, A> {
     pub fn shrink_to_fit(&mut self, cap: usize) {
         handle_reserve(self.shrink(cap));
     }
+
+    /// Tries to shrink the buffer down to the specified capacity. If the given amount
+    /// is 0, actually completely deallocates.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the given amount is *larger* than the current capacity.
+    pub fn try_shrink_to_fit(&mut self, cap: usize) -> Result<(), TryReserveError> {
+        self.shrink(cap)
+    }
 }
 
 impl<T, A: Allocator> RawVec<T, A> {
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
index f0397d08f95a..8cb5170f639d 100644
--- a/rust/alloc/slice.rs
+++ b/rust/alloc/slice.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A dynamically-sized view into a contiguous sequence, `[T]`.
 //!
 //! *[See also the slice primitive type](slice).*
@@ -93,11 +95,11 @@ use core::mem::size_of;
 use core::ptr;
 
 use crate::alloc::Allocator;
-#[cfg(not(no_global_oom_handling))]
 use crate::alloc::Global;
 #[cfg(not(no_global_oom_handling))]
 use crate::borrow::ToOwned;
 use crate::boxed::Box;
+use crate::collections::TryReserveError;
 use crate::vec::Vec;
 
 #[unstable(feature = "slice_range", issue = "76393")]
@@ -157,6 +159,7 @@ mod hack {
     use core::alloc::Allocator;
 
     use crate::boxed::Box;
+    use crate::collections::TryReserveError;
     use crate::vec::Vec;
 
     // We shouldn't add inline attribute to this since this is used in
@@ -176,6 +179,11 @@ mod hack {
         T::to_vec(s, alloc)
     }
 
+    #[inline]
+    pub fn try_to_vec<T: TryConvertVec, A: Allocator>(s: &[T], alloc: A) -> Result<Vec<T, A>, TryReserveError> {
+        T::try_to_vec(s, alloc)
+    }
+
     #[cfg(not(no_global_oom_handling))]
     pub trait ConvertVec {
         fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A>
@@ -183,6 +191,12 @@ mod hack {
             Self: Sized;
     }
 
+    pub trait TryConvertVec {
+        fn try_to_vec<A: Allocator>(s: &[Self], alloc: A) -> Result<Vec<Self, A>, TryReserveError>
+        where
+            Self: Sized;
+    }
+
     #[cfg(not(no_global_oom_handling))]
     impl<T: Clone> ConvertVec for T {
         #[inline]
@@ -235,6 +249,42 @@ mod hack {
             v
         }
     }
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
 }
 
 #[lang = "slice_alloc"]
@@ -477,6 +527,24 @@ impl<T> [T] {
         self.to_vec_in(Global)
     }
 
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
     /// Copies `self` into a new `Vec` with an allocator.
     ///
     /// # Examples
@@ -501,6 +569,29 @@ impl<T> [T] {
         hack::to_vec(self, alloc)
     }
 
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
     /// Converts `self` into a vector without clones or allocation.
     ///
     /// The resulting vector can be converted back into a box via
diff --git a/rust/alloc/str.rs b/rust/alloc/str.rs
index 69495f31c32c..a1370c2d674c 100644
--- a/rust/alloc/str.rs
+++ b/rust/alloc/str.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Unicode string slices.
 //!
 //! *[See also the `str` primitive type](str).*
@@ -36,6 +38,7 @@ use core::unicode::conversions;
 
 use crate::borrow::ToOwned;
 use crate::boxed::Box;
+use crate::collections::TryReserveError;
 use crate::slice::{Concat, Join, SliceIndex};
 use crate::string::String;
 use crate::vec::Vec;
@@ -590,6 +593,22 @@ impl str {
         // make_ascii_lowercase() preserves the UTF-8 invariant.
         unsafe { String::from_utf8_unchecked(bytes) }
     }
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
 }
 
 /// Converts a boxed slice of bytes to a boxed string slice without checking
diff --git a/rust/alloc/string.rs b/rust/alloc/string.rs
index 716bb4983a65..5b9780cfc11f 100644
--- a/rust/alloc/string.rs
+++ b/rust/alloc/string.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A UTF-8–encoded, growable string.
 //!
 //! This module contains the [`String`] type, the [`ToString`] trait for
@@ -47,8 +49,8 @@ use core::char::{decode_utf16, REPLACEMENT_CHARACTER};
 use core::fmt;
 use core::hash;
 #[cfg(not(no_global_oom_handling))]
-use core::iter::FromIterator;
-use core::iter::{from_fn, FusedIterator};
+use core::iter::{from_fn, FromIterator};
+use core::iter::FusedIterator;
 #[cfg(not(no_global_oom_handling))]
 use core::ops::Add;
 #[cfg(not(no_global_oom_handling))]
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
index 1bff19d05c10..8116ba6dfd9e 100644
--- a/rust/alloc/vec/drain.rs
+++ b/rust/alloc/vec/drain.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::{Allocator, Global};
 use core::fmt;
 use core::iter::{FusedIterator, TrustedLen};
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
index 3c37c92ae44b..b04fce041622 100644
--- a/rust/alloc/vec/drain_filter.rs
+++ b/rust/alloc/vec/drain_filter.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::{Allocator, Global};
 use core::ptr::{self};
 use core::slice::{self};
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
index f985fb78465b..11d01ac868ca 100644
--- a/rust/alloc/vec/into_iter.rs
+++ b/rust/alloc/vec/into_iter.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::{Allocator, Global};
 use crate::raw_vec::RawVec;
 use core::fmt;
diff --git a/rust/alloc/vec/is_zero.rs b/rust/alloc/vec/is_zero.rs
index 0efc4893c3c4..40e1e667c9fb 100644
--- a/rust/alloc/vec/is_zero.rs
+++ b/rust/alloc/vec/is_zero.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::boxed::Box;
 
 #[rustc_specialization_trait]
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index c29aa0fec5b8..a2b1dfca3561 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A contiguous growable array type with heap-allocated contents, written
 //! `Vec<T>`.
 //!
@@ -118,10 +120,8 @@ use self::spec_from_elem::SpecFromElem;
 #[cfg(not(no_global_oom_handling))]
 mod spec_from_elem;
 
-#[cfg(not(no_global_oom_handling))]
 use self::set_len_on_drop::SetLenOnDrop;
 
-#[cfg(not(no_global_oom_handling))]
 mod set_len_on_drop;
 
 #[cfg(not(no_global_oom_handling))]
@@ -145,7 +145,8 @@ mod spec_from_iter;
 #[cfg(not(no_global_oom_handling))]
 use self::spec_extend::SpecExtend;
 
-#[cfg(not(no_global_oom_handling))]
+use self::spec_extend::TrySpecExtend;
+
 mod spec_extend;
 
 /// A contiguous growable array type, written as `Vec<T>`, short for 'vector'.
@@ -470,6 +471,49 @@ impl<T> Vec<T> {
         Self::with_capacity_in(capacity, Global)
     }
 
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
     /// Creates a `Vec<T>` directly from the raw components of another vector.
     ///
     /// # Safety
@@ -609,6 +653,53 @@ impl<T, A: Allocator> Vec<T, A> {
         Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
     }
 
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
     /// Creates a `Vec<T, A>` directly from the raw components of another vector.
     ///
     /// # Safety
@@ -940,6 +1031,33 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
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
     /// Shrinks the capacity of the vector with a lower bound.
     ///
     /// The capacity will remain at least as large as both the length
@@ -1002,6 +1120,41 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
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
     /// Shortens the vector, keeping the first `len` elements and dropping
     /// the rest.
     ///
@@ -1735,6 +1888,29 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
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
+            self.buf.try_reserve_for_push(self.len)?;
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+        Ok(())
+    }
+
     /// Removes the last element from a vector and returns it, or [`None`] if it
     /// is empty.
     ///
@@ -1799,6 +1975,17 @@ impl<T, A: Allocator> Vec<T, A> {
         self.len += count;
     }
 
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
     /// Removes the specified range from the vector in bulk, returning all
     /// removed elements as an iterator. If the iterator is dropped before
     /// being fully consumed, it drops the remaining removed elements.
@@ -2209,6 +2396,44 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         }
     }
 
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
     /// Clones and appends all elements in a slice to the `Vec`.
     ///
     /// Iterates over the slice `other`, clones each element, and then appends
@@ -2234,6 +2459,30 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         self.spec_extend(other.iter())
     }
 
+    /// Tries to clone and append all elements in a slice to the `Vec`.
+    ///
+    /// Iterates over the slice `other`, clones each element, and then appends
+    /// it to this `Vec`. The `other` slice is traversed in-order.
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
     /// Copies elements from `src` range to the end of the vector.
     ///
     /// # Panics
@@ -2328,6 +2577,36 @@ impl<T, A: Allocator> Vec<T, A> {
             // len set by scope guard
         }
     }
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
 }
 
 impl<T: PartialEq, A: Allocator> Vec<T, A> {
@@ -2662,6 +2941,34 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
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
+                // Since next() executes user code which can panic we have to bump the length
+                // after each step.
+                // NB can't overflow since we would have had to alloc the address space
+                self.set_len(len + 1);
+            }
+        }
+
+        Ok(())
+    }
+
     /// Creates a splicing iterator that replaces the specified range in the vector
     /// with the given `replace_with` iterator and yields the removed items.
     /// `replace_with` does not need to be the same length as `range`.
diff --git a/rust/alloc/vec/partial_eq.rs b/rust/alloc/vec/partial_eq.rs
index 50e140961050..273e99bed488 100644
--- a/rust/alloc/vec/partial_eq.rs
+++ b/rust/alloc/vec/partial_eq.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::Allocator;
 #[cfg(not(no_global_oom_handling))]
 use crate::borrow::Cow;
diff --git a/rust/alloc/vec/set_len_on_drop.rs b/rust/alloc/vec/set_len_on_drop.rs
index 8b66bc812129..448bf5076a0b 100644
--- a/rust/alloc/vec/set_len_on_drop.rs
+++ b/rust/alloc/vec/set_len_on_drop.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 // Set the length of the vec when the `SetLenOnDrop` value goes out of scope.
 //
 // The idea is: The length field in SetLenOnDrop is a local variable
diff --git a/rust/alloc/vec/spec_extend.rs b/rust/alloc/vec/spec_extend.rs
index c3b4534096de..729f4bb1709f 100644
--- a/rust/alloc/vec/spec_extend.rs
+++ b/rust/alloc/vec/spec_extend.rs
@@ -1,4 +1,7 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::Allocator;
+use crate::collections::{TryReserveError, TryReserveErrorKind};
 use core::iter::TrustedLen;
 use core::ptr::{self};
 use core::slice::{self};
@@ -6,10 +9,17 @@ use core::slice::{self};
 use super::{IntoIter, SetLenOnDrop, Vec};
 
 // Specialization trait used for Vec::extend
+#[cfg(not(no_global_oom_handling))]
 pub(super) trait SpecExtend<T, I> {
     fn spec_extend(&mut self, iter: I);
 }
 
+// Specialization trait used for Vec::try_extend
+pub(super) trait TrySpecExtend<T, I> {
+    fn try_spec_extend(&mut self, iter: I) -> Result<(), TryReserveError>;
+}
+
+#[cfg(not(no_global_oom_handling))]
 impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
 where
     I: Iterator<Item = T>,
@@ -19,6 +29,16 @@ where
     }
 }
 
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
 impl<T, I, A: Allocator> SpecExtend<T, I> for Vec<T, A>
 where
     I: TrustedLen<Item = T>,
@@ -57,6 +77,41 @@ where
     }
 }
 
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
+                    // Since the loop executes user code which can panic we have to bump the pointer
+                    // after each step.
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
 impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
     fn spec_extend(&mut self, mut iterator: IntoIter<T>) {
         unsafe {
@@ -66,6 +121,17 @@ impl<T, A: Allocator> SpecExtend<T, IntoIter<T>> for Vec<T, A> {
     }
 }
 
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
 impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
 where
     I: Iterator<Item = &'a T>,
@@ -76,6 +142,17 @@ where
     }
 }
 
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
 impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
 where
     T: Copy,
@@ -85,3 +162,13 @@ where
         unsafe { self.append_elements(slice) };
     }
 }
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
2.35.3

