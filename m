Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0355EFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiF1Udg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiF1Udd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:33:33 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152619C2C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:33:32 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z66so13162944vsb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96xhbYiTU/KE791cPv1Ec34DiphPIV0a/3KLjf6U6CU=;
        b=pJdg7XilXTxEPJguu4B1V6t1yFrgRPJzgTB0zzXha1C0GXvPImTaTne5Zzeo0FeO/X
         8T98FE9DmEc7nU6//lotpccvFw+/0RR1fnbOxgJQoOr1Y3U6ouyJOrn1EDUAWehotCSx
         L1ReCZAm7nyaboEl+krLn/tXxHQ1nYzVpDyvDBkYS8gt59GGHCQahyjA76hMGmvVZGma
         CI9704uPQwIqsRGyqxBNg4Vsd1+c8AkXgPFMDN/vkiNrtHBmpoN6c/ILQXw8FtTDOS+g
         BQnwIkKVjlosjhxBA/69lY+KXRf3Ne96YenH4qA/kirD8hVWx3oXZB6bSnv6UROwPy5v
         0+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96xhbYiTU/KE791cPv1Ec34DiphPIV0a/3KLjf6U6CU=;
        b=r8Isa2/60z7QWkz88vX+FxjCMuJLTJ/kX/nCFuIA4bvQ3JSVPOiW97Cdn2yGRwqLdh
         b59/SLfAubKS0TAf2SeRPN6NgSkCjvcTUYzTTd4syaTqQkg4ukVYxthwJdP/0Fy2QLwZ
         VDuAd/IJkUgM2UhD22Um9QgLocVXkliI7jN6fwAGTcmYXNdQVJbtsPe0a3q20TMwKXUY
         iBsSWZOO7E5iChGTfP7lC3AThJnRuTEp6ATXFTeCRHYrPNhy+BqeFeipT4WpHQ5YSIq4
         3p3wETtCuPw4wd10ky9ObQO94VDpTODE3pwlibGGsI51eKXQLL8vAGqfcBmF8r7Xj4nS
         sLJA==
X-Gm-Message-State: AJIora/FIG3OjLNt1MOrTLrw5ighbJkCIiBqhqIBA/HR4b/YwQe+/QC9
        0bO7XrwlibT/RPWEdQ0jQGHV/DybcrhJN7Bth17fEA==
X-Google-Smtp-Source: AGRyM1uVlFBAQwA+pYsT/CH8aC8G895Y3mPd0TsSfST3Ox2ZooTS7yCmHDP6hooIdjCk7r0C7q0e1IpezEcsMQUiEgA=
X-Received: by 2002:a05:6102:f81:b0:354:3967:118a with SMTP id
 e1-20020a0561020f8100b003543967118amr2549996vsv.67.1656448411327; Tue, 28 Jun
 2022 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-10-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-10-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 13:33:19 -0700
Message-ID: <CAHS8izNb5quGb-iqj3h52i9sFKwxYy=HiMmyVYVTMOKjWeZrtg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/26] hugetlb: add hugetlb_hgm_enabled
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> Currently, this is always true if the VMA is shared. In the future, it's
> possible that private mappings will get some or all HGM functionality.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  include/linux/hugetlb.h | 10 ++++++++++
>  mm/hugetlb.c            |  8 ++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 33ba48fac551..e7a6b944d0cc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1174,6 +1174,16 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +/* If HugeTLB high-granularity mappings are enabled for this VMA. */
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>                                         struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a2d2ffa76173..8b10b941458d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6983,6 +6983,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       /* All shared VMAs have HGM enabled. */

Personally I find the comment redundant; the next line does just that.

What about VM_MAYSHARE? Should those also have HGM enabled?

Is it possible to get some docs with this series for V1? This would be
something to highlight in the docs.

> +       return vma->vm_flags & VM_SHARED;
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
