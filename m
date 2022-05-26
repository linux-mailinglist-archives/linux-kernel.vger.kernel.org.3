Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EE535015
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiEZNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEZNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:38:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068658E52
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:38:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so3003227ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZ9DAhCNK6+O0V4masvprPNhs/nf8Fvi/U/e6pxEsj0=;
        b=T4I1s68XXJRufZfuiZ1VZqCrjcDXks8TmQ8oOs2CAd82x1Ea5MYgXQ/hfb66CkrVKh
         5xOeCj8uHt2B+CgY6Q9qIMpIvsttNrIw4aGRB/7PctSnXHNgMY251O68aaf6GrtMnSxw
         Doy1oSWuSM7cQ7+q6k1B60IEafItMK0tUJHf/44SIx2D66qkNgFXDF6L2grXHIvKPwCO
         vHXqTLPG6SIeYKbhzT09p+jRk/c2LO6ko+9+u/LDyxvtUREQCd98SebqpPmUHdMuXze2
         qXgOaZV4I7bUXjTMWtzpwUa3WnqrYGrGciOuF8smnswGCoeRXOcELI9l1MOExdSN7yj7
         tMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZ9DAhCNK6+O0V4masvprPNhs/nf8Fvi/U/e6pxEsj0=;
        b=v44zFuIluDT7iPOD4EvxJyoxDtRa/UGuibtUR6+zoKE42+K0lXfLnR1gTH+QTOeRNP
         roh54mVlbjZjVLjh2Zb6M79aeY19NZrZmrWxDXibse34UuEe4JQaY8ToQyFNS5EP0eM1
         MXIhJSCAWlgaKA5ulBaBOKUfdW+GQknlAsJopoS8KNJxpDshTolbOGhR/7Z7SZhAmELW
         1yQwoDkeFuwxLB4nqwCMHJlgvS0IMYg64jYASw2+0+kfrNnmQRFY8/Qu50oH+Y9ieet0
         Tp/JO9m9o5yTQuIEp77kIyIlcrTqCVqptT/h219kM/HXlHHxRkBy5O7H+ZlGDRbDo/Ym
         he0Q==
X-Gm-Message-State: AOAM531QVRTpGXlaC7fcl5EStT96DOk3v8xhyK/dLbqLQTKZxtG+QBYT
        oozoeOXMMaq3Oqh7WXGol+euX5+3alwl7WLCGZGh+ejBvhheGg==
X-Google-Smtp-Source: ABdhPJxwsu+q88tcq7anl1xlkA6jRqbX/Y2WxaXnApABL4iLZzEE9mWLZ5XTPYNtc14+W7qgANcEq8W+9zqihQphORo=
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id
 dd6-20020a1709069b8600b006fed37fb29dmr19980411ejc.327.1653572300197; Thu, 26
 May 2022 06:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220526113350.30806-1-linmiaohe@huawei.com> <Yo+B4b0nF+kI35pG@casper.infradead.org>
In-Reply-To: <Yo+B4b0nF+kI35pG@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 09:37:43 -0400
Message-ID: <CA+CK2bBBLjr3kGqc=zA6M5773G6gj83LB_kwwOCNuFX8YoUp+w@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
To:     Matthew Wilcox <willy@infradead.org>
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

On Thu, May 26, 2022 at 9:34 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 26, 2022 at 07:33:50PM +0800, Miaohe Lin wrote:
> > ptep is unmapped too early, so ptep will be accessed while it's unmapped.
> > Fix it by deferring pte_unmap() until page table checking is done.
> >
> > Fixes: 80110bbfbba6 ("mm/page_table_check: check entries at pmd levels")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/page_table_check.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
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
>
> But ptep was mutated in the loop.  So surely this needs to be:
>
>                 pte_unmap(ptep - PTRS_PER_PTE);
>
> or you'll be unmapping the wrong page.

Right, thank you Matthew.

Miaohe, please store the ptep, or maybe drop this patch entirely.

Thanks,
Pasha
