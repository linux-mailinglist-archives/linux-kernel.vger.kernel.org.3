Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427514DCD52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiCQSNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiCQSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:13:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31121F75A;
        Thu, 17 Mar 2022 11:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62623B81F38;
        Thu, 17 Mar 2022 18:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C1C340F2;
        Thu, 17 Mar 2022 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540712;
        bh=0cz16QcbdfFJeFLFZoUUp2Q+11lUswEBgER2oXwJmgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2WZWi+YXFflaRRtJLjpWdRC2rgoWRRBu3EACKrfWyQAccxcUr91M0gv4FQVIAz0G
         8LG6PweEs3xiwX88gBnzZhooSk37XwJph/DHqw3xoWoMUWi16NhTNatMnknSL8nQET
         DavrsBTazgAzQA5qic3Sp/yz450SD6X41H+gJlQ9a2KtLm6S/3z8+6sYYJJ03hErIB
         aAwHahp0tYLpdK/ebC9lY5ofPcAtUMIlhHrfmfVL9QAfDMqQixBQ+qhgB2iXLxu1DK
         UAom5zceYVCrik5yotDoGCLQpEBhNm9AtsAEosnqgWJNhpgXw6llREQt0sLNaUvKLj
         8JfNQdVYGEMNw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Daniel Xu <dxu@dxuuu.xyz>,
        Hsiang-Cheng Yang <rick68@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v5 09/20] rust: add `kernel` crate's `sync` module
Date:   Thu, 17 Mar 2022 19:09:57 +0100
Message-Id: <20220317181032.15436-10-ojeda@kernel.org>
In-Reply-To: <20220317181032.15436-1-ojeda@kernel.org>
References: <20220317181032.15436-1-ojeda@kernel.org>
MIME-Version: 1.0
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

