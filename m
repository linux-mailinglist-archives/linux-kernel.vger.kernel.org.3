Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25A469801
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbhLFOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbhLFOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EDC0698C4;
        Mon,  6 Dec 2021 06:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8055DB810D9;
        Mon,  6 Dec 2021 14:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B3FC341C2;
        Mon,  6 Dec 2021 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799586;
        bh=jQQZAF1kSquVzitq16JJcyMw4B9XEj5xjiEA262P4og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n69fLHhzHN8I8lTIOFQyECPbo4IM6dOmSACkal2PF5dsCa1797Rg9vdLh38gmaRsy
         Y1rl954boXImXGqYWLkBIJdcxa3XPyKCEwb12KJmLvSukEXY809V4up8InWw3q5hx9
         RVMue8E0H02GBGRMecRA91/XH6b0paUFFHxmXe+ln5Js3cbO3mrZqi7lNH0EHKHxwj
         CcVVpL46kP4aFKLuV2Y/FMs/z77QDfXn7+ClSRt/Jn7kMeTa0G+RoYtbtrMYkstHou
         zv4LhJN8h8oc4NwWKLyN9Rn3C6PQp+G17Y3iOxR3BFeoCr9d/N6YvGaVzg8+ddRg0v
         /9WW9OTDsBQTg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [RFC PATCH 19/19] drivers: android: Binder IPC in Rust
Date:   Mon,  6 Dec 2021 15:03:13 +0100
Message-Id: <20211206140313.5653-20-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <wedsonaf@google.com>

A port to Rust of the Android Binder IPC mechanism.

This module is a work in progress and will be sent for review later
on, as well as separately from the Rust support.

However, it is included to show how an actual working module
written in Rust may look like.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Wayne Campbell <wcampbell1995@gmail.com>
Signed-off-by: Wayne Campbell <wcampbell1995@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/android/Kconfig             |   7 +
 drivers/android/Makefile            |   2 +
 drivers/android/allocation.rs       | 266 ++++++++
 drivers/android/context.rs          |  79 +++
 drivers/android/defs.rs             |  99 +++
 drivers/android/node.rs             | 476 ++++++++++++++
 drivers/android/process.rs          | 964 ++++++++++++++++++++++++++++
 drivers/android/range_alloc.rs      | 189 ++++++
 drivers/android/rust_binder.rs      | 114 ++++
 drivers/android/thread.rs           | 871 +++++++++++++++++++++++++
 drivers/android/transaction.rs      | 326 ++++++++++
 include/uapi/linux/android/binder.h |  28 +-
 12 files changed, 3408 insertions(+), 13 deletions(-)
 create mode 100644 drivers/android/allocation.rs
 create mode 100644 drivers/android/context.rs
 create mode 100644 drivers/android/defs.rs
 create mode 100644 drivers/android/node.rs
 create mode 100644 drivers/android/process.rs
 create mode 100644 drivers/android/range_alloc.rs
 create mode 100644 drivers/android/rust_binder.rs
 create mode 100644 drivers/android/thread.rs
 create mode 100644 drivers/android/transaction.rs

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 53b22e26266c..7aef7f38f988 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -20,6 +20,13 @@ config ANDROID_BINDER_IPC
 	  Android process, using Binder to identify, invoke and pass arguments
 	  between said processes.
 
+config ANDROID_BINDER_IPC_RUST
+	bool "Android Binder IPC Driver in Rust"
+	depends on MMU && RUST
+	default n
+	help
+	  Implementation of the Binder IPC in Rust.
+
 config ANDROID_BINDERFS
 	bool "Android Binderfs filesystem"
 	depends on ANDROID_BINDER_IPC
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c9d3d0c99c25..c428f2ce2f05 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -4,3 +4,5 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
 obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
