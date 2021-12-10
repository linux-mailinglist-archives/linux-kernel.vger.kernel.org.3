Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0576646F862
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhLJBXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhLJBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:23:45 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC6FC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 17:20:11 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m192so6544532qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E21fiaL89lo4s80Dd5ii4XZUAZScAir+7D/5kVfVX38=;
        b=LNX/aZ8MpB6J7/SH0awcpQ3mUnZJ9LVZ7LxNG8qIa4wbdAXRqhjWIrAJ3CNRaXcMLv
         4/Uw0sXHITT5Oq2mEA/F6ky0tvfXkmj8IFWDoC1V1B7skWaPW727zZO0IZvUnvcc5cho
         SOjK4FBeaiuc85xy2inM4RU9XMIVqVDjoA9oGui8K5Yj7JXaUkOTa8a6fDzeSaWJQ6Rb
         3+k3N02RdZpZtylNb+v+IweudAjBE0uE/pfJhLvbz/gHp6KYZCvOa5VhBlxaF45hrt+R
         rcLiaJ7z3Ma5yCcG6e/RlNFinkTXj2EBK6e3f8TxNDKoO3exoOL9qJHlkwKh6DACfnyg
         7U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E21fiaL89lo4s80Dd5ii4XZUAZScAir+7D/5kVfVX38=;
        b=jly3eJkbP9gd84H47l1Pih0ZCPZMgDltkyKE5q9kKN9a0fd5iJTxa01wRlVG/7Ol3d
         ENDiE0zY0nqerrWWjh1q2YH5SXvFNLYVF9aQefQCmosnW1Rod1OZjEpZBE0AKVQZAqps
         +ZjFjncmfq/5v3WpGRs0UpF5UUWBqjpbuJlLdHd8OU51huRHv6lvROUCmfg/Zlh6rQ9L
         AfiHLEB2f9vZeK5+Pwp937JK4hlX/zI6aAEgwTzPznInbftDe24kGUtSal6zjEEXteab
         MwbRsjpJcdIIQt/9P7N+VmKfIl4/fAJAYvfQ2exDdwrjNokuzi30Awx+jgRt531D78yD
         uX9w==
X-Gm-Message-State: AOAM533rapBikw+tZz5xwThupfKVUj0aqvHpaBc6abCZwF4OV3g/GSM0
        Kj0/jRJXvL8siX9ajO5t39NobreLpzU2QphhARs2wCTX786J3w==
X-Google-Smtp-Source: ABdhPJy7V2QnpcJ3Eb+OTiWtoQ0lK7fyfojgG2YB6/22nOPTv6HTzhiVYf8DDFCMK0a5h2JW/6pXECWsJHf1m+I5uNM=
X-Received: by 2002:a05:620a:1924:: with SMTP id bj36mr17821101qkb.476.1639099210545;
 Thu, 09 Dec 2021 17:20:10 -0800 (PST)
MIME-Version: 1.0
References: <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com> <2868725.1638995206@warthog.procyon.org.uk>
In-Reply-To: <2868725.1638995206@warthog.procyon.org.uk>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 10 Dec 2021 09:19:50 +0800
Message-ID: <CAGWkznHcuiwPPMZE95nYG=EFkM8NmLUQZooS5+a+GigP50qksg@mail.gmail.com>
Subject: Re: [PATCH] fs: judging context via current_is_kswapd instead of gfp_flag
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-cachefs@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 4:26 AM David Howells <dhowells@redhat.com> wrote:
>
> Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> [adding linux-cachefs to the cc list]
>
> > Kswapd uses GFP_KERNEL as gfp_flag which make the judgment of
> > context is unexpected. fix it by using current_is_kswapd.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  fs/afs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/afs/file.c b/fs/afs/file.c
> > index eb11d04..6c199d5 100644
> > --- a/fs/afs/file.c
> > +++ b/fs/afs/file.c
> > @@ -485,7 +485,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
> >        * elected to wait */
> >  #ifdef CONFIG_AFS_FSCACHE
> >       if (PageFsCache(page)) {
> > -             if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
> > +             if (current_is_kswapd() || !(gfp_flags & __GFP_FS))
> >                       return false;
> >               wait_on_page_fscache(page);
> >       }
>
> I have several of these in my fscache-rewrite branch, spread across a number
> of filesystems.  Should I fix all of them the same way?
>
> fs/9p/vfs_addr.c:               if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
> fs/afs/file.c:          if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
> fs/nfs/file.c:          if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
> fs/nfs/fscache.h:               if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
>
> David
If the gfp flag here is used for judging kswapd context, I think the
answer is yes as kswapd applied __GFP_DIRECT_RECLAIM.
>
