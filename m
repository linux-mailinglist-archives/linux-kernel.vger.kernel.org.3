Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A944F9BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiDHReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiDHRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:34:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE92B65BE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:32:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ll10so822377pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+kUNyfJxKm1ujevbiKigyKUXoT0kLKRU8aUxaHDSJE=;
        b=LrDF39pFuyzFZCAc/KZZzv/i/lQS7AbtFvrZsJC9ht/xGzpR4Uap43EwOT5pCq/gN0
         0m1zd3eKnI3N0ZqQP8BuVhki7pJYY6UMdIBH4phNgf8qTpH5VTEHtFOqCwsQwA62br0G
         Q1uJDMHB/x21RFxO+Z8hf6PAlMJkaWLmo/ZCnKot2lzGZ+MonvsIuMf8Z9zoOw2Gv1tg
         c4YlFWRUNBZyH2vdaEAEu/LKLWYOx2Rqw1i29D/YkmDw+0DTeSlquJ0xpHtTWLeW8uGL
         7H+QtiemzbyiWRUSZz3F8a8DKxGLKb+OBTD3ZJq1ocgSbKbQ8ULO1gTGmuGEp7520Gmw
         O8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+kUNyfJxKm1ujevbiKigyKUXoT0kLKRU8aUxaHDSJE=;
        b=qQlVqGN5Q9bWGt2N5xEiPSLa1sytTTCfkWkhwjWzoYuq7WqkBVsLYlJzOPWFQlcUI0
         cwp9E27kGBQsSuqyvrbrxFmSdPl7oy1a35BcPD75eik6A+f0XoNDefY4iMVYoIhjgVBy
         2pnTZWIE1PLpShxqopww0AJ07wHgOxBUjVnoqVRl1EsWtWrjhwiGl0hLYgBEeWlL6U5Y
         owd3b1OQqQe6fleOvXtJikDhoSwO4Rxrmkb5tZSXp4llnnQRE2D12TUjSC7aP7hOTcMc
         C1EdIguO/TMKT2W3GCs25ODe9Ik30zTiUbNzV6/szGVQQPLfb0iwQyOa21zOBhlj4HVi
         O+Lw==
X-Gm-Message-State: AOAM53125EHxVjkewXXD2D06p9CxbjoH5gQLwOM3TX3XXGHpK8oNAvwZ
        hqjyxLbrjZjSziYuiIOYQuxLRi03czMSqU7bymI=
X-Google-Smtp-Source: ABdhPJyo+7ur34lczUuWXhS+cFJV0p3jAE1QHpbJ+OGoe30mxQfN2d/8OcdiDpUhGPMbA6MKB7D70J3WbKtxfEf6ZFA=
X-Received: by 2002:a17:902:9304:b0:155:eb5a:8dd4 with SMTP id
 bc4-20020a170902930400b00155eb5a8dd4mr20540077plb.117.1649439164974; Fri, 08
 Apr 2022 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407130352.15618-1-linmiaohe@huawei.com> <20220407130352.15618-2-linmiaohe@huawei.com>
 <09d363ba-5bd0-75ae-8ece-cd91997f1b46@redhat.com>
In-Reply-To: <09d363ba-5bd0-75ae-8ece-cd91997f1b46@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 8 Apr 2022 10:32:33 -0700
Message-ID: <CAHbLzko-oobg2rNO0y-Sgj9ePPEpoFEMmhgBumjzzFFFa=argw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Apr 8, 2022 at 1:52 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.04.22 15:03, Miaohe Lin wrote:
> > PageSwapCache is only reliable when PageAnon is true because PG_swapcache
> > serves as PG_owner_priv_1 which can be used by fs if it's pagecache page.
> > So we should test PageAnon to distinguish pagecache page from swapcache
> > page to avoid false-postive PageSwapCache test.
>
> Well, that's not quite correct. Just because a page is PageAnon()
> doesn't mean that it's in the swapache. It means that it might be in the
> swapcache but cannot be in the pagecache.
>
> Maybe you wanted to say
>
> "So we should test PageAnon() to distinguish pagecache pages from
> anonymous pages."

Yeah, I agree. The patch looks fine to me with David's comment addressed.

>
> >
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/memory-failure.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index ef402b490663..2e97302d62e4 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2262,7 +2262,7 @@ static int __soft_offline_page(struct page *page)
> >               return 0;
> >       }
> >
> > -     if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
> > +     if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))
> >               /*
> >                * Try to invalidate first. This should work for
> >                * non dirty unmapped page cache pages.
>
>
> --
> Thanks,
>
> David / dhildenb
>
>
