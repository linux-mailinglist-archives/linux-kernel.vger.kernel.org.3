Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0C4C1282
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiBWMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiBWMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D9BB9A996
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645618368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFaWIFIAWbCZZlUkAh2lkRliBgd1XRdRHOnZNx1Zc70=;
        b=AE9KrSIydw79LaywNSwwATce0lXYpcLNCikAmn3rACf+5Vhwe+m4O6Z2YwpIgb0LH+RD8t
        KArjGbYjDVARh6378deNDXDqlPCaoMRGTD/bWGWlsPC1kHMjNkj8WLxw5iitS7SGkeTsPK
        0OqMPDjSdDJVWFjyi9kOwkZdEEO7++A=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-I_st-SlyPbGgumUm_AvSig-1; Wed, 23 Feb 2022 07:12:47 -0500
X-MC-Unique: I_st-SlyPbGgumUm_AvSig-1
Received: by mail-yb1-f198.google.com with SMTP id r14-20020a5b018e000000b00624f6f97bf4so1066353ybl.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFaWIFIAWbCZZlUkAh2lkRliBgd1XRdRHOnZNx1Zc70=;
        b=c44cvsHrbFpeKL997GStn1yOYl/NfJVGvJVS4UtINkFtrs1N9g3jgPUE3ry+j3W5sx
         d/ZCgEvMHZWnum0lGoXQmBTNXHirRKatjJC1378boLRvXNkZPRxT2x9mzv34pUgoPieZ
         Nhyq4w/17KGAxKaTC0nkzQe2E9SLHzzWqlKEYngDFEQo9bAHszJ+umn6qwCy0By6VPMp
         O35/Zd6ZtaB0NpqY/gjA0japG9hnsZrdu//mSKLEMKqbZoJOCWOBmyfHoTqwTF3ZvSAh
         eG/o9Tyt2ZNvMw6UKE1hdoGBYGX4263jHV6GXQgQu9jU4ZnPfGueRvR+0KXtGw9TVz/2
         hgUg==
X-Gm-Message-State: AOAM530bgkph0R3q0DvwHYvoxgC885OTof0g9UIebcJXQAsLt6Yva+a/
        DyKzQ6b4NFmnqYDQTugXp3+CUSUnJMFxA6Se+voeQhikw9Fse30bz0wo7GFXWHk/QzYyU0bXpYL
        ZMTO3RjQPRqqVJyWxBzgx0KpkPidIXWwxWfC1gCzO
X-Received: by 2002:a25:374d:0:b0:611:a6c1:b948 with SMTP id e74-20020a25374d000000b00611a6c1b948mr27535681yba.21.1645618366845;
        Wed, 23 Feb 2022 04:12:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwm3Igy2eJcx5CR9bOCFhm+6tZKKA9klVaCA39zy7HSo6HF0bJv2D07KHeeOqE0LCB39k2IhUNJQEdkKyVUiAA=
X-Received: by 2002:a25:374d:0:b0:611:a6c1:b948 with SMTP id
 e74-20020a25374d000000b00611a6c1b948mr27535619yba.21.1645618365933; Wed, 23
 Feb 2022 04:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
 <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com> <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
In-Reply-To: <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 23 Feb 2022 13:12:36 +0100
Message-ID: <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > SELinux
> > > always allows too.  Furthermore, a failed FIOCLEX could result in a
> > > file
> > > descriptor being leaked to a process that should not have access to
> > > it.
> > >
> > > As this patch removes access controls, a policy capability needs to
> > > be
> > > enabled in policy to always allow these ioctls.
> > >
> > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > V2 Change: Control via a policy capability. See this thread for
> > > discussion:
> > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > >
> > > With this patch and the polcap enabled, the selinux-testsuite will
> > > fail:
> > > ioctl/test at line 47 - Will need a fix.
> > >
> > >  security/selinux/hooks.c                   | 7 +++++++
> > >  security/selinux/include/policycap.h       | 1 +
> > >  security/selinux/include/policycap_names.h | 3 ++-
> > >  security/selinux/include/security.h        | 7 +++++++
> > >  4 files changed, 17 insertions(+), 1 deletion(-)
> >
> > Thanks Richard for putting together the v2 of this patch.
> >
> > As far as the test is concerned, it seems like the quick-n-dirty fix
> > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > everyone okay with that?  At least that is what I'm going to do with
> > my local copy that I use to validate the kernel-secnext builds unless
> > someone has a better patch :)
>
> To fix this I was planning to submit a patch that would change the
> ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would continue
> to test the xperms.

That one seems to be implemented only by some filesystems. Is there
any more generic one we could use?

>
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 5b6895e4f..030c41652 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3745,6 +3745,13 @@ static int selinux_file_ioctl(struct file
> > > *file, unsigned int cmd,
> > >                                             CAP_OPT_NONE, true);
> > >                 break;
> > >
> > > +       case FIOCLEX:
> > > +       case FIONCLEX:
> > > +               /* Must always succeed if polcap set, else default:
> > > */
> > > +               if (selinux_policycap_ioctl_skip_cloexec())
> > > +                       break;
> > > +               fallthrough;
> > > +
> >
> > The break/fallthrough looks like it might be a little more fragile
> > than necessary, how about something like this:
> >
> >   case FIOCLEX:
> >   case FIONCLEX:
> >     if (!selinux_policycap_ioctl_skip_cloexec())
> >       error = ioctl_has_perm(cred, file, FILE__IOCTL, (u16) cmd);
> >       break;
> >
> > Yes, it does duplicate the default ioctl_has_perm() call, but since
> > we
> > are effectively deprecating this and locking the FIOCLEX/FIONCLEX
> > behavior with this policy capability it seems okay to me (and
> > preferable to relying on the fallthrough).
> >
> > Thoughts?
>
> Yes I did ponder this and in my first attempt I had this before the
> switch():
>
>         /* Must always succeed if polcap set */
>         if (selinux_policycap_ioctl_skip_cloexec() &&
>             (cmd == FIOCLEX || cmd == FIONCLEX))
>                 return 0;
>
>         switch (cmd) {
>         case FIONREAD:
>         case FIBMAP:
>
> but changed to within the switch(), anyway I'm happy to resubmit a
> patch either way.

I agree with Paul's suggestion. Better to duplicate the simple call
than to complicate the code flow.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