+
+obj-$(CONFIG_ANDROID_BINDER_IPC_RUST) += rust_binder.o
diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
new file mode 100644
index 000000000000..5142bc11ab45
--- /dev/null
+++ b/drivers/android/allocation.rs
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::mem::{replace, size_of, MaybeUninit};
+use kernel::{
+    bindings, linked_list::List, pages::Pages, prelude::*, sync::Ref, user_ptr::UserSlicePtrReader,
+};
+
+use crate::{
+    defs::*,
+    node::NodeRef,
+    process::{AllocationInfo, Process},
+    thread::{BinderError, BinderResult},
+    transaction::FileInfo,
+};
+
+pub(crate) struct Allocation<'a> {
+    pub(crate) offset: usize,
+    size: usize,
+    pub(crate) ptr: usize,
+    pages: Ref<[Pages<0>]>,
+    pub(crate) process: &'a Process,
+    allocation_info: Option<AllocationInfo>,
+    free_on_drop: bool,
+    file_list: List<Box<FileInfo>>,
+}
+
+impl<'a> Allocation<'a> {
+    pub(crate) fn new(
+        process: &'a Process,
+        offset: usize,
+        size: usize,
+        ptr: usize,
+        pages: Ref<[Pages<0>]>,
+    ) -> Self {
+        Self {
+            process,
+            offset,
+            size,
+            ptr,
+            pages,
+            allocation_info: None,
+            free_on_drop: true,
+            file_list: List::new(),
+        }
+    }
+
+    pub(crate) fn take_file_list(&mut self) -> List<Box<FileInfo>> {
+        replace(&mut self.file_list, List::new())
+    }
+
+    pub(crate) fn add_file_info(&mut self, file: Box<FileInfo>) {
+        self.file_list.push_back(file);
+    }
+
+    fn iterate<T>(&self, mut offset: usize, mut size: usize, mut cb: T) -> Result
+    where
+        T: FnMut(&Pages<0>, usize, usize) -> Result,
+    {
+        // Check that the request is within the buffer.
+        if offset.checked_add(size).ok_or(Error::EINVAL)? > self.size {
+            return Err(Error::EINVAL);
+        }
+        offset += self.offset;
+        let mut page_index = offset >> bindings::PAGE_SHIFT;
+        offset &= (1 << bindings::PAGE_SHIFT) - 1;
+        while size > 0 {
+            let available = core::cmp::min(size, (1 << bindings::PAGE_SHIFT) as usize - offset);
+            cb(&self.pages[page_index], offset, available)?;
+            size -= available;
+            page_index += 1;
+            offset = 0;
+        }
+        Ok(())
+    }
+
+    pub(crate) fn copy_into(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        size: usize,
+    ) -> Result {
+        self.iterate(offset, size, |page, offset, to_copy| {
+            page.copy_into_page(reader, offset, to_copy)
+        })
+    }
+
+    pub(crate) fn read<T>(&self, offset: usize) -> Result<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        let mut out_offset = 0;
+        self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
+            // SAFETY: Data buffer is allocated on the stack.
+            unsafe {
+                page.read(
+                    (out.as_mut_ptr() as *mut u8).add(out_offset),
+                    offset,
+                    to_copy,
+                )
+            }?;
+            out_offset += to_copy;
+            Ok(())
+        })?;
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+
+    pub(crate) fn write<T>(&self, offset: usize, obj: &T) -> Result {
+        let mut obj_offset = 0;
+        self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
+            // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
+            let obj_ptr = unsafe { (obj as *const T as *const u8).add(obj_offset) };
+            // SAFETY: We have a reference to the object, so the pointer is valid.
+            unsafe { page.write(obj_ptr, offset, to_copy) }?;
+            obj_offset += to_copy;
+            Ok(())
+        })
+    }
+
+    pub(crate) fn keep_alive(mut self) {
+        self.process
+            .buffer_make_freeable(self.offset, self.allocation_info.take());
+        self.free_on_drop = false;
+    }
+
+    pub(crate) fn set_info(&mut self, info: AllocationInfo) {
+        self.allocation_info = Some(info);
+    }
+}
+
+impl Drop for Allocation<'_> {
+    fn drop(&mut self) {
+        if !self.free_on_drop {
+            return;
+        }
+
+        if let Some(info) = &self.allocation_info {
+            let offsets = info.offsets.clone();
+            let view = AllocationView::new(self, offsets.start);
+            for i in offsets.step_by(size_of::<usize>()) {
+                if view.cleanup_object(i).is_err() {
+                    pr_warn!("Error cleaning up object at offset {}\n", i)
+                }
+            }
+        }
+
+        self.process.buffer_raw_free(self.ptr);
+    }
+}
+
+pub(crate) struct AllocationView<'a, 'b> {
+    pub(crate) alloc: &'a mut Allocation<'b>,
+    limit: usize,
+}
+
+impl<'a, 'b> AllocationView<'a, 'b> {
+    pub(crate) fn new(alloc: &'a mut Allocation<'b>, limit: usize) -> Self {
+        AllocationView { alloc, limit }
+    }
+
+    pub(crate) fn read<T>(&self, offset: usize) -> Result<T> {
+        if offset.checked_add(size_of::<T>()).ok_or(Error::EINVAL)? > self.limit {
+            return Err(Error::EINVAL);
+        }
+        self.alloc.read(offset)
+    }
+
+    pub(crate) fn write<T>(&self, offset: usize, obj: &T) -> Result {
+        if offset.checked_add(size_of::<T>()).ok_or(Error::EINVAL)? > self.limit {
+            return Err(Error::EINVAL);
+        }
+        self.alloc.write(offset, obj)
+    }
+
+    pub(crate) fn transfer_binder_object<T>(
+        &self,
+        offset: usize,
+        strong: bool,
+        get_node: T,
+    ) -> BinderResult
+    where
+        T: FnOnce(&bindings::flat_binder_object) -> BinderResult<NodeRef>,
+    {
+        // TODO: Do we want this function to take a &mut self?
+        let obj = self.read::<bindings::flat_binder_object>(offset)?;
+        let node_ref = get_node(&obj)?;
+
+        if core::ptr::eq(&*node_ref.node.owner, self.alloc.process) {
+            // The receiving process is the owner of the node, so send it a binder object (instead
+            // of a handle).
+            let (ptr, cookie) = node_ref.node.get_id();
+            let newobj = bindings::flat_binder_object {
+                hdr: bindings::binder_object_header {
+                    type_: if strong {
+                        BINDER_TYPE_BINDER
+                    } else {
+                        BINDER_TYPE_WEAK_BINDER
+                    },
+                },
+                flags: obj.flags,
+                __bindgen_anon_1: bindings::flat_binder_object__bindgen_ty_1 { binder: ptr as _ },
+                cookie: cookie as _,
+            };
+            self.write(offset, &newobj)?;
+
+            // Increment the user ref count on the node. It will be decremented as part of the
+            // destruction of the buffer, when we see a binder or weak-binder object.
+            node_ref.node.update_refcount(true, strong);
+        } else {
+            // The receiving process is different from the owner, so we need to insert a handle to
+            // the binder object.
+            let handle = self
+                .alloc
+                .process
+                .insert_or_update_handle(node_ref, false)?;
+
+            let newobj = bindings::flat_binder_object {
+                hdr: bindings::binder_object_header {
+                    type_: if strong {
+                        BINDER_TYPE_HANDLE
+                    } else {
+                        BINDER_TYPE_WEAK_HANDLE
+                    },
+                },
+                flags: obj.flags,
+                // TODO: To avoid padding, we write to `binder` instead of `handle` here. We need a
+                // better solution though.
+                __bindgen_anon_1: bindings::flat_binder_object__bindgen_ty_1 {
+                    binder: handle as _,
+                },
+                ..bindings::flat_binder_object::default()
+            };
+            if self.write(offset, &newobj).is_err() {
+                // Decrement ref count on the handle we just created.
+                let _ = self.alloc.process.update_ref(handle, false, strong);
+                return Err(BinderError::new_failed());
+            }
+        }
+        Ok(())
+    }
+
+    fn cleanup_object(&self, index_offset: usize) -> Result {
+        let offset = self.alloc.read(index_offset)?;
+        let header = self.read::<bindings::binder_object_header>(offset)?;
+        // TODO: Handle other types.
+        match header.type_ {
+            BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
+                let obj = self.read::<bindings::flat_binder_object>(offset)?;
+                let strong = header.type_ == BINDER_TYPE_BINDER;
+                // SAFETY: The type is `BINDER_TYPE_{WEAK_}BINDER`, so the `binder` field is
+                // populated.
+                let ptr = unsafe { obj.__bindgen_anon_1.binder } as usize;
+                let cookie = obj.cookie as usize;
+                self.alloc.process.update_node(ptr, cookie, strong, false);
+                Ok(())
+            }
+            BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => {
+                let obj = self.read::<bindings::flat_binder_object>(offset)?;
+                let strong = header.type_ == BINDER_TYPE_HANDLE;
+                // SAFETY: The type is `BINDER_TYPE_{WEAK_}HANDLE`, so the `handle` field is
+                // populated.
+                let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
+                self.alloc.process.update_ref(handle, false, strong)
+            }
+            _ => Ok(()),
+        }
+    }
+}
diff --git a/drivers/android/context.rs b/drivers/android/context.rs
new file mode 100644
index 000000000000..3661e7a4f646
--- /dev/null
+++ b/drivers/android/context.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    bindings,
+    prelude::*,
+    security,
+    sync::{Mutex, Ref, UniqueRef},
+};
+
+use crate::{
+    node::NodeRef,
+    thread::{BinderError, BinderResult},
+};
+
+struct Manager {
+    node: Option<NodeRef>,
+    uid: Option<bindings::kuid_t>,
+}
+
+pub(crate) struct Context {
+    manager: Mutex<Manager>,
+}
+
+unsafe impl Send for Context {}
+unsafe impl Sync for Context {}
+
+impl Context {
+    pub(crate) fn new() -> Result<Ref<Self>> {
+        let mut ctx = Pin::from(UniqueRef::try_new(Self {
+            // SAFETY: Init is called below.
+            manager: unsafe {
+                Mutex::new(Manager {
+                    node: None,
+                    uid: None,
+                })
+            },
+        })?);
+
+        // SAFETY: `manager` is also pinned when `ctx` is.
+        let manager = unsafe { ctx.as_mut().map_unchecked_mut(|c| &mut c.manager) };
+        kernel::mutex_init!(manager, "Context::manager");
+
+        Ok(ctx.into())
+    }
+
+    pub(crate) fn set_manager_node(&self, node_ref: NodeRef) -> Result {
+        let mut manager = self.manager.lock();
+        if manager.node.is_some() {
+            return Err(Error::EBUSY);
+        }
+        security::binder_set_context_mgr(&node_ref.node.owner.cred)?;
+
+        // TODO: Get the actual caller id.
+        let caller_uid = bindings::kuid_t::default();
+        if let Some(ref uid) = manager.uid {
+            if uid.val != caller_uid.val {
+                return Err(Error::EPERM);
+            }
+        }
+
+        manager.node = Some(node_ref);
+        manager.uid = Some(caller_uid);
+        Ok(())
+    }
+
+    pub(crate) fn unset_manager_node(&self) {
+        let node_ref = self.manager.lock().node.take();
+        drop(node_ref);
+    }
+
+    pub(crate) fn get_manager_node(&self, strong: bool) -> BinderResult<NodeRef> {
+        self.manager
+            .lock()
+            .node
+            .as_ref()
+            .ok_or_else(BinderError::new_dead)?
+            .clone(strong)
+    }
+}
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
new file mode 100644
index 000000000000..ec2dde9b3dd8
--- /dev/null
+++ b/drivers/android/defs.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::ops::{Deref, DerefMut};
+use kernel::{
+    bindings,
+    bindings::*,
+    io_buffer::{ReadableFromBytes, WritableToBytes},
+};
+
+macro_rules! pub_no_prefix {
+    ($prefix:ident, $($newname:ident),+) => {
+        $(pub(crate) const $newname: u32 = concat_idents!($prefix, $newname);)+
+    };
+}
+
+pub_no_prefix!(
+    binder_driver_return_protocol_,
+    BR_OK,
+    BR_ERROR,
+    BR_TRANSACTION,
+    BR_REPLY,
+    BR_DEAD_REPLY,
+    BR_TRANSACTION_COMPLETE,
+    BR_INCREFS,
+    BR_ACQUIRE,
+    BR_RELEASE,
+    BR_DECREFS,
+    BR_NOOP,
+    BR_SPAWN_LOOPER,
+    BR_DEAD_BINDER,
+    BR_CLEAR_DEATH_NOTIFICATION_DONE,
+    BR_FAILED_REPLY
+);
+
+pub_no_prefix!(
+    binder_driver_command_protocol_,
+    BC_TRANSACTION,
+    BC_REPLY,
+    BC_FREE_BUFFER,
+    BC_INCREFS,
+    BC_ACQUIRE,
+    BC_RELEASE,
+    BC_DECREFS,
+    BC_INCREFS_DONE,
+    BC_ACQUIRE_DONE,
+    BC_REGISTER_LOOPER,
+    BC_ENTER_LOOPER,
+    BC_EXIT_LOOPER,
+    BC_REQUEST_DEATH_NOTIFICATION,
+    BC_CLEAR_DEATH_NOTIFICATION,
+    BC_DEAD_BINDER_DONE
+);
+
+pub_no_prefix!(transaction_flags_, TF_ONE_WAY, TF_ACCEPT_FDS);
+
+pub(crate) use bindings::{
+    BINDER_TYPE_BINDER, BINDER_TYPE_FD, BINDER_TYPE_HANDLE, BINDER_TYPE_WEAK_BINDER,
+    BINDER_TYPE_WEAK_HANDLE, FLAT_BINDER_FLAG_ACCEPTS_FDS,
+};
+
+macro_rules! decl_wrapper {
+    ($newname:ident, $wrapped:ty) => {
+        #[derive(Copy, Clone, Default)]
+        pub(crate) struct $newname($wrapped);
+
+        // TODO: This must be justified by inspecting the type, so should live outside the macro or
+        // the macro should be somehow marked unsafe.
+        unsafe impl ReadableFromBytes for $newname {}
+        unsafe impl WritableToBytes for $newname {}
+
+        impl Deref for $newname {
+            type Target = $wrapped;
+            fn deref(&self) -> &Self::Target {
+                &self.0
+            }
+        }
+
+        impl DerefMut for $newname {
+            fn deref_mut(&mut self) -> &mut Self::Target {
+                &mut self.0
+            }
+        }
+    };
+}
+
+decl_wrapper!(BinderNodeDebugInfo, bindings::binder_node_debug_info);
+decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
+decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
+decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
+decl_wrapper!(BinderWriteRead, bindings::binder_write_read);
+decl_wrapper!(BinderVersion, bindings::binder_version);
+
+impl BinderVersion {
+    pub(crate) fn current() -> Self {
+        Self(bindings::binder_version {
+            protocol_version: bindings::BINDER_CURRENT_PROTOCOL_VERSION as _,
+        })
+    }
+}
diff --git a/drivers/android/node.rs b/drivers/android/node.rs
new file mode 100644
index 000000000000..fd0c80aba476
--- /dev/null
+++ b/drivers/android/node.rs
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::sync::atomic::{AtomicU64, Ordering};
+use kernel::{
+    io_buffer::IoBufferWriter,
+    linked_list::{GetLinks, Links, List},
+    prelude::*,
+    sync::{GuardMut, LockedBy, Mutex, Ref, SpinLock},
+    user_ptr::UserSlicePtrWriter,
+};
+
+use crate::{
+    defs::*,
+    process::{Process, ProcessInner},
+    thread::{BinderError, BinderResult, Thread},
+    DeliverToRead,
+};
+
+struct CountState {
+    count: usize,
+    has_count: bool,
+    is_biased: bool,
+}
+
+impl CountState {
+    fn new() -> Self {
+        Self {
+            count: 0,
+            has_count: false,
+            is_biased: false,
+        }
+    }
+
+    fn add_bias(&mut self) {
+        self.count += 1;
+        self.is_biased = true;
+    }
+}
+
+struct NodeInner {
+    strong: CountState,
+    weak: CountState,
+    death_list: List<Ref<NodeDeath>>,
+}
+
+struct NodeDeathInner {
+    dead: bool,
+    cleared: bool,
+    notification_done: bool,
+
+    /// Indicates whether the normal flow was interrupted by removing the handle. In this case, we
+    /// need behave as if the death notification didn't exist (i.e., we don't deliver anything to
+    /// the user.
+    aborted: bool,
+}
+
+pub(crate) struct NodeDeath {
+    node: Ref<Node>,
+    process: Ref<Process>,
+    // TODO: Make this private.
+    pub(crate) cookie: usize,
+    work_links: Links<dyn DeliverToRead>,
+    // TODO: Add the moment we're using this for two lists, which isn't safe because we want to
+    // remove from the list without knowing the list it's in. We need to separate this out.
+    death_links: Links<NodeDeath>,
+    inner: SpinLock<NodeDeathInner>,
+}
+
+impl NodeDeath {
+    /// Constructs a new node death notification object.
+    ///
+    /// # Safety
+    ///
+    /// The caller must call `NodeDeath::init` before using the notification object.
+    pub(crate) unsafe fn new(node: Ref<Node>, process: Ref<Process>, cookie: usize) -> Self {
+        Self {
+            node,
+            process,
+            cookie,
+            work_links: Links::new(),
+            death_links: Links::new(),
+            inner: unsafe {
+                SpinLock::new(NodeDeathInner {
+                    dead: false,
+                    cleared: false,
+                    notification_done: false,
+                    aborted: false,
+                })
+            },
+        }
+    }
+
+    pub(crate) fn init(self: Pin<&mut Self>) {
+        // SAFETY: `inner` is pinned when `self` is.
+        let inner = unsafe { self.map_unchecked_mut(|n| &mut n.inner) };
+        kernel::spinlock_init!(inner, "NodeDeath::inner");
+    }
+
+    /// Sets the cleared flag to `true`.
+    ///
+    /// It removes `self` from the node's death notification list if needed. It must only be called
+    /// once.
+    ///
+    /// Returns whether it needs to be queued.
+    pub(crate) fn set_cleared(self: &Ref<Self>, abort: bool) -> bool {
+        let (needs_removal, needs_queueing) = {
+            // Update state and determine if we need to queue a work item. We only need to do it
+            // when the node is not dead or if the user already completed the death notification.
+            let mut inner = self.inner.lock();
+            inner.cleared = true;
+            if abort {
+                inner.aborted = true;
+            }
+            (!inner.dead, !inner.dead || inner.notification_done)
+        };
+
+        // Remove death notification from node.
+        if needs_removal {
+            let mut owner_inner = self.node.owner.inner.lock();
+            let node_inner = self.node.inner.access_mut(&mut owner_inner);
+            unsafe { node_inner.death_list.remove(self) };
+        }
+
+        needs_queueing
+    }
+
+    /// Sets the 'notification done' flag to `true`.
+    ///
+    /// Returns whether it needs to be queued.
+    pub(crate) fn set_notification_done(self: Ref<Self>, thread: &Thread) {
+        let needs_queueing = {
+            let mut inner = self.inner.lock();
+            inner.notification_done = true;
+            inner.cleared
+        };
+
+        if needs_queueing {
+            let _ = thread.push_work_if_looper(self);
+        }
+    }
+
+    /// Sets the 'dead' flag to `true` and queues work item if needed.
+    pub(crate) fn set_dead(self: Ref<Self>) {
+        let needs_queueing = {
+            let mut inner = self.inner.lock();
+            if inner.cleared {
+                false
+            } else {
+                inner.dead = true;
+                true
+            }
+        };
+
+        if needs_queueing {
+            // Push the death notification to the target process. There is nothing else to do if
+            // it's already dead.
+            let process = self.process.clone();
+            let _ = process.push_work(self);
+        }
+    }
+}
+
+impl GetLinks for NodeDeath {
+    type EntryType = NodeDeath;
+    fn get_links(data: &NodeDeath) -> &Links<NodeDeath> {
+        &data.death_links
+    }
+}
+
+impl DeliverToRead for NodeDeath {
+    fn do_work(self: Ref<Self>, _thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        let done = {
+            let inner = self.inner.lock();
+            if inner.aborted {
+                return Ok(true);
+            }
+            inner.cleared && (!inner.dead || inner.notification_done)
+        };
+
+        let cookie = self.cookie;
+        let cmd = if done {
+            BR_CLEAR_DEATH_NOTIFICATION_DONE
+        } else {
+            let process = self.process.clone();
+            let mut process_inner = process.inner.lock();
+            let inner = self.inner.lock();
+            if inner.aborted {
+                return Ok(true);
+            }
+            // We're still holding the inner lock, so it cannot be aborted while we insert it into
+            // the delivered list.
+            process_inner.death_delivered(self.clone());
+            BR_DEAD_BINDER
+        };
+
+        writer.write(&cmd)?;
+        writer.write(&cookie)?;
+
+        // Mimic the original code: we stop processing work items when we get to a death
+        // notification.
+        Ok(cmd != BR_DEAD_BINDER)
+    }
+
+    fn get_links(&self) -> &Links<dyn DeliverToRead> {
+        &self.work_links
+    }
+}
+
+pub(crate) struct Node {
+    pub(crate) global_id: u64,
+    ptr: usize,
+    cookie: usize,
+    pub(crate) flags: u32,
+    pub(crate) owner: Ref<Process>,
+    inner: LockedBy<NodeInner, Mutex<ProcessInner>>,
+    links: Links<dyn DeliverToRead>,
+}
+
+impl Node {
+    pub(crate) fn new(ptr: usize, cookie: usize, flags: u32, owner: Ref<Process>) -> Self {
+        static NEXT_ID: AtomicU64 = AtomicU64::new(1);
+        let inner = LockedBy::new(
+            &owner.inner,
+            NodeInner {
+                strong: CountState::new(),
+                weak: CountState::new(),
+                death_list: List::new(),
+            },
+        );
+        Self {
+            global_id: NEXT_ID.fetch_add(1, Ordering::Relaxed),
+            ptr,
+            cookie,
+            flags,
+            owner,
+            inner,
+            links: Links::new(),
+        }
+    }
+
+    pub(crate) fn get_id(&self) -> (usize, usize) {
+        (self.ptr, self.cookie)
+    }
+
+    pub(crate) fn next_death(
+        &self,
+        guard: &mut GuardMut<'_, Mutex<ProcessInner>>,
+    ) -> Option<Ref<NodeDeath>> {
+        self.inner.access_mut(guard).death_list.pop_front()
+    }
+
+    pub(crate) fn add_death(
+        &self,
+        death: Ref<NodeDeath>,
+        guard: &mut GuardMut<'_, Mutex<ProcessInner>>,
+    ) {
+        self.inner.access_mut(guard).death_list.push_back(death);
+    }
+
+    pub(crate) fn update_refcount_locked(
+        &self,
+        inc: bool,
+        strong: bool,
+        biased: bool,
+        owner_inner: &mut ProcessInner,
+    ) -> bool {
+        let inner = self.inner.access_from_mut(owner_inner);
+
+        // Get a reference to the state we'll update.
+        let state = if strong {
+            &mut inner.strong
+        } else {
+            &mut inner.weak
+        };
+
+        // Update biased state: if the count is not biased, there is nothing to do; otherwise,
+        // we're removing the bias, so mark the state as such.
+        if biased {
+            if !state.is_biased {
+                return false;
+            }
+
+            state.is_biased = false;
+        }
+
+        // Update the count and determine whether we need to push work.
+        // TODO: Here we may want to check the weak count being zero but the strong count being 1,
+        // because in such cases, we won't deliver anything to userspace, so we shouldn't queue
+        // either.
+        if inc {
+            state.count += 1;
+            !state.has_count
+        } else {
+            state.count -= 1;
+            state.count == 0 && state.has_count
+        }
+    }
+
+    pub(crate) fn update_refcount(self: &Ref<Self>, inc: bool, strong: bool) {
+        self.owner
+            .inner
+            .lock()
+            .update_node_refcount(self, inc, strong, false, None);
+    }
+
+    pub(crate) fn populate_counts(
+        &self,
+        out: &mut BinderNodeInfoForRef,
+        guard: &GuardMut<'_, Mutex<ProcessInner>>,
+    ) {
+        let inner = self.inner.access(guard);
+        out.strong_count = inner.strong.count as _;
+        out.weak_count = inner.weak.count as _;
+    }
+
+    pub(crate) fn populate_debug_info(
+        &self,
+        out: &mut BinderNodeDebugInfo,
+        guard: &GuardMut<'_, Mutex<ProcessInner>>,
+    ) {
+        out.ptr = self.ptr as _;
+        out.cookie = self.cookie as _;
+        let inner = self.inner.access(guard);
+        if inner.strong.has_count {
+            out.has_strong_ref = 1;
+        }
+        if inner.weak.has_count {
+            out.has_weak_ref = 1;
+        }
+    }
+
+    pub(crate) fn force_has_count(&self, guard: &mut GuardMut<'_, Mutex<ProcessInner>>) {
+        let inner = self.inner.access_mut(guard);
+        inner.strong.has_count = true;
+        inner.weak.has_count = true;
+    }
+
+    fn write(&self, writer: &mut UserSlicePtrWriter, code: u32) -> Result {
+        writer.write(&code)?;
+        writer.write(&self.ptr)?;
+        writer.write(&self.cookie)?;
+        Ok(())
+    }
+}
+
+impl DeliverToRead for Node {
+    fn do_work(self: Ref<Self>, _thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        let mut owner_inner = self.owner.inner.lock();
+        let inner = self.inner.access_mut(&mut owner_inner);
+        let strong = inner.strong.count > 0;
+        let has_strong = inner.strong.has_count;
+        let weak = strong || inner.weak.count > 0;
+        let has_weak = inner.weak.has_count;
+        inner.weak.has_count = weak;
+        inner.strong.has_count = strong;
+
+        if !weak {
+            // Remove the node if there are no references to it.
+            owner_inner.remove_node(self.ptr);
+        } else {
+            if !has_weak {
+                inner.weak.add_bias();
+            }
+
+            if !has_strong && strong {
+                inner.strong.add_bias();
+            }
+        }
+
+        drop(owner_inner);
+
+        // This could be done more compactly but we write out all the posibilities for
+        // compatibility with the original implementation wrt the order of events.
+        if weak && !has_weak {
+            self.write(writer, BR_INCREFS)?;
+        }
+
+        if strong && !has_strong {
+            self.write(writer, BR_ACQUIRE)?;
+        }
+
+        if !strong && has_strong {
+            self.write(writer, BR_RELEASE)?;
+        }
+
+        if !weak && has_weak {
+            self.write(writer, BR_DECREFS)?;
+        }
+
+        Ok(true)
+    }
+
+    fn get_links(&self) -> &Links<dyn DeliverToRead> {
+        &self.links
+    }
+}
+
+pub(crate) struct NodeRef {
+    pub(crate) node: Ref<Node>,
+    strong_count: usize,
+    weak_count: usize,
+}
+
+impl NodeRef {
+    pub(crate) fn new(node: Ref<Node>, strong_count: usize, weak_count: usize) -> Self {
+        Self {
+            node,
+            strong_count,
+            weak_count,
+        }
+    }
+
+    pub(crate) fn absorb(&mut self, mut other: Self) {
+        self.strong_count += other.strong_count;
+        self.weak_count += other.weak_count;
+        other.strong_count = 0;
+        other.weak_count = 0;
+    }
+
+    pub(crate) fn clone(&self, strong: bool) -> BinderResult<NodeRef> {
+        if strong && self.strong_count == 0 {
+            return Err(BinderError::new_failed());
+        }
+
+        Ok(self
+            .node
+            .owner
+            .inner
+            .lock()
+            .new_node_ref(self.node.clone(), strong, None))
+    }
+
+    /// Updates (increments or decrements) the number of references held against the node. If the
+    /// count being updated transitions from 0 to 1 or from 1 to 0, the node is notified by having
+    /// its `update_refcount` function called.
+    ///
+    /// Returns whether `self` should be removed (when both counts are zero).
+    pub(crate) fn update(&mut self, inc: bool, strong: bool) -> bool {
+        if strong && self.strong_count == 0 {
+            return false;
+        }
+
+        let (count, other_count) = if strong {
+            (&mut self.strong_count, self.weak_count)
+        } else {
+            (&mut self.weak_count, self.strong_count)
+        };
+
+        if inc {
+            if *count == 0 {
+                self.node.update_refcount(true, strong);
+            }
+            *count += 1;
+        } else {
+            *count -= 1;
+            if *count == 0 {
+                self.node.update_refcount(false, strong);
+                return other_count == 0;
+            }
+        }
+
+        false
+    }
+}
+
+impl Drop for NodeRef {
+    fn drop(&mut self) {
+        if self.strong_count > 0 {
+            self.node.update_refcount(false, true);
+        }
+
+        if self.weak_count > 0 {
+            self.node.update_refcount(false, false);
+        }
+    }
+}
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
new file mode 100644
index 000000000000..ce3ab176b8ac
--- /dev/null
+++ b/drivers/android/process.rs
@@ -0,0 +1,964 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::{convert::TryFrom, mem::take, ops::Range};
+use kernel::{
+    bindings, c_types,
+    cred::Credential,
+    file::File,
+    file_operations::{FileOpener, FileOperations, IoctlCommand, IoctlHandler, PollTable},
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    linked_list::List,
+    pages::Pages,
+    prelude::*,
+    rbtree::RBTree,
+    sync::{GuardMut, Mutex, Ref, RefBorrow, UniqueRef},
+    task::Task,
+    user_ptr::{UserSlicePtr, UserSlicePtrReader},
+};
+
+use crate::{
+    allocation::Allocation,
+    context::Context,
+    defs::*,
+    node::{Node, NodeDeath, NodeRef},
+    range_alloc::RangeAllocator,
+    thread::{BinderError, BinderResult, Thread},
+    DeliverToRead, DeliverToReadListAdapter, Either,
+};
+
+// TODO: Review this:
+// Lock order: Process::node_refs -> Process::inner -> Thread::inner
+
+pub(crate) struct AllocationInfo {
+    /// Range within the allocation where we can find the offsets to the object descriptors.
+    pub(crate) offsets: Range<usize>,
+}
+
+struct Mapping {
+    address: usize,
+    alloc: RangeAllocator<AllocationInfo>,
+    pages: Ref<[Pages<0>]>,
+}
+
+impl Mapping {
+    fn new(address: usize, size: usize, pages: Ref<[Pages<0>]>) -> Result<Self> {
+        let alloc = RangeAllocator::new(size)?;
+        Ok(Self {
+            address,
+            alloc,
+            pages,
+        })
+    }
+}
+
+// TODO: Make this private.
+pub(crate) struct ProcessInner {
+    is_manager: bool,
+    is_dead: bool,
+    threads: RBTree<i32, Ref<Thread>>,
+    ready_threads: List<Ref<Thread>>,
+    work: List<DeliverToReadListAdapter>,
+    mapping: Option<Mapping>,
+    nodes: RBTree<usize, Ref<Node>>,
+
+    delivered_deaths: List<Ref<NodeDeath>>,
+
+    /// The number of requested threads that haven't registered yet.
+    requested_thread_count: u32,
+
+    /// The maximum number of threads used by the process thread pool.
+    max_threads: u32,
+
+    /// The number of threads the started and registered with the thread pool.
+    started_thread_count: u32,
+}
+
+impl ProcessInner {
+    fn new() -> Self {
+        Self {
+            is_manager: false,
+            is_dead: false,
+            threads: RBTree::new(),
+            ready_threads: List::new(),
+            work: List::new(),
+            mapping: None,
+            nodes: RBTree::new(),
+            requested_thread_count: 0,
+            max_threads: 0,
+            started_thread_count: 0,
+            delivered_deaths: List::new(),
+        }
+    }
+
+    fn push_work(&mut self, work: Ref<dyn DeliverToRead>) -> BinderResult {
+        // Try to find a ready thread to which to push the work.
+        if let Some(thread) = self.ready_threads.pop_front() {
+            // Push to thread while holding state lock. This prevents the thread from giving up
+            // (for example, because of a signal) when we're about to deliver work.
+            thread.push_work(work)
+        } else if self.is_dead {
+            Err(BinderError::new_dead())
+        } else {
+            // There are no ready threads. Push work to process queue.
+            self.work.push_back(work);
+
+            // Wake up polling threads, if any.
+            for thread in self.threads.values() {
+                thread.notify_if_poll_ready();
+            }
+            Ok(())
+        }
+    }
+
+    // TODO: Should this be private?
+    pub(crate) fn remove_node(&mut self, ptr: usize) {
+        self.nodes.remove(&ptr);
+    }
+
+    /// Updates the reference count on the given node.
+    // TODO: Decide if this should be private.
+    pub(crate) fn update_node_refcount(
+        &mut self,
+        node: &Ref<Node>,
+        inc: bool,
+        strong: bool,
+        biased: bool,
+        othread: Option<&Thread>,
+    ) {
+        let push = node.update_refcount_locked(inc, strong, biased, self);
+
+        // If we decided that we need to push work, push either to the process or to a thread if
+        // one is specified.
+        if push {
+            if let Some(thread) = othread {
+                thread.push_work_deferred(node.clone());
+            } else {
+                let _ = self.push_work(node.clone());
+                // Nothing to do: `push_work` may fail if the process is dead, but that's ok as in
+                // that case, it doesn't care about the notification.
+            }
+        }
+    }
+
+    // TODO: Make this private.
+    pub(crate) fn new_node_ref(
+        &mut self,
+        node: Ref<Node>,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> NodeRef {
+        self.update_node_refcount(&node, true, strong, false, thread);
+        let strong_count = if strong { 1 } else { 0 };
+        NodeRef::new(node, strong_count, 1 - strong_count)
+    }
+
+    /// Returns an existing node with the given pointer and cookie, if one exists.
+    ///
+    /// Returns an error if a node with the given pointer but a different cookie exists.
+    fn get_existing_node(&self, ptr: usize, cookie: usize) -> Result<Option<Ref<Node>>> {
+        match self.nodes.get(&ptr) {
+            None => Ok(None),
+            Some(node) => {
+                let (_, node_cookie) = node.get_id();
+                if node_cookie == cookie {
+                    Ok(Some(node.clone()))
+                } else {
+                    Err(Error::EINVAL)
+                }
+            }
+        }
+    }
+
+    /// Returns a reference to an existing node with the given pointer and cookie. It requires a
+    /// mutable reference because it needs to increment the ref count on the node, which may
+    /// require pushing work to the work queue (to notify userspace of 0 to 1 transitions).
+    fn get_existing_node_ref(
+        &mut self,
+        ptr: usize,
+        cookie: usize,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> Result<Option<NodeRef>> {
+        Ok(self
+            .get_existing_node(ptr, cookie)?
+            .map(|node| self.new_node_ref(node, strong, thread)))
+    }
+
+    fn register_thread(&mut self) -> bool {
+        if self.requested_thread_count == 0 {
+            return false;
+        }
+
+        self.requested_thread_count -= 1;
+        self.started_thread_count += 1;
+        true
+    }
+
+    /// Finds a delivered death notification with the given cookie, removes it from the thread's
+    /// delivered list, and returns it.
+    fn pull_delivered_death(&mut self, cookie: usize) -> Option<Ref<NodeDeath>> {
+        let mut cursor = self.delivered_deaths.cursor_front_mut();
+        while let Some(death) = cursor.current() {
+            if death.cookie == cookie {
+                return cursor.remove_current();
+            }
+            cursor.move_next();
+        }
+        None
+    }
+
+    pub(crate) fn death_delivered(&mut self, death: Ref<NodeDeath>) {
+        self.delivered_deaths.push_back(death);
+    }
+}
+
+struct NodeRefInfo {
+    node_ref: NodeRef,
+    death: Option<Ref<NodeDeath>>,
+}
+
+impl NodeRefInfo {
+    fn new(node_ref: NodeRef) -> Self {
+        Self {
+            node_ref,
+            death: None,
+        }
+    }
+}
+
+struct ProcessNodeRefs {
+    by_handle: RBTree<u32, NodeRefInfo>,
+    by_global_id: RBTree<u64, u32>,
+}
+
+impl ProcessNodeRefs {
+    fn new() -> Self {
+        Self {
+            by_handle: RBTree::new(),
+            by_global_id: RBTree::new(),
+        }
+    }
+}
+
+pub(crate) struct Process {
+    ctx: Ref<Context>,
+
+    // The task leader (process).
+    pub(crate) task: Task,
+
+    // Credential associated with file when `Process` is created.
+    pub(crate) cred: Credential,
+
+    // TODO: For now this a mutex because we have allocations in RangeAllocator while holding the
+    // lock. We may want to split up the process state at some point to use a spin lock for the
+    // other fields.
+    // TODO: Make this private again.
+    pub(crate) inner: Mutex<ProcessInner>,
+
+    // References are in a different mutex to avoid recursive acquisition when
+    // incrementing/decrementing a node in another process.
+    node_refs: Mutex<ProcessNodeRefs>,
+}
+
+unsafe impl Send for Process {}
+unsafe impl Sync for Process {}
+
+impl Process {
+    fn new(ctx: Ref<Context>, cred: Credential) -> Result<Ref<Self>> {
+        let mut process = Pin::from(UniqueRef::try_new(Self {
+            ctx,
+            cred,
+            task: Task::current().group_leader().clone(),
+            // SAFETY: `inner` is initialised in the call to `mutex_init` below.
+            inner: unsafe { Mutex::new(ProcessInner::new()) },
+            // SAFETY: `node_refs` is initialised in the call to `mutex_init` below.
+            node_refs: unsafe { Mutex::new(ProcessNodeRefs::new()) },
+        })?);
+
+        // SAFETY: `inner` is pinned when `Process` is.
+        let pinned = unsafe { process.as_mut().map_unchecked_mut(|p| &mut p.inner) };
+        kernel::mutex_init!(pinned, "Process::inner");
+
+        // SAFETY: `node_refs` is pinned when `Process` is.
+        let pinned = unsafe { process.as_mut().map_unchecked_mut(|p| &mut p.node_refs) };
+        kernel::mutex_init!(pinned, "Process::node_refs");
+
+        Ok(process.into())
+    }
+
+    /// Attemps to fetch a work item from the process queue.
+    pub(crate) fn get_work(&self) -> Option<Ref<dyn DeliverToRead>> {
+        self.inner.lock().work.pop_front()
+    }
+
+    /// Attemps to fetch a work item from the process queue. If none is available, it registers the
+    /// given thread as ready to receive work directly.
+    ///
+    /// This must only be called when the thread is not participating in a transaction chain; when
+    /// it is, work will always be delivered directly to the thread (and not through the process
+    /// queue).
+    pub(crate) fn get_work_or_register<'a>(
+        &'a self,
+        thread: &'a Ref<Thread>,
+    ) -> Either<Ref<dyn DeliverToRead>, Registration<'a>> {
+        let mut inner = self.inner.lock();
+
+        // Try to get work from the process queue.
+        if let Some(work) = inner.work.pop_front() {
+            return Either::Left(work);
+        }
+
+        // Register the thread as ready.
+        Either::Right(Registration::new(self, thread, &mut inner))
+    }
+
+    fn get_thread(self: RefBorrow<'_, Self>, id: i32) -> Result<Ref<Thread>> {
+        // TODO: Consider using read/write locks here instead.
+        {
+            let inner = self.inner.lock();
+            if let Some(thread) = inner.threads.get(&id) {
+                return Ok(thread.clone());
+            }
+        }
+
+        // Allocate a new `Thread` without holding any locks.
+        let ta = Thread::new(id, self.into())?;
+        let node = RBTree::try_allocate_node(id, ta.clone())?;
+
+        let mut inner = self.inner.lock();
+
+        // Recheck. It's possible the thread was create while we were not holding the lock.
+        if let Some(thread) = inner.threads.get(&id) {
+            return Ok(thread.clone());
+        }
+
+        inner.threads.insert(node);
+        Ok(ta)
+    }
+
+    pub(crate) fn push_work(&self, work: Ref<dyn DeliverToRead>) -> BinderResult {
+        self.inner.lock().push_work(work)
+    }
+
+    fn set_as_manager(
+        self: RefBorrow<'_, Self>,
+        info: Option<FlatBinderObject>,
+        thread: &Thread,
+    ) -> Result {
+        let (ptr, cookie, flags) = if let Some(obj) = info {
+            (
+                // SAFETY: The object type for this ioctl is implicitly `BINDER_TYPE_BINDER`, so it
+                // is safe to access the `binder` field.
+                unsafe { obj.__bindgen_anon_1.binder },
+                obj.cookie,
+                obj.flags,
+            )
+        } else {
+            (0, 0, 0)
+        };
+        let node_ref = self.get_node(ptr as _, cookie as _, flags as _, true, Some(thread))?;
+        let node = node_ref.node.clone();
+        self.ctx.set_manager_node(node_ref)?;
+        self.inner.lock().is_manager = true;
+
+        // Force the state of the node to prevent the delivery of acquire/increfs.
+        let mut owner_inner = node.owner.inner.lock();
+        node.force_has_count(&mut owner_inner);
+        Ok(())
+    }
+
+    pub(crate) fn get_node(
+        self: RefBorrow<'_, Self>,
+        ptr: usize,
+        cookie: usize,
+        flags: u32,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> Result<NodeRef> {
+        // Try to find an existing node.
+        {
+            let mut inner = self.inner.lock();
+            if let Some(node) = inner.get_existing_node_ref(ptr, cookie, strong, thread)? {
+                return Ok(node);
+            }
+        }
+
+        // Allocate the node before reacquiring the lock.
+        let node = Ref::try_new(Node::new(ptr, cookie, flags, self.into()))?;
+        let rbnode = RBTree::try_allocate_node(ptr, node.clone())?;
+
+        let mut inner = self.inner.lock();
+        if let Some(node) = inner.get_existing_node_ref(ptr, cookie, strong, thread)? {
+            return Ok(node);
+        }
+
+        inner.nodes.insert(rbnode);
+        Ok(inner.new_node_ref(node, strong, thread))
+    }
+
+    pub(crate) fn insert_or_update_handle(
+        &self,
+        node_ref: NodeRef,
+        is_mananger: bool,
+    ) -> Result<u32> {
+        {
+            let mut refs = self.node_refs.lock();
+
+            // Do a lookup before inserting.
+            if let Some(handle_ref) = refs.by_global_id.get(&node_ref.node.global_id) {
+                let handle = *handle_ref;
+                let info = refs.by_handle.get_mut(&handle).unwrap();
+                info.node_ref.absorb(node_ref);
+                return Ok(handle);
+            }
+        }
+
+        // Reserve memory for tree nodes.
+        let reserve1 = RBTree::try_reserve_node()?;
+        let reserve2 = RBTree::try_reserve_node()?;
+
+        let mut refs = self.node_refs.lock();
+
+        // Do a lookup again as node may have been inserted before the lock was reacquired.
+        if let Some(handle_ref) = refs.by_global_id.get(&node_ref.node.global_id) {
+            let handle = *handle_ref;
+            let info = refs.by_handle.get_mut(&handle).unwrap();
+            info.node_ref.absorb(node_ref);
+            return Ok(handle);
+        }
+
+        // Find id.
+        let mut target = if is_mananger { 0 } else { 1 };
+        for handle in refs.by_handle.keys() {
+            if *handle > target {
+                break;
+            }
+            if *handle == target {
+                target = target.checked_add(1).ok_or(Error::ENOMEM)?;
+            }
+        }
+
+        // Ensure the process is still alive while we insert a new reference.
+        let inner = self.inner.lock();
+        if inner.is_dead {
+            return Err(Error::ESRCH);
+        }
+        refs.by_global_id
+            .insert(reserve1.into_node(node_ref.node.global_id, target));
+        refs.by_handle
+            .insert(reserve2.into_node(target, NodeRefInfo::new(node_ref)));
+        Ok(target)
+    }
+
+    pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
+        // When handle is zero, try to get the context manager.
+        if handle == 0 {
+            self.ctx.get_manager_node(true)
+        } else {
+            self.get_node_from_handle(handle, true)
+        }
+    }
+
+    pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> BinderResult<NodeRef> {
+        self.node_refs
+            .lock()
+            .by_handle
+            .get(&handle)
+            .ok_or(Error::ENOENT)?
+            .node_ref
+            .clone(strong)
+    }
+
+    pub(crate) fn remove_from_delivered_deaths(&self, death: &Ref<NodeDeath>) {
+        let mut inner = self.inner.lock();
+        let removed = unsafe { inner.delivered_deaths.remove(death) };
+        drop(inner);
+        drop(removed);
+    }
+
+    pub(crate) fn update_ref(&self, handle: u32, inc: bool, strong: bool) -> Result {
+        if inc && handle == 0 {
+            if let Ok(node_ref) = self.ctx.get_manager_node(strong) {
+                if core::ptr::eq(self, &*node_ref.node.owner) {
+                    return Err(Error::EINVAL);
+                }
+                let _ = self.insert_or_update_handle(node_ref, true);
+                return Ok(());
+            }
+        }
+
+        // To preserve original binder behaviour, we only fail requests where the manager tries to
+        // increment references on itself.
+        let mut refs = self.node_refs.lock();
+        if let Some(info) = refs.by_handle.get_mut(&handle) {
+            if info.node_ref.update(inc, strong) {
+                // Clean up death if there is one attached to this node reference.
+                if let Some(death) = info.death.take() {
+                    death.set_cleared(true);
+                    self.remove_from_delivered_deaths(&death);
+                }
+
+                // Remove reference from process tables.
+                let id = info.node_ref.node.global_id;
+                refs.by_handle.remove(&handle);
+                refs.by_global_id.remove(&id);
+            }
+        }
+        Ok(())
+    }
+
+    /// Decrements the refcount of the given node, if one exists.
+    pub(crate) fn update_node(&self, ptr: usize, cookie: usize, strong: bool, biased: bool) {
+        let mut inner = self.inner.lock();
+        if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
+            inner.update_node_refcount(&node, false, strong, biased, None);
+        }
+    }
+
+    pub(crate) fn inc_ref_done(&self, reader: &mut UserSlicePtrReader, strong: bool) -> Result {
+        let ptr = reader.read::<usize>()?;
+        let cookie = reader.read::<usize>()?;
+        self.update_node(ptr, cookie, strong, true);
+        Ok(())
+    }
+
+    pub(crate) fn buffer_alloc(&self, size: usize) -> BinderResult<Allocation<'_>> {
+        let mut inner = self.inner.lock();
+        let mapping = inner.mapping.as_mut().ok_or_else(BinderError::new_dead)?;
+
+        let offset = mapping.alloc.reserve_new(size)?;
+        Ok(Allocation::new(
+            self,
+            offset,
+            size,
+            mapping.address + offset,
+            mapping.pages.clone(),
+        ))
+    }
+
+    // TODO: Review if we want an Option or a Result.
+    pub(crate) fn buffer_get(&self, ptr: usize) -> Option<Allocation<'_>> {
+        let mut inner = self.inner.lock();
+        let mapping = inner.mapping.as_mut()?;
+        let offset = ptr.checked_sub(mapping.address)?;
+        let (size, odata) = mapping.alloc.reserve_existing(offset).ok()?;
+        let mut alloc = Allocation::new(self, offset, size, ptr, mapping.pages.clone());
+        if let Some(data) = odata {
+            alloc.set_info(data);
+        }
+        Some(alloc)
+    }
+
+    pub(crate) fn buffer_raw_free(&self, ptr: usize) {
+        let mut inner = self.inner.lock();
+        if let Some(ref mut mapping) = &mut inner.mapping {
+            if ptr < mapping.address
+                || mapping
+                    .alloc
+                    .reservation_abort(ptr - mapping.address)
+                    .is_err()
+            {
+                pr_warn!(
+                    "Pointer {:x} failed to free, base = {:x}\n",
+                    ptr,
+                    mapping.address
+                );
+            }
+        }
+    }
+
+    pub(crate) fn buffer_make_freeable(&self, offset: usize, data: Option<AllocationInfo>) {
+        let mut inner = self.inner.lock();
+        if let Some(ref mut mapping) = &mut inner.mapping {
+            if mapping.alloc.reservation_commit(offset, data).is_err() {
+                pr_warn!("Offset {} failed to be marked freeable\n", offset);
+            }
+        }
+    }
+
+    fn create_mapping(&self, vma: &mut bindings::vm_area_struct) -> Result {
+        let size = core::cmp::min(
+            (vma.vm_end - vma.vm_start) as usize,
+            bindings::SZ_4M as usize,
+        );
+        let page_count = size >> bindings::PAGE_SHIFT;
+
+        // Allocate and map all pages.
+        //
+        // N.B. If we fail halfway through mapping these pages, the kernel will unmap them.
+        let mut pages = Vec::new();
+        pages.try_reserve_exact(page_count)?;
+        let mut address = vma.vm_start as usize;
+        for _ in 0..page_count {
+            let page = Pages::<0>::new()?;
+            page.insert_page(vma, address)?;
+            pages.try_push(page)?;
+            address += 1 << bindings::PAGE_SHIFT;
+        }
+
+        let ref_pages = Ref::try_from(pages)?;
+
+        // Save pages for later.
+        let mut inner = self.inner.lock();
+        match &inner.mapping {
+            None => inner.mapping = Some(Mapping::new(vma.vm_start as _, size, ref_pages)?),
+            Some(_) => return Err(Error::EBUSY),
+        }
+        Ok(())
+    }
+
+    fn version(&self, data: UserSlicePtr) -> Result {
+        data.writer().write(&BinderVersion::current())
+    }
+
+    pub(crate) fn register_thread(&self) -> bool {
+        self.inner.lock().register_thread()
+    }
+
+    fn remove_thread(&self, thread: Ref<Thread>) {
+        self.inner.lock().threads.remove(&thread.id);
+        thread.release();
+    }
+
+    fn set_max_threads(&self, max: u32) {
+        self.inner.lock().max_threads = max;
+    }
+
+    fn get_node_debug_info(&self, data: UserSlicePtr) -> Result {
+        let (mut reader, mut writer) = data.reader_writer();
+
+        // Read the starting point.
+        let ptr = reader.read::<BinderNodeDebugInfo>()?.ptr as usize;
+        let mut out = BinderNodeDebugInfo::default();
+
+        {
+            let inner = self.inner.lock();
+            for (node_ptr, node) in &inner.nodes {
+                if *node_ptr > ptr {
+                    node.populate_debug_info(&mut out, &inner);
+                    break;
+                }
+            }
+        }
+
+        writer.write(&out)
+    }
+
+    fn get_node_info_from_ref(&self, data: UserSlicePtr) -> Result {
+        let (mut reader, mut writer) = data.reader_writer();
+        let mut out = reader.read::<BinderNodeInfoForRef>()?;
+
+        if out.strong_count != 0
+            || out.weak_count != 0
+            || out.reserved1 != 0
+            || out.reserved2 != 0
+            || out.reserved3 != 0
+        {
+            return Err(Error::EINVAL);
+        }
+
+        // Only the context manager is allowed to use this ioctl.
+        if !self.inner.lock().is_manager {
+            return Err(Error::EPERM);
+        }
+
+        let node_ref = self
+            .get_node_from_handle(out.handle, true)
+            .or(Err(Error::EINVAL))?;
+
+        // Get the counts from the node.
+        {
+            let owner_inner = node_ref.node.owner.inner.lock();
+            node_ref.node.populate_counts(&mut out, &owner_inner);
+        }
+
+        // Write the result back.
+        writer.write(&out)
+    }
+
+    pub(crate) fn needs_thread(&self) -> bool {
+        let mut inner = self.inner.lock();
+        let ret = inner.requested_thread_count == 0
+            && inner.ready_threads.is_empty()
+            && inner.started_thread_count < inner.max_threads;
+        if ret {
+            inner.requested_thread_count += 1
+        };
+        ret
+    }
+
+    pub(crate) fn request_death(
+        self: &Ref<Self>,
+        reader: &mut UserSlicePtrReader,
+        thread: &Thread,
+    ) -> Result {
+        let handle: u32 = reader.read()?;
+        let cookie: usize = reader.read()?;
+
+        // TODO: First two should result in error, but not the others.
+
+        // TODO: Do we care about the context manager dying?
+
+        // Queue BR_ERROR if we can't allocate memory for the death notification.
+        let death = UniqueRef::try_new_uninit().map_err(|err| {
+            thread.push_return_work(BR_ERROR);
+            err
+        })?;
+
+        let mut refs = self.node_refs.lock();
+        let info = refs.by_handle.get_mut(&handle).ok_or(Error::EINVAL)?;
+
+        // Nothing to do if there is already a death notification request for this handle.
+        if info.death.is_some() {
+            return Ok(());
+        }
+
+        let death = {
+            let mut pinned = Pin::from(death.write(
+                // SAFETY: `init` is called below.
+                unsafe { NodeDeath::new(info.node_ref.node.clone(), self.clone(), cookie) },
+            ));
+            pinned.as_mut().init();
+            Ref::<NodeDeath>::from(pinned)
+        };
+
+        info.death = Some(death.clone());
+
+        // Register the death notification.
+        {
+            let mut owner_inner = info.node_ref.node.owner.inner.lock();
+            if owner_inner.is_dead {
+                drop(owner_inner);
+                let _ = self.push_work(death);
+            } else {
+                info.node_ref.node.add_death(death, &mut owner_inner);
+            }
+        }
+        Ok(())
+    }
+
+    pub(crate) fn clear_death(&self, reader: &mut UserSlicePtrReader, thread: &Thread) -> Result {
+        let handle: u32 = reader.read()?;
+        let cookie: usize = reader.read()?;
+
+        let mut refs = self.node_refs.lock();
+        let info = refs.by_handle.get_mut(&handle).ok_or(Error::EINVAL)?;
+
+        let death = info.death.take().ok_or(Error::EINVAL)?;
+        if death.cookie != cookie {
+            info.death = Some(death);
+            return Err(Error::EINVAL);
+        }
+
+        // Update state and determine if we need to queue a work item. We only need to do it when
+        // the node is not dead or if the user already completed the death notification.
+        if death.set_cleared(false) {
+            let _ = thread.push_work_if_looper(death);
+        }
+
+        Ok(())
+    }
+
+    pub(crate) fn dead_binder_done(&self, cookie: usize, thread: &Thread) {
+        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
+            death.set_notification_done(thread);
+        }
+    }
+}
+
+impl IoctlHandler for Process {
+    type Target<'a> = RefBorrow<'a, Process>;
+
+    fn write(
+        this: RefBorrow<'_, Process>,
+        _file: &File,
+        cmd: u32,
+        reader: &mut UserSlicePtrReader,
+    ) -> Result<i32> {
+        let thread = this.get_thread(Task::current().pid())?;
+        match cmd {
+            bindings::BINDER_SET_MAX_THREADS => this.set_max_threads(reader.read()?),
+            bindings::BINDER_SET_CONTEXT_MGR => this.set_as_manager(None, &thread)?,
+            bindings::BINDER_THREAD_EXIT => this.remove_thread(thread),
+            bindings::BINDER_SET_CONTEXT_MGR_EXT => {
+                this.set_as_manager(Some(reader.read()?), &thread)?
+            }
+            _ => return Err(Error::EINVAL),
+        }
+        Ok(0)
+    }
+
+    fn read_write(
+        this: RefBorrow<'_, Process>,
+        file: &File,
+        cmd: u32,
+        data: UserSlicePtr,
+    ) -> Result<i32> {
+        let thread = this.get_thread(Task::current().pid())?;
+        match cmd {
+            bindings::BINDER_WRITE_READ => thread.write_read(data, file.is_blocking())?,
+            bindings::BINDER_GET_NODE_DEBUG_INFO => this.get_node_debug_info(data)?,
+            bindings::BINDER_GET_NODE_INFO_FOR_REF => this.get_node_info_from_ref(data)?,
+            bindings::BINDER_VERSION => this.version(data)?,
+            _ => return Err(Error::EINVAL),
+        }
+        Ok(0)
+    }
+}
+
+impl FileOpener<Ref<Context>> for Process {
+    fn open(ctx: &Ref<Context>, file: &File) -> Result<Self::Wrapper> {
+        Self::new(ctx.clone(), file.cred().clone())
+    }
+}
+
+impl FileOperations for Process {
+    type Wrapper = Ref<Self>;
+
+    kernel::declare_file_operations!(ioctl, compat_ioctl, mmap, poll);
+
+    fn release(obj: Self::Wrapper, _file: &File) {
+        // Mark this process as dead. We'll do the same for the threads later.
+        obj.inner.lock().is_dead = true;
+
+        // If this process is the manager, unset it.
+        if obj.inner.lock().is_manager {
+            obj.ctx.unset_manager_node();
+        }
+
+        // TODO: Do this in a worker?
+
+        // Cancel all pending work items.
+        while let Some(work) = obj.get_work() {
+            work.cancel();
+        }
+
+        // Free any resources kept alive by allocated buffers.
+        let omapping = obj.inner.lock().mapping.take();
+        if let Some(mut mapping) = omapping {
+            let address = mapping.address;
+            let pages = mapping.pages.clone();
+            mapping.alloc.for_each(|offset, size, odata| {
+                let ptr = offset + address;
+                let mut alloc = Allocation::new(&obj, offset, size, ptr, pages.clone());
+                if let Some(data) = odata {
+                    alloc.set_info(data);
+                }
+                drop(alloc)
+            });
+        }
+
+        // Drop all references. We do this dance with `swap` to avoid destroying the references
+        // while holding the lock.
+        let mut refs = obj.node_refs.lock();
+        let mut node_refs = take(&mut refs.by_handle);
+        drop(refs);
+
+        // Remove all death notifications from the nodes (that belong to a different process).
+        for info in node_refs.values_mut() {
+            let death = if let Some(existing) = info.death.take() {
+                existing
+            } else {
+                continue;
+            };
+
+            death.set_cleared(false);
+        }
+
+        // Do similar dance for the state lock.
+        let mut inner = obj.inner.lock();
+        let threads = take(&mut inner.threads);
+        let nodes = take(&mut inner.nodes);
+        drop(inner);
+
+        // Release all threads.
+        for thread in threads.values() {
+            thread.release();
+        }
+
+        // Deliver death notifications.
+        for node in nodes.values() {
+            loop {
+                let death = {
+                    let mut inner = obj.inner.lock();
+                    if let Some(death) = node.next_death(&mut inner) {
+                        death
+                    } else {
+                        break;
+                    }
+                };
+
+                death.set_dead();
+            }
+        }
+    }
+
+    fn ioctl(this: RefBorrow<'_, Process>, file: &File, cmd: &mut IoctlCommand) -> Result<i32> {
+        cmd.dispatch::<Self>(this, file)
+    }
+
+    fn compat_ioctl(
+        this: RefBorrow<'_, Process>,
+        file: &File,
+        cmd: &mut IoctlCommand,
+    ) -> Result<i32> {
+        cmd.dispatch::<Self>(this, file)
+    }
+
+    fn mmap(
+        this: RefBorrow<'_, Process>,
+        _file: &File,
+        vma: &mut bindings::vm_area_struct,
+    ) -> Result {
+        // We don't allow mmap to be used in a different process.
+        if !Task::current().group_leader().eq(&this.task) {
+            return Err(Error::EINVAL);
+        }
+
+        if vma.vm_start == 0 {
+            return Err(Error::EINVAL);
+        }
+
+        if (vma.vm_flags & (bindings::VM_WRITE as c_types::c_ulong)) != 0 {
+            return Err(Error::EPERM);
+        }
+
+        vma.vm_flags |= (bindings::VM_DONTCOPY | bindings::VM_MIXEDMAP) as c_types::c_ulong;
+        vma.vm_flags &= !(bindings::VM_MAYWRITE as c_types::c_ulong);
+
+        // TODO: Set ops. We need to learn when the user unmaps so that we can stop using it.
+        this.create_mapping(vma)
+    }
+
+    fn poll(this: RefBorrow<'_, Process>, file: &File, table: &PollTable) -> Result<u32> {
+        let thread = this.get_thread(Task::current().pid())?;
+        let (from_proc, mut mask) = thread.poll(file, table);
+        if mask == 0 && from_proc && !this.inner.lock().work.is_empty() {
+            mask |= bindings::POLLIN;
+        }
+        Ok(mask)
+    }
+}
+
+pub(crate) struct Registration<'a> {
+    process: &'a Process,
+    thread: &'a Ref<Thread>,
+}
+
+impl<'a> Registration<'a> {
+    fn new(
+        process: &'a Process,
+        thread: &'a Ref<Thread>,
+        guard: &mut GuardMut<'_, Mutex<ProcessInner>>,
+    ) -> Self {
+        guard.ready_threads.push_back(thread.clone());
+        Self { process, thread }
+    }
+}
+
+impl Drop for Registration<'_> {
+    fn drop(&mut self) {
+        let mut inner = self.process.inner.lock();
+        unsafe { inner.ready_threads.remove(self.thread) };
+    }
+}
diff --git a/drivers/android/range_alloc.rs b/drivers/android/range_alloc.rs
new file mode 100644
index 000000000000..9ece39c5e1df
--- /dev/null
+++ b/drivers/android/range_alloc.rs
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::ptr::NonNull;
+use kernel::{
+    linked_list::{CursorMut, GetLinks, Links, List},
+    prelude::*,
+};
+
+pub(crate) struct RangeAllocator<T> {
+    list: List<Box<Descriptor<T>>>,
+}
+
+#[derive(Debug, PartialEq, Eq)]
+enum DescriptorState {
+    Free,
+    Reserved,
+    Allocated,
+}
+
+impl<T> RangeAllocator<T> {
+    pub(crate) fn new(size: usize) -> Result<Self> {
+        let desc = Box::try_new(Descriptor::new(0, size))?;
+        let mut list = List::new();
+        list.push_back(desc);
+        Ok(Self { list })
+    }
+
+    fn find_best_match(&self, size: usize) -> Option<NonNull<Descriptor<T>>> {
+        // TODO: Use a binary tree instead of list for this lookup.
+        let mut best = None;
+        let mut best_size = usize::MAX;
+        let mut cursor = self.list.cursor_front();
+        while let Some(desc) = cursor.current() {
+            if desc.state == DescriptorState::Free {
+                if size == desc.size {
+                    return Some(NonNull::from(desc));
+                }
+
+                if size < desc.size && desc.size < best_size {
+                    best = Some(NonNull::from(desc));
+                    best_size = desc.size;
+                }
+            }
+
+            cursor.move_next();
+        }
+        best
+    }
+
+    pub(crate) fn reserve_new(&mut self, size: usize) -> Result<usize> {
+        let desc_ptr = match self.find_best_match(size) {
+            None => return Err(Error::ENOMEM),
+            Some(found) => found,
+        };
+
+        // SAFETY: We hold the only mutable reference to list, so it cannot have changed.
+        let desc = unsafe { &mut *desc_ptr.as_ptr() };
+        if desc.size == size {
+            desc.state = DescriptorState::Reserved;
+            return Ok(desc.offset);
+        }
+
+        // We need to break up the descriptor.
+        let new = Box::try_new(Descriptor::new(desc.offset + size, desc.size - size))?;
+        unsafe { self.list.insert_after(desc_ptr, new) };
+        desc.state = DescriptorState::Reserved;
+        desc.size = size;
+        Ok(desc.offset)
+    }
+
+    fn free_with_cursor(cursor: &mut CursorMut<'_, Box<Descriptor<T>>>) -> Result {
+        let mut size = match cursor.current() {
+            None => return Err(Error::EINVAL),
+            Some(ref mut entry) => {
+                match entry.state {
+                    DescriptorState::Free => return Err(Error::EINVAL),
+                    DescriptorState::Allocated => return Err(Error::EPERM),
+                    DescriptorState::Reserved => {}
+                }
+                entry.state = DescriptorState::Free;
+                entry.size
+            }
+        };
+
+        // Try to merge with the next entry.
+        if let Some(next) = cursor.peek_next() {
+            if next.state == DescriptorState::Free {
+                next.offset -= size;
+                next.size += size;
+                size = next.size;
+                cursor.remove_current();
+            }
+        }
+
+        // Try to merge with the previous entry.
+        if let Some(prev) = cursor.peek_prev() {
+            if prev.state == DescriptorState::Free {
+                prev.size += size;
+                cursor.remove_current();
+            }
+        }
+
+        Ok(())
+    }
+
+    fn find_at_offset(&mut self, offset: usize) -> Option<CursorMut<'_, Box<Descriptor<T>>>> {
+        let mut cursor = self.list.cursor_front_mut();
+        while let Some(desc) = cursor.current() {
+            if desc.offset == offset {
+                return Some(cursor);
+            }
+
+            if desc.offset > offset {
+                return None;
+            }
+
+            cursor.move_next();
+        }
+        None
+    }
+
+    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
+        // TODO: The force case is currently O(n), but could be made O(1) with unsafe.
+        let mut cursor = self.find_at_offset(offset).ok_or(Error::EINVAL)?;
+        Self::free_with_cursor(&mut cursor)
+    }
+
+    pub(crate) fn reservation_commit(&mut self, offset: usize, data: Option<T>) -> Result {
+        // TODO: This is currently O(n), make it O(1).
+        let mut cursor = self.find_at_offset(offset).ok_or(Error::ENOENT)?;
+        let desc = cursor.current().unwrap();
+        desc.state = DescriptorState::Allocated;
+        desc.data = data;
+        Ok(())
+    }
+
+    /// Takes an entry at the given offset from [`DescriptorState::Allocated`] to
+    /// [`DescriptorState::Reserved`].
+    ///
+    /// Returns the size of the existing entry and the data associated with it.
+    pub(crate) fn reserve_existing(&mut self, offset: usize) -> Result<(usize, Option<T>)> {
+        // TODO: This is currently O(n), make it O(log n).
+        let mut cursor = self.find_at_offset(offset).ok_or(Error::ENOENT)?;
+        let desc = cursor.current().unwrap();
+        if desc.state != DescriptorState::Allocated {
+            return Err(Error::ENOENT);
+        }
+        desc.state = DescriptorState::Reserved;
+        Ok((desc.size, desc.data.take()))
+    }
+
+    pub(crate) fn for_each<F: Fn(usize, usize, Option<T>)>(&mut self, callback: F) {
+        let mut cursor = self.list.cursor_front_mut();
+        while let Some(desc) = cursor.current() {
+            if desc.state == DescriptorState::Allocated {
+                callback(desc.offset, desc.size, desc.data.take());
+            }
+
+            cursor.move_next();
+        }
+    }
+}
+
+struct Descriptor<T> {
+    state: DescriptorState,
+    size: usize,
+    offset: usize,
+    links: Links<Descriptor<T>>,
+    data: Option<T>,
+}
+
+impl<T> Descriptor<T> {
+    fn new(offset: usize, size: usize) -> Self {
+        Self {
+            size,
+            offset,
+            state: DescriptorState::Free,
+            links: Links::new(),
+            data: None,
+        }
+    }
+}
+
+impl<T> GetLinks for Descriptor<T> {
+    type EntryType = Self;
+    fn get_links(desc: &Self) -> &Links<Self> {
+        &desc.links
+    }
+}
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
new file mode 100644
index 000000000000..2a9636e94d94
--- /dev/null
+++ b/drivers/android/rust_binder.rs
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Binder -- the Android IPC mechanism.
+//!
+//! TODO: This module is a work in progress.
+
+#![no_std]
+#![feature(global_asm, allocator_api, concat_idents, generic_associated_types)]
+
+use kernel::{
+    io_buffer::IoBufferWriter,
+    linked_list::{GetLinks, GetLinksWrapped, Links},
+    miscdev::Registration,
+    prelude::*,
+    str::CStr,
+    sync::Ref,
+    user_ptr::UserSlicePtrWriter,
+};
+
+mod allocation;
+mod context;
+mod defs;
+mod node;
+mod process;
+mod range_alloc;
+mod thread;
+mod transaction;
+
+use {context::Context, thread::Thread};
+
+module! {
+    type: BinderModule,
+    name: b"rust_binder",
+    author: b"Wedson Almeida Filho",
+    description: b"Android Binder",
+    license: b"GPL v2",
+}
+
+enum Either<L, R> {
+    Left(L),
+    Right(R),
+}
+
+trait DeliverToRead {
+    /// Performs work. Returns true if remaining work items in the queue should be processed
+    /// immediately, or false if it should return to caller before processing additional work
+    /// items.
+    fn do_work(self: Ref<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool>;
+
+    /// Cancels the given work item. This is called instead of [`DeliverToRead::do_work`] when work
+    /// won't be delivered.
+    fn cancel(self: Ref<Self>) {}
+
+    /// Returns the linked list links for the work item.
+    fn get_links(&self) -> &Links<dyn DeliverToRead>;
+}
+
+struct DeliverToReadListAdapter {}
+
+impl GetLinks for DeliverToReadListAdapter {
+    type EntryType = dyn DeliverToRead;
+
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        data.get_links()
+    }
+}
+
+impl GetLinksWrapped for DeliverToReadListAdapter {
+    type Wrapped = Ref<dyn DeliverToRead>;
+}
+
+struct DeliverCode {
+    code: u32,
+    links: Links<dyn DeliverToRead>,
+}
+
+impl DeliverCode {
+    fn new(code: u32) -> Self {
+        Self {
+            code,
+            links: Links::new(),
+        }
+    }
+}
+
+impl DeliverToRead for DeliverCode {
+    fn do_work(self: Ref<Self>, _thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        writer.write(&self.code)?;
+        Ok(true)
+    }
+
+    fn get_links(&self) -> &Links<dyn DeliverToRead> {
+        &self.links
+    }
+}
+
+const fn ptr_align(value: usize) -> usize {
+    let size = core::mem::size_of::<usize>() - 1;
+    (value + size) & !size
+}
+
+unsafe impl Sync for BinderModule {}
+
+struct BinderModule {
+    _reg: Pin<Box<Registration<Ref<Context>>>>,
+}
+
+impl KernelModule for BinderModule {
+    fn init(name: &'static CStr, _module: &'static kernel::ThisModule) -> Result<Self> {
+        let ctx = Context::new()?;
+        let reg = Registration::new_pinned::<process::Process>(name, None, ctx)?;
+        Ok(Self { _reg: reg })
+    }
+}
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
new file mode 100644
index 000000000000..3891abca798b
--- /dev/null
+++ b/drivers/android/thread.rs
@@ -0,0 +1,871 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::{
+    alloc::AllocError,
+    mem::size_of,
+    sync::atomic::{AtomicU32, Ordering},
+};
+use kernel::{
+    bindings,
+    file::File,
+    file_operations::PollTable,
+    io_buffer::{IoBufferReader, IoBufferWriter},
+    linked_list::{GetLinks, Links, List},
+    prelude::*,
+    security,
+    sync::{CondVar, Ref, SpinLock, UniqueRef},
+    user_ptr::{UserSlicePtr, UserSlicePtrWriter},
+};
+
+use crate::{
+    allocation::{Allocation, AllocationView},
+    defs::*,
+    process::{AllocationInfo, Process},
+    ptr_align,
+    transaction::{FileInfo, Transaction},
+    DeliverCode, DeliverToRead, DeliverToReadListAdapter, Either,
+};
+
+pub(crate) type BinderResult<T = ()> = core::result::Result<T, BinderError>;
+
+pub(crate) struct BinderError {
+    pub(crate) reply: u32,
+}
+
+impl BinderError {
+    pub(crate) fn new_failed() -> Self {
+        Self {
+            reply: BR_FAILED_REPLY,
+        }
+    }
+
+    pub(crate) fn new_dead() -> Self {
+        Self {
+            reply: BR_DEAD_REPLY,
+        }
+    }
+}
+
+impl From<Error> for BinderError {
+    fn from(_: Error) -> Self {
+        Self::new_failed()
+    }
+}
+
+impl From<AllocError> for BinderError {
+    fn from(_: AllocError) -> Self {
+        Self::new_failed()
+    }
+}
+
+const LOOPER_REGISTERED: u32 = 0x01;
+const LOOPER_ENTERED: u32 = 0x02;
+const LOOPER_EXITED: u32 = 0x04;
+const LOOPER_INVALID: u32 = 0x08;
+const LOOPER_WAITING: u32 = 0x10;
+const LOOPER_POLL: u32 = 0x20;
+
+struct InnerThread {
+    /// Determines the looper state of the thread. It is a bit-wise combination of the constants
+    /// prefixed with `LOOPER_`.
+    looper_flags: u32,
+
+    /// Determines if thread is dead.
+    is_dead: bool,
+
+    /// Work item used to deliver error codes to the thread that started a transaction. When set to
+    /// `Some(x)`, it will hold the only reference to the object so that it can update the error
+    /// code to be delivered before queuing it.
+    reply_work: Option<Ref<ThreadError>>,
+
+    /// Work item used to deliver error codes to the current thread. When set to `Some(x)`, it will
+    /// hold the only reference to the object so that it can update the error code to be delivered
+    /// before queuing.
+    return_work: Option<Ref<ThreadError>>,
+
+    /// Determines whether the work list below should be processed. When set to false, `work_list`
+    /// is treated as if it were empty.
+    process_work_list: bool,
+    work_list: List<DeliverToReadListAdapter>,
+    current_transaction: Option<Ref<Transaction>>,
+}
+
+impl InnerThread {
+    fn new() -> Self {
+        Self {
+            looper_flags: 0,
+            is_dead: false,
+            process_work_list: false,
+            work_list: List::new(),
+            current_transaction: None,
+            return_work: None,
+            reply_work: None,
+        }
+    }
+
+    fn set_reply_work(&mut self, reply_work: Ref<ThreadError>) {
+        self.reply_work = Some(reply_work);
+    }
+
+    fn push_reply_work(&mut self, code: u32) {
+        let work = self.reply_work.take();
+        self.push_existing_work(work, code);
+    }
+
+    fn set_return_work(&mut self, return_work: Ref<ThreadError>) {
+        self.return_work = Some(return_work);
+    }
+
+    fn push_return_work(&mut self, code: u32) {
+        let work = self.return_work.take();
+        self.push_existing_work(work, code);
+    }
+
+    fn push_existing_work(&mut self, owork: Option<Ref<ThreadError>>, code: u32) {
+        // TODO: Write some warning when the following fails. It should not happen, and
+        // if it does, there is likely something wrong.
+        if let Some(work) = owork {
+            // `error_code` is written to with relaxed semantics because the queue onto which it is
+            // being inserted is protected by a lock. The release barrier when the lock is released
+            // by the caller matches with the acquire barrier of the future reader to guarantee
+            // that `error_code` is visible.
+            work.error_code.store(code, Ordering::Relaxed);
+            self.push_work(work);
+        }
+    }
+
+    fn pop_work(&mut self) -> Option<Ref<dyn DeliverToRead>> {
+        if !self.process_work_list {
+            return None;
+        }
+
+        let ret = self.work_list.pop_front();
+        // Once the queue is drained, we stop processing it until a non-deferred item is pushed
+        // again onto it.
+        self.process_work_list = !self.work_list.is_empty();
+        ret
+    }
+
+    fn push_work_deferred(&mut self, work: Ref<dyn DeliverToRead>) {
+        self.work_list.push_back(work);
+    }
+
+    fn push_work(&mut self, work: Ref<dyn DeliverToRead>) {
+        self.push_work_deferred(work);
+        self.process_work_list = true;
+    }
+
+    fn has_work(&self) -> bool {
+        self.process_work_list && !self.work_list.is_empty()
+    }
+
+    /// Fetches the transaction the thread can reply to. If the thread has a pending transaction
+    /// (that it could respond to) but it has also issued a transaction, it must first wait for the
+    /// previously-issued transaction to complete.
+    fn pop_transaction_to_reply(&mut self, thread: &Thread) -> Result<Ref<Transaction>> {
+        let transaction = self.current_transaction.take().ok_or(Error::EINVAL)?;
+
+        if core::ptr::eq(thread, transaction.from.as_ref()) {
+            self.current_transaction = Some(transaction);
+            return Err(Error::EINVAL);
+        }
+
+        // Find a new current transaction for this thread.
+        self.current_transaction = transaction.find_from(thread);
+        Ok(transaction)
+    }
+
+    fn pop_transaction_replied(&mut self, transaction: &Ref<Transaction>) -> bool {
+        match self.current_transaction.take() {
+            None => false,
+            Some(old) => {
+                if !Ref::ptr_eq(transaction, &old) {
+                    self.current_transaction = Some(old);
+                    return false;
+                }
+                self.current_transaction = old.clone_next();
+                true
+            }
+        }
+    }
+
+    fn looper_enter(&mut self) {
+        self.looper_flags |= LOOPER_ENTERED;
+        if self.looper_flags & LOOPER_REGISTERED != 0 {
+            self.looper_flags |= LOOPER_INVALID;
+        }
+    }
+
+    fn looper_register(&mut self, valid: bool) {
+        self.looper_flags |= LOOPER_REGISTERED;
+        if !valid || self.looper_flags & LOOPER_ENTERED != 0 {
+            self.looper_flags |= LOOPER_INVALID;
+        }
+    }
+
+    fn looper_exit(&mut self) {
+        self.looper_flags |= LOOPER_EXITED;
+    }
+
+    /// Determines whether the thread is part of a pool, i.e., if it is a looper.
+    fn is_looper(&self) -> bool {
+        self.looper_flags & (LOOPER_ENTERED | LOOPER_REGISTERED) != 0
+    }
+
+    /// Determines whether the thread should attempt to fetch work items from the process queue
+    /// (when its own queue is empty). This is case when the thread is not part of a transaction
+    /// stack and it is registered as a looper.
+    fn should_use_process_work_queue(&self) -> bool {
+        self.current_transaction.is_none() && self.is_looper()
+    }
+
+    fn poll(&mut self) -> u32 {
+        self.looper_flags |= LOOPER_POLL;
+        if self.has_work() {
+            bindings::POLLIN
+        } else {
+            0
+        }
+    }
+}
+
+pub(crate) struct Thread {
+    pub(crate) id: i32,
+    pub(crate) process: Ref<Process>,
+    inner: SpinLock<InnerThread>,
+    work_condvar: CondVar,
+    links: Links<Thread>,
+}
+
+impl Thread {
+    pub(crate) fn new(id: i32, process: Ref<Process>) -> Result<Ref<Self>> {
+        let return_work = Ref::try_new(ThreadError::new(InnerThread::set_return_work))?;
+        let reply_work = Ref::try_new(ThreadError::new(InnerThread::set_reply_work))?;
+        let mut thread = Pin::from(UniqueRef::try_new(Self {
+            id,
+            process,
+            // SAFETY: `inner` is initialised in the call to `spinlock_init` below.
+            inner: unsafe { SpinLock::new(InnerThread::new()) },
+            // SAFETY: `work_condvar` is initalised in the call to `condvar_init` below.
+            work_condvar: unsafe { CondVar::new() },
+            links: Links::new(),
+        })?);
+
+        // SAFETY: `inner` is pinned when `thread` is.
+        let inner = unsafe { thread.as_mut().map_unchecked_mut(|t| &mut t.inner) };
+        kernel::spinlock_init!(inner, "Thread::inner");
+
+        // SAFETY: `work_condvar` is pinned when `thread` is.
+        let condvar = unsafe { thread.as_mut().map_unchecked_mut(|t| &mut t.work_condvar) };
+        kernel::condvar_init!(condvar, "Thread::work_condvar");
+
+        {
+            let mut inner = thread.inner.lock();
+            inner.set_reply_work(reply_work);
+            inner.set_return_work(return_work);
+        }
+
+        Ok(thread.into())
+    }
+
+    pub(crate) fn set_current_transaction(&self, transaction: Ref<Transaction>) {
+        self.inner.lock().current_transaction = Some(transaction);
+    }
+
+    /// Attempts to fetch a work item from the thread-local queue. The behaviour if the queue is
+    /// empty depends on `wait`: if it is true, the function waits for some work to be queued (or a
+    /// signal); otherwise it returns indicating that none is available.
+    fn get_work_local(self: &Ref<Self>, wait: bool) -> Result<Ref<dyn DeliverToRead>> {
+        // Try once if the caller does not want to wait.
+        if !wait {
+            return self.inner.lock().pop_work().ok_or(Error::EAGAIN);
+        }
+
+        // Loop waiting only on the local queue (i.e., not registering with the process queue).
+        let mut inner = self.inner.lock();
+        loop {
+            if let Some(work) = inner.pop_work() {
+                return Ok(work);
+            }
+
+            inner.looper_flags |= LOOPER_WAITING;
+            let signal_pending = self.work_condvar.wait(&mut inner);
+            inner.looper_flags &= !LOOPER_WAITING;
+
+            if signal_pending {
+                return Err(Error::ERESTARTSYS);
+            }
+        }
+    }
+
+    /// Attempts to fetch a work item from the thread-local queue, falling back to the process-wide
+    /// queue if none is available locally.
+    ///
+    /// This must only be called when the thread is not participating in a transaction chain. If it
+    /// is, the local version (`get_work_local`) should be used instead.
+    fn get_work(self: &Ref<Self>, wait: bool) -> Result<Ref<dyn DeliverToRead>> {
+        // Try to get work from the thread's work queue, using only a local lock.
+        {
+            let mut inner = self.inner.lock();
+            if let Some(work) = inner.pop_work() {
+                return Ok(work);
+            }
+        }
+
+        // If the caller doesn't want to wait, try to grab work from the process queue.
+        //
+        // We know nothing will have been queued directly to the thread queue because it is not in
+        // a transaction and it is not in the process' ready list.
+        if !wait {
+            return self.process.get_work().ok_or(Error::EAGAIN);
+        }
+
+        // Get work from the process queue. If none is available, atomically register as ready.
+        let reg = match self.process.get_work_or_register(self) {
+            Either::Left(work) => return Ok(work),
+            Either::Right(reg) => reg,
+        };
+
+        let mut inner = self.inner.lock();
+        loop {
+            if let Some(work) = inner.pop_work() {
+                return Ok(work);
+            }
+
+            inner.looper_flags |= LOOPER_WAITING;
+            let signal_pending = self.work_condvar.wait(&mut inner);
+            inner.looper_flags &= !LOOPER_WAITING;
+
+            if signal_pending {
+                // A signal is pending. We need to pull the thread off the list, then check the
+                // state again after it's off the list to ensure that something was not queued in
+                // the meantime. If something has been queued, we just return it (instead of the
+                // error).
+                drop(inner);
+                drop(reg);
+                return self.inner.lock().pop_work().ok_or(Error::ERESTARTSYS);
+            }
+        }
+    }
+
+    pub(crate) fn push_work(&self, work: Ref<dyn DeliverToRead>) -> BinderResult {
+        {
+            let mut inner = self.inner.lock();
+            if inner.is_dead {
+                return Err(BinderError::new_dead());
+            }
+            inner.push_work(work);
+        }
+        self.work_condvar.notify_one();
+        Ok(())
+    }
+
+    /// Attempts to push to given work item to the thread if it's a looper thread (i.e., if it's
+    /// part of a thread pool) and is alive. Otherwise, push the work item to the process instead.
+    pub(crate) fn push_work_if_looper(&self, work: Ref<dyn DeliverToRead>) -> BinderResult {
+        let mut inner = self.inner.lock();
+        if inner.is_looper() && !inner.is_dead {
+            inner.push_work(work);
+            Ok(())
+        } else {
+            drop(inner);
+            self.process.push_work(work)
+        }
+    }
+
+    pub(crate) fn push_work_deferred(&self, work: Ref<dyn DeliverToRead>) {
+        self.inner.lock().push_work_deferred(work);
+    }
+
+    fn translate_object(
+        &self,
+        index_offset: usize,
+        view: &mut AllocationView<'_, '_>,
+        allow_fds: bool,
+    ) -> BinderResult {
+        let offset = view.alloc.read(index_offset)?;
+        let header = view.read::<bindings::binder_object_header>(offset)?;
+        // TODO: Handle other types.
+        match header.type_ {
+            BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
+                let strong = header.type_ == BINDER_TYPE_BINDER;
+                view.transfer_binder_object(offset, strong, |obj| {
+                    // SAFETY: `binder` is a `binder_uintptr_t`; any bit pattern is a valid
+                    // representation.
+                    let ptr = unsafe { obj.__bindgen_anon_1.binder } as _;
+                    let cookie = obj.cookie as _;
+                    let flags = obj.flags as _;
+                    let node = self.process.as_ref_borrow().get_node(
+                        ptr,
+                        cookie,
+                        flags,
+                        strong,
+                        Some(self),
+                    )?;
+                    security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
+                    Ok(node)
+                })?;
+            }
+            BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => {
+                let strong = header.type_ == BINDER_TYPE_HANDLE;
+                view.transfer_binder_object(offset, strong, |obj| {
+                    // SAFETY: `handle` is a `u32`; any bit pattern is a valid representation.
+                    let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
+                    let node = self.process.get_node_from_handle(handle, strong)?;
+                    security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
+                    Ok(node)
+                })?;
+            }
+            BINDER_TYPE_FD => {
+                if !allow_fds {
+                    return Err(BinderError::new_failed());
+                }
+
+                let obj = view.read::<bindings::binder_fd_object>(offset)?;
+                // SAFETY: `fd` is a `u32`; any bit pattern is a valid representation.
+                let fd = unsafe { obj.__bindgen_anon_1.fd };
+                let file = File::from_fd(fd)?;
+                security::binder_transfer_file(
+                    &self.process.cred,
+                    &view.alloc.process.cred,
+                    &file,
+                )?;
+                let field_offset =
+                    kernel::offset_of!(bindings::binder_fd_object, __bindgen_anon_1.fd) as usize;
+                let file_info = Box::try_new(FileInfo::new(file, offset + field_offset))?;
+                view.alloc.add_file_info(file_info);
+            }
+            _ => pr_warn!("Unsupported binder object type: {:x}\n", header.type_),
+        }
+        Ok(())
+    }
+
+    fn translate_objects(
+        &self,
+        alloc: &mut Allocation<'_>,
+        start: usize,
+        end: usize,
+        allow_fds: bool,
+    ) -> BinderResult {
+        let mut view = AllocationView::new(alloc, start);
+        for i in (start..end).step_by(size_of::<usize>()) {
+            if let Err(err) = self.translate_object(i, &mut view, allow_fds) {
+                alloc.set_info(AllocationInfo { offsets: start..i });
+                return Err(err);
+            }
+        }
+        alloc.set_info(AllocationInfo {
+            offsets: start..end,
+        });
+        Ok(())
+    }
+
+    pub(crate) fn copy_transaction_data<'a>(
+        &self,
+        to_process: &'a Process,
+        tr: &BinderTransactionData,
+        allow_fds: bool,
+    ) -> BinderResult<Allocation<'a>> {
+        let data_size = tr.data_size as _;
+        let adata_size = ptr_align(data_size);
+        let offsets_size = tr.offsets_size as _;
+        let aoffsets_size = ptr_align(offsets_size);
+
+        // This guarantees that at least `sizeof(usize)` bytes will be allocated.
+        let len = core::cmp::max(
+            adata_size.checked_add(aoffsets_size).ok_or(Error::ENOMEM)?,
+            size_of::<usize>(),
+        );
+        let mut alloc = to_process.buffer_alloc(len)?;
+
+        // Copy raw data.
+        let mut reader = unsafe { UserSlicePtr::new(tr.data.ptr.buffer as _, data_size) }.reader();
+        alloc.copy_into(&mut reader, 0, data_size)?;
+
+        // Copy offsets if there are any.
+        if offsets_size > 0 {
+            let mut reader =
+                unsafe { UserSlicePtr::new(tr.data.ptr.offsets as _, offsets_size) }.reader();
+            alloc.copy_into(&mut reader, adata_size, offsets_size)?;
+
+            // Traverse the objects specified.
+            self.translate_objects(
+                &mut alloc,
+                adata_size,
+                adata_size + aoffsets_size,
+                allow_fds,
+            )?;
+        }
+
+        Ok(alloc)
+    }
+
+    fn unwind_transaction_stack(self: &Ref<Self>) {
+        let mut thread = self.clone();
+        while let Ok(transaction) = {
+            let mut inner = thread.inner.lock();
+            inner.pop_transaction_to_reply(thread.as_ref())
+        } {
+            let reply = Either::Right(BR_DEAD_REPLY);
+            if !transaction.from.deliver_single_reply(reply, &transaction) {
+                break;
+            }
+
+            thread = transaction.from.clone();
+        }
+    }
+
+    pub(crate) fn deliver_reply(
+        &self,
+        reply: Either<Ref<Transaction>, u32>,
+        transaction: &Ref<Transaction>,
+    ) {
+        if self.deliver_single_reply(reply, transaction) {
+            transaction.from.unwind_transaction_stack();
+        }
+    }
+
+    /// Delivers a reply to the thread that started a transaction. The reply can either be a
+    /// reply-transaction or an error code to be delivered instead.
+    ///
+    /// Returns whether the thread is dead. If it is, the caller is expected to unwind the
+    /// transaction stack by completing transactions for threads that are dead.
+    fn deliver_single_reply(
+        &self,
+        reply: Either<Ref<Transaction>, u32>,
+        transaction: &Ref<Transaction>,
+    ) -> bool {
+        {
+            let mut inner = self.inner.lock();
+            if !inner.pop_transaction_replied(transaction) {
+                return false;
+            }
+
+            if inner.is_dead {
+                return true;
+            }
+
+            match reply {
+                Either::Left(work) => inner.push_work(work),
+                Either::Right(code) => inner.push_reply_work(code),
+            }
+        }
+
+        // Notify the thread now that we've released the inner lock.
+        self.work_condvar.notify_one();
+        false
+    }
+
+    /// Determines if the given transaction is the current transaction for this thread.
+    fn is_current_transaction(&self, transaction: &Ref<Transaction>) -> bool {
+        let inner = self.inner.lock();
+        match &inner.current_transaction {
+            None => false,
+            Some(current) => Ref::ptr_eq(current, transaction),
+        }
+    }
+
+    fn transaction<T>(self: &Ref<Self>, tr: &BinderTransactionData, inner: T)
+    where
+        T: FnOnce(&Ref<Self>, &BinderTransactionData) -> BinderResult,
+    {
+        if let Err(err) = inner(self, tr) {
+            self.inner.lock().push_return_work(err.reply);
+        }
+    }
+
+    fn reply_inner(self: &Ref<Self>, tr: &BinderTransactionData) -> BinderResult {
+        let orig = self.inner.lock().pop_transaction_to_reply(self)?;
+        if !orig.from.is_current_transaction(&orig) {
+            return Err(BinderError::new_failed());
+        }
+
+        // We need to complete the transaction even if we cannot complete building the reply.
+        (|| -> BinderResult<_> {
+            let completion = Ref::try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+            let process = orig.from.process.clone();
+            let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
+            let reply = Transaction::new_reply(self, process, tr, allow_fds)?;
+            self.inner.lock().push_work(completion);
+            orig.from.deliver_reply(Either::Left(reply), &orig);
+            Ok(())
+        })()
+        .map_err(|mut err| {
+            // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
+            // the sender know that the transaction has completed (with an error in this case).
+            let reply = Either::Right(BR_FAILED_REPLY);
+            orig.from.deliver_reply(reply, &orig);
+            err.reply = BR_TRANSACTION_COMPLETE;
+            err
+        })
+    }
+
+    /// Determines the current top of the transaction stack. It fails if the top is in another
+    /// thread (i.e., this thread belongs to a stack but it has called another thread). The top is
+    /// [`None`] if the thread is not currently participating in a transaction stack.
+    fn top_of_transaction_stack(&self) -> Result<Option<Ref<Transaction>>> {
+        let inner = self.inner.lock();
+        Ok(if let Some(cur) = &inner.current_transaction {
+            if core::ptr::eq(self, cur.from.as_ref()) {
+                return Err(Error::EINVAL);
+            }
+            Some(cur.clone())
+        } else {
+            None
+        })
+    }
+
+    fn oneway_transaction_inner(self: &Ref<Self>, tr: &BinderTransactionData) -> BinderResult {
+        let handle = unsafe { tr.target.handle };
+        let node_ref = self.process.get_transaction_node(handle)?;
+        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
+        let completion = Ref::try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+        let transaction = Transaction::new(node_ref, None, self, tr)?;
+        self.inner.lock().push_work(completion);
+        // TODO: Remove the completion on error?
+        transaction.submit()?;
+        Ok(())
+    }
+
+    fn transaction_inner(self: &Ref<Self>, tr: &BinderTransactionData) -> BinderResult {
+        let handle = unsafe { tr.target.handle };
+        let node_ref = self.process.get_transaction_node(handle)?;
+        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
+        // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
+        // could this happen?
+        let top = self.top_of_transaction_stack()?;
+        let completion = Ref::try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+        let transaction = Transaction::new(node_ref, top, self, tr)?;
+
+        // Check that the transaction stack hasn't changed while the lock was released, then update
+        // it with the new transaction.
+        {
+            let mut inner = self.inner.lock();
+            if !transaction.is_stacked_on(&inner.current_transaction) {
+                return Err(BinderError::new_failed());
+            }
+            inner.current_transaction = Some(transaction.clone());
+        }
+
+        // We push the completion as a deferred work so that we wait for the reply before returning
+        // to userland.
+        self.push_work_deferred(completion);
+        // TODO: Remove completion if submission fails?
+        transaction.submit()?;
+        Ok(())
+    }
+
+    fn write(self: &Ref<Self>, req: &mut BinderWriteRead) -> Result {
+        let write_start = req.write_buffer.wrapping_add(req.write_consumed);
+        let write_len = req.write_size - req.write_consumed;
+        let mut reader = unsafe { UserSlicePtr::new(write_start as _, write_len as _).reader() };
+
+        while reader.len() >= size_of::<u32>() && self.inner.lock().return_work.is_some() {
+            let before = reader.len();
+            match reader.read::<u32>()? {
+                BC_TRANSACTION => {
+                    let tr = reader.read::<BinderTransactionData>()?;
+                    if tr.flags & TF_ONE_WAY != 0 {
+                        self.transaction(&tr, Self::oneway_transaction_inner)
+                    } else {
+                        self.transaction(&tr, Self::transaction_inner)
+                    }
+                }
+                BC_REPLY => self.transaction(&reader.read()?, Self::reply_inner),
+                BC_FREE_BUFFER => drop(self.process.buffer_get(reader.read()?)),
+                BC_INCREFS => self.process.update_ref(reader.read()?, true, false)?,
+                BC_ACQUIRE => self.process.update_ref(reader.read()?, true, true)?,
+                BC_RELEASE => self.process.update_ref(reader.read()?, false, true)?,
+                BC_DECREFS => self.process.update_ref(reader.read()?, false, false)?,
+                BC_INCREFS_DONE => self.process.inc_ref_done(&mut reader, false)?,
+                BC_ACQUIRE_DONE => self.process.inc_ref_done(&mut reader, true)?,
+                BC_REQUEST_DEATH_NOTIFICATION => self.process.request_death(&mut reader, self)?,
+                BC_CLEAR_DEATH_NOTIFICATION => self.process.clear_death(&mut reader, self)?,
+                BC_DEAD_BINDER_DONE => self.process.dead_binder_done(reader.read()?, self),
+                BC_REGISTER_LOOPER => {
+                    let valid = self.process.register_thread();
+                    self.inner.lock().looper_register(valid);
+                }
+                BC_ENTER_LOOPER => self.inner.lock().looper_enter(),
+                BC_EXIT_LOOPER => self.inner.lock().looper_exit(),
+
+                // TODO: Add support for BC_TRANSACTION_SG and BC_REPLY_SG.
+                // BC_ATTEMPT_ACQUIRE and BC_ACQUIRE_RESULT are no longer supported.
+                _ => return Err(Error::EINVAL),
+            }
+
+            // Update the number of write bytes consumed.
+            req.write_consumed += (before - reader.len()) as u64;
+        }
+        Ok(())
+    }
+
+    fn read(self: &Ref<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
+        let read_start = req.read_buffer.wrapping_add(req.read_consumed);
+        let read_len = req.read_size - req.read_consumed;
+        let mut writer = unsafe { UserSlicePtr::new(read_start as _, read_len as _) }.writer();
+        let (in_pool, getter) = {
+            let inner = self.inner.lock();
+            (
+                inner.is_looper(),
+                if inner.should_use_process_work_queue() {
+                    Self::get_work
+                } else {
+                    Self::get_work_local
+                },
+            )
+        };
+
+        // Reserve some room at the beginning of the read buffer so that we can send a
+        // BR_SPAWN_LOOPER if we need to.
+        if req.read_consumed == 0 {
+            writer.write(&BR_NOOP)?;
+        }
+
+        // Loop doing work while there is room in the buffer.
+        let initial_len = writer.len();
+        while writer.len() >= size_of::<u32>() {
+            match getter(self, wait && initial_len == writer.len()) {
+                Ok(work) => {
+                    if !work.do_work(self, &mut writer)? {
+                        break;
+                    }
+                }
+                Err(err) => {
+                    // Propagate the error if we haven't written anything else.
+                    if initial_len == writer.len() {
+                        return Err(err);
+                    } else {
+                        break;
+                    }
+                }
+            }
+        }
+
+        req.read_consumed += read_len - writer.len() as u64;
+
+        // Write BR_SPAWN_LOOPER if the process needs more threads for its pool.
+        if in_pool && self.process.needs_thread() {
+            let mut writer =
+                unsafe { UserSlicePtr::new(req.read_buffer as _, req.read_size as _) }.writer();
+            writer.write(&BR_SPAWN_LOOPER)?;
+        }
+
+        Ok(())
+    }
+
+    pub(crate) fn write_read(self: &Ref<Self>, data: UserSlicePtr, wait: bool) -> Result {
+        let (mut reader, mut writer) = data.reader_writer();
+        let mut req = reader.read::<BinderWriteRead>()?;
+
+        // TODO: `write(&req)` happens in all exit paths from here on. Find a better way to encode
+        // it.
+
+        // Go through the write buffer.
+        if req.write_size > 0 {
+            if let Err(err) = self.write(&mut req) {
+                req.read_consumed = 0;
+                writer.write(&req)?;
+                return Err(err);
+            }
+        }
+
+        // Go through the work queue.
+        let mut ret = Ok(());
+        if req.read_size > 0 {
+            ret = self.read(&mut req, wait);
+        }
+
+        // Write the request back so that the consumed fields are visible to the caller.
+        writer.write(&req)?;
+        ret
+    }
+
+    pub(crate) fn poll(&self, file: &File, table: &PollTable) -> (bool, u32) {
+        // SAFETY: `free_waiters` is called on release.
+        unsafe { table.register_wait(file, &self.work_condvar) };
+        let mut inner = self.inner.lock();
+        (inner.should_use_process_work_queue(), inner.poll())
+    }
+
+    pub(crate) fn notify_if_poll_ready(&self) {
+        // Determine if we need to notify. This requires the lock.
+        let inner = self.inner.lock();
+        let notify = inner.looper_flags & LOOPER_POLL != 0
+            && inner.should_use_process_work_queue()
+            && !inner.has_work();
+        drop(inner);
+
+        // Now that the lock is no longer held, notify the waiters if we have to.
+        if notify {
+            self.work_condvar.notify_one();
+        }
+    }
+
+    pub(crate) fn push_return_work(&self, code: u32) {
+        self.inner.lock().push_return_work(code)
+    }
+
+    pub(crate) fn release(self: &Ref<Self>) {
+        // Mark the thread as dead.
+        self.inner.lock().is_dead = true;
+
+        // Cancel all pending work items.
+        while let Ok(work) = self.get_work_local(false) {
+            work.cancel();
+        }
+
+        // Complete the transaction stack as far as we can.
+        self.unwind_transaction_stack();
+
+        // Remove epoll items if polling was ever used on the thread.
+        let poller = self.inner.lock().looper_flags & LOOPER_POLL != 0;
+        if poller {
+            self.work_condvar.free_waiters();
+
+            unsafe { bindings::synchronize_rcu() };
+        }
+    }
+}
+
+impl GetLinks for Thread {
+    type EntryType = Thread;
+    fn get_links(data: &Thread) -> &Links<Thread> {
+        &data.links
+    }
+}
+
+struct ThreadError {
+    error_code: AtomicU32,
+    return_fn: fn(&mut InnerThread, Ref<ThreadError>),
+    links: Links<dyn DeliverToRead>,
+}
+
+impl ThreadError {
+    fn new(return_fn: fn(&mut InnerThread, Ref<ThreadError>)) -> Self {
+        Self {
+            error_code: AtomicU32::new(BR_OK),
+            return_fn,
+            links: Links::new(),
+        }
+    }
+}
+
+impl DeliverToRead for ThreadError {
+    fn do_work(self: Ref<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        // See `ThreadInner::push_existing_work` for the reason why `error_code` is up to date even
+        // though we use relaxed semantics.
+        let code = self.error_code.load(Ordering::Relaxed);
+
+        // Return the `ThreadError` to the thread.
+        (self.return_fn)(&mut *thread.inner.lock(), self);
+
+        // Deliver the error code to userspace.
+        writer.write(&code)?;
+        Ok(true)
+    }
+
+    fn get_links(&self) -> &Links<dyn DeliverToRead> {
+        &self.links
+    }
+}
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
new file mode 100644
index 000000000000..7d2567dda319
--- /dev/null
+++ b/drivers/android/transaction.rs
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::sync::atomic::{AtomicBool, Ordering};
+use kernel::{
+    bindings,
+    file::{File, FileDescriptorReservation},
+    io_buffer::IoBufferWriter,
+    linked_list::List,
+    linked_list::{GetLinks, Links},
+    prelude::*,
+    sync::{Ref, SpinLock, UniqueRef},
+    user_ptr::UserSlicePtrWriter,
+    ScopeGuard,
+};
+
+use crate::{
+    defs::*,
+    node::NodeRef,
+    process::Process,
+    ptr_align,
+    thread::{BinderResult, Thread},
+    DeliverToRead, Either,
+};
+
+struct TransactionInner {
+    file_list: List<Box<FileInfo>>,
+}
+
+pub(crate) struct Transaction {
+    inner: SpinLock<TransactionInner>,
+    // TODO: Node should be released when the buffer is released.
+    node_ref: Option<NodeRef>,
+    stack_next: Option<Ref<Transaction>>,
+    pub(crate) from: Ref<Thread>,
+    to: Ref<Process>,
+    free_allocation: AtomicBool,
+    code: u32,
+    pub(crate) flags: u32,
+    data_size: usize,
+    offsets_size: usize,
+    data_address: usize,
+    links: Links<dyn DeliverToRead>,
+}
+
+impl Transaction {
+    pub(crate) fn new(
+        node_ref: NodeRef,
+        stack_next: Option<Ref<Transaction>>,
+        from: &Ref<Thread>,
+        tr: &BinderTransactionData,
+    ) -> BinderResult<Ref<Self>> {
+        let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
+        let to = node_ref.node.owner.clone();
+        let mut alloc = from.copy_transaction_data(&to, tr, allow_fds)?;
+        let data_address = alloc.ptr;
+        let file_list = alloc.take_file_list();
+        alloc.keep_alive();
+        let mut tr = Pin::from(UniqueRef::try_new(Self {
+            // SAFETY: `spinlock_init` is called below.
+            inner: unsafe { SpinLock::new(TransactionInner { file_list }) },
+            node_ref: Some(node_ref),
+            stack_next,
+            from: from.clone(),
+            to,
+            code: tr.code,
+            flags: tr.flags,
+            data_size: tr.data_size as _,
+            data_address,
+            offsets_size: tr.offsets_size as _,
+            links: Links::new(),
+            free_allocation: AtomicBool::new(true),
+        })?);
+
+        // SAFETY: `inner` is pinned when `tr` is.
+        let pinned = unsafe { tr.as_mut().map_unchecked_mut(|t| &mut t.inner) };
+        kernel::spinlock_init!(pinned, "Transaction::inner");
+
+        Ok(tr.into())
+    }
+
+    pub(crate) fn new_reply(
+        from: &Ref<Thread>,
+        to: Ref<Process>,
+        tr: &BinderTransactionData,
+        allow_fds: bool,
+    ) -> BinderResult<Ref<Self>> {
+        let mut alloc = from.copy_transaction_data(&to, tr, allow_fds)?;
+        let data_address = alloc.ptr;
+        let file_list = alloc.take_file_list();
+        alloc.keep_alive();
+        let mut tr = Pin::from(UniqueRef::try_new(Self {
+            // SAFETY: `spinlock_init` is called below.
+            inner: unsafe { SpinLock::new(TransactionInner { file_list }) },
+            node_ref: None,
+            stack_next: None,
+            from: from.clone(),
+            to,
+            code: tr.code,
+            flags: tr.flags,
+            data_size: tr.data_size as _,
+            data_address,
+            offsets_size: tr.offsets_size as _,
+            links: Links::new(),
+            free_allocation: AtomicBool::new(true),
+        })?);
+
+        // SAFETY: `inner` is pinned when `tr` is.
+        let pinned = unsafe { tr.as_mut().map_unchecked_mut(|t| &mut t.inner) };
+        kernel::spinlock_init!(pinned, "Transaction::inner");
+
+        Ok(tr.into())
+    }
+
+    /// Determines if the transaction is stacked on top of the given transaction.
+    pub(crate) fn is_stacked_on(&self, onext: &Option<Ref<Self>>) -> bool {
+        match (&self.stack_next, onext) {
+            (None, None) => true,
+            (Some(stack_next), Some(next)) => Ref::ptr_eq(stack_next, next),
+            _ => false,
+        }
+    }
+
+    /// Returns a pointer to the next transaction on the transaction stack, if there is one.
+    pub(crate) fn clone_next(&self) -> Option<Ref<Self>> {
+        let next = self.stack_next.as_ref()?;
+        Some(next.clone())
+    }
+
+    /// Searches in the transaction stack for a thread that belongs to the target process. This is
+    /// useful when finding a target for a new transaction: if the node belongs to a process that
+    /// is already part of the transaction stack, we reuse the thread.
+    fn find_target_thread(&self) -> Option<Ref<Thread>> {
+        let process = &self.node_ref.as_ref()?.node.owner;
+
+        let mut it = &self.stack_next;
+        while let Some(transaction) = it {
+            if Ref::ptr_eq(&transaction.from.process, process) {
+                return Some(transaction.from.clone());
+            }
+            it = &transaction.stack_next;
+        }
+        None
+    }
+
+    /// Searches in the transaction stack for a transaction originating at the given thread.
+    pub(crate) fn find_from(&self, thread: &Thread) -> Option<Ref<Transaction>> {
+        let mut it = &self.stack_next;
+        while let Some(transaction) = it {
+            if core::ptr::eq(thread, transaction.from.as_ref()) {
+                return Some(transaction.clone());
+            }
+
+            it = &transaction.stack_next;
+        }
+        None
+    }
+
+    /// Submits the transaction to a work queue. Use a thread if there is one in the transaction
+    /// stack, otherwise use the destination process.
+    pub(crate) fn submit(self: Ref<Self>) -> BinderResult {
+        if let Some(thread) = self.find_target_thread() {
+            thread.push_work(self)
+        } else {
+            let process = self.to.clone();
+            process.push_work(self)
+        }
+    }
+
+    /// Prepares the file list for delivery to the caller.
+    fn prepare_file_list(&self) -> Result<List<Box<FileInfo>>> {
+        // Get list of files that are being transferred as part of the transaction.
+        let mut file_list = core::mem::replace(&mut self.inner.lock().file_list, List::new());
+
+        // If the list is non-empty, prepare the buffer.
+        if !file_list.is_empty() {
+            let alloc = self.to.buffer_get(self.data_address).ok_or(Error::ESRCH)?;
+            let cleanup = ScopeGuard::new(|| {
+                self.free_allocation.store(false, Ordering::Relaxed);
+            });
+
+            let mut it = file_list.cursor_front_mut();
+            while let Some(file_info) = it.current() {
+                let reservation = FileDescriptorReservation::new(bindings::O_CLOEXEC)?;
+                alloc.write(file_info.buffer_offset, &reservation.reserved_fd())?;
+                file_info.reservation = Some(reservation);
+                it.move_next();
+            }
+
+            alloc.keep_alive();
+            cleanup.dismiss();
+        }
+
+        Ok(file_list)
+    }
+}
+
+impl DeliverToRead for Transaction {
+    fn do_work(self: Ref<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        /* TODO: Initialise the following fields from tr:
+            pub sender_pid: pid_t,
+            pub sender_euid: uid_t,
+        */
+        let send_failed_reply = ScopeGuard::new(|| {
+            if self.node_ref.is_some() && self.flags & TF_ONE_WAY == 0 {
+                let reply = Either::Right(BR_FAILED_REPLY);
+                self.from.deliver_reply(reply, &self);
+            }
+        });
+        let mut file_list = if let Ok(list) = self.prepare_file_list() {
+            list
+        } else {
+            // On failure to process the list, we send a reply back to the sender and ignore the
+            // transaction on the recipient.
+            return Ok(true);
+        };
+
+        let mut tr = BinderTransactionData::default();
+
+        if let Some(nref) = &self.node_ref {
+            let (ptr, cookie) = nref.node.get_id();
+            tr.target.ptr = ptr as _;
+            tr.cookie = cookie as _;
+        };
+
+        tr.code = self.code;
+        tr.flags = self.flags;
+        tr.data_size = self.data_size as _;
+        tr.data.ptr.buffer = self.data_address as _;
+        tr.offsets_size = self.offsets_size as _;
+        if tr.offsets_size > 0 {
+            tr.data.ptr.offsets = (self.data_address + ptr_align(self.data_size)) as _;
+        }
+
+        let code = if self.node_ref.is_none() {
+            BR_REPLY
+        } else {
+            BR_TRANSACTION
+        };
+
+        // Write the transaction code and data to the user buffer.
+        writer.write(&code)?;
+        writer.write(&tr)?;
+
+        // Dismiss the completion of transaction with a failure. No failure paths are allowed from
+        // here on out.
+        send_failed_reply.dismiss();
+
+        // Commit all files.
+        {
+            let mut it = file_list.cursor_front_mut();
+            while let Some(file_info) = it.current() {
+                if let Some(reservation) = file_info.reservation.take() {
+                    if let Some(file) = file_info.file.take() {
+                        reservation.commit(file);
+                    }
+                }
+
+                it.move_next();
+            }
+        }
+
+        // When `drop` is called, we don't want the allocation to be freed because it is now the
+        // user's reponsibility to free it.
+        //
+        // `drop` is guaranteed to see this relaxed store because `Ref` guarantess that everything
+        // that happens when an object is referenced happens-before the eventual `drop`.
+        self.free_allocation.store(false, Ordering::Relaxed);
+
+        // When this is not a reply and not an async transaction, update `current_transaction`. If
+        // it's a reply, `current_transaction` has already been updated appropriately.
+        if self.node_ref.is_some() && tr.flags & TF_ONE_WAY == 0 {
+            thread.set_current_transaction(self);
+        }
+
+        Ok(false)
+    }
+
+    fn cancel(self: Ref<Self>) {
+        let reply = Either::Right(BR_DEAD_REPLY);
+        self.from.deliver_reply(reply, &self);
+    }
+
+    fn get_links(&self) -> &Links<dyn DeliverToRead> {
+        &self.links
+    }
+}
+
+impl Drop for Transaction {
+    fn drop(&mut self) {
+        if self.free_allocation.load(Ordering::Relaxed) {
+            self.to.buffer_get(self.data_address);
+        }
+    }
+}
+
+pub(crate) struct FileInfo {
+    links: Links<FileInfo>,
+
+    /// The file for which a descriptor will be created in the recipient process.
+    file: Option<File>,
+
+    /// The file descriptor reservation on the recipient process.
+    reservation: Option<FileDescriptorReservation>,
+
+    /// The offset in the buffer where the file descriptor is stored.
+    buffer_offset: usize,
+}
+
+impl FileInfo {
+    pub(crate) fn new(file: File, buffer_offset: usize) -> Self {
+        Self {
+            file: Some(file),
+            reservation: None,
+            buffer_offset,
+            links: Links::new(),
+        }
+    }
+}
+
+impl GetLinks for FileInfo {
+    type EntryType = Self;
+
+    fn get_links(data: &Self::EntryType) -> &Links<Self::EntryType> {
+        &data.links
+    }
+}
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 3246f2c74696..ad619623571e 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -236,19 +236,21 @@ struct binder_frozen_status_info {
 	__u32            async_recv;
 };
 
