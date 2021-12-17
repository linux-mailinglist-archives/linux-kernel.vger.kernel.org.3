Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6C47942D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhLQSmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:42:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhLQSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:42:20 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639766539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7s6+vDDrV2VKVYxq7RWzaMYfIJJiwG6U2vIbbBF9SM=;
        b=hk50wLhenhdS6JW3HQ56BocfuPWMrmaaAnjLQlaoRPFXLJGzWOfXuN2a/r+XgOxcvedqYV
        glsY77tjXnm0E7YWrtuEv8FID/YV+PcrARl668HMmZ0M/PwLbuySbyrgM92DxaE1UDQfxi
        i+EORnpufGkUYnRjWQUr7xbe7CygxYX44rCySOc2HsZP3Ism/4ZVy8vU8iZloFjHF3mfii
        CFGhkiHW6XZ4Vi1GGea+qx1KFwbt3QevN3hcWXJCSEju6cJlGZw6wEdT6H+3Jwnt1/Mu5T
        IWRCcVKWtohKJ3B7cjGxer09tB4b1k4OWC3TRuk2mg9uGWXk+zv7t7m4J7mUDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639766539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7s6+vDDrV2VKVYxq7RWzaMYfIJJiwG6U2vIbbBF9SM=;
        b=lsiOc4DFm9+HGQKXcGkg56hNqH0SKQBo/+Ce9mjsQmEygforgQBl3hlwVTaMxc0LBLJIGT
        DfPaUXrM9xrkTECQ==
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 4/7] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
In-Reply-To: <CAMn1gO7iaaXEgAt3kQVRSN3ueY7MPt0yww40ADAmUZLOb0ZwZg@mail.gmail.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <20211209221545.2333249-5-pcc@google.com> <87a6h7webt.ffs@tglx>
 <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
 <87a6h0lmxm.ffs@tglx>
 <CAMn1gO7iaaXEgAt3kQVRSN3ueY7MPt0yww40ADAmUZLOb0ZwZg@mail.gmail.com>
Date:   Fri, 17 Dec 2021 19:42:18 +0100
Message-ID: <875yrncbud.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Dec 16 2021 at 16:09, Peter Collingbourne wrote:
> userspace program sets addr to 0. Furthermore, a userspace program
> setting addr to 0 would not automatically cause the pending signals to
> be delivered (because simply storing a value to memory from userspace
> will not necessarily trigger a kernel entry), and signals could
> therefore be left blocked for longer than expected (at least until the
> next kernel entry).

Groan, so what you are trying to prevent is:

   *ptr = addr;

--> interrupt
       signal raised

    signal delivery

    signal handler
      syscall()   <- Logs this syscall
      sigreturn;

   syscall() <- Is not logged

I must have missed that detail in these novel sized comments all over
the place.

Yes, I can see how that pre/post muck solves this, but TBH while it is
admittedly a smart hack it's also a horrible hack.

There are a two aspects which I really dislike:

  - It's yet another ad hoc 'solution' to scratch 'my particular itch'

  - It's adding a horrorshow in the syscall hotpath. We have already
    enough gunk there. No need to add more.

The problem you are trying to solve is to instrument user accesses of
the kernel, which is special purpose tracing, right?

May I ask why this is not solvable via tracepoints?

  DECLARE_EVENT_CLASS(uaccess_class,....);
  DECLARE_EVENT(uaccess_class, uaccess_read,...);
  DECLARE_EVENT(uaccess_class, uaccess_write,...);

    trace_uaccess_read(from, n);

    trace_uaccess_write(to, n);

Tracepoints have filters, tooling, libraries etc. Zero code except for
the tracepoints themself. They are disabled by default with a static
key, which means very close to 0 overhead.

Aside of that such tracepoints can be used for other purposes as well
and are therefore not bound to 'my particular itch'.

There are obviously some questions to solve versus filtering, but even
with a stupid tid based filter, it's easy enough to filter out the stuff
you're interested in. E.g. to filter out the signal scenario above all
you need is to enable two more tracepoints:

   signal:signal_deliver
   syscalls:sys_enter_rt_sigreturn

and when analyzing the event stream you can just skip the noise between
signal:signal_deliver and syscalls:sys_enter_rt_sigreturn trace entries.

There are other fancies like BPF which can be used for filtering and
filling a map with entries.

The only downside is that system configuration restricts access and
requires certain priviledges. But is that a real problem for the purpose
at hand, sanitizers and validation tools?

I don't think it is, but you surely can provide more information here.

Thanks,

        tglx
