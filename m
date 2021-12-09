Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6616F46F6A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhLIWTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhLIWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E8C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso13060122ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a1e01/uQIMruIVMxVHsJI+lKzq1arm+BxjGSeQVMHMA=;
        b=PqB8Y03IRHWlUaGuR+3mpNmM+NV36jEBvM5WalY9UQa7LJQ3Ha7mLeU0SrXzuGpgv7
         3f1FJ7nyOU1HKi0FN2fKfIxI5t5swTAFYDfuuNdYZhQqduoKHQ1cYMi4OIcVm53c3vCy
         7yT5rL4j/PWClDNNlKwcRZOM73uddO3lpdJphfRR21b42NwPq21ghJtd4I9iZuBlLngU
         qCZ6m7MdzEt3RAGpy7Ix+uOw5VaFfqKUEZwR8gWh/+ky7IT5ELKb9UeUJd9IKkCKn5xq
         NkDxW8QZ9WvEJwcrHkgaoPFQ7+5GNQoVTcHihopQaPQAfuvCjJ80sufoumyAG3oTmcrm
         rdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a1e01/uQIMruIVMxVHsJI+lKzq1arm+BxjGSeQVMHMA=;
        b=cwIHoZMJu6sOS/55kzg2erYMHIKySxZnimKMrciJisOiH4iuTmEiP/Y9MThs2Rt+PY
         b82Vu9vZyRJD6MYPNxFLo4z6c3/zmzHLlJUSaAWlUDK1hRexInVZLFzD5meV6A7JxnHb
         SIo2hHRuh9NpoFlyn3sAKNliXrCDg/i8zg0oXPYb+M1XwmQpRmKEin1zHP2TNCQG32Dk
         N3L9Jb3VqnatE0gnc4wqc0aL7Dc45pKjr4Bq7y8N0GtUjQ7b7HuRf83TlTUylNzGkbYw
         EU7YZ2DBD+FYbs5jvRQwC1ERXTTvaFL3cIhHQPHjzivvFJoHOHSBrGaHnusl/+MCpm8h
         1MpA==
X-Gm-Message-State: AOAM533A2hYzTbwI2/uqOfu+Rj/Hx7z/BQMv3ZlSJiypgOpRoHn8te0O
        IQgTs6IWQabwQqIrslURINToyRs=
X-Google-Smtp-Source: ABdhPJxc0LQEcS2GZ0xtTl0rfiaEYOwwtlAW2WphlbELpXxEcghi8DcFKiFyg+sJxtCD3pCjqLRkEqw=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a25:2e49:: with SMTP id b9mr10139518ybn.414.1639088166927;
 Thu, 09 Dec 2021 14:16:06 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:43 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-7-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 6/7] Documentation: document uaccess logging
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the uaccess logging feature.

Link: https://linux-review.googlesource.com/id/Ia626c0ca91bc0a3d8067d7f28406aa40693b65a2
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v3:
- document what happens if passing NULL to prctl
- be explicit about meaning of addr and size

 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/uaccess-logging.rst | 151 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/admin-guide/uaccess-logging.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 1bedab498104..4f6ee447ab2f 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -54,6 +54,7 @@ ABI will be found here.
    :maxdepth: 1
 
    sysfs-rules
+   uaccess-logging
 
 The rest of this manual consists of various unordered guides on how to
 configure specific aspects of kernel behavior to your liking.
