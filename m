Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73514ED254
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiCaEOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCaEOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:14:07 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3928EA28
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:46:06 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e6ceb45174so201046847b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+ueIIKq75xrOgcbpQGCP0Xp5hXOruV4yiy78MzdsaM=;
        b=xF/J7v97bhv1UsQTHnB+oBqMfeIAD9hShTLRksgabyqK2tVhgKtDtkLmc5GQKPQhfo
         dnm1DcIGeLSIDCQ/OkLHR4kYPHLDVeVa1G/NKeXdtKoyJubynsPePbmIvtT6tsPIElCv
         xhatSYIul1FpQ+5luE2LftI/IaNtqtDgcwiMiEJRe2lSE4op1T4f203G18T5JZRVM+WQ
         Y+1+SFuF6v00ObQ0dQyfehBxjpDArKxpBsg8GF2ZDtDKHMqQgsoVXTUUr9+/Hw5QtlLD
         llIC04kkVwqvRIAmy7WDCVRlb/tq4OGtEMZcFd7bbhdxjMxxf+GON+jNTy2a6YdUgXpy
         PAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+ueIIKq75xrOgcbpQGCP0Xp5hXOruV4yiy78MzdsaM=;
        b=AtQHGMJtwOtJ5MypS21/zzyKNcy9KCPg+oJ6UBdKw6TAP3ALT6PIfsdtwMRBE8f6zL
         1wnLr/5azZLFUEb3qk8u9ikrjpVWAfowtENMEc2N+4oV/jXB48MY2jZFCDIeSMxSXJkS
         Rd18mkTICkIfEysrX+cSLoJpZ40fztpK5zNjsTOUf1FZJMvoc6K5mxG3KmtXwqOq6VCQ
         U838x6ChNKD8WeiW+8YxMf8p4zPh1U30qBBkMhlsVOPs17B68sknCMi3b6j/E64CwI/s
         Cr+PhMME59N9xYCIe4Fy5a5wOv9yaTR4vDJrUn4EjQcDoUcYFdKDfGq7jBggt9r+U7Dm
         qAuA==
X-Gm-Message-State: AOAM531LItyj32W2DDqLp0yv510pb48gOFgiqrWg/Sj30KQ77WLY8gNt
        Mi6w2u5aQMw/kjbKVqwVUG8X9s5trAPZmjxxkO70kA==
X-Google-Smtp-Source: ABdhPJzAjwosvewbJoeV/iiCgGlooRUtsyvcPlkFEVpMn3m+Ye5MVLmT/reJ4+CbJIPHMSFZy+YQ1bp1/u/2GLohUgY=
X-Received: by 2002:a81:3756:0:b0:2e3:3db4:7de1 with SMTP id
 e83-20020a813756000000b002e33db47de1mr3232544ywa.458.1648698365817; Wed, 30
 Mar 2022 20:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220330153745.20465-1-songmuchun@bytedance.com>
 <20220330153745.20465-5-songmuchun@bytedance.com> <20220330193657.88f68bbf13fb198fb189bc15@linux-foundation.org>
In-Reply-To: <20220330193657.88f68bbf13fb198fb189bc15@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 11:45:29 +0800
Message-ID: <CAMZfGtWqaM5n38kSvjTJxCSYVq-ic30-VmshrYK9xXsF=Fe10A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mm: hugetlb_vmemmap: add hugetlb_free_vmemmap sysctl
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:37 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 30 Mar 2022 23:37:45 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> > server to enable the feature of freeing vmemmap pages of HugeTLB
> > pages.  Rebooting usually takes a long time.  Add a sysctl to enable
> > or disable the feature at runtime without rebooting.
>
> I forget, why did we add the hugetlb_free_vmemmap option in the first
> place? Why not just leave the feature enabled in all cases?

The 1st reason is because we disable PMD/huge page mapping
of vmemmap pages (in the original version) which increase page
table pages.  So if a user/sysadmin only  uses a small number of
HugeTLB pages (as a percentage of system memory), they could
end up using more memory with hugetlb_free_vmemmap on as
opposed to off.  Now this tradeoff is gone.

The 2nd reason is this feature adds more overhead in the path of
HugeTLB allocation/freeing from/to the buddy system.  As Mike said
in the link [1].
"
There are still some instances where huge pages
are allocated 'on the fly' instead of being pulled from the pool.  Michal
pointed out the case of page migration.  It is also possible for someone to
use hugetlbfs without pre-allocating huge pages to the pool.  I remember the
use case pointed out in commit 099730d67417.  It says, "I have a hugetlbfs
user which is never explicitly allocating huge pages with 'nr_hugepages'.
They only set 'nr_overcommit_hugepages' and then let the pages be allocated
from the buddy allocator at fault time."  In this case, I suspect they were
using 'page fault' allocation for initialization much like someone using
/proc/sys/vm/nr_hugepages.  So, the overhead may not be as noticeable.
"

For those different workloads, we introduce hugetlb_free_vmemmap and
expect users to make decisions based on their workloads.

[1] https://patchwork.kernel.org/comment/23752641/

>
> Furthermore, why would anyone want to tweak this at runtime?  What is
> the use case?  Where is the end-user value in all of this?

If the workload is changed in the future on a server.  The users need to
adapt this at runtime without rebooting the server.

>
> > Disabling requires there is no any optimized HugeTLB page in the
> > system.  If you fail to disable it, you can set "nr_hugepages" to 0
> > and then retry.
> >
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -561,6 +561,20 @@ Change the minimum size of the hugepage pool.
> >  See Documentation/admin-guide/mm/hugetlbpage.rst
> >
> >
> > +hugetlb_free_vmemmap
> > +====================
> > +
> > +Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap
> > +pages associated with each HugeTLB page.  Once true, the vmemmap pages of
> > +subsequent allocation of HugeTLB pages from buddy system will be optimized,
> > +whereas already allocated HugeTLB pages will not be optimized.  If you fail
> > +to disable this feature, you can set "nr_hugepages" to 0 and then retry
> > +since it is only allowed to be disabled after there is no any optimized
> > +HugeTLB page in the system.
> > +
>
> Pity the poor user who is looking at this and wondering whether it will
> improve or worsen things.  If we don't tell them, who will?  Are they
> supposed to just experiment?
>
> What can we add here to help them understand whether this might be
> beneficial?
>

My bad. I should explain more details to let users make better decisions.

Thanks.
