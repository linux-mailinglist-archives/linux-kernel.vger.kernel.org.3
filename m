Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF34F77E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiDGHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiDGHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:44:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417D7892D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:42:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c2so4272283pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmGJug9XSvLc9UYs1snhVqbU1zFE1jKfOiCb4bT1Xyg=;
        b=TJToiuxAPxO5gLD+PPdeYwNbEDsymoriISgGQMYm42U8IwVbKx0WrqMGHSbilyJb3S
         Sqx8moZPwNEVW7CPcU5qbbHcrA0xQOqYjV89Wyq8q5k7yhUR3jNKvMsf49IBMStV1adY
         0tLWB2SF/fBoQg0g7VDy3KaG1MXvzAqSBVaH8MvY5KPrr2+sxqZRxeE6HWkmfg13mQd7
         P/B0GqanU/0MUAx2Btjd8XvipjUR9DBmUrexqTgtO3+JkCR2ICJAgzqepmSKESe4zv2d
         3AkbJCIC7jZ6k2H/o4TIb3Iz/UOACOY2Sbl/8Qn2z/e8iLCQYt4s85+wfUXPT89oZftL
         2htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmGJug9XSvLc9UYs1snhVqbU1zFE1jKfOiCb4bT1Xyg=;
        b=4EOb0KxMrFDqfk7m2ZPeUiv8RNS5CLk8J5ip5xVPCWehK8lWqPnl4eoM5IV2s7g5Cv
         Cq0K50BYjDIQWMsHykalJFVdDTob3a84SV6yxjb1HaEw1vw8g8LIjgHe9gRx2yZgnE9G
         H4iVmFW0X6yceDWalZT207smDUEwiVfaCuhckkn2E7IjoSeY0/bDBziKVM2LDzQaPfve
         0xvxHPJcwshev+LZ6Qi6VuZ4omUE0QOjZK7z8QFogWWHC1FlzRUaQu4NtziYo3YW86VY
         JZHY6Pc+2BnFIdrizuZWG8R/yhOKypNYW3sV3K+XyvrEUeDrIsDOBy6axQX7NR2xAePu
         T9zw==
X-Gm-Message-State: AOAM532JS1FOP5aoG06OpmtFacT/qh9r2oSux8fBf5/mnGhcufjskDYG
        uo7IxwwBlSDoItm1BTta4fyVlMWnW9Djyz1srZv5OA==
X-Google-Smtp-Source: ABdhPJzL4k8cNQVWa4KDJhE14ZI813y48fsqof0zEaw00HIk2pdqyRAXsd/G22FnKYSuMAjQx3qQezRJ+iq5Yv+hb1A=
X-Received: by 2002:a05:6a00:995:b0:4fb:607d:444c with SMTP id
 u21-20020a056a00099500b004fb607d444cmr12738497pfg.69.1649317355656; Thu, 07
 Apr 2022 00:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUa44GDg7hAAFsmeOOkeqi8_1P1Q6jATRdnV9b6S-DhpEEQrA@mail.gmail.com>
 <20220406144028.4203-1-phil.chang@mediatek.com>
In-Reply-To: <20220406144028.4203-1-phil.chang@mediatek.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 7 Apr 2022 09:42:24 +0200
Message-ID: <CAHUa44GDp=GSP5D=eCowZv09Ws_j44Y7mc=dY3eFAf0uLQBsRA@mail.gmail.com>
Subject: Re: Re: [PATCH v4] tee: make tee_shm_register_kernel_buf vmalloc supported
To:     Phil Chang <Phil.Chang@mediatek.com>
Cc:     sumit.garg@linaro.org, matthias.bgg@gmail.com,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Apr 6, 2022 at 4:40 PM Phil Chang <phil.chang@mediatek.com> wrote:
>
> > On Fri, Feb 25, 2022 at 4:20 PM Phil Chang <phil.chang@mediatek.com>
> > wrote:
> >>
> >> In some low-memory devices, it's hard to aquire large-orders pages,
> >> this patch allowed user using scatter pages to register shm.
> >>
> >> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> >> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/tee/optee/call.c |  2 +-
> >>  drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
> >>  2 files changed, 26 insertions(+), 11 deletions(-)
> >
> > Looks good to me. Unfortunately this is too late for the coming merge
> > window, so it's going to be the one after that. Meanwhile it will be
> > in linux-next.
> >
> > Thanks,
> > Jens
>
>  Hi Jens
>    thanks for your review, did I push again wile merge window open ?
>    Or just wait ?

Just wait. You should be able to see it in linux-next for now.

Cheers,
Jens

>
>  Thanks
>
> >>
> >> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> >> index bd49ec934060..2082e632adff 100644
> >> --- a/drivers/tee/optee/call.c
> >> +++ b/drivers/tee/optee/call.c
> >> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start,
> >> size_t num_pages)
> >>          * Allow kernel address to register with OP-TEE as kernel
> >>          * pages are configured as normal memory only.
> >>          */
> >> -       if (virt_addr_valid(start))
> >> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
> >>                 return 0;
> >>
> >>         mmap_read_lock(mm);
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index f31e29e8f1ca..836872467dc6 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page
> >> **pages, size_t page_count)
> >>  static int shm_get_kernel_pages(unsigned long start, size_t
> >>  page_count,
> >>                                 struct page **pages)
> >>  {
> >> -       struct kvec *kiov;
> >>         size_t n;
> >>         int rc;
> >>
> >> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> >> -       if (!kiov)
> >> -               return -ENOMEM;
> >> +       if (is_vmalloc_addr((void *)start)) {
> >> +               struct page *page;
> >>
> >> -       for (n = 0; n < page_count; n++) {
> >> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> >> -               kiov[n].iov_len = PAGE_SIZE;
> >> -       }
> >> +               for (n = 0; n < page_count; n++) {
> >> +                       page = vmalloc_to_page((void *)(start +
> >> PAGE_SIZE * n));
> >> +                       if (!page)
> >> +                               return -ENOMEM;
> >> +
> >> +                       get_page(page);
> >> +                       pages[n] = page;
> >> +               }
> >> +               rc = page_count;
> >> +       } else {
> >> +               struct kvec *kiov;
> >> +
> >> +               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> >> +               if (!kiov)
> >> +                       return -ENOMEM;
> >>
> >> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
> >> -       kfree(kiov);
> >> +               for (n = 0; n < page_count; n++) {
> >> +                       kiov[n].iov_base = (void *)(start + n *
> >> PAGE_SIZE);
> >> +                       kiov[n].iov_len = PAGE_SIZE;
> >> +               }
> >> +
> >> +               rc = get_kernel_pages(kiov, page_count, 0, pages);
> >> +               kfree(kiov);
> >> +       }
> >>
> >>         return rc;
> >>  }
> >> --
> >> 2.25.1