diff --git a/Documentation/admin-guide/uaccess-logging.rst b/Documentation/admin-guide/uaccess-logging.rst
new file mode 100644
index 000000000000..24def38bbdf8
--- /dev/null
+++ b/Documentation/admin-guide/uaccess-logging.rst
@@ -0,0 +1,151 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Uaccess Logging
+===============
+
+Background
+----------
+
+Userspace tools such as sanitizers (ASan, MSan, HWASan) and tools
+making use of the ARM Memory Tagging Extension (MTE) need to
+monitor all memory accesses in a program so that they can detect
+memory errors. Furthermore, fuzzing tools such as syzkaller need to
+monitor all memory accesses so that they know which parts of memory
+to fuzz. For accesses made purely in userspace, this is achieved
+via compiler instrumentation, or for MTE, via direct hardware
+support. However, accesses made by the kernel on behalf of the user
+program via syscalls (i.e. uaccesses) are normally invisible to
+these tools.
+
+Traditionally, the sanitizers have handled this by interposing the libc
+syscall stubs with a wrapper that checks the memory based on what we
+believe the uaccesses will be. However, this creates a maintenance
+burden: each syscall must be annotated with its uaccesses in order
+to be recognized by the sanitizer, and these annotations must be
+continuously updated as the kernel changes.
+
+The kernel's uaccess logging feature provides userspace tools with
+the address and size of each userspace access, thereby allowing these
+tools to report memory errors involving these accesses without needing
+annotations for every syscall.
+
+By relying on the kernel's actual uaccesses, rather than a
+reimplementation of them, the userspace memory safety tools may
+play a dual role of verifying the validity of kernel accesses. Even
+a sanitizer whose syscall wrappers have complete knowledge of the
+kernel's intended API may vary from the kernel's actual uaccesses due
+to kernel bugs. A sanitizer with knowledge of the kernel's actual
+uaccesses may produce more accurate error reports that reveal such
+bugs. For example, a kernel that accesses more memory than expected
+by the userspace program could indicate that either userspace or the
+kernel has the wrong idea about which kernel functionality is being
+requested -- either way, there is a bug.
+
+Interface
+---------
+
+The feature may be used via the following prctl:
+
+.. code-block:: c
+
+  uint64_t addr = 0; /* Generally will be a TLS slot or equivalent */
+  prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &addr, 0, 0, 0);
+
+Supplying a non-zero address as the second argument to ``prctl``
+will cause the kernel to read an address (referred to as the *uaccess
+descriptor address*) from that address on each kernel entry. Specifying
+an address of NULL as the second argument will restore the kernel's
+default behavior, i.e. no uaccess descriptor address is read.
+
+When entering the kernel with a non-zero uaccess descriptor address
+to handle a syscall, the kernel will read a data structure of type
+``struct uaccess_descriptor`` from the uaccess descriptor address,
+which is defined as follows:
+
+.. code-block:: c
+
+  struct uaccess_descriptor {
+    uint64_t addr, size;
+  };
+
+This data structure contains the address and size (in array elements)
+of a *uaccess buffer*, which is an array of data structures of type
+``struct uaccess_buffer_entry``. Before returning to userspace, the
+kernel will log information about uaccesses to sequential entries
+in the uaccess buffer. It will also store ``NULL`` to the uaccess
+descriptor address, and store the address and size of the unused
+portion of the uaccess buffer to the uaccess descriptor.
+
+The format of a uaccess buffer entry is defined as follows:
+
+.. code-block:: c
+
+  struct uaccess_buffer_entry {
+    uint64_t addr, size, flags;
+  };
+
+``addr`` and ``size`` contain the address and size of the user memory
+access. On arm64, tag bits are preserved in the ``addr`` field. There
+is currently one flag bit assignment for the ``flags`` field:
+
+.. code-block:: c
+
+  #define UACCESS_BUFFER_FLAG_WRITE 1
+
+This flag is set if the access was a write, or clear if it was a
+read. The meaning of all other flag bits is reserved.
+
+When entering the kernel with a non-zero uaccess descriptor
+address for a reason other than a syscall (for example, when
+IPI'd due to an incoming asynchronous signal), any signals other
+than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
+``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
+initialized with ``sigfillset(set)``. This is to prevent incoming
+signals from interfering with uaccess logging.
+
+Example
+-------
+
+Here is an example of a code snippet that will enumerate the accesses
+performed by a ``uname(2)`` syscall:
+
+.. code-block:: c
+
+  struct uaccess_buffer_entry entries[64];
+  struct uaccess_descriptor desc;
+  uint64_t desc_addr = 0;
+  prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &desc_addr, 0, 0, 0);
+
+  desc.addr = (uint64_t)&entries;
+  desc.size = 64;
+  desc_addr = (uint64_t)&desc;
+
+  struct utsname un;
+  uname(&un);
+
+  struct uaccess_buffer_entry* entries_end = (struct uaccess_buffer_entry*)desc.addr;
+  for (struct uaccess_buffer_entry* entry = entries; entry != entries_end; ++entry) {
+    printf("%s at 0x%lx size 0x%lx\n", entry->flags & UACCESS_BUFFER_FLAG_WRITE ? "WRITE" : "READ",
+           (unsigned long)entry->addr, (unsigned long)entry->size);
+  }
+
+Limitations
+-----------
+
+This feature is currently only supported on the arm64, s390 and x86
+architectures.
+
+Uaccess buffers are a "best-effort" mechanism for logging uaccesses. Of
+course, not all of the accesses may fit in the buffer, but aside from
+that, not all internal kernel APIs that access userspace memory are
+covered. Therefore, userspace programs should tolerate unreported
+accesses.
+
+On the other hand, the kernel guarantees that it will not
+(intentionally) report accessing more data than it is specified
+to read. For example, if the kernel implements a syscall that is
+specified to read a data structure of size ``N`` bytes by first
+reading a page's worth of data and then only using the first ``N``
+bytes from it, the kernel will either report reading ``N`` bytes or
+not report the access at all.
-- 
2.34.1.173.g76aa8bc2d0-goog

