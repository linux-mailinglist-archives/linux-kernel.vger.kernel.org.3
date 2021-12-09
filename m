Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D246E5ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhLIJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhLIJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:53:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15567C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:50:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5817149pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=dflFa57KzKY7miq+oyqL8dKoeanSyMiQ37rQN5fCdoo=;
        b=hSPPIGtTqBk+SmIs7bjQkgAd5gyMcHBS3ZjLqd+5UqIjZ17nfbytSiaBWT8xWtdKxi
         6y5NybwuBgMxW03+gjYkLqtgAjWrl6CPBoMeE3YkLBvk59H1XlB+NAhh7ymmfCFTmT5G
         VYYQgAn+eV3uoQUzoDZ65L62QhWGznavzTEhpPr/K2H8FbWfMlV3cijHGTUteCzCFmXO
         Ta+ZnlYSBlpp4c4BL4oARIkInvSme3Z4IoifXmF/knJdxvFJJWYUG6C0L+k/TLFQH++q
         Ki7++aPkAX5x4uAT2XFfODKECO0xvS6IwICKeCe3FvH8wzNjbKORxujyV48thLG3F51V
         4AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dflFa57KzKY7miq+oyqL8dKoeanSyMiQ37rQN5fCdoo=;
        b=1+QbKlBBCEPIBewsue0qHfNs5r31Yif79OeAvvm+3639ziOWUigh0P6POX4GN63L/P
         jwNt1DbKQCSUdJ0B1aL1J7ZMuklUK1n3GnozJriw7vfgTQ1FjUInyh34uqMFPrJr/On2
         r/DIgkliwLXN727m6rYnO40HjVUCZBOBGHrMdPaQ81DmQXrGWxeGAvQGkax5Trer6Ohj
         +nul0k1i7537/T8S9ac8Wd7XLCvE5772m/9VybEHOZWNt0OAASfzRLSUxmLNywa40zzY
         NIpHvMsu798qQ0yWghPIEKMHbHLyJI3tVfq8qQTYeyqso+egQArY3B3vs6LbtvqLnLbl
         Xu1A==
X-Gm-Message-State: AOAM532586DYkambY0zeFVJzMQxWan/kH5XNmSRtSaNummt5gzefpFOI
        DCnUb/2rcMk7ukbKLsfHANw=
X-Google-Smtp-Source: ABdhPJyY2fdAACtiJPICzx8niudtj7D9tiYJtKmUUH+J5Ymcu4yJcVh8uUq3Z3w9yYkhJiN/99VgAA==
X-Received: by 2002:a17:903:185:b0:141:f5f3:dae with SMTP id z5-20020a170903018500b00141f5f30daemr66362344plg.56.1639043413657;
        Thu, 09 Dec 2021 01:50:13 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id f15sm7099488pfe.171.2021.12.09.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 01:50:13 -0800 (PST)
Date:   Thu, 09 Dec 2021 19:50:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 06/10] powerpc/mm: Use generic_get_unmapped_area() and
 call it from arch_get_unmapped_area()
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
        <8f54a8d097c402d808147b2044365ebfda2862dd.1638976229.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8f54a8d097c402d808147b2044365ebfda2862dd.1638976229.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639042828.6q5z2bujam.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
> Use the generic version of arch_get_unmapped_area() which
> is now available at all time instead of its copy
> radix__arch_get_unmapped_area()
>=20
> Instead of setting mm->get_unmapped_area() to either
> arch_get_unmapped_area() or generic_get_unmapped_area(),
> always set it to arch_get_unmapped_area() and call
> generic_get_unmapped_area() from there when radix is enabled.
>=20
> Do the same with radix__arch_get_unmapped_area_topdown()
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/mmap.c | 127 ++---------------------------------------
>  1 file changed, 6 insertions(+), 121 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> index 9b0d6e395bc0..46781d0103d1 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -81,115 +81,15 @@ static inline unsigned long mmap_base(unsigned long =
rnd,
>  }
> =20
>  #ifdef HAVE_ARCH_UNMAPPED_AREA
> -#ifdef CONFIG_PPC_RADIX_MMU
> -/*
> - * Same function as generic code used only for radix, because we don't n=
eed to overload
> - * the generic one. But we will have to duplicate, because hash select
> - * HAVE_ARCH_UNMAPPED_AREA
> - */
> -static unsigned long
> -radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
> -			     unsigned long len, unsigned long pgoff,
> -			     unsigned long flags)
> -{
> -	struct mm_struct *mm =3D current->mm;
> -	struct vm_area_struct *vma;
> -	int fixed =3D (flags & MAP_FIXED);
> -	unsigned long high_limit;
> -	struct vm_unmapped_area_info info;
> -
> -	high_limit =3D DEFAULT_MAP_WINDOW;
> -	if (addr >=3D high_limit || (fixed && (addr + len > high_limit)))
> -		high_limit =3D TASK_SIZE;

Does 64s radix need to define arch_get_mmap_end() to do the above now?

Otherwise great to consolidate this with core code, nice patch.

Thanks,
Nick

