Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6724649D5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiAZXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiAZXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:01:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F17C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:01:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l5so1222241edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hrY2ypU0UcUzpuu0HvUTLlqvcOyvCuZ5uizVCmG3Y+w=;
        b=156HEm9ggPBMtKmoA1cSwYVY8LRaPIaePKKm5brqfy6Hg5Vd33JEYnRffn1YfXbjBu
         5PQzcEDO2OOp7L+L6hE8FjtNF0o+9euUc80AUFcW7DsXEZuOsgyf7fn/a2Kr+k81kO0h
         X501ZPQTRFaCNdwavx84Jv8iUjqaVQfhEI96RUn7DENBN30GVn6NnsRFBOyAAWk+KYXC
         An/BnQdJQbQlNc/xdYqaDO28aQ4WChARmRIfQZMcgbols5NU8GKsDcgem0fX8YQor+1n
         97Aa0aEfyAwAgVtcZFHN/yWwZmevAJrOHiD7oktGU3yyrHiCHwAI8/hupVG/wMRZqQ9d
         uTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hrY2ypU0UcUzpuu0HvUTLlqvcOyvCuZ5uizVCmG3Y+w=;
        b=6eU6FSedJz+yS/8NOHnJXGmHPv0rl/ADX6kqhpDISU27db0k4YqFcQLnTeYxGMjbqt
         rpH161jZEkee+epzqURS3WTf+Ky3Axo0pTTSWSm2RT9pJwEwHh8vI8g9qqBKQ/8+mqHF
         CIvJ/oSkNbXCN4hdLEru2JxnHEdDmzNLXyCpaP/t73FYocnd6qI++j2E52jq/j7v2nGG
         15MVBGBZs9dGsIviLtgPdwNPOxjnNL0kR5IekmM/VuiUwQ88aE5CZWkXSlhY6Lq8f/yo
         ilPZwuNlqGHe2G57lmQCilGuzjcm/cn9+KWBXTTWyNQx78ekBldftmRoC9t6VzBTYyyJ
         En/g==
X-Gm-Message-State: AOAM530F2oMU+IPiSzQdKA2jJzBADfp4nbI3HAanCtZGKQJWTs6Mrvf5
        b2eL3Ixs58JQbO/MijfcK4kKxdAJuqLW5xBv7/+U
X-Google-Smtp-Source: ABdhPJxIKOsEIfJTFhstoFnygEcu2edsCxb/edCGSMTyG99GpPkZvv/0HQ9atKeEH1Dbj6XG8KgRPxB252BRD34Xfs0=
X-Received: by 2002:a50:ef16:: with SMTP id m22mr1130661eds.340.1643238101310;
 Wed, 26 Jan 2022 15:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
In-Reply-To: <20220125143304.34628-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 18:01:30 -0500
Message-ID: <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Create a security context for the inodes created by memfd_secret(2) via
> the LSM hook inode_init_security_anon to allow a fine grained control.
> As secret memory areas can affect hibernation and have a global shared
> limit access control might be desirable.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> An alternative way of checking memfd_secret(2) is to create a new LSM
> hook and e.g. for SELinux check via a new process class permission.
> ---
>  mm/secretmem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This seems reasonable to me, and I like the idea of labeling the anon
inode as opposed to creating a new set of LSM hooks.  If we want to
apply access control policy to the memfd_secret() fds we are going to
need to attach some sort of LSM state to the inode, we might as well
use the mechanism we already have instead of inventing another one.

> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 22b310adb53d..b61cd2f661bc 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -164,11 +164,20 @@ static struct file *secretmem_file_create(unsigned =
long flags)
>  {
>         struct file *file =3D ERR_PTR(-ENOMEM);
>         struct inode *inode;
> +       const char *anon_name =3D "[secretmem]";
> +       const struct qstr qname =3D QSTR_INIT(anon_name, strlen(anon_name=
));
> +       int err;
>
>         inode =3D alloc_anon_inode(secretmem_mnt->mnt_sb);
>         if (IS_ERR(inode))
>                 return ERR_CAST(inode);
>
> +       err =3D security_inode_init_security_anon(inode, &qname, NULL);
> +       if (err) {
> +               file =3D ERR_PTR(err);
> +               goto err_free_inode;
> +       }
> +
>         file =3D alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>                                  O_RDWR, &secretmem_fops);
>         if (IS_ERR(file))
> --
> 2.34.1

--=20
paul-moore.com
