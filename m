Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720B3474F08
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbhLOAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbhLOAUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:20:07 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ADDC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:20:07 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q72so27217233iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=te6hwZw6i27i6VYZTBmJgJ4rYzmPq2RFyeORvdWaIgY=;
        b=HjZ3qP76XrzWAUSkeH3H+hAkpPjspRh0jyBBWrNbRUyAhnzNdiue3gZesoqNEvRcpr
         itEUlMM1qJvvflZ96s3V0aGIA13NvdrUn/BLp8BEq+y5vKQ5fs+recU9KeVTYMIm3Q68
         QqCz/1YYPV1FZncmvRsZUg+ey0a13P75nsfuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=te6hwZw6i27i6VYZTBmJgJ4rYzmPq2RFyeORvdWaIgY=;
        b=gKYJUPcMxc0MMME+m5V/Rde+KlSYuBq/jNfY4sOKZ/eg+dHXHLZuhJoSEAboe6d7oI
         Wj7Mh1Ph7HL63MhMl3Bon1ICSBLpjPx2yEgIjJsp8Z8lF6H1lcO9EDqnJse20JsssW5d
         R9YiCwd1HR1eGfQDpCUdb6voAs8KGcC7OdzPTfT8Mo64L94kAjs2qNdZDmvJ31+foDo1
         UYjp/jj00wfFZu8/73n2xPJGg626reOHZVLAg8XglO20FmjsZVNLr05acRfTSOZ1QMp3
         I/PevqOsdRt09tiYrfNt1rlSt4U88aYCCL7mq/yMGs2IuVBi5R24lMiyPsxqRt0AxSfV
         wQWA==
X-Gm-Message-State: AOAM5311q1N22TJ3Qh3GnHpUrMtmp3kZZdt7MZTtl8h4qpCFHJx70v+5
        eMnRQnpJKgaBYLXZ+0NZaNr250yPModFwQ==
X-Google-Smtp-Source: ABdhPJzeIpQHs/H9JKic1oq/C3Cr3/nfzRha4bl7c3zxv52ZWx3oarFV9mMKcvSfr1t2qKGGUc0/8Q==
X-Received: by 2002:a6b:440f:: with SMTP id r15mr5368497ioa.128.1639527606678;
        Tue, 14 Dec 2021 16:20:06 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b7sm186172iln.34.2021.12.14.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:20:06 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, akpm@linux-foundation.org, luto@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: add vmalloced-kernel-stacks document
Date:   Tue, 14 Dec 2021 17:20:04 -0700
Message-Id: <20211215002004.47981-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new document to explain Virtually Mapped Kernel Stack Support.
This is a compilation of information from the code and original patch
series that introduced the Virtually Mapped Kernel Stacks feature.

This document summarizes the feature and provides details on allocation,
free, and stack overflow handling. Provides reference to available tests.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/vm/index.rst                   |   1 +
 Documentation/vm/vmalloced-kernel-stacks.rst | 153 +++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/vm/vmalloced-kernel-stacks.rst

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 6f5ffef4b716..b1826ca2c576 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -36,5 +36,6 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    split_page_table_lock
    transhuge
    unevictable-lru
+   vmalloced-kernel-stacks
    z3fold
    zsmalloc
