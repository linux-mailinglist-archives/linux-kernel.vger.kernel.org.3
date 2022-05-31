Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936325396F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347264AbiEaTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEaTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:25:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E39968A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:25:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q203so15243062iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laksvj7tZyE5VfjRjxemXKqC6M/6B12dc0r+gd4pLSY=;
        b=qeNPEzonX3bCWTM4a4Otdhfg66OsyZPyGRQmqwX/A5k5ZHfzwX+DQsB4tuyCbqJtys
         TgR1d2CJYKWYel6bjsq3sBjTKxWswcu24zyuKGoLmTjMp/GzWD5NQ8BYXC9hxPX080mi
         8AzGtOdMMnmIiDTe6N/4iFy8MoX0cbz7tNQT1CVKlxOAa1WD4A+Cxj88/++nNXMI9525
         S/V+WoNp/0SmgPIIDo2/VD34+ef+MfP8wvlLJcDpsDgNirPcIySDKI8N/ijTaTtBr0Pn
         s83naywkoullNDe1942zZF0GrBvgkNXx5BT+vsj81jJ571nfVZKMTu07G6z2Mew+W7kg
         W1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laksvj7tZyE5VfjRjxemXKqC6M/6B12dc0r+gd4pLSY=;
        b=1jupT4p+DkjyvdjGokdaHbD71KfLQpIKCSJCtaFdjUNHooiK95M5FFZtcMFDc3ypPH
         5MIAUfDRflLlvgx+qrVVQVMPInyLitrF3dCl+QlW0DM44fTKWLM6/dOjLa9wKgBJR/mV
         sDC8ie9bh/5/nYbC4OAX8btKZXVOBmcfpdHeyYECdeEHrvTaKwTSmamS66MuBmOupsfT
         sQtQyuo30ViwUojrI6y8IPu7OKA5bACiy16o9DFtkRhYHghwGIoEiL/FCOeJoLyjt35Q
         hxK7yKYHL1ZsBdVazxqqgrI0E9/84n9FVRTrv5I8Eie6iTI4Z4DHi9FGvGWej2duAHqh
         sEmQ==
X-Gm-Message-State: AOAM5312jKNB8HZ8nbTpznq8GZTQBPRYbCgqajXavZb/XQEHyfNBlEVu
        N525uMlZB8XaarQc0F9rstu8O4gA87AZj+RSmUU=
X-Google-Smtp-Source: ABdhPJz0rV8XQi8hDUNqCk1ex/1IT3XH2q3iTT9AyvNYOhXkXFQEknTRLjaikUvfKN3J4g9+LJr7k8HXfmXbXta8yEM=
X-Received: by 2002:a6b:3115:0:b0:660:d5f1:e3b6 with SMTP id
 j21-20020a6b3115000000b00660d5f1e3b6mr22025461ioa.99.1654025108757; Tue, 31
 May 2022 12:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
 <d6ba060f18999a00052180c2c10536226b50438a.1654011120.git.andreyknvl@google.com>
 <20220531105200.587db61db99f19e308a05c5e@linux-foundation.org>
In-Reply-To: <20220531105200.587db61db99f19e308a05c5e@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 May 2022 21:24:57 +0200
Message-ID: <CA+fCnZdyu-iHjsciTs35bCtXuH0X-UJkfhs4P=tLq2_sHK-Rfw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: introduce clear_highpage_tagged
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 7:52 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 31 May 2022 17:43:49 +0200 andrey.konovalov@linux.dev wrote:
>
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add a clear_highpage_tagged() helper that does clear_highpage() on a
> > page potentially tagged by KASAN.
>
> clear_highpage_kasan_tagged() would be a better name, no?

Sounds good! Will include into v2.

I also noticed there's an extra empty line at the end of the function
I need to fix.

>
> --- a/include/linux/highmem.h~mm-introduce-clear_highpage_tagged-fix
> +++ a/include/linux/highmem.h
> @@ -243,7 +243,7 @@ static inline void clear_highpage(struct
>         kunmap_local(kaddr);
>  }
>
> -static inline void clear_highpage_tagged(struct page *page)
> +static inline void clear_highpage_kasan_tagged(struct page *page)
>  {
>         u8 tag;
>
> --- a/mm/page_alloc.c~mm-introduce-clear_highpage_tagged-fix
> +++ a/mm/page_alloc.c
> @@ -1311,7 +1311,7 @@ static void kernel_init_pages(struct pag
>         /* s390's use of memset() could override KASAN redzones. */
>         kasan_disable_current();
>         for (i = 0; i < numpages; i++)
> -               clear_highpage_tagged(page + i);
> +               clear_highpage_kasan_tagged(page + i);
>         kasan_enable_current();
>  }
>
> _
>
