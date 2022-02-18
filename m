Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FA4BBCEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiBRQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:02:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiBRQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:01:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5AD2B5223
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:01:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id om7so8945300pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XFjNobaT2htcA4k2+rACGDlyXr0w1b0IEeXMGWoU+GQ=;
        b=EPaXCh+QRxSRoSgsWxmJwRg6tqGCP82QzcP53X8m2d27haBnyVeGZM/TmoF1kloVEv
         7uQ7xQGri+04tUGGioLH9mW/QWzlVs+zX7RZTBaQOhJJwwzqnHwshwpwJ6HUuR1cM/sN
         jIEDk5XztFcGgigk325bNCeR1Ru4VN9kqMAvfG6ip18Rjx3zzJ3oKs4CEcrfw7ByvDt2
         B1XNj1b9UPfOQEqnwvGeyQQ9Cr0MFD+oF5AaJlW4klqELqyMnDOo9UBdgnu6QmXprStY
         4Kp5UNnyQlMzncVujkp9F47AvHEfza+1X5MHABFWaCkzNpUMMPQomJCv57ZgHaXhwpSb
         YjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XFjNobaT2htcA4k2+rACGDlyXr0w1b0IEeXMGWoU+GQ=;
        b=nmyEkJlydDb0vgBXJfbH9PMNXjTiK6sTWF2gXNTWBAsuhPSo2vwQXGPXknotWML7Kn
         JIXhxwf/CiL5uwKtiEt/qQIIz8m/TN8IjZfb8JDOFTjU9pu+NkfQ9NepSACC2/XNWW9v
         4J/Npia8UGzh8dt5rZs+cCWyMi8LXiUGr+D9KOZgxnjcQje//5lhdtrxHQf4DHalmYaf
         FRovbzvFPOuun78NvRvtyqYdGF4SvpE7LpsiuWJwwf6thNubmgu34KCxm4Yzzx/4CmVK
         Reod2nhZtzc0GImOVgeRaCgmI05hE9mxZlPBAsjz6+fDP1jC0ugJdMSNyr0by+4f4vqr
         jCow==
X-Gm-Message-State: AOAM5337/etQhZqsUijrhJQX38y+xkW55vKST8DhDiITw3rZCPQ43Tbo
        iii9zvpYo3e7Znnbpp4LI9To7BB1bSa3fGGUm1K1
X-Google-Smtp-Source: ABdhPJwLt+s8aeYwD2rdVVWp7ivVPPj6qTMkm8CczLA4ox6HcF14gZmFwHu1ScwIEJ2iHUDfWyR9MXBzmMJA0gyJ1CA=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr13317434pjo.200.1645200081628; Fri, 18
 Feb 2022 08:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-2-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-2-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 11:01:10 -0500
Message-ID: <CAHC9VhQPZ3_dXvM9eqwsxZ2c+2mcdvNNJbtUNs_-9Md5F3P8vA@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: use consistent pointer types for boolean arrays
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use a consistent type of unsigned int* for boolean arrays, instead of
> using implicit casts to and from int*.
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1481:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1481:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1481:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1398:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1398:48:    expected int *values
>     security/selinux/selinuxfs.c:1398:48:    got unsigned int *bool_pendi=
ng_values
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> A more invasive change would be to change all boolean arrays to bool*.

I think that might be a worthwhile change, although that can happen at
a later date.

A quick general comment: please try to stick to 80-char long lines.  I
realize Linus/checkpatch.pl has started to allow longer lines but I
would still like SELinux to try and keep to 80-chars or under.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 6901dc07680d..7865926962ab 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3175,7 +3175,8 @@ int security_get_bool_value(struct selinux_state *s=
tate,
>  static int security_preserve_bools(struct selinux_policy *oldpolicy,
>                                 struct selinux_policy *newpolicy)
>  {
> -       int rc, *bvalues =3D NULL;
> +       int rc;
> +       unsigned int *bvalues =3D NULL;

Doesn't this cause a type mismatch (unsigned int vs int) when an entry
from bvalues[] is assigned to cond_bool_datum::state later in the
security_preserve_bools() function?

--=20
paul-moore.com
