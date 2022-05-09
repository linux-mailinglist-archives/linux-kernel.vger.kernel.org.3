Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567A05202A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiEIQmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiEIQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:42:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527111033C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:38:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so20251680wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHCy33IfC5TyILOeQkmukBylQEbte8TBRw0A+aY3Nnw=;
        b=H6nlUcikiCWMQ0NyQpEOvAX9YWAzxJVOMo8TCOD+MTF5x++KFtykM38ezcNgkrqf/k
         HsEf3EJd5U1zetXK4vcQ2qXVxKjVLLmxk64eVHzC1lhLd+csiUOWanUBOMc0ehk+lL8Z
         8kMOXwBH5hATNTPogQUXQIImHkrg03NEi/77hdTa1677HBxwaUfkv/QQ7yLseBE1HcJE
         YPtPpea4ak7+T4Dqx7q3oWEasv5JJswYYW1+IlWiL+SM1CpjXzbyzq9KKAOv4Z51ZAoC
         p4WvvEjdiEI05l2ZOHE80zU68Yi/ftR+9e3AoP2yMz5PBJyRJ0fD1vQ47PM6C0czbLOE
         9nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHCy33IfC5TyILOeQkmukBylQEbte8TBRw0A+aY3Nnw=;
        b=uL5O0TFfObcs7UwFhTCx28FWgION37qowigwJng607A7MXgRqwu/lOAi2KHorHYTtx
         Ixbqq7tK45PHBdBVqs49rzRNKSiCadt800JBVjtwx+SMMv3jHxYg0wmAv+8XBsHAETzD
         0jq/LGJdRk1EnL3P4oD18eBNjeUJPRnSu95wo8vEcjL0/w7W3A50qZcPMirguv8QFDrG
         0GZ/xAEVYzj8tU4FE/VxTtahDkvx8R88fUYNBtlgMVGgqZE7x02FdDQGS1TTRA0/rFWN
         5Odxkhobb4QHPFVRxHQsCkF2ErtXyiUdSKxF/6Wftnw+h/cqoBBvWR0DvHj0SwwwKdVD
         ONUw==
X-Gm-Message-State: AOAM532Puu8Jy1Cu/IWzqoUfRIs5XC+/oq35GhEtjkf6LK/k+lEiyIxn
        AVvbuacdoA/uA9Rdu4O5QfvZWImGuj8ujR+aVKgQCQ==
X-Google-Smtp-Source: ABdhPJzFCb2Pw91KP2O7w1MuAK0a7BY2JKborW82eGXzK/VRCy5OZV3s+PnflU0xod+JItQXe5EJnWI4vMeydL7hgKY=
X-Received: by 2002:a05:6000:230:b0:209:87ac:4cf5 with SMTP id
 l16-20020a056000023000b0020987ac4cf5mr14646217wrz.80.1652114333976; Mon, 09
 May 2022 09:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com> <87ilqoi77b.wl-maz@kernel.org>
 <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
In-Reply-To: <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 9 May 2022 09:38:17 -0700
Message-ID: <CAJD7tkbfT-FRs3LE2GPddqrQSWw_eC1R6k3z04x=z9Zvt5yLpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 11:46 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, May 2, 2022 at 3:01 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Fri, 29 Apr 2022 21:11:28 +0100,
> > Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> > > KVM mmu. This provides more insights on the kernel memory used
> > > by a workload.
> > >
> > > This stat will be used by subsequent patches to count KVM mmu
> > > memory usage.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst | 5 +++++
> > >  Documentation/filesystems/proc.rst      | 4 ++++
> > >  drivers/base/node.c                     | 2 ++
> > >  fs/proc/meminfo.c                       | 2 ++
> > >  include/linux/mmzone.h                  | 1 +
> > >  mm/memcontrol.c                         | 1 +
> > >  mm/page_alloc.c                         | 6 +++++-
> > >  mm/vmstat.c                             | 1 +
> > >  8 files changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 69d7a6983f78..828cb6b6f918 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1312,6 +1312,11 @@ PAGE_SIZE multiple when read back.
> > >         pagetables
> > >                  Amount of memory allocated for page tables.
> > >
> > > +       secondary_pagetables
> > > +             Amount of memory allocated for secondary page tables,
> > > +             this currently includes KVM mmu allocations on x86
> > > +             and arm64.
> >
> > Can you please explain what the rationale is for this? We already
> > account for the (arm64) S2 PTs as a userspace allocation (see
>
> This can be considered as continuation for that work. The mentioned
> commit accounts S2 PTs to the VM process cgroup kernel memory. We have
> stats for the total kernel memory, and some fine-grained categories of
> that, like (pagetables, stack, slab, etc.).
>
> This patch just adds another category to give further insights into
> what exactly is using kernel memory.
>
> > 115bae923ac8bb29ee635). You are saying that this is related to a
> > 'workload', but given that the accounting is global, I fail to see how
> > you can attribute these allocations on a particular VM.
>
> The main motivation is having the memcg stats, which give attribution
> to workloads. If you think it's more appropriate, we can add it as a
> memcg-only stat, like MEMCG_VMALLOC (see 4e5aa1f4c2b4 ("memcg: add
> per-memcg vmalloc stat")). The only reason I made this as a global
> stat too is to be consistent with NR_PAGETABLE.
>
> >
> > What do you plan to do for IOMMU page tables? After all, they serve
> > the exact same purpose, and I'd expect these to be handled the same
> > way (i.e. why is this KVM specific?).
>
> The reason this was named NR_SECONDARY_PAGTABLE instead of
> NR_KVM_PAGETABLE is exactly that. To leave room to incrementally
> account other types of secondary page tables to this stat. It is just
> that we are currently interested in the KVM MMU usage.
>


Any thoughts on this? Do you think MEMCG_SECONDARY_PAGETABLE would be
more appropriate here?
