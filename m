Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520B51541E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380156AbiD2S4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380141AbiD2S42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:56:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53AEC3E0E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:53:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d15so7901214plh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnG5K+6GZGTk0Z+mBsRXabRwISJ34tcUygk9A36SU/w=;
        b=TQ0zt57WMvFnVzpCM5wllddGng37U+my/gOVohy4FpWzlnN1WsEemracGMGapcdkXx
         n0vUdj1ZHjVyi8f/0kdegI2QfgLyuOdyzmBfpO1YiyFx/it8CXQ/fxG1qFB/Co7kUa+7
         3VYqM4h5TWv8mxV+BIa8rEWlrE9RbYYZ7GAxqPiG8A58HcLopgBVzNj1WWyjL/5SuHdQ
         SloBfxRSB44oaVvQaozsIZHwktVU3tCn89Znu+6c0AXhaceQ1/OAxQChZYMk9WRoD0NT
         XDJMGuIs/G8rX/UJ9QAD+LLsFXdFP+v/pciuzMa9kfHs+xSQNhgvbSID27B0hlgQAL1f
         xaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnG5K+6GZGTk0Z+mBsRXabRwISJ34tcUygk9A36SU/w=;
        b=j6eHxUoeoflmTji5N8TL3ni7FsHSfq/A1MCEjzZYJpMV62bvWp5jrYBWiazcX8gD8s
         OogCWoF8z3NPmB5Nct0taAFKUbgYQSyfJlfvRnCDMk1P5AEPuHvINGrBRBWIDVIDeR32
         NLgknQ3my+KbuP5q8I5Pu/1yCpbTgaqA7rAOjrcO/Cwnn9j0++wcMMBlvDH7QouskAo6
         C3RLDfk9YxudJ14a5ztcoMrBbF7VyY3G1KYCSuh9Tn5YzdmGEff4RVkqkM41ypO22SJL
         b9wDKYwN1VxHKp8H1o1t7LHgqib4nivr8A6DP4HN7/majL8AYHruKosRDMIIVPvR1KDh
         HWXg==
X-Gm-Message-State: AOAM533Ov51yvc2h1hUsCZvOh7Qnk1SrQ0WyxwqARDZbBm6WZrcfrJDV
        eK3TqV7Joy7CzcWyldnBAFuUP405O+4gDOBohBY=
X-Google-Smtp-Source: ABdhPJxgDokrjXhcBm/LZiJHCLbw7K6BV04d2J3W8dgRmIAh4Q7Zjx1DdIhkOxQ49sI0B/Y218ruNmRBqFfAbDgz/fA=
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id
 g3-20020a170902d5c300b00154c472de80mr730533plh.87.1651258384237; Fri, 29 Apr
 2022 11:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
 <CAAPL-u-sSg=p1n_Trm9TyrgdCCO1zZ-LbKM=tkp3M827gLv=CA@mail.gmail.com>
 <CAHbLzkr=izetwUdMnXn+s=52TYK7rG7QwxiRLz8dfu3i-4sZ7A@mail.gmail.com>
 <7535568.9lEE7krE1S@nvdebian> <f6282d421ee66b56ae889d408ca5bbe843bd9494.camel@intel.com>
 <CAAPL-u8cdpi6r3wM6UN9qT22-xyd6J0-a_8Kgmdc7mT1smAq-A@mail.gmail.com>
