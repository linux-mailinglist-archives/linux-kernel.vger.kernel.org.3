Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140EF482CDC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiABV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiABV5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:57:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB61C061761;
        Sun,  2 Jan 2022 13:57:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bm14so129285208edb.5;
        Sun, 02 Jan 2022 13:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=VFkaUm4I8kYR4Xjd4zDIBygRM7dXVRDKeo92WqYc++M=;
        b=XYlQ94Ud4kWMsZfeqeZl533OvwixYoETJX8xYds2Ouj4Rsh+mi/5uEzuw/rXCn4niL
         dhQ9MdQyoecS0kAeMgQpGOqiEnNQBzrkzlfLLtvmoHWjBiamzQB4JX2BWo2u8SHDjgca
         lfxNGtAjLakekCfC+o7/mofXzMiOgz6S1nm7oI4lStIUTA8tflT5oenaGWlGQX1vs/TB
         EYARrlZhRdsG/byIaBDNTZlh99e5pCN/FpavVGOMbTOFviuY+D+BV9sIBCI5K5m7GjwB
         dpRg0WE9eYuCicU75S5Krw0WWAurNb0BZFkwh8bIWrQjNlaI6UGji4H9WZbR2OJva2BF
         BniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=VFkaUm4I8kYR4Xjd4zDIBygRM7dXVRDKeo92WqYc++M=;
        b=xIIGUB72LbHqCxi5a6EnI+5WTA0xNAlefmVRW+4J16VkP+0Acgv+BAfb1juPBnpi5f
         TQ7+ddhrGenvISRm5IUEd7CFJXslrohvGb3VIOuYAs8Dj/fReSxCtby3lwtKdmkIKZWn
         ZYWwWRNA5FrtOplclhg9hpUDH9ozO08ZDhkAaxP8zwD7AVnNg8omfQl5fpr/GltbmyDd
         1rMD26UDbs7YqlVz20KzSeP1kafhXGdKGNrB+VKGpZ4bpg3UZjvSrPWlV+nH8WSMhYp2
         AJFM6S8ucxQxLRneDx+i0Qlnk7ZXOPxHuKcKZAwNC775Sx1die1Tb5FkHZJakbB+S58Q
         MHoA==
X-Gm-Message-State: AOAM531Usuq8dZz0dBkwDFJMPtEW0Dm63S2mZmrgWd8Hh50GOITICBHB
        UJtgcAJ/2GQUvXB4iWaVia4Zhx9/U10=
X-Google-Smtp-Source: ABdhPJxSWPT3m0OsVPiSgOvtVwUnUgSrmFO9wIva2oDDisAXkw7Dp0GT8dL0xpO6M/6iSTC0DnrBtQ==
X-Received: by 2002:a05:6402:3593:: with SMTP id y19mr41498275edc.25.1641160659137;
        Sun, 02 Jan 2022 13:57:39 -0800 (PST)
Received: from gmail.com (0526F103.dsl.pool.telekom.hu. [5.38.241.3])
        by smtp.gmail.com with ESMTPSA id 14sm10127020ejk.215.2022.01.02.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 13:57:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 2 Jan 2022 22:57:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree -v1:
 Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm pleased to announce the first public version of my new "Fast Kernel 
Headers" project that I've been working on since late 2020, which is a 
comprehensive rework of the Linux kernel's header hierarchy & header 
dependencies, with the dual goals of:

 - speeding up the kernel build (both absolute and incremental build times)

 - decoupling subsystem type & API definitions from each other

The fast-headers tree consists of over 25 sub-trees internally, spanning 
over 2,200 commits, which can be found here:

   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master

