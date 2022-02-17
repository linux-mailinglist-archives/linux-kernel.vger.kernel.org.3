Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128D84BA2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiBQOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:25:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiBQOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:25:09 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C82B1669;
        Thu, 17 Feb 2022 06:24:54 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s8so3533581oij.13;
        Thu, 17 Feb 2022 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1hgyMGgqm2l0K029MbAV7HB50NHopCA50vfzIyF3//M=;
        b=gQIB0sLtPnj5zwwT6gSkOleVRcwWPRVCa1YooIVwsnJQdqp3MZFTwxOgBj4PIVqMR9
         HqLVXmmGuTj92Uye5WSlg/rwABYU9/nGb62XzyB+OdvtXNA1wlnjp1bq8XeCgYrNCmxN
         pqERattXxPcSY+V14OZunWDZjVg/p6wlKR1VgBQudZ0phigkvc1yr2w4jWVqLIxKA2rx
         ivP0IcPyTN9baWaayTX9flCTDJiiOVTqMq5bZ+KLs3hAwk+tkTUo47Ru6Jo/xLKQEwhT
         zYXO+ZDWre/jy5RV35OWpw+XXCKO7dY/KkzsnkV3FY1lhSQoPZnE8YKGPPoRs7P7ZOO1
         H4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1hgyMGgqm2l0K029MbAV7HB50NHopCA50vfzIyF3//M=;
        b=4452g39XNQgyHWxzVfIuTUzhdESICkbYZqsD70p4CzDXaE4fAsrn6/2Yoh5u6DMrY1
         7WzFbXx7dGHpdqbYNaUapX03XMVJ5BHqBS3ngIbsfGcJW1+DVeFdPhf28wStRXJuql0z
         0JARR2ZNInf15wyPnh+TksHDTDDw6aqYrPSATevgQzhwoQF9VvAWIwHwxic7afiztKth
         GvowFRsOE4qPRTIwmzk2IE+QI+H5/8sxgHk6lP5R0exrp7P1Fzugtx0eqEAyAgo9kjwb
         Zxw5/z0au11Wg5kY94VSB9E4/bv6seRRUaJU1Oi+lvotF7Lc+7X7O5FuQ97Mp8N3LEA6
         4Jcg==
X-Gm-Message-State: AOAM533qi1F+FDT/cVVO56LVeOOStjAHq/qRQc7GOBLD17cuZsKVaWSd
        qoOp1RFIKBAeHixP4Z4EG+2P2d/6aBPuGM0Ko5M=
X-Google-Smtp-Source: ABdhPJwvvtQk6R3zwXKzTDX5Ys3fUplA2RG10agfaeCFg5xA9zIXmJGVa0X27BvMbrhRnqbgtwKDQQsOy9PJ6NgZqgs=
X-Received: by 2002:a05:6808:f8e:b0:2d4:1d66:3a22 with SMTP id
 o14-20020a0568080f8e00b002d41d663a22mr2774822oiw.120.1645107893906; Thu, 17
 Feb 2022 06:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com> <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
In-Reply-To: <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 17 Feb 2022 15:24:42 +0100
Message-ID: <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Create a security context for the inodes created by memfd_secret(2) via
> > the LSM hook inode_init_security_anon to allow a fine grained control.
> > As secret memory areas can affect hibernation and have a global shared
> > limit access control might be desirable.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > An alternative way of checking memfd_secret(2) is to create a new LSM
> > hook and e.g. for SELinux check via a new process class permission.
> > ---
> >  mm/secretmem.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>
> This seems reasonable to me, and I like the idea of labeling the anon
> inode as opposed to creating a new set of LSM hooks.  If we want to
> apply access control policy to the memfd_secret() fds we are going to
> need to attach some sort of LSM state to the inode, we might as well
> use the mechanism we already have instead of inventing another one.

Any further comments (on design or implementation)?

Should I resend a non-rfc?

One naming question:
Should the anonymous inode class be named "[secretmem]", like
"[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?


> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 22b310adb53d..b61cd2f661bc 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -164,11 +164,20 @@ static struct file *secretmem_file_create(unsigne=
d long flags)
> >  {
> >         struct file *file =3D ERR_PTR(-ENOMEM);
> >         struct inode *inode;
> > +       const char *anon_name =3D "[secretmem]";
> > +       const struct qstr qname =3D QSTR_INIT(anon_name, strlen(anon_na=
me));
> > +       int err;
> >
> >         inode =3D alloc_anon_inode(secretmem_mnt->mnt_sb);
> >         if (IS_ERR(inode))
> >                 return ERR_CAST(inode);
> >
> > +       err =3D security_inode_init_security_anon(inode, &qname, NULL);
> > +       if (err) {
> > +               file =3D ERR_PTR(err);
> > +               goto err_free_inode;
> > +       }
> > +
> >         file =3D alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> >                                  O_RDWR, &secretmem_fops);
> >         if (IS_ERR(file))
> > --
> > 2.34.1
>
> --
> paul-moore.com
