Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C949F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiA1CJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiA1CJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:09:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E0C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:09:25 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so14328998ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwYc8EPwvZAfcok/i1klve6YvTvhdKKT/Z+jWLT+TpE=;
        b=AFV/h3vfDaW2CsLcOAthS6sVAOM9fJPdNgsbXwxp8SIlkyBL1BNVUBYq+IALU5F4az
         287USOxS/l81HnX9tNbFOOqevbQLtvbk2YxTZ08cHo8SxPNrlSUrodlV7EhvsxKqZARi
         B5qp6TCDbBz956FdQ8/J2fhQra/NGr6LKuFNfJr9EyqNJNAygyOaoereO1OYrifdJEDP
         jZsC4+9Dm7MADACbr6Epl2VZD3dJrgZIJB3KwDxCmOZo44Y77P1v4QSdlHe5AaKeeEVz
         DLH+GxeTOg6Pq8OaU4bppoWl1EkjsOvIuIFJvACgNkJNbVhL+p+V1s8GmM2zt1tJadmq
         Bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwYc8EPwvZAfcok/i1klve6YvTvhdKKT/Z+jWLT+TpE=;
        b=3svydTLwGUjGoGE1P1qCfjY/VQZu9kvXCg2Qy0FiB+gmmAmmCzFXCBqihYaWxDO3g0
         VRArgoK8Kje3Rkk7EhYQYqv6qjRu/KdVQnrsLowuozJ2HyYbUhFf14JsQYQyo/nDi7yI
         q9uDcFcQPjHI03hNe+yvc5VHRmkOSmNqb6Asb94XpBVjhXj0WXfv0qltX3KIXcnKYe2w
         IiTjLfvdFm7ml0REDVU7w3L+dAKFeYrscnvmqxbSALqoXJ8Tero4k9ynopIZmJPDyLuJ
         Zw3b7es2/2h71O8qUKXb4gyM4JgUxE1YHeEsX/TXXOlarKR0reNAd6gpP5HdwWHQlHt2
         PB5w==
X-Gm-Message-State: AOAM531+F/wNWRSZyMcGx+XJtkF3lI/mKHwrWEQ4ng2Jwfo46CzkXlaj
        lW0/o2HAPYruLx3y8lPmOhVsHN12xD7LDG1TxEfjtcPDR8bwrg==
X-Google-Smtp-Source: ABdhPJwluMLkd9agWvkuP70E+3PLIG5WMEHyD6L7q/gkeiEXh+mLKktF1XS8DxuLSxOrNrmSWLjSN3EhviGdDmo64NI=
X-Received: by 2002:a25:d988:: with SMTP id q130mr9507569ybg.711.1643335764159;
 Thu, 27 Jan 2022 18:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com>
In-Reply-To: <20220128014303.2334568-1-jannh@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jan 2022 18:09:13 -0800
Message-ID: <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Jann Horn <jannh@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 5:43 PM Jann Horn <jannh@google.com> wrote:
>
> I've run into a bug where dev_hold() was being called after
> netdev_wait_allrefs(). But at that point, the device is already going
> away, and dev_hold() can't stop that anymore.
>
> To make such problems easier to diagnose in the future:
>
>  - For CONFIG_PCPU_DEV_REFCNT builds: Recheck in free_netdev() whether
>    the net refcount has been elevated. If this is detected, WARN() and
>    leak the object (to prevent worse consequences from a
>    use-after-free).
>  - For builds without CONFIG_PCPU_DEV_REFCNT: Set the refcount to zero.
>    This signals to the generic refcount infrastructure that any attempt
>    to increment the refcount later is a bug.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  net/core/dev.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1baab07820f6..f7916c0d226d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9949,8 +9949,18 @@ void netdev_run_todo(void)
>
>                 netdev_wait_allrefs(dev);
>
> +               /* Drop the netdev refcount (which should be 1 at this point)
> +                * to zero. If we're using the generic refcount code, this will
> +                * tell it that any dev_hold() after this point is a bug.
> +                */
> +#ifdef CONFIG_PCPU_DEV_REFCNT
> +               this_cpu_dec(*dev->pcpu_refcnt);
> +               BUG_ON(netdev_refcnt_read(dev) != 0);
> +#else
> +               BUG_ON(!refcount_dec_and_test(&dev->dev_refcnt));
> +#endif
> +
>                 /* paranoia */
> -               BUG_ON(netdev_refcnt_read(dev) != 1);
>                 BUG_ON(!list_empty(&dev->ptype_all));
>                 BUG_ON(!list_empty(&dev->ptype_specific));
>                 WARN_ON(rcu_access_pointer(dev->ip_ptr));
> @@ -10293,6 +10303,12 @@ void free_netdev(struct net_device *dev)
>         free_percpu(dev->xdp_bulkq);
>         dev->xdp_bulkq = NULL;
>
> +       /* Recheck in case someone called dev_hold() between
> +        * netdev_wait_allrefs() and here.
> +        */

At this point, dev->pcpu_refcnt per-cpu data has been freed already
(CONFIG_PCPU_DEV_REFCNT=y)

So this should probably crash, or at least UAF ?

> +       if (WARN_ON(netdev_refcnt_read(dev) != 0))
> +               return; /* leak memory, otherwise we might get UAF */
> +
>         /*  Compatibility with error handling in drivers */
>         if (dev->reg_state == NETREG_UNINITIALIZED) {
>                 netdev_freemem(dev);
>
> base-commit: 23a46422c56144939c091c76cf389aa863ce9c18
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
