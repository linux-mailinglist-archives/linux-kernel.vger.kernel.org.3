Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958F5498768
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiAXR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244781AbiAXR7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:59:53 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9026C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:59:52 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id g205so26701413oif.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDJ2atOq+odBrX85L51zk+4WIQAQxuGUPgw+QxCzzw4=;
        b=hg6bbvNJY1HV9AmrK7Ect3vbTYFvrYScXZdRSZ+JdQpDUUvm4vQtdzOXW+i/lr630l
         7HI6y3qEqw4rM/wso3mZsB1HNyggiuO0Ym+joMMV4vb4k2bG+EqQzoxF6Dfi0NYBj6KN
         E1QtjdjBMhz+5OBOKGRwuSM5iRj528f9oBbYfqzstxQirp8W9Y759/w0ZWKyXjA94Whz
         BV//1X338AoCEJrvY0W12VAe7Kfxgdjue56St7qcy5jr03eo0T95n0Fk5MzCYhSuOnxB
         c87YfmGa037WYByODqkrFkgZKnQR9Qo+7bIIWq58TbL9n2xt5iGOQkozkT80t6z2GsP2
         vSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDJ2atOq+odBrX85L51zk+4WIQAQxuGUPgw+QxCzzw4=;
        b=mNQ4HVyu7cC+U9T3PsG+RxuKi+oFgQ0WDbnNCHcJBEGJ8ZBlO2QAvVpuaZ8wYc+kP8
         v3ikTWWq4zv348E9pyxwsKMCvBYiM88uUyBvXz9lJfXxTlOjYKyrfmEQ2J5ImQ25QlyS
         FqxuyJzTVI1utgTW/SJ5eAlY1by85b8LmZbXyCSHOdjXtAJX8pFBeS81T6Ct7IyanlNw
         zJDE1pzMD+VeKbsa4xqPPvvdgS0SqSosgcRHHL0hctNcNEvIjldfYaaktESngXop7yl7
         m+FrWFjZCopcg7OZIYXYLvNFBcnM8xU6PzMJ1B3nRFsjWxpHnOo1VOC9MvyEm2ckgWcu
         mStA==
X-Gm-Message-State: AOAM533Mgm7WxkWp+Mhy5gRC/SJ8c0SYys3EEDxDF/xn8Qz5S5mvM1MQ
        paZgh7XYwiEYpbOpb0OZ8a2/dgi5FriF5l72zE7bng==
X-Google-Smtp-Source: ABdhPJzjvnKetD9DQ1LikgmSEJtncCyvPZd0qGvFVHLDPo/yclNBXoQ/bp9gTv0JM8kBUYeiHp1bo8c/Ev2K7Km1Gx8=
X-Received: by 2002:a05:6808:a97:: with SMTP id q23mr2556523oij.4.1643047191963;
 Mon, 24 Jan 2022 09:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20220124160744.1244685-1-elver@google.com> <CA+fCnZd9fhv0RShoSF5xStQZuXFC2DGv8JQpthffdm6qVA2D3w@mail.gmail.com>
In-Reply-To: <CA+fCnZd9fhv0RShoSF5xStQZuXFC2DGv8JQpthffdm6qVA2D3w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 18:59:40 +0100
Message-ID: <CANpmjNNjOG2z1m-8ViiD1+mwqqOargdDp3s268k6eeTyuKeM+Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: fix compatibility with FORTIFY_SOURCE
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-hardening@vger.kernel.org, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 18:54, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
>  -On Mon, Jan 24, 2022 at 5:07 PM Marco Elver <elver@google.com> wrote:
> >
> > With CONFIG_FORTIFY_SOURCE enabled, string functions will also perform
> > dynamic checks using __builtin_object_size(ptr), which when failed will
> > panic the kernel.
> >
> > Because the KASAN test deliberately performs out-of-bounds operations,
> > the kernel panics with FORITY_SOURCE, for example:
>
> Nit: FORITY_SOURCE -> FORTIFY_SOURCE

How did that happen?! My hands need some better synchronization...

I'll refrain sending a v2, assuming Andrew can fix up this spelling
mistake upon applying.

[...]
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
