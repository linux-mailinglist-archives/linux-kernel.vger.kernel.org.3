Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E404C3A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiBYA0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBYA0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:26:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E74275785
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:25:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m3so5163551eda.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tEVqjxBsx+zdcxyuCP32PdgEl44+G4Pk6hPEa4sGMWI=;
        b=L3xvgoPUdl+Mu+1xybfGSxGm/vUrl5/eYg+wVwayPTKOhBwqLL4nCkqokl+jP/mse+
         iZsiJlVQ4tbNm+GKMVZHU7UzlQ/5Xk/ZuNm0hTnrXjLoRvoOqo/O5J+vj3oEL3pbelvw
         F/alXMOoKIEni6Bv/uo2f7nIL6zF3tG5Y1Scobm0jrlhbNMujXKYDGpd0bC+IMrN/sOF
         WwDtPJkzWYqs1/1ZGc/d6w695MUt+7VHCEzbrbA+fY8DLVUuI+vvRv/acm7p87GA8sIx
         wjEBug9s/0P2LOnNnSD7n9P2eNLLpqJyLAEW4WegBneNCQxkiW2j8I5nsOw4SmYK/4/U
         JYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tEVqjxBsx+zdcxyuCP32PdgEl44+G4Pk6hPEa4sGMWI=;
        b=Zx18C4jzEMOdP1tLci9PE+q4iZZ6hLowiIXhkvTj835kYFusv9M+4mzjjba8r0w9v6
         s6l50dGpFcS1+myVWMarj8CGKBKRUFXKSUj2+IY27MKaYNWYnq59/qnTVdsz9DTsTyd4
         2QtiCZR7KaRS31RouVVyyTDOX47+oQiA1no0E0FGoBAhl9ZRlQHaZ2z44C6+xPqnKKyK
         4qcdCK3etDcIJuTEuzdIAq5xBaT/eEDXIDLGdXkVEza6luuTFO4/+GK4zMv+eN1hnXnd
         gQv0al6vufo3iKz4OFR3QaiIHiomzTx2NLZWorNVV/khAMyDIpLllSlTPDnUQkbdR4oY
         TR4g==
X-Gm-Message-State: AOAM530jQTGpgXhnaalIxAzO9BblOZol7N0u10kSnyWZh5tENXHyobLZ
        2sysvkD0aVMyJTqA8HuJ9WYc8vVYden1rWksShAo
X-Google-Smtp-Source: ABdhPJxBJvCVWWSs7qkL+zhxKoux3jmICxuRptbAUzqKSMRF5gkiUfDgk/ukE5plqx25CTr7EHsJ8XaHiTx7vFYs1lE=
X-Received: by 2002:a05:6402:2922:b0:40f:7241:74d4 with SMTP id
 ee34-20020a056402292200b0040f724174d4mr4791988edb.43.1645748740824; Thu, 24
 Feb 2022 16:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com>
In-Reply-To: <20220217143457.75229-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Feb 2022 19:25:29 -0500
Message-ID: <CAHC9VhRPwFGohkPT_PcFT=GXX66w2PYpRyXxY2p_hkcPx3j_jw@mail.gmail.com>
Subject: Re: [PATCH] selinux: log anon inode class name
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

On Thu, Feb 17, 2022 at 9:35 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Log the anonymous inode class name in the security hook
> inode_init_security_anon.  This name is the key for name based type
> transitions on the anon_inode security class on creation.  Example:
>
>     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  granted  { =
create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io_uring]" dev=3D"an=
on_inodefs" ino=3D6871 scontext=3Dsystem_u:system_r:mysqld_t:s0 tcontext=3D=
system_u:system_r:mysqld_iouring_t:s0 tclass=3Danon_inode
>
> Add a new LSM audit data type holding the inode and the class name.
>
> Also warn if the security hook gets called with no name set; currently
> the only caller fs/anon_inodes.c:anon_inode_make_secure_inode() passes
> one.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  include/linux/lsm_audit.h |  5 +++++
>  security/lsm_audit.c      | 21 +++++++++++++++++++++
>  security/selinux/hooks.c  |  7 +++++--
>  3 files changed, 31 insertions(+), 2 deletions(-)

...

> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 17d02eda9538..8135a88d6d82 100644
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
> @@ -96,6 +97,10 @@ struct common_audit_data {
>                 struct lsm_ibpkey_audit *ibpkey;
>                 struct lsm_ibendport_audit *ibendport;
>                 int reason;
> +               struct {
> +                       struct inode *inode;
> +                       const char *anonclass;
> +               } anoninode_struct;
>         } u;
>         /* this union contains LSM specific data */
>         union {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 1897cbf6fc69..5545fed35539 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -433,6 +433,27 @@ static void dump_common_audit_data(struct audit_buff=
er *ab,
>                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
>                                  lockdown_reasons[a->u.reason]);
>                 break;
> +       case LSM_AUDIT_DATA_ANONINODE: {
> +               struct dentry *dentry;
> +               struct inode *inode;
> +
> +               rcu_read_lock();
> +               inode =3D a->u.anoninode_struct.inode;
> +               dentry =3D d_find_alias_rcu(inode);
> +               if (dentry) {
> +                       audit_log_format(ab, " name=3D");
> +                       spin_lock(&dentry->d_lock);
> +                       audit_log_untrustedstring(ab, dentry->d_name.name=
);
> +                       spin_unlock(&dentry->d_lock);
> +               }

I'm not sure we are ever going to get a useful dentry name for
anonymous inodes, I think we can probably drop this.  The "anonclass=3D"
field will likely be much more interesting and helpful.

> +               audit_log_format(ab, " anonclass=3D");
> +               audit_log_untrustedstring(ab, a->u.anoninode_struct.anonc=
lass);
> +               audit_log_format(ab, " dev=3D");
> +               audit_log_untrustedstring(ab, inode->i_sb->s_id);

I'm pretty sure this is always going to end up being "anon_inodefs"
and thus not very useful.

> +               audit_log_format(ab, " ino=3D%lu", inode->i_ino);

Similarly, I'm not sure how useful the inode number is in practice.
I've never tried, but can a user lookup an anonymous inode via the
inode number?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index dafabb4dcc64..19c831d94d9b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2932,6 +2932,8 @@ static int selinux_inode_init_security_anon(struct =
inode *inode,
>         if (unlikely(!selinux_initialized(&selinux_state)))
>                 return 0;
>
> +       WARN_ON(!name);
> +
>         isec =3D selinux_inode(inode);
>
>         /*
> @@ -2965,8 +2967,9 @@ static int selinux_inode_init_security_anon(struct =
inode *inode,
>          * allowed to actually create this type of anonymous inode.
>          */
>
> -       ad.type =3D LSM_AUDIT_DATA_INODE;
> -       ad.u.inode =3D inode;
> +       ad.type =3D LSM_AUDIT_DATA_ANONINODE;
> +       ad.u.anoninode_struct.inode =3D inode;
> +       ad.u.anoninode_struct.anonclass =3D name ? (const char *)name->na=
me : "unknown(null)";

This doesn't seem to match well with the newly added WARN_ON()
assertion above.  I would suggest dropping the WARN_ON() assertion as
security_transition_sid() can already handle that safely, and leaving
the tertiary statement above; however I think we should probably
change the anonclass string to "?" as that is the common unset field
value used by audit.

--=20
paul-moore.com
