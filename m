Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B85476A80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhLPGlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhLPGlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:41:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C644C061574;
        Wed, 15 Dec 2021 22:41:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v13so750486pfi.3;
        Wed, 15 Dec 2021 22:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArBZty9F8manrgCKxo2XVUz8HSojtN8IjPyjuiPK50E=;
        b=Bu2ruXLj4/tHxkppDKDaPtP8Yj99YwwDFRpFRMWeIvWBbdE9ZxR8foipinySOJGntK
         asmrPte/BoFmm1SBWwrhsX/9DLi5mW9zS8/dFii7r487OoaY2MP0i8t/VR6A/LsXaOx0
         gBDiBOD43gKHhGB1jIv3CIgf8zm5jJ19bjOdXhhQwARURYtwf/6XAIbwnlh105N9m9SS
         BBVnn0Nn8p6wBpi/5OWGP7ExEqbXLBz58zszxbzq7EHtk2aoCB1F2JtBJX4v6YSTVfmN
         4Anhnmg6V+ENC6TeiWoF5IleLcfWmNI4idCmTe9/gB7sBRsaQHXHhweUxBQpsr++d3MF
         /KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArBZty9F8manrgCKxo2XVUz8HSojtN8IjPyjuiPK50E=;
        b=UfC9xFk+VlszrmwoJA5rS05K1eLdo/rPZfl7ThcYYXam5Il5CJnaZCloCTXI6qwPqw
         7Gr8goB9chNmoU491BvxKViHD+7WjJBbHe8doxIR1RwhpB5qbVfbGu3AESvaKjq5g+kO
         L9h+G9vZ/KL61OqAXmhqHtXdsM+V5Sl203m/Ok34dWSwvMBzzDHaANBQowxdnhwv+k86
         FDM3sdYBJS7X7eybmSBQXAqSsuTMfk2fGGD4nvVa/KB+xqdQ1DRU4Mja10vIy8Lh+6RZ
         aiglvjt1ooRorDsl3faykqLXRfy+n2er7N/L4LHxCtBuR0Krpam2EJAztCdTXo5rOLC0
         0yAA==
X-Gm-Message-State: AOAM531L5SKkUDE0asB8HS5rw2QdJPAqBSkiFrnGibzYPkw5URgx1wYJ
        +nagMqM7VkwXO5BFnF4KtMMFGzf4PXtw7ca9dBE=
X-Google-Smtp-Source: ABdhPJz0EsLxdA66bhXO5hjCGuSToPtFicyMLgWAaL1gxxOAbM4QqdwTNyHfXIy3tmkY6y9BXpVF60sogkFf77Ql3TE=
X-Received: by 2002:a63:2a0d:: with SMTP id q13mr10954563pgq.513.1639636874555;
 Wed, 15 Dec 2021 22:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20211215232432.2069605-1-keescook@chromium.org>
In-Reply-To: <20211215232432.2069605-1-keescook@chromium.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 15 Dec 2021 22:41:04 -0800
Message-ID: <CAAH8bW9e_O_3DSjZvN3YENCkNB9oa63bMb93PaOCwZ6AxbfTHA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Use correctly sized arguments for bit field
To:     Kees Cook <keescook@chromium.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 3:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
>
> In file included from ./include/linux/bitmap.h:9,
>                  from drivers/iommu/intel/iommu.c:17:
> drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> ./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
>   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                                     ^~~~~
> drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
>  2115 |         int pds, max_pde;
>       |                  ^~~~~~~
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

For all patches in this (not a) series
Acked-by: Yury Norov <yury.norov@gmail.com>

But can you explain, what for did you split this change? The
Documentation/process says: "Solve only one problem per patch.",
but here one problem is solved per 4 patches with identical
description.

I think it would be more logical to move-in this change as a single
commitment rather than random scattered patches.

Thanks,
Yury

> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b6a8f3282411..99f9e8229384 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2112,10 +2112,10 @@ static void domain_exit(struct dmar_domain *domain)
>   */
>  static inline unsigned long context_get_sm_pds(struct pasid_table *table)
>  {
> -       int pds, max_pde;
> +       unsigned long pds, max_pde;
>
>         max_pde = table->max_pasid >> PASID_PDE_SHIFT;
> -       pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
> +       pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
>         if (pds < 7)
>                 return 0;
>
> --
> 2.30.2
>
