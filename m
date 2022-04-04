Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995D24F1B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359095AbiDDVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380522AbiDDUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:21:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A62AE9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:19:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f18so7436241edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+IOD94qLZON7z5cpIIeb+KlBMTXlMtRyTG6pq9z/7sE=;
        b=1XznDSFaeBL43LgBjOmEUUMnMaSzLra1EE4nshzUAR1prsSMutPqf14uLfx3FS29gE
         /zkI90HkCOuxsuRP2wKobkOzkJoRkH4aGE/Ck197Xe6RG0BH3GbKpttQc1ooL8Q9e3yg
         +gLc3YjjJaB4aSDB5M+CDRi94nmWY2YeNvMhm2V4ldT2wRMrwG69n0hS4g+7W7GUAJQZ
         2Ok60fbFu7wN2BdPXmcfCY2S+BwuORU9QSDwOHElcoDt1LiLztnLrMft5lJCLqwObQx+
         7IPdIEx2J94GEZ64jxysK9JK7eKTu9bq9aEBOteC/fYv0ksWMBgJ+dj9RQveG/satKBv
         RT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+IOD94qLZON7z5cpIIeb+KlBMTXlMtRyTG6pq9z/7sE=;
        b=X66+OCDj2zKf+dHk4nG88orCgjfp/3KpRJwdXuSCVJo4yhBg7WfQFCDifeaFX+A5Jm
         t/AzpCb2vMdQmgIxslf5bZ2OXkAwoTP5VTilp8gR89UHUSSVYdjKRA9ASdcYwlBdhG++
         ADOcDjCqKD8MtG+UVtQz0B4wAh6FMTMekJY0A8oy2sQeiE7UUsxC17ZnFD2WlvE/f3Kz
         cAJlzZE8k70Uueb5HAYP3gh3KyqGuj7SJGCya7PZdlc98UVywxgRluIINoUsTvzh+bUH
         u+MQheTiNVMCXlvYhuQMR+hXrHMMqGdERouwrYBc6/CsmqTWoyWYP4q0XJSQl8nMKctg
         RZbw==
X-Gm-Message-State: AOAM5326WiGnhVrWPLAu6fN5lnPpZCQla3EhDhJ6gg7U3A3rGqXupur+
        iQ/T1tXOGXk6S4Az9ysbdTJ54T5D9MzR9CeTShBdwLPJdw==
X-Google-Smtp-Source: ABdhPJz7lr2QA4pAedBicmWoNNd3dV+nYeSKLZcGV0j1cS/xio7wu3dCf3exaEW4/+2Wf2hvpNbYqREZigKGexmGcxo=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr1969103edd.405.1649103550207; Mon, 04
 Apr 2022 13:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com> <20220308170928.58040-1-cgzones@googlemail.com>
In-Reply-To: <20220308170928.58040-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 16:18:59 -0400
Message-ID: <CAHC9VhSiqvCbKQHYTGAj3vqECNto6eNm0MyzLd92kcJnvZSw1A@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log anon inode class name
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 12:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Log the anonymous inode class name in the security hook
> inode_init_security_anon.  This name is the key for name based type
> transitions on the anon_inode security class on creation.  Example:
>
>     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  granted \
>         { create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io_uring=
]" \
>         scontext=3Dsystem_u:system_r:mysqld_t:s0 \
>         tcontext=3Dsystem_u:system_r:mysqld_iouring_t:s0 tclass=3Danon_in=
ode
>
> Add a new LSM audit data type holding the inode and the class name.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> v2:
>   - drop dev=3D and name=3D output for anonymous inodes, and hence simpli=
fy
>     the common_audit_data union member.
>   - drop WARN_ON() on empty name passed to inode_init_security_anon hook
> ---
>  include/linux/lsm_audit.h | 2 ++
>  security/lsm_audit.c      | 4 ++++
>  security/selinux/hooks.c  | 4 ++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 17d02eda9538..97a8b21eb033 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -76,6 +76,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_IBENDPORT 14
>  #define LSM_AUDIT_DATA_LOCKDOWN 15
>  #define LSM_AUDIT_DATA_NOTIFICATION 16
> +#define LSM_AUDIT_DATA_ANONINODE       17
>         union   {
>                 struct path path;
>                 struct dentry *dentry;
> @@ -96,6 +97,7 @@ struct common_audit_data {
>                 struct lsm_ibpkey_audit *ibpkey;
>                 struct lsm_ibendport_audit *ibendport;
>                 int reason;
> +               const char *anonclass;
>         } u;
>         /* this union contains LSM specific data */
>         union {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 1897cbf6fc69..981f6a4e4590 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -433,6 +433,10 @@ static void dump_common_audit_data(struct audit_buff=
er *ab,
>                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
>                                  lockdown_reasons[a->u.reason]);
>                 break;
> +       case LSM_AUDIT_DATA_ANONINODE:
> +               audit_log_format(ab, " anonclass=3D");
> +               audit_log_untrustedstring(ab, a->u.anonclass);

My apologies, I didn't notice this in the previous patch ... I don't
think we need to log this as an untrusted string as the string value
is coming from the kernel, not userspace, so we could rewrite the
above as the following:

  audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);

... if you are okay with that, I can make the change when I merge the
patch or you can submit another revision, let me know which you would
prefer.

The rest of the patch looks good, thanks!

> +               break;
>         } /* switch (a->type) */
>  }
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b12e14b2797b..49c0abfd2f6a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2965,8 +2965,8 @@ static int selinux_inode_init_security_anon(struct =
inode *inode,
>          * allowed to actually create this type of anonymous inode.
>          */
>
> -       ad.type =3D LSM_AUDIT_DATA_INODE;
> -       ad.u.inode =3D inode;
> +       ad.type =3D LSM_AUDIT_DATA_ANONINODE;
> +       ad.u.anonclass =3D name ? (const char *)name->name : "?";
>
>         return avc_has_perm(&selinux_state,
>                             tsec->sid,
> --
> 2.35.1

--=20
paul-moore.com
