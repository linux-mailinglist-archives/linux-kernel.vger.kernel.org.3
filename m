Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D358833B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiHBUxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiHBUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:53:36 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384142AE8;
        Tue,  2 Aug 2022 13:53:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 13E2B3BD128;
        Tue,  2 Aug 2022 16:53:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yIAsc6ttWfzH; Tue,  2 Aug 2022 16:53:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 641EA3BCDC3;
        Tue,  2 Aug 2022 16:53:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 641EA3BCDC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659473613;
        bh=B4hGP4iemtQL3+g6m57wntdkv5cbUmU1xdPvwXkx730=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FgfzuDujXtuqmlLuUhBPgbNEB0BayrWQ64GhuqOiCaRbhMfVrY18ASvf6lFEiJMyH
         kmYBY//BsfjRazO5HxaUDXq2IOjRBojCUGC9omSYlEtPT4owV07S6kasuzWnODFiqi
         Q9CLRQ4dd6BDefSpvGn4E2yuoiGAifiUEkmyHp8rFIeoUOLjfG1kQjdunboRWgAQej
         fFaf+2WhUmB5aeAAxk1um756pZW7EAtnNhXYpfvcG5cdw1BLwrfeoUBVzg6MwnEsmL
         RovAKQbLvNzx+EynWTtG6AZe8NTrTpufJQMmau8VW1WENd7NYk5Ynk27hqx4lS3vMu
         R3JRb3s81uxMg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eQe_PWRuowej; Tue,  2 Aug 2022 16:53:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 469A13BCDC2;
        Tue,  2 Aug 2022 16:53:33 -0400 (EDT)
Date:   Tue, 2 Aug 2022 16:53:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <2019726322.96838.1659473613204.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPNVh5dviLMLS5APS8M+n9cHups2zvoJvcguqnO0aPO8bi4DDQ@mail.gmail.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com> <CAFTs51UAyc4Z5WUFdMXCTYR6zji6NwLeBxYsp9GQZvFdEtUm1w@mail.gmail.com> <500891137.95782.1659452479846.JavaMail.zimbra@efficios.com> <CAPNVh5dviLMLS5APS8M+n9cHups2zvoJvcguqnO0aPO8bi4DDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: RSEQ node id and virtual cpu id extensions
Thread-Index: /pE0N3nNhdEhX/LvlngMjGKCuJweJw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 2, 2022, at 1:06 PM, Peter Oskolkov posk@google.com wrote:

> On Tue, Aug 2, 2022 at 8:01 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
> 
> [...]
> 
>> >
>> > We have experimented with several approaches here. The one that we are
>> > currently using is the "flat" model: we allocate vcpu IDs ignoring numa nodes.
>> >
>> > We did try per-numa-node vcpus, but it did not show any material improvement
>> > over the "flat" model, perhaps because on our most "wide" servers the CPU
>> > topology is multi-level. Chris Kennelly may provide more details here.
>>
>> I would really like to know more about Google's per-numa-node vcpus
>> implementation.
>> I suspect you guys may have taken a different turn somewhere in the design which
>> led to these results. But having not seen that implementation, I can only guess.
>>
>> I notice the following Google-specific prototype extension in tcmalloc:
>>
>>   // This is a prototype extension to the rseq() syscall.  Since a process may
>>   // run on only a few cores at a time, we can use a dense set of "v(irtual)
>>   // cpus."  This can reduce cache requirements, as we only need N caches for
>>   // the cores we actually run on simultaneously, rather than a cache for every
>>   // physical core.
>>   union {
>>     struct {
>>       short numa_node_id;
>>       short vcpu_id;
>>     };
>>     int vcpu_flat;
>>   };
>>
>> Can you tell me more about the way the numa_node_id and vcpu_id are allocated
>> internally, and how they are expected to be used by userspace ?
> 
> Based on a "VCPU policy" flag passed by the userspace during rseq registration
> request, our kernel would:
> - do nothing re: vcpus, i.e. behave like it currently does upstream;
> - allocate VCPUs in a "flat" manner, ignoring NUMA;
> - populate numa_node_id with the value from the function with the same name in
>  https://elixir.bootlin.com/linux/latest/source/include/linux/topology.h
>  and allocate vcpu_id within the numa node in a tight manner.
> 
> Basically, if there are M threads running on node 0 and N threads
> running on node 1 at time T, there will be [0,M-1] vcpu IDs associated with
> node 0 and [0,N-1] vcpu IDs associated with node 1 at this moment
> in time. If a thread migrates across nodes, the balance would change
> accordingly.
> 
> I'm not sure how exactly tcmalloc tried to use VCPUs under this policy, and
> what were the benefits expected. The simplest way would be to keep
> a freelist per node_id/vcpu_id pair (basically, per vcpu_flat in the union),
> but this would tend to increase the number of freelists due to thread
> migrations,
> so benefits should be related to memory locality, and so somewhat difficult to
> measure precisely.

