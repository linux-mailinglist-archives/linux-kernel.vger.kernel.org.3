Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFF55A18C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiFXTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiFXTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:01:22 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3181C64
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:01:21 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 184so3165179vsz.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIrc9o3Ym8mlgL0ZplaC2RFgVj5LySwYy0WilhgT4MM=;
        b=F5jEel+WZ/H/X0hplayi8ELMjTc+MXk1RcXV0sVvB5tLsPXC7BSWQoqp62PsXz58J0
         D95G8oOOfNVDnb62ka8Ji3GuiXOpjy9seJiA+8UESEwLQuz+s3RJ5+AgBWJU4KOiBy9W
         KBL5pb8qcwHIhwNXsamyqjU5En70koEkiMaoyWRBd1tMc7ma/jJktKoLWe4q/bt2lEJ+
         wVpkQATTfIgsECfn1EoNN4niUc+Sgcw+M7Kr6bvD7lKabGlYl+jCSuYBJYdvfCajUKF7
         aiyFmPguWbBZ9K1mf1ciYWoaD2SiiSANMyT2/6QttCCOmghe73hxOgVtMC1nBjBjcLqL
         c6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIrc9o3Ym8mlgL0ZplaC2RFgVj5LySwYy0WilhgT4MM=;
        b=TZFZjoxoexDGyrORlzd7h2DssXwA6Cjt+z0j4q4k6jdAY/Era2+Lds6D2XC+biK43r
         VfoAXs0PHF3wsUB6ywITV215B7AXfgtn29KeDDFhP04HAYMDKeLHJNGJ4Xu8bwCNrNyX
         znvci6aBRVNbmqYcAYckslas873fTOf0EJHvo966LAvp84gJ9k2DQyHRj2edXb8QQjym
         gb3rRQXfQI4cacp1C4ZpsHvCaT3zI2j4k9gAPl23z+mvsYA0RITfkhBPSHoMsunodP+Y
         gcq1L5PnazxJ6Mk4eYROtyFgpFZ2TBzCr6B0dG7hAHDxMXMs/dBu5f8cb56rKjmg/T43
         lE+g==
X-Gm-Message-State: AJIora8QpOF3ITT9yvLi6tZP4nZ+Wje4N5vkHz7R9+zt03nR9aHd6kQ2
        pc9RDLDjbb/2OrHT6lETTWseY6zL6a2Lq1p4U8hXjQ==
X-Google-Smtp-Source: AGRyM1vHljBh2oZBpNEDzgqpR40r2mOS+tZza5CCpAx5hr4z3f8PC2854wSd/r2sAFQBMkqppy8MfmI2w2O75WMngOk=
X-Received: by 2002:a05:6102:f81:b0:354:3967:118a with SMTP id
 e1-20020a0561020f8100b003543967118amr243458vsv.67.1656097280288; Fri, 24 Jun
 2022 12:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-4-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-4-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 24 Jun 2022 12:01:08 -0700
Message-ID: <CAHS8izOTyFApWsqvt4Tf3k4oqqOy88UzkJEv4eQvGq2G5KzAHw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/26] hugetlb: add make_huge_pte_with_shift
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
> This allows us to make huge PTEs at shifts other than the hstate shift,
> which will be necessary for high-granularity mappings.
>

Can you elaborate on why?

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5df838d86f32..0eec34edf3b2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4686,23 +4686,30 @@ const struct vm_operations_struct hugetlb_vm_ops = {
>         .pagesize = hugetlb_vm_op_pagesize,
>  };
>
> +static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
> +                                     struct page *page, int writable,
> +                                     int shift)
> +{
> +       bool huge = shift > PAGE_SHIFT;
> +       pte_t entry = huge ? mk_huge_pte(page, vma->vm_page_prot)
> +                          : mk_pte(page, vma->vm_page_prot);
> +
> +       if (writable)
> +               entry = huge ? huge_pte_mkwrite(entry) : pte_mkwrite(entry);
> +       else
> +               entry = huge ? huge_pte_wrprotect(entry) : pte_wrprotect(entry);
> +       pte_mkyoung(entry);
> +       if (huge)
> +               entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
> +       return entry;
> +}
> +
>  static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> -                               int writable)
> +                          int writable)

Looks like an unnecessary diff?

>  {
> -       pte_t entry;
>         unsigned int shift = huge_page_shift(hstate_vma(vma));
>
> -       if (writable) {
> -               entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> -                                        vma->vm_page_prot)));

In this case there is an intermediate call to huge_pte_mkdirty() that
is not done in make_huge_pte_with_shift(). Why was this removed?

> -       } else {
> -               entry = huge_pte_wrprotect(mk_huge_pte(page,
> -                                          vma->vm_page_prot));
> -       }
> -       entry = pte_mkyoung(entry);
> -       entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
> -
> -       return entry;
> +       return make_huge_pte_with_shift(vma, page, writable, shift);

I think this is marginally cleaner to calculate the shift inline:

  return make_huge_pte_with_shift(vma, page, writable,
huge_page_shift(hstate_vma(vma)));

>  }
>
>  static void set_huge_ptep_writable(struct vm_area_struct *vma,
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
