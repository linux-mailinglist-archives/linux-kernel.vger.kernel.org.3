Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD552581A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354405AbiELXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359345AbiELXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:07:08 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971255EDD3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:07:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k8so5919508qki.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cUck+cVE4Zxuay2oogDnSAcnKGvRjnTdnpV0Wo1py44=;
        b=Dj1JULLJRgmUJGyzT66YmWR2bXmVOPWjKovt19K15mjhXg3HwFYBwEJuzTGwKaAq9s
         UlYZ0/IUYcAg2aRR26LgYG0/HAiOUXbRTrjNR+Wc4SxPVT5MXbauCdL2/WDBI7QN0Gh0
         c2v6RoCDtzZcEzCwRaxfIkuXKgKFQmfp7WteHFGn9yxB7UXbRpwFXrmu9mN6KLIniXYn
         E6Ng4kcGK1aHvRPzZUSVA18lIbBd/twXGFM4i7KmkNJcxCIrUG0eta5gQ+Zhk4sMsbTs
         bfvIMBQOMEqF/RWs5LYTgoZiIZ4OfdOx64M8r+ZkVp/WNmWSvYEJZ9cPVzcTwYawUn43
         j07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cUck+cVE4Zxuay2oogDnSAcnKGvRjnTdnpV0Wo1py44=;
        b=BFSN7UUZPRYFQrYGOJC0pugUiCfY5dlbiygIkog7CMoo2NTbo9IIbgbiGlhbBogk53
         qZ3WqZe9uRuTJ400BjrLg3tSM0i4uUzagEfd0k3ds6rrhDarjrMiw5terWKrcwe6PpRs
         Q47tb3SCfT5cjofOEuZEqEPYBUHCf7WurSHfMnpH1yo8/dKyF3rOyKfBr1FENyJcO9jE
         xDoQIs93aXnOkNwOEdNGD54oOs7lhjxORAer/MbvmUYLS5rzbGRjEvLC8GeIInWDugOU
         RTJFXGxRJZYAjWtMnoux2yXp8s3E95Ai1UOdakeFSRs8jn/sYJPg7lUv3v359ofOWLrc
         Ww4Q==
X-Gm-Message-State: AOAM531SK/6+0z4KEY2uycEO7au3/NRxL2G69I5YLipAPgwXUuw3Npc6
        Pt5e6fAmMTgrjotVSYbnk3JmmQ==
X-Google-Smtp-Source: ABdhPJzPe/f2XnvNR7HBy1hfb2wAJ55PWzG5ke4OAfKWdYulxV6DryUEgezu1lF0L4l4p+1B2aoJOQ==
X-Received: by 2002:a05:620a:4553:b0:6a0:5280:defd with SMTP id u19-20020a05620a455300b006a05280defdmr1763977qkp.165.1652396825764;
        Thu, 12 May 2022 16:07:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id w13-20020ac86b0d000000b002f39b99f677sm545833qts.17.2022.05.12.16.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:07:05 -0700 (PDT)
Date:   Thu, 12 May 2022 19:07:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
Message-ID: <Yn2TGJ4vZ/fst+CY@cmpxchg.org>
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com>
 <87ilqoi77b.wl-maz@kernel.org>
 <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yosry,

On Mon, May 02, 2022 at 11:46:26AM -0700, Yosry Ahmed wrote:
> On Mon, May 2, 2022 at 3:01 AM Marc Zyngier <maz@kernel.org> wrote:
> > 115bae923ac8bb29ee635). You are saying that this is related to a
> > 'workload', but given that the accounting is global, I fail to see how
> > you can attribute these allocations on a particular VM.
> 
> The main motivation is having the memcg stats, which give attribution
> to workloads. If you think it's more appropriate, we can add it as a
> memcg-only stat, like MEMCG_VMALLOC (see 4e5aa1f4c2b4 ("memcg: add
> per-memcg vmalloc stat")). The only reason I made this as a global
> stat too is to be consistent with NR_PAGETABLE.

Please no memcg-specific stats if a regular vmstat item is possible
and useful at the system level as well, like in this case. It's extra
memcg code, extra callbacks, and it doesn't have NUMA node awareness.

> > What do you plan to do for IOMMU page tables? After all, they serve
> > the exact same purpose, and I'd expect these to be handled the same
> > way (i.e. why is this KVM specific?).
> 
> The reason this was named NR_SECONDARY_PAGTABLE instead of
> NR_KVM_PAGETABLE is exactly that. To leave room to incrementally
> account other types of secondary page tables to this stat. It is just
> that we are currently interested in the KVM MMU usage.

Do you actually care at the supervisor level that this memory is used
for guest page tables?

It seems to me you primarily care that it is reported *somewhere*
(hence the piggybacking off of NR_PAGETABLE at first). And whether
it's page tables or iommu tables or whatever else allocated for the
purpose of virtualization, it doesn't make much of a difference to the
host/cgroup that is tracking it, right?

(The proximity to nr_pagetable could also be confusing. A high page
table count can be a hint to userspace to enable THP. It seems
actionable in a different way than a high number of kvm page tables or
iommu page tables.)

How about NR_VIRT? It's shorter, seems descriptive enough, less room
for confusion, and is more easily extensible in the future.
