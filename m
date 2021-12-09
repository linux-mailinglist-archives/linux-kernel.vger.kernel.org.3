Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1845A46E611
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhLIKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhLIKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639043995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUOR5I53OGqJSsk4CJuJI/xCDSxY8ZttZFgVhslyUfQ=;
        b=EEoAyeNVJ5f0xttbWNAF3uFBgtHXy/jny1/HINBOpb9xsymkdeurD5mg/B/tJY8Qk7M+NR
        kLTJ7hnn/JkGHRvOZB3/36YaKvfslNCCY0qoJ2ZNEHjnvD9kZwNtqPme99rQzsyJtSo+WV
        OxtyXmYLZ0E87NE/VyAtt64gp4EXFuk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-CHAVz73FMc2KS8b1Nmcc5Q-1; Thu, 09 Dec 2021 04:59:52 -0500
X-MC-Unique: CHAVz73FMc2KS8b1Nmcc5Q-1
Received: by mail-yb1-f198.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso9630227ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 01:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUOR5I53OGqJSsk4CJuJI/xCDSxY8ZttZFgVhslyUfQ=;
        b=FVDauWd4XHkO03QISrzoYfgH2vcZLGuaxeLR4GfQ6uzZ8GEGaPycS3Wwtpd/mkoS1c
         /d0IQ7EAgRYMcHgR6y3gfFwNm8Asz1d9QPCaG0ZNkDbUZiV0FeC34eLz/f2tLgip1Fu8
         O8M2gPOxEr5hhTbQ54tJ8VYQpmw9UJ2sPJreLxXbCsTl64TPxBYL417PgjVMxY1NJzJp
         lusBN4h5F4EydqGTBYCiU2Ek1pdCO5/ylEKzzVxV0GnJcyy0xQpwDAghP3b+wjOtVWQc
         Uvq8FF28xciiMe+ZiEZdY6bbpZ0gqGOL9pW8t8IJoynnhgP17L5SqqF1OvCIUzEdWf6/
         rPWw==
X-Gm-Message-State: AOAM533rc99auqZvP8YzPDN1u3U/KmH/skzYfjYomB0RszAPwTyfq64n
        /FbEI6pvQ0gHWGs0a7w+IdmrDK++c1Bn3mr4LQqvWiXPE7zPQrBaxp2lMyaqV4h2pVoS7NB/b2J
        d3AXymKF+SlVBBTmdfleUDcbmhT7i2/iY6tHa1CJj
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr5033688ybt.31.1639043992130;
        Thu, 09 Dec 2021 01:59:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrr+vAHKPEZBQaEYYqOfoATRuulMF2VBeZzYmrE7yoOP/TwNriGBB1nhEwEobAQfMqOghOptG3Y2QK2Urm1i0=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr5033658ybt.31.1639043991851;
 Thu, 09 Dec 2021 01:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20211206071859.324729-1-bernard@vivo.com> <PSAPR06MB4021DF6A6135859C2332E5B9DF6E9@PSAPR06MB4021.apcprd06.prod.outlook.com>
