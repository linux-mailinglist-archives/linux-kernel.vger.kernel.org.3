Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11962468FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhLFD0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhLFD0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:26:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4AC061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 19:23:08 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so37076903eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1PA5xvmyrjpD2+FReiSF/wgv+xvFJ7WV78WXJ8A5Sw=;
        b=TRdoEsE9Jm5HV2SPbuwvOG1h3oq/nZBXFROrzvW68RAq8eDgEC1L9nPHNnWxo+c0YO
         uh8h/XVGlsn2xRoQU49XhZcs/Gaca/MtbfsJIFpsMkeTrbfYSgwkhoff4uLLiHxzeGkv
         qTSA+YQg1lhPA2N6tOtTzsdf1olhj3IPYt/xggp3LgkkIkmXN+g8pjWFQLHnhpbrm4Eu
         p/cfm5dHsHujaFcHqAJVAzW67sdpqJYUN2Zoh/bTn35eHknIw5gqmnVFhRxYHz8QiOOE
         mVZVJAgIn2kl36eLMxQugKlf0zht+sWUrqao2niTJmjM5Kn+jxLK1V3I3vMPASyoHbFt
         JLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1PA5xvmyrjpD2+FReiSF/wgv+xvFJ7WV78WXJ8A5Sw=;
        b=snbwFwz/a4If8cmfhXW9S5PgDbbdxYsQo71iQ3AIuABnJ5po23LRh3+WQryCHoyvWj
         PIvkWqiYJUNDqZCSJYkXi87ZlAOlENqXEwc0vnM+RpJ8UjaVkUdjM1NITwcB1c052Y82
         NOiKfhSoaRFNxhTHM2CLFFROB6E9OlihUIcYwt1tWmkNnfHTlJJUahcs7v2fTlD75rVW
         nKFeBY1zjLjyRU51vDKhrxTQhLze0MDflwnlR3fJb+6QO4eo3nqWtkoklVbnXXCYk7aH
         7ypwJPMt4lBt22Mhyj8HsD2M3aYlbFKxt+7qmbkbx6ThQiEoM6catXnxV3ZnSnhUhXq1
         /I4A==
X-Gm-Message-State: AOAM5310A2wntIdDL8IRtkg2FX5aFmRTyeZ/ynUiTS+uQkru1aEa4Fz+
        3wCT/EjOvs1GXS95oWYupZQhtZPj0dm5ps2rfmcp
X-Google-Smtp-Source: ABdhPJz9qPH2zHEbQG4bKPg3GE3gnZE+IlE8wob+sDA23h3YS0ckZXJgrCKbGSDqQgtERGxRzWwuvEZ1wE+lvp52XjM=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr41524560ejb.104.1638760986856;
 Sun, 05 Dec 2021 19:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20211202031209.253228-1-bernard@vivo.com>
In-Reply-To: <20211202031209.253228-1-bernard@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 22:22:56 -0500
Message-ID: <CAHC9VhT5ts2Ax+PQ0hV48GzN-xphogfZNSwE97K3-tUZS60BLw@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix potential memleak in error branch
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 10:12 PM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch try to fix potential memleak in error branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  security/selinux/hooks.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..10700720bb74 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -983,6 +983,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = *mnt_opts;
> +       bool is_alloc_opts = false;
>
>         if (token == Opt_seclabel)      /* eaten and completely ignored */
>                 return 0;
> @@ -992,9 +993,13 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>                 if (!opts)
>                         return -ENOMEM;
>                 *mnt_opts = opts;
> +               is_alloc_opts = true;
>         }
> -       if (!s)
> +       if (!s) {
> +               if (is_alloc_opts)
> +                       kfree(opts);
>                 return -ENOMEM;
> +       }

Thanks for catching this and submitting a patch, but would it be
simpler to do the "(!s)" check before the "(!opts)" check?

>         switch (token) {
>         case Opt_context:
>                 if (opts->context || opts->defcontext)
> @@ -1020,6 +1025,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>         return 0;
>  Einval:
>         pr_warn(SEL_MOUNT_FAIL_MSG);
> +       if (is_alloc_opts)
> +               kfree(opts);
>         return -EINVAL;
>  }
>
> --
> 2.33.1

-- 
paul moore
www.paul-moore.com