As most kernel developers know, there's around ~10,000 main .h headers in 
the Linux kernel, in the include/ and arch/*/include/ hierarchies. Over the 
last 30+ years they have grown into a complicated & painful set of 
cross-dependencies we are affectionately calling 'Dependency Hell'.

Before going into details about how this tree solves 'dependency hell' 
exactly, here's the current kernel build performance gain with 
CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as 
well - see below), using a stock x86 Linux distribution's .config with all 
modules built into the vmlinux:

  #
  # Performance counter stats for 'make -j96 vmlinux' (3 runs):
  #
  # (Elapsed time in seconds):
  #

  v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
  -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement

Or in terms of CPU time utilized:

  v5.16-rc7:            11,474,982.05 msec cpu-clock   # 49.601 CPUs utilized
  -fast-headers-v1:      7,100,730.37 msec cpu-clock   # 54.635 CPUs utilized   # +61.6% improvement


The fast-headers tree offers a +50-80% improvement in absolute kernel build 
performance on supported architectures, depending on the config. This is a 
major step forward in terms of Linux kernel build efficiency & performance.

A justified question would be: why on Earth 2,200 commits??

Turns out it's not easy to reduce header dependencies, at all:

- When I started this project, late 2020, I expected there to be maybe 
  50-100 patches. I did a few crude measurements that suggested that about 
  20% build speed improvement could be gained by reducing header 
  dependencies, without having a substantial runtime effect on the kernel. 
  Seemed substantial enough to justify 50-100 commits.

- But as the number of patches increased, I saw only limited performance 
  increases. By mid-2021 I got to over 500 commits in this tree and had to 
  throw away my second attempt (!), the first two approaches simply didn't 
  scale, weren't maintainable and barely offered a 4% build speedup, not 
  worth the churn of 500 patches and not worth even announcing.

- With the third attempt I introduced the per_task() machinery which 
  brought the necessary flexibility to reduce dependencies drastically, and 
  it was a type-clean approach that improved maintainability. But even at 
  1,000 commits I barely got to a 10% build speed improvement. Again this 
  was not something I felt comfortable pushing upstream, or even 
  announcing. :-/

- But the numbers were pretty clear: 20% performance gains were very much 
  possible. So I kept developing this tree, and most of the speedups 
  started arriving after over 1,500 commits, in the fall of 2021. I was 
  very surprised when it went beyond 20% speedup and more, then arrived at 
  the current 78% with my reference config. There's a clear super-linear 
  improvement property of kernel build overhead, once the number of 
  dependencies is reduced to the bare minimum.

Incremental builds while doing kernel development benefit even more. Here's 
the performance improvement of incremental kernel builds if any of the 
headers used by one of the major subsystems is modified:

                                  | v5.16-rc7                      | -fast-headers-v1
                                  |--------------------------------|---------------------------------------
 'touch include/linux/sched.h'    | 230.30 secs | 15.6 builds/hour | 108.35 secs | 33.2 builds/hour | +112%
 'touch include/linux/mm.h'       | 216.57 secs | 16.6 builds/hour |  79.42 secs | 45.3 builds/hour | +173%
 'touch include/linux/fs.h'       | 223.58 secs | 16.1 builds/hour |  85.52 secs | 42.1 builds/hour | +161%
 'touch include/linux/device.h'   | 224.35 secs | 16.0 builds/hour |  97.09 secs | 37.1 builds/hour | +132%
 'touch include/net/sock.h'       | 105.85 secs | 34.0 builds/hour |  40.88 secs | 88.1 builds/hour | +159%

How does the fast-header tree achieve this reduction in build overhead? 
Mainly by drastically reducing the effective post-preprocessing effective 
size of key kernel headers:

    ------------------------------------------------------------------------------------------
    | Combined, preprocessed C code size of header, without line markers,
    | with comments stripped:
    ------------------------------.-----------------------------.-----------------------------
                                  | v5.16-rc7                   |  -fast-headers-v1
				  |-----------------------------|-----------------------------
     #include <linux/sched.h>     | LOC: 13,292 | headers:  324 |  LOC:    769 | headers:   64
     #include <linux/wait.h>      | LOC:  9,369 | headers:  235 |  LOC:    483 | headers:   46
     #include <linux/rcupdate.h>  | LOC:  8,975 | headers:  224 |  LOC:  1,385 | headers:   86
     #include <linux/hrtimer.h>   | LOC: 10,861 | headers:  265 |  LOC:    229 | headers:   37
     #include <linux/fs.h>        | LOC: 22,497 | headers:  427 |  LOC:  1,993 | headers:  120
     #include <linux/cred.h>      | LOC: 17,257 | headers:  368 |  LOC:  4,830 | headers:  129
     #include <linux/dcache.h>    | LOC: 10,545 | headers:  253 |  LOC:    858 | headers:   65
     #include <linux/cgroup.h>    | LOC: 33,518 | headers:  522 |  LOC:  2,477 | headers:  111
     #include <linux/module.h>    | LOC: 16,948 | headers:  339 |  LOC:  2,239 | headers:  122
     #include <linux/kobject.h>   | LOC: 15,210 | headers:  318 |  LOC:    799 | headers:   59
     #include <linux/device.h>    | LOC: 20,505 | headers:  408 |  LOC:  2,131 | headers:  123
     #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
     #include <linux/slab.h>      | LOC: 14,037 | headers:  307 |  LOC:    999 | headers:   74
     #include <linux/mm.h>        | LOC: 26,727 | headers:  453 |  LOC:  1,855 | headers:  133
     #include <linux/mmzone.h>    | LOC: 12,755 | headers:  293 |  LOC:    832 | headers:   64
     #include <linux/swap.h>      | LOC: 38,292 | headers:  559 |  LOC: 11,085 | headers:  294
     #include <linux/writeback.h> | LOC: 36,481 | headers:  550 |  LOC:  1,566 | headers:   92
     #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
     #include <linux/skbuff.h>    | LOC: 36,130 | headers:  558 |  LOC:  1,209 | headers:   89
     #include <linux/tcp.h>       | LOC: 60,133 | headers:  725 |  LOC:  3,829 | headers:  153
     #include <linux/udp.h>       | LOC: 59,411 | headers:  721 |  LOC:  3,236 | headers:  146
     #include <linux/filter.h>    | LOC: 54,172 | headers:  689 |  LOC:  4,087 | headers:   73
     #include <linux/interrupt.h> | LOC: 14,085 | headers:  340 |  LOC:  2,629 | headers:  124

     #include <net/sock.h>        | LOC: 58,880 | headers:  715 |  LOC:  1,543 | headers:   98

     #include <asm/processor.h>   | LOC:  7,821 | headers:  204 |  LOC:    618 | headers:   41
     #include <asm/page.h>        | LOC:  1,540 | headers:   97 |  LOC:  1,193 | headers:   82
     #include <asm/pgtable.h>     | LOC: 12,949 | headers:  297 |  LOC:  5,742 | headers:  217

  ( The column next to the Lines-Of-Code figure is the number of headers 
    included indirectly. )

As you can see it from the table, the size of the 'default' headers (which 
with the fast-headers tree will mostly include type definitions), has been 
reduced by 1-2 orders of magnitude. Much of the build speed improvement is 
due to these reductions.

For example, the preprocessed kernel/pid.c file explodes into over 94,000 
lines of code on the vanilla kernel:

  # v5.16-rc7:

  kepler:~/mingo.tip.git> make kernel/pid.i
  kepler:~/mingo.tip.git> wc -l kernel/pid.i
  94569 kernel/pid.i

The compiler has to go through those 95,000 lines of code - even if a lot 
of it is trivial fluff not actually used by kernel/pid.c.

With the fast-headers kernel that's down to ~36,000 lines of code, almost a 
factor of 3 reduction:

  # fast-headers-v1:
  kepler:~/mingo.tip.git> wc -l kernel/pid.i
  35941 kernel/pid.i

From the long preamble outlining the performance advantages dear readers 
probably guessed that there must be a downside - and indeed there is: in 
addition to the aforementioned 25 sub-trees and 2,200 commits, the 
fast-headers tree modifies over half of all kernel source files in 
existence:

    25,288 files changed, 178,024 insertions(+), 74,720 deletions(-)

Yeah, so this is probably the largest single feature announcement in LKML's 
history. Not by choice! :-/

For this reason this tree is an RFC announcement, and I'd like to gather 
feedback from fellow maintainers about the structure of tree(s) before 
pushing for an upstream merge. See design details below.

Internally the fast-headers tree consists of over 25 sub-trees, where the 
subtrees are easy to see in git log --pretty=oneline, git shortlog and the 
'git rebase' todo file:

  pick 39075c3caa2f .————————————————————————————————————.
  pick 34a7790ad07f | Prepare ARM64 headers:             |
  pick 19168fb871fb |                                    |
  pick b53ea7db716d headers/prep: arm64: Move the ARCH_LOW_ADDRESS_LIMIT definition from <asm/processor.h> to <asm/dma.h>
  pick 29e114e5d9ba headers/prep: arm64/mm: Move the VM_DATA_DEFAULT_FLAGS definition from <asm/page.h> to <asm/mmu.h>
  pick 39fa734203a4 headers/prep: arm64/mm: Add <asm/page_types.h>
  pick 4ce75a05eeec headers/prep: arm64/mm: Move the THREAD_SIZE and THREAD_ALIGN definitions from <asm/memory.h> to <asm/thread_info.h>

[ Since the trees depend on each other and required frequent reworking,
  keeping them in separate trees didn't scale and I had to abandon that
  approach in mid-2020. The organizational markers/separators will
  obviously not be submitted upstream. ]

Techniques used by the fast-headers tree to reduce header size & dependencies:

 - Aggressive decoupling of high level headers from each other, starting
   with <linux/sched.h>. Since 'struct task_struct' is a union of many
   subsystems, there's a new "per_task" infrastructure modeled after the
   per_cpu framework, which creates fields in task_struct without having
   to modify sched.h or the 'struct task_struct' type:

            DECLARE_PER_TASK(type, name);
            ...
            per_task(current, name) = val;

   The per_task() facility then seamlessly creates an offset into the
   task_struct->per_task_area[] array, and uses the asm-offsets.h
   mechanism to create offsets into it early in the build.

   There's no runtime overhead disadvantage from using per_task() framework,
   the generated code is functionally equivalent to types embedded in
   task_struct.

 - Uninlining: there's a number of unnecessary inline functions that also
   couple otherwise unrelated headers to each other. The fast-headers tree
   contains over 100 uninlining commits.

 - Type & API header decoupling. This is one of the most effective techniques
   to reduce size - but it can rarely be done in a straightforward fashion,
   and has to be prepared by various decoupling measures, such as the moving
   of inline functions or the creation of new headers for less frequently used
   APIs and types.

 - "Make headers standalone": over 80 headers don't build standalone and
   depend on various accidental indirect dependencies they gain through
   other headers, especially once headers get their unnecessary dependencies
   removed. So there's over 80 commits changing these headers.

 - Automated dependency addition to .h and .c files. This is about 790 commits,
   which are strictly limited to trivial addition of header dependencies. These
   patches make indirect dependencies explicit, and thus prepare the tree for
   aggressive removal of cross-dependencies from headers.

 - "Optimizing headers": step by step removal of dependencies from headers. In
   addition to the per_task() facility, this process took the most effort - as
   each dependency has to be mapped out, reorganized, eliminated and tested.
   This part cannot be sanely automated IMO, because it's not just a mechanical
   removal of unnecessary dependencies, but that's OK, the modifications all make
   sense in isolation as well.

 - CONFIG_KALLSYMS_FAST=y is an objtool based uncompressed symbol table feature that avoids
   the usual triple-linking of the vmlinux object file - which is the primary bottleneck
   of incremental kernel builds. Since even with distro configs the kallsyms table is only a few
   dozen MB big, on the desktop systems of kernel developers the memory cost is acceptable.
   It's obviously not acceptable on embedded systems - but a compressed symbol table could
   be implemented based on this objtool feature in the future. This feature is only
   implemented on x86-64 for the moment.

 - For the 'reference' subsystem of the scheduler, I also improved build speed by
   consolidating .c files into roughly equal size build units. Instead of 20+
   separate .o's, there's now just 4 .o's being built. Obviously this approach
   does not scale to the over 30,000 .c files in the kernel, but I wanted to
   demonstrate it because optimizing at that level brings the next level of build
   performance, and it might be feasible for a handful of other core kernel subsystems.

 - ... and probably a few more things I forgot about. Please see the tree for the
   details - but obviously it's not sensible to expect people to review 2,200+
   commits.

Misc notes:

 - Supported architectures at the moment are:

     - ARM64  # build & boot tested
     - MIPS   # build        tested                             # 32-bit & 64-bit
     - Sparc  # build        tested                             # 32-bit & 64-bit
     - X86    # build & boot tested, my main desktop runs this  # 32-bit & 64-bit

   Other architectures don't even build, primarily due to the necessity to 
   port the per_task() infrastructure to them. Fixing that & making the 
   tree mergable will be my next focus, assuming there's broad consensus 
   about this approach.

 - As to testing & runtime behavior: while all of these patches are 
   intended to be bug-free, I did find a couple of semi-bugs in the kernel 
   where a specific order of headers guaranteed a particular code 
   generation outcome - and if that header order was disturbed, the kernel 
   would silently break and fail to boot ...

 - I've been dogfooding this tree for a year, and I have fixed all problems 
   I have encountered. YMMV, be careful in any case. I'm writing this email 
   from the latest fast-headers kernel.

 - Please note that the tree is RFC, and not all patches are fully refined.

 - As to other approaches attempted: I also tried enabling the kernel to 
   use pre-compiled headers (with GCC), which didn't bring a performance 
   improvement beyond a 1-2% for repeat builds. Plus during development 
   most of the precompiled headers are cache-cold in any case and need to 
   be generated by the compiler again and again.

 - As to maintenance overhead: it was surprisingly low overhead to keep 
   dependencies at a minimum across upstream kernel releases - there were 
   tyically just around ~5 dependency additions that need to be addressed. 
   This makes me hopeful that an optimal 'fast' state of header 
   dependencies can be maintained going forward - once the initial set of 
   fixes are in of course.

 - But I'd love to hear from Linus & Andrew and the other maintainers of 
   the biggest subsystems affected by these changes - is this approach 
   acceptable?

Anyway, all feedback is welcome, and I'll keep updating the tree at the URI 
above.

Also, Happy New Year to everyone! :-)

Thanks,

     Ingo

============================>

Abbreviated diffstat (full diffstat too large to post on LKML):

    25,288 files changed, 178,024 insertions(+), 74,720 deletions(-)

Shortlog:

  Ingo Molnar (2297):
      ⠀
      .————————————————————————————————————.
      | Uninline multi-use functions:      |
      |                                    |
      headers/uninline: Uninline audit_inode_child()
      headers/uninline: Uninline audit_get_loginuid() and audit_get_sessionid()
      headers/uninline: Uninline scheduler_ipi()
      headers/uninline: Uninline task_ppid_nr()
      headers/uninline: Uninline __cond_resched_rcu()
      headers/uninline: Uninline task_index_to_char()
      headers/uninline: Uninline sk_under_memory_pressure() and sk_page_frag()
      ⠀
      .————————————————————————————————————.
      | Misc preparatory patches:          |
      |                                    |
      headers/deps: Add initial new headers as identity mappings
      headers/deps: uapi/headers: Create usr/include/uapi symbolic link
      headers/prep: Add type pre-declarations to various headers
      headers/prep: x86/mm: Remove unnecessary #ifdef MODULE block from <asm/tlbflush.h>
      headers/prep: sched/headers: Add header guard to kernel/sched/sched.h
      headers/prep: sched/headers: Add header guard to <linux/sched/deadline.h>
      headers/prep: sched/headers: Add kernel/sched/sched.h dependencies
      headers/prep: Introduce the task_thread() accessor
      headers/prep: list.h: Introduce the list_for_each_reverse() method
      headers/prep: arm64/paravirt: Remove __init annotation from <asm/paravirt.h>
      x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>
      headers/prep: Avoid stack_canary_offset namespace collision
      x86/defconfig: Enable CONFIG_LOCALVERSION_AUTO=y in the defconfig
      ⠀
      .————————————————————————————————————.
      | Add dependencies to .h files:      |
      |                                    |
      headers/deps: Add header dependencies to .h files: <asm/cpufeature.h>
      headers/deps: Add header dependencies to .h files: <asm/signal.h>
      headers/deps: Add header dependencies to .h files: <linux/bug.h>
      headers/deps: Add header dependencies to .h files: <linux/cpumask_api.h>
      headers/deps: Add header dependencies to .h files: <linux/ipc.h>
      headers/deps: Add header dependencies to .h files: <linux/kernel.h>
      headers/deps: Add header dependencies to .h files: <linux/ktime.h>
      headers/deps: Add header dependencies to .h files: <linux/pid.h>
      headers/deps: Add header dependencies to .h files: <linux/preempt.h>
      headers/deps: Add header dependencies to .h files: <linux/resource.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/affinity.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/cond_resched.h>
      headers/deps: Add header dependencies to .h files: <linux/seqlock.h>
      headers/deps: Add header dependencies to .h files: <linux/signal_types.h>
      headers/deps: Add header dependencies to .h files: <linux/spinlock_api.h>
      headers/deps: Add header dependencies to .h files: <linux/timer.h>
      headers/deps: Add header dependencies to .h files: <linux/wait.h>
      headers/deps: Add header dependencies to .h files: <linux/workqueue.h>
      headers/deps: Add header dependencies to .h files: <net/sock.h>
      ⠀
      .————————————————————————————————————.
      | Add dependencies to .c files:      |
      |                                    |
      headers/deps: Add header dependencies to .c files: <asm/cpumask.h>
      headers/deps: Add header dependencies to .c files: <asm/msr.h>
      headers/deps: Add header dependencies to .c files: <asm/pgalloc.h>
      headers/deps: Add header dependencies to .c files: <asm/unistd.h>
      headers/deps: Add header dependencies to .c files: <linux/bug.h>
      headers/deps: Add header dependencies to .c files: <linux/hrtimer.h>
      headers/deps: Add header dependencies to .c files: <linux/ipc.h>
      headers/deps: Add header dependencies to .c files: <linux/kernel.h>
      headers/deps: Add header dependencies to .c files: <linux/limits.h>
      headers/deps: Add header dependencies to .c files: <linux/plist.h>
      headers/deps: Add header dependencies to .c files: <linux/rculist.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/affinity.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/cond_resched.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/cputime.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/task_flags.h>
      headers/deps: Add header dependencies to .c files: <linux/shm.h>
      headers/deps: Add header dependencies to .c files: <linux/string.h>
      headers/deps: Add header dependencies to .c files: <linux/vtime.h>
      ⠀
      .————————————————————————————————————.
      | Add per-task infrastructure:       |
      |                                    |
      headers/prep: Rename header: <asm/pgtable-types.h> => <asm/pgtable_types.h>
      headers/prep: Rename constants: ARM64 ASM offset definitions
      headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
      headers/deps: x86/fpu: Make task_struct::thread constant size
      headers/deps: Spread out the TASK_SIZE_OF() default to individual <asm/processor.h> files
      headers/deps: rbtrees: Split more types out into <linux/rbtree_types.h>
      headers/deps: pid: Move PID type definitions to <linux/pid_types.h>
      headers/deps: seccomp: Split out <linux/seccomp_types.h>
      headers/deps: Move rseq APIs to <linux/sched/rseq_api.h>
      headers/deps: Remove the <linux/hrtimer.h> dependency from <linux/sched.h>
      headers/deps: timers/posix-timers: Move posix_cputimers fields to the per_task API
      headers/deps: sched/deadline: Move task->dl to per_task
      headers/deps: sched/deadline: Move 'struct sched_dl_entity' definition from <linux/sched.h> to <linux/sched/deadline.h>
      headers/deps: Remove <linux/posix-timers.h> from <linux/sched.h>
      headers/deps: Remove <linux/rcupdate.h> dependency from <linux/sched.h>
      headers/deps: ipc: Move the 'struct semid_ds' definition to the C code that uses it
      headers/deps: ipc/shm: Move the 'struct shmid_ds' definition to ipc/shm.c
      headers/deps: ipc/sem: Move thread_struct::sysvsem to per_task()
      headers/deps: ipc/shm: Move thread_struct::sysvshm to per_task()
      headers/deps: Remove <linux/sem.h> from <linux/sched.h>
      headers/deps: Remove <linux/shm.h> from <linux/sched.h>
      headers/deps: Factor out the conditional rescheduling APIs into <linux/sched/cond_resched.h>
      headers/deps: rcu: Move cond_resched_tasks_rcu_qs() from <linux/rcupdate.h> into <linux/sched/cond_resched.h>
      headers/deps: cpusets: Move task_struct::mems_allowed to per_task()
      headers/deps: Move task_struct::vtime to per_task()
      headers/deps: cpusets: Move task_struct::mems_allowed_seq to per_task()
      headers/deps: cpusets: Move task_struct::cpuset_mem_spread_rotor to per_task()
      headers/deps: cpusets: Move task_struct::cpuset_slab_spread_rotor to per_task()
      headers/deps: Move thread_info APIs to <linux/sched/thread_info_api.h>
      headers/deps: kernel: Split <linux/restart_block.h> into <linux/restart_block_types.h> and <linux/restart_block_api.h>
      sched/headers: Add compatibility bridge for the thread_info cleanups
      headers/deps: Remove <linux/restart_block.h> dependency from <linux/thread_info.h>
      headers/deps: Remove <linux/restart_block.h> dependency from <linux/thread_info.h>
      headers/deps: arm64: Don't include headers from <asm/pointer_auth.h> if !CONFIG_ARM64_PTR_AUTH
      headers/deps: arm64: Simplify <asm/percpu.h> dependencies
      headers/deps: arm64: Decouple <asm/processor.h> from test_thread_flag() facilities
      headers/deps: locking/lockdep: Optimize <linux/lockdep.h> dependencies
      headers/deps: percpu:: Optimize <linux/percpu.h> dependencies
      headers/deps: Use task_thread_info() primitives instead of open coding task->thread_info access
      headers/deps: Move task->thread_info to per_task()
      headers/deps: Half-automated conversion of task->thread accessors to task_thread()
      headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field
      headers/deps: arm64/mm: Move the arch_faults_on_old_pte(), arch_wants_old_prefaulted_pte() and arch_filter_pgprot() inlines to <asm/pgalloc.h>
      headers/deps: timers/posix-timers: Move <linux/sched/posix-timers.h> fields to <linux/posix-timers.h>
      headers/deps: sched/core: Move task_struct::on_rq to a per_task field
      headers/deps: sched/rt: Move task_struct::rt to per_task()
      headers/deps: sched/core: Move task_struct::sched_class to per_task()
      headers/deps: Move per_task::dl declaration from <linux/sched/deadline.h> to kernel/sched/sched.h
      headers/deps: Move task_struct::se to per_task()
      headers/deps: Move task_struct::stack to per_task()
      headers/deps: Move task_struct::usage to per_task()
      headers/deps: Move task_struct::stack_refcount to per_task()
      headers/deps: Move task_struct::stack_vm_area to per_task()
      headers/deps: Move task_on_another_cpu() from unwind.h to <linux/sched/task.h>
      headers/deps: Move task_struct::on_cpu to per_task()
      headers/deps: Move task_struct::wake_entry to per_task()
      headers/deps: Move task_struct::wakee_flips to per_task()
      headers/deps: Move task_struct::wakee_flip_decay_ts to per_task()
      headers/deps: Move task_struct::last_wakee to per_task()
      headers/deps: Move task_struct::recent_used_cpu to per_task()
      headers/deps: Move task_struct::wake_cpu to per_task()
      headers/deps: Move task_struct::sched_task_group to per_task()
      headers/deps: Move task_struct::core_node to per_task()
      headers/deps: Move task_struct::core_cookie to per_task()
      headers/deps: Move task_struct::core_occupation to per_task()
      headers/deps: Move task_struct::uclamp_req[] to per_task()
      headers/deps: Move task_struct::uclamp[] to per_task()
      headers/deps: Move task_struct::preempt_notifiers to per_task()
      headers/deps: Move task_struct::btrace_seq to per_task()
      headers/deps: rcu: Move task_struct::rcu_tasks_nvcsw to per_task()
      headers/deps: rcu: Move task_struct::rcu_tasks_holdout to per_task()
      headers/deps: rcu: Move task_struct::rcu_tasks_idx to per_task()
      headers/deps: rcu: Move task_struct::rcu_tasks_idle_cpu to per_task()
      headers/deps: rcu: Move task_struct::rcu_tasks_holdout_list to per_task()
      headers/deps: locking/futexes: Move task_struct::futex_exit_mutex to per_task()
      headers/deps: perf: Move task_struct::perf_event_ctxp[] to per_task()
      headers/deps: perf: Move task_struct::perf_event_mutex to per_task()
      headers/deps: perf: Move task_struct::perf_event_list to per_task()
      headers/deps: Move the 'def_root_domain' and 'sched_domains_mutex' declarations to <linux/sched/topology.h>
      headers/deps: locking/mutexes: Move task_struct::blocked_on to per_task()
      headers/deps: kprobes: Move task_struct::kretprobe_instances to per_task()
      headers/deps: plist: Move task_struct::pushable_tasks to per_task()
      headers/deps: signal: Move task_struct::restart_block to per_task()
      headers/deps: Move task_struct::sched_info to per_task()
      headers/deps: audit: Move task_struct::loginuid to per_task()
      headers/deps: sched/cputime: Move 'enum vtime_state' and 'struct vtime' to kernel/sched/sched.h
      headers/deps: Remove scheduler internal data types from <linux/sched.h>
      headers/deps: Move CPU affinity APIs from <linux/sched.h> to <linux/sched/affinity.h>
      headers/deps: Move more CPU affinity APIs from <linux/sched.h> to <linux/sched/affinity.h>
      headers/deps: sched/core: Move task_struct::cpus_ptr and user_cpus_ptr to per_task()
      headers/deps: sched/core: Move task_struct::cpus_mask to per_task()
      headers/deps: Move more CPU affinity APIs from <linux/sched.h> to <linux/sched/affinity.h>
      headers/deps: Move sched_trace_rd_span() from <linux/sched.h> to <linux/sched/topology.h>
      headers/deps: mm: Move task_struct::tlb_ubc to per_task()
      headers/deps: mm: Move task_struct::vmacache to per_task()
      headers/deps: mm: Move task_struct::rss_stat to per_task()
      headers/deps: net, mm: Move task_struct::task_frag to per_task()
      headers/deps: time: Move task_struct::tick_dep_mask to per_task()
      headers/deps: tracing: Move task_struct::trace_overrun to per_task()
      headers/deps: tracing: Move task_struct::tracing_graph_pause to per_task()
      headers/deps: seccomp: Move task_struct::seccomp to per_task()
      headers/deps: rcu: Move task_struct::rcu_users to per_task(), add <linux/rcu_internal.h>
      headers/deps: rcu: Move task_struct::rcu to per_task()
      headers/deps: signals: Move task_struct::blocked to per_task()
      headers/deps: signals: Move task_struct::real_blocked to per_task()
      headers/deps: signals: Move task_struct::saved_sigmask to per_task()
      headers/deps: signals: Move task_struct::pending to per_task()
      headers/deps: signals: Move task_struct::last_siginfo to per_task()
      headers/deps: Move task_struct::pushable_dl_tasks to per_task()
      headers/deps: locking/rtmutexes: Move task_struct::pi_waiters to per_task()
      headers/deps: Move task_struct::prev_cputime to per_task()
      headers/deps: Move 'struct prev_cputime' definition from <linux/sched.h> to <linux/sched/signal.h>
      headers/deps: Move task_struct::alloc_lock to per_task()
      headers/deps: Move the task_state_index definitions from <linux/sched.h> to <linux/sched/task.h>
      headers/deps: kcsan: Move task_struct::kcsan_ctx to per_task()
      headers/deps: kcsan: Move task_struct::kcsan_save_irqtrace to per_task()
      headers/deps: rseq: Move task_struct::rseq to per_task()
      headers/deps: Move task flag definitions & methods into <linux/sched/task_flags.h>
      headers/deps: mm: Move task_struct::kmap_ctrl to per_task()
      headers/deps: Add task_flags() accessor
      headers/deps: Automated conversion to task_flags() accessors
      headers/deps: Manual conversion to task_flags() accessors
      headers/deps: Move task_struct::flags to per_task()
      headers/deps: mm: Move task_struct::pagefault_disabled to per_task()
      ⠀
      .————————————————————————————————————.
      | Misc upstream preparatory fixes:   |
      |                                    |
      drm/vmwgfx: Always include the <drm/ttm/ttm_range_manager.h> header
      clocksource: Make CLOCKSOURCE_WATCHDOG configurable interactively
      headers/prep: pci: Fix header ordering bug
      headers/prep: drm/komeda: Move the <linux/seq_file.h> out from under the CONFIG_DEBUG_FS section
      headers/prep: net: Fix fs/compat_binfmt_elf.c vs. <linux/skbuff.h> type ordering assumption
      ⠀
      .————————————————————————————————————.
      | Standardize namespaces:            |
      |                                    |
      headers/prep: Rename header: <linux/fs_types.h> => <linux/fs_entry_types.h>
      headers/prep: Rename header: <linux/percpu-rwsem.h> => <linux/percpu_rwsem.h>
      headers/prep: Rename API: gfn_to_pfn() => xen_gfn_to_pfn()
      headers/prep: Rename API: pv_ops.mmu.set_fixmap() => __set_fixmap()
      headers/prep: Rename constants: SOCK_DESTROY => SOCK_DIAG_SOCK_DESTROY
      headers/prep: ecryptfs: Avoid PKT_TYPE_OFFSET namespace collision
      ⠀
      .————————————————————————————————————.
      | Add identity mappings:             |
      |                                    |
      headers/deps: Add initial new headers as identity mappings
      ⠀
      .————————————————————————————————————.
      | Standardize alignment attributes:  |
      |                                    |
      headers/prep: genirq: Move ____cacheline_internodealigned_in_smp attributes to before the structure definition
      headers/prep: net/xdp: Move the ____cacheline_aligned attribute to an easier to debug position
      ⠀
      .————————————————————————————————————.
      | Standardize headers:               |
      |                                    |
      headers/prep: Add <linux/types.h> inclusion for files with non-standard header sections
      headers/prep: headers: Fix pr_fmt() definitions
      headers/prep: Fix non-standard header section: drivers/scsi/pm8001/pm8001_hwi.c
      headers/prep: Fix non-standard header section: drivers/scsi/pm8001/pm80xx_hwi.c
      headers/prep: Fix non-standard header section: drivers/usb/host/ohci-tmio.c
      headers/prep: Fix non-standard header section: drivers/usb/cdns3/core.h
      headers/prep: Fix non-standard header section: drivers/staging/rtl8723bs/include/osdep_service_linux.h
      headers/prep: Fix non-standard header section: mm/slab.c
      headers/prep: Fix non-standard header section: drivers/phy/phy-can-transceiver.c
      headers/prep: Fix non-standard header section: drivers/crypto/ccree/cc_driver.h
      headers/prep: Fix non-standard header section: drivers/scsi/pm8001/pm8001_hwi.c
      headers/prep: Fix non-standard header section: arch/x86/xen/enlighten.c
      headers/prep: Fix non-standard header section: drivers/char/ipmi/ipmi_ssif.c
      headers/prep: Fix non-standard header section: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
      headers/prep: Fix non-standard header section: drivers/gpu/drm/drm_vm.c
      headers/prep: Fix non-standard header section: drivers/net/ethernet/amazon/ena/ena_netdev.c
      headers/prep: Fix non-standard header section: fs/nfs/dns_resolve.c
      headers/prep: Fix non-standard header section: arch/x86/platform/intel-quark/imr*.c
      headers/prep: Fix non-standard header section: arch/arm64/include/asm/compat.h
      headers/prep: Fix non-standard header section: include/xen/xen.h
      ⠀
      .————————————————————————————————————.
      | Fix headers to build standalone:   |
      |                                    |
      headers/prep: Fix header to build standalone: <acpi/acpi_drivers.h>
      headers/prep: Fix header to build standalone: <asm-generic/bitops/find.h>
      headers/prep: Fix header to build standalone: <drm/drm_legacy.h>
      headers/prep: Fix header to build standalone: <drm/drm_property.h>
      headers/prep: Fix header to build standalone: <linux/atmdev.h>
      headers/prep: Fix header to build standalone: <linux/bit_spinlock.h>
      headers/prep: Fix header to build standalone: <linux/delayed_call.h>
      headers/prep: Fix header to build standalone: <linux/dynamic_queue_limits.h>
      headers/prep: Fix header to build standalone: <linux/eventpoll.h>
      headers/prep: Fix header to build standalone: <linux/fs_entry_types.h>
      headers/prep: Fix header to build standalone: <linux/huge_mm.h>
      headers/prep: Fix header to build standalone: <linux/irqdesc.h>
      headers/prep: Fix header to build standalone: <linux/kdev_t.h>
      headers/prep: Fix header to build standalone: <linux/mpage.h>
      headers/prep: Fix header to build standalone: <linux/nfs_fs_i.h>
      headers/prep: Fix header to build standalone: <linux/pci-dma-compat.h>
      headers/prep: Fix header to build standalone: <linux/pipe_fs_i.h>
      headers/prep: Fix header to build standalone: <linux/prandom.h>
      headers/prep: Fix header to build standalone: <linux/reboot.h>
      headers/prep: Fix header to build standalone: <linux/resctrl.h>
      headers/prep: Fix header to build standalone: <linux/seccomp.h>
      headers/prep: Fix header to build standalone: <linux/shm.h>
      headers/prep: Fix header to build standalone: <linux/srcutiny.h>
      headers/prep: Fix header to build standalone: <linux/timekeeping.h>
      headers/prep: Fix header to build standalone: <linux/watchdog.h>
      headers/prep: Fix header to build standalone: <net/dcbnl.h>
      headers/prep: Fix header to build standalone: <net/dn_route.h>
      headers/prep: Fix header to build standalone: <net/ip6_fib.h>
      headers/prep: Fix header to build standalone: x86: <asm/atomic64_64.h>
      headers/prep: Fix header to build standalone: x86: <asm/fpu/types.h>
      headers/prep: Fix header to build standalone: x86: <asm/frame.h>
      headers/prep: Fix header to build standalone: x86: <asm/irq.h>
      headers/prep: Fix header to build standalone: x86: <asm/jump_label.h>
      headers/prep: Fix header to build standalone: x86: <asm/qspinlock.h>
      headers/prep: Fix header to build standalone: x86: <asm/qwrlock.h>
      headers/prep: Fix header to build standalone: x86: <asm/tlb.h>
      headers/prep: Fix header to build standalone: drivers/net/wireguard/ratelimiter.h
      headers/prep: Fix header to build standalone: sparc: <asm/processor.h>
      headers/prep: Fix header to build standalone: sparc: <asm/mman.h>
      headers/prep: Fix header to build standalone: sparc: <asm/compat.h>
      headers/prep: Fix header to build standalone: <linux/of_pdt.h>
      headers/prep: Fix header to build standalone: sparc: <asm/smp_64.h>
      headers/prep: Fix header to build standalone: <video/da8xx-fb.h>
      headers/prep: Fix header to build standalone: <uapi/linux/fb.h>
      headers/prep: Fix header to build standalone: sparc, <asm/pgtable_64.h>
      headers/prep: Fix header to build standalone: sparc, <asm/page_32.h>
      headers/prep: Fix header to build standalone: sparc, <asm/pgtable_32.h>
      headers/prep: Fix header to build standalone: <asm-generic/tlb.h>
      headers/prep: Fix header to build standalone: sparc, <asm/leon.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/cmpxchg.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/page.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/pgtable.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/smp.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/thread_info.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/watch.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/fpu.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/cpu-type.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/mipsmtregs.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/irq.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/compat.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/processor.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/mach-loongson64/spaces.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/i8259.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/fb.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/mips-cps.h>
      headers/prep: Fix header to build standalone: x86: <asm/special_insns.h>
      headers/prep: Fix header to build standalone: <linux/sched_clock.h>
      headers/prep: Fix header to build standalone: x86: <asm/thermal.h>
      headers/prep: Fix header to build standalone: sparc: <asm/fb.h>
      headers/prep: Fix header to build standalone: sparc: <asm/pci.h>
      headers/prep: Fix header to build standalone: x86: <asm/compat.h>
      headers/prep: Fix header to build standalone: drivers/gpu/drm/vmwgfx/vmwgfx_mksstat.h
      headers/prep: Fix header to build standalone: MIPS: <asm/page.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/mipsregs.h>
      headers/prep: Fix header to build standalone: MIPS: <asm/mmu_context.h>
      headers/prep: Fix header to build standalone: <linux/nfs_page.h>
      headers/prep: Fix header to build standalone: x86: <asm/ftrace.h>
      ⠀
      .————————————————————————————————————.
      | Fix header guards:                 |
      |                                    |
      headers/prep: sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
      headers/prep: sched/headers: Add header guard to <linux/task_io_account.h>
      headers/prep: list_lru: Use standard header guards
      ⠀
      .————————————————————————————————————.
      | Relax header protections:          |
      |                                    |
      headers/prep: bitops: Remove inclusion guard from <asm/bitops.h>
      headers/prep: PM / wakeup: Remove inclusion protection, make header build standalone
      ⠀
      .————————————————————————————————————.
      | Cleanups:                          |
      |                                    |
      headers/prep: x86/relocs: Bring the reloc*.c code up to modern kernel standards
      headers/prep: x86/relocs: Pass in file name from command line
      headers/prep: x86/relocs: Add struct section::idx
      headers/prep: x86/relocs: Improve symbol warning messages
      headers/prep: time: Clean up <linux/time.h>
      ⠀
      .————————————————————————————————————.
      | Prepare ARM64 headers:             |
      |                                    |
      headers/prep: arm64: Move the ARCH_LOW_ADDRESS_LIMIT definition from <asm/processor.h> to <asm/dma.h>
      headers/prep: arm64/mm: Move the VM_DATA_DEFAULT_FLAGS definition from <asm/page.h> to <asm/mmu.h>
      headers/prep: arm64/mm: Add <asm/page_types.h>
      headers/prep: arm64/mm: Move the THREAD_SIZE and THREAD_ALIGN definitions from <asm/memory.h> to <asm/thread_info.h>
      ⠀
      .————————————————————————————————————.
      | Uninline single-use functions:     |
      |                                    |
      headers/uninline: Uninline single-use function: wb_find_current() and wb_get_create_current()
      headers/uninline: Uninline single-use function: sk_under_cgroup_hierarchy()
      headers/uninline: Uninline single-use function: itimerspec64_valid()
      headers/uninline: Uninline single-use function: ptrace_event_pid()
      headers/uninline: Uninline single-use function: ep_take_care_of_epollwakeup()
      headers/uninline: Uninline single-use function: proc_sys_poll_event()
      headers/uninline: Uninline single-use function: syscall_tracepoint_update()
      headers/uninline: Uninline single-use function: skb_propagate_pfmemalloc()
      headers/uninline: Uninline single-use function: reqsk_alloc()
      headers/uninline: Uninline single-use function: flow_dissector_init_keys()
      headers/uninline: Uninline single-use function: xfrm_dev_state_free()
      headers/uninline: Uninline single-use function: kobject_has_children()
      headers/uninline: Uninline single-use function: dev_validate_header()
      headers/uninline: Uninline single-use function: qdisc_run()
      headers/uninline: Uninline single-use function: SPI_STATISTICS_ADD_*()
      headers/uninline: Uninline single-use function: for_each_netdev_feature()
      headers/uninline: Uninline single-use function: skb_metadata_differs()
      headers/uninline: Uninline single-use function: wb_domain_size_changed()
      headers/uninline: Uninline single-use function: cpupid_to_nid()
      headers/uninline: Uninline single-use function: set_page_links()
      headers/uninline: Uninline single-use function: mips: page_size_ftlb()
      ⠀
      .————————————————————————————————————.
      | Uninline multi-use functions:      |
      |                                    |
      headers/uninline: Uninline multi-use function: seq_escape_str()
      headers/uninline: Uninline multi-use function: rb_link_node() and rb_link_node_rcu()
      headers/uninline: Uninline multi-use function: hypervisor_cpuid_base()
      headers/uninline: Uninline multi-use function: ratelimit_state_init() and ratelimit_state_exit()
      headers/uninline: Uninline multi-use function: mmap_is_ia32()
      headers/uninline: Uninline multi-use function: em_cpu_energy()
      headers/uninline: Uninline multi-use functions: *kmap*() APIs
      headers/uninline: Uninline multi-use function: vma_is_foreign()
      headers/uninline: Uninline multi-use function: finish_rcuwait()
      headers/uninline: Uninline multi-use function: task_nice_ioclass(), task_nice_ioprio() and get_current_ioprio()
      headers/uninline: Uninline multi-use function: mapped_fsuid() and mapped_fsgid()
      headers/uninline: Uninline multi-use function: scm_send()
      headers/uninline: Uninline multi-use function: trace_test_and_set_recursion() and trace_clear_recursion()
      headers/uninline: Uninline multi-use function: Uninline scm_recv()
      headers/uninline: Uninline multi-use function: bpf_jit_dump()
      headers/uninline: Uninline multi-use function: arch_trace_is_compat_syscall()
      headers/uninline: Uninline multi-use function: elf_core_*() methods
      headers/uninline: Uninline multi-use function: in_x32_syscall() and in_32bit_syscall()
      headers/uninline: Uninline multi-use function: mem_cgroup_swappiness()
      headers/uninline: Uninline multi-use function: blk_wake_io_task() and blk_needs_flush_plug()
      headers/uninline: Uninline multi-use function: io_mapping_map_atomic_wc() and io_mapping_unmap_atomic()
      headers/uninline: Uninline multi-use function: init_sync_kiocb() and kiocb_clone()
      headers/uninline: Uninline multi-use function: vma_is_dax() and vma_is_fsdax()
      headers/uninline: Uninline multi-use function: eventpoll_release()
      headers/uninline: Uninline multi-use function: __transparent_hugepage_enabled()
      headers/uninline: Uninline multi-use function: bio_set_polled()
      headers/uninline: Uninline multi-use function: put_compat_sigset()
      headers/uninline: Uninline multi-use function: seq_user_ns()
      headers/uninline: Uninline multi-use function: sock_graft()
      headers/uninline: Uninline multi-use function: sk_user_ns()
      headers/uninline: Uninline multi-use function: sock_poll_wait()
      headers/uninline: Uninline multi-use function: sk_dev_equal_l3scope()
      headers/uninline: Uninline multi-use function: bvec_advance()
      headers/uninline: Uninline multi-use function: skb_get_hash_flowi6()
      headers/uninline: Uninline multi-use function: dma_resv_get_excl_unlocked()
      headers/uninline: Uninline multi-use function: drm_syncobj_fence_get()
      headers/uninline: Uninline multi-use function: ttm_resource_manager_cleanup()
      headers/uninline: Uninline multi-use function: dqstats_inc() and dqstats_dec()
      headers/uninline: Uninline multi-use function: inet_csk_prepare_for_destroy_sock()
      headers/uninline: Uninline multi-use function: ptrace_event()
      headers/uninline: Uninline multi-use function: inode_cgwb_enabled()
      headers/uninline: Uninline multi-use function: tcp_under_memory_pressure()
      headers/uninline: Uninline multi-use function: net_generic()
      headers/uninline: Uninline multi-use function: d_lookup_done() and dont_mount()
      headers/uninline: Uninline multi-use function: parent_ino()
      headers/uninline: Uninline multi-use function: get_debugctlmsr() and update_debugctlmsr()
      headers/uninline: Uninline multi-use function: dma_map_single_attrs()
      headers/uninline: Uninline multi-use function: dma_alloc_noncoherent() and dma_free_noncoherent()
      headers/uninline: Uninline multi-use function: skb_copy_to_page_nocache()
      headers/uninline: Uninline multi-use function: scsi_device_reprobe()
      headers/uninline: Uninline multi-use function: inet_csk_reset_xmit_timer()
      headers/uninline: Uninline multi-use function: ip6_dst_store()
      headers/uninline: Uninline multi-use function: __skb_fill_page_desc()
      headers/uninline: Uninline multi-use function: dev_page_is_reusable()
      headers/uninline: Uninline multi-use function: __reqsk_free()
      headers/uninline: Uninline multi-use function: reqsk_queue_remove()
      headers/uninline: Uninline multi-use function: get_rtconn_flags() and get_rttos()
      headers/uninline: Uninline multi-use function: __inet_lookup_skb()
      headers/uninline: Uninline multi-use function: acpi_alloc_fwnode_static() and acpi_free_fwnode_static()
      headers/uninline: Uninline multi-use function: mm_init_cpumask()
      headers/uninline: Uninline multi-use function: rwsem_is_locked()
      headers/uninline: Uninline multi-use function: rwsem_is_contended()
      headers/uninline: Uninline multi-use function: napi_synchronize()
      headers/uninline: Uninline multi-use function: tcf_exts_stats_update() and tcf_exts_exec()
      headers/uninline: Uninline multi-use function: tcf_change_indev()
      headers/uninline: Uninline multi-use function: kmalloc_large()
      headers/uninline: Uninline multi-use function: clone_pgd_range()
      headers/uninline: Uninline multi-use function: register_one_node()
      headers/uninline: Uninline multi-use function: free_reserved_page()
      headers/uninline: Uninline multi-use function: put_page()
      headers/uninline: Uninline multi-use function: kmap() & kunmap()
      headers/uninline: Uninline multi-use function: cgroup_throttle_swaprate(), mem_cgroup_try_charge_swap() and mem_cgroup_uncharge_swap()
      headers/uninline: Uninline multi-use function: bvec_virt()
      headers/uninline: Uninline multi-use function: get_io_context_active() & ioc_task_link()
      headers/uninline: Uninline multi-use function: mapping_set_error()
      ⠀
      .————————————————————————————————————.
      | Add non-standard dependencies:     |
      |                                    |
      .————————————————————————————————————.
      headers/prep: Add non-standard header dependencies to .h file: include/linux/perf_regs.h
      headers/prep: Add non-standard header dependencies to .h file: arch/arm64/include/asm/cpufeature.h
      headers/prep: Add non-standard header dependencies to .h file: arch/x86/include/asm/fixmap.h
      headers/prep: Add non-standard header dependencies to .c file: drivers/net/ethernet/fealnx.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/tty/serial/samsung_tty.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/gpu/drm/drm_cache.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/acpi/processor_perflib.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/input/gameport/gameport.c
      headers/prep: Add non-standard header dependencies to .c file: net/ceph/crush/mapper.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/pci/p2pdma.c
      headers/prep: Add non-standard header dependencies to .c file: drivers/net/ethernet/dec/tulip/winbond-840.c
      headers/prep: Add non-standard header dependencies to .c file: kernel/sysctl.c
      ⠀
      .————————————————————————————————————.
      | Misc preparatory patches:          |
      |                                    |
      .————————————————————————————————————.
      headers/prep: mm: Move the PAGE_FRAG_CACHE_MAX_ORDER definition from <linux/mm_types.h> to its only user
      headers/prep: kernel.h: Move READ/WRITE definitions to <linux/types.h>
      headers/prep: tools: Sync tools/arch/x86/lib/insn.c with arch/x86/lib/insn.c
      headers/prep: Add type pre-declarations to various headers
      headers/prep: Work around <linux/vmstat.h> header dependency bug temporarily
      headers/prep: usb: gadget: Fix namespace collision
      headers/prep: net: intel: igc_ptp: Fix implicit <asm/tsc.h> dependency
      headers/prep: bitops: Move the __sw_hweight*() prototypes to where they are used
      headers/prep: Fix Sparc <linux/of.h> inclusion quirk
      headers/prep: sparc: Introduce <asm/vdso/processor.h>
      headers/prep: sparc64: Move untagged_addr() from <asm/pgtable_64.h> to <asm/page_64.h>
      headers/prep: sparc/mm: Move the page address definitions from <asm/pgtable.h> side to <asm/page.h>
      headers/prep, iommu/sun50i: Avoid 'PT_SIZE' namespace collision by renaming it to 'IOMMU_PT_SIZE'
      headers/prep, drm/etnaviv: Avoid 'PT_SIZE' namespace collision by renaming it to 'IOMMU_PT_SIZE'
      headers/prep: net: hdlc_ppp: Avoid 'struct proto' namespace collision
      headers/prep: net/mlx5: Avoid 'reclaim_pages()' namespace collision
      headers/prep: kprobes/test: Make it depend on CONFIG_STACKTRACE
      headers/prep: drm/i915: Standardize & fix header inclusion relative paths
      headers/prep: x86/kbuild: Add symbol prototype header dependencies for modversions
      headers/deps: arm64: Add <linux/sched/thread_info_api.h> dependency to <asm/preempt.h>
      headers/prep: MIPS: Split <asm/pgtable_types.h> out of <asm/pgtables.h>
      headers/prep: MIPS: Move simple types from <asm/page.h> to <asm/page_types.h>
      headers/prep: MIPS: Define current_thread_info
      headers/prep: MIPS: Prepare <asm/mmu.h> for a broader role
      headers/prep: MIPS: Move the VM_DATA_DEFAULT_FLAGS definition from <asm/page.h> to <asm/page_types.h>
      headers/prep: MIPS: Split <asm/ptrace_types.h> out of <asm/ptrace.h>
      headers/prep: MIPS: Add new header dependencies to the arch/mips/vdso/vdso-image.c generation code
      headers/prep: MIPS: Move the __va()/__pa() definitions from <asm/page.h> to <asm/page_types.h>
      headers/prep: MIPS: Remove the <asm/io.h> and <asm/page.h> circular dependency
      headers/prep: MIPS: Simplify <asm/elf.h> dependencies
      headers/prep: MIPS: Move more pgtable types into <asm/pgtable_types.h>
      headers/prep: MIPS: Don't build methods relying on SECTIONS_* et al
      ⠀
      .————————————————————————————————————.
      | Optimize headers:                  |
      |                                    |
      headers/deps: rbtree: Remove <linux/rcupdate.h> from <linux/rbtree.h>
      headers/deps: Remove <linux/resource.h> from <linux/sched.h>
      headers/deps: Remove <linux/seqlock.h> from <linux/sched.h>
      headers/deps: Remove <linux/thread_info.h> dependencies from a number of headers
      headers/deps: Remove <linux/thread_info.h> dependency from <linux/smp.h>
      headers/deps: Remove <linux/irqflags.h> from <linux/sched.h>
      headers/deps: perf: Move the 'enum perf_event_task_context' from <linux/sched.h> to <linux/perf_events.h>
      headers/deps: Remove <linux/mutex.h> from <linux/sched.h>
      headers/deps: Remove <linux/plist.h> from <linux/sched.h>
      headers/deps: Remove <linux/restart_block_types.h> from <linux/sched.h>
      headers/deps: x86/msr: Remove <linux/cpumask.h> inclusion from <asm/msr.h>
      headers/deps: mm: Remove <linux/cpumask.h> dependency from <linux/mm_types_task.h>
      headers/deps: net, mm: Move 'struct page_frag' definition from <linux/mm_types_task.h> to <net/sock.h>
      headers/deps: Remove <linux/mm_types_task.h> from <linux/sched.h>
      headers/deps: Remove the <linux/seccomp_types.h> inclusion from <linux/sched.h>
      headers/deps: Remove <linux/refcount.h> from <linux/sched.h>
      headers/deps: Remove the <linux/signal_types.h> dependency from <linux/sched.h>
      headers/deps: Remove <linux/nodemask.h> from <linux/sched.h>
      headers/deps: Remove <linux/kcsan.h> include from <linux/sched.h>
      headers/deps: Remove the <linux/rseq.h> dependency from <linux/sched.h>
      headers/deps: Remove the <linux/vtime.h> dependency from <linux/hardirq.h>
      headers/deps: Remove the <asm/kmap_size.h> dependency from <linux/sched.h>
      headers/deps: Move the account_*() methods from <linux/kernel_stat.h> to <linux/sched/cputime.h>
      headers/deps: Remove <linux/vtime.h> dependency from <linux/kernel_stat.h>
      headers/deps: Move the sched_core_*() methods to <linux/sched/topology.h>
      headers/deps: Move the sched_trace_*() methods to the internal header
      headers/deps: Move sched_cpu_util() from <linux/sched.h> to <linux/sched/cpufreq.h>
      headers/deps: Optimize <linux/sched.h> dependencies, remove <linux/sched/thread_info_api_lowlevel.h> inclusion
      headers/deps: Optimize <linux/sched.h> dependencies, remove <linux/sched/cond_resched.h> inclusion
      ⠀
      .————————————————————————————————————.
      | Implement CONFIG_KALLSYMS_FAST:    |
      |                                    |
      objtool/kallsyms: Add new section
      kbuild/linker: Gather all the __kallsyms sections into a single table
      objtool/kallsyms: Copy the symbol name and offset to the new __kallsyms ELF section
      objtool/kallsyms: Increase section size dynamically
      objtool/kallsyms: Use zero entry size for section
      objtool/kallsyms: Output variable length strings
      objtool/kallsyms: Add kallsyms_offsets[] table
      objtool/kallsyms: Change name to __kallsyms_strs
      objtool/kallsyms: Split out process_kallsyms_symbols()
      objtool/kallsyms: Add relocations
      objtool/kallsyms: Skip discarded sections
      kallsyms/objtool: Print out the new symbol table on the kernel side
      objtool/kallsyms: Use struct kallsyms_entry
      objtool/kallsyms, kallsyms/objtool: Share 'struct kallsyms_entry' definition
      kallsyms/objtool: Process entries
      objtool/kallsyms: Switch to 64-bit absolute relocations
      objtool/kallsyms: Fix initial offset
      kallsyms/objtool: Emit System.map-alike symbol list
      objtool/kallsyms: Skip undefined symbols
      objtool: Update the file even if there are no ORC symbols generated
      objtool/kallsyms: Update symbol filter
      objtool/kallsyms: Add the CONFIG_KALLSYMS_FAST Kconfig option & its related Kconfig switches
      kallsyms/objtool: Make the kallsyms work even if the generic tables are not there
      objtool/kallsyms, x86/relocs: Detect & ignore __kallsyms_offset section relocations
      kallsyms/objtool: Introduce linear table of symbol structures: kallsyms_syms[]
      kallsyms/objtool: Split fast vs. generic functions
      kallsyms/objtool: Sort symbols by address and deduplicate them
      kallsyms/objtool: Utilize the kallsyms_syms[] table in kallsyms_expand_symbol() and kallsyms_sym_address()
      kallsyms/objtool: Port kallsyms_relative_base functionality to the kallsyms_syms[] offsets
      ⠀
      .————————————————————————————————————.
      | Automated dependency additions:    |
      |                                    |
      headers/deps: Add header dependencies to .h files: <asm/alternative.h>
      headers/deps: Add header dependencies to .h files: <asm/barrier.h>
      headers/deps: Add header dependencies to .h files: <asm/byteorder.h>
      headers/deps: Add header dependencies to .h files: <asm/cacheflush.h>
      headers/deps: Add header dependencies to .h files: <asm/cpufeature.h>
      headers/deps: Add header dependencies to .h files: <asm/cpufeatures.h>
      headers/deps: Add header dependencies to .h files: <asm/current.h>
      headers/deps: Add header dependencies to .h files: <asm/fpu/types.h>
      headers/deps: Add header dependencies to .h files: <asm/io.h>
      headers/deps: Add header dependencies to .h files: <asm/kvm_arm.h>
      headers/deps: Add header dependencies to .h files: <asm/kvm_mmu.h>
      headers/deps: Add header dependencies to .h files: <asm/local_api.h>
      headers/deps: Add header dependencies to .h files: <asm/msr.h>
      headers/deps: Add header dependencies to .h files: <asm/page.h>
      headers/deps: Add header dependencies to .h files: <asm/param.h>
      headers/deps: Add header dependencies to .h files: <asm/paravirt.h>
      headers/deps: Add header dependencies to .h files: <asm/percpu.h>
      headers/deps: Add header dependencies to .h files: <asm/pgtable_api_access.h>
      headers/deps: Add header dependencies to .h files: <asm/pgtable.h>
      headers/deps: Add header dependencies to .h files: <asm/pgtable-prot.h>
      headers/deps: Add header dependencies to .h files: <asm/pgtable_types.h>
      headers/deps: Add header dependencies to .h files: <asm/processor_api.h>
      headers/deps: Add header dependencies to .h files: <asm/processor.h>
      headers/deps: Add header dependencies to .h files: <asm/processor_types.h>
      headers/deps: Add header dependencies to .h files: <asm/signal.h>
      headers/deps: Add header dependencies to .h files: <asm/special_insns.h>
      headers/deps: Add header dependencies to .h files: <asm/switch_to.h>
      headers/deps: Add header dependencies to .h files: <asm/uaccess.h>
      headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
      headers/deps: Add header dependencies to .h files: <linux/align.h>
      headers/deps: Add header dependencies to .h files: <linux/atomic_api.h>
      headers/deps: Add header dependencies to .h files: <linux/atomic.h>
      headers/deps: Add header dependencies to .h files: <linux/backing-dev-api.h>
      headers/deps: Add header dependencies to .h files: <linux/backing-dev-types.h>
      headers/deps: Add header dependencies to .h files: <linux/bitmap.h>
      headers/deps: Add header dependencies to .h files: <linux/bitops.h>
      headers/deps: Add header dependencies to .h files: <linux/bitops_types.h>
      headers/deps: Add header dependencies to .h files: <linux/bits.h>
      headers/deps: Add header dependencies to .h files: <linux/bpf.h>
      headers/deps: Add header dependencies to .h files: <linux/bug.h>
      headers/deps: Add header dependencies to .h files: <linux/build_bug.h>
      headers/deps: Add header dependencies to .h files: <linux/cache.h>
      headers/deps: Add header dependencies to .h files: <linux/capability.h>
      headers/deps: Add header dependencies to .h files: <linux/cgroup_api.h>
      headers/deps: Add header dependencies to .h files: <linux/compiler_attributes.h>
      headers/deps: Add header dependencies to .h files: <linux/compiler.h>
      headers/deps: Add header dependencies to .h files: <linux/completion.h>
      headers/deps: Add header dependencies to .h files: <linux/cpumask_api.h>
      headers/deps: Add header dependencies to .h files: <linux/cpumask.h>
      headers/deps: Add header dependencies to .h files: <linux/cpumask_types.h>
      headers/deps: Add header dependencies to .h files: <linux/cred.h>
      headers/deps: Add header dependencies to .h files: <linux/dcache.h>
      headers/deps: Add header dependencies to .h files: <linux/debugfs.h>
      headers/deps: Add header dependencies to .h files: <linux/debug_locks.h>
      headers/deps: Add header dependencies to .h files: <linux/debugobjects.h>
      headers/deps: Add header dependencies to .h files: <linux/delay.h>
      headers/deps: Add header dependencies to .h files: <linux/device_api.h>
      headers/deps: Add header dependencies to .h files: <linux/device_api_lock.h>
      headers/deps: Add header dependencies to .h files: <linux/device/bus.h>
      headers/deps: Add header dependencies to .h files: <linux/device/class.h>
      headers/deps: Add header dependencies to .h files: <linux/device/driver.h>
      headers/deps: Add header dependencies to .h files: <linux/device.h>
      headers/deps: Add header dependencies to .h files: <linux/device_types.h>
      headers/deps: Add header dependencies to .h files: <linux/dev_printk.h>
      headers/deps: Add header dependencies to .h files: <linux/dma-direction.h>
      headers/deps: Add header dependencies to .h files: <linux/dma-fence-api.h>
      headers/deps: Add header dependencies to .h files: <linux/dma-mapping.h>
      headers/deps: Add header dependencies to .h files: <linux/dma-resv.h>
      headers/deps: Add header dependencies to .h files: <linux/err.h>
      headers/deps: Add header dependencies to .h files: <linux/errno.h>
      headers/deps: Add header dependencies to .h files: <linux/error-injection.h>
      headers/deps: Add header dependencies to .h files: <linux/etherdevice_api_addr.h>
      headers/deps: Add header dependencies to .h files: <linux/etherdevice_api.h>
      headers/deps: Add header dependencies to .h files: <linux/export.h>
      headers/deps: Add header dependencies to .h files: <linux/filter_api.h>
      headers/deps: Add header dependencies to .h files: <linux/filter.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_api_f_count.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_api.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_api_sb.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_entry_types.h>
      headers/deps: Add header dependencies to .h files: <linux/fs.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_types.h>
      headers/deps: Add header dependencies to .h files: <linux/fs_types_sb.h>
      headers/deps: Add header dependencies to .h files: <linux/gfp_api.h>
      headers/deps: Add header dependencies to .h files: <linux/gfp_types.h>
      headers/deps: Add header dependencies to .h files: <linux/hardirq.h>
      headers/deps: Add header dependencies to .h files: <linux/hashtable_api.h>
      headers/deps: Add header dependencies to .h files: <linux/hashtable_types.h>
      headers/deps: Add header dependencies to .h files: <linux/highmem_extra.h>
      headers/deps: Add header dependencies to .h files: <linux/highmem.h>
      headers/deps: Add header dependencies to .h files: <linux/hrtimer.h>
      headers/deps: Add header dependencies to .h files: <linux/huge_mm.h>
      headers/deps: Add header dependencies to .h files: <linux/i2c.h>
      headers/deps: Add header dependencies to .h files: <linux/icmpv6.h>
      headers/deps: Add header dependencies to .h files: <linux/idr_api.h>
      headers/deps: Add header dependencies to .h files: <linux/idr_types.h>
      headers/deps: Add header dependencies to .h files: <linux/if_ether_api.h>
      headers/deps: Add header dependencies to .h files: <linux/if_vlan_api.h>
      headers/deps: Add header dependencies to .h files: <linux/if_vlan_types.h>
      headers/deps: Add header dependencies to .h files: <linux/indirect_call_wrapper.h>
      headers/deps: Add header dependencies to .h files: <linux/init.h>
      headers/deps: Add header dependencies to .h files: <linux/instruction_pointer.h>
      headers/deps: Add header dependencies to .h files: <linux/interrupt.h>
      headers/deps: Add header dependencies to .h files: <linux/interrupt_types.h>
      headers/deps: Add header dependencies to .h files: <linux/ioctl.h>
      headers/deps: Add header dependencies to .h files: <linux/io_extra.h>
      headers/deps: Add header dependencies to .h files: <linux/io.h>
      headers/deps: Add header dependencies to .h files: <linux/ioport.h>
      headers/deps: Add header dependencies to .h files: <linux/ioprio.h>
      headers/deps: Add header dependencies to .h files: <linux/ipv6.h>
      headers/deps: Add header dependencies to .h files: <linux/irqdesc.h>
      headers/deps: Add header dependencies to .h files: <linux/irqflags.h>
      headers/deps: Add header dependencies to .h files: <linux/irq_work.h>
      headers/deps: Add header dependencies to .h files: <linux/jiffies.h>
      headers/deps: Add header dependencies to .h files: <linux/jump_label_ratelimit.h>
      headers/deps: Add header dependencies to .h files: <linux/kdev_t.h>
      headers/deps: Add header dependencies to .h files: <linux/kernel.h>
      headers/deps: Add header dependencies to .h files: <linux/kernel_stat.h>
      headers/deps: Add header dependencies to .h files: <linux/kmod.h>
      headers/deps: Add header dependencies to .h files: <linux/kobject_api.h>
      headers/deps: Add header dependencies to .h files: <linux/kobject_types.h>
      headers/deps: Add header dependencies to .h files: <linux/kref_api.h>
      headers/deps: Add header dependencies to .h files: <linux/kref_types.h>
      headers/deps: Add header dependencies to .h files: <linux/kthread.h>
      headers/deps: Add header dependencies to .h files: <linux/ktime_api.h>
      headers/deps: Add header dependencies to .h files: <linux/ktime.h>
      headers/deps: Add header dependencies to .h files: <linux/limits.h>
      headers/deps: Add header dependencies to .h files: <linux/linkage.h>
      headers/deps: Add header dependencies to .h files: <linux/list.h>
      headers/deps: Add header dependencies to .h files: <linux/llist_api.h>
      headers/deps: Add header dependencies to .h files: <linux/llist.h>
      headers/deps: Add header dependencies to .h files: <linux/llist_types.h>
      headers/deps: Add header dependencies to .h files: <linux/lockdep_api.h>
      headers/deps: Add header dependencies to .h files: <linux/lockdep.h>
      headers/deps: Add header dependencies to .h files: <linux/log2.h>
      headers/deps: Add header dependencies to .h files: <linux/math64.h>
      headers/deps: Add header dependencies to .h files: <linux/math.h>
      headers/deps: Add header dependencies to .h files: <linux/memcontrol.h>
      headers/deps: Add header dependencies to .h files: <linux/memory_hotplug.h>
      headers/deps: Add header dependencies to .h files: <linux/memremap.h>
      headers/deps: Add header dependencies to .h files: <linux/minmax.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_api_extra.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_api.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_api_kvmalloc.h>
      headers/deps: Add header dependencies to .h files: <linux/mmap_lock.h>
      headers/deps: Add header dependencies to .h files: <linux/mm.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_page_address.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_ptlock.h>
      headers/deps: Add header dependencies to .h files: <linux/mm_types.h>
      headers/deps: Add header dependencies to .h files: <linux/mmzone_api.h>
      headers/deps: Add header dependencies to .h files: <linux/mmzone.h>
      headers/deps: Add header dependencies to .h files: <linux/mod_devicetable.h>
      headers/deps: Add header dependencies to .h files: <linux/module.h>
      headers/deps: Add header dependencies to .h files: <linux/mutex_api.h>
      headers/deps: Add header dependencies to .h files: <linux/mutex.h>
      headers/deps: Add header dependencies to .h files: <linux/mutex_types.h>
      headers/deps: Add header dependencies to .h files: <linux/netdev_features.h>
      headers/deps: Add header dependencies to .h files: <linux/netdevice_api_extra.h>
      headers/deps: Add header dependencies to .h files: <linux/netdevice_api.h>
      headers/deps: Add header dependencies to .h files: <linux/netdevice_api_lock.h>
      headers/deps: Add header dependencies to .h files: <linux/netdevice_types.h>
      headers/deps: Add header dependencies to .h files: <linux/netfilter/nf_conntrack_common_api.h>
      headers/deps: Add header dependencies to .h files: <linux/net.h>
      headers/deps: Add header dependencies to .h files: <linux/netlink.h>
      headers/deps: Add header dependencies to .h files: <linux/notifier_api.h>
      headers/deps: Add header dependencies to .h files: <linux/notifier.h>
      headers/deps: Add header dependencies to .h files: <linux/notifier_types.h>
      headers/deps: Add header dependencies to .h files: <linux/numa_types.h>
      headers/deps: Add header dependencies to .h files: <linux/of_api.h>
      headers/deps: Add header dependencies to .h files: <linux/pagefault_ctrl.h>
      headers/deps: Add header dependencies to .h files: <linux/page-flags-thp.h>
      headers/deps: Add header dependencies to .h files: <linux/pagemap_api_readahead.h>
      headers/deps: Add header dependencies to .h files: <linux/pagemap.h>
      headers/deps: Add header dependencies to .h files: <linux/path.h>
      headers/deps: Add header dependencies to .h files: <linux/pci-dma-compat.h>
      headers/deps: Add header dependencies to .h files: <linux/percpu_counter_api.h>
      headers/deps: Add header dependencies to .h files: <linux/percpu_counter.h>
      headers/deps: Add header dependencies to .h files: <linux/percpu.h>
      headers/deps: Add header dependencies to .h files: <linux/percpu-refcount-types.h>
      headers/deps: Add header dependencies to .h files: <linux/percpu_rwsem.h>
      headers/deps: Add header dependencies to .h files: <linux/perf_event_api.h>
      headers/deps: Add header dependencies to .h files: <linux/perf_event.h>
      headers/deps: Add header dependencies to .h files: <linux/pfn.h>
      headers/deps: Add header dependencies to .h files: <linux/pgtable_api.h>
      headers/deps: Add header dependencies to .h files: <linux/pgtable.h>
      headers/deps: Add header dependencies to .h files: <linux/pid.h>
      headers/deps: Add header dependencies to .h files: <linux/pm_wakeup.h>
      headers/deps: Add header dependencies to .h files: <linux/poll.h>
      headers/deps: Add header dependencies to .h files: <linux/prandom.h>
      headers/deps: Add header dependencies to .h files: <linux/preempt.h>
      headers/deps: Add header dependencies to .h files: <linux/printk.h>
      headers/deps: Add header dependencies to .h files: <linux/property.h>
      headers/deps: Add header dependencies to .h files: <linux/ptrace_api.h>
      headers/deps: Add header dependencies to .h files: <linux/quota.h>
      headers/deps: Add header dependencies to .h files: <linux/radix-tree-api.h>
      headers/deps: Add header dependencies to .h files: <linux/radix-tree.h>
      headers/deps: Add header dependencies to .h files: <linux/range.h>
      headers/deps: Add header dependencies to .h files: <linux/ratelimit.h>
      headers/deps: Add header dependencies to .h files: <linux/rbtree_api.h>
      headers/deps: Add header dependencies to .h files: <linux/rbtree_latch_types.h>
      headers/deps: Add header dependencies to .h files: <linux/rbtree_types.h>
      headers/deps: Add header dependencies to .h files: <linux/rculist.h>
      headers/deps: Add header dependencies to .h files: <linux/rcupdate.h>
      headers/deps: Add header dependencies to .h files: <linux/refcount_api.h>
      headers/deps: Add header dependencies to .h files: <linux/refcount.h>
      headers/deps: Add header dependencies to .h files: <linux/restart_block.h>
      headers/deps: Add header dependencies to .h files: <linux/rhashtable-types.h>
      headers/deps: Add header dependencies to .h files: <linux/rtmutex.h>
      headers/deps: Add header dependencies to .h files: <linux/rtnetlink.h>
      headers/deps: Add header dependencies to .h files: <linux/rwsem_api.h>
      headers/deps: Add header dependencies to .h files: <linux/rwsem.h>
      headers/deps: Add header dependencies to .h files: <linux/scatterlist_api.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/cond_resched.h>
      headers/deps: Add header dependencies to .h files: <linux/sched.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/per_task.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/signal.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/task_flags.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/task.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/task_stack.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/thread.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/thread_info_api.h>
      headers/deps: Add header dependencies to .h files: <linux/sched/types.h>
      headers/deps: Add header dependencies to .h files: <linux/security.h>
      headers/deps: Add header dependencies to .h files: <linux/semaphore.h>
      headers/deps: Add header dependencies to .h files: <linux/seq_file.h>
      headers/deps: Add header dependencies to .h files: <linux/seq_file_net.h>
      headers/deps: Add header dependencies to .h files: <linux/seqlock_api.h>
      headers/deps: Add header dependencies to .h files: <linux/seqlock.h>
      headers/deps: Add header dependencies to .h files: <linux/seqlock_types.h>
      headers/deps: Add header dependencies to .h files: <linux/shrinker.h>
      headers/deps: Add header dependencies to .h files: <linux/signal_types.h>
      headers/deps: Add header dependencies to .h files: <linux/sizes.h>
      headers/deps: Add header dependencies to .h files: <linux/skbuff_api_extra.h>
      headers/deps: Add header dependencies to .h files: <linux/skbuff_api_frag.h>
      headers/deps: Add header dependencies to .h files: <linux/skbuff_api.h>
      headers/deps: Add header dependencies to .h files: <linux/skbuff_types.h>
      headers/deps: Add header dependencies to .h files: <linux/skbuff_types_head.h>
      headers/deps: Add header dependencies to .h files: <linux/slab.h>
      headers/deps: Add header dependencies to .h files: <linux/smp_api.h>
      headers/deps: Add header dependencies to .h files: <linux/smp.h>
      headers/deps: Add header dependencies to .h files: <linux/socket.h>
      headers/deps: Add header dependencies to .h files: <linux/softirq.h>
      headers/deps: Add header dependencies to .h files: <linux/spinlock_api.h>
      headers/deps: Add header dependencies to .h files: <linux/spinlock.h>
      headers/deps: Add header dependencies to .h files: <linux/spinlock_types.h>
      headers/deps: Add header dependencies to .h files: <linux/srcu.h>
      headers/deps: Add header dependencies to .h files: <linux/srcu_types.h>
      headers/deps: Add header dependencies to .h files: <linux/stat.h>
      headers/deps: Add header dependencies to .h files: <linux/string.h>
      headers/deps: Add header dependencies to .h files: <linux/swab.h>
      headers/deps: Add header dependencies to .h files: <linux/swait_api.h>
      headers/deps: Add header dependencies to .h files: <linux/swap.h>
      headers/deps: Add header dependencies to .h files: <linux/sysfs.h>
      headers/deps: Add header dependencies to .h files: <linux/sysfs_types.h>
      headers/deps: Add header dependencies to .h files: <linux/tasklet_api.h>
      headers/deps: Add header dependencies to .h files: <linux/tasklet_types.h>
      headers/deps: Add header dependencies to .h files: <linux/threads.h>
      headers/deps: Add header dependencies to .h files: <linux/time32.h>
      headers/deps: Add header dependencies to .h files: <linux/time64.h>
      headers/deps: Add header dependencies to .h files: <linux/time64_types.h>
      headers/deps: Add header dependencies to .h files: <linux/time.h>
      headers/deps: Add header dependencies to .h files: <linux/timer.h>
      headers/deps: Add header dependencies to .h files: <linux/timex.h>
      headers/deps: Add header dependencies to .h files: <linux/topology.h>
      headers/deps: Add header dependencies to .h files: <linux/tracepoint.h>
      headers/deps: Add header dependencies to .h files: <linux/typecheck.h>
      headers/deps: Add header dependencies to .h files: <linux/types.h>
      headers/deps: Add header dependencies to .h files: <linux/u64_stats_sync_api.h>
      headers/deps: Add header dependencies to .h files: <linux/u64_stats_sync.h>
      headers/deps: Add header dependencies to .h files: <linux/uaccess.h>
      headers/deps: Add header dependencies to .h files: <linux/uidgid.h>
      headers/deps: Add header dependencies to .h files: <linux/uio_api.h>
      headers/deps: Add header dependencies to .h files: <linux/uuid_api.h>
      headers/deps: Add header dependencies to .h files: <linux/vmalloc.h>
      headers/deps: Add header dependencies to .h files: <linux/vmstat.h>
      headers/deps: Add header dependencies to .h files: <linux/wait_api.h>
      headers/deps: Add header dependencies to .h files: <linux/wait_bit.h>
      headers/deps: Add header dependencies to .h files: <linux/wait_types.h>
      headers/deps: Add header dependencies to .h files: <linux/workqueue_api.h>
      headers/deps: Add header dependencies to .h files: <linux/workqueue.h>
      headers/deps: Add header dependencies to .h files: <linux/workqueue_types.h>
      headers/deps: Add header dependencies to .h files: <linux/writeback.h>
      headers/deps: Add header dependencies to .h files: <linux/xarray_api.h>
      headers/deps: Add header dependencies to .h files: <linux/xarray_types.h>
      headers/deps: Add header dependencies to .h files: <media/dvbdev.h>
      headers/deps: Add header dependencies to .h files: <net/checksum.h>
      headers/deps: Add header dependencies to .h files: <net/dst_api.h>
      headers/deps: Add header dependencies to .h files: <net/dst.h>
      headers/deps: Add header dependencies to .h files: <net/flow_dissector.h>
      headers/deps: Add header dependencies to .h files: <net/ip_fib_api.h>
      headers/deps: Add header dependencies to .h files: <net/ipv6_api.h>
      headers/deps: Add header dependencies to .h files: <net/ndisc_api.h>
      headers/deps: Add header dependencies to .h files: <net/neighbour_api.h>
      headers/deps: Add header dependencies to .h files: <net/netlink_api.h>
      headers/deps: Add header dependencies to .h files: <net/netlink_types.h>
      headers/deps: Add header dependencies to .h files: <net/net_namespace_api.h>
      headers/deps: Add header dependencies to .h files: <net/net_namespace.h>
      headers/deps: Add header dependencies to .h files: <net/net_namespace_types.h>
      headers/deps: Add header dependencies to .h files: <net/pkt_cls_api_tcf_filter.h>
      headers/deps: Add header dependencies to .h files: <net/rtnetlink_api.h>
      headers/deps: Add header dependencies to .h files: <net/sch_generic_api.h>
      headers/deps: Add header dependencies to .h files: <net/sch_generic.h>
      headers/deps: Add header dependencies to .h files: <net/sock_api_extra.h>
      headers/deps: Add header dependencies to .h files: <net/sock_api.h>
      headers/deps: Add header dependencies to .h files: <net/socket_alloc.h>
      headers/deps: Add header dependencies to .h files: <net/sock_types.h>
      headers/deps: Add header dependencies to .h files: <net/xdp.h>
      headers/deps: Add header dependencies to .h files: <net/xdp_types.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/bpf.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/dcbnl.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/icmpv6.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/if_ether.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/in6.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/in.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/net_tstamp.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/personality.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/pkt_sched.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/sched.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/signal.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/stat.h>
      headers/deps: Add header dependencies to .h files: <uapi/linux/uuid.h>
      headers/deps: Add header dependencies to .h files: <vdso/bits.h>
      headers/deps: Add header dependencies to .h files: <vdso/limits.h>
      ⠀
      .————————————————————————————————————.
      | Automated .c dependency additions: |
      |                                    |
      headers/deps: Add header dependencies to .c files: <acpi/platform/aclinuxex_locking.h>
      headers/deps: Add header dependencies to .c files: <asm/apicdef.h>
      headers/deps: Add header dependencies to .c files: <asm/byteorder.h>
      headers/deps: Add header dependencies to .c files: <asm/cacheflush.h>
      headers/deps: Add header dependencies to .c files: <asm/cpudata.h>
      headers/deps: Add header dependencies to .c files: <asm/cpufeature.h>
      headers/deps: Add header dependencies to .c files: <asm/cpu-features.h>
      headers/deps: Add header dependencies to .c files: <asm/cpu-info.h>
      headers/deps: Add header dependencies to .c files: <asm/cpumask_arch.h>
      headers/deps: Add header dependencies to .c files: <asm/cpu-type.h>
      headers/deps: Add header dependencies to .c files: <asm/desc_defs.h>
      headers/deps: Add header dependencies to .c files: <asm/dma.h>
      headers/deps: Add header dependencies to .c files: <asm/elf_api.h>
      headers/deps: Add header dependencies to .c files: <asm/fixmap.h>
      headers/deps: Add header dependencies to .c files: <asm/fpu/types.h>
      headers/deps: Add header dependencies to .c files: <asm/halt.h>
      headers/deps: Add header dependencies to .c files: <asm/insn.h>
      headers/deps: Add header dependencies to .c files: <asm/io.h>
      headers/deps: Add header dependencies to .c files: <asm/kvm_arm.h>
      headers/deps: Add header dependencies to .c files: <asm/local64_api.h>
      headers/deps: Add header dependencies to .c files: <asm/local_api.h>
      headers/deps: Add header dependencies to .c files: <asm/local.h>
      headers/deps: Add header dependencies to .c files: <asm/math_emu.h>
      headers/deps: Add header dependencies to .c files: <asm/mshyperv.h>
      headers/deps: Add header dependencies to .c files: <asm/msr.h>
      headers/deps: Add header dependencies to .c files: <asm/mte.h>
      headers/deps: Add header dependencies to .c files: <asm/nospec-branch.h>
      headers/deps: Add header dependencies to .c files: <asm/page.h>
      headers/deps: Add header dependencies to .c files: <asm/paravirt_api_clock.h>
      headers/deps: Add header dependencies to .c files: <asm/pgalloc.h>
      headers/deps: Add header dependencies to .c files: <asm/pgtable.h>
      headers/deps: Add header dependencies to .c files: <asm/pkru.h>
      headers/deps: Add header dependencies to .c files: <asm/processor_api.h>
      headers/deps: Add header dependencies to .c files: <asm/processor-flags.h>
      headers/deps: Add header dependencies to .c files: <asm/processor.h>
      headers/deps: Add header dependencies to .c files: <asm/processor_types.h>
      headers/deps: Add header dependencies to .c files: <asm/ptrace.h>
      headers/deps: Add header dependencies to .c files: <asm/qspinlock.h>
      headers/deps: Add header dependencies to .c files: <asm/sections.h>
      headers/deps: Add header dependencies to .c files: <asm/segment.h>
      headers/deps: Add header dependencies to .c files: <asm/segment_types.h>
      headers/deps: Add header dependencies to .c files: <asm/smp-ops.h>
      headers/deps: Add header dependencies to .c files: <asm/special_insns.h>
      headers/deps: Add header dependencies to .c files: <asm/spectre.h>
      headers/deps: Add header dependencies to .c files: <asm/stacktrace.h>
      headers/deps: Add header dependencies to .c files: <asm/switch_to.h>
      headers/deps: Add header dependencies to .c files: <asm/tsc.h>
      headers/deps: Add header dependencies to .c files: <asm/unaligned.h>
      headers/deps: Add header dependencies to .c files: <asm/unistd.h>
      headers/deps: Add header dependencies to .c files: <asm/unwind.h>
      headers/deps: Add header dependencies to .c files: <asm/vdso/processor.h>
      headers/deps: Add header dependencies to .c files: <asm/vmalloc.h>
      headers/deps: Add header dependencies to .c files: <asm/x86_init.h>
      headers/deps: Add header dependencies to .c files: <asm/x86_irq.h>
      headers/deps: Add header dependencies to .c files: <clocksource/arm_arch_timer.h>
      headers/deps: Add header dependencies to .c files: <crypto/sha1.h>
      headers/deps: Add header dependencies to .c files: <drm/drm_vma_manager_api_vm_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/acpi.h>
      headers/deps: Add header dependencies to .c files: <linux/align.h>
      headers/deps: Add header dependencies to .c files: <linux/atomic_api.h>
      headers/deps: Add header dependencies to .c files: <linux/audit.h>
      headers/deps: Add header dependencies to .c files: <linux/backing-dev-api.h>
      headers/deps: Add header dependencies to .c files: <linux/backlight.h>
      headers/deps: Add header dependencies to .c files: <linux/bitfield.h>
      headers/deps: Add header dependencies to .c files: <linux/bitmap.h>
      headers/deps: Add header dependencies to .c files: <linux/bitops.h>
      headers/deps: Add header dependencies to .c files: <linux/bitops_types.h>
      headers/deps: Add header dependencies to .c files: <linux/bits.h>
      headers/deps: Add header dependencies to .c files: <linux/bit_spinlock.h>
      headers/deps: Add header dependencies to .c files: <linux/blkdev.h>
      headers/deps: Add header dependencies to .c files: <linux/blk_types.h>
      headers/deps: Add header dependencies to .c files: <linux/bottom_half.h>
      headers/deps: Add header dependencies to .c files: <linux/bpf-cgroup-api.h>
      headers/deps: Add header dependencies to .c files: <linux/bpf-cgroup.h>
      headers/deps: Add header dependencies to .c files: <linux/bpf.h>
      headers/deps: Add header dependencies to .c files: <linux/bug.h>
      headers/deps: Add header dependencies to .c files: <linux/build_bug.h>
      headers/deps: Add header dependencies to .c files: <linux/bvec_api.h>
      headers/deps: Add header dependencies to .c files: <linux/cache.h>
      headers/deps: Add header dependencies to .c files: <linux/capability.h>
      headers/deps: Add header dependencies to .c files: <linux/cc_platform.h>
      headers/deps: Add header dependencies to .c files: <linux/cgroup_api.h>
      headers/deps: Add header dependencies to .c files: <linux/compat.h>
      headers/deps: Add header dependencies to .c files: <linux/cpu.h>
      headers/deps: Add header dependencies to .c files: <linux/cpuhotplug.h>
      headers/deps: Add header dependencies to .c files: <linux/cpumask_api.h>
      headers/deps: Add header dependencies to .c files: <linux/cpuset.h>
      headers/deps: Add header dependencies to .c files: <linux/crc32.h>
      headers/deps: Add header dependencies to .c files: <linux/cred.h>
      headers/deps: Add header dependencies to .c files: <linux/dax.h>
      headers/deps: Add header dependencies to .c files: <linux/dcache.h>
      headers/deps: Add header dependencies to .c files: <linux/dcbnl.h>
      headers/deps: Add header dependencies to .c files: <linux/debugfs.h>
      headers/deps: Add header dependencies to .c files: <linux/debug_locks.h>
      headers/deps: Add header dependencies to .c files: <linux/debugobjects.h>
      headers/deps: Add header dependencies to .c files: <linux/delayed_call.h>
      headers/deps: Add header dependencies to .c files: <linux/delay.h>
      headers/deps: Add header dependencies to .c files: <linux/device_api.h>
      headers/deps: Add header dependencies to .c files: <linux/device_api_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/device/bus.h>
      headers/deps: Add header dependencies to .c files: <linux/device/class.h>
      headers/deps: Add header dependencies to .c files: <linux/device/driver.h>
      headers/deps: Add header dependencies to .c files: <linux/device.h>
      headers/deps: Add header dependencies to .c files: <linux/dma-direction.h>
      headers/deps: Add header dependencies to .c files: <linux/dma-fence-api.h>
      headers/deps: Add header dependencies to .c files: <linux/dma-mapping.h>
      headers/deps: Add header dependencies to .c files: <linux/dma-resv.h>
      headers/deps: Add header dependencies to .c files: <linux/energy_model.h>
      headers/deps: Add header dependencies to .c files: <linux/err.h>
      headers/deps: Add header dependencies to .c files: <linux/errno.h>
      headers/deps: Add header dependencies to .c files: <linux/error-injection.h>
      headers/deps: Add header dependencies to .c files: <linux/etherdevice_api.h>
      headers/deps: Add header dependencies to .c files: <linux/etherdevice.h>
      headers/deps: Add header dependencies to .c files: <linux/eventfd.h>
      headers/deps: Add header dependencies to .c files: <linux/eventpoll.h>
      headers/deps: Add header dependencies to .c files: <linux/export.h>
      headers/deps: Add header dependencies to .c files: <linux/file.h>
      headers/deps: Add header dependencies to .c files: <linux/filter_api.h>
      headers/deps: Add header dependencies to .c files: <linux/filter.h>
      headers/deps: Add header dependencies to .c files: <linux/freezer.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_dio.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_dir_context.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_f_count.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_mapping.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_rw_access.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_api_sb.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_entry_types.h>
      headers/deps: Add header dependencies to .c files: <linux/fs.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_types.h>
      headers/deps: Add header dependencies to .c files: <linux/fs_types_sb.h>
      headers/deps: Add header dependencies to .c files: <linux/ftrace.h>
      headers/deps: Add header dependencies to .c files: <linux/ftrace_pause.h>
      headers/deps: Add header dependencies to .c files: <linux/fwnode.h>
      headers/deps: Add header dependencies to .c files: <linux/gfp_api.h>
      headers/deps: Add header dependencies to .c files: <linux/gfp.h>
      headers/deps: Add header dependencies to .c files: <linux/gfp_types.h>
      headers/deps: Add header dependencies to .c files: <linux/hardirq.h>
      headers/deps: Add header dependencies to .c files: <linux/hash.h>
      headers/deps: Add header dependencies to .c files: <linux/hashtable_api.h>
      headers/deps: Add header dependencies to .c files: <linux/highmem_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/highmem.h>
      headers/deps: Add header dependencies to .c files: <linux/hrtimer_api.h>
      headers/deps: Add header dependencies to .c files: <linux/huge_mm.h>
      headers/deps: Add header dependencies to .c files: <linux/hugetlb_inline.h>
      headers/deps: Add header dependencies to .c files: <linux/i2c.h>
      headers/deps: Add header dependencies to .c files: <linux/icmpv6.h>
      headers/deps: Add header dependencies to .c files: <linux/idr_api.h>
      headers/deps: Add header dependencies to .c files: <linux/if_ether_api.h>
      headers/deps: Add header dependencies to .c files: <linux/if_ether.h>
      headers/deps: Add header dependencies to .c files: <linux/if_link.h>
      headers/deps: Add header dependencies to .c files: <linux/if_vlan_api.h>
      headers/deps: Add header dependencies to .c files: <linux/if_vlan_types.h>
      headers/deps: Add header dependencies to .c files: <linux/init.h>
      headers/deps: Add header dependencies to .c files: <linux/interrupt.h>
      headers/deps: Add header dependencies to .c files: <linux/iocontext.h>
      headers/deps: Add header dependencies to .c files: <linux/ioctl.h>
      headers/deps: Add header dependencies to .c files: <linux/io_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/io.h>
      headers/deps: Add header dependencies to .c files: <linux/ioport.h>
      headers/deps: Add header dependencies to .c files: <linux/ioprio.h>
      headers/deps: Add header dependencies to .c files: <linux/ip.h>
      headers/deps: Add header dependencies to .c files: <linux/ipv6.h>
      headers/deps: Add header dependencies to .c files: <linux/irq_api_eff_affinity.h>
      headers/deps: Add header dependencies to .c files: <linux/irq_api_free.h>
      headers/deps: Add header dependencies to .c files: <linux/irq_api_gc_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/irq_api_io.h>
      headers/deps: Add header dependencies to .c files: <linux/irqdesc.h>
      headers/deps: Add header dependencies to .c files: <linux/irqdomain.h>
      headers/deps: Add header dependencies to .c files: <linux/irqflags.h>
      headers/deps: Add header dependencies to .c files: <linux/irq.h>
      headers/deps: Add header dependencies to .c files: <linux/irqnr.h>
      headers/deps: Add header dependencies to .c files: <linux/jiffies.h>
      headers/deps: Add header dependencies to .c files: <linux/kallsyms.h>
      headers/deps: Add header dependencies to .c files: <linux/kallsyms_objtool.h>
      headers/deps: Add header dependencies to .c files: <linux/kdev_t.h>
      headers/deps: Add header dependencies to .c files: <linux/kernel.h>
      headers/deps: Add header dependencies to .c files: <linux/key.h>
      headers/deps: Add header dependencies to .c files: <linux/kmod.h>
      headers/deps: Add header dependencies to .c files: <linux/kobject_api.h>
      headers/deps: Add header dependencies to .c files: <linux/kprobes.h>
      headers/deps: Add header dependencies to .c files: <linux/kref_api.h>
      headers/deps: Add header dependencies to .c files: <linux/kstrtox.h>
      headers/deps: Add header dependencies to .c files: <linux/kthread.h>
      headers/deps: Add header dependencies to .c files: <linux/ktime_api.h>
      headers/deps: Add header dependencies to .c files: <linux/limits.h>
      headers/deps: Add header dependencies to .c files: <linux/linkage.h>
      headers/deps: Add header dependencies to .c files: <linux/list_bl_api.h>
      headers/deps: Add header dependencies to .c files: <linux/list_lru_api.h>
      headers/deps: Add header dependencies to .c files: <linux/llist_api.h>
      headers/deps: Add header dependencies to .c files: <linux/local_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/lockdep_api.h>
      headers/deps: Add header dependencies to .c files: <linux/lockdep.h>
      headers/deps: Add header dependencies to .c files: <linux/log2.h>
      headers/deps: Add header dependencies to .c files: <linux/math64.h>
      headers/deps: Add header dependencies to .c files: <linux/math.h>
      headers/deps: Add header dependencies to .c files: <linux/memcontrol.h>
      headers/deps: Add header dependencies to .c files: <linux/mem_encrypt.h>
      headers/deps: Add header dependencies to .c files: <linux/memory.h>
      headers/deps: Add header dependencies to .c files: <linux/memory_hotplug.h>
      headers/deps: Add header dependencies to .c files: <linux/memremap.h>
      headers/deps: Add header dependencies to .c files: <linux/minmax.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_exe_file.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_gate_area.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_kasan.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_kvmalloc.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_tlb_flush.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_api_truncate.h>
      headers/deps: Add header dependencies to .c files: <linux/mmap_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/mm.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_page_address.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_ptlock.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_types.h>
      headers/deps: Add header dependencies to .c files: <linux/mm_types_task.h>
      headers/deps: Add header dependencies to .c files: <linux/mmzone_api.h>
      headers/deps: Add header dependencies to .c files: <linux/mmzone.h>
      headers/deps: Add header dependencies to .c files: <linux/mmzone_types.h>
      headers/deps: Add header dependencies to .c files: <linux/mod_devicetable.h>
      headers/deps: Add header dependencies to .c files: <linux/module.h>
      headers/deps: Add header dependencies to .c files: <linux/moduleparam.h>
      headers/deps: Add header dependencies to .c files: <linux/mutex_api.h>
      headers/deps: Add header dependencies to .c files: <linux/mutex.h>
      headers/deps: Add header dependencies to .c files: <linux/netdev_features.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api_dev_stats.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api_lock.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api_pcpu_stats.h>
      headers/deps: Add header dependencies to .c files: <linux/netdevice_api_prefetch.h>
      headers/deps: Add header dependencies to .c files: <linux/netfilter/nf_conntrack_common_api.h>
      headers/deps: Add header dependencies to .c files: <linux/net.h>
      headers/deps: Add header dependencies to .c files: <linux/netlink_api_skb_clone.h>
      headers/deps: Add header dependencies to .c files: <linux/netlink.h>
      headers/deps: Add header dependencies to .c files: <linux/node.h>
      headers/deps: Add header dependencies to .c files: <linux/nodemask.h>
      headers/deps: Add header dependencies to .c files: <linux/notifier_api.h>
      headers/deps: Add header dependencies to .c files: <linux/notifier.h>
      headers/deps: Add header dependencies to .c files: <linux/notifier_types.h>
      headers/deps: Add header dependencies to .c files: <linux/nsproxy.h>
      headers/deps: Add header dependencies to .c files: <linux/numa.h>
      headers/deps: Add header dependencies to .c files: <linux/numa_types.h>
      headers/deps: Add header dependencies to .c files: <linux/of_api.h>
      headers/deps: Add header dependencies to .c files: <linux/of.h>
      headers/deps: Add header dependencies to .c files: <linux/overflow.h>
      headers/deps: Add header dependencies to .c files: <linux/pagefault_ctrl.h>
      headers/deps: Add header dependencies to .c files: <linux/page-flags.h>
      headers/deps: Add header dependencies to .c files: <linux/page-flags-thp.h>
      headers/deps: Add header dependencies to .c files: <linux/pagemap_api_readahead.h>
      headers/deps: Add header dependencies to .c files: <linux/pagemap.h>
      headers/deps: Add header dependencies to .c files: <linux/page_ref_api_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/panic.h>
      headers/deps: Add header dependencies to .c files: <linux/pci-dma-compat.h>
      headers/deps: Add header dependencies to .c files: <linux/percpu_counter_api.h>
      headers/deps: Add header dependencies to .c files: <linux/percpu.h>
      headers/deps: Add header dependencies to .c files: <linux/percpu-refcount-api.h>
      headers/deps: Add header dependencies to .c files: <linux/percpu_rwsem_api.h>
      headers/deps: Add header dependencies to .c files: <linux/percpu_rwsem.h>
      headers/deps: Add header dependencies to .c files: <linux/perf_event_api.h>
      headers/deps: Add header dependencies to .c files: <linux/perf_event.h>
      headers/deps: Add header dependencies to .c files: <linux/personality.h>
      headers/deps: Add header dependencies to .c files: <linux/pgtable_api_access.h>
      headers/deps: Add header dependencies to .c files: <linux/pgtable_api.h>
      headers/deps: Add header dependencies to .c files: <linux/pgtable.h>
      headers/deps: Add header dependencies to .c files: <linux/pgtable_types.h>
      headers/deps: Add header dependencies to .c files: <linux/pid.h>
      headers/deps: Add header dependencies to .c files: <linux/pid_namespace.h>
      headers/deps: Add header dependencies to .c files: <linux/plist.h>
      headers/deps: Add header dependencies to .c files: <linux/pm.h>
      headers/deps: Add header dependencies to .c files: <linux/pm_wakeup.h>
      headers/deps: Add header dependencies to .c files: <linux/poll.h>
      headers/deps: Add header dependencies to .c files: <linux/poll_time.h>
      headers/deps: Add header dependencies to .c files: <linux/prandom.h>
      headers/deps: Add header dependencies to .c files: <linux/preempt.h>
      headers/deps: Add header dependencies to .c files: <linux/prefetch.h>
      headers/deps: Add header dependencies to .c files: <linux/printk.h>
      headers/deps: Add header dependencies to .c files: <linux/processor.h>
      headers/deps: Add header dependencies to .c files: <linux/profile.h>
      headers/deps: Add header dependencies to .c files: <linux/property.h>
      headers/deps: Add header dependencies to .c files: <linux/ptrace_api.h>
      headers/deps: Add header dependencies to .c files: <linux/ptrace.h>
      headers/deps: Add header dependencies to .c files: <linux/ptrace_types.h>
      headers/deps: Add header dependencies to .c files: <linux/quota.h>
      headers/deps: Add header dependencies to .c files: <linux/radix-tree-api.h>
      headers/deps: Add header dependencies to .c files: <linux/random.h>
      headers/deps: Add header dependencies to .c files: <linux/range.h>
      headers/deps: Add header dependencies to .c files: <linux/ratelimit.h>
      headers/deps: Add header dependencies to .c files: <linux/rbtree_api.h>
      headers/deps: Add header dependencies to .c files: <linux/rbtree_latch.h>
      headers/deps: Add header dependencies to .c files: <linux/rcu_internal.h>
      headers/deps: Add header dependencies to .c files: <linux/rculist.h>
      headers/deps: Add header dependencies to .c files: <linux/rcupdate.h>
      headers/deps: Add header dependencies to .c files: <linux/rcu_sync_api.h>
      headers/deps: Add header dependencies to .c files: <linux/rcuwait_api.h>
      headers/deps: Add header dependencies to .c files: <linux/refcount_api.h>
      headers/deps: Add header dependencies to .c files: <linux/resource_ext_api.h>
      headers/deps: Add header dependencies to .c files: <linux/rtnetlink.h>
      headers/deps: Add header dependencies to .c files: <linux/rwsem_api.h>
      headers/deps: Add header dependencies to .c files: <linux/rwsem.h>
      headers/deps: Add header dependencies to .c files: <linux/scatterlist_api.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/affinity.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/clock.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/cond_resched.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/coredump.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/cpufreq.h>
      headers/deps: Add header dependencies to .c files: <linux/sched.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/idle.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/mm.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/per_task.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/rseq_api.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/rt.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/signal.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/task_flags.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/task.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/task_stack.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/thread.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/thread_info_api.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/topology.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/types.h>
      headers/deps: Add header dependencies to .c files: <linux/sched/user.h>
      headers/deps: Add header dependencies to .c files: <linux/security.h>
      headers/deps: Add header dependencies to .c files: <linux/semaphore.h>
      headers/deps: Add header dependencies to .c files: <linux/sem.h>
      headers/deps: Add header dependencies to .c files: <linux/seq_file.h>
      headers/deps: Add header dependencies to .c files: <linux/seq_file_net.h>
      headers/deps: Add header dependencies to .c files: <linux/seqlock_api.h>
      headers/deps: Add header dependencies to .c files: <linux/shrinker.h>
      headers/deps: Add header dependencies to .c files: <linux/signal.h>
      headers/deps: Add header dependencies to .c files: <linux/signal_types.h>
      headers/deps: Add header dependencies to .c files: <linux/siphash_api.h>
      headers/deps: Add header dependencies to .c files: <linux/siphash.h>
      headers/deps: Add header dependencies to .c files: <linux/sizes.h>
      headers/deps: Add header dependencies to .c files: <linux/skbuff_api_extra.h>
      headers/deps: Add header dependencies to .c files: <linux/skbuff_api_frag.h>
      headers/deps: Add header dependencies to .c files: <linux/skbuff_api.h>
      headers/deps: Add header dependencies to .c files: <linux/skbuff_api_nf.h>
      headers/deps: Add header dependencies to .c files: <linux/skbuff_api_page_pool.h>
      headers/deps: Add header dependencies to .c files: <linux/slab.h>
      headers/deps: Add header dependencies to .c files: <linux/smp_api.h>
      headers/deps: Add header dependencies to .c files: <linux/smp.h>
      headers/deps: Add header dependencies to .c files: <linux/softirq.h>
      headers/deps: Add header dependencies to .c files: <linux/spinlock_api.h>
      headers/deps: Add header dependencies to .c files: <linux/spinlock.h>
      headers/deps: Add header dependencies to .c files: <linux/splice.h>
      headers/deps: Add header dependencies to .c files: <linux/srcu.h>
      headers/deps: Add header dependencies to .c files: <linux/stackprotector.h>
      headers/deps: Add header dependencies to .c files: <linux/stacktrace.h>
      headers/deps: Add header dependencies to .c files: <linux/stat.h>
      headers/deps: Add header dependencies to .c files: <linux/static_call.h>
      headers/deps: Add header dependencies to .c files: <linux/static_key.h>
      headers/deps: Add header dependencies to .c files: <linux/string.h>
      headers/deps: Add header dependencies to .c files: <linux/stringhash.h>
      headers/deps: Add header dependencies to .c files: <linux/string.h>
      headers/deps: Add header dependencies to .c files: <linux/sunrpc/debug.h>
      headers/deps: Add header dependencies to .c files: <linux/swait_api.h>
      headers/deps: Add header dependencies to .c files: <linux/swap_api_device.h>
      headers/deps: Add header dependencies to .c files: <linux/swap.h>
      headers/deps: Add header dependencies to .c files: <linux/syscalls_api.h>
      headers/deps: Add header dependencies to .c files: <linux/syscalls.h>
      headers/deps: Add header dependencies to .c files: <linux/sysctl.h>
      headers/deps: Add header dependencies to .c files: <linux/sysfs.h>
      headers/deps: Add header dependencies to .c files: <linux/tasklet_api.h>
      headers/deps: Add header dependencies to .c files: <linux/tcp.h>
      headers/deps: Add header dependencies to .c files: <linux/textsearch.h>
      headers/deps: Add header dependencies to .c files: <linux/thread_info.h>
      headers/deps: Add header dependencies to .c files: <linux/time32.h>
      headers/deps: Add header dependencies to .c files: <linux/time64_api.h>
      headers/deps: Add header dependencies to .c files: <linux/timekeeping.h>
      headers/deps: Add header dependencies to .c files: <linux/timer.h>
      headers/deps: Add header dependencies to .c files: <linux/timerqueue_api.h>
      headers/deps: Add header dependencies to .c files: <linux/timex.h>
      headers/deps: Add header dependencies to .c files: <linux/topology.h>
      headers/deps: Add header dependencies to .c files: <linux/trace_clock.h>
      headers/deps: Add header dependencies to .c files: <linux/trace_events.h>
      headers/deps: Add header dependencies to .c files: <linux/tracepoint.h>
      headers/deps: Add header dependencies to .c files: <linux/u64_stats_sync_api.h>
      headers/deps: Add header dependencies to .c files: <linux/u64_stats_sync.h>
      headers/deps: Add header dependencies to .c files: <linux/uaccess.h>
      headers/deps: Add header dependencies to .c files: <linux/udp_api.h>
      headers/deps: Add header dependencies to .c files: <linux/udp.h>
      headers/deps: Add header dependencies to .c files: <linux/uio_api.h>
      headers/deps: Add header dependencies to .c files: <linux/uio.h>
      headers/deps: Add header dependencies to .c files: <linux/umh.h>
      headers/deps: Add header dependencies to .c files: <linux/utsname.h>
      headers/deps: Add header dependencies to .c files: <linux/uuid_api.h>
      headers/deps: Add header dependencies to .c files: <linux/vfs_pressure.h>
      headers/deps: Add header dependencies to .c files: <linux/vmalloc.h>
      headers/deps: Add header dependencies to .c files: <linux/vmstat.h>
      headers/deps: Add header dependencies to .c files: <linux/wait_api.h>
      headers/deps: Add header dependencies to .c files: <linux/wait_bit.h>
      headers/deps: Add header dependencies to .c files: <linux/wait.h>
      headers/deps: Add header dependencies to .c files: <linux/wait_types.h>
      headers/deps: Add header dependencies to .c files: <linux/workqueue_api.h>
      headers/deps: Add header dependencies to .c files: <linux/writeback_api.h>
      headers/deps: Add header dependencies to .c files: <linux/writeback.h>
      headers/deps: Add header dependencies to .c files: <linux/xarray_api.h>
      headers/deps: Add header dependencies to .c files: <media/dvbdev.h>
      headers/deps: Add header dependencies to .c files: <net/act_api.h>
      headers/deps: Add header dependencies to .c files: <net/arp.h>
      headers/deps: Add header dependencies to .c files: <net/checksum.h>
      headers/deps: Add header dependencies to .c files: <net/dcbnl.h>
      headers/deps: Add header dependencies to .c files: <net/dst_api.h>
      headers/deps: Add header dependencies to .c files: <net/dst_api_tunnel.h>
      headers/deps: Add header dependencies to .c files: <net/dst_ops_api.h>
      headers/deps: Add header dependencies to .c files: <net/dst_types.h>
      headers/deps: Add header dependencies to .c files: <net/if_inet6.h>
      headers/deps: Add header dependencies to .c files: <net/inet_connection_sock_api.h>
      headers/deps: Add header dependencies to .c files: <net/inet_ecn.h>
      headers/deps: Add header dependencies to .c files: <net/inet_frag.h>
      headers/deps: Add header dependencies to .c files: <net/inet_sock_api.h>
      headers/deps: Add header dependencies to .c files: <net/inet_timewait_sock_api.h>
      headers/deps: Add header dependencies to .c files: <net/ip6_route_api_mtu.h>
      headers/deps: Add header dependencies to .c files: <net/ip_api_gro.h>
      headers/deps: Add header dependencies to .c files: <net/ip_extra.h>
      headers/deps: Add header dependencies to .c files: <net/ip_fib_api.h>
      headers/deps: Add header dependencies to .c files: <net/ip_tunnels_ecn.h>
      headers/deps: Add header dependencies to .c files: <net/ipv6_api.h>
      headers/deps: Add header dependencies to .c files: <net/ipv6_api_sock.h>
      headers/deps: Add header dependencies to .c files: <net/ipv6_stubs.h>
      headers/deps: Add header dependencies to .c files: <net/ipv6_types.h>
      headers/deps: Add header dependencies to .c files: <net/l3mdev.h>
      headers/deps: Add header dependencies to .c files: <net/ndisc_api.h>
      headers/deps: Add header dependencies to .c files: <net/neighbour_api.h>
      headers/deps: Add header dependencies to .c files: <net/neighbour_api_output.h>
      headers/deps: Add header dependencies to .c files: <net/neighbour_api_seqlock.h>
      headers/deps: Add header dependencies to .c files: <net/neighbour.h>
      headers/deps: Add header dependencies to .c files: <net/netlink_api.h>
      headers/deps: Add header dependencies to .c files: <net/netlink.h>
      headers/deps: Add header dependencies to .c files: <net/net_namespace_api.h>
      headers/deps: Add header dependencies to .c files: <net/net_namespace.h>
      headers/deps: Add header dependencies to .c files: <net/net_namespace_types.h>
      headers/deps: Add header dependencies to .c files: <net/netprio_cgroup.h>
      headers/deps: Add header dependencies to .c files: <net/pkt_cls_api_tcf_filter.h>
      headers/deps: Add header dependencies to .c files: <net/pkt_cls.h>
      headers/deps: Add header dependencies to .c files: <net/pkt_sched.h>
      headers/deps: Add header dependencies to .c files: <net/route_api.h>
      headers/deps: Add header dependencies to .c files: <net/rtnetlink_api.h>
      headers/deps: Add header dependencies to .c files: <net/rtnetlink_types.h>
      headers/deps: Add header dependencies to .c files: <net/sch_generic_api.h>
      headers/deps: Add header dependencies to .c files: <net/sch_generic.h>
      headers/deps: Add header dependencies to .c files: <net/sock_api_extra.h>
      headers/deps: Add header dependencies to .c files: <net/sock_api.h>
      headers/deps: Add header dependencies to .c files: <net/sock_batch.h>
      headers/deps: Add header dependencies to .c files: <net/socket_alloc.h>
      headers/deps: Add header dependencies to .c files: <net/sock.h>
      headers/deps: Add header dependencies to .c files: <net/sock_types.h>
      headers/deps: Add header dependencies to .c files: <net/tcp_bpf.h>
      headers/deps: Add header dependencies to .c files: <net/timewait_sock.h>
      headers/deps: Add header dependencies to .c files: <net/udp_api_sock.h>
      headers/deps: Add header dependencies to .c files: <net/udp_api_table.h>
      headers/deps: Add header dependencies to .c files: <net/xdp_api.h>
      headers/deps: Add header dependencies to .c files: <uapi/asm/fcntl.h>
      headers/deps: Add header dependencies to .c files: <uapi/asm/sigcontext.h>
      headers/deps: Add header dependencies to .c files: <uapi/asm/siginfo.h>
      headers/deps: Add header dependencies to .c files: <uapi/asm/signal.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/fs.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/if_arp.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/if_ether.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/in.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/in_route.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/ipv6.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/magic.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/net.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/net_tstamp.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/pkt_sched.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/route.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/rtnetlink.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/sem.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/signal.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/sockios.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/stat.h>
      headers/deps: Add header dependencies to .c files: <uapi/linux/unistd.h>
      headers/deps: Add header dependencies to .c files: <vdso/limits.h>
      headers/deps: Add header dependencies to .c files: <vdso/processor.h>
      ⠀
      .————————————————————————————————————.
      | Optimize headers, phase #2:        |
      |                                    |
      headers/deps: mm: Move current_is_kswapd() from <linux/swap.h> to <linux/sched/task_flags.h>
      headers/deps: bpf: Remove the <linux/sched/mm.h> dependency from <linux/bpf.h>
      headers/deps: rcu: Remove <linux/sched/signal.h> dependency from <linux/rcuwait.h>
      headers/deps: mm: Optimize <linux/coredump.h> dependencies
      headers/deps: printk/ratelimit: Remove the <linux/sched.h> dependency from <linux/ratelimit.h>
      headers/deps: mm: Remove <linux/sched.h> from <linux/mm.h>
      headers/deps: x86/mm: Remove <linux/thread_info_api.h> from <asm/elf.h>
      headers/deps: sched/energy: Remove unnecessary headers from <linux/energy_model.h>
      headers/deps: mm: Move pagefault_disable()/enable() methods from <linux/uaccess.h> to <linux/pagefault_ctrl.h>
      headers/deps: mm: Optimize <linux/uaccess.h>
      headers/deps: rcu/wait: Remove <linux/sched/task_flags.h> from <linux/rcuwait.h>
      headers/deps: block/ioprio: Remove the <linux/sched.h> dependency from <linux/ioprio.h>
      headers/deps: Move TASK_COMM_LEN from <linux/sched.h> to <linux/sched/types.h>
      headers/deps: Move TASK_* definitions to <linux/sched/types.h>
      headers/deps: fs: Remove the <linux/sched.h> and <linux/sched/user.h> includes from <linux/cred.h>
      headers/deps: irq: Remove the <linux/sched.h> header from <linux/hardirq.h>
      headers/deps: ACPI: Remove <linux/sched.h> from <acpi/platform/aclinux.h>
      headers/deps: net: Remove the <linux/sched.h> headers from <linux/skbuff.h>
      headers/deps: nsproxy: Remove the <linux/sched.h> header from <linux/nsproxy.h>
      headers/deps: ns: Remove <linux/sched.h> from <linux/user_namespace.h>
      headers/deps: kernel_stat: Remove the <linux/sched.h> header from <linux/kernel_stat.h>
      headers/deps: psi: Remove the <linux/sched.h> include from <linux/psi_types.h>
      headers/deps: Move 'struct prev_cputime' from <linux/sched/signal.h> to <linux/kernel_stat.h>
      headers/deps: cgroups: Remove the <linux/sched/signal.h> header from <linux/cgroup-defs.h>
      headers/deps: net/scm: Remove the <linux/sched/signal.h> header from <net/scm.h>
      headers/deps: net: Remove <net/netprio_cgroup.h> from <linux/netdevice.h>
      headers/deps: Move MAX_SCHEDULE_TIMEOUT from <linux/sched.h> to <linux/sched/types.h>
      headers/deps: net: Remove <linux/sched.h> headers from <net/sock.h> and <linux/filter.h>
      headers/deps: i2c: Remove <linux/sched.h> from <linux/i2c.h>
      headers/deps: sched/wait: Remove <linux/sched.h> from <linux/wait_bit.h>
      headers/deps: ptrace: Move user_single_step_report() from <linux/ptrace.h> to <linux/tracehook.h>
      headers/deps: ptrace: Factor out ptrace data types into <linux/ptrace_types.h>
      headers/deps: audit: Split <linux/audit_types.h> from <linux/audit.h>
      headers/deps: audit: Remove <uapi/linux/netfilter/nf_tables.h> include from <linux/audit.h>
      headers/deps: audit: Make <linux/audit.h> build standalone on !CONFIG_AUDIT kernels too
      headers/deps: security: Include <linux/audit_types.h> instead of <linux/audit.h>
      headers/deps: tracing: Remove spurious <linux/ptrace.h> inclusion from <linux/ftrace.h>
      headers/deps: kprobes: Optimize the x86 <asm/kprobes.h> header's dependencies
      headers/deps: ptrace: Move is_syscall_success() to <linux/ptrace_types.h>
      headers/deps: audit: Remove <linux/sched.h> from <linux/audit.h>
      headers/deps: elfcore: Remove <linux/ptrace.h> include from <linux/elfcore.h>
      headers/deps: bpf: Use <uapi/linux/ptrace.h> in <uapi/asm-generic/bpf_perf_event.h>
      headers/deps: mm: Split <linux/mm_ptlock.h> out of <linux/mm.h>
      headers/deps: sched/wait: Include <linux/sched/types.h> in <linux/wait.h>
      headers/deps: sound: Remove spurious <linux/sched.h> inclusion from <linux/sound.h>
      headers/deps: x86/compat: Optimize x86 <asm/compat.h> header dependencies
      headers/deps: mm: Remove spurious <linux/cgroup.h> include from <linux/vmpressure.h>
      headers/deps: mm: Optimize <linux/swap.h> dependencies
      headers/deps: kthread: Remove <linux/sched.h> from <linux/kthread.h>
      headers/deps: block: Remove the <linux/sched.h> includes from <linux/blkdev.h>
      headers/deps: mm: Optimize <linux/io-mapping.h> header dependencies
      headers/deps: usb: Remove <linux/sched.h> from <linux/usb.h>
      headers/deps: modules: Remove <linux/srcu.h> from <linux/module.h>
      headers/deps: rcu: Split <linux/srcu_types.h> out of <linux/srcu.h>
      headers/deps: x86/mm: Move the pgd_list definitions from <asm/pgtable.h> to <asm/pgalloc.h>
      headers/deps: list: Optimize <linux/list.h> header dependencies
      headers/deps: Optimize <linux/kernel.h>
      headers/deps: printk: Reduce <linux/printk.h> header dependencies
      headers/deps: rbtree: Move the rbtree_latch_node definition into <linux/rbtree_latch_types.h>
      headers/deps: kref: Remove unnecessary <linux/spinlock.h> include from <linux/kref.h>
      headers/deps: kobject: Split out <linux/kobject_types.h>
      headers/deps: sysfs: Split <linux/sysfs_types.h> header from <linux/sysfs.h>
      headers/deps: kobject: Use <linux/sysfs_types.h> in <linux/kobject.h>, remove <linux/sysfs.h> inclusion
      headers/deps: x86/vdso: Optimize <asm/vdso.h>'s dependencies
      headers/deps: Prepare for <linux/module.h> simplification changes
      headers/deps: module: Optimize <linux/module.h> header dependencies
      headers/deps: time: Optimize <linux/time.h> header dependencies, remove <linux/cache.h>, <linux/math64.h> and <linux/timex.h> dependencies
      headers/deps: numa: Factor out <linux/numa_types.h> from <linux/numa.h>
      headers/deps: cpumask: Introduce <linux/cpumask_types.h>
      headers/deps: sched/topology, x86: Optimize <asm/topology.h> header dependencies
      headers/deps: sched/topology, x86: Prepare <asm/topology.h>
      headers/deps: sched/topology: Optimize <linux/topology.h> header dependencies
      headers/deps: mm: Optimize <linux/gfp.h> header dependencies
      headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>
      headers/deps: XArray: Reduce <linux/xarray.h> header dependencies
      headers/deps: locking/spinlocks: Move spinlock_init() to <linux/spinlock_types.h>
      headers/deps: XArray: Introduce <linux/xarray_types.h>
      headers/deps: XArray: Optimize <linux/xarray_types.h> header dependencies
      headers/deps: radix-trees: Use the new <linux/xarray_types.h> header
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies, remove <linux/rcupdate.h>
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies, remove <linux/spinlock.h>
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies, remove misc headers
      headers/deps: fs: Remove <linux/ioprio.h> dependency from <linux/fs.h>
      headers/deps: sched/wait: Introduce <linux/wait_types.h>
      headers/deps: sched/wait: Optimize <linux/wait_types.h>
      headers/deps: fs: Optimize <linux/dcache.h> header dependencies
      headers/deps: fs: Optimize <linux/fs.h> header dependencies: remove <linux/semaphore.h> and <linux/rculist_bl.h> inclusions
      headers/deps: fs: Optimize <linux/fs.h> header dependencies
      headers/deps: fs/quota: Introduce <linux/quota_types.h>
      headers/deps: mm: Move the isolate_mode_t typedef from <linux/mmzone.h> to <linux/gfp_types.h>
      headers/deps: fs: Optimize <linux/fs.h> dependencies
      headers/deps: mm/thp: Remove <linux/fs.h> and <linux/dax.h> includes from <linux/huge_mm.h>
      headers/deps: fb: Optimize <linux/fb.h> dependencies
      headers/deps: net: Decouple <linux/net.h> from <linux/fs.h>
      headers/deps: net: Remove <linux/fs.h> from <linux/net.h>
      headers/deps: mm/highmem: Remove <linux/fs.h> inclusion from <linux/highmem.h>
      headers/deps: input: Remove unnecessary inclusion of <linux/fs.h> from <linux/input.h>
      headers/deps: compat: Optimize <linux/compat.h>
      headers/deps: net: Split <linux/socket_types.h> out of <linux/socket.h>
      headers/deps: x86/compat: Move the compat_user_stack_pointer() definition from <asm/ptrace.h> to <asm/compat.h>
      headers/deps: compat: Optimize <linux/compat.h> dependencies even more
      headers/deps: fs: Remove the <linux/fs.h> dependency from <linux/seq_file.h>
      headers/deps: security: Remove the <linux/fs.h> include from <linux/security.h>
      headers/deps: security/keys: Introduce the <linux/key_types.h> header
      headers/deps: security: Optimize <linux/security.h> dependencies
      headers/deps: fs: Move file_can_poll() and vfs_poll() from <linux/poll.h> to <linux/eventpoll.h>
      headers/deps: net: Separate out <linux/socket_alloc.h>
      headers/deps: net: Remove <linux/poll.h> from <net/sock.h>
      headers/deps: fs: Remove the <linux/fs.h> include from <linux/poll.h>
      headers/deps: net: Collect headers to the top of the file
      headers/deps: bvec: Optimize <linux/bvec.h> header dependencies
      headers/deps: Split <linux/check_size.h> from <linux/thread_info.h>
      headers/deps: uio: Optimize <linux/uio.h> dependencies
      headers/deps: net: Optimize <linux/net.h> header dependencies
      headers/deps: net: Optimize <linux/skbuff.h> header dependencies
      headers/deps: mm: Move the MAX_ORDER* definitions from <linux/mmzone.h> to <linux/gfp_types.h>
      headers/deps: mm: Optimize <linux/slab.h>'s header file dependencies
      headers/deps: net: Introduce <linux/skbuff_types.h>
      headers/deps: net: Optimize <linux/skbuff_types.h> dependencies
      headers/deps: net: Move header includes to the top of the file in <net/net_namespace.h>
      headers/deps: net: Introduce <net/net_namespace_types.h> header
      headers/deps: net: Optimize <net/net_namespace_types.h> and <net/net_namespace.h>
      headers/deps: uids: Add 'struct kuid_struct' and 'struct kgid_struct' for easy predeclaration
      headers/deps: fs: Optimize the <linux/sysctl.h> header
      headers/deps: Optimize <linux/u64_stats_sync.h> dependencies
      headers/deps: atomics: Optimize <asm-generic/local64.h> & x86's <asm/local.h>
      headers/deps: net: Optimize the header dependencies of <net/snmp.h>
      headers/deps: locking/mutexes: Optimize <linux/mutex.h> header dependencies
      headers/deps: net: Optimize <net/netns/packet.h> dependencies
      headers/deps: locking/seqlock: Move seqlock API definitions to <linux/seqlock_api.h>
      headers/deps: locking/seqlocks: Optimize <linux/seqlock.h>, remove <linux/seqlock_api.h> and other changes
      headers/deps: i2c: Optimize <linux/i2c.h> header dependencies
      headers/deps: net: Optimize the header dependencies of <uapi/linux/if_bonding.h>
      headers/deps: net: Optimize the <uapi/linux/if.h> header
      headers/deps: net: Optimize <uapi/linux/if_link.h>
      headers/deps: net: Optimize <uapi/linux/netdevice.h>
      headers/deps: net: Optimize <uapi/linux/netlink.h>
      headers/deps: net: Introduce <net/xdp_api.h>
      headers/deps: Optimize <linux/netdevice.h>
      headers/deps: locking: Make <linux/local_lock.h> build standalone on allnoconfig kernels
      headers/deps: power: Optimize <linux/suspend.h> dependencies, remove <linux/freezer.h> inclusion
      headers/deps: power: Optimize <linux/suspend.h> dependencies, remove <linux/swap.h>
      headers/deps: power: Optimize <linux/suspend.h> dependencies, remove <linux/mm.h>
      headers/deps: power: Optimize <linux/suspend.h> dependencies, remove <linux/notifier.h> and <linux/init.h>
      headers/deps: timers/hrtimer: Split out <linux/hrtimer_api.h>
      headers/deps: timers/hrtimer: Change all hrtimer API using files to use <linux/hrtimer_api.h>
      headers/deps: timers/hrtimer: Remove the <linux/hrtimer_api.h> inclusion from <linux/hrtimer.h>
      headers/deps: timers/hrtimer: Optimize <linux/hrtimer.h>, remove <linux/timer.h>
      headers/deps: timers/hrtimer: Optimize <linux/hrtimer.h>, remove <linux/seqlock.h>
      headers/deps: timers/hrtimer: Optimize <linux/hrtimer.h> dependencies, remove <linux/init.h>, <linux/percpu.h>
      headers/deps: timers/hrtimer: Optimize <linux/hrtimer.h> dependencies, remove <linux/rbtree.h>
      headers/deps: timers/timerqueue: Split <linux/timerqueue_api.h> from <linux/timerqueue.h>
      headers/deps: timers/timerqueue: Remove the <linux/timerqueue_api.h> include from <linux/timerqueue.h>
      headers/deps: timers/timerqueue: Optimize <linux/timerqueue.h>
      headers/deps: rbtree: Optimize <linux/rbtree_types.h>, remove the <linux/kernel.h> header
      headers/deps: timers/ktime: Split the <linux/ktime_api.h> header from <linux/ktime.h>
      headers/deps: ktime: Remove the <linux/ktime_api.h> header from <linux/ktime.h>
      headers/deps: timers/hrtimer: Optimize <linux/hrtimer.h>, remove <linux/rbtree.h> dependency
      headers/deps: workqueue: Split <linux/workqueue_api.h> out of <linux/workqueue.h>
      headers/deps: workqueue: Optimize <linux/workqueue.h> dependencies, remove the <linux/workqueue_api.h> inclusion
      headers/deps: workqueue: Optimize <linux/workqueue.h> by removing <linux/rcupdate.h>
      headers/deps: timers/timer_list: Optimize <linux/timer.h>
      headers/deps: workqueue: Optimize <linux/workqueue.h> dependencies
      headers/deps: sched/wait: Split <linux/swait_api.h> from <linux/swait.h>
      headers/deps: sched/wait: Remove <linux/swait_api.h> from <linux/swait.h>
      headers/deps: sched/wait: Optimize <linux/swait.h> dependencies
      headers/deps: power: Optimize <linux/pm.h> header dependencies
      headers/deps: net: Split up <linux/skbuff.h> into <linux/skbuff_types.h> and <linux/skbuff_api.h>
      headers/deps: net/headers: Split <linux/netdevice_api.h> from <linux/netdevice.h>
      headers/deps: networking/headers: Remove the <linux/netdevice_api.h> inclusion from <linux/netdevice.h>
      headers/deps: net/headers: Optimize <linux/netdevice.h>
      headers/deps: net/headers: Optimize <linux/skbuff.h> by removing <linux/skbuff_api.h>
      headers/deps: types: Include netdev_features_t in <linux/types.h>
      headers/deps: net/headers: Optimize <linux/netdevice.h>
      headers/deps: dma-fence: Split out <linux/dma-fence-api.h>
      headers/deps: dma-fence: Optimize <linux/dma-fence.h>, remove <linux/dma-fence-api.h>
      headers/deps: dma-fence: Optimize <linux/dma-fence.h> header dependencies some more
      headers/deps: drm/syncobj: Optimize <drm/drm_syncobj.h>
      headers/deps: drm/ttm: Optimize <drm/ttm/ttm_resource.h> dependencies
      headers/deps: ftrace: Optimize <linux/trace_recursion.h> header dependencies
      headers/deps: ftrace: Optimize the <linux/ftrace.h> header dependencies
      headers/deps: ftrace: Remove the task-tracing definitions from <linux/ftrace.h>
      headers/deps: ftrace: Split <linux/ftrace_pause.h> out of <linux/ftrace.h>
      headers/deps: ftrace: Optimize the <linux/ftrace.h> header dependencies, take 2
      headers/deps: x86/asm: Remove <linux/ftrace.h> from <asm/unwind.h>
      headers/deps: writeback: Split the <linux/writeback_api.h> header out of <linux/writeback.h>
      headers/deps: writeback: Remove the <linux/writeback_api.h> header from <linux/writeback.h>
      headers/deps: writeback: Optimize <linux/writeback.h> header dependencies by removing <linux/blk-cgroup.h>
      headers/deps: writeback: Optimize <linux/writeback.h> header dependencies by removing <linux/blk_types.h>
      headers/deps: writeback: Optimize <linux/writeback.h> header dependencies by removing <linux/backing-dev-defs.h>
      headers/deps: writeback: Optimize <linux/writeback.h> header dependencies by removing <linux/fs.h>
      headers/deps: writeback: Optimize <linux/writeback.h> header dependencies by removing <linux/workqueue.h> and <linux/sched.h>
      headers/deps: locking: Split <linux/percpu_counter_api.h> from <linux/percpu_counter.h>
      headers/deps: locking: Remove <linux/percpu_counter_api.h> from <linux/percpu_counter.h>
      headers/deps: net/dst: Split out the <net/dst_ops_api.h> header from <net/dst_ops.h>
      headers/deps: net/dst: Remove the <net/dst_ops_api.h> header from <net/dst_ops.h>
      headers/deps: net/dst: Optimize the <net/dst_ops_api.h> header
      headers/deps: locking/percpu_counters: Optimize the <linux/percpu_counter.h> dependencies
      headers/deps: net: Split out <net/sock_batch.h> from <net/sock.h>
      headers/deps: net: Optimize <net/sock.h> dependencies, remove <linux/percpu_counter_api.h>
      headers/deps: net: Remove <linux/percpu_counter_api.h> from <net/inet_connection_sock.h>
      headers/deps: net/tcp: Optimize <net/tcp.h> header dependencies
      headers/deps: locking/local_locks: Optimize <linux/local_lock.h>
      headers/deps: radix-tree: Split out the <linux/radix-tree-api.h> header
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies, remove <linux/radix-tree-api.h> inclusion
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> some more
      headers/deps: idr: Split out <linux/idr_api.h> from <linux/idr.h>
      headers/deps: idr: Remove <linux/idr_api.h> from <linux/idr.h>
      headers/deps: radix-tree: Move radix tree initialization defines from <linux/radix-tree-api.h> to <linux/radix-tree.h>
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> header dependencies
      headers/deps: idr: Optimize <linux/idr.h> header dependencies
      headers/deps: ptrace: Move the <linux/ptrace.h> header to <linux/ptrace_api.h>
      headers/deps: mm: Move PAGE_ALIGN() and PAGE_ALIGNED() from <linux/mm.h> to <linux/mm_types.h>
      headers/deps: ptrace: Optimize <linux/ptrace.h> by removing the <linux/ptrace_api.h> header
      headers/deps: nodemask: Introduce 'struct nodemask_struct'
      headers/deps: mm: Optimize the <linux/oom.h> header
      headers/deps: net/sunrpc: Optimize <linux/sunrpc/types.h>
      headers/deps: media: Optimize the <media/v4l2-ioctl.h> header dependencies
      headers/deps: syscalls: Split <linux/syscalls_api.h> out of <linux/syscalls.h>
      headers/deps: syscalls: Remove the <linux/syscalls_api.h> include from <linux/syscalls.h>
      headers/deps: seq_buf: Optimize the <linux/seq_buf.h> header's dependencies
      headers/deps: tracing: Split out <linux/trace_events_types.h> from <linux/trace_events.h>
      headers/deps: fs/poll: Fix macro assumption in <linux/poll.h>
      headers/deps: tracing: Optimize <linux/ring_buffer.h>'s header dependencies, remove <linux/poll.h>
      headers/deps: tracing: Optimize the <trace/syscall.h> header
      headers/deps: syscalls: Optimize <linux/syscalls.h> dependencies
      headers/deps: drm/core: Optimize the <drm/drm_framebuffer.h> header's dependencies
      headers/deps: mm: Optimize the <linux/backing-dev.h> header's dependencies
      headers/deps: radix-tree: Optimize <linux/radix-tree-api.h>
      headers/deps: Optimize <media/dvb_frontend.h> dependencies
      headers/deps: media: Optimize the main <media/*.h> header dependencies
      headers/deps: mm: Create <linux/gfp_api.h>
      headers/deps: mm: Remove the <linux/gfp_api.h> header from <linux/gfp.h>
      headers/deps: sound: Remove <linux/sched.h> from <sound/compress_driver.h>
      headers/deps: cgroup: Rename <linux/cgroup-defs.h> to <linux/cgroup_types.h>
      headers/deps: cgroup: Move <linux/cgroup.h> to <linux/cgroup_api.h>
      headers/deps: tracing: Optimize the <linux/ring_buffer.h> header
      headers/deps: tracing: Optimize the <linux/trace_events.h> header
      headers/deps: mm: Optimize the <linux/memcontrol.h> header
      headers/deps: writeback: Optimize the <linux/backing-dev.h> header dependencies
      headers/deps: mm/writeback: Remove the unused bdi_sched_wait() inline
      headers/deps: bdi: Split <linux/backing-dev.h> into <linux/backing-dev-types.h> and <linux/backing-dev-api.h>
      headers/deps: bdi: Move various APIs from <linux/backing-dev-types.h> to <linux/backing-dev-api.h>
      headers/deps: bdi: Remove <linux/backing-dev-api.h> from the default <linux/backing-dev.h> header
      headers/deps: bdi: Move 'struct backing_dev_info' from <linux/backing-dev-types.h> to <linux/backing-dev-api.h>
      headers/deps: bdi: Optimize <linux/backing-dev-types.h>
      headers/deps: cgroups: Remove the <linux/cgroup_api.h> header from the default <linux/cgroup.h> header
      headers/deps: cgroup: Move the sock_cgroup*() inline functions from <linux/cgroup_types.h> to <linux/cgroup_api.h>
      headers/deps: cgroup: Move the cgroup_threadgroup_*() inline functions from <linux/cgroup_types.h> to <linux/cgroup_api.h>
      headers/deps: cgroup: Split <linux/bpf-cgroup.h> into <linux/bpf-cgroup-types.h> and <linux/bpf-cgroup-api.h>
      headers/deps: net/tcp: Split the <net/tcp_bpf.h> header out of <net/tcp.h>
      headers/deps: cgroups: Use the <linux/bpf-cgroup-types.h> header in <linux/cgroup_types.h> and <net/tcp.h>
      headers/deps: cgroups: Optimize <linux/cgroup_types.h>, remove various headers
      headers/deps: bpf: Introduce <linux/bpf_defs.h>
      headers/deps: bpf: Move the 'struct bpf_link' definition into <linux/bpf_defs.h>
      headers/deps: bpf: Move the MAX_BPF_CGROUP_STORAGE_TYPE definition from <linux/bpf.h> to <linux/bpf_defs.h>
      headers/deps: cgroup, bpf: Optimize <linux/bpf-cgroup-types.h>
      headers/deps: locking: Split <linux/percpu-refcount.h> into <linux/percpu-refcount-types.h> and <linux/percpu-refcount-api.h>
      headers/deps: locking: Optimize <linux/percpu-refcount-types.h> header dependencies
      headers/deps: cgroups, bpf: Optimize the <linux/bpf-cgroup-types.h> header's dependencies
      headers/deps: bpf, cgroups: Optimize the <linux/bpf-cgroup-types.h> header's dependencies
      headers/deps: psi: Optimize the <linux/psi_types.h> header's dependencies
      headers/deps: kernel_stat: Split out <linux/kernel_stat_types.h> from <linux/kernel_stat.h>
      headers/deps: cgroups: Optimize the <linux/cgroup_types.h> header
      headers/deps: irq: Split out <linux/interrupt_types.h> out of <linux/interrupt.h>
      headers/deps: kernel_stat: Optimize the <linux/kernel_stat.h> header's dependencies
      headers/deps: utsname: Reduce <linux/utsname.h> inclusions
      headers/deps: mm: Optimize <linux/rmap.h> dependencies
      headers/deps: Optimize <net/tcp.h> dependencies, remove <linux/memcontrol.h>
      headers/deps: driver/core: Optimize <linux/device.h> dependencies, remove <linux/energy_model.h>
      headers/deps: driver/core: Optimize <linux/device.h> dependencies, remove <linux/topology.h>
      headers/deps: sched/wait: Split <linux/wait.h> into <linux/wait_api.h> and <linux/wait_types.h> headers
      headers/deps: sched/wait: Optimize <linux/wait.h>, remove <linux/wait_api.h> inclusion
      headers/deps: sched/wait, fs: Remove <linux/wait_api.h> from <linux/fs.h>
      headers/deps: net: Remove the <linux/wait_api.h> inclusion from <net/sock.h>
      headers/deps: pid_namespace: Optimize <linux/pid_namespace.h> dependencies
      headers/deps: net: Split <linux/etherdevice.h> into <linux/etherdevice_types.h> and <linux/etherdevice_api.h>
      headers/deps: net: Split <linux/if_vlan.h> into <linux/if_vlan_types.h> and <linux/if_vlan_api.h>
      headers/deps: net: Move <linux/netdevice.h> to <linux/netdevice_types.h>
      headers/deps: net: Optimize <linux/if_vlan.h>, remove <linux/if_vlan_api.h> inclusion
      headers/deps: net: Move ip_tunnel_ecn_encap() into <net/ip_tunnels_ecn.h>
      headers/deps: net: Remove the <net/inet_ecn_api.h> header from <net/ip_tunnels.h>
      headers/deps: net: Remove the <linux/inet_ecn.h> header from <net/tcp.h>
      headers/deps: net: Remove <net/inet_ecn.h> from <net/codel.h>
      headers/deps: net: Optimize the <linux/if_vlan_types.h> header
      headers/deps: net: Split out the <net/net_namespace_types_possible.h> header
      headers/deps: net: Optimize <linux/netdevice_types.h> header dependencies
      headers/deps: net: Optimize the <linux/etherdevice.h> header's dependencies, remove the <linux/etherdevice_api.h> header
      headers/deps: net: Split <linux/if_ether_api.h> header out of <linux/if_ether.h>
      headers/deps: net: Optimize <linux/if_ether.h>
      headers/deps: lib/scatterlist: Split <linux/scatterlist.h> into <linux/scatterlist_types.h> and <linux/scatterlist_api.h> headers
      headers/deps: lib/scatterlist: Optimize the default <linux/scatterlist.h> header, remove the <linux/scatterlist_api.h> header
      headers/deps: lib/scatterlist: Optimize <linux/scatterlist_types.h> dependencies, remove <linux/mm.h>
      headers/deps: lib/scatterlist: Optimize the <linux/scatterlist_types.h> header, remove <linux/io.h>
      headers/deps: lib/scatterlist: Optimize <linux/scatterlist_types.h>, remove <linux/bug.h>
      headers/deps: lib/scatterlist: Optimize <linux/scatterlist_types.h>, remove <linux/string.h>
      headers/deps: x86/mm/64: Move the vmemmap definitions from the pgtable.h hierarchy over into page.h
      headers/deps: mm: Split out <linux/mm_page_address.h> definitions
      headers/deps: dma-mapping: Optimize <linux/dma-mapping.h> dependencies, remove <linux/mm.h>
      headers/deps: locking/spinlocks: Create a standard <linux/spinlock[_types|_api].h> header split
      headers/deps: x86/asm: Split out <asm/ptrace_types.h> from <asm/ptrace.h>
      headers/deps: x86/asm: Optimize <asm/processor.h>
      headers/deps: x86/hyperv: Decouple <clocksource/hyperv_timer.h> from low level x86 headers
      headers/deps: x86/mm: Move the page address definitions from <asm/page.h> to <asm/page_types.h>
      headers/deps: mm: Optimize <linux/mm_page_address.h>, use <asm/page_types.h>
      headers/deps: locking/spinlocks: Optimize <linux/spinlock.h> dependencies, remove the <linux/spinlock_api.h> inclusion
      headers/deps: fs/dcache: Optimize <linux/dcache.h>, remove <linux/spinlock_api.h>
      headers/deps: fs: Optimize <linux/fs.h> dependencies
      headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition
      headers/deps: x86/mm: Optimize <asm/page_types.h> header dependencies
      headers/deps: x86/mm: Optimize <asm/pgtable_types.h> header dependencies
      headers/deps: x86/cpu: Decouple <asm/cpufeature.h> and <asm/processor.h>
      headers/deps: x86/msr: Split out the <asm/msr_types.h> header from <asm/msr.h>
      headers/deps: x86/cpu: Optimize <asm/processor.h> dependencies
      headers/deps: mm/mmzone: Optimize <linux/mmzone.h> dependencies, remove <linux/memory_hotplug.h> inclusion
      headers/deps: mm/mmzone: Optimize <linux/mmzone.h> dependencies, remove <linux/spinlock_api.h> inclusion
      headers/deps: mm: Optimize <linux/mm.h>, remove <linux/spinlock_api.h>
      headers/deps: ACPICA: Split locking definitions into <acpi/platform/aclinuxex_locking.h>
      headers/deps: hashtables: Split <linux/hashtables.h> into <linux/hashtable_types.h> and <linux/hashtable_api.h>
      headers/deps: hashtable: Optimize <linux/hashtable.h> dependencies, remove <linux/hashtable_api.h>
      headers/deps: hashtable: Optimize the <linux/hashtable_types.h> header
      headers/deps: Optimize kernel/sched/clock.c dependencies
      headers/deps: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
      headers/deps: Fix comment typo in kernel/sched/cpudeadline.c
      headers/deps: Make the <linux/sched/deadline.h> header build standalone
      headers/deps: Introduce kernel/sched/build_utility.c and build multiple .c files there
      headers/deps: Introduce kernel/sched/build_policy.c and build multiple .c files there
      headers/deps: Standardize kernel/sched/sched.h header dependencies
      headers/deps: Reorganize, clean up and optimize kernel/sched/core.c dependencies
      headers/deps: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
      headers/deps: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
      headers/deps: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
      headers/deps: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
      headers/deps: locking: Move more lock-debug definitions from <linux/lockdep.h> to <linux/lockdep_types.h>
      headers/deps: Use <linux/lockdep_types.h> instead of <linux/lockdep.h> in <linux/sched.h>
      headers/deps: bitops: Split out <linux/bitops_types.h> header
      headers/deps: locking: Move <linux/seqlock.h> to <linux/seqlock_types.h>
      headers/deps: timers/hrtimer: Merge <linux/hrtimer_defs.h> and <linux/hrtimer.h> into <linux/hrtimer_types.h>
      headers/deps: time: Move <linux/ktime.h> to <linux/ktime_types.h>
      headers/deps: workqueue: Move <linux/workqueue.h> to <linux/workqueue_types.h>
      headers/deps: idr: Move <linux/idr.h> to <linux/idr_types.h>
      headers/deps: sched/swait: Move <linux/swait.h> to <linux/swait_types.h>
      headers/deps: percpu: Move <linux/percpu_counter.h> to <linux/percpu_counter_types.h>
      headers/deps: mm: Move <linux/writeback.h> to <linux/writeback_types.h>
      headers/deps: syscalls: Move <linux/syscalls.h> to <linux/syscalls_types.h>
      headers/deps: net: Optimize the <linux/skbuff_types.h> header dependencies, remove <linux/ktime_api.h>
      headers/deps: locking/refcount: Split <linux/refcount.h> into <linux/refcount_types.h> and <linux/refcount_api.h>
      headers/deps: net: Optimize <linux/skbuff.h> header dependencies, remove <linux/refcount_api.h>
      headers/deps: locking: Split <linux/atomic.h> into <linux/atomic_types.h> and <linux/atomic_api.h>
      headers/deps: kref: Split <linux/kref.h> into <linux/kref_types.h> and <linux/kref_api.h>
      headers/deps: locking/refcount: Optimize the <linux/refcount.h> header, remove <linux/refcount_api.h>
      headers/deps: kref: Optimize the <linux/kref.h> header, remove <linux/kref_api.h>
      headers/deps: time: Move <linux/timerqueue.h> to <linux/timerqueue_types.h>
      headers/deps: time: Move <linux/rbtree.h> to <linux/rbtree_api.h>
      headers/deps: rbtree: Optimize <linux/rbtree.h> dependencies, remove the <linux/rbtree_api.h> inclusion
      headers/deps: locking/atomics: Move the atomic_long_t definition in <linux/types.h>
      headers/deps: netdevice: Simplify <linux/netdevice_types.h> a bit
      headers/deps: drivers/core: Split <linux/device.h> into <linux/device_types.h> and <linux/device_api.h>
      headers/deps: driver/core: Optimize <linux/device_types.h> dependencies
      headers/deps: net: Optimize <linux/netdevice_types.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: kobject: Split <linux/kobject.h> into <linux/kobject_types.h> and <linux/kobject_api.h>
      headers/deps: kobject: Optimize <linux/kobject.h> dependencies, remove the <linux/kobject_api.h> header
      headers/deps: of: Split <linux/of.h> into <linux/of_types.h> and <linux/of_api.h>
      headers/deps: of: Optimize <linux/of.h> dependencies, remove <linux/of_api.h>
      headers/deps: ACPI: Optimize <linux/acpi.h> dependencies, remove <linux/irqdomain.h> inclusion
      headers/deps: of: Optimize <linux/of_types.h> dependencies
      headers/deps: arm64/mm: Prepare <asm/pgtable_types.h> for generic use
      headers/deps: mm: Split <linux/pgtable.h> into <linux/pgtable_types.h> and <linux/pgtable_api.h>
      headers/deps: mm: Optimize <linux/pgtable.h> dependencies - remove the <linux/pgtable_api.h> inclusion
      headers/deps: csd: Move <linux/smp.h> to <linux/smp_api.h>
      headers/deps: csd: Move 'struct __call_single_data' definition and initialization helpers from <linux/smp_api.h> to <linux/smp_types.h>
      headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
      headers/deps: mm/fixmap: Don't include <linux/mm_types.h> in a low level header
      headers/deps: mm: Clean up <linux/mm_types.h>, introduce <linux/mm_api.h>
      headers/deps: mm: Decouple <linux/swap.h> from <linux/vmstat.h>
      headers/deps: mm/thp: Move the PageTrans*() methods to <linux/page-flags-thp.h>
      headers/deps: mm: Further split up <linux/mm.h> into <linux/mm_types.h> and <linux/mm_api.h>
      headers/deps: mm: Move <linux/vmstat.h> out of the middle of <linux/mm_api.h> and clean up its dependencies
      headers/deps: locking/seqlocks: Split <linux/seqcount_types.h> out of <linux/seqlock_types.h>
      headers/deps: mm: Simplify <linux/mm_types.h>
      headers/deps: notifiers: Split <linux/notifier.h> into <linux/notifier_types.h> and <linux/notifier_api.h>
      headers/deps: uprobes: Optimize <linux/uprobes.h> and x86 <asm/uprobes.h> dependencies
      headers/deps: mm: Optimize <linux/mm_types.h> dependencies
      headers/deps: arm64: Duplicate the vabits_actual declaration
      headers/deps: notifiers: Optimize <linux/notifier.h> dependencies, remove <linux/notifier_api.h> inclusion
      headers/deps: mm: Move the minimal KASAN API bits to <linux/mm_api_kasan.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <linux/dma-mapping.h>
      headers/deps: cpumask: Split <linux/cpumask.h> into <linux/cpumask_types.h> and <linux/cpumask_api.h>
      headers/deps: cpumask: Simplify <linux/cpumask_types.h>
      headers/deps: cpumask: Optimize <linux/cpumask.h>, remove <linux/cpumask_api.h>
      headers/deps: RCU: Remove __read_mostly annotations from externs
      headers/deps: x86/cpu, arm64/cpu: Split out <asm/processor_api.h> from <asm/processor.h>
      headers/deps: x86/asm: Split <asm/segment.h> into <asm/segment_types.h> and <asm/segment_api.h>
      headers/deps: x86/cpu: Optimize <asm/processor.h> dependencies
      headers/deps: x86/cpu: Move <asm/processor.h> to <asm/processor_types.h>
      headers/deps: mm: Move the VM_* flag definitions from <linux/mm_api.h> to <linux/mm_types.h>
      headers/deps: mm: Move the gate VMA related methods from <linux/mm_api.h> into <linux/mm_api_gate_area.h>
      headers/deps: mm: Split <linux/mm_api_kvmalloc.h> methods out of <linux/slab.h>
      headers/deps: mm: Split out the <linux/mm_api_truncate.h> APIs from <linux/mm_api.h>
      headers/deps: kallsyms: Optimize the <linux/kallsyms.h> header, remove <linux/mm_api.h>
      headers/deps: fs/xattr: Optimize <linux/xattr.h> dependencies, use the new <linux/mm_api_kvmalloc.h> header
      headers/deps: mm: Optimize <linux/mm_api.h>, remove the <linux/mm_api_gate_area.h> header
      headers/deps: mm: Optimize <linux/slab.h>, remove the <linux/mm_api_kvmalloc.h> header inclusion
      headers/deps: mm: Optimize <linux/mm_api.h>, remove the <linux/mm_truncate.h> header
      headers/deps: mm: Optimize <linux/mm.h>, remove <linux/mm_api.h> inclusion
      headers/deps: locking/atomics: Optimize <linux/atomic.h>, remove the <linux/atomic_api.h> inclusion
      headers/deps: PCI: Optimize <linux/pci.h>, remove the <linux/pci-dma-compat.h> header
      headers/deps: xarray: Split <linux/xarray.h> into <linux/xarray_types.h> and <linux/xarray_api.h>
      headers/deps: Optimize <linux/xarray.h>, remove the <linux/xarray_api.h> inclusion
      headers/deps: dma-mapping: Optimize <linux/dma-mapping.h.h> dependencies, remove <linux/mm_api.h> inclusion
      headers/deps: net: Split <linux/skbuff_api_frag.h> out of <linux/skbuff_api.h>
      headers/deps: net: Move netlink_skb_clone() into its own header
      headers/deps: net: Optimize <linux/skbuff_api.h>, remove the <linux/skbuff_api_frag.h> inclusion
      headers/deps: mm: Move the gfpflags_allow_blocking() method from <linux/gfp_api.h> to <linux/gfp_types.h>
      headers/deps: Move the dev_alloc*() methods from <linux/skbuff_api.h> to <linux/skbuff_api_frag.h>
      headers/deps: net: Split <linux/skbuff_api_page_pool.h> from <linux/skbuff_api.h>
      headers/deps: mm: Split the <linux/mm_api_exe_file.h> header out of <linux/mm_api.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove the <linux/mm_api.h> inclusion
      headers/deps: EFI: Move efivar_unregister() to its sole user
      headers/deps: driver/core: Move more types into <linux/device_types.h>
      headers/deps: bdi: Decouple <linux/backing-dev-api.h> from <linux/kref_api.h>
      headers/deps: kobject: Move kobject_name() from <linux/kobject_api.h> to <linux/kobject_types.h>
      headers/deps: driver/core: Move the device_name() method from <linux/device_api.h> to <linux/device_types.h>
      headers/deps: kobject: Move global variables into <linux/kobject_types.h>
      headers/deps: device/core: Move kobj_to_dev() from <linux/device_api.h> to <linux/device_types.h>
      headers/deps: locking/lockdep: Optimize <linux/lockdep.h> dependencies
      headers/deps: locking/debug: Optimize <linux/debug_locks.h> dependencies
      headers/deps: x86/elf: Optimize <asm/elf.h> dependencies, split out <asm/elf_api.h>
      headers/deps: net: Optimize <linux/netdevice_api.h>, remove the <linux/device.h> inclusion
      headers/deps: PCI: Optimize <linux/pci.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: mm: Optimize <linux/node.h> dependencies
      headers/deps: i2c: Optimize <linux/i2c.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: block: Optimize <linux/blk_types.h> dependencies, remove the <linux/device_api.h> inclusion
      headers/deps: dma-mapping: Optimize <linux/dma-mapping.> dependencies, remove <linux/device_api.h>
      headers/deps: USB: Optimize <linux/usb/ch9.h> dependencies, remove <linux/device.h>
      headers/deps: DRM: Optimize <drm/drm_print.h> dependencies
      headers/deps: driver/core: Optimize <linux/genhd.h> and <linux/platform_device.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: PM/runtime: Optimize <linux/pm_runtime.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: USB: Optimize <linux/usb.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: ACPI: Optimize <linux/acpi.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: driver/core: Move the dev_driver_string() method from <linux/device_api.h> to <linux/device_types.h>
      headers/deps: video/hdmi: Optimize <linux/hdmi.h> dependencies, remove <linux/device_api.h>
      headers/deps: ALSA: Optimize <sound/core.h> dependencies, remove <linux/drivers_api.h> inclusion
      headers/deps: locking: Split <linux/filter.h> into <linux/filter_types.h> and <linux/filter_api.h>
      headers/deps: net: Split <net/sch_generic.h> into <net/sch_generic_types.h> and <net/sch_generic_api.h>
      headers/deps: net: Optimize <net/sock.h>, remove <linux/filter.h> inclusion
      headers/deps: net: Split <net/sock.h> into <net/sock_types.h> and <net/sock_api.h>
      headers/deps: net: Optimize <net/sock.h> dependencies, remove <net/sock_api.h> inclusion
      headers/deps: net: Split <net/ipv6_api_sock.h> header out of <net/ipv6.h>
      headers/deps: net: Move net_sock() from <net/sock_api.h> to <net/sock_types.h>
      headers/deps: net: Move 'struct proto' from <net/sock_api.h> to <net/sock_types.h>
      headers/deps: net: Move sk_fullsock() from <net/sock_api.h> to <net/sock_types.h>
      headers/deps: net: Move 'struct sockcm_cookie' from <net/sock_api.h> to <net/sock_types.h>
      headers/deps: net: Split <net/route.h> into <net/route_types.h> and <net/route_api.h>
      headers/deps: net: Optimize <net/route.h> dependencies, remove <net/route_api.h> inclusion
      headers/deps: net: Move more constants from <net/sock_api.h> to <net/sock_types.h>
      headers/deps: ipv6: Move __inet6_lookup_skb() next to its primary user
      headers/deps: net: Optimize <net/request_sock.h> dependencies, remove <net/sock_api.h>
      headers/deps: net: Decouple <net/udp.h> from <net/sock_api.h>
      headers/deps: net/rds: Decouple <net/rds/rds.h> from <net/sock_api.h>
      headers/deps: net: Optimize <net/ip.h> dependencies, remove <net/route_api.h> and <net/sock_api.h> dependencies
      headers/deps: net: Move read_pnet() from <net/net_namespace.h> into <net/net_namespace_types_possible.h>
      headers/deps: net: Optimize <net/sock_types.h> dependencies, remove various headers
      headers/deps: net: Optimize <linux/inet_hashtables.h> dependencies, remove <net/route_api.h> inclusion
      headers/deps: net: Optimize <net/fib_notifier.h> dependencies
      headers/deps: net: Split <linux/siphash.h> into <linux/siphash_types.h> and <linux/siphash_api.h>
      headers/deps: net: Optimize <net/flow_dissector.h> dependencies
      headers/deps: time: Split <linux/time64.h> into <linux/time64_types.h> and <linux/time64_api.h>
      headers/deps: iov: Split <linux/uio.h> into <linux/uio_types.h> and <linux/uio_api.h>
      headers/deps: net: Optimize <linux/socket.h> dependencies
      headers/deps: net: Optimize <net/flow.h> dependencies a bit
      headers/deps: net: Move the 'struct sk_buff_head' definition to <linux/skbuff_types_head.h> header
      headers/deps: net: Optimize <linux/netdevice_types.h> dependencies
      headers/deps: notifiers: Move the NOTIFY_* constants into <linux/notifier_types.h>
      headers/deps: locking: Split <linux/osq_lock.h> into <linux/osq_lock_types.h> and <linux/osq_lock_api.h>
      headers/deps: locking/mutexes: Split <linux/mutex.h> into <linux/mutex_types.h> and <linux/mutex_api.h>
      headers/deps: PM/core: Optimize <linux/pm.h> dependencies
      headers/deps: net/dql: Split <linux/dynamic_queue_limits.h> into <linux/dynamic_queue_limits_types.h> and <linux/dynamic_queue_limits_api.h>
      headers/deps: net: Optimize <linux/netdevice_types.h> dependencies a bit
      headers/deps: net: Optimize <uapi/linux/if_addr.h> dependencies
      headers/deps: net: Optimize <uapi/linux/neighbour.h> dependencies
      headers/deps: net: Optimize <uapi/linux/rtnetlink.h> dependencies
      headers/deps: net: Optimize <linux/rtnetlink.h> dependencies
      headers/deps: net: Split <net/scm.h> into <net/scm_types.h> and <net/scm_api.h>
      headers/deps: net: Optimize <linux/netlink.h> dependencies
      headers/deps: net: Split <net/netlink.h> into <net/netlink_types.h> and <net/netlink_api.h>
      headers/deps: net: Optimize <net/netlink_types.h> dependencies
      headers/deps: net: Optimize <net/netlink.h> dependencies
      headers/deps: net: Split <net/rtnetlink.h> into <net/rtnetlink_types.h> and <net/rtnetlink_api.h>
      headers/deps: net: Optimize <net/rtnetlink.h> dependencies, remove <linux/rtnetlink_api.h> inclusion
      headers/deps: net: Split <net/inet_connection_sock.h> into <net/inet_connection_sock_types.h> and <net/inet_connection_sock_api.h>
      headers/deps: net: Split <net/inet_sock.h> into <net/inet_sock_types.h> and <net/inet_sock_api.h>
      headers/deps: net: Optimize <net/inet_sock.h> dependencies
      headers/deps: net: Split <net/request_sock.h> into <net/request_sock_types.h> and <net/request_sock_api.h>
      headers/deps: net: Optimize <net/request_sock_types.h> dependencies
      headers/deps: net: Optimize <net/inet_connection_sock_types.h> dependencies
      headers/deps: net: Optimize <net/inet_timewait_sock.h> dependencies
      headers/deps: net: Split <net/inet_timewait_sock.h> into <net/inet_timewait_sock_types.h> and <net/inet_timewait_sock_api.h>
      headers/deps: locking: Split <linux/u64_stats_sync.h> into <linux/u64_stats_sync_types.h> and <linux/u64_stats_sync_api.h>
      headers/deps: net: Optimize <net/inet_sock_types.h> dependencies
      headers/deps: net: Optimize <linux/kernel_stat_types.h> dependencies for the !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE case
      headers/deps: net: Optimize <linux/cgroup_types.h> dependencies
      headers/deps: cgroups: Optimize <linux/bpf-cgroup-types.h> dependencies
      headers/deps: net: Optimize <net/inet_timewait_sock_types.h> dependencies
      headers/deps: net: Move skb_transport_header() and skb_inner_transport_header() from <linux/skbuff_api.h> to <linux/skbuff_types.h>
      headers/deps: net: Optimize <linux/tcp.h> dependencies, remove various headers
      headers/deps: locking/rwsems: Split <linux/rwsem.h> into <linux/rwsem_types.h> and <linux/rwsem_api.h>
      headers/deps: locking/rwsem: Optimize <linux/rwsem_types.h> dependencies
      headers/deps: mm: Move the __pa_symbol() and lm_alias() defaults to <linux/mm_api.h>
      headers/deps: mm: Optimize <linux/mm_types_task.h> dependencies
      headers/deps: x86/mm: Optimize <asm/mmu.h> dependencies
      headers/deps: mm: Optimize <linux/mm_types.h> dependencies, remove <linux/rwsem_api.h> inclusion
      headers/deps: tracing: Optimize <linux/trace_events.h> dependencies some more
      headers/deps: radix-tree: Optimize <linux/radix-tree.h> dependencies
      headers/deps: net: Optimize <net/timewait_sock.h> dependencies
      headers/deps: seccomp: Optimize <linux/seccomp_types.h> dependencies
      headers/deps: sched/header, x86: Optimize <asm/preempt.h> dependencies
      headers/deps: llist: Split <linux/llist.h> into <linux/llist_types.h> and <linux/llist_api.h>
      headers/deps: llist: Optimize <linux/llist.h>, remove <linux/llist_api.h> inclusion
      headers/deps: net: Optimize <linux/filter.h> dependencies, remove <linux/filter_api.h> inclusion
      headers/deps: net: Optimize <linux/filter_types.h> dependencies
      headers/deps: locking/mutexes: Optimize <linux/mutex.h> dependencies, remove <linux/mutex_api.h> inclusion
      headers/deps: locking/mutexes: Reduce <linux/mutex_api.h> dependencies
      headers/deps: drivers/core: Move the device_lock*() APIs from <linux/device_api.h> to the new <linux/device_api_lock.h> header
      headers/deps: locking/rwsems: Optimize <linux/rwsem.h> dependencies, remove <linux/rwsem_api.h> inclusion
      headers/deps: locking: Optimize <asm-generic/qrwlock.h> dependencies, remove <asm/processor.h> and <asm/barrier.h> inclusions
      headers/deps: x86/paravirt: Optimize <asm/paravirt_types.h> dependencies
      headers/deps: locking/x86: Optimize <asm/spinlock.h> dependencies
      headers/deps: x86/paravirt: Optimize <asm/paravirt.h> dependencies
      headers/deps: locking/x86: Optimize <asm/qspinlock.h> dependencies
      headers/deps: smp: Optimize <linux/smp_types.h> dependencies
      headers/deps: Optimize <linux/jump_label.h>, remove the <linux/atomic_api.h> inclusion in the CONFIG_JUMP_LABEL=y case
      headers/deps: smp: Optimize <linux/smp_api.h> dependencies
      headers/deps: smp/x86: Optimize <asm/smp.h> dependencies
      headers/deps: x86: Rename <asm/cpumask.h> to <asm/cpumask_arch.h>
      headers/deps: fs: Introduce <linux/fs_api_dir_context.h> header
      headers/deps: fs: Optimize <linux/fs.h> dependencies, remove <linux/fs_entry_types.h> inclusion
      headers/deps: fs: Split <linux/fs.h> into <linux/fs_types.h> and <linux/fs_api.h>
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies
      headers/deps: rcu: Split <linux/rcuwait.h> into <linux/rcuwait_types.h> and <linux/rcuwait_api.h>
      headers/deps: net: Split <linux/percpu_rwsem.h> into <linux/percpu_rwsem_types.h> and <linux/percpu_rwsem_api.h>
      headers/deps: net: Split <linux/rcu_sync.h> into <linux/rcu_sync_types.h> and <linux/rcu_sync_api.h>
      headers/deps: locking/percpu-rwsems: Optimize <linux/percpu_rwsem_types.h> dependencies
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies
      headers/deps: locking/percpu-rwsems: Optimize <linux/percpu_rwsem.h> dependencies
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/dcache.h> inclusion
      headers/deps: net: Split <linux/list_bl.h> into <linux/list_bl_types.h> and <linux/list_bl_api.h>
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies
      headers/deps: list_bl: Optimize <linux/list_bl.h> dependencies
      headers/deps: net: Optimize <linux/fcntl.h> dependencies
      headers/deps: list_lru: Split <linux/list_lru.h> into <linux/list_lru_types.h> and <linux/list_lru_api.h>
      headers/deps: list_lru: Optimize <linux/list_lru_types.h> dependencies
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/list_lru_api.h> inclusion
      headers/deps: fs: Optimize <linux/fs.h> dependencies, remove <linux/fs_api.h> inclusion
      headers/deps: fs: Move i_size_read() from <linux/fs_api.h> to <linux/fs_types.h>
      headers/deps: fs: Move inode_unhashed() from <linux/fs_api.h> to <linux/fs_types.h>
      headers/deps: block: Optimize <linux/genhd.h> dependencies, remove <linux/fs_api.h> inclusion
      headers/deps: fs: Optimize <linux/seq_file.h> dependencies
      headers/deps: net: Move neigh_output() and helper function into <net/neighbour_api_output.h>
      headers/deps: net/rps: Factor out the rps_sock_flow_table functionality from header files and move it into net/core/dev.c
      headers/deps: u64_stats: Move the u64_stats_t types into <linux/u64_stats_sync_types.h>
      headers/deps: net_namespace: Move write_pnet() to <net/net_namespace_types_possible.h>
      headers/deps: net/dev: Move lightweight types & methods from <linux/netdevice_api.h> to <linux/netdevice_types.h>
      headers/deps: net/ip6: Factor out <net/ip6_route_api_mtu.h> from <net/ip6_route.h>
      headers/deps: net/gso: Move inet_gro_compute_pseudo() from <net/ip.h> to its own header in <net/ip_api_gro.h>
      headers/deps: net: Optimize <net/neighbour.h> dependencies, remove <linux/netdevice_api.h> inclusion
      headers/deps: net: Split <net/net_namespace_api.h> from <net/net_namespace.h>
      headers/deps: net/ns: Move net_eq() from <net/net_namespace_api.h> to <net/net_namespace_types.h>
      headers/deps: net/ns: Move net_namespace_list methods from <net/net_namespace_api.h> to <net/net_namespace_types.h>
      headers/deps: net: Optimize <net/net_namespace.h> dependencies
      headers/deps: net: Optimize <net/netns/ipv4.h> dependencies
      headers/deps: net: Optimize <net/netns/ipv6.h> dependencies
      headers/deps: net: Optimize <net/netns/ieee802154_6lowpan.h>> dependencies
      headers/deps: net: Optimize <net/net_namespace_types.h> dependencies
      headers/deps: net: Optimize <linux/notifier_api.h> dependencies
      headers/deps: net: Split <linux/netfilter/nf_conntrack_common_api.h> from <linux/netfilter/nf_conntrack_common.h>
      headers/deps: Move more APIs from <linux/device_api.h> to <linux/device_api_lock.h>
      headers/deps: device/core: Move dev_get_platdata() from <linux/device_api.h> to <linux/device_types.h>
      headers/deps: dev/core: Optimize <linux/device.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: kobject: Optimize <linux/kobject_api.h> dependencies, remove <linux/kref_api.h> inclusion
      headers/deps: driver core: Optimize <linux/fwnode.h> dependencies, remove <linux/device_api_lock.h> inclusion
      headers/deps: drivers/core: Remove unnecessary <linux/fwnode.h> inclusions
      headers/deps: of: Optimize <linux/of_api.h> dependencies
      headers/deps: keys: Optimize <linux/key.h> dependencies, remove <linux/sysctl.h>
      headers/deps: keys: Optimize <linux/key.h> dependencies, remove <linux/rwsem_api.h>
      headers/deps: keys: Optimize <linux/key.h> dependencies, remove <linux/refcount_api.h>
      headers/deps: of: Optimize <linux/of_api.h> dependencies, remove <linux/property.h> inclusion
      headers/deps: keys: Optimize <linux/key.h> dependencies, remove <linux/rcupdate.h> inclusion
      headers/deps: net: Split <linux/tasklet_types.h> and <linux/tasklet_api.h> out of <linux/interrupt.h>
      headers/deps: genirq: Optimize <linux/irq.h> dependencies
      headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove the <linux/tasklet_api.h> inclusion
      headers/deps: genirq: Split <linux/softirq.h> out of <linux/interrupt.h>
      headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/softirq.h> inclusion
      headers/deps: genirq: Move hard_irq_disable() from <linux/interrupt.h> to <linux/hardirq.h>
      headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/hardirq.h>
      headers/deps: Remove <linux/hardirq.h> inclusions from headers that don't need it anymore
      headers/deps: genirq: Optimize <linux/interrupt.h> dependencies, remove <linux/atomic_api.h> inclusion
      headers/deps: locking/lockdep: Split <linux/lockep.h> into <linux/lockep_types.h> and <linux/lockep_api.h>
      headers/deps: locking/lockdep: Optimize <linux/lockdep.h> dependencies, remove <linux/lockdep_api.h> inclusion
      headers/deps: net: Optimize <linux/etherdevice_api.h> dependencies
      headers/deps: net: Factor out various <linux/etherdevice_api.h> methods into <linux/etherdevice_api_addr.h>
      headers/deps: net: Optimize <linux/if_vlan_api.h> dependencies, remove the <linux/etherdevice_api.h> inclusion
      headers/deps: net: Optimize <linux/etherdevice_api.h> dependencies: remove <linux/etherdevice_api.h> inclusions from headers
      headers/deps: Move netdev_priv() from <linux/netdevice_api.h> to <linux/netdevice_types.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <linux/skbuff_api.h> from headers that don't need it
      headers/deps: net: Optimize <linux/etherdevice_types.h> dependencies
      headers/deps: sched: Optimize <linux/sched/topology.h> dependencies, remove <linux/cpumask_api.h> inclusion
      headers/deps: cpumask: Optimize <linux/cpumask_api.h> dependencies, move accessor methods to <linux/cpumask_types.h>
      headers/deps: cpumask: Optimize <linux/cpumask_api.h> dependencies, remove unnecessary <linux/cpumask_api.h> inclusions
      headers/deps: cpumask: Optimize <linux/cpumask_api.h> dependencies, move the cpu_max_bits_warn() and cpumask_check() methods to <linux/cpumask_types.h>
      headers/deps: net: Move per-cpu stats methods from <linux/netdevice_api.h> into the new <linux/netdevice_api_pcpu_stats.h> header
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove <linux/cpumask_api.h> inclusion
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove <linux/device_api.h> inclusion
      headers/deps: acpi: Optimize <acpi/acpi_bus.h> dependencies
      headers/deps: PCI: Convert pci_is_enabled() to a macro
      headers/deps: PCI: Optimize <linux/pci.h> dependencies, remove <linux/atomic_api.h> inclusion
      headers/deps: locking/mutexes: Optimize <linux/mutex_api.h> dependencies, remove <linux/osq_lock_api.h> inclusion
      headers/deps: locking/mutexes: Optimize <linux/mutex_api.h> dependencies, remove <linux/atomic_api.h> inclusion
      headers/deps: locking/rwsem: Optimize <linux/rwsem_api.h> dependencies
      headers/deps: locking/rwsem: Optimize <linux/rwsem_api.h> dependencies some more
      headers/deps: resource: Split <linux/resource_ext.h> into <linux/resource_ext_types.h> and <linux/resource_ext_api.h>
      headers/deps: resource: Optimize <linux/resource_ext.h> dependencies, remove <linux/resource_ext_api.h> inclusion
      headers/deps: workqueue: Optimize <linux/workqueue_api.h> dependencies
      headers/deps: compiler: Move __must_be_array() from <linux/compiler.h> to <linux/compiler_types.h>
      headers/deps: kernel: Optimize <linux/build_bug.h> and <linux/kstrtox.h> dependencies, remove <linux/compiler.h> inclusion
      headers/deps: net: Split <linux/skbuff_api_nf.h> out of <linux/skbuff_api.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <linux/netfilter/nf_conntrack_common_api.h> inclusion
      headers/deps: net: Split <linux/netdevice_api_prefetch.h> out of <linux/netdevice_api.h>
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove <linux/prefetch.h> inclusion
      headers/deps: net: Split locking methods out of <linux/netdevice_api.h>, into the new <linux/netdevice_api_lock.h> header
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove <linux/capability.h> inclusion
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove <linux/hrtimer.h> inclusion
      headers/deps: net/core: Optimize <linux/netdevice_api.h> dependencies, remove <linux/delay.h> inclusion
      headers/deps: net: Optimize <net/netns/smc.h> dependencies
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies - remove misc headers
      headers/deps: net: Split <net/xdp.h> into <net/xdp_types.h> and <net/xdp_api.h>
      headers/deps: net: Move the ____cacheline_aligned_in_smp attributes to an easier to debug position
      headers/deps: net: Optimize <net/xdp.h> dependencies
      headers/deps: fs: Optimize <linux/dcache.h> dependencies, remove <linux/spinlock_types.h> inclusion
      headers/deps: list_bl: Move hlist_bl_unhashed() from <linux/list_bl_api.h> to <linux/list_bl_types.h>
      headers/deps: fs: Optimize <linux/dcache.h> dependencies, remove <linux/list_bl_api.h> inclusion
      headers/deps: vfs: Split <linux/vfs_pressure.h> out of <linux/dcache.h>
      headers/deps: fs: Optimize <linux/dcache.h> dependencies, remove <linux/math.h> inclusion
      headers/deps: fs: Optimize <linux/mount.h> dependencies
      headers/deps: irq: Move the generic chip locking methods into <linux/irq_api_gc_lock.h>
      headers/deps: irq: Optimize <linux/irq.h> dependencies
      headers/deps: irq: Move the IO methods into <linux/irq_api_io.h>
      headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <linux/io.h> inclusion
      headers/deps: irq: Move the generic effective IRQ affinity methods into <linux/irq_api_eff_affinity.h>
      headers/deps: irq: Optimize <linux/irq.h> dependencies
      headers/deps: irq: Move the generic IRQ chip freeing methods into <linux/irq_api_free.h>
      headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <linux/slab.h>
      headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <linux/irqdesc.h> inclusion
      headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <asm/ptrace.h> inclusion
      headers/deps: irq/x86: Optimize <asm/hw_irq.h> dependencies, remove <linux/profile.h> inclusion
      headers/deps: irq/x86: Move arch local definitions into the new <asm/x86_irq.h> header
      headers/deps: sched/wait: Optimize <linux/wait_api.h> dependencies, remove <linux/spinlock_api.h> inclusion
      headers/deps: net: Move seqlock related methods from <net/neighbour.h> to <net/neighbour_api_seqlock.h>
      headers/deps: net: Optimize <net/neighbour.h> dependencies, remove <linux/seqlock_api.h> inclusion
      headers/deps: net: Optimize <net/sch_generic.h> dependencies, remove <net/sch_generic_api.h> inclusion
      headers/deps: net: Optimize <net/pkt_sched.h> dependencies
      headers/deps: net: Move tcf_filter related methods from <net/pkt_cls.h> to <net/pkt_cls_api_tcf_filter.h>
      headers/deps: net: Optimize <net/pkt_cls.h> dependencies, remove <net/sch_generic_api.h> inclusion
      headers/deps: net: Move more types from <net/sch_generic_api.h> to <net/sch_generic_types.h>
      headers/deps: net: Optimize <net/pkt_cls.h> dependencies
      headers/deps: net: Optimize <linux/filter_api.h> dependencies, remove <net/sch_generic_api.h> inclusion
      headers/deps: net: Optimize <net/sch_generic_types.h> dependencies
      headers/deps: bpf: Optimize <linux/bpf.h> dependencies, remove <linux/rbtree_latch.h> inclusion
      headers/deps: mm: Optimize <sound/control.h> dependencies, remove <linux/spinlock_api.h> inclusion
      headers/deps: spi Optimize <linux/spi/spi.h> dependencies, remove <linux/spinlock_api.h> inclusion
      headers/deps: mm: Remove <asm/getorder.h> inclusions
      headers/deps: drm: Split <drm/drm_vma_manager_api_vm_lock.h> out of <drm/drm_vma_manager.h>
      headers/deps: mm/filemap: Split <linux/pagemap_api_readahead.h> out of <linux/pagemap_api_readahead.h>
      headers/deps: mm/filemap: Optimize <linux/pagemap.h> dependencies
      headers/deps: list_lru: Optimize <linux/list_lru.h> dependencies, remove <linux/list_lru_api.h> inclusion
      headers/deps: list_lru: Remove ____cacheline_aligned_in_smp designation from 'struct list_lru_node'
      headers/deps: list_lru: Optimize <linux/list_lru.h> dependencies, remove <linux/cache.h> inclusion
      headers/deps: time: Move shift_right() from <linux/timex.h> to <linux/math.h>
      headers/deps: time: Optimize <linux/jiffies.h> dependencies, remove <linux/timex.h> inclusion
      headers/deps: time: Optimize <linux/clocksource.h> dependencies, remove <linux/timex.h> inclusion
      headers/deps: mm: Move a couple of self-contained methods from <linux/mm_api.h> to <linux/mm_types.h>
      headers/deps: mm: Optimize <linux/mm_api.h> related dependencies
      headers/deps: mm: Move compound_nr() from <linux/mm_api.h> to <linux/mm_types.h>
      headers/deps: scatterlist: Optimize <linux/scatterlist_api.h> dependencies, remove <linux/mm_api.h> inclusion
      headers/deps: net: Move device statistics methods from <linux/netdevice_api.h> to <linux/netdevice_api_dev_stats.h>
      headers/deps: net: Optimize <net/snmp.h> dependencies, remove <linux/u64_stats_sync_api.h> inclusion
      headers/deps: uaccess: Optimize <linux/uaccess.h> dependencies
      headers/deps: sched: Optimize <linux/sched.h> dependencies
      headers/deps: mm/x86: Move the *access*permitted() methods into the new <asm/pgtable_access.h> header
      headers/deps: x86/mm: Optimize <asm/pgtable.h> dependencies, remove <asm/pkru> and <asm/fpu/api.h> inclusion
      headers/deps: x86/mm: Optimize <asm/pgtable.h> dependencies: remove <linux/mm_api_tlb_flush.h> inclusion
      headers/deps: net: Split <linux/udp_api.h> out of <linux/udp.h>
      headers/deps: net: Optimize <linux/udp.h> dependencies, remove <linux/skb_api.h> inclusion
      headers/deps: net: Move 'struct sock_cgroup_data' from <linux/cgroup_types.h> into its own header
      headers/deps: net: Move accessor methods from <net/request_sock_api.h> to <net/request_sock_types.h>
      headers/deps: net: Move accessor methods from <net/inet_sock_api.h> into <net/inet_sock_types.h>
      headers/deps: net: Optimize <net/inet_sock.h> dependencies, remove <net/inet_sock_api.h> inclusion
      headers/deps: net/udp: Move the UDP table definition & methods from <net/udp.h> to <net/udp_api_table.h>
      headers/deps: net/udp: Move udp_hashfn() from <linux/udp.h> to <linux/upd_api.h>
      headers/deps: net: Optimize <linux/udp.h> dependencies, remove <net/netns/hash.h> inclusion
      headers/deps: net/skbuff: Move accessor methods from <linux/skbuff_api.h> to <linux/skbuff_types.h>
      headers/deps: uio: Optimize <linux/uio.h> dependencies
      headers/deps: net: Optimize <linux/ipv6.h> dependencies, remove <linux/skbuff_api.h> inclusion
      headers/deps: net: Optimize <net/sock_types.h> dependencies, remove <linux/netdevice_types.h> inclusion
      headers/deps: locking/local, x86: Split <asm/local.h> into <asm/local_types.h> and <asm/local_api.h>
      headers/deps: locking/local, x86: Optimize <asm/local.h> dependencies, remove <asm/local_api.h> inclusion
      headers/deps: locking/local64, x86: Split <asm/local64.h> into <asm/local64_types.h> and <asm/local64_api.h>
      headers/deps: locking/local: Optimize <asm/local64.h> dependencies, remove <asm/local64_api.h> inclusion
      headers/deps: u64_stats: Optimize <linux/u64_stats_sync.h> dependencies, remove <linux/u64_stats_sync_api.h> inclusion
      headers/deps: net: Optimize <net/snmp.h> dependencies, remove <linux/u64_stats_sync_api.h> inclusion on 64-bit kernels
      headers/deps: net: Optimize <net/netns/xdp.h> dependencies, remove <linux/rculist.h> inclusion
      headers/deps: net: Optimize <net/netns/xfrm.h> dependencies, remove various headers
      headers/deps: net: Split <net/ipv6.h> into <net/ipv6_types.h> and <net/ipv6_api.h>
      headers/deps: net: Optimize <net/ipv6.h> dependencies, remove <net/ipv6_api.h> inclusion
      headers/deps: net: Optimize <net/ipv6_types.h> dependencies
      headers/deps: net: Split <net/dst.h> into <net/dst_types.h> and <net/dst_api.h>
      headers/deps: net: Optimize <net/dst.h> dependencies, remove <net/dst_api.h> inclusion
      headers/deps: net: Optimize <net/dst_types.h> dependencies
      headers/deps: net: Split <net/ip_fib.h> into <net/ip_fib_types.h> and <net/ip_fib_api.h>
      headers/deps: net: Optimize <net/ip_fib.h> dependencies, remove <net/ip_fib_api.h> inclusion
      headers/deps: net: Optimize <net/ip_fib_types.h> dependencies
      headers/deps: net: Split <net/ndisc.h> into <net/ndisc_types.h> and <net/ndisc_api.h>
      headers/deps: net: Optimize <net/ndisc.h> dependencies, remove <net/ndisc_api.h> inclusion
      headers/deps: net: Optimize <net/route_types.h> dependencies
      headers/deps: net: Optimize <linux/netdev_features.h> dependencies, remove <linux/bitops.h>
      headers/deps: net: Remove unused is_etherdev_addr()
      headers/deps: net: Move rare & expensive APIs from <linux/netdevice_api.h> to <linux/netdevice_api_extra.h>
      headers/deps: net: Optimize <linux/netdevice_api.h> dependencies, remove various headers
      headers/deps: rcu: Split out debug methods from <linux/rcupdate.h> into <linux/rcupdate_api_debug.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <linux/rcupdate.h> inclusion
      headers/deps: net: Move rare & expensive APIs from <linux/skbuff_api.h> to <linux/skbuff_api_extra.h>
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <net/checksum.h> inclusion
      headers/deps: net: Optimize <linux/skbuff_api.h> dependencies, remove <net/flow_dissector.h> inclusion
      headers/deps: net: Split <net/neighbour.h> into <net/neighbour_types.h> and <net/neighbour_api.h>
      headers/deps: net: Optimize <net/neighbour.h> dependencies, remove <net/neighbour_api.h> inclusion
      headers/deps: net: Optimize <net/dst_api.h> dependencies, remove various headers
      headers/deps: net: Move *skb_tunnel_rx() from <net/dst_api.h> to <net/dst_api_tunnel.h>
      headers/deps: net: Optimize <net/dst_api.h> dependencies, remove <linux/netdevice.h> inclusion
      headers/deps: net: Optimize <net/dst_api.h> dependencies, remove <net/net_namespace_types.h> inclusion
      headers/deps: time: Optimize <linux/jiffies.h> dependencies, remove <linux/cache.h> inclusion
      headers/deps: time: Optimize <linux/ktime_api.h> dependencies, remove <linux/jiffies.h> inclusion
      headers/deps: net: Split <linux/mmzone.h> into <linux/mmzone_types.h> and <linux/mmzone_api.h>
      headers/deps: mm: Optimize <linux/gfp_api.h> dependencies, remove <linux/mmzone_api.h> inclusion
      headers/deps: node: Optimize <linux/node.h> dependencies
      headers/deps: mm: Optimize <linux/page-flags-thp.h> dependencies, remove <linux/huge_mm.h> and <linux/mmzone_api.h> inclusion
      headers/deps: mm: Move put_swap_device() into its separate header in <linux/swap_api_device.h>
      headers/deps: mm: Optimize <linux/swap.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: mm: Optimize <linux/mempolicy.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: mm: Optimize <linux/sched/mm.h> dependencies, remove <linux/gfp_api.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/gfp_api.h> inclusion
      headers/deps: mm: Move rare & expensive APIs from <linux/mm_api.h> to <linux/mm_api_extra.h>"
      headers/deps: net: Optimize <linux/mm_api.h> dependencies, remove <linux/mm_api_extra.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies
      headers/deps: nfs: Optimize <linux/nfs_fs.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: mm: Move devmap methods from <linux/mm_api.h> to <linux/mm_api_extra.h>
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/memremap.h>
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/percpu-refcount.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/topology.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/bit_spinlock.h>
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmap_lock.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/irqflags.h> inclusion
      headers/deps: mm: Move page_needs_cow_for_dma() from <linux/mm_api.h> to <linux/mm_api_extra.h>
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/sched/coredump.h> inclusion
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mm_page_address.h> inclusion
      headers/deps: irq: Move the irq_handler_t definition to <linux/interrupt_types.h>
      headers/deps: pci: Optimize <linux/pci.h> dependencies, remove the <linux/interrupt.h> inclusion
      headers/deps: pci: Optimize <linux/pci.h> dependencies, remove <linux/io.h>
      headers/deps: pci/x86: Optimize <asm/pci.h> dependencies
      headers/deps: pci: Optimize <linux/pci.h> dependencies, remove <linux/topology.h> inclusion
      headers/deps: mm: Optimize <linux/dmapool.h> dependencies, remove <linux/scatterlist.h> and <asm/io.h> inclusion
      headers/deps: mm: Optimize <linux/mmzone.h> dependencies, remove <linux/mmzone_api.h> inclusion
      headers/deps: mm: Move the page flag mask definitions from <linux/mm_api.h> to <linux/page-flags-layout.h>
      headers/deps: mm/sparsemem: Move the set_page_section() and page_to_section() definitions from <linux/mm_api.h> to <linux/mmzone_api.h>
      headers/deps: mm/flatmem: Move the max_mapnr definitions from <linux/mm_api.h> to <linux/mmzone_types.h>
      headers/deps: mm: Implement better CONFIG_SPARSEMEM && !CONFIG_SPARSEMEM_VMEMMAP header hell quirks
      headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove <linux/mm_api.h> inclusion
      headers/deps: modules: Optimize <linux/buildid.h> dependencies, remove <linux/mm_types.h> inclusion
      headers/deps: x86/paravirt: Split sched_clock/steal_clock methods from <asm/paravirt.h>, into <asm/paravirt_api_clock.h>
      headers/deps: x86/paravirt: Optimize <linux/paravirt.h> dependencies - remove the <linux/paravirt_api_clock.h> inclusion
      headers/deps: x86/paravirt: Optimize <linux/paravirt.h> dependencies - remove the <linux/static_call_types.h> inclusion
      headers/deps: x86/paravirt: Optimize <linux/paravirt.h> dependencies - remove the <linux/bug.h> inclusion
      headers/deps: x86/speculation: Optimize <asm/nospec-branch.h> dependencies
      headers/deps: x86/paravirt: Optimize <linux/paravirt_types.h> dependencies
      headers/deps: x86/mm: Clean up <asm/pgtable.h> header section
      headers/deps: x86/mm: Optimize <asm/pgtable.h> dependencies, remove unused headers
      headers/deps: arm64/mm: Move the vmemmap definitions from the pgtable.h hierarchy over into <asm/page.h>
      headers/deps: arm64/mm: Move the hugetlb definitions from the pgtable.h hierarchy over into <asm/page.h>
      headers/deps: Reduce dependencies on <linux/init.h>'s __init* attributes in header prototypes
      headers/deps: Optimize <linux/sched.h> dependencies, remove <linux/uidgid.h> and <linux/rbtree.h> dependencies
      headers/deps: printk: Reduce <linux/printk.h> header dependencies, remove <linux/bitops.h>
      headers/deps: mm: Reduce <linux/sunrpc/xdr.h> dependencies, remove <linux/mm.h> inclusion
      headers/deps: sparc/mm: Remove <linux/sched.h> inclusion from the middle of <asm/pgtable_64.h>
      headers/deps, drm/vmwgfx: Include <asm/msr.h> when VMware mks-guest-stats are enabled
      headers/deps: kernel: Split <linux/bvec.h> into <linux/bvec_types.h> and <linux/bvec_api.h>
      headers/deps: bvec: Reduce <linux/bvec.h> dependencies, remove <linux/bvec_api.h> inclusion
      headers/deps: block: Optimize <linux/iocontext.h> dependencies
      headers/deps: irq: Optimize <linux/interrupt.h> dependencies
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/pgtable_api.h> inclusion
      headers/deps: mm: Move various rare APIs from <linux/mm_api.h> to <linux/mm_api_extra.h>
      headers/deps: mm: Move __pa_symbol() fallback definition from <linux/mm_api.h> to <linux/pgtable_api.h>
      headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mmzone_api.h> dependency
      headers/deps: mm: Move the folio_try_*() APIs from <linux/page_ref.h> to <linux/page_ref_api_extra.h>
      headers/deps: mm: Optimize <linux/page_ref.h> dependencies
      headers/deps: mm: Optimize <linux/pgtable_api.h> dependencies, remove <asm/pgtable_api_access.h> inclusion
      headers/deps: net: Optimize <net/sock_api.h> dependencies
      headers/deps: net: Introduce <net/sock_api_extra.h> for rarely used APIs
      headers/deps: net: Move the sk_dst_set/reset() APIs from <net/sock_api.h> to <net/sock_api_extra.h>
      headers/deps: net: Optimize <net/sock_api.h> dependencies, remove <net/dst_api.h> inclusion
      headers/deps: net: Move the sock_confirm_neigh() API from <net/sock_api.h> to <net/sock_api_extra.h>
      headers/deps: net: Optimize <net/sock_api.h> dependencies, remove <net/neighbour_api.h> inclusion
      headers/deps: net: Introduce <net/ip_extra.h> for rarely used APIs
      headers/deps: net: Optimize <net/ip.h> dependencies, remove <net/dst_api.h> inclusion
      headers/deps: net: Move skb_mark_not_on_list() from <linux/skbuff_api.h> to <linux/skbuff_types.h>
      headers/deps: net: Move the snmp_get*() APIs from <net/ip.h> to <net/ip_extra.h>
      headers/deps: net: Optimize <linux/ip.h> dependencies, remove <linux/skbuff_api.h> inclusion
      headers/deps: net: Optimize <net/ip.h> dependencies, remove <linux/skbuff_api.h> inclusion
      headers/deps: core: Introduce <linux/log2_const.h> for constant logarithmic calculations
      headers/deps: hashtable_types: Use ilog2_const()
      headers/deps: hashtable: Optimize <linux/hashtable_types.h> dependencies
      headers/deps: net: Optimize <linux/skbuff_types.h> dependencies, use <asm/page_types.h> instead of <asm/page.h>
      headers/deps: io: Optimize <asm-generic/io.h> dependencies, remove <linux/vmalloc.h> inclusion
      headers/deps: io: Introduce <linux/io.h> for rarely used APIs
      headers/deps: io: Optimize <asm-generic/io.h> dependencies, remove <linux/string.h> inclusion
      headers/deps: io: Optimize <asm/io.h> dependencies, remove <linux/string.h> inclusion
      headers/deps: uuid: Split <linux/uuid.h> into <linux/uuid_types.h> and <linux/uuid_api.h>
      headers/deps: uuid: Optimize <linux/uuid.h> dependencies, remove <linux/uuid_api.h> inclusion
      headers/deps: io: Introduce <asm/io_extra.h>, use it on x86 to move iosubmit_cmds512()
      headers/deps: io/x86: Optimize <asm/io.h> dependencies, remove <asm/special_insns.h> inclusion
      headers/deps: io/arch: Move the address translation APIs from <asm/io.h> to <asm/io_extra.h>
      headers/deps: mm: Introduce <linux/highmem_extra.h> for rarely used APIs
      headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove <linux/cacheflush.h> inclusion
      headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove <linux/uaccess.h> inclusion
      headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove MM headers from the !CONFIG_HIGHMEM path
      headers/deps: mm: Optimize <linux/highmem.h> dependencies, remove <linux/gfp_api.h> inclusion
      headers/deps: x86: Optimize <asm/irqflags.h> dependencies, remove <asm/processor-flags.h> inclusion
      headers/deps: x86: Move native_safe_halt() and native_halt() from <asm/irqflags.h> to <asm/halt.h>
      headers/deps: x86: Optimize <asm/irqflags.h> dependencies, remove <asm/nospec-branch.h> inclusion
      headers/deps: x86: Optimize <linux/paravirt.h> dependencies
      headers/deps: x86: Optimize <asm/mem_encrypt.h> dependencies
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies, remove <linux/xarray_api.h> inclusion
      headers/deps: fs: Introduce <linux/fs_api_sb.h> for superblock related APIs
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies, remove <linux/percpu_rwsem_api.h> inclusion
      headers/deps: fs: Introduce <linux/fs_api_dio.h> for Direct IO related APIs
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies, remove <linux/wait_bit.h> inclusion
      headers/deps: fs: Introduce <linux/fs_api_mapping.h> for address space mapping related APIs
      headers/deps: fs: Introduce <linux/fs_api_rw_access.h> for inode RW access related APIs
      headers/deps: fs: Introduce <linux/fs_api_fb_count.h> for f_count related APIs
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies, remove <linux/atomic_api.h> inclusion
      headers/deps: fs: Introduce <linux/fs_types_sb.h> for 'struct superblock' definitions
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/percpu_rwsem_types.h> inclusion
      headers/deps: fs: Move more superblock related APIs from <linux/fs_api.h> to <linux/fs_api_sb.h>
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies, remove <linux/fs_types_sb.h> inclusion
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/list_bl_types.h>
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/list_lru_types.h> inclusion
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/shrinker.h> inclusion
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/workqueue_types.h> inclusion
      headers/deps: fs: Optimize <linux/fs_types.h> dependencies, remove <linux/uuid.h>
      headers/deps: fs: Move the ____cacheline_aligned attribute to an easier to debug position
      headers/deps: fs: Optimize <linux/fs_api.h> dependencies
      headers/deps: uhm: Introduce <linux/umh_sysctl.h> for sysctl definitions
      headers/deps: umh: Optimize <linux/umh.h> dependencies
      headers/deps: umh: Optimize <linux/umh.h> dependencies, remove <linux/gfp.h> inclusion
      headers/deps: umh: Optimize <linux/umh.h> dependencies
      headers/deps: poll: Optimize <linux/poll.h> dependencies, remove <linux/sysctl.h> inclusion
      headers/deps: poll: Optimize <linux/poll.h> dependencies, remove <linux/uaccess.h> inclusion
      headers/deps: poll: Optimize <linux/poll.h> dependencies, remove <linux/string.h> inclusion
      headers/deps: poll: Introduce <linux/poll_time.h> for time related APIs
      headers/deps: poll: Optimize <linux/poll.h> dependencies, remove time headers
      headers/deps: rcu: Optimize <linux/rcupdate.h> dependencies, remove <asm/processor.h> inclusion
      headers/deps: rcu: Optimize <linux/rcupdate.h> dependencies
      headers/deps: nfs: Optimize <linux/nfs_page.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: drm: Optimize <drm/ttm/ttm_tt.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: mm/balloon_compaction: Optimize <linux/.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: buffer_head: Optimize <linux/buffer_head.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: ceph: Optimize <linux/ceph/libceph.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: f2fs_fs: Optimize <linux/f2fs_fs.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: fscache: Optimize <linux/fscache.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: pagemap: Optimize <linux/pagemap_api_readahead.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: ksm: Optimize <linux/ksm.h> dependencies, remove <linux/pagemap.h> inclusion
      headers/deps: mm: Optimize <linux/pagemap.h> dependencies
      headers/deps: mm: Optimize <linux/kasan.h> dependencies
      headers/deps: mm: Move nth_page() from <linux/mm_api.h> to <linux/pgtable_api.h>
      headers/prep: locking/atomic: Convert C++ style comments to ISO C90 comments in generated headers
      headers/deps: perf: Split <linux/perf_event.h> into <linux/perf_event_types.h> and <linux/perf_event_api.h>
      headers/deps: perf_event: Optimize <linux/perf_event_types.h> dependencies
      headers/deps: x86/stacktrace: Move various unwind APIs from <asm/stacktrace.h> to <asm/unwind.h>
      headers/deps: x86/stacktrace: Optimize <asm/stacktrace.h> dependencies, remove <asm/switch_to.h> inclusion
      headers/deps: perf: Optimize <linux/perf_event.h> dependencies, remove <linux/perf_event_api.h> inclusion
      headers/deps: sched: Optimize <linux/restart_block.h> dependencies, remove <linux/restart_block_api.h> inclusion
      headers/deps: net: Optimize <linux/dynamic_queue_limits.h> dependencies, remove <linux/dynamic_queue_limits_api.h> inclusion
      headers/deps: Optimize <linux/siphash.h> dependencies, remove <linux/siphash_api.h> inclusion
      headers/deps: time: Optimize <linux/time64.h> dependencies, remove <linux/time64_api.h> inclusion
      headers/deps: sparc64, mm: Define simple constants earlier
      headers/deps: driver/core: Optimize <linux/device/driver.h> dependencies, remove <linux/module.h> inclusion
      headers/deps: Introduce the CONFIG_FAST_HEADERS=y config option