In-Reply-To: <CAAPL-u8cdpi6r3wM6UN9qT22-xyd6J0-a_8Kgmdc7mT1smAq-A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Apr 2022 11:52:51 -0700
Message-ID: <CAHbLzkrm4mf6rfJKWqiPMxDonz9zsEaRQeacppaQbG1N_QpLjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     Wei Xu <weixugc@google.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 7:59 PM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Apr 28, 2022 at 7:21 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> >
> > On Fri, 2022-04-29 at 11:27 +1000, Alistair Popple wrote:
> > > On Friday, 29 April 2022 3:14:29 AM AEST Yang Shi wrote:
> > > > On Wed, Apr 27, 2022 at 9:11 PM Wei Xu <weixugc@google.com> wrote:
> > > > >
> > > > > On Wed, Apr 27, 2022 at 5:56 PM ying.huang@intel.com
> > > > > <ying.huang@intel.com> wrote:
> > > > > >
> > > > > > On Wed, 2022-04-27 at 11:27 -0700, Wei Xu wrote:
> > > > > > > On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
> > > > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > > > >
> > > > > > > > On 4/25/22 10:26 PM, Wei Xu wrote:
> > > > > > > > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > > > > > > > > <ying.huang@intel.com> wrote:
> > > > > > > > > >
> > > > > > > >
> > > > > > > > ....
> > > > > > > >
> > > > > > > > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> > > > > > > > > >
> > > > > > > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > > > > > > > > > memory node near node 0,
> > > > > > > > > >
> > > > > > > > > > available: 3 nodes (0-2)
> > > > > > > > > > node 0 cpus: 0 1
> > > > > > > > > > node 0 size: n MB
> > > > > > > > > > node 0 free: n MB
> > > > > > > > > > node 1 cpus:
> > > > > > > > > > node 1 size: n MB
> > > > > > > > > > node 1 free: n MB
> > > > > > > > > > node 2 cpus: 2 3
> > > > > > > > > > node 2 size: n MB
> > > > > > > > > > node 2 free: n MB
> > > > > > > > > > node distances:
> > > > > > > > > > node   0   1   2
> > > > > > > > > >    0:  10  40  20
> > > > > > > > > >    1:  40  10  80
> > > > > > > > > >    2:  20  80  10
> > > > > > > > > >
> > > > > > > > > > We have 2 choices,
> > > > > > > > > >
> > > > > > > > > > a)
> > > > > > > > > > node    demotion targets
> > > > > > > > > > 0       1
> > > > > > > > > > 2       1
> > > > > > > > > >
> > > > > > > > > > b)
> > > > > > > > > > node    demotion targets
> > > > > > > > > > 0       1
> > > > > > > > > > 2       X
> > > > > > > > > >
> > > > > > > > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > > > > > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > > > > > > > prefer the other one.  So we need a user space ABI to override the
> > > > > > > > > > default configuration.
> > > > > > > > >
> > > > > > > > > I think 2(a) should be the system-wide configuration and 2(b) can be
> > > > > > > > > achieved with NUMA mempolicy (which needs to be added to demotion).
> > > > > > > > >
> > > > > > > > > In general, we can view the demotion order in a way similar to
> > > > > > > > > allocation fallback order (after all, if we don't demote or demotion
> > > > > > > > > lags behind, the allocations will go to these demotion target nodes
> > > > > > > > > according to the allocation fallback order anyway).  If we initialize
> > > > > > > > > the demotion order in that way (i.e. every node can demote to any node
> > > > > > > > > in the next tier, and the priority of the target nodes is sorted for
> > > > > > > > > each source node), we don't need per-node demotion order override from
> > > > > > > > > the userspace.  What we need is to specify what nodes should be in
> > > > > > > > > each tier and support NUMA mempolicy in demotion.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I have been wondering how we would handle this. For ex: If an
> > > > > > > > application has specified an MPOL_BIND policy and restricted the
> > > > > > > > allocation to be from Node0 and Node1, should we demote pages allocated
> > > > > > > > by that application
> > > > > > > > to Node10? The other alternative for that demotion is swapping. So from
> > > > > > > > the page point of view, we either demote to a slow memory or pageout to
> > > > > > > > swap. But then if we demote we are also breaking the MPOL_BIND rule.
> > > > > > >
> > > > > > > IMHO, the MPOL_BIND policy should be respected and demotion should be
> > > > > > > skipped in such cases.  Such MPOL_BIND policies can be an important
> > > > > > > tool for applications to override and control their memory placement
> > > > > > > when transparent memory tiering is enabled.  If the application
> > > > > > > doesn't want swapping, there are other ways to achieve that (e.g.
> > > > > > > mlock, disabling swap globally, setting memcg parameters, etc).
> > > > > > >
> > > > > > >
> > > > > > > > The above says we would need some kind of mem policy interaction, but
> > > > > > > > what I am not sure about is how to find the memory policy in the
> > > > > > > > demotion path.
> > > > > > >
> > > > > > > This is indeed an important and challenging problem.  One possible
> > > > > > > approach is to retrieve the allowed demotion nodemask from
> > > > > > > page_referenced() similar to vm_flags.
> > > > > >
> > > > > > This works for mempolicy in struct vm_area_struct, but not for that in
> > > > > > struct task_struct.  Mutiple threads in a process may have different
> > > > > > mempolicy.
> > > > >
> > > > > From vm_area_struct, we can get to mm_struct and then to the owner
> > > > > task_struct, which has the process mempolicy.
> > > > >
> > > > > It is indeed a problem when a page is shared by different threads or
> > > > > different processes that have different thread default mempolicy
> > > > > values.
> > > >
> > > > Sorry for chiming in late, this is a known issue when we were working
> > > > on demotion. Yes, it is hard to handle the shared pages and multi
> > > > threads since mempolicy is applied to each thread so each thread may
> > > > have different mempolicy. And I don't think this case is rare. And not
> > > > only mempolicy but also may cpuset settings cause the similar problem,
> > > > different threads may have different cpuset settings for cgroupv1.
> > > >
> > > > If this is really a problem for real life workloads, we may consider
> > > > tackling it for exclusively owned pages first. Thanks to David's
> > > > patches, now we have dedicated flags to tell exclusively owned pages.
> > >
> > > One of the problems with demotion when I last looked is it does almost exactly
> > > the opposite of what we want on systems like POWER9 where GPU memory is a
> > > CPU-less memory node.
> > >
> > > On those systems users tend to use MPOL_BIND or MPOL_PREFERRED to allocate
> > > memory on the GPU node. Under memory pressure demotion should migrate GPU
> > > allocations to the CPU node and finally other slow memory nodes or swap.
> > >
> > > Currently though demotion considers the GPU node slow memory (because it is
> > > CPU-less) so will demote CPU memory to GPU memory which is a limited resource.
> > > And when trying to allocate GPU memory with MPOL_BIND/PREFERRED it will swap
> > > everything to disk rather than demote to CPU memory (which would be preferred).
> > >
> > > I'm still looking at this series but as I understand it it will help somewhat
> > > because we could make GPU memory the top-tier so nothing gets demoted to it.
> >
> > Yes.  If we have a way to put GPU memory in top-tier (tier 0) and
> > CPU+DRAM in tier 1.  Your requirement can be satisfied.  One way is to
> > override the auto-generated demotion order via some user space tool.
> > Another way is to change the GPU driver (I guess where the GPU memory is
> > enumerated and onlined?) to change the tier of GPU memory node.
> >
> > > However I wouldn't want to see demotion skipped entirely when a memory policy
> > > such as MPOL_BIND is specified. For example most memory on a GPU node will have
> > > some kind of policy specified and IMHO it would be better to demote to another
> > > node in the mempolicy nodemask rather than going straight to swap, particularly
> > > as GPU memory capacity tends to be limited in comparison to CPU memory
> > > capacity.
> > > >
> >
> > Can you use MPOL_PREFERRED?  Even if we enforce MPOL_BIND as much as
> > possible, we will not stop demoting from GPU to DRAM with
> > MPOL_PREFERRED.  And in addition to demotion, allocation fallbacking can
> > be used too to avoid allocation latency caused by demotion.
>
> I expect that MPOL_BIND can be used to either prevent demotion or
> select a particular demotion node/nodemask. It all depends on the
> mempolicy nodemask specified by MPOL_BIND.

Preventing demotion doesn't make too much sense to me IMHO. But I tend
to agree the demotion target should be selected from the nodemask. I
think this could follow what numa fault does.

>
> > This is another example of a system with 3 tiers if PMEM is installed in
> > this machine too.
> >
> > Best Regards,
> > Huang, Ying
> >
> > > > > On the other hand, it can already support most interesting use cases
> > > > > for demotion (e.g. selecting the demotion node, mbind to prevent
> > > > > demotion) by respecting cpuset and vma mempolicies.
> > > > >
> > > > > > Best Regards,
> > > > > > Huang, Ying
> > > > > >
> > > > > > > >
> > > > > > > > > Cross-socket demotion should not be too big a problem in practice
> > > > > > > > > because we can optimize the code to do the demotion from the local CPU
> > > > > > > > > node (i.e. local writes to the target node and remote read from the
> > > > > > > > > source node).  The bigger issue is cross-socket memory access onto the
> > > > > > > > > demoted pages from the applications, which is why NUMA mempolicy is
> > > > > > > > > important here.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > -aneesh
> > > > > >
> > > > > >
> > > >
> > > >
> > >
> > >
> > >
> > >
> >
> >
