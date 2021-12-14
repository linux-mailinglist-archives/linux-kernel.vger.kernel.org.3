Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109B8474745
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhLNQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhLNQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:14:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65DC061574;
        Tue, 14 Dec 2021 08:14:10 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id p8so29096204ljo.5;
        Tue, 14 Dec 2021 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7PtDlj0mth27+bgBvDyP1PaVmibKSZKtcK9ZB7JRas=;
        b=WDmoQgV5VlTLoi7Skx9OjojOP4C3E7Nve+DTDNEqtrUQkDID7QFNNf6DboZS2/8M/x
         WgYBjlUNQ4EdUwaP6DxZ0IxesIGYGBdnHCnfIB4YPX+zjvTlI4TExZfCxS7wQUUzwg0S
         OGIKasYrmfmsHH2L84Mjk8hCEub5UFz3XaORd4k5t78KSrhGKa0Qgpy7so0DGLq6qjFt
         m3cpsuI098rcB4OMgbDZFlKdmSkgoW7lg27uLydJsRs7y91Gk7omDgVVeKYVjHs2j5fx
         766ahOf1pwHIqaurmg8hfJ59mSjWs7sgN6/QQLt2CPw8x5g7Hv0D/Sfc2rNUeCZGApn0
         mimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7PtDlj0mth27+bgBvDyP1PaVmibKSZKtcK9ZB7JRas=;
        b=rBsSjHw4KmClYs/d7ypwHPHunBYPSy3CO9HahRlSjNvs5AqGu8hjmpX5z5GfLI6kzz
         lWpi4XLONHwDqIphrbrjpdH7Rt4sQevEStSB0NplFRxa2CNfaWFPj5mAr7iJrlU/B9aK
         VKrW2QNO2/jWS5rIXxV6B69UFTW/x5PybsFijr21E9Ric63jlChkdwYC1OOmarDstw7y
         fu0YHwJulsRtQfiaz9AYtvalLEzdLCoKkIhW0PWNBJXFdQ7jDoCSZNtSSJ894kfY7Y95
         qySi2+ng0xX3YEYQs7oeLfnTjjaYtI2S9MnwG7xnmcoR3GdhxE4jIWqK9JvA185XLD8a
         5z5A==
X-Gm-Message-State: AOAM530jAQbcd6HBMce8vUfNDh0SiKCpvqmfGfWLe32TgXwtlAqCqKru
        GTUSwhM5UzkBxqoNbHeCG1hR5U9BHz/BaQUWvw6a6GeG
X-Google-Smtp-Source: ABdhPJwaFhUmPowOhknAjENiJU2wmzO54MK8rvUGgjSOcYJS7DBEjVUPnPJ+6tDHDHJxk6I4cruojLgklofzu4v7178=
X-Received: by 2002:a2e:e1a:: with SMTP id 26mr5764067ljo.199.1639498448760;
 Tue, 14 Dec 2021 08:14:08 -0800 (PST)
MIME-Version: 1.0
References: <tencent_D6BF2948237359EE0A47338567B88512D106@qq.com>
In-Reply-To: <tencent_D6BF2948237359EE0A47338567B88512D106@qq.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 14 Dec 2021 11:14:10 -0500
Message-ID: <CAEjxPJ4nT3LFqNNh7PRP5DuuJeVfOh_JQiDboskbpBATgoJkOQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a wrong check condition of strcmp()
To:     xkernel.wang@foxmail.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 4:34 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> strcmp() will return 0 when two strings(s1, s2 for example) are equal.
> And if a negative number means s1 < s2. Here seems should use == 0 as
> the condition. Otherwise, the value of genfs->fstype can not be
> guaranteed.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

NAK. Look more closely at the code that follows, and understand that
the list is ordered to avoid needing to traverse all of it.

> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 759d878..c9f6c3a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2883,7 +2883,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>
>         for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
>                 cmp = strcmp(fstype, genfs->fstype);
> -               if (cmp <= 0)
> +               if (cmp == 0)
>                         break;
>         }
>
> --
