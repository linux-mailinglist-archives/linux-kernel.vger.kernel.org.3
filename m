Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78153587E81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiHBPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHBPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:01:25 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DDB1E3;
        Tue,  2 Aug 2022 08:01:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF7DE3B95B7;
        Tue,  2 Aug 2022 11:01:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OsEnzjYzB6w4; Tue,  2 Aug 2022 11:01:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F3EAB3B94D0;
        Tue,  2 Aug 2022 11:01:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F3EAB3B94D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659452480;
        bh=bVG2zyAAyFZSYcpouAX+4anDt1x5+l+apwXOG9Uq0l8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VGcoTt3+r5S+Xff6eEGdSbW5xVsSjtZupC7Yc1jt9zHv50xJLJCskRc3mTER23RGI
         SFMMBZBSecknVn/HbWgRX5H0fta4CcLp1B7QeEM4FflhAqjklZpcuhy8lZWOZXZ6mK
         RBnkPnY/RhJ4sfmMAd4Z/Br4w9gBt2soYXeXnpr12jeu4htyhG10GfXuF5cSSbh24v
         zaBCR4irk780nF7KcgQM8L+iEK9ZKCkm0c6EPxfKHY66DaE+ehtNHYKqfNMMPXSKJ3
         IebBXBi7+5nVRdykbWmwiqBN+WOJNdFutEtykSYSswxAed22xfx9txkoRwoqfFmP0s
         OnC7VWVwloGhw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a_9Zkqfwy8ch; Tue,  2 Aug 2022 11:01:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E12DA3B9371;
        Tue,  2 Aug 2022 11:01:19 -0400 (EDT)
Date:   Tue, 2 Aug 2022 11:01:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@google.com>
Message-ID: <500891137.95782.1659452479846.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com> <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: RSEQ node id and virtual cpu id extensions
Thread-Index: 56GbPqtcNuVVI1uvQlqn/jwXHtFfHg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 1, 2022, at 1:07 PM, Peter Oskolkov posk@posk.io wrote:

> On Fri, Jul 29, 2022 at 12:02 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.
> 
> Thanks a lot, Mathieu - it is really exciting to see this happening!
> 
> I'll share our experiences here, with the hope that it may be useful.
> I've also cc-ed
> Chris Kennelly, who worked on the userspace/tcmalloc side, as he can provide
> more context/details if I miss or misrepresent something.

Thanks for sharing your experiences at Google. This helps put things in
perspective.

> 
> The problem:
> 
> tcmalloc maintains per-cpu freelists in the userspace to make userspace
> memory allocations fast and efficient; it relies on rseq to do so, as
> any manipulation
> of the freelists has to be protected vs thread migrations.
> 
> However, as a typical userspace process at a Google datacenter is confined to
> a relatively small number of CPUs (8-16) via cgroups, while the
> servers typically
> have a much larger number of physical CPUs, the per-cpu freelist model
> is somewhat
> wasteful: if a process has only at most 10 threads running, for
> example, but these threads
> can "wander" across 100 CPUs over the lifetime of the process, keeping 100
> freelists instead of 10 noticeably wastes memory.
> 
> Note that although a typical process at Google has a limited CPU
> quota, thus using
> only a small number of CPUs at any given time, the process may often have many
> hundreds or thousands of threads, so per-thread freelists are not a viable
> solution to the problem just described.
> 
> Our current solution:
> 
> As you outlined in patch 9, tracking the number of currently running threads per
> address space and exposing this information via a vcpu_id abstraction helps
> tcmalloc to noticeably reduce its freelist overhead in the "narrow
> process running
> on a wide server" situation, which is typical at Google.
> 
> We have experimented with several approaches here. The one that we are
> currently using is the "flat" model: we allocate vcpu IDs ignoring numa nodes.
> 
> We did try per-numa-node vcpus, but it did not show any material improvement
> over the "flat" model, perhaps because on our most "wide" servers the CPU
> topology is multi-level. Chris Kennelly may provide more details here.

I would really like to know more about Google's per-numa-node vcpus implementation.
I suspect you guys may have taken a different turn somewhere in the design which
led to these results. But having not seen that implementation, I can only guess.

I notice the following Google-specific prototype extension in tcmalloc:

  // This is a prototype extension to the rseq() syscall.  Since a process may
  // run on only a few cores at a time, we can use a dense set of "v(irtual)
  // cpus."  This can reduce cache requirements, as we only need N caches for
  // the cores we actually run on simultaneously, rather than a cache for every
  // physical core.
  union {
    struct {
      short numa_node_id;
      short vcpu_id;
    };
    int vcpu_flat;
  };

Can you tell me more about the way the numa_node_id and vcpu_id are allocated
internally, and how they are expected to be used by userspace ?

> 
> On a more technical note, we do use atomic operations extensively in
> the kernel to make sure
> vcpu IDs are "tightly packed", i.e. if only N threads of a process are currently
> running on physical CPUs, vcpu IDs will be in the range [0, N-1], i.e. no gaps,
> no going to N and above; this does consume some extra CPU cycles, but the
> RAM savings we gain far outweigh the extra CPU cost; it will be interesting to
> see what you can do with the optimizations you propose in this patchset.

The optimizations I propose keep those "tightly packed" characteristics, but skip
the atomic operations in common scenarios. I'll welcome benchmarks of the added
overhead in representative workloads.

> Again, thanks a lot for this effort!

Thanks for your input. It really helps steering the effort in the right direction.

Mathieu

> 
> Peter
> 
> [...]

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
