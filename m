Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CBA58BBE3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiHGQpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiHGQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:45:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99B3897
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 09:45:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j8so12646956ejx.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2PGRnV5Y4dd0AnjAyFuQDf1h6O5fn8Zc/uUHPAUm+NI=;
        b=YTdmANKJVa5XOjtTiYdXOz+UpK7W2lg+6xzggLPWy1aVGc0PSzaU0FfbggFIMoe3j3
         a4P5kaxXhGpHYCGP+FVZosVM2o5lRc6NMQmxc+yY9t/Lbi/El9cLdJs5z7+guGzRyhaL
         q3ZNdIA/KgGGoNNK4ClGkp9BO8iy4ra69yMkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2PGRnV5Y4dd0AnjAyFuQDf1h6O5fn8Zc/uUHPAUm+NI=;
        b=AsEp8RKy4R2+ME8cvpkbwKJDEh2v4iR8gKa4wA/RsTj96+rsrx3FW94SN4G1IUVAPj
         1e6VqqCi7z9pjPO35su+6iJswotQ1M7VwpTpn9N3y+SjuqwL4E8uEWwaZ7Sw+venbA1/
         gLFpUClzl/ZvzZAf3PN/vippGhgnTPpAznK+vdDAVdsx9C2MvGQkz/cAa7nFTQshUZhe
         5fzJi4RjJgsMuTOfDbYAgXrUubGCsRW617d45gO/Q+HdaXtuZhBVdWS0YWZpMin9D4Hz
         xx7JsRzmfuTIVCz4yb+jzDn0e5ydeTYguUaqNGul/bBhj6xR3k7b2Oefma8qdXG4KumA
         NDxg==
X-Gm-Message-State: ACgBeo1HK2WR+8Zs//giNDDeeauA5F2u9c2DgwBz2FfhjGDSsUPfYdb/
        NMyjwMfCKzkbe8szBLUWVGgwrio0fMd9yxsQ
X-Google-Smtp-Source: AA6agR6xJsIcu74blZGAEgMDmSF+yFdQbkRoc/uJQ1oXqlyblNYUx4hZOl/UPLo6VKIrmrUlWDYqkQ==
X-Received: by 2002:a17:906:7955:b0:72f:5c1f:1816 with SMTP id l21-20020a170906795500b0072f5c1f1816mr11492680ejo.396.1659890725706;
        Sun, 07 Aug 2022 09:45:25 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906311400b0072b8fbc9be1sm3931182ejx.187.2022.08.07.09.45.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 09:45:25 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so1439451wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 09:45:24 -0700 (PDT)
X-Received: by 2002:a1c:2582:0:b0:3a5:1453:ca55 with SMTP id
 l124-20020a1c2582000000b003a51453ca55mr9611614wml.68.1659890724521; Sun, 07
 Aug 2022 09:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220730022529.497941-1-linux@roeck-us.net> <Yu+OzWv2JDbI89mW@gmail.com>
In-Reply-To: <Yu+OzWv2JDbI89mW@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Aug 2022 09:45:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGO=pfxyW6E7HdxCnRwWOF_STL=z7yUNwZK__DrV1WmQ@mail.gmail.com>
Message-ID: <CAHk-=wiGO=pfxyW6E7HdxCnRwWOF_STL=z7yUNwZK__DrV1WmQ@mail.gmail.com>
Subject: Re: [GIT PULL] hwmon updates for v5.20
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Kees - this *looks* like it's a compiler bug.

On Sun, Aug 7, 2022 at 3:07 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Just a quick build regression report, i386 allmodconfig fails to build du=
e
> to a 'string overread' compiler warning in drivers/hwmon/lm90.o:

I tried to see it here with gcc-12.1, but it's not triggering, so it's
presumably compiler-dependent.

Which compiler is it?

>       inlined from =E2=80=98lm90_detect=E2=80=99 at drivers/hwmon/lm90.c:=
2550:2:
> warning: =E2=80=98__builtin_strlen=E2=80=99 reading 1 or more bytes from =
a region of size 0 [-Wstringop-overread]

Normally it's easier to see what triggers it, but here it's just that

        strlcpy(info->type, name, I2C_NAME_SIZE);

so it's either just the compiler being confused (we've seen that
before), or it's one of the

                name =3D lm90_detect_xyz(client, chip_id, config1, convrate=
);

calls in the case statement above that returns something that gcc then
thinks is bad.

However, from an admittedly quick look, all those functions simply
seem to return either NULL or a simple constant string.

Which makes me think "oh, it's gcc being confused by the fortification
code again".

Kees? Do you see anything I don't?

I get the feeling that we should just disable
-Werror=3Dstringop-overread and/or FORTIFY_SOURCE for that
compiler/architecture combination if it's just gcc causing bogus
errors.

              Linus
