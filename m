Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C6511963
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiD0NWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiD0NW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:22:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767D220D8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:19:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e24so2459609wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tN2tlewy0jrtdqoRAyVen4TTXWYKbcGUUb+F7FNds44=;
        b=sILlvjaoa79+Jq01+MGUwsyPooetRBFU1iAlpEECl2cPudJppo1YinTxtU6abSgyo/
         QTA8Zal/mY1bq/1gXa5bGs4VCzXMxQlrYPPkvWhOuipPIJddCI7Pl5S355jWcNB+KXTF
         copiZnvjqGPWxS19fl3NAkgziHJJbzpJxxIpU/iRFfS3o9ahS+EiHPRyrAZZv0dneyrr
         5vcYzflMyfO1bzHOj2sjGFMgAZxmEtB1HqdkKRvTR8P7rovFcv6QLT51Qe+3Lot7TJgV
         eu9bENb+UHFZIHYs8z+oKsQfqK0SHXvNR9xROa3FqIXFFz326OB6yvDRdAPvR++9Xxln
         FavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tN2tlewy0jrtdqoRAyVen4TTXWYKbcGUUb+F7FNds44=;
        b=ebL9AU7j5APoBdVD9rXNt7taBsRPfEPj9ciudSB3uPuw9bjsJJ9GgvYtqOFgobIV1G
         C6aTYLLe2SuUvxlbQKmYydxzVRAAq8qa7vYONFN1nwUbKX5kJzaf63LXrhWgdL6xx0Q2
         b6+zyMFZGVDHfVDmhFkCdFZbfavfIhGhdFW674XeKEu3OfBLlTIrFn5dvVDrgGKO2Eti
         UWJzjQ6P02s9r3DnK4ppc2ZSBP8PFByXkcOIVfUolZ8bpYuQPuqWJkpbp+G+2hgaOmmi
         dO3kiG8meBowOVP6ePtrybQEnM/lu28N6EuLPEf9MM3e3R/sYuGS/xqpo6WLBnIwEB9F
         EAcA==
X-Gm-Message-State: AOAM531VK8dYYv70nrlrRxGXwg0gvMmW6UdHY7tor2eRq6ecdkosRqDh
        6xJKDsmHlbSuUxcaxkWWMs5/W27nB7X6riSWah/f
X-Google-Smtp-Source: ABdhPJziiXjvIwMJT7dfv53VTvmnoS9K6s+GynI9tKTuYMuTtw+zl4pVm4a+yn0Aihr2c/ScXnnE4CTOiPRxDImKy5A=
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id
 b12-20020a05600010cc00b0020ade6f3c48mr10712609wrx.650.1651065546145; Wed, 27
 Apr 2022 06:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com>
 <20220308170928.58040-1-cgzones@googlemail.com> <CAHC9VhSiqvCbKQHYTGAj3vqECNto6eNm0MyzLd92kcJnvZSw1A@mail.gmail.com>
In-Reply-To: <CAHC9VhSiqvCbKQHYTGAj3vqECNto6eNm0MyzLd92kcJnvZSw1A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Apr 2022 09:18:55 -0400
Message-ID: <CAHC9VhR1d2aLKsZOxLb6b1uuTcWOpnJ22S5=mXygvjcv6Sm=xg@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 4:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 8, 2022 at 12:09 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Log the anonymous inode class name in the security hook
> > inode_init_security_anon.  This name is the key for name based type
> > transitions on the anon_inode security class on creation.  Example:
> >
> >     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  granted \
> >         { create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io_uri=
ng]" \
> >         scontext=3Dsystem_u:system_r:mysqld_t:s0 \
> >         tcontext=3Dsystem_u:system_r:mysqld_iouring_t:s0 tclass=3Danon_=
inode
> >
> > Add a new LSM audit data type holding the inode and the class name.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > ---
> > v2:
> >   - drop dev=3D and name=3D output for anonymous inodes, and hence simp=
lify
> >     the common_audit_data union member.
> >   - drop WARN_ON() on empty name passed to inode_init_security_anon hoo=
k
> > ---
> >  include/linux/lsm_audit.h | 2 ++
> >  security/lsm_audit.c      | 4 ++++
> >  security/selinux/hooks.c  | 4 ++--
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > index 17d02eda9538..97a8b21eb033 100644
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
> > @@ -96,6 +97,7 @@ struct common_audit_data {
> >                 struct lsm_ibpkey_audit *ibpkey;
> >                 struct lsm_ibendport_audit *ibendport;
> >                 int reason;
> > +               const char *anonclass;
> >         } u;
> >         /* this union contains LSM specific data */
> >         union {
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index 1897cbf6fc69..981f6a4e4590 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -433,6 +433,10 @@ static void dump_common_audit_data(struct audit_bu=
ffer *ab,
> >                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
> >                                  lockdown_reasons[a->u.reason]);
> >                 break;
> > +       case LSM_AUDIT_DATA_ANONINODE:
> > +               audit_log_format(ab, " anonclass=3D");
> > +               audit_log_untrustedstring(ab, a->u.anonclass);
>
> My apologies, I didn't notice this in the previous patch ... I don't
> think we need to log this as an untrusted string as the string value
> is coming from the kernel, not userspace, so we could rewrite the
> above as the following:
>
>   audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
>
> ... if you are okay with that, I can make the change when I merge the
> patch or you can submit another revision, let me know which you would
> prefer.
>
> The rest of the patch looks good, thanks!

Hi Christian,

I just wanted to follow up on this as we are at -rc4 this week and if
we want this to go during the next merge window this would need to be
merged soon ...

--=20
paul-moore.com