This module contains the kernel APIs related to synchronisation that
have been ported or wrapped for usage by Rust code in the kernel and
is shared by all of them.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-developed-by: Hsiang-Cheng Yang <rick68@gmail.com>
Signed-off-by: Hsiang-Cheng Yang <rick68@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/spinlock.h            |  17 +-
 rust/kernel/sync/arc.rs             | 500 ++++++++++++++++++++++++++++
 rust/kernel/sync/condvar.rs         | 138 ++++++++
 rust/kernel/sync/guard.rs           | 166 +++++++++
 rust/kernel/sync/locked_by.rs       | 112 +++++++
 rust/kernel/sync/mod.rs             | 157 +++++++++
 rust/kernel/sync/mutex.rs           | 114 +++++++
 rust/kernel/sync/revocable_mutex.rs | 184 ++++++++++
 rust/kernel/sync/rwsem.rs           | 149 +++++++++
 rust/kernel/sync/seqlock.rs         | 202 +++++++++++
 rust/kernel/sync/spinlock.rs        | 192 +++++++++++
 11 files changed, 1925 insertions(+), 6 deletions(-)
 create mode 100644 rust/kernel/sync/arc.rs
 create mode 100644 rust/kernel/sync/condvar.rs
 create mode 100644 rust/kernel/sync/guard.rs
 create mode 100644 rust/kernel/sync/locked_by.rs
 create mode 100644 rust/kernel/sync/mod.rs
 create mode 100644 rust/kernel/sync/mutex.rs
 create mode 100644 rust/kernel/sync/revocable_mutex.rs
 create mode 100644 rust/kernel/sync/rwsem.rs
 create mode 100644 rust/kernel/sync/seqlock.rs
 create mode 100644 rust/kernel/sync/spinlock.rs

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c5174155d..a732d62dbe35 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -326,12 +326,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 
-# define spin_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+static inline void __spin_lock_init(spinlock_t *lock, const char *name,
+				    struct lock_class_key *key)
+{
+	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+}
+
+# define spin_lock_init(lock)			\
+do {						\
+	static struct lock_class_key __key;	\
+						\
+	__spin_lock_init(lock, #lock, &__key);	\
 } while (0)
 
 #else
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
new file mode 100644
index 000000000000..142add78e287
--- /dev/null
+++ b/rust/kernel/sync/arc.rs
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A reference-counted pointer.
+//!
+//! This module implements a way for users to create reference-counted objects and pointers to
+//! them. Such a pointer automatically increments and decrements the count, and drops the
+//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
+//! threads.
+//!
+//! It is different from the standard library's [`Arc`] in a few ways:
+//! 1. It is backed by the kernel's `refcount_t` type.
+//! 2. It does not support weak references, which allows it to be half the size.
+//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
+//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
+//!
+//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
+
+use crate::{bindings, error::code::*, Error, Opaque, Result};
+use alloc::{
+    alloc::{alloc, dealloc},
+    vec::Vec,
+};
+use core::{
+    alloc::Layout,
+    convert::{AsRef, TryFrom},
+    marker::{PhantomData, Unsize},
+    mem::{ManuallyDrop, MaybeUninit},
+    ops::{Deref, DerefMut},
+    pin::Pin,
+    ptr::{self, NonNull},
+};
+
+/// A reference-counted pointer to an instance of `T`.
+///
+/// The reference count is incremented when new instances of [`Ref`] are created, and decremented
+/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
+///
+/// # Invariants
+///
+/// The reference count on an instance of [`Ref`] is always non-zero.
+/// The object pointed to by [`Ref`] is always pinned.
+pub struct Ref<T: ?Sized> {
+    ptr: NonNull<RefInner<T>>,
+    _p: PhantomData<RefInner<T>>,
+}
+
+#[repr(C)]
+struct RefInner<T: ?Sized> {
+    refcount: Opaque<bindings::refcount_t>,
+    data: T,
+}
+
+// This is to allow [`Ref`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for Ref<T> {}
+
+// This is to allow [`RefBorrow`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for RefBorrow<'_, T> {}
+
+// This is to allow coercion from `Ref<T>` to `Ref<U>` if `T` can be converted to the
+// dynamically-sized type (DST) `U`.
+impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::CoerceUnsized<Ref<U>> for Ref<T> {}
+
+// This is to allow `Ref<U>` to be dispatched on when `Ref<T>` can be coerced into `Ref<U>`.
+impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<Ref<U>> for Ref<T> {}
+
+// SAFETY: It is safe to send `Ref<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has a `Ref<T>` may ultimately access `T` directly, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ?Sized + Sync + Send> Send for Ref<T> {}
+
+// SAFETY: It is safe to send `&Ref<T>` to another thread when the underlying `T` is `Sync` for
+// the same reason as above. `T` needs to be `Send` as well because a thread can clone a `&Ref<T>`
+// into a `Ref<T>`, which may lead to `T` being accessed by the same reasoning as above.
+unsafe impl<T: ?Sized + Sync + Send> Sync for Ref<T> {}
+
+impl<T> Ref<T> {
+    /// Constructs a new reference counted instance of `T`.
+    pub fn try_new(contents: T) -> Result<Self> {
+        let layout = Layout::new::<RefInner<T>>();
+        // SAFETY: The layout size is guaranteed to be non-zero because `RefInner` contains the
+        // reference count.
+        let inner = NonNull::new(unsafe { alloc(layout) })
+            .ok_or(ENOMEM)?
+            .cast::<RefInner<T>>();
+
+        // INVARIANT: The refcount is initialised to a non-zero value.
+        let value = RefInner {
+            // SAFETY: Just an FFI call that returns a `refcount_t` initialised to 1.
+            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            data: contents,
+        };
+        // SAFETY: `inner` is writable and properly aligned.
+        unsafe { inner.as_ptr().write(value) };
+
+        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
+        // `Ref` object.
+        Ok(unsafe { Self::from_inner(inner) })
+    }
+
+    /// Deconstructs a [`Ref`] object into a `usize`.
+    ///
+    /// It can be reconstructed once via [`Ref::from_usize`].
+    pub fn into_usize(obj: Self) -> usize {
+        ManuallyDrop::new(obj).ptr.as_ptr() as _
+    }
+
+    /// Borrows a [`Ref`] instance previously deconstructed via [`Ref::into_usize`].
+    ///
+    /// # Safety
+    ///
+    /// `encoded` must have been returned by a previous call to [`Ref::into_usize`]. Additionally,
+    /// [`Ref::from_usize`] can only be called after *all* instances of [`RefBorrow`] have been
+    /// dropped.
+    pub unsafe fn borrow_usize<'a>(encoded: usize) -> RefBorrow<'a, T> {
+        // SAFETY: By the safety requirement of this function, we know that `encoded` came from
+        // a previous call to `Ref::into_usize`.
+        let inner = NonNull::new(encoded as *mut RefInner<T>).unwrap();
+
+        // SAFETY: The safety requirements ensure that the object remains alive for the lifetime of
+        // the returned value. There is no way to create mutable references to the object.
+        unsafe { RefBorrow::new(inner) }
+    }
+
+    /// Recreates a [`Ref`] instance previously deconstructed via [`Ref::into_usize`].
+    ///
+    /// # Safety
+    ///
+    /// `encoded` must have been returned by a previous call to [`Ref::into_usize`]. Additionally,
+    /// it can only be called once for each previous call to [`Ref::into_usize`].
+    pub unsafe fn from_usize(encoded: usize) -> Self {
+        // SAFETY: By the safety invariants we know that `encoded` came from `Ref::into_usize`, so
+        // the reference count held then will be owned by the new `Ref` object.
+        unsafe { Self::from_inner(NonNull::new(encoded as _).unwrap()) }
+    }
+}
+
+impl<T: ?Sized> Ref<T> {
+    /// Constructs a new [`Ref`] from an existing [`RefInner`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
+    /// count, one of which will be owned by the new [`Ref`] instance.
+    unsafe fn from_inner(inner: NonNull<RefInner<T>>) -> Self {
+        // INVARIANT: By the safety requirements, the invariants hold.
+        Ref {
+            ptr: inner,
+            _p: PhantomData,
+        }
+    }
+
+    /// Determines if two reference-counted pointers point to the same underlying instance of `T`.
+    pub fn ptr_eq(a: &Self, b: &Self) -> bool {
+        ptr::eq(a.ptr.as_ptr(), b.ptr.as_ptr())
+    }
+
+    /// Deconstructs a [`Ref`] object into a raw pointer.
+    ///
+    /// It can be reconstructed once via [`Ref::from_raw`].
+    pub fn into_raw(obj: Self) -> *const T {
+        let ret = &*obj as *const T;
+        core::mem::forget(obj);
+        ret
+    }
+
+    /// Recreates a [`Ref`] instance previously deconstructed via [`Ref::into_raw`].
+    ///
+    /// This code relies on the `repr(C)` layout of structs as described in
+    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`Ref::into_raw`]. Additionally, it
+    /// can only be called once for each previous call to [`Ref::into_raw`].
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The safety requirement ensures that the pointer is valid.
+        let align = core::mem::align_of_val(unsafe { &*ptr });
+        let offset = Layout::new::<RefInner<()>>()
+            .align_to(align)
+            .unwrap()
+            .pad_to_align()
+            .size();
+        // SAFETY: The pointer is in bounds because by the safety requirements `ptr` came from
+        // `Ref::into_raw`, so it is a pointer `offset` bytes from the beginning of the allocation.
+        let data = unsafe { (ptr as *const u8).sub(offset) };
+        let metadata = ptr::metadata(ptr as *const RefInner<T>);
+        let ptr = ptr::from_raw_parts_mut(data as _, metadata);
+        // SAFETY: By the safety requirements we know that `ptr` came from `Ref::into_raw`, so the
+        // reference count held then will be owned by the new `Ref` object.
+        unsafe { Self::from_inner(NonNull::new(ptr).unwrap()) }
+    }
+
+    /// Returns a [`RefBorrow`] from the given [`Ref`].
+    ///
+    /// This is useful when the argument of a function call is a [`RefBorrow`] (e.g., in a method
+    /// receiver), but we have a [`Ref`] instead. Getting a [`RefBorrow`] is free when optimised.
+    #[inline]
+    pub fn as_ref_borrow(&self) -> RefBorrow<'_, T> {
+        // SAFETY: The constraint that lifetime of the shared reference must outlive that of
+        // the returned `RefBorrow` ensures that the object remains alive.
+        unsafe { RefBorrow::new(self.ptr) }
+    }
+}
+
+impl<T: ?Sized> Deref for Ref<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { &self.ptr.as_ref().data }
+    }
+}
+
+impl<T: ?Sized> Clone for Ref<T> {
+    fn clone(&self) -> Self {
+        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to increment the refcount.
+        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+
+        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Ref`.
+        unsafe { Self::from_inner(self.ptr) }
+    }
+}
+
+impl<T: ?Sized> AsRef<T> for Ref<T> {
+    fn as_ref(&self) -> &T {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        unsafe { &self.ptr.as_ref().data }
+    }
+}
+
+impl<T: ?Sized> Drop for Ref<T> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
+        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
+        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
+        // freed/invalid memory as long as it is never dereferenced.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
+        // INVARIANT: If the refcount reaches zero, there are no other instances of `Ref`, and
+        // this instance is being dropped, so the broken invariant is not observable.
+        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
+        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        if is_zero {
+            // The count reached zero, we must free the memory.
+
+            // SAFETY: This thread holds the only remaining reference to `self`, so it is safe to
+            // get a mutable reference to it.
+            let inner = unsafe { self.ptr.as_mut() };
+            let layout = Layout::for_value(inner);
+            // SAFETY: The value stored in inner is valid.
+            unsafe { core::ptr::drop_in_place(inner) };
+            // SAFETY: The pointer was initialised from the result of a call to `alloc`.
+            unsafe { dealloc(self.ptr.cast().as_ptr(), layout) };
+        }
+    }
+}
+
+impl<T> TryFrom<Vec<T>> for Ref<[T]> {
+    type Error = Error;
+
+    fn try_from(mut v: Vec<T>) -> Result<Self> {
+        let value_layout = Layout::array::<T>(v.len())?;
+        let layout = Layout::new::<RefInner<()>>()
+            .extend(value_layout)?
+            .0
+            .pad_to_align();
+        // SAFETY: The layout size is guaranteed to be non-zero because `RefInner` contains the
+        // reference count.
+        let ptr = NonNull::new(unsafe { alloc(layout) }).ok_or(ENOMEM)?;
+        let inner =
+            core::ptr::slice_from_raw_parts_mut(ptr.as_ptr() as _, v.len()) as *mut RefInner<[T]>;
+
+        // SAFETY: Just an FFI call that returns a `refcount_t` initialised to 1.
+        let count = Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) });
+        // SAFETY: `inner.refcount` is writable and properly aligned.
+        unsafe { core::ptr::addr_of_mut!((*inner).refcount).write(count) };
+        // SAFETY: The contents of `v` as readable and properly aligned; `inner.data` is writable
+        // and properly aligned. There is no overlap between the two because `inner` is a new
+        // allocation.
+        unsafe {
+            core::ptr::copy_nonoverlapping(
+                v.as_ptr(),
+                core::ptr::addr_of_mut!((*inner).data) as *mut [T] as *mut T,
+                v.len(),
+            )
+        };
+        // SAFETY: We're setting the new length to zero, so it is <= to capacity, and old_len..0 is
+        // an empty range (so satisfies vacuously the requirement of being initialised).
+        unsafe { v.set_len(0) };
+        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
+        // `Ref` object.
+        Ok(unsafe { Self::from_inner(NonNull::new(inner).unwrap()) })
+    }
+}
+
+impl<T: ?Sized> From<UniqueRef<T>> for Ref<T> {
+    fn from(item: UniqueRef<T>) -> Self {
+        item.inner
+    }
+}
+
+impl<T: ?Sized> From<UniqueRef<T>> for Pin<UniqueRef<T>> {
+    fn from(obj: UniqueRef<T>) -> Self {
+        // SAFETY: It is not possible to move/replace `T` inside a `Pin<UniqueRef<T>>` (unless `T`
+        // is `Unpin`), so it is ok to convert it to `Pin<UniqueRef<T>>`.
+        unsafe { Pin::new_unchecked(obj) }
+    }
+}
+
+impl<T: ?Sized> From<Pin<UniqueRef<T>>> for Ref<T> {
+    fn from(item: Pin<UniqueRef<T>>) -> Self {
+        // SAFETY: The type invariants of `Ref` guarantee that the data is pinned.
+        unsafe { Pin::into_inner_unchecked(item).inner }
+    }
+}
+
+/// A borrowed [`Ref`] with manually-managed lifetime.
+///
+/// # Invariants
+///
+/// There are no mutable references to the underlying [`Ref`], and it remains valid for the lifetime
+/// of the [`RefBorrow`] instance.
+pub struct RefBorrow<'a, T: ?Sized + 'a> {
+    inner: NonNull<RefInner<T>>,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Clone for RefBorrow<'_, T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized> Copy for RefBorrow<'_, T> {}
+
+impl<T: ?Sized> RefBorrow<'_, T> {
+    /// Creates a new [`RefBorrow`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure the following for the lifetime of the returned [`RefBorrow`] instance:
+    /// 1. That `obj` remains valid;
+    /// 2. That no mutable references to `obj` are created.
+    unsafe fn new(inner: NonNull<RefInner<T>>) -> Self {
+        // INVARIANT: The safety requirements guarantee the invariants.
+        Self {
+            inner,
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized> From<RefBorrow<'_, T>> for Ref<T> {
+    fn from(b: RefBorrow<'_, T>) -> Self {
+        // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
+        // guarantees that `drop` isn't called, so it's ok that the temporary `Ref` doesn't own the
+        // increment.
+        ManuallyDrop::new(unsafe { Ref::from_inner(b.inner) })
+            .deref()
+            .clone()
+    }
+}
+
+impl<T: ?Sized> Deref for RefBorrow<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
+        // references to it, so it is safe to create a shared reference.
+        unsafe { &self.inner.as_ref().data }
+    }
+}
+
+/// A refcounted object that is known to have a refcount of 1.
+///
+/// It is mutable and can be converted to a [`Ref`] so that it can be shared.
+///
+/// # Invariants
+///
+/// `inner` always has a reference count of 1.
+///
+/// # Examples
+///
+/// In the following example, we make changes to the inner object before turning it into a
+/// `Ref<Test>` object (after which point, it cannot be mutated directly). Note that `x.into()`
+/// cannot fail.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{Ref, UniqueRef};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test() -> Result<Ref<Example>> {
+///     let mut x = UniqueRef::try_new(Example { a: 10, b: 20 })?;
+///     x.a += 1;
+///     x.b += 1;
+///     Ok(x.into())
+/// }
+/// ```
+///
+/// In the following example we first allocate memory for a ref-counted `Example` but we don't
+/// initialise it on allocation. We do initialise it later with a call to [`UniqueRef::write`],
+/// followed by a conversion to `Ref<Example>`. This is particularly useful when allocation happens
+/// in one context (e.g., sleepable) and initialisation in another (e.g., atomic):
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{Ref, UniqueRef};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test2() -> Result<Ref<Example>> {
+///     let x = UniqueRef::try_new_uninit()?;
+///     Ok(x.write(Example { a: 10, b: 20 }).into())
+/// }
+/// ```
+///
+/// In the last example below, the caller gets a pinned instance of `Example` while converting to
+/// `Ref<Example>`; this is useful in scenarios where one needs a pinned reference during
+/// initialisation, for example, when initialising fields that are wrapped in locks.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{Ref, UniqueRef};
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn test2() -> Result<Ref<Example>> {
+///     let mut pinned = Pin::from(UniqueRef::try_new(Example { a: 10, b: 20 })?);
+///     // We can modify `pinned` because it is `Unpin`.
+///     pinned.as_mut().a += 1;
+///     Ok(pinned.into())
+/// }
+/// ```
+pub struct UniqueRef<T: ?Sized> {
+    inner: Ref<T>,
+}
+
+impl<T> UniqueRef<T> {
+    /// Tries to allocate a new [`UniqueRef`] instance.
+    pub fn try_new(value: T) -> Result<Self> {
+        Ok(Self {
+            // INVARIANT: The newly-created object has a ref-count of 1.
+            inner: Ref::try_new(value)?,
+        })
+    }
+
+    /// Tries to allocate a new [`UniqueRef`] instance whose contents are not initialised yet.
+    pub fn try_new_uninit() -> Result<UniqueRef<MaybeUninit<T>>> {
+        Ok(UniqueRef::<MaybeUninit<T>> {
+            // INVARIANT: The newly-created object has a ref-count of 1.
+            inner: Ref::try_new(MaybeUninit::uninit())?,
+        })
+    }
+}
+
+impl<T> UniqueRef<MaybeUninit<T>> {
+    /// Converts a `UniqueRef<MaybeUninit<T>>` into a `UniqueRef<T>` by writing a value into it.
+    pub fn write(mut self, value: T) -> UniqueRef<T> {
+        self.deref_mut().write(value);
+        let inner = ManuallyDrop::new(self).inner.ptr;
+        UniqueRef {
+            // SAFETY: The new `Ref` is taking over `ptr` from `self.inner` (which won't be
+            // dropped). The types are compatible because `MaybeUninit<T>` is compatible with `T`.
+            inner: unsafe { Ref::from_inner(inner.cast()) },
+        }
+    }
+}
+
+impl<T: ?Sized> Deref for UniqueRef<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        self.inner.deref()
+    }
+}
+
+impl<T: ?Sized> DerefMut for UniqueRef<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: By the `Ref` type invariant, there is necessarily a reference to the object, so
+        // it is safe to dereference it. Additionally, we know there is only one reference when
+        // it's inside a `UniqueRef`, so it is safe to get a mutable reference.
+        unsafe { &mut self.inner.ptr.as_mut().data }
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
new file mode 100644
index 000000000000..7f8aa1c55a19
--- /dev/null
+++ b/rust/kernel/sync/condvar.rs
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A condition variable.
+//!
+//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
+//! variable.
+
+use super::{Guard, Lock, LockInfo, NeedsLockClass};
+use crate::{bindings, str::CStr, task::Task, Opaque};
+use core::{marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`CondVar`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! condvar_init {
+    ($condvar:expr, $name:literal) => {
+        $crate::init_with_lockdep!($condvar, $name)
+    };
+}
+
+// TODO: `bindgen` is not generating this constant. Figure out why.
+const POLLFREE: u32 = 0x4000;
+
+/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
+/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
+/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
+/// [`CondVar::notify_all`]) or because the thread received a signal.
+///
+/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
+pub struct CondVar {
+    pub(crate) wait_list: Opaque<bindings::wait_queue_head>,
+
+    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl Send for CondVar {}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
+// concurrently.
+unsafe impl Sync for CondVar {}
+
+impl CondVar {
+    /// Constructs a new conditional variable.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call `CondVar::init` before using the conditional variable.
+    pub const unsafe fn new() -> Self {
+        Self {
+            wait_list: Opaque::uninit(),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
+    /// [`CondVar::notify_all`], or when the thread receives a signal.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait<L: Lock<I>, I: LockInfo>(&self, guard: &mut Guard<'_, L, I>) -> bool {
+        let lock = guard.lock;
+        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { bindings::init_wait(wait.get()) };
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(
+                self.wait_list.get(),
+                wait.get(),
+                bindings::TASK_INTERRUPTIBLE as _,
+            )
+        };
+
+        // SAFETY: The guard is evidence that the caller owns the lock.
+        unsafe { lock.unlock(&mut guard.context) };
+
+        // SAFETY: No arguments, switches to another thread.
+        unsafe { bindings::schedule() };
+
+        guard.context = lock.lock_noguard();
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+
+        Task::current().signal_pending()
+    }
+
+    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
+    fn notify(&self, count: i32, flags: u32) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe {
+            bindings::__wake_up(
+                self.wait_list.get(),
+                bindings::TASK_NORMAL,
+                count,
+                flags as _,
+            )
+        };
+    }
+
+    /// Wakes a single waiter up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_one(&self) {
+        self.notify(1, 0);
+    }
+
+    /// Wakes all waiters up, if any. This is not 'sticky' in the sense that if no thread is
+    /// waiting, the notification is lost completely (as opposed to automatically waking up the
+    /// next waiter).
+    pub fn notify_all(&self) {
+        self.notify(0, 0);
+    }
+
+    /// Wakes all waiters up. If they were added by `epoll`, they are also removed from the list of
+    /// waiters. This is useful when cleaning up a condition variable that may be waited on by
+    /// threads that use `epoll`.
+    pub fn free_waiters(&self) {
+        self.notify(1, bindings::POLLHUP | POLLFREE);
+    }
+}
+
+impl NeedsLockClass for CondVar {
+    unsafe fn init(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+        _: *mut bindings::lock_class_key,
+    ) {
+        unsafe { bindings::__init_waitqueue_head(self.wait_list.get(), name.as_char_ptr(), key) };
+    }
+}
diff --git a/rust/kernel/sync/guard.rs b/rust/kernel/sync/guard.rs
new file mode 100644
index 000000000000..e121a7d0e8e1
--- /dev/null
+++ b/rust/kernel/sync/guard.rs
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A generic lock guard and trait.
+//!
+//! This module contains a lock guard that can be used with any locking primitive that implements
+//! the ([`Lock`]) trait. It also contains the definition of the trait, which can be leveraged by
+//! other constructs to work on generic locking primitives.
+
+use super::NeedsLockClass;
+use crate::{bindings, str::CStr, Bool, False, True};
+use core::pin::Pin;
+
+/// Allows mutual exclusion primitives that implement the [`Lock`] trait to automatically unlock
+/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
+/// protected by the lock.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, L: Lock<I> + ?Sized, I: LockInfo = WriteLock> {
+    pub(crate) lock: &'a L,
+    pub(crate) context: L::GuardContext,
+}
+
+// SAFETY: `Guard` is sync when the data protected by the lock is also sync. This is more
+// conservative than the default compiler implementation; more details can be found on
+// https://github.com/rust-lang/rust/issues/41622 -- it refers to `MutexGuard` from the standard
+// library.
+unsafe impl<L, I> Sync for Guard<'_, L, I>
+where
+    L: Lock<I> + ?Sized,
+    L::Inner: Sync,
+    I: LockInfo,
+{
+}
+
+impl<L: Lock<I> + ?Sized, I: LockInfo> core::ops::Deref for Guard<'_, L, I> {
+    type Target = L::Inner;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &*self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock<I> + ?Sized, I: LockInfo<Writable = True>> core::ops::DerefMut for Guard<'_, L, I> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &mut *self.lock.locked_data().get() }
+    }
+}
+
+impl<L: Lock<I> + ?Sized, I: LockInfo> Drop for Guard<'_, L, I> {
+    fn drop(&mut self) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { self.lock.unlock(&mut self.context) };
+    }
+}
+
+impl<'a, L: Lock<I> + ?Sized, I: LockInfo> Guard<'a, L, I> {
+    /// Constructs a new immutable lock guard.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that it owns the lock.
+    pub(crate) unsafe fn new(lock: &'a L, context: L::GuardContext) -> Self {
+        Self { lock, context }
+    }
+}
+
+/// Specifies properties of a lock.
+pub trait LockInfo {
+    /// Determines if the data protected by a lock is writable.
+    type Writable: Bool;
+}
+
+/// A marker for locks that only allow reading.
+pub struct ReadLock;
+impl LockInfo for ReadLock {
+    type Writable = False;
+}
+
+/// A marker for locks that allow reading and writing.
+pub struct WriteLock;
+impl LockInfo for WriteLock {
+    type Writable = True;
+}
+
+/// A generic mutual exclusion primitive.
+///
+/// [`Guard`] is written such that any mutual exclusion primitive that can implement this trait can
+/// also benefit from having an automatic way to unlock itself.
+///
+/// # Safety
+///
+/// - Implementers of this trait with the [`WriteLock`] marker must ensure that only one thread/CPU
+///   may access the protected data once the lock is held, that is, between calls to `lock_noguard`
+///   and `unlock`.
+/// - Implementers of all other markers must ensure that a mutable reference to the protected data
+///   is not active in any thread/CPU because at least one shared refence is active between calls
+///   to `lock_noguard` and `unlock`.
+pub unsafe trait Lock<I: LockInfo = WriteLock> {
+    /// The type of the data protected by the lock.
+    type Inner: ?Sized;
+
+    /// The type of context, if any, that needs to be stored in the guard.
+    type GuardContext;
+
+    /// Acquires the lock, making the caller its owner.
+    #[must_use]
+    fn lock_noguard(&self) -> Self::GuardContext;
+
+    /// Reacquires the lock, making the caller its owner.
+    ///
+    /// The guard context before the last unlock is passed in.
+    ///
+    /// Locks that don't require this state on relock can simply use the default implementation
+    /// that calls [`Lock::lock_noguard`].
+    fn relock(&self, ctx: &mut Self::GuardContext) {
+        *ctx = self.lock_noguard();
+    }
+
+    /// Releases the lock, giving up ownership of the lock.
+    ///
+    /// # Safety
+    ///
+    /// It must only be called by the current owner of the lock.
+    unsafe fn unlock(&self, context: &mut Self::GuardContext);
+
+    /// Returns the data protected by the lock.
+    fn locked_data(&self) -> &core::cell::UnsafeCell<Self::Inner>;
+}
+
+/// A generic mutual exclusion primitive that can be instantiated generically.
+pub trait CreatableLock {
+    /// The type of the argument passed to [`CreatableLock::new_lock`].
+    type CreateArgType: ?Sized;
+
+    /// Constructs a new instance of the lock.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`CreatableLock::init_lock`] before using the lock.
+    unsafe fn new_lock(data: Self::CreateArgType) -> Self;
+
+    /// Initialises the lock type instance so that it can be safely used.
+    ///
+    /// # Safety
+    ///
+    /// `key` must point to a valid memory location that will remain valid until the lock is
+    /// dropped.
+    unsafe fn init_lock(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+    );
+}
+
+impl<L: CreatableLock> NeedsLockClass for L {
+    unsafe fn init(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+        _: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements of this function satisfy those of `init_lock`.
+        unsafe { self.init_lock(name, key) };
+    }
+}
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
new file mode 100644
index 000000000000..d3e0b0d5e9b4
--- /dev/null
+++ b/rust/kernel/sync/locked_by.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A wrapper for data protected by a lock that does not wrap it.
+
+use super::{Guard, Lock};
+use core::{cell::UnsafeCell, ops::Deref, ptr};
+
+/// Allows access to some data to be serialised by a lock that does not wrap it.
+///
+/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
+/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
+/// possible. For example, if a container has a lock and some data in the contained elements needs
+/// to be protected by the same lock.
+///
+/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
+/// when the caller shows evidence that 'external' lock is locked.
+///
+/// # Example
+///
+/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
+/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
+/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
+/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
+/// locked; we enforce at run time that the right `InnerDirectory` is locked.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{LockedBy, Mutex};
+///
+/// struct InnerFile {
+///     bytes_used: u64,
+/// }
+///
+/// struct File {
+///     name: String,
+///     inner: LockedBy<InnerFile, Mutex<InnerDirectory>>,
+/// }
+///
+/// struct InnerDirectory {
+///     /// The sum of the bytes used by all files.
+///     bytes_used: u64,
+///     files: Vec<File>,
+/// }
+///
+/// struct Directory {
+///     name: String,
+///     inner: Mutex<InnerDirectory>,
+/// }
+/// ```
+pub struct LockedBy<T: ?Sized, L: Lock + ?Sized> {
+    owner: *const L::Inner,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Send for LockedBy<T, L> {}
+
+// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send, L: Lock + ?Sized> Sync for LockedBy<T, L> {}
+
+impl<T, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Constructs a new instance of [`LockedBy`].
+    ///
+    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
+    /// that the right owner is being used to access the protected data. If the owner is freed, the
+    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
+    /// memory location*, the data becomes accessible again: none of this affects memory safety
+    /// because in any case at most one thread (or CPU) can access the protected data at a time.
+    pub fn new(owner: &L, data: T) -> Self {
+        Self {
+            owner: owner.locked_data().get(),
+            data: UnsafeCell::new(data),
+        }
+    }
+}
+
+impl<T: ?Sized, L: Lock + ?Sized> LockedBy<T, L> {
+    /// Returns a reference to the protected data when the caller provides evidence (via a
+    /// [`Guard`]) that the owner is locked.
+    pub fn access<'a>(&'a self, guard: &'a Guard<'_, L>) -> &'a T {
+        if !ptr::eq(guard.deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable [`Guard`]) that the owner is locked mutably.
+    pub fn access_mut<'a>(&'a self, guard: &'a mut Guard<'_, L>) -> &'a mut T {
+        if !ptr::eq(guard.deref().deref(), self.owner) {
+            panic!("guard does not match owner");
+        }
+
+        // SAFETY: `guard` is evidence that the owner is locked.
+        unsafe { &mut *self.data.get() }
+    }
+
+    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
+    /// mutable owner) that the owner is locked mutably. Showing a mutable reference to the owner
+    /// is sufficient because we know no other references can exist to it.
+    pub fn access_from_mut<'a>(&'a self, owner: &'a mut L::Inner) -> &'a mut T {
+        if !ptr::eq(owner, self.owner) {
+            panic!("mismatched owners");
+        }
+
+        // SAFETY: `owner` is evidence that there is only one reference to the owner.
+        unsafe { &mut *self.data.get() }
+    }
+}
diff --git a/rust/kernel/sync/mod.rs b/rust/kernel/sync/mod.rs
new file mode 100644
index 000000000000..e66b4a04e0a5
--- /dev/null
+++ b/rust/kernel/sync/mod.rs
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Synchronisation primitives.
+//!
+//! This module contains the kernel APIs related to synchronisation that have been ported or
+//! wrapped for usage by Rust code in the kernel and is shared by all of them.
+//!
+//! # Example
+//!
+//! ```no_run
+//! # use kernel::prelude::*;
+//! # use kernel::mutex_init;
+//! # use kernel::sync::Mutex;
+//! # use alloc::boxed::Box;
+//! # use core::pin::Pin;
+//! // SAFETY: `init` is called below.
+//! let mut data = Pin::from(Box::new(unsafe { Mutex::new(0) }));
+//! mutex_init!(data.as_mut(), "test::data");
+//! *data.lock() = 10;
+//! pr_info!("{}\n", *data.lock());
+//! ```
+
+use crate::{bindings, str::CStr};
+use core::pin::Pin;
+
+mod arc;
+mod condvar;
+mod guard;
+mod locked_by;
+mod mutex;
+mod revocable_mutex;
+mod rwsem;
+mod seqlock;
+mod spinlock;
+
+pub use arc::{Ref, RefBorrow, UniqueRef};
+pub use condvar::CondVar;
+pub use guard::{CreatableLock, Guard, Lock, LockInfo, ReadLock, WriteLock};
+pub use locked_by::LockedBy;
+pub use mutex::Mutex;
+pub use revocable_mutex::{RevocableMutex, RevocableMutexGuard};
+pub use rwsem::RwSemaphore;
+pub use seqlock::{SeqLock, SeqLockReadGuard};
+pub use spinlock::SpinLock;
+
+/// Safely initialises an object that has an `init` function that takes a name and a lock class as
+/// arguments, examples of these are [`Mutex`] and [`SpinLock`]. Each of them also provides a more
+/// specialised name that uses this macro.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! init_with_lockdep {
+    ($obj:expr, $name:expr) => {{
+        static mut CLASS1: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        static mut CLASS2: core::mem::MaybeUninit<$crate::bindings::lock_class_key> =
+            core::mem::MaybeUninit::uninit();
+        let obj = $obj;
+        let name = $crate::c_str!($name);
+        // SAFETY: `CLASS1` and `CLASS2` are never used by Rust code directly; the C portion of the
+        // kernel may change it though.
+        #[allow(unused_unsafe)]
+        unsafe {
+            $crate::sync::NeedsLockClass::init(obj, name, CLASS1.as_mut_ptr(), CLASS2.as_mut_ptr())
+        };
+    }};
+}
+
+/// A trait for types that need a lock class during initialisation.
+///
+/// Implementers of this trait benefit from the [`init_with_lockdep`] macro that generates a new
+/// class for each initialisation call site.
+pub trait NeedsLockClass {
+    /// Initialises the type instance so that it can be safely used.
+    ///
+    /// Callers are encouraged to use the [`init_with_lockdep`] macro as it automatically creates a
+    /// new lock class on each usage.
+    ///
+    /// # Safety
+    ///
+    /// `key1` and `key2` must point to valid memory locations and remain valid until `self` is
+    /// dropped.
+    unsafe fn init(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key1: *mut bindings::lock_class_key,
+        key2: *mut bindings::lock_class_key,
+    );
+}
+
+/// Automatically initialises static instances of synchronisation primitives.
+///
+/// The syntax resembles that of regular static variables, except that the value assigned is that
+/// of the protected type (if one exists). In the examples below, all primitives except for
+/// [`CondVar`] require the inner value to be supplied.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use kernel::{init_static_sync, sync::{CondVar, Mutex, RevocableMutex, SpinLock}};
+/// struct Test {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// init_static_sync! {
+///     static A: Mutex<Test> = Test { a: 10, b: 20 };
+///
+///     /// Documentation for `B`.
+///     pub static B: Mutex<u32> = 0;
+///
+///     pub(crate) static C: SpinLock<Test> = Test { a: 10, b: 20 };
+///     static D: CondVar;
+///
+///     static E: RevocableMutex<Test> = Test { a: 30, b: 40 };
+/// }
+/// ```
+#[macro_export]
+macro_rules! init_static_sync {
+    ($($(#[$outer:meta])* $v:vis static $id:ident : $t:ty $(= $value:expr)?;)*) => {
+        $(
+            $(#[$outer])*
+            $v static $id: $t = {
+                #[link_section = ".init_array"]
+                #[used]
+                static TMP: extern "C" fn() = {
+                    extern "C" fn constructor() {
+                        // SAFETY: This locally-defined function is only called from a constructor,
+                        // which guarantees that `$id` is not accessible from other threads
+                        // concurrently.
+                        #[allow(clippy::cast_ref_to_mut)]
+                        let mutable = unsafe { &mut *(&$id as *const _ as *mut $t) };
+                        // SAFETY: It's a shared static, so it cannot move.
+                        let pinned = unsafe { core::pin::Pin::new_unchecked(mutable) };
+                        $crate::init_with_lockdep!(pinned, stringify!($id));
+                    }
+                    constructor
+                };
+                $crate::init_static_sync!(@call_new $t, $($value)?)
+            };
+        )*
+    };
+    (@call_new $t:ty, $value:expr) => {{
+        let v = $value;
+        // SAFETY: the initialisation function is called by the constructor above.
+        unsafe { <$t>::new(v) }
+    }};
+    (@call_new $t:ty,) => {
+        // SAFETY: the initialisation function is called by the constructor above.
+        unsafe { <$t>::new() }
+    };
+}
+
+/// Reschedules the caller's task if needed.
+pub fn cond_resched() -> bool {
+    // SAFETY: No arguments, reschedules `current` if needed.
+    unsafe { bindings::cond_resched() != 0 }
+}
diff --git a/rust/kernel/sync/mutex.rs b/rust/kernel/sync/mutex.rs
new file mode 100644
index 000000000000..916725d53917
--- /dev/null
+++ b/rust/kernel/sync/mutex.rs
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex.
+//!
+//! This module allows Rust code to use the kernel's [`struct mutex`].
+
+use super::{CreatableLock, Guard, Lock};
+use crate::{bindings, str::CStr, Opaque};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`Mutex`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! mutex_init {
+    ($mutex:expr, $name:literal) => {
+        $crate::init_with_lockdep!($mutex, $name)
+    };
+}
+
+/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
+/// only one at a time is allowed to progress, the others will block (sleep) until the mutex is
+/// unlocked, at which point another thread will be allowed to wake up and make progress.
+///
+/// A [`Mutex`] must first be initialised with a call to [`Mutex::init_lock`] before it can be
+/// used. The [`mutex_init`] macro is provided to automatically assign a new lock class to a mutex
+/// instance.
+///
+/// Since it may block, [`Mutex`] needs to be used with care in atomic contexts.
+///
+/// [`struct mutex`]: ../../../include/linux/mutex.h
+pub struct Mutex<T: ?Sized> {
+    /// The kernel `struct mutex` object.
+    mutex: Opaque<bindings::mutex>,
+
+    /// A mutex needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+
+    /// The data protected by the mutex.
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `Mutex` can be transferred across thread boundaries iff the data it protects can.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: ?Sized + Send> Send for Mutex<T> {}
+
+// SAFETY: `Mutex` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for Mutex<T> {}
+
+impl<T> Mutex<T> {
+    /// Constructs a new mutex.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`Mutex::init_lock`] before using the mutex.
+    pub const unsafe fn new(t: T) -> Self {
+        Self {
+            mutex: Opaque::uninit(),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> Mutex<T> {
+    /// Locks the mutex and gives the caller access to the data protected by it. Only one thread at
+    /// a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<'_, Self> {
+        let ctx = self.lock_noguard();
+        // SAFETY: The mutex was just acquired.
+        unsafe { Guard::new(self, ctx) }
+    }
+}
+
+impl<T> CreatableLock for Mutex<T> {
+    type CreateArgType = T;
+
+    unsafe fn new_lock(data: Self::CreateArgType) -> Self {
+        // SAFETY: The safety requirements of `new_lock` also require that `init_lock` be called.
+        unsafe { Self::new(data) }
+    }
+
+    unsafe fn init_lock(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+    ) {
+        unsafe { bindings::__mutex_init(self.mutex.get(), name.as_char_ptr(), key) };
+    }
+}
+
+pub struct EmptyGuardContext;
+
+// SAFETY: The underlying kernel `struct mutex` object ensures mutual exclusion.
+unsafe impl<T: ?Sized> Lock for Mutex<T> {
+    type Inner = T;
+    type GuardContext = EmptyGuardContext;
+
+    fn lock_noguard(&self) -> EmptyGuardContext {
+        // SAFETY: `mutex` points to valid memory.
+        unsafe { bindings::mutex_lock(self.mutex.get()) };
+        EmptyGuardContext
+    }
+
+    unsafe fn unlock(&self, _: &mut EmptyGuardContext) {
+        // SAFETY: The safety requirements of the function ensure that the mutex is owned by the
+        // caller.
+        unsafe { bindings::mutex_unlock(self.mutex.get()) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sync/revocable_mutex.rs b/rust/kernel/sync/revocable_mutex.rs
new file mode 100644
index 000000000000..d2d56fdfc4fe
--- /dev/null
+++ b/rust/kernel/sync/revocable_mutex.rs
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel mutex where acccess to contents can be revoked at runtime.
+
+use crate::{
+    bindings,
+    str::CStr,
+    sync::{Guard, Mutex, NeedsLockClass},
+};
+use core::{
+    mem::ManuallyDrop,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+};
+
+/// The state within a `RevocableMutex` that is protected by a mutex.
+///
+/// We don't use simply `Option<T>` because we need to drop in-place because the contents are
+/// implicitly pinned.
+struct RevocableMutexInner<T: ?Sized> {
+    is_available: bool,
+    data: ManuallyDrop<T>,
+}
+
+/// A mutex whose contents can become inaccessible at runtime.
+///
+/// Once access is revoked and all concurrent users complete (i.e., all existing instances of
+/// [`RevocableMutexGuard`] are dropped), the wrapped object is also dropped.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::sync::RevocableMutex;
+/// # use kernel::revocable_mutex_init;
+/// # use core::pin::Pin;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn add_two(v: &RevocableMutex<Example>) -> Option<u32> {
+///     let guard = v.try_lock()?;
+///     Some(guard.a + guard.b)
+/// }
+///
+/// fn example() {
+///     // SAFETY: We call `revocable_mutex_init` immediately below.
+///     let mut v = unsafe { RevocableMutex::new(Example { a: 10, b: 20 }) };
+///     // SAFETY: We never move out of `v`.
+///     let pinned = unsafe { Pin::new_unchecked(&mut v) };
+///     revocable_mutex_init!(pinned, "example::v");
+///     assert_eq!(add_two(&v), Some(30));
+///     v.revoke();
+///     assert_eq!(add_two(&v), None);
+/// }
+/// ```
+pub struct RevocableMutex<T: ?Sized> {
+    inner: Mutex<RevocableMutexInner<T>>,
+}
+
+// SAFETY: `Mutex` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for RevocableMutex<T> {}
+
+// SAFETY: `Mutex` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for RevocableMutex<T> {}
+
+/// Safely initialises a [`RevocableMutex`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! revocable_mutex_init {
+    ($mutex:expr, $name:literal) => {
+        $crate::init_with_lockdep!($mutex, $name)
+    };
+}
+
+impl<T> RevocableMutex<T> {
+    /// Creates a new revocable instance of the given data.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`RevocableMutex::init`] before using the revocable mutex.
+    pub const unsafe fn new(data: T) -> Self {
+        Self {
+            // SAFETY: The safety requirements of this function require that `RevocableMutex::init`
+            // be called before the returned object can be used. Mutex initialisation is called
+            // from `RevocableMutex::init`, so we satisfy the requirement from `Mutex`.
+            inner: unsafe {
+                Mutex::new(RevocableMutexInner {
+                    is_available: true,
+                    data: ManuallyDrop::new(data),
+                })
+            },
+        }
+    }
+}
+
+impl<T> NeedsLockClass for RevocableMutex<T> {
+    unsafe fn init(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key1: *mut bindings::lock_class_key,
+        key2: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: `inner` is pinned when `self` is.
+        let mutex = unsafe { self.map_unchecked_mut(|r| &mut r.inner) };
+
+        // SAFETY: The safety requirements of this function satisfy the ones for `Mutex::init`
+        // (they're the same).
+        unsafe { mutex.init(name, key1, key2) };
+    }
+}
+
+impl<T: ?Sized> RevocableMutex<T> {
+    /// Tries to lock (and access) the \[revocable\] wrapped object.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible.
+    ///
+    /// Returns a guard that gives access to the object otherwise; the object is guaranteed to
+    /// remain accessible while the guard is alive. Callers are allowed to sleep while holding on
+    /// to the returned guard.
+    pub fn try_lock(&self) -> Option<RevocableMutexGuard<'_, T>> {
+        let inner = self.inner.lock();
+        if !inner.is_available {
+            return None;
+        }
+        Some(RevocableMutexGuard::new(inner))
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Revocation and dropping happens after ongoing accessors complete.
+    pub fn revoke(&self) {
+        let mut inner = self.inner.lock();
+        if !inner.is_available {
+            // Already revoked.
+            return;
+        }
+
+        inner.is_available = false;
+
+        // SAFETY: We know `inner.data` is valid because `is_available` was true. We'll drop it
+        // here, and given that we set `is_available` to false above, it won't be dropped again.
+        unsafe { ManuallyDrop::drop(&mut inner.data) };
+    }
+}
+
+impl<T: ?Sized> Drop for RevocableMutex<T> {
+    fn drop(&mut self) {
+        self.revoke();
+    }
+}
+
+/// A guard that allows access to a revocable object and keeps it alive.
+pub struct RevocableMutexGuard<'a, T: ?Sized> {
+    guard: Guard<'a, Mutex<RevocableMutexInner<T>>>,
+}
+
+impl<'a, T: ?Sized> RevocableMutexGuard<'a, T> {
+    fn new(guard: Guard<'a, Mutex<RevocableMutexInner<T>>>) -> Self {
+        Self { guard }
+    }
+
+    /// Returns a pinned mutable reference to the wrapped object.
+    pub fn as_pinned_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: Revocable mutexes must be pinned, so we choose to always project the data as
+        // pinned as well (i.e., we guarantee we never move it).
+        unsafe { Pin::new_unchecked(&mut self.guard.data) }
+    }
+}
+
+impl<T: ?Sized> Deref for RevocableMutexGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.guard.data
+    }
+}
+
+impl<T: ?Sized> DerefMut for RevocableMutexGuard<'_, T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.guard.data
+    }
+}
diff --git a/rust/kernel/sync/rwsem.rs b/rust/kernel/sync/rwsem.rs
new file mode 100644
index 000000000000..e6668d4705a4
--- /dev/null
+++ b/rust/kernel/sync/rwsem.rs
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel read/write mutex.
+//!
+//! This module allows Rust code to use the kernel's [`struct rw_semaphore`].
+//!
+//! C header: [`include/linux/rwsem.h`](../../../../include/linux/rwsem.h)
+
+use super::{mutex::EmptyGuardContext, CreatableLock, Guard, Lock, ReadLock};
+use crate::{bindings, str::CStr, Opaque};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`RwSemaphore`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! rwsemaphore_init {
+    ($rwsem:expr, $name:literal) => {
+        $crate::init_with_lockdep!($rwsem, $name)
+    };
+}
+
+/// Exposes the kernel's [`struct rw_semaphore`].
+///
+/// It's a read/write mutex. That is, it allows multiple readers to acquire it concurrently, but
+/// only one writer at a time. On contention, waiters sleep.
+///
+/// A [`RwSemaphore`] must first be initialised with a call to [`RwSemaphore::init_lock`] before it
+/// can be used. The [`rwsemaphore_init`] macro is provided to automatically assign a new lock
+/// class to an [`RwSemaphore`] instance.
+///
+/// Since it may block, [`RwSemaphore`] needs to be used with care in atomic contexts.
+///
+/// [`struct rw_semaphore`]: ../../../include/linux/rwsem.h
+pub struct RwSemaphore<T: ?Sized> {
+    /// The kernel `struct rw_semaphore` object.
+    rwsem: Opaque<bindings::rw_semaphore>,
+
+    /// An rwsem needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    _pin: PhantomPinned,
+
+    /// The data protected by the rwsem.
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `RwSemaphore` can be transferred across thread boundaries iff the data it protects can.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: ?Sized + Send> Send for RwSemaphore<T> {}
+
+// SAFETY: `RwSemaphore` requires that the protected type be `Sync` for it to be `Sync` as well
+// because the read mode allows multiple threads to access the protected data concurrently. It
+// requires `Send` because the write lock allows a `&mut T` to be accessible from an arbitrary
+// thread.
+unsafe impl<T: ?Sized + Send + Sync> Sync for RwSemaphore<T> {}
+
+impl<T> RwSemaphore<T> {
+    /// Constructs a new rw semaphore.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`RwSemaphore::init_lock`] before using the rw semaphore.
+    pub unsafe fn new(t: T) -> Self {
+        Self {
+            rwsem: Opaque::uninit(),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> RwSemaphore<T> {
+    /// Locks the rw semaphore in write (exclusive) mode and gives the caller access to the data
+    /// protected by it. Only one thread at a time is allowed to access the protected data.
+    pub fn write(&self) -> Guard<'_, Self> {
+        let ctx = <Self as Lock>::lock_noguard(self);
+        // SAFETY: The rw semaphore was just acquired in write mode.
+        unsafe { Guard::new(self, ctx) }
+    }
+
+    /// Locks the rw semaphore in read (shared) mode and gives the caller access to the data
+    /// protected by it. Only one thread at a time is allowed to access the protected data.
+    pub fn read(&self) -> Guard<'_, Self, ReadLock> {
+        let ctx = <Self as Lock<ReadLock>>::lock_noguard(self);
+        // SAFETY: The rw semaphore was just acquired in read mode.
+        unsafe { Guard::new(self, ctx) }
+    }
+}
+
+impl<T> CreatableLock for RwSemaphore<T> {
+    type CreateArgType = T;
+
+    unsafe fn new_lock(data: Self::CreateArgType) -> Self {
+        // SAFETY: The safety requirements of `new_lock` also require that `init_lock` be called.
+        unsafe { Self::new(data) }
+    }
+
+    unsafe fn init_lock(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+    ) {
+        unsafe { bindings::__init_rwsem(self.rwsem.get(), name.as_char_ptr(), key) };
+    }
+}
+
+// SAFETY: The underlying kernel `struct rw_semaphore` object ensures mutual exclusion because it's
+// acquired in write mode.
+unsafe impl<T: ?Sized> Lock for RwSemaphore<T> {
+    type Inner = T;
+    type GuardContext = EmptyGuardContext;
+
+    fn lock_noguard(&self) -> EmptyGuardContext {
+        // SAFETY: `rwsem` points to valid memory.
+        unsafe { bindings::down_write(self.rwsem.get()) };
+        EmptyGuardContext
+    }
+
+    unsafe fn unlock(&self, _: &mut EmptyGuardContext) {
+        // SAFETY: The safety requirements of the function ensure that the rw semaphore is owned by
+        // the caller.
+        unsafe { bindings::up_write(self.rwsem.get()) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
+
+// SAFETY: The underlying kernel `struct rw_semaphore` object ensures that only shared references
+// are accessible from other threads because it's acquired in read mode.
+unsafe impl<T: ?Sized> Lock<ReadLock> for RwSemaphore<T> {
+    type Inner = T;
+    type GuardContext = EmptyGuardContext;
+
+    fn lock_noguard(&self) -> EmptyGuardContext {
+        // SAFETY: `rwsem` points to valid memory.
+        unsafe { bindings::down_read(self.rwsem.get()) };
+        EmptyGuardContext
+    }
+
+    unsafe fn unlock(&self, _: &mut EmptyGuardContext) {
+        // SAFETY: The safety requirements of the function ensure that the rw semaphore is owned by
+        // the caller.
+        unsafe { bindings::up_read(self.rwsem.get()) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
diff --git a/rust/kernel/sync/seqlock.rs b/rust/kernel/sync/seqlock.rs
new file mode 100644
index 000000000000..a80a588676b8
--- /dev/null
+++ b/rust/kernel/sync/seqlock.rs
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel sequential lock (seqlock).
+//!
+//! This module allows Rust code to use the sequential locks based on the kernel's `seqcount_t` and
+//! any locks implementing the [`CreatableLock`] trait.
+//!
+//! See <https://www.kernel.org/doc/Documentation/locking/seqlock.rst>.
+
+use super::{CreatableLock, Guard, Lock, NeedsLockClass, ReadLock};
+use crate::{bindings, str::CStr, Opaque};
+use core::{cell::UnsafeCell, marker::PhantomPinned, ops::Deref, pin::Pin};
+
+/// Exposes sequential locks backed by the kernel's `seqcount_t`.
+///
+/// The write-side critical section is protected by a lock implementing the `CreatableLock` trait.
+///
+/// # Examples
+///
+///```
+/// # use kernel::prelude::*;
+/// use kernel::sync::{SeqLock, SpinLock};
+/// use core::sync::atomic::{AtomicU32, Ordering};
+///
+/// struct Example {
+///     a: AtomicU32,
+///     b: AtomicU32,
+/// }
+///
+/// fn get_sum(v: &SeqLock<SpinLock<Example>>) -> u32 {
+///     // Use `access` to access the fields of `Example`.
+///     v.access(|e| e.a.load(Ordering::Relaxed) + e.b.load(Ordering::Relaxed))
+/// }
+///
+/// fn get_sum_with_guard(v: &SeqLock<SpinLock<Example>>) -> u32 {
+///     // Use `read` and `need_retry` in a loop to access the fields of `Example`.
+///     loop {
+///         let guard = v.read();
+///         let sum = guard.a.load(Ordering::Relaxed) + guard.b.load(Ordering::Relaxed);
+///         if !guard.need_retry() {
+///             break sum;
+///         }
+///     }
+/// }
+///
+/// fn inc_each(v: &SeqLock<SpinLock<Example>>) {
+///     // Use a write-side guard to access the fields of `Example`.
+///     let guard = v.write();
+///     let a = guard.a.load(Ordering::Relaxed);
+///     guard.a.store(a + 1, Ordering::Relaxed);
+///     let b = guard.b.load(Ordering::Relaxed);
+///     guard.b.store(b + 1, Ordering::Relaxed);
+/// }
+/// ```
+pub struct SeqLock<L: CreatableLock + Lock + ?Sized> {
+    _p: PhantomPinned,
+    count: Opaque<bindings::seqcount>,
+    write_lock: L,
+}
+
+// SAFETY: `SeqLock` can be transferred across thread boundaries iff the data it protects and the
+// underlying lock can.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<L: CreatableLock + Lock + Send> Send for SeqLock<L> where L::Inner: Send {}
+
+// SAFETY: `SeqLock` allows concurrent access to the data it protects by both readers and writers,
+// so it requires that the data it protects be `Sync`, as well as the underlying lock.
+unsafe impl<L: CreatableLock + Lock + Sync> Sync for SeqLock<L> where L::Inner: Sync {}
+
+impl<L: CreatableLock + Lock> SeqLock<L> {
+    /// Constructs a new instance of [`SeqLock`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`SeqLock::init`] before using the seqlock.
+    pub unsafe fn new(data: L::CreateArgType) -> Self
+    where
+        L::CreateArgType: Sized,
+    {
+        Self {
+            _p: PhantomPinned,
+            count: Opaque::uninit(),
+            // SAFETY: `L::init_lock` is called from `SeqLock::init`, which is required to be
+            // called by the function's safety requirements.
+            write_lock: unsafe { L::new_lock(data) },
+        }
+    }
+}
+
+impl<L: CreatableLock + Lock + ?Sized> SeqLock<L> {
+    /// Accesses the protected data in read mode.
+    ///
+    /// Readers and writers are allowed to run concurrently, so callers must check if they need to
+    /// refetch the values before they are used (e.g., because a writer changed them concurrently,
+    /// rendering them potentially inconsistent). The check is performed via calls to
+    /// [`SeqLockReadGuard::need_retry`].
+    pub fn read(&self) -> SeqLockReadGuard<'_, L> {
+        SeqLockReadGuard {
+            lock: self,
+            // SAFETY: `count` contains valid memory.
+            start_count: unsafe { bindings::read_seqcount_begin(self.count.get()) },
+        }
+    }
+
+    /// Accesses the protected data in read mode.
+    ///
+    /// The provided closure is called repeatedly if it may have accessed inconsistent data (e.g.,
+    /// because a concurrent writer modified it). This is a wrapper around [`SeqLock::read`] and
+    /// [`SeqLockReadGuard::need_retry`] in a loop.
+    pub fn access<F: Fn(&L::Inner) -> R, R>(&self, cb: F) -> R {
+        loop {
+            let guard = self.read();
+            let ret = cb(&guard);
+            if !guard.need_retry() {
+                return ret;
+            }
+        }
+    }
+
+    /// Locks the underlying lock and returns a guard that allows access to the protected data.
+    ///
+    /// The guard is not mutable though because readers are still allowed to concurrently access
+    /// the data. The protected data structure needs to provide interior mutability itself (e.g.,
+    /// via atomic types) for the individual fields that can be mutated.
+    pub fn write(&self) -> Guard<'_, Self, ReadLock> {
+        let ctx = self.lock_noguard();
+        // SAFETY: The seqlock was just acquired.
+        unsafe { Guard::new(self, ctx) }
+    }
+}
+
+impl<L: CreatableLock + Lock + ?Sized> NeedsLockClass for SeqLock<L> {
+    unsafe fn init(
+        mut self: Pin<&mut Self>,
+        name: &'static CStr,
+        key1: *mut bindings::lock_class_key,
+        key2: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: `write_lock` is pinned when `self` is.
+        let pinned = unsafe { self.as_mut().map_unchecked_mut(|s| &mut s.write_lock) };
+        // SAFETY: `key1` is valid by the safety requirements of this function.
+        unsafe { pinned.init_lock(name, key1) };
+        // SAFETY: `key2` is valid by the safety requirements of this function.
+        unsafe { bindings::__seqcount_init(self.count.get(), name.as_char_ptr(), key2) };
+    }
+}
+
+// SAFETY: The underlying lock ensures mutual exclusion.
+unsafe impl<L: CreatableLock + Lock + ?Sized> Lock<ReadLock> for SeqLock<L> {
+    type Inner = L::Inner;
+    type GuardContext = L::GuardContext;
+
+    fn lock_noguard(&self) -> L::GuardContext {
+        let ctx = self.write_lock.lock_noguard();
+        // SAFETY: `count` contains valid memory.
+        unsafe { bindings::write_seqcount_begin(self.count.get()) };
+        ctx
+    }
+
+    fn relock(&self, ctx: &mut L::GuardContext) {
+        self.write_lock.relock(ctx);
+        // SAFETY: `count` contains valid memory.
+        unsafe { bindings::write_seqcount_begin(self.count.get()) };
+    }
+
+    unsafe fn unlock(&self, ctx: &mut L::GuardContext) {
+        // SAFETY: The safety requirements of the function ensure that lock is owned by the caller.
+        unsafe { bindings::write_seqcount_end(self.count.get()) };
+        // SAFETY: The safety requirements of the function ensure that lock is owned by the caller.
+        unsafe { self.write_lock.unlock(ctx) };
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<L::Inner> {
+        self.write_lock.locked_data()
+    }
+}
+
+/// Allows read-side access to data protected by a sequential lock.
+pub struct SeqLockReadGuard<'a, L: CreatableLock + Lock + ?Sized> {
+    lock: &'a SeqLock<L>,
+    start_count: u32,
+}
+
+impl<L: CreatableLock + Lock + ?Sized> SeqLockReadGuard<'_, L> {
+    /// Determine if the callers needs to retry reading values.
+    ///
+    /// It returns `true` when a concurrent writer ran between the guard being created and
+    /// [`Self::need_retry`] being called.
+    pub fn need_retry(&self) -> bool {
+        // SAFETY: `count` is valid because the guard guarantees that the lock remains alive.
+        unsafe { bindings::read_seqcount_retry(self.lock.count.get(), self.start_count) != 0 }
+    }
+}
+
+impl<L: CreatableLock + Lock + ?Sized> Deref for SeqLockReadGuard<'_, L> {
+    type Target = L::Inner;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: We only ever allow shared access to the protected data.
+        unsafe { &*self.lock.locked_data().get() }
+    }
+}
diff --git a/rust/kernel/sync/spinlock.rs b/rust/kernel/sync/spinlock.rs
new file mode 100644
index 000000000000..afad033854fe
--- /dev/null
+++ b/rust/kernel/sync/spinlock.rs
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel spinlock.
+//!
+//! This module allows Rust code to use the kernel's [`struct spinlock`].
+//!
+//! See <https://www.kernel.org/doc/Documentation/locking/spinlocks.txt>.
+
+use super::{mutex::EmptyGuardContext, CreatableLock, Guard, Lock, LockInfo, WriteLock};
+use crate::{bindings, c_types, str::CStr, Opaque, True};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
+
+/// Safely initialises a [`SpinLock`] with the given name, generating a new lock class.
+#[macro_export]
+macro_rules! spinlock_init {
+    ($spinlock:expr, $name:literal) => {
+        $crate::init_with_lockdep!($spinlock, $name)
+    };
+}
+
+/// Exposes the kernel's [`spinlock_t`]. When multiple CPUs attempt to lock the same spinlock, only
+/// one at a time is allowed to progress, the others will block (spinning) until the spinlock is
+/// unlocked, at which point another CPU will be allowed to make progress.
+///
+/// A [`SpinLock`] must first be initialised with a call to [`SpinLock::init_lock`] before it can be
+/// used. The [`spinlock_init`] macro is provided to automatically assign a new lock class to a
+/// spinlock instance.
+///
+/// There are two ways to acquire the lock:
+///  - [`SpinLock::lock`], which doesn't manage interrupt state, so it should be used in only two
+///    cases: (a) when the caller knows that interrupts are disabled, or (b) when callers never use
+///    it in atomic context (e.g., interrupt handlers), in which case it is ok for interrupts to be
+///    enabled.
+///  - [`SpinLock::lock_irqdisable`], which disables interrupts if they are enabled before
+///    acquiring the lock. When the lock is released, the interrupt state is automatically returned
+///    to its value before [`SpinLock::lock_irqdisable`] was called.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::sync::SpinLock;
+/// # use core::pin::Pin;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// // Function that acquires spinlock without changing interrupt state.
+/// fn lock_example(value: &SpinLock<Example>) {
+///     let mut guard = value.lock();
+///     guard.a = 10;
+///     guard.b = 20;
+/// }
+///
+/// // Function that acquires spinlock and disables interrupts while holding it.
+/// fn lock_irqdisable_example(value: &SpinLock<Example>) {
+///     let mut guard = value.lock_irqdisable();
+///     guard.a = 30;
+///     guard.b = 40;
+/// }
+///
+/// // Initialises a spinlock and calls the example functions.
+/// pub fn spinlock_example() {
+///     // SAFETY: `spinlock_init` is called below.
+///     let mut value = unsafe { SpinLock::new(Example { a: 1, b: 2 }) };
+///     // SAFETY: We don't move `value`.
+///     kernel::spinlock_init!(unsafe { Pin::new_unchecked(&mut value) }, "value");
+///     lock_example(&value);
+///     lock_irqdisable_example(&value);
+/// }
+/// ```
+///
+/// [`spinlock_t`]: ../../../include/linux/spinlock.h
+pub struct SpinLock<T: ?Sized> {
+    spin_lock: Opaque<bindings::spinlock>,
+
+    /// Spinlocks are architecture-defined. So we conservatively require them to be pinned in case
+    /// some architecture uses self-references now or in the future.
+    _pin: PhantomPinned,
+
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `SpinLock` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send> Send for SpinLock<T> {}
+
+// SAFETY: `SpinLock` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send> Sync for SpinLock<T> {}
+
+impl<T> SpinLock<T> {
+    /// Constructs a new spinlock.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call [`SpinLock::init_lock`] before using the spinlock.
+    pub const unsafe fn new(t: T) -> Self {
+        Self {
+            spin_lock: Opaque::uninit(),
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+impl<T: ?Sized> SpinLock<T> {
+    /// Locks the spinlock and gives the caller access to the data protected by it. Only one thread
+    /// at a time is allowed to access the protected data.
+    pub fn lock(&self) -> Guard<'_, Self, WriteLock> {
+        let ctx = <Self as Lock<WriteLock>>::lock_noguard(self);
+        // SAFETY: The spinlock was just acquired.
+        unsafe { Guard::new(self, ctx) }
+    }
+
+    /// Locks the spinlock and gives the caller access to the data protected by it. Additionally it
+    /// disables interrupts (if they are enabled).
+    ///
+    /// When the lock in unlocked, the interrupt state (enabled/disabled) is restored.
+    pub fn lock_irqdisable(&self) -> Guard<'_, Self, DisabledInterrupts> {
+        let ctx = <Self as Lock<DisabledInterrupts>>::lock_noguard(self);
+        // SAFETY: The spinlock was just acquired.
+        unsafe { Guard::new(self, ctx) }
+    }
+}
+
+impl<T> CreatableLock for SpinLock<T> {
+    type CreateArgType = T;
+
+    unsafe fn new_lock(data: Self::CreateArgType) -> Self {
+        // SAFETY: The safety requirements of `new_lock` also require that `init_lock` be called.
+        unsafe { Self::new(data) }
+    }
+
+    unsafe fn init_lock(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        key: *mut bindings::lock_class_key,
+    ) {
+        unsafe { bindings::__spin_lock_init(self.spin_lock.get(), name.as_char_ptr(), key) };
+    }
+}
+
+/// A type state indicating that interrupts were disabled.
+pub struct DisabledInterrupts;
+impl LockInfo for DisabledInterrupts {
+    type Writable = True;
+}
+
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
+unsafe impl<T: ?Sized> Lock for SpinLock<T> {
+    type Inner = T;
+    type GuardContext = EmptyGuardContext;
+
+    fn lock_noguard(&self) -> EmptyGuardContext {
+        // SAFETY: `spin_lock` points to valid memory.
+        unsafe { bindings::spin_lock(self.spin_lock.get()) };
+        EmptyGuardContext
+    }
+
+    unsafe fn unlock(&self, _: &mut EmptyGuardContext) {
+        // SAFETY: The safety requirements of the function ensure that the spinlock is owned by
+        // the caller.
+        unsafe { bindings::spin_unlock(self.spin_lock.get()) }
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
+
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
+unsafe impl<T: ?Sized> Lock<DisabledInterrupts> for SpinLock<T> {
+    type Inner = T;
+    type GuardContext = c_types::c_ulong;
+
+    fn lock_noguard(&self) -> c_types::c_ulong {
+        // SAFETY: `spin_lock` points to valid memory.
+        unsafe { bindings::spin_lock_irqsave(self.spin_lock.get()) }
+    }
+
+    unsafe fn unlock(&self, ctx: &mut c_types::c_ulong) {
+        // SAFETY: The safety requirements of the function ensure that the spinlock is owned by
+        // the caller.
+        unsafe { bindings::spin_unlock_irqrestore(self.spin_lock.get(), *ctx) }
+    }
+
+    fn locked_data(&self) -> &UnsafeCell<T> {
+        &self.data
+    }
+}
-- 
2.35.1

