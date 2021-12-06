Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B159468FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhLFDQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbhLFDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:15:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807EC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 19:12:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so37171247edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IyolONNkDbR7sT7twDhZs7xy7XX9+UpOdA7FHMqNRI=;
        b=iNdrtK2U9atJVlQKeX5jhr+4CBLjOdm83gqc9Ehrf2a89bTiCPn/+MeMauOGbg+Coz
         RqJTe/cjMpiLh0YGhaT3DXqlwnM39G1N2UhzvVZpTf+y3PqkYq/go/OJtxegp/0PPRmt
         zc3p9vMMk7rNA9HRgYmu/jJqbkYbMU4WzSLR7Cym59Lq9iT9Qdvg9krojubnZFzexiN4
         s8oTFKWvsjge04uU1koEl5YRsx/BUoaIUdu/TFmW0iBlEpfx0RPmYnW93EOUCq5Xy7CK
         yW/Po9oXQ1hfQu11Wjhl3hZQbYGe4nuvgg4h2d2XGXpXhGGvt37JAiRFwyfXhloC2Pb9
         e2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IyolONNkDbR7sT7twDhZs7xy7XX9+UpOdA7FHMqNRI=;
        b=bxMAqOxPPCbPfvS1fzNXpaIpg9bfjVYzwUK3a973QWami0FpPcERpsS/QyPnzzv5LH
         0hHk71TXAjZhzAKY2BajJryYptSRBxH1q5MpOdeKMwqzKb9myASkpk2ykS5y4Kvttyfh
         B3ZS8yTg7x2b9Qd9dpxXEWoxaIsclUBBGhNlQcelw3MCBVqlysEqJrmVGenAqQwzubkR
         ebEDXZEfB/4nLAj9krEK9ew42KCwhJbKhSXwGjbsuY+FUsmN4l4+S6+f03BkfLlUKBmt
         rF7QS+1HKpx4asHI3EZp3VyFjcPynlWd5LlslD/t/WiIN988kwkRCSzEEediEfrRiXrm
         mKsA==
X-Gm-Message-State: AOAM531Z/c45SO3FDw8NvC8/bZe1N339bDqUfjKDBmDASH1X/XYNt6gd
        g/Qho8maR563WRqWJu8yQkfTElZ1NWC6aS1hqXJs
X-Google-Smtp-Source: ABdhPJxJ7VmkTg3OwBCylZyCwHv8hxCmvxe7XYg6d5Z3vHUbOdKFsPP3tUPleTN7ObhwrjZIFbLhUfkc4kjckpV5i0w=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr40420784ejb.69.1638760344800;
 Sun, 05 Dec 2021 19:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20211202033447.253596-1-bernard@vivo.com>
In-Reply-To: <20211202033447.253596-1-bernard@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 22:12:14 -0500
Message-ID: <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix potential memleak
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 10:35 PM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch try to fix potential memleak in function
> selinux_fs_context_dup`s error branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  security/selinux/hooks.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..36d7fc373839 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2856,24 +2856,38 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>         if (src->fscontext) {
>                 opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
>                 if (!opts->fscontext)
> -                       return -ENOMEM;
> +                       goto err_fscontext;
>         }
>         if (src->context) {
>                 opts->context = kstrdup(src->context, GFP_KERNEL);
>                 if (!opts->context)
> -                       return -ENOMEM;
> +                       goto err_context;
>         }
>         if (src->rootcontext) {
>                 opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
>                 if (!opts->rootcontext)
> -                       return -ENOMEM;
> +                       goto err_rootcontext;
>         }
>         if (src->defcontext) {
>                 opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
>                 if (!opts->defcontext)
> -                       return -ENOMEM;
> +                       goto err_defcontext;
>         }
>         return 0;
> +
> +err_defcontext:
> +       if (src->rootcontext)
> +               kfree(opts->rootcontext);
> +err_rootcontext:
> +       if (src->context)
> +               kfree(opts->context);
> +err_context:
> +       if (src->fscontext)
> +               kfree(opts->fscontext);
> +err_fscontext:
> +       kfree(fc->security);
> +
> +       return -ENOMEM;
>  }

Thanks for catching this a providing a patch, however I think the
memory cleanup can be made simpler, see the pseudo code below:

static int selinux_fs_context_dup(...)
{

  fc->security = kzalloc(...);
  if (!fc->security)
    return -ENOMEM;

  opts = fc->security;

  if (src->fscontext) {
    opts->fscontext = kstrdup(...);
    if (!opts->fscontext)
      goto err;
  }

  /* ... */

  return 0;

  err:
    kfree(opts->fscontext);
    kfree(opts->context);
    kfree(opts->rootcontext);
    kfree(opts->defcontext);
    kfree(opts);
    fc->security = NULL;
    return -ENOMEM;
}

--
paul moore
www.paul-moore.com
