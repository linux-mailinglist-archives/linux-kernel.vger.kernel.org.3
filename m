Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959004F5E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiDFM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiDFM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:27:10 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB793B120E;
        Wed,  6 Apr 2022 01:17:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y38so2724931ybi.8;
        Wed, 06 Apr 2022 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrgQWoWyB5y62bEoUfojWKqj8rDJrUtN2w1+bXGXRNI=;
        b=NKy9MbIr/mGh2TiFzd/eiHPj42EQXvCCaQeuYu/RvH7JJTLZdVUH0VcMDNsMMDfKfe
         CrfWbqUshjJ1nYkUjy1oBFQESesK2xslFONY1luaUl0a6TP/oAk8Hcn//gITAXlHNHEj
         oslvzJXMqjJgdssfKkxushn5ALO4npvXdNlMKR017hHxxyHTXjBRXuuik7ij9AAiTa9c
         3yRx5BS8/OLXN3DOVG5/40nJhr7DMmMGXv3O4SOOfJKlKLIIvpJg1C/cjYxZpfBmzxo6
         d6g5jCMsfKzPyDfqt0b0U12xjhh0dPmqMiNLYf3yo3F/RuqEeWmmqPev1TTtWpa963z0
         onmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrgQWoWyB5y62bEoUfojWKqj8rDJrUtN2w1+bXGXRNI=;
        b=3SAQ6KKhn0mlkMaT/rzSjx9x1wGLJEvKiVXNhTMoyfw01goGEzvAA5Oeu80ecAHDHi
         rs69YutNB6pi0vfM64GUoVzTTPQq5jbuNowAqs9gao95K52Ygl8251drisKABvJ9yaFu
         foTzot71E8rc+LlV6714LtVf8BLa6ob/OX8YqeUhKmw06RWGEfElwSH359aqrbtvr2Hq
         FZZ/bK/oLKWSbH8OhA8FmASf+mYHoDIg+5dLiPm+KXUnLVRtcgsHusnO+t4mL8TWvCm/
         FNHZtN901Kx2jniLVPxNFFVfPsVK9bgl1UL+j7uUcXggQ10ZJ9+hlz/nRC2WxPxqu9Sv
         fxFw==
X-Gm-Message-State: AOAM530lKhZevOQvld3TyxkJTx/QHgzPx8F25ldLL2dd62MZMpI/bE/Q
        UDD2y+crQkivpU88XmgEIHhamjJU9ldrv2EoxNY=
X-Google-Smtp-Source: ABdhPJzIGX4X6wQ3/0KaVtUXKipS8SltQuKn2tGDJJTtWysBh46/b/bDrEbDdoAAe1895xTV1smSrAMigR3+jtt64cY=
X-Received: by 2002:a25:e0d3:0:b0:63d:c615:afb8 with SMTP id
 x202-20020a25e0d3000000b0063dc615afb8mr5380270ybg.182.1649233024822; Wed, 06
 Apr 2022 01:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <6419fd7b-8213-3a51-268b-a9602c770991@linaro.org>
In-Reply-To: <6419fd7b-8213-3a51-268b-a9602c770991@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Apr 2022 09:16:38 +0100
Message-ID: <CA+V-a8sZdrpYMy-FSbaZzbKw_F_jEhTpOExPXr8_jDXD4_pooA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Daniel,

On Wed, Apr 6, 2022 at 9:03 AM Daniel Lezcano <daniel.lezcano@linaro.org> w=
rote:
>
> On 06/04/2022 09:24, Lad Prabhakar wrote:
> > The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so inst=
ead
> > of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> > ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> > ARCH_R9A07G054.
> >
> > With the above change OSTM will be enabled on RZ/V2L SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/clocksource/renesas-ostm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/r=
enesas-ostm.c
> > index 21d1392637b8..8da972dc1713 100644
> > --- a/drivers/clocksource/renesas-ostm.c
> > +++ b/drivers/clocksource/renesas-ostm.c
> > @@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
> >
> >   TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
> >
> > -#ifdef CONFIG_ARCH_R9A07G044
> > +#ifdef CONFIG_ARCH_RZG2L
>
> I'm not finding this option anywhere
>
ARCH_RZG2L config option is part of v5.18-rc1 [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/soc/renesas/Kconfig?h=3Dv5.18-rc1#n43

Cheers,
Prabhakar
>
> >   static int __init ostm_probe(struct platform_device *pdev)
> >   {
> >       struct device *dev =3D &pdev->dev;
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
