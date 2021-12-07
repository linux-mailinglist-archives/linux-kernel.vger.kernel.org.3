Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97A46C0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhLGQzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLGQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:55:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6DDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:51:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi37so35039538lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGXVxTLbQmBfgWuonyaABZsb6R4P9U2TOy7bqOMu6ww=;
        b=QbeuQPjH9RfFJEdFKlYnA58NxSRrcrfR78rDCN+2pqxbXm0+21yLgIFtGNC3MEg2YT
         wwhIp9VCuQk22HgglBBkzgVqrrowReUhrqGU3gcijoY9902gBN2sJlQxDsNEA88rIueR
         +YSkeq+GBB6IoMKG9kATH5dQiLMMy7fIGwU7n6cZf72sAwTeZ3OQk0MbAYZvP382LAVt
         8+iHB7deUWXGwiZAaFGK/xI3zbBGfz/QTKU2BNwELfUcAPDG1eTk2bz5SKS9jI6WIE25
         kAiPz8myxiYeU3dO/I8IghmA6EwG+v6wxGVtvk7WYNgfT7FZAKMkkLyHtNHgibjoRHW2
         BqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGXVxTLbQmBfgWuonyaABZsb6R4P9U2TOy7bqOMu6ww=;
        b=KGEpKs22zqIxXGKkG2UxxRyd20Ghhs/0bXwsk9gHFvOgqkq8oPFGg4LbpUyh1PPBiD
         7vpzmc+HvM5c7R8hfOpRj+0OIL3o8qbZbk+YE44O7hJuo6U9L0csRKUxDVsJ33Eli8Pf
         sW7lCbXbQYYw0DBRgbAjcpZkMw8SXVINL+O2/IT1o4LuhPzdvJhqKvxpIcypI7CPjJlO
         1mhBtc/FTuJBvt+4W/awTi74Bl0ThdH6vboudHNc1eV4ofN6Xv6wak9I+YgkLLPntVeM
         XS78OKGTeg0XXc+WJ0iLwFKmGSb+jnOZv6EnhtwLXmovxyjFAOb4CZkkbH1dq3hKubB2
         HGyQ==
X-Gm-Message-State: AOAM530+dcGQ1YuW5D4wtkyvX/NK/ZHfnT4ZmGgW8idHOsA6J4BXRi5K
        0NFbSvQd6iZGUzMzD42UZb0x/dWXZeDMVqDTIRsAxQ==
X-Google-Smtp-Source: ABdhPJxQa76T+l/IFTznMnLiPnhZaMvi0Gt+p8wteBwi9ykvlRZehjxryJFTcpzrWt3jkC6I9+ApbtwKRkcaD4Wp5cY=
X-Received: by 2002:a19:7709:: with SMTP id s9mr43860542lfc.682.1638895900300;
 Tue, 07 Dec 2021 08:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20211207122448.1185769-1-arnd@kernel.org>
In-Reply-To: <20211207122448.1185769-1-arnd@kernel.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 7 Dec 2021 08:51:28 -0800
Message-ID: <CAHRSSEyuWLHWyxnmes=Kd6vwXrm+_UHb7etgKT1kfdTeV0RqVA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix pointer cast warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 4:25 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> binder_uintptr_t is not the same as uintptr_t, so converting it into a
> pointer requires a second cast:
>
> drivers/android/binder.c: In function 'binder_translate_fd_array':
> drivers/android/binder.c:2511:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>  2511 |         sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
>       |                            ^
>
> Fixes: 656e01f3ab54 ("binder: read pre-translated fds from sender buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5497797ab258..182bb4221b06 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2508,7 +2508,8 @@ static int binder_translate_fd_array(struct list_head *pf_head,
>          */
>         fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
>                 fda->parent_offset;
> -       sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
> +       sender_ufda_base = (void __user *)(uintptr_t)sender_uparent->buffer +
> +                               fda->parent_offset;
>
>         if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
>             !IS_ALIGNED((unsigned long)sender_ufda_base, sizeof(u32))) {
> --
> 2.29.2
>
