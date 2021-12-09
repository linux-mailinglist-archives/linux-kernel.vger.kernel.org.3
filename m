Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B056B46E61A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLIKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhLIKFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:05:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:02:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id k4so4632353pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5oVFdJaM2PcvUusC9hs7LeIc0YvFAbCJaVJ7FzBWJdM=;
        b=kFVc38vaTBxkwEMJdZmfRtbKqwkN31Wc5nZTgf5Fg20Ay116TKWw9FyZg0s8UM4FHP
         Fhnf+MIBC/ZO3ayNf/q4q51faWxqHALqjWZ0QbPLDwOLDBKLNe5Lct50J8ySCmzQF3dT
         c7qiLkroSDir7Ss0SGzdqv2Q5bn+IPHTtfKDkqW5UlWecpET9bftDMvgD9y7QY+6QqwK
         R7pksqgo416XTozyzHluRDszHwSQ8G9xdOQT4/a215mpHRcb+HCxTSrpSu0kCDpeJlYU
         pH1CoZRpCgHrcKaZUOnsEOyg7l3v8Z7RrCe9hV2h4VZG7XBy+95sq1+nrEYp7MUj4MtS
         eytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5oVFdJaM2PcvUusC9hs7LeIc0YvFAbCJaVJ7FzBWJdM=;
        b=uMUAHkBeTWSGIccXW+844kZmvNyjtSj1WdTUO0hbXKeilyPESO5wbjxSGtF1YDH0KR
         dQN31k51zbCCPNZ2R936udhgygeSUn/dFwk5edYhX4/VIDCDHSKPxCJjCRpr9J4W9leJ
         qzZRdDeistaBI9/apzC7qoe5J6/aojSle3OzSjTPok8MPm+V/ZfpVrMDtFE8EQARQJb8
         7WKXW+T9yOmaweksTObFIif9Rn7/QGjZ3/ZQMefPLTUZcCTqvt1/Q+6Au56zHN4xrWlt
         /jvGUXr1i8E+GZFrDtiSaQigclHa47DUPb0qOrt2A1CaT9QzhajwQYr0pD2AwB+lAKDe
         T3+w==
X-Gm-Message-State: AOAM532i20VhjgMthNQbEM7vXrS4Hd14WrfjVor4zSyxnsOb4iqj5H7o
        2VY4wjOTLGvarP4vK9qP78g=
X-Google-Smtp-Source: ABdhPJzy3TvVBy6QQSkTJFD+qdFCNy0Rp7564qrtzvh+bA8jUmTAU5XESi30JQgsDpF2u6x66E5wLA==
X-Received: by 2002:a63:e34c:: with SMTP id o12mr27909026pgj.509.1639044129670;
        Thu, 09 Dec 2021 02:02:09 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id n6sm6176458pfa.28.2021.12.09.02.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:02:09 -0800 (PST)
Date:   Thu, 09 Dec 2021 20:02:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 07/10] powerpc/mm: Use
 generic_hugetlb_get_unmapped_area()
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
        <f292a83707b64c73fcb02a8708f18f09422f7eea.1638976229.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f292a83707b64c73fcb02a8708f18f09422f7eea.1638976229.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639043741.e2zqhea1ix.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
> Use the generic version of arch_hugetlb_get_unmapped_area()
> which is now available at all time.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/hugetlb.h |  4 --
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c | 55 --------------------
>  arch/powerpc/mm/hugetlbpage.c                |  4 +-
>  3 files changed, 1 insertion(+), 62 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/=
include/asm/book3s/64/hugetlb.h
> index 12e150e615b7..b37a28f62cf6 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -8,10 +8,6 @@
>   */
>  void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long=
 vmaddr);
>  void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigne=
d long vmaddr);
> -extern unsigned long
> -radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> -				unsigned long len, unsigned long pgoff,
> -				unsigned long flags);
> =20
>  extern void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *v=
ma,
>  						unsigned long addr, pte_t *ptep,
> diff --git a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c b/arch/powerpc/=
mm/book3s64/radix_hugetlbpage.c
> index 23d3e08911d3..d2fb776febb4 100644
> --- a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
> +++ b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
> @@ -41,61 +41,6 @@ void radix__flush_hugetlb_tlb_range(struct vm_area_str=
uct *vma, unsigned long st
>  		radix__flush_tlb_range_psize(vma->vm_mm, start, end, psize);
>  }
> =20
> -/*
> - * A vairant of hugetlb_get_unmapped_area doing topdown search
> - * FIXME!! should we do as x86 does or non hugetlb area does ?
> - * ie, use topdown or not based on mmap_is_legacy check ?
> - */
> -unsigned long
> -radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> -				unsigned long len, unsigned long pgoff,
> -				unsigned long flags)
> -{
> -	struct mm_struct *mm =3D current->mm;
> -	struct vm_area_struct *vma;
> -	struct hstate *h =3D hstate_file(file);
> -	int fixed =3D (flags & MAP_FIXED);
> -	unsigned long high_limit;
> -	struct vm_unmapped_area_info info;
> -
> -	high_limit =3D DEFAULT_MAP_WINDOW;
> -	if (addr >=3D high_limit || (fixed && (addr + len > high_limit)))
> -		high_limit =3D TASK_SIZE;

I wonder if generic hugetlb_get_unmapped_area needs to have the
arch_get_mmap_end() added.

arm64 has arch_get_mmap_end() and !HAVE_ARCH_HUGETLB_UNMAPPED_AREA so
it looks like it has broken large address hint logic for hugetlbfs
mappings? x86-64 defines their own and does the same hinting for
normal and hugetlbfs mmap.

If we had that and defied arch_get_mmap_end(), then this patch should
work.

Thanks,
Nick
