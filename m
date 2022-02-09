Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6644AF5DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiBIP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiBIP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:57:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A714C061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:57:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p24so8700798ejo.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKTbfzAbzSzuDBlSqgffZBElxZWF6Y4ApMmrhfDad+k=;
        b=UwZU2yX6C2SsnLLgkzFuPVjHpXnuQ8gKHC30WzB0bO2tQYjKEaylb181yB1/Em0ROB
         pItD5MnneoScrwrsEBOaT2k5TGzV/ENvQpbMyBmy7yff5//ixlOTJEBTD9GEhkv07Fbf
         M6rT8diPRvG5jvfCOBHZP906B7CHbWHZt8zGbb87JelO3htRp2NoU8orygwREoDBDXJ1
         GzF+oplcNz5ZsRBlvd+DMh98HTZa/zkP0lhkLVhZ1kS0SqsWMAqgvGnauZJOkgBaPvfx
         XpptjCYrd8LwTOiFAtA22j0vtA2jkfPywan2arAzG6Hq0L6bxdPoWPuQ26+wrEeUqIWK
         zjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKTbfzAbzSzuDBlSqgffZBElxZWF6Y4ApMmrhfDad+k=;
        b=HAADi53+A+cdxGjCBsZuwo0VCmTO4RQZL6qBVVOTQIGWD8AuG/+bUWV3BoexeaJqZd
         hi27zSxOxNiy7xpEwllOFnDnElBDiUKV/0sHY3oTRBIb/fdPVYSBagkB29YwD1aD3gUS
         FZ998h/4enFcmYey7N7DwuVMNGLWs4Nh+z2hFkLJ0UGKdxPT89sokh/IAZ/azDcRo1+R
         oGZG3iyE1fd0LmHAhrHpas3TnP6debmgvaT/1DTlJz6hv7Ekx1dh/LU1mukVSnAhb+gC
         zCBH9QJZieQTXzujOsQx2VsxDXT7pNVV/PT7XJ2WC8ySYIUNLUN7ug2hYnT+9fa8cAP9
         IBYg==
X-Gm-Message-State: AOAM5328v2J2uns0gLKA8AooPmfQnkhTHOTvEqDfWfdeteKRaf8ulSo2
        8OaS4oBJoirDUoD5Q1hbYjonHwJDTZnSnkba+mDR
X-Google-Smtp-Source: ABdhPJwsBg1ILC6THJFrorYkqgUKYo/VidnQyrFDlbP40NcFypY9Nzf+28UM/+wjzXuqX1NUtVpcPR4JXhLdPSiP/EY=
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr2521032ejc.610.1644422246743;
 Wed, 09 Feb 2022 07:57:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com>
In-Reply-To: <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 10:57:15 -0500
Message-ID: <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
To:     Jeff Mahoney <jeffm@suse.com>, Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, Tony Jones <tonyj@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 10:44 PM Jeff Mahoney <jeffm@suse.com> wrote:
>
> Hi Richard -
>
> On 5/19/21 16:00, Richard Guy Briggs wrote:
> > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > ("open: introduce openat2(2) syscall")
> >
> > Add the openat2(2) syscall to the audit syscall classifier.
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > ---
>
> [...]
>
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d775ea16505b..3f59ab209dfd 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -76,6 +76,7 @@
> >  #include <linux/fsnotify_backend.h>
> >  #include <uapi/linux/limits.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> > +#include <uapi/linux/openat2.h>
> >
> >  #include "audit.h"
> >
> > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> >       case AUDITSC_EXECVE:
> >               return mask & AUDIT_PERM_EXEC;
> > +     case AUDITSC_OPENAT2:
> > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> >       default:
> >               return 0;
> >       }
>
> ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.
>
> I'm getting oopses, like so:
> BUG: unable to handle page fault for address: 00007fff961bbe70

Thanks Jeff.

Yes, this is obviously the wrong thing to being doing; I remember
checking to make sure we placed the audit_openat2_how() hook after the
open_how was copied from userspace, but I missed the argv dereference
in the syscall exit path when reviewing the code.

Richard, as we are already copying the open_how info into
audit_context::openat2 safely, the obvious fix is to convert
audit_match_perm() to use the previously copied value instead of argv.
If you can't submit a patch for this today please let me know.

-- 
paul-moore.com
