Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFC534FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiEZNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiEZNLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:11:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E29D6817
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:11:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi33so2974287ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nt+n2haklMuWStLRmgRtCfZgoN7afB/xjurnhlibBtA=;
        b=mdh4hUALSiiYooecz2d11OWfKfPev1AO99H5MjRa6BV8gFhSR5KjdOV7L8lCUi701X
         3oE6KQ+1Pz6HNtSdOhN1ac/v1j7/wpJtJXG1c7Dh3jy9720CFNKoHEiAKmaYWREiK0ud
         YPTCe4Pc+4v24AnQM0uCl3U+MMV2GfyF3FlVlTaUgBDtnVSPu1My2a5HuiHpmoSOG1mv
         h2D8npJzXAq8jGEnX4q+C/5kLLFJGhzC4EXV/j+51zADBGxTb5cAvm9GkoMGrWR/n9dW
         F/fQMJIw96OTAOdjrFD8j/ghyoWQhiLQbiCcljv/HWdzPJ0F3RK7VneNeFgQnQq4WV71
         GF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nt+n2haklMuWStLRmgRtCfZgoN7afB/xjurnhlibBtA=;
        b=VwSYozbtARaNQPQvWsqlhmbaPf6i5lLb6uSPKQ8ggCaq8H2J/GAnWvjBPvlLd6EORR
         gAQSFMb1LjeYw29gkkVc58IbG1DhbVOEMMMFkhzbaWRCIETyzMG+kf7v/Gfuf/9sW4TF
         5GewGkje4X3MRZGuRgTqB4BlS2zfi/8Axp5Ba2N/JoUkC7RVt+o1uX4MsBUbUQ7VVkQ3
         A64O1+YoV3/2mS3UlfGLj8q8x0vvrp/ad9GyvJOyS5cZVTzOn6Xee9llZVcAb6c1gktH
         /1U3i42qUTRBss8irFF/57WixUY/H2Z53rJtZsXQX8hik0IY+yNz0g9BSmnssguAxBUR
         kETQ==
X-Gm-Message-State: AOAM5303TUtQ81Rv7pk7dldZaFzEERnzk+lleCFWxbOFFFtB8uIwLdIB
        pMHpnU9cljIdduFNsDaC/xyFYvQ40ZaMAyiJZSF7cw==
X-Google-Smtp-Source: ABdhPJyVOJFJpwtgzyvTJVh+RCxHEKoowBQj8NU7m0i1XTs+8LBvYgl44pjc658B2YptHEliXFJqRdQ1QdhtiUwI7so=
X-Received: by 2002:a17:907:86a9:b0:6ff:45d:c05b with SMTP id
 qa41-20020a17090786a900b006ff045dc05bmr11989570ejc.492.1653570704863; Thu, 26
 May 2022 06:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220526113350.30806-1-linmiaohe@huawei.com> <09f38cf3-282a-61fa-9916-057b01b57d30@bytedance.com>
In-Reply-To: <09f38cf3-282a-61fa-9916-057b01b57d30@bytedance.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 09:11:07 -0400
Message-ID: <CA+CK2bC0cUACMbSDFhxxPEv2J2pgEvVk=n=Pu00OgLadjNhEMA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 9:04 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
>
>
> On 2022/5/26 7:33 PM, Miaohe Lin wrote:
> > ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> > Fix it by deferring pte_unmap() until page table checking is done.
>
> In the beginning, page_table_check only supported x86_64, so there
> is no problem. But then the commit 3fee229a8eb9 ("riscv/mm: enable
> ARCH_SUPPORTS_PAGE_TABLE_CHECK") added support for riscv-32, it is
> indeed a problem in this case.

pte_unmap() is needed only with  CONFIG_HIGHPTE. I do not see this
config for  riskv-32?

Pasha

>
> So:
>
> Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
>
> >
> > Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >   mm/page_table_check.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > index 3692bea2ea2c..971c3129b0e3 100644
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -234,11 +234,11 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
> >               pte_t *ptep = pte_offset_map(&pmd, addr);
> >               unsigned long i;
> >
> > -             pte_unmap(ptep);
> >               for (i = 0; i < PTRS_PER_PTE; i++) {
> >                       __page_table_check_pte_clear(mm, addr, *ptep);
> >                       addr += PAGE_SIZE;
> >                       ptep++;
> >               }
> > +             pte_unmap(ptep);
> >       }
> >   }
>
> --
> Thanks,
> Qi
