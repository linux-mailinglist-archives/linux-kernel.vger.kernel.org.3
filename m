Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103204D1E41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiCHRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348628AbiCHRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:13:33 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DB25E0;
        Tue,  8 Mar 2022 09:12:35 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so9651054ooc.4;
        Tue, 08 Mar 2022 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRTETGecuG6wFvpJiWj2QB7gtWBg3s5Eo853/+tZlW8=;
        b=WxX6Vsrn74ymtFqVMdNmUFhV7bRO8ZdIijHBTmDXbqPTWEWKhLXzmaIaq4HV3IpIJ7
         Vwe5GzLp4wmt4oPD8QFb0EwAeUYMRn3VCRYU3xkbQNqM9QF8gjD8tyTvXyG7o0wT7u+h
         SxK7TUnBAjCr/QxmM71n/cA0s6LSIj/dMvOqRc/pW/qxwqi1h76lG6M3m4kc0BFCv8wK
         SJYkX65fNOMiaHQf8LPyJDE9GC0Q8dIf00wBQxl/P3jk8EriEoUUehiINN9HHM1O6Ppf
         7jAi8VAni4yKdxVTkfz5dzMvhq4t7JxCTLqydNFI+zQqxKDaJzS/G9gBf+f955n7sy1g
         q4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRTETGecuG6wFvpJiWj2QB7gtWBg3s5Eo853/+tZlW8=;
        b=HqbTIk4gn8jhzGZtq1+KVBmBYyuOm25e1rn40idoZ4QlbPA91Me37MidTS3O8rWRnD
         ++nv9YAx0doQ9h0QQXH9YfYxinMRoytEpY1utgLlwI67OUyoEWzenr+ncvf4R+adwTNd
         0yQgm/vhqBA29d9ipMxRxt+neSHE6S1VXXd+XowIBf33+U1UKdGNDRg02/scoMwdXCqr
         Sn0VbK+bUgQFJkHFGkI02dIb0Bw0i2CvCXkEXKXvNX/ri5OOEVJzN75gFDT7qR7Mwsvl
         eYQojMMEJ0EYN44lk2oR9044IIKX3MEyz3fNTsGvWSqYAZ0lPOb0tVtL3gCzbYRMWlcL
         +mdQ==
X-Gm-Message-State: AOAM531pXIxhRgOU7RVS+F4N7IYaSo4yPWIqP10QcC6ytlxVMCQ0NKMV
        WYfNI015Pyx09KTFHkVjal+5WDmcXj+QMbIw3/g=
X-Google-Smtp-Source: ABdhPJzzp25E3kaf8Q2FMGPMK5d8e3fJIfD55qj+2erCT2la6Z/G+vDddwWrdV3y06rmy/NJuifHPivO3F9rtKrQVqc=
X-Received: by 2002:a05:6870:1688:b0:da:b3f:321d with SMTP id
 j8-20020a056870168800b000da0b3f321dmr3068797oae.205.1646759555172; Tue, 08
 Mar 2022 09:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com> <CAHC9VhRPwFGohkPT_PcFT=GXX66w2PYpRyXxY2p_hkcPx3j_jw@mail.gmail.com>
In-Reply-To: <CAHC9VhRPwFGohkPT_PcFT=GXX66w2PYpRyXxY2p_hkcPx3j_jw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 8 Mar 2022 18:12:24 +0100
Message-ID: <CAJ2a_Dfa+KhwQUHQo0uBdYZkoTsKvzZYVVM03JdzRoxwR3tZaw@mail.gmail.com>
Subject: Re: [PATCH] selinux: log anon inode class name
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
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

