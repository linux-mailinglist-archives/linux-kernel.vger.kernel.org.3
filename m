Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DACB47CCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbhLVFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhLVFuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:50:39 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:50:38 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f9so3254810ybq.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOCm/oJBsq2ZwSQorZrJi2VqFNi1hqeL0TWzmb2Fnv8=;
        b=mi//nob8VYTI3rBiDGoqlMGRzwjv1GQs5VJn7Uib8o9FXpj1YUXjvRadOWukVUY8RM
         r2MRnM1l9SlVXFL/+5HWUgAGayqIcsuPif2wNKrd8Fh+gj3X+RaSdEaKW5FJX68FIZ6+
         eZRp43PV8byAfFHm5yfi9EXNzPMfNcmkQP0O/VBRAxBqh0H9y+7YhOI6M5GYju3j2KrX
         CJ1lb050ll9Z+by701E6IB50ZfHb5+ikg1/k/9xo39Xm++hb5SfRODa8cnEyNI4revqT
         m/pGW0ceW6I9md8QvI828pw+G21xCGvBHE4IqhaKpZTSi2wO/ZVGyMSLk22b4XZJAZkA
         wHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOCm/oJBsq2ZwSQorZrJi2VqFNi1hqeL0TWzmb2Fnv8=;
        b=kwKLYIR/WvO8kroNP6BbVKAZdd011AJEPZ+0/bx3UILzbLHIlrch/ULeic/U11mZ7R
         AQ6BYg6FxIbkg0WoeV1dBJ0VJbabqXxYJPzjagIK/NGzTz5KctajZaZSx9WXbEsysHWj
         7hou/1KdeMSGXSBZAO4WnCYTZnPuGiQbaV/Sh0zhSariPFaMpD2BUiX5j91uFgZjdDfX
         8b9R6VaVlLQQVrAik/eflnQ9Ll2h0kcMFcXKCkEgwsXSupzTbZAjP0E7VYyw4ntEZU+v
         2JKMAL+rqv1Y7d1UhUnJ1dizQZPFjHSJFoOox5hQseVBwwTM4bHdgax4LIyk3eTEQTYw
         I6FA==
X-Gm-Message-State: AOAM532jeYImi3arjKgDGDQj6XvY9TOyzW+p9+xoNhV8APzlML+a8kiT
        Q9Tkpz/gQRT8Eqj6e5lvREClWqNBB5WW08ep8S3v5Q==
X-Google-Smtp-Source: ABdhPJz5Um4Ayt8ywUbOfrNvufZSGWpaW9Dec3TzjHbSNi4lJFZi/fWE1/rjkRit0FjkuQf5cHWmW0LWkhj016tYOFw=
X-Received: by 2002:a25:b04:: with SMTP id 4mr2291276ybl.317.1640152237892;
 Tue, 21 Dec 2021 21:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20211222052457.1960701-1-shakeelb@google.com>
In-Reply-To: <20211222052457.1960701-1-shakeelb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 22 Dec 2021 13:50:01 +0800
Message-ID: <CAMZfGtWb7pBTbX_radgv50y12aNBZxP3aeTQr91=7qQacQFE9w@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:25 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
> @@ -2626,6 +2627,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
>                 unsigned int page_order = vm_area_page_order(area);
>                 int i;
>
> +               mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
> +                                    -(int)area->nr_pages);

The cast can go away since the type of 3rd parameter of
mod_memcg_page_state() is int but not long. I suggest
to remove it. Anyway

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
