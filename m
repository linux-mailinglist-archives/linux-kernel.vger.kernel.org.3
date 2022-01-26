Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5135E49C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiAZBEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiAZBEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:04:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB6C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:04:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so34838691eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GTAyGpZpmaUsPX9axsiybxghgU18jS0enUJ4yCmKfeA=;
        b=gqKUWRyRARbRk0SGN0Ug87qWmhiWP++BNrtjFXsLJKVCte7lTE+HTbyWyEoPAy4N5U
         Cr/nvGCQsDIwzs732Xj1dYSYM47ja/d5pm0F5YZMDHNVCSW37GrkW4saw96qY87DLWe9
         3J32o/WgUPqJAAwC8BvNXDmAHZ12guTjhNoCBu6SRZd8H/gbavxyahxeyogwFZC7/Ao/
         TpXQlklenvh9cbGVXERoeSJfI4YGELTJWS0ItxWav3nXitxmb/qlIqL1RYIXHSKrJ5eH
         SqqxjJSARcyscmkEbZlnJF+wBqo52bftQNRUgPljpqcKO7W5ffyJHyJ66Sbe8IlxTkNp
         DNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GTAyGpZpmaUsPX9axsiybxghgU18jS0enUJ4yCmKfeA=;
        b=VbpxaD53SUoS0qUWzqfja0/YjustfJoxTkDpU+2dNuqyPutnoOo2A7FCSXZhn8aw1D
         PL0aZXVvApVHebKx5cKp/ZHoUC9UoNgh5xyxUa+E5HQc+BwAn21ZTCitjcPR1ZCUozum
         22zD38lKF5VP2wrhksY5MKU7UcJeNcujw4kiquTaMz3SsILcY21rzjIuwEqzMVfM+JlT
         7qXIWO6YL0/Y9yf1theu9tCixLzgNkBOBsgUQbzYetV9WRSVC3tg7Ls2UzCxSMyPTjIt
         wHCJOD3vN3gDsMiWh7JL7D0pY8naEieOZocDFs9mfU/o6Jd9sQh8Y8g73WR9jLsL4Tar
         Ccuw==
X-Gm-Message-State: AOAM533dAPRM40urX0b6geQGM1cq0JvfIgm8pONn9ewYszvRelS6Cm3e
        mBjnnQF6dtDqupF4+LZcu62EiAfIujPOYJvcAnbE
X-Google-Smtp-Source: ABdhPJylTjO6CmnEjURDc3496be4uSWx25zcu1IuJcyKxIu4SxC0yap6Qho7LjX/sjkwRB6y+dJR2BuAoych5i4rE90=
X-Received: by 2002:a17:906:c14f:: with SMTP id dp15mr18137575ejc.327.1643159060317;
 Tue, 25 Jan 2022 17:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 20:04:09 -0500
Message-ID: <CAHC9VhTiGU_PMDGNKdFD977_Uk2iqVKr51kOzJV+njc0B9Eq5g@mail.gmail.com>
Subject: Re: [PATCH 2/9] selinux: declare path parameters of _genfs_sid const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The path parameter is only read from in security_genfs_sid(),
> selinux_policy_genfs_sid() and __security_genfs_sid(). Since a string
> literal is passed as argument, declare the parameter const.
> Also align the parameter names in the declaration and definition.
>
> Reported by clang [-Wwrite-strings]:
>
>     security/selinux/hooks.c:553:60: error: passing 'const char [2]' to p=
arameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types=
-discards-qualifiers]
>             rc =3D security_genfs_sid(&selinux_state, sb->s_type->name, /=
,
>                                                                       ^~~
>     ./security/selinux/include/security.h:389:36: note: passing argument =
to parameter 'name' here
>                            const char *fstype, char *name, u16 sclass,
>                                                      ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 4 ++--
>  security/selinux/ss/services.c      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Merged, thanks!

--=20
paul-moore.com
