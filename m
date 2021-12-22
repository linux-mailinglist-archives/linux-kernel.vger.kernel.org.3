Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB547CCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbhLVGGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhLVGGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:06:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0225C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:06:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp20so2955944lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxjacBwjJoYbgzWLXarSAngifcVatMlW+kbmP1VYJ6Y=;
        b=huVTVo6X+EOszoN9mmNCN7ZejGvAzZ9508W/Gr4LS48mbT0o5rDLAHe46h08zL6q49
         4lDB2SD+Msqv8mVvXuVYinRmNCpIlFQ1GknfJ9YHZRj0awyOhswn6S3CdlPRgg2rQ1dp
         kTD/xxvbNzhIy0QfqIU/T7o1UrRelG+vMypO6y3MZADyFdrITdR3MXamGNkR/p7ui7Tq
         nLbIQDJLjNnLjX633ifOmbvHnazdtmfaTWV76mozDq3onlBE2Q/MRHVy5rSrbDRZNbrX
         YgrWMKYKBVg33sQ+HsYaeBIlwQkmjxHD9jeHtmmQf6TArCB4VL/jNTq5Wp1qVo+hEBLs
         3TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxjacBwjJoYbgzWLXarSAngifcVatMlW+kbmP1VYJ6Y=;
        b=JPvapEIprfBbn5HUOCd9n4S4DYdwIg4f53RI4Zl2tW5mlcZlTSbQXSsYWXg0H6gRUw
         i5QpdI38cDWwLOJx5d2OBUXQpsM55SaMjVrZviHBImjAngOa0GXhShQzoc6+Kmk80RyU
         y8YCdd7IUPhxnfqZPtp6FWTLErTKsoV7Fu6pk40YDLmLk/w/DYL5jlSQAOPJH5ZT4cWg
         vDWu2a2R/mvTxLNx4k89jLE/6e9Gdet25FO/8jmaqgB373LdBHM5BG9LMAGoZxbdTWLe
         T7Wn5KFNpFA9ndDOVV1D2CUxJjLPchGbWYY/ctqM1uKtZemSHBT2VvoZRvIpQLJqvDJI
         dTOw==
X-Gm-Message-State: AOAM531eNqmeNxkHwtZY58kpPAWfLqW2SKb6qm8n2nWpka0iv+cvTVXX
        pxavPTmmOkgrGfWyolaRibdMQ3qcBWRPh7/zM4qAtg==
X-Google-Smtp-Source: ABdhPJz529xFqKPOhLy/leKzNzkzQUFsdZskr38jdM4KpzidFcnr/DXETsbVDjN5mqP6V3AmtWJKVOesfUNLbkZWXLU=
X-Received: by 2002:ac2:446d:: with SMTP id y13mr1283045lfl.210.1640153172045;
 Tue, 21 Dec 2021 22:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20211222052457.1960701-1-shakeelb@google.com> <CAMZfGtWb7pBTbX_radgv50y12aNBZxP3aeTQr91=7qQacQFE9w@mail.gmail.com>
In-Reply-To: <CAMZfGtWb7pBTbX_radgv50y12aNBZxP3aeTQr91=7qQacQFE9w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Dec 2021 22:06:00 -0800
Message-ID: <CALvZod4vqUC248R_1PmvvfkYEu9oBPN48rtCiWwSZ0UGaE_bVA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 9:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Dec 22, 2021 at 1:25 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> [...]
> > @@ -2626,6 +2627,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
> >                 unsigned int page_order = vm_area_page_order(area);
> >                 int i;
> >
> > +               mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> > +                                    -(int)area->nr_pages);
>
> The cast can go away since the type of 3rd parameter of
> mod_memcg_page_state() is int but not long. I suggest
> to remove it. Anyway

Andrew, please remove this cast of the third param when you add this
patch in the mm tree.

>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