On Fri, 25 Feb 2022 at 01:25, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:35 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Log the anonymous inode class name in the security hook
> > inode_init_security_anon.  This name is the key for name based type
> > transitions on the anon_inode security class on creation.  Example:
> >
> >     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  granted  =
{ create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io_uring]" dev=3D"=
anon_inodefs" ino=3D6871 scontext=3Dsystem_u:system_r:mysqld_t:s0 tcontext=
=3Dsystem_u:system_r:mysqld_iouring_t:s0 tclass=3Danon_inode
> >
> > Add a new LSM audit data type holding the inode and the class name.
> >
> > Also warn if the security hook gets called with no name set; currently
> > the only caller fs/anon_inodes.c:anon_inode_make_secure_inode() passes
> > one.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  include/linux/lsm_audit.h |  5 +++++
> >  security/lsm_audit.c      | 21 +++++++++++++++++++++
> >  security/selinux/hooks.c  |  7 +++++--
> >  3 files changed, 31 insertions(+), 2 deletions(-)
>
> ...
>
> > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > index 17d02eda9538..8135a88d6d82 100644
> > --- a/include/linux/lsm_audit.h
> > +++ b/include/linux/lsm_audit.h
> > @@ -76,6 +76,7 @@ struct common_audit_data {
> >  #define LSM_AUDIT_DATA_IBENDPORT 14
> >  #define LSM_AUDIT_DATA_LOCKDOWN 15
> >  #define LSM_AUDIT_DATA_NOTIFICATION 16
> > +#define LSM_AUDIT_DATA_ANONINODE       17
> >         union   {
> >                 struct path path;
> >                 struct dentry *dentry;
> > @@ -96,6 +97,10 @@ struct common_audit_data {
> >                 struct lsm_ibpkey_audit *ibpkey;
> >                 struct lsm_ibendport_audit *ibendport;
> >                 int reason;
> > +               struct {
> > +                       struct inode *inode;
> > +                       const char *anonclass;
> > +               } anoninode_struct;
> >         } u;
> >         /* this union contains LSM specific data */
> >         union {
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 1897cbf6fc69..5545fed35539 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -433,6 +433,27 @@ static void dump_common_audit_data(struct audit_bu=
ffer *ab,
> >                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
> >                                  lockdown_reasons[a->u.reason]);
> >                 break;
> > +       case LSM_AUDIT_DATA_ANONINODE: {
> > +               struct dentry *dentry;
> > +               struct inode *inode;
> > +
> > +               rcu_read_lock();
> > +               inode =3D a->u.anoninode_struct.inode;
> > +               dentry =3D d_find_alias_rcu(inode);
> > +               if (dentry) {
> > +                       audit_log_format(ab, " name=3D");
> > +                       spin_lock(&dentry->d_lock);
> > +                       audit_log_untrustedstring(ab, dentry->d_name.na=
me);
> > +                       spin_unlock(&dentry->d_lock);
> > +               }
>
> I'm not sure we are ever going to get a useful dentry name for
> anonymous inodes, I think we can probably drop this.  The "anonclass=3D"
> field will likely be much more interesting and helpful.
>
> > +               audit_log_format(ab, " anonclass=3D");
> > +               audit_log_untrustedstring(ab, a->u.anoninode_struct.ano=
nclass);
> > +               audit_log_format(ab, " dev=3D");
> > +               audit_log_untrustedstring(ab, inode->i_sb->s_id);
>
> I'm pretty sure this is always going to end up being "anon_inodefs"
> and thus not very useful.
>
> > +               audit_log_format(ab, " ino=3D%lu", inode->i_ino);
>
> Similarly, I'm not sure how useful the inode number is in practice.
> I've never tried, but can a user lookup an anonymous inode via the
> inode number?
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index dafabb4dcc64..19c831d94d9b 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2932,6 +2932,8 @@ static int selinux_inode_init_security_anon(struc=
t inode *inode,
> >         if (unlikely(!selinux_initialized(&selinux_state)))
> >                 return 0;
> >
> > +       WARN_ON(!name);
> > +
> >         isec =3D selinux_inode(inode);
> >
> >         /*
> > @@ -2965,8 +2967,9 @@ static int selinux_inode_init_security_anon(struc=
t inode *inode,
> >          * allowed to actually create this type of anonymous inode.
> >          */
> >
> > -       ad.type =3D LSM_AUDIT_DATA_INODE;
> > -       ad.u.inode =3D inode;
> > +       ad.type =3D LSM_AUDIT_DATA_ANONINODE;
> > +       ad.u.anoninode_struct.inode =3D inode;
> > +       ad.u.anoninode_struct.anonclass =3D name ? (const char *)name->=
name : "unknown(null)";
>
> This doesn't seem to match well with the newly added WARN_ON()
> assertion above.  I would suggest dropping the WARN_ON() assertion as
> security_transition_sid() can already handle that safely, and leaving
> the tertiary statement above; however I think we should probably
> change the anonclass string to "?" as that is the common unset field
> value used by audit.

Is the hook inode_init_security_anon expected to be called with an
empty name though?
The condition was just a fallback to not crash the kernel.
(Dropped in v2.)

>
> --
> paul-moore.com
