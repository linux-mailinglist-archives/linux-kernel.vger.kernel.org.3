Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A87535D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbiE0JNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350528AbiE0JMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:12:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA9140402
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:09:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v26so6956732ybd.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TG+iSsiIbLTbPNNUL0ORzg2RkUZbD1rwYMRW4iLJ3AU=;
        b=fyD49Th59LU888uf582LKdFMlTJSAarmXQqeFevtl8BYVsIVRx4+iX3lyi7uFdKsLZ
         Rlgl0gCcsPo9iRtcUchSVBJclKPisbAleBC+OWDN0LXvzCaVtZcdtQW99sh0IS3BRCa9
         mYgE62zU/KspvzwVKo3rMik0y01+tK/agY2mJAhS7XzYKGi5Oqc4einUiM4Dj9Rd2cjd
         AXzfcu9DoMkGLUCRGzfnjdF+elltlbAcYApGu6eLqo77KjhPXQ9vX5KVdaSTjcQ7K3bZ
         G8ShbVWhJQ7ACH3DohXPMiyEQashOEhFeFd0cP/s8Y0Q4VSLNXYrE4W0nvJdZwexB+Ek
         vo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TG+iSsiIbLTbPNNUL0ORzg2RkUZbD1rwYMRW4iLJ3AU=;
        b=CJW0DKmX0KZVejAPSfL3wv4Vj8ilEYrHX5Be7asB1zmnhlMv+UzZ4d11SqMNGonPGc
         xQjJHcWADQRXnzb714JZA1c6duu6OCFVU/ZJpMxZhMPlvs+m3vmxBe2VbvoDkrvlKj6O
         cXrHNziM9itmDfXZx66MjCBmawbptJu0F6pyzLEseBYu120WoMwZe8/2HIylJx05qYhq
         CiQddelXWUdnY0dAmiWNIdkSdeDwc6dNeJgGT+J++3FYS79v7GT5qPOGtWDHBTf4dd1B
         kpAeY6urhpLFvbndUlaZCmk/hj76y4ZT/PffZXY4hxCRpbr5A5cg4zloWKnRWmBz9+I8
         7YhA==
X-Gm-Message-State: AOAM5338nkDEKCIynQtH3yRKqQEgU5FHreoCR/I2lkMoZJDXPJnY44rT
        UXFH3QKVIsQ0IpAdmxL92iyjbkhn+yfUSCuFLKSX+g==
X-Google-Smtp-Source: ABdhPJzt2Un82eGkxlq/rmaV5PzNC/frN7c/GhKnhyecHR7dNF2Jdb8nRS9M3VYPNJoD0Tj0UBS5EfkS6EJKaQW0eaE=
X-Received: by 2002:a05:6902:1004:b0:64f:4748:e8be with SMTP id
 w4-20020a056902100400b0064f4748e8bemr37872350ybt.537.1653642553018; Fri, 27
 May 2022 02:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 May 2022 14:39:01 +0530
Message-ID: <CA+G9fYuND9eW5qBEvcfjPuW=wobQq5bu5Bzr3QOX3YUT-Qsviw@mail.gmail.com>
Subject: Re: [PATCH] arm64/hugetlb: Fix building errors in huge_ptep_clear_flush()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 10:21, Baolin Wang <baolin.wang@linux.alibaba.com> w=
rote:
>
> Fix below building errors which was caused by commit ae07562909f3
> ("mm: change huge_ptep_clear_flush() to return the original pte")
> interacting with commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush
> from get_clear_flush()").
>
> Due to the new get_clear_contig() has dropped TLB flush, we should
> add an explicit TLB flush in huge_ptep_clear_flush() to keep original
> semantics when changing to use new get_clear_contig().
>
> "
> arch/arm64/mm/hugetlbpage.c: In function =E2=80=98huge_ptep_clear_flush=
=E2=80=99:
> arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of
> function =E2=80=98get_clear_flush=E2=80=99; did you mean =E2=80=98ptep_cl=
ear_flush=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   515 |  return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>       |         ^~~~~~~~~~~~~~~
>       |         ptep_clear_flush
> "
>

This patch tested on arm, arm64, i386 and x86 with gcc-11 and clang-14.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
>  arch/arm64/mm/hugetlbpage.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0f0c17dfeb9c..e2a5ec9fdc0d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -507,12 +507,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *=
vma,
>  {
>         size_t pgsize;
>         int ncontig;
> +       pte_t orig_pte;
>
>         if (!pte_cont(READ_ONCE(*ptep)))
>                 return ptep_clear_flush(vma, addr, ptep);
>
>         ncontig =3D find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -       return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +       orig_pte =3D get_clear_contig(vma->vm_mm, addr, ptep, pgsize, nco=
ntig);
> +       flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> +       return orig_pte;
>  }
>
>  static int __init hugetlbpage_init(void)
> --
> 2.27.0
>


--
Linaro LKFT
https://lkft.linaro.org
