Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3374A6569
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiBAUKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiBAUKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:10:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30079C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:10:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r10so37063763edt.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFUSweAG1xqhzQLZf+qgHtmVMyG+ZwNZxELpOo7tJ7Y=;
        b=CuUvvIsTnO5K5mWWbYYmYYXege1CBgtanGtwEfBdyx7IDiadCxdZRbJ3kkvt3/w1rp
         09/Lr0wBt1eqUr45j9XsfBW6SAH1YALzgAQISJ62txmRPEnV3YLmNreJF9SaQ3+clrVe
         gF0T+NyP7E7+QMauL9Y/2EyITmo5IpWj3msatcJzANo+tvM+mMSDHmyAVtZKxAOjaL6B
         I66CbZWYpZ/kcP9nxbL4oFAC2NLgzpuDHNwhPQKdAlJiBCSWofLDzP13MSRpJPYHjtmt
         uuM2WV36BoMaiTBLe6JvuqqI45nhtQtDyUk9qBLYz/M7dTyJ+guR1MgzJ2mMxlyeitsG
         z6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFUSweAG1xqhzQLZf+qgHtmVMyG+ZwNZxELpOo7tJ7Y=;
        b=mHoBlEglcpysPX8jnm+kWv8yF3M3ij6/Z3XAHDl6q/pe0WqkWKG0uF+wQJ885msaO2
         A5n6qSFEVmX4lQeU96UODe+V4llVahDLtiLM1z1xxl+qtSu1mgjzA/5a/aQyM0vDMhiU
         xQdWmEpvia+opZ5vNadMACJ7VJgXb7HtqLDmjXZD/pPvIHQdDtcJQJoeHfXArI60sAU5
         LyeDCmSacimh90QkpXtFaUhHZEBrXLzgByPQpaLIXJcJzXk4Cw6a2MH1XxAjwOadA29H
         fHnmXBPtWPf8/1jywarJ9esk5xqYBsc2KaUzmJ+5LSBkBJREyqi+b0mBawynUF1xqP+3
         RR7w==
X-Gm-Message-State: AOAM530oG1ct3/nBn9fBMzZitzGNW70r5L1Eg72SZXo7uXaxiBe50rOp
        K3eZ/tD96uZCQmhKirx8mOg+6XfF0gPSdtJS29wm
X-Google-Smtp-Source: ABdhPJwMt3ROWjFbgsVgFHnPMASy0Jm2iEtG5+43QwWyA2Em39TLV2pHLZdwaOmcYahMWv2KUec141fZPR7IaSvFlko=
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr27432331edw.269.1643746204648;
 Tue, 01 Feb 2022 12:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-4-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-4-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 15:09:53 -0500
Message-ID: <CAHC9VhRXFf22+2wjxT6KAbVC2R6FVZ6m1i7EFGTbm1icWdr_vw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: remove duplicate cond_list clean up calls
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> From: Vratislav Bendel <vbendel@redhat.com>
>
> On error path from cond_read_list() and duplicate_policydb_cond_list()
> the *_destroy() functions get called a second time in caller functions.
> Remove the first calls and let the callers clean it.
>
> Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 8bc16ad3af9e..c333daaeceab 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -432,19 +432,16 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>         if (rc)
> -               goto err;
> +               return rc;
>
>         p->cond_list_len = len;
>
>         for (i = 0; i < len; i++) {
>                 rc = cond_read_node(p, &p->cond_list[i], fp);
>                 if (rc)
> -                       goto err;
> +                       return rc;
>         }
>         return 0;
> -err:
> -       cond_list_destroy(p);
> -       return rc;
>  }

I tend to prefer functions that cleanup their own allocations on
error.  It makes it easier and quicker to reason about a function's
error handling.  I recognize in this case it may mean multiple calls
to cond_list_destroy(), but that should be safe (considering the
previous patches in this series), and we are on the error path anyway
so I'm not as worried about a few extra instructions.

-- 
paul-moore.com
