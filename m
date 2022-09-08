Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430665B13C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIHEvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:51:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3126DAF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:51:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r17so7909561ejy.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 21:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=NB/5phlrQWjGIxi/Z08AmIeAlR9CZftGG5wn5NLNb24=;
        b=qSLlmPRe8Sp/NoNo+DkUaUz0j0GMO38uWcV9VEDKRJYLH0qoYjqaAogHlCe1659B6Z
         DDzb787iTqunoWP3Sb+Uifs3Xd2wwlmqkptSt0VCfoRr/6gICDOpfhW1uZ5kIEeJkRys
         68dDdtmrO57orrefZ6IGRUTBQdpWHfXV0jMTg2AYg+230YpKaZqDGhQDXpRYn9TZvBta
         4Lld+d3xXqBRPwEtMg3OkeEkgyKfXX2HDf0WNGH989jEfBeXCQVqmi6zFztttrmNgZbD
         Yy6UWmuYqxNYaFDEgBuYgo5jmOemeZADaAIZLsa7yG764+FxsIbdwml+F8VGAvPnSqi4
         KUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NB/5phlrQWjGIxi/Z08AmIeAlR9CZftGG5wn5NLNb24=;
        b=PB1vMwjXcCEJ2KwqZNCzoIeL64Vif6lkNzc4bwXQpacHp46OOyaGdLEhAqe5fDteF4
         Cpvy177WkuUyLvfJ86OEiimR45vXcjTPoanIKTNzWZ8ciy4HoH0V8rOTLOdQg6EFIikP
         +8VJcf3ZZf6V05+2JzlKkfvW/9RAJTSQIMsYIVpZ2sMS6mnfAX+T7NAEL6Xlut3t70wr
         1CWtBj3RF4R4HDMljBV0KnuoY3/APOJg2FgWp9vNXE0meb2eucP2tQ+dzmyn/I8weMmD
         5S49xcy8h+tCAVCGEEIzXY3XSSrhoXxlLUOaNLWXlEqInR1rCiJ8duK+y0E4rOT/gE+E
         kN5Q==
X-Gm-Message-State: ACgBeo0FnmYSJVHYhu2elCWleCIVMoMsqATvXmYvXtIUCUZ9YQWUmYsm
        2M7UyJrl1dRWUgvJBZIeZdPu+tiEPdZwSRW7ObmMcLh2h7FqCA==
X-Google-Smtp-Source: AA6agR7uP7oo6riRdZQgCsipebGefxCjnBxgqGxdNJUrHUAvOmK5fk8vad+64DgOn0tWB7W1fncM3ZrKP4Kxj6bFzcE=
X-Received: by 2002:a17:906:8b81:b0:733:183b:988e with SMTP id
 nr1-20020a1709068b8100b00733183b988emr4613917ejc.457.1662612709532; Wed, 07
 Sep 2022 21:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220902155820.34755-1-liq3ea@163.com>
In-Reply-To: <20220902155820.34755-1-liq3ea@163.com>
From:   Li Qiang <liq3ea@gmail.com>
Date:   Thu, 8 Sep 2022 12:51:11 +0800
Message-ID: <CAKXe6SJpzUMkjyb1hGagaNUiXS0h5xen95iTqCMs0UcGVW1ECQ@mail.gmail.com>
Subject: Re: [PATCH] kprobe: reverse kp->flags when arm_kprobe failed
To:     Li Qiang <liq3ea@163.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping.

Li Qiang <liq3ea@163.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=883=E6=97=A5=E5=91=
=A8=E5=85=AD 00:00=E5=86=99=E9=81=93=EF=BC=9A
>
> In aggregate kprobe case, when arm_kprobe failed,
> we need set the kp->flags with KPROBE_FLAG_DISABLED again.
> If not, the 'kp' kprobe will been considered as enabled
> but it actually not enabled.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  kernel/kprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 08350e35a..333454df5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2424,8 +2424,11 @@ int enable_kprobe(struct kprobe *kp)
>         if (!kprobes_all_disarmed && kprobe_disabled(p)) {
>                 p->flags &=3D ~KPROBE_FLAG_DISABLED;
>                 ret =3D arm_kprobe(p);
> -               if (ret)
> +               if (ret) {
>                         p->flags |=3D KPROBE_FLAG_DISABLED;
> +                       if (p !=3D kp)
> +                               kp->flags |=3D KPROBE_FLAG_DISABLED;
> +               }
>         }
>  out:
>         mutex_unlock(&kprobe_mutex);
> --
> 2.25.1
>
