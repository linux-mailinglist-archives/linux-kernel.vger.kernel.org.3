Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A914A6FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbiBBLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343832AbiBBLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643800526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+RrgHuoDl7M1QEbXcn4m2MpVuIXUyU64Gjjitl9CAU=;
        b=V3G7YBk0D98PI8DOhjJv1MD2eMjDg6VXa8xumGKl7Xh8iNB/yqat8g434jd1DC2FNutq/3
        8k8LNKScl2dRY/hAnyULgkuvtEECP+XMpVB6clRHIYbE+sEd544VdkPVKTP2cKcf+kfwRJ
        4PZ0PLzBmHf6F9GZtth97uGSZskw1eA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-1Gj_Kr4DNzG_rjOHRTforw-1; Wed, 02 Feb 2022 06:15:25 -0500
X-MC-Unique: 1Gj_Kr4DNzG_rjOHRTforw-1
Received: by mail-wm1-f72.google.com with SMTP id l16-20020a1c7910000000b0034e4206ecb7so2339305wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+RrgHuoDl7M1QEbXcn4m2MpVuIXUyU64Gjjitl9CAU=;
        b=kjmTAj5YpmljGzTgph61UkbzT2BueULOIXczj198DMuMGdyyvdnAQIahlx79s/Kq4/
         ntnwShWIeyKrJ69K5y9GLdgPgJjMVcexDHSMo9LXy/he3rBYx5C7ldr7hWnCbZfMpJ4d
         X5RGsHds+mtGQIsxsjttsU/dBWE4LeeKA0x4O7V6b3yexMwwsHMqJp6Yd6SvVkOZhUWq
         3IgteUhIO3xTyJz0kMmwuGmRNZV6Gk/0niKTCQNoex7qVZHK7HY+on9GrAtnXomJxdkj
         GHXoixkrALlI4INTr725wOWGLoMr/UodBYVFMdBDJR0P3DNS+K06w7Utip1VZNIi9mFV
         d+jA==
X-Gm-Message-State: AOAM530bu8QoqaJBn2UsymIiGg620nojQSc9F36rbovHoaDfaHQxZ0jF
        tTZtePhym35gKTbvEblh+DBVvl518cJdMzz/3ChCx/C25ecw7kizGuxwsCiXrw8vuhYwUjUJqIj
        oOM8ueE2mhEigN4aHu2yLzapGOiTP+y/x/0K0GTrG
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr25398157wrw.351.1643800524158;
        Wed, 02 Feb 2022 03:15:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYXUHhgSLHqw5s9ksxKF1GddwzaXPe6Jy+furjkmPn1aaYRk34LT/vH3NGrNrnm0KYLC9ewubhdeprXBtk3pA=
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr25398136wrw.351.1643800523886;
 Wed, 02 Feb 2022 03:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-2-vbendel@redhat.com>
 <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com> <CAHC9VhRkL++m_jkqK+0D2rXc_LMbkH1SSFGmAJiGEeDu6rA-xQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRkL++m_jkqK+0D2rXc_LMbkH1SSFGmAJiGEeDu6rA-xQ@mail.gmail.com>
From:   Vratislav Bendel <vbendel@redhat.com>
Date:   Wed, 2 Feb 2022 12:15:07 +0100
Message-ID: <CAHrQN1zVgNFrxns32nw5r5iEA21SKWgyYUeoApwz5UC1K86KfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: consistently clear cond_list on error paths
To:     Paul Moore <paul@paul-moore.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Feb 1, 2022 at 12:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> > > From: Vratislav Bendel <vbendel@redhat.com>
> > >
> > > Currently there are two users of policydb->cond_list: cond_read_list()
> > > and duplicate_policydb_cond_list(). On their error path one clears
> > > ->cond_list to NULL, but the other doesn't.
> > > Make the behavior consistent by resetting ->cond_list to NULL in
> > > cond_list_destroy(), which is called by both on the error path.
> >
> > It's also important to see if there are any callers of
> > cond_list_destroy() which incorrectly might be making use of
> > policydb::cond_list after it has been freed; thankfully that does not
> > appear to be the case in any of the call paths I looked at just now.
> > As this is more a a style/Right-Thing-To-Do patch and not an immediate
> > bugfix I'm going to go and merge this into selinux/next.
>
> After looking at patches 2/3 and 3/3, ignore the last sentence above
> and see my comments below :)
>
> > Thanks Vratislav.
> >
> > > Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> > > ---
> > >  security/selinux/ss/conditional.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > > index 2ec6e5cd25d9..1d0e5f326b62 100644
> > > --- a/security/selinux/ss/conditional.c
> > > +++ b/security/selinux/ss/conditional.c
> > > @@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
> > >         for (i = 0; i < p->cond_list_len; i++)
> > >                 cond_node_destroy(&p->cond_list[i]);
> > >         kfree(p->cond_list);
> > > +       p->cond_list = NULL;
>
> While patch 1/3 may not be a candidate for selinux/stable-5.17 by
> itself, patch 2/3 definitely qualifies.  Considering that both patches
> are small, easily understood, and the likelihood of a merge conflict
> between the two is high, why don't you squash 1/3 and 2/3 together so
> we can submit this for selinux/stable-5.17?  In addition, put the two
> lines which reset cond_list and cond_list_len together in v2, it's
> cleaner that way, example below.  If you don't have time to do that
> let me know and I can squash them together and move the
> "p->cond_list_len = 0" line (don't worry, I'll preserve your
> name/email as the patch author).

I was also wondering about the possible conflict for submission
into stable. I see no problem with squashing 1/3 and 2/3 together.
I'll send the v2, as per your suggestions. :)

Thank you and have a nice day!

>
>   static void cond_list_destroy(...)
>   {
>
>     /* ... */
>
>     kfree(p->cond_list);
>     p->cond_list = NULL;
>     p->cond_list_len = 0;
>   }
>
> > >  }
> > >
> > >  void cond_policydb_destroy(struct policydb *p)
> > > @@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
> > >         return 0;
> > >  err:
> > >         cond_list_destroy(p);
> > > -       p->cond_list = NULL;
> > >         return rc;
> > >  }
>
> --
> paul-moore.com
>

