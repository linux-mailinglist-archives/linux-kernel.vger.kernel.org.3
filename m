Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF00515A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 05:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382157AbiD3DkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 23:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiD3DkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 23:40:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367E8165B;
        Fri, 29 Apr 2022 20:37:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh6so18724892ejb.0;
        Fri, 29 Apr 2022 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kT+smoqxUUOo2Ktb3O9J5lGl3PYg+G58BG/KvkNJLgY=;
        b=dOOyVJ1DSf5EiPM0yEiLtTWcQTVfi5wciGDnyaADIduC2+gcdvYlI5tRYQTCHnDhSr
         LXM7EkzvctBcMF1FminCCFJCS8vCeJtg89aARu0QtQuzx4LOFhqFXLU3eLjm4dWCYU6Q
         uhQeXljguvxrXhdWkrdjYoGZv31V4VjbY/1d3A/L1tEHt/0l3qyF5jRzpaRh9yUqh2eE
         kwpPGEpbRyu2V/jHmgUw1VNKSlc9yqC2a5stheuULoxj29pfhDmB6iO7y+p2zYWWYpz6
         rYvifEr9NB8PQ9rBL5phInZwyTaiEOYcwb+u5YXNMLX0pXqm2BHHny8hO9UKg7ZEJjd5
         u3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kT+smoqxUUOo2Ktb3O9J5lGl3PYg+G58BG/KvkNJLgY=;
        b=p6kNj4EolSZ8O2yUel6FfMdvb8z3IuLrydGVsnO+fEMJ+YZ/8eFDb4p8WvZpEbkRPu
         CdvZ2idaN4nMPYRLQx2dX+U7lf/5YMHLeqrGao83U4Q3j4wFwNAKNfZrS7z2rItlxjjS
         +IkLpSfwYxgOK1wn5f88ol1CNx6fh/lws1VK/ttOlfiIWA1VRjbzXWzVOw+wuaB4WUbZ
         4QpmOagUU77JmsbU6kZiTMQEq3/dcUbGORMVttVIJeaBksIez2COi7cwQHuNCGh1flyS
         gJnAbSWmzjXqGzPADFGcaxyuM9k+RIMnPsN5rP9eJypvu1oB4u8NRbSVezfV4lhTHzdC
         Fn5w==
X-Gm-Message-State: AOAM532GiVcUJriZwP99A1SryzprePkR60+bREjZ0/WejsiaNkJLCvRN
        +LODXshzJz539K68TJ3nN888Il1DPuhwQ7v0E7g=
X-Google-Smtp-Source: ABdhPJxSwa0ZvThB2y7U1qXJuytrsR3sAUODm38c/6umMoXT+nuUmT29GgsL+afa8y+EZwJlI96akhGnLOunEcy24Ng=
X-Received: by 2002:a17:906:6a0d:b0:6f3:b341:3b94 with SMTP id
 qw13-20020a1709066a0d00b006f3b3413b94mr2262811ejc.31.1651289819573; Fri, 29
 Apr 2022 20:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220429032621.674865-1-starzhangzsd@gmail.com>
 <20220429095104.GA11365@alpha.franken.de> <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Sat, 30 Apr 2022 11:36:23 +0800
Message-ID: <CANubcdWykz0j5BaGNhYMW16wX9UbfgsLdEs-ebNWCWP+p1OKWw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is overrided
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     liam.howlett@oracle.com, ebiederm@xmission.com, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2022=E5=B9=B44=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 23:11=E5=86=99=E9=81=93=EF=BC=9A
>
>  Additionally I've thought of adding something like:
>
> #if cpu_has_fpu
> # undef cpu_has_fpu
> #endif
>
> or maybe even:
>
> #if cpu_has_fpu
> # error "Forcing `cpu_has_fpu' to non-zero is not supported"
> #endif
>
> to arch/mips/include/asm/cpu-features.h, but maybe that's an overkill.
>
>   Maciej

Yeah, but why do you think that's an overkill? There is a great chance
people will ignore the note of 'cpu_has_fpu', and it did happen. When
that happens, there should exist a way to point out  or fix that.

Thomas Bogendoerfer <tsbogend@alpha.franken.de> =E4=BA=8E2022=E5=B9=B44=E6=
=9C=8829=E6=97=A5=E5=91=A8=E4=BA=94 18:01=E5=86=99=E9=81=93=EF=BC=9A
>
> I prefer just removing the #defines from ip27/ip30 cpu-feasture-overrides=
.h.
> Or isn't that enough for fixing the problem ?
>
> Thomas.

So maybe that's  why I don't think just removing the #defines from
ip27/ip30 cpu-feasture-overrides.h. is enough for fixing the problem.

Stephen.
