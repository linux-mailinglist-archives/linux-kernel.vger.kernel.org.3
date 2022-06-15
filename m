Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966AA54D3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349623AbiFOVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346434AbiFOVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:36:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7B56381
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:36:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u18so11499330plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liEq3vTBzjbeEOgGm9j8jdSvHDZIAOUrgNJBC9Mei7k=;
        b=SfpbG/R/1cL+p415YQgXtEAqXlPY2tWuY5j5/RzVTJWFDAclmh8IcA35qoSdcVUE8B
         V1IfBRuDWrn5+htxaFyyCjh7MDMNohRxD8EZFppRYvipzz4fF3iBlYQ3eJBlCYgS6fwi
         z7vu8Itu7b8j/HYfaqt2UW71Ad2XAzi+Kn2Owajt8QvGnU/KbznSzR+88BkMTvJmmPoh
         l9/75WwY9Lsx3z5EMeN6IPpCq71SEwAAsZz5QB4GGZ7KM/1+BVb2rMqVmg7bH7qUbeiP
         RQTy/CkiAcQO7mMpQILl9QUoPhtPCFfOp9Eqw7GzoRiO9Wuy2K+C26KkxgB2LJIx2pg+
         urPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liEq3vTBzjbeEOgGm9j8jdSvHDZIAOUrgNJBC9Mei7k=;
        b=dHhmD5nx/m3ITW/LvHzaMLlKke88X3VHbBR9IS+zExyHij23qZTt4tMD9LqFChJ/hB
         DjiuOfNgEhhIZOCGoQen1xMeZk9NoILS33lEo8/CeqVSyfIJXH2kEz+rAEDEQYXUkfId
         Z9s2Z8Dc+Y1kFsifqXfqxus27P/WXJ3BU5UhniQKDDKdP95OKi/Z/N6droWw0drrtbLt
         ul3fwFqmCxNWnS2HkXfGsBWY0vME6ZRCamafnJxQmmCptQRviW5SSz/XJviu2ItjP4dj
         9lhoYe+r1UixxBYJrrEaOHFgZCaaVa4jci1AAkTazGiJOZVRqb89fzIweeAHGbFcOeOp
         hndw==
X-Gm-Message-State: AJIora+UFQ490QUblbiZKIIPj/FLRU38tN+UVrQDocz6RvCJa0jl9qdg
        mJj45nlecNg8EURAKAOQu3WGHMtJ8WbRg6SmcVQ=
X-Google-Smtp-Source: AGRyM1v9bzZXIMQlrwrf3iX44DrRyXyp98zyb72ewbQ0053q7cZtMja4mrbigfHdyi9NBRoH9cWxHDN3rdfrMd54uaI=
X-Received: by 2002:a17:902:8492:b0:167:6cbf:145b with SMTP id
 c18-20020a170902849200b001676cbf145bmr1750643plo.26.1655328961593; Wed, 15
 Jun 2022 14:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-7-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-7-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 14:35:49 -0700
Message-ID: <CAHbLzkp98QWpUJOB0ytBZrycp=dBNckjc3fH5NCNTUvtaVcW_g@mail.gmail.com>
Subject: Re: [PATCH 6/7] mm/khugepaged: remove unneeded return value of khugepaged_add_pte_mapped_thp()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The return value of khugepaged_add_pte_mapped_thp() is always 0 and also
> ignored. Remove it to clean up the code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 142e26e4bdbf..ee0a719c8be9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1372,7 +1372,7 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
>   * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
>   * khugepaged should try to collapse the page table.
>   */
> -static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>                                          unsigned long addr)
>  {
>         struct mm_slot *mm_slot;
> @@ -1384,7 +1384,6 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>         if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
>                 mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
>         spin_unlock(&khugepaged_mm_lock);
> -       return 0;
>  }
>
>  static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> --
> 2.23.0
>
>
