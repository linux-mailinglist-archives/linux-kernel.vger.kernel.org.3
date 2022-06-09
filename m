Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58B545355
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiFIRuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiFIRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:49:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05221D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:49:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u23so39169318lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0Vji0EjnoY15nq95wdEHkqVUnYc8nZBcuXoE9qlWJw=;
        b=iVzTNtmsg/ZMgOKayzXHbuj5O3maSElPPq3+9aHx1Gs5efAUuC3W6u23v37NhjYv+E
         bMI+HkLmvAoiwBwlj1bTH2GH3JpYiNao3p7O8VC2/B+ApsbZmS39D+w77U5HEbaM6ghk
         aSQXNQODhEZH2cEz/DfWhLz2LueoiAyFgY7dSYi9vmw2Hw1O4rYUp6L3lUc1otb5Z7GL
         dPLC8QsP6l5rfWPhDw5N4PN8CR+4M0yzdYBU8RxrpPTN0wnYyrrdWxkASUqCkiBYMKjP
         VAHPyHqwBAwj1XyqG0MBNFf1fdquqxeZLCgc26bR5rmub8YYP7gFQtAPcb7UDLPwCtJe
         y/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0Vji0EjnoY15nq95wdEHkqVUnYc8nZBcuXoE9qlWJw=;
        b=Bodnq5VQHYzQMTim2lFcFTzJgDelUT1UyGu5oMFCyQCjejmBfyB680rRfpaqWBCRIJ
         xOsZvYe/K99BWrunEJnJTyUnX2e79dQc+cfI7ylpB1rvIHJCP1d3lhHv1thcUTHADn9n
         Ou3Ho8S+f87wCjA/JRwrFKv5uGYpIQqjIdQQIfjm9sH6boXE+ftleF1MNBa+CSyyWXxC
         vZFeJp0zClTWxyd2/GFiEsRCgib63e+ab8zoPn0h0NlGfmIxUe9FycShFwvRqsME+7wt
         BL2yeO81DbI0wxcQmGApSpbj4XTZwQ2ErDYNQtThgAvm+zcggH70zUW+2ndYEb/7XWmM
         PfzQ==
X-Gm-Message-State: AOAM530hzihsEtbEX6/89BhXMPek0wpadsTJYWbmCPOPBE0Qjo+KsYas
        0q022YDVwKSH6AfpCwzriUFSS6iBB62szgQn/DOT4w==
X-Google-Smtp-Source: ABdhPJz0AJQ7nUsBXpgyPLtEn6TRkv3ozMeeXS6kJlPpnt9pJAzGs+9Ye5AEKMkwVa93Djdixbfko6i9P6ZIMVIGlzs=
X-Received: by 2002:a19:6742:0:b0:479:17b7:afa6 with SMTP id
 e2-20020a196742000000b0047917b7afa6mr21400796lfj.159.1654796996153; Thu, 09
 Jun 2022 10:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com> <20220606214414.736109-2-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-2-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 10:49:19 -0700
Message-ID: <CAAa6QmQJyaWTdjd35DNy34uqbFq5_x35JwT52OZuydA1HDAaNg@mail.gmail.com>
Subject: Re: [v3 PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Currently the THP flag check in hugepage_vma_check() will fallthrough if
> the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
> since all the callers have the flag checked before or can't be invoked if
> the flag is NEVER.
>
> However, the following patch will call hugepage_vma_check() in more
> places, for example, page fault, so this flag must be checked in
> hugepge_vma_check().
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 671ac7800e53..84b9cf4b9be9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>         if (shmem_file(vma->vm_file))
>                 return shmem_huge_enabled(vma);
>
> +       if (!khugepaged_enabled())
> +               return false;
> +
>         /* THP settings require madvise. */
>         if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
>                 return false;
> --
> 2.26.3
>
>