So, based on your explanation of the Google implementation, for each memory space,
the kernel keeps per-numa-node vcpu-id allocation domains.

This leaves two choices to userspace AFAIU:

1) Userspace takes the vcpu_flat (int, combining the short node_id with the short vcpu_id)
   as index in a sparse array. The sparseness of the array may be unwelcome in terms of
   memory and cache footprint.

2) Userspace could take a 2-level approach: using the short node_id to index an array of
   "numa node" objects, which would then point to a 2nd level indexed by short vcpu_id.
   This adds an extra pointer dereference on the fast-path, and touches additional cache
   lines on the fast path as well, which is probably unwelcome. In addition, keeping track
   of this 2-level table adds extra complexity in userspace, and requires that user-space
   designs its data structure specifically for NUMA, which is unusual considering that NUMA
   is typically just an optimization hint to improve locality of memory accesses.

Hopefully I did not miss anything there.

So here is how I did things differently.

I realized that when userspace uses a rseq_abi()->cpu_id as index into per-cpu data structures,
it expects that when any of the process' threads observe a numa_node_id when running on behalf
of a given cpu_id once in the process lifetime, this topology is invariant [1]. IOW, the same
cpu_id should always run on the same NUMA node in the future.

This characteristic is what allows indexing by cpu_id to index data structures that have a
good NUMA locality: on first use of a given cpu_id, memory allocation can be done on behalf of
the right NUMA node, and then all per-cpu accesses are guaranteed to be local.

So I applied this concept to vcpu_ids.

The trick here is mostly to add a per-numa-node bitmap to the mm_struct in addition to the bitmap
tracking the current vcpu_id allocation. The per-numa-node bitmap keeps track of which vcpu_ids
have been allocated on behalf of each numa node in the past.

So when a thread running on a given NUMA node needs to find the lowest vcpu_id which is available,
it uses cpumask_first_one_and_zero(node_cpumask, cpumask) to find the first bit which has both
been allocated already for this NUMA node, and is currently not in use by another thread.

There is also a node_alloc_vcpumask bitmap which keeps track of which vcpu have already been
allocated in the past, across all NUMA nodes. This allows scanning efficiently for the first
vcpu which was _not_ yet allocated, and is currently unused with
cpumask_first_zero_and_zero(node_alloc_cpumask, cpumask).

With this, user-space can simply use the vm_vcpu_id field as index into the per-vcpu array,
and the NUMA locality is implicit. Upon initial allocation of the numa-local memory, it just
needs to read both vm_vcpu_id and numa_node_id fields within a rseq critical section to
ensure there is no migration between the two field loads.

So as long as the scheduler does a good job at keeping the number of threads per NUMA node
relatively constant by pushing back against thread migration across NUMA nodes over the process
lifetime, there should not be too many extra vcpu_ids needed. In the worse-case scenario, the
number of vcpu_ids needed is equal to the number of online cpus in the system.

The performance overhead of keeping track of those additional bitmaps for NUMA locality should
be minimal considering that the only update needed in the per-numa-node bitmap and the
node_alloc_vcpumask bitmap is the first time a vcpu_id is assigned within a process. The rest
is lookup only. And even there, the optimizations I have put in place skip those lookups in
the common scenarios entirely.

Thanks,

Mathieu

[1] There is the exception of Power CPU hotplug which can reconfigure the NUMA topology,
    but this seems like a rather odd and rare corner-case. It is supported by my implementation,
    but userspace would have to deal with this kind of reconfiguration on its own to
    preserve NUMA locality.

> 
> Chris Kennelly may offer more details here.
> 
> Thanks,
> Peter

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
