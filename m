Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46ED518E71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbiECUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiECUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:15:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559D40E52
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:10:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so2916044pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F1Z4/d6DDe3J/2+a6zGvXw/SwahIrpiTzs4QPSGop1Q=;
        b=AhDLELavTudJm4Q4HJmBysN8XtrTMfFnCe15RLGV4KJnUqdms/L3RqTK7tRVF4QFVC
         T6H+NTDqgYEzJEVqsZdpnLa+6ApN4LBlt6glH8keHBix5Y828v4Fwk4F8EAVosiwPEt8
         hWWFmf4NCVfMVLqHTyCJcaJDHAeQIdUUkXs1dj8yQN4H8MsJ/K+51jHPKxSBqGOP5J3Y
         it8s9sBRuEku0sppDBxiZN4y2pWV6M1ulo5q+Wc49JUTMJ9GBDpBJ7nJvoNkRAkpQCkP
         XbCyCFRw74gGN4A95lOX6TXnYvydrTRttTx4839DDBzRNwd443p7jf8iMZ8HrbCcE38S
         1Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F1Z4/d6DDe3J/2+a6zGvXw/SwahIrpiTzs4QPSGop1Q=;
        b=mlk0Szsq0qw2zEdbTI928rTgSvNI6y9HgzFhLEdvs/oLnS19TcN8ReZb40IOGLLjAQ
         mPMo6oS6LXgxpblWje8/PQ7aTlVVvWw8Ibo1oATFymZGUgUqB/oEUGKicUxkAui/GaT1
         00jQ2DKt4w0r7TN7YnFfqbKghXbTu0zfoFEhPBMJ7efcXH7WikSIMfLEF9PZFjqi1oge
         VwAWWA6iV97b1/yfZ94EBjNrku1pmcs4IEjydgK1Dr2fyxIeRHka3kus9UiZdLr3ehnN
         eJaLy7qGHdoYoxCZZvLnpfOMgmz9CD4gmVDCihbG/XAkvBXmq0Bu5b3K9naC8a50YhyO
         8+Iw==
X-Gm-Message-State: AOAM532GUDxVqPsCT3DG7NrMGe5Nqr3HyinvbxfR4Db86RN9SkCN6ZqE
        +n9q1PxLrDOjHMAD3yzCEVglOep7qapQR5PAT9J5
X-Google-Smtp-Source: ABdhPJzC8uRUEmor5TSiXSaoorAevlrZJXQ06HarNkBGXZKYY+cwiBMvymFFqCd4CEY2Xo2nfn+MwlAPLNc/IT20HvA=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr18100490plr.6.1651608653214; Tue, 03
 May 2022 13:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com>
 <20220308170928.58040-1-cgzones@googlemail.com> <CAHC9VhSiqvCbKQHYTGAj3vqECNto6eNm0MyzLd92kcJnvZSw1A@mail.gmail.com>
 <CAHC9VhR1d2aLKsZOxLb6b1uuTcWOpnJ22S5=mXygvjcv6Sm=xg@mail.gmail.com> <CAJ2a_DeWWoSYwhmbNpSuDhve9KUfEnoPiHdd5s_CpKHRUbi8Bw@mail.gmail.com>
In-Reply-To: <CAJ2a_DeWWoSYwhmbNpSuDhve9KUfEnoPiHdd5s_CpKHRUbi8Bw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 16:10:42 -0400
Message-ID: <CAHC9VhQYpo38Bv6tHYh=L-Bkxe=ym97xG8pt1tE6wR+V0Qy+WA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log anon inode class name
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:39 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Wed, 27 Apr 2022 at 15:19, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Apr 4, 2022 at 4:18 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Mar 8, 2022 at 12:09 PM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Log the anonymous inode class name in the security hook
> > > > inode_init_security_anon.  This name is the key for name based type
> > > > transitions on the anon_inode security class on creation.  Example:
> > > >
> > > >     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  grant=
ed \
> > > >         { create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io=
_uring]" \
> > > >         scontext=3Dsystem_u:system_r:mysqld_t:s0 \
> > > >         tcontext=3Dsystem_u:system_r:mysqld_iouring_t:s0 tclass=3Da=
non_inode
> > > >
> > > > Add a new LSM audit data type holding the inode and the class name.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > >
> > > > ---
> > > > v2:
> > > >   - drop dev=3D and name=3D output for anonymous inodes, and hence =
simplify
> > > >     the common_audit_data union member.
> > > >   - drop WARN_ON() on empty name passed to inode_init_security_anon=
 hook
> > > > ---
> > > >  include/linux/lsm_audit.h | 2 ++
> > > >  security/lsm_audit.c      | 4 ++++
> > > >  security/selinux/hooks.c  | 4 ++--
> > > >  3 files changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > > > index 17d02eda9538..97a8b21eb033 100644
> > > > --- a/include/linux/lsm_audit.h
> > > > +++ b/include/linux/lsm_audit.h
> > > > @@ -76,6 +76,7 @@ struct common_audit_data {
> > > >  #define LSM_AUDIT_DATA_IBENDPORT 14
> > > >  #define LSM_AUDIT_DATA_LOCKDOWN 15
> > > >  #define LSM_AUDIT_DATA_NOTIFICATION 16
> > > > +#define LSM_AUDIT_DATA_ANONINODE       17
> > > >         union   {
> > > >                 struct path path;
> > > >                 struct dentry *dentry;
> > > > @@ -96,6 +97,7 @@ struct common_audit_data {
> > > >                 struct lsm_ibpkey_audit *ibpkey;
> > > >                 struct lsm_ibendport_audit *ibendport;
> > > >                 int reason;
> > > > +               const char *anonclass;
> > > >         } u;
> > > >         /* this union contains LSM specific data */
> > > >         union {
> > > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > > index 1897cbf6fc69..981f6a4e4590 100644
> > > > --- a/security/lsm_audit.c
> > > > +++ b/security/lsm_audit.c
> > > > @@ -433,6 +433,10 @@ static void dump_common_audit_data(struct audi=
t_buffer *ab,
> > > >                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
> > > >                                  lockdown_reasons[a->u.reason]);
> > > >                 break;
> > > > +       case LSM_AUDIT_DATA_ANONINODE:
> > > > +               audit_log_format(ab, " anonclass=3D");
> > > > +               audit_log_untrustedstring(ab, a->u.anonclass);
> > >
> > > My apologies, I didn't notice this in the previous patch ... I don't
> > > think we need to log this as an untrusted string as the string value
> > > is coming from the kernel, not userspace, so we could rewrite the
> > > above as the following:
> > >
> > >   audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
> > >
> > > ... if you are okay with that, I can make the change when I merge the
> > > patch or you can submit another revision, let me know which you would
> > > prefer.
>
> Feel free to adjust while merging, thanks.

Adjusted and merged, thanks.

--=20
paul-moore.com
