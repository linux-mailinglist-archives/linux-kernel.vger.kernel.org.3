Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CCD49BC72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiAYTrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiAYTqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:46:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C27C061749
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:46:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c15so12616331ljf.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ikFUcN/tVzW0fMx/FxScW5ahceyJ22Tp7p5x3rRO04=;
        b=CWv1dcqS9d6z8NlzDMCXj6rpH318FLRdFz5BY/i0Nq/W+uFGbdiDpgTdTCnQt14tXc
         reNilqW32iAwQTb8YsYUb4vNhVJH1SSSAygrjtDqnfZ9pv+fmYv/jsy9H45TAtbH1Rb8
         u1XrRhQNg7V3PFsCNcIJPKXLqcPvCELeDeQcMP1sTlEKik2PSk9IaMt+5zBCkR/Pp/5Y
         FDhUw9nr9lkJnqJMmpRYpSthLjAJhyTzt3VBy3PNb3AnxYLljB2JHuyZ1LIam45cKkPs
         vxsO038RSEQ7K/hsYfx0kh0Y6yT1j8o0NFtUOBSQbg1TJBgwBWbJzbkQGZypFtR19Fhx
         zLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ikFUcN/tVzW0fMx/FxScW5ahceyJ22Tp7p5x3rRO04=;
        b=KJ3UN4acjpAkuY2fC0xg+++ZRZR6VRBxiJAaPf2mVu5SMve4Q7h/ahCDkux+e7VWTQ
         Uwx+qjztltbS7l1P/Ci7L6Z6mPaSFkJ/+Zc8iVGRCoNo36jFsAsNiFDeD5tiwijU6QCF
         GHn1vCjiaCezM0asYeHdPjT/VMUqDAVNjRtkwmXDamknaFWiO4aeTbLqOevwOzA/o4DC
         7iTjQ7J9PMG/IYTqTNKG/JH1j+JmZ1/RysOkSMf2dhLszCbGIA2zc/nj7Z5HXqaWxUP/
         tc4apTjzMRWMA7OJU05tEk78ccgZkeJKFwDHlBfKA6rEj7p/goTG8os2C2DpA8KRI3hN
         pxvg==
X-Gm-Message-State: AOAM530V5g8DMpCndCufh7zuNvrBTiQcdIp6YZm37R8lTd+WHbIx8JU0
        3+K7rhWB2SECXqsrE0EQgD1QV3qhpaYqmWOaeCnw2Q==
X-Google-Smtp-Source: ABdhPJzPuKCgEjEjJHS0X0O6pfg/Jc6Cj92bekA8cLL6QcjUutztZ41ZgQaRpvglGyC6VvuyAkF9v2v6ZwHcD0s1n4E=
X-Received: by 2002:a2e:9610:: with SMTP id v16mr7963140ljh.339.1643139973065;
 Tue, 25 Jan 2022 11:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-9-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-9-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 11:46:00 -0800
Message-ID: <CAKwvOdmkfSQrLL2+fbjnRoY3wiRfpxLUU4YwP+XaiCwNrbi9ww@mail.gmail.com>
Subject: Re: [PATCH 1/9] selinux: check return value of sel_make_avc_files
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> sel_make_avc_files() might fail and return a negative errno value on
> memory allocation failures. Re-add the check of the return value,
> dropped in 66f8e2f03c02.
>
> Reported by clang-analyzer:
>
>     security/selinux/selinuxfs.c:2129:2: warning: Value stored to 'ret' i=
s never read [deadcode.DeadStores]
>             ret =3D sel_make_avc_files(dentry);
>             ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/selinux/selinuxfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index e4cd7cb856f3..f2f6203e0fff 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2127,6 +2127,8 @@ static int sel_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         }
>
>         ret =3D sel_make_avc_files(dentry);
> +       if (ret)
> +               goto err;
>
>         dentry =3D sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
>         if (IS_ERR(dentry)) {
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
