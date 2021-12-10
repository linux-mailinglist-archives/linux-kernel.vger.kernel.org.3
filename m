Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A971B470C95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbhLJVdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbhLJVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:33:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC53C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:30:06 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id a11so9648110ilj.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+aq6j8q7qdyN2ff4xhoJmmib7U6wNPGCU8yDnkbsfic=;
        b=oPr9DHzuxjnst52qEp59rKDQjXRQwDpPBjwgBjuwTHppgrG7l/mT+xSWGy1seH0bWF
         tqVo+g6qCLZpNWEWm0XKc/0nmPao0TQhSHCb+MfmEqG8PLu+XQGWRcljIugMsoHCHDDH
         Oo1obaQq0lWw3lqWoAdAozxfMa0GNiMmLsN46gO5TnSM5n5UPWdhVg7JVMWSGnWk2ljP
         O+p6zC0z+iM20Zav7IiGR8ywF1GXslwR6kpAe47RXN9zL9CAGSgFogDs+KVLPL6xmzDK
         J6AB9CbDniYnPcQ5WmGTUfzdObwJaX+hdWeDd6EavnCYBXSbrRZ/RBAhzTB0JHihipRm
         lJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aq6j8q7qdyN2ff4xhoJmmib7U6wNPGCU8yDnkbsfic=;
        b=fSf/YzpACzi06KgsMzuQLej4P1QRe9MKry6nuzfuh/1zFq1SbFPXew5p1RyUNzgPRD
         TuBxLFHx5H+SInEL3a1if01dkzvBHkHKWR/rWlinnP1EMlBtJXUfpmtzydXJhDeeSPPD
         PMlc9IunbLANDxVX2HC3FzNIJ3NHlvGMngGwYMZDRW8DaKJXX0BGT2qE3agUzJ0qFkKk
         bbT3JQBWBd7RpEb/mN72Z43+JPt9WmQPAwTgZenGierP/UoaEY9UTmlCgGG1BscGaGLf
         rMl03q0Us/xExigdu68i/JVJBNOq6WC7CkwpHlEw/Qa56YmBhCZ7b374j9VkaSR1zeEe
         EeUw==
X-Gm-Message-State: AOAM531dJfrGmEXB6VUAzOjGrFEIPJOpplTX7OFObCqA8s6NNdo9q88o
        GpFQOBASaibhlqxvtWTqsxwFQ4Y0ykqxnIq0ywaBcA==
X-Google-Smtp-Source: ABdhPJzilurZFgAA0q/w0n5m9qwKOlM1sQsd63Q4vtYjzflRAY2Iphk2VNThEKIglY6Fs7qOdfpk5S0LA95FViC97Dk=
X-Received: by 2002:a92:cd8b:: with SMTP id r11mr21256766ilb.39.1639171805869;
 Fri, 10 Dec 2021 13:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com> <20211123051658.3195589-6-pcc@google.com>
 <CACT4Y+YTEeuhus8py=nDbs2XxmpPU5Ak4mhjydrBPRv+L2dH4A@mail.gmail.com>
In-Reply-To: <CACT4Y+YTEeuhus8py=nDbs2XxmpPU5Ak4mhjydrBPRv+L2dH4A@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 10 Dec 2021 13:29:54 -0800
Message-ID: <CAMn1gO4oU8cRiJyRcsy-s-PNZeRjnT=j0VTTSanOjV-+1m=fJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Documentation: document uaccess logging
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 23 Nov 2021 at 06:17, Peter Collingbourne <pcc@google.com> wrote:
> >
> > Add documentation for the uaccess logging feature.
> >
> > Link: https://linux-review.googlesource.com/id/Ia626c0ca91bc0a3d8067d7f28406aa40693b65a2
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> >  Documentation/admin-guide/index.rst           |   1 +
> >  Documentation/admin-guide/uaccess-logging.rst | 149 ++++++++++++++++++
> >  2 files changed, 150 insertions(+)
> >  create mode 100644 Documentation/admin-guide/uaccess-logging.rst
> >
> > diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> > index 1bedab498104..4f6ee447ab2f 100644
> > --- a/Documentation/admin-guide/index.rst
> > +++ b/Documentation/admin-guide/index.rst
> > @@ -54,6 +54,7 @@ ABI will be found here.
> >     :maxdepth: 1
> >
> >     sysfs-rules
> > +   uaccess-logging
> >
> >  The rest of this manual consists of various unordered guides on how to
> >  configure specific aspects of kernel behavior to your liking.
> > diff --git a/Documentation/admin-guide/uaccess-logging.rst b/Documentation/admin-guide/uaccess-logging.rst
> > new file mode 100644
> > index 000000000000..4b2b297afc00
> > --- /dev/null
> > +++ b/Documentation/admin-guide/uaccess-logging.rst
> > @@ -0,0 +1,149 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Uaccess Logging
> > +===============
> > +
> > +Background
> > +----------
> > +
> > +Userspace tools such as sanitizers (ASan, MSan, HWASan) and tools
> > +making use of the ARM Memory Tagging Extension (MTE) need to
> > +monitor all memory accesses in a program so that they can detect
> > +memory errors. Furthermore, fuzzing tools such as syzkaller need to
> > +monitor all memory accesses so that they know which parts of memory
> > +to fuzz. For accesses made purely in userspace, this is achieved
> > +via compiler instrumentation, or for MTE, via direct hardware
> > +support. However, accesses made by the kernel on behalf of the user
> > +program via syscalls (i.e. uaccesses) are normally invisible to
> > +these tools.
> > +
> > +Traditionally, the sanitizers have handled this by interposing the libc
> > +syscall stubs with a wrapper that checks the memory based on what we
> > +believe the uaccesses will be. However, this creates a maintenance
> > +burden: each syscall must be annotated with its uaccesses in order
> > +to be recognized by the sanitizer, and these annotations must be
> > +continuously updated as the kernel changes.
> > +
> > +The kernel's uaccess logging feature provides userspace tools with
> > +the address and size of each userspace access, thereby allowing these
> > +tools to report memory errors involving these accesses without needing
> > +annotations for every syscall.
> > +
> > +By relying on the kernel's actual uaccesses, rather than a
> > +reimplementation of them, the userspace memory safety tools may
> > +play a dual role of verifying the validity of kernel accesses. Even
> > +a sanitizer whose syscall wrappers have complete knowledge of the
> > +kernel's intended API may vary from the kernel's actual uaccesses due
> > +to kernel bugs. A sanitizer with knowledge of the kernel's actual
> > +uaccesses may produce more accurate error reports that reveal such
> > +bugs. For example, a kernel that accesses more memory than expected
> > +by the userspace program could indicate that either userspace or the
> > +kernel has the wrong idea about which kernel functionality is being
> > +requested -- either way, there is a bug.
> > +
> > +Interface
> > +---------
> > +
> > +The feature may be used via the following prctl:
> > +
> > +.. code-block:: c
> > +
> > +  uint64_t addr = 0; /* Generally will be a TLS slot or equivalent */
> > +  prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &addr, 0, 0, 0);
> > +
> > +Supplying a non-zero address as the second argument to ``prctl``
>
> Is it possible to unregister it? Is it what happens when 0 is passed
> as addr? If so, please describe.
> It may be handy to do one-off tracing with the address on stack.