In-Reply-To: <PSAPR06MB4021DF6A6135859C2332E5B9DF6E9@PSAPR06MB4021.apcprd06.prod.outlook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 9 Dec 2021 10:59:41 +0100
Message-ID: <CAFqZXNsSDFKDJ8PX2bu9p4-pHH+3yAEoy=XZ+uHB=XqM=k5yhQ@mail.gmail.com>
Subject: Re: [PATCH v2] security/selinux: fix potential memleak in error branch
To:     =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 1:05 PM =E8=B5=B5=E5=86=9B=E5=A5=8E <bernard@vivo.co=
m> wrote:
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: bernard@vivo.com <bernard@vivo.com> =E4=BB=
=A3=E8=A1=A8 Ondrej Mosnacek
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B412=E6=9C=886=E6=97=A5 =
17:11
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E8=B5=B5=E5=86=9B=E5=A5=8E <bernard@vivo.co=
m>
> =E6=8A=84=E9=80=81: Paul Moore <paul@paul-moore.com>; Stephen Smalley <st=
ephen.smalley.work@gmail.com>; Eric Paris <eparis@parisplace.org>; SElinux =
list <selinux@vger.kernel.org>; Linux kernel mailing list <linux-kernel@vge=
r.kernel.org>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] security/selinux: fix potential memlea=
k in error branch
>
> On Mon, Dec 6, 2021 at 8:19 AM Bernard Zhao <bernard@vivo.com> wrote:
> > This patch try to fix potential memleak in error branch.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > ---
> >  security/selinux/hooks.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c index
> > 62d30c0a30c2..8dc140399a23 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -983,18 +983,22 @@ static int selinux_sb_clone_mnt_opts(const
> > struct super_block *oldsb,  static int selinux_add_opt(int token,
> > const char *s, void **mnt_opts)  {
> >         struct selinux_mnt_opts *opts =3D *mnt_opts;
> > +       bool is_alloc_opts =3D false;
> >
> >         if (token =3D=3D Opt_seclabel)      /* eaten and completely ign=
ored */
> >                 return 0;
> >
> > +       if (!s)
> > +               return -ENOMEM;
> > +
> >         if (!opts) {
> >                 opts =3D kzalloc(sizeof(struct selinux_mnt_opts), GFP_K=
ERNEL);
> >                 if (!opts)
> >                         return -ENOMEM;
> >                 *mnt_opts =3D opts;
> > +               is_alloc_opts =3D true;
> >         }
> > -       if (!s)
> > -               return -ENOMEM;
> > +
> >         switch (token) {
> >         case Opt_context:
> >                 if (opts->context || opts->defcontext) @@ -1019,6
> > +1023,8 @@ static int selinux_add_opt(int token, const char *s, void **=
mnt_opts)
> >         }
> >         return 0;
> >  Einval:
> > +       if (is_alloc_opts)
> > +               kfree(opts);
> >         pr_warn(SEL_MOUNT_FAIL_MSG);
> >         return -EINVAL;
> >  }
> > --
> > 2.33.1
>
> >The problem is a bit more tricky... As is, this patch will lead to doubl=
e frees in some cases. Look at security_sb_eat_lsm_opts() callers, for exam=
ple - some of them don't do anything when error is returned, some call
> >security_free_mnt_opts() on the opts regardless, some will let it store =
the opts in fc->security, where
> >put_fs_context() will eventually call security_free_mnt_opts() on them.
>
> >You need to at least *mnt_opts =3D NULL after kfree(opts), but it would =
be also nice to make the LSM hook callers more consistent in what they do i=
n the error path and document the fact that *mnt_opts will be NULL
> >on error in lsm_hooks.h (in case of the sb_eat_lsm_opts hook).
> Hi Ondrej Mosnacek:
>
> Thanks for your comments!
> I am not sure if there is some gap, for this part " it would be also nice=
 to make the LSM hook callers more consistent in what they do in the error =
path and document the fact that *mnt_opts will be NULL
> on error in lsm_hooks.h (in case of the sb_eat_lsm_opts hook)"
> I am not sure if this is OK:
> 116   * @sb_eat_lsm_opts:
> 117   *         Eat (scan @orig options) and save them in @mnt_opts.
> 118   *     If error is returned, then the *mnt_opts will be NULL.
> Please help to double check, thanks!

I'd prefer something like:

If the hook returns 0, the caller is responsible for destroying the
returned @mnt_opts using the @sb_free_mnt_opts hook. The LSMs must not
expect the callers to destroy @mnt_opts if the hook returns an error
and should always set it to NULL in such case.

(You may want to double-check that the other implementations of this
hook (i.e. security/smack/smack_lsm.c) follow that contract and fix
them if necessary.)

Thanks for your efforts to improve this!

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

