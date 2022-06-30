Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A805624C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiF3VCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiF3VCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:02:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2724D160
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:02:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so335921wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtUlpkuhliUwoUgmaGEH+kEoEeunaS6PJnDK/W1XYz4=;
        b=JfrrtzAQjyLxnw8RtQ5sQiSNUfohoaMNZW2kYvifXlmGWgHr7XJMl/LQ5yWh4ZDLRh
         EIUPHXZDb5Va4mirbCSRVDZCPMlakbWCUXbrVx3s9CYunFEZ1slL1J+n0+lLyBmkjvq6
         dywxS4/phRbyRQsua97BR94hWDn23Q49DbtcSC9+zkt3E5pfCOfz49pW3hhqdvrjGdv+
         pKKf1x3hKQqAQrlbcPos/8s8jUYluEAVcvGGsPGpoOXyv0wrj0LnCa606tZy9ddxQBAt
         cF8lFcME2E999BhE7foEKF9XdpoRPCaTJec6Ks6Sa9LMwb5hg+yO+AGHFhUc1+iXyNs+
         Ct9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtUlpkuhliUwoUgmaGEH+kEoEeunaS6PJnDK/W1XYz4=;
        b=GVQaF1yh/X8nKPLu1LO/AFGrcPyDoZeTe3zpkMJsphv/LwxCNlOx/+MvuaGGjmm0t9
         vFJrDvefMQYMvDCoLsDnDrX82Q+hNBNDuqtsrdmww4frfvjXFhYaMGDzEHD9jmf5NAD8
         yZAxvoHAz1sV6EUZQyIkCo96LBQZ9fMl3q7HtVg1bONrarX3xHLomiJC+O8P9gbLXiUl
         feCxXi4C5ZSo/XbAUV7Am1IwV0lfhBbN0f9DrESUEnP7AAOhkm7YzAGFJsbIEK0f1kK1
         i0RrXPQjR+1NMIoJEvJi4S3QVU/586KuoyYaVqqXsbPNbQX3+UlTdReomO1ZRtEX9KT8
         6sRg==
X-Gm-Message-State: AJIora/SisVWMdQOzy4P0632lrX6+paOmuVRaOXxTc0HZXApYusVOZ4J
        cHWPX8IUqEaJu8OJWQYtPJoplk+/GtrE3AFQeFzMrg==
X-Google-Smtp-Source: AGRyM1tplZDxrLp9WaTGqMe3midVuGQbVARcYH1sMixpR7FPn6Bu0DJJ+rFZvHMXvlCiQJACUGtNy4P+3OS3+ElQNfs=
X-Received: by 2002:a05:6000:a1e:b0:21b:8c8d:3cb5 with SMTP id
 co30-20020a0560000a1e00b0021b8c8d3cb5mr10358939wrb.372.1656622949489; Thu, 30
 Jun 2022 14:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220628220938.3657876-1-yosryahmed@google.com>
In-Reply-To: <20220628220938.3657876-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Jun 2022 14:01:52 -0700
Message-ID: <CAJD7tkb3bDwt0gzOhS+3sSiy20Qy=G_AD8jZeY5DYh4=NyX3Bg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] KVM: mm: count KVM mmu usage in memory stats
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Huang@google.com, Tejun Heo <tj@kernel.org>,
        Shaoqin <shaoqin.huang@intel.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jim Mattson <jmattson@google.com>,
        James Morse <james.morse@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Oliver Upton <oupton@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Zefan Li <lizefan.x@bytedance.com>
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

If/when this patchset gets merged, would it be through the mm tree or
kvm tree? It is based on the kvm-queue branch so I am guessing it
could be easier to go through kvm but I am not sure what the policy is
here. Andrew or Paolo, do you mind clarifying the policy on such
patchsets? Thanks!

On Tue, Jun 28, 2022 at 3:09 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Add NR_SECONDARY_PAGETABLE memory stat and use it to account KVM mmu
> usage as the first type of accounted secondary page tables. This stat
> can be later extended to account for other types of secondary pages
> tables (e.g. iommu page tables).
>
> Rationale behind why this is useful and link to extended discussion in
> the first patch.
>
> ---
>
> Changes in V6:
> - Rebased on top of kvm/queue and fixed conflicts.
> - Fixed docs spaces and tabs (Sean).
> - More narrative commit logs (Sean and Oliver).
> - Updated kvm_account_pgtable_pages() documentation to describe the
>   rules of using it more clearly (Sean).
> - Collected Acks and Reviewed-by's by Shakeel and Oliver (Thanks!)
>
> Changes in V5:
> - Updated cover letter to explain more the rationale behind the change
>   (Thanks to contributions by Sean Christopherson).
> - Removed extraneous + in arm64 patch (Oliver Upton, Marc Zyngier).
> - Shortened secondary_pagetables to sec_pagetables (Shakeel Butt).
> - Removed dependency on other patchsets (applies to queue branch).
>
> Changes in V4:
> - Changed accounting hooks in arm64 to only account s2 page tables and
>   refactored them to a much cleaner form, based on recommendations from
>   Oliver Upton and Marc Zyngier.
> - Dropped patches for mips and riscv. I am not interested in those archs
>   anyway and don't have the resources to test them. I posted them for
>   completeness but it doesn't seem like anyone was interested.
>
> Changes in V3:
> - Added NR_SECONDARY_PAGETABLE instead of piggybacking on NR_PAGETABLE
>   stats.
>
> Changes in V2:
> - Added accounting stats for other archs than x86.
> - Changed locations in the code where x86 KVM page table stats were
>   accounted based on suggestions from Sean Christopherson.
>
> ---
>
> Yosry Ahmed (4):
>   mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.
>   KVM: mmu: add a helper to account memory used by KVM MMU.
>   KVM: x86/mmu: count KVM mmu usage in secondary pagetable stats.
>   KVM: arm64/mmu: count KVM s2 mmu usage in secondary pagetable stats
>
>  Documentation/admin-guide/cgroup-v2.rst |  5 ++++
>  Documentation/filesystems/proc.rst      |  4 +++
>  arch/arm64/kvm/mmu.c                    | 36 ++++++++++++++++++++++---
>  arch/x86/kvm/mmu/mmu.c                  | 16 +++++++++--
>  arch/x86/kvm/mmu/tdp_mmu.c              | 12 +++++++++
>  drivers/base/node.c                     |  2 ++
>  fs/proc/meminfo.c                       |  2 ++
>  include/linux/kvm_host.h                | 10 +++++++
>  include/linux/mmzone.h                  |  1 +
>  mm/memcontrol.c                         |  1 +
>  mm/page_alloc.c                         |  6 ++++-
>  mm/vmstat.c                             |  1 +
>  12 files changed, 89 insertions(+), 7 deletions(-)
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
