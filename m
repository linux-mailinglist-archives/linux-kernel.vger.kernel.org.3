Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84847CDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbhLVICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbhLVICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:02:39 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:02:38 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a1so1217543qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEHO9mF2ihCkk9k6a/idoNBNvOKWMCPKO1yXdk6ABVQ=;
        b=il3BzMhmlW/d+Rrc5RiG8X7UUWBfNUy3XBoUGUll4924Cdc8tvryQHCH30Fbd2cpGZ
         Qnjf3QSBnX+9L2aFC5NTHr+3ka9ZQ1p9EsOxWJNoYBpi04vX0kIXevs2zMO0am8iONOC
         ykNyVKyrdBgweFl392jWl3CYh8XzW/E3jZMzlkB4oO0mB9FlfaH+cN0jVpMuhZdOd44l
         3UkRpfiUxfUpGiHs5OIEJEM0FP0Adza1HieFis4vYupjKF3QKOLhzXeJGDtKQauluxwj
         3/I+1FZGQE/M9hmHrVRDmeLgpx9jxkdjdJ0njQEkCmKa+sEut6k6leNkO7mGtwVjm9LA
         AbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEHO9mF2ihCkk9k6a/idoNBNvOKWMCPKO1yXdk6ABVQ=;
        b=mLHXSH8Y2DFSrmNfV/v7UZjBZxibH/zdYLaXuqyAMPP3e3yWhrZYnUZPXXWVaYj6js
         rqRc3K4p9e/Saw8HRZg/E8YFNWxY7T3sF8ncu3FLBkyIGha7LgDus9j7D+GY6TRR8vfK
         qTH1UhHNKJCy6D0V7xvLdIMD/X3FOXPyKPMNQ9Cv31Uw5zgDzdeQ/Y7Xttj8LcBBvoKn
         ELuKgJUcn0vvbwBAjF9YVfPntUW7hdfuZV7vvnGbhbfEg/fT6q88g6TUCRP/6uVK/EXe
         2vtx8IvTxa4P6XajzlsAseU8qZ50tL5e/j/hxhfE8gMKHecQTRSIDxPZSWuYhjtuwnjs
         8FJw==
X-Gm-Message-State: AOAM530NDb7agzuiEkeNpk9BQcizep9OpyiGUL7jUIqZcndZN9KwQK9d
        aBAHt1p7FDGjtJ9OI6yzBY0CW+WUdA2okA7P1QB06YucQNJbcw==
X-Google-Smtp-Source: ABdhPJxE83WxXenOaQLGWEZKR8S/ngERCAo39PxXlPYIFzgmWE6XIX8ED0EEjeGPv4PBFRACkMEpCHVVp18YzJq+fQQ=
X-Received: by 2002:a05:622a:120b:: with SMTP id y11mr1275305qtx.544.1640160158101;
 Wed, 22 Dec 2021 00:02:38 -0800 (PST)
MIME-Version: 1.0
References: <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com>
 <2868725.1638995206@warthog.procyon.org.uk> <CAGWkznHcuiwPPMZE95nYG=EFkM8NmLUQZooS5+a+GigP50qksg@mail.gmail.com>
 <73896.1640098820@warthog.procyon.org.uk>
In-Reply-To: <73896.1640098820@warthog.procyon.org.uk>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 22 Dec 2021 16:02:18 +0800
Message-ID: <CAGWkznGgyS5VrcuYkWR_7sbDOkr0k2mDNUwF6F6N-Y_3GGtoJA@mail.gmail.com>
Subject: Re: [PATCH] fs: judging context via current_is_kswapd instead of gfp_flag
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-cachefs@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:01 PM David Howells <dhowells@redhat.com> wrote:
>
> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> > > > -             if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
> > > > +             if (current_is_kswapd() || !(gfp_flags & __GFP_FS))
> > > >                       return false;
> > > >               wait_on_page_fscache(page);
> > ...
> > If the gfp flag here is used for judging kswapd context, I think the
> > answer is yes as kswapd applied __GFP_DIRECT_RECLAIM.
>
> Now I come to look at applying it, I'm not sure whether this change is right.
>
> I don't know if kswapd has anything to do with it.  The check is to see if
> we're allowed to block at this point - and wait is just for the completion of
> a DIO write to disk.
>
> It would seem like gfpflags_allow_blocking() is the right thing to call - and
> that should use current_is_kswapd() if appropriate.
>
> David
According to my understanding, this check is redundant according to
current vmscan logic. For the allocation which deny
__GFP_DIRECT_RECLAIM could NOT have the context reach here as there is
no synchronous reclaiming. while kswapd also has __GFP_DIRECT_RECLAIM
set and would also block on the page's release.
>