diff --git a/Documentation/vm/vmalloced-kernel-stacks.rst b/Documentation/vm/vmalloced-kernel-stacks.rst
new file mode 100644
index 000000000000..fc8c67833af6
--- /dev/null
+++ b/Documentation/vm/vmalloced-kernel-stacks.rst
@@ -0,0 +1,153 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Virtually Mapped Kernel Stack Support
+=====================================
+
+:Author: Shuah Khan <skhan@linuxfoundation.org>
+
+.. contents:: :local:
+
+Overview
+--------
+
+This is a compilation of information from the code and original patch
+series that introduced the `Virtually Mapped Kernel Stacks feature
+<https://lwn.net/Articles/694348/>`
+
+Introduction
+------------
+
+Kernel stack overflows are often hard to debug and make the kernel
+susceptible to exploits. Problems could show up at a later time making
+it difficult to isolate and root-cause.
+
+Virtually-mapped kernel stacks with guard pages causes kernel stack
+overflows to be caught immediately rather than causing difficult to
+diagnose corruptions.
+
+HAVE_ARCH_VMAP_STACK and VMAP_STACK configuration options enable
+support for virtually mapped stacks with guard pages. This feature
+causes reliable faults when the stack overflows. The usability of
+the stack trace after overflow and response to the overflow itself
+is architecture dependent.
+
+.. note::
+        As of this writing, arm64, powerpc, riscv, s390, um, and x86 have
+        support for VMAP_STACK.
+
+HAVE_ARCH_VMAP_STACK
+--------------------
+
+Architectures that can support Virtually Mapped Kernel Stacks should
+enable this bool configuration option. The requirements are:
+
+- vmalloc space must be large enough to hold many kernel stacks. This
+  may rule out many 32-bit architectures.
+- Stacks in vmalloc space need to work reliably.  For example, if
+  vmap page tables are created on demand, either this mechanism
+  needs to work while the stack points to a virtual address with
+  unpopulated page tables or arch code (switch_to() and switch_mm(),
+  most likely) needs to ensure that the stack's page table entries
+  are populated before running on a possibly unpopulated stack.
+- If the stack overflows into a guard page, something reasonable
+  should happen. The definition of "reasonable" is flexible, but
+  instantly rebooting without logging anything would be unfriendly.
+
+VMAP_STACK
+----------
+
+VMAP_STACK bool configuration option when enabled allocates virtually
+mapped task stacks. This option depends on HAVE_ARCH_VMAP_STACK.
+
+- Enable this if you want the use virtually-mapped kernel stacks
+  with guard pages. This causes kernel stack overflows to be caught
+  immediately rather than causing difficult-to-diagnose corruption.
+
+.. note::
+
+        Using this feature with KASAN requires architecture support
+        for backing virtual mappings with real shadow memory, and
+        KASAN_VMALLOC must be enabled.
+
+.. note::
+
+        VMAP_STACK is enabled, it is not possible to run DMA on stack
+        allocated data.
+
+Kernel configuration options and dependencies keep changing. Refer to
+the latest code base:
+
+`Kconfig <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/Kconfig>`
+
+Allocation
+-----------
+
+When a new kernel thread is created, thread stack is allocated from
+virtually contiguous memory pages from the page level allocator. These
+pages are mapped into contiguous kernel virtual space with PAGE_KERNEL
+protections.
+
+alloc_thread_stack_node() calls __vmalloc_node_range() to allocate stack
+with PAGE_KERNEL protections.
+
+- Allocated stacks are cached and later reused by new threads, so memcg
+  accounting is performed manually on assigning/releasing stacks to tasks.
+  Hence, __vmalloc_node_range is called without __GFP_ACCOUNT.
+- vm_struct is cached to be able to find when thread free is initiated
+  in interrupt context. free_thread_stack() can be called in interrupt
+  context.
+- On arm64, all VMAP's stacks need to have the same alignment to ensure
+  that VMAP'd stack overflow detection works correctly. Arch specific
+  vmap stack allocator takes care of this detail.
+- This does not address interrupt stacks - according to the original patch
+
+Thread stack allocation is initiated from clone(), fork(), vfork(),
+kernel_thread() via kernel_clone(). Leaving a few hints for searching
+the code base to understand when and how thread stack is allocated.
+
+Bulk of the code is in:
+`kernel/fork.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c>`.
+
+stack_vm_area pointer in task_struct keeps track of the virtually allocated
+stack and a non-null stack_vm_area pointer serves as a indication that the
+virtually mapped kernel stacks are enabled.
+
+::
+
+        struct vm_struct *stack_vm_area;
+
+Stack overflow handling
+-----------------------
+
+Leading and trailing guard pages help detect stack overflows. When stack
+overflows into the guard pages, handlers have to be careful not overflow
+the stack again. When handlers are called, it is likely that very little
+stack space is left.
+
+On x86, this is done by handling the page fault indicating the kernel
+stack overflow on the double-fault stack.
+
+Testing VMAP allocation with guard pages
+----------------------------------------
+
+How do we ensure that VMAP_STACK is actually allocating with a leading
+and trailing guard page? The following lkdtm tests can help detect any
+regressions.
+
+::
+
+        void lkdtm_STACK_GUARD_PAGE_LEADING()
+        void lkdtm_STACK_GUARD_PAGE_TRAILING()
+
+Conclusions
+-----------
+
+- A percpu cache of vmalloced stacks appears to be a bit faster than a
+  high-order stack allocation, at least when the cache hits.
+- THREAD_INFO_IN_TASK gets rid of arch-specific thread_info entirely and
+  simply embed the thread_info (containing only flags) and 'int cpu' into
+  task_struct.
+- The thread stack can be free'ed as soon as the task is dead (without
+  waiting for RCU) and then, if vmapped stacks are in use, cache the
+  entire stack for reuse on the same cpu.
-- 
2.32.0

