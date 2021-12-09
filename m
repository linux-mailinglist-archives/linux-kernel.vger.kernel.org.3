Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1841D46E5AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhLIJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLIJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:39:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF34C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:36:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5795680pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 01:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ANnqQo7YlVyJRVO2UBynpUD5QgJ1sL4B6Gna7gav4x0=;
        b=b2ViHkJCp5m2+2YQHTPTBDm3RXv4V9ziuzsBvMmlYIRLLAOHKjnI0TyaxmWM0mwzzE
         sTEowXvVIH/XHfcRygVyF9S8R03oieKXkXP5ZrR1GTIuxfMMkJCH4KHjcm/Cv4Mw8q/u
         Op5FnGErqqIGrcCx3n5EE/Yv9ta4UdDVjhZUSZqoDm9WA5EUH+2TehBUWdv/4vh2myyy
         casRoLbcXeK4OYu0zE04pKOKQk5SoMBTi/Fckg/qDnwjpvDErFnYp6eUxL4M7cNHZzAM
         PrMt9U5KCKplnJmehYc13wsAimamkDxvhE6PJAWFf4JnU7sPBWrStGm4CPeMcyoziKWp
         b99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ANnqQo7YlVyJRVO2UBynpUD5QgJ1sL4B6Gna7gav4x0=;
        b=EOOOyjWMB9SZNZTPThhN/kA3j/B9kaAbSReDnHyCITinOOdGOgC0zlAUyRIP+ygC1g
         xy8mwJsP+Xq8hzFH1s+oW06HVbmKLmZ/44wl0Zc/a6Ld0+8I4z2sCO1Eug9pCU57EpO7
         HODAHWjJQbl7WZpg9J2Vtp6guu/2Xtde4YVUCeI61/C17OnjhePHueJoPEcAEmXg0V1H
         tvSIquh9amErr6q2blKnPi9WOLD6U6oEsKFz0k2Hu1aVC2BlnQiyRf5rb4o30H0T2DFd
         AtyCJB/Sj180J+Fx++Y0+FUWhrCI7burwubX3Ax2uUwQKTIy2Ry7sInqBeFPW3PZG77V
         oD5Q==
X-Gm-Message-State: AOAM530dsLZ+QQ9vSe5dkgp+gzaxYuFN2N2FzJOyOalzR8A1iDJGpAhu
        ZST8MoE/RysK+7lHsOjDJxw=
X-Google-Smtp-Source: ABdhPJxAboP2NZuRVxFnuWAZ/4Plf9uJs6kjYeQI3ZWn5Gl+RspeZdtlIldC9e6K060mWaNM2FrOMA==
X-Received: by 2002:a17:90a:b88d:: with SMTP id o13mr14105935pjr.39.1639042581800;
        Thu, 09 Dec 2021 01:36:21 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id g7sm6435078pfv.159.2021.12.09.01.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 01:36:21 -0800 (PST)
Date:   Thu, 09 Dec 2021 19:36:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 03/10] powerpc/mm: Move vma_mmu_pagesize()
To:     "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1638976228.git.christophe.leroy@csgroup.eu>
        <372d1488c35dca1c5af04f95d9b8548ea07ea603.1638976229.git.christophe.leroy@csgroup.eu>
In-Reply-To: <372d1488c35dca1c5af04f95d9b8548ea07ea603.1638976229.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639042485.7qs1vmt7kw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
> vma_mmu_pagesize() is only required for slices,
> otherwise there is a generic weak version doing the
> exact same thing.
>=20
> Move it to slice.c
>=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 11 -----------
>  arch/powerpc/mm/slice.c       |  9 +++++++++
>  2 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.=
c
> index ddead41e2194..0eec3b61bd13 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -565,17 +565,6 @@ unsigned long hugetlb_get_unmapped_area(struct file =
*file, unsigned long addr,
>  }
>  #endif
> =20
> -unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> -{
> -	/* With radix we don't use slice, so derive it from vma*/
> -	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled()) {
> -		unsigned int psize =3D get_slice_psize(vma->vm_mm, vma->vm_start);
> -
> -		return 1UL << mmu_psize_to_shift(psize);
> -	}
> -	return vma_kernel_pagesize(vma);
> -}
> -
>  bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	int shift =3D __ffs(size);
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index f42711f865f3..8a3ac062b71e 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -759,4 +759,13 @@ int slice_is_hugepage_only_range(struct mm_struct *m=
m, unsigned long addr,
> =20
>  	return !slice_check_range_fits(mm, maskp, addr, len);
>  }
> +
> +unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> +{
> +	/* With radix we don't use slice, so derive it from vma*/
> +	if (radix_enabled())
> +		return vma_kernel_pagesize(vma);
> +
> +	return 1UL << mmu_psize_to_shift(get_slice_psize(vma->vm_mm, vma->vm_st=
art));
> +}
>  #endif
> --=20
> 2.33.1
>=20
>=20