Yes, done in v3.

> > +will cause the kernel to read an address (referred to as the *uaccess
> > +descriptor address*) from that address on each kernel entry.
> > +
> > +When entering the kernel with a non-zero uaccess descriptor address
> > +to handle a syscall, the kernel will read a data structure of type
> > +``struct uaccess_descriptor`` from the uaccess descriptor address,
> > +which is defined as follows:
> > +
> > +.. code-block:: c
> > +
> > +  struct uaccess_descriptor {
> > +    uint64_t addr, size;
> > +  };
>
> Want to double check the extension story. If we ever want flags in
> uaccess_descriptor, we can add a flag to prctl that would say that
> address must point to uaccess_descriptor_v2 that contains flags,
> right?
> And similarly we can extend uaccess_buffer_entry, right?

Yes, we can specify a flag bit in e.g. the third argument to prctl,
which could switch us to using new struct definitions for the uaccess
descriptor and uaccess buffer entries.

> > +This data structure contains the address and size (in array elements)
> > +of a *uaccess buffer*, which is an array of data structures of type
> > +``struct uaccess_buffer_entry``. Before returning to userspace, the
> > +kernel will log information about uaccesses to sequential entries
> > +in the uaccess buffer. It will also store ``NULL`` to the uaccess
> > +descriptor address, and store the address and size of the unused
> > +portion of the uaccess buffer to the uaccess descriptor.
> > +
> > +The format of a uaccess buffer entry is defined as follows:
> > +
> > +.. code-block:: c
> > +
> > +  struct uaccess_buffer_entry {
> > +    uint64_t addr, size, flags;
> > +  };
> > +
> > +The meaning of ``addr`` and ``size`` should be obvious. On arm64,
>
> I would say explicitly "addr and size contain address and size of the
> user memory access".

Done in v3.

> > +tag bits are preserved in the ``addr`` field. There is currently
> > +one flag bit assignment for the ``flags`` field:
> > +
> > +.. code-block:: c
> > +
> > +  #define UACCESS_BUFFER_FLAG_WRITE 1
> > +
> > +This flag is set if the access was a write, or clear if it was a
> > +read. The meaning of all other flag bits is reserved.
> > +
> > +When entering the kernel with a non-zero uaccess descriptor
> > +address for a reason other than a syscall (for example, when
> > +IPI'd due to an incoming asynchronous signal), any signals other
> > +than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
> > +``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
> > +initialized with ``sigfillset(set)``. This is to prevent incoming
> > +signals from interfering with uaccess logging.
> > +
> > +Example
> > +-------
> > +
> > +Here is an example of a code snippet that will enumerate the accesses
> > +performed by a ``uname(2)`` syscall:
> > +
> > +.. code-block:: c
> > +
> > +  struct uaccess_buffer_entry entries[64];
> > +  struct uaccess_descriptor desc;
> > +  uint64_t desc_addr = 0;
> > +  prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &desc_addr, 0, 0, 0);
> > +
> > +  desc.addr = (uint64_t)&entries;
> > +  desc.size = 64;
> > +  desc_addr = (uint64_t)&desc;
>
> We don't need any additional compiler barriers here, right?
> It seems that we only need to prevent re-ordering of these writes with
> the next and previous syscalls, which the compiler should do already.

Right. From the compiler's perspective the address of desc_addr is
leaked at the prctl call site, so any external function call
(including syscalls) could read or write to it.

Peter
