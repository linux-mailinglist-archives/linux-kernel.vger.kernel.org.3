Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD94CC692
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiCCTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiCCTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:52:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245E1A39D9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:51:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so12984936eju.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjmWT/W5MRqML4fV3l4pipH2e7/zhAuEQ7CGP/nmDbM=;
        b=bNXFAaflB55BjF2vEloQHSSJIxeOGy0jLkFcVy1CXkF0XyVe0a9nTBaTyP5kHa+g+e
         mA5iKiBRiynFpXgd6FGPvYFk1Wn1UKWvLgSr7rMghEftWcpW/zwxua6wkisl9n/TdxBS
         1tUshZbkOaiprXD4UTmcZsamRW+UmrZ6PMEu6JBcvXY8p1Ly/PI4w1Bqws3U0H2z3sI0
         5umEPO11T9SzsU1DCEbPSYRgkQxXt+pjLTexGJrFnaaCtafbNXyxxsc/M6oyTkEIUYqR
         LgDEUkPmo/Sam58MWhBfdm3OBF+USHeiDJsXS1hH70P6D7/SPsZc2CnFkj/Cpm4AM9Gs
         TzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjmWT/W5MRqML4fV3l4pipH2e7/zhAuEQ7CGP/nmDbM=;
        b=Y7A7rQbA5lC7063INR+H8gqCedoSg5thbu4FsKOasKGfDsiw4Tz4jZgGqqmulprLBE
         Kfk0i2gDVD3md4btgP30b8yZ9R3I1Sh0jdmrEB949+0hccxW+OGOLFoAPQQiyEwpDrq3
         g0fS1+KuyLxPfQcCm4IPq8b8DESBRBO9Mf/1XRK2+sss0cJzcP7NIg2TbgEndUM6XowZ
         J1C2o4Db192ULmx+7P30dYbZy2+07AivSWk0oQ31bwa3Hub6wjChDdEMTupjYPWyXPYc
         yYS6Bi9x6OxJO7aq/mcZFj7m/HoAeKZeXIEV/V6yCD4DRM8oCM39ClzEQvrdRG+Mlbus
         s/5g==
X-Gm-Message-State: AOAM5326M4K84hYPrYXVy/ewZaTG/0fGvKCv+2d3xg9pzYSaGvbKhnEs
        F9TjPirOn8Fee3cmc4/jbJs8AfsV5xYG0DN9W2M=
X-Google-Smtp-Source: ABdhPJzuicciNIaD29btjcvtEpl11t9WodpI6Lk5thTnnh5192JvUE8OYxi/RYjedjFjZS4JW2dJz9TUg3MQ+Gkswzc=
X-Received: by 2002:a17:906:5d12:b0:6da:960c:7e30 with SMTP id
 g18-20020a1709065d1200b006da960c7e30mr2855735ejt.380.1646337117337; Thu, 03
 Mar 2022 11:51:57 -0800 (PST)
MIME-Version: 1.0
References: <84792468-f512-e48f-378c-e34c3641e97@google.com>
In-Reply-To: <84792468-f512-e48f-378c-e34c3641e97@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Mar 2022 11:51:45 -0800
Message-ID: <CAHbLzkppwEBSkd2QFAHkRfQPsLqzRqPegbNUg_bnY62ai2Emyg@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm/thp: refix __split_huge_pmd_locked() for
 migration PMD
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
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

On Wed, Mar 2, 2022 at 5:43 PM Hugh Dickins <hughd@google.com> wrote:
>
> Migration entries do not contribute to a page's reference count: move
> __split_huge_pmd_locked()'s page_ref_add() into pmd_migration's else
> block (along with the page_count() check - a page is quite likely to
> to have reference count frozen to 0 when a migration entry is found).
>
> This will fix a very rare anonymous memory leak, after a split_huge_pmd()
> raced with an anon split_huge_page() or an anon THP migrate_pages(): since
> the wrongly raised refcount stopped the page (perhaps small, perhaps huge,
> depending on when the race hit) from ever being freed.  At first I thought
> there were worse risks, from prematurely unfreezing a frozen page: but now
> think that would only affect page cache pages, which do not come this way
> (except for anonymous pages in swap cache, perhaps).

Thanks for catching this. I agree there may be anon memory leak due to
bumped refcount. But I don't think it could affect page cache page
since that code (bumping refcount) is never called for page cache page
IIUC.

The patch looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: ec0abae6dcdf ("mm/thp: fix __split_huge_pmd_locked() for migration PMD")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> That's an unfair "Fixes": it did not introduce the problem, but it
> missed this aspect of the problem; and will be a good guide to where this
> refix should go if stable backports are asked for.
>
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2039,9 +2039,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 young = pmd_young(old_pmd);
>                 soft_dirty = pmd_soft_dirty(old_pmd);
>                 uffd_wp = pmd_uffd_wp(old_pmd);
> +               VM_BUG_ON_PAGE(!page_count(page), page);
> +               page_ref_add(page, HPAGE_PMD_NR - 1);
>         }
> -       VM_BUG_ON_PAGE(!page_count(page), page);
> -       page_ref_add(page, HPAGE_PMD_NR - 1);
>
>         /*
>          * Withdraw the table only after we mark the pmd entry invalid.