-#define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
-#define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
-#define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
-#define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
-#define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
-#define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
-#define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
-#define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
-#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
-#define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
-#define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
-#define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
-#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
+enum {
+	BINDER_WRITE_READ		= _IOWR('b', 1, struct binder_write_read),
+	BINDER_SET_IDLE_TIMEOUT		= _IOW('b', 3, __s64),
+	BINDER_SET_MAX_THREADS		= _IOW('b', 5, __u32),
+	BINDER_SET_IDLE_PRIORITY	= _IOW('b', 6, __s32),
+	BINDER_SET_CONTEXT_MGR		= _IOW('b', 7, __s32),
+	BINDER_THREAD_EXIT		= _IOW('b', 8, __s32),
+	BINDER_VERSION			= _IOWR('b', 9, struct binder_version),
+	BINDER_GET_NODE_DEBUG_INFO	= _IOWR('b', 11, struct binder_node_debug_info),
+	BINDER_GET_NODE_INFO_FOR_REF	= _IOWR('b', 12, struct binder_node_info_for_ref),
+	BINDER_SET_CONTEXT_MGR_EXT	= _IOW('b', 13, struct flat_binder_object),
+	BINDER_FREEZE			= _IOW('b', 14, struct binder_freeze_info),
+	BINDER_GET_FROZEN_INFO		= _IOWR('b', 15, struct binder_frozen_status_info),
+	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	= _IOW('b', 16, __u32),
+};
 
 /*
  * NOTE: Two special error codes you should check for when calling
-- 
2.34.0

