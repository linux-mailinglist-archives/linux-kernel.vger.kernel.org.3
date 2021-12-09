Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8464746F53B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLIUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhLIUvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:51:52 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52325C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:48:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id p19so6497954qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3+Qzp/iT/XfetT3Cfp4G8l+HGGufPXYg6Iw3f+gTpM=;
        b=Q1541colSruE92jN06qy10g/3KNhtWWSxW1NbaqvWOwV2AVXQklZfHb3QGEsQDRPOD
         OyaMRyfEmWuAkWviDB95qEpS9M8s7ESKrcozuSq4H+wfXzpCqubylgFUjoIR95ywuddl
         QtbunefU8jXI6qLbJ4+0spN+f7plMju9an+Y38pc1b7sebpG3JA7ODqcDfAuJT7pXxq+
         qIT3ORdcecR+7J/40aODehTvi4N7IlThy5l47gi62D7DmUK4m262BHZE3Tfl5CIpVV7J
         UmxRbpYeVRWJvWd15CFzxRaIogyW8Qn+lzeaNlSeeiLUJGfgs2u84eA/VmKMIxK/DXPT
         1OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3+Qzp/iT/XfetT3Cfp4G8l+HGGufPXYg6Iw3f+gTpM=;
        b=2YPSespKUySFaNJFg8iP9QnOtTUvGanUksMfaHg8h8/SPIC4Wdm8MPoCxXfI3Wp/ZR
         ajn2YWxSTRbb7ZkHPyuoNoQbxap2CHJGuK82cG8QFMCh9CWMwtR5nunOwv3tsl+NcAKN
         bXXZZIBH6NzCBgQvwp+ks2SY5V7uOnWlfp5ya0twKgx9QIjTJM3tsRN9iczp1omjFOAi
         jN5qcF8f6bUePjuDINEaYoyIjcnZIqZVt6BawnfOr7XdLjS/Udo6U8zKjYwHlR/wzmz4
         mLfj3eILVsOm/C0gv4NaM/JRH8PioghoW3QQs/zGkv+VUKrGd/sFvS78FzIM5RxIsgpy
         4IUQ==
X-Gm-Message-State: AOAM533hMmwzZIGYdTT5YAAfSAqOMmeaDNeeC7mxPUgePEALItTuiwUH
        9Dneq5iJQxMXuSmW6Le/GgOSJQ==
X-Google-Smtp-Source: ABdhPJzBAhwyVg6aVv6mrjRRdZtvbI0aDHRVp0CpwytxoU4oHMhqh6bvnLKC6F/QJ/H1EkAk82XAVA==
X-Received: by 2002:ac8:7e95:: with SMTP id w21mr21530426qtj.22.1639082897518;
        Thu, 09 Dec 2021 12:48:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i14sm389184qko.9.2021.12.09.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:48:17 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mvQKu-001R29-2S; Thu, 09 Dec 2021 16:48:16 -0400
Date:   Thu, 9 Dec 2021 16:48:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 3/3] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
Message-ID: <20211209204816.GF6467@ziepe.ca>
References: <20211209191325.3069345-1-surenb@google.com>
 <20211209191325.3069345-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209191325.3069345-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:13:25AM -0800, Suren Baghdasaryan wrote:
> With exit_mmap holding mmap_write_lock during free_pgtables call,
> process_mrelease does not need to elevate mm->mm_users in order to
> prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
> is walking the VMA tree. The change prevents process_mrelease from
> calling the last mmput, which can lead to waiting for IO completion
> in exit_aio.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> changes in v5
> - Removed Fixes: tag, per Michal Hocko
> - Added Acked-by's
> 
>  mm/oom_kill.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

There are mmget_not_zero's all over the place, can others be cleaned
after this series goes ahead too?

It seems like anything doing the mmget just to look at the vma list
under the mmap lock is now fine with only a mmgrab?

A few I know about:

drivers/infiniband/core/umem_odp.c:     if (!mmget_not_zero(umem->owning_mm)) {

This is because mmu_interval_notifier_insert() might call
mm_take_all_locks() which was unsafe with concurrent exit_mmap

drivers/infiniband/core/umem_odp.c:     if (!owning_process || !mmget_not_zero(owning_mm)) {

This is because it calls hmm_range_fault() which iterates over the vma
list which is safe now

drivers/iommu/iommu-sva-lib.c:  return mmget_not_zero(mm);
drivers/iommu/iommu-sva-lib.c:  return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);

It calls find_extend_vma() - but also it doesn't seem to have a mmgrab when it
does that mmget. The rcu is messed up here too, so humm.

Jason
